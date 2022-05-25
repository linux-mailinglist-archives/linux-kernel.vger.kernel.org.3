Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278C5533E76
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244702AbiEYN7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244532AbiEYN6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:31 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12093AB0E6;
        Wed, 25 May 2022 06:58:28 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-f2ccb58ee0so515626fac.1;
        Wed, 25 May 2022 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i5WSZHcHSK9HjSsM6PIOIMSfiTkXVCgmkwZNulqpINw=;
        b=ISelWC3ACLOjCQ+/qrSbD+jVrXFptyhcF/ZnQExhUiiIE8Fm3KFi/jqAQxM4P8uqPo
         Yu4Bn8ZC+HWBX+RDTmH1WkC/w8RVZ/cPbllq5tgH4R7VP3fN6enWI2D73bCxugtKnKWb
         RGuCi/JXC9XYeOccwYklWWwq4PZXtfjY8+JAI4Wfab3ZLi6TsaYHCd7O81veFGNT9sCW
         Mo1nhRppZ7/BCzXcGb85CbK2YbNXC+TB14N48SyF9FbpGMUEexSNmPjt8qZ/9hYmXDcj
         Kc/8PLtYRuitP+mVCAKq1Zr56ci6/2Zsqg7gx06UKcJnfcMlGIx3eVN65nQWQZ3WsQqV
         hMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=i5WSZHcHSK9HjSsM6PIOIMSfiTkXVCgmkwZNulqpINw=;
        b=gRAIf/WiBB25+WchHC0nRt0ReF+sqvL2N6p0oMnrnZK+MnyIVOqElTjEYcQdmUL7Di
         KvD7H1UUfEjpEAeMQMy8rDOgz58I21SZHouWZ/ohgKZ0wEgcdrLiL0jnB6G4U6652WVs
         d1JiNMrYFOVvUwFra2HK1b5eyM+H2HScurIDdFUOeLbdL1vGhv4sj31E9dIlzy/DVbJl
         +8TKojQ8AEYeMcH+WEPPLT140t/52z+tpMS2Qe6bh93T8B5DFhOB0iRKGEcxEOWFZMko
         P03JKMy6I6JLr6PEGlXBfZ+bR3YfrU1THdw+1hMXAkjH563Kk32NYpJc+mS5i7HTYE3u
         p58w==
X-Gm-Message-State: AOAM532UrOwR28Lnzxk2Ulmwm8XTH5RRY0I1CgiPPMOgRn+V4SZt0Vbz
        1wijRWVjyTeW+aQJ22RiX7azWeucv41SCw==
X-Google-Smtp-Source: ABdhPJxb8AnU9ZPYtYN9XaY5s5fAFQRx3BqPopiTOJRl/b+HKA5awAfRkwuivkr4akpSuB7lAm1HBA==
X-Received: by 2002:a05:6870:f683:b0:f2:cc34:452a with SMTP id el3-20020a056870f68300b000f2cc34452amr603777oab.216.1653487106855;
        Wed, 25 May 2022 06:58:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s22-20020a056870e6d600b000e686d13895sm5979999oak.47.2022.05.25.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 13/40] hwmon: (lm90) Support multiple temperature resolutions
Date:   Wed, 25 May 2022 06:57:31 -0700
Message-Id: <20220525135758.2944744-14-linux@roeck-us.net>
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

While most LM90 compatible chips support a temperature sensor resolution
of 11 bit, this is not the case for all chips. ADT7461 only supports a
resolution of 10 bit, and TMP451/TMP461 support a resolution of 12 bit.

Add support for various temperature sensor resolutions. To do this,
model all temperature sensors as 16 bit sensors, and use unified
temperature conversion functions which take the sensor resolution
as parameter.

While enhancing functionality, this has the positive side effect of
reducing code size by about 5%.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 450 +++++++++++++++----------------------------
 1 file changed, 153 insertions(+), 297 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index b20be0cb28b5..8e5f791aca07 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -343,6 +343,7 @@ struct lm90_params {
 	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
 				/* Upper 8 bits for max6695/96 */
 	u8 max_convrate;	/* Maximum conversion rate register value */
+	u8 resolution;		/* 16-bit resolution (default 11 bit) */
 	u8 reg_local_ext;	/* Extended local temp register (optional) */
 };
 
