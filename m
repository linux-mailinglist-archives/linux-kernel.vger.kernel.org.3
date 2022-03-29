Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF744EB663
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiC2XCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbiC2XCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:02:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B9C4AE38;
        Tue, 29 Mar 2022 16:00:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id t2so17190627pfj.10;
        Tue, 29 Mar 2022 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5mokzcWUJeEgdsztBUx3V6Ayus21b4yBmtSSS7BPMiI=;
        b=ThnTSEL/39R9/mEDiBGAOhdk0PCChMdnYROKuQIswnZ174/3+g1q4upNptNMVg9Ek3
         UWa6W+doWVOTs9cgfhVMYIdwGp5OecVIt9SKUptDZ8rBuzOFiTGduW3Cdw1E/8s/SZex
         lz7LeHwxKJXl8G0XnpotU3Je/aB5sct2bJcVASNmN8TnbIJ8JnSz1cl9OPLBq586tdA6
         SGBtmkLPp6WvU4Pi2aBeN1QF+7q6iCqIFZ0UASLbWmZbOSZtvy84S19SLskLacyTAH37
         uO/XF9NqIzOrqaAg5lAYP2bIk/QiRQ+1UwisK7xtjwmU/5HogimQn6rFcoO97U2Naf0u
         +PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5mokzcWUJeEgdsztBUx3V6Ayus21b4yBmtSSS7BPMiI=;
        b=kc0EJ+JopTcwP2oPH5EPYWUywoqj4jqW0OQS6ZPAbtQM34TGw4fOd5ouRGVadqPjfj
         YVs03bEza0FvyIX7GD7nhFAE2Y0eDCoSgUXRqEUave8qcNHuELQUiC8U6M7nIdV++lrz
         MBORZibS8YhGZHOB6TaRok2nMvz39upRN19fLt9qfm76keQw7gYV3ueJyg49qi+WO2LR
         QHlPiaxAv/ZwnZILz1xjyNtfTjrt4gzoVADfTdD5BmI4Jhyd/53rKtsYhcQkVrs2RdgT
         kDQrbOn7AMXfUX7jzP58KdphRK+7SAXCmPthCpBGJbOJZZaAn06g+trbSyjEZ3NHJN4R
         1LKw==
X-Gm-Message-State: AOAM533QlQ/J9PA+NkxIJiSYApbv7iqOl32UMKQdIy1GAW8g1U8MejJz
        K2Eg1sTMa8HvhoyJvC701SM=
X-Google-Smtp-Source: ABdhPJzhIiLz0mDyVwfumhtw2MZNZguepzv6N0tFi8ImJ4G3jDykVQHUs+A2TFwxcIfNMnCY0QMuPQ==
X-Received: by 2002:a63:4721:0:b0:382:70fa:479d with SMTP id u33-20020a634721000000b0038270fa479dmr3717925pga.259.1648594829563;
        Tue, 29 Mar 2022 16:00:29 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090a660600b001c985b0cb53sm3906992pjj.26.2022.03.29.16.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:00:28 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/9] drm/msm/gem: Drop PAGE_SHIFT for address space mm
Date:   Tue, 29 Mar 2022 16:00:52 -0700
Message-Id: <20220329230105.601666-5-robdclark@gmail.com>
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

Get rid of all the unnecessary conversion between address/size and page
offsets.  It just confuses things.

Signed-off-by: Rob Clark <robdclark@chromium.org>
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

