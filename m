Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ADC4FC71E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350300AbiDKWBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350272AbiDKWAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:00:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF918120A1;
        Mon, 11 Apr 2022 14:58:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t13so15338989pgn.8;
        Mon, 11 Apr 2022 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0tHIsGzTPzPZiDuRsukQZsT+v6AmVTymqyX9Izja0U=;
        b=XBNJN50310yoSuZnkMOOCReIaTtnynwQjf9jZTd/YlXFVdIYSy2I1BQ9Ytmlw/JnRf
         5QGcSe3d8ubjM8Gx62SzIXdnJ0/H/yAl2FGzmJAwglobBLbBH1RJ4Rm2smiGSWHeASs2
         xBQ+bCMXecuCAKJdgxpmAEDWk18R7FdqKewqM4Ul8VvBRcnBevlzyGLDYvChlry05OPN
         t6Wr9cSvYFMm+dGG97AJAELZr8QRW0Vb21coZgULcIN3i3U28DrLEIxxnKLoQ2o4vVlf
         mykUEiR9NVdhQUf6lhI1KYpzmNnvNWWM43mo9yZumPnnZr2LISnGuYzsWpSyN86fQsiA
         icQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0tHIsGzTPzPZiDuRsukQZsT+v6AmVTymqyX9Izja0U=;
        b=a0AKexk2pozSsCnSpp/jOnrxDX8/uggG82lTYTRire1F5T8d2VWOZDL064PNYHMzMz
         iEeHDxuPB/+6q6G4dKFPtD9k9FUH/as99jwrM+d098ScYWWiGPrCrzv5M1nPv5NXVPP5
         ubYVbhfmNj938qWlk9qlPf9LbVU4VSSleiDzsHinKRXg6NbvL+UVYo6TtRJU6bq/6Jvt
         LftyRLJ+efkUF8G7tBKoI1kO0uApV3bh1Y7bOWGfKeyzZwVmAEt4Jfcj7PZmo4U/XZuL
         CewUWsvZa5Ck/5aeQrMIt4dI/hwfnrFcWX1dflyQjXvbwlM0kiqYm4vo3AsWDRSJhhC4
         3+FQ==
X-Gm-Message-State: AOAM531NQbtHPtO5Y0Wgfxn7iSUoagT3ESVq8jUvbqxLNW2mUzGu6J1G
        qMX4Kadf04WtQYR2QMcEqZ0=
X-Google-Smtp-Source: ABdhPJy/opVYLoBSZxFmdyMpT1eQqfRBY2ZrNEMM0e0xhcAV2z58F889PMTtmbxAzHa6fZjgzY9xTw==
X-Received: by 2002:a05:6a00:1145:b0:4f6:3ebc:a79b with SMTP id b5-20020a056a00114500b004f63ebca79bmr34524616pfm.41.1649714310017;
        Mon, 11 Apr 2022 14:58:30 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id 6-20020a621406000000b00505ad87290dsm6711688pfu.162.2022.04.11.14.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:58:28 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 06/10] drm/msm: Drop msm_gem_iova()
Date:   Mon, 11 Apr 2022 14:58:35 -0700
Message-Id: <20220411215849.297838-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411215849.297838-1-robdclark@gmail.com>
References: <20220411215849.297838-1-robdclark@gmail.com>
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

