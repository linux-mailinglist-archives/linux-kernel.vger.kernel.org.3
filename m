Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E9E47CCAA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 06:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242581AbhLVF1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 00:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhLVF1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 00:27:44 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA36C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 21:27:44 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f125so1247366pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 21:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzVJoWnVKuHRY07c9p2jG3ENIE447Yyj+QR55sYQSR4=;
        b=JcErYDjqib81W1HW9K085wJWYMfUhlEBkTpfUD2xAEU+DLtNh8wAEnFheksoI5nUj9
         HzmkhIlEbXi2Jzm6AZBtJEb6SCnvcY/ydyO0O4UO4PfC5vvDn7lyVHACvYj/uVzt2s2A
         HZcUOmLKVMnjjuMYRP66UQvL/R6X+USXWDnPr5zEP8XFxJHZPn8MDmnE0cDjO5BmgSGY
         657rMrylhXevVBxMaZOUyYsR+fKND0Ds+R/SNRzjtBuLPPG6BEj1lSGW8HsJ+0tS5kAH
         7MfK1EBay3QvSaoJW+Omkjh6esTFIpGw50PcQC1E/l7TAAtV8t524hvSefBZmy3RH/ax
         lPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzVJoWnVKuHRY07c9p2jG3ENIE447Yyj+QR55sYQSR4=;
        b=wFpP7jfNyWFHdy9nN9OF9MZIdE/uYNmc1IfUBGEgMUv9vc+CuZpVkaim/j61JvBKOt
         T7WZLbztLWpGrXit0l6s9EtCHqB1Mgx7froMYjVJrYJsmt7rAl+ia07mpPY0fRZtf+2e
         FQaSVIz1rZ5lnhfWrBxO2P3OGb9BBcT2Z01V8w0nu3QaNapGsJAZkk7/ahmyzjbbd0q5
         JmV04JYWorDw5zxTNEWMNyDPp0CUGBpRvE6bPFDnQZkOKq6+Ui827/P4h4fQYbxuZA2F
         QtmRLYDdi3Lo2/A2wQ7GRpUN+jzYltAzdaYqbe0ubZTU/IwqV4Vmallmqeytzt+yl2A8
         +FtQ==
X-Gm-Message-State: AOAM532Zg0QZNqGU2cRpRqMEP491qx/ACmk4FEtloXJ8re3hOvVmKeKo
        xgDW5rXzXU52DZjGfX0ixrziUw==
X-Google-Smtp-Source: ABdhPJzj+GPlxurLuqLoBKu153aUUw6RYvLCrjySDnYLaoT0pAwGhgH6LAFcJEvbS0vx6Dad8rbDMQ==
X-Received: by 2002:a05:6a00:1249:b0:4bb:4a31:1e0a with SMTP id u9-20020a056a00124900b004bb4a311e0amr1374574pfi.81.1640150864046;
        Tue, 21 Dec 2021 21:27:44 -0800 (PST)
Received: from aqua.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id v63sm737465pgv.71.2021.12.21.21.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 21:27:43 -0800 (PST)
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
        nouveau@lists.freedesktop.org, Tomohito Esaki <etom@igel.co.jp>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
Subject: [RFC PATH 1/3] drm: add support modifiers for drivers whose planes only support linear layout
Date:   Wed, 22 Dec 2021 14:27:25 +0900
Message-Id: <20211222052727.19725-2-etom@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222052727.19725-1-etom@igel.co.jp>
References: <20211222052727.19725-1-etom@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LINEAR modifier is advertised as default if a driver doesn't specify
modifiers. However, there are legacy drivers such as radeon that do not
support modifiers but infer the actual layout of the underlying buffer.
Therefore, a new flag not_support_fb_modifires is introduced for these
legacy drivers. Allow_fb_modifiers will be replaced with this new flag.

Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
---
 drivers/gpu/drm/drm_plane.c   | 34 ++++++++++++++++++++++++++--------
 include/drm/drm_mode_config.h | 10 ++++++++++
 include/drm/drm_plane.h       |  3 +++
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 82afb854141b..75308ee240c0 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -161,6 +161,16 @@ modifiers_ptr(struct drm_format_modifier_blob *blob)
 	return (struct drm_format_modifier *)(((char *)blob) + blob->modifiers_offset);
 }
 
