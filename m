Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F167533E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbiEYOAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244572AbiEYN6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:41 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F10AB0E8;
        Wed, 25 May 2022 06:58:36 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c15-20020a9d684f000000b0060b097c71ecso7317866oto.10;
        Wed, 25 May 2022 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kgX0NZH7fDiJQUhAb8gmt+meldKpgisUE8fSxZ9Voms=;
        b=SmSGRZLh4nDtJaPUUJNmoIqmiM4VYKKYTebXwj7QKvEBhpj4eJ8NV1csfbh4M5s/D+
         IxgEC3x+QMeMi86ZW4R5krrHQy71kG6MkfGvIQGEiKPnCo7paC4twFinaa5zAkIclLoP
         ymQlJ5CH02BzRy1EZWPH0BfTBmFciI57xqmqTze4JNNjm9hEtpsvV+x5d+HJ+hO/Op39
         t6lfhcU8onF216cc12hIChBeVejK9etIT8E9f9U3vftTQLWseXP8n7oc5uMJzwhPQJsN
         NSbS+socvuHnYYkHzFokJ6p3kfZwK94fdOQUsDeKli8SMK9wMz3+5ruEFkJjhUhon7KL
         OU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kgX0NZH7fDiJQUhAb8gmt+meldKpgisUE8fSxZ9Voms=;
        b=TXijp0chv9pJilDpQp2cJnkKs2skPLObfrx6tUcNIgr2vCSRoIOjV2Gh5YYGCTZaOU
         dKbhXW6pOidPcEK1bQbJwJW7+Phex9ar+vnunRkTOQLGoOZVYsOiBhkf077hidzDDi81
         DHpySMF76wqKQcr8/6y1faux10AZccPmYh1PfOry17Cl1W7xtdz9w1YUjE/JPlc392NU
         GY/T36e8pKFhS3fLcbTekJ+t3W3zTnSBWdWfj5dmGReoTwVvf9Myscjh5XU5P/LCGo/D
         c9gsikdbed081556slJe9iarOCxOGA7WIWkH/E4Of1B/Dm6tMfP4wB//fEqo16G/YGa3
         0wQQ==
X-Gm-Message-State: AOAM531xsGO+E4V+B48Kwzm2wpTsC7xi+DSxK2e9iRw9fzaOCZw/JdFj
        1IUDqND5x4b1gK+aV/aU01waf1IGqvvCkg==
X-Google-Smtp-Source: ABdhPJx+H4WTIHKANnxe2J9Y83pEM8P72qvXOuDrSHgjNRis8S2G6ID0thNGOhMngirq4VarMMRTug==
X-Received: by 2002:a05:6830:40c5:b0:60b:39c0:750b with SMTP id h5-20020a05683040c500b0060b39c0750bmr246667otu.97.1653487115898;
        Wed, 25 May 2022 06:58:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y21-20020a4ae715000000b00333220959b9sm6752729oou.1.2022.05.25.06.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 18/40] hwmon: (lm90) Add flag to indicate 'alarms' attribute support
Date:   Wed, 25 May 2022 06:57:36 -0700
Message-Id: <20220525135758.2944744-19-linux@roeck-us.net>
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

