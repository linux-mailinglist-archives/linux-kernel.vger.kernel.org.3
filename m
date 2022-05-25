Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2433C533EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiEYOBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244655AbiEYN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:48 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A2BAE240;
        Wed, 25 May 2022 06:58:40 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e5e433d66dso26113066fac.5;
        Wed, 25 May 2022 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FOJ7UN0h8fXZtM0hP0PplVDK/svBHNylTVAam7zGQyk=;
        b=Ri3l3B4zXSWPzOT53K/Jp1ABTn8KRUOKi0QKHNVgGk4v8Zcjkj6rwBF6iyVqDEmJtC
         e59hVjGwdejlDpJW+AZb3fjSUcxRXHu2wxRYVRtDXinCT3yG89h361R2VMb2ghY5QrG4
         PnR2+G68qSUZMU90Hsi9v2k3tZk0UP79GzC59x98Yrqtj7ljtL8or2FA5bRSQhaiqKGl
         d49CQmjWsUJ5fOMfg+Oe+b6SFZ2PIa9pSG/xeY8Eo+X4OELYsufbTcjbdDjcOY/U9KKU
         wIls7AVyHfvizXv7Pywx0wQGiWcxoBPc+SI5n4TMkob9bS6OpMTMvLQJHlaJ+jqRcX04
         Fn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FOJ7UN0h8fXZtM0hP0PplVDK/svBHNylTVAam7zGQyk=;
        b=QHG9vrPTHfmlaf3rT09+Q3YF/rFNwNPCfxjF2MxHbyXAk3/gOtkzR7iUlv0myxDNyM
         3jyEceIDR7vhhffw/XGMCHDklcXp8mT8rLQx96zcd9oYF1MeQ7V0xVj6TBaHLhSsM/GX
         iUIj8lKpvuyRJYS9Tl/GhDD5kM7UuqD/M0N2yGXWsI8jVjPCe34vFNvm2hBP2Bdb/Kd5
         5Abtc0mmG655izEW/3lE6TTxYx7ifSjfhL+2mbSctFj2Um+aAbHdzHSSqhOY91wJ1Umq
         qKRt9zsb8EQrpKIDzNdtdnsFDGmSJ08lC3o+OE8bSav7fJx4TQu+FCoa3qPsVmhH2wKR
         RHEA==
X-Gm-Message-State: AOAM532rHCsLljScLrk7dAgZh7vr+feZIWb2cWLuJztWc18PGWnRPIn8
        A2IsyROjSqXThqK7InFdqqhpW08f5PyDLQ==
X-Google-Smtp-Source: ABdhPJxqCx7Hoe3HmlHnCXfWWMHqbBZH8LqkoAMMyiCC4gqQwTeexQIJTF+5NlxKLf0rZjzTfQbbpw==
X-Received: by 2002:a05:6870:45a5:b0:e1:f27d:d1c8 with SMTP id y37-20020a05687045a500b000e1f27dd1c8mr5913928oao.60.1653487119580;
        Wed, 25 May 2022 06:58:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g6-20020aca3906000000b00325cda1ffb5sm6308874oia.52.2022.05.25.06.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 20/40] hwmon: (lm90) Add support for ADT7481, ADT7482, and ADT7483
Date:   Wed, 25 May 2022 06:57:38 -0700
Message-Id: <20220525135758.2944744-21-linux@roeck-us.net>
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

ADT7481, ADT7482, and ADT7483 are similar to ADT7461, but support two
external temperature sensors, similar to MAX6695/6696. They support an
extended temperature range similar to ADT7461. Registers for the second
external channel can be accessed directly or by using the same method as
used by MAX6695/6696. For simplicity, the access method implemented for
MAX6695/6696 is used.

The chips support PEC (packet error checking). Set the PEC feature flag
and let the user decide if it should be enabled or not (it is by default
disabled).

