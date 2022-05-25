Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F608533EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbiEYOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244755AbiEYN7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:35 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDD9AF1D3;
        Wed, 25 May 2022 06:59:02 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-f2ccb58ee0so517615fac.1;
        Wed, 25 May 2022 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fFT6p8IiTrtfXjZmv5UVaPsu1wy8wO96VfaZ9u+Bhg=;
        b=W/hC+1+ed+bHrtxH/RPsNJq32dhVN1zNRe5ClqI+gopzW5IFSdW1hC22TAWuowOxXz
         wJjH1J5srT/zh/Cb0hcvDd8p6OMqK+oYILehw3CAJjfG3SH8BWTdnRPNR5SMKnFmthjU
         Glocd5grZddnLVJBG8lLeUIaVD7ZcAxR84mfW3ym9dcEUlunHoHKNcsRCyONpo6r7kUw
         uZ/nMk3AfdxGviI5tx1PGS5RyTPuNBUOt+6BlCTmLqOR9/Ho0mXKywDJhj/vKTAd5cwp
         QEir3bN6LxsVOIJ1ht5opJl1As78HCcETpB8NzNNadBpleWptAd5r5GY6dKh0SlJd3+0
         loLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+fFT6p8IiTrtfXjZmv5UVaPsu1wy8wO96VfaZ9u+Bhg=;
        b=4OYZf6W4Wzr0GIByokH1jfj3mIOIykG7K54nqJYwrSkIUiFu2Uh33ScGr4IS2PZyT7
         ckZuVTh8AYy7xR8qD9qHOc78jTUb9umoutxju3NqUtiMWPqlD5Sj2CaHhoX7uc/rfYey
         XO7EW5VUYX9fylnNFDbD+b7+Ff4jzSh0zgmCYFqqwLPflUDcYeflLQThF4S4cwMBX2IX
         MbURMvodkJXQctf1i2tgayCZK9t9459W5VFN2X42AX2gMlcUQyN3kOaRHBMHukIa873R
         U81CL9/NwRJn/j7uBt67cwcPoscnDjsKxzyaBLdcYIVcVqyIi+L3JSoenXgNMINsh5cI
         mNqQ==
X-Gm-Message-State: AOAM530R31mq8BVh7DW/b/GKnBZ5J6dd3JjZFgC0gtTgQZEzT3EbxK+X
        +zr3bcDjAcIx/G/EgC26+gzlbRVXLPZQBw==
X-Google-Smtp-Source: ABdhPJxGtgCgCT/ut6BayUViRl1spzvRGOa5PZtb6oW6d8FJ26nOe82zEMk1NeialTxBbtWW6fv1SQ==
X-Received: by 2002:a05:6870:310d:b0:da:f5e5:5b5b with SMTP id v13-20020a056870310d00b000daf5e55b5bmr5639283oaa.297.1653487141889;
        Wed, 25 May 2022 06:59:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8-20020a9d0688000000b0060ae5f10973sm6084750otx.15.2022.05.25.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:59:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 32/40] hwmon: (lm90) Add explicit support for NCT210
Date:   Wed, 25 May 2022 06:57:50 -0700
Message-Id: <20220525135758.2944744-33-linux@roeck-us.net>
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

Unlike ADM1023 and compatible chips, NCT210 does not support a temperature
offset register. A real chip was found to have a chip revision of 0x3f.
Use it to detect NCT210 explicitly.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst | 14 ++++++++++++++
 drivers/hwmon/Kconfig        |  2 +-
 drivers/hwmon/lm90.c         | 18 ++++++++++++++++--
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index dfbdfe11606e..e9a8c11eba8b 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -137,6 +137,16 @@ Supported chips:
 
 	       https://www.onsemi.com/PowerSolutions/product.do?id=NCT1008
 
+  * ON Semiconductor NCT210
+
+    Prefix: 'adm1021'
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheet: Publicly available at the ON Semiconductor website
+
+	       https://www.onsemi.com/PowerSolutions/product.do?id=NCT210
+
   * Maxim MAX1617
 
     Prefix: 'max1617'
