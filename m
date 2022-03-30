Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA494EC9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348837AbiC3Qfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348711AbiC3Qfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:35:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED15E2;
        Wed, 30 Mar 2022 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648658021;
        bh=Aw52GudjzfV6DBA1f+n4H6s9lkEEzRPi45KdcBXLxZ0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LNkfa0reL5HBrPFyXfSnVY+Aw2Bl3LXKaR5hv9nJ4c1sBBUxk/ni44ICmOMbHgAQT
         ll/vxykhy0Y2bfO9uTxDmEsuTbj9IosozgHiqKm7GmA4VTqR4PZwOJ7GiEikkc25CC
         txrSR15lgDefdi3dsU0wV9YC8nDi5Bh4eqlI8oes=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mj8qd-1oCFXN3IxR-00f9s0; Wed, 30 Mar 2022 18:33:40 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Add cooling device support
Date:   Wed, 30 Mar 2022 18:33:24 +0200
Message-Id: <20220330163324.572437-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tbSqy/9T9ZBldJcHFKXCEAyFh5LU2EBIRmdONn/JNv3Z+98KbMw
 Izfpr/J+cJWyUOdsRgMG1s96WSJqu7tXUs+KJYpVBRnvfSYS+t9X9KMY+xf4UX43vJEOTWo
 BqeSxpbPmfKf0OdqDU7VQbdDNQQ0rJGM1guQ8CilLwHhd4zfnTXP5nbYuXpF+L5ghIrMT2Q
 BvjnI+P7WBuZ+sW6RI43Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TX1inUXOY+g=:Q4a1QCJ8KXVnRJYHeHMC3g
 Ykq5Na8Y+mjHCtCePKOaLFLWPpBPtB/BjW6dGXuKB9IkUS1wTinJGdy4gO4Ev6oh2PA8vbHEa
 6Z+eWhlNNRbM2s5uVQiNafbwfjgdHS/bpxpTwN1KB70pkfJdZ6UPNbQUBCZ8C2Ydog1/ZtQAt
 vqnjml3b9Py8MmqtK9qwscRW1CjfUvGBArmi1PB5+GL+SUzmcszm5d1JIhDwgEQjJVF8khSO5
 Gp2WUEmCft0Vv5B3AFbyvapphQfEPCb3k6gkGqX8aK2qJB8qWWcjjamSKVr6svgpMoYNxjW/G
 xkTy/iXcLbFHK5jId/MLrXa6ife3tUNNIoqH0030GXABcepnjJLfXYNJaweZzLAqI1vi1dv3B
 NCPoAAvQTAZ6+JQnZf1tP51VN+0e5Qs/89tR7X20JG4rTc9fYKKh75JGNb7mjOvedLcqxM/HZ
 Y84Lj/aBZKt7+81S/UFiIAPeLsHcuYq50jXNxo+CSVHqj9zd9pTAJ67/R2nJcJLQAGxomGZqf
 XaU5GbMvtm6FKCTFs3BgU33aCMTZEvQey7Fy5wiOQoNCzeJ/VEH1So6Ge0FHu5w4mLbNHtBNB
 a4QzvIX4UqGjfiy/ZYtdzsIhYY43XMk/0D+Ok0nveJDQj6j6m/BHEdF+h0qAFFie5Qfjc44ng
 ZQjUGZ186KnI4OjGWd7iykx6ZStrWlEJAbp+hZIv/zJmojY3TNpPaxC7CrXOL+c/wYvYCu9Dk
 gERIsF2pfYkspJEqqhYL4NKNKvV/V7Q6fpKGcolEWc+YnHRa3J2v6dLUvDgEOo12QcN21NCyf
 4b0SpR+yIgfyz7URxc0nq3VdrjTMmmhdp+85NuaKPbqWP4yFls3K8i3apqLDipXpbhimOUAfP
 F+qogR1vxdF8/EeVOOkjG/LJCbFhJw+NitOaBoUhVJiQu+YuxIx5kjCLOjvbYVKuPYNnTxh5J
 pC+jA26vYBMlGj7xyAnFwKUIyhU4Go5FUfGT20ixP+IFhXGZMb6/vpcORhDRAE12EUPyGxJWB
 TaQBYvjIYYgXxhqdwBtTM82j4+0nrE5kfCfTMyUUiPpMX7feZfdda69GD2l9ivAAF1ikBo9zw
 27corAm0O1RiGA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, only the temperature sensors where exported thru
the thermal subsystem. Export the fans as "dell-smm-fan[1-3]" too
to make them available as cooling devices.
Also update Documentation.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst |  7 ++
 drivers/hwmon/Kconfig                  |  1 +
 drivers/hwmon/dell-smm-hwmon.c         | 94 +++++++++++++++++++++++++-
 3 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index d3323a96665d..41839b7de2c1 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -86,6 +86,13 @@ probe the BIOS on your machine and discover the appropr=
iate codes.

 Again, when you find new codes, we'd be happy to have your patches!

