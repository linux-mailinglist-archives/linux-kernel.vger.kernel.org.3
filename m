Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028775A2E97
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243619AbiHZSdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344659AbiHZSdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:16 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB2FE3C2C;
        Fri, 26 Aug 2022 11:33:13 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B5BC7FF80F;
        Fri, 26 Aug 2022 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5zvr8GUUIl8BZtc8RF9yzFuenMKn2tdvNLGUULuRJk8=;
        b=JRMXidZ7G1ZKo8HqW2hfxEDnGUOMjfd342eKteJOIgJBvE5KrazEIUZ+mtUd4A9CWlBl7n
        k2AbY/8QgZuF17Cu0dsHbDZSfYUlcch4e1Lu8xp6+GL7w0Q0l55QSuOZuVh9R4mJN6G4Ek
        sQ4grbVaMR22Gs24rg9Z2BRaiFWA4QSo0qIaoIdCO/pdb2lEArXl8byYdkQyIzcE1IMXRZ
        Fd1aDMBqdRw87YW1hEwhvhEYQNbVlUlL9eImxeiFPe1BoPgQ7d+1EVlGB97gtw0RB+Y4Kj
        IJtCsRUvHnOvuv+FinPHZEC8eFd886hkxm61Y7ifVLHPnAZAqjZaG6s2GSxFsA==
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
Subject: [PATCH v6 05/43] media: sun6i-csi: Define and use variant to get module clock rate
Date:   Fri, 26 Aug 2022 20:32:02 +0200
Message-Id: <20220826183240.604834-6-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a proper variant structure with the module clock rate
instead of hardcoding it with a manual check on the compatible.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 47 ++++++++++++++-----
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  4 ++
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 89a15cd779ac..800851f4e18c 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -808,11 +808,15 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 				     struct platform_device *platform_dev)
 {
 	struct device *dev = csi_dev->dev;
-	unsigned long clock_mod_rate;
+	const struct sun6i_csi_variant *variant;
 	void __iomem *io_base;
 	int ret;
 	int irq;
 
+	variant = of_device_get_match_data(dev);
+	if (!variant)
+		return -EINVAL;
+
 	/* Registers */
 
 	io_base = devm_platform_ioremap_resource(platform_dev, 0);
@@ -840,12 +844,8 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 		return PTR_ERR(csi_dev->clock_ram);
 	}
 
-	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
-		clock_mod_rate = 300000000;
-	else
-		clock_mod_rate = 297000000;
-
-	ret = clk_set_rate_exclusive(csi_dev->clock_mod, clock_mod_rate);
+	ret = clk_set_rate_exclusive(csi_dev->clock_mod,
+				     variant->clock_mod_rate);
 	if (ret) {
 		dev_err(dev, "failed to set mod clock rate\n");
 		return ret;
@@ -928,12 +928,35 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun6i_csi_variant sun6i_a31_csi_variant = {
+	.clock_mod_rate	= 297000000,
+};
+
+static const struct sun6i_csi_variant sun50i_a64_csi_variant = {
+	.clock_mod_rate	= 300000000,
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
index 945d0cb5ab39..a76b545f2aa4 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -58,6 +58,10 @@ struct sun6i_csi_device {
 	int				planar_offset[3];
 };
 
+struct sun6i_csi_variant {
+	unsigned long	clock_mod_rate;
+};
+
 /**
  * sun6i_csi_is_format_supported() - check if the format supported by csi
  * @csi:	pointer to the csi
-- 
2.37.1

