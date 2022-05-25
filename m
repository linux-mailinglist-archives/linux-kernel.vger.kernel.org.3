Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41437533E92
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiEYOA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiEYN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:10 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C358AB0DE;
        Wed, 25 May 2022 06:58:47 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l10-20020a9d7a8a000000b0060b151de434so6014149otn.2;
        Wed, 25 May 2022 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FB3mQBcVKuAp3ZiZ7Tsm3HzcSHmHse1JzHnZRr198DE=;
        b=N8Vf5jRnKkGT4g/wmFK8mYredI6JRH3CT2rrkRD/8XFCugj/B3hzfQiqg2umii6KqV
         l7vt8bwbLgY0qzXqJ1+d9voBvZT+g7QCY4m5EX7i35perO9GGI7AHsS9Deas4B7Qwpwo
         BGLL1uDABFTWLvb3+z1+GqilmV6Ysd2B5aDIEapRfpGLLBf4oq/X26oCakiTXzLiFFeG
         jQbo9cEjwplwkqYT12ZZuECTqiKLyulhigxx12nSL+eBzMV/DlYlGgvIyVj2UH6wXF+/
         E1CCXInROcl412uKGTzpa5rEzRBzqin2t1GQenZfGIcGtj9o6o8iZg+AvAWTkQ2LHQCq
         3CnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FB3mQBcVKuAp3ZiZ7Tsm3HzcSHmHse1JzHnZRr198DE=;
        b=g5eNcWa3HazJo/TjscowkVjyzPKbejy40yfep6iNtZ9itBnQG+vEagdhQkUI6SuUOq
         Z9qucP5NNFO04nqZaBU/u23AmexfyxxCpvHLxwVSOlubOgEeSzcLAs02eTXZoHg+T97k
         9O+oo4WoEE5ISwj5owOEEHc4AI5LiHashliPHKuNpCPqIhfAfZGtmPyP3J7J8gHyOtGz
         oXNXpitak8uAlZQMpC+lf53xqcUWVG5MAaUfnKUNSsjLnEWnz1yhKdcFK6koRT/sk4G3
         G6/6MXOpXiFWCW3BKPM4iW/VqwHvz3qF42fOLHBkcvkiwC/YaAbcxYUbK3aw8W6o9Z4A
         341g==
X-Gm-Message-State: AOAM531FlkUPYD/GHVoQGPYX7LM05G9y5DvARKdNdJL10ZfJbO4leFUO
        cBaEj4N1AkDGYOuE2gEeMBt5ioZc72xKhA==
X-Google-Smtp-Source: ABdhPJzaMBJZ6eHSQkdxc+2STq2Uh/rHr4M15r/ONB6k+XGuphjGC0BQGUhrQAYQ9ovAr18vKHcAFQ==
X-Received: by 2002:a9d:69d7:0:b0:60b:cee:4cd0 with SMTP id v23-20020a9d69d7000000b0060b0cee4cd0mr6566309oto.145.1653487126993;
        Wed, 25 May 2022 06:58:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e18-20020a056830201200b00606a6f74748sm6049977otp.25.2022.05.25.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 24/40] hwmon: (lm90) Add flag to indicate conversion rate support
Date:   Wed, 25 May 2022 06:57:42 -0700
Message-Id: <20220525135758.2944744-25-linux@roeck-us.net>
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

