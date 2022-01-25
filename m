Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D18E49BC97
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiAYUA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:00:27 -0500
Received: from mail.hugovil.com ([162.243.120.170]:53736 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiAYUAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2Aka9M75NunXd/L8wCHL21CsvcClb289rT/3UUcq5tY=; b=QkGuBgTVJSQE0H45KpyEjQUFXT
        eyG9Y0sfuzEJ43e84oKGGyWNI9F8SPceiMwYHCRn2htCJvAu/w9xpntLe36VKdb2K6Rci6Wdcu9N5
        mE241yRrQ0PEa5tv0Zj2dL3RmAbQ3vc1yl1f/P5g9pZcKtBahdeA55J0gIhLJd7Um8S0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55004 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nCRzC-0007fC-JP; Tue, 25 Jan 2022 15:00:16 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 15:00:00 -0500
Message-Id: <20220125200009.900660-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125200009.900660-1-hugo@hugovil.com>
References: <20220125200009.900660-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: dimonoff.com]
        * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 01/10] rtc: pcf2127: add variant-specific configuration structure
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Create variant-specific configuration structures to simplify the
implementation of new variants into this driver. It will also avoid
to have too many tests for a specific variant, or a list of variants
for new devices, inside the code itself.

Add configuration options for the support of the NVMEM, bit CD0 in
register WD_CTL as well as the maximum number of registers for each
variant, instead of hardcoding the variant (PCF2127) inside the
i2c_device_id and spi_device_id structures.

Also specify a different maximum number of registers (max_register)
for the PCF2129.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 96 +++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 81a5b1f2e68c..d2b335a64887 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/watchdog.h>
 
@@ -101,10 +102,17 @@
 		PCF2127_BIT_CTRL2_WDTF | \
 		PCF2127_BIT_CTRL2_TSF2)
 
+struct pcf21xx_config {
+	int max_register;
+	unsigned int has_nvmem:1;
+	unsigned int has_bit_wd_ctl_cd0:1;
+};
+
 struct pcf2127 {
 	struct rtc_device *rtc;
 	struct watchdog_device wdd;
 	struct regmap *regmap;
+	const struct pcf21xx_config *cfg;
 	time64_t ts;
 	bool ts_valid;
 	bool irq_enabled;
@@ -630,8 +638,27 @@ static const struct attribute_group pcf2127_attr_group = {
 	.attrs	= pcf2127_attrs,
 };
 
+enum pcf21xx_type {
+	PCF2127,
+	PCF2129,
+	PCF21XX_LAST_ID
+};
+
+static struct pcf21xx_config pcf21xx_cfg[] = {
+	[PCF2127] = {
+		.max_register = 0x1d,
+		.has_nvmem = 1,
+		.has_bit_wd_ctl_cd0 = 1,
+	},
+	[PCF2129] = {
+		.max_register = 0x19,
+		.has_nvmem = 0,
+		.has_bit_wd_ctl_cd0 = 0,
+	},
+};
+
 static int pcf2127_probe(struct device *dev, struct regmap *regmap,
-			 int alarm_irq, const char *name, bool is_pcf2127)
+			 int alarm_irq, const char *name, const struct pcf21xx_config *config)
 {
 	struct pcf2127 *pcf2127;
 	int ret = 0;
@@ -644,6 +671,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 		return -ENOMEM;
 
 	pcf2127->regmap = regmap;
+	pcf2127->cfg = config;
 
 	dev_set_drvdata(dev, pcf2127);
 
@@ -675,7 +703,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 		set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
 	}
 
