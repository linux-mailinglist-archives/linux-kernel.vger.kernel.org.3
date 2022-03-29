Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8BC4EB66B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbiC2XC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238943AbiC2XCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:02:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8734B1F2;
        Tue, 29 Mar 2022 16:00:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w8so18944632pll.10;
        Tue, 29 Mar 2022 16:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3F9VO5+wYzu8l8XdnSC4LwBDKzbPQV3dhpcf6YMDn+0=;
        b=Q7ythc7PhXt8NJF+5D8GamntEnj6SY9tOJcOeMcvuv+C90lWDETds0B7xe8NjQRag6
         Ixk9DKGrezWwpdYF33c8HjbjoFaica2JegfEiHbnm7M26AlVHp7536gB7OKXz0pJIX/Y
         3BtOUgQkUEacAbBG9NIsou76Z4h43/xVmDMHS9ClsXUjIcHABW5Pr2GTHnCS2K5OKHG1
         GPrdLBNj0auTE45VcKm4RY+Ez03NFF0EcwcjLAohz+hhCtyr/wK7AzN40QluN97h9jVv
         mgQG1dwsM5mzXA4R3dvkhOwx03JjtJ/3/UoYZVGNjjeIs6lRdR88EMJ2oc4rHGvlRHAW
         WGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3F9VO5+wYzu8l8XdnSC4LwBDKzbPQV3dhpcf6YMDn+0=;
        b=VbXob0zone0IdIKK+mF8WIpE7iI/UyKb/KQbyrv4A0/AxkHAuyd2uF2iwZeFDKcxP0
         GpSdc5ZVk2npyW9eTxYNJpSwdDUzu157+JbDAtd8CtR13VBfRyDpr0WGWiUjtVUBVLHf
         MtBj54O78jRXyBXSbtNLLh/AzBA/6x540YlScIK4kVA2AIavtLkeWuQ3XbNCU1GPNVcM
         q5OgGclGszDmZAPiddXXsHgwYyBNT/uUmU3ioT5cVy2YEvw8/U9W4vesnTU8kA6pDlw5
         YfQsLLIL4NDKY3RRZe5sNUE99iRJVZU26rg/oHASVzG0Q95l8gny2j6dNHEHP5+9J8rZ
         +GuA==
X-Gm-Message-State: AOAM532bRn/8KYg5P23kC/REKvr0V+SFXB5yt2CfpXAHCof/frVbV+V2
        7qVLh93UShbTvhJMcTbIq94C4rrflb8=
X-Google-Smtp-Source: ABdhPJyQLMgwpLrJlYoaySIheQ5oaE/hqzKIVSsmHAV9rQJjDnxQ1AaUdvrHfa8AUCn604DIxE30Aw==
X-Received: by 2002:a17:903:2341:b0:156:196a:3ef with SMTP id c1-20020a170903234100b00156196a03efmr9614915plh.81.1648594833757;
        Tue, 29 Mar 2022 16:00:33 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id e11-20020a056a001a8b00b004fab740dbddsm20921004pfv.105.2022.03.29.16.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:00:31 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/9] drm/msm: Drop msm_gem_iova()
Date:   Tue, 29 Mar 2022 16:00:53 -0700
Message-Id: <20220329230105.601666-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329230105.601666-1-robdclark@gmail.com>
References: <20220329230105.601666-1-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_fb.c  | 16 ++++++++++------
 drivers/gpu/drm/msm/msm_gem.c | 16 ----------------
 drivers/gpu/drm/msm/msm_gem.h |  2 --
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 7137492fe78e..d4eef66e29dc 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -21,6 +21,9 @@ struct msm_framebuffer {
 
 	/* Count of # of attached planes which need dirtyfb: */
 	refcount_t dirtyfb;
+
+	/* Framebuffer per-plane address, if pinned, else zero: */
+	uint64_t iova[DRM_FORMAT_MAX_PLANES];
 };
 #define to_msm_framebuffer(x) container_of(x, struct msm_framebuffer, base)
 
@@ -76,14 +79,14 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb,
 {
 	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
 	int ret, i, n = fb->format->num_planes;
-	uint64_t iova;
 
 	if (needs_dirtyfb)
 		refcount_inc(&msm_fb->dirtyfb);
 
 	for (i = 0; i < n; i++) {
-		ret = msm_gem_get_and_pin_iova(fb->obj[i], aspace, &iova);
-		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)", fb->base.id, i, iova, ret);
+		ret = msm_gem_get_and_pin_iova(fb->obj[i], aspace, &msm_fb->iova[i]);
+		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)",
+			      fb->base.id, i, msm_fb->iova[i], ret);
 		if (ret)
 			return ret;
 	}
@@ -103,14 +106,15 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb,
 
 	for (i = 0; i < n; i++)
 		msm_gem_unpin_iova(fb->obj[i], aspace);
+
+	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
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

