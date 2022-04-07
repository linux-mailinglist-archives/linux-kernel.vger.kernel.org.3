Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC44F7BBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243814AbiDGJg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243820AbiDGJg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:36:26 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961C58F9A7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:34:26 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4F6FE240003;
        Thu,  7 Apr 2022 09:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649324064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1QZGZ1l8/R6LZhl//SEGQRr/cjfdJ4XRWOzBWhSBo4I=;
        b=E0RlPrFXWSHAXPNxV2G21nu0veHQpr26sTTRKSYUb1XKBVxKJVi4xUpdsBFHnjoWGApEUC
        umKFnAhmhvCBpt+LvvamJ8rkTiq+WMqwcBagV2COABEPuDEcp23nx7LNZSQOjzZGqnzY3S
        XMZYEaIJAbX/azduTrkHP1SHWwxzGmG2iPmifpxpFjzUzNW3fZFyyBns7bRD8t4N0fhBDt
        RL2rsXPfW2eCcQbokZ/s0x2KwpEyG8zcv/JSPaTp4qJaI3a4aT2DtfnCD5HSOLqzqU8M83
        v4oV3rOV13JSuHv6MsmVl/aIZhJc0HTie6N+OdeS7WQAb1ISSXkRUSWPvijwlA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] drm: of: Improve error handling in bridge/panel detection
Date:   Thu,  7 Apr 2022 11:34:08 +0200
Message-Id: <20220407093408.1478769-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the previous rework of drm_of_find_panel_or_bridge only
-EPROBE_DEFER is returned while previous behavior allowed -ENODEV
to be returned when the port/endpoint is either missing or unavailable.

Make the default return code of the function -ENODEV to handle this and
only return -EPROBE_DEFER in find_panel_or_bridge when the of device is
available but not yet registered. Also return the error code whenever
the remote node exists to avoid checking for child nodes.

Checking child nodes could result in -EPROBE_DEFER returned by
find_panel_or_bridge with an unrelated child node that would overwrite
a legitimate -ENODEV from find_panel_or_bridge if the remote node from
the of graph is unavailable. This happens because find_panel_or_bridge
has no way to distinguish between a legitimate panel/bridge node that
isn't yet registered and an unrelated node.

Add comments around to clarify this behavior.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Fixes: 67bae5f28c89 ("drm: of: Properly try all possible cases for bridge/panel detection")
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

---
 drivers/gpu/drm/drm_of.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 8716da6369a6..97ea9d2016ff 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -223,6 +223,9 @@ static int find_panel_or_bridge(struct device_node *node,
 				struct drm_panel **panel,
 				struct drm_bridge **bridge)
 {
+	if (!of_device_is_available(node))
+		return -ENODEV;
+
 	if (panel) {
 		*panel = of_drm_find_panel(node);
 		if (!IS_ERR(*panel))
@@ -265,7 +268,7 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 				struct drm_bridge **bridge)
 {
 	struct device_node *node;
-	int ret;
+	int ret = -ENODEV;
 
 	if (!panel && !bridge)
 		return -EINVAL;
@@ -282,8 +285,12 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 			ret = find_panel_or_bridge(node, panel, bridge);
 			of_node_put(node);
 
-			if (!ret)
-				return 0;
+			/*
+			 * If the graph/remote node is present we consider it
+			 * to be the legitimate candidate here and return
+			 * whatever code we got from find_panel_or_bridge.
+			 */
+			return ret;
 		}
 	}
 
@@ -296,12 +303,18 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 		ret = find_panel_or_bridge(node, panel, bridge);
 		of_node_put(node);
 
-		/* Stop at the first found occurrence. */
+		/*
+		 * Note that an unrelated (available) child node will cause
+		 * find_panel_or_bridge to return -EPROBE_DEFER because there
+		 * is no way to distinguish the node from a legitimate
+		 * panel/bridge that didn't register yet. Keep iterating nodes
+		 * and only return on the first found occurrence.
+		 */
 		if (!ret)
 			return 0;
 	}
 
-	return -EPROBE_DEFER;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
 
-- 
2.35.1

