Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E57510B66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355534AbiDZVfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355528AbiDZVfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:35:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D46473B7;
        Tue, 26 Apr 2022 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651008718;
        bh=NKFKAKCLTOL1m3NDU/BmygYePpH8tCNAz8bh93sKgz0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UnWmWUgloGYQyZ3ZSEkzNybE9hnC0VINAmK6KIMHhaBkdfpi742FR/3jIAoWOOuOt
         2P0Cw/5BZwRjyUPHfVpgGtOJwxlU6+6E5XNN3KdDGegbB2Dn73bJGHLNaEz3G/XDtN
         hKMuBXv391gzf0jL96xz3gZ7hEUef4Jiyb6HPF/U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mzyuc-1o7C8m1ZYM-00x2rC; Tue, 26 Apr 2022 23:31:58 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] hwmon: (dell-smm) Avoid unnecessary SMM calls during init
Date:   Tue, 26 Apr 2022 23:31:52 +0200
Message-Id: <20220426213154.724708-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426213154.724708-1-W_Armin@gmx.de>
References: <20220426213154.724708-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XczC9ZRL7DOxRk1A1C9yu96lr6ybK1gJs+016LkFsWLDmQwRzSd
 G+xl+rxPJ9DcVS8XWqH+rsEjulourYGF56U5jekakquprj6mnUMhy67Kl/ztDIcnYW/79BK
 bK5wjRjGqYoewjbTWcQGq4v+hFI4dZ3fXDsqZ0V1DXC8hMnMymxuQGtP/WAoCAQg1Fam/JF
 4uhQwgkeSKPXKsXa0GPWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YzSxZhxqQVo=:arID7AYbt4NarKTmdiL+pW
 OEyn4ni2d/Yvg06Frz0bp80AVqd9R4veMTTc3oIPp4thq5Q4cRlLqjcbdm6VCjoEkkuPID276
 AtskAKrGZzaXJM6zpd8XX+32WLeIbDfBvALQheufeS48jnfh974zF+iJLnJj8RdwE9QjDSlo2
 F4GkgEqJiWmAgtt9RGKeDFNi1E/PBrbQdhrSapey5uRfhwy/n/hba+7iygIb3sHK2fSy+kw1b
 sSEy+ZM1B7FZx5pmzlfFWyLwjl7ZSl5u2RRpmV+bAVGf6DE11l5dFRE+shkE9xWd2zUTS8B57
 pgWnCeQhEsdwRDgKCHC78pc8vrdTyh1uzDoRiRc7v4TsZwAUPjBwiUDTtzyCF3PoTP+P8vZMH
 CdzrxmHxz+rMm+hmg9hElnvvOT01A8xWzDb1aGNZXeFc6iFhLDHL8gmo6jAefVr2jx+jYoFER
 JFlorAi//QaQGBx7EpKlWT/MWNM1eeI8/jbjA4rJ2Wme2NgdZnBFhLtYONd5zOFJTpuqhPisf
 wPPMpD/0dDtLsyK8aoa9QOja/QtWy2cX3FTBvU1YsueSoTfXGeo339pPmOB+WlptqOJloshJA
 L+SpePt8DQMdZr1pNNbsglxkatp29jzlmh3RWPumKlKcHLgsgqtyVzKcqThDLI6N6SqyYzO9v
 RPSvQ5iObd/OCz4hn+W62urk5iHphCGlCvMKq2eaZy6AxApcsylI8IijviHUKSCnFlcfcWByw
 CSFU43sHUjznmU+76lnH8msjrXArOQxCL0TF1yZ7QhSuH6B0CPzofafKFjr5Q47oExg1EiInG
 XCFqNt3Fu7DobqrnmfnwgTkVJv6uE6rDrBm4mKIQm102cOFlMSrl+lO3QjaKuRu5F7+XvB7AB
 sOkGQpcUMR//youI1MVDaMD77PPv3GYA6uNKYoWZ0dE4YynmglYFVCeoZYliuF3fZDP3kiX8M
 PS7KYvhfP7sHEXZyQPecOu/hLs88RfPtrchzojF5mTHNDbifpxBEpphyRutYBB8E0McOj/gRU
 EqtfgYkOsoyNU9XIWwF6xGlTDjUh8N3a4YBs5FoLIb5TRjPZI3tqTJahe1l5dpjXsXuLFevtH
 gEpzu2IRbdXBzI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver tries to detect the fan multiplier during
