Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D344AA4F2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378726AbiBEAOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378698AbiBEAOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:14:14 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28064DF8C1BD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 16:14:11 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 132so6310501pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 16:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yhbxh7kkqGGusGWBNx2mCA04d+nWExRaG4eT8COW5H4=;
        b=lW6XJL1GStnh11sxE6c3AEle1jPDq08bgs8pl3Qpl/pK4zYtnr+ztxBX07afHyB6nu
         wSLkzJT/NtirEqBGto3hq3t4fbxaHfhHfEj7wRY6raIcpc0Jpb5eG0m4HIIvOxX+Ez6v
         QTdow9MsyanB+ZzJUlBgqSf5f9qWQJEzMJwPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yhbxh7kkqGGusGWBNx2mCA04d+nWExRaG4eT8COW5H4=;
        b=ldW7XZdC+2CjxxlsZgFSLmQRvCvHlwgzQ3OIqOXTkjx0OS8J0xq5kLqgAZBozUFoQ0
         kYgdmV32ffbveg3RpUvHPU6I7V0fcf1o1KH47V3PIcby70GL2OmB5bawifV1QSUgPGt6
         M37Sqo7R29DPkPHgfhgu77EtkRUHl553WDctvI/7oW0gQbCu9TQX/mbwkKqpd1643XjW
         +B2Zpc5jc7B5jDZwCj4uH1Zy8kH1R3xJk9m8SU8z7EVBn41rBmQh6vsGk7wq8wR2glmQ
         Fm9n+l63NXW25tFhoFPCU7bNWlb+PVLqy97rUaqtI4sJbkvOHh+j7C4d8d3stDlnQa0G
         V6DQ==
X-Gm-Message-State: AOAM531JKyNUQy1hZESKNJwNqJienLx7/TV90StCVitJ3vm0GZo9N2nH
        ncbWGT/nczpW3O3ZNChGCU15eg==
X-Google-Smtp-Source: ABdhPJwHbENOYwTwkFtmdn6y83vbJk6FTR1NFcvBdcuuTC/JSeQWcPm1Se3dFMTqcxl6aZvQHwe4dQ==
X-Received: by 2002:a63:690a:: with SMTP id e10mr1171147pgc.599.1644020050659;
        Fri, 04 Feb 2022 16:14:10 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:d668:55ac:a465:88bf])
        by smtp.gmail.com with ESMTPSA id q13sm3720231pfj.44.2022.02.04.16.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 16:14:10 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        robert.foss@linaro.org, lschyi@chromium.org,
        Sam Ravnborg <sam@ravnborg.org>, jjsu@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/bridge: ti-sn65dsi86: Use drm_bridge_connector
Date:   Fri,  4 Feb 2022 16:13:40 -0800
Message-Id: <20220204161245.v2.1.I3ab26b7f197cc56c874246a43e57913e9c2c1028@changeid>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220205001342.3155839-1-dianders@chromium.org>
References: <20220205001342.3155839-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti-sn65dsi86 driver shouldn't hand-roll its own bridge
connector. It should use the normal drm_bridge_connector. Let's switch
to do that, removing all of the custom code.

NOTE: this still _doesn't_ implement DRM_BRIDGE_ATTACH_NO_CONNECTOR
support for ti-sn65dsi86 and that would still be a useful thing to do
in the future. It was attempted in the past [1] but put on the back
burner. However, unless we instantly change ti-sn65dsi86 fully from
not supporting DRM_BRIDGE_ATTACH_NO_CONNECTOR at all to _only_
supporting DRM_BRIDGE_ATTACH_NO_CONNECTOR then we'll still need a bit
of time when we support both. This is a better way to support the old
way where the driver hand rolls things itself.

A new notes about the implementation here:
* When using the drm_bridge_connector the connector should be created
  after all the bridges, so we change the ordering a bit.
* I'm reasonably certain that we don't need to do anything to "free"
  the new drm_bridge_connector. If drm_bridge_connector_init() returns
  success then we know drm_connector_init() was called with the
  `drm_bridge_connector_funcs`. The `drm_bridge_connector_funcs` has a
  .destroy() that does all the cleanup. drm_connector_init() calls
  __drm_mode_object_add() with a drm_connector_free() that will call
  the .destroy().
