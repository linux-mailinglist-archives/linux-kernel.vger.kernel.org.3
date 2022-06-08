Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D780542C99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbiFHKHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiFHKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:05:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F1F196A91
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:48:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so17908775pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEB2zHdExy2JKoB2FnnXWzAZLyF7rSGKqnEw/8nOqCs=;
        b=BFMw6WULQCXhZ0tMZpRPApSUFdvzdpcdbu7DQ5CIROH9eKmlQdSvTvQvryO95/iwNh
         KjlKG2uLJlvDV3lsqovmLOB1RgNHoYkLjGCexXy9vCymrGL+byGXwuwL9r0yXNb0mdcf
         mXOpu12iRggJxkgYZEBDa+j0NDJ2POeM1/G5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEB2zHdExy2JKoB2FnnXWzAZLyF7rSGKqnEw/8nOqCs=;
        b=YcVB2RSQ1NEPzBjf0sP75/uoij/zRdEniSj2jDylw7A3Xn6FXjq5Kv9rI/EUOw/MM/
         3lg+5VrBbeuFFeIT7TKfmJK1FlbTAAtVAAXxT+lpI6gz3JBFS/jHON81xWuSrzsmvIcd
         4JmLR4N91UJbrPDRoxAmJfseBpS49b2neEqJUTEwYZ/KEPcgMB78op+aJh8ufhtSpade
         PzMCZ9gbI3lOMUnxE+fkFKCc5KJJBzPTGZKROdFUTqkIllOy+5K6GvsiO/v2EoKElL5j
         S2NmGPdfuFqqipuo9F8mJe4slSGENd0ZWiI/+HkrPpSKp9LUz8bOeSdGST1yBHHXjvGd
         RCMw==
X-Gm-Message-State: AOAM5306MhbTeKHDC4VkXxJDqSLdr0IRyPPgrzJuLJ7eg5wZUm7Cpade
        xqbGSSyZEABQvFE8FjJbEKKHIg==
X-Google-Smtp-Source: ABdhPJx3PhU71x1q1DzxQGfjWbLB3CXS9FckTrvMBw6DjrgI8cNdYqfg0cuniygWSY3E6OgqeEJ2xg==
X-Received: by 2002:a63:8a44:0:b0:3fc:a1f8:806d with SMTP id y65-20020a638a44000000b003fca1f8806dmr29776837pgd.363.1654681727327;
        Wed, 08 Jun 2022 02:48:47 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c46b:e7b1:f6c8:5eb8])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a950a00b001e28e80a8d6sm13584038pjo.38.2022.06.08.02.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:48:46 -0700 (PDT)
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
Subject: [PATCH v6 8/8] drm: Config orientation property if panel provides it
Date:   Wed,  8 Jun 2022 17:48:16 +0800
Message-Id: <20220608094816.2898692-9-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220608094816.2898692-1-hsinyi@chromium.org>
References: <20220608094816.2898692-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
v5->v6:
mtk_dsi is using panel bridge, we don't need to obtain the panel in
mtk_dsi. Instead, drm_connector_set_orientation_from_panel() can be
called from drm_bridge_connector_init().
---
 drivers/gpu/drm/bridge/panel.c         | 36 ++++++++++++++++++++++++++
 drivers/gpu/drm/drm_bridge_connector.c |  8 +++++-
 include/drm/drm_bridge.h               |  3 +++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 0ee563eb2b6f..53c98cba719b 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -170,6 +170,17 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.debugfs_init = panel_bridge_debugfs_init,
 };
 
+/**
+ * drm_bridge_is_panel - Checks if a drm_bridge is a panel_bridge.
+ *
+ * @bridge: The drm_bridge to be checked.
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
@@ -269,6 +280,31 @@ void drm_panel_bridge_remove(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_panel_bridge_remove);
 
+/**
+ * drm_panel_bridge_set_orientation - Set the connector's panel orientation
+ * if the bridge is a panel bridge.
+ *
+ * @connector: The connector to be set panel orientation.
+ * @bridge: The drm_bridge to be transformed to panel bridge.
+ */
+int drm_panel_bridge_set_orientation(struct drm_connector *connector,
+				     struct drm_bridge *bridge)
+{
+	struct panel_bridge *panel_bridge;
+
+	if (!bridge)
+		return 0;
+
+	if (bridge->funcs != &panel_bridge_bridge_funcs)
+		return 0;
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
index 6b3dad03d77d..1c7d936523df 100644
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
index f27b4060faa2..b0691d728139 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -917,10 +917,13 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
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
-- 
2.36.1.255.ge46751e96f-goog

