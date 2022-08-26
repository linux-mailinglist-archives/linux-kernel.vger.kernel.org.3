Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6709A5A2E95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbiHZSdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiHZSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:13 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B3AE3C21;
        Fri, 26 Aug 2022 11:33:11 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 80ECCFF80D;
        Fri, 26 Aug 2022 18:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KIxhuV3gjGTZxAqWn3+VKaoQQ3io1ugYvzNyhFuC/Q=;
        b=M4joXRD2eHa+o2mtUTEWaSjHkspQOLN7DPCnbOWMRi4VKhcx9TuqjJZCGtphnkJWLT15uf
        PYPAVMeb+XcCBulYr6hUxllUetH2+SMckJZKo1Wp1d+fuM6SMGRkgIUrsqESsj+Z4mGHCI
        whI55iSnNNXOr3oDjANdPoU6oSU2vqyMGRMk1uKGi7EkZZZpnnaKU3sr6YQ8DOcPP8QETH
        AsuhXfZ3oauhiHA727v6VylQbVDTgBpr3t5uWSnZkJtuAQzETs5Byf5skC7XQtLVYsuir4
        zHXRzJGPpMRz1UI7scxAOpf9pKGOYp+Z88d9cX1jZh0S+gLDj21eKuxE8liXOA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v6 03/43] media: sun6i-csi: Tidy up platform code
Date:   Fri, 26 Aug 2022 20:32:00 +0200
Message-Id: <20220826183240.604834-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various renames, variables lowering and other cosmetic changes in the
platform-support code. No functional change intended.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 98 ++++++++++---------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  4 +-
 2 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 0e2b4d38e81c..514f97d67c1c 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -153,25 +153,25 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
 	if (!enable) {
 		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
 
-		clk_disable_unprepare(csi_dev->clk_ram);
+		clk_disable_unprepare(csi_dev->clock_ram);
 		if (of_device_is_compatible(dev->of_node,
 					    "allwinner,sun50i-a64-csi"))
-			clk_rate_exclusive_put(csi_dev->clk_mod);
-		clk_disable_unprepare(csi_dev->clk_mod);
+			clk_rate_exclusive_put(csi_dev->clock_mod);
+		clk_disable_unprepare(csi_dev->clock_mod);
 		reset_control_assert(csi_dev->reset);
 		return 0;
 	}
 
-	ret = clk_prepare_enable(csi_dev->clk_mod);
+	ret = clk_prepare_enable(csi_dev->clock_mod);
 	if (ret) {
 		dev_err(csi_dev->dev, "Enable csi clk err %d\n", ret);
 		return ret;
 	}
 
 	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
-		clk_set_rate_exclusive(csi_dev->clk_mod, 300000000);
+		clk_set_rate_exclusive(csi_dev->clock_mod, 300000000);
 
-	ret = clk_prepare_enable(csi_dev->clk_ram);
+	ret = clk_prepare_enable(csi_dev->clock_ram);
 	if (ret) {
 		dev_err(csi_dev->dev, "Enable clk_dram_csi clk err %d\n", ret);
 		goto clk_mod_disable;
@@ -188,11 +188,11 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
 	return 0;
 
 clk_ram_disable:
-	clk_disable_unprepare(csi_dev->clk_ram);
+	clk_disable_unprepare(csi_dev->clock_ram);
 clk_mod_disable:
 	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
-		clk_rate_exclusive_put(csi_dev->clk_mod);
-	clk_disable_unprepare(csi_dev->clk_mod);
+		clk_rate_exclusive_put(csi_dev->clock_mod);
+	clk_disable_unprepare(csi_dev->clock_mod);
 	return ret;
 }
 
@@ -773,12 +773,11 @@ static int sun6i_csi_v4l2_init(struct sun6i_csi_device *csi_dev)
 	return ret;
 }
 
