Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FAA4FC71F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350290AbiDKWA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350274AbiDKWAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:00:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03B11275E;
        Mon, 11 Apr 2022 14:58:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c23so15078004plo.0;
        Mon, 11 Apr 2022 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FOiXrhcG6D/pgTVrD2sfYvvtxc1rOGgLTAX3yAXgAyg=;
        b=c9v+QY90G+UHTqw5akQUpW/JtS32c8Cdm5b6fk0Ih0frLz7DCn4QLK5XbqHfDd1/pj
         U9ddY11uJDs5uOv6wwmn7fC3eMMbj6epv3zU4kmHy8uIQACaxXegOgVMFw0Aw+GJu8nu
         Au0M7xWG6d3baUkmTcbtorGfeT8DSCQTZujBmYnwzc21kd1Q+rnI9cRod0Nud10CO/6e
         PDh7xbL5plTfeDDU3+GMPofmL8oXDc1X1PxXxBxFqDWgBfkf6GDk6x8YlkBjEkPBKrbX
         ia1svMoHJWNeB6PI6sUlWHJfoAVevtTMrSP/CwnwoONq32M5xG7YDrNKHqDBzxy+RpRd
         cjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FOiXrhcG6D/pgTVrD2sfYvvtxc1rOGgLTAX3yAXgAyg=;
        b=8Ew/aa41fyqcf317pIQs4pYrVLzpZzI6pd+24Oy6/ReNdzXHHPHniVOapjRpieaESp
         DC/WgrltfNrh7Q3a11JvWXgqjYd90AZezlFfB6VSL4kgJlcc99bOK2AmagYpvbNHSbcY
         14DB6ksxSyYKSf/80o7AzUd7N/wK5BUAHVqBF8e/tPzHVpnDImXQqjWjC468Ibx9n2cT
         AZONVJ3ztDQUcblm5rzXJRFO28I8ar5x83eDlOC26RTqRo1YSwKYFO6N5jxS5PABzBFS
         w5h2AOvVVbQqnar1D+J25cBz12t9UVlBZl4I1HHzJn7Cz8z+lL22FI7weS+NxIkZLf7c
         /rcA==
X-Gm-Message-State: AOAM531TWr9taFCyN2gQjkP4xeb2RpJMSGNUiTJ8l4ESIsNCqkJHdI4x
        OyEmcbmed7Ck5NviUEdnWMw=
X-Google-Smtp-Source: ABdhPJwxOGi1hkqA2QcN5GTf32C0rMz+28oJvhkEYGcNZLcAx/m70gQjwvCwJkgtrFouxLZzO6DHLQ==
X-Received: by 2002:a17:90b:4ac1:b0:1cb:bc12:1a68 with SMTP id mh1-20020a17090b4ac100b001cbbc121a68mr1355345pjb.49.1649714312256;
        Mon, 11 Apr 2022 14:58:32 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id e127-20020a621e85000000b00505a64c8ea6sm8129180pfe.66.2022.04.11.14.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:58:31 -0700 (PDT)
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
Subject: [PATCH v4 07/10] drm/msm/gem: Rework vma lookup and pin
Date:   Mon, 11 Apr 2022 14:58:36 -0700
Message-Id: <20220411215849.297838-8-robdclark@gmail.com>
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

Combines duplicate vma lookup in the get_and_pin path.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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

