Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21D859D271
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbiHWHm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbiHWHmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:42:15 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512DB647ED
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:42:06 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id QOXyo53B7XaJmQOXyoHkvv; Tue, 23 Aug 2022 09:42:04 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 23 Aug 2022 09:42:04 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/2] media: sunxi: Fix some error handling path of sun8i_a83t_mipi_csi2_probe()
Date:   Tue, 23 Aug 2022 09:42:01 +0200
Message-Id: <28d04b260acff7eb4416a410d5678cbafb5e2784.1661240416.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release some resources in the error handling path of the probe and of
sun8i_a83t_mipi_csi2_resources_setup(), as already done in the remove
function.

Fixes: 576d196c522b ("media: sunxi: Add support for the A83T MIPI CSI-2 controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I'm unsure about the phy_exit() call in
sun8i_a83t_mipi_csi2_resources_cleanup() because no explicit phy_init()
call is performed.

The same code is in sun6i-mipi-csi2/sun6i_mipi_csi2.c, but in this driver
phy_init() IS called.

I leave it as-is because I don't if it is an issue or not.
My feeling is that it is a copy'n'paste error and that it should be
removed.

Changes in v2:
  * add some blank line   [Paul Kocialkowski <paul.kocialkowski@bootlin.com>]
  * rename the new labels   [Paul Kocialkowski <paul.kocialkowski@bootlin.com>]

v1:
  https://lore.kernel.org/all/62c0aef8d3b86d8f290bf6787f1b2b41efbb0b55.1659295329.git.christophe.jaillet@wanadoo.fr/
---
 .../sun8i_a83t_mipi_csi2.c                    | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
index d052ee77ef0a..b032ec13a683 100644
--- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
@@ -719,13 +719,15 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a83t_mipi_csi2_device *csi2_de
 	csi2_dev->clock_mipi = devm_clk_get(dev, "mipi");
 	if (IS_ERR(csi2_dev->clock_mipi)) {
 		dev_err(dev, "failed to acquire mipi clock\n");
-		return PTR_ERR(csi2_dev->clock_mipi);
+		ret = PTR_ERR(csi2_dev->clock_mipi);
+		goto error_clock_rate_exclusive;
 	}
 
 	csi2_dev->clock_misc = devm_clk_get(dev, "misc");
 	if (IS_ERR(csi2_dev->clock_misc)) {
 		dev_err(dev, "failed to acquire misc clock\n");
-		return PTR_ERR(csi2_dev->clock_misc);
+		ret = PTR_ERR(csi2_dev->clock_misc);
+		goto error_clock_rate_exclusive;
 	}
 
 	/* Reset */
@@ -733,7 +735,8 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a83t_mipi_csi2_device *csi2_de
 	csi2_dev->reset = devm_reset_control_get_shared(dev, NULL);
 	if (IS_ERR(csi2_dev->reset)) {
 		dev_err(dev, "failed to get reset controller\n");
-		return PTR_ERR(csi2_dev->reset);
+		ret = PTR_ERR(csi2_dev->reset);
+		goto error_clock_rate_exclusive;
 	}
 
 	/* D-PHY */
@@ -741,7 +744,7 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a83t_mipi_csi2_device *csi2_de
 	ret = sun8i_a83t_dphy_register(csi2_dev);
 	if (ret) {
 		dev_err(dev, "failed to initialize MIPI D-PHY\n");
-		return ret;
+		goto error_clock_rate_exclusive;
 	}
 
 	/* Runtime PM */
@@ -749,6 +752,11 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a83t_mipi_csi2_device *csi2_de
 	pm_runtime_enable(dev);
 
 	return 0;
+
+error_clock_rate_exclusive:
+	clk_rate_exclusive_put(csi2_dev->clock_mod);
+
+	return ret;
 }
 
 static void
@@ -778,9 +786,14 @@ static int sun8i_a83t_mipi_csi2_probe(struct platform_device *platform_dev)
 
 	ret = sun8i_a83t_mipi_csi2_bridge_setup(csi2_dev);
 	if (ret)
-		return ret;
+		goto error_resources;
 
 	return 0;
+
+error_resources:
+	sun8i_a83t_mipi_csi2_resources_cleanup(csi2_dev);
+
+	return ret;
 }
 
 static int sun8i_a83t_mipi_csi2_remove(struct platform_device *platform_dev)
-- 
2.34.1