-/* -----------------------------------------------------------------------------
- * Resources and IRQ
- */
-static irqreturn_t sun6i_csi_isr(int irq, void *dev_id)
+/* Platform */
+
+static irqreturn_t sun6i_csi_interrupt(int irq, void *private)
 {
-	struct sun6i_csi_device *csi_dev = (struct sun6i_csi_device *)dev_id;
+	struct sun6i_csi_device *csi_dev = private;
 	struct regmap *regmap = csi_dev->regmap;
 	u32 status;
 
@@ -813,73 +812,82 @@ static const struct regmap_config sun6i_csi_regmap_config = {
 	.max_register	= 0x9c,
 };
 
-static int sun6i_csi_resource_request(struct sun6i_csi_device *csi_dev,
-				      struct platform_device *pdev)
+static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
+				     struct platform_device *platform_dev)
 {
+	struct device *dev = csi_dev->dev;
 	void __iomem *io_base;
 	int ret;
 	int irq;
 
-	io_base = devm_platform_ioremap_resource(pdev, 0);
+	/* Registers */
+
+	io_base = devm_platform_ioremap_resource(platform_dev, 0);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
-	csi_dev->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus", io_base,
+	csi_dev->regmap = devm_regmap_init_mmio_clk(dev, "bus", io_base,
 						    &sun6i_csi_regmap_config);
 	if (IS_ERR(csi_dev->regmap)) {
-		dev_err(&pdev->dev, "Failed to init register map\n");
+		dev_err(dev, "failed to init register map\n");
 		return PTR_ERR(csi_dev->regmap);
 	}
 
-	csi_dev->clk_mod = devm_clk_get(&pdev->dev, "mod");
-	if (IS_ERR(csi_dev->clk_mod)) {
-		dev_err(&pdev->dev, "Unable to acquire csi clock\n");
-		return PTR_ERR(csi_dev->clk_mod);
+	/* Clocks */
+
+	csi_dev->clock_mod = devm_clk_get(dev, "mod");
+	if (IS_ERR(csi_dev->clock_mod)) {
+		dev_err(dev, "failed to acquire module clock\n");
+		return PTR_ERR(csi_dev->clock_mod);
 	}
 
-	csi_dev->clk_ram = devm_clk_get(&pdev->dev, "ram");
-	if (IS_ERR(csi_dev->clk_ram)) {
-		dev_err(&pdev->dev, "Unable to acquire dram-csi clock\n");
-		return PTR_ERR(csi_dev->clk_ram);
+	csi_dev->clock_ram = devm_clk_get(dev, "ram");
+	if (IS_ERR(csi_dev->clock_ram)) {
+		dev_err(dev, "failed to acquire ram clock\n");
+		return PTR_ERR(csi_dev->clock_ram);
 	}
 
-	csi_dev->reset = devm_reset_control_get_shared(&pdev->dev, NULL);
+	/* Reset */
+
+	csi_dev->reset = devm_reset_control_get_shared(dev, NULL);
 	if (IS_ERR(csi_dev->reset)) {
-		dev_err(&pdev->dev, "Cannot get reset controller\n");
+		dev_err(dev, "failed to acquire reset\n");
 		return PTR_ERR(csi_dev->reset);
 	}
 
-	irq = platform_get_irq(pdev, 0);
+	/* Interrupt */
+
+	irq = platform_get_irq(platform_dev, 0);
 	if (irq < 0)
 		return -ENXIO;
 
-	ret = devm_request_irq(&pdev->dev, irq, sun6i_csi_isr, 0,
-			       SUN6I_CSI_NAME, csi_dev);
+	ret = devm_request_irq(dev, irq, sun6i_csi_interrupt, 0, SUN6I_CSI_NAME,
+			       csi_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "Cannot request csi IRQ\n");
+		dev_err(dev, "failed to request interrupt\n");
 		return ret;
 	}
 
 	return 0;
 }
 
-static int sun6i_csi_probe(struct platform_device *pdev)
+static int sun6i_csi_probe(struct platform_device *platform_dev)
 {
 	struct sun6i_csi_device *csi_dev;
+	struct device *dev = &platform_dev->dev;
 	int ret;
 
-	csi_dev = devm_kzalloc(&pdev->dev, sizeof(*csi_dev), GFP_KERNEL);
+	csi_dev = devm_kzalloc(dev, sizeof(*csi_dev), GFP_KERNEL);
 	if (!csi_dev)
 		return -ENOMEM;
 
-	csi_dev->dev = &pdev->dev;
+	csi_dev->dev = &platform_dev->dev;
+	platform_set_drvdata(platform_dev, csi_dev);
 
-	ret = sun6i_csi_resource_request(csi_dev, pdev);
+	ret = sun6i_csi_resources_setup(csi_dev, platform_dev);
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, csi_dev);
-
 	return sun6i_csi_v4l2_init(csi_dev);
 }
 
@@ -900,16 +908,18 @@ static const struct of_device_id sun6i_csi_of_match[] = {
 	{ .compatible = "allwinner,sun50i-a64-csi", },
 	{},
 };
+
 MODULE_DEVICE_TABLE(of, sun6i_csi_of_match);
 
 static struct platform_driver sun6i_csi_platform_driver = {
-	.probe = sun6i_csi_probe,
-	.remove = sun6i_csi_remove,
-	.driver = {
-		.name = SUN6I_CSI_NAME,
-		.of_match_table = of_match_ptr(sun6i_csi_of_match),
+	.probe	= sun6i_csi_probe,
+	.remove	= sun6i_csi_remove,
+	.driver	= {
+		.name		= SUN6I_CSI_NAME,
+		.of_match_table	= of_match_ptr(sun6i_csi_of_match),
 	},
 };
+
 module_platform_driver(sun6i_csi_platform_driver);
 
 MODULE_DESCRIPTION("Allwinner A31 Camera Sensor Interface driver");
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index e4e7ac6c869f..945d0cb5ab39 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -51,8 +51,8 @@ struct sun6i_csi_device {
 	struct sun6i_video		video;
 
 	struct regmap			*regmap;
-	struct clk			*clk_mod;
-	struct clk			*clk_ram;
+	struct clk			*clock_mod;
+	struct clk			*clock_ram;
 	struct reset_control		*reset;
 
 	int				planar_offset[3];
-- 
2.37.1

