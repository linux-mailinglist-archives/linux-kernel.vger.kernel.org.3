Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530F6542C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiFHKGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiFHKFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:05:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FDA14015
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:48:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so20131957pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dk2EVUG101rQm23r/ZlU8mzZDKwDG1KKDCi7n9ZjRd8=;
        b=j8QWqh3VeH6zE+x5CqSxyRP92nBBtths9qDeKi+gqFUHoz2TBsRRzOmCA/dl65TGwX
         /YWZzow5DUgSybhjFdXM6++3qtRpUf+Y3ZTUfD0/hucV8+31RhGlibfVOBG48yYoOvcN
         ChPCccBhnxS9PivqID9+qUOQp1utj7jEqX7+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dk2EVUG101rQm23r/ZlU8mzZDKwDG1KKDCi7n9ZjRd8=;
        b=Y4+VLBTpz88qC/HNW/8nF3QH8dnTqXrUF25ZYDiQkZCYmVmKofz9GvkYLsTNwSrsOR
         4zm3Hi87NV/3LaJp/r1E/annd9DZDXTp20rEUG8GvOqIG0t0af6xpwuAWejpn3m9cXlk
         tgH+sHdwo8Lz2wBXwolJHp5LkXHSpmQlBIlNbe1r2T4YTVLQapk6Ozh4WyVdSy1n1QS3
         0zpg8ozRrdYtZc4jCH8gzRgL3Zt2R/HcttkdbDqEB8EcsdI7NM3CWUNKWZfj3BNtbBF7
         Gyv8HPgSrPPbq5/lMtb7v6LZKLp/HhYtx+mC2Flv//ivwsoWhmufEelgw0Pt1bFV0mOn
         cIYA==
X-Gm-Message-State: AOAM533YE/RbKLfFeaByKH5jFf5tOgku6/LYRAtXeq/N+lboxWbXtssa
        z6CbStV+oyZzVxpbjTTnLUIs5w==
X-Google-Smtp-Source: ABdhPJzyscN4nhpdxlEaz3bHujhJtkfRSWOh9x+gpg+krvUZqaEWRACfaESxbhHHo/6Uk0P45Tdfvg==
X-Received: by 2002:a17:90b:c85:b0:1e2:e645:a8c9 with SMTP id o5-20020a17090b0c8500b001e2e645a8c9mr36464915pjz.185.1654681705655;
        Wed, 08 Jun 2022 02:48:25 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c46b:e7b1:f6c8:5eb8])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a950a00b001e28e80a8d6sm13584038pjo.38.2022.06.08.02.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:48:25 -0700 (PDT)
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
Subject: [PATCH v6 1/8] drm/panel: Add an API to allow drm to set orientation from panel
Date:   Wed,  8 Jun 2022 17:48:09 +0800
Message-Id: <20220608094816.2898692-2-hsinyi@chromium.org>
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

Panels usually call drm_connector_set_panel_orientation(), which is
later than drm/kms driver calling drm_dev_register(). This leads to a
WARN().

The orientation property is known earlier. For example, some panels
parse the property through device tree during probe.

Add an API to return the property from panel to drm/kms driver, so the
drivers are able to call drm_connector_set_orientation_from_panel() before
drm_dev_register().

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/drm_connector.c | 32 ++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     |  4 ++++
 include/drm/drm_panel.h         |  9 +++++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 1c48d162c77e..859165a1c8f1 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -24,6 +24,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_utils.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -2320,6 +2321,9 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
  * It is allowed to call this function with a panel_orientation of
  * DRM_MODE_PANEL_ORIENTATION_UNKNOWN, in which case it is a no-op.
  *
+ * The function shouldn't be called in panel after drm is registered (i.e.
+ * drm_dev_register() is called in drm).
+ *
  * Returns:
  * Zero on success, negative errno on failure.
  */
@@ -2389,6 +2393,34 @@ int drm_connector_set_panel_orientation_with_quirk(
 }
 EXPORT_SYMBOL(drm_connector_set_panel_orientation_with_quirk);
 
+/**
+ * drm_connector_set_orientation_from_panel -
+ * 	set the connector's panel_orientation from panel's callback.
+ * @connector: connector for which to init the panel-orientation property.
+ * @panel: panel that can provide orientation information.
+ *
+ * Drm drivers should call this function before drm_dev_register().
+ * Orientation is obtained from panel's .get_orientation() callback.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_set_orientation_from_panel(
+	struct drm_connector *connector,
+	struct drm_panel *panel)
+{
+	enum drm_panel_orientation panel_orientation;
+
+	if (panel && panel->funcs && panel->funcs->get_orientation)
+		panel_orientation = panel->funcs->get_orientation(panel);
+	else
+		panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+
+	return drm_connector_set_panel_orientation(connector,
+						   panel_orientation);
+}
+EXPORT_SYMBOL(drm_connector_set_orientation_from_panel);
+
 static const struct drm_prop_enum_list privacy_screen_enum[] = {
 	{ PRIVACY_SCREEN_DISABLED,		"Disabled" },
 	{ PRIVACY_SCREEN_ENABLED,		"Enabled" },
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 3ac4bf87f257..94b422b55cc1 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -38,6 +38,7 @@ struct drm_modeset_acquire_ctx;
 struct drm_device;
 struct drm_crtc;
 struct drm_encoder;
+struct drm_panel;
 struct drm_property;
 struct drm_property_blob;
 struct drm_printer;
@@ -1802,6 +1803,9 @@ int drm_connector_set_panel_orientation_with_quirk(
 	struct drm_connector *connector,
 	enum drm_panel_orientation panel_orientation,
 	int width, int height);
+int drm_connector_set_orientation_from_panel(
+	struct drm_connector *connector,
+	struct drm_panel *panel);
 int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 					  int min, int max);
 void drm_connector_create_privacy_screen_properties(struct drm_connector *conn);
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index d279ee455f01..3a271128c078 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -116,6 +116,15 @@ struct drm_panel_funcs {
 	int (*get_modes)(struct drm_panel *panel,
 			 struct drm_connector *connector);
 
+	/**
+	 * @get_orientation:
+	 *
+	 * Return the panel orientation set by device tree or EDID.
+	 *
+	 * This function is optional.
+	 */
+	enum drm_panel_orientation (*get_orientation)(struct drm_panel *panel);
+
 	/**
 	 * @get_timings:
 	 *
-- 
2.36.1.255.ge46751e96f-goog

