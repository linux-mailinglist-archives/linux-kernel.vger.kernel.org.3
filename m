Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473AF539F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350557AbiFAISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiFAISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:18:36 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA5F28720
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:18:35 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 7so430876pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6otup5wwDiJiR5+96KYND5483KtpYkBAJdtKoJuyjw=;
        b=BGAvSYU9vjZTkpLSJ7omYSCLkD5rwGC1Zrhe14tzTJ6mJD+IIaL5fUI5zVIvCYI+5u
         O3f/OGU3hXmiYGCIGDMvonGidLU3nu4HPEq+CqlZbJgIDMOLjCYmDLKBo5HvLSpDqxVe
         H1KJgITqR080yv/vNhZy4x0gJZsaELlx3YRkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6otup5wwDiJiR5+96KYND5483KtpYkBAJdtKoJuyjw=;
        b=Ii4aC1MB5Qk3tLAX4FZE4Q4UISp7glQcevdRBtB0+Fv1/bDkdwdYOBctXcG4M46Dad
         iJJlC+WAIQ3Xyb0B2dLdbBb2OItSgoatTnitCbIoRcpkdGtKexHQLmRqcNKpsiPuL22i
         wyD0wgHQaiswrwjdiHE1PCkPDwNax5FUoShlQAUo7UiQuqOF/MeZRAy4M1TMrE5HcJRS
         aJY8mX1rpCP72ZNj4rEZPptU89B9gg4aPb3f3FpVPd6ufRD8vWo9KF9CJppXjCrUWkGe
         c3t/6T65YegXiLrGGJbNUIR+y/x1RedayLxEUiKEK5Kzx0xVj3GX+6BnTZtWgB1bo1UR
         yqAw==
X-Gm-Message-State: AOAM533rYDZzw/U1pDF6brYPFf/qAapT/GWxjcDJSStaoeEqaJbfDnWi
        8rquOn6yJpyVKKO2EoQP6ecMYA==
X-Google-Smtp-Source: ABdhPJxZtG9SxZt0jjn5YoMjm5E41BxQstTom3oWSD4bkT9rz40vuUR4Iqfq9TVHuB+ISGAC/oywrw==
X-Received: by 2002:a05:6a00:850:b0:518:a9b2:1a19 with SMTP id q16-20020a056a00085000b00518a9b21a19mr45874414pfk.75.1654071515261;
        Wed, 01 Jun 2022 01:18:35 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b0050dc7628182sm824680pfo.92.2022.06.01.01.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:18:34 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] drm/panel: Add an API drm_panel_get_orientation() to return panel orientation
Date:   Wed,  1 Jun 2022 16:18:16 +0800
Message-Id: <20220601081823.1038797-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601081823.1038797-1-hsinyi@chromium.org>
References: <20220601081823.1038797-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
drivers are able to call drm_connector_set_panel_orientation() before
drm_dev_register().

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Previous discussion:
https://patchwork.kernel.org/project/linux-mediatek/cover/20220530081910.3947168-1-hsinyi@chromium.org/#24877477
---
 drivers/gpu/drm/drm_panel.c |  8 ++++++++
 include/drm/drm_panel.h     | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index f634371c717a..4a512ca80673 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -223,6 +223,14 @@ int drm_panel_get_modes(struct drm_panel *panel,
 }
 EXPORT_SYMBOL(drm_panel_get_modes);
 
+enum drm_panel_orientation drm_panel_get_orientation(struct drm_panel *panel)
+{
+	if (panel && panel->funcs && panel->funcs->get_orientation)
+		return panel->funcs->get_orientation(panel);
+
+	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+}
+EXPORT_SYMBOL(drm_panel_get_orientation);
 #ifdef CONFIG_OF
 /**
  * of_drm_find_panel - look up a panel using a device tree node
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 1ba2d424a53f..d1bd3be4bbdf 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -133,6 +133,15 @@ struct drm_panel_funcs {
 	 * Allows panels to create panels-specific debugfs files.
 	 */
 	void (*debugfs_init)(struct drm_panel *panel, struct dentry *root);
+
+	/**
+	 * @get_orientation:
+	 *
+	 * Return the panel orientation set by device tree or EDID.
+	 *
+	 * This function is optional.
+	 */
+	enum drm_panel_orientation (*get_orientation)(struct drm_panel *panel);
 };
 
 /**
@@ -195,6 +204,7 @@ int drm_panel_enable(struct drm_panel *panel);
 int drm_panel_disable(struct drm_panel *panel);
 
 int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
+enum drm_panel_orientation drm_panel_get_orientation(struct drm_panel *panel);
 
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);
-- 
2.36.1.255.ge46751e96f-goog

