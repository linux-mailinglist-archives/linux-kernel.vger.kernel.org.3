Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28A44D6395
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349432AbiCKOhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349419AbiCKOhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:04 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F7D1C8DA4;
        Fri, 11 Mar 2022 06:36:00 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EE790240005;
        Fri, 11 Mar 2022 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osJFZDLYgAC0fspugFGrGdYz4LqqrPjdk0ybNWCGf6E=;
        b=OxZaue9a/kjsG7KtVJ2Qznfrr0EA/l8zjAIVPpqQ22B9aEsHmVHVfWwSkBWJ9L6rd85+x4
        YSIBKJvTUCeU1XSkCQbQGYigtWswXM1eNOisDUjnOMjszRS/n69AGWOvcqkEcdCPpTbK9v
        QAu9zK5ORcqK9/OnXp7q3Yjb9wOPknhYKNQHDq13jflODtCN9ahfljCRl93cYllYbCOCy4
        fzHK2/n1wOrtH/lKrJ9GjTiVk9dY2FYjuFk/Le81yULVRtbpiSDp+jSJdANaV0x+1AAxni
        +KjVv8XMoFtlMkBfKU26VRjRPSm2VGPC6RHPwtPcgiw1iqvzNstuPg/DyhGT+Q==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 05/46] media: sun6i-csi: Always set exclusive module clock rate
Date:   Fri, 11 Mar 2022 15:34:51 +0100
Message-Id: <20220311143532.265091-6-paul.kocialkowski@bootlin.com>
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
2.35.1

