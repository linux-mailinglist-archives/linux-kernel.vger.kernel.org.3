Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC709533EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244782AbiEYOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244781AbiEYN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:37 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134B4AF306;
        Wed, 25 May 2022 06:59:06 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id l84so7785614oif.10;
        Wed, 25 May 2022 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8G4mNyfX42pURKlaYJ4WIPubKcQr0JIN426OOqx92Q=;
        b=JL9uumT1LYH5uwIvRM8175wUfizcU53GOSt73CBp1cEg8nbQGLiVb+DN2vRx68jDUr
         N7zRdFdQsERxwfWcM5DsB6WU9N4P56aTLiD3fv4nuufXLU2fY9uBjldSMLjNVTpIdnUy
         47FjNqRGkRzQwQl0jWw8k4ZPxALpXujvucxeUjaNPfiBv9EHGpB6aQJtp+hYZoamakzU
         aFG7CMmbevxEOYUe/bGILJl50ZgxMv2MOo1SQ93sJ+bSm0hJ8F+gLMsr8J9GporAHls1
         DX6R7Ksje0Yl1wWFcW+hiTaUjaVaD6GV7stJ2WNBS88MDOhhmOsqbq/UcxACBFiyzKLO
         Wikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=y8G4mNyfX42pURKlaYJ4WIPubKcQr0JIN426OOqx92Q=;
        b=l9G/f6pvMOe1ZovhL+W+9lr71/7RSGg0VHLkG0kTvOII4nAdevI3q9e4kg94jFydKt
         JfJnsCCka+pNNTWkIBoc7ojV6oYYhf+notqJHDW8plkahoHHPuef/+SEgcJ7XCP7zykb
         DK8AvGd3t3uvnUgvDUmiIqY6GXmgd3cFty2TLZiwbtBmj5YWaU4o24BpjODhuLsMRrYW
         pawtb0t/lpbkKYZESNfJAUM9A2k5dqt6cP42sC1MBLrrTlIyqy/v1o8ELDG0DhfhV0tQ
         GyB09v30ULzXo+WzhyHJUvzbxgty72YT7cJ40i7dqUpeba5bUu/7teqGdTAY5JxEkWAn
         WxTg==
X-Gm-Message-State: AOAM532z1uvfr5EGi/83oZY/w5mMvwceP5L5hxH4aZ8QOEY6XRJvf+TS
        ITMtkszEReZwQm+itaXu5qdgDodf6dpjgQ==
X-Google-Smtp-Source: ABdhPJyTeHNtyGBX9YEeTqRZxVcNfhi304dHeCkIAVPu2pxJyQW5b/MQ83NTiB9/bAOmqEJPkSNRqQ==
X-Received: by 2002:a05:6808:a92:b0:32b:66c:b8f3 with SMTP id q18-20020a0568080a9200b0032b066cb8f3mr5366369oij.274.1653487145620;
        Wed, 25 May 2022 06:59:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w2-20020acaad02000000b0032af1c6bf02sm6169719oie.45.2022.05.25.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:59:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 34/40] hwmon: (lm90) Add support for ON Semiconductor NCT218
Date:   Wed, 25 May 2022 06:57:52 -0700
Message-Id: <20220525135758.2944744-35-linux@roeck-us.net>
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

NCT218 is compatible to NCT72 and NCT214. It also supports PEC (packet
error checking). Similar to NCT72 and NCT214, PEC support is undocumented.

Unlike NCT214 and NCT72, NCT218 does not support the undocumented secondary
chip and manufacturer ID registers at 0x3e and 0x3f and returns 0x00 when
reading those registers. The value for the chip revision register is not
documented but was observed to be 0xca. Use that information to improve
chip detection accuracy.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst | 10 ++++++++++
 drivers/hwmon/Kconfig        |  2 +-
 drivers/hwmon/lm90.c         | 31 +++++++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index d3836d1f1275..c3ce54f61f44 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -157,6 +157,16 @@ Supported chips:
 
 	       https://www.onsemi.com/PowerSolutions/product.do?id=NCT214
 
