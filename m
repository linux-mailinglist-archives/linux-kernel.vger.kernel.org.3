Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B8A471495
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhLKPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:55:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:59927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231368AbhLKPzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639238082;
        bh=m568THOr9bt8drU5mZJQIxwuBPDKHdZftpxVk033ksw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BcRJ3TK3aR+bEfFhLqjlK+A+L5muGiBb0E0rGUp2nHLRt7ODh+VgTNcmxKhS48HRE
         FiWEpIPAeYoF+zvsbnHKmvOAUlv6vWCfOHZ+R/AOPJfq8+BSEmbcb/7IZtXp6McCPW
         Ff0rc2wQxblAzhnhEbG2vouq6XWUjDhtJ9SYyvY0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M6Daq-1mtsr41eES-006dXs; Sat, 11 Dec 2021 16:54:42 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and i8k_ioctl_unlocked()
Date:   Sat, 11 Dec 2021 16:54:22 +0100
Message-Id: <20211211155422.16830-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211211155422.16830-1-W_Armin@gmx.de>
References: <20211211155422.16830-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xrtytWxXih+yIIn3dgrrUvFTd142Fajn1/6o4bZpufa12OUItdv
 yjfKHdKEENGmZ3fitgt45CLi/JydwyW+yL7aoOBcN7GvJNXFSplqKRBMSC6hbqilK4dfdvr
 1Nl+Sf2rdImV9OfFLyMkZ6IkYmt/faFmeljPLVjHZmhYhOT/jhWE7ZgtPwGq+JumHmTdIz9
 gerWhpmfaGGenhTOYrC+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:at9PlmCMxqg=:E9eablUPpTULKGtCJz6Wpo
 6I5x+vhhhCb7cvzHDfODnc775q0u6dqousipWk3nOfNv3OAzgqnSmEheAIaAOJqv+BikMso5K
 Efy+gH+3LplX5nyb3px7/U9pyRJhj0y8rCK/06nAI8mVrJDZur8VymQF1XluodgavMhOtEhmz
 qeemyNXu0Rv64pBOWNdz0cvpoVaDR4wAaWrd/xhD0b9j0eYwOFmaPNUo+NOfKaboSYJf3VS/x
 Z9gPEixmdNKya/tXlP9LYQ5g8F9A8u+Wwz0LPAWn0XEu0iot/8FHsW3XShBEqDyKM7ASlqZ0H
 45P9enNiZUiJoxj5z3X31QQkKK80oPTZG46yEyE3ms4KCjGJtD/l9Lb19KMl8Q6TDIPF85+VU
 4w4phH5cJDxczbMWGM2XWnRBbR1+mBhSVUtSQlmgWpgxV77xYWnS2v0lBo+QxwcBWDofUpexf
 RF9hs8poh3v9SL4XBrFatvq2u6vfgasQQYkbH9/bN38nKz0xDmDpng2nYXxbizmFlFxIPRwdB
 WeYp8NvvtmCxu/OsWL0vLWkL9GdgWKDE0XyVoJM+foSOww3lPMxzNn5uywaiB91ektq+AHW3e
 fk0fX+v+Quy/j+uNaR8wVN6tGg7dEJOJ05pzUmlADsTWRI2K6G/Ix7E9XMIKpLZVe9+drarFj
 ciuI5vuQUolL9kDGY+pDVJfTlIEMuF4qIUo11DGQOohSxaCbbkcarA+RmnCBEkGG1/5+eOZrH
 hB2PDD6n04no6MOZWQvP8bLvlcBiXXOD/aSL44beWErQeOEJKUoTRM82+89msY6DPZI2S5GCE
 j7Y+RO8su4jTyNzMcCeRh9YZK9/GzEHbL0LfbxJy0Y23naSrkACJiDu8JptsnOfDNgVIDSQqz
 Va3oPkc26GhFLqmg1FEQZzRmV9KXvFopIYTkgwWiJpRjqlELsI5evywUe8/R0nvDsfg7bWkTc
 xFkOdYEv3dyjanQjvRlm/aannJN1j6Yn5BnJmmrgGaCXeUDZdXDMY80MilHowqSuhlompNLSc
 CV5NZwHILhQ3WEJC98HNQWcMMTKn0/n7jJYtWIPnt2LBrsacDeURScjg/aZs9+44aLhA4GbRX
 Z4SBmTSbVW+VbY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
with i8k_mutex held. Judging from the hwmon code, this mutex
only needs to be held when setting the fan speed/mode, so
the operation of I8K_SET_FAN is guaranteed to be atomic.
Unify both functions and reduce the locking of i8k_mutex
to I8K_SET_FAN.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 186d40938036..d8c6e75bb374 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -449,12 +449,12 @@ static int i8k_get_power_status(void)
  * Procfs interface
  */

-static int
-i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned =
int cmd, unsigned long arg)
+static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long ar=
g)
 {
-	int val =3D 0;
-	int speed, err;
+	struct dell_smm_data *data =3D PDE_DATA(file_inode(fp));
 	int __user *argp =3D (int __user *)arg;
+	int speed, err;
+	int val =3D 0;

 	if (!argp)
 		return -EINVAL;
@@ -516,11 +516,13 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_=
data *data, unsigned int cmd
 		if (copy_from_user(&speed, argp + 1, sizeof(int)))
 			return -EFAULT;

+		mutex_lock(&data->i8k_mutex);
 		err =3D i8k_set_fan(data, val, speed);
 		if (err < 0)
-			return err;
-
-		val =3D i8k_get_fan_status(data, val);
+			val =3D err;
+		else
+			val =3D i8k_get_fan_status(data, val);
+		mutex_unlock(&data->i8k_mutex);
 		break;

 	default:
@@ -536,18 +538,6 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_d=
ata *data, unsigned int cmd
 	return 0;
 }

-static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long ar=
g)
-{
-	struct dell_smm_data *data =3D PDE_DATA(file_inode(fp));
-	long ret;
-
-	mutex_lock(&data->i8k_mutex);
-	ret =3D i8k_ioctl_unlocked(fp, data, cmd, arg);
-	mutex_unlock(&data->i8k_mutex);
-
-	return ret;
-}
-
 /*
  * Print the information for /proc/i8k.
  */
=2D-
2.30.2

