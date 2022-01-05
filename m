Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CC6484FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbiAEJIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbiAEJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:08:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557F2C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 01:08:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AB3D01F4415F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641373691;
        bh=I67Uv6Cy2hK+LHIl0VkG9gAWCveyN5g+6PhqqgBQlF4=;
        h=From:To:Cc:Subject:Date:From;
        b=deJgGk+aYuWwoE6VD6TD2Y4B1BZNeA1Sxlue3OKercwINlKi16/pp35GMOyxuzgHP
         M30UWtMgtP1qeMA0y0+Ve710BAPVb0pSvHjIwXoc5mX0be2ywYQB05A8AthH8lKPC8
         SxZclAuUG9FcLh3pVLetygItZazefrR0cWi8yQA8d6x7OCk+nzcDd8j0SPEniyCXRx
         uHEZwqKmpSlh7d4d+NXe0J283xlUe/EnV4PvTFEV11YL+yDHCag5RPZNVYf3QkNaCP
         9AypXaHX3gGG/FCFNK6Gwy8gMqAslv2tELYyTx8DB141fleWTYs4Kj4WyKhWZ3Poya
         Kjo30kcmFEgzA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     a.hajda@samsung.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] drm/bridge: parade-ps8640: Link device to ensure suspend/resume order
Date:   Wed,  5 Jan 2022 10:08:02 +0100
Message-Id: <20220105090802.73564-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entering suspend while the display attached to this bridge is still on
makes the resume sequence to resume the bridge first, display last:
when this happens, we get a timeout while resuming the bridge, as its
MCU will get stuck due to the display being unpowered.

On the other hand, on mt8173-elm, closing the lid makes the display to
get powered off first, bridge last, so at resume time the sequence is
swapped (compared to the first example) and everything just works
as expected.

Add a stateless device link to the DRM device that this bridge belongs
to, ensuring a correct resume sequence and solving the unability to
correctly resume bridge operation in the first mentioned example.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/bridge/parade-ps8640.c | 27 ++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 818704bf5e86..450bc9bdf295 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -102,6 +102,7 @@ struct ps8640 {
 	struct regulator_bulk_data supplies[2];
 	struct gpio_desc *gpio_reset;
 	struct gpio_desc *gpio_powerdown;
+	struct device_link *link;
 	bool pre_enabled;
 };
 
@@ -456,14 +457,36 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
 		return ret;
 	}
 
+	ps_bridge->link = device_link_add(bridge->dev->dev, dev, DL_FLAG_STATELESS);
+	if (!ps_bridge->link) {
+		dev_err(dev, "failed to create device link");
+		ret = -EINVAL;
+		goto err_devlink;
+	}
+
 	/* Attach the panel-bridge to the dsi bridge */
-	return drm_bridge_attach(bridge->encoder, ps_bridge->panel_bridge,
+	ret = drm_bridge_attach(bridge->encoder, ps_bridge->panel_bridge,
 				 &ps_bridge->bridge, flags);
+	if (ret)
+		goto err_bridge_attach;
+
+	return 0;
+
+err_bridge_attach:
+	device_link_del(ps_bridge->link);
+err_devlink:
+	drm_dp_aux_unregister(&ps_bridge->aux);
+
+	return ret;
 }
 
 static void ps8640_bridge_detach(struct drm_bridge *bridge)
 {
-	drm_dp_aux_unregister(&bridge_to_ps8640(bridge)->aux);
+	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
+
+	drm_dp_aux_unregister(&ps_bridge->aux);
+	if (ps_bridge->link)
+		device_link_del(ps_bridge->link);
 }
 
 static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
-- 
2.33.1

