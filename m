Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451FE4DC751
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiCQNOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiCQNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:14:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1427ADFF94;
        Thu, 17 Mar 2022 06:13:09 -0700 (PDT)
Received: from Monstersaurus.ksquared.org.uk.beta.tailscale.net (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BC63448F;
        Thu, 17 Mar 2022 14:13:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647522784;
        bh=K6t6ybVcm9ml9nZnpnQaFZ2JXtZPtX0gN85GefxQ+5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMZ1ThbkIs75ThenSdb98d4ISHVFqFegKMXSS7Gw1bfkcjgw3woyYm/gagghSy5UQ
         c85EOWt2S8bOb+VnclEnf5s7MCiJf0SFE4txBROV0NkaYo7mMiE1KuCTsFsEV4S2db
         1daE5wuPctNHIyrznxMqNDhNOui+FMhXlAci09gs=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/3] drm/bridge: ti-sn65dsi86: Implement bridge connector operations
Date:   Thu, 17 Mar 2022 13:12:49 +0000
Message-Id: <20220317131250.1481275-3-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317131250.1481275-1-kieran.bingham+renesas@ideasonboard.com>
References: <20220317131250.1481275-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Implement the bridge connector-related .get_edid() operation, and report
the related bridge capabilities and type.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v1:

- The connector .get_modes() operation doesn't rely on EDID anymore,
  __ti_sn_bridge_get_edid() and ti_sn_bridge_get_edid() got merged
  together
 - Fix on top of Sam Ravnborg's DRM_BRIDGE_STATE_OPS

Changes since v2: [Kieran]
 - Only support EDID on DRM_MODE_CONNECTOR_DisplayPort modes.

Changes since v3: [Kieran]
 - Remove PM calls in ti_sn_bridge_get_edid() and simplify

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index c5f020a2d0d3..910bf3d41d2f 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1134,10 +1134,19 @@ static void ti_sn_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	pm_runtime_put_sync(pdata->dev);
 }
 
+static struct edid *ti_sn_bridge_get_edid(struct drm_bridge *bridge,
+					  struct drm_connector *connector)
+{
+	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
+
+	return drm_get_edid(connector, &pdata->aux.ddc);
+}
+
 static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
 	.attach = ti_sn_bridge_attach,
 	.detach = ti_sn_bridge_detach,
 	.mode_valid = ti_sn_bridge_mode_valid,
+	.get_edid = ti_sn_bridge_get_edid,
 	.atomic_pre_enable = ti_sn_bridge_atomic_pre_enable,
 	.atomic_enable = ti_sn_bridge_atomic_enable,
 	.atomic_disable = ti_sn_bridge_atomic_disable,
@@ -1232,6 +1241,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 	pdata->bridge.type = pdata->next_bridge->type == DRM_MODE_CONNECTOR_DisplayPort
 			   ? DRM_MODE_CONNECTOR_DisplayPort : DRM_MODE_CONNECTOR_eDP;
 
+	if (pdata->bridge.type == DRM_MODE_CONNECTOR_DisplayPort)
+		pdata->bridge.ops = DRM_BRIDGE_OP_EDID;
+
 	drm_bridge_add(&pdata->bridge);
 
 	ret = ti_sn_attach_host(pdata);
-- 
2.32.0

