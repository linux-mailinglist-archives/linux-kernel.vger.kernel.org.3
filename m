Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F37A549FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiFMUoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245459AbiFMUnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:43:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6AFE030;
        Mon, 13 Jun 2022 12:46:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e24so6591483pjt.0;
        Mon, 13 Jun 2022 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PJJNUcJj53ev3AqJRn3xVtb+ZpTb0J1fJRS/I1pZqo=;
        b=j/Xl5g9NFS0JUQC69FXYr+svQcCT14l0bivAxI2nyR+X8FM6UQZKcoEoVsihPU7lWO
         i19+z9tQemZeYruJR5ghpoevoYa3r7x8g0nl3neKATakG/axZF+CQjn/qn2PI4lSotee
         KYczE/L1R/e483aBjj2+BU4xanG3sJNL7fWdDHp5OFltj46W7ATvG74EoiTBroqErfDi
         W1C0Z95EMYGO94zakXZqcFOTKs/AMONEiRpxMGTKDr2S1YSPOWjBlMgE24ZNe/8TOjZI
         H5P5vzZJqzaiaRsSaUyFu0QeMK7GW/Gbv1uEjmS858q+Y/E1Nz88iDCZ3IzUta4UvgAX
         FBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PJJNUcJj53ev3AqJRn3xVtb+ZpTb0J1fJRS/I1pZqo=;
        b=WxRgJeEpGw8KClvTq3QKAj1oWPUDXG/OOZEwtj74WHdYVfqZT9/CygCrkZUrK8Z2of
         dt3hSz29ICC39f4AQiU3du539Tfhc9siIsLmuwabwBh+J37feanKEUnjHR4tpb9sYsaJ
         vas9ypuLi0JD5fnySOj8kXicVkOQq7zNL/jwiVcUxxuDtCU+077OUC1Ubg95QVNccn09
         +8NOIV0yVx6+B2IXpNn7uLKHBBR5su7NetDxLyawqjBq365EFNmFFBqVFzxLaLx+7zW+
         zj6luBAJaPYGlMgCKnAVKx0u6J8Y3BPWRDP0DqOJuMSwFsciWgfmFD7u60lGCfLuXOCZ
         dVUg==
X-Gm-Message-State: AOAM531lWui5Oc5Fb1q6tzI2RHBd+FtO+nEpPv8TKHTV7QB79HLzCOWZ
        YtVsAVEGld9Hy8p/33AIAw8=
X-Google-Smtp-Source: AGRyM1thfR5WcCUpEKNj9m6vRAIv50Kk1vGSAieTTtgXiETCAqb603bEsvDIQhWxcu3vrC8MEVnyoA==
X-Received: by 2002:a17:903:2c2:b0:168:e323:d471 with SMTP id s2-20020a17090302c200b00168e323d471mr667931plk.147.1655149573799;
        Mon, 13 Jun 2022 12:46:13 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id jj18-20020a170903049200b0015ee24acf38sm5474487plb.212.2022.06.13.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:46:12 -0700 (PDT)
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
Subject: [PATCH] drm/msm: Deprecate MSM_BO_UNCACHED harder
Date:   Mon, 13 Jun 2022 12:46:23 -0700
Message-Id: <20220613194623.2588353-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Handle the demotion to MSM_BO_WC at the userspace ABI level, and fix
the remaining internal MSM_BO_UNCACHED user.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 13 +++++++++++++
 drivers/gpu/drm/msm/msm_gem.c |  7 +++----
 drivers/gpu/drm/msm/msm_gpu.c |  2 +-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 57a66093e671..acc940d32ab4 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -633,12 +633,25 @@ static int msm_ioctl_gem_new(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
 	struct drm_msm_gem_new *args = data;
+	uint32_t flags = args->flags;
 
 	if (args->flags & ~MSM_BO_FLAGS) {
 		DRM_ERROR("invalid flags: %08x\n", args->flags);
 		return -EINVAL;
 	}
 
+	/*
+	 * Uncached CPU mappings are deprecated, as of:
+	 *
+	 * 9ef364432db4 ("drm/msm: deprecate MSM_BO_UNCACHED (map as writecombine instead)")
+	 *
+	 * So promote them to WC.
+	 */
+	if (flags & MSM_BO_UNCACHED) {
+		flags &= ~MSM_BO_CACHED;
+		flags |= MSM_BO_WC;
+	}
+
 	return msm_gem_new_handle(dev, file, args->size,
 			args->flags, &args->handle, NULL);
 }
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 9a73e48a3049..35845e273d81 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -129,7 +129,7 @@ static struct page **get_pages(struct drm_gem_object *obj)
 		/* For non-cached buffers, ensure the new pages are clean
 		 * because display controller, GPU, etc. are not coherent:
 		 */
-		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
+		if (msm_obj->flags & MSM_BO_WC)
 			sync_for_device(msm_obj);
 
 		update_inactive(msm_obj);
@@ -160,7 +160,7 @@ static void put_pages(struct drm_gem_object *obj)
 			 * pages are clean because display controller,
 			 * GPU, etc. are not coherent:
 			 */
-			if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
+			if (msm_obj->flags & MSM_BO_WC)
 				sync_for_cpu(msm_obj);
 
 			sg_free_table(msm_obj->sgt);
@@ -213,7 +213,7 @@ void msm_gem_put_pages(struct drm_gem_object *obj)
 
 static pgprot_t msm_gem_pgprot(struct msm_gem_object *msm_obj, pgprot_t prot)
 {
-	if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
+	if (msm_obj->flags & MSM_BO_WC)
 		return pgprot_writecombine(prot);
 	return prot;
 }
@@ -1122,7 +1122,6 @@ static int msm_gem_new_impl(struct drm_device *dev,
 	struct msm_gem_object *msm_obj;
 
 	switch (flags & MSM_BO_CACHE_MASK) {
-	case MSM_BO_UNCACHED:
 	case MSM_BO_CACHED:
 	case MSM_BO_WC:
 		break;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index f99292eaf529..e59a757578df 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -952,7 +952,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	memptrs = msm_gem_kernel_new(drm,
 		sizeof(struct msm_rbmemptrs) * nr_rings,
-		check_apriv(gpu, MSM_BO_UNCACHED), gpu->aspace, &gpu->memptrs_bo,
+		check_apriv(gpu, MSM_BO_WC), gpu->aspace, &gpu->memptrs_bo,
 		&memptrs_iova);
 
 	if (IS_ERR(memptrs)) {
-- 
2.36.1

