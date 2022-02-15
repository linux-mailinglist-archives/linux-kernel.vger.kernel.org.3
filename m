Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF9A4B7779
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbiBOTRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:17:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiBOTRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:17:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8FEDF04;
        Tue, 15 Feb 2022 11:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644952616;
        bh=QBp47Ao8hk1CypxEZVLu5PS8jzIXoGO+0fq3zbtf9bQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cS1govI+VnsRtVJW00iWERhGrFI1JlFEAu4sa+vlm/ER6rORqZAKiNor+H7Nw15XH
         7JPbsg1EXdKbZa87wp5zLwVx/5G6qD5REv7ycd4tJZfdvrwwN6dOAsDWyIYO2NrPfl
         r8cf9Wo2Bm0y0OtVOzelKtI1e6DxcoY4Zzna8BB0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MrQEn-1o6XKy3VLz-00oV9N; Tue, 15 Feb 2022 20:11:27 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] hwmon: (dell-smm) Make fan/temp sensor number a u8
Date:   Tue, 15 Feb 2022 20:11:09 +0100
Message-Id: <20220215191113.16640-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215191113.16640-1-W_Armin@gmx.de>
References: <20220215191113.16640-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bauKB2E27lkfRLxkS9zFka7i5hru7LsSR+EZsJwrIs51NxKcNY+
 e8+6bIdsGQbuw0o3jTvZwcCO76Msg/9REDY5BEsTRvpU4fOYF5IXxoY9OfOFNXlmLv7EJnu
 +TXK5PV3rpbulDjATZGtLbOaUvaj6+EXarSBSCMH69B0Qr7tZGpKK7HcCMZahQ7hviCH0V8
 GQdH/sbaCAEHhpfZxMmkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gx3tOgB5GhY=:5K2eZ/FF0upJ/F8nR7VnFY
 SE2EnWv4r20ckBGp9RBn+xjFK2diY2SWsmulmPylwAT2R8I6KHTvlyIVJH1/nW/NjAdOlqK+n
 DdESihLlDKi2I9ushLl1uckvkQUBpT8KhdFFWF+h8JAL2xFo/K1HnlNMLRaJoYsaCheB+Rpw6
 PiYmrL3q3TqhC6pH8oVg51S1yPqcX9olEC1X87EiP5y4hclLrHbQzp3QUa18eAURamc84gehP
 Ha8XHvIu8up3897eRpd/lD0G2Aov3jobJoeXtlBMpxe5k3Z/KxYsySYLSYgeuLUhAvIfri3ko
 olkVrQjqYBSWWmWpRylWHE5owMnnW357SH+mPWK7LIGfiIVRVGXTpVUrl1wikQT4OLtE/QcC3
 X94mFFiUMF56WH8gIijC2Y6AXP7QQz1akeyhs/Z1ER/DxHO+1Umb0azJVrH+dKd2OHX5G5n0v
 tmpqI0TWAVpLLrqvwToYrmIIA1rBwCLAUe9SEnQTPrL9DLQKIdgZfZGwXpe3Qo5JxPBw5ge+T
 o9Zl44o3GCTcakXGHKcHPqHV8yq0e9pP9uNorCi22ed3nTU0PLUH9qXAr+kDYCCDzPc+vQZmW
 J5iGb9vwhC2CcWaRDGJgpRZxzRNK3xb3rRjXlcj90I2GuRPi5IMHbxJv2OBRnTcbyqNGg/tUo
 8vxB3NUkhSHtBeGGwr8JyMnJ3HWKIfObpsCN0Uvc9OccNuV10baAKjfXfmLUxUiu/cZPCYRt1
 RMnVvbc7PV6yi2TIlbTpnnNUGwGQvB8AtZgrXMUZnMM/RxqFm4aG2cmKgvnOkao4m8SgaJ4ux
 qbamAJ9pU7E4gCjNVyPvYooxJuSaN3iInykDnqs+DJGb3uGIeI9pML7nJ6U7jat/BtXP8grWn
 rEmNXCghij7vXJuM7WRv1wqRfLr4gAzi4xpECOHdtJemAJez4IupYYgpaj3Cg95w2KhRuKym7
 /del75wW2fzsRNGIT2on4nDC8zp5fhpR92VmtYd5W3rEYAPIUKlhMLDSjm4RvrGY5VWsgke1p
 I3D7ePpxO6kVC2d5yILfXm5afoVnSrPV5MknYfKg3aeBalLqWmosojEKappKNbZszoyPfCd1+
 EeDwGRtSvy9JzU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, we only use bits 0 to 7 of the fan/temp sensor number
