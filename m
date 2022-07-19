Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DBA57A4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiGSRS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbiGSRSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:18:51 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70D47BA4;
        Tue, 19 Jul 2022 10:18:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f11so12556802plr.4;
        Tue, 19 Jul 2022 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6E5wGlWgwtmRN55cq/vUaSJZuL1NyuRgvoYtJGWwhUY=;
        b=BuJsnc398rfPIFc8fRsJaLTnog5hsqN/+XgNHPJk9ZBqXssTwHL7CTuyZuzl92Krnj
         mN7ZPWDTK2qjPE4w/VlRi6wAPL9CLJ8cq+f60wcmRKLSdFGRjva0LwVRgqWXHljBAkZ1
         ObtaN+pdx/IsNJMNBFQDlLBWdFE3l5noKaOWNrm12N91zorP5FARH3nEvSj8MvL/R3f0
         paspiTNMF2vYlIzznZ/RSZ+2ia4ai7FiqRxMTLi2AeI3dP/B37DWmvJAQ1KUjGtsrS6h
         /tzeir28FbRXoA5PPto/pNtzOnRIGfwLgnOx1G5zIZYsyMecglSQc0ugQVdX6JPYu7wV
         pXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6E5wGlWgwtmRN55cq/vUaSJZuL1NyuRgvoYtJGWwhUY=;
        b=MrvyvTnLU2O7Yx74lpkudAtNCYC+Wv2h/wnr1DYum44cf6xp62MCwL0IYaPQoL9/Gn
         lDu/qTgrQbTuARqo0jB7wB/vn1MdIP3k9Cu+e+z4IWmCywxlPcwbs+pqMq2UeyJhtXFr
         NV3M2Ubifx1puKNw4jcjUh+fjtCA6xOKW6cNDsIviAx9QRm6vZhg9gOtUYS1EJ+Vs+xx
         ++gfqiXj6liGKs3+4r2kYCsFwNVJ7s8gCvMT3lwDzXWF73mv5nQ79xaJWd50/eJG7C3T
         lRp2HoFvg3aGLC7Yz/UYCtw2I9UHKsp6YT2EnevacrurdO4RmqAqarLiYdJxg/FU1Pib
         LUkQ==
X-Gm-Message-State: AJIora80LyM7uPHQWK3R2NLCWUDflsLh9c9TO9fM2+/IQxSNT8374X8Z
        hVJ4ScMx+D4S5APkaBsaZMM=
X-Google-Smtp-Source: AGRyM1vQvvozAIxX6sWiAmFPrxMnWkv2PukPVsxPIawN7d+3XSkrBXeJkyuxtUxYCRCiD4niUkiXEA==
X-Received: by 2002:a17:90b:33ce:b0:1ef:e5f4:f8e2 with SMTP id lk14-20020a17090b33ce00b001efe5f4f8e2mr451516pjb.70.1658251129300;
        Tue, 19 Jul 2022 10:18:49 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id nt14-20020a17090b248e00b001ef82e5f5aesm11802310pjb.47.2022.07.19.10.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:18:48 -0700 (PDT)
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
Subject: [PATCH v2 04/13] drm/msm/gem: Check for active in shrinker path
Date:   Tue, 19 Jul 2022 10:18:48 -0700
Message-Id: <20220719171900.289265-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220719171900.289265-1-robdclark@gmail.com>
References: <20220719171900.289265-1-robdclark@gmail.com>
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

