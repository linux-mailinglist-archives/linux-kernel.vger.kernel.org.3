Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0668B5444CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiFIH2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbiFIH2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:28:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894D4157E87
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:28:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q18so19575452pln.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EU3KV+nUfeIhuNF/Ro7jf0eLAkt330a3bAydA7XSi+w=;
        b=VqbUTr3H73qk7OZZz/TA+W+HpQdKZ3GSi8c1Gz+F66d9XD1DhQZtcZj9tYoGnBFCMH
         9jxzZQrJD2AuqpJhiITLGgJFsgqcH4cZdZ4DMvOA/HAXrFenxq9XEcffHdqI51W5b0+R
         vgKEqD5AT7EuudEvdhCxmhMR6bB4DJJnlMh60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EU3KV+nUfeIhuNF/Ro7jf0eLAkt330a3bAydA7XSi+w=;
        b=uoFmfiziMMoj9CUY17Eje0IW6EcnULeI3Zkphv0JXg4mTbXuzuiig+exytfYx85+Fw
         aCv8sTW8qTlXu8ENxffA4YGSP3FM8XsHfLKhgq/RsHF39aDpWj0WxonHMWu7b9u9lOTE
         Uk/vOS90nuLWB9T459lah4O88ST8heSA24IrcNeu8xVRl3GrwI1MyYhEBDqvHTcccmqL
         Ct/u1kinYGzjtFuZIuJd+nHUV8AVmfanvdQqc81rTTfi77sCGsf+WSdqIMzmsL72E3FR
         eajqpe3wJx/xILFks2nF/iCxybzvyWAHH+7J5ev8gYsdWHdQut7wKzFjbMq0hgPqY9Do
         Hwdg==
X-Gm-Message-State: AOAM531W1aNRzIrpOPOtlI5p0ewY4hzd5WD41E04gHHVyz3UOL3US34C
        RTDSiYAcoob2GOMAacAk+zASJw==
X-Google-Smtp-Source: ABdhPJx0y6DchLUvvk/yuIYEnoMtoscHMuzTnupHjzPr0+cwAebGuaRDhnVQTQoMdt/AcKvuivAq0Q==
X-Received: by 2002:a17:903:24f:b0:15c:e3b8:a640 with SMTP id j15-20020a170903024f00b0015ce3b8a640mr38088332plh.5.1654759691087;
        Thu, 09 Jun 2022 00:28:11 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5119:d95b:c6cd:77fb])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b0016403cae7desm15312221plb.276.2022.06.09.00.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:28:10 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 8/8] drm: Config orientation property if panel provides it
Date:   Thu,  9 Jun 2022 15:27:23 +0800
Message-Id: <20220609072722.3488207-9-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609072722.3488207-1-hsinyi@chromium.org>
References: <20220609072722.3488207-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panel orientation property should be set before drm_dev_register().
Some drm driver calls drm_dev_register() in .bind(). However, most
panels sets orientation property relatively late, mostly in .get_modes()
callback, since this is when they are able to get the connector and
binds the orientation property to it, though the value should be known
when the panel is probed.

In drm_bridge_connector_init(), if a bridge is a panel bridge, use it to
set the connector's panel orientation property.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v6->v7: remove redundant check and fix config issue.
---
 drivers/gpu/drm/bridge/panel.c         | 34 ++++++++++++++++++++++++++
 drivers/gpu/drm/drm_bridge_connector.c |  8 +++++-
 include/drm/drm_bridge.h               | 14 +++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 0ee563eb2b6f9..4277bf4f032be 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -170,6 +170,19 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.debugfs_init = panel_bridge_debugfs_init,
 };
 
+/**
+ * drm_bridge_is_panel - Checks if a drm_bridge is a panel_bridge.
+ *
+ * @bridge: The drm_bridge to be checked.
+ *
+ * Returns true if the bridge is a panel bridge, or false otherwise.
+ */
+bool drm_bridge_is_panel(const struct drm_bridge *bridge)
+{
+	return bridge->funcs == &panel_bridge_bridge_funcs;
+}
+EXPORT_SYMBOL(drm_bridge_is_panel);
+
 /**
  * drm_panel_bridge_add - Creates a &drm_bridge and &drm_connector that
  * just calls the appropriate functions from &drm_panel.
@@ -269,6 +282,27 @@ void drm_panel_bridge_remove(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_panel_bridge_remove);
 
+/**
+ * drm_panel_bridge_set_orientation - Set the connector's panel orientation
+ * from the bridge that can be transformed to panel bridge.
+ *
+ * @connector: The connector to be set panel orientation.
+ * @bridge: The drm_bridge to be transformed to panel bridge.
+ *
+ * Returns 0 on success, negative errno on failure.
+ */
+int drm_panel_bridge_set_orientation(struct drm_connector *connector,
+				     struct drm_bridge *bridge)
+{
+	struct panel_bridge *panel_bridge;
+
+	panel_bridge = drm_bridge_to_panel_bridge(bridge);
+
+	return drm_connector_set_orientation_from_panel(connector,
+							panel_bridge->panel);
+}
+EXPORT_SYMBOL(drm_panel_bridge_set_orientation);
+
 static void devm_drm_panel_bridge_release(struct device *dev, void *res)
 {
 	struct drm_bridge **bridge = res;
diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 6b3dad03d77d0..1c7d936523df5 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -331,7 +331,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct drm_bridge_connector *bridge_connector;
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
-	struct drm_bridge *bridge;
+	struct drm_bridge *bridge, *panel_bridge = NULL;
 	int connector_type;
 
 	bridge_connector = kzalloc(sizeof(*bridge_connector), GFP_KERNEL);
@@ -373,6 +373,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 		if (bridge->ddc)
 			ddc = bridge->ddc;
+
+		if (drm_bridge_is_panel(bridge))
+			panel_bridge = bridge;
 	}
 
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown) {
@@ -392,6 +395,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		connector->polled = DRM_CONNECTOR_POLL_CONNECT
 				  | DRM_CONNECTOR_POLL_DISCONNECT;
 
+	if (panel_bridge)
+		drm_panel_bridge_set_orientation(connector, panel_bridge);
+
 	return connector;
 }
 EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index f27b4060faa2f..bd11bbe5e9b33 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -917,16 +917,30 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 			   enum drm_connector_status status);
 
 #ifdef CONFIG_DRM_PANEL_BRIDGE
+bool drm_bridge_is_panel(const struct drm_bridge *bridge);
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
 struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
 					      u32 connector_type);
 void drm_panel_bridge_remove(struct drm_bridge *bridge);
+int drm_panel_bridge_set_orientation(struct drm_connector *connector,
+                                     struct drm_bridge *bridge);
 struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
 					     struct drm_panel *panel);
 struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
 						   struct drm_panel *panel,
 						   u32 connector_type);
 struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge);
+#else
+static inline bool drm_bridge_is_panel(const struct drm_bridge *bridge)
+{
+	return false;
+}
+
+static inline int drm_panel_bridge_set_orientation(struct drm_connector *connector,
+						   struct drm_bridge *bridge)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
-- 
2.36.1.255.ge46751e96f-goog

