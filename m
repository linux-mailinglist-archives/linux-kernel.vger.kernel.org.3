Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339274F6D7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiDFVyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiDFVwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:52:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557613EA0;
        Wed,  6 Apr 2022 14:46:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m16so3162179plx.3;
        Wed, 06 Apr 2022 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0tHIsGzTPzPZiDuRsukQZsT+v6AmVTymqyX9Izja0U=;
        b=AQA4hqL0s9Q7QXsT6cS5iuwpbM2FT8mX+MhS/6wcy+NqU+0LG0xU9oEJeZmj3+mEbf
         vARWqxRwWftnWmXFUTFoo6UAhch6IJwLBNvvPZUsKNJHFEer5bSc/+6GUkyjsFPSVctQ
         IYR1nFIrUI2xTV+kD5R7V6koa9uCM3yRF+ocNcX9g8YSK5fRC8YTd+neuUlsz/VTUuO3
         uJ4jgXGg0h3i+DihHTyYtVClDsxoq3iEMdm4HOL9XOfQcPJEAM7gIh9c5uxbi0Qb5EIf
         ul+zZMM/Y5MfYehrFj146UviUozKgg3FwnoHZ7AjENjyeGgvQy+VRtNrtf+yk8fHOaGm
         yt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0tHIsGzTPzPZiDuRsukQZsT+v6AmVTymqyX9Izja0U=;
        b=3eXQX7PTyOJqpAoUq+vf32m4u4XNwGi6nmoPjAs/H40Qpg29q6EL+GFj/7Mh5iQd8G
         B59CUyITKkFPdQWkwDLT2Y8ar+1gHjCyUynAO+fbjYZkBMUmUHFm9+Icwe5sPfR4fp/9
         N0/9zn31goIgMsArPxJ93k27MNun2mi5pjIH45W0SnOKUSevJz5Uak5PlmBW8b3xUzyF
         VZsA4+ttiXZCQQjst2AKLAVg1OxXDMDxc0PqVxoj0aCDnXNArYplnK/GkwUoD0SFJfI6
         YJydiImNayNtqR0K739RtiSDKPnKKYw/Hy4iQxJvlO8kBo0eXicjM8R1cDepyg5cSABD
         SN6w==
X-Gm-Message-State: AOAM532iBJZfZrGhA6p/dplhefB9Kw6+YA3nMmYda5FLcfHddJn/rHBm
        re0V15F9FOBIwvoCrTbTm1uOx1afPlA=
X-Google-Smtp-Source: ABdhPJwv6a6gChwpRdXvCUj2qOkIUsO7XVaw0bin3rIB0wrQDGyQFAFzCGJ0wPo/O87A61RCEoFEAA==
X-Received: by 2002:a17:902:7689:b0:157:3d:a5bc with SMTP id m9-20020a170902768900b00157003da5bcmr1165399pll.25.1649281603252;
        Wed, 06 Apr 2022 14:46:43 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id t34-20020a056a0013a200b004faa8346e83sm21523201pfg.2.2022.04.06.14.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:46:42 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 06/10] drm/msm: Drop msm_gem_iova()
Date:   Wed,  6 Apr 2022 14:46:22 -0700
Message-Id: <20220406214636.1156978-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406214636.1156978-1-robdclark@gmail.com>
References: <20220406214636.1156978-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

There was only a single user, which could just as easily stash the iova
when pinning.

v2: fix prepare->prepare->cleanup->cleanup sequences

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/msm_fb.c  | 20 ++++++++++++++------
 drivers/gpu/drm/msm/msm_gem.c | 16 ----------------
 drivers/gpu/drm/msm/msm_gem.h |  2 --
 3 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 7137492fe78e..362775ae50af 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -21,6 +21,10 @@ struct msm_framebuffer {
 
 	/* Count of # of attached planes which need dirtyfb: */
 	refcount_t dirtyfb;
+
+	/* Framebuffer per-plane address, if pinned, else zero: */
+	uint64_t iova[DRM_FORMAT_MAX_PLANES];
+	atomic_t prepare_count;
 };
 #define to_msm_framebuffer(x) container_of(x, struct msm_framebuffer, base)
 
@@ -76,14 +80,16 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb,
 {
 	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
 	int ret, i, n = fb->format->num_planes;
-	uint64_t iova;
 
 	if (needs_dirtyfb)
 		refcount_inc(&msm_fb->dirtyfb);
 
+	atomic_inc(&msm_fb->prepare_count);
+
 	for (i = 0; i < n; i++) {
-		ret = msm_gem_get_and_pin_iova(fb->obj[i], aspace, &iova);
-		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)", fb->base.id, i, iova, ret);
+		ret = msm_gem_get_and_pin_iova(fb->obj[i], aspace, &msm_fb->iova[i]);
+		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)",
+			      fb->base.id, i, msm_fb->iova[i], ret);
 		if (ret)
 			return ret;
 	}
@@ -103,14 +109,16 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb,
 
 	for (i = 0; i < n; i++)
 		msm_gem_unpin_iova(fb->obj[i], aspace);
+
+	if (!atomic_dec_return(&msm_fb->prepare_count))
+		memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
 }
 
 uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb,
 		struct msm_gem_address_space *aspace, int plane)
 {
-	if (!fb->obj[plane])
-		return 0;
-	return msm_gem_iova(fb->obj[plane], aspace) + fb->offsets[plane];
+	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
+	return msm_fb->iova[plane];
 }
 
 struct drm_gem_object *msm_framebuffer_bo(struct drm_framebuffer *fb, int plane)
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index f4b68bb28a4d..deafae6feaa8 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -509,22 +509,6 @@ int msm_gem_get_iova(struct drm_gem_object *obj,
 	return ret;
 }
 
-/* get iova without taking a reference, used in places where you have
- * already done a 'msm_gem_get_and_pin_iova' or 'msm_gem_get_iova'
- */
-uint64_t msm_gem_iova(struct drm_gem_object *obj,
-		struct msm_gem_address_space *aspace)
-{
-	struct msm_gem_vma *vma;
-
-	msm_gem_lock(obj);
-	vma = lookup_vma(obj, aspace);
-	msm_gem_unlock(obj);
-	GEM_WARN_ON(!vma);
-
-	return vma ? vma->iova : 0;
-}
-
 /*
  * Locked variant of msm_gem_unpin_iova()
  */
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 090c3b1a6d9a..772de010a669 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -142,8 +142,6 @@ int msm_gem_get_and_pin_iova_locked(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova);
 int msm_gem_get_and_pin_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova);
-uint64_t msm_gem_iova(struct drm_gem_object *obj,
-		struct msm_gem_address_space *aspace);
 void msm_gem_unpin_iova_locked(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace);
 void msm_gem_unpin_iova(struct drm_gem_object *obj,
-- 
2.35.1