@@ -365,6 +366,7 @@ static const struct lm90_params lm90_params[] = {
 		  | LM90_HAVE_CRIT | LM90_HAVE_PARTIAL_PEC,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
+		.resolution = 10,
 	},
 	[adt7461a] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
@@ -462,6 +464,7 @@ static const struct lm90_params lm90_params[] = {
 		  | LM90_HAVE_UNSIGNED_TEMP,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
+		.resolution = 12,
 		.reg_local_ext = TMP451_REG_LOCAL_TEMPL,
 	},
 	[tmp461] = {
@@ -469,14 +472,15 @@ static const struct lm90_params lm90_params[] = {
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
+		.resolution = 12,
 		.reg_local_ext = TMP451_REG_LOCAL_TEMPL,
 	},
 };
 
 /*
- * TEMP8 register index
+ * temperature register index
  */
-enum lm90_temp8_reg_index {
+enum lm90_temp_reg_index {
 	LOCAL_LOW = 0,
 	LOCAL_HIGH,
 	LOCAL_CRIT,
@@ -485,14 +489,8 @@ enum lm90_temp8_reg_index {
 	REMOTE_EMERG,	/* max6659 and max6695/96 */
 	REMOTE2_CRIT,	/* max6695/96 only */
 	REMOTE2_EMERG,	/* max6695/96 only */
-	TEMP8_REG_NUM
-};
 
-/*
- * TEMP11 register index
- */
-enum lm90_temp11_reg_index {
-	REMOTE_TEMP = 0,
+	REMOTE_TEMP,
 	REMOTE_LOW,
 	REMOTE_HIGH,
 	REMOTE_OFFSET,	/* except max6646, max6657/58/59, and max6695/96 */
@@ -500,7 +498,8 @@ enum lm90_temp11_reg_index {
 	REMOTE2_TEMP,	/* max6695/96 only */
 	REMOTE2_LOW,	/* max6695/96 only */
 	REMOTE2_HIGH,	/* max6695/96 only */
-	TEMP11_REG_NUM
+
+	TEMP_REG_NUM
 };
 
 /*
@@ -528,14 +527,14 @@ struct lm90_data {
 	u8 config;		/* Current configuration register value */
 	u8 config_orig;		/* Original configuration register value */
 	u8 convrate_orig;	/* Original conversion rate register value */
+	u8 resolution;		/* temperature resolution in bit */
 	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
 				/* Upper 8 bits for max6695/96 */
 	u8 max_convrate;	/* Maximum conversion rate */
 	u8 reg_local_ext;	/* local extension register offset */
 
 	/* registers values */
-	s8 temp8[TEMP8_REG_NUM];
-	s16 temp11[TEMP11_REG_NUM];
+	u16 temp[TEMP_REG_NUM];
 	u8 temp_hyst;
 	u16 reported_alarms;	/* alarms reported as sysfs/udev events */
 	u16 current_alarms;	/* current alarms, reported by chip */
@@ -732,12 +731,12 @@ static int lm90_update_limits(struct device *dev)
 		val = lm90_read_reg(client, LM90_REG_LOCAL_CRIT);
 		if (val < 0)
 			return val;
-		data->temp8[LOCAL_CRIT] = val;
+		data->temp[LOCAL_CRIT] = val << 8;
 
 		val = lm90_read_reg(client, LM90_REG_REMOTE_CRIT);
 		if (val < 0)
 			return val;
-		data->temp8[REMOTE_CRIT] = val;
+		data->temp[REMOTE_CRIT] = val << 8;
 
 		val = lm90_read_reg(client, LM90_REG_TCRIT_HYST);
 		if (val < 0)
@@ -748,25 +747,25 @@ static int lm90_update_limits(struct device *dev)
 	val = lm90_read_reg(client, LM90_REG_REMOTE_LOWH);
 	if (val < 0)
 		return val;
-	data->temp11[REMOTE_LOW] = val << 8;
+	data->temp[REMOTE_LOW] = val << 8;
 
 	if (data->flags & LM90_HAVE_REM_LIMIT_EXT) {
 		val = lm90_read_reg(client, LM90_REG_REMOTE_LOWL);
 		if (val < 0)
 			return val;
-		data->temp11[REMOTE_LOW] |= val;
+		data->temp[REMOTE_LOW] |= val;
 	}
 
 	val = lm90_read_reg(client, LM90_REG_REMOTE_HIGHH);
 	if (val < 0)
 		return val;
-	data->temp11[REMOTE_HIGH] = val << 8;
+	data->temp[REMOTE_HIGH] = val << 8;
 
 	if (data->flags & LM90_HAVE_REM_LIMIT_EXT) {
 		val = lm90_read_reg(client, LM90_REG_REMOTE_HIGHL);
 		if (val < 0)
 			return val;
-		data->temp11[REMOTE_HIGH] |= val;
+		data->temp[REMOTE_HIGH] |= val;
 	}
 
 	if (data->flags & LM90_HAVE_OFFSET) {
@@ -774,19 +773,19 @@ static int lm90_update_limits(struct device *dev)
 				  LM90_REG_REMOTE_OFFSL, false);
 		if (val < 0)
 			return val;
-		data->temp11[REMOTE_OFFSET] = val;
+		data->temp[REMOTE_OFFSET] = val;
 	}
 
 	if (data->flags & LM90_HAVE_EMERGENCY) {
 		val = lm90_read_reg(client, MAX6659_REG_LOCAL_EMERG);
 		if (val < 0)
 			return val;
-		data->temp8[LOCAL_EMERG] = val;
+		data->temp[LOCAL_EMERG] = val << 8;
 
 		val = lm90_read_reg(client, MAX6659_REG_REMOTE_EMERG);
 		if (val < 0)
 			return val;
-		data->temp8[REMOTE_EMERG] = val;
+		data->temp[REMOTE_EMERG] = val << 8;
 	}
 
 	if (data->kind == max6696) {
@@ -797,22 +796,22 @@ static int lm90_update_limits(struct device *dev)
 		val = lm90_read_reg(client, LM90_REG_REMOTE_CRIT);
 		if (val < 0)
 			return val;
-		data->temp8[REMOTE2_CRIT] = val;
+		data->temp[REMOTE2_CRIT] = val << 8;
 
 		val = lm90_read_reg(client, MAX6659_REG_REMOTE_EMERG);
 		if (val < 0)
 			return val;
-		data->temp8[REMOTE2_EMERG] = val;
+		data->temp[REMOTE2_EMERG] = val << 8;
 
 		val = lm90_read_reg(client, LM90_REG_REMOTE_LOWH);
 		if (val < 0)
 			return val;
-		data->temp11[REMOTE2_LOW] = val << 8;
+		data->temp[REMOTE2_LOW] = val << 8;
 
 		val = lm90_read_reg(client, LM90_REG_REMOTE_HIGHH);
 		if (val < 0)
 			return val;
-		data->temp11[REMOTE2_HIGH] = val << 8;
+		data->temp[REMOTE2_HIGH] = val << 8;
 
 		lm90_select_remote_channel(data, 0);
 	}
@@ -995,30 +994,30 @@ static int lm90_update_device(struct device *dev)
 		val = lm90_read_reg(client, LM90_REG_LOCAL_LOW);
 		if (val < 0)
 			return val;
-		data->temp8[LOCAL_LOW] = val;
+		data->temp[LOCAL_LOW] = val << 8;
 
 		val = lm90_read_reg(client, LM90_REG_LOCAL_HIGH);
 		if (val < 0)
 			return val;
-		data->temp8[LOCAL_HIGH] = val;
+		data->temp[LOCAL_HIGH] = val << 8;
 
 		if (data->reg_local_ext) {
 			val = lm90_read16(client, LM90_REG_LOCAL_TEMP,
 					  data->reg_local_ext, true);
 			if (val < 0)
 				return val;
-			data->temp11[LOCAL_TEMP] = val;
+			data->temp[LOCAL_TEMP] = val;
 		} else {
 			val = lm90_read_reg(client, LM90_REG_LOCAL_TEMP);
 			if (val < 0)
 				return val;
-			data->temp11[LOCAL_TEMP] = val << 8;
+			data->temp[LOCAL_TEMP] = val << 8;
 		}
 		val = lm90_read16(client, LM90_REG_REMOTE_TEMPH,
 				  LM90_REG_REMOTE_TEMPL, true);
 		if (val < 0)
 			return val;
-		data->temp11[REMOTE_TEMP] = val;
+		data->temp[REMOTE_TEMP] = val;
 
 		if (data->kind == max6696) {
 			val = lm90_select_remote_channel(data, 1);
@@ -1031,7 +1030,7 @@ static int lm90_update_device(struct device *dev)
 				lm90_select_remote_channel(data, 0);
 				return val;
 			}
-			data->temp11[REMOTE2_TEMP] = val;
+			data->temp[REMOTE2_TEMP] = val;
 
 			lm90_select_remote_channel(data, 0);
 		}
@@ -1047,123 +1046,6 @@ static int lm90_update_device(struct device *dev)
 	return 0;
 }
 
