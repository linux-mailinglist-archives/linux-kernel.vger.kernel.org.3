Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A601533E98
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiEYOBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244721AbiEYN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:33 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752FAEE1E;
        Wed, 25 May 2022 06:58:55 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2c8c0d5bdso1264028fac.4;
        Wed, 25 May 2022 06:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waqDWqNuW5+NNe7+vkj+9ug9vp2U0QUOBf+Z/Shh+iE=;
        b=oh7FZyQFRhoixlFTnJjWA3z7ndOc9Ru/D4203Jfc+da4RRGRD3nTctPbKKI3+A13iR
         Bwqvb4fZ8xrbtbGS99z+4hmoMsYMier3+W226V9zUNRvd7eF62FEMh8Io0xriYigRtwC
         dWg/zLQN9oH13i7gbLa3pYOXXtBhv3670DP+TweCj1PkEYOhLRIfqDQTjxyEb952jV4J
         i939liRXGJgEZmBbfiqOzLwibzngA3D7vl+KtITQMZkI691Tg7VTLowxlyinw33mlecE
         UaZdSOcQuc4sI+hpIJ7qLeKUnYIPVx+4VOpzB/ISQa2d8VGLZpu2Lm/9CYXU0WVfil1Y
         mjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=waqDWqNuW5+NNe7+vkj+9ug9vp2U0QUOBf+Z/Shh+iE=;
        b=U2cugzkYz4cswqM0xESyCivg1fV+xq7a7Ph+5myDxMG0OWLVBOfPJbI97+phXa59O0
         wBG9lY/xBWZzkGihU8O4R3IUK59GDU7gas6iUaCjYrNnztLTgjLVo8WGEWqnlCPeL/OB
         ZeN76Qh9mR+Wc2EcPX4Nsbhw0Vk3uKXd7xAmrpszkvg+FRJd0RXranH7EplSwtRTBlvJ
         MNWmwVGjHClAnfZA5WetJ+utkXZ75M+mtXeA37pYeBBZ5Fq6Cnnxr1IQ2AEpOppClwCs
         l4vhPrx34nmkT3SetMDC3nidlelYUlhDUHGfS/04r5hr5Ocut82JyL1v57PLxc626/Of
         zmgQ==
X-Gm-Message-State: AOAM533vsejvp730ySUYEtcTomhFFSkDEXu3b8qkQVL8jS+s5y0nHgj0
        5ADeMkpH+QzN8hKrhOTLmfphOpdt4ggPzA==
X-Google-Smtp-Source: ABdhPJxL6sa2RJ5Nk3unmfgvciZBn6QM+k4hgPnVXshUnjpDwcii5zJCiJ4Vy8gDjDLNuEfViZra1A==
X-Received: by 2002:a05:6870:f708:b0:f2:b090:3378 with SMTP id ej8-20020a056870f70800b000f2b0903378mr3710817oab.118.1653487134469;
        Wed, 25 May 2022 06:58:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 61-20020a9d0c43000000b0060603221245sm6092539otr.21.2022.05.25.06.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 28/40] hwmon: (lm90) Support MAX1617 and LM84
Date:   Wed, 25 May 2022 06:57:46 -0700
Message-Id: <20220525135758.2944744-29-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135758.2944744-1-linux@roeck-us.net>
References: <20220525135758.2944744-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX1617 and LM84 are stripped-down versions of LM90, so they can easily
be supported by the LM90 driver. The most difficult part is chip detection,
since those old chips do not support manufacturer ID or chip ID registers.

The "alarms" attribute is enabled for both chips to match the functionality
of the adm1021 driver. Chip detection was improved and is less prone to
misdetection than the chip detection in the adm1021 driver.

Devicetree nodes are not added for the added chips since it is quite
unlikely that such old chips will ever be used in a devicetree based
system. They can be added later if needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst |  45 +++++-
 drivers/hwmon/Kconfig        |   9 +-
 drivers/hwmon/lm90.c         | 264 ++++++++++++++++++++++++++++++-----
 3 files changed, 275 insertions(+), 43 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index 313b18f6531d..8fe9013b9c39 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -3,6 +3,14 @@ Kernel driver lm90
 
 Supported chips:
 
