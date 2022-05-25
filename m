Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF0533E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244540AbiEYN7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244608AbiEYN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:28 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B28BA88B8;
        Wed, 25 May 2022 06:58:24 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2c8c0d5bdso1264028fac.4;
        Wed, 25 May 2022 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHeaF4qvR8W10l3XF9HQVODR5ZGAlxmNzSKfdN0dyPo=;
        b=L9BNg9IGCAAEBU75yplClteKFTWUAo+XJPAiHOloRNlM6bA3ABMrjmSbit6VGilKQt
         5btzFqSfjkzBKRCwrvSyjY5Bj4KMoykBoSvsifmH4ZuiVj9bwNx0fYFwPJFtlfjV3+Tq
         LkyzHIWszFL7xY1p+5t9B9BHk5bWJ1CayxsuCEjkfArLQlZX0ebRAuSGd7tDy+scBJc5
         rr7+VXvweP8d5U4AULcdUHKNAlpxrPgjIm1ltWYIko7ioTR5WyX0qYTqz93selw4womJ
         tfEuCuJacj6UtfEFZqzQuS6eQ+8tpQklYa2dKPCUdq0gdJGpKh5N04P1FKU6vzRzyG1R
         obdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iHeaF4qvR8W10l3XF9HQVODR5ZGAlxmNzSKfdN0dyPo=;
        b=BmdcFnEhzwrtmTyjh78HBNXQc9mD/n2E87B8c+1nsZ0Q7pGmIHWbdAMJmTvDH0yE22
         lg7xOcIvmrbaND3ksdbSTftNLKlmm56jHdaTe4412cY5tqKrX4GlaPrb6YhEfQTfT9Ae
         +380rgPfGAkms5YpShmHL5TI6qGPtmhevGn6T3o7k1qGzspou8ra4ybu9Y7xYkTUr4cb
         LIrxzM130OI0BPIE9nAmihUSAcBEvsBJXWjO7yebuVHDWONicdR1AwlEdW4ztvHaLF/w
         +28Z2ot9OkMohjJR4zKHidfopp1qITc3clIU5iBz0t5+peJPjGXhIQfF21hYjj4nfPY9
         CYAg==
X-Gm-Message-State: AOAM532drB95880ScsqGliymgrSVSXZ19+axQNlpcQlxeAYdhETlyKz+
        OmdEDwoAM6e2odPMDxk+XOPq4pItYyXiJw==
X-Google-Smtp-Source: ABdhPJwnR/sS4OKH8+WNV2EFXv4UHyB7+AfQmrs2RGSwtyP4kYSiXU3VgplUqzcEiDaNl9/vkqFEnA==
X-Received: by 2002:a05:6870:b254:b0:ec:6ca4:c89f with SMTP id b20-20020a056870b25400b000ec6ca4c89fmr5801560oam.272.1653487103094;
        Wed, 25 May 2022 06:58:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o9-20020a4ad149000000b0035eb4e5a6b2sm6551198oor.8.2022.05.25.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 11/40] hwmon: (lm90) Add support for unsigned and signed temperatures
Date:   Wed, 25 May 2022 06:57:29 -0700
Message-Id: <20220525135758.2944744-12-linux@roeck-us.net>
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

ADT7461 and TMP451 temperature sensors support extended temperature ranges.
If standard temperature range is selected, the temperature range is
unsigned and limited to 0 .. 127 degrees C. For TMP461, the standard
temperature range is -128000 ... 127000 degrees C. Distinguish between
the two chips by introducing a feature flag indicating if the standard
temperature range is signed or unsigned. Use the same flag for MAX6646/
MAX6647 as well since those chips also support unsigned temperatures.

Note that while the datasheet for ADT7461 suggests that the default
temperature range is unsigned, tests with a real chip suggest that this
is not the case: If the temperature offset is set to a value << 0,
the temperature register does report negative values.

