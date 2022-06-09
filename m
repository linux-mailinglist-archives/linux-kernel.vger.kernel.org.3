Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD275444CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbiFIH1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239990AbiFIH1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:27:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7695F166D5F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:27:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t2so19603321pld.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSY8PN7v8lUTRFzxoXQ+q0czheJOMexRG2Ekt+dl1cw=;
        b=STJ78LHWIq3C6SkgzJ/vmNYE8VNnAJLKUqWHPZRVIUmZBSKT92GoA4MlA2UUn+zELj
         Hecy+rWHtXRTwVJWiNpg4XrX00FawpR2IH3ajUFEBTJ39rvjrxyMYGCLADFePJ90Fxl+
         vrYyOqQ1njaCv4FURyE3Kxlnv7lisKIFrKmC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSY8PN7v8lUTRFzxoXQ+q0czheJOMexRG2Ekt+dl1cw=;
        b=FWfe7IrszCjTpBqtYDhkntWBsutUM7vOgQVzPYTac0z6S1KOPfxL7VY/4zsXanm3cq
         5pOCBDNI9xcP70rEBznVIVW7jNZkxvGbLTeoVsOU/k7HaTsFwzk1b7qQkvJky5dsoUZV
         5B20tytRDSW6FRrRoVj+S0lrGhnQUdzs/cWyuPM5dHXSWM7Koyq8YvtzLoZlqMAmU7q6
         lFmR3+NDkkjwphm9Rqa4CLQDxX1HLsHtqgaKc2W2jFh2lFPAEM8C04cqTcqsW3AuKXn/
         wrvHRc7jxKl8FMUuyZ9Sq8DQS0igu+50XV6t8ul0Nf5zR3q8+gQwdG2KdobN5UjJQjmC
         Tg/Q==
X-Gm-Message-State: AOAM533mOTWggJIP0EqKZaqygC/XsrVrbgZvTeDoDuvEWnrKD+7qx+k9
        H5QcmiD7qXa3ULXz2pJrejGvvg==
X-Google-Smtp-Source: ABdhPJwo9bGpZq3j3Hg8vWR6yfq0caGSeW49YqnFYPqIpd3sh6CRePqPT5MMChG5397aZoHFHAVPCA==
X-Received: by 2002:a17:902:8b89:b0:168:ab37:3283 with SMTP id ay9-20020a1709028b8900b00168ab373283mr1151222plb.101.1654759659616;
        Thu, 09 Jun 2022 00:27:39 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5119:d95b:c6cd:77fb])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b0016403cae7desm15312221plb.276.2022.06.09.00.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:27:39 -0700 (PDT)
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
Subject: [PATCH v7 1/8] drm/panel: Add an API to allow drm to set orientation from panel
Date:   Thu,  9 Jun 2022 15:27:15 +0800
Message-Id: <20220609072722.3488207-2-hsinyi@chromium.org>
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
v6->v7: remane variable.
---
 drivers/gpu/drm/drm_connector.c | 31 +++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     |  4 ++++
 include/drm/drm_panel.h         |  9 +++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 1c48d162c77e3..ab066a063f3ba 100644
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
@@ -2389,6 +2393,33 @@ int drm_connector_set_panel_orientation_with_quirk(
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
+	enum drm_panel_orientation orientation;
+
+	if (panel && panel->funcs && panel->funcs->get_orientation)
+		orientation = panel->funcs->get_orientation(panel);
+	else
+		orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+
+	return drm_connector_set_panel_orientation(connector, orientation);
+}
+EXPORT_SYMBOL(drm_connector_set_orientation_from_panel);
+
 static const struct drm_prop_enum_list privacy_screen_enum[] = {
 	{ PRIVACY_SCREEN_DISABLED,		"Disabled" },
 	{ PRIVACY_SCREEN_ENABLED,		"Enabled" },
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 3ac4bf87f2571..94b422b55cc1f 100644
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
index d279ee455f014..3a271128c0784 100644
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

