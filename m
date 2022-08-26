Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EA95A23D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245664AbiHZJLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245728AbiHZJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:11:46 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DBAD6B8D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:11:44 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id C5A1A5208BD;
        Fri, 26 Aug 2022 11:11:41 +0200 (CEST)
Received: from vmlxhi-182.adit-jv.com (10.72.94.19) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Fri, 26 Aug
 2022 11:11:41 +0200
From:   Michael Rodin <mrodin@de.adit-jv.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Michael Rodin <mrodin@de.adit-jv.com>, <michael@rodin.online>,
        <erosca@de.adit-jv.com>
Subject: [PATCH] drm: do not call detect for connectors which are forced on
Date:   Fri, 26 Aug 2022 11:11:21 +0200
Message-ID: <20220826091121.389315-1-mrodin@de.adit-jv.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.94.19]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"detect" should not be called and its return value shall not be used when a
connector is forced as hinted in the commit d50ba256b5f1 ("drm/kms: start
adding command line interface using fb.") and the commit 6fe14acd496e
("drm: Document drm_connector_funcs"). One negative side effect of doing
this is observed on the RCar3 SoCs which use the dw-hdmi driver. It
continues executing drm_helper_hpd_irq_event even if its connector is
forced to ON. As consequence drm_helper_hpd_irq_event calls "detect" so the
connector status is updated to "disconnected":

[  420.201527] [drm:drm_helper_hpd_irq_event] [CONNECTOR:76:HDMI-A-1] status updated from connected to disconnected

This status is corrected by drm_helper_probe_single_connector_modes shortly
after this because this function checks if a connector is forced:

[  420.218703] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:76:HDMI-A-1] status updated from disconnected to connected

To avoid similar issues this commit adapts functions which call "detect"
so they check if a connector is forced and return the correct status.

Fixes: 949f08862d66 ("drm: Make the connector .detect() callback optional")
Signed-off-by: Michael Rodin <mrodin@de.adit-jv.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index bb427c5a4f1f..1691047d0472 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -289,7 +289,12 @@ drm_helper_probe_detect_ctx(struct drm_connector *connector, bool force)
 retry:
 	ret = drm_modeset_lock(&connector->dev->mode_config.connection_mutex, &ctx);
 	if (!ret) {
-		if (funcs->detect_ctx)
+		if (connector->force == DRM_FORCE_ON ||
+		    connector->force == DRM_FORCE_ON_DIGITAL)
+			ret = connector_status_connected;
+		else if (connector->force == DRM_FORCE_OFF)
+			ret = connector_status_disconnected;
+		else if (funcs->detect_ctx)
 			ret = funcs->detect_ctx(connector, &ctx, force);
 		else if (connector->funcs->detect)
 			ret = connector->funcs->detect(connector, force);
@@ -340,7 +345,14 @@ drm_helper_probe_detect(struct drm_connector *connector,
 	if (ret)
 		return ret;
 
-	if (funcs->detect_ctx)
+	if (connector->force == DRM_FORCE_ON ||
+	    connector->force == DRM_FORCE_ON_DIGITAL)
+		ret = connector_status_connected;
+	else if (connector->force == DRM_FORCE_OFF)
+		ret = connector_status_disconnected;
+	else if (funcs->detect_ctx)
+		ret = funcs->detect_ctx(connector, ctx, force);
+	else if (funcs->detect_ctx)
 		ret = funcs->detect_ctx(connector, ctx, force);
 	else if (connector->funcs->detect)
 		ret = connector->funcs->detect(connector, force);
-- 
2.25.1

