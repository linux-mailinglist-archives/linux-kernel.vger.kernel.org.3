Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9CC46209D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352928AbhK2Tj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:39:29 -0500
Received: from mout01.posteo.de ([185.67.36.141]:54555 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhK2Th1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:37:27 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 14:37:27 EST
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 1FBDE24002A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 20:27:06 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4J2wMs5d4Fz9rxg
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 20:27:05 +0100 (CET)
Message-ID: <5be0e863-cb9b-c448-9089-6a95f59b8f74@miltschek.de>
Date:   Mon, 29 Nov 2021 19:26:59 +0000
MIME-Version: 1.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Reply-To: linux-kernel@miltschek.de
From:   "K." <linux-kernel@miltschek.de>
Subject: =?UTF-8?Q?Kernel_driver=3a_W1_DALLAS=e2=80=99S_1-WIRE_BUS_invalid_c?=
 =?UTF-8?Q?alculation?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel-driver developers,

I believe there is a mistake in calculation of the fine part of the 
temperature value as received from 1-Wire DS18x20-family sensors.

The current implementation does indeed follow the official datasheet, 
but exactly the datasheet seems to be incorrect in this place.

Datasheet: https://datasheets.maximintegrated.com/en/ds/DS18S20.pdf
says two different things on Page 6:

- First:
"Resolutions greater than 9 bits can be calculated using the data from 
the temperature, COUNT REMAIN and COUNT PER °C registers in the 
scratchpad. Note that the COUNT PER  °C  register  is  hard-wired  to 
16  (10h).  After  reading  the  scratchpad,  the  TEMP_READ  value  is 
obtained  by  truncating  the  0.5°C  bit  (bit  0)  from  the 
temperature  data  (see Figure  4)."

- And then:
"The  extended  resolution  temperature  can  then be calculated using 
the following equation:
TEMPERATURE = TEMP_READ - 0.25 + (COUNT_PER_C - COUNT_REMAIN) / COUNT_PER_C"

I have performed live tests with DS18S20 sensors to verify it, how they 
behave. I was lowering the temperature in slow steps to see individual 
transitions. Below is the result.

Columns:
- 00, 01, 06, 07 = response bytes 0 (value), 1 (sign), 6 (count remain) 
and 7 (count per degC)
- 01-bin = response byte 0 again as binary
- 7-min-6 = response byte 7 minus response byte 6
- -0- = bits 7..1 of response byte 0
- -76- = bits 3..0 of the (byte 7 - byte 6 subtraction)
- hex = the value as hex
- degreesC = the value multiplied by 1/16°C

00 01  06 07 --01-bin- -7-min-6- --0---- -76- hex    degreesC
37:00::04:10 0011 0111 0C = 1100 0011011.1100 1BC -> 27.75
37:00::05:10 0011 0111 0B = 1011 0011011.1011 1BB -> 27.6875
37:00::06:10 0011 0111 0A = 1010 0011011.1010 1BA -> 27.625
37:00::07:10 0011 0111 09 = 1001 0011011.1001 1B9 -> 27.5625
37:00::08:10 0011 0111 08 = 1000 0011011.1000 1B8 -> 27.5
36:00::09:10 0011 0110 07 = 0111 0011011.0111 1B7 -> 27.4375
36:00::0A:10 0011 0110 06 = 0110 0011011.0110 1B6 -> 27.375
36:00::0B:10 0011 0110 05 = 0101 0011011.0101 1B5 -> 27.3125
36:00::0C:10 0011 0110 04 = 0100 0011011.0100 1B4 -> 27.25
36:00::0D:10 0011 0110 03 = 0011 0011011.0011 1B3 -> 27.1875
36:00::0E:10 0011 0110 02 = 0010 0011011.0010 1B2 -> 27.125
36:00::0F:10 0011 0110 01 = 0001 0011011.0001 1B1 -> 27.0625
36:00::10:10 0011 0110 00 = 0000 0011011.0000 1B0 -> 27
35:00::01:10 0011 0101 0F = 1111 0011010.1111 1AF -> 26.9375
35:00::02:10 0011 0101 0E = 1110 0011010.1110 1AE -> 26.875
35:00::03:10 0011 0101 0D = 1101 0011010.1101 1AD -> 26.8125
35:00::04:10 0011 0101 0C = 1100 0011010.1100 1AC -> 26.75
35:00::05:10 0011 0101 0B = 1011 0011010.1011 1AB -> 26.6875
35:00::06:10 0011 0101 0A = 1010 0011010.1010 1AA -> 26.625

for temperature(s) below zero (u2 coding):

00 01  06 07 --01-bin- -7-min-6- --0---- -76- hex    degreesC
00:00::0E:10 0000 0000 02 = 0010       0.0010        0.125
00:00::0F:10 0000 0000 01 = 0001       0.0001        0.0625
00:00::10:10 0000 0000 00 = 0000       0.0000        0
FF:FF::01:10 1111 1111 0F = 1111 1111111.1111       -0.0625
FF:FF::02:10 1111 1111 0E = 1110 1111111.1110       -0.125
...
FC:FF::0F:10 1111 1100 01 = 0001 1111110.0001       -1.9375
FC:FF::10:10 1111 1100 00 = 0000 1111110.0000       -2.0000
FB:FF::01:10 1111 1011 0F = 1111 1111101.1111       -2.0625

My findings are confirmed by other people, e.g. here:
https://www.electro-tech-online.com/threads/expanding-ds18s20-output-from-9-bit-to-12-bit.128569/post-1070629

The only unclear thing for me is the byte[7]. The datasheet says it is 
hard wired to 10h. The guy here says, he has seen devices with other 
dividers:
https://www.electro-tech-online.com/threads/expanding-ds18s20-output-from-9-bit-to-12-bit.128569/post-1084824
"I noticed that the count divisor was not equal to 16 as the data sheet 
indicated it would be. In fact, as the temperature was raised and 
lowered, the count divisor would increase and decrease in value (not 
fixed)."

Assuming the guy did not make any mistake, it would be interesting to 
know, whether the divisor is always a power of 2 (which would make the 
conversion easy) or can be of any value.

For your info: I have contacted Evgeniy P. as an author of the driver, 
but according to the response, he is not maintaining the driver anymore. 
That's why a question to all of you, if anyone could take a look at this 
please.

Thank you very much and best regards
K.
