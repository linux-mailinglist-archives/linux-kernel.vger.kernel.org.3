Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B5C533EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244689AbiEYOCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbiEYN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:33 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14588AEE32;
        Wed, 25 May 2022 06:58:59 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-f2a4c51c45so5075441fac.9;
        Wed, 25 May 2022 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PPew1VM41xxNGE+qDgXPgSNgmsal/QTwCvqXDhBfHZs=;
        b=mO7KiIxyOAqn6dba0565pUUarXvLH4mEF9vHL5idhvPoZ25Q755Axhpot89kFdh9XD
         XAzURRoEt5WboDo7GuSW8YTcps429sKuPCIpVMlTnnnp2jopdtM87kAV9esxjwVZsMGo
         e+n9RqBk1FFRXMhGkBDvFVxFl3bXK/gUoGykZRIoyo9qlzuk0scAQahohIBaPhQ4M/wn
         2MGBpuhK23FK3teoU6ZLTpbTs8bgUtJY5HPKbDz7sMnVRA+w/3HC0Wb4X/Zr16cNIp8v
         QxMmzfv9b4X0Ay11eo6V2o+oBtSC8OVjGKA2rKOueTiHFexDxtAsKfJTNTlOxZY00RX3
         gGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PPew1VM41xxNGE+qDgXPgSNgmsal/QTwCvqXDhBfHZs=;
        b=NxjZdOzHl669FtHjQPs3pQGTHEs6EGkNMJubFwQEIFQnt6JIHjNGV4ux19EwLghcPu
         3kuRtJNRq23yvkzto3Fp6ipwp9Q+W64FJlTAUTuj0wjoFNGMqQWgkG6j234uVVnD24+Z
         JKaUG6hBxluWtf5wzkYvZCLhqCvRUXEYwilwWaMxSNoAQ1fVEsBbETKOREzqctOgcRDI
         bT028x+D9KRZzcu/7Af+O5z6TgKbjJ+enHdXFn4g7dknXeWncIE7SPd/yjriDUxf9VmJ
         UZ1Joz+HqBRqGePjbklDy82wPyzd36JXkejdMMg3PbyjE5Q+oa0eO5od57phDLEdK/e0
         EpVQ==
X-Gm-Message-State: AOAM530SezkidYAc94nTufPtR7QWig1FtpTSZfiWHJfOwislpOZuyjGU
        9gJd73mO41C+USQKniMY9wW1hZd25gBGHA==
X-Google-Smtp-Source: ABdhPJy44reUgxpnPhwKQnRDMnUOrcnOzAMez2ZdHc+3DM2niZOT1sVoa2sQMOJdRMU04ypVAnteHw==
X-Received: by 2002:a05:6870:e3c1:b0:d7:2dc8:7fd0 with SMTP id y1-20020a056870e3c100b000d72dc87fd0mr5715140oad.104.1653487138159;
        Wed, 25 May 2022 06:58:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h16-20020a9d6010000000b0060603221247sm6180119otj.23.2022.05.25.06.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 30/40] hwmon: (lm90) Add remaining chips supported by adm1021 driver
Date:   Wed, 25 May 2022 06:57:48 -0700
Message-Id: <20220525135758.2944744-31-linux@roeck-us.net>
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

All chips supported by the ADM1021 driver are also supported by the LM90
driver. Make that support official.

After this change, the adm1021 driver is only needed if the lm90 driver
is disabled. Also, the adm1021 driver misdetects a variety of chips as
MAX1617A, which is unwanted if any of those chips is in the system.
For this reason. make the adm1021 driver dependent on !SENSORS_LM90 to
show that it is not needed if the lm90 driver is enabled, and to avoid
misdetection if a chip supported by the lm90 driver is in the system.

Devicetree nodes are not added for the added chips since it is quite
unlikely that such old chips will ever be used in a devicetree based
system. They can be added later if needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst | 34 +++++++++++++++++++++++++++++++++-
 drivers/hwmon/Kconfig        |  1 +
 drivers/hwmon/lm90.c         | 26 ++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index 699ac963722b..dfbdfe11606e 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -355,6 +355,38 @@ Supported chips:
 
 	       https://www.ti.com/lit/gpn/tmp461
 
