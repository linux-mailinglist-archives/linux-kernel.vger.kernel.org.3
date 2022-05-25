Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436865343C3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbiEYTHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243005AbiEYTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:06:36 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F2310FD8;
        Wed, 25 May 2022 12:06:33 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 712001C0012;
        Wed, 25 May 2022 19:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RP/2aXE4+NVXX960d19mrWvfrTBHmQMjfLlYPNRcBMg=;
        b=PcqCRzGb7mqyOiLvVh2STKW+6MaZQ5eXGveL/JLoZGm875jX/SwlpE/RWyTcPheNpXuPsK
        593m0L6vDpUAY8hD06vZ6krHOQi2xBYdS16+uunPAz720X3q7uRCGsr7dP1vljbkpV57t9
        amQnMwwgoFg72iCeGzuqmGgckjF26aH+X0LLK51K4Dku5AqOAW2CdwMOUPMSs6GIhwlu9Q
        mIMZ3EOkzGSjaTUBYPBV9RDg57TKvAvNrwp1u8jVT8bDwXL7MPkRaeXkPhVatIJEVtvBij
        j0TRJ8wkiqtuYTdHUK0vdD7pxxlBPXnFGwaOGfGGefM2NvWDI0FE+Dh/p/CbDg==
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
Subject: [PATCH v5 06/44] media: sun6i-csi: Use runtime pm for clocks and reset
Date:   Wed, 25 May 2022 21:05:39 +0200
Message-Id: <20220525190617.696344-7-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
References: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
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

Wrap the clock and reset preparation into runtime pm functions
for better organization of the code. Also fix the clock and
reset enable order to first deassert reset, as recommended in
Allwinner literature.

Make the driver depend on PM while at it since runtime pm is
mandatory for the driver to work.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../media/platform/sunxi/sun6i-csi/Kconfig    |  2 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 84 +++++++++++++------
 2 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
index 0345901617d4..965fbd937841 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
+++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
@@ -2,7 +2,7 @@
 config VIDEO_SUN6I_CSI
 	tristate "Allwinner V3s Camera Sensor Interface driver"
 	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && COMMON_CLK  && HAS_DMA
+	depends on VIDEO_DEV && COMMON_CLK  && HAS_DMA && PM
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 800851f4e18c..31374d45eb9f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -152,40 +152,18 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
 
 	if (!enable) {
 		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
+		pm_runtime_put(dev);
 
-		clk_disable_unprepare(csi_dev->clock_ram);
-		clk_disable_unprepare(csi_dev->clock_mod);
-		reset_control_assert(csi_dev->reset);
 		return 0;
 	}
 
-	ret = clk_prepare_enable(csi_dev->clock_mod);
-	if (ret) {
-		dev_err(csi_dev->dev, "Enable csi clk err %d\n", ret);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
-	}
-
-	ret = clk_prepare_enable(csi_dev->clock_ram);
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
-	clk_disable_unprepare(csi_dev->clock_ram);
-clk_mod_disable:
-	clk_disable_unprepare(csi_dev->clock_mod);
-	return ret;
 }
 
 static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_device *csi_dev,
@@ -797,6 +775,56 @@ static irqreturn_t sun6i_csi_interrupt(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static int sun6i_csi_suspend(struct device *dev)
+{
+	struct sun6i_csi_device *csi_dev = dev_get_drvdata(dev);
+
+	reset_control_assert(csi_dev->reset);
+	clk_disable_unprepare(csi_dev->clock_ram);
+	clk_disable_unprepare(csi_dev->clock_mod);
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
+	ret = clk_prepare_enable(csi_dev->clock_mod);
+	if (ret) {
+		dev_err(dev, "failed to enable module clock\n");
+		goto error_reset;
+	}
+
+	ret = clk_prepare_enable(csi_dev->clock_ram);
+	if (ret) {
+		dev_err(dev, "failed to enable ram clock\n");
+		goto error_clock_mod;
+	}
+
+	return 0;
+
+error_clock_mod:
+	clk_disable_unprepare(csi_dev->clock_mod);
+
+error_reset:
+	reset_control_assert(csi_dev->reset);
+
+	return ret;
+}
+
+static const struct dev_pm_ops sun6i_csi_pm_ops = {
+	.runtime_suspend	= sun6i_csi_suspend,
+	.runtime_resume		= sun6i_csi_resume,
+};
+
 static const struct regmap_config sun6i_csi_regmap_config = {
 	.reg_bits       = 32,
 	.reg_stride     = 4,
@@ -876,6 +904,10 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 		goto error_clock_rate_exclusive;
 	}
 
+	/* Runtime PM */
+
+	pm_runtime_enable(dev);
+
 	return 0;
 
 error_clock_rate_exclusive:
@@ -886,6 +918,7 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 
 static void sun6i_csi_resources_cleanup(struct sun6i_csi_device *csi_dev)
 {
+	pm_runtime_disable(csi_dev->dev);
 	clk_rate_exclusive_put(csi_dev->clock_mod);
 }
 
@@ -968,6 +1001,7 @@ static struct platform_driver sun6i_csi_platform_driver = {
 	.driver	= {
 		.name		= SUN6I_CSI_NAME,
 		.of_match_table	= of_match_ptr(sun6i_csi_of_match),
+		.pm		= &sun6i_csi_pm_ops,
 	},
 };
 
-- 
2.36.1