-/*
- * Conversions
- * For local temperatures and limits, critical limits and the hysteresis
- * value, the LM90 uses signed 8-bit values with LSB = 1 degree Celsius.
- * For remote temperatures and limits, it uses signed 11-bit values with
- * LSB = 0.125 degree Celsius, left-justified in 16-bit registers.  Some
- * Maxim chips use unsigned values.
- */
-
-static inline int temp_from_s8(s8 val)
-{
-	return val * 1000;
-}
-
-static inline int temp_from_u8(u8 val)
-{
-	return val * 1000;
-}
-
-static inline int temp_from_s16(s16 val)
-{
-	return val / 32 * 125;
-}
-
-static inline int temp_from_u16(u16 val)
-{
-	return val / 32 * 125;
-}
-
-static s8 temp_to_s8(long val)
-{
-	if (val <= -128000)
-		return -128;
-	if (val >= 127000)
-		return 127;
-	if (val < 0)
-		return (val - 500) / 1000;
-	return (val + 500) / 1000;
-}
-
-static u8 temp_to_u8(long val)
-{
-	if (val <= 0)
-		return 0;
-	if (val >= 255000)
-		return 255;
-	return (val + 500) / 1000;
-}
-
-static s16 temp_to_s16(long val)
-{
-	if (val <= -128000)
-		return 0x8000;
-	if (val >= 127875)
-		return 0x7FE0;
-	if (val < 0)
-		return (val - 62) / 125 * 32;
-	return (val + 62) / 125 * 32;
-}
-
-static u8 hyst_to_reg(long val)
-{
-	if (val <= 0)
-		return 0;
-	if (val >= 30500)
-		return 31;
-	return (val + 500) / 1000;
-}
-
-/*
- * ADT7461 in compatibility mode is almost identical to LM90 except that
- * attempts to write values that are outside the range 0 < temp < 127 are
- * treated as the boundary value.
- *
- * ADT7461 in "extended mode" operation uses unsigned integers offset by
- * 64 (e.g., 0 -> -64 degC).  The range is restricted to -64..191 degC.
- */
-static inline int temp_from_u8_adt7461(struct lm90_data *data, u8 val)
-{
-	if (data->flags & LM90_FLAG_ADT7461_EXT)
-		return (val - 64) * 1000;
-	return temp_from_s8(val);
-}
-
-static inline int temp_from_u16_adt7461(struct lm90_data *data, u16 val)
-{
-	if (data->flags & LM90_FLAG_ADT7461_EXT)
-		return (val - 0x4000) / 64 * 250;
-	return temp_from_s16(val);
-}
-
-static u8 temp_to_u8_adt7461(struct lm90_data *data, long val)
-{
-	if (data->flags & LM90_FLAG_ADT7461_EXT) {
-		val = clamp_val(val, -64000, 191000);
-		val += 64000;
-	} else if (data->flags & LM90_HAVE_UNSIGNED_TEMP) {
-		val = clamp_val(val, 0, 127000);
-	} else {
-		val = clamp_val(val, -128000, 127000);
-	}
-	return DIV_ROUND_CLOSEST(val, 1000);
-}
-
-static u16 temp_to_u16_adt7461(struct lm90_data *data, long val)
-{
-	if (data->flags & LM90_FLAG_ADT7461_EXT) {
-		val = clamp_val(val, -64000, 191000);
-		val += 64000;
-	} else if (data->flags & LM90_HAVE_UNSIGNED_TEMP) {
-		val = clamp_val(val, 0, 127000);
-	} else {
-		val = clamp_val(val, -128000, 127000);
-	}
-	return DIV_ROUND_CLOSEST(val, 1000) & 0xfff0;
-}
-
 /* pec used for devices with PEC support */
 static ssize_t pec_show(struct device *dev, struct device_attribute *dummy,
 			char *buf)
