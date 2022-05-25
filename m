Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84985533EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiEYOCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244826AbiEYOAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:00:11 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D6DAFAC2;
        Wed, 25 May 2022 06:59:13 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v9so20438509oie.5;
        Wed, 25 May 2022 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GInhXZynQUsIY0Odafh8O/3S5hYlWZEpMmKYkSJtma8=;
        b=iMXHMLYZT93YStp37lQeB2BI6gaptbbRuMxplyOpcbsFhpRJgY/vEqLVpacYHpedIV
         XtDUvbwIDXbAcdWJbSAdg0n3s7wSqhBKfUS+RTZXoGq1D7qogrhvRj0gAX6xec78k+38
         CGQDQ6VRdHDf8musfDc3TtTuoU4fMilDOl2sulRwqxHZOTR63PrCshVU7sCMhCBbnLDj
         FCpUFhqlSHiuM6sp9ldvshn/1EhjOWQRdOkq4Grsiy4v0imprxfjeLVTzRJwZ5ceTr1c
         bC712lGhppkWZd8K4xGcVyJmg/lgY0siFUdyp4uoCc29TfBSpGAzOaxw48CSxoVg/YsW
         /5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GInhXZynQUsIY0Odafh8O/3S5hYlWZEpMmKYkSJtma8=;
        b=ZsYmVHRiVAC1qT+qQ4jmbIMwtthkPYCn/+zcXeEdZ/v1oAZDaIdAn2Aw5OsbdmK/MK
         UKNW8EC5pqMi9RDrGBAzQLvlRK+Y3zLCIScoFOJthm+037WpNMgRFvLAoKXcWxYmMgz1
         GJpCQSu7ACH+ZupUfJqhpQcceLH52pmMrI2jWp94cmx5cNyWvgjXGT/HXe2r25aWjmH7
         qGpBeYUhLo3akxlOiazioGp0VpQGExUICdZV/G4P2J1YDeCukQnyiDRuk1IYVNaHs7/T
         4J2WZ6ka6fm1/0eAU4+a+5wnov4NCd/AwcxRluOyV4koJXw+hNAvq2OSaN4F0U/xSEhJ
         DaoA==
X-Gm-Message-State: AOAM531GyKLdIBoP7m90zgouF2RAzdBSJD0+QOXI8ngfr7LOLMmViio0
        9WJ0SyNVIehqah0LhgJYz19/yP2tBumhDw==
X-Google-Smtp-Source: ABdhPJyECyjV1O0ppTb0PWUeMyqnxG1ZWokzg07mkZO3qYugk2XyNaQqAtUGW6+/Vurfo8ByvJVKcg==
X-Received: by 2002:a05:6808:21a5:b0:32b:2791:2cef with SMTP id be37-20020a05680821a500b0032b27912cefmr5313000oib.147.1653487153050;
        Wed, 25 May 2022 06:59:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p21-20020a4a8e95000000b0040e5ff4a737sm6612535ook.26.2022.05.25.06.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:59:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 38/40] hwmon: (lm90) Add support and detection of Philips/NXP NE1618
Date:   Wed, 25 May 2022 06:57:56 -0700
Message-Id: <20220525135758.2944744-39-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135758.2944744-1-linux@roeck-us.net>
References: <20220525135758.2944744-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NE1618 is similar to NE1617 but supports manufacturer and chip ID
registers as well as 11 bit external temperature resolution.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst | 10 +++++++-
 drivers/hwmon/Kconfig        |  2 +-
 drivers/hwmon/lm90.c         | 44 ++++++++++++++++++++++++++----------
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index b2ca10f37218..ea1556be645c 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -411,6 +411,14 @@ Supported chips:
 
     Datasheets: Publicly available at the Philips website
 
+  * Philips NE1618
+
+    Prefix: 'ne1618'
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheets: Publicly available at the Philips website
+
   * Genesys Logic GL523SM
 
     Prefix: 'gl523sm'
@@ -469,7 +477,7 @@ ADM1020, ADM1021, GL523SM, MAX1617, NE1617, NE1617A, THMC10:
   * 8 bit sensor resolution
   * Low temperature limits
 
