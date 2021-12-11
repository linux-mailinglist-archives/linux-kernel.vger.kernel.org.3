Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64017471493
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhLKPzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:55:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:60843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhLKPzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639238080;
        bh=ejKcLUvHddgrUEMS0flKbxFEHFJj1izRytQyFU0ff5w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YbimlK7FU7tXMKuFv4h09xLR5bjQZ9Btur9XEcr2kvQzlS5QJoSyNJSWdpD9PQ7Z6
         Pwyc5iIMJZdESjpoYVoxJtyq1PwIvBTE+cg8L7Hn4Ocpl3zp/UUulb/WOD093NJuTo
         KwDD6nfLV75exijEkehfO0QsWEGj8vyUq2qZeZI8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Ml6qC-1mF4Oa1weS-00lS8R; Sat, 11 Dec 2021 16:54:40 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: (dell-smm) Simplify ioctl handler
Date:   Sat, 11 Dec 2021 16:54:21 +0100
Message-Id: <20211211155422.16830-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211211155422.16830-1-W_Armin@gmx.de>
References: <20211211155422.16830-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tTCSxSzTXohQ7PY0EcALDH5K0O/uBfh9WZWj5MXCQVSqZpe2HS9
 FXGJvTide0zsiLNsmqDQIP6jRTtceFWGIJ/lYY3O/6V8RJZCzvc0QwtXOKlHddS/fQ+fVPc
 IKEtpTfgRK2BYE/rckm2Lry2KHApSaeGaRsA0Uu5e+mhKaOUwxGgebVtOexUWAjgo5OqTK+
 7LW6XuTW0ZnBmVF6IIjuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:11EJANrfG3s=:jE+fhfhZaXSPxTr4gtopjE
 ulgyNnIHn8q2Q8wye6chpOrrJcCb5U6oCFvHP/KmIJrXHewmn/3kq0L5fbvEX2vlbZsDWE2tz
 cf0HGni9lw6zT04MM1O64lCtzTK5Ee+Si3Pbnwa9bl89dxRgHJeUnBlmeJ7qSpmLsuJfC38ap
 hXjZlrUXcMC7Llx873fOxY218aEnR+gpKH/s7GzkN6Z6eKForaV2IOtSGQ+nQ0SAZie84HnNB
 gMMgXk+ngZ3hbB6N6/mWr3T6+KTvt6Y3uL+L/so4mHXPHUM2nR123VUh5/1ET7VjuXk9mC59f
 gbaCDXCqdzfLVOHcdlg5K4pJbwGeqlVR39DBzgR5dj72uY2aqwpn5Ww/Ck9Apbf6Ywc6nCujA
 YxzlSsGAhirjozaOod0BtSc9C3LZQyGPA2PpxrUAnoLwcCJkYkqCpnFTxnKZHgNjPPSgWgnO9
 JVgSB38IPIElyDIb/RqrdwEoCADx/IVeP0cjD8q+F/MOahiKb2cVkicYHzYFH3HpUz0gMBGrY
 8vpXziKb+Gp0dSRCrx3i1DJJCW2eaGFZWf3QknPSWUxGdrHwzhImJ+BwLJzWMnZVniwEQrX9z
 jj9iRm06vE3nI0OxU8tBHPgFHa35MShV6XxwEQ2FMPMNus+SdQ4drK/rE6ixKO0SAT7qwIrd9
 PI3UUwkVOM570NpurbWobGv9MzGREjA8sTiyYIkbJz2IoRroLLObxVTLN+Hjo1ljTOkm4hFgU
 4zry//2EwCQwCCrt6zDXiRVYtL5s7iJXarlCntO4gXEkC8Q7GtS9ssE5og5HudHMYa5dpBy0m
 N3SutanDdj4EqpKBwX9/WWUlfb91jqgV1Q0OfcpMD45RGl1zyiXHCc+SfVtJXeM34IwBJhIQg
 8NF4OHUdYUWOsEGiE+/W8YWg8ZsN4hOlgT/HIKbmkM1L2KdwQvpL9BDMIk3HslUytWTbYMoUA
 ymgsIAafGzRo4hF5x27Fal3dpqrc3fp4e1n6DcppVJQkFV8V3TowTxrrFlW8S6JaKvlF/Lqe6
 bRdHyS+8v1T+fIOSyFJ960YY1hjNyFMXIPCCabZlB4XMBSz4lO2X/1powPnudNPm3YIwiM/L7
 IzrCnWrr9O62K4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second switch-case has no real purpose:

- for I8K_BIOS_VERSION, val does not represent a return value,
  making the check for error values unnecessary.
- for I8K_MACHINE_ID, val remains zero, so the error check is
  unnecessary too.

Remove the switch-case and move the calls to copy_to_user()
into the first switch-case for I8K_BIOS_VERSION/_MACHINE_ID.
Omit buff[] since data->bios_machineid already contains the string
with the necessary zero padding through devm_kzalloc().

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 5596c211f38d..186d40938036 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -454,7 +454,6 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_da=
ta *data, unsigned int cmd
 {
 	int val =3D 0;
 	int speed, err;
-	unsigned char buff[16];
 	int __user *argp =3D (int __user *)arg;

 	if (!argp)
@@ -468,15 +467,19 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_=
data *data, unsigned int cmd

 		val =3D (data->bios_version[0] << 16) |
 				(data->bios_version[1] << 8) | data->bios_version[2];
-		break;

+		if (copy_to_user(argp, &val, sizeof(val)))
+			return -EFAULT;
+
+		return 0;
 	case I8K_MACHINE_ID:
 		if (restricted && !capable(CAP_SYS_ADMIN))
 			return -EPERM;

-		strscpy_pad(buff, data->bios_machineid, sizeof(buff));
-		break;
+		if (copy_to_user(argp, data->bios_machineid, sizeof(data->bios_machinei=
d)))
+			return -EFAULT;

+		return 0;
 	case I8K_FN_STATUS:
 		val =3D i8k_get_fn_status();
 		break;
@@ -527,23 +530,8 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_d=
ata *data, unsigned int cmd
 	if (val < 0)
 		return val;

-	switch (cmd) {
-	case I8K_BIOS_VERSION:
-		if (copy_to_user(argp, &val, 4))
-			return -EFAULT;
-
-		break;
-	case I8K_MACHINE_ID:
-		if (copy_to_user(argp, buff, 16))
-			return -EFAULT;
-
-		break;
-	default:
-		if (copy_to_user(argp, &val, sizeof(int)))
-			return -EFAULT;
-
-		break;
-	}
+	if (copy_to_user(argp, &val, sizeof(int)))
+		return -EFAULT;

 	return 0;
 }
=2D-
2.30.2