@@ -1200,159 +1082,141 @@ static ssize_t pec_store(struct device *dev, struct device_attribute *dummy,
 
 static DEVICE_ATTR_RW(pec);
 
-static int lm90_get_temp11(struct lm90_data *data, int index)
+static int lm90_temp_get_resolution(struct lm90_data *data, int index)
 {
-	s16 temp11 = data->temp11[index];
-	int temp;
-
-	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
-		temp = temp_from_u16_adt7461(data, temp11);
-	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
-		temp = temp_from_u16(temp11);
-	else
-		temp = temp_from_s16(temp11);
-
-	/* +16 degrees offset for temp2 for the LM99 */
-	if (data->kind == lm99 && index <= 2)
-		temp += 16000;
-
-	return temp;
+	switch (index) {
+	case REMOTE_TEMP:
+	case REMOTE_OFFSET:
+	case REMOTE2_TEMP:
+		return data->resolution;
+	case LOCAL_TEMP:
+		if (data->reg_local_ext)
+			return data->resolution;
+		return 8;
+	case REMOTE_LOW:
+	case REMOTE_HIGH:
+	case REMOTE2_LOW:
+	case REMOTE2_HIGH:
+		if (data->flags & LM90_HAVE_REM_LIMIT_EXT)
+			return data->resolution;
+		return 8;
+	default:
+		return 8;
+	}
 }
 
-static int lm90_set_temp11(struct lm90_data *data, int index, long val)
+static int lm90_temp_from_reg(u32 flags, u16 regval, u8 resolution)
 {
-	static struct reg {
-		u8 high;
-		u8 low;
-	} reg[] = {
-	[REMOTE_LOW] = { LM90_REG_REMOTE_LOWH, LM90_REG_REMOTE_LOWL },
-	[REMOTE_HIGH] = { LM90_REG_REMOTE_HIGHH, LM90_REG_REMOTE_HIGHL },
-	[REMOTE_OFFSET] = { LM90_REG_REMOTE_OFFSH, LM90_REG_REMOTE_OFFSL },
-	[REMOTE2_LOW] = { LM90_REG_REMOTE_LOWH, LM90_REG_REMOTE_LOWL },
-	[REMOTE2_HIGH] = { LM90_REG_REMOTE_HIGHH, LM90_REG_REMOTE_HIGHL }
-	};
-	struct i2c_client *client = data->client;
-	struct reg *regp = &reg[index];
-	int err;
-
-	/* +16 degrees offset for temp2 for the LM99 */
-	if (data->kind == lm99 && index <= 2) {
-		/* prevent integer underflow */
-		val = max(val, -128000l);
-		val -= 16000;
-	}
+	int val;
 
-	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
-		data->temp11[index] = temp_to_u16_adt7461(data, val);
-	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
-		data->temp11[index] = temp_to_u8(val) << 8;
-	else if (data->flags & LM90_HAVE_REM_LIMIT_EXT)
-		data->temp11[index] = temp_to_s16(val);
+	if (flags & LM90_FLAG_ADT7461_EXT)
+		val = regval - 0x4000;
+	else if (flags & LM90_HAVE_UNSIGNED_TEMP)
+		val = regval;
 	else
-		data->temp11[index] = temp_to_s8(val) << 8;
-
-	lm90_select_remote_channel(data, index >= 3);
-	err = lm90_write_reg(client, regp->high, data->temp11[index] >> 8);
-	if (err < 0)
-		return err;
-	if (data->flags & LM90_HAVE_REM_LIMIT_EXT)
-		err = lm90_write_reg(client, regp->low,
-				     data->temp11[index] & 0xff);
+		val = (s16)regval;
 
-	lm90_select_remote_channel(data, 0);
-	return err;
+	return ((val >> (16 - resolution)) * 1000) >> (resolution - 8);
 }
 
-static int lm90_get_temp8(struct lm90_data *data, int index)
+static int lm90_get_temp(struct lm90_data *data, int index, int channel)
 {
-	s8 temp8 = data->temp8[index];
-	int temp;
-
-	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
-		temp = temp_from_u8_adt7461(data, temp8);
-	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
-		temp = temp_from_u8(temp8);
-	else
-		temp = temp_from_s8(temp8);
+	int temp = lm90_temp_from_reg(data->flags, data->temp[index],
+				      lm90_temp_get_resolution(data, index));
 
-	/* +16 degrees offset for temp2 for the LM99 */
-	if (data->kind == lm99 && index == 3)
+	/* +16 degrees offset for remote temperature on LM99 */
+	if (data->kind == lm99 && channel)
 		temp += 16000;
 
 	return temp;
 }
 
-static int lm90_set_temp8(struct lm90_data *data, int index, long val)
+static u16 lm90_temp_to_reg(u32 flags, long val, u8 resolution)
 {
-	static const u8 reg[TEMP8_REG_NUM] = {
-		LM90_REG_LOCAL_LOW,
-		LM90_REG_LOCAL_HIGH,
-		LM90_REG_LOCAL_CRIT,
-		LM90_REG_REMOTE_CRIT,
-		MAX6659_REG_LOCAL_EMERG,
-		MAX6659_REG_REMOTE_EMERG,
-		LM90_REG_REMOTE_CRIT,
-		MAX6659_REG_REMOTE_EMERG,
+	int fraction = resolution > 8 ?
+			1000 - DIV_ROUND_CLOSEST(1000, BIT(resolution - 8)) : 0;
+
+	if (flags & LM90_FLAG_ADT7461_EXT) {
+		val = clamp_val(val, -64000, 191000 + fraction);
+		val += 64000;
+	} else if (flags & LM90_HAVE_UNSIGNED_TEMP) {
+		val = clamp_val(val, 0, 127000 + fraction);
+	} else {
+		val = clamp_val(val, -128000, 127000 + fraction);
+	}
+
+	return DIV_ROUND_CLOSEST(val << (resolution - 8), 1000) << (16 - resolution);
+}
+
+static int lm90_set_temp(struct lm90_data *data, int index, int channel, long val)
+{
+	static const u8 regs[] = {
+		[LOCAL_LOW] = LM90_REG_LOCAL_LOW,
+		[LOCAL_HIGH] = LM90_REG_LOCAL_HIGH,
+		[LOCAL_CRIT] = LM90_REG_LOCAL_CRIT,
+		[REMOTE_CRIT] = LM90_REG_REMOTE_CRIT,
+		[LOCAL_EMERG] = MAX6659_REG_LOCAL_EMERG,
+		[REMOTE_EMERG] = MAX6659_REG_REMOTE_EMERG,
+		[REMOTE2_CRIT] = LM90_REG_REMOTE_CRIT,
+		[REMOTE2_EMERG] = MAX6659_REG_REMOTE_EMERG,
+		[REMOTE_LOW] = LM90_REG_REMOTE_LOWH,
+		[REMOTE_HIGH] = LM90_REG_REMOTE_HIGHH,
+		[REMOTE2_LOW] = LM90_REG_REMOTE_LOWH,
+		[REMOTE2_HIGH] = LM90_REG_REMOTE_HIGHH,
 	};
 	struct i2c_client *client = data->client;
+	u8 regh = regs[index];
+	u8 regl = 0;
 	int err;
 
-	/* +16 degrees offset for temp2 for the LM99 */
-	if (data->kind == lm99 && index == 3) {
+	if (channel && (data->flags & LM90_HAVE_REM_LIMIT_EXT)) {
+		if (index == REMOTE_LOW || index == REMOTE2_LOW)
+			regl = LM90_REG_REMOTE_LOWL;
+		else if (index == REMOTE_HIGH || index == REMOTE2_HIGH)
+			regl = LM90_REG_REMOTE_HIGHL;
+	}
+
+	/* +16 degrees offset for remote temperature on LM99 */
+	if (data->kind == lm99 && channel) {
 		/* prevent integer underflow */
 		val = max(val, -128000l);
 		val -= 16000;
 	}
 
-	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
-		data->temp8[index] = temp_to_u8_adt7461(data, val);
-	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
-		data->temp8[index] = temp_to_u8(val);
-	else
-		data->temp8[index] = temp_to_s8(val);
+	data->temp[index] = lm90_temp_to_reg(data->flags, val,
+					     lm90_temp_get_resolution(data, index));
 
-	lm90_select_remote_channel(data, index >= 6);
-	err = lm90_write_reg(client, reg[index], data->temp8[index]);
-	lm90_select_remote_channel(data, 0);
+	if (channel > 1)
+		lm90_select_remote_channel(data, 1);
+
+	err = lm90_write_reg(client, regh, data->temp[index] >> 8);
+	if (err < 0)
+		goto deselect;
+	if (regl)
+		err = lm90_write_reg(client, regl, data->temp[index] & 0xff);
+deselect:
+	if (channel > 1)
+		lm90_select_remote_channel(data, 0);
 
 	return err;
 }
 
-static int lm90_get_temphyst(struct lm90_data *data, int index)
+static int lm90_get_temphyst(struct lm90_data *data, int index, int channel)
 {
-	int temp;
-
-	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
-		temp = temp_from_u8_adt7461(data, data->temp8[index]);
-	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
-		temp = temp_from_u8(data->temp8[index]);
-	else
-		temp = temp_from_s8(data->temp8[index]);
-
-	/* +16 degrees offset for temp2 for the LM99 */
-	if (data->kind == lm99 && index == 3)
-		temp += 16000;
+	int temp = lm90_get_temp(data, index, channel);
 
-	return temp - temp_from_s8(data->temp_hyst);
+	return temp - data->temp_hyst * 1000;
 }
 
 static int lm90_set_temphyst(struct lm90_data *data, long val)
 {
-	struct i2c_client *client = data->client;
-	int temp;
-
-	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
-		temp = temp_from_u8_adt7461(data, data->temp8[LOCAL_CRIT]);
-	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
-		temp = temp_from_u8(data->temp8[LOCAL_CRIT]);
-	else
-		temp = temp_from_s8(data->temp8[LOCAL_CRIT]);
+	int temp = lm90_get_temp(data, LOCAL_CRIT, 0);
 
 	/* prevent integer overflow/underflow */
 	val = clamp_val(val, -128000l, 255000l);
+	data->temp_hyst = clamp_val(DIV_ROUND_CLOSEST(temp - val, 1000), 0, 31);
 
-	data->temp_hyst = hyst_to_reg(temp - val);
-	return lm90_write_reg(client, LM90_REG_TCRIT_HYST, data->temp_hyst);
+	return lm90_write_reg(data->client, LM90_REG_TCRIT_HYST, data->temp_hyst);
 }
 
 static const u8 lm90_temp_index[3] = {
@@ -1396,7 +1260,7 @@ static int lm90_temp_read(struct device *dev, u32 attr, int channel, long *val)
 
 	switch (attr) {
 	case hwmon_temp_input:
-		*val = lm90_get_temp11(data, lm90_temp_index[channel]);
+		*val = lm90_get_temp(data, lm90_temp_index[channel], channel);
 		break;
 	case hwmon_temp_min_alarm:
 	case hwmon_temp_max_alarm:
@@ -1428,35 +1292,26 @@ static int lm90_temp_read(struct device *dev, u32 attr, int channel, long *val)
 		data->alarms |= data->current_alarms;
 		break;
 	case hwmon_temp_min:
-		if (channel == 0)
-			*val = lm90_get_temp8(data,
-					      lm90_temp_min_index[channel]);
-		else
-			*val = lm90_get_temp11(data,
-					       lm90_temp_min_index[channel]);
+		*val = lm90_get_temp(data, lm90_temp_min_index[channel], channel);
 		break;
 	case hwmon_temp_max:
-		if (channel == 0)
-			*val = lm90_get_temp8(data,
-					      lm90_temp_max_index[channel]);
-		else
-			*val = lm90_get_temp11(data,
-					       lm90_temp_max_index[channel]);
+		*val = lm90_get_temp(data, lm90_temp_max_index[channel], channel);
 		break;
 	case hwmon_temp_crit:
-		*val = lm90_get_temp8(data, lm90_temp_crit_index[channel]);
+		*val = lm90_get_temp(data, lm90_temp_crit_index[channel], channel);
 		break;
 	case hwmon_temp_crit_hyst:
-		*val = lm90_get_temphyst(data, lm90_temp_crit_index[channel]);
+		*val = lm90_get_temphyst(data, lm90_temp_crit_index[channel], channel);
 		break;
 	case hwmon_temp_emergency:
-		*val = lm90_get_temp8(data, lm90_temp_emerg_index[channel]);
+		*val = lm90_get_temp(data, lm90_temp_emerg_index[channel], channel);
 		break;
 	case hwmon_temp_emergency_hyst:
-		*val = lm90_get_temphyst(data, lm90_temp_emerg_index[channel]);
+		*val = lm90_get_temphyst(data, lm90_temp_emerg_index[channel], channel);
 		break;
 	case hwmon_temp_offset:
-		*val = lm90_get_temp11(data, REMOTE_OFFSET);
+		*val = lm90_temp_from_reg(0, data->temp[REMOTE_OFFSET],
+					  lm90_temp_get_resolution(data, REMOTE_OFFSET));
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1477,36 +1332,36 @@ static int lm90_temp_write(struct device *dev, u32 attr, int channel, long val)
 
 	switch (attr) {
 	case hwmon_temp_min:
-		if (channel == 0)
-			err = lm90_set_temp8(data,
-					      lm90_temp_min_index[channel],
-					      val);
-		else
-			err = lm90_set_temp11(data,
-					      lm90_temp_min_index[channel],
-					      val);
+		err = lm90_set_temp(data, lm90_temp_min_index[channel],
+				    channel, val);
 		break;
 	case hwmon_temp_max:
-		if (channel == 0)
-			err = lm90_set_temp8(data,
-					     lm90_temp_max_index[channel],
-					     val);
-		else
-			err = lm90_set_temp11(data,
-					      lm90_temp_max_index[channel],
-					      val);
+		err = lm90_set_temp(data, lm90_temp_max_index[channel],
+				    channel, val);
 		break;
 	case hwmon_temp_crit:
-		err = lm90_set_temp8(data, lm90_temp_crit_index[channel], val);
+		err = lm90_set_temp(data, lm90_temp_crit_index[channel],
+				    channel, val);
 		break;
 	case hwmon_temp_crit_hyst:
 		err = lm90_set_temphyst(data, val);
 		break;
 	case hwmon_temp_emergency:
-		err = lm90_set_temp8(data, lm90_temp_emerg_index[channel], val);
+		err = lm90_set_temp(data, lm90_temp_emerg_index[channel],
+				    channel, val);
 		break;
 	case hwmon_temp_offset:
-		err = lm90_set_temp11(data, REMOTE_OFFSET, val);
+		val = lm90_temp_to_reg(0, val,
+				       lm90_temp_get_resolution(data, REMOTE_OFFSET));
+		data->temp[REMOTE_OFFSET] = val;
+		err = i2c_smbus_write_byte_data(data->client,
+						LM90_REG_REMOTE_OFFSH,
+						val >> 8);
+		if (err)
+			break;
+		err = i2c_smbus_write_byte_data(data->client,
+						LM90_REG_REMOTE_OFFSL,
+						val & 0xff);
 		break;
 	default:
 		err = -EOPNOTSUPP;
@@ -2035,6 +1890,7 @@ static int lm90_probe(struct i2c_client *client)
 	 * ALERT# output
 	 */
 	data->alert_alarms = lm90_params[data->kind].alert_alarms;
+	data->resolution = lm90_params[data->kind].resolution ? : 11;
 
 	/* Set chip capabilities */
 	data->flags = lm90_params[data->kind].flags;
-- 
2.35.1

