Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1713E533E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiEYN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244589AbiEYN6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:20 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3FBAB0EC;
        Wed, 25 May 2022 06:58:17 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s188so21303700oie.4;
        Wed, 25 May 2022 06:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7F42WDhuEOZCqFLtsy7+MsIBzNuo73kwtXfuBMDyVHI=;
        b=Ir4yZ2T22ugbw6lmzAtxdOm5VOUiGTpI4FsK731p/zLxeZLmGAUfO4FVe5vf6D7rU0
         6RMcsshOKjz7F3Ih7DNXv0Dy7aAbauQ7S2QQAgdyTroYHdDKeY5WcbWDQi/twHUa3HX+
         XX2a42b6E64XBKBfaUM5QLkGW4n+zJtJtxKvG8jU/AAjwttfh3T5KCSyxWJYdcWuNNjl
         +GVltfYmkVwoVPwaBb1CKPly3mw/3XTAFcK/2s9uBeptLODNogITAfZuex5OvHjUxlQ1
         FzE555Omf6ASmAf12+WSV4EBbw7JkSKgKD16NY69w/okvIBeQ22gLC2Aeq2ENgL2vJsj
         oc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7F42WDhuEOZCqFLtsy7+MsIBzNuo73kwtXfuBMDyVHI=;
        b=QYVIZkiBKpoVEmvdZ9gYWqg3eeCTMwgKOzb/seD0wHgv2sWulpGIvjnIgg7WbACNri
         Dyslpk0OjmwrcgkCL09lZVVhq8w33x0CZZJQKGxi1RNxvdM50CpWywAbhSpY1qc6rUyg
         +xABXDSVvVkU7FyHHi7X2cd+hI592Xn2gcHMrBPSmKwHTqNQtDbEUArXUNKDVjf0A0GJ
         BRIEwMyTe0y+QmjUlaO+gzFW5WZrNJbshIaPFrxLT/8Jitd/7xmwWO2mA/Fd16eEReEN
         PdfwgCf9uKAq6vByY0Hhorxnccn0nDANHkuqpBjFRoF47IHU2aJlVRrAjp5UrYBsk4Ky
         KeOQ==
X-Gm-Message-State: AOAM530e6lT1a/+n+Dp0X0UTyeJ2wqdn4p1cLjH+q6mh+1N2aP2hYZJZ
        BRjfgu45RHUbwf6eX5JVF+9ypbn2MnDEHA==
X-Google-Smtp-Source: ABdhPJyys4rRkXZV84NUTmDmknJsEuWTCH2Vj+8i+TCfGhdrkKXzd7UbitXPXxIYIj1LevafTkyj7w==
X-Received: by 2002:a05:6808:1244:b0:2f9:e450:4bc4 with SMTP id o4-20020a056808124400b002f9e4504bc4mr5288340oiv.290.1653487096510;
        Wed, 25 May 2022 06:58:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7-20020a4ab2c7000000b0035ef3da8387sm6595521ooo.4.2022.05.25.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/40] hwmon: (lm90) Improve PEC support
Date:   Wed, 25 May 2022 06:57:26 -0700
Message-Id: <20220525135758.2944744-9-linux@roeck-us.net>
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

PEC (packet error checking) support for ADM1032 is currently only enabled
if the chip was auto-detected, but not if a chip is instantiated
explicitly. Always enable PEC support by introducing a chip feature flag
indicating partial PEC support. Also, for consistency, disable PEC support
by default to match existing functionality if the chip was not auto-
detected.

At the same time, introduce generic support for PEC with a separate feature
flag. This will be used when support for chips with full PEC functionality
is added.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst |  6 ++--
 drivers/hwmon/lm90.c         | 56 +++++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index 05391fb4042d..f107d4a159fa 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -423,6 +423,6 @@ two transactions will typically mean twice as much delay waiting for
 transaction completion, effectively doubling the register cache refresh time.
 I guess reliability comes at a price, but it's quite expensive this time.
 
