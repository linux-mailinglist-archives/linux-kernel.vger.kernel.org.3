Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8F348D522
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiAMJpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiAMJo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:44:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2C8C061751
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:44:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id c6so372821plh.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jofGU3F6JV6Xnd3MLtpHFZbNGTfUfABRqEKk6sSzclU=;
        b=ayuztF6+ZI2tex2HA6h1irVuMnU3YvjcdJbXChZ+6SHIHBFrITWegz49Czmex6qcAI
         qPi4PguPIym1kW8d8s4BtpaZfIAt2XfC8+TNmMOqADEwfy4NBENQz4I829NaPkZvEuiJ
         gphggvtATw/E8zLWSNg5KHnbpL/TcpZTLfWrrKjATC7nJxhQ0WvbS/yrojfdN5Nwov7D
         WzDpNZNo3TFRX4sUMxybdPI/zwwHu0kKyTh+9YCIjBIW5T5bSIt4YdsblERtmp82UvFa
         x3SlV59CFcwOAtW7TiLdMdVNkEJQ+WfqGIxxuqqLyZoTpMTloGY4uUMenRKkBrtSMsyR
         o1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jofGU3F6JV6Xnd3MLtpHFZbNGTfUfABRqEKk6sSzclU=;
        b=Uz9Vyr+YTPoDmQ2++gbvAzGx+ef6D6is7DVEGjB7XI9t4lKTFCP+LiMNnybJIe+dOn
         vSDG2C3/gS582HPbPub9FaVrPLovK/74K8YbR0Bc+D/OJwpetgwMgKdm/kXgvrn5ejbP
         GE7QKlTocbBb7BDmO6nxIvE4ChDbECz6CPVan7iVyd8tTtCOd/jZXXDxqsPSQPWYbUBH
         INVI3BFqkLLjGJpQrA6lShhJbJxRp0N4LqIJakuoRDbm/UgEjRce06M10SxjjcoGNIPC
         IK3OXQX8I5SLnbARoAqE/XvH6/wAyAk5AtzYjxPYYM1JbdxvFzTOdmjEAuaH8pVrlv0z
         V7cg==
X-Gm-Message-State: AOAM532XvDim762A8luhYOee1xskFeVAkvhleULLBXcHXijKWnOP0nt7
        JTB6jJe7tUi2wyWwtjFlLaWD7g==
X-Google-Smtp-Source: ABdhPJxN/HQwJfR2UqPUqvGYqhn+J1xaONJrFkxrOuGxrEaG0+WsaSNKUxks7IjbH6WNV6IK4Jvu3A==
X-Received: by 2002:a17:902:c402:b0:14a:8735:1a5c with SMTP id k2-20020a170902c40200b0014a87351a5cmr38057plk.154.1642067097227;
        Thu, 13 Jan 2022 01:44:57 -0800 (PST)
Received: from aqua.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id rm4sm2207154pjb.4.2022.01.13.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:44:56 -0800 (PST)
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
        Takanari Hayama <taki@igel.co.jp>
Subject: [RFC PATCH v2 3/3] drm: replace allow_fb_modifiers with fb_modifiers_not_supported
Date:   Thu, 13 Jan 2022 18:44:19 +0900
Message-Id: <20220113094419.12433-4-etom@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113094419.12433-1-etom@igel.co.jp>
References: <20220113094419.12433-1-etom@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since almost drivers support fb modifiers, allow_fb_modifiers is
replaced with fb_modifiers_not_supported and removed.

Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
---
 drivers/gpu/drm/drm_framebuffer.c                |  6 +++---
 drivers/gpu/drm/drm_ioctl.c                      |  2 +-
 drivers/gpu/drm/drm_plane.c                      |  9 ---------
 drivers/gpu/drm/selftests/test-drm_framebuffer.c |  1 -
 include/drm/drm_mode_config.h                    | 16 ----------------
 5 files changed, 4 insertions(+), 30 deletions(-)

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
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 5aa7e241971e..89a3d044ab59 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -288,15 +288,6 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 		}
 	}
 
-	/* autoset the cap and check for consistency across all planes */
-	if (format_modifier_count) {
-		drm_WARN_ON(dev, !config->allow_fb_modifiers &&
-			    !list_empty(&config->plane_list));
-		config->allow_fb_modifiers = true;
-	} else {
-		drm_WARN_ON(dev, config->allow_fb_modifiers);
-	}
-
 	plane->modifier_count = format_modifier_count;
 	plane->modifiers = kmalloc_array(format_modifier_count,
 					 sizeof(format_modifiers[0]),
diff --git a/drivers/gpu/drm/selftests/test-drm_framebuffer.c b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
index 61b44d3a6a61..f6d66285c5fc 100644
--- a/drivers/gpu/drm/selftests/test-drm_framebuffer.c
+++ b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
@@ -323,7 +323,6 @@ static struct drm_device mock_drm_device = {
 		.max_width = MAX_WIDTH,
 		.min_height = MIN_HEIGHT,
 		.max_height = MAX_HEIGHT,
-		.allow_fb_modifiers = true,
 		.funcs = &mock_config_funcs,
 	},
 };
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index c56f298c55bd..6fd13d6510f1 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -904,22 +904,6 @@ struct drm_mode_config {
 	 */
 	bool async_page_flip;
 
-	/**
-	 * @allow_fb_modifiers:
-	 *
-	 * Whether the driver supports fb modifiers in the ADDFB2.1 ioctl call.
-	 * Note that drivers should not set this directly, it is automatically
-	 * set in drm_universal_plane_init().
-	 *
-	 * IMPORTANT:
-	 *
-	 * If this is set the driver must fill out the full implicit modifier
-	 * information in their &drm_mode_config_funcs.fb_create hook for legacy
-	 * userspace which does not set modifiers. Otherwise the GETFB2 ioctl is
-	 * broken for modifier aware userspace.
-	 */
-	bool allow_fb_modifiers;
-
 	/**
 	 * @fb_modifiers_not_supported:
 	 *
-- 
2.25.1

