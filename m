Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021FC4F6D70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiDFVxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiDFVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:52:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017EC15722;
        Wed,  6 Apr 2022 14:46:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id m16so3162396plx.3;
        Wed, 06 Apr 2022 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2N06dMrP8RW1oarOAHUuXoy5/UGnSXeufO2Lw5JU04=;
        b=bSF4Qo7mWBwdrnb2KTo0zQ+Ki2ediBd8mxppaCqrDgb7Mo9vKySm0eh3POR2pImOOX
         hMLmdyiDNSgCt7ChB74a92WT+WKtEJ9kEPSCbadDxVTKfhTOUF2tdXL07zrmOZDYEYiR
         HKHHwAHfhfef42GWwkekFvjK5hrQHSRU7kqLJi9QuNP7JeWC/K3BovFb25Mw/DFnq6N0
         y9ZptLYbyd/f3hsgRFhKTnRrOVAYNtV8LoDMFznxF7zVZoVq4ss5KEDJNbmdWWeFH7dj
         t1LLZBGGq7gy3QNhzy46JdUOBE/2a2yCTEuBL0fHZJrnB9864iPPPYxNj4VHKC5V6Ek9
         HRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2N06dMrP8RW1oarOAHUuXoy5/UGnSXeufO2Lw5JU04=;
        b=IqeTLC/C2k9KcKvm+HOWbrbnNDgHlu3HFwZI97f4OquhficMBqECmvur2wM5hxeoms
         gUbL7xsgLo2Thg3PyEg7nePpBGidbqBplQ+iL/EaVPIY/7A3zzklPmE9Dh01XK40UnS9
         S0lGbeRIba+pSSFejwCL/pVwGf6CJRmTjVp1qsSv8EfcTzfagaior9lMEEgIxzzU3xI8
         jKlLIXiSWQG6brBB1shVQ9NqgFwFAoHPfhKVKNj59h9lZjs6gVzVVw++Z3QFZMJIVtVN
         5eKY6mWMXoMW2Gmo03m7R/rWEs5EZpOCOfQCH7Z3r/4LJWLT9Drz2uf7aCDmmcLRiZXf
         Qrrw==
X-Gm-Message-State: AOAM532pwDmp56HKBn2mQ4j035r0v9kF6IspXZxwl44oSfgpyFRXWqTx
        p8QRCyrreRJ26SwzHzNcsMI=
X-Google-Smtp-Source: ABdhPJxLZ4DBBZQ0EKMOh8RF/iyUSfuDris0fGYChDNnYxGxINmrXJ0KJr2b/wEfczBfHJCVPIV/6w==
X-Received: by 2002:a17:90a:c302:b0:1bd:14ff:15 with SMTP id g2-20020a17090ac30200b001bd14ff0015mr12382599pjt.19.1649281610480;
        Wed, 06 Apr 2022 14:46:50 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm6642746pjm.13.2022.04.06.14.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:46:49 -0700 (PDT)
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
Subject: [PATCH v3 09/10] drm/msm/gem: Add fenced vma unpin
Date:   Wed,  6 Apr 2022 14:46:25 -0700
Message-Id: <20220406214636.1156978-10-robdclark@gmail.com>
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

With userspace allocated iova (next patch), we can have a race condition
where userspace observes the fence completion and deletes the vma before
retire_submit() gets around to unpinning the vma.  To handle this, add a
fenced unpin which drops the refcount but tracks the fence, and update
msm_gem_vma_inuse() to check any previously unsignaled fences.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_fence.c      |  6 ++++--
 drivers/gpu/drm/msm/msm_fence.h      |  3 +++
 drivers/gpu/drm/msm/msm_gem.c        |  2 +-
 drivers/gpu/drm/msm/msm_gem.h        |  9 +++++++--
 drivers/gpu/drm/msm/msm_gem_vma.c    | 28 +++++++++++++++++++++++++---
 drivers/gpu/drm/msm/msm_ringbuffer.c | 12 +++++++++++-
 6 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
