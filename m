Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC27533E80
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244645AbiEYOB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244603AbiEYN7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:02 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B2AAE26E;
        Wed, 25 May 2022 06:58:46 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id q7-20020a4adc47000000b0035f4d798376so3805282oov.6;
        Wed, 25 May 2022 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/ZGCgIBEp8AMD68mP9NkD6nfR4ulY45JIBNTsS2fQI=;
        b=RTcC9btHA5Q7OChjAGQ0KWnGdtZKwq8kJ2taVeIPpe+stiQfQqWDne+0LqBsPIGedO
         eilTjCNY7kstMkumyTIxkSDwj5BwEWSwU2cQokkV43WZQ1ia3CJThzGuPyantcYXSkvM
         faDXWDFbQPwtz7j6whxmrvBShmA8aA7rPf9Fty5na4GJ8vx/jK011dl8Qy9emwsqci0Z
         fEvqgFBTRjDRAhNGwfVDlu6dQNMAwuUHjazmyD5A8EKRfCWWrsYASINxM93kiiz6jQW5
         i96a16+y9HBXqTB73gkkYmeT8Nyx5IT4gRQXHhliBqAvoc0aYnfwa98dA0tTYMNstx6w
         DgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=b/ZGCgIBEp8AMD68mP9NkD6nfR4ulY45JIBNTsS2fQI=;
        b=8AT8YMCR2YF/U4dm66tYSg9R094J915w0iDBp2EtzQF/APBXI68dgUArO2AfSMfrHw
         lvsuJ5ddp1lbIbuDrwrTJkeSfK8nQJh61dd7ejAcBfvQcDcILk9qPHMxbBIJol/E0GEA
         CGC7x9NNy4EfrJDe8JLuEDA6wBmqvz4n8lyrShrcHUpOTyWqTptorh1Mphy9kgUKVBZa
         2NJXItHxHdAVQIYYuiGhrBo3bs4VHVxGKYgi0KJV1cvv8QzPPyGPqtmH9fHXhRnIhjYh
         yZ3RCSpEN+eZacpPx3DPR0JecZ3RMNF55VHO101/1d+ySSfNv2EYpN3AYZy3BJl1wF70
         vhaQ==
X-Gm-Message-State: AOAM530PzjjcTbTQzzd3cILCwD42eW5A/Cc/JuwIxcCsfK/D/tgr6Oej
        cECORuD76uwrMeoM/V/AQz5SX71abkhZDw==
X-Google-Smtp-Source: ABdhPJy40x/hvUevpeVAXmRRXh00G0P8KdYomjxZo82BR6ZpfTUjylGWP2A9H9L+YVaDgQkwYfzjsA==
X-Received: by 2002:a4a:2819:0:b0:40e:6f37:1ae8 with SMTP id h25-20020a4a2819000000b0040e6f371ae8mr8879821ooa.44.1653487125233;
        Wed, 25 May 2022 06:58:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w9-20020a9d6389000000b0060ae12c51a5sm6122092otk.59.2022.05.25.06.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 23/40] hwmon: (lm90) Add flag to indicate support for minimum temperature limits
Date:   Wed, 25 May 2022 06:57:41 -0700
Message-Id: <20220525135758.2944744-24-linux@roeck-us.net>
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

