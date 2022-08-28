Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06A35A3E37
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiH1PL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 11:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiH1PL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 11:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFBB30575
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661699485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IB2nJEgvsPN0rLqZOSC1GXntDBa4WoVJaMi4z7UfUCE=;
        b=VlgnrHU8ZnLcSW7cYp7G2MnEbluEHJ6U7WMyFpLBmgNQM2tzLddMRLowa7v8C9DXBXGV0g
        0myy+vGWDBmRx13cZfk49XDuR52fkWUdMcBmYRZog89hpVhj+MO4dcCZ7ap4LSLUE162Rr
        1E85vxtVR1lfCp6ukp1IGTMahvNiJMM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-oG7YzrPiNlewbINx4m2-YQ-1; Sun, 28 Aug 2022 11:11:24 -0400
X-MC-Unique: oG7YzrPiNlewbINx4m2-YQ-1
Received: by mail-oi1-f200.google.com with SMTP id x17-20020a056808145100b00344f0608cbaso1611100oiv.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=IB2nJEgvsPN0rLqZOSC1GXntDBa4WoVJaMi4z7UfUCE=;
        b=aempXQ1udHpB1/xHuQEnPRhSetBrD784cOLAfRqCmXT72TelBDXQBidO38CWgMIcJD
         cvCDN61lRWIRGpUe43+fm8qnnzWVzPtc45lBXVHtGI+gi+egdY/Nh6lm8Ng5F7Ko/jSJ
         eGUMwQf+RKUBwdq4MToHPuAQwyfuFJP6zQ6Q4UGNTsmsJf3N2CBF/Lna/RT3xo6vfGZt
         6EBAjAPHR5jvlridGU3myE12kV/Tjal7OJaWXaflSfe3WfhXziPjKd8YiI8jjkfICsPf
         LwEn+rgCpyMH1zx0yz+P2725YnTWQZOwdlPBRXF1H7XT38fiCf/+tFQVOY6cNZWCJMZX
         ZkhA==
X-Gm-Message-State: ACgBeo1Lf7ubH0rCNzxykzv+J12TukSe+B2txR0s2kQcxv7bbfbp1fwq
        6nom8TY+DL6gw91yBv3Oh8aoD2mmcwOfGU29EwqGf7ah/7HNp0Rk8vdxqmQCUIU6OMRYF472eKY
        gQJxTWqNQSR12LTo5Y/MQRhrMEB5I7L/HmAcfClYSaUGOTZCQ2LM9Szr9wQx4wfxIBLkqhOBWiS
        A=
X-Received: by 2002:a05:6870:2185:b0:11c:e533:e8c6 with SMTP id l5-20020a056870218500b0011ce533e8c6mr5759190oae.135.1661699482855;
        Sun, 28 Aug 2022 08:11:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6mRVyYutJEgVjXkVAKsmbHDH7m+LvXYBleBhNnI82Kpd4bpOCXsOjtn9eppEdIG59mBDC6iA==
X-Received: by 2002:a05:6870:2185:b0:11c:e533:e8c6 with SMTP id l5-20020a056870218500b0011ce533e8c6mr5759174oae.135.1661699482424;
        Sun, 28 Aug 2022 08:11:22 -0700 (PDT)
Received: from minerva.. ([181.120.137.43])
        by smtp.gmail.com with ESMTPSA id l17-20020a0568301d7100b0063696cbb6bdsm4109392oti.62.2022.08.28.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 08:11:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Replace simple display helpers with the atomic helpers
Date:   Sun, 28 Aug 2022 17:11:14 +0200
Message-Id: <20220828151114.1141510-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple display pipeline is a set of helpers that can be used by DRM
drivers to avoid dealing with all the needed components and just define
a few functions to operate a simple display device with one full-screen
scanout buffer feeding a single output.

But it is arguable that this provides the correct level of abstraction
for simple drivers, and recently some have been ported from using these
simple display helpers to use the regular atomic helpers instead.

The rationale for this is that the simple display pipeline helpers don't
hide that much of the DRM complexity, while adding an indirection layer
that conflates the concepts of CRTCs and planes. This makes the helpers
less flexible and harder to be reused among different graphics drivers.

Also, for simple drivers, using the full atomic helpers doesn't require
a lot of additional code. So adding a simple display pipeline layer may
not be worth it.

