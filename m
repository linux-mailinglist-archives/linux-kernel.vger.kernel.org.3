Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B57F51096F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354395AbiDZUHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354354AbiDZUHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:07:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFD0D0839;
        Tue, 26 Apr 2022 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651003411;
        bh=NKFKAKCLTOL1m3NDU/BmygYePpH8tCNAz8bh93sKgz0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YImytSqdZZYWqI7qUYjSTr1dzwfu/h12OjbVsHkF1GmMJnw0vu4IM6kvRQ9GtFNAj
         QmEmaysmPTnFntKKElSnLRIUuXXv2Xtu/NByxtI1eLGIj3xGoJa2xu8Pmbgo1yITHF
         zaPXcM22EJ60gLcR8Phka2hyXRmXKDN8pIieGny8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MZTmO-1nP30n2sRa-00WT5q; Tue, 26 Apr 2022 22:03:31 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (dell-smm) Avoid unnecessary SMM calls during init
Date:   Tue, 26 Apr 2022 22:03:18 +0200
Message-Id: <20220426200320.399435-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426200320.399435-1-W_Armin@gmx.de>
References: <20220426200320.399435-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UG/oD1uM2BullOcRsnmVOG3PY/YNnwg9B5vCwC3rJDRzma6B3Tx
 dr3n/HWsJcnPFJi8xLGQa+gtijPCLNH6MPoLg+E7lrTJgJXnBl9d5xYGTFnaAusO3SpLag5
 Nsy91DTELO41qATWJitLdFYNZgTwtbdGJyq3XDuoP1y4Nio+L87Zu86G8Q9eJW9QMu9ws2c
 vOZn4xfIFOCdE1PSZdQ9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CBOL7YLXtuc=:ZV9mNoNgcftUV1FPHE1ruO
 yOCs0StT1CH/pfogY7Z4Yu7JDllcsprZJH/iGCuyBHzYruHSi75mcf0S0okXQhTqjnrD6uXT9
 xpZYsGI4PY/wB9N8twkXaSBWEy8WNISI5LqQPH9IHEIyNHBaMcsovWk6Q7H21hfnrA70X+ijq
 RkZlXrk9dpAB33Ohl2rQn1Pe/DUvqYkX+0ON7yLMGuvhX6e8aqrwMxMa71h04pzrRD37chl2i
 4qa9YuPq4IZ0M0n+dxqxZMGW27zenwhG39qnqYsSmja8PFb42p4VYflWkQ0Ec2WfDluaHc5uP
 DE0+wTjfG/I/8FFNQ//5m6UDsbiLFiuZq236Uqg16JnAGJpc+33Ql5nxfliddmJOhZA/pE+E3
 psyWTTnYFvgzYgQiKmPVHmZZn8V3ftyRm3ZrDN6bE5ze1YwFeVDz1vQFeAH7riYIBtJhjRRk7
 sYukrZXVqIOzIejBNYSHx61y3sd9gCvQbknsZ6mHDTl1tF23NbFSbmK/PigO9wTcPczmn1A2Y
 iFbbWDclfIYzJMasEotxtInOVp1Zj52OmxjJnFz2wSfdu/oRRNQzREPC7mnSS8rNYht96TH62
 lzyApTSL7bgSS4MoxZ96JE1jHhBdiARnKHs8j69jGY9AnOED0P73buCHqneNKoZaJQw9nBWsG
 4KANLCYemL5XK+M3nzClmSF6Y3NqW5gujuTr0QhPZ7jzNJwczCDoui9MDhlmnzOxY/D+SZfex
 B1oe2KO1zWRZO0MxUtOvTAAxM3Pq7gmOcDbDREjg68S7w8spqEwfpcjyIPAthPZbuiRat1eDW
 TpxKyRrd4XwqgoQw7BQlLESbVRW9Uok/MHnUMCtpzxBN+MKG68Dr/Y/yrzsvPppHqumfn41Tx
 bBjUqYl3/RpbJp97STFGuzjP7/sIEbA+JYBwv0wKrPdR8iM+uhHmvTw3gpWCdOqmUPex0c87N
 QxYqpioUrI6k85qSAnXH4t5vRO/awH7ID/UbSfkw3v2QEDtd9E4U62lSEabp3TXR4Uia776Ua
 bV28tcgdaESvT3LenvAYosDVoSykXnBf8WeOMVWs6SAkuvN1bxKorGh/Ty1Sj4VpkpdmKZhHD
 YWrWeOYwhGS+8A=
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