A flag indicating support for minimum temperature limits doesn't cost much
and will enable us to add support for MAX6642 to the lm90 driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 54 +++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 22ea75535ab4..abf1451c5652 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -192,6 +192,7 @@ enum chips { adm1032, adt7461, adt7461a, adt7481, g781, lm86, lm90, lm99,
 #define LM90_HAVE_PARTIAL_PEC	BIT(12)	/* Partial PEC support (adm1032)*/
 #define LM90_HAVE_ALARMS	BIT(13)	/* Create 'alarms' attribute	*/
 #define LM90_HAVE_EXT_UNSIGNED	BIT(14)	/* extended unsigned temperature*/
+#define LM90_HAVE_LOW		BIT(15)	/* low limits			*/
 
 /* LM90 status */
 #define LM90_STATUS_LTHRM	BIT(0)	/* local THERM limit tripped */
@@ -369,7 +370,8 @@ static const struct lm90_params lm90_params[] = {
 	[adm1032] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
-		  | LM90_HAVE_PARTIAL_PEC | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_PARTIAL_PEC | LM90_HAVE_ALARMS
+		  | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
@@ -382,7 +384,7 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_CRIT | LM90_HAVE_PARTIAL_PEC
-		  | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 		.resolution = 10,
@@ -390,7 +392,8 @@ static const struct lm90_params lm90_params[] = {
 	[adt7461a] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
-		  | LM90_HAVE_CRIT | LM90_HAVE_PEC | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_CRIT | LM90_HAVE_PEC | LM90_HAVE_ALARMS
+		  | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
@@ -398,7 +401,7 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_PEC
-		  | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT,
+		  | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT | LM90_HAVE_LOW,
 		.alert_alarms = 0x1c7c,
 		.max_convrate = 11,
 		.resolution = 10,
@@ -407,58 +410,58 @@ static const struct lm90_params lm90_params[] = {
 	[g781] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 	},
 	[lm86] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
 	[lm90] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
 	[lm99] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
 	[max6646] = {
 		.flags = LM90_HAVE_CRIT | LM90_HAVE_BROKEN_ALERT
-		  | LM90_HAVE_EXT_UNSIGNED | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_EXT_UNSIGNED | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6648] = {
 		.flags = LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_CRIT
-		  | LM90_HAVE_BROKEN_ALERT,
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6654] = {
-		.flags = LM90_HAVE_BROKEN_ALERT | LM90_HAVE_ALARMS,
+		.flags = LM90_HAVE_BROKEN_ALERT | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6657] = {
 		.flags = LM90_PAUSE_FOR_CONFIG | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6659] = {
 		.flags = LM90_HAVE_EMERGENCY | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
@@ -471,14 +474,14 @@ static const struct lm90_params lm90_params[] = {
 		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_CRIT
 		  | LM90_HAVE_CRIT_ALRM_SWP | LM90_HAVE_BROKEN_ALERT
-		  | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 	},
 	[max6696] = {
 		.flags = LM90_HAVE_EMERGENCY
 		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x1c7c,
 		.max_convrate = 6,
 		.reg_status2 = MAX6696_REG_STATUS2,
@@ -486,7 +489,7 @@ static const struct lm90_params lm90_params[] = {
 	},
 	[w83l771] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 	},
@@ -497,7 +500,7 @@ static const struct lm90_params lm90_params[] = {
 		 * be set).
 		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 		.reg_local_ext = SA56004_REG_LOCAL_TEMPL,
@@ -505,7 +508,7 @@ static const struct lm90_params lm90_params[] = {
 	[tmp451] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT
-		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.resolution = 12,
@@ -514,7 +517,7 @@ static const struct lm90_params lm90_params[] = {
 	[tmp461] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.resolution = 12,
@@ -2161,10 +2164,15 @@ static int lm90_probe(struct i2c_client *client)
 	info->type = hwmon_temp;
 	info->config = data->channel_config;
 
-	data->channel_config[0] = HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
-		HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM;
-	data->channel_config[1] = HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
-		HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM | HWMON_T_FAULT;
+	data->channel_config[0] = HWMON_T_INPUT | HWMON_T_MAX |
+		HWMON_T_MAX_ALARM;
+	data->channel_config[1] = HWMON_T_INPUT | HWMON_T_MAX |
+		HWMON_T_MAX_ALARM | HWMON_T_FAULT;
+
+	if (data->flags & LM90_HAVE_LOW) {
+		data->channel_config[0] |= HWMON_T_MIN | HWMON_T_MIN_ALARM;
+		data->channel_config[1] |= HWMON_T_MIN | HWMON_T_MIN_ALARM;
+	}
 
 	if (data->flags & LM90_HAVE_CRIT) {
 		data->channel_config[0] |= HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_CRIT_HYST;
-- 
2.35.1

