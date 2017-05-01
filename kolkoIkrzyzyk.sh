#!bin/bash
declare -a Map
size=9
isCorrect=1
field=0
turn=0

function displayMap {
	echo $"   | 1 | 2 | 3 |"
	echo $"---|-----------|"
	echo $" A | ${Map[0]} | ${Map[1]} | ${Map[2]} |"
	echo $"---|-----------|"
	echo $" B | ${Map[3]} | ${Map[4]} | ${Map[5]} |"
	echo $"---|-----------|"
	echo $" C | ${Map[6]} | ${Map[7]} | ${Map[8]} |" 
	echo $"----------------"
}

function validateInput {
	num=$((field-1))
	if [ $field -gt 10 ] || [ $field -lt 1 ]; then
		isCorrect=0
	elif [ "${Map[$num]}" == " " ]; then
		isCorrect=1
	else
		isCorrect=0
	fi
}
function checkWin {
	# Sprawdzenie zwyciestwa w kolumnie
	for ((i=0; i<3; i++ )); do
		if [ "${Map[$i]}" == "${Map[$((i+3))]}" ] && [ "${Map[$i]}" == "${Map[$((i+6))]}" ]; then
			if [ "${Map[$i]}" == "O" ]; then
				echo $"Brawo kolko, wygrales!"
				exit
			elif [ "${Map[$i]}" == "X" ]; then
				echo $"Brawo krzyzyk, wygrales!"
				exit
			fi
		fi
	done

	# Sprawdzenie zwyciestwa w wierszu
	for ((i=0; i<3; i++ )); do
		if [ "${Map[$((3*i))]}" == "${Map[$(((3*i)+1))]}" ] && [ "${Map[$((3*i))]}" == "${Map[$(((3*i)+2))]}" ]; then
			if [ "${Map[$((3*i))]}" == "O" ]; then
				echo $"Brawo kolko, wygrales!"
				exit
			elif [ "${Map[$((3*i))]}" == "X" ]; then
				echo $"Brawo krzyzyk, wygrales!"
				exit
			fi
		fi
	done
	# Sprawdzenie zwyciestwa po skosie
	if [ "${Map[0]}" == "${Map[4]}" ] && [ "${Map[0]}" == "${Map[8]}" ]; then
		if [ "${Map[0]}" == "O" ]; then
			echo $"Brawo kolko, wygrales!"
			exit
		elif [ "${Map[0]}" == "X" ]; then
			echo $"Brawo krzyzyk, wygrales!"
			exit
		fi
	fi
	if [ "${Map[2]}" == "${Map[4]}" ] && [ "${Map[2]}" == "${Map[6]}" ]; then
		if [ "${Map[2]}" == "O" ]; then
			echo $"Brawo kolko, wygrales!"
			exit
		elif [ "${Map[2]}" == "X" ]; then
			echo $"Brawo krzyzyk, wygrales!"
			exit
		fi
	fi
}

# Skrypt gry
for ((i=0; i<size; i++)); do
		Map[$i]=" "
done

displayMap

while [ $turn -lt 9 ]
do
	turn=$((turn+1))
	echo $"Kolko wybierz wolne pole od 1 do 9"
	read field
	validateInput
	while [ $isCorrect -eq 0 ] 
	do
		echo $"Podales bledne pole, podaj jeszcze raz"
		read field
		validateInput
	done
	
	field=$((field-1))
	Map[$field]="O"
	displayMap
	checkWin

	if [ $turn -eq 9 ]; then
		echo $"Remis!"
		exit
	fi

	turn=$((turn+1))
	echo $"Krzyzyk wybierz wolne pole od 1 do 9"
	read field
	validateInput
	while [ $isCorrect -eq 0 ] 
	do
		echo $"Podales bledne pole, podaj jeszcze raz"
		read field
		validateInput
	done
	
	field=$((field-1))
	Map[$field]="X"
	displayMap
	checkWin
done
echo $"Remis!"	

	