Even though it is only documented for ADT7483, all three chips support a
secondary manufacturer ID register at 0x3e and a chip ID register at 0x3f.
Use the contents of those registers register for improved chip detection
accuracy. Add the same check to the ADT7461A detection code since this chip
also supports the same (undocumented) registers.

Devicetree nodes are not added for the added chips since it is quite
unlikely that such old chips will ever be used in a devicetree based
system. They can be added later if needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst |  38 +++++++++++
 drivers/hwmon/Kconfig        |   3 +-
 drivers/hwmon/lm90.c         | 119 ++++++++++++++++++++++++++---------
 3 files changed, 129 insertions(+), 31 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index e947e609990b..53429f79b819 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -73,6 +73,36 @@ Supported chips:
 
 	       https://www.onsemi.com/PowerSolutions/product.do?id=ADT7461A
 
+  * Analog Devices ADT7481
+
+    Prefix: 'adt7481'
+
+    Addresses scanned: I2C 0x4b and 0x4c
+
+    Datasheet: Publicly available at the ON Semiconductor website
+
+	       https://www.onsemi.com/PowerSolutions/product.do?id=ADT7481
+
+  * Analog Devices ADT7482
+
+    Prefix: 'adt7482'
+
+    Addresses scanned: I2C 0x4c
+
+    Datasheet: Publicly available at the ON Semiconductor website
+
+	       https://www.onsemi.com/PowerSolutions/product.do?id=ADT7482
+
+  * Analog Devices ADT7483A
+
+    Prefix: 'adt7483a'
+
+    Addresses scanned: I2C 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e
+
+    Datasheet: Publicly available at the ON Semiconductor website
+
+	       https://www.onsemi.com/PowerSolutions/product.do?id=ADT7483A
+
   * ON Semiconductor NCT1008
 
     Prefix: 'nct1008'
@@ -323,6 +353,14 @@ ADT7461, ADT7461A, NCT1008:
   * Extended temperature range (breaks compatibility)
   * Lower resolution for remote temperature
   * SMBus PEC support for Write Byte and Receive Byte transactions.
+  * 10 bit temperature resolution
+
+ADT7481, ADT7482, ADT7483:
+  * Temperature offset register
+  * SMBus PEC support
+  * 10 bit temperature resolution for external sensors
+  * Two remote sensors
+  * Selectable address (ADT7483)
 
 MAX6646, MAX6647, MAX6649:
   * Better local resolution
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 590d3d550acb..df54628bd36b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1358,7 +1358,8 @@ config SENSORS_LM90
 	depends on I2C
 	help
 	  If you say yes here you get support for National Semiconductor LM90,
-	  LM86, LM89 and LM99, Analog Devices ADM1032, ADT7461, and ADT7461A,
+	  LM86, LM89 and LM99, Analog Devices ADM1032, ADT7461, ADT7461A,
+	  ADT7481, ADT7482, and ADT7483A,
 	  Maxim MAX6646, MAX6647, MAX6648, MAX6649, MAX6654, MAX6657, MAX6658,
 	  MAX6659, MAX6680, MAX6681, MAX6692, MAX6695, MAX6696,
 	  ON Semiconductor NCT1008, Winbond/Nuvoton W83L771W/G/AWG/ASG,
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index df4b861024e3..d2477e0c1e1e 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -64,6 +64,10 @@
  * and extended mode. They are mostly compatible with LM90 except for a data
  * format difference for the temperature value registers.
  *
+ * This driver also supports ADT7481, ADT7482, and ADT7483 from Analog Devices
+ * / ON Semiconductor. The chips are similar to ADT7461 but support two external
+ * temperature sensors.
+ *
  * This driver also supports the SA56004 from Philips. This device is
  * pin-compatible with the LM86, the ED/EDP parts are also address-compatible.
  *