module initialisation, it issues one SMM call for each fan.
Those SMM calls are however redundant and also try to query
fans which may not be present.
Fix that by detecting the fan multiplier during hwmon
initialisation when no extra SMM calls are needed.
Also dont assume the last nominal speed entry to be the
biggest and instead check all entries.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 37 +++++++++++++---------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 30b6f0c28093..202ee884de9e 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -50,7 +50,7 @@
 #define I8K_SMM_GET_DELL_SIG2	0xffa3

 #define I8K_FAN_MULT		30
-#define I8K_FAN_MAX_RPM		30000
+#define I8K_FAN_RPM_THRESHOLD	1000
 #define I8K_MAX_TEMP		127

 #define I8K_FN_NONE		0x00
@@ -326,7 +326,7 @@ static int __init i8k_get_fan_nominal_speed(const stru=
ct dell_smm_data *data, u8
 	if (data->disallow_fan_support)
 		return -EINVAL;

-	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * data->i8k_fan_mult;
+	return i8k_smm(&regs) ? : (regs.eax & 0xffff);
 }

 /*
@@ -776,6 +776,7 @@ static int dell_smm_read(struct device *dev, enum hwmo=
n_sensor_types type, u32 a
 			 long *val)
 {
 	struct dell_smm_data *data =3D dev_get_drvdata(dev);
+	int mult =3D data->i8k_fan_mult;
 	int ret;

 	switch (type) {
@@ -804,11 +805,11 @@ static int dell_smm_read(struct device *dev, enum hw=
mon_sensor_types type, u32 a

 			return 0;
 		case hwmon_fan_min:
-			*val =3D data->fan_nominal_speed[channel][0];
+			*val =3D data->fan_nominal_speed[channel][0] * mult;

 			return 0;
 		case hwmon_fan_max:
-			*val =3D data->fan_nominal_speed[channel][data->i8k_fan_max];
+			*val =3D data->fan_nominal_speed[channel][data->i8k_fan_max] * mult;

 			return 0;
 		case hwmon_fan_target:
@@ -819,7 +820,7 @@ static int dell_smm_read(struct device *dev, enum hwmo=
n_sensor_types type, u32 a
 			if (ret > data->i8k_fan_max)
 				ret =3D data->i8k_fan_max;

-			*val =3D data->fan_nominal_speed[channel][ret];
+			*val =3D data->fan_nominal_speed[channel][ret] * mult;

 			return 0;
 		default:
@@ -1071,6 +1072,13 @@ static int __init dell_smm_init_hwmon(struct device=
 *dev)
 				break;
 			}
 			data->fan_nominal_speed[i][state] =3D err;
+			/*
+			 * Autodetect fan multiplier based on nominal rpm if multiplier
+			 * was not specified as module param or in DMI. If fan reports
+			 * rpm value too high then set multiplier to 1.
+			 */
+			if (!fan_mult && err > I8K_FAN_RPM_THRESHOLD)
+				data->i8k_fan_mult =3D 1;
 		}
 	}

@@ -1359,7 +1367,6 @@ static int __init dell_smm_probe(struct platform_dev=
ice *pdev)
 	struct dell_smm_data *data;
 	const struct dmi_system_id *id, *fan_control;
 	int ret;
-	u8 fan;

 	data =3D devm_kzalloc(&pdev->dev, sizeof(struct dell_smm_data), GFP_KERN=
EL);
 	if (!data)
@@ -1414,24 +1421,8 @@ static int __init dell_smm_probe(struct platform_de=
vice *pdev)
 		dev_info(&pdev->dev, "enabling support for setting automatic/manual fan=
 control\n");
 	}

-	if (!fan_mult) {
-		/*
-		 * Autodetect fan multiplier based on nominal rpm
-		 * If fan reports rpm value too high then set multiplier to 1
-		 */
-		for (fan =3D 0; fan < DELL_SMM_NO_FANS; ++fan) {
-			ret =3D i8k_get_fan_nominal_speed(data, fan, data->i8k_fan_max);
-			if (ret < 0)
-				continue;
-
-			if (ret > I8K_FAN_MAX_RPM)
-				data->i8k_fan_mult =3D 1;
-			break;
-		}
-	} else {
-		/* Fan multiplier was specified in module param or in dmi */
+	if (fan_mult)
 		data->i8k_fan_mult =3D fan_mult;
-	}

 	ret =3D dell_smm_init_hwmon(&pdev->dev);
 	if (ret)
=2D-
2.30.2

