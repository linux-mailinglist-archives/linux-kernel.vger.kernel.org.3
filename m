Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0016A4FC714
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350281AbiDKWAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbiDKWAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:00:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69A12615;
        Mon, 11 Apr 2022 14:58:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y6so15046328plg.2;
        Mon, 11 Apr 2022 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYDyepM1PAw2FFzhXN5YHyImg0OWJ25svdZsQDoslA8=;
        b=IgiRq2YBM9Q50bND9/T2EktfHs+bywcFM7harxYjE0GN6FuDi/15cA6S/MCP8Vt9OQ
         2weBoDASOho8EfSReOYF5cXfkuV1GWZ7Cfxz99OMzlP651CNwlyERUMuwDkfFyccTwKa
         lPsYMBl5FBW34vF3T2i1jY4T62syvF5nROTRxHKJfmjr+jzm/Sin1+aF9uVhhmK3Mfgc
         EBim/ZpDh544gRE2URA+qllOTpKiX+SNGhJCWNgEIl4J6TSKcCkloRTyshNUgLHtkOJo
         cEEn9t78tD0FJNLb8HQG7CJXDtmI1Z8VPduaf8Zz/HcDgUFenN9VoxDK6fUJEVWAhw76
         0cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYDyepM1PAw2FFzhXN5YHyImg0OWJ25svdZsQDoslA8=;
        b=nqOXcjvN1oFSaVuDvlGDzu1+8rq9z/CwtZYlXPS9ZR/nTCNT23nzEDNMaI2bOT6/VE
         1Yfhvux5yRJtllCVMCmtLdGLEIQdTgri5eOVv19j6wSJDWLxrKvEWZj3ivmkdP225Jpa
         nWtoSA+7ZqS0dwAme0GEqbRIDW/Dsynpo2w3L+mSi3vxU3dIquavTpm6NI7h7Vp+Kht6
         qlOnqLe3Jvgy6iwlopzQ2z53WHVek/fSqigCetsH1rm3SVBsr9y6sjsxUuxJOWdk8jcF
         giNsvU6ek0cJXc8PT6RLK8Ydk8Dythy4QPq+3sW+ugOcX7+MSsyDsGtoey2AbDTdikM0
         hMFA==
X-Gm-Message-State: AOAM532PJ5gwb7RMMCN6TemXtTblaZQo+7mCDy6M9jQcR7MmKWs7vV2P
        JY5Xq4Y0or+B6ll8H5ZFQLw=
X-Google-Smtp-Source: ABdhPJyWO+TC5on2boxn2KlxubjD3ibBGCOduavereEJTX0OpC47juaojhwLl4CEGYwt29WcKG23BA==
X-Received: by 2002:a17:90a:b10c:b0:1cb:9e27:5005 with SMTP id z12-20020a17090ab10c00b001cb9e275005mr1331492pjq.241.1649714307405;
        Mon, 11 Apr 2022 14:58:27 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm413254pjv.57.2022.04.11.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:58:26 -0700 (PDT)
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
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Wang Qing <wangqing@vivo.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 05/10] drm/msm/gem: Drop PAGE_SHIFT for address space mm
Date:   Mon, 11 Apr 2022 14:58:34 -0700
Message-Id: <20220411215849.297838-6-robdclark@gmail.com>
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

