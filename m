Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3912B533EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244669AbiEYOBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244642AbiEYN6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:47 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC32DABF5C;
        Wed, 25 May 2022 06:58:38 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-f2bb84f9edso2957858fac.10;
        Wed, 25 May 2022 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LzGrQA521f4znRunTBtTAMSfpI//uWmIAfNJSo5sNZA=;
        b=XkgIGJzq6ZsqjOoEOrFai7RDdw8V1TQ1e1GR0XxLJFvITV2bslKd7xaCeZhbda9WSq
         BOnxqzxs91F12+lUGNvcnD25CW25mRDZbxqhnqz9l+sDcUEPqTMuKRjDzKISLquvbLMk
         fRdRg8YQNW/lKj5rsW8QLUL6cT419ej0t0nVh1UW7663+5JCwD89Wh4uMFrDYRX0+rhW
         RMCRNjC0thjBqfzRW9yZ9F3OL/8ELyB8n5pRgeiYlEFiYQYBo9sH38SqLvluXLjrtlD4
         IlK7KE36p8J6jUrqqmYe9qZoLv0Krg8HQlUoApoLPTah07b/RQF8WNovPyaVHzyLiXA0
         wOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LzGrQA521f4znRunTBtTAMSfpI//uWmIAfNJSo5sNZA=;
        b=djVbsty7v5JBgZa9OcyXICkpjapJLS0pXpPi74hVe625+y4x9nHgdfCWUzWqMrTnwE
         5iHOB0sew7VwiLVUSySIW7Vi5xB3i22aYAHidda+X0v7931hHmlVAE0/9ZMWMgCQ1BlI
         XJtgjqduhU7+iBi7SU3N7+TNaA8U5Iodgv30YJcwlLZfpxx4mz1VUnmIQqBwDWCMUDyX
         miWZn3m9qFDJj4WHJc6HL6j/4P990LpGVKWjsKsBOZUoAxwdKysvcj7EjpVmK/YTPtPb
         uMkEubJZCMP5sF8jREYHlSxxvK4WS16J1WgLFoCtET+oLrLElMLZsbC8X5Q/g9wJdilq
         thtg==
X-Gm-Message-State: AOAM531r3MGzAYJh2KZO1KB2fhqktTLNakT4HfE+Mc8XeEjV8TASuNfS
        bgnQz10AVOuz0dDYNrywBT+bTuKVU9f5IA==
X-Google-Smtp-Source: ABdhPJw0PX9ox0gioOGRmo3RLhLmQmrs6oy3tl0SO9PrS4QgapbHzFazuXdSSSGKmXp9D+11NopwYQ==
X-Received: by 2002:a05:6870:d1cd:b0:e1:e7ee:faa0 with SMTP id b13-20020a056870d1cd00b000e1e7eefaa0mr5769865oac.5.1653487117817;
        Wed, 25 May 2022 06:58:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q203-20020acac0d4000000b00325cda1ff94sm6215926oif.19.2022.05.25.06.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 19/40] hwmon: (lm90) Add explicit support for MAX6648/MAX6692
Date:   Wed, 25 May 2022 06:57:37 -0700
Message-Id: <20220525135758.2944744-20-linux@roeck-us.net>
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

Unlike MAX6646/MAX6647/MAX6649, MAX6648 and MAX6692 only support
a temperature range of 0..127 degrees C. Separate support for the
two sets of chips to be able to support maximum temperature ranges
correctly for all chips. Introduce new feature flag to indicate
temperature support up to 255 degrees C.

Since the chips are almost identical except for the supported temperature
range, automatic chip detection is limited. Effectively this means that
MAX6648 may be mis-detected as MAX6649 when auto-detected, but there is
nothing we can do about that.

Devicetree nodes are not added for the added chips since it is quite
unlikely that such old chips will ever be used in a devicetree based
system. They can be added later if needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst | 12 +++++++++--
 drivers/hwmon/lm90.c         | 41 ++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index 9886a298797f..e947e609990b 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -105,7 +105,7 @@ Supported chips:
 
   * Maxim MAX6648
 
-    Prefix: 'max6646'
+    Prefix: 'max6648'
 
     Addresses scanned: I2C 0x4c
 
@@ -191,7 +191,7 @@ Supported chips:
 
   * Maxim MAX6692
 
-    Prefix: 'max6646'
+    Prefix: 'max6648'
 
     Addresses scanned: I2C 0x4c
 
@@ -324,6 +324,14 @@ ADT7461, ADT7461A, NCT1008:
   * Lower resolution for remote temperature
   * SMBus PEC support for Write Byte and Receive Byte transactions.
 
