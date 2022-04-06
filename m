Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2824F6D74
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbiDFVyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiDFVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:52:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1377615708;
        Wed,  6 Apr 2022 14:46:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o20so3123061pla.13;
        Wed, 06 Apr 2022 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05mUL8FeeCXWVDafJ6OfP4ybn8WOOy9jUdlt3AmYSNs=;
        b=C/htTmoJPwHdsusOkfG+Rwk/o+/FKO4D3LDZS6ygNSErkB/XiVDpeKzRddPa9x7Z+t
         W4lUJMdHW/CEkxuSpZIweiO1glI2u5YB7x/jwQrn69y2lDlw3Ac7iYqt417IYtMHa6kB
         OarTPgwKpNs1vVpbVADkBAcnjhQzFM343X70aEJLjZHHekIed+gZkwTKpViIT9YMfPWj
         Qy96FmRSer5cX9Q5P8SvsI0lkcEg5BoH8oisAHdv7zM0BrL4MjKRgRuBois4QZW55Aue
         iWkiJLNny7syqCAtdIlfPWwMGlJlL0j4MbB+svhqYwCjKbS3cC1rV9K3rhEUIxFENsGE
         GI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05mUL8FeeCXWVDafJ6OfP4ybn8WOOy9jUdlt3AmYSNs=;
        b=xT5FQx2dCREUOCY8c1okA+gBi0ylgd6u1/l81mbkirIROdUjG4PTnGVQmKmQnHuFGr
         oNqmu9UQFXHRluZQt3WM5A+PuNs67uH2hSdDF15qT/d5r75z8INOUMMLAzesNALlG3YS
         Kp0j4A75J1tirD1xXXr0X8WSDJ/tAS7A21psAVcOXKCvNc7Z5BsL4C7H6luFaGlaB+B1
         Sl6NoSdcjCTA1+sj6LVoEf9NYD2oIe1M8N82038HZKDtVHz2gNfoC5115kR0Y4stdqAI
         uekIspg5d9hAtjxuhNSy19QdMfqlloFiXtS2x2/LPAe636P3nWhA6KwDwfZpAA90+JQh
         hTpQ==
X-Gm-Message-State: AOAM531pdhpDlnXorI1RYkGFomdFQTAwfcOyhZ32OtVBx0Gyl3j44cFd
        aCFG8G9XTdWYTVIVYz7jvjo=
X-Google-Smtp-Source: ABdhPJxPXOjJ4YTTM3itRDHPef7YTGBTVqEzOTUqnK9JWuqXuLcVqCxfHcfGVgvzJfUS3LNlSGPyVg==
X-Received: by 2002:a17:90b:380b:b0:1ca:c6dd:d75b with SMTP id mq11-20020a17090b380b00b001cac6ddd75bmr12330809pjb.146.1649281608126;
        Wed, 06 Apr 2022 14:46:48 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7982d000000b004fb199b9c7dsm21126253pfl.119.2022.04.06.14.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:46:47 -0700 (PDT)
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
Subject: [PATCH v3 08/10] drm/msm/gem: Split vma lookup and pin
Date:   Wed,  6 Apr 2022 14:46:24 -0700
Message-Id: <20220406214636.1156978-9-robdclark@gmail.com>
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

This way we only lookup vma once per object per submit, for both the
submit and retire path.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c        | 60 +++++++++++++---------------
 drivers/gpu/drm/msm/msm_gem.h        |  9 +++--
 drivers/gpu/drm/msm/msm_gem_submit.c | 17 +++++---
 3 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 218744a490a4..e8107a22c33a 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -407,7 +407,7 @@ static struct msm_gem_vma *get_vma_locked(struct drm_gem_object *obj,
 	return vma;
 }
 
-static int msm_gem_pin_iova(struct drm_gem_object *obj, struct msm_gem_vma *vma)
+int msm_gem_pin_vma_locked(struct drm_gem_object *obj, struct msm_gem_vma *vma)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct page **pages;
@@ -439,6 +439,26 @@ static int msm_gem_pin_iova(struct drm_gem_object *obj, struct msm_gem_vma *vma)
 	return ret;
 }
 
+void msm_gem_unpin_vma_locked(struct drm_gem_object *obj, struct msm_gem_vma *vma)
+{
+	struct msm_gem_object *msm_obj = to_msm_bo(obj);
+
+	GEM_WARN_ON(!msm_gem_is_locked(obj));
+
+	msm_gem_unmap_vma(vma->aspace, vma);
+
+	msm_obj->pin_count--;
+	GEM_WARN_ON(msm_obj->pin_count < 0);
+
+	update_inactive(msm_obj);
+}
+
+struct msm_gem_vma *msm_gem_get_vma_locked(struct drm_gem_object *obj,
+					   struct msm_gem_address_space *aspace)
+{
+	return get_vma_locked(obj, aspace, 0, U64_MAX);
+}
+
 static int get_and_pin_iova_range_locked(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova,
 		u64 range_start, u64 range_end)
