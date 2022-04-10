Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE64FAF03
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243659AbiDJQmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiDJQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:42:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F114E4B425;
        Sun, 10 Apr 2022 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649608782;
        bh=bfUht+yhKihneEx/gIXnhunosYC6w8n5u6B/KWD2U9M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZZDNZSzdfiW9bZI5gmLm87AjTgnW/OKWrp0uDgejZA+ZT6aTGsAVfOSkH4YU1oxVM
         LhmfgYlue7uj4/KhLYdI6DYxUq2UG5tl94J4q1isKeBiIs8zPdGnVMj7Pg50Xb0JAa
         qsmoZUI6pmDKGNxmK/de5OMbFseTb99AeyKvtRv4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MxDou-1ntCg22FJI-00xcus; Sun, 10 Apr 2022 18:39:42 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (dell-smm) Add cooling device support
Date:   Sun, 10 Apr 2022 18:39:35 +0200
Message-Id: <20220410163935.7840-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n+7Lxcy2/VGK2kh3KSYSpbyBIvw1M44yU3ceKHmyb83PCvevLQj
 n2/8r/GNNz8c0S0r4kYlIpsBUQRtv5uoPqJ54Q0eZWOjWoziicnvAVPk6YdELS5KwaLmgcA
 e/696hlzVuE4rBMGQ4HDRrz+uAM7UeFUsRMJ3UKjAGgH6q7Ds7PpLcHBwdv/nsl2oxov+V6
 nDbS+ggatYfZFBUbJlYzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jdPJmCfZNYw=:DKcgYAgnkzfEDESqt6XO6o
 IUbtNG9uzJwXWSoCzvaxgs8kCuglPeD1rsYrd1gdqnwwCKWBybsAgMssdedXURj8JiY54Rzsr
 dTVYUq3uXGBZVXTE52dSstxOLd3p3ZII51ZdjQUEN6AP46aMdjQzyt51KMjBMhaAkMPzffQ/0
 PGEinW6LtmDfmXhdWHPAxkq5HLuC3ZdlZ8/WJnvLL2xX4iYOkCwuxccP7QyETAMqqLyKug9f2
 DC0KocXwk3VNOj8Rhpc47xaJF1ooaZJZejnl8UwXXh2WTgwQq45V8u/vC662rIyXEZdT+gngl
 HiTamlbDtjHj5JF5lJxORiaXz+3scu0uiSZmWbnVcdjUsZvMHBA6RaCOWXNXImgaYYSwp2R5s
 fIbvFX0iYObhb0HtM8Vc8jxaTyB13UHxQhVhaorZ+4DVI+ssQu+Hirt3mvkMIW3+KEBiEMG0D
 4YKix5Y6JUcpRaJtCbI+SCz7PtGHCGRiwRyhXrA6aOQZD5ZqITZtz5yn1LTikXXtWmycXNoWm
 5cnE+5rwqoDNP/Y5r7WCm1FqeXLE6fijCxYhAxjMwb6zUIo3UwetZgz02ZsvakfFf5gi8QxT4
 WkpJJaLr8kWysUEgIqU0cufMlviipzngevhb51BRZ59qriGU3FOARURM9xqL+DqoosF6EvAgK
 6AJtYS/MkT57U7C16cLDeg6GAYT3nFNGDlbbylf2T2rrIaemBPBKE+4iFaiJDqNFd6Yw0Lb7r
 gJE3acJ44kThDTFi9Inin11l8O/Z3G3Ewz6VJUGpLrID7dAJlSGMAJcD6Sxya7grh1LZPvCPB
 hLnxOZ5MAev+tBFkoQicRmr6Krx04XgFYzilBoQCcKxG9rm++QfKnZ4OgHcQzsv5yoga0ru6P
 J91k3CezxSOgkDWD6g5inzuJsQOuTS1mKV2USEZj295tvzJdCe7KxrmIzemc116I9bZFVjLyJ
 +jK76IPJVe2baEehYf4pwXcQu5RCQdwnndpmBxi9x8J54qvtPc5QJjT1OsDdysU4MVacXprjP
 Z8N7RBpK4uzS6JsfblnC4lgHY1haLnvy3jVPh8RLU/I0MuA39j47QCwoU1zafojrGihwNE9Wu
 SnWLX8Uv9jyIjs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, only the temperature sensors where exported thru
the thermal subsystem. Export the fans as "dell-smm-fan[1-3]" too
to make them available as cooling devices.
Also update Documentation and fix a minor issue with the alphabetic
ordering of the includes.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v2:
- fix spelling mistake
- use dev_warn() instead of dev_err()
- add missing include of slab.h
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst |  7 ++
 drivers/hwmon/Kconfig                  |  1 +
 drivers/hwmon/dell-smm-hwmon.c         | 97 ++++++++++++++++++++++++--
 3 files changed, 101 insertions(+), 4 deletions(-)

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
index 1f1bb4d858cb..b640c751da22 100644
=2D-- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -500,6 +500,7 @@ config SENSORS_DS1621
 config SENSORS_DELL_SMM
 	tristate "Dell laptop SMM BIOS hwmon driver"
 	depends on X86
+	imply THERMAL
 	help
 	  This hwmon driver adds support for reporting temperature of different
 	  sensors and controls the fans on Dell laptops via System Management
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 84cb1ede7bc0..30b6f0c28093 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -21,14 +21,17 @@
 #include <linux/errno.h>
 #include <linux/hwmon.h>
 #include <linux/init.h>
+#include <linux/kconfig.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/string.h>
+#include <linux/slab.h>
 #include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/thermal.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>

@@ -80,6 +83,11 @@ struct dell_smm_data {
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
@@ -638,9 +646,50 @@ static void __init i8k_init_procfs(struct device *dev=
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
@@ -941,6 +990,37 @@ static const struct hwmon_chip_info dell_smm_chip_inf=
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
@@ -967,6 +1047,15 @@ static int __init dell_smm_init_hwmon(struct device =
*dev)
 			continue;

 		data->fan[i] =3D true;
+
+		/* the cooling device is not critical, ignore failures */
+		if (IS_REACHABLE(CONFIG_THERMAL)) {
+			err =3D dell_smm_init_cdev(dev, i);
+			if (err < 0)
+				dev_warn(dev, "Failed to register cooling device for fan %u\n",
+					 i + 1);
+		}
+
 		data->fan_nominal_speed[i] =3D devm_kmalloc_array(dev, data->i8k_fan_ma=
x + 1,
 								sizeof(*data->fan_nominal_speed[i]),
 								GFP_KERNEL);
=2D-
2.30.2

