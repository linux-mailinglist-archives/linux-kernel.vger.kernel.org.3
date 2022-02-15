Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809974B75B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbiBOTMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:12:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiBOTLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:11:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C594C3F325;
        Tue, 15 Feb 2022 11:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644952285;
        bh=NE3SmSyvsIc+yp86uyQecHdksbrzxClHB0DUNilnqOA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OtvwKngAVSR/shRSxwjlJXgTh5zFworG4MDT2UIV6VMWCmIMICl9TQNGiRAMD1Tag
         AuSSjuODm1jVyHdoQpK2tGTyIewtYi1yp8Lxh2doM0X06JOeQhd3nu/F6O3BAtW8O+
         8cUvJjBDJOD3e7dfmqyaMgcNpA8rrgKjQRSO7YWo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MnJhO-1o2yq112Zg-00jMv0; Tue, 15 Feb 2022 20:11:25 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] hwmon: (dell-smm) Allow for specifying fan control method as module parameter
Date:   Tue, 15 Feb 2022 20:11:07 +0100
Message-Id: <20220215191113.16640-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215191113.16640-1-W_Armin@gmx.de>
References: <20220215191113.16640-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HVzF3y0zGHeiywKVaVpwx7TYM3H+BD0YL2OG29O+G3VRu4+VTAo
 dTwu1OH8O/nU2arjGwkhGIUlDkZX+HNPcfgKviJhOwyPNv+p0vaYvTETetU+5wdZnOZh61+
 2WT46vOTZYi7xw1+eTwV5eFevn8B7gpLxoxn3qRTGTg8P1451wCuTnLX1JYAF2zhjDuRnhI
 2Eqf48CB2sG+5WCT0r/rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5zpQqalhucc=:cLFptNfyNxoMPlxLvNRz3Q
 weRFcRM+cACUSMaBnDgnYXQuwlV1bCzNLNL77XM0x+O33S5fDNlNOHTPXEBdoJjL7QMkQLhwn
 2VnVAFZPSDfP3i5vQkhxmmJkwNSCRh8buwNJVH0nR78mDa+Kicg4TSOjncZy/C5pF0cOBUZzC
 RhoGmxDMQ7kpiPShYuZjkY2RRl7HB08Cgv3eU0xWCXrJDdNqPfWr7TTAkgGR0aULUZ4M020dN
 gku+DuuNUFBylVmxW6NOCTgcaoS0HzDMGLcHRKcwjvsMY4MrHUMTgQbdjvyOhata8/Bds15bN
 PYkSfi0FLWSMdXayuw+a2viXZLxQazTrLhLpL3uQ1f6b7vlw/Ir5zMxu05VmWUoIp/0c4WfsG
 mCXXZjONO09RkOwSgTty01ywmuFjKdu+OecgyayJe0SR/HvqDXRoJjUx5Qp3QRdlFobxrxLzR
 XT1W7JlnH32EPKS2VhZQUVliuuaOV8LTWyeQgoZV/5XE7IzKarl2d5TxSoBQ9zG0G/pp63vI0
 /7Mh/tD+75SHHgl/Pw5PSpILLIyCqqserEHul8nVTYOvgRtF2tgDgtu4rKbI5fmKw188VSdSG
 d3lLjW8ZId8yIkJZ/+r7u+5VgRJ19t6Z3DGDKAm5WZ/dNt4yCoyVgXc57rXI7XGZwsZ1KFIxD
 NvASh7zp1vZD0f4uUoE8Z6wpneRE2TOTY+uNtFru0t4BLZLrTkDR5I15qZawxH8UjYLrulixI
 KXWocjbb0CYGjpdHDb6GVs4MsykGF3M3lqZM8fNrkh6RxTW/h0vmZ4Qp7WblavBKJ1d9waYAd
 gu/21DPK3cUMdDEk4bqFciiqyuJbvJOe69ylyZPhkKTlp7us1MEyWt1RWfq7d8dJmmS52rGKA
 qT2btiLnjt7uxWoi25X3fx93MKStPQOsbxqWNB+6RWmZwXJxku9lNSRCO0KeX1Q41qUBjc4PF
 64AYkHWvmKl1oGeNY4ULR4xaMAlRfwIcvwcCoDgkPfa7rYg11wZ3oKWymCTvWLnSG0XKpghrM
 WWHsEFEFk0eRmrnoRYvCxklaE167VLhwFBU/Q39ZQ5vDMTFpKPFfsOlle1K3n6U/z8sAK2SUx
 DwprT0by1nLdQ4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the only way to test if setting manual/auto fan control works
