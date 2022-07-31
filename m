Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24F158610A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 21:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbiGaTYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 15:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbiGaTY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 15:24:26 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E107B13E8D
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 12:23:02 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id IEWYoK0AjxFTAIEWYok3tY; Sun, 31 Jul 2022 21:22:53 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 31 Jul 2022 21:22:53 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 2/2] media: sunxi: Fix some error handling path of sun6i_mipi_csi2_probe()
Date:   Sun, 31 Jul 2022 21:22:49 +0200
Message-Id: <9999a30560d0ab8201734cbab0483c6f840402da.1659295329.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <62c0aef8d3b86d8f290bf6787f1b2b41efbb0b55.1659295329.git.christophe.jaillet@wanadoo.fr>
References: <62c0aef8d3b86d8f290bf6787f1b2b41efbb0b55.1659295329.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release some resources in the error handling path of the probe and of
sun6i_mipi_csi2_resources_setup(), as already done in the remove
function.

Fixes: af54b4f4c17f ("media: sunxi: Add support for the A31 MIPI CSI-2 controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c    | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
index a4e3f9a6b2ff..1ee8501e25f6 100644
--- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
+++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
@@ -661,7 +661,8 @@ sun6i_mipi_csi2_resources_setup(struct sun6i_mipi_csi2_device *csi2_dev,
 	csi2_dev->reset = devm_reset_control_get_shared(dev, NULL);
 	if (IS_ERR(csi2_dev->reset)) {
 		dev_err(dev, "failed to get reset controller\n");
-		return PTR_ERR(csi2_dev->reset);
+		ret = PTR_ERR(csi2_dev->reset);
+		goto err_put_clk_rate;
 	}
 
 	/* D-PHY */
@@ -669,13 +670,14 @@ sun6i_mipi_csi2_resources_setup(struct sun6i_mipi_csi2_device *csi2_dev,
 	csi2_dev->dphy = devm_phy_get(dev, "dphy");
 	if (IS_ERR(csi2_dev->dphy)) {
 		dev_err(dev, "failed to get MIPI D-PHY\n");
-		return PTR_ERR(csi2_dev->dphy);
+		ret = PTR_ERR(csi2_dev->dphy);
+		goto err_put_clk_rate;
 	}
 
 	ret = phy_init(csi2_dev->dphy);
 	if (ret) {
 		dev_err(dev, "failed to initialize MIPI D-PHY\n");
-		return ret;
+		goto err_put_clk_rate;
 	}
 
 	/* Runtime PM */
@@ -683,6 +685,10 @@ sun6i_mipi_csi2_resources_setup(struct sun6i_mipi_csi2_device *csi2_dev,
 	pm_runtime_enable(dev);
 
 	return 0;
+
+err_put_clk_rate:
+	clk_rate_exclusive_put(csi2_dev->clock_mod);
+	return ret;
 }
 
 static void
@@ -712,9 +718,13 @@ static int sun6i_mipi_csi2_probe(struct platform_device *platform_dev)
 
 	ret = sun6i_mipi_csi2_bridge_setup(csi2_dev);
 	if (ret)
-		return ret;
+		goto err_cleanup_resources;
 
 	return 0;
+
+err_cleanup_resources:
+	sun6i_mipi_csi2_resources_cleanup(csi2_dev);
+	return ret;
 }
 
 static int sun6i_mipi_csi2_remove(struct platform_device *platform_dev)
-- 
2.34.1