Tests with real chips show that MAX6680/MAX6681 and SA56004 report
temperatures of 128 degrees C and higher as negative temperatures.
Add respective comments to the code.

Also use clamp_val() and DIV_ROUND_CLOSEST where appropriate in
calculations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 70 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 42e72702b9a9..acb9ca3b99b0 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -170,6 +170,7 @@ enum chips { adm1032, adt7461, adt7461a, g781, lm86, lm90, lm99,
 #define LM90_FLAG_ADT7461_EXT	BIT(0)	/* ADT7461 extended mode	*/
 /* Device features */
 #define LM90_HAVE_OFFSET	BIT(1)	/* temperature offset register	*/
+#define LM90_HAVE_UNSIGNED_TEMP	BIT(2)	/* temperatures are unsigned	*/
 #define LM90_HAVE_REM_LIMIT_EXT	BIT(3)	/* extended remote limit	*/
 #define LM90_HAVE_EMERGENCY	BIT(4)	/* 3rd upper (emergency) limit	*/
 #define LM90_HAVE_EMERGENCY_ALARM BIT(5)/* emergency alarm		*/
@@ -354,6 +355,11 @@ static const struct lm90_params lm90_params[] = {
 		.max_convrate = 10,
 	},
 	[adt7461] = {
+		/*
+		 * Standard temperature range is supposed to be unsigned,
+		 * but that does not match reality. Negative temperatures
+		 * are always reported.
+		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_CRIT | LM90_HAVE_PARTIAL_PEC,
@@ -392,7 +398,8 @@ static const struct lm90_params lm90_params[] = {
 		.max_convrate = 9,
 	},
 	[max6646] = {
-		.flags = LM90_HAVE_CRIT | LM90_HAVE_BROKEN_ALERT,
+		.flags = LM90_HAVE_CRIT | LM90_HAVE_BROKEN_ALERT
+		  | LM90_HAVE_UNSIGNED_TEMP,
 		.alert_alarms = 0x7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
@@ -416,6 +423,11 @@ static const struct lm90_params lm90_params[] = {
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6680] = {
+		/*
+		 * Apparent temperatures of 128 degrees C or higher are reported
+		 * and treated as negative temperatures (meaning min_alarm will
+		 * be set).
+		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_CRIT
 		  | LM90_HAVE_CRIT_ALRM_SWP | LM90_HAVE_BROKEN_ALERT,
 		.alert_alarms = 0x7c,
@@ -434,6 +446,11 @@ static const struct lm90_params lm90_params[] = {
 		.max_convrate = 8,
 	},
 	[sa56004] = {
+		/*
+		 * Apparent temperatures of 128 degrees C or higher are reported
+		 * and treated as negative temperatures (meaning min_alarm will
+		 * be set).
+		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
@@ -441,7 +458,8 @@ static const struct lm90_params lm90_params[] = {
 	},
 	[tmp451] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT,
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT
+		  | LM90_HAVE_UNSIGNED_TEMP,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.reg_local_ext = TMP451_REG_LOCAL_TEMPL,
@@ -1118,33 +1136,27 @@ static inline int temp_from_u16_adt7461(struct lm90_data *data, u16 val)
 static u8 temp_to_u8_adt7461(struct lm90_data *data, long val)
 {
 	if (data->flags & LM90_FLAG_ADT7461_EXT) {
-		if (val <= -64000)
-			return 0;
-		if (val >= 191000)
-			return 0xFF;
-		return (val + 500 + 64000) / 1000;
+		val = clamp_val(val, -64000, 191000);
+		val += 64000;
+	} else if (data->flags & LM90_HAVE_UNSIGNED_TEMP) {
+		val = clamp_val(val, 0, 127000);
+	} else {
+		val = clamp_val(val, -128000, 127000);
 	}
-	if (val <= 0)
-		return 0;
-	if (val >= 127000)
-		return 127;
-	return (val + 500) / 1000;
+	return DIV_ROUND_CLOSEST(val, 1000);
 }
 
 static u16 temp_to_u16_adt7461(struct lm90_data *data, long val)
 {
 	if (data->flags & LM90_FLAG_ADT7461_EXT) {
-		if (val <= -64000)
-			return 0;
-		if (val >= 191750)
-			return 0xFFC0;
-		return (val + 64000 + 125) / 250 * 64;
+		val = clamp_val(val, -64000, 191000);
+		val += 64000;
+	} else if (data->flags & LM90_HAVE_UNSIGNED_TEMP) {
+		val = clamp_val(val, 0, 127000);
+	} else {
+		val = clamp_val(val, -128000, 127000);
 	}
-	if (val <= 0)
-		return 0;
-	if (val >= 127750)
-		return 0x7FC0;
-	return (val + 125) / 250 * 64;
+	return DIV_ROUND_CLOSEST(val, 1000) & 0xfff0;
 }
 
 /* pec used for devices with PEC support */
@@ -1190,7 +1202,7 @@ static int lm90_get_temp11(struct lm90_data *data, int index)
 
 	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		temp = temp_from_u16_adt7461(data, temp11);
-	else if (data->kind == max6646)
+	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
 		temp = temp_from_u16(temp11);
 	else
 		temp = temp_from_s16(temp11);
@@ -1227,7 +1239,7 @@ static int lm90_set_temp11(struct lm90_data *data, int index, long val)
 
 	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		data->temp11[index] = temp_to_u16_adt7461(data, val);
-	else if (data->kind == max6646)
+	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
 		data->temp11[index] = temp_to_u8(val) << 8;
 	else if (data->flags & LM90_HAVE_REM_LIMIT_EXT)
 		data->temp11[index] = temp_to_s16(val);
@@ -1253,7 +1265,7 @@ static int lm90_get_temp8(struct lm90_data *data, int index)
 
 	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		temp = temp_from_u8_adt7461(data, temp8);
-	else if (data->kind == max6646)
+	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
 		temp = temp_from_u8(temp8);
 	else
 		temp = temp_from_s8(temp8);
@@ -1289,7 +1301,7 @@ static int lm90_set_temp8(struct lm90_data *data, int index, long val)
 
 	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		data->temp8[index] = temp_to_u8_adt7461(data, val);
-	else if (data->kind == max6646)
+	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
 		data->temp8[index] = temp_to_u8(val);
 	else
 		data->temp8[index] = temp_to_s8(val);
@@ -1307,7 +1319,7 @@ static int lm90_get_temphyst(struct lm90_data *data, int index)
 
 	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		temp = temp_from_u8_adt7461(data, data->temp8[index]);
-	else if (data->kind == max6646)
+	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
 		temp = temp_from_u8(data->temp8[index]);
 	else
 		temp = temp_from_s8(data->temp8[index]);
@@ -1326,7 +1338,7 @@ static int lm90_set_temphyst(struct lm90_data *data, long val)
 
 	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		temp = temp_from_u8_adt7461(data, data->temp8[LOCAL_CRIT]);
-	else if (data->kind == max6646)
+	else if (data->flags & LM90_HAVE_UNSIGNED_TEMP)
 		temp = temp_from_u8(data->temp8[LOCAL_CRIT]);
 	else
 		temp = temp_from_s8(data->temp8[LOCAL_CRIT]);
@@ -1901,6 +1913,8 @@ static int lm90_init_client(struct i2c_client *client, struct lm90_data *data)
 	 * Put MAX6680/MAX8881 into extended resolution (bit 0x10,
 	 * 0.125 degree resolution) and range (0x08, extend range
 	 * to -64 degree) mode for the remote temperature sensor.
+	 * Note that expeciments with an actual chip do not show a difference
+	 * if bit 3 is set or not.
 	 */
 	if (data->kind == max6680)
 		config |= 0x18;
-- 
2.35.1

