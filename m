Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75554533E87
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbiEYOAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244688AbiEYN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:30 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A568A5AAA;
        Wed, 25 May 2022 06:58:50 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q8so25050356oif.13;
        Wed, 25 May 2022 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o4wMKM4knFAO2Oh+lzwksFLiGAmKikVtsti1xElldMg=;
        b=dYkuXsRdbpQgIFQpqjZk5b3RWoQYTwKpFs5UavoJXiLDI/egbWMN82sC4Js+tbAhvB
         Wtegf9R/jNL4ByZ+nYMcKVG/QUb7nHcAZHZtOMlrXZl/XC/DLHHV1w5Ynsva7yfPx2gR
         jf40mYQ82YU+UOQCRq1tk2aIRq6ijfr+MnfM35FxuXzaZot1ZOOJBHadjB8d+LxSdWvx
         pk4uk2L85MuALcD78lr0U1kCsd9uEDgUb3TPxe5I+Zo66BJ7ZHUNxTcy3LO3JnG2F8G8
         x69nhHB/9tIjDPFerkdQHoCyzz/tEYRMfxIne1+6kYibK3FH3mQP9pF3uJbVivf23bZk
         e3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=o4wMKM4knFAO2Oh+lzwksFLiGAmKikVtsti1xElldMg=;
        b=mlzBGY9IkDQrk2XhXptKkXBHHmMhCLPRaBOQepODnoxt/+Ti1dY0/gvF1dByvVFrjt
         POOY0JZWT3YZ9x65pBfpcXlATpnTcikkbOgERRzgXGeMNcrOyd9E0lXIITTop2v6kv62
         r95kM9jM8O/1QINGQC2wYhdrvuj9wGu6l7afI4MrVB7sjTTkqw8AIEnm1fs6zY0O8FPv
         awpcIiQ5wwmRB44N8q/om7gVV6UZogqpWh5Whzu0kiqcb3D1zBo7kdKyatmsvnTzQZbM
         Bo8BFLOlezhw1Jpw+I8QIXIfFFhYqTdf62n47U+mr6pOya26TC2g56B+Q39sBoCLOZ67
         MSZA==
X-Gm-Message-State: AOAM531vHZD/3LPvlLciLm5Hy1IWqZgduCZzZO0L8vxW2qi6pgBooptr
        o46Jnn8eeE0+XvNOyFiGxv7lwwgeXQCq2w==
X-Google-Smtp-Source: ABdhPJwBEQhWSOh3n4bKv1uzGP5ApM9YvUOAqI0MT8VjjQWCL5cM0e487kuF9KRmg2sLHwWB2KhMoQ==
X-Received: by 2002:a05:6808:1150:b0:328:b7dc:dac5 with SMTP id u16-20020a056808115000b00328b7dcdac5mr5375328oiu.224.1653487128931;
        Wed, 25 May 2022 06:58:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id eo44-20020a056870ecac00b000f2c4ebb832sm442165oab.10.2022.05.25.06.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 25/40] hwmon: (lm90) Add support for MAX6642
Date:   Wed, 25 May 2022 06:57:43 -0700
Message-Id: <20220525135758.2944744-26-linux@roeck-us.net>
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

MAX6642 is a reduced version of LM90 with no low limits and no conversion
rate register. Its alert functionality is broken, similar to many other
chips supported by the lm90 driver.

After this change, the stand-alone max6642 driver is only needed if the
lm90 driver is disabled. Make it dependent on SENSORS_LM90=n to show that
it is not needed if the lm90 driver is enabled.

A devicetree node is not added for this chip since it is quite unlikely
that such an old chip will ever be used in a devicetree based system.
It can be added later if needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst | 16 ++++++++
 drivers/hwmon/Kconfig        |  5 ++-
 drivers/hwmon/lm90.c         | 78 +++++++++++++++++++++++++++++-------
 3 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index 45bc333a1219..313b18f6531d 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -113,6 +113,16 @@ Supported chips:
 
 	       https://www.onsemi.com/PowerSolutions/product.do?id=NCT1008
 
+  * Maxim MAX6642
+
+    Prefix: 'max6642'
+
+    Addresses scanned: I2C 0x48-0x4f
+
+    Datasheet: Publicly available at the Maxim website
+
+	       http://datasheets.maxim-ic.com/en/ds/MAX6642.pdf
+
   * Maxim MAX6646
 
     Prefix: 'max6646'