+MAX6646, MAX6647, MAX6649:
+  * Better local resolution
+  * Extended range unsigned external temperature
+
+MAX6648, MAX6692:
+  * Better local resolution
+  * Unsigned temperature
+
 MAX6654:
   * Better local resolution
   * Selectable address
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index e23dcf299b03..df4b861024e3 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -115,7 +115,7 @@ static const unsigned short normal_i2c[] = {
 	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 enum chips { adm1032, adt7461, adt7461a, g781, lm86, lm90, lm99,
-	max6646, max6654, max6657, max6659, max6680, max6696,
+	max6646, max6648, max6654, max6657, max6659, max6680, max6696,
 	sa56004, tmp451, tmp461, w83l771,
 };
 
@@ -179,6 +179,7 @@ enum chips { adm1032, adt7461, adt7461a, g781, lm86, lm90, lm99,
 #define LM90_HAVE_PEC		BIT(11)	/* Chip supports PEC		*/
 #define LM90_HAVE_PARTIAL_PEC	BIT(12)	/* Partial PEC support (adm1032)*/
 #define LM90_HAVE_ALARMS	BIT(13)	/* Create 'alarms' attribute	*/
+#define LM90_HAVE_EXT_UNSIGNED	BIT(14)	/* extended unsigned temperature*/
 
 /* LM90 status */
 #define LM90_STATUS_LTHRM	BIT(0)	/* local THERM limit tripped */
@@ -213,6 +214,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "lm99", lm99 },
 	{ "max6646", max6646 },
 	{ "max6647", max6646 },
+	{ "max6648", max6648 },
 	{ "max6649", max6646 },
 	{ "max6654", max6654 },
 	{ "max6657", max6657 },
@@ -220,6 +222,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "max6659", max6659 },
 	{ "max6680", max6680 },
 	{ "max6681", max6680 },
+	{ "max6692", max6648 },
 	{ "max6695", max6696 },
 	{ "max6696", max6696 },
 	{ "nct1008", adt7461a },
@@ -400,7 +403,14 @@ static const struct lm90_params lm90_params[] = {
 	},
 	[max6646] = {
 		.flags = LM90_HAVE_CRIT | LM90_HAVE_BROKEN_ALERT
-		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_ALARMS,
+		  | LM90_HAVE_EXT_UNSIGNED | LM90_HAVE_ALARMS,
+		.alert_alarms = 0x7c,
+		.max_convrate = 6,
+		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
+	},
+	[max6648] = {
+		.flags = LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_CRIT
+		  | LM90_HAVE_BROKEN_ALERT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
@@ -1119,7 +1129,7 @@ static int lm90_temp_from_reg(u32 flags, u16 regval, u8 resolution)
 
 	if (flags & LM90_HAVE_EXTENDED_TEMP)
 		val = regval - 0x4000;
-	else if (flags & LM90_HAVE_UNSIGNED_TEMP)
+	else if (flags & (LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_EXT_UNSIGNED))
 		val = regval;
 	else
 		val = (s16)regval;
@@ -1147,6 +1157,8 @@ static u16 lm90_temp_to_reg(u32 flags, long val, u8 resolution)
 	if (flags & LM90_HAVE_EXTENDED_TEMP) {
 		val = clamp_val(val, -64000, 191000 + fraction);
 		val += 64000;
+	} else if (flags & LM90_HAVE_EXT_UNSIGNED) {
+		val = clamp_val(val, 0, 255000 + fraction);
 	} else if (flags & LM90_HAVE_UNSIGNED_TEMP) {
 		val = clamp_val(val, 0, 127000 + fraction);
 	} else {
@@ -1673,11 +1685,32 @@ static const char *lm90_detect_maxim(struct i2c_client *client, int chip_id,
 		 * The chip_id register of the MAX6646/6647/6649 holds the
 		 * revision of the chip. The lowest 6 bits of the config1
 		 * register are unused and should return zero when read.
+		 * The I2C address of MAX6648/6692 is fixed at 0x4c.
+		 * MAX6646 is at address 0x4d, MAX6647 is at address 0x4e,
+		 * and MAX6649 is at address 0x4c. A slight difference between
+		 * the two sets of chips is that the remote temperature register
+		 * reports different values if the DXP pin is open or shorted.
+		 * We can use that information to help distinguish between the
+		 * chips. MAX6648 will be mis-detected as MAX6649 if the remote
+		 * diode is connected, but there isn't really anything we can
+		 * do about that.
 		 */
 		if (!(config1 & 0x3f) && convrate <= 0x07) {
+			int temp;
+
 			switch (address) {
 			case 0x4c:
-				name = "max6649";
+				/*
+				 * MAX6649 reports an external temperature
+				 * value of 0xff if DXP is open or shorted.
+				 * MAX6648 reports 0x80 in that case.
+				 */
+				temp = i2c_smbus_read_byte_data(client,
+								LM90_REG_REMOTE_TEMPH);
+				if (temp == 0x80)
+					name = "max6648";
+				else
+					name = "max6649";
 				break;
 			case 0x4d:
 				name = "max6646";
-- 
2.35.1

