Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B564ECE69
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351186AbiC3Uul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351161AbiC3UuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:50:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C4849933;
        Wed, 30 Mar 2022 13:48:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so807258pjb.4;
        Wed, 30 Mar 2022 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOn9Tor8polPNHF4xDcLky0lDAw9l38xozLRMXI1//U=;
        b=UPK7hL40Q2YvCF9wKbtwYgJsCkDD4S3VjnoBgdNSt+WHM9zo7jOHSYtbtzE/pU7cc0
         vWJUocRHernfEg73QBM9SK2P7rVRf+2qdpt+ZCnjAmUNaIeYI02wik/UvelXsmEXugFg
         mTdOEsnNaUwfQ3W9rElImmVHtS95BnTfIj0w4SFFy33B7vRuFqiyB0rLTQpND+vxfjtH
         rCYoA7o2YWALAs1UeWMk1if0oh2cESd++RhA4sJ9c4ITBqScF7/6YyldnC+nq+FLVFGB
         8O8zqvBh1YQAdW1FoWS9e2nQjbVz42hJ+8eewUQecBhbeb47p8JtIXXDUNSDVXTrK/WH
         dwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOn9Tor8polPNHF4xDcLky0lDAw9l38xozLRMXI1//U=;
        b=bKqw9IZ+8KdPmcrAeJyrWLaUBihGEfpgEhlUnC6QQZtpjvrr8C70Q9F399p+LTiLL9
         CI6Lqamwq8YesqYOR7p3aGzU9rK8/4mbMpOMtBtDnsPGOoNUkfGprZidO04gZ2g4JzVP
         6wj+DvfoNGStOKDCCCzs9ra610L4arNzG+Fm20sXqs7zrT4TOMnTIZJWFPkVtR/Szy15
         Y08ZREPaXFRJYP+DOgRkUoz87wnY+FXLxyd9h8k9FNscW3f+s7Lm/zCIkggbzQb7d5s0
         6gxOaY4fA1zfo5m8JWQfiqJCfdYYL8g9LeAdbCiq34SBU2QeHKRk5xVvTfww/r4L5Rgd
         Ntdg==
X-Gm-Message-State: AOAM532PDNMe2ce4VnhQFbY9rBkCxVdpAmKCQw6jxWsdbSrbTVE0L2Q1
        jGxgNyQK6BsdpCZ12rw5vRE=
X-Google-Smtp-Source: ABdhPJwJYRnX56RJoMLOVKWPDbw1s9PqMDGKWuJcsQPWKmnOylUzAMHvewFPAxCbjEv4C8yhrsXlMQ==
X-Received: by 2002:a17:902:c745:b0:151:e8fa:629b with SMTP id q5-20020a170902c74500b00151e8fa629bmr38131930plq.90.1648673291159;
        Wed, 30 Mar 2022 13:48:11 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id d21-20020a056a0024d500b004fb0e7c7c3bsm21656825pfv.161.2022.03.30.13.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:48:10 -0700 (PDT)
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
Subject: [PATCH v2 07/10] drm/msm/gem: Rework vma lookup and pin
Date:   Wed, 30 Mar 2022 13:47:52 -0700
Message-Id: <20220330204804.660819-8-robdclark@gmail.com>
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

Combines duplicate vma lookup in the get_and_pin path.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 50 ++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index deafae6feaa8..218744a490a4 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -376,39 +376,40 @@ put_iova_vmas(struct drm_gem_object *obj)
 	}
 }
 
-static int get_iova_locked(struct drm_gem_object *obj,
-		struct msm_gem_address_space *aspace, uint64_t *iova,
+static struct msm_gem_vma *get_vma_locked(struct drm_gem_object *obj,
+		struct msm_gem_address_space *aspace,
 		u64 range_start, u64 range_end)
 {
 	struct msm_gem_vma *vma;
-	int ret = 0;
 
 	GEM_WARN_ON(!msm_gem_is_locked(obj));
 
 	vma = lookup_vma(obj, aspace);
 
 	if (!vma) {
+		int ret;
+
 		vma = add_vma(obj, aspace);
 		if (IS_ERR(vma))
-			return PTR_ERR(vma);
+			return vma;
 
 		ret = msm_gem_init_vma(aspace, vma, obj->size,
 			range_start, range_end);
 		if (ret) {
 			del_vma(vma);
-			return ret;
+			return ERR_PTR(ret);
 		}
+	} else {
+		GEM_WARN_ON(vma->iova < range_start);
+		GEM_WARN_ON((vma->iova + obj->size) > range_end);
 	}
 
-	*iova = vma->iova;
-	return 0;
+	return vma;
 }
 
-static int msm_gem_pin_iova(struct drm_gem_object *obj,
-		struct msm_gem_address_space *aspace)
+static int msm_gem_pin_iova(struct drm_gem_object *obj, struct msm_gem_vma *vma)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	struct msm_gem_vma *vma;
 	struct page **pages;
 	int ret, prot = IOMMU_READ;
 
@@ -426,15 +427,11 @@ static int msm_gem_pin_iova(struct drm_gem_object *obj,
 	if (GEM_WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED))
 		return -EBUSY;
 
-	vma = lookup_vma(obj, aspace);
-	if (GEM_WARN_ON(!vma))
-		return -EINVAL;
-
 	pages = get_pages(obj);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
 
-	ret = msm_gem_map_vma(aspace, vma, prot, msm_obj->sgt, obj->size);
+	ret = msm_gem_map_vma(vma->aspace, vma, prot, msm_obj->sgt, obj->size);
 
 	if (!ret)
 		msm_obj->pin_count++;
@@ -446,19 +443,18 @@ static int get_and_pin_iova_range_locked(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova,
 		u64 range_start, u64 range_end)
 {
-	u64 local;
+	struct msm_gem_vma *vma;
 	int ret;
 
 	GEM_WARN_ON(!msm_gem_is_locked(obj));
 
-	ret = get_iova_locked(obj, aspace, &local,
-		range_start, range_end);
-
-	if (!ret)
-		ret = msm_gem_pin_iova(obj, aspace);
+	vma = get_vma_locked(obj, aspace, range_start, range_end);
+	if (IS_ERR(vma))
+		return PTR_ERR(vma);
 
+	ret = msm_gem_pin_iova(obj, vma);
 	if (!ret)
-		*iova = local;
+		*iova = vma->iova;
 
 	return ret;
 }
@@ -500,10 +496,16 @@ int msm_gem_get_and_pin_iova(struct drm_gem_object *obj,
 int msm_gem_get_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova)
 {
-	int ret;
+	struct msm_gem_vma *vma;
+	int ret = 0;
 
 	msm_gem_lock(obj);
-	ret = get_iova_locked(obj, aspace, iova, 0, U64_MAX);
+	vma = get_vma_locked(obj, aspace, 0, U64_MAX);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+	} else {
+		*iova = vma->iova;
+	}
 	msm_gem_unlock(obj);
 
 	return ret;
-- 
2.35.1

