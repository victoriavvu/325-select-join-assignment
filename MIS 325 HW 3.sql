--MIS 325 HW 3
--Victoria Vu (vtv244)

--Problem 1
SELECT cardholder_first_name, cardholder_last_name, card_type, expiration_date
FROM customer_payment
ORDER BY expiration_date ASC;

--Problem 2
SELECT first_name || ' ' || last_name as customer_full_name
FROM customer
WHERE SUBSTR(first_name,1,1) IN ('A','B','C')
ORDER BY last_name DESC;

--Problem 3
SELECT customer_id, confirmation_nbr, date_created, check_in_date, number_of_guests
FROM reservation
WHERE status = 'U' and check_in_date >= SYSDATE and check_in_date <= '31-DEC-21';

--Problem 4A
SELECT customer_id, confirmation_nbr, date_created, check_in_date, number_of_guests
FROM reservation
WHERE status = 'U' and check_in_date BETWEEN SYSDATE AND '31-DEC-21';

--Problem 4B
SELECT customer_id, confirmation_nbr, date_created, check_in_date, number_of_guests
FROM reservation
WHERE status = 'U' and check_in_date >= SYSDATE and check_in_date <= '31-DEC-21'
MINUS
SELECT customer_id, confirmation_nbr, date_created, check_in_date, number_of_guests
FROM reservation
WHERE status = 'U' and check_in_date BETWEEN SYSDATE AND '31-DEC-21';

--Problem 5
SELECT customer_id, location_id, check_out_date - check_in_date as length_of_stay
FROM reservation
WHERE status = 'C' AND ROWNUM <= 10
ORDER BY length_of_stay DESC, customer_id ASC;

--Problem 6
SELECT first_name, last_name, email, stay_credits_earned - stay_credits_used as credits_avaiable
FROM customer
WHERE stay_credits_earned - stay_credits_used >= 10
ORDER BY credits_avaiable;

--Problem 7
SELECT cardholder_first_name, cardholder_mid_name, cardholder_last_name
FROM customer_payment
WHERE cardholder_mid_name IS NOT NULL
ORDER BY 2,3 ASC;

--Problem 8
SELECT  SYSDATE AS today_unformatted, TO_CHAR (SYSDATE, 'fmMM/DD/YYYY') AS today_formatted,
        25 AS credits_earned, 25/10 AS stays_earned, FLOOR(25/10) AS redeemable_stays, 
        ROUND(25/10) AS next_stay_to_earn
FROM dual;

--Problem 9
SELECT customer_id, location_id, check_out_date - check_in_date as length_of_stay
FROM reservation
WHERE status = 'C' AND location_id = 2
ORDER BY length_of_stay DESC, customer_id ASC
FETCH FIRST 20 ROWS ONLY;

--Problem 10
SELECT first_name, last_name, confirmation_nbr, date_created, check_in_date, check_out_date
FROM customer c INNER JOIN reservation r
ON c.customer_id = r.customer_id
WHERE status = 'C'
ORDER BY c.customer_id ASC, check_out_date DESC;

--Problem 11
SELECT first_name || ' ' || last_name as name, r.location_id, confirmation_nbr, check_in_date, room_number
FROM customer c 
    INNER JOIN reservation r ON c.customer_id = r.customer_id
    INNER JOIN reservation_details d ON d.reservation_id = r.reservation_id
    INNER JOIN room o ON d.room_id = o.room_id
 WHERE status = 'U' and stay_credits_earned >= 40;

--Problem 12
SELECT first_name, last_name, confirmation_nbr, date_created, check_in_date, check_out_date
FROM customer c
LEFT OUTER JOIN reservation r ON c.customer_id = r.customer_id
WHERE confirmation_nbr IS NULL;

--Problem 13
SELECT '1-Gold Member' AS status_level, first_name, last_name, email, stay_credits_earned
FROM customer
WHERE stay_credits_earned < 10
UNION
SELECT '2-Platinum Member' AS status_level, first_name, last_name, email, stay_credits_earned
FROM customer
WHERE stay_credits_earned >= 10 AND stay_credits_earned < 40
UNION
SELECT '3-Diamond Club' AS status_level, first_name, last_name, email, stay_credits_earned
FROM customer
WHERE stay_credits_earned >= 40
ORDER BY 1, 3;