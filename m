Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD60480DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 23:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhL1Whc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 17:37:32 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:50089 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhL1Whc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 17:37:32 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 2L5ynCkAhV2Y12L5zn4FXZ; Tue, 28 Dec 2021 23:37:30 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 28 Dec 2021 23:37:30 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, marex@denx.de, linus.walleij@linaro.org,
        frieder.schrempf@kontron.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/bridge: sn65dsi83: Fix an error handling path in sn65dsi83_probe()
Date:   Tue, 28 Dec 2021 23:37:25 +0100
Message-Id: <16e7c6e94a61e6fc2d65db61620955c388798dbb.1640730512.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sn65dsi83_parse_dt() takes a reference on 'ctx->host_node' that must be
released in the error handling path of the probe.
This is only done in the remove function up to now.

Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 945f08de45f1..6edea9f8f8c4 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -673,8 +673,10 @@ static int sn65dsi83_probe(struct i2c_client *client,
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
@@ -691,6 +693,8 @@ static int sn65dsi83_probe(struct i2c_client *client,
 
 err_remove_bridge:
 	drm_bridge_remove(&ctx->bridge);
+err_put_node:
+	of_node_put(ctx->host_node);
 	return ret;
 }
 
-- 
2.32.0

