Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74771481123
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbhL2I6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:58:51 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:49489 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbhL2I6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:58:50 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 2UnFnTsapMxZu2UnFnMfwb; Wed, 29 Dec 2021 09:58:49 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 29 Dec 2021 09:58:49 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, marex@denx.de, frieder.schrempf@kontron.de,
        linus.walleij@linaro.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] drm/bridge: sn65dsi83: Fix an error handling path in sn65dsi83_probe()
Date:   Wed, 29 Dec 2021 09:58:44 +0100
Message-Id: <4bc21aed4b60d3d5ac4b28d8b07a6fdd8da6a536.1640768126.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sn65dsi83_parse_dt() takes a reference on 'ctx->host_node' that must be
released in the error handling path of this function and of the probe.
This is only done in the remove function up to now.

Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: add error handling in sn65dsi83_parse_dt() [Laurent Pinchart]
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 32 +++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 945f08de45f1..314a84ffcea3 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -560,10 +560,14 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
 	ctx->host_node = of_graph_get_remote_port_parent(endpoint);
 	of_node_put(endpoint);
 
-	if (ctx->dsi_lanes < 0 || ctx->dsi_lanes > 4)
-		return -EINVAL;
-	if (!ctx->host_node)
-		return -ENODEV;
+	if (ctx->dsi_lanes < 0 || ctx->dsi_lanes > 4) {
+		ret = -EINVAL;
+		goto err_put_node;
+	}
+	if (!ctx->host_node) {
+		ret = -ENODEV;
+		goto err_put_node;
+	}
 
 	ctx->lvds_dual_link = false;
 	ctx->lvds_dual_link_even_odd_swap = false;
@@ -590,16 +594,22 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
 
 	ret = drm_of_find_panel_or_bridge(dev->of_node, 2, 0, &panel, &panel_bridge);
 	if (ret < 0)
-		return ret;
+		goto err_put_node;
 	if (panel) {
 		panel_bridge = devm_drm_panel_bridge_add(dev, panel);
-		if (IS_ERR(panel_bridge))
-			return PTR_ERR(panel_bridge);
+		if (IS_ERR(panel_bridge)) {
+			ret = PTR_ERR(panel_bridge);
+			goto err_put_node;
+		}
 	}
 
 	ctx->panel_bridge = panel_bridge;
 
 	return 0;
+
+err_put_node:
+	of_node_put(ctx->host_node);
+	return ret;
 }
 
 static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
@@ -673,8 +683,10 @@ static int sn65dsi83_probe(struct i2c_client *client,
 		return ret;
 
 	ctx->regmap = devm_regmap_init_i2c(client, &sn65dsi83_regmap_config);
-	if (IS_ERR(ctx->regmap))
-		return PTR_ERR(ctx->regmap);
+	if (IS_ERR(ctx->regmap)) {
+		ret = PTR_ERR(ctx->regmap);
+		goto err_put_node;
+	}
 
 	dev_set_drvdata(dev, ctx);
 	i2c_set_clientdata(client, ctx);
@@ -691,6 +703,8 @@ static int sn65dsi83_probe(struct i2c_client *client,
 
 err_remove_bridge:
 	drm_bridge_remove(&ctx->bridge);
+err_put_node:
+	of_node_put(ctx->host_node);
 	return ret;
 }
 
-- 
2.32.0

