Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA6B4AAB51
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381226AbiBESz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:55:59 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:34435 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381298AbiBESzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:15 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0EA6A240005;
        Sat,  5 Feb 2022 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AeQJoNjubf2CY4+FRw73J3db9TTnuJgIzuiaD3WR1Fo=;
        b=OH8ZfBQrSGdrJpcAR1ZqzUV4CXso9sfRgEZRYGXHfn40a9iksBschAikqH1Ckpcqg8+weX
        TUaC09vfQkyz0oGerGw1cmLeMwEHhmwmfq+iHhv21UbfuOhIRE7k6w+k9a/He5Z/kAI5by
        u8vLIPWFvez080k9R4DHhYGYVNrmq8Q+syir39O+YTfGGWrw+0jeEuB+MyY0bs6Jtuoovi
        GIKHpuWS+cj9x6nRqsdHiWEW1nZoK1CDVzIvnZOoqGJgrz4/Q2lEWaX94d/7ko1joy8uZq
        23irKs0CcGt7sGMpLpKPZ0slsvroHumCPsZJryTf8l/4RAykG025Ty/cCG4CFQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 20/66] media: sun6i-csi: Tidy up platform code
Date:   Sat,  5 Feb 2022 19:53:43 +0100
Message-Id: <20220205185429.2278860-21-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various renames, variables lowering and other cosmetic changes in the
platform-support code. No functional change intended.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
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
2.34.1