-NCT210:
+NCT210, NE1618:
   * 11 bit sensor resolution for remote temperature sensor
   * Low temperature limits
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 494539e4be3d..981df62bd6ab 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1367,7 +1367,7 @@ config SENSORS_LM90
 	  MAX6696,
 	  ON Semiconductor NCT1008, NCT210, NCT72, NCT214, NCT218,
 	  Winbond/Nuvoton W83L771W/G/AWG/ASG,
-	  Philips SA56004, GMT G781, Texas Instruments TMP451 and TMP461
+	  Philips NE1618, SA56004, GMT G781, Texas Instruments TMP451 and TMP461
 	  sensor chips.
 
 	  This driver can also be built as a module. If so, the module
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index de51d205b63f..77102e0a4440 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -87,6 +87,9 @@
  * This driver also supports MAX1617 and various clones such as G767
  * and NE1617. Such clones will be detected as MAX1617.
  *
+ * This driver also supports NE1618 from Philips. It is similar to NE1617
+ * but supports 11 bit external temperature values.
+ *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
  * concern all supported chipsets, unless mentioned otherwise.
@@ -129,7 +132,7 @@ static const unsigned short normal_i2c[] = {
 enum chips { adm1023, adm1032, adt7461, adt7461a, adt7481,
 	g781, lm84, lm90, lm99,
 	max1617, max6642, max6646, max6648, max6654, max6657, max6659, max6680, max6696,
-	nct210, nct72, sa56004, tmp451, tmp461, w83l771,
+	nct210, nct72, ne1618, sa56004, tmp451, tmp461, w83l771,
 };
 
 /*
@@ -267,6 +270,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "nct214", nct72 },
 	{ "nct218", nct72 },
 	{ "nct72", nct72 },
+	{ "ne1618", ne1618 },
 	{ "w83l771", w83l771 },
 	{ "sa56004", sa56004 },
 	{ "thmc10", max1617 },
@@ -572,6 +576,13 @@ static const struct lm90_params lm90_params[] = {
 		.resolution = 11,
 		.max_convrate = 7,
 	},
+	[ne1618] = {
+		.flags = LM90_PAUSE_FOR_CONFIG | LM90_HAVE_BROKEN_ALERT
+		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
+		.alert_alarms = 0x7c,
+		.resolution = 11,
+		.max_convrate = 7,
+	},
 	[w83l771] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT
 		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
@@ -2149,20 +2160,29 @@ static const char *lm90_detect_nuvoton(struct i2c_client *client, int chip_id,
 	return name;
 }
 
-static const char *lm90_detect_nxp(struct i2c_client *client, int chip_id,
-				   int config1, int convrate)
+static const char *lm90_detect_nxp(struct i2c_client *client, bool common_address,
+				   int chip_id, int config1, int convrate)
 {
-	int config2 = i2c_smbus_read_byte_data(client, LM90_REG_CONFIG2);
 	int address = client->addr;
 	const char *name = NULL;
+	int config2;
 
-	if (config2 < 0)
-		return NULL;
-
-	if (address >= 0x48 && address <= 0x4f && chip_id == 0x00 &&
-	    !(config1 & 0x2a) && !(config2 & 0xfe) && convrate <= 0x09)
-		name = "sa56004";
-
+	switch (chip_id) {
+	case 0x00:
+		config2 = i2c_smbus_read_byte_data(client, LM90_REG_CONFIG2);
+		if (config2 < 0)
+			return NULL;
+		if (address >= 0x48 && address <= 0x4f &&
+		    !(config1 & 0x2a) && !(config2 & 0xfe) && convrate <= 0x09)
+			name = "sa56004";
+		break;
+	case 0x80:
+		if (common_address && !(config1 & 0x3f) && convrate <= 0x07)
+			name = "ne1618";
+		break;
+	default:
+		break;
+	}
 	return name;
 }
 
@@ -2335,7 +2355,7 @@ static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
 		name = lm90_detect_nuvoton(client, chip_id, config1, convrate);
 		break;
 	case 0xa1:	/*  NXP Semiconductor/Philips */
-		name = lm90_detect_nxp(client, chip_id, config1, convrate);
+		name = lm90_detect_nxp(client, common_address, chip_id, config1, convrate);
 		break;
 	case 0xff:	/* MAX1617, G767, NE1617 */
 		if (common_address && chip_id == 0xff && convrate < 8)
-- 
2.35.1