@@ -452,7 +472,7 @@ static int get_and_pin_iova_range_locked(struct drm_gem_object *obj,
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
 
-	ret = msm_gem_pin_iova(obj, vma);
+	ret = msm_gem_pin_vma_locked(obj, vma);
 	if (!ret)
 		*iova = vma->iova;
 
@@ -476,12 +496,6 @@ int msm_gem_get_and_pin_iova_range(struct drm_gem_object *obj,
 	return ret;
 }
 
-int msm_gem_get_and_pin_iova_locked(struct drm_gem_object *obj,
-		struct msm_gem_address_space *aspace, uint64_t *iova)
-{
-	return get_and_pin_iova_range_locked(obj, aspace, iova, 0, U64_MAX);
-}
-
 /* get iova and pin it. Should have a matching put */
 int msm_gem_get_and_pin_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova)
@@ -511,29 +525,6 @@ int msm_gem_get_iova(struct drm_gem_object *obj,
 	return ret;
 }
 
-/*
- * Locked variant of msm_gem_unpin_iova()
- */
-void msm_gem_unpin_iova_locked(struct drm_gem_object *obj,
-		struct msm_gem_address_space *aspace)
-{
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	struct msm_gem_vma *vma;
-
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
-
-	vma = lookup_vma(obj, aspace);
-
-	if (!GEM_WARN_ON(!vma)) {
-		msm_gem_unmap_vma(aspace, vma);
-
-		msm_obj->pin_count--;
-		GEM_WARN_ON(msm_obj->pin_count < 0);
-
-		update_inactive(msm_obj);
-	}
-}
-
 /*
  * Unpin a iova by updating the reference counts. The memory isn't actually
  * purged until something else (shrinker, mm_notifier, destroy, etc) decides
@@ -542,8 +533,13 @@ void msm_gem_unpin_iova_locked(struct drm_gem_object *obj,
 void msm_gem_unpin_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace)
 {
+	struct msm_gem_vma *vma;
+
 	msm_gem_lock(obj);
-	msm_gem_unpin_iova_locked(obj, aspace);
+	vma = lookup_vma(obj, aspace);
+	if (!GEM_WARN_ON(!vma)) {
+		msm_gem_unpin_vma_locked(obj, vma);
+	}
 	msm_gem_unlock(obj);
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 772de010a669..f98264cf130d 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -133,17 +133,17 @@ struct msm_gem_object {
 #define to_msm_bo(x) container_of(x, struct msm_gem_object, base)
 
 uint64_t msm_gem_mmap_offset(struct drm_gem_object *obj);
+int msm_gem_pin_vma_locked(struct drm_gem_object *obj, struct msm_gem_vma *vma);
+void msm_gem_unpin_vma_locked(struct drm_gem_object *obj, struct msm_gem_vma *vma);
+struct msm_gem_vma *msm_gem_get_vma_locked(struct drm_gem_object *obj,
+					   struct msm_gem_address_space *aspace);
 int msm_gem_get_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova);
 int msm_gem_get_and_pin_iova_range(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova,
 		u64 range_start, u64 range_end);
-int msm_gem_get_and_pin_iova_locked(struct drm_gem_object *obj,
-		struct msm_gem_address_space *aspace, uint64_t *iova);
 int msm_gem_get_and_pin_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova);
-void msm_gem_unpin_iova_locked(struct drm_gem_object *obj,
-		struct msm_gem_address_space *aspace);
 void msm_gem_unpin_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace);
 struct page **msm_gem_get_pages(struct drm_gem_object *obj);
@@ -369,6 +369,7 @@ struct msm_gem_submit {
 			uint32_t handle;
 		};
 		uint64_t iova;
+		struct msm_gem_vma *vma;
 	} bos[];
 };
 
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index c6d60c8d286d..91da05af40ee 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -232,7 +232,7 @@ static void submit_cleanup_bo(struct msm_gem_submit *submit, int i,
 	unsigned flags = submit->bos[i].flags & cleanup_flags;
 
 	if (flags & BO_PINNED)
-		msm_gem_unpin_iova_locked(obj, submit->aspace);
+		msm_gem_unpin_vma_locked(obj, submit->bos[i].vma);
 
 	if (flags & BO_ACTIVE)
 		msm_gem_active_put(obj);
@@ -365,21 +365,26 @@ static int submit_pin_objects(struct msm_gem_submit *submit)
 
 	for (i = 0; i < submit->nr_bos; i++) {
 		struct drm_gem_object *obj = &submit->bos[i].obj->base;
-		uint64_t iova;
+		struct msm_gem_vma *vma;
 
 		/* if locking succeeded, pin bo: */
-		ret = msm_gem_get_and_pin_iova_locked(obj,
-				submit->aspace, &iova);
+		vma = msm_gem_get_vma_locked(obj, submit->aspace);
+		if (IS_ERR(vma)) {
+			ret = PTR_ERR(vma);
+			break;
+		}
 
+		ret = msm_gem_pin_vma_locked(obj, vma);
 		if (ret)
 			break;
 
 		submit->bos[i].flags |= BO_PINNED;
+		submit->bos[i].vma = vma;
 
-		if (iova == submit->bos[i].iova) {
+		if (vma->iova == submit->bos[i].iova) {
 			submit->bos[i].flags |= BO_VALID;
 		} else {
-			submit->bos[i].iova = iova;
+			submit->bos[i].iova = vma->iova;
 			/* iova changed, so address in cmdstream is not valid: */
 			submit->bos[i].flags &= ~BO_VALID;
 			submit->valid = false;
-- 
2.35.1

