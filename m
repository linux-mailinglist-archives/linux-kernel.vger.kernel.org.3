Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081624AA4F0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378053AbiBEAOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378699AbiBEAOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:14:14 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A6D8399EF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 16:14:13 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id n32so6407337pfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 16:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1YXgPQg/QgIjJPLCBmICQvUckRJaQCi5C+VqMeIvS8=;
        b=Sckp/asfIozxW6+xn26hgboYzojlq2fJp0f/cWViFPP5LEVqkjJNujfGR3enGVfekg
         djCvSjwk9cRt3TXxY8kTZjjQ8be4dShkvIEpLPkjvoKx6c1KR4gXhXhm0cNQgCc5i3+z
         hgyEmOmP8sG5U4Ef8pF/jwtlX4AicnYcnoDes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1YXgPQg/QgIjJPLCBmICQvUckRJaQCi5C+VqMeIvS8=;
        b=Qmtz2MZIfr6Tv4ypb7oOWU7dyHTbSacsoBFY0jqXhpj8/UOdF+u2MJvTDt5K3dTs5w
         KgTOvu4HdPSqFr/rfxoaKtNa6wRjTIIZoKsIOtUCT5jP03lCrkjXWDmSLrLSvCsMO6Pl
         aeUwXULwVJJl2WCgaWuUq+93TagMFPDfYFimZePLLYENlNsGF5Qrkw46LOJAburbJjHX
         ojFjTQXi4bZlsxI2D7s0XyK0OjiwPTrzQtdXsM0wNtVRIaLZSdwltMf3XcXpzpTNO6xA
         cR1u8RBqEwtnXY1QQFXmFNWzSrYrO/mHdm1aj2Cd9/atErzVtMiBm8a7TVXQHhOMJxUz
         VOZg==
X-Gm-Message-State: AOAM5331563WYwt55GwdPQPrhT+h7rpoI+Y3mAIg8wnv+8mI2pcsWqJo
        xdF3umB1jQIP+owVJXiriffmOA==
X-Google-Smtp-Source: ABdhPJz+Fkk9gqDAia0auO55LEycSweXxaTCerYWw5xHDV+zLvHydudS8AzzEA9Cikmz2NxmdWE4kQ==
X-Received: by 2002:a63:6b41:: with SMTP id g62mr1194976pgc.538.1644020052438;
        Fri, 04 Feb 2022 16:14:12 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:d668:55ac:a465:88bf])
        by smtp.gmail.com with ESMTPSA id q13sm3720231pfj.44.2022.02.04.16.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 16:14:12 -0800 (PST)
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm: Plumb debugfs_init through to panels
Date:   Fri,  4 Feb 2022 16:13:41 -0800
Message-Id: <20220204161245.v2.2.Ib0bd5346135cbb0b63006b69b61d4c8af6484740@changeid>
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

We'd like panels to be able to add things to debugfs underneath the
connector's directory. Let's plumb it through. A panel will be able to
put things in a "panel" directory under the connector's
directory. Note that debugfs is not ABI and so it's always possible
that the location that the panel gets for its debugfs could change in
the future.

NOTE: this currently only works if you're using a modern
architecture. Specifically the plumbing relies on _both_
drm_bridge_connector and drm_panel_bridge. If you're not using one or
both of these things then things won't be plumbed through.

As a side effect of this change, drm_bridges can also get callbacks to
put stuff underneath the connector's debugfs directory. At the moment
all bridges in the chain have their debugfs_init() called with the
connector's root directory.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("drm: Plumb debugfs_init through to panels") new for v2.

 drivers/gpu/drm/bridge/panel.c         | 12 ++++++++++++
 drivers/gpu/drm/drm_bridge_connector.c | 15 +++++++++++++++
 drivers/gpu/drm/drm_debugfs.c          |  3 +++
 include/drm/drm_bridge.h               |  7 +++++++
 include/drm/drm_connector.h            |  7 +++++++
 include/drm/drm_panel.h                |  8 ++++++++
 6 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index b32295abd9e7..5be057575183 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -138,6 +138,17 @@ static int panel_bridge_get_modes(struct drm_bridge *bridge,
 	return drm_panel_get_modes(panel_bridge->panel, connector);
 }
 
