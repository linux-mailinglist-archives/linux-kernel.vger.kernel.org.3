Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F17587F4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiHBPvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiHBPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:51:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69A8252AE;
        Tue,  2 Aug 2022 08:51:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f28so5701440pfk.1;
        Tue, 02 Aug 2022 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6E5wGlWgwtmRN55cq/vUaSJZuL1NyuRgvoYtJGWwhUY=;
        b=GEfOJB7gdA4SxlaauM6Ugt1tZF4JKhQxQH244oEQIqhh9LV1XJGzasRjPRwFOhk6nj
         LqCY2Zm8HojS7Ghpd7BFD0y/3AEM4H/VSjoCC7jnTy5WxAZF4Cis+szcEaa3F0BtcWaQ
         OEgtEdaN7O56vF8AlFJTMSQ70vMFGNsQpwIfD0E1IK2s8rLZwRFXNm6iFW5CfwrN72LX
         bxegJs1R/Myor9Wf2/nRrbu5F5Cj3JEI9p3qBIL38QLw56hBPFlHBSy3rKEQTflMdgXn
         6xoFT/4AAos4XOP2Vc0dT+/Xa2uSn43q5vGyGQClCkgeFbcxV2t3ev+fOYpno61xx7eH
         i5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6E5wGlWgwtmRN55cq/vUaSJZuL1NyuRgvoYtJGWwhUY=;
        b=7PIcWq6WoVm+icsuZvHPrpAvDgFPRqqOThHC0gidendsSpryyyuFie/KF3qolNy7M1
         sD2ORkLmWXazd5YpfFI8FAFreFcc/JZjSmSDOkKnyXPcBeILbvisQZf1VhKBKYAKHjok
         9H921q+fcOof2d3WBdvNeeIHBTPxX42O0ohB98zx1WITa5n2Vnee5kgXQW9IH3akzeKo
         lkUNzynOpyyGIZG/EMwvCPYT0xBgKgj6JnQqE8mHqsUbD7RDTFu06XnrLSlBFQDGFHVQ
         Ep9sLqd1tyCL0HHWJ5P2uX2QoqMCSTNSIoQGlum2b1vsDhZ/d/3aIBS8X0B06vBleuFy
         BJtw==
X-Gm-Message-State: ACgBeo0rVQkAl1XSqHA5B6z1E8ze3F0iwE2pTm3p+StpaR81OoBygb/G
        mD+uHg4YM8F8xp+iSCTzVrw=
X-Google-Smtp-Source: AA6agR5hyY6tEw30Evo0Mcd6KS/1UZLdeHQ2xVV06qRPr03qk2v+YkINNRhwe6EVTfVeOpSWQkvuWw==
X-Received: by 2002:a63:448:0:b0:41b:b3a6:c005 with SMTP id 69-20020a630448000000b0041bb3a6c005mr14712235pge.201.1659455488843;
        Tue, 02 Aug 2022 08:51:28 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id c189-20020a624ec6000000b0052b6ed5ca40sm4871314pfb.192.2022.08.02.08.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:51:27 -0700 (PDT)
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
Subject: [PATCH v4 04/15] drm/msm/gem: Check for active in shrinker path
Date:   Tue,  2 Aug 2022 08:51:37 -0700
Message-Id: <20220802155152.1727594-5-robdclark@gmail.com>
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

Currently in our shrinker path we shouldn't be encountering anything
that is active, but this will change in subsequent patches.  So check
if there are unsignaled fences.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c          | 10 ++++++++++
 drivers/gpu/drm/msm/msm_gem.h          |  1 +
 drivers/gpu/drm/msm/msm_gem_shrinker.c |  6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 8ddbd2e001d4..b55d252aef17 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -870,6 +870,16 @@ static void update_inactive(struct msm_gem_object *msm_obj)
 	mutex_unlock(&priv->mm_lock);
 }
 
+bool msm_gem_active(struct drm_gem_object *obj)
+{
+	GEM_WARN_ON(!msm_gem_is_locked(obj));
+
+	if (to_msm_bo(obj)->pin_count)
+		return true;
+
+	return !dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(true));
+}
+
 int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t *timeout)
 {
 	bool write = !!(op & MSM_PREP_WRITE);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 432032ad4aed..0ab0dc4f8c25 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -173,6 +173,7 @@ void msm_gem_put_vaddr(struct drm_gem_object *obj);
 int msm_gem_madvise(struct drm_gem_object *obj, unsigned madv);
 void msm_gem_active_get(struct drm_gem_object *obj, struct msm_gpu *gpu);
 void msm_gem_active_put(struct drm_gem_object *obj);
+bool msm_gem_active(struct drm_gem_object *obj);
 int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t *timeout);
 int msm_gem_cpu_fini(struct drm_gem_object *obj);
 int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 6e39d959b9f0..ea8ed74982c1 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -43,6 +43,9 @@ purge(struct msm_gem_object *msm_obj)
 	if (!is_purgeable(msm_obj))
 		return false;
 
+	if (msm_gem_active(&msm_obj->base))
+		return false;
+
 	/*
 	 * This will move the obj out of still_in_list to
 	 * the purged list
@@ -58,6 +61,9 @@ evict(struct msm_gem_object *msm_obj)
 	if (is_unevictable(msm_obj))
 		return false;
 
+	if (msm_gem_active(&msm_obj->base))
+		return false;
+
 	msm_gem_evict(&msm_obj->base);
 
 	return true;
-- 
2.36.1