@@ -362,6 +372,12 @@ ADT7481, ADT7482, ADT7483:
   * Two remote sensors
   * Selectable address (ADT7483)
 
+MAX6642:
+  * No critical limit register
+  * Conversion rate not configurable
+  * Better local resolution (10 bit)
+  * 10 bit external sensor resolution
+
 MAX6646, MAX6647, MAX6649:
   * Better local resolution
   * Extended range unsigned external temperature
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index df54628bd36b..39ce1b2ccbb3 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1102,6 +1102,7 @@ config SENSORS_MAX6639
 config SENSORS_MAX6642
 	tristate "Maxim MAX6642 sensor chip"
 	depends on I2C
+	depends on SENSORS_LM90=n
 	help
 	  If you say yes here you get support for MAX6642 sensor chip.
 	  MAX6642 is a SMBus-Compatible Remote/Local Temperature Sensor
@@ -1360,8 +1361,8 @@ config SENSORS_LM90
 	  If you say yes here you get support for National Semiconductor LM90,
 	  LM86, LM89 and LM99, Analog Devices ADM1032, ADT7461, ADT7461A,
 	  ADT7481, ADT7482, and ADT7483A,
-	  Maxim MAX6646, MAX6647, MAX6648, MAX6649, MAX6654, MAX6657, MAX6658,
-	  MAX6659, MAX6680, MAX6681, MAX6692, MAX6695, MAX6696,
+	  Maxim MAX6642, MAX6646, MAX6647, MAX6648, MAX6649, MAX6654, MAX6657,
+	  MAX6658, MAX6659, MAX6680, MAX6681, MAX6692, MAX6695, MAX6696,
 	  ON Semiconductor NCT1008, Winbond/Nuvoton W83L771W/G/AWG/ASG,
 	  Philips SA56004, GMT G781, Texas Instruments TMP451 and TMP461
 	  sensor chips.
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 90c3a496bb6c..78eda648d960 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -120,7 +120,7 @@ static const unsigned short normal_i2c[] = {
 	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 enum chips { adm1032, adt7461, adt7461a, adt7481, g781, lm86, lm90, lm99,
-	max6646, max6648, max6654, max6657, max6659, max6680, max6696,
+	max6642, max6646, max6648, max6654, max6657, max6659, max6680, max6696,
 	sa56004, tmp451, tmp461, w83l771,
 };
 
@@ -230,6 +230,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "lm86", lm86 },
 	{ "lm89", lm86 },
 	{ "lm99", lm99 },
+	{ "max6642", max6642 },
 	{ "max6646", max6646 },
 	{ "max6647", max6646 },
 	{ "max6648", max6648 },
