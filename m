Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE34749F34E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbiA1GJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346301AbiA1GJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:09:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C095C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:09:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d5so5550291pjk.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9OzDyLbxHiptRu8aPtp+nu1uB5blDVW/bU01H77AoMs=;
        b=7dbPaRC95XZLXtUt7We9hvhYTemuqRCNVRhv9im6aqLkPx1t+AXxqeElX3ZhK2E/XI
         QjaLlFGclSQng/O1bnhUtvDIaNy0WXfjpM2AwnKIyaSA+2ooiwG2oVtWXpuFUQXhHYic
         u+dMIAmPrz08E78nSKStMMlL5upV4ILlMwafgzCXp0NkEHszgW7UV0zvdkIJmCQCe1Q9
         Pr9JPaSSMXhhVJOZJDUgXqQb9YnrF5gZr23ucl6Sm28gT3bDcGfvtdrPtTqNOkF9h/9a
         YYg1WJIei14of4O3L/xyKcq9NqbhUFBocH+kSCNczOr6truWKWM6dearxgHf7KSO37qz
         flrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9OzDyLbxHiptRu8aPtp+nu1uB5blDVW/bU01H77AoMs=;
        b=0FE46ZmRVef6599sZmUl+ViydYlq+BOPGfIpHp1rDEGkNrZoSAlIOH3ReMUD6YNAxw
         W1YfFIjgtu3hjPR6A1u2ZPg2Z1jVYyCNR/jPuFkvaux1xjt4FzRVDtxWAOXoPo0xRrRv
         y24aUcigerPVbQUcgCAd2JgSDF1L9F0SmKnDX3n6UKqZ6Am0XxeboOzdqG7oYs7a3VfS
         4XWsYgYWdSRqxNCPhl6E6hqZh2XGq9lmyrRtrYSdErJ98EhyreXAi/UW1PnUMQ5oS4Vl
         hWPWoFRI1CvbD4FhIUBB+qpA2/hranf9LuyQ3zm05OvM8CpTnE74lNI3sHTZfM1k2Gb4
         TCAw==
X-Gm-Message-State: AOAM530bE2HmnOdrNAqo9o996RhCAiTMaVGg+Ii4nA2DPwDCP7bcufed
        BJcGziwtiFGT/2kLjdT2ZrMKxg==
X-Google-Smtp-Source: ABdhPJy2sVlRtsrg85pdzE37SLPebBW7l+fxKl8otodYNXeMZDFUM/4dx4pSYZNuMXJWGZU4YDzOdQ==
X-Received: by 2002:a17:903:3049:: with SMTP id u9mr6896351pla.2.1643350142723;
        Thu, 27 Jan 2022 22:09:02 -0800 (PST)
Received: from aqua.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id h5sm7743182pfi.111.2022.01.27.22.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 22:09:02 -0800 (PST)
From:   Tomohito Esaki <etom@igel.co.jp>
To:     dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomohito Esaki <etom@igel.co.jp>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH v6 1/3] drm: introduce fb_modifiers_not_supported flag in mode_config
Date:   Fri, 28 Jan 2022 15:08:34 +0900
Message-Id: <20220128060836.11216-2-etom@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128060836.11216-1-etom@igel.co.jp>
References: <20220128060836.11216-1-etom@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If only linear modifier is advertised, since there are many drivers that
only linear supported, the DRM core should handle this rather than
open-coding in every driver. However, there are legacy drivers such as
radeon that do not support modifiers but infer the actual layout of the
underlying buffer. Therefore, a new flag fb_modifiers_not_supported is
introduced for these legacy drivers, and allow_fb_modifiers is replaced
with this new flag.

v3:
 - change the order as follows:
   1. add fb_modifiers_not_supported flag
   2. add default modifiers
   3. remove allow_fb_modifiers flag
 - add a conditional disable in amdgpu_dm_plane_init()

v4:
 - modify kernel docs

v5:
 - modify kernel docs

Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       |  6 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             |  2 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +++
 drivers/gpu/drm/drm_framebuffer.c                 |  6 +++---
 drivers/gpu/drm/drm_ioctl.c                       |  2 +-
 drivers/gpu/drm/nouveau/nouveau_display.c         |  6 ++++--
 drivers/gpu/drm/radeon/radeon_display.c           |  2 ++
 include/drm/drm_mode_config.h                     | 10 ++++++++++
 11 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 82011e75ed85..edbb30d47b8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -954,7 +954,7 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 	int ret;
 	unsigned int i, block_width, block_height, block_size_log2;
 
