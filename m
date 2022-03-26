Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76914E83C4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiCZT2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiCZT2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:28:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3D457498;
        Sat, 26 Mar 2022 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648322775;
        bh=BhYwGJesufnhB1BugiBJY7l8WrEGuEqC2mGAreqhWuE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DMR8XN6EnCWR38zGCa+LYRE1rVwuxxtXvGENMiZk/YAVBHNEotdDmRKfvNRJM4vzd
         1wQ3qnDliXLXTTE+oQvtPfZtR5LLcOI0ig77GsaImVznnzOPaeSrmKp+v/KpS8cFzv
         SFgyJtFqoKLCi2Kh+IPV5cRigY0dX+qpZ1CW+Mx8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M1Ygt-1nVABI0X6J-0034Md; Sat, 26 Mar 2022 20:26:15 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] hwmon: (dell_smm) Add cooling device support
Date:   Sat, 26 Mar 2022 20:25:09 +0100
Message-Id: <20220326192509.23175-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XNw4w5M70AJchJrK8wKkebOiS3TxRSb0azt4ds2uX4w3jAmQv+k
 0o6JtT7HnaI0itW31f1ABeovugR/pcg+pON3VWjbRmKNqi5DtIioUszO3qjZfHOT2kZS6sb
 aAzEAvsZdUwEbNumQYciugjkx6b2qQmYON+hFGeUXV2nsF3hsAiFgwvnoPmtKhvrpPD5Njq
 IAqWZsSG27W2xmk11+aKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B132diyDJ4A=:0ujCpCgsjuRQf/LUXKrs9C
 8N5xrD9xD2H6HwEDEE9V28N4TehDnkl0UYvAl6uIc/yAY7ETeYCs9KG+/cLo+6DKRQ+7wYPy8
 AYnevOnYEKyaMLfYuNwAcwFIMuGK11zz9HDLN2sVCrEsyAMFxgnIImAsu7PfeFGKHRjXy6TOS
 44V9DCx0WticGTbnXWUZtlP/5H4BSdUx9B36ulWRJ63n4n3g3UCnWV7LvaN/IhAeP5I+Lm9id
 z68wItR59tkdtTXyqTxbfDafPqF1S842nM9pYc7TUFQfaydlzUmk7hjK8wQxNXR2EyEmTkkX/
 F+uCV06sN+8Ujp8pzA6Un8J/xsE/zT/poLJzODHeHrWh9cfoykfDrM0VfAk3H3Qm5ZCHE6H1g
 rPteKghBpLvNMxSt0z0Lfa4ss7JBO+awZwWmCDH2KO5NARPn7svqsyfZm2l8Be5XUK8oF0+Bt
 hUhVHI+GVPoiWXqlI0fShcosg41YU4IGspPFUOkK0EPD4baBta1VxWBXTkN6BLGfCZBXwLTd+
 zhlfX5vCDO1MPrhdHuwDGaGG1W1SpkI25Xt7GmUaT2pYNMrt5WR0l5mSK1MeEUOe81dUla8fX
 TSR9ZSj/kuZ97KnVxE1T/PfcDcuATx/EdNr4QdwevLNs5wwoFUJJsd43LKzIjUajl9Nc6rpjo
 S3c8gO/WTqTAgJCGZ04W2NdNa48pZA3u8aQyHDtNU0Qcx8ETWPLmEa+IS2UDrbjc3O8ejHXS8
 OGoFEL+e5k0YdMEFCu/e/ONjE2ZXWvS089nM47XVUSwrflZAXbziJZ/4/o6RVzZdoA++QdxkW
 1V1mkSACAjHNryOka6xoKS3qHCRrvsoXJdRb+vSUkR/T1AonWiETGb2Uy5KXDG4LlVxEUwoUC
 TXCIqFRROu1O3k+hzS/hgpOkr230XR9l+g+lCbwzWc6PjprfxuS191oGGCL0BxHXZfB81pOGG
 dgL3QaO5XRXAjQFLmT7/lyUndhiZSia4F+N1naGs+jrdVY3MlLxv4uj6IawZO+NAn1ilChtCW
 Wg/VnN+jSiTPos/Lg/TU9eiWG2LiIp95Mb+QsQn9udvUqdmrA4JJUsJku5KmH96inaYrgW6rq
 vLkLt5vNlAs42Y=
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
the thermal subsystem. Export the fans as "dell-smm-fan" too
to make them available as cooling devices. This could be a
potential successor of the nonstandard procfs interface
currently provided by the driver.
Also update Documentation.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst |  7 +++
 drivers/hwmon/dell-smm-hwmon.c         | 68 ++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index d3323a96665d..da07e39935f1 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -86,6 +86,13 @@ probe the BIOS on your machine and discover the appropr=
iate codes.

 Again, when you find new codes, we'd be happy to have your patches!

+``thermal`` interface
+---------------------------
+
+The driver also exports the fans as thermal cooling devices with
+``type`` set to ``dell-smm-fan``. This allows for easy fan control
+using one of the thermal governors.
+
 Module parameters
 -----------------

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 84cb1ede7bc0..fb2c70875c0a 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -29,6 +29,7 @@
 #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/smp.h>
+#include <linux/thermal.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>

@@ -80,6 +81,11 @@ struct dell_smm_data {
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
@@ -638,9 +644,50 @@ static void __init i8k_init_procfs(struct device *dev=
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
+	ret =3D i8k_get_fan_speed(cdata->data, cdata->fan_num);
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
@@ -944,6 +991,8 @@ static const struct hwmon_chip_info dell_smm_chip_info=
 =3D {
 static int __init dell_smm_init_hwmon(struct device *dev)
 {
 	struct dell_smm_data *data =3D dev_get_drvdata(dev);
+	struct thermal_cooling_device *cdev;
+	struct dell_smm_cooling_data *cdata;
 	struct device *dell_smm_hwmon_dev;
 	int state, err;
 	u8 i;
@@ -967,6 +1016,19 @@ static int __init dell_smm_init_hwmon(struct device =
*dev)
 			continue;

 		data->fan[i] =3D true;
+
+		/* the cooling device it not critical, ignore failures */
+		cdata =3D devm_kmalloc(dev, sizeof(*cdata), GFP_KERNEL);
+		if (cdata) {
+			cdata->fan_num =3D i;
+			cdata->data =3D data;
+			cdev =3D devm_thermal_of_cooling_device_register(dev, NULL, "dell-smm-=
fan",
+								       cdata,
+								       &dell_smm_cooling_ops);
+			if (IS_ERR(cdev))
+				devm_kfree(dev, cdata);
+		}
+
 		data->fan_nominal_speed[i] =3D devm_kmalloc_array(dev, data->i8k_fan_ma=
x + 1,
 								sizeof(*data->fan_nominal_speed[i]),
 								GFP_KERNEL);
=2D-
2.30.2

