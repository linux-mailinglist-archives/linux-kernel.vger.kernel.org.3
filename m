Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1FC502BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354384AbiDOOZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354571AbiDOOZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:25:05 -0400
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDB7D1CCF;
        Fri, 15 Apr 2022 07:22:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07483269|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0236375-0.00029974-0.976063;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.NRMqfXs_1650032541;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NRMqfXs_1650032541)
          by smtp.aliyun-inc.com(33.32.109.194);
          Fri, 15 Apr 2022 22:22:22 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul@crapouillou.net, contact@artur-rojek.eu,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH 3/3] SPI: Ingenic: Add support for new Ingenic SoCs.
Date:   Fri, 15 Apr 2022 22:22:08 +0800
Message-Id: <1650032528-118220-4-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650032528-118220-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1650032528-118220-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Since it would be dangerous to specify a newer SoC's compatible
  string as the fallback of an older SoC's compatible string, we
  add support for the "ingenic,jz4775-spi" compatible string in
  the driver.

  This will permit to support the JZ4775 by having:
  compatible = "ingenic,jz4775-spi";

  Instead of doing:
  compatible = "ingenic,jz4775-spi", "ingenic,jz4780-spi";

2.Add support for probing the spi-ingenic driver on the X1000 SoC
  from Ingenic. From the X1000 SoC onwards, the maximum frequency
  allowed by the SSI module of Ingenic SoCs has been changed from
  54MHz to 50MHz. So "max_speed_hz" is introduced in "jz_soc_info"
  to set different maximum frequency values.

3.Add support for probing the spi-ingenic driver on the X2000 SoC
  from Ingenic. The X2000 SoC has only one native chip select line,
  so "max_native_cs" is introduced in "jz_soc_info" to set different
  maximum number of native chip select lines.

4.Because of the introduction of support for the X-series SoCs, the
  current driver is not only applicable to the JZ-series SoCs, so
  the description texts has been modified to avoid misunderstanding.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/spi/Kconfig       |  4 ++--
 drivers/spi/spi-ingenic.c | 42 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d2815eb..cca92a8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -419,10 +419,10 @@ config SPI_IMX
 	  This enables support for the Freescale i.MX SPI controllers.
 
 config SPI_INGENIC
-	tristate "Ingenic JZ47xx SoCs SPI controller"
+	tristate "Ingenic SoCs SPI controller"
 	depends on MACH_INGENIC || COMPILE_TEST
 	help
-	  This enables support for the Ingenic JZ47xx SoCs SPI controller.
+	  This enables support for the Ingenic SoCs SPI controller.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called spi-ingenic.
diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
index 672e4ed..ff507c8 100644
--- a/drivers/spi/spi-ingenic.c
+++ b/drivers/spi/spi-ingenic.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SPI bus driver for the Ingenic JZ47xx SoCs
+ * SPI bus driver for the Ingenic SoCs
  * Copyright (c) 2017-2021 Artur Rojek <contact@artur-rojek.eu>
  * Copyright (c) 2017-2021 Paul Cercueil <paul@crapouillou.net>
+ * Copyright (c) 2022 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
  */
 
 #include <linux/clk.h>
@@ -52,6 +53,9 @@ struct jz_soc_info {
 	u32 bits_per_word_mask;
 	struct reg_field flen_field;
 	bool has_trendian;
+
+	unsigned int max_speed_hz;
+	unsigned int max_native_cs;
 };
 
 struct ingenic_spi {
@@ -418,7 +422,7 @@ static int spi_ingenic_probe(struct platform_device *pdev)
 
 	if (of_property_read_u32(dev->of_node, "num-cs", &num_cs)) {
 		dev_warn(dev, "Number of chip select lines not specified.\n");
-		num_cs = 2;
+		num_cs = pdata->max_native_cs;
 	}
 
 	platform_set_drvdata(pdev, ctlr);
@@ -433,9 +437,9 @@ static int spi_ingenic_probe(struct platform_device *pdev)
 	ctlr->max_dma_len = SPI_INGENIC_FIFO_SIZE;
 	ctlr->bits_per_word_mask = pdata->bits_per_word_mask;
 	ctlr->min_speed_hz = 7200;
-	ctlr->max_speed_hz = 54000000;
+	ctlr->max_speed_hz = pdata->max_speed_hz;
 	ctlr->use_gpio_descriptors = true;
-	ctlr->max_native_cs = 2;
+	ctlr->max_native_cs = pdata->max_native_cs;
 	ctlr->num_chipselect = num_cs;
 	ctlr->dev.of_node = pdev->dev.of_node;
 
@@ -459,17 +463,44 @@ static const struct jz_soc_info jz4750_soc_info = {
 	.bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 17),
 	.flen_field = REG_FIELD(REG_SSICR1, 4, 7),
 	.has_trendian = false,
+
+	.max_speed_hz = 54000000,
+	.max_native_cs = 2,
 };
 
 static const struct jz_soc_info jz4780_soc_info = {
 	.bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 32),
 	.flen_field = REG_FIELD(REG_SSICR1, 3, 7),
 	.has_trendian = true,
+
+	.max_speed_hz = 54000000,
+	.max_native_cs = 2,
+};
+
+static const struct jz_soc_info x1000_soc_info = {
+	.bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 32),
+	.flen_field = REG_FIELD(REG_SSICR1, 3, 7),
+	.has_trendian = true,
+
+	.max_speed_hz = 50000000,
+	.max_native_cs = 2,
+};
+
+static const struct jz_soc_info x2000_soc_info = {
+	.bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 32),
+	.flen_field = REG_FIELD(REG_SSICR1, 3, 7),
+	.has_trendian = true,
+
+	.max_speed_hz = 50000000,
+	.max_native_cs = 1,
 };
 
 static const struct of_device_id spi_ingenic_of_match[] = {
 	{ .compatible = "ingenic,jz4750-spi", .data = &jz4750_soc_info },
+	{ .compatible = "ingenic,jz4775-spi", .data = &jz4780_soc_info },
 	{ .compatible = "ingenic,jz4780-spi", .data = &jz4780_soc_info },
+	{ .compatible = "ingenic,x1000-spi", .data = &x1000_soc_info },
+	{ .compatible = "ingenic,x2000-spi", .data = &x2000_soc_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, spi_ingenic_of_match);
@@ -483,7 +514,8 @@ static struct platform_driver spi_ingenic_driver = {
 };
 
 module_platform_driver(spi_ingenic_driver);
-MODULE_DESCRIPTION("SPI bus driver for the Ingenic JZ47xx SoCs");
+MODULE_DESCRIPTION("SPI bus driver for the Ingenic SoCs");
 MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
 MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_AUTHOR("周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>");
 MODULE_LICENSE("GPL");
-- 
2.7.4

