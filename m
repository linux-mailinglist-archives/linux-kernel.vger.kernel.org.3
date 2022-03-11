Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B9A4D6392
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349481AbiCKOhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349428AbiCKOhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:06 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ADA1C8D9C;
        Fri, 11 Mar 2022 06:36:01 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3FF9D240002;
        Fri, 11 Mar 2022 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtqvGR2qx3fG3mVGNkeVbc6J/VMjoN9TX7j1jYCLPUI=;
        b=j75vUwWr8uohNCqRwp69wdWywhTHuh+MLlAupqPPyXwlLJ5LpiDzmdtSTIseRc10QLpyyj
        +VF4mPkCH1Sodlgf0YSb/rwMXrEm3okz6gHGAhRwMyvvuR0Sir2DuUuiyfLMaEr5fNFJLR
        apNJmgVz0mT99VRVoLO0fUoNsDar+NVQgXpRhf/t4WmCylJ4qPROzNUt+0mu16FKKboosx
        9H+4m8lp8EjR1bwMDh3WsytVqjbTFVj18bUPtu87Avswn++Uz4KtDGcc/3RP0mFCPO8bBW
        JNTHLDF+Jy9CreDbPRRux7cF8plPo8wJRJLJ58iYtOq5/NOzCg1uizaq3tJl2A==
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
Subject: [PATCH v3 06/46] media: sun6i-csi: Define and use variant to get module clock rate
Date:   Fri, 11 Mar 2022 15:34:52 +0100
Message-Id: <20220311143532.265091-7-paul.kocialkowski@bootlin.com>
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

Introduce a proper variant structure with the module clock rate
instead of hardcoding it with a manual check on the compatible.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 48 ++++++++++++++-----
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  4 ++
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 2355088fdc37..4a0d08e0ac25 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -811,11 +811,17 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 				     struct platform_device *platform_dev)
 {
 	struct device *dev = csi_dev->dev;
-	unsigned long clk_mod_rate;
+	const struct sun6i_csi_variant *variant;
 	void __iomem *io_base;
 	int ret;
 	int irq;
 
+	/* Variant */
+
+	variant = of_device_get_match_data(dev);
+	if (!variant)
+		return -EINVAL;
+
 	/* Registers */
 
 	io_base = devm_platform_ioremap_resource(platform_dev, 0);
@@ -849,12 +855,7 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 		return PTR_ERR(csi_dev->clk_ram);
 	}
 
-	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
-		clk_mod_rate = 300000000;
-	else
-		clk_mod_rate = 297000000;
-
-	ret = clk_set_rate_exclusive(csi_dev->clk_mod, clk_mod_rate);
+	ret = clk_set_rate_exclusive(csi_dev->clk_mod, variant->clk_mod_rate);
 	if (ret) {
 		dev_err(dev, "failed to set mod clock rate\n");
 		return ret;
@@ -937,12 +938,35 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun6i_csi_variant sun6i_a31_csi_variant = {
+	.clk_mod_rate	= 297000000,
+};
+
+static const struct sun6i_csi_variant sun50i_a64_csi_variant = {
+	.clk_mod_rate	= 300000000,
+};
+
 static const struct of_device_id sun6i_csi_of_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-csi", },
-	{ .compatible = "allwinner,sun8i-a83t-csi", },
-	{ .compatible = "allwinner,sun8i-h3-csi", },
-	{ .compatible = "allwinner,sun8i-v3s-csi", },
-	{ .compatible = "allwinner,sun50i-a64-csi", },
+	{
+		.compatible	= "allwinner,sun6i-a31-csi",
+		.data		= &sun6i_a31_csi_variant,
+	},
+	{
+		.compatible	= "allwinner,sun8i-a83t-csi",
+		.data		= &sun6i_a31_csi_variant,
+	},
+	{
+		.compatible	= "allwinner,sun8i-h3-csi",
+		.data		= &sun6i_a31_csi_variant,
+	},
+	{
+		.compatible	= "allwinner,sun8i-v3s-csi",
+		.data		= &sun6i_a31_csi_variant,
+	},
+	{
+		.compatible	= "allwinner,sun50i-a64-csi",
+		.data		= &sun50i_a64_csi_variant,
+	},
 	{},
 };
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 356661b413f8..3c4a3af6b897 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -59,6 +59,10 @@ struct sun6i_csi_device {
 	int				planar_offset[3];
 };
 
+struct sun6i_csi_variant {
+	unsigned long	clk_mod_rate;
+};
+
 /**
  * sun6i_csi_is_format_supported() - check if the format supported by csi
  * @csi:	pointer to the csi
-- 
2.35.1

