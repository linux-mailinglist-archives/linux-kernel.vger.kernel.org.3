Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4C247F683
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhLZLM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhLZLMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:12:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CB0C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:12:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so1241115wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KeNgCDnr+KkxK1aQI/zTLmWCtb7DQX1Gm0dPobkQJhQ=;
        b=dChID6gt0nDFRBOt7BCYvos7HP4Omj7fH4BhPX5suCnA81o4ZQYn5GOuQpLhr+V12H
         lV20Bjw+62nzVusyhbj8eSzQs4ACHSN+vrhlaac5UD5++sEFxN2I4NaTXDE/wITIOqi6
         rNCClqin6wUacyxH+GzAkDlylR4EdLFBigYk1bCelUOmBcG27IOoygAUjFgozg/B6xTY
         NrwH51a/zu+qDijyO7hHsLSLpMxFayd1tdpn/n9Te8dRnLO6GYxTvTpjTdaJMBy6vsFH
         lFVD821PUYpGwcIpe9rfXA5ovIO0RlnYuCkGqgi8AIvHagXGF5x9f4X1T6O4azSICk5Q
         NoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KeNgCDnr+KkxK1aQI/zTLmWCtb7DQX1Gm0dPobkQJhQ=;
        b=uPre1r/BJNUCdAFsTqiV6yyDLKkr5ARC4baoZ9+VBGStn3mcJmbuQPoZonhOvAl60G
         nYs7hdJYg0eVQriN3Oo+YmupLAGSvkIeiXKWb7Wtyp3Rt5bmnsqHpswYdhDqNeHLi+v8
         JmqkIjGpTqKHtvYQU375gOIAmkpHMI6//J3uzNFZRCOYFU16caDw9ivBFwxyHnCF+n7C
         X4xpPAxCherU5SHxGuJnggsXmv9dJqn78DY1BtbweEO3DW18QmYohTvM0tePpVjzPQYq
         vV8zV/iOvCeEIiU44jnX7fgiP4YRiaq+5j1IcTibrHZIi6jk4Jozu+uk1IPp6ktFbiTX
         Jhrg==
X-Gm-Message-State: AOAM531G7g51njTCE7LORxdROnrGGuRFseHFM130EoCSL07dsbOdRlmG
        pMAiFkiyWDUCxayo2ZUc/6U=
X-Google-Smtp-Source: ABdhPJy865CFBqADf2jvNLHCedn1O7Bhwh1mztfaff3rDLDWW3mvxKs0n/UrtuExcTgkFua6zT5EYQ==
X-Received: by 2002:a05:600c:c8:: with SMTP id u8mr10146398wmm.171.1640517171112;
        Sun, 26 Dec 2021 03:12:51 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id q14sm12156970wro.58.2021.12.26.03.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 03:12:50 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     melissa.srw@gmail.com
Cc:     mwen@igalia.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 1/1] drm/vkms: add zpos plane property
Date:   Sun, 26 Dec 2021 12:12:19 +0100
Message-Id: <20211226111219.27616-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211226111219.27616-1-jose.exposito89@gmail.com>
References: <20211226111219.27616-1-jose.exposito89@gmail.com>
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

The following igt-gpu-tools tests were executed:

                    |     master branch     |      this  patch      |
                    | SUCCESS | SKIP | FAIL | SUCCESS | SKIP | FAIL |
 kms_atomic         |      10 |   02 |   00 |      09 |   02 |   01 |
 kms_plane          |      06 |   00 |   14 |      06 |   00 |   14 |
 kms_plane_cursor   |      09 |   45 |   00 |      09 |   45 |   00 |
 kms_plane_multiple |      01 |   23 |   00 |      01 |   23 |   00 |
 kms_writeback      |      04 |   00 |   00 |      04 |   00 |   00 |

Notice that there is one test failing in the kms_atomic row
(plane-immutable-zpos) but it is due to timeout capturing CRC.
This happens when the primary plane is disabled and the composer is not
able to find the "primary_composer" variable.
While the timeout bug needs to be fixed in a different series, the zpos
property works as expected.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2:

 - Use number of planes constant introduced in "drm/vkms: add support
   for multiple overlay planes" v2

 - Add a test results in the commit message
---
 drivers/gpu/drm/vkms/vkms_crtc.c  |  3 +--
 drivers/gpu/drm/vkms/vkms_drv.c   |  1 +
 drivers/gpu/drm/vkms/vkms_plane.c | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

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
index 0ffe5f0e33f7..d7ee64f5e339 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -153,6 +153,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	 * fbdev helpers. We have to go with 0, meaning "pick the default",
 	 * which ix XRGB8888 in all cases. */
 	dev->mode_config.preferred_depth = 0;
+	dev->mode_config.normalize_zpos = true;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
 	return vkms_output_init(vkmsdev, 0);
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 32409e15244b..55d22a6a401a 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -81,6 +81,8 @@ static void vkms_plane_reset(struct drm_plane *plane)
 	}
 
 	__drm_gem_reset_shadow_plane(plane, &vkms_state->base);
+	vkms_state->base.base.zpos = drm_plane_index(plane);
+	vkms_state->base.base.normalized_zpos = drm_plane_index(plane);
 }
 
 static const struct drm_plane_funcs vkms_plane_funcs = {
@@ -158,6 +160,22 @@ static const struct drm_plane_helper_funcs vkms_primary_helper_funcs = {
 	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
 };
 
+static int vkms_plane_create_zpos_property(struct vkms_plane *plane)
+{
+	int ret;
+	unsigned int zpos = drm_plane_index(&plane->base);
+
+	if (plane->base.type == DRM_PLANE_TYPE_OVERLAY) {
+		ret = drm_plane_create_zpos_property(&plane->base, zpos,
+						     1, NUM_OVERLAY_PLANES);
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
@@ -166,6 +184,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	struct vkms_plane *plane;
 	const u32 *formats;
 	int nformats;
+	int ret;
 
 	switch (type) {
 	case DRM_PLANE_TYPE_PRIMARY:
@@ -195,5 +214,9 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
 	drm_plane_helper_add(&plane->base, funcs);
 
+	ret = vkms_plane_create_zpos_property(plane);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return plane;
 }
-- 
2.25.1