For these reasons, let's follow that trend and make ssd130x a plain DRM
driver that creates its own primary plane, CRTC, enconder and connector.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 258 +++++++++++++++++++++---------
 drivers/gpu/drm/solomon/ssd130x.h |   9 +-
 2 files changed, 187 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index f87f5443e714..0ae17fcceb7c 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -18,6 +18,7 @@
 #include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_edid.h>
@@ -564,61 +565,56 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_m
 	return ret;
 }
 
-static int ssd130x_display_pipe_mode_valid(struct drm_simple_display_pipe *pipe,
-					   const struct drm_display_mode *mode)
+static int ssd130x_primary_plane_helper_atomic_check(struct drm_plane *plane,
+						     struct drm_atomic_state *new_state)
 {
-	struct ssd130x_device *ssd130x = drm_to_ssd130x(pipe->crtc.dev);
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
+	struct drm_crtc *new_crtc = new_plane_state->crtc;
+	struct drm_crtc_state *new_crtc_state = NULL;
 
-	if (mode->hdisplay != ssd130x->mode.hdisplay &&
-	    mode->vdisplay != ssd130x->mode.vdisplay)
-		return MODE_ONE_SIZE;
-
-	if (mode->hdisplay != ssd130x->mode.hdisplay)
-		return MODE_ONE_WIDTH;
-
-	if (mode->vdisplay != ssd130x->mode.vdisplay)
-		return MODE_ONE_HEIGHT;
+	if (new_crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(new_state, new_crtc);
 
-	return MODE_OK;
+	return drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
 }
 
-static void ssd130x_display_pipe_enable(struct drm_simple_display_pipe *pipe,
-					struct drm_crtc_state *crtc_state,
-					struct drm_plane_state *plane_state)
+static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
+						       struct drm_atomic_state *old_state)
 {
-	struct ssd130x_device *ssd130x = drm_to_ssd130x(pipe->crtc.dev);
+	struct drm_plane_state *plane_state = plane->state;
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(old_state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
-	struct drm_device *drm = &ssd130x->drm;
-	int idx, ret;
+	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_device *drm = plane->dev;
+	struct drm_rect src_clip, dst_clip;
+	int idx;
 
-	ret = ssd130x_power_on(ssd130x);
-	if (ret)
+	if (!fb)
 		return;
 
-	ret = ssd130x_init(ssd130x);
-	if (ret)
-		goto out_power_off;
-
-	if (!drm_dev_enter(drm, &idx))
-		goto out_power_off;
+	if (!drm_atomic_helper_damage_merged(old_plane_state, plane_state, &src_clip))
+		return;
 
-	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &plane_state->dst);
+	dst_clip = plane_state->dst;
+	if (!drm_rect_intersect(&dst_clip, &src_clip))
+		return;
 
-	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_ON);
+	if (!drm_dev_enter(drm, &idx))
+		return;
 
-	backlight_enable(ssd130x->bl_dev);
+	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &dst_clip);
 
 	drm_dev_exit(idx);
-
-	return;
-out_power_off:
-	ssd130x_power_off(ssd130x);
 }
 
-static void ssd130x_display_pipe_disable(struct drm_simple_display_pipe *pipe)
+static void ssd130x_primary_plane_helper_atomic_disable(struct drm_plane *plane,
+							struct drm_atomic_state *old_state)
 {
-	struct ssd130x_device *ssd130x = drm_to_ssd130x(pipe->crtc.dev);
-	struct drm_device *drm = &ssd130x->drm;
+	struct drm_device *drm = plane->dev;
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
 	int idx;
 
 	if (!drm_dev_enter(drm, &idx))
@@ -626,56 +622,114 @@ static void ssd130x_display_pipe_disable(struct drm_simple_display_pipe *pipe)
 
 	ssd130x_clear_screen(ssd130x);
 
-	backlight_disable(ssd130x->bl_dev);
+	drm_dev_exit(idx);
+}
 
-	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_OFF);
+static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = ssd130x_primary_plane_helper_atomic_check,
+	.atomic_update = ssd130x_primary_plane_helper_atomic_update,
+	.atomic_disable = ssd130x_primary_plane_helper_atomic_disable,
+};
 