+  * National Semiconductor LM84
+
+    Prefix: 'lm84'
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheet: Publicly available at the National Semiconductor website
+
   * National Semiconductor LM90
 
     Prefix: 'lm90'
@@ -113,6 +121,22 @@ Supported chips:
 
 	       https://www.onsemi.com/PowerSolutions/product.do?id=NCT1008
 
+  * Maxim MAX1617
+
+    Prefix: 'max1617'
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheet: Publicly available at the Maxim website
+
+  * Maxim MAX1617A
+
+    Prefix: 'max1617a'
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheet: Publicly available at the Maxim website
+
   * Maxim MAX6642
 
     Prefix: 'max6642'
@@ -325,6 +349,12 @@ The LM90 is a digital temperature sensor. It senses its own temperature as
 well as the temperature of up to one external diode. It is compatible
 with many other devices, many of which are supported by this driver.
 
+The family of chips supported by this driver is derived from MAX1617.
+This chip as well as various compatible chips support a local and a remote
+temperature sensor with 8 bit accuracy. Later chips provide improved accuracy
+and other additional features such as hysteresis and temperature offset
+registers.
+
 Note that there is no easy way to differentiate between the MAX6657,
 MAX6658 and MAX6659 variants. The extra features of the MAX6659 are only
 supported by this driver if the chip is located at address 0x4d or 0x4e,
@@ -332,15 +362,22 @@ or if the chip type is explicitly selected as max6659.
 The MAX6680 and MAX6681 only differ in their pinout, therefore they obviously
 can't (and don't need to) be distinguished.
 
-The specificity of this family of chipsets over the ADM1021/LM84
-family is that it features critical limits with hysteresis, and an
-increased resolution of the remote temperature measurement.
-
 The different chipsets of the family are not strictly identical, although
 very similar. For reference, here comes a non-exhaustive list of specific
 features:
 
+LM84:
+  * 8 bit sensor resolution
+
+MAX1617:
+  * 8 bit sensor resolution
+  * Low temperature limits
+
 LM90:
+  * 11 bit resolution for remote temperature sensor
+  * Temperature offset register for remote temperature sensor
+  * Low and critical temperature limits
+  - Configurable conversion rate
   * Filter and alert configuration register at 0xBF.
   * ALERT is triggered by temperatures over critical limits.
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 39ce1b2ccbb3..1dd812cf15bb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1358,11 +1358,12 @@ config SENSORS_LM90
 	tristate "National Semiconductor LM90 and compatibles"
 	depends on I2C
 	help
-	  If you say yes here you get support for National Semiconductor LM90,
-	  LM86, LM89 and LM99, Analog Devices ADM1032, ADT7461, ADT7461A,
+	  If you say yes here you get support for National Semiconductor LM84,
+	  LM90, LM86, LM89 and LM99, Analog Devices ADM1032, ADT7461, ADT7461A,
 	  ADT7481, ADT7482, and ADT7483A,
-	  Maxim MAX6642, MAX6646, MAX6647, MAX6648, MAX6649, MAX6654, MAX6657,
-	  MAX6658, MAX6659, MAX6680, MAX6681, MAX6692, MAX6695, MAX6696,
+	  Maxim MAX1617, MAX6642, MAX6646, MAX6647, MAX6648, MAX6649, MAX6654,
+	  MAX6657, MAX6658, MAX6659, MAX6680, MAX6681, MAX6692, MAX6695,
+	  MAX6696,
 	  ON Semiconductor NCT1008, Winbond/Nuvoton W83L771W/G/AWG/ASG,
 	  Philips SA56004, GMT G781, Texas Instruments TMP451 and TMP461
 	  sensor chips.
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 46837f0bf62e..09c3b9eb2f8b 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -80,6 +80,9 @@
  * They are mostly compatible with ADT7461 except for local temperature
  * low byte register and max conversion rate.
  *
+ * This driver also supports MAX1617 and various clones such as G767
+ * and NE1617. Such clones will be detected as MAX1617.
+ *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
  * concern all supported chipsets, unless mentioned otherwise.
