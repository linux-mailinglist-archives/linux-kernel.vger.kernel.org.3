Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B69C533EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbiEYOC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244846AbiEYOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:00:12 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30506AFACA;
        Wed, 25 May 2022 06:59:14 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 30-20020a9d0121000000b0060ae97b9967so11329369otu.7;
        Wed, 25 May 2022 06:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vMz1kX25Jfo/Wgl2AsnsPe1M/xiRh78iJYf0iREBtKQ=;
        b=AXluDQX1JURladUQ5YTDNoDqSbbTrj2ZXKtAHJQQqZm8QYCC8xWPwV8Yjzg/yyuHYD
         cN8CoTuIgKkOH1zsaSAlZ3Fz4E2E4c4uNNuuZbNoju0EquZYrH3UbL9Zl8me2W+qnPs6
         GD5C1wrWuw3MJ1olnPGKQSdgB8/CdnAxc+IWC4r2Fw6o8u9UqvDfJP8YgYzJlRmgLFpz
         01b+tjvuvs4sG67ctuf+cnC+ewi6XmruSMNeAd+F4RoIMZ+4oTljLgPfEwQ71be3s77+
         gaT3D91BgpF5bO29NnL2v2oVimFP/I+R2Lpbl68Udv/aso56fliGfSsZ4KH+G+OadinI
         VI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vMz1kX25Jfo/Wgl2AsnsPe1M/xiRh78iJYf0iREBtKQ=;
        b=xNcvG4ks2l+GbVrOUUm5dQYp7uQlSxgK+jUQ43rHFW4zCsafGFGC2GYoIs9qRjQh5Z
         ZxYTClGwK0Xs41JdgJiLpTseMMJj51i1oibjr+vR65y1yRD5POe4v4e8gSYrePmpEW8J
         lUiHgdvwFW6qzaG4aAzJvRFYTnmoZG6s1EzOKQn1r33TztwA+IOSOdgCCohxUERgj2lg
         PUacO/5x83Et2r99NDly04C3kokdnJo44puoSa51VsjX8LgrLhkANdaLuwKo/oc0oZAz
         LOgK1Vto92Jv0EsbG3NRK/erGOWQK8cIw1TOx8U6xX3hqoO+7mdiuVrxTYIE5icDYutM
         wALg==
X-Gm-Message-State: AOAM5310PUZCik6mv6OGkFO0B2SgondPGrkv0xwl4BW/7J7QmVDFf1F+
        hkIUAdSvZfg+p5a4eiMOGUNkLkn3rgv7Kw==
X-Google-Smtp-Source: ABdhPJw9heiaMO+NWdE2NiCJyW57unM1eLa2AW4b+mMuv07yqsuoSZ9cLRktcSvyrnSvWOgYmQTToQ==
X-Received: by 2002:a05:6830:2b2b:b0:606:56e4:9d5b with SMTP id l43-20020a0568302b2b00b0060656e49d5bmr12782663otv.320.1653487151208;
        Wed, 25 May 2022 06:59:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o7-20020a4abe87000000b0035eb4e5a6c0sm6516251oop.22.2022.05.25.06.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:59:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 37/40] hwmon: (lm90) Add explicit support for ADM1020
Date:   Wed, 25 May 2022 06:57:55 -0700
Message-Id: <20220525135758.2944744-38-linux@roeck-us.net>
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

ADM1020 is compatible with ADM1021 but has a separate chip revision and
a limited I2C address range.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst | 10 +++++++++-
 drivers/hwmon/Kconfig        |  4 ++--
 drivers/hwmon/lm90.c         | 10 +++++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index c3ce54f61f44..b2ca10f37218 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -51,6 +51,14 @@ Supported chips:
 
 	       http://www.national.com/mpf/LM/LM86.html
 
+  * Analog Devices ADM1020
+
+    Prefix: 'adm1020'
+
+    Addresses scanned: I2C 0x4c - 0x4e
+
+    Datasheet: Publicly available at the Analog Devices website
+
   * Analog Devices ADM1021
 
     Prefix: 'adm1021'
@@ -457,7 +465,7 @@ features:
 LM84:
   * 8 bit sensor resolution
 
-ADM1021, GL523SM, MAX1617, NE1617, NE1617A, THMC10:
+ADM1020, ADM1021, GL523SM, MAX1617, NE1617, NE1617A, THMC10:
   * 8 bit sensor resolution
   * Low temperature limits
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 32c605eaec7e..494539e4be3d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1360,8 +1360,8 @@ config SENSORS_LM90
 	depends on I2C
 	help
 	  If you say yes here you get support for National Semiconductor LM84,
-	  LM90, LM86, LM89 and LM99, Analog Devices ADM2021, ADM1021A, ADM1023,
-	  ADM1032, ADT7461, ADT7461A, ADT7481, ADT7482, and ADT7483A,
+	  LM90, LM86, LM89 and LM99, Analog Devices ADM1020, ADM2021, ADM1021A,
+	  ADM1023, ADM1032, ADT7461, ADT7461A, ADT7481, ADT7482, and ADT7483A,
 	  Maxim MAX1617, MAX6642, MAX6646, MAX6647, MAX6648, MAX6649, MAX6654,
 	  MAX6657, MAX6658, MAX6659, MAX6680, MAX6681, MAX6692, MAX6695,
 	  MAX6696,
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 6d1e7052e3ed..de51d205b63f 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -228,6 +228,7 @@ enum chips { adm1023, adm1032, adt7461, adt7461a, adt7481,
  */
 
 static const struct i2c_device_id lm90_id[] = {
+	{ "adm1020", max1617 },
 	{ "adm1021", max1617 },
 	{ "adm1023", adm1023 },
 	{ "adm1032", adm1032 },
@@ -1829,7 +1830,8 @@ static const char *lm90_detect_analog(struct i2c_client *client, bool common_add
 		    (config1 & 0x0b) == 0x08 && convrate <= 0x0a)
 			name = "adt7421";
 		break;
-	case 0x30 ... 0x3e:	/* ADM1021A, ADM1023 */
+	case 0x30 ... 0x38:	/* ADM1021A, ADM1023 */
+	case 0x3a ... 0x3e:
 		/*
 		 * ADM1021A and compatible chips will be mis-detected as
 		 * ADM1023. Chips labeled 'ADM1021A' and 'ADM1023' were both
@@ -1847,6 +1849,12 @@ static const char *lm90_detect_analog(struct i2c_client *client, bool common_add
 		    !(status & 0x03) && !(config1 & 0x3f) && !(convrate & 0xf8))
 			name = "adm1023";
 		break;
+	case 0x39:		/* ADM1020 (undocumented) */
+		if (man_id2 == 0x00 && chip_id2 == 0x00 &&
+		    (address == 0x4c || address == 0x4d || address == 0x4e) &&
+		    !(status & 0x03) && !(config1 & 0x3f) && !(convrate & 0xf8))
+			name = "adm1020";
+		break;
 	case 0x3f:		/* NCT210 */
 		if (man_id2 == 0x00 && chip_id2 == 0x00 && common_address &&
 		    !(status & 0x03) && !(config1 & 0x3f) && !(convrate & 0xf8))
-- 
2.35.1