* I'm also reasonably certain that I don't need to "undo" the
  drm_bridge_attach() if drm_bridge_connector_init() fails. The
  "detach" function is private and other similar code doesn't try to
  undo the drm_bridge_attach() in error cases. There's also a comment
  indicating the lack of balance at the top of drm_bridge_attach().

[1] https://lore.kernel.org/r/20210920225801.227211-4-robdclark@gmail.com

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("ti-sn65dsi86: Use drm_bridge_connector") new for v2.

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 72 ++++++---------------------
 1 file changed, 14 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index ba136a188be7..38616aab12ac 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -26,6 +26,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/dp/drm_dp_aux_bus.h>
 #include <drm/dp/drm_dp_helper.h>
 #include <drm/drm_mipi_dsi.h>
@@ -174,7 +175,7 @@ struct ti_sn65dsi86 {
 	struct regmap			*regmap;
 	struct drm_dp_aux		aux;
 	struct drm_bridge		bridge;
-	struct drm_connector		connector;
+	struct drm_connector		*connector;
 	struct device_node		*host_node;
 	struct mipi_dsi_device		*dsi;
 	struct clk			*refclk;
@@ -646,54 +647,6 @@ static struct auxiliary_driver ti_sn_aux_driver = {
 	.id_table = ti_sn_aux_id_table,
 };
 
-/* -----------------------------------------------------------------------------
- * DRM Connector Operations
- */
-
-static struct ti_sn65dsi86 *
-connector_to_ti_sn65dsi86(struct drm_connector *connector)
-{
-	return container_of(connector, struct ti_sn65dsi86, connector);
-}
-
-static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
-{
-	struct ti_sn65dsi86 *pdata = connector_to_ti_sn65dsi86(connector);
-
-	return drm_bridge_get_modes(pdata->next_bridge, connector);
-}
-
-static struct drm_connector_helper_funcs ti_sn_bridge_connector_helper_funcs = {
-	.get_modes = ti_sn_bridge_connector_get_modes,
-};
-
-static const struct drm_connector_funcs ti_sn_bridge_connector_funcs = {
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-};
-
-static int ti_sn_bridge_connector_init(struct ti_sn65dsi86 *pdata)
-{
-	int ret;
-
-	ret = drm_connector_init(pdata->bridge.dev, &pdata->connector,
-				 &ti_sn_bridge_connector_funcs,
-				 DRM_MODE_CONNECTOR_eDP);
-	if (ret) {
-		DRM_ERROR("Failed to initialize connector with drm\n");
-		return ret;
-	}
-
-	drm_connector_helper_add(&pdata->connector,
-				 &ti_sn_bridge_connector_helper_funcs);
-	drm_connector_attach_encoder(&pdata->connector, pdata->bridge.encoder);
-
-	return 0;
-}
-
 /*------------------------------------------------------------------------------
  * DRM Bridge
  */
@@ -757,10 +710,6 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
 		return ret;
 	}
 
-	ret = ti_sn_bridge_connector_init(pdata);
-	if (ret < 0)
-		goto err_conn_init;
-
 	/* We never want the next bridge to *also* create a connector: */
 	flags |= DRM_BRIDGE_ATTACH_NO_CONNECTOR;
 
@@ -768,13 +717,20 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
 	ret = drm_bridge_attach(bridge->encoder, pdata->next_bridge,
 				&pdata->bridge, flags);
 	if (ret < 0)
-		goto err_dsi_host;
+		goto err_initted_aux;
+
+	pdata->connector = drm_bridge_connector_init(pdata->bridge.dev,
+						     pdata->bridge.encoder);
+	if (IS_ERR(pdata->connector)) {
+		ret = PTR_ERR(pdata->connector);
+		goto err_initted_aux;
+	}
+
+	drm_connector_attach_encoder(pdata->connector, pdata->bridge.encoder);
 
 	return 0;
 
-err_dsi_host:
-	drm_connector_cleanup(&pdata->connector);
-err_conn_init:
+err_initted_aux:
 	drm_dp_aux_unregister(&pdata->aux);
 	return ret;
 }
@@ -824,7 +780,7 @@ static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
 
 static unsigned int ti_sn_bridge_get_bpp(struct ti_sn65dsi86 *pdata)
 {
-	if (pdata->connector.display_info.bpc <= 6)
+	if (pdata->connector->display_info.bpc <= 6)
 		return 18;
 	else
 		return 24;
-- 
2.35.0.263.gb82422642f-goog

