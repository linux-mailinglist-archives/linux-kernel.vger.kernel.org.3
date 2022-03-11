Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD34D638C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbiCKOhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349415AbiCKOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:03 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9381C8DA3;
        Fri, 11 Mar 2022 06:35:59 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B3033240014;
        Fri, 11 Mar 2022 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/9w4iol/OgR2hA7bibkg4EZnyOwhop/XnEYBOaJEpI=;
        b=B0RV7CSHOUnTxHpAUVx9T5dtZIA4ERthcyJokO0wCwhPzbzqFRjaPzMQ4ZPjbOSQ8SnOqt
        Rbvjv23dKjGI/LYcAGN/9sxXAxEin8eLoasf9Me1MM0cu/ITB+SkgOLWVQ0WJdIja41HHd
        wnuU9+VlMaVS+Oi2fNlsTdK0ZElR2ZTVvvPoD9Gx5pLpIhXFTFa/xcgupp5/HdDAHtQHNb
        4PocK8KdvF1iKM5GZDmo265ca3u3dyY1Dk9llZRxe++/Vrq2+tKdWhSp1mFaBM+L8oBcDq
        XStkh8dhmo1H26T6xBM1EWqCTZGv9dpa1LKSIhPLfeG33mnBXtw4CDB5q5ZLDw==
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
Subject: [PATCH v3 04/46] media: sun6i-csi: Tidy up platform code
Date:   Fri, 11 Mar 2022 15:34:50 +0100
Message-Id: <20220311143532.265091-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 76 +++++++++++--------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index dc79f3c14336..8155e9560164 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -776,12 +776,11 @@ static int sun6i_csi_v4l2_init(struct sun6i_csi_device *csi_dev)
 	return ret;
 }
 
-/* -----------------------------------------------------------------------------
- * Resources and IRQ
- */
-static irqreturn_t sun6i_csi_isr(int irq, void *dev_id)
+/* Platform */
+
+static irqreturn_t sun6i_csi_isr(int irq, void *private)
 {
-	struct sun6i_csi_device *csi_dev = (struct sun6i_csi_device *)dev_id;
+	struct sun6i_csi_device *csi_dev = private;
 	struct regmap *regmap = csi_dev->regmap;
 	u32 status;
 
@@ -816,79 +815,88 @@ static const struct regmap_config sun6i_csi_regmap_config = {
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
 
-	csi_dev->regmap = devm_regmap_init_mmio(&pdev->dev, io_base,
+	csi_dev->regmap = devm_regmap_init_mmio(dev, io_base,
 						&sun6i_csi_regmap_config);
 	if (IS_ERR(csi_dev->regmap)) {
-		dev_err(&pdev->dev, "Failed to init register map\n");
+		dev_err(dev, "failed to init register map\n");
 		return PTR_ERR(csi_dev->regmap);
 	}
 
-	csi_dev->clk_bus = devm_clk_get(&pdev->dev, "bus");
+	/* Clocks */
+
+	csi_dev->clk_bus = devm_clk_get(dev, "bus");
 	if (IS_ERR(csi_dev->clk_bus)) {
-		dev_err(&pdev->dev, "Unable to acquire bus clock\n");
+		dev_err(dev, "failed to acquire bus clock\n");
 		return PTR_ERR(csi_dev->clk_bus);
 	}
 
-	csi_dev->clk_mod = devm_clk_get(&pdev->dev, "mod");
+	csi_dev->clk_mod = devm_clk_get(dev, "mod");
 	if (IS_ERR(csi_dev->clk_mod)) {
-		dev_err(&pdev->dev, "Unable to acquire csi clock\n");
+		dev_err(dev, "failed to acquire module clock\n");
 		return PTR_ERR(csi_dev->clk_mod);
 	}
 
-	csi_dev->clk_ram = devm_clk_get(&pdev->dev, "ram");
+	csi_dev->clk_ram = devm_clk_get(dev, "ram");
 	if (IS_ERR(csi_dev->clk_ram)) {
-		dev_err(&pdev->dev, "Unable to acquire dram-csi clock\n");
+		dev_err(dev, "failed to acquire ram clock\n");
 		return PTR_ERR(csi_dev->clk_ram);
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
+	ret = devm_request_irq(dev, irq, sun6i_csi_isr, 0, SUN6I_CSI_NAME,
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
 
@@ -909,16 +917,18 @@ static const struct of_device_id sun6i_csi_of_match[] = {
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
-- 
2.35.1