+static bool check_format_modifier(struct drm_plane *plane, uint32_t format,
+				  uint64_t modifier)
+{
+	if (plane->funcs->format_mod_supported)
+		return plane->funcs->format_mod_supported(plane, format,
+							  modifier);
+
+	return modifier == DRM_FORMAT_MOD_LINEAR;
+}
+
 static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane)
 {
 	const struct drm_mode_config *config = &dev->mode_config;
@@ -203,16 +213,15 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
 	memcpy(formats_ptr(blob_data), plane->format_types, formats_size);
 
 	/* If we can't determine support, just bail */
-	if (!plane->funcs->format_mod_supported)
+	if (config->fb_modifiers_not_supported)
 		goto done;
 
 	mod = modifiers_ptr(blob_data);
 	for (i = 0; i < plane->modifier_count; i++) {
 		for (j = 0; j < plane->format_count; j++) {
-			if (plane->funcs->format_mod_supported(plane,
-							       plane->format_types[j],
-							       plane->modifiers[i])) {
-
+			if (check_format_modifier(plane,
+						  plane->format_types[j],
+						  plane->modifiers[i])) {
 				mod->formats |= 1ULL << j;
 			}
 		}
@@ -242,6 +251,10 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 				      const char *name, va_list ap)
 {
 	struct drm_mode_config *config = &dev->mode_config;
+	const uint64_t default_modifiers[] = {
+		DRM_FORMAT_MOD_LINEAR,
+		DRM_FORMAT_MOD_INVALID
+	};
 	unsigned int format_modifier_count = 0;
 	int ret;
 
@@ -282,6 +295,11 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 
 		while (*temp_modifiers++ != DRM_FORMAT_MOD_INVALID)
 			format_modifier_count++;
+	} else {
+		if (!dev->mode_config.fb_modifiers_not_supported) {
+			format_modifiers = default_modifiers;
+			format_modifier_count = 1;
+		}
 	}
 
 	/* autoset the cap and check for consistency across all planes */
@@ -346,7 +364,7 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 		drm_object_attach_property(&plane->base, config->prop_src_h, 0);
 	}
 
-	if (config->allow_fb_modifiers)
+	if (format_modifier_count)
 		create_in_format_blob(dev, plane);
 
 	return 0;
@@ -373,8 +391,8 @@ static int __drm_universal_plane_init(struct drm_device *dev,
  * drm_universal_plane_init() to let the DRM managed resource infrastructure
  * take care of cleanup and deallocation.
  *
- * Drivers supporting modifiers must set @format_modifiers on all their planes,
- * even those that only support DRM_FORMAT_MOD_LINEAR.
+ * For drivers supporting modifiers, all planes will advertise
+ * DRM_FORMAT_MOD_LINEAR support, if @format_modifiers is not set.
  *
  * Returns:
  * Zero on success, error code on failure.
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 48b7de80daf5..c56f298c55bd 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -920,6 +920,16 @@ struct drm_mode_config {
 	 */
 	bool allow_fb_modifiers;
 
+	/**
+	 * @fb_modifiers_not_supported:
+	 *
+	 * This flag is for legacy drivers such as radeon that do not support
+	 * modifiers but infer the actual layout of the underlying buffer.
+	 * Generally, each drivers must support modifiers, this flag should not
+	 * be set.
+	 */
+	bool fb_modifiers_not_supported;
+
 	/**
 	 * @normalize_zpos:
 	 *
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 0c1102dc4d88..cad641b1f797 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -803,6 +803,9 @@ void *__drmm_universal_plane_alloc(struct drm_device *dev,
  *
  * The @drm_plane_funcs.destroy hook must be NULL.
  *
+ * For drivers supporting modifiers, all planes will advertise
+ * DRM_FORMAT_MOD_LINEAR support, if @format_modifiers is not set.
+ *
  * Returns:
  * Pointer to new plane, or ERR_PTR on failure.
  */
-- 
2.17.1