A flag indicating support for setting the conversion rate doesn't cost
much and will enable us to add support for MAX6642 to the lm90 driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 66 ++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index abf1451c5652..90c3a496bb6c 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -193,6 +193,7 @@ enum chips { adm1032, adt7461, adt7461a, adt7481, g781, lm86, lm90, lm99,
 #define LM90_HAVE_ALARMS	BIT(13)	/* Create 'alarms' attribute	*/
 #define LM90_HAVE_EXT_UNSIGNED	BIT(14)	/* extended unsigned temperature*/
 #define LM90_HAVE_LOW		BIT(15)	/* low limits			*/
+#define LM90_HAVE_CONVRATE	BIT(16)	/* conversion rate		*/
 
 /* LM90 status */
 #define LM90_STATUS_LTHRM	BIT(0)	/* local THERM limit tripped */
@@ -371,7 +372,7 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
 		  | LM90_HAVE_PARTIAL_PEC | LM90_HAVE_ALARMS
-		  | LM90_HAVE_LOW,
+		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
@@ -384,7 +385,7 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_CRIT | LM90_HAVE_PARTIAL_PEC
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 		.resolution = 10,
@@ -393,7 +394,7 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_CRIT | LM90_HAVE_PEC | LM90_HAVE_ALARMS
-		  | LM90_HAVE_LOW,
+		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
@@ -401,7 +402,8 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_PEC
-		  | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT | LM90_HAVE_LOW,
+		  | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT | LM90_HAVE_LOW
+		  | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x1c7c,
 		.max_convrate = 11,
 		.resolution = 10,
@@ -410,58 +412,61 @@ static const struct lm90_params lm90_params[] = {
 	[g781] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 	},
 	[lm86] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
 	[lm90] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
 	[lm99] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
 	[max6646] = {
 		.flags = LM90_HAVE_CRIT | LM90_HAVE_BROKEN_ALERT
-		  | LM90_HAVE_EXT_UNSIGNED | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_EXT_UNSIGNED | LM90_HAVE_ALARMS | LM90_HAVE_LOW
+		  | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6648] = {
 		.flags = LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_CRIT
-		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_LOW,
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_LOW
+		  | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6654] = {
-		.flags = LM90_HAVE_BROKEN_ALERT | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		.flags = LM90_HAVE_BROKEN_ALERT | LM90_HAVE_ALARMS | LM90_HAVE_LOW
+		  | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6657] = {
 		.flags = LM90_PAUSE_FOR_CONFIG | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6659] = {
 		.flags = LM90_HAVE_EMERGENCY | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
@@ -474,14 +479,14 @@ static const struct lm90_params lm90_params[] = {
 		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_CRIT
 		  | LM90_HAVE_CRIT_ALRM_SWP | LM90_HAVE_BROKEN_ALERT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 	},
 	[max6696] = {
 		.flags = LM90_HAVE_EMERGENCY
 		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x1c7c,
 		.max_convrate = 6,
 		.reg_status2 = MAX6696_REG_STATUS2,
@@ -489,7 +494,7 @@ static const struct lm90_params lm90_params[] = {
 	},
 	[w83l771] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 	},
@@ -500,7 +505,7 @@ static const struct lm90_params lm90_params[] = {
 		 * be set).
 		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 		.reg_local_ext = SA56004_REG_LOCAL_TEMPL,
@@ -508,7 +513,8 @@ static const struct lm90_params lm90_params[] = {
 	[tmp451] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT
-		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_ALARMS | LM90_HAVE_LOW
+		  | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.resolution = 12,
@@ -517,7 +523,7 @@ static const struct lm90_params lm90_params[] = {
 	[tmp461] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.resolution = 12,
@@ -1979,7 +1985,8 @@ static void lm90_restore_conf(void *_data)
 	cancel_delayed_work_sync(&data->alert_work);
 
 	/* Restore initial configuration */
-	lm90_write_convrate(data, data->convrate_orig);
+	if (data->flags & LM90_HAVE_CONVRATE)
+		lm90_write_convrate(data, data->convrate_orig);
 	lm90_write_reg(client, LM90_REG_CONFIG1, data->config_orig);
 }
 
@@ -1988,10 +1995,15 @@ static int lm90_init_client(struct i2c_client *client, struct lm90_data *data)
 	struct device_node *np = client->dev.of_node;
 	int config, convrate;
 
-	convrate = lm90_read_reg(client, LM90_REG_CONVRATE);
-	if (convrate < 0)
-		return convrate;
-	data->convrate_orig = convrate;
+	if (data->flags & LM90_HAVE_CONVRATE) {
+		convrate = lm90_read_reg(client, LM90_REG_CONVRATE);
+		if (convrate < 0)
+			return convrate;
+		data->convrate_orig = convrate;
+		lm90_set_convrate(client, data, 500); /* 500ms; 2Hz conversion rate */
+	} else {
+		data->update_interval = 500;
+	}
 
 	/*
 	 * Start the conversions.
@@ -2002,8 +2014,6 @@ static int lm90_init_client(struct i2c_client *client, struct lm90_data *data)
 	data->config_orig = config;
 	data->config = config;
 
-	lm90_set_convrate(client, data, 500); /* 500ms; 2Hz conversion rate */
-
 	/* Check Temperature Range Select */
 	if (data->flags & LM90_HAVE_EXTENDED_TEMP) {
 		if (of_property_read_bool(np, "ti,extended-range-enable"))
@@ -2154,9 +2164,11 @@ static int lm90_probe(struct i2c_client *client)
 	info->type = hwmon_chip;
 	info->config = data->chip_config;
 
-	data->chip_config[0] = HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL;
+	data->chip_config[0] = HWMON_C_REGISTER_TZ;
 	if (data->flags & LM90_HAVE_ALARMS)
 		data->chip_config[0] |= HWMON_C_ALARMS;
+	if (data->flags & LM90_HAVE_CONVRATE)
+		data->chip_config[0] |= HWMON_C_UPDATE_INTERVAL;
 
 	data->info[1] = &data->temp_info;
 
-- 
2.35.1

