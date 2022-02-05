Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195654AAB5F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381455AbiBESzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:55:54 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:38919 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381359AbiBESzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:20 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ABDDD240010;
        Sat,  5 Feb 2022 18:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOYYdmVl8pCa6416mpF3NEna8HLFfUDBAwcaSrt2+2M=;
        b=VxQtLVgU7ACEeiDt3hx/cbGZ1AzOweLSU9e+y4s2LlMlq8/5opiUlHwE0nSMgNYvcnbC7u
        QFFsVOxQFb5I4Q8fTCjDKHpWsa1vkE0SnTO0SsApqbLF1/GmuvN6ekjO2Vjq+phdUuB4rc
        McgSwydexepQqEaYPYE2cibSrPb83lu6grZJ3lC3HE8PaCCy2PVyrhWqzAAUVorqJFRx5a
        48wNZ5W+mdWRTfKdNS2VqQLVA/MLD34FCBB9VQKkT5jbBu7eHIEiU7UWnscsDa1msBLryN
        c1f8Cv+eEoUvHmE1Sp91XN+qPKBSkF+GpanFtUKoAW4m6T5C2DhKvL5TmZCMPA==
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
Subject: [PATCH v2 21/66] media: sun6i-csi: Always set exclusive module clock rate
Date:   Sat,  5 Feb 2022 19:53:44 +0100
Message-Id: <20220205185429.2278860-22-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some situations the default rate of the module clock is not the
required one for operation (for example when reconfiguring the clock
tree to use a different parent). As a result, always set the correct
rate for the clock (and take care of cleanup).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 54 ++++++++++++++-----
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 8155e9560164..2355088fdc37 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -154,9 +154,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
 		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
 
 		clk_disable_unprepare(csi_dev->clk_ram);
-		if (of_device_is_compatible(dev->of_node,
-					    "allwinner,sun50i-a64-csi"))
-			clk_rate_exclusive_put(csi_dev->clk_mod);
 		clk_disable_unprepare(csi_dev->clk_mod);
 		reset_control_assert(csi_dev->reset);
 		return 0;
@@ -168,9 +165,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
 		return ret;
 	}
 
-	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
-		clk_set_rate_exclusive(csi_dev->clk_mod, 300000000);
-
 	ret = clk_prepare_enable(csi_dev->clk_ram);
 	if (ret) {
 		dev_err(csi_dev->dev, "Enable clk_dram_csi clk err %d\n", ret);
@@ -190,8 +184,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
 clk_ram_disable:
 	clk_disable_unprepare(csi_dev->clk_ram);
 clk_mod_disable:
-	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
-		clk_rate_exclusive_put(csi_dev->clk_mod);
 	clk_disable_unprepare(csi_dev->clk_mod);
 	return ret;
 }
@@ -819,6 +811,7 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 				     struct platform_device *platform_dev)
 {
 	struct device *dev = csi_dev->dev;
+	unsigned long clk_mod_rate;
 	void __iomem *io_base;
 	int ret;
 	int irq;
@@ -856,28 +849,53 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 		return PTR_ERR(csi_dev->clk_ram);
 	}
 
+	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
+		clk_mod_rate = 300000000;
+	else
+		clk_mod_rate = 297000000;
+
+	ret = clk_set_rate_exclusive(csi_dev->clk_mod, clk_mod_rate);
+	if (ret) {
+		dev_err(dev, "failed to set mod clock rate\n");
+		return ret;
+	}
+
 	/* Reset */
 
 	csi_dev->reset = devm_reset_control_get_shared(dev, NULL);
 	if (IS_ERR(csi_dev->reset)) {
 		dev_err(dev, "failed to acquire reset\n");
-		return PTR_ERR(csi_dev->reset);
+		ret = PTR_ERR(csi_dev->reset);
+		goto error_clk_rate_exclusive;
 	}
 
 	/* Interrupt */
 
 	irq = platform_get_irq(platform_dev, 0);
-	if (irq < 0)
-		return -ENXIO;
+	if (irq < 0) {
+		dev_err(dev, "failed to get interrupt\n");
+		ret = -ENXIO;
+		goto error_clk_rate_exclusive;
+	}
 
 	ret = devm_request_irq(dev, irq, sun6i_csi_isr, 0, SUN6I_CSI_NAME,
 			       csi_dev);
 	if (ret) {
 		dev_err(dev, "failed to request interrupt\n");
-		return ret;
+		goto error_clk_rate_exclusive;
 	}
 
 	return 0;
+
+error_clk_rate_exclusive:
+	clk_rate_exclusive_put(csi_dev->clk_mod);
+
+	return ret;
+}
+
+static void sun6i_csi_resources_cleanup(struct sun6i_csi_device *csi_dev)
+{
+	clk_rate_exclusive_put(csi_dev->clk_mod);
 }
 
 static int sun6i_csi_probe(struct platform_device *platform_dev)
@@ -897,7 +915,16 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
 	if (ret)
 		return ret;
 
-	return sun6i_csi_v4l2_init(csi_dev);
+	ret = sun6i_csi_v4l2_init(csi_dev);
+	if (ret)
+		goto error_resources;
+
+	return 0;
+
+error_resources:
+	sun6i_csi_resources_cleanup(csi_dev);
+
+	return ret;
 }
 
 static int sun6i_csi_remove(struct platform_device *pdev)
@@ -905,6 +932,7 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 	struct sun6i_csi_device *csi_dev = platform_get_drvdata(pdev);
 
 	sun6i_csi_v4l2_cleanup(csi_dev);
+	sun6i_csi_resources_cleanup(csi_dev);
 
 	return 0;
 }
-- 
2.34.1

