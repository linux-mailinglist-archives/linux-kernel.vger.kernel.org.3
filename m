Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483DB581928
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbiGZRwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbiGZRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:51:19 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612F132D91;
        Tue, 26 Jul 2022 10:50:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b133so13884172pfb.6;
        Tue, 26 Jul 2022 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lydIYqrd+W135f9r06NI6UhXQCS/e+8vxoGcpQKqzg=;
        b=PDhqNYSA6xODDrDd0vHt957kMkLlkt5YZtjJxu+uvf+VzRec12Wl4zGHGQHNUR+kud
         r2uR4/8h303E1AlsaXNAe3ZhUAaJfqkiYP0VjNx0BL05Jb/zMAbRYkXPnovdWnP+9p7r
         5dvkMe5GeXznPQS1F+3pDa/nbm8Qwt3ybBYB/ZLstnjmLb3xOx3GEMP8Ze41fwemHtyQ
         ozXKvekJUrPjKiub/Y3PVDeY3AiKdoDoVnUBe/6XnPIkYEyPRNyoqqaCdj4k7BOBjbvm
         C+jMrQIrT81XHU+XCobgj7olhE+JGMUjWjw87bizuidWC86Pg/xKTPq1+2viHdzRY82B
         Vc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lydIYqrd+W135f9r06NI6UhXQCS/e+8vxoGcpQKqzg=;
        b=eStA9FE2RNay30JnUX9iK4DJBsCuATaBkGAHMnq+vn6JSahj+gCkWv6bkNwJBPKXL0
         MXHk3ujPFHdot1U+wUCf/cDvDR0xuV9BaAiqZLJPVEcN4wAUqJvznfMlbu8HyaIzdgfM
         v9Ug1QoMu1fDwLgmBJ4KWyCEt14GYSNO/bxq9qxpDcAvI7z9kc9lInXtuBMRsLV7OANW
         h/csYFedunnSJgOu2XzMV+QZpML+WXz3LuaSU6D+tBdse2Drh1qCAN1cge8c6cAPmOH5
         3iRIV92mH21+De8U7Ys5qngylgHur4YAcOW25A7oRoSbXbifrZFVxuBv71MItsxZFiYR
         VguQ==
X-Gm-Message-State: AJIora8d0nu9yF0a821+48/UUOqsFHkfqxrPnEG7iwZf0p4YvL2OC9vz
        26V8mApS+7Tco5V8UTmCm0g=
X-Google-Smtp-Source: AGRyM1sGBKIW+nSuF4xjycb0Y98jAeOZnMBjSoj/fVz6HwmitE1tylB8Q/1BW6YONmhkBh9qfmetyg==
X-Received: by 2002:a05:6a00:179e:b0:518:9e1d:1cbd with SMTP id s30-20020a056a00179e00b005189e1d1cbdmr18408477pfg.12.1658857853881;
        Tue, 26 Jul 2022 10:50:53 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id p127-20020a622985000000b00528d3d7194dsm12026601pfp.4.2022.07.26.10.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:50:52 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 14/15] drm/msm/gem: Add msm_gem_assert_locked()
Date:   Tue, 26 Jul 2022 10:50:38 -0700
Message-Id: <20220726175043.1027731-15-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220726175043.1027731-1-robdclark@gmail.com>
References: <20220726175043.1027731-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