+static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
+				      struct dentry *root)
+{
+	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_panel *panel = panel_bridge->panel;
+
+	root = debugfs_create_dir("panel", root);
+	if (panel->funcs->debugfs_init)
+		panel->funcs->debugfs_init(panel, root);
+}
+
 static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.attach = panel_bridge_attach,
 	.detach = panel_bridge_detach,
@@ -150,6 +161,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
+	.debugfs_init = panel_bridge_debugfs_init,
 };
 
 /**
diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 791379816837..60923cdfe8e1 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -216,6 +216,20 @@ static void drm_bridge_connector_destroy(struct drm_connector *connector)
 	kfree(bridge_connector);
 }
 
+static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
+					      struct dentry *root)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_encoder *encoder = bridge_connector->encoder;
+	struct drm_bridge *bridge;
+
+	list_for_each_entry(bridge, &encoder->bridge_chain, chain_node) {
+		if (bridge->funcs->debugfs_init)
+			bridge->funcs->debugfs_init(bridge, root);
+	}
+}
+
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 	.detect = drm_bridge_connector_detect,
@@ -223,6 +237,7 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.destroy = drm_bridge_connector_destroy,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.debugfs_init = drm_bridge_connector_debugfs_init,
 };
 
 /* -----------------------------------------------------------------------------
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index b0a826489488..7f1b82dbaebb 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -436,6 +436,9 @@ void drm_debugfs_connector_add(struct drm_connector *connector)
 	/* vrr range */
 	debugfs_create_file("vrr_range", S_IRUGO, root, connector,
 			    &vrr_range_fops);
+
+	if (connector->funcs->debugfs_init)
+		connector->funcs->debugfs_init(connector, root);
 }
 
 void drm_debugfs_connector_remove(struct drm_connector *connector)
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 061d87313fac..f27b4060faa2 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -649,6 +649,13 @@ struct drm_bridge_funcs {
 	 * the DRM_BRIDGE_OP_HPD flag in their &drm_bridge->ops.
 	 */
 	void (*hpd_disable)(struct drm_bridge *bridge);
+
+	/**
+	 * @debugfs_init:
+	 *
+	 * Allows bridges to create bridge-specific debugfs files.
+	 */
+	void (*debugfs_init)(struct drm_bridge *bridge, struct dentry *root);
 };
 
 /**
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 64cf5f88c05b..54429dde744a 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1142,6 +1142,13 @@ struct drm_connector_funcs {
 	 * has been received from a source outside the display driver / device.
 	 */
 	void (*oob_hotplug_event)(struct drm_connector *connector);
+
+	/**
+	 * @debugfs_init:
+	 *
+	 * Allows connectors to create connector-specific debugfs files.
+	 */
+	void (*debugfs_init)(struct drm_connector *connector, struct dentry *root);
 };
 
 /**
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 4602f833eb51..1ba2d424a53f 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -29,6 +29,7 @@
 #include <linux/list.h>
 
 struct backlight_device;
+struct dentry;
 struct device_node;
 struct drm_connector;
 struct drm_device;
@@ -125,6 +126,13 @@ struct drm_panel_funcs {
 	 */
 	int (*get_timings)(struct drm_panel *panel, unsigned int num_timings,
 			   struct display_timing *timings);
+
+	/**
+	 * @debugfs_init:
+	 *
+	 * Allows panels to create panels-specific debugfs files.
+	 */
+	void (*debugfs_init)(struct drm_panel *panel, struct dentry *root);
 };
 
 /**
-- 
2.35.0.263.gb82422642f-goog

