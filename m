Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816BA533EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244760AbiEYOCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244740AbiEYN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:33 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D6AEE28;
        Wed, 25 May 2022 06:58:57 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id q10so25102008oia.9;
        Wed, 25 May 2022 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LpREWf24Z1Y0Q1itAhOByEIa1J2oUjo3qOeVA9rLEjw=;
        b=WaoJiR91MTH/idKXiWa3Ur+RKayAqk1MMt+wSgfgGTtqEv7XgXbTV9nKsEsnWCMBBR
         g6hpvrBFWIQDCGIguMUDMeBljm+gYPvyzLDC+8laXLMT2wqzW0jmzC77meYcbjO0AElq
         MwiVMiyxBqzMeWS1JxoxSjdKJ3LFCsTRCDBKya5FD+9ojd+vcWX5Iz38anEgEBIpwWby
         gqxiqV2c1/9GpsfbTSb/SLBKm9IN+O8jnwCyl3KcvoxLXhG7VhOUzU4zBSa1Lp3EBpJK
         vGdU3EM71K83wz3KmjXDyqpcfVdURuUY/5pIJ/MOZDYyVrpoXRo6MxG23ns/gYtqM6oJ
         nfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LpREWf24Z1Y0Q1itAhOByEIa1J2oUjo3qOeVA9rLEjw=;
        b=TRHbTYt57w9JGGZb/sidl8FACW5Q7/W7klKZ09NGwQtUcggascPIGY3tBA2TIox9HF
         EHv+473zqBL5rWBSad8V1I5R6ODxjNyEJNbh04ligERtEDroPLUkHRLQn/aWTrs8tcJt
         WsSYOUgqdx99Lx1wq48xkRGmniIM4SFi4/TqG0H8zfk1qNrn5VdqUj02LwUT9TfP+tfc
         /Vctv/h/FwMNCpafrlnRUGb7nidXOM+fyDh11Mrz8QPcNOwtBcclYj++HFTGLj0kjEcD
         1zsdKh5JWbi24RnybnRzxLGPd6SNSHMCQ7CeA9bqtJZk3lqx8bnSVM1dRSDgfQ4qqb+G
         6QnA==
X-Gm-Message-State: AOAM533a0KbEsN5ZH18/RfjKqWaiuQFi5KiWwlFMpLmhF3dz4de9ror6
        nFUnSylJsgKfGhmWnA7z+DbXRbCjlVNixw==
X-Google-Smtp-Source: ABdhPJyqzYTI5CxHYcfBWiZl1wmILD93Q/kyCrfrRCGqsElUrho0z1MGTb2u9Nwm+QCwuAIU0LrfSA==
X-Received: by 2002:a05:6808:1315:b0:32b:6c09:91f5 with SMTP id y21-20020a056808131500b0032b6c0991f5mr5261285oiv.181.1653487136408;
        Wed, 25 May 2022 06:58:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o9-20020a4ad149000000b0035eb4e5a6b2sm6551836oor.8.2022.05.25.06.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 29/40] hwmon: (lm90) Add support for ADM1021, ADM1021A, and ADM1023
Date:   Wed, 25 May 2022 06:57:47 -0700
Message-Id: <20220525135758.2944744-30-linux@roeck-us.net>
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

Both chips are quite similar to other chips of this series, so add
support for them to the lm90 driver. Also mention ON Semiconductor NCT210,
which is pin and register compatible to ADM1021A.

None of the chips support the secondary manufacturer and chip ID registers
at 0x3e and 0x3f, but return 0 when reading from those registers.
Use that information to improve the accuracy of chip detection code.

Devicetree nodes are not added for the added chips since it is quite
unlikely that such old chips will ever be used in a devicetree based
system. They can be added later if needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst | 23 +++++++++++++++++-
 drivers/hwmon/Kconfig        |  4 +--
 drivers/hwmon/lm90.c         | 47 ++++++++++++++++++++++++++++++++----
 3 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index 8fe9013b9c39..699ac963722b 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -51,6 +51,22 @@ Supported chips:
 
 	       http://www.national.com/mpf/LM/LM86.html
 
+  * Analog Devices ADM1021
+
+    Prefix: 'adm1021'
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheet: Publicly available at the Analog Devices website
+
+  * Analog Devices ADM1021A/ADM1023
+
+    Prefix: 'adm1023'
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheet: Publicly available at the Analog Devices website
+
   * Analog Devices ADM1032
 
     Prefix: 'adm1032'
@@ -369,10 +385,15 @@ features:
 LM84:
   * 8 bit sensor resolution
 
-MAX1617:
+ADM1021, MAX1617:
   * 8 bit sensor resolution
   * Low temperature limits
 
+ADM1021A, ADM1023:
+  * Temperature offset register for remote temperature sensor
+  * 11 bit resolution for remote temperature sensor
+  * Low temperature limits
+
 LM90:
   * 11 bit resolution for remote temperature sensor
   * Temperature offset register for remote temperature sensor
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 1dd812cf15bb..50fa255b1e3c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1359,8 +1359,8 @@ config SENSORS_LM90
 	depends on I2C
 	help
 	  If you say yes here you get support for National Semiconductor LM84,
