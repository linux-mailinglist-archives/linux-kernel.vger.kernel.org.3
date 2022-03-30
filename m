Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C8B4ECE63
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351166AbiC3Uut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351205AbiC3UuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:50:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B861A28E0A;
        Wed, 30 Mar 2022 13:48:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so1343153pjf.1;
        Wed, 30 Mar 2022 13:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YhqBYA9LoIJ60EteTk4vCygqpc91SV8qqSrLcG+7bKE=;
        b=L4SR1WCpED6fkMkYuMq3AOPXc7D+DfBVHRbBTe0mTx0nwQjpoUpWp0yIRLexbteB61
         CV3lexE8g+SPRee0kIY+szy+eBmElgYVAPlTZa03xsrOwJwWJmc/URyKIgA6L4vso4Sw
         6p0r/Jaw17uPV6KjeFurzPR3vzmqbeGLyZenexARFf1ct+Sv717Iug03T/3BIbm6Jwfj
         RQcoMsS82pOjple+UrCxzBEUuhcduUGEKWegSsCLy8xtTXTl6KqgJkN5/2K6gJv1Ki7h
         9syOyxo+/DSsaFis/bcg5Hvf6/ziLbYmcobQaV5WVExW4mvGxljlzeq54VrNxmVDTFd+
         lcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YhqBYA9LoIJ60EteTk4vCygqpc91SV8qqSrLcG+7bKE=;
        b=eEwNK2QWrpx1fAtMy6jRAeXpvkcxTB1/NjC9dj6rx2vVkU2JSPsVnQ6qFneItwhGmJ
         AS2ew0y2QpYEwhNi+U0YteieLZTd/f6OOzt0HQw+ni5qBGIqWDpaJNS5R60RbZFpukaU
         6Y2f8JPfaI2ixoSOhTm2ANF9kcspUKi1Xkw0I8L8PNDsgopCYCIC+aEP3N68Q5VjogFM
         0UZcBe0ChhBszQ4Na8j89i7h0OBkB6c5nWzCUtyqLNHVO78lwL0YatVQJU1XsBKDM/f1
         xFPefb/LHjtg1+j18YITzgYzwvAL/dzSil8S0GTor2HzHWQpoCWFtggmCpaj+M8F+upW
         qYvg==
X-Gm-Message-State: AOAM532jRPzYLSd9k73tRARLIav224qkptZxxPA1bwAxb9HhsYIxPC0h
        CAnStAvOFerGHU4ydd0mWMs=
X-Google-Smtp-Source: ABdhPJzliute0Xo12/AQ7Lagh7KmApHVAEXKXm8zAL9n1MqwiTAD6W3ussZ2n3k1etmO+Q5vQGj6MQ==
X-Received: by 2002:a17:90b:1583:b0:1c7:3736:629c with SMTP id lc3-20020a17090b158300b001c73736629cmr1512606pjb.215.1648673300173;
        Wed, 30 Mar 2022 13:48:20 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a390d00b001c995e0a481sm7264610pjb.30.2022.03.30.13.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:48:19 -0700 (PDT)
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
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Emma Anholt <emma@anholt.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 10/10] drm/msm: Add a way for userspace to allocate GPU iova
Date:   Wed, 30 Mar 2022 13:47:55 -0700
Message-Id: <20220330204804.660819-11-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330204804.660819-1-robdclark@gmail.com>
References: <20220330204804.660819-1-robdclark@gmail.com>
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

The motivation at this point is mainly native userspace mesa driver in a
VM guest.  The one remaining synchronous "hotpath" is buffer allocation,
because guest needs to wait to know the bo's iova before it can start
emitting cmdstream/state that references the new bo.  By allocating the
iova in the guest userspace, we no longer need to wait for a response
from the host, but can just rely on the allocation request being
processed before the cmdstream submission.  Allocation failures (OoM,
etc) would just be treated as context-lost (ie. GL_GUILTY_CONTEXT_RESET)
or subsequent allocations (or readpix, etc) can raise GL_OUT_OF_MEMORY.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++
 drivers/gpu/drm/msm/msm_drv.c           | 21 +++++++++++
 drivers/gpu/drm/msm/msm_gem.c           | 48 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_gem.h           |  8 +++++
 drivers/gpu/drm/msm/msm_gem_vma.c       |  2 ++
 include/uapi/drm/msm_drm.h              |  3 ++
 6 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 6385ab06632f..4caae0229518 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -281,6 +281,16 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 	case MSM_PARAM_SUSPENDS:
 		*value = gpu->suspend_count;
 		return 0;
+	case MSM_PARAM_VA_START:
+		if (ctx->aspace == gpu->aspace)
+			return -EINVAL;
+		*value = ctx->aspace->va_start;
+		return 0;
+	case MSM_PARAM_VA_SIZE:
+		if (ctx->aspace == gpu->aspace)
+			return -EINVAL;
+		*value = ctx->aspace->va_size;
+		return 0;
 	default:
 		DBG("%s: invalid param: %u", gpu->name, param);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index a5eed5738ac8..45523b4123eb 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -719,6 +719,23 @@ static int msm_ioctl_gem_info_iova(struct drm_device *dev,
 	return msm_gem_get_iova(obj, ctx->aspace, iova);
 }
 
+static int msm_ioctl_gem_info_set_iova(struct drm_device *dev,
+		struct drm_file *file, struct drm_gem_object *obj,
+		uint64_t iova)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+	struct msm_file_private *ctx = file->driver_priv;
+
+	if (!priv->gpu)
+		return -EINVAL;
+
+	/* Only supported if per-process address space is supported: */
+	if (priv->gpu->aspace == ctx->aspace)
+		return -EOPNOTSUPP;
+
+	return msm_gem_set_iova(obj, ctx->aspace, iova);
+}
+
 static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