Get rid of all the unnecessary conversion between address/size and page
offsets.  It just confuses things.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  2 +-
 drivers/gpu/drm/msm/msm_gem.c         |  5 ++---
 drivers/gpu/drm/msm/msm_gem.h         |  4 ++--
 drivers/gpu/drm/msm/msm_gem_vma.c     | 16 ++++++++--------
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 3e325e2a2b1b..9f76f5b15759 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1172,7 +1172,7 @@ static int a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu, struct a6xx_gmu_bo *bo,
 		return PTR_ERR(bo->obj);
 
 	ret = msm_gem_get_and_pin_iova_range(bo->obj, gmu->aspace, &bo->iova,
-		range_start >> PAGE_SHIFT, range_end >> PAGE_SHIFT);
+					     range_start, range_end);
 	if (ret) {
 		drm_gem_object_put(bo->obj);
 		return ret;
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index f96d1dc72021..f4b68bb28a4d 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -392,7 +392,7 @@ static int get_iova_locked(struct drm_gem_object *obj,
 		if (IS_ERR(vma))
 			return PTR_ERR(vma);
 
-		ret = msm_gem_init_vma(aspace, vma, obj->size >> PAGE_SHIFT,
+		ret = msm_gem_init_vma(aspace, vma, obj->size,
 			range_start, range_end);
 		if (ret) {
 			del_vma(vma);
@@ -434,8 +434,7 @@ static int msm_gem_pin_iova(struct drm_gem_object *obj,
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
 
-	ret = msm_gem_map_vma(aspace, vma, prot,
-			msm_obj->sgt, obj->size >> PAGE_SHIFT);
+	ret = msm_gem_map_vma(aspace, vma, prot, msm_obj->sgt, obj->size);
 
 	if (!ret)
 		msm_obj->pin_count++;
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 1b7f0f0b88bf..090c3b1a6d9a 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -59,7 +59,7 @@ struct msm_gem_vma {
 };
 
 int msm_gem_init_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma, int npages,
+		struct msm_gem_vma *vma, int size,
 		u64 range_start, u64 range_end);
 bool msm_gem_vma_inuse(struct msm_gem_vma *vma);
 void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
@@ -68,7 +68,7 @@ void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma);
 int msm_gem_map_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma, int prot,
-		struct sg_table *sgt, int npages);
+		struct sg_table *sgt, int size);
 void msm_gem_close_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma);
 
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index dc2ae097805e..4949899f1fc7 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -46,7 +46,7 @@ bool msm_gem_vma_inuse(struct msm_gem_vma *vma)
 void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
 {
-	unsigned size = vma->node.size << PAGE_SHIFT;
+	unsigned size = vma->node.size;
 
 	/* Print a message if we try to purge a vma in use */
 	if (GEM_WARN_ON(msm_gem_vma_inuse(vma)))
@@ -73,9 +73,8 @@ void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
 int
 msm_gem_map_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma, int prot,
-		struct sg_table *sgt, int npages)
+		struct sg_table *sgt, int size)
 {
-	unsigned size = npages << PAGE_SHIFT;
 	int ret = 0;
 
 	if (GEM_WARN_ON(!vma->iova))
@@ -120,7 +119,7 @@ void msm_gem_close_vma(struct msm_gem_address_space *aspace,
 
 /* Initialize a new vma and allocate an iova for it */
 int msm_gem_init_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma, int npages,
+		struct msm_gem_vma *vma, int size,
 		u64 range_start, u64 range_end)
 {
 	int ret;
@@ -129,14 +128,15 @@ int msm_gem_init_vma(struct msm_gem_address_space *aspace,
 		return -EBUSY;
 
 	spin_lock(&aspace->lock);
-	ret = drm_mm_insert_node_in_range(&aspace->mm, &vma->node, npages, 0,
-		0, range_start, range_end, 0);
+	ret = drm_mm_insert_node_in_range(&aspace->mm, &vma->node,
+					  size, PAGE_SIZE, 0,
+					  range_start, range_end, 0);
 	spin_unlock(&aspace->lock);
 
 	if (ret)
 		return ret;
 
-	vma->iova = vma->node.start << PAGE_SHIFT;
+	vma->iova = vma->node.start;
 	vma->mapped = false;
 
 	kref_get(&aspace->kref);
@@ -161,7 +161,7 @@ msm_gem_address_space_create(struct msm_mmu *mmu, const char *name,
 	aspace->name = name;
 	aspace->mmu = mmu;
 
-	drm_mm_init(&aspace->mm, va_start >> PAGE_SHIFT, size >> PAGE_SHIFT);
+	drm_mm_init(&aspace->mm, va_start, size);
 
 	kref_init(&aspace->kref);
 
-- 
2.35.1