+  * ON Semiconductor NCT218
+
+    Prefix: 'nct218'
+
+    Addresses scanned: I2C 0x4c - 0x4d
+
+    Datasheet: Publicly available at the ON Semiconductor website
+
+	       https://www.onsemi.com/PowerSolutions/product.do?id=NCT218
+
   * ON Semiconductor NCT72
 
     Prefix: 'nct72'
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9353d207f254..32c605eaec7e 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1365,7 +1365,7 @@ config SENSORS_LM90
 	  Maxim MAX1617, MAX6642, MAX6646, MAX6647, MAX6648, MAX6649, MAX6654,
 	  MAX6657, MAX6658, MAX6659, MAX6680, MAX6681, MAX6692, MAX6695,
 	  MAX6696,
-	  ON Semiconductor NCT1008, NCT210, NCT72, NCT214,
+	  ON Semiconductor NCT1008, NCT210, NCT72, NCT214, NCT218,
 	  Winbond/Nuvoton W83L771W/G/AWG/ASG,
 	  Philips SA56004, GMT G781, Texas Instruments TMP451 and TMP461
 	  sensor chips.
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 2a1630b85967..4194b8838f20 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -69,8 +69,9 @@
  * / ON Semiconductor. The chips are similar to ADT7461 but support two external
  * temperature sensors.
  *
- * This driver also supports NCT72 and NCT214 from ON Semiconductor. The chips
- * are similar to ADT7461/ADT7461A but have full PEC support (undocumented).
+ * This driver also supports NCT72, NCT214, and NCT218 from ON Semiconductor.
+ * The chips are similar to ADT7461/ADT7461A but have full PEC support
+ * (undocumented).
  *
  * This driver also supports the SA56004 from Philips. This device is
  * pin-compatible with the LM86, the ED/EDP parts are also address-compatible.
@@ -262,6 +263,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "nct1008", adt7461a },
 	{ "nct210", nct210 },
 	{ "nct214", nct72 },
+	{ "nct218", nct72 },
 	{ "nct72", nct72 },
 	{ "w83l771", w83l771 },
 	{ "sa56004", sa56004 },
@@ -357,6 +359,10 @@ static const struct of_device_id __maybe_unused lm90_of_match[] = {
 		.compatible = "onnn,nct214",
 		.data = (void *)nct72
 	},
+	{
+		.compatible = "onnn,nct218",
+		.data = (void *)nct72
+	},
 	{
 		.compatible = "onnn,nct72",
 		.data = (void *)nct72
@@ -1778,6 +1784,24 @@ static const char *lm90_detect_national(struct i2c_client *client, int chip_id,
 	return name;
 }
 
+static const char *lm90_detect_on(struct i2c_client *client, int chip_id, int config1,
+				  int convrate)
+{
+	int address = client->addr;
+	const char *name = NULL;
+
+	switch (chip_id) {
+	case 0xca:		/* NCT218 */
+		if ((address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
+		    convrate <= 0x0a)
+			name = "nct218";
+		break;
+	default:
+		break;
+	}
+	return name;
+}
+
 static const char *lm90_detect_analog(struct i2c_client *client, bool common_address,
 				      int chip_id, int config1, int convrate)
 {
@@ -2263,6 +2287,9 @@ static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
 	case 0x01:	/* National Semiconductor */
 		name = lm90_detect_national(client, chip_id, config1, convrate);
 		break;
+	case 0x1a:	/* ON */
+		name = lm90_detect_on(client, chip_id, config1, convrate);
+		break;
 	case 0x23:	/* Genesys Logic */
 		if (common_address && !(config1 & 0x3f) && !(convrate & 0xf8))
 			name = "gl523sm";
-- 
2.35.1

