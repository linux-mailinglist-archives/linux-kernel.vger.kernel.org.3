Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3E7587F71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiHBPwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbiHBPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:52:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B12A2CCBB;
        Tue,  2 Aug 2022 08:51:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 130so6118664pfv.13;
        Tue, 02 Aug 2022 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2lydIYqrd+W135f9r06NI6UhXQCS/e+8vxoGcpQKqzg=;
        b=loVsfXno3F4OkX6WtMi9HTFVA7zrZ11/TR0oHh25qr+zUexe9JPK6p8LM1oQ5W2kA3
         6CyyTZ7Jebx2hDnXMe1RE5IaEbjXDEpfImPpM4m9/uFU2byrlRF0qoqzZmZvoXqkWxNv
         pLgmMR0mHXjyGznJZGD3NIQVN7AZEgjkqcsz8zdEqv0w0n0Ghc/s6ZMPxx+BcwuHu+OV
         4G87t8SI2b+rauEavzuj62lQiunyBlDMOLNBFBGcsIMUKV6ZlOb7fzCeLSKW/7WH+qoD
         51ku/1DM0zwSglyhFgCkkjNch1tdBtksG+axhSvdzS0f3FUtbV41Qf4ECv2RCGKkbC8x
         lijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2lydIYqrd+W135f9r06NI6UhXQCS/e+8vxoGcpQKqzg=;
        b=qz64tLEGqIPuujnz+9DUa3mhzDjl1APifrYZCyPvrzef/KSlYVhcaTxpymMWsGojTl
         nYL28eePma1dKCoMx/1z3b8w1BKdXKzQXzk6tGKTJN76qUHPa68FP0s2FFZNHVegTa3T
         WwnjNcfcYjhhRE8DQZKDyNdKejnTGUVTy4pHHi37sSDya6x9+/fFg7c72c7lpqT+46TO
         K3CVmcDX5ezqEZaJp8hNoeawXnX3856BBGIrAD1tPAErtsrk0Hiu9EVSTVAJV1CWF64G
         5SY6joXrAiwaFlhZjNWlU+GMFXxySp2xwixSoouXI/7hBC4dzMW7BUL3HjsN7P1lq/Qh
         D72A==
X-Gm-Message-State: AJIora+/KKPdZPPotoOOMoffksRKQf7+s2mAL+nQsENCx4sYkQ+sb+qg
        tDIb6m0HTCkr7dQx3r7i6Xg=
X-Google-Smtp-Source: AGRyM1texTaTGh1BJJVTw7XWN8lXo9/2dAJgkRwDwtOI15rv31zNkE0tFjxshdmUZ9GLTkm3lCo1rQ==
X-Received: by 2002:a05:6a00:1d26:b0:52b:f8ab:6265 with SMTP id a38-20020a056a001d2600b0052bf8ab6265mr21661696pfx.54.1659455514362;
        Tue, 02 Aug 2022 08:51:54 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id m4-20020a654384000000b0041c79a5f443sm961330pgp.9.2022.08.02.08.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:51:53 -0700 (PDT)
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
Subject: [PATCH v4 14/15] drm/msm/gem: Add msm_gem_assert_locked()
Date:   Tue,  2 Aug 2022 08:51:47 -0700
Message-Id: <20220802155152.1727594-15-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220802155152.1727594-1-robdclark@gmail.com>
References: <20220802155152.1727594-1-robdclark@gmail.com>
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