@@ -733,6 +750,7 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 	switch (args->info) {
 	case MSM_INFO_GET_OFFSET:
 	case MSM_INFO_GET_IOVA:
+	case MSM_INFO_SET_IOVA:
 		/* value returned as immediate, not pointer, so len==0: */
 		if (args->len)
 			return -EINVAL;
@@ -757,6 +775,9 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 	case MSM_INFO_GET_IOVA:
 		ret = msm_ioctl_gem_info_iova(dev, file, obj, &args->value);
 		break;
+	case MSM_INFO_SET_IOVA:
+		ret = msm_ioctl_gem_info_set_iova(dev, file, obj, args->value);
+		break;
 	case MSM_INFO_SET_NAME:
 		/* length check should leave room for terminating null: */
 		if (args->len >= sizeof(msm_obj->name)) {
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index bf4af17e2f1e..83ded2b7154e 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -525,6 +525,54 @@ int msm_gem_get_iova(struct drm_gem_object *obj,
 	return ret;
 }
 
+static int clear_iova(struct drm_gem_object *obj,
+		      struct msm_gem_address_space *aspace)
+{
+	struct msm_gem_vma *vma = lookup_vma(obj, aspace);
+
+	if (!vma)
+		return 0;
+
+	if (msm_gem_vma_inuse(vma))
+		return -EBUSY;
+
+	msm_gem_purge_vma(vma->aspace, vma);
+	msm_gem_close_vma(vma->aspace, vma);
+	del_vma(vma);
+
+	return 0;
+}
+
+/*
+ * Get the requested iova but don't pin it.  Fails if the requested iova is
+ * not available.  Doesn't need a put because iovas are currently valid for
+ * the life of the object.
+ *
+ * Setting an iova of zero will clear the vma.
+ */
+int msm_gem_set_iova(struct drm_gem_object *obj,
+		     struct msm_gem_address_space *aspace, uint64_t iova)
+{
+	int ret = 0;
+
+	msm_gem_lock(obj);
+	if (!iova) {
+		ret = clear_iova(obj, aspace);
+	} else {
+		struct msm_gem_vma *vma;
+		vma = get_vma_locked(obj, aspace, iova, iova + obj->size);
+		if (IS_ERR(vma)) {
+			ret = PTR_ERR(vma);
+		} else if (GEM_WARN_ON(vma->iova != iova)) {
+			clear_iova(obj, aspace);
+			ret = -ENOSPC;
+		}
+	}
+	msm_gem_unlock(obj);
+
+	return ret;
+}
+
 /*
  * Unpin a iova by updating the reference counts. The memory isn't actually
  * purged until something else (shrinker, mm_notifier, destroy, etc) decides
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 38d66e1248b1..efa2e5c19f1e 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -38,6 +38,12 @@ struct msm_gem_address_space {
 
 	/* @faults: the number of GPU hangs associated with this address space */
 	int faults;
+
+	/** @va_start: lowest possible address to allocate */
+	uint64_t va_start;
+
+	/** @va_size: the size of the address space (in bytes) */
+	uint64_t va_size;
 };
 
 struct msm_gem_address_space *
@@ -144,6 +150,8 @@ struct msm_gem_vma *msm_gem_get_vma_locked(struct drm_gem_object *obj,
 					   struct msm_gem_address_space *aspace);
 int msm_gem_get_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova);
+int msm_gem_set_iova(struct drm_gem_object *obj,
+		struct msm_gem_address_space *aspace, uint64_t iova);
 int msm_gem_get_and_pin_iova_range(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova,
 		u64 range_start, u64 range_end);
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 6f9a402450f9..354f91aff573 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -182,6 +182,8 @@ msm_gem_address_space_create(struct msm_mmu *mmu, const char *name,
 	spin_lock_init(&aspace->lock);
 	aspace->name = name;
 	aspace->mmu = mmu;
+	aspace->va_start = va_start;
+	aspace->va_size  = size;
 
 	drm_mm_init(&aspace->mm, va_start, size);
 
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 794ad1948497..3c7b097c4e3d 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -84,6 +84,8 @@ struct drm_msm_timespec {
 #define MSM_PARAM_SYSPROF    0x0b  /* WO: 1 preserves perfcntrs, 2 also disables suspend */
 #define MSM_PARAM_COMM       0x0c  /* WO: override for task->comm */
 #define MSM_PARAM_CMDLINE    0x0d  /* WO: override for task cmdline */
+#define MSM_PARAM_VA_START   0x0e  /* RO: start of valid GPU iova range */
+#define MSM_PARAM_VA_SIZE    0x0f  /* RO: size of valid GPU iova range (bytes) */
 
 /* For backwards compat.  The original support for preemption was based on
  * a single ring per priority level so # of priority levels equals the #
@@ -135,6 +137,7 @@ struct drm_msm_gem_new {
 #define MSM_INFO_GET_IOVA	0x01   /* get iova, returned by value */
 #define MSM_INFO_SET_NAME	0x02   /* set the debug name (by pointer) */
 #define MSM_INFO_GET_NAME	0x03   /* get debug name, returned by pointer */
+#define MSM_INFO_SET_IOVA	0x04   /* set the iova, passed by value */
 
 struct drm_msm_gem_info {
 	__u32 handle;         /* in */
-- 
2.35.1