@@ -114,7 +118,7 @@ static const unsigned short normal_i2c[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
-enum chips { adm1032, adt7461, adt7461a, g781, lm86, lm90, lm99,
+enum chips { adm1032, adt7461, adt7461a, adt7481, g781, lm86, lm90, lm99,
 	max6646, max6648, max6654, max6657, max6659, max6680, max6696,
 	sa56004, tmp451, tmp461, w83l771,
 };
@@ -164,6 +168,13 @@ enum chips { adm1032, adt7461, adt7461a, g781, lm86, lm90, lm99,
 #define TMP461_REG_CHEN			0x16
 #define TMP461_REG_DFC			0x24
 
+/* ADT7481 registers */
+#define ADT7481_REG_STATUS2		0x23
+#define ADT7481_REG_CONFIG2		0x24
+
+#define ADT7481_REG_MAN_ID		0x3e
+#define ADT7481_REG_CHIP_ID		0x3d
+
 /* Device features */
 #define LM90_HAVE_EXTENDED_TEMP	BIT(0)	/* extended temperature support	*/
 #define LM90_HAVE_OFFSET	BIT(1)	/* temperature offset register	*/
@@ -191,6 +202,7 @@ enum chips { adm1032, adt7461, adt7461a, g781, lm86, lm90, lm99,
 #define LM90_STATUS_LHIGH	BIT(6)	/* local high temp limit tripped */
 #define LM90_STATUS_BUSY	BIT(7)	/* conversion is ongoing */
 
+/* MAX6695/6696 and ADT7481 2nd status register */
 #define MAX6696_STATUS2_R2THRM	BIT(1)	/* remote2 THERM limit tripped */
 #define MAX6696_STATUS2_R2OPEN	BIT(2)	/* remote2 is an open circuit */
 #define MAX6696_STATUS2_R2LOW	BIT(3)	/* remote2 low temp limit tripped */
@@ -207,6 +219,9 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "adm1032", adm1032 },
 	{ "adt7461", adt7461 },
 	{ "adt7461a", adt7461a },
+	{ "adt7481", adt7481 },
+	{ "adt7482", adt7481 },
+	{ "adt7483a", adt7481 },
 	{ "g781", g781 },
 	{ "lm90", lm90 },
 	{ "lm86", lm86 },
@@ -344,6 +359,7 @@ struct lm90_params {
 				/* Upper 8 bits for max6695/96 */
 	u8 max_convrate;	/* Maximum conversion rate register value */
 	u8 resolution;		/* 16-bit resolution (default 11 bit) */
+	u8 reg_status2;		/* 2nd status register (optional) */
 	u8 reg_local_ext;	/* Extended local temp register (optional) */
 };
 
@@ -376,6 +392,16 @@ static const struct lm90_params lm90_params[] = {
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
+	[adt7481] = {
+		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
+		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_PEC
+		  | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT,
+		.alert_alarms = 0x1c7c,
+		.max_convrate = 11,
+		.resolution = 10,
+		.reg_status2 = ADT7481_REG_STATUS2,
+	},
 	[g781] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
@@ -453,6 +479,7 @@ static const struct lm90_params lm90_params[] = {
 		  | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x1c7c,
 		.max_convrate = 6,
+		.reg_status2 = MAX6696_REG_STATUS2,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[w83l771] = {
@@ -549,6 +576,7 @@ struct lm90_data {
 	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
 				/* Upper 8 bits for max6695/96 */
 	u8 max_convrate;	/* Maximum conversion rate */
+	u8 reg_status2;		/* 2nd status register (optional) */
 	u8 reg_local_ext;	/* local extension register offset */
 
 	/* registers values */
@@ -679,18 +707,14 @@ static int lm90_update_confreg(struct lm90_data *data, u8 config)
  * various registers have different meanings as a result of selecting a
  * non-default remote channel.
  */
-static int lm90_select_remote_channel(struct lm90_data *data, int channel)
+static int lm90_select_remote_channel(struct lm90_data *data, bool second)
 {
-	int err = 0;
+	u8 config = data->config & ~0x08;
 
-	if (data->kind == max6696) {
-		u8 config = data->config & ~0x08;
+	if (second)
+		config |= 0x08;
 
-		if (channel)
-			config |= 0x08;
-		err = lm90_update_confreg(data, config);
-	}
-	return err;
+	return lm90_update_confreg(data, config);
 }
 
 static int lm90_write_convrate(struct lm90_data *data, int val)
@@ -806,8 +830,8 @@ static int lm90_update_limits(struct device *dev)
 		data->temp[REMOTE_EMERG] = val << 8;
 	}
 
-	if (data->kind == max6696) {
-		val = lm90_select_remote_channel(data, 1);
+	if (data->flags & LM90_HAVE_TEMP3) {
+		val = lm90_select_remote_channel(data, true);
 		if (val < 0)
 			return val;
 
@@ -816,10 +840,12 @@ static int lm90_update_limits(struct device *dev)
 			return val;
 		data->temp[REMOTE2_CRIT] = val << 8;
 
-		val = lm90_read_reg(client, MAX6659_REG_REMOTE_EMERG);
-		if (val < 0)
-			return val;
-		data->temp[REMOTE2_EMERG] = val << 8;
+		if (data->flags & LM90_HAVE_EMERGENCY) {
+			val = lm90_read_reg(client, MAX6659_REG_REMOTE_EMERG);
+			if (val < 0)
+				return val;
+			data->temp[REMOTE2_EMERG] = val << 8;
+		}
 
 		val = lm90_read_reg(client, LM90_REG_REMOTE_LOWH);
 		if (val < 0)
@@ -831,7 +857,7 @@ static int lm90_update_limits(struct device *dev)
 			return val;
 		data->temp[REMOTE2_HIGH] = val << 8;
 
-		lm90_select_remote_channel(data, 0);
+		lm90_select_remote_channel(data, false);
 	}
 
 	return 0;
@@ -914,8 +940,8 @@ static int lm90_update_alarms_locked(struct lm90_data *data, bool force)
 			return val;
 		alarms = val & ~LM90_STATUS_BUSY;
 
-		if (data->kind == max6696) {
-			val = lm90_read_reg(client, MAX6696_REG_STATUS2);
+		if (data->reg_status2) {
+			val = lm90_read_reg(client, data->reg_status2);
 			if (val < 0)
 				return val;
 			alarms |= val << 8;
@@ -1037,20 +1063,20 @@ static int lm90_update_device(struct device *dev)
 			return val;
 		data->temp[REMOTE_TEMP] = val;
 
-		if (data->kind == max6696) {
-			val = lm90_select_remote_channel(data, 1);
+		if (data->flags & LM90_HAVE_TEMP3) {
+			val = lm90_select_remote_channel(data, true);
 			if (val < 0)
 				return val;
 
 			val = lm90_read16(client, LM90_REG_REMOTE_TEMPH,
 					  LM90_REG_REMOTE_TEMPL, true);
 			if (val < 0) {
-				lm90_select_remote_channel(data, 0);
+				lm90_select_remote_channel(data, false);
 				return val;
 			}
 			data->temp[REMOTE2_TEMP] = val;
 
-			lm90_select_remote_channel(data, 0);
+			lm90_select_remote_channel(data, false);
 		}
 
 		val = lm90_update_alarms_locked(data, false);
@@ -1207,7 +1233,7 @@ static int lm90_set_temp(struct lm90_data *data, int index, int channel, long va
 					     lm90_temp_get_resolution(data, index));
 
 	if (channel > 1)
-		lm90_select_remote_channel(data, 1);
+		lm90_select_remote_channel(data, true);
 
 	err = lm90_write_reg(client, regh, data->temp[index] >> 8);
 	if (err < 0)
@@ -1216,7 +1242,7 @@ static int lm90_set_temp(struct lm90_data *data, int index, int channel, long va
 		err = lm90_write_reg(client, regl, data->temp[index] & 0xff);
 deselect:
 	if (channel > 1)
-		lm90_select_remote_channel(data, 0);
+		lm90_select_remote_channel(data, false);
 
 	return err;
 }
@@ -1566,9 +1592,15 @@ static const char *lm90_detect_national(struct i2c_client *client, int chip_id,
 static const char *lm90_detect_analog(struct i2c_client *client, int chip_id,
 				      int config1, int convrate)
 {
+	int config2 = i2c_smbus_read_byte_data(client, ADT7481_REG_CONFIG2);
+	int man_id2 = i2c_smbus_read_byte_data(client, ADT7481_REG_MAN_ID);
+	int chip_id2 = i2c_smbus_read_byte_data(client, ADT7481_REG_CHIP_ID);
 	int address = client->addr;
 	const char *name = NULL;
 
+	if (config2 < 0 || man_id2 < 0 || chip_id2 < 0)
+		return NULL;
+
 	switch (chip_id) {
 	case 0x40 ... 0x4f:	/* ADM1032 */
 		if ((address == 0x4c || address == 0x4d) && !(config1 & 0x3f) &&
@@ -1590,6 +1622,28 @@ static const char *lm90_detect_analog(struct i2c_client *client, int chip_id,
 		    convrate <= 0x0a)
 			name = "adt7461a";
 		break;
+	case 0x62:	/* ADT7481, undocumented */
+		if (man_id2 == 0x41 && chip_id2 == 0x81 &&
+		    (address == 0x4b || address == 0x4c) && !(config1 & 0x10) &&
+		    !(config2 & 0x7f) && (convrate & 0x0f) <= 0x0b) {
+			name = "adt7481";
+		}
+		break;
+	case 0x65:	/* ADT7482, datasheet */
+	case 0x75:	/* ADT7482, real chip */
+		if (man_id2 == 0x41 && chip_id2 == 0x82 &&
+		    address == 0x4c && !(config1 & 0x10) && !(config2 & 0x7f) &&
+		    convrate <= 0x0a)
+			name = "adt7482";
+		break;
+	case 0x94:	/* ADT7483 */
+		if (man_id2 == 0x41 && chip_id2 == 0x83 &&
+		    ((address >= 0x18 && address <= 0x1a) ||
+		     (address >= 0x29 && address <= 0x2b) ||
+		     (address >= 0x4c && address <= 0x4e)) &&
+		    !(config1 & 0x10) && !(config2 & 0x7f) && convrate <= 0x0a)
+			name = "adt7483a";
+		break;
 	default:
 		break;
 	}
@@ -1956,9 +2010,9 @@ static int lm90_init_client(struct i2c_client *client, struct lm90_data *data)
 		config |= 0x20;
 
 	/*
-	 * Select external channel 0 for max6695/96
+	 * Select external channel 0 for devices with three sensors
 	 */
-	if (data->kind == max6696)
+	if (data->flags & LM90_HAVE_TEMP3)
 		config &= ~0x08;
 
 	/*
@@ -2117,13 +2171,18 @@ static int lm90_probe(struct i2c_client *client)
 		data->channel_config[2] = HWMON_T_INPUT |
 			HWMON_T_MIN | HWMON_T_MAX |
 			HWMON_T_CRIT | HWMON_T_CRIT_HYST |
-			HWMON_T_EMERGENCY | HWMON_T_EMERGENCY_HYST |
 			HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM |
-			HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY_ALARM |
-			HWMON_T_FAULT;
+			HWMON_T_CRIT_ALARM | HWMON_T_FAULT;
+		if (data->flags & LM90_HAVE_EMERGENCY) {
+			data->channel_config[2] |= HWMON_T_EMERGENCY |
+				HWMON_T_EMERGENCY_HYST;
+		}
+		if (data->flags & LM90_HAVE_EMERGENCY_ALARM)
+			data->channel_config[2] |= HWMON_T_EMERGENCY_ALARM;
 	}
 
 	data->reg_local_ext = lm90_params[data->kind].reg_local_ext;
+	data->reg_status2 = lm90_params[data->kind].reg_status2;
 
 	/* Set maximum conversion rate */
 	data->max_convrate = lm90_params[data->kind].max_convrate;
-- 
2.35.1