index f2cece542c3f..3df255402a33 100644
--- a/drivers/gpu/drm/msm/msm_fence.c
+++ b/drivers/gpu/drm/msm/msm_fence.c
@@ -15,6 +15,7 @@ msm_fence_context_alloc(struct drm_device *dev, volatile uint32_t *fenceptr,
 		const char *name)
 {
 	struct msm_fence_context *fctx;
+	static int index = 0;
 
 	fctx = kzalloc(sizeof(*fctx), GFP_KERNEL);
 	if (!fctx)
@@ -23,6 +24,7 @@ msm_fence_context_alloc(struct drm_device *dev, volatile uint32_t *fenceptr,
 	fctx->dev = dev;
 	strncpy(fctx->name, name, sizeof(fctx->name));
 	fctx->context = dma_fence_context_alloc(1);
+	fctx->index = index++;
 	fctx->fenceptr = fenceptr;
 	spin_lock_init(&fctx->spinlock);
 
@@ -34,7 +36,7 @@ void msm_fence_context_free(struct msm_fence_context *fctx)
 	kfree(fctx);
 }
 
-static inline bool fence_completed(struct msm_fence_context *fctx, uint32_t fence)
+bool msm_fence_completed(struct msm_fence_context *fctx, uint32_t fence)
 {
 	/*
 	 * Note: Check completed_fence first, as fenceptr is in a write-combine
@@ -76,7 +78,7 @@ static const char *msm_fence_get_timeline_name(struct dma_fence *fence)
 static bool msm_fence_signaled(struct dma_fence *fence)
 {
 	struct msm_fence *f = to_msm_fence(fence);
-	return fence_completed(f->fctx, f->base.seqno);
+	return msm_fence_completed(f->fctx, f->base.seqno);
 }
 
 static const struct dma_fence_ops msm_fence_ops = {
diff --git a/drivers/gpu/drm/msm/msm_fence.h b/drivers/gpu/drm/msm/msm_fence.h
index 17ee3822b423..7f1798c54cd1 100644
--- a/drivers/gpu/drm/msm/msm_fence.h
+++ b/drivers/gpu/drm/msm/msm_fence.h
@@ -21,6 +21,8 @@ struct msm_fence_context {
 	char name[32];
 	/** context: see dma_fence_context_alloc() */
 	unsigned context;
+	/** index: similar to context, but local to msm_fence_context's */
+	unsigned index;
 
 	/**
 	 * last_fence:
@@ -56,6 +58,7 @@ struct msm_fence_context * msm_fence_context_alloc(struct drm_device *dev,
 		volatile uint32_t *fenceptr, const char *name);
 void msm_fence_context_free(struct msm_fence_context *fctx);
 
+bool msm_fence_completed(struct msm_fence_context *fctx, uint32_t fence);
 void msm_update_fence(struct msm_fence_context *fctx, uint32_t fence);
 
 struct dma_fence * msm_fence_alloc(struct msm_fence_context *fctx);
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index e8107a22c33a..bf4af17e2f1e 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -445,7 +445,7 @@ void msm_gem_unpin_vma_locked(struct drm_gem_object *obj, struct msm_gem_vma *vm
 
 	GEM_WARN_ON(!msm_gem_is_locked(obj));
 
-	msm_gem_unmap_vma(vma->aspace, vma);
+	msm_gem_unpin_vma(vma);
 
 	msm_obj->pin_count--;
 	GEM_WARN_ON(msm_obj->pin_count < 0);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index f98264cf130d..38d66e1248b1 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -49,6 +49,8 @@ struct msm_gem_address_space *
 msm_gem_address_space_create(struct msm_mmu *mmu, const char *name,
 		u64 va_start, u64 size);
 
+struct msm_fence_context;
+
 struct msm_gem_vma {
 	struct drm_mm_node node;
 	uint64_t iova;
@@ -56,6 +58,9 @@ struct msm_gem_vma {
 	struct list_head list;    /* node in msm_gem_object::vmas */
 	bool mapped;
 	int inuse;
+	uint32_t fence_mask;
+	uint32_t fence[MSM_GPU_MAX_RINGS];
+	struct msm_fence_context *fctx[MSM_GPU_MAX_RINGS];
 };
 
 int msm_gem_init_vma(struct msm_gem_address_space *aspace,
@@ -64,8 +69,8 @@ int msm_gem_init_vma(struct msm_gem_address_space *aspace,
 bool msm_gem_vma_inuse(struct msm_gem_vma *vma);
 void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma);
-void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma);
+void msm_gem_unpin_vma(struct msm_gem_vma *vma);
+void msm_gem_unpin_vma_fenced(struct msm_gem_vma *vma, struct msm_fence_context *fctx);
 int msm_gem_map_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma, int prot,
 		struct sg_table *sgt, int size);
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 4949899f1fc7..6f9a402450f9 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -5,6 +5,7 @@
  */
 
 #include "msm_drv.h"
+#include "msm_fence.h"
 #include "msm_gem.h"
 #include "msm_mmu.h"
 
@@ -39,7 +40,19 @@ msm_gem_address_space_get(struct msm_gem_address_space *aspace)
 
 bool msm_gem_vma_inuse(struct msm_gem_vma *vma)
 {
-	return !!vma->inuse;
+	if (vma->inuse > 0)
+		return true;
+
+	while (vma->fence_mask) {
+		unsigned idx = ffs(vma->fence_mask) - 1;
+
+		if (!msm_fence_completed(vma->fctx[idx], vma->fence[idx]))
+			return true;
+
+		vma->fence_mask &= ~BIT(idx);
+	}
+
+	return false;
 }
 
 /* Actually unmap memory for the vma */
@@ -63,13 +76,22 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 }
 
 /* Remove reference counts for the mapping */
-void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma)
+void msm_gem_unpin_vma(struct msm_gem_vma *vma)
 {
 	if (!GEM_WARN_ON(!vma->iova))
 		vma->inuse--;
 }
 
+/* Replace pin reference with fence: */
+void msm_gem_unpin_vma_fenced(struct msm_gem_vma *vma, struct msm_fence_context *fctx)
+{
+	vma->fctx[fctx->index] = fctx;
+	vma->fence[fctx->index] = fctx->last_fence;
+	vma->fence_mask |= BIT(fctx->index);
+	msm_gem_unpin_vma(vma);
+}
+
+/* Map and pin vma: */
 int
 msm_gem_map_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma, int prot,
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index 367a6aaa3a20..4ab5448fe070 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -14,9 +14,19 @@ module_param(num_hw_submissions, uint, 0600);
 static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 {
 	struct msm_gem_submit *submit = to_msm_submit(job);
+	struct msm_fence_context *fctx = submit->ring->fctx;
 	struct msm_gpu *gpu = submit->gpu;
+	int i;
 
-	submit->hw_fence = msm_fence_alloc(submit->ring->fctx);
+	submit->hw_fence = msm_fence_alloc(fctx);
+
+	for (i = 0; i < submit->nr_bos; i++) {
+		struct drm_gem_object *obj = &submit->bos[i].obj->base;
+
+		msm_gem_lock(obj);
+		msm_gem_unpin_vma_fenced(submit->bos[i].vma, fctx);
+		msm_gem_unlock(obj);
+	}
 
 	pm_runtime_get_sync(&gpu->pdev->dev);
 
-- 
2.35.1

