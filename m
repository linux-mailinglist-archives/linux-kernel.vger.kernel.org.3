Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D9A4A3F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbiAaJib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:38:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:38679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239035AbiAaJi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643621891;
        bh=mJxsPYb64pkiiR8ddTh3vIBADHaclB5tW+tmgCYuZ4E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DjOqOjcKf6PsYr0gC2i8mR+mWvxunldjDiHfbBx/VrJHDZmeA/eaKxARhyfw8lFQf
         lfEwBRVfhY9qik4RFo4B3CNp78maZ07It4QbunrVNh4SbZ6hYHdSFbJIS/nMKSRwvT
         7Y8yYKtLRG15POTjIVVbfoBNEFGjZ4TiISABr33Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MtfJX-1mNrie0hXb-00v9Xk; Mon, 31 Jan 2022 10:38:11 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 3/4] hwmon: (sch56xx-common) Replace msleep() with usleep_range()
Date:   Mon, 31 Jan 2022 10:37:55 +0100
Message-Id: <20220131093756.8075-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131093756.8075-1-W_Armin@gmx.de>
References: <20220131093756.8075-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:631rragYDHePZtnqpgl3BQnNodwzxhbldTFzOnV4v7m4bHM3v5p
 ZufQ9k9OiQITAnQMafQ8bq6HJkZqt8u7WV8BkswfZLu5EjZCkBXbcJv48B3TN0ls8oDpbQd
 +6AgyWzRaKaqpwJGXjmgVjGO0L5/3zfKy8klJ7ZOZ369tMSuOhxrxaRANPBV42HgoYUEiwc
 zDhkYM75m+rKjmGQyrTVQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4zPAX+ETwoU=:L1KV9YzhpboZ+tTm0lbg3F
 rAWp9+mzAsxl8fpRuQ1C16J10VzeK/lzcGIaDdc/Acquvn+nXuRQwul8uYM2m6bLiYAdJkiKu
 mgOLXnT3P66POAz0eivLpWUsfE4HVTVI850WKVHMJdpUJprVICr3/PX5Nyg9V03MOGdibDNp2
 VvfqpjpNohZ2akk0gOKeq4Kj3+gahcjl9AgD1DJS0V03D7TSTJpiwIb09ujsd7mZJUwEXANbU
 1SHi6sg7YcqH0PJV5c3KEWM0+8WrBFV6dNzNLLPOVnLQsFHcpqEV8DL9Y4/M4hCTkI2SRZO9o
 MKkWtGP9e0dOudC/pwYoYqypO7/cidE5xUQDNnBp7FqyXVsx+rwXQ9XdeZueIPMa3lX6ybPyD
 qZmgZWUbT9LblpjQZlN5s1zUTRSBGmzX4pFtqAlzqIVHN10YUiBLjXByOgZ9b/1ybdAkTsT3H
 quEYmvkoU3Z6Y3egOB9jbb3I2m+W2vAIB6QaSeZ+I81CWm6kKs/dNnhoI9W7mG0699tMctaYs
 1roB72WtG1hTsLzpNOUgkhTa1apIHE0z1ZBUJh4B+ET4/WwTJ9OsOn02zHqbsq6qnKindQSL4
 y8/+Z2ynQxxImQEdU3dRVKxpEoZyxAREBJdO1RtZR4+6s6RYbwR2q+B7rfjANfy0yoZbZrIFX
 G5i/pHRQseESLtdxYus2Wa2+CG/khDrRGPvEzIR1YmTWRFz/eZFLUOOI2yRPri/JUAuv75aEH
 rfxfg9FUN4y5ATh1xQpyt+tMBWrIs0uE4XUHG6oTwqTV+Z44+CCcos59ZSSHT0R2Uqz+B1Bfn
 P1pwN41L1/BJXCXnxtxc7ey4gCZ75OAPph6ziasuJYqJtQR+IiyQqyI2Hi+XWIRClNBHHfCcM
 Xa/sZulTCbwU4xzOIC/S69c/POoKtXt8/SKxDm9Pj7Iyoii8BAClTwZp7gykWUDghHzQE+85q
 OUtN9gScLjKIBFZ+dQKcFBoOJ4PrGz1PsLWlaYd6sFIiFpbie0tlE3zwCwZe1Zg/giVkYyGeE
 Yk2+zmWfw2WrUZjocBlY1hkp/uezFqzJkThoq6FLhnesorEapTqOp/7VZNWzewl3gYcCaG9Xn
 HX35ijh0kM8lIk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msleep(1) will often sleep more than 20ms, slowing down sensor
and watchdog reads/writes. Use usleep_range() as recommended
in timers-howto.rst to fix that.

Tested on a Fujitsu Esprimo P720.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch56xx-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common=
.c
index 0172aa16dc0c..f66e1ed4b1aa 100644
=2D-- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -139,7 +139,7 @@ static int sch56xx_send_cmd(u16 addr, u8 cmd, u16 reg,=
 u8 v)
 	/* EM Interface Polling "Algorithm" */
 	for (i =3D 0; i < max_busy_polls + max_lazy_polls; i++) {
 		if (i >=3D max_busy_polls)
-			msleep(1);
+			usleep_range(1, 2);
 		/* Read Interrupt source Register */
 		val =3D inb(addr + 8);
 		/* Write Clear the interrupt source bits */
=2D-
2.30.2