@@ -434,6 +435,12 @@ static const struct lm90_params lm90_params[] = {
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
+	[max6642] = {
+		.flags = LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXT_UNSIGNED,
+		.alert_alarms = 0x50,
+		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
+		.resolution = 10,
+	},
 	[max6646] = {
 		.flags = LM90_HAVE_CRIT | LM90_HAVE_BROKEN_ALERT
 		  | LM90_HAVE_EXT_UNSIGNED | LM90_HAVE_ALARMS | LM90_HAVE_LOW
@@ -1666,18 +1673,18 @@ static const char *lm90_detect_analog(struct i2c_client *client, int chip_id,
 	return name;
 }
 
-static const char *lm90_detect_maxim(struct i2c_client *client, int chip_id,
-				     int config1, int convrate)
+static const char *lm90_detect_maxim(struct i2c_client *client, bool common_address,
+				     int chip_id, int config1, int convrate)
 {
 	int man_id, emerg, emerg2, status2;
 	int address = client->addr;
 	const char *name = NULL;
 
-	if ((address >= 0x48 && address <= 0x4b) || address == 0x4f)
-		return NULL;
-
 	switch (chip_id) {
 	case 0x01:
+		if (!common_address)
+			break;
+
 		/*
 		 * We read MAX6659_REG_REMOTE_EMERG twice, and re-read
 		 * LM90_REG_MAN_ID in between. If MAX6659_REG_REMOTE_EMERG
@@ -1724,7 +1731,7 @@ static const char *lm90_detect_maxim(struct i2c_client *client, int chip_id,
 		 * The lowest 3 bits of the config1 register are unused and
 		 * should return zero when read.
 		 */
-		if (!(config1 & 0x07) && convrate <= 0x07)
+		if (common_address && !(config1 & 0x07) && convrate <= 0x07)
 			name = "max6654";
 		break;
 	case 0x09:
@@ -1737,16 +1744,21 @@ static const char *lm90_detect_maxim(struct i2c_client *client, int chip_id,
 		 * MAX6690 datasheet lists a chip ID of 0x08, and a chip labeled
 		 * MAX6654 was observed to have a chip ID of 0x09.
 		 */
-		if (!(config1 & 0x07) && convrate <= 0x07)
+		if (common_address && !(config1 & 0x07) && convrate <= 0x07)
 			name = "max6690";
 		break;
 	case 0x4d:
 		/*
-		 * The MAX6657, MAX6658 and MAX6659 do NOT have a chip_id
+		 * MAX6642, MAX6657, MAX6658 and MAX6659 do NOT have a chip_id
 		 * register. Reading from that address will return the last
 		 * read value, which in our case is those of the man_id
-		 * register, or 0x4d. Likewise, the config1 register seems to
-		 * lack a low nibble, so the value will be those of the previous
+		 * register, or 0x4d.
+		 * MAX6642 does not have a conversion rate register, nor low
+		 * limit registers. Reading from those registers returns the
+		 * last read value.
+		 *
+		 * For MAX6657, MAX6658 and MAX6659, the config1 register lacks
+		 * a low nibble, so the value will be those of the previous
 		 * read, so in our case again those of the man_id register.
 		 * MAX6659 has a third set of upper temperature limit registers.
 		 * Those registers also return values on MAX6657 and MAX6658,
@@ -1754,8 +1766,40 @@ static const char *lm90_detect_maxim(struct i2c_client *client, int chip_id,
 		 * For this reason it will be mis-detected as MAX6657 if its
 		 * address is 0x4c.
 		 */
-		if ((address == 0x4c || address == 0x4d || address == 0x4e) &&
-		    (config1 & 0x1f) == 0x0d && convrate <= 0x09) {
+		if (address >= 0x48 && address <= 0x4f && config1 == convrate &&
+		    !(config1 & 0x0f)) {
+			int regval;
+
+			/*
+			 * We know that this is not a MAX6657/58/59 because its
+			 * configuration register has the wrong value and it does
+			 * not appear to have a conversion rate register.
+			 */
+
+			/* re-read manufacturer ID to have a good baseline */
+			if (i2c_smbus_read_byte_data(client, LM90_REG_MAN_ID) != 0x4d)
+				break;
+
+			/* check various non-existing registers */
+			if (i2c_smbus_read_byte_data(client, LM90_REG_CONVRATE) != 0x4d ||
+			    i2c_smbus_read_byte_data(client, LM90_REG_LOCAL_LOW) != 0x4d ||
+			    i2c_smbus_read_byte_data(client, LM90_REG_REMOTE_LOWH) != 0x4d)
+				break;
+
+			/* check for unused status register bits */
+			regval = i2c_smbus_read_byte_data(client, LM90_REG_STATUS);
+			if (regval < 0 || (regval & 0x2b))
+				break;
+
+			/* re-check unsupported registers */
+			if (i2c_smbus_read_byte_data(client, LM90_REG_CONVRATE) != regval ||
+			    i2c_smbus_read_byte_data(client, LM90_REG_LOCAL_LOW) != regval ||
+			    i2c_smbus_read_byte_data(client, LM90_REG_REMOTE_LOWH) != regval)
+				break;
+
+			name = "max6642";
+		} else if ((address == 0x4c || address == 0x4d || address == 0x4e) &&
+			   (config1 & 0x1f) == 0x0d && convrate <= 0x09) {
 			if (address == 0x4c)
 				name = "max6657";
 			else
@@ -1927,6 +1971,11 @@ static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
 	struct i2c_adapter *adapter = client->adapter;
 	int man_id, chip_id, config1, convrate;
 	const char *name = NULL;
+	int address = client->addr;
+	bool common_address =
+			(address >= 0x18 && address <= 0x1a) ||
+			(address >= 0x29 && address <= 0x2b) ||
+			(address >= 0x4c && address <= 0x4e);
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -1950,7 +1999,8 @@ static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
 		name = lm90_detect_gmt(client, chip_id, config1, convrate);
 		break;
 	case 0x4d:	/* Maxim Integrated */
-		name = lm90_detect_maxim(client, chip_id, config1, convrate);
+		name = lm90_detect_maxim(client, common_address, chip_id,
+					 config1, convrate);
 		break;
 	case 0x55:	/* TI */
 		name = lm90_detect_ti(client, chip_id, config1, convrate);
-- 
2.35.1