by doing number & 0xff. Passing the value as a u8 makes this
step unnecessary. Also add checks to the ioctl handler since
users might get confused when passing 0x00000101 does the same
as passing 0x00000001.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 68 ++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 3b49e55d060f..a102034a1d38 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -21,6 +21,7 @@
 #include <linux/errno.h>
 #include <linux/hwmon.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
@@ -254,46 +255,52 @@ static int i8k_smm(struct smm_regs *regs)
 /*
  * Read the fan status.
  */
-static int i8k_get_fan_status(const struct dell_smm_data *data, int fan)
+static int i8k_get_fan_status(const struct dell_smm_data *data, u8 fan)
 {
-	struct smm_regs regs =3D { .eax =3D I8K_SMM_GET_FAN, };
+	struct smm_regs regs =3D {
+		.eax =3D I8K_SMM_GET_FAN,
+		.ebx =3D fan,
+	};

 	if (data->disallow_fan_support)
 		return -EINVAL;

-	regs.ebx =3D fan & 0xff;
 	return i8k_smm(&regs) ? : regs.eax & 0xff;
 }

 /*
  * Read the fan speed in RPM.
  */
-static int i8k_get_fan_speed(const struct dell_smm_data *data, int fan)
+static int i8k_get_fan_speed(const struct dell_smm_data *data, u8 fan)
 {
-	struct smm_regs regs =3D { .eax =3D I8K_SMM_GET_SPEED, };
+	struct smm_regs regs =3D {
+		.eax =3D I8K_SMM_GET_SPEED,
+		.ebx =3D fan,
+	};

 	if (data->disallow_fan_support)
 		return -EINVAL;

-	regs.ebx =3D fan & 0xff;
 	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * data->i8k_fan_mult;
 }

 /*
  * Read the fan type.
  */
-static int _i8k_get_fan_type(const struct dell_smm_data *data, int fan)
+static int _i8k_get_fan_type(const struct dell_smm_data *data, u8 fan)
 {
-	struct smm_regs regs =3D { .eax =3D I8K_SMM_GET_FAN_TYPE, };
+	struct smm_regs regs =3D {
+		.eax =3D I8K_SMM_GET_FAN_TYPE,
+		.ebx =3D fan,
+	};

 	if (data->disallow_fan_support || data->disallow_fan_type_call)
 		return -EINVAL;

-	regs.ebx =3D fan & 0xff;
 	return i8k_smm(&regs) ? : regs.eax & 0xff;
 }