+``thermal`` interface
+---------------------------
+
+The driver also exports the fans as thermal cooling devices with
+``type`` set to ``dell-smm-fan[1-3]``. This allows for easy fan control
+using one of the thermal governors.
+
 Module parameters
 -----------------

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9ab4e9b3d27b..1175b8e38c45 100644
=2D-- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -498,6 +498,7 @@ config SENSORS_DS1621
 config SENSORS_DELL_SMM
 	tristate "Dell laptop SMM BIOS hwmon driver"
 	depends on X86
+	imply THERMAL
 	help
 	  This hwmon driver adds support for reporting temperature of different
 	  sensors and controls the fans on Dell laptops via System Management
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 84cb1ede7bc0..0c29386f4bd3 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -21,6 +21,7 @@
 #include <linux/errno.h>
 #include <linux/hwmon.h>
 #include <linux/init.h>
+#include <linux/kconfig.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -29,6 +30,7 @@
 #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/smp.h>
+#include <linux/thermal.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>

@@ -80,6 +82,11 @@ struct dell_smm_data {
 	int *fan_nominal_speed[DELL_SMM_NO_FANS];
 };

+struct dell_smm_cooling_data {
+	u8 fan_num;
+	struct dell_smm_data *data;
+};
+
 MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
 MODULE_AUTHOR("Pali Roh=C3=A1r <pali@kernel.org>");
 MODULE_DESCRIPTION("Dell laptop SMM BIOS hwmon driver");
@@ -638,9 +645,50 @@ static void __init i8k_init_procfs(struct device *dev=
)

 #endif

-/*
- * Hwmon interface
- */
+static int dell_smm_get_max_state(struct thermal_cooling_device *dev, uns=
igned long *state)
+{
+	struct dell_smm_cooling_data *cdata =3D dev->devdata;
+
+	*state =3D cdata->data->i8k_fan_max;
+
+	return 0;
+}
+
+static int dell_smm_get_cur_state(struct thermal_cooling_device *dev, uns=
igned long *state)
+{
+	struct dell_smm_cooling_data *cdata =3D dev->devdata;
+	int ret;
+
+	ret =3D i8k_get_fan_status(cdata->data, cdata->fan_num);
+	if (ret < 0)
+		return ret;
+
+	*state =3D ret;
+
+	return 0;
+}
+
+static int dell_smm_set_cur_state(struct thermal_cooling_device *dev, uns=
igned long state)
+{
+	struct dell_smm_cooling_data *cdata =3D dev->devdata;
+	struct dell_smm_data *data =3D cdata->data;
+	int ret;
+
+	if (state > data->i8k_fan_max)
+		return -EINVAL;
+
+	mutex_lock(&data->i8k_mutex);
+	ret =3D i8k_set_fan(data, cdata->fan_num, (int)state);
+	mutex_unlock(&data->i8k_mutex);
+
+	return ret;
+}
+
+static const struct thermal_cooling_device_ops dell_smm_cooling_ops =3D {
+	.get_max_state =3D dell_smm_get_max_state,
+	.get_cur_state =3D dell_smm_get_cur_state,
+	.set_cur_state =3D dell_smm_set_cur_state,
+};

 static umode_t dell_smm_is_visible(const void *drvdata, enum hwmon_sensor=
_types type, u32 attr,
 				   int channel)
@@ -941,6 +989,37 @@ static const struct hwmon_chip_info dell_smm_chip_inf=
o =3D {
 	.info =3D dell_smm_info,
 };

+static int __init dell_smm_init_cdev(struct device *dev, u8 fan_num)
+{
+	struct dell_smm_data *data =3D dev_get_drvdata(dev);
+	struct thermal_cooling_device *cdev;
+	struct dell_smm_cooling_data *cdata;
+	int ret =3D 0;
+	char *name;
+
+	name =3D kasprintf(GFP_KERNEL, "dell-smm-fan%u", fan_num + 1);
+	if (!name)
+		return -ENOMEM;
+
+	cdata =3D devm_kmalloc(dev, sizeof(*cdata), GFP_KERNEL);
+	if (cdata) {
+		cdata->fan_num =3D fan_num;
+		cdata->data =3D data;
+		cdev =3D devm_thermal_of_cooling_device_register(dev, NULL, name, cdata=
,
+							       &dell_smm_cooling_ops);
+		if (IS_ERR(cdev)) {
+			devm_kfree(dev, cdata);
+			ret =3D PTR_ERR(cdev);
+		}
+	} else {
+		ret =3D -ENOMEM;
+	}
+
+	kfree(name);
+
+	return ret;
+}
+
 static int __init dell_smm_init_hwmon(struct device *dev)
 {
 	struct dell_smm_data *data =3D dev_get_drvdata(dev);
@@ -967,6 +1046,15 @@ static int __init dell_smm_init_hwmon(struct device =
*dev)
 			continue;

 		data->fan[i] =3D true;
+
+		/* the cooling device it not critical, ignore failures */
+		if (IS_REACHABLE(CONFIG_THERMAL)) {
+			err =3D dell_smm_init_cdev(dev, i);
+			if (err < 0)
+				dev_err(dev, "Failed to register cooling device for fan %u\n",
+					i + 1);
+		}
+
 		data->fan_nominal_speed[i] =3D devm_kmalloc_array(dev, data->i8k_fan_ma=
x + 1,
 								sizeof(*data->fan_nominal_speed[i]),
 								GFP_KERNEL);
=2D-
2.30.2