-So, as not everyone might enjoy the slowdown, PEC can be disabled through
-sysfs. Just write 0 to the "pec" file and PEC will be disabled. Write 1
-to that file to enable PEC again.
+So, as not everyone might enjoy the slowdown, PEC is disabled by default and
+can be enabled through sysfs. Just write 1 to the "pec" file and PEC will be
+enabled. Write 0 to that file to disable PEC again.
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 995b27a248e6..8ba95ea06f0c 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -179,6 +179,8 @@ enum chips { adm1032, adt7461, g781, lm86, lm90, lm99,
 #define LM90_PAUSE_FOR_CONFIG	BIT(9)	/* Pause conversion for config	*/
 #define LM90_HAVE_CRIT		BIT(10)	/* Chip supports CRIT/OVERT register	*/
 #define LM90_HAVE_CRIT_ALRM_SWP	BIT(11)	/* critical alarm bits swapped	*/
+#define LM90_HAVE_PEC		BIT(12)	/* Chip supports PEC		*/
+#define LM90_HAVE_PARTIAL_PEC	BIT(13)	/* Partial PEC support (adm1032)*/
 
 /* LM90 status */
 #define LM90_STATUS_LTHRM	BIT(0)	/* local THERM limit tripped */
@@ -346,7 +348,8 @@ struct lm90_params {
 static const struct lm90_params lm90_params[] = {
 	[adm1032] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT,
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
+		  | LM90_HAVE_PARTIAL_PEC,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
@@ -519,10 +522,10 @@ struct lm90_data {
  */
 
 /*
- * The ADM1032 supports PEC but not on write byte transactions, so we need
+ * If the chip supports PEC but not on write byte transactions, we need
  * to explicitly ask for a transaction without PEC.
  */
-static inline s32 adm1032_write_byte(struct i2c_client *client, u8 value)
+static inline s32 lm90_write_no_pec(struct i2c_client *client, u8 value)
 {
 	return i2c_smbus_xfer(client->adapter, client->addr,
 			      client->flags & ~I2C_CLIENT_PEC,
@@ -531,22 +534,24 @@ static inline s32 adm1032_write_byte(struct i2c_client *client, u8 value)
 
 /*
  * It is assumed that client->update_lock is held (unless we are in
- * detection or initialization steps). This matters when PEC is enabled,
- * because we don't want the address pointer to change between the write
- * byte and the read byte transactions.
+ * detection or initialization steps). This matters when PEC is enabled
+ * for chips with partial PEC support, because we don't want the address
+ * pointer to change between the write byte and the read byte transactions.
  */
 static int lm90_read_reg(struct i2c_client *client, u8 reg)
 {
+	struct lm90_data *data = i2c_get_clientdata(client);
+	bool partial_pec = (client->flags & I2C_CLIENT_PEC) &&
+			(data->flags & LM90_HAVE_PARTIAL_PEC);
 	int err;
 
-	if (client->flags & I2C_CLIENT_PEC) {
-		err = adm1032_write_byte(client, reg);
-		if (err >= 0)
-			err = i2c_smbus_read_byte(client);
-	} else
-		err = i2c_smbus_read_byte_data(client, reg);
-
-	return err;
+	if (partial_pec) {
+		err = lm90_write_no_pec(client, reg);
+		if (err)
+			return err;
+		return i2c_smbus_read_byte(client);
+	}
+	return i2c_smbus_read_byte_data(client, reg);
 }
 
 /*
@@ -1135,7 +1140,7 @@ static u16 temp_to_u16_adt7461(struct lm90_data *data, long val)
 	return (val + 125) / 250 * 64;
 }
 
-/* pec used for ADM1032 only */
+/* pec used for devices with PEC support */
 static ssize_t pec_show(struct device *dev, struct device_attribute *dummy,
 			char *buf)
 {
@@ -1675,13 +1680,6 @@ static int lm90_detect(struct i2c_client *client,
 		 && (config1 & 0x3F) == 0x00
 		 && convrate <= 0x0A) {
 			name = "adm1032";
-			/*
-			 * The ADM1032 supports PEC, but only if combined
-			 * transactions are not used.
-			 */
-			if (i2c_check_functionality(adapter,
-						    I2C_FUNC_SMBUS_BYTE))
-				info->flags |= I2C_CLIENT_PEC;
 		} else
 		if (chip_id == 0x51 /* ADT7461 */
 		 && (config1 & 0x1B) == 0x00
@@ -2005,10 +2003,6 @@ static int lm90_probe(struct i2c_client *client)
 		data->kind = (enum chips)of_device_get_match_data(&client->dev);
 	else
 		data->kind = i2c_match_id(lm90_id, client)->driver_data;
-	if (data->kind == adm1032) {
-		if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
-			client->flags &= ~I2C_CLIENT_PEC;
-	}
 
 	/*
 	 * Different devices have different alarm bits triggering the
@@ -2019,6 +2013,14 @@ static int lm90_probe(struct i2c_client *client)
 	/* Set chip capabilities */
 	data->flags = lm90_params[data->kind].flags;
 
+	if ((data->flags & (LM90_HAVE_PEC | LM90_HAVE_PARTIAL_PEC)) &&
+	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_PEC))
+		data->flags &= ~(LM90_HAVE_PEC | LM90_HAVE_PARTIAL_PEC);
+
+	if ((data->flags & LM90_HAVE_PARTIAL_PEC) &&
+	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+		data->flags &= ~LM90_HAVE_PARTIAL_PEC;
+
 	data->chip.ops = &lm90_ops;
 	data->chip.info = data->info;
 
@@ -2081,7 +2083,7 @@ static int lm90_probe(struct i2c_client *client)
 	 * The 'pec' attribute is attached to the i2c device and thus created
 	 * separately.
 	 */
-	if (client->flags & I2C_CLIENT_PEC) {
+	if (data->flags & (LM90_HAVE_PEC | LM90_HAVE_PARTIAL_PEC)) {
 		err = device_create_file(dev, &dev_attr_pec);
 		if (err)
 			return err;
-- 
2.35.1

