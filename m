Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A7647E02C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbhLWIKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbhLWIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:10:46 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 00:10:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so9851118wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 00:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkvR1gHSe2IjM5ARC815Kf628ZgjzxkOpI9zgg4nLC0=;
        b=qh2WPW9Y8y6+kjf8icGxT+J/JVRgM7yvr0WY9qXSt0L1B448ofhaSZiR2c9J0MyTPF
         ND9BkmJMTcgj2IMz/5cdxESHk+/inpmTMV0s4n0gnsK2fa2//5QZacUhBRt5Tcpz06rJ
         NGhqldm03XtOv3yewF3mSb7lR8q0NVR9M+Uiq4x+1cRzEICtp8iiT3A15XhPFsEo1hDG
         a+0+2G2gK9qvvaa/ZrhSL6cwhRpj5V028G3N30qQZtnLglxqSqfbX90lCoxdtsRhFrlX
         19xb5CIA8NfnJHvaImiUHZqBwt6Oi2N8kcpDrSFkK6v8JUA7iDwRdFZQhANZVhqSOV02
         rsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkvR1gHSe2IjM5ARC815Kf628ZgjzxkOpI9zgg4nLC0=;
        b=An5yCk0HIiBXNrw+MZsBUx76oq1cldyIWmySBGrWomWsCeY491PwKdZq89bYwaIOMX
         FlRt8+ktSdSYQwv1bNQS7FQbsaQk8qPezZeY1PTWE58cpz11jNHbzohPHFD+S3P88X5Y
         S81xQP1oJq9WXA135KJQyYRPLFI4YdC4p/G2Eqy8kuLWWLkO4TV7yPmdLsMkh5cKSfBU
         RSJIRNf1qlxl7T7b5bzes8jgojzHgEC447WlZRa4XivW1ifvOnyglipO9ahbeCLV0Lau
         ywF80vpHZZhVrqKE/+O80CQy2kNmlhhkFDB6w79tgNbuTsdzCFQ7+CeZGdsl012i9kLe
         B6bQ==
X-Gm-Message-State: AOAM531AUXdw00CDCPFQkWwSMQKwH2tXmELn3U6K1UA4nlQY20faFVAf
        6CGQsfeDRVLkwgtdw6p73Z3hDUpghyn6mw==
X-Google-Smtp-Source: ABdhPJxICwXcYDz+FEECFh0a7o7VzKwW8Gumv/0LMIWAV4pYWQOA58t5JSN7+YI79ld2Jgp3Dz4PCw==
X-Received: by 2002:a5d:6312:: with SMTP id i18mr851978wru.475.1640247044620;
        Thu, 23 Dec 2021 00:10:44 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id r62sm3841313wmr.35.2021.12.23.00.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 00:10:44 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     rodrigosiqueiramelo@gmail.com
Cc:     melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/1] drm/vkms: add zpos plane property
Date:   Thu, 23 Dec 2021 09:10:30 +0100
Message-Id: <20211223081030.16629-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223081030.16629-1-jose.exposito89@gmail.com>
References: <20211223081030.16629-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the zpos plane property. Depending on the plane type:

- Primary and cursor planes: Create an immutable zpos property. The
  primary plane is always at the bottom and the cursor plane is always
  on the top.
- Overlay planes: Create a mutable zpos property allowing to change
  their order but always keep them between the primary and cursor
  planes.

As documented, "vkms_crtc_state.active_planes" must be sorted by zpos.
This is achieved by inserting them in the array at their
normalized_zpos index.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c  |  3 +--
 drivers/gpu/drm/vkms/vkms_drv.c   |  1 +
 drivers/gpu/drm/vkms/vkms_plane.c | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 57bbd32e9beb..4f23488b15f3 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -207,7 +207,6 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 		return -ENOMEM;
 	vkms_state->num_active_planes = i;
 
-	i = 0;
 	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
 		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state,
 								  plane);
@@ -215,7 +214,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 		if (!plane_state->visible)
 			continue;
 
-		vkms_state->active_planes[i++] =
+		vkms_state->active_planes[plane_state->normalized_zpos] =
 			to_vkms_plane_state(plane_state);
 	}
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index bb98f6c6c561..a97b338318c6 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -157,6 +157,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	 * fbdev helpers. We have to go with 0, meaning "pick the default",
 	 * which ix XRGB8888 in all cases. */
 	dev->mode_config.preferred_depth = 0;
+	dev->mode_config.normalize_zpos = true;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
 	return vkms_output_init(vkmsdev, 0);
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 32409e15244b..f491abb35d4a 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -81,6 +81,8 @@ static void vkms_plane_reset(struct drm_plane *plane)
 	}
 
 	__drm_gem_reset_shadow_plane(plane, &vkms_state->base);
+	vkms_state->base.base.zpos = drm_plane_index(plane);
+	vkms_state->base.base.normalized_zpos = drm_plane_index(plane);
 }
 
 static const struct drm_plane_funcs vkms_plane_funcs = {
@@ -158,6 +160,24 @@ static const struct drm_plane_helper_funcs vkms_primary_helper_funcs = {
 	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
 };
 
+static int vkms_plane_create_zpos_property(struct vkms_device *vkmsdev,
+					   struct vkms_plane *plane)
+{
+	int ret;
+	unsigned int zpos = drm_plane_index(&plane->base);
+	int overlay_max_zpos = vkmsdev->config->num_overlay_planes;
+
+	if (plane->base.type == DRM_PLANE_TYPE_OVERLAY) {
+		ret = drm_plane_create_zpos_property(&plane->base, zpos,
+						     1, overlay_max_zpos);
+	} else {
+		ret = drm_plane_create_zpos_immutable_property(&plane->base,
+							       zpos);
+	}
+
+	return ret;
+}
+
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 				   enum drm_plane_type type, int index)
 {
@@ -166,6 +186,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	struct vkms_plane *plane;
 	const u32 *formats;
 	int nformats;
+	int ret;
 
 	switch (type) {
 	case DRM_PLANE_TYPE_PRIMARY:
@@ -195,5 +216,9 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
 	drm_plane_helper_add(&plane->base, funcs);
 
+	ret = vkms_plane_create_zpos_property(vkmsdev, plane);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return plane;
 }
-- 
2.25.1