-	ssd130x_power_off(ssd130x);
+static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
 
-	drm_dev_exit(idx);
+static enum drm_mode_status ssd130x_crtc_helper_mode_valid(struct drm_crtc *crtc,
+							   const struct drm_display_mode *mode)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(crtc->dev);
+
+	if (mode->hdisplay != ssd130x->mode.hdisplay &&
+	    mode->vdisplay != ssd130x->mode.vdisplay)
+		return MODE_ONE_SIZE;
+	else if (mode->hdisplay != ssd130x->mode.hdisplay)
+		return MODE_ONE_WIDTH;
+	else if (mode->vdisplay != ssd130x->mode.vdisplay)
+		return MODE_ONE_HEIGHT;
+
+	return MODE_OK;
 }
 
-static void ssd130x_display_pipe_update(struct drm_simple_display_pipe *pipe,
-					struct drm_plane_state *old_plane_state)
+static int ssd130x_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					    struct drm_atomic_state *new_state)
 {
-	struct ssd130x_device *ssd130x = drm_to_ssd130x(pipe->crtc.dev);
-	struct drm_plane_state *plane_state = pipe->plane.state;
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
-	struct drm_framebuffer *fb = plane_state->fb;
-	struct drm_device *drm = &ssd130x->drm;
-	struct drm_rect src_clip, dst_clip;
-	int idx;
+	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(new_state, crtc);
+	int ret;
 
-	if (!fb)
-		return;
+	ret = drm_atomic_helper_check_crtc_state(new_crtc_state, false);
+	if (ret)
+		return ret;
 
-	if (!pipe->crtc.state->active)
-		return;
+	return drm_atomic_add_affected_planes(new_state, crtc);
+}
 
-	if (!drm_atomic_helper_damage_merged(old_plane_state, plane_state, &src_clip))
-		return;
+/*
+ * The CRTC is always enabled. Screen updates are performed by
+ * the primary plane's atomic_update function. Disabling clears
+ * the screen in the primary plane's atomic_disable function.
+ */
+static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs = {
+	.mode_valid = ssd130x_crtc_helper_mode_valid,
+	.atomic_check = ssd130x_crtc_helper_atomic_check,
+};
 
-	dst_clip = plane_state->dst;
-	if (!drm_rect_intersect(&dst_clip, &src_clip))
-		return;
+static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
+	.reset = drm_atomic_helper_crtc_reset,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
 
-	if (!drm_dev_enter(drm, &idx))
+static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
+						 struct drm_atomic_state *state)
+{
+	struct drm_device *drm = encoder->dev;
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
+	int ret;
+
+	ret = ssd130x_power_on(ssd130x);
+	if (ret)
 		return;
 
-	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &dst_clip);
+	ret = ssd130x_init(ssd130x);
+	if (ret)
+		return ssd130x_power_off(ssd130x);
 
-	drm_dev_exit(idx);
+	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_ON);
+
+	backlight_enable(ssd130x->bl_dev);
 }
 
-static const struct drm_simple_display_pipe_funcs ssd130x_pipe_funcs = {
-	.mode_valid = ssd130x_display_pipe_mode_valid,
-	.enable = ssd130x_display_pipe_enable,
-	.disable = ssd130x_display_pipe_disable,
-	.update = ssd130x_display_pipe_update,
-	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
+static void ssd130x_encoder_helper_atomic_disable(struct drm_encoder *encoder,
+						  struct drm_atomic_state *state)
+{
+	struct drm_device *drm = encoder->dev;
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
+
+	backlight_disable(ssd130x->bl_dev);
+
+	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_OFF);
+
+	ssd130x_power_off(ssd130x);
+}
+
+static const struct drm_encoder_helper_funcs ssd130x_encoder_helper_funcs = {
+	.atomic_enable = ssd130x_encoder_helper_atomic_enable,
+	.atomic_disable = ssd130x_encoder_helper_atomic_disable,
+};
+
+static const struct drm_encoder_funcs ssd130x_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
-static int ssd130x_connector_get_modes(struct drm_connector *connector)
+static int ssd130x_connector_helper_get_modes(struct drm_connector *connector)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(connector->dev);
 	struct drm_display_mode *mode;