-	if (!rfb->base.dev->mode_config.allow_fb_modifiers)
+	if (rfb->base.dev->mode_config.fb_modifiers_not_supported)
 		return 0;
 
 	for (i = 0; i < format_info->num_planes; ++i) {
@@ -1141,7 +1141,7 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	if (!dev->mode_config.allow_fb_modifiers) {
+	if (dev->mode_config.fb_modifiers_not_supported) {
 		drm_WARN_ONCE(dev, adev->family >= AMDGPU_FAMILY_AI,
 			      "GFX9+ requires FB check based on format modifier\n");
 		ret = check_tiling_flags_gfx6(rfb);
@@ -1149,7 +1149,7 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 			return ret;
 	}
 
-	if (dev->mode_config.allow_fb_modifiers &&
+	if (!dev->mode_config.fb_modifiers_not_supported &&
 	    !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
 		ret = convert_tiling_flags_to_modifier(rfb);
 		if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index d1570a462a51..fb61c0814115 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2798,6 +2798,8 @@ static int dce_v10_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
 	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 
+	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
+
 	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
 
 	r = amdgpu_display_modeset_create_props(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 18a7b3bd633b..17942a11366d 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2916,6 +2916,8 @@ static int dce_v11_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
 	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 
+	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
+
 	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
 
 	r = amdgpu_display_modeset_create_props(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index c7803dc2b2d5..2ec99ec8e1a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2674,6 +2674,7 @@ static int dce_v6_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.max_height = 16384;
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
 	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
+	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
 	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
 
 	r = amdgpu_display_modeset_create_props(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 8318ee8339f1..de11fbe5aba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2695,6 +2695,8 @@ static int dce_v8_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
 	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 
+	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
+
 	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
 
 	r = amdgpu_display_modeset_create_props(adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7f9773f8dab6..0fbcd19489f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7894,6 +7894,9 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	if (res)
 		return res;
 
+	if (modifiers == NULL)
+		adev_to_drm(dm->adev)->mode_config.fb_modifiers_not_supported = true;
+
 	res = drm_universal_plane_init(adev_to_drm(dm->adev), plane, possible_crtcs,
 				       &dm_plane_funcs, formats, num_formats,
 				       modifiers, plane->type, NULL);
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 07f5abc875e9..4562a8b86579 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -309,7 +309,7 @@ drm_internal_framebuffer_create(struct drm_device *dev,
 	}
 
 	if (r->flags & DRM_MODE_FB_MODIFIERS &&
-	    !dev->mode_config.allow_fb_modifiers) {
+	    dev->mode_config.fb_modifiers_not_supported) {
 		DRM_DEBUG_KMS("driver does not support fb modifiers\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -594,7 +594,7 @@ int drm_mode_getfb2_ioctl(struct drm_device *dev,
 	r->pixel_format = fb->format->format;
 
 	r->flags = 0;
-	if (dev->mode_config.allow_fb_modifiers)
+	if (!dev->mode_config.fb_modifiers_not_supported)
 		r->flags |= DRM_MODE_FB_MODIFIERS;
 
 	for (i = 0; i < ARRAY_SIZE(r->handles); i++) {
@@ -607,7 +607,7 @@ int drm_mode_getfb2_ioctl(struct drm_device *dev,
 	for (i = 0; i < fb->format->num_planes; i++) {
 		r->pitches[i] = fb->pitches[i];
 		r->offsets[i] = fb->offsets[i];
-		if (dev->mode_config.allow_fb_modifiers)
+		if (!dev->mode_config.fb_modifiers_not_supported)
 			r->modifier[i] = fb->modifier;
 	}
 
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 8b8744dcf691..51fcf1298023 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -297,7 +297,7 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
 			req->value = 64;
 		break;
 	case DRM_CAP_ADDFB2_MODIFIERS:
-		req->value = dev->mode_config.allow_fb_modifiers;
+		req->value = !dev->mode_config.fb_modifiers_not_supported;
 		break;
 	case DRM_CAP_CRTC_IN_VBLANK_EVENT:
 		req->value = 1;
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 2b460835a438..2cd0932b3d68 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -708,10 +708,12 @@ nouveau_display_create(struct drm_device *dev)
 				     &disp->disp);
 		if (ret == 0) {
 			nouveau_display_create_properties(dev);
-			if (disp->disp.object.oclass < NV50_DISP)
+			if (disp->disp.object.oclass < NV50_DISP) {
+				dev->mode_config.fb_modifiers_not_supported = true;
 				ret = nv04_display_create(dev);
-			else
+			} else {
 				ret = nv50_display_create(dev);
+			}
 		}
 	} else {
 		ret = 0;
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 573154268d43..b9a07677a71e 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1596,6 +1596,8 @@ int radeon_modeset_init(struct radeon_device *rdev)
 	rdev->ddev->mode_config.preferred_depth = 24;
 	rdev->ddev->mode_config.prefer_shadow = 1;
 
+	rdev->ddev->mode_config.fb_modifiers_not_supported = true;
+
 	rdev->ddev->mode_config.fb_base = rdev->mc.aper_base;
 
 	ret = radeon_modeset_create_props(rdev);
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 91ca575a78de..4a93dac91cf9 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -933,6 +933,16 @@ struct drm_mode_config {
 	 */
 	bool allow_fb_modifiers;
 
+	/**
+	 * @fb_modifiers_not_supported:
+	 *
+	 * When this flag is set, the DRM device will not expose modifier
+	 * support to userspace. This is only used by legacy drivers that infer
+	 * the buffer layout through heuristics without using modifiers. New
+	 * drivers shall not set fhis flag.
+	 */
+	bool fb_modifiers_not_supported;
+
 	/**
 	 * @normalize_zpos:
 	 *
-- 
2.25.1