@@ -421,6 +431,10 @@ ADM1021, GL523SM, MAX1617, NE1617, NE1617A, THMC10:
   * 8 bit sensor resolution
   * Low temperature limits
 
+NCT210:
+  * 11 bit sensor resolution for remote temperature sensor
+  * Low temperature limits
+
 ADM1021A, ADM1023:
   * Temperature offset register for remote temperature sensor
   * 11 bit resolution for remote temperature sensor
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index bb952287fcee..d30ea2fea3e2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1365,7 +1365,7 @@ config SENSORS_LM90
 	  Maxim MAX1617, MAX6642, MAX6646, MAX6647, MAX6648, MAX6649, MAX6654,
 	  MAX6657, MAX6658, MAX6659, MAX6680, MAX6681, MAX6692, MAX6695,
 	  MAX6696,
-	  ON Semiconductor NCT1008, Winbond/Nuvoton W83L771W/G/AWG/ASG,
+	  ON Semiconductor NCT1008, NCT210, Winbond/Nuvoton W83L771W/G/AWG/ASG,
 	  Philips SA56004, GMT G781, Texas Instruments TMP451 and TMP461
 	  sensor chips.
 
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 16481051a530..4ae8027722e0 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -125,7 +125,7 @@ static const unsigned short normal_i2c[] = {
 enum chips { adm1023, adm1032, adt7461, adt7461a, adt7481,
 	g781, lm84, lm90, lm99,
 	max1617, max6642, max6646, max6648, max6654, max6657, max6659, max6680, max6696,
-	sa56004, tmp451, tmp461, w83l771,
+	nct210, sa56004, tmp451, tmp461, w83l771,
 };
 
 /*
@@ -257,6 +257,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "max6696", max6696 },
 	{ "mc1066", max1617 },
 	{ "nct1008", adt7461a },
+	{ "nct210", nct210 },
 	{ "w83l771", w83l771 },
 	{ "sa56004", sa56004 },
 	{ "thmc10", max1617 },
@@ -533,6 +534,14 @@ static const struct lm90_params lm90_params[] = {
 		.reg_status2 = MAX6696_REG_STATUS2,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
+	[nct210] = {
+		.flags = LM90_HAVE_ALARMS | LM90_HAVE_BROKEN_ALERT
+		  | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
+		  | LM90_HAVE_REMOTE_EXT,
+		.alert_alarms = 0x7c,
+		.resolution = 11,
+		.max_convrate = 7,
+	},
 	[w83l771] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT
 		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
@@ -1766,7 +1775,7 @@ static const char *lm90_detect_analog(struct i2c_client *client, bool common_add
 		    !(status & 0x03) && !(config1 & 0x3f) && !(convrate & 0xf8))
 			name = "adm1021";
 		break;
-	case 0x30 ... 0x3f:	/* ADM1021A, ADM1023 */
+	case 0x30 ... 0x3e:	/* ADM1021A, ADM1023 */
 		/*
 		 * ADM1021A and compatible chips will be mis-detected as
 		 * ADM1023. Chips labeled 'ADM1021A' and 'ADM1023' were both
@@ -1784,6 +1793,11 @@ static const char *lm90_detect_analog(struct i2c_client *client, bool common_add
 		    !(status & 0x03) && !(config1 & 0x3f) && !(convrate & 0xf8))
 			name = "adm1023";
 		break;
+	case 0x3f:		/* NCT210 */
+		if (man_id2 == 0x00 && chip_id2 == 0x00 && common_address &&
+		    !(status & 0x03) && !(config1 & 0x3f) && !(convrate & 0xf8))
+			name = "nct210";
+		break;
 	case 0x40 ... 0x4f:	/* ADM1032 */
 		if (man_id2 == 0x00 && chip_id2 == 0x00 &&
 		    (address == 0x4c || address == 0x4d) && !(config1 & 0x3f) &&
-- 
2.35.1

