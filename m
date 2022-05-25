Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC91533EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244323AbiEYOCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244633AbiEYN7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F970AF1ED;
        Wed, 25 May 2022 06:59:05 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id i66so25076519oia.11;
        Wed, 25 May 2022 06:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4qJbHRCQPSjBqmK7IyBTGSJJ7jfGY+55bbNWV5rLWc=;
        b=ZDsdXXX1OCZVXzxtOQPrlsLQI+15s+3208Dx84CLJjGn2bbIVFLsmcJX0T9vO3UyVZ
         HXfyvU3M2KRFg8F6kaR0ZjSNFbdICATrNFyjK2h+7a1ITFMubiljNfzoDPM800mIBaA2
         l5aqNG2XklwB4RGnD79FYQUaK5iAKUgtDWUsb8oaZwLhGGTHEeqvdrmRchonTP37FRdy
         yjXVHEOkHwdpbu4oUqtD05kJozfRm89HgmdV2ZrYafkgN5LcEmFe0UrzMsAOsX9vdpjc
         beT8pcT+P/0pIQgERXhKjgxLpZlP/tMKKhZM4nqcQSpln7gK1yGI03D9yC7kkI2xbrMu
         2H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=l4qJbHRCQPSjBqmK7IyBTGSJJ7jfGY+55bbNWV5rLWc=;
        b=2ABwfrwQtzEIyR8B5xEl5k14y0kcVysuwBOJiWd+KcE2Tdv6gIio7lvM8kRhSf2xNZ
         U+Dnbo5LVU0feglZtsWELHpYK1vFex6V3XxJxoUcVAiQDitv3f3cN4LMpZRntEYsf2U5
         /KR+eBIH0Selb7MJYT4wljG/TGor0XO/ROXS865tq1WIrcQyS6kCF7epVvdEACsok2JE
         pYf29AJpZQQBNXal44cvjNPFBdZRfBtBe4rgWLO+dNIFY7UCgVFGKn4Dk87162bkC4OJ
         RTVMRSFoFJW3sqivoE8xJH6+41nFg1r2GaoBLNRJxEe8bj0QBKCIIg0tEldRUAUA9K1r
         iZ9Q==
X-Gm-Message-State: AOAM533sNaAuTsPS6SS4h4Vp7/y6nBxZyVvDsMi/ZI0FmlZ1zATfPsDq
        ka3EGrTQehkGXqWu3Cz4V12KY/ucUihE2g==
X-Google-Smtp-Source: ABdhPJwhhtInHOR4Wb6kVkM7Ld7zK9Z6f/SUiZnE94qFodIGHyUylJjh3sfdS8//qImV9/Rp+99S8g==
X-Received: by 2002:a05:6808:2388:b0:32b:14cf:ad6c with SMTP id bp8-20020a056808238800b0032b14cfad6cmr5262064oib.100.1653487143840;
        Wed, 25 May 2022 06:59:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p187-20020acabfc4000000b0032b4ae1fc2csm3147976oif.21.2022.05.25.06.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:59:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 33/40] hwmon: (lm90) Add support for ON Semiconductor NCT214 and NCT72
Date:   Wed, 25 May 2022 06:57:51 -0700
Message-Id: <20220525135758.2944744-34-linux@roeck-us.net>
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

NCT214 and NCT72 are compatible to ADT7461/ADT7461A but have full
PEC (packet error checking) support. PEC support is undocumented.

Both chips support the undocumented secondary chip and manufacturer
ID registers at 0x3e and 0x3f, and return 0x61 as chip ID. Use this
information to improve the accuracy of chip detection code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst | 20 ++++++++++++++++++++
 drivers/hwmon/Kconfig        |  3 ++-
 drivers/hwmon/lm90.c         | 35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index e9a8c11eba8b..d3836d1f1275 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -147,6 +147,26 @@ Supported chips:
 
 	       https://www.onsemi.com/PowerSolutions/product.do?id=NCT210
 
+  * ON Semiconductor NCT214
+
+    Prefix: 'nct214'
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheet: Publicly available at the ON Semiconductor website
+
+	       https://www.onsemi.com/PowerSolutions/product.do?id=NCT214
+
+  * ON Semiconductor NCT72
+
+    Prefix: 'nct72'
+
+    Addresses scanned: I2C 0x4c - 0x4d
+
+    Datasheet: Publicly available at the ON Semiconductor website
+
+	       https://www.onsemi.com/PowerSolutions/product.do?id=NCT72
+
   * Maxim MAX1617
 
     Prefix: 'max1617'
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d30ea2fea3e2..9353d207f254 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1365,7 +1365,8 @@ config SENSORS_LM90
 	  Maxim MAX1617, MAX6642, MAX6646, MAX6647, MAX6648, MAX6649, MAX6654,
 	  MAX6657, MAX6658, MAX6659, MAX6680, MAX6681, MAX6692, MAX6695,
 	  MAX6696,