+  * Philips NE1617, NE1617A
+
+    Prefix: 'max1617' (probably detected as a max1617)
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheets: Publicly available at the Philips website
+
+  * Genesys Logic GL523SM
+
+    Prefix: 'gl523sm'
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheet:
+
+  * TI THMC10
+
+    Prefix: 'thmc10'
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheet: Publicly available at the TI website
+
+  * Onsemi MC1066
+
+    Prefix: 'mc1066'
+
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+
+    Datasheet: Publicly available at the Onsemi website
+
 Author: Jean Delvare <jdelvare@suse.de>
 
 
@@ -385,7 +417,7 @@ features:
 LM84:
   * 8 bit sensor resolution
 
-ADM1021, MAX1617:
+ADM1021, GL523SM, MAX1617, NE1617, NE1617A, THMC10:
   * 8 bit sensor resolution
   * Low temperature limits
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 50fa255b1e3c..bb952287fcee 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -100,6 +100,7 @@ config SENSORS_AD7418
 config SENSORS_ADM1021
 	tristate "Analog Devices ADM1021 and compatibles"
 	depends on I2C
+	depends on SENSORS_LM90=n
 	help
 	  If you say yes here you get support for Analog Devices ADM1021
 	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 40c012bc6ca6..97453a7de1fa 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -233,6 +233,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "adt7482", adt7481 },
 	{ "adt7483a", adt7481 },
 	{ "g781", g781 },
+	{ "gl523sm", max1617 },
 	{ "lm84", lm84 },
 	{ "lm86", lm86 },
 	{ "lm89", lm86 },
@@ -254,9 +255,11 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "max6692", max6648 },
 	{ "max6695", max6696 },
 	{ "max6696", max6696 },
+	{ "mc1066", max1617 },
 	{ "nct1008", adt7461a },
 	{ "w83l771", w83l771 },
 	{ "sa56004", sa56004 },
+	{ "thmc10", max1617 },
 	{ "tmp451", tmp451 },
 	{ "tmp461", tmp461 },
 	{ }
@@ -2125,6 +2128,18 @@ static const char *lm90_detect_gmt(struct i2c_client *client, int chip_id,
 	return NULL;
 }
 
+static const char *lm90_detect_ti49(struct i2c_client *client, bool common_address,
+				    int chip_id, int config1, int convrate)
+{
+	if (common_address && chip_id == 0x00 && !(config1 & 0x3f) && !(convrate & 0xf8)) {
+		/* THMC10: Unsupported registers return 0xff */
+		if (i2c_smbus_read_byte_data(client, LM90_REG_REMOTE_TEMPL) == 0xff &&
+		    i2c_smbus_read_byte_data(client, LM90_REG_REMOTE_CRIT) == 0xff)
+			return "thmc10";
+	}
+	return NULL;
+}
+
 static const char *lm90_detect_ti(struct i2c_client *client, int chip_id,
 				  int config1, int convrate)
 {
@@ -2208,6 +2223,10 @@ static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
 	case 0x01:	/* National Semiconductor */
 		name = lm90_detect_national(client, chip_id, config1, convrate);
 		break;
+	case 0x23:	/* Genesys Logic */
+		if (common_address && !(config1 & 0x3f) && !(convrate & 0xf8))
+			name = "gl523sm";
+		break;
 	case 0x41:	/* Analog Devices */
 		name = lm90_detect_analog(client, common_address, chip_id, config1,
 					  convrate);
@@ -2215,10 +2234,17 @@ static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
 	case 0x47:	/* GMT */
 		name = lm90_detect_gmt(client, chip_id, config1, convrate);
 		break;
+	case 0x49:	/* TI */
+		name = lm90_detect_ti49(client, common_address, chip_id, config1, convrate);
+		break;
 	case 0x4d:	/* Maxim Integrated */
 		name = lm90_detect_maxim(client, common_address, chip_id,
 					 config1, convrate);
 		break;
+	case 0x54:	/* ON MC1066, Microchip TC1068, TCM1617 (originally TelCom) */
+		if (common_address && !(config1 & 0x3f) && !(convrate & 0xf8))
+			name = "mc1066";
+		break;
 	case 0x55:	/* TI */
 		name = lm90_detect_ti(client, chip_id, config1, convrate);
 		break;
-- 
2.35.1

