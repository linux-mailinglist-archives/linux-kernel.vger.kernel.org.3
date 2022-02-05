Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EAA4AAB56
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381177AbiBESz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:55:57 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:36681 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381337AbiBESzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:19 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 591E6240004;
        Sat,  5 Feb 2022 18:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ApNDABL+v60j762wlpZO71a5EOaULmOso+sYzlyX/q8=;
        b=CGR/MjgCf4uRlhIjZ1I4RTuJj7Rjqvvhwl8EGn+bCKV+SgIYs9r7nJuJJ7fxWAKCmz5/a2
        whRbr2GUWxXpMt2YWID7I25SgLpw3PQbwcRmxV+fxR3RhVVnsIg2YqUR4GuF4KhymM9aUe
        yZmqdYP0+2YHomdknVQYZgvGbrzt21ebh5UKhyvCgQ8j3uyuwTXtxEkGB6JlwgbDqH/Ej4
        qavRon98rqQqQEWZty+dZiC1cjgYkfiF2AKS/u7RHmcPyyTjYJhMbZU7sTQKD+GFPor5lY
        CjYUGQzxEG4MnQyuJA8T0FPycuaNM9+zKuQDbzj5T1Qc+ag0oHuMibyGo1cxPQ==
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
Subject: [PATCH v2 22/66] media: sun6i-csi: Use runtime pm for clocks and reset
Date:   Sat,  5 Feb 2022 19:53:45 +0100
Message-Id: <20220205185429.2278860-23-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the clock and reset preparation into runtime pm functions
for better organization of the code.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 94 ++++++++++++++-----
 1 file changed, 69 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 2355088fdc37..b53b92b70a89 100644
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
@@ -885,6 +922,11 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 		goto error_clk_rate_exclusive;
 	}
 
+	/* Runtime PM */
+
+	pm_runtime_enable(dev);
+	pm_runtime_set_suspended(dev);
+
 	return 0;
 
 error_clk_rate_exclusive:
@@ -895,6 +937,7 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 
 static void sun6i_csi_resources_cleanup(struct sun6i_csi_device *csi_dev)
 {
+	pm_runtime_disable(csi_dev->dev);
 	clk_rate_exclusive_put(csi_dev->clk_mod);
 }
 
@@ -954,6 +997,7 @@ static struct platform_driver sun6i_csi_platform_driver = {
 	.driver	= {
 		.name		= SUN6I_CSI_NAME,
 		.of_match_table	= of_match_ptr(sun6i_csi_of_match),
+		.pm		= &sun6i_csi_pm_ops,
 	},
 };
 
-- 
2.34.1

