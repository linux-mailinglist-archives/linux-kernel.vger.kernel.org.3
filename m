Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99DB5818F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiGZRui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbiGZRuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:50:25 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C042B61F;
        Tue, 26 Jul 2022 10:50:24 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 6so13726811pgb.13;
        Tue, 26 Jul 2022 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwYCVdrGkHnM2D+4h4BxfmYuAccPj8wFXhKV37+GyLo=;
        b=d07ps/PxhGLVTQay3ZOMj+wOILdTIPfoaYbqxIjtMx0KUtWZQl1malmooufQqO0e49
         ERbm62n+OGlKUrXWuE5FbiXGq198R9jlAdrxLPEdh7uX6M+SKPjr1hkIl6ptbM8kVio+
         U7NfKTU6WjUonHvM5by8NfWmb7jx+y+Cbe/LDju3PmtbSXv31k7VWji+KQB3JEAlBCIc
         44+pUVLvjT7NDW5ctkprIaBP28MpTimydDrs1SMV99kZsKtjqfRYLDztREVN9ZKBY9+r
         m6dYEnGJnEiwDDrreE2BBHvfamp+lDuL6JYnbqm2ovuE+ddhxTzFzdHgI4ukEMkL/7HP
         zdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwYCVdrGkHnM2D+4h4BxfmYuAccPj8wFXhKV37+GyLo=;
        b=mVGQeyACXSW+CcVuU2zEvCLoua2+FUlhWuymhhrAZg0sQQXoW+8w24p02jaB6ae2Sm
         rGLJl3YORSuiLNAux2N+LvxJ6cRd2UaQoN6jNBKS4QrsgTDRd6FZPBqsHcsL9YdojvVV
         RK2gEX2b58Qna/wditNlgLjUVjQ23ajGET4Qpoz+iQHAGtBkLdBOnhT+/DuZuUHiHTz9
         kLjdZ6EWYbf4V919jdD1CwxfscNtot0QJy93Kick8YuA7UESjQodcMOskozv8D1bGsmS
         BwPaDSr3yIhsBmGL7NIzMGxcjFZydx2Nn+hUY0QCvRvokxYOJu95WTzyTJttKRYZMVSc
         eDyQ==
X-Gm-Message-State: AJIora/PYxb7yaIENtUwhfcdLgt++iKWGX7kxO9w0asLAt5ePOQRGMj9
        Zj/v6rz2eCkbhmB0yHQEtnOA3XBNb6Q=
X-Google-Smtp-Source: AGRyM1vKma7jG+VAhlmr2RGqxxeVlHvtkFjPUXWcN4AIdM90MN87noNjNu1A+3O5qideJRIuVAuTsQ==
X-Received: by 2002:a63:6b0a:0:b0:40d:ffa6:85c5 with SMTP id g10-20020a636b0a000000b0040dffa685c5mr15585780pgc.327.1658857823442;
        Tue, 26 Jul 2022 10:50:23 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902f60300b0016bdea07b9esm11775714plg.190.2022.07.26.10.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:50:22 -0700 (PDT)
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
Subject: [PATCH v3 03/15] drm/msm: Split out idr_lock
Date:   Tue, 26 Jul 2022 10:50:27 -0700
Message-Id: <20220726175043.1027731-4-robdclark@gmail.com>
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
index 1ed4cd09dbf8..d7ca025457b6 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -883,13 +883,13 @@ static int wait_fence(struct msm_gpu_submitqueue *queue, uint32_t fence_id,
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
index 4d935fedd2ac..962d2070bcdf 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -466,7 +466,8 @@ static inline int msm_gpu_convert_priority(struct msm_gpu *gpu, int prio,
  * @node:      node in the context's list of submitqueues
  * @fence_idr: maps fence-id to dma_fence for userspace visible fence
  *             seqno, protected by submitqueue lock
- * @lock:      submitqueue lock
+ * @idr_lock:  for serializing access to fence_idr
+ * @lock:      submitqueue lock for serializing submits on a queue
  * @ref:       reference count
  * @entity:    the submit job-queue
  */
@@ -479,6 +480,7 @@ struct msm_gpu_submitqueue {
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