-	if (is_pcf2127) {
+	if (pcf2127->cfg->has_nvmem) {
 		struct nvmem_config nvmem_cfg = {
 			.priv = pcf2127,
 			.reg_read = pcf2127_nvmem_read,
@@ -721,7 +749,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 				 PCF2127_BIT_WD_CTL_TF1 |
 				 PCF2127_BIT_WD_CTL_TF0,
 				 PCF2127_BIT_WD_CTL_CD1 |
-				 (is_pcf2127 ? PCF2127_BIT_WD_CTL_CD0 : 0) |
+				 (pcf2127->cfg->has_bit_wd_ctl_cd0 ? PCF2127_BIT_WD_CTL_CD0 : 0) |
 				 PCF2127_BIT_WD_CTL_TF1);
 	if (ret) {
 		dev_err(dev, "%s: watchdog config (wd_ctl) failed\n", __func__);
@@ -786,9 +814,9 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 
 #ifdef CONFIG_OF
 static const struct of_device_id pcf2127_of_match[] = {
-	{ .compatible = "nxp,pcf2127" },
-	{ .compatible = "nxp,pcf2129" },
-	{ .compatible = "nxp,pca2129" },
+	{ .compatible = "nxp,pcf2127", .data = &pcf21xx_cfg[PCF2127] },
+	{ .compatible = "nxp,pcf2129", .data = &pcf21xx_cfg[PCF2129] },
+	{ .compatible = "nxp,pca2129", .data = &pcf21xx_cfg[PCF2129] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pcf2127_of_match);
@@ -872,19 +900,36 @@ static const struct regmap_bus pcf2127_i2c_regmap = {
 
 static struct i2c_driver pcf2127_i2c_driver;
 
+static const struct i2c_device_id pcf2127_i2c_id[];
+
 static int pcf2127_i2c_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct regmap *regmap;
-	static const struct regmap_config config = {
+	static struct regmap_config config = {
 		.reg_bits = 8,
 		.val_bits = 8,
-		.max_register = 0x1d,
 	};
+	const struct pcf21xx_config *variant;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
+	if (client->dev.of_node) {
+		variant = of_device_get_match_data(&client->dev);
+		if (!variant)
+			return -ENODEV;
+	} else {
+		enum pcf21xx_type type =
+			i2c_match_id(pcf2127_i2c_id, client)->driver_data;
+
+		if (type >= PCF21XX_LAST_ID)
+			return -ENODEV;
+		variant = &pcf21xx_cfg[type];
+	}
+
+	config.max_register = variant->max_register,
+
 	regmap = devm_regmap_init(&client->dev, &pcf2127_i2c_regmap,
 					&client->dev, &config);
 	if (IS_ERR(regmap)) {
@@ -894,13 +939,13 @@ static int pcf2127_i2c_probe(struct i2c_client *client,
 	}
 
 	return pcf2127_probe(&client->dev, regmap, client->irq,
-			     pcf2127_i2c_driver.driver.name, id->driver_data);
+			     pcf2127_i2c_driver.driver.name, variant);
 }
 
 static const struct i2c_device_id pcf2127_i2c_id[] = {
-	{ "pcf2127", 1 },
-	{ "pcf2129", 0 },
-	{ "pca2129", 0 },
+	{ "pcf2127", PCF2127 },
+	{ "pcf2129", PCF2129 },
+	{ "pca2129", PCF2129 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pcf2127_i2c_id);
@@ -940,17 +985,32 @@ static void pcf2127_i2c_unregister_driver(void)
 #if IS_ENABLED(CONFIG_SPI_MASTER)
 
 static struct spi_driver pcf2127_spi_driver;
+static const struct spi_device_id pcf2127_spi_id[];
 
 static int pcf2127_spi_probe(struct spi_device *spi)
 {
-	static const struct regmap_config config = {
+	static struct regmap_config config = {
 		.reg_bits = 8,
 		.val_bits = 8,
 		.read_flag_mask = 0xa0,
 		.write_flag_mask = 0x20,
-		.max_register = 0x1d,
 	};
 	struct regmap *regmap;
+	const struct pcf21xx_config *variant;
+
+	if (spi->dev.of_node) {
+		variant = of_device_get_match_data(&spi->dev);
+		if (!variant)
+			return -ENODEV;
+	} else {
+		enum pcf21xx_type type = spi_get_device_id(spi)->driver_data;
+
+		if (type >= PCF21XX_LAST_ID)
+			return -ENODEV;
+		variant = &pcf21xx_cfg[type];
+	}
+
+	config.max_register = variant->max_register,
 
 	regmap = devm_regmap_init_spi(spi, &config);
 	if (IS_ERR(regmap)) {
@@ -961,13 +1021,13 @@ static int pcf2127_spi_probe(struct spi_device *spi)
 
 	return pcf2127_probe(&spi->dev, regmap, spi->irq,
 			     pcf2127_spi_driver.driver.name,
-			     spi_get_device_id(spi)->driver_data);
+			     variant);
 }
 
 static const struct spi_device_id pcf2127_spi_id[] = {
-	{ "pcf2127", 1 },
-	{ "pcf2129", 0 },
-	{ "pca2129", 0 },
+	{ "pcf2127", PCF2127 },
+	{ "pcf2129", PCF2129 },
+	{ "pca2129", PCF2129 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, pcf2127_spi_id);
-- 
2.30.2