@@ -119,8 +122,8 @@ static const unsigned short normal_i2c[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 	0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
-enum chips { adm1032, adt7461, adt7461a, adt7481, g781, lm86, lm90, lm99,
-	max6642, max6646, max6648, max6654, max6657, max6659, max6680, max6696,
+enum chips { adm1032, adt7461, adt7461a, adt7481, g781, lm84, lm86, lm90, lm99,
+	max1617, max6642, max6646, max6648, max6654, max6657, max6659, max6680, max6696,
 	sa56004, tmp451, tmp461, w83l771,
 };
 
@@ -194,6 +197,7 @@ enum chips { adm1032, adt7461, adt7461a, adt7481, g781, lm86, lm90, lm99,
 #define LM90_HAVE_EXT_UNSIGNED	BIT(14)	/* extended unsigned temperature*/
 #define LM90_HAVE_LOW		BIT(15)	/* low limits			*/
 #define LM90_HAVE_CONVRATE	BIT(16)	/* conversion rate		*/
+#define LM90_HAVE_REMOTE_EXT	BIT(17)	/* extended remote temperature	*/
 
 /* LM90 status */
 #define LM90_STATUS_LTHRM	BIT(0)	/* local THERM limit tripped */
@@ -226,10 +230,12 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "adt7482", adt7481 },
 	{ "adt7483a", adt7481 },
 	{ "g781", g781 },
-	{ "lm90", lm90 },
+	{ "lm84", lm84 },
 	{ "lm86", lm86 },
 	{ "lm89", lm86 },
+	{ "lm90", lm90 },
 	{ "lm99", lm99 },
+	{ "max1617", max1617 },
 	{ "max6642", max6642 },
 	{ "max6646", max6646 },
 	{ "max6647", max6646 },
@@ -373,7 +379,7 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
 		  | LM90_HAVE_PARTIAL_PEC | LM90_HAVE_ALARMS
-		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
@@ -386,7 +392,8 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_CRIT | LM90_HAVE_PARTIAL_PEC
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
+		  | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 		.resolution = 10,
@@ -395,7 +402,7 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_CRIT | LM90_HAVE_PEC | LM90_HAVE_ALARMS
-		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
@@ -404,7 +411,7 @@ static const struct lm90_params lm90_params[] = {
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_PEC
 		  | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT | LM90_HAVE_LOW
-		  | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x1c7c,
 		.max_convrate = 11,
 		.resolution = 10,
@@ -413,38 +420,54 @@ static const struct lm90_params lm90_params[] = {
 	[g781] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
+		  | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 	},
+	[lm84] = {
+		.flags = LM90_HAVE_ALARMS,
+		.resolution = 8,
+	},
 	[lm86] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
 	[lm90] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
 	[lm99] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 	},
+	[max1617] = {
+		.flags = LM90_HAVE_CONVRATE | LM90_HAVE_BROKEN_ALERT |
+		  LM90_HAVE_LOW | LM90_HAVE_ALARMS,
+		.alert_alarms = 0x78,
+		.resolution = 8,
+		.max_convrate = 7,
+	},
 	[max6642] = {
-		.flags = LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXT_UNSIGNED,
+		.flags = LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXT_UNSIGNED
+		  | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x50,
-		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 		.resolution = 10,
+		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6646] = {
 		.flags = LM90_HAVE_CRIT | LM90_HAVE_BROKEN_ALERT
 		  | LM90_HAVE_EXT_UNSIGNED | LM90_HAVE_ALARMS | LM90_HAVE_LOW
-		  | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
@@ -452,28 +475,30 @@ static const struct lm90_params lm90_params[] = {
 	[max6648] = {
 		.flags = LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_CRIT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_LOW
-		  | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6654] = {
 		.flags = LM90_HAVE_BROKEN_ALERT | LM90_HAVE_ALARMS | LM90_HAVE_LOW
-		  | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6657] = {
 		.flags = LM90_PAUSE_FOR_CONFIG | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
+		  | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6659] = {
 		.flags = LM90_HAVE_EMERGENCY | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
+		  | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
@@ -486,14 +511,16 @@ static const struct lm90_params lm90_params[] = {
 		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_CRIT
 		  | LM90_HAVE_CRIT_ALRM_SWP | LM90_HAVE_BROKEN_ALERT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
+		  | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 	},
 	[max6696] = {
 		.flags = LM90_HAVE_EMERGENCY
 		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
+		  | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x1c7c,
 		.max_convrate = 6,
 		.reg_status2 = MAX6696_REG_STATUS2,
@@ -501,7 +528,8 @@ static const struct lm90_params lm90_params[] = {
 	},
 	[w83l771] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
+		  | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
 	},
@@ -512,7 +540,8 @@ static const struct lm90_params lm90_params[] = {
 		 * be set).
 		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
+		  | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 		.reg_local_ext = SA56004_REG_LOCAL_TEMPL,
@@ -521,7 +550,7 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT
 		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_ALARMS | LM90_HAVE_LOW
-		  | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.resolution = 12,
@@ -530,7 +559,8 @@ static const struct lm90_params lm90_params[] = {
 	[tmp461] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT
-		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE,
+		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
+		  | LM90_HAVE_REMOTE_EXT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.resolution = 12,
@@ -596,6 +626,7 @@ struct lm90_data {
 	u8 max_convrate;	/* Maximum conversion rate */
 	u8 reg_status2;		/* 2nd status register (optional) */
 	u8 reg_local_ext;	/* local extension register offset */
+	u8 reg_remote_ext;	/* remote temperature low byte */
 
 	/* registers values */
 	u16 temp[TEMP_REG_NUM];
@@ -1078,7 +1109,7 @@ static int lm90_update_device(struct device *dev)
 			return val;
 		data->temp[LOCAL_TEMP] = val;
 		val = lm90_read16(client, LM90_REG_REMOTE_TEMPH,
-				  LM90_REG_REMOTE_TEMPL, true);
+				  data->reg_remote_ext, true);
 		if (val < 0)
 			return val;
 		data->temp[REMOTE_TEMP] = val;
@@ -1089,7 +1120,7 @@ static int lm90_update_device(struct device *dev)
 				return val;
 
 			val = lm90_read16(client, LM90_REG_REMOTE_TEMPH,
-					  LM90_REG_REMOTE_TEMPL, true);
+					  data->reg_remote_ext, true);
 			if (val < 0) {
 				lm90_select_remote_channel(data, false);
 				return val;
@@ -1150,6 +1181,9 @@ static int lm90_temp_get_resolution(struct lm90_data *data, int index)
 {
 	switch (index) {
 	case REMOTE_TEMP:
+		if (data->reg_remote_ext)
+			return data->resolution;
+		return 8;
 	case REMOTE_OFFSET:
 	case REMOTE2_TEMP:
 		return data->resolution;
@@ -1558,11 +1592,118 @@ static umode_t lm90_is_visible(const void *data, enum hwmon_sensor_types type,
 	}
 }
 
-/*
- * Per-manufacturer chip detect functions.
- * Functions are expected to return a pointer to the chip name or NULL
- * if detection was not successful.
- */
+static const char *lm90_detect_lm84(struct i2c_client *client)
+{
+	static const u8 regs[] = {
+		LM90_REG_STATUS, LM90_REG_LOCAL_TEMP, LM90_REG_LOCAL_HIGH,
+		LM90_REG_REMOTE_TEMPH, LM90_REG_REMOTE_HIGHH
+	};
+	int status = i2c_smbus_read_byte_data(client, LM90_REG_STATUS);
+	int reg1, reg2, reg3, reg4;
+	bool nonzero = false;
+	u8 ff = 0xff;
+	int i;
+
+	if (status < 0 || (status & 0xab))
+		return NULL;
+
+	/*
+	 * For LM84, undefined registers return the most recent value.
+	 * Repeat several times, each time checking against a different
+	 * (presumably) existing register.
+	 */
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		reg1 = i2c_smbus_read_byte_data(client, regs[i]);
+		reg2 = i2c_smbus_read_byte_data(client, LM90_REG_REMOTE_TEMPL);
+		reg3 = i2c_smbus_read_byte_data(client, LM90_REG_LOCAL_LOW);
+		reg4 = i2c_smbus_read_byte_data(client, LM90_REG_REMOTE_LOWH);
+
+		if (reg1 < 0)
+			return NULL;
+
+		/* If any register has a different value, this is not an LM84 */
+		if (reg2 != reg1 || reg3 != reg1 || reg4 != reg1)
+			return NULL;
+
+		nonzero |= reg1 || reg2 || reg3 || reg4;
+		ff &= reg1;
+	}
+	/*
+	 * If all registers always returned 0 or 0xff, all bets are off,
+	 * and we can not make any predictions about the chip type.
+	 */
+	return nonzero && ff != 0xff ? "lm84" : NULL;
+}
+
+static const char *lm90_detect_max1617(struct i2c_client *client, int config1)
+{
+	int status = i2c_smbus_read_byte_data(client, LM90_REG_STATUS);
+	int llo, rlo, lhi, rhi;
+
+	if (status < 0 || (status & 0x03))
+		return NULL;
+
+	if (config1 & 0x3f)
+		return NULL;
+
+	/*
+	 * Fail if unsupported registers return anything but 0xff.
+	 * The calling code already checked man_id and chip_id.
+	 * A byte read operation repeats the most recent read operation
+	 * and should also return 0xff.
+	 */
+	if (i2c_smbus_read_byte_data(client, LM90_REG_REMOTE_TEMPL) != 0xff ||
+	    i2c_smbus_read_byte_data(client, MAX6657_REG_LOCAL_TEMPL) != 0xff ||
+	    i2c_smbus_read_byte_data(client, LM90_REG_REMOTE_LOWL) != 0xff ||
+	    i2c_smbus_read_byte(client) != 0xff)
+		return NULL;
+
+	llo = i2c_smbus_read_byte_data(client, LM90_REG_LOCAL_LOW);
+	rlo = i2c_smbus_read_byte_data(client, LM90_REG_REMOTE_LOWH);
+
+	lhi = i2c_smbus_read_byte_data(client, LM90_REG_LOCAL_HIGH);
+	rhi = i2c_smbus_read_byte_data(client, LM90_REG_REMOTE_HIGHH);
+
+	if (llo < 0 || rlo < 0)
+		return NULL;
+
+	/*
+	 * A byte read operation repeats the most recent read and should
+	 * return the same value.
+	 */
+	if (i2c_smbus_read_byte(client) != rhi)
+		return NULL;
+
+	/*
+	 * The following two checks are marginal since the checked values
+	 * are strictly speaking valid.
+	 */
+
+	/* fail for negative high limits; this also catches read errors */
+	if ((s8)lhi < 0 || (s8)rhi < 0)
+		return NULL;
+
+	/* fail if low limits are larger than or equal to high limits */
+	if ((s8)llo >= lhi || (s8)rlo >= rhi)
+		return NULL;
+
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
+		/*
+		 * Word read operations return 0xff in second byte
+		 */
+		if (i2c_smbus_read_word_data(client, LM90_REG_REMOTE_TEMPL) !=
+						0xffff)
+			return NULL;
+		if (i2c_smbus_read_word_data(client, LM90_REG_CONFIG1) !=
+						(config1 | 0xff00))
+			return NULL;
+		if (i2c_smbus_read_word_data(client, LM90_REG_LOCAL_HIGH) !=
+						(lhi | 0xff00))
+			return NULL;
+	}
+
+	return "max1617";
+}
 
 static const char *lm90_detect_national(struct i2c_client *client, int chip_id,
 					int config1, int convrate)
@@ -1712,10 +1853,29 @@ static const char *lm90_detect_maxim(struct i2c_client *client, bool common_addr
 		 * The chip_id register of the MAX6680 and MAX6681 holds the
 		 * revision of the chip. The lowest bit of the config1 register
 		 * is unused and should return zero when read, so should the
-		 * second to last bit of config1 (software reset).
+		 * second to last bit of config1 (software reset). Register
+		 * address 0x12 (LM90_REG_REMOTE_OFFSL) exists for this chip and
+		 * should differ from emerg2, and emerg2 should match man_id
+		 * since it does not exist.
 		 */
-		else if (!(config1 & 0x03) && convrate <= 0x07)
+		else if (!(config1 & 0x03) && convrate <= 0x07 &&
+			 emerg2 == man_id && emerg2 != status2)
 			name = "max6680";
+		/*
+		 * MAX1617A does not have any extended registers (register
+		 * address 0x10 or higher) except for manufacturer and
+		 * device ID registers. Unlike other chips of this series,
+		 * unsupported registers were observed to return a fixed value
+		 * of 0x01.
+		 * Note: Multiple chips with different markings labeled as
+		 * "MAX1617" (no "A") were observed to report manufacturer ID
+		 * 0x4d and device ID 0x01. It is unknown if other variants of
+		 * MAX1617/MAX617A with different behavior exist. The detection
+		 * code below works for those chips.
+		 */
+		else if (!(config1 & 0x03f) && convrate <= 0x07 &&
+			 emerg == 0x01 && emerg2 == 0x01 && status2 == 0x01)
+			name = "max1617";
 		break;
 	case 0x08:
 		/*
@@ -1961,7 +2121,7 @@ static const char *lm90_detect_ti(struct i2c_client *client, int chip_id,
 static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	int man_id, chip_id, config1, convrate;
+	int man_id, chip_id, config1, convrate, lhigh;
 	const char *name = NULL;
 	int address = client->addr;
 	bool common_address =
@@ -1972,15 +2132,43 @@ static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
+	/*
+	 * Get well defined register value for chips with neither man_id nor
+	 * chip_id registers.
+	 */
+	lhigh = i2c_smbus_read_byte_data(client, LM90_REG_LOCAL_HIGH);
+
 	/* detection and identification */
 	man_id = i2c_smbus_read_byte_data(client, LM90_REG_MAN_ID);
 	chip_id = i2c_smbus_read_byte_data(client, LM90_REG_CHIP_ID);
 	config1 = i2c_smbus_read_byte_data(client, LM90_REG_CONFIG1);
 	convrate = i2c_smbus_read_byte_data(client, LM90_REG_CONVRATE);
-	if (man_id < 0 || chip_id < 0 || config1 < 0 || convrate < 0)
+	if (man_id < 0 || chip_id < 0 || config1 < 0 || convrate < 0 || lhigh < 0)
 		return -ENODEV;
 
+	/* Bail out immediately if all register report the same value */
+	if (lhigh == man_id && lhigh == chip_id && lhigh == config1 && lhigh == convrate)
+		return -ENODEV;
+
+	/*
+	 * If reading man_id and chip_id both return the same value as lhigh,
+	 * the chip may not support those registers and return the most recent read
+	 * value. Check again with a different register and handle accordingly.
+	 */
+	if (man_id == lhigh && chip_id == lhigh) {
+		convrate = i2c_smbus_read_byte_data(client, LM90_REG_CONVRATE);
+		man_id = i2c_smbus_read_byte_data(client, LM90_REG_MAN_ID);
+		chip_id = i2c_smbus_read_byte_data(client, LM90_REG_CHIP_ID);
+		if (convrate < 0 || man_id < 0 || chip_id < 0)
+			return -ENODEV;
+		if (man_id == convrate && chip_id == convrate)
+			man_id = -1;
+	}
 	switch (man_id) {
+	case -1:	/* Chip does not support man_id / chip_id */
+		if (common_address && !convrate && !(config1 & 0x7f))
+			name = lm90_detect_lm84(client);
+		break;
 	case 0x01:	/* National Semiconductor */
 		name = lm90_detect_national(client, chip_id, config1, convrate);
 		break;
@@ -2003,6 +2191,10 @@ static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
 	case 0xa1:	/*  NXP Semiconductor/Philips */
 		name = lm90_detect_nxp(client, chip_id, config1, convrate);
 		break;
+	case 0xff:	/* MAX1617, G767, NE1617 */
+		if (common_address && chip_id == 0xff && convrate < 8)
+			name = lm90_detect_max1617(client, config1);
+		break;
 	default:
 		break;
 	}
@@ -2263,6 +2455,8 @@ static int lm90_probe(struct i2c_client *client)
 	}
 
 	data->reg_local_ext = lm90_params[data->kind].reg_local_ext;
+	if (data->flags & LM90_HAVE_REMOTE_EXT)
+		data->reg_remote_ext = LM90_REG_REMOTE_TEMPL;
 	data->reg_status2 = lm90_params[data->kind].reg_status2;
 
 	/* Set maximum conversion rate */
-- 
2.35.1

