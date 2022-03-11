Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38C4D6388
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349487AbiCKOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349434AbiCKOhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:07 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569251C8DA8;
        Fri, 11 Mar 2022 06:36:03 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A6C7F240015;
        Fri, 11 Mar 2022 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cz8N6RvCKaWbZnNFxdRWzzyjz/M3Rp7k8RHQ9h9A25A=;
        b=VWKJCbJZfcFbt1P+JijpBUMqVYtOVeEKdYJ6rQXigSvs/0v5bE9XgfVXj49qa1ObiUC44i
        shZwhoMYdYUwTsN+aFEhBX++DaCFs8cSE97g9aaB+Ru16z/6GORXXFGEcWEdRswOj9Iu16
        YISDkvqwv6gI7P0DQxMAnOqtq1j2+4GCuAG44CPN93du2z20u8nQ0uRYajMP4upQSiwLRK
        kKIjqUZHHkg9L0Jfig4XJYXEgHuFHUKtj9umo/HZu/J4SunbdzZSJnhQEH38pweg6Rsj5V
        lk2Vq4S57k53U24i6hofV5wrHMZ9HeNe9NOVIYMrJS2uKdT/09RsSdUMYzpCgA==
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
Subject: [PATCH v3 07/46] media: sun6i-csi: Use runtime pm for clocks and reset
Date:   Fri, 11 Mar 2022 15:34:53 +0100
Message-Id: <20220311143532.265091-8-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the clock and reset preparation into runtime pm functions
for better organization of the code. Also fix the clock and
reset enable order to first deassert reset, as recommended in
Allwinner litterature.

Make the driver depend on PM while at it since runtime pm is
mandatory for the driver to work.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../media/platform/sunxi/sun6i-csi/Kconfig    |  2 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 94 ++++++++++++++-----
 2 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
index 586e3fb3a80d..fd03e48f0c8a 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
+++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_SUN6I_CSI
 	tristate "Allwinner V3s Camera Sensor Interface driver"
-	depends on VIDEO_V4L2 && COMMON_CLK  && HAS_DMA
+	depends on PM && VIDEO_V4L2 && COMMON_CLK  && HAS_DMA
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 4a0d08e0ac25..7f045a9551a7 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -152,40 +152,18 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
 
 	if (!enable) {
 		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
+		pm_runtime_put(dev);
 
-		clk_disable_unprepare(csi_dev->clk_ram);
-		clk_disable_unprepare(csi_dev->clk_mod);
-		reset_control_assert(csi_dev->reset);
 		return 0;
 	}
 
-	ret = clk_prepare_enable(csi_dev->clk_mod);
-	if (ret) {
-		dev_err(csi_dev->dev, "Enable csi clk err %d\n", ret);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
-	}
-
-	ret = clk_prepare_enable(csi_dev->clk_ram);
-	if (ret) {
-		dev_err(csi_dev->dev, "Enable clk_dram_csi clk err %d\n", ret);
-		goto clk_mod_disable;
-	}
-
-	ret = reset_control_deassert(csi_dev->reset);
-	if (ret) {
-		dev_err(csi_dev->dev, "reset err %d\n", ret);
-		goto clk_ram_disable;
-	}
 
 	regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, CSI_EN_CSI_EN);
 
 	return 0;
-
-clk_ram_disable:
-	clk_disable_unprepare(csi_dev->clk_ram);
-clk_mod_disable:
-	clk_disable_unprepare(csi_dev->clk_mod);
-	return ret;
 }
 
 static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_device *csi_dev,
@@ -800,6 +778,65 @@ static irqreturn_t sun6i_csi_isr(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static int sun6i_csi_suspend(struct device *dev)
+{
+	struct sun6i_csi_device *csi_dev = dev_get_drvdata(dev);
+
+	reset_control_assert(csi_dev->reset);
+	clk_disable_unprepare(csi_dev->clk_ram);
+	clk_disable_unprepare(csi_dev->clk_mod);
+	clk_disable_unprepare(csi_dev->clk_bus);
+
+	return 0;
+}
+
+static int sun6i_csi_resume(struct device *dev)
+{
+	struct sun6i_csi_device *csi_dev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(csi_dev->reset);
+	if (ret) {
+		dev_err(dev, "failed to deassert reset\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(csi_dev->clk_bus);
+	if (ret) {
+		dev_err(dev, "failed to enable bus clock\n");
+		goto error_reset;
+	}
+
+	ret = clk_prepare_enable(csi_dev->clk_mod);
+	if (ret) {
+		dev_err(dev, "failed to enable module clock\n");
+		goto error_clk_bus;
+	}
+
+	ret = clk_prepare_enable(csi_dev->clk_ram);
+	if (ret) {
+		dev_err(dev, "failed to enable ram clock\n");
+		goto error_clk_mod;
+	}
+
+	return 0;
+
+error_clk_mod:
+	clk_disable_unprepare(csi_dev->clk_mod);
+
+error_clk_bus:
+	clk_disable_unprepare(csi_dev->clk_bus);
+
+error_reset:
+	reset_control_assert(csi_dev->reset);
+
+	return ret;
+}
+
+static const struct dev_pm_ops sun6i_csi_pm_ops = {
+	SET_RUNTIME_PM_OPS(sun6i_csi_suspend, sun6i_csi_resume, NULL)
+};
+
 static const struct regmap_config sun6i_csi_regmap_config = {
 	.reg_bits       = 32,
 	.reg_stride     = 4,
@@ -886,6 +923,11 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 		goto error_clk_rate_exclusive;
 	}
 
+	/* Runtime PM */
+
+	pm_runtime_enable(dev);
+	pm_runtime_set_suspended(dev);
+
 	return 0;
 
 error_clk_rate_exclusive:
@@ -896,6 +938,7 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 
 static void sun6i_csi_resources_cleanup(struct sun6i_csi_device *csi_dev)
 {
+	pm_runtime_disable(csi_dev->dev);
 	clk_rate_exclusive_put(csi_dev->clk_mod);
 }
 
@@ -978,6 +1021,7 @@ static struct platform_driver sun6i_csi_platform_driver = {
 	.driver	= {
 		.name		= SUN6I_CSI_NAME,
 		.of_match_table	= of_match_ptr(sun6i_csi_of_match),
+		.pm		= &sun6i_csi_pm_ops,
 	},
 };
 
-- 
2.35.1