-static int i8k_get_fan_type(struct dell_smm_data *data, int fan)
+static int i8k_get_fan_type(struct dell_smm_data *data, u8 fan)
 {
 	/* I8K_SMM_GET_FAN_TYPE SMM call is expensive, so cache values */
 	if (data->fan_type[fan] =3D=3D INT_MIN)
@@ -305,14 +312,16 @@ static int i8k_get_fan_type(struct dell_smm_data *da=
ta, int fan)
 /*
  * Read the fan nominal rpm for specific fan speed.
  */
-static int __init i8k_get_fan_nominal_speed(const struct dell_smm_data *d=
ata, int fan, int speed)
+static int __init i8k_get_fan_nominal_speed(const struct dell_smm_data *d=
ata, u8 fan, int speed)
 {
-	struct smm_regs regs =3D { .eax =3D I8K_SMM_GET_NOM_SPEED, };
+	struct smm_regs regs =3D {
+		.eax =3D I8K_SMM_GET_NOM_SPEED,
+		.ebx =3D fan | (speed << 8),
+	};

 	if (data->disallow_fan_support)
 		return -EINVAL;

-	regs.ebx =3D (fan & 0xff) | (speed << 8);
 	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * data->i8k_fan_mult;
 }

@@ -333,7 +342,7 @@ static int i8k_enable_fan_auto_mode(const struct dell_=
smm_data *data, bool enabl
 /*
  * Set the fan speed (off, low, high, ...).
  */
-static int i8k_set_fan(const struct dell_smm_data *data, int fan, int spe=
ed)
+static int i8k_set_fan(const struct dell_smm_data *data, u8 fan, int spee=
d)
 {
 	struct smm_regs regs =3D { .eax =3D I8K_SMM_SET_FAN, };

@@ -341,33 +350,35 @@ static int i8k_set_fan(const struct dell_smm_data *d=
ata, int fan, int speed)
 		return -EINVAL;

 	speed =3D (speed < 0) ? 0 : ((speed > data->i8k_fan_max) ? data->i8k_fan=
_max : speed);
-	regs.ebx =3D (fan & 0xff) | (speed << 8);
+	regs.ebx =3D fan | (speed << 8);

 	return i8k_smm(&regs);
 }

-static int __init i8k_get_temp_type(int sensor)
+static int __init i8k_get_temp_type(u8 sensor)
 {
-	struct smm_regs regs =3D { .eax =3D I8K_SMM_GET_TEMP_TYPE, };
+	struct smm_regs regs =3D {
+		.eax =3D I8K_SMM_GET_TEMP_TYPE,
+		.ebx =3D sensor,
+	};

-	regs.ebx =3D sensor & 0xff;
 	return i8k_smm(&regs) ? : regs.eax & 0xff;
 }

 /*
  * Read the cpu temperature.
  */
-static int _i8k_get_temp(int sensor)
+static int _i8k_get_temp(u8 sensor)
 {
 	struct smm_regs regs =3D {
 		.eax =3D I8K_SMM_GET_TEMP,
-		.ebx =3D sensor & 0xff,
+		.ebx =3D sensor,
 	};

 	return i8k_smm(&regs) ? : regs.eax & 0xff;
 }

-static int i8k_get_temp(int sensor)
+static int i8k_get_temp(u8 sensor)
 {
 	int temp =3D _i8k_get_temp(sensor);

@@ -500,6 +511,9 @@ static long i8k_ioctl(struct file *fp, unsigned int cm=
d, unsigned long arg)
 		if (copy_from_user(&val, argp, sizeof(int)))
 			return -EFAULT;

+		if (val > U8_MAX || val < 0)
+			return -EINVAL;
+
 		val =3D i8k_get_fan_speed(data, val);
 		break;

@@ -507,6 +521,9 @@ static long i8k_ioctl(struct file *fp, unsigned int cm=
d, unsigned long arg)
 		if (copy_from_user(&val, argp, sizeof(int)))
 			return -EFAULT;

+		if (val > U8_MAX || val < 0)
+			return -EINVAL;
+
 		val =3D i8k_get_fan_status(data, val);
 		break;

@@ -517,6 +534,9 @@ static long i8k_ioctl(struct file *fp, unsigned int cm=
d, unsigned long arg)
 		if (copy_from_user(&val, argp, sizeof(int)))
 			return -EFAULT;

+		if (val > U8_MAX || val < 0)
+			return -EINVAL;
+
 		if (copy_from_user(&speed, argp + 1, sizeof(int)))
 			return -EFAULT;

@@ -924,7 +944,8 @@ static int __init dell_smm_init_hwmon(struct device *d=
ev)
 {
 	struct dell_smm_data *data =3D dev_get_drvdata(dev);
 	struct device *dell_smm_hwmon_dev;
-	int i, state, err;
+	int state, err;
+	u8 i;

 	for (i =3D 0; i < DELL_SMM_NO_TEMP; i++) {
 		data->temp_type[i] =3D i8k_get_temp_type(i);
@@ -1245,7 +1266,8 @@ static int __init dell_smm_probe(struct platform_dev=
ice *pdev)
 {
 	struct dell_smm_data *data;
 	const struct dmi_system_id *id, *fan_control;
-	int fan, ret;
+	int ret;
+	u8 fan;

 	data =3D devm_kzalloc(&pdev->dev, sizeof(struct dell_smm_data), GFP_KERN=
EL);
 	if (!data)
=2D-
2.30.2