All use of msm_gem_is_locked() is just for WARN_ON()s, so extract out
into an msm_gem_assert_locked() patch.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 36 +++++++++++++++++------------------
 drivers/gpu/drm/msm/msm_gem.h |  8 +++++++-
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index d4e8af46f4ef..1dee0d18abbb 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -97,7 +97,7 @@ static struct page **get_pages(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	if (!msm_obj->pages) {
 		struct drm_device *dev = obj->dev;
@@ -183,7 +183,7 @@ static struct page **msm_gem_pin_pages_locked(struct drm_gem_object *obj)
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct page **p;
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	if (GEM_WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED)) {
 		return ERR_PTR(-EBUSY);
@@ -278,7 +278,7 @@ static uint64_t mmap_offset(struct drm_gem_object *obj)
 	struct drm_device *dev = obj->dev;
 	int ret;
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	/* Make it mmapable */
 	ret = drm_gem_create_mmap_offset(obj);
@@ -307,7 +307,7 @@ static struct msm_gem_vma *add_vma(struct drm_gem_object *obj,
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct msm_gem_vma *vma;
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	vma = kzalloc(sizeof(*vma), GFP_KERNEL);
 	if (!vma)
@@ -326,7 +326,7 @@ static struct msm_gem_vma *lookup_vma(struct drm_gem_object *obj,
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct msm_gem_vma *vma;
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	list_for_each_entry(vma, &msm_obj->vmas, list) {
 		if (vma->aspace == aspace)
@@ -357,7 +357,7 @@ put_iova_spaces(struct drm_gem_object *obj, bool close)
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct msm_gem_vma *vma;
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	list_for_each_entry(vma, &msm_obj->vmas, list) {
 		if (vma->aspace) {
@@ -375,7 +375,7 @@ put_iova_vmas(struct drm_gem_object *obj)
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct msm_gem_vma *vma, *tmp;
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	list_for_each_entry_safe(vma, tmp, &msm_obj->vmas, list) {
 		del_vma(vma);
@@ -388,7 +388,7 @@ static struct msm_gem_vma *get_vma_locked(struct drm_gem_object *obj,
 {
 	struct msm_gem_vma *vma;
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	vma = lookup_vma(obj, aspace);
 
@@ -428,7 +428,7 @@ int msm_gem_pin_vma_locked(struct drm_gem_object *obj, struct msm_gem_vma *vma)
 	if (msm_obj->flags & MSM_BO_CACHED_COHERENT)
 		prot |= IOMMU_CACHE;
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	if (GEM_WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED))
 		return -EBUSY;
@@ -448,7 +448,7 @@ void msm_gem_unpin_locked(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	msm_obj->pin_count--;
 	GEM_WARN_ON(msm_obj->pin_count < 0);
@@ -469,7 +469,7 @@ static int get_and_pin_iova_range_locked(struct drm_gem_object *obj,
 	struct msm_gem_vma *vma;
 	int ret;
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	vma = get_vma_locked(obj, aspace, range_start, range_end);
 	if (IS_ERR(vma))
@@ -630,7 +630,7 @@ static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	int ret = 0;
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	if (obj->import_attach)
 		return ERR_PTR(-ENODEV);
@@ -703,7 +703,7 @@ void msm_gem_put_vaddr_locked(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 	GEM_WARN_ON(msm_obj->vmap_count < 1);
 
 	msm_obj->vmap_count--;
@@ -745,7 +745,7 @@ void msm_gem_purge(struct drm_gem_object *obj)
 	struct drm_device *dev = obj->dev;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 	GEM_WARN_ON(!is_purgeable(msm_obj));
 
 	/* Get rid of any iommu mapping(s): */
@@ -782,7 +782,7 @@ void msm_gem_evict(struct drm_gem_object *obj)
 	struct drm_device *dev = obj->dev;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 	GEM_WARN_ON(is_unevictable(msm_obj));
 
 	/* Get rid of any iommu mapping(s): */
@@ -797,7 +797,7 @@ void msm_gem_vunmap(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	if (!msm_obj->vaddr || GEM_WARN_ON(!is_vunmapable(msm_obj)))
 		return;
@@ -811,7 +811,7 @@ static void update_lru(struct drm_gem_object *obj)
 	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	GEM_WARN_ON(!msm_gem_is_locked(&msm_obj->base));
+	msm_gem_assert_locked(&msm_obj->base);
 
 	if (!msm_obj->pages) {
 		GEM_WARN_ON(msm_obj->pin_count);
@@ -831,7 +831,7 @@ static void update_lru(struct drm_gem_object *obj)
 
 bool msm_gem_active(struct drm_gem_object *obj)
 {
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	msm_gem_assert_locked(obj);
 
 	if (to_msm_bo(obj)->pin_count)
 		return true;
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 0403b27ff779..3c6add51d13b 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -215,6 +215,12 @@ msm_gem_is_locked(struct drm_gem_object *obj)
 	return dma_resv_is_locked(obj->resv) || (kref_read(&obj->refcount) == 0);
 }
 
+static inline void
+msm_gem_assert_locked(struct drm_gem_object *obj)
+{
+	GEM_WARN_ON(!msm_gem_is_locked(obj));
+}
+
 /* imported/exported objects are not purgeable: */
 static inline bool is_unpurgeable(struct msm_gem_object *msm_obj)
 {
@@ -229,7 +235,7 @@ static inline bool is_purgeable(struct msm_gem_object *msm_obj)
 
 static inline bool is_vunmapable(struct msm_gem_object *msm_obj)
 {
-	GEM_WARN_ON(!msm_gem_is_locked(&msm_obj->base));
+	msm_gem_assert_locked(&msm_obj->base);
 	return (msm_obj->vmap_count == 0) && msm_obj->vaddr;
 }
 
-- 
2.36.1