We don't want to support the obsolete 'alarms' attribute for new
chips supported by this driver. Add flag to indicate 'alarms' attribute
support and use it for existing chips. This flag will not be set for
additional chips supported by this driver in the future.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 57 +++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index b39e31ded2cb..e23dcf299b03 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -178,6 +178,7 @@ enum chips { adm1032, adt7461, adt7461a, g781, lm86, lm90, lm99,
 #define LM90_HAVE_CRIT_ALRM_SWP	BIT(10)	/* critical alarm bits swapped	*/
 #define LM90_HAVE_PEC		BIT(11)	/* Chip supports PEC		*/
 #define LM90_HAVE_PARTIAL_PEC	BIT(12)	/* Partial PEC support (adm1032)*/
+#define LM90_HAVE_ALARMS	BIT(13)	/* Create 'alarms' attribute	*/
 
 /* LM90 status */
 #define LM90_STATUS_LTHRM	BIT(0)	/* local THERM limit tripped */
@@ -347,7 +348,7 @@ static const struct lm90_params lm90_params[] = {
 	[adm1032] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
-		  | LM90_HAVE_PARTIAL_PEC,
+		  | LM90_HAVE_PARTIAL_PEC | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
@@ -359,7 +360,8 @@ static const struct lm90_params lm90_params[] = {
 		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
-		  | LM90_HAVE_CRIT | LM90_HAVE_PARTIAL_PEC,
+		  | LM90_HAVE_CRIT | LM90_HAVE_PARTIAL_PEC
+		  | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 		.resolution = 10,
@@ -367,55 +369,58 @@ static const struct lm90_params lm90_params[] = {
 	[adt7461a] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
-		  | LM90_HAVE_CRIT | LM90_HAVE_PEC,
+		  | LM90_HAVE_CRIT | LM90_HAVE_PEC | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
 	[g781] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT,
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
+		  | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 	},
 	[lm86] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
 	[lm90] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
 	[lm99] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
 	[max6646] = {
 		.flags = LM90_HAVE_CRIT | LM90_HAVE_BROKEN_ALERT
-		  | LM90_HAVE_UNSIGNED_TEMP,
+		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6654] = {
-		.flags = LM90_HAVE_BROKEN_ALERT,
+		.flags = LM90_HAVE_BROKEN_ALERT | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6657] = {
-		.flags = LM90_PAUSE_FOR_CONFIG | LM90_HAVE_CRIT,
+		.flags = LM90_PAUSE_FOR_CONFIG | LM90_HAVE_CRIT
+		  | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6659] = {
-		.flags = LM90_HAVE_EMERGENCY | LM90_HAVE_CRIT,
+		.flags = LM90_HAVE_EMERGENCY | LM90_HAVE_CRIT
+		  | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
@@ -427,19 +432,22 @@ static const struct lm90_params lm90_params[] = {
 		 * be set).
 		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_CRIT
-		  | LM90_HAVE_CRIT_ALRM_SWP | LM90_HAVE_BROKEN_ALERT,
+		  | LM90_HAVE_CRIT_ALRM_SWP | LM90_HAVE_BROKEN_ALERT
+		  | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 	},
 	[max6696] = {
 		.flags = LM90_HAVE_EMERGENCY
-		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT,
+		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT
+		  | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x1c7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[w83l771] = {
-		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT,
+		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT
+		  | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 	},
@@ -449,7 +457,8 @@ static const struct lm90_params lm90_params[] = {
 		 * and treated as negative temperatures (meaning min_alarm will
 		 * be set).
 		 */
-		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT,
+		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT
+		  | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 		.reg_local_ext = SA56004_REG_LOCAL_TEMPL,
@@ -457,7 +466,7 @@ static const struct lm90_params lm90_params[] = {
 	[tmp451] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT
-		  | LM90_HAVE_UNSIGNED_TEMP,
+		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.resolution = 12,
@@ -465,7 +474,8 @@ static const struct lm90_params lm90_params[] = {
 	},
 	[tmp461] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT,
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT
+		  | LM90_HAVE_ALARMS,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.resolution = 12,
@@ -505,7 +515,9 @@ enum lm90_temp_reg_index {
 struct lm90_data {
 	struct i2c_client *client;
 	struct device *hwmon_dev;
+	u32 chip_config[2];
 	u32 channel_config[4];
+	struct hwmon_channel_info chip_info;
 	struct hwmon_channel_info temp_info;
 	const struct hwmon_channel_info *info[3];
 	struct hwmon_chip_info chip;
@@ -2028,8 +2040,15 @@ static int lm90_probe(struct i2c_client *client)
 	data->chip.ops = &lm90_ops;
 	data->chip.info = data->info;
 
-	data->info[0] = HWMON_CHANNEL_INFO(chip,
-		HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL | HWMON_C_ALARMS);
+	data->info[0] = &data->chip_info;
+	info = &data->chip_info;
+	info->type = hwmon_chip;
+	info->config = data->chip_config;
+
+	data->chip_config[0] = HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL;
+	if (data->flags & LM90_HAVE_ALARMS)
+		data->chip_config[0] |= HWMON_C_ALARMS;
+
 	data->info[1] = &data->temp_info;
 
 	info = &data->temp_info;
-- 
2.35.1