is to edit and recompile the module, which may be too cumbersome for
the average user.
Allow for specifying the desired fan mode control method when loading
the module, but taint the kernel if so since there is the possibility
for strange side effects on non-whitelisted models.
Also update docs and kernel-parameters.txt accordingly.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../admin-guide/kernel-parameters.txt         |  3 +++
 Documentation/hwmon/dell-smm-hwmon.rst        | 21 ++++++++++------
 drivers/hwmon/dell-smm-hwmon.c                | 25 +++++++++++++------
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
index d68053db21cc..4f1b6c2b7ed1 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -968,6 +968,9 @@
 	dell_smm_hwmon.fan_max=3D
 			[HW] Maximum configurable fan speed.

+	dell_smm_hwmon.fan_mode_method=3D
+			[HW] Method to use for changing fan mode.
+
 	dfltcc=3D		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index beec88491171..564d99cda869 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -67,13 +67,16 @@ for your hardware. It is possible that codes that work=
 for other
 laptops actually work for yours as well, or that you have to discover
 new codes.

-Check the list ``i8k_whitelist_fan_control`` in file
-``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree: as a first
-attempt you can try to add your machine and use an already-known code
-pair. If, after recompiling the kernel, you see that ``pwm1_enable``
-is present and works (i.e., you can manually control the fan speed),
-then please submit your finding as a kernel patch, so that other users
-can benefit from it. Please see
+As a first step, you can load the module with the module parameter
+``fan_mode_method`` set to 1 to test if your hardware works with
+an already know method for disabling automatic BIOS fan control.
+If ``pwm1_enable`` is now present and works (i.e., you can
+manually control the fan speed), then please submit your finding
+as a kernel patch, so that other users can benefit from it.
+Just add your model to the list ``i8k_whitelist_fan_control`` in
+file ``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree and use
+the already known code pair.
+Please read
 :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
 for information on submitting patches.

@@ -120,6 +123,10 @@ Module parameters
                    Maximum configurable fan speed. (default:
                    autodetect)

+* fan_mode_method:uint
+                   Method to use for changing fan mode (default:
+                   from whitelist)
+
 Legacy ``/proc`` interface
 --------------------------

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 9949eeb79378..1c4cc516c8b2 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -111,6 +111,10 @@ static uint fan_max;
 module_param(fan_max, uint, 0);
 MODULE_PARM_DESC(fan_max, "Maximum configurable fan speed (default: autod=
etect)");

+static uint fan_mode_method;
+module_param_unsafe(fan_mode_method, uint, 0);
+MODULE_PARM_DESC(fan_mode_method, "Method to use for changing fan mode (d=
efault: from whitelist)");
+
 struct smm_regs {
 	unsigned int eax;
 	unsigned int ebx;
@@ -677,7 +681,7 @@ static umode_t dell_smm_is_visible(const void *drvdata=
, enum hwmon_sensor_types

 			break;
 		case hwmon_pwm_enable:
-			if (data->auto_fan)
+			if (data->auto_fan && data->manual_fan)
 				/*
 				 * There is no command for retrieve the current status
 				 * from BIOS, and userspace/firmware itself can change
@@ -1282,14 +1286,21 @@ static int __init dell_smm_probe(struct platform_d=
evice *pdev)
 	data->i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
 	data->i8k_pwm_mult =3D DIV_ROUND_UP(255, data->i8k_fan_max);

-	fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
-	if (fan_control && fan_control->driver_data) {
-		const struct i8k_fan_control_data *control =3D fan_control->driver_data=
;
+	/* value specified via module param overrides whitelist */
+	if (fan_mode_method > 0 && fan_mode_method <=3D ARRAY_SIZE(i8k_fan_contr=
ol_data)) {
+		data->manual_fan =3D i8k_fan_control_data[fan_mode_method - 1].manual_f=
an;
+		data->auto_fan =3D i8k_fan_control_data[fan_mode_method - 1].auto_fan;
+	} else {
+		fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
+		if (fan_control && fan_control->driver_data) {
+			const struct i8k_fan_control_data *control =3D fan_control->driver_dat=
a;

-		data->manual_fan =3D control->manual_fan;
-		data->auto_fan =3D control->auto_fan;
-		dev_info(&pdev->dev, "enabling support for setting automatic/manual fan=
 control\n");
+			data->manual_fan =3D control->manual_fan;
+			data->auto_fan =3D control->auto_fan;
+		}
 	}
+	if (data->manual_fan && data->auto_fan)
+		dev_info(&pdev->dev, "enabling support for setting automatic/manual fan=
 control\n");

 	if (!fan_mult) {
 		/*
=2D-
2.30.2