@@ -695,7 +749,7 @@ static int ssd130x_connector_get_modes(struct drm_connector *connector)
 }
 
 static const struct drm_connector_helper_funcs ssd130x_connector_helper_funcs = {
-	.get_modes = ssd130x_connector_get_modes,
+	.get_modes = ssd130x_connector_helper_get_modes,
 };
 
 static const struct drm_connector_funcs ssd130x_connector_funcs = {
@@ -806,8 +860,16 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
 	struct device *dev = ssd130x->dev;
 	struct drm_device *drm = &ssd130x->drm;
 	unsigned long max_width, max_height;
+	struct drm_plane *primary_plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder *encoder;
+	struct drm_connector *connector;
 	int ret;
 
+	/*
+	 * Modesetting
+	 */
+
 	ret = drmm_mode_config_init(drm);
 	if (ret) {
 		dev_err(dev, "DRM mode config init failed: %d\n", ret);
@@ -833,25 +895,65 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
 	drm->mode_config.preferred_depth = 32;
 	drm->mode_config.funcs = &ssd130x_mode_config_funcs;
 
-	ret = drm_connector_init(drm, &ssd130x->connector, &ssd130x_connector_funcs,
+	/* Primary plane */
+
+	primary_plane = &ssd130x->primary_plane;
+	ret = drm_universal_plane_init(drm, primary_plane, 0, &ssd130x_primary_plane_funcs,
+				       ssd130x_formats, ARRAY_SIZE(ssd130x_formats),
+				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret) {
+		dev_err(dev, "DRM primary plane init failed: %d\n", ret);
+		return ret;
+	}
+
+	drm_plane_helper_add(primary_plane, &ssd130x_primary_plane_helper_funcs);
+
+	drm_plane_enable_fb_damage_clips(primary_plane);
+
+	/* CRTC */
+
+	crtc = &ssd130x->crtc;
+	ret = drm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
+					&ssd130x_crtc_funcs, NULL);
+	if (ret) {
+		dev_err(dev, "DRM crtc init failed: %d\n", ret);
+		return ret;
+	}
+
+	drm_crtc_helper_add(crtc, &ssd130x_crtc_helper_funcs);
+
+	/* Encoder */
+
+	encoder = &ssd130x->encoder;
+	ret = drm_encoder_init(drm, encoder, &ssd130x_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret) {
+		dev_err(dev, "DRM encoder init failed: %d\n", ret);
+		return ret;
+	}
+
+	drm_encoder_helper_add(encoder, &ssd130x_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	/* Connector */
+
+	connector = &ssd130x->connector;
+	ret = drm_connector_init(drm, connector, &ssd130x_connector_funcs,
 				 DRM_MODE_CONNECTOR_Unknown);
 	if (ret) {
 		dev_err(dev, "DRM connector init failed: %d\n", ret);
 		return ret;
 	}
 
-	drm_connector_helper_add(&ssd130x->connector, &ssd130x_connector_helper_funcs);
+	drm_connector_helper_add(connector, &ssd130x_connector_helper_funcs);
 
-	ret = drm_simple_display_pipe_init(drm, &ssd130x->pipe, &ssd130x_pipe_funcs,
-					   ssd130x_formats, ARRAY_SIZE(ssd130x_formats),
-					   NULL, &ssd130x->connector);
+	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret) {
-		dev_err(dev, "DRM simple display pipeline init failed: %d\n", ret);
+		dev_err(dev, "DRM attach connector to encoder failed: %d\n", ret);
 		return ret;
 	}
 
-	drm_plane_enable_fb_damage_clips(&ssd130x->pipe.plane);
-
 	drm_mode_config_reset(drm);
 
 	return 0;
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index 4c4a84e962e7..03038c1b6476 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -13,8 +13,11 @@
 #ifndef __SSD1307X_H__
 #define __SSD1307X_H__
 
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_plane_helper.h>
 
 #include <linux/regmap.h>
 
@@ -42,8 +45,10 @@ struct ssd130x_deviceinfo {
 struct ssd130x_device {
 	struct drm_device drm;
 	struct device *dev;
-	struct drm_simple_display_pipe pipe;
 	struct drm_display_mode mode;
+	struct drm_plane primary_plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	struct drm_connector connector;
 	struct i2c_client *client;
 
-- 
2.37.1

