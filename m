Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B0A55AD29
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiFYWzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiFYWzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:55:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11313F42;
        Sat, 25 Jun 2022 15:55:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so572626pji.4;
        Sat, 25 Jun 2022 15:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYZR0Z12iPpbx+Q3gyCHkuavybhxOk7o0RqxHP2v+Kc=;
        b=iMZ+H+mK0wcQoijBBKKG6Hhs4/17MWuyeJbkIJ2XRQhONAfAx3j9X7VUTYHXB+1Gn8
         Ky8Imge2Gf3V0YFDno7uxwrAxEv2MhVtR0itBsKhxeNwo7EijhqhY0byPJtQyLP1oOHc
         iuCquHh3GvEySfOu5As1X3z89IEOxidZx8pybAFj5PKDiWmJhZl1CrijJBcH6iBfKqjK
         jMtQQ7qbY23OtXYm9AK9Z/EzI1SFV94liMeM0MT9+TovUDJbpSaSO9vrrZy3Lhvg95Rr
         lnYazSUsTYgcpuIG91nf/sS7MUtlRcpkYZ5X+44kR2MJlsWxNunMkta6RyjvJsm6+4L4
         Y8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYZR0Z12iPpbx+Q3gyCHkuavybhxOk7o0RqxHP2v+Kc=;
        b=JokncI9ON53Y2Pt+LB5dAiAhrfYHkqs01DGakVC7mxFsdGFF1Sqj5FVQD07IGFMono
         tBrbW0GiOME2PuSx5ihtFtoSUrNDcRUQRIqw/+LbEEkBK6CqoHup8ucmMgelFJtXJzsD
         LqmJQrriTJRsRwzKJCVDNxmRO9jzyhPmNuZypaSLsxwUo/9+a5ldWvpb9ffjtp0Gilo5
         tYTauLNbPKC/mglvUa+snj9U3+sZtppWgDbiiMeF7V6TR72Oo0IiJbbh/15WvB4VkHNB
         3m8Uhr2LzoBHXldHzo12DChRMcVBHddmEoWoN5k6QXDU3qjaw/rdLB56Yzgr9CVSWBA9
         zuDg==
X-Gm-Message-State: AJIora9AkzPo7tXZQMFESwu766nwevdlQJZo+bEaHYtWYcnbfHvy1bdT
        GbekceYrqUe/VZOa7L1pAR4=
X-Google-Smtp-Source: AGRyM1t9EaGdDdFekCCemPuWzi1zT4XQYUtT/1KaJXp/3h1bVgepbXhFy3eAQFs70Uz8roIXDmAwlw==
X-Received: by 2002:a17:902:f78e:b0:168:fffc:fd57 with SMTP id q14-20020a170902f78e00b00168fffcfd57mr6368941pln.149.1656197710878;
        Sat, 25 Jun 2022 15:55:10 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id r12-20020a170902ea4c00b001679a4711e5sm4180619plg.108.2022.06.25.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:55:09 -0700 (PDT)
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
Subject: [PATCH 05/15] drm/msm: Split out idr_lock
Date:   Sat, 25 Jun 2022 15:54:40 -0700
Message-Id: <20220625225454.81039-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625225454.81039-1-robdclark@gmail.com>
References: <20220625225454.81039-1-robdclark@gmail.com>
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

Otherwise if we hit reclaim pinning objects in the submit path, we'll be
blocking retire_worker trying to free a submit.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c         |  4 ++--
 drivers/gpu/drm/msm/msm_gem_submit.c  | 10 ++++++++--
 drivers/gpu/drm/msm/msm_gpu.h         |  4 +++-
 drivers/gpu/drm/msm/msm_submitqueue.c |  1 +
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index acc940d32ab4..ace91ead2caf 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -838,13 +838,13 @@ static int wait_fence(struct msm_gpu_submitqueue *queue, uint32_t fence_id,
 	 * retired, so if the fence is not found it means there is nothing
 	 * to wait for
 	 */
-	ret = mutex_lock_interruptible(&queue->lock);
+	ret = mutex_lock_interruptible(&queue->idr_lock);
 	if (ret)
 		return ret;
 	fence = idr_find(&queue->fence_idr, fence_id);
 	if (fence)
 		fence = dma_fence_get_rcu(fence);
-	mutex_unlock(&queue->lock);
+	mutex_unlock(&queue->idr_lock);
 
 	if (!fence)
 		return 0;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index c7819781879c..16c662808522 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -72,9 +72,9 @@ void __msm_gem_submit_destroy(struct kref *kref)
 	unsigned i;
 
 	if (submit->fence_id) {
-		mutex_lock(&submit->queue->lock);
+		mutex_lock(&submit->queue->idr_lock);
 		idr_remove(&submit->queue->fence_idr, submit->fence_id);
-		mutex_unlock(&submit->queue->lock);
+		mutex_unlock(&submit->queue->idr_lock);
 	}
 
 	dma_fence_put(submit->user_fence);
@@ -881,6 +881,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 
 	submit->nr_cmds = i;
 
+	mutex_lock(&queue->idr_lock);
+
 	/*
 	 * If using userspace provided seqno fence, validate that the id
 	 * is available before arming sched job.  Since access to fence_idr
@@ -889,6 +891,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	 */
 	if ((args->flags & MSM_SUBMIT_FENCE_SN_IN) &&
 			idr_find(&queue->fence_idr, args->fence)) {
+		mutex_unlock(&queue->idr_lock);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -921,6 +924,9 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 						    submit->user_fence, 1,
 						    INT_MAX, GFP_KERNEL);
 	}
+
+	mutex_unlock(&queue->idr_lock);
+
 	if (submit->fence_id < 0) {
 		ret = submit->fence_id;
 		submit->fence_id = 0;
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 4911943ba53b..4ca56d96344a 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -457,7 +457,8 @@ static inline int msm_gpu_convert_priority(struct msm_gpu *gpu, int prio,
  * @node:      node in the context's list of submitqueues
  * @fence_idr: maps fence-id to dma_fence for userspace visible fence
  *             seqno, protected by submitqueue lock
- * @lock:      submitqueue lock
+ * @idr_lock:  for serializing access to fence_idr
+ * @lock:      submitqueue lock for serializing submits on a queue
  * @ref:       reference count
  * @entity:    the submit job-queue
  */
@@ -470,6 +471,7 @@ struct msm_gpu_submitqueue {
 	struct msm_file_private *ctx;
 	struct list_head node;
 	struct idr fence_idr;
+	struct mutex idr_lock;
 	struct mutex lock;
 	struct kref ref;
 	struct drm_sched_entity *entity;
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index f486a3cd4e55..c6929e205b51 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -200,6 +200,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
 		*id = queue->id;
 
 	idr_init(&queue->fence_idr);
+	mutex_init(&queue->idr_lock);
 	mutex_init(&queue->lock);
 
 	list_add_tail(&queue->node, &ctx->submitqueues);
-- 
2.36.1