-	  LM90, LM86, LM89 and LM99, Analog Devices ADM1032, ADT7461, ADT7461A,
-	  ADT7481, ADT7482, and ADT7483A,
+	  LM90, LM86, LM89 and LM99, Analog Devices ADM2021, ADM1021A, ADM1023,
+	  ADM1032, ADT7461, ADT7461A, ADT7481, ADT7482, and ADT7483A,
 	  Maxim MAX1617, MAX6642, MAX6646, MAX6647, MAX6648, MAX6649, MAX6654,
 	  MAX6657, MAX6658, MAX6659, MAX6680, MAX6681, MAX6692, MAX6695,
 	  MAX6696,
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 09c3b9eb2f8b..40c012bc6ca6 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -122,7 +122,8 @@ static const unsigned short normal_i2c[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
-enum chips { adm1032, adt7461, adt7461a, adt7481, g781, lm84, lm86, lm90, lm99,
+enum chips { adm1023, adm1032, adt7461, adt7461a, adt7481,
+	g781, lm84, lm86, lm90, lm99,
 	max1617, max6642, max6646, max6648, max6654, max6657, max6659, max6680, max6696,
 	sa56004, tmp451, tmp461, w83l771,
 };
@@ -223,6 +224,8 @@ enum chips { adm1032, adt7461, adt7461a, adt7481, g781, lm84, lm86, lm90, lm99,
  */
 
 static const struct i2c_device_id lm90_id[] = {
+	{ "adm1021", max1617 },
+	{ "adm1023", adm1023 },
 	{ "adm1032", adm1032 },
 	{ "adt7461", adt7461 },
 	{ "adt7461a", adt7461a },
@@ -375,6 +378,14 @@ struct lm90_params {
 };
 
 static const struct lm90_params lm90_params[] = {
+	[adm1023] = {
+		.flags = LM90_HAVE_ALARMS | LM90_HAVE_OFFSET | LM90_HAVE_BROKEN_ALERT
+		  | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
+		  | LM90_HAVE_REMOTE_EXT,
+		.alert_alarms = 0x7c,
+		.resolution = 8,
+		.max_convrate = 7,
+	},
 	[adm1032] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
@@ -1740,19 +1751,43 @@ static const char *lm90_detect_national(struct i2c_client *client, int chip_id,
 	return name;
 }
 
-static const char *lm90_detect_analog(struct i2c_client *client, int chip_id,
-				      int config1, int convrate)
+static const char *lm90_detect_analog(struct i2c_client *client, bool common_address,
+				      int chip_id, int config1, int convrate)
 {
+	int status = i2c_smbus_read_byte_data(client, LM90_REG_STATUS);
 	int config2 = i2c_smbus_read_byte_data(client, ADT7481_REG_CONFIG2);
 	int man_id2 = i2c_smbus_read_byte_data(client, ADT7481_REG_MAN_ID);
 	int chip_id2 = i2c_smbus_read_byte_data(client, ADT7481_REG_CHIP_ID);
 	int address = client->addr;
 	const char *name = NULL;
 
-	if (config2 < 0 || man_id2 < 0 || chip_id2 < 0)
+	if (status < 0 || config2 < 0 || man_id2 < 0 || chip_id2 < 0)
 		return NULL;
 
 	switch (chip_id) {
+	case 0x00 ... 0x0f:	/* ADM1021, undocumented */
+		if (man_id2 == 0x00 && chip_id2 == 0x00 && common_address &&
+		    !(status & 0x03) && !(config1 & 0x3f) && !(convrate & 0xf8))
+			name = "adm1021";
+		break;
+	case 0x30 ... 0x3f:	/* ADM1021A, ADM1023 */
+		/*
+		 * ADM1021A and compatible chips will be mis-detected as
+		 * ADM1023. Chips labeled 'ADM1021A' and 'ADM1023' were both
+		 * found to have a Chip ID of 0x3c.
+		 * ADM1021A does not officially support low byte registers
+		 * (0x12 .. 0x14), but a chip labeled ADM1021A does support it.
+		 * Official support for the temperature offset high byte
+		 * register (0x11) was added to revision F of the ADM1021A
+		 * datasheet.
+		 * It is currently unknown if there is a means to distinguish
+		 * ADM1021A from ADM1023, and/or if revisions of ADM1021A exist
+		 * which differ in functionality from ADM1023.
+		 */
+		if (man_id2 == 0x00 && chip_id2 == 0x00 && common_address &&
+		    !(status & 0x03) && !(config1 & 0x3f) && !(convrate & 0xf8))
+			name = "adm1023";
+		break;
 	case 0x40 ... 0x4f:	/* ADM1032 */
 		if (man_id2 == 0x00 && chip_id2 == 0x00 &&
 		    (address == 0x4c || address == 0x4d) && !(config1 & 0x3f) &&
@@ -1793,6 +1828,7 @@ static const char *lm90_detect_analog(struct i2c_client *client, int chip_id,
 		break;
 	case 0x94:	/* ADT7483 */
 		if (man_id2 == 0x41 && chip_id2 == 0x83 &&
+		    common_address &&
 		    ((address >= 0x18 && address <= 0x1a) ||
 		     (address >= 0x29 && address <= 0x2b) ||
 		     (address >= 0x4c && address <= 0x4e)) &&
@@ -2173,7 +2209,8 @@ static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
 		name = lm90_detect_national(client, chip_id, config1, convrate);
 		break;
 	case 0x41:	/* Analog Devices */
-		name = lm90_detect_analog(client, chip_id, config1, convrate);
+		name = lm90_detect_analog(client, common_address, chip_id, config1,
+					  convrate);
 		break;
 	case 0x47:	/* GMT */
 		name = lm90_detect_gmt(client, chip_id, config1, convrate);
-- 
2.35.1