-	  ON Semiconductor NCT1008, NCT210, Winbond/Nuvoton W83L771W/G/AWG/ASG,
+	  ON Semiconductor NCT1008, NCT210, NCT72, NCT214,
+	  Winbond/Nuvoton W83L771W/G/AWG/ASG,
 	  Philips SA56004, GMT G781, Texas Instruments TMP451 and TMP461
 	  sensor chips.
 
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 4ae8027722e0..2a1630b85967 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -69,6 +69,9 @@
  * / ON Semiconductor. The chips are similar to ADT7461 but support two external
  * temperature sensors.
  *
+ * This driver also supports NCT72 and NCT214 from ON Semiconductor. The chips
+ * are similar to ADT7461/ADT7461A but have full PEC support (undocumented).
+ *
  * This driver also supports the SA56004 from Philips. This device is
  * pin-compatible with the LM86, the ED/EDP parts are also address-compatible.
  *
@@ -125,7 +128,7 @@ static const unsigned short normal_i2c[] = {
 enum chips { adm1023, adm1032, adt7461, adt7461a, adt7481,
 	g781, lm84, lm90, lm99,
 	max1617, max6642, max6646, max6648, max6654, max6657, max6659, max6680, max6696,
-	nct210, sa56004, tmp451, tmp461, w83l771,
+	nct210, nct72, sa56004, tmp451, tmp461, w83l771,
 };
 
 /*
@@ -258,6 +261,8 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "mc1066", max1617 },
 	{ "nct1008", adt7461a },
 	{ "nct210", nct210 },
+	{ "nct214", nct72 },
+	{ "nct72", nct72 },
 	{ "w83l771", w83l771 },
 	{ "sa56004", sa56004 },
 	{ "thmc10", max1617 },
@@ -348,6 +353,14 @@ static const struct of_device_id __maybe_unused lm90_of_match[] = {
 		.compatible = "onnn,nct1008",
 		.data = (void *)adt7461a
 	},
+	{
+		.compatible = "onnn,nct214",
+		.data = (void *)nct72
+	},
+	{
+		.compatible = "onnn,nct72",
+		.data = (void *)nct72
+	},
 	{
 		.compatible = "winbond,w83l771",
 		.data = (void *)w83l771
@@ -534,6 +547,15 @@ static const struct lm90_params lm90_params[] = {
 		.reg_status2 = MAX6696_REG_STATUS2,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
+	[nct72] = {
+		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
+		  | LM90_HAVE_CRIT | LM90_HAVE_PEC | LM90_HAVE_UNSIGNED_TEMP
+		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
+		.alert_alarms = 0x7c,
+		.max_convrate = 10,
+		.resolution = 10,
+	},
 	[nct210] = {
 		.flags = LM90_HAVE_ALARMS | LM90_HAVE_BROKEN_ALERT
 		  | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
@@ -1816,12 +1838,23 @@ static const char *lm90_detect_analog(struct i2c_client *client, bool common_add
 		    convrate <= 0x0a)
 			name = "nct1008";
 		break;
+	case 0x55:	/* NCT72 */
+		if (man_id2 == 0x41 && chip_id2 == 0x61 &&
+		    (address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
+		    convrate <= 0x0a)
+			name = "nct72";
+		break;
 	case 0x57:	/* ADT7461A, NCT1008 (datasheet rev. 3) */
 		if (man_id2 == 0x41 && chip_id2 == 0x61 &&
 		    (address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
 		    convrate <= 0x0a)
 			name = "adt7461a";
 		break;
+	case 0x5a:	/* NCT214 */
+		if (man_id2 == 0x41 && chip_id2 == 0x61 &&
+		    common_address && !(config1 & 0x1b) && convrate <= 0x0a)
+			name = "nct214";
+		break;
 	case 0x62:	/* ADT7481, undocumented */
 		if (man_id2 == 0x41 && chip_id2 == 0x81 &&
 		    (address == 0x4b || address == 0x4c) && !(config1 & 0x10) &&
-- 
2.35.1

