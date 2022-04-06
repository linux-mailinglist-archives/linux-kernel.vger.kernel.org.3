Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02D44F6D78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiDFVyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbiDFVwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:52:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20682AD4;
        Wed,  6 Apr 2022 14:46:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y6so3165239plg.2;
        Wed, 06 Apr 2022 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g43LRxOPnuHcbyfQfDVoT6M8d2laa4QFWkHWb/Yu4qg=;
        b=cC++/7iikgLl+TlbToW62IbL+eLLrvQvapq1zNrxD5/+8s/GbJTo3cvVyLJQaVBi4L
         d6/BUYS7CVX33I69jsTcxOSjnUXstEUUrcpRYrgPC8OPYBTLXazETCclzSM1cNVKQSrj
         I4rUvPfMXV0AC+zxAyaPrqCXjq7i7KFu86DCHIs0+Hiww6vOtmix7P0zRMfLAKKb/8v4
         gD+SgXYsfw0XGzBT1BJtCgECQ1Dm57FMXqRMpeOxurvAXSdXQpraJ9iZuznvnRnDvZBH
         qp+/izm2cQfU6XtR4J17qBMpxpjRYuSi+pUZZyznLjvJ/Dn9UlEHmqQ1NV8t+iX8AyG+
         LzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g43LRxOPnuHcbyfQfDVoT6M8d2laa4QFWkHWb/Yu4qg=;
        b=Mhx7aQ2Y+LjofFsyoD/42SIZR1MgZnCMBO1uNzMRxGkDHiYY3hP7R/gqY1t7NbGQRG
         2U6dH8SAijDNSIByxuaVoxps95sqJNFywXkUbnRH5v/uyqnWUrD0JMyfx2jyW0vEDraN
         4ZsNFJIUQ+8zM39FKMGvgUkeRmzHCqLS49zAy0b7ZP7BIOJx7U63hG7w2RYe9NlQ2D2Y
         nLfzFDaJ+Ue4ygzBZSmylOrZtPM35xEP/Y74TYO7S4jfrYCbISqHnAwRRDsnqkj4+M37
         IBVtdTZkyVV3lAz23pqixWkqoXcFC3samzzU3UpRupV1NyGES9fgT3VzhNX5vKe4Ox+m
         oenw==
X-Gm-Message-State: AOAM533dROG1S5m0E4XtwZTj4eSlHkOHOPQVEe9j/uWxFffKxu7RHVjW
        ZQMBzopP2H+7fnSCkWytT+g=
X-Google-Smtp-Source: ABdhPJwS7xjVi2P9Nvb1pvAJY4RpS03oEFr6/hTLDnbpKf4JHfZ+vpuqNvAJneLCYK6QWR2bLkFdJQ==
X-Received: by 2002:a17:90a:3486:b0:1ca:c6a0:3f8f with SMTP id p6-20020a17090a348600b001cac6a03f8fmr12410889pjb.6.1649281591139;
        Wed, 06 Apr 2022 14:46:31 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id f31-20020a17090a702200b001ca996866b5sm6514598pjk.12.2022.04.06.14.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:46:30 -0700 (PDT)
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
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 02/10] drm/msm/gpu: Drop duplicate fence counter
Date:   Wed,  6 Apr 2022 14:46:18 -0700
Message-Id: <20220406214636.1156978-3-robdclark@gmail.com>
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

The ring seqno counter duplicates the fence-context last_fence counter.
They end up getting incremented in lock-step, on the same scheduler
thread, but the split just makes things less obvious.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 4 ++--
 drivers/gpu/drm/msm/msm_gpu.c           | 8 ++++----
 drivers/gpu/drm/msm/msm_gpu.h           | 2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h    | 1 -
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 407f50a15faa..d31aa87c6c8d 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1235,7 +1235,7 @@ static void a5xx_fault_detect_irq(struct msm_gpu *gpu)
 		return;
 
 	DRM_DEV_ERROR(dev->dev, "gpu fault ring %d fence %x status %8.8X rb %4.4x/%4.4x ib1 %16.16llX/%4.4x ib2 %16.16llX/%4.4x\n",
-		ring ? ring->id : -1, ring ? ring->seqno : 0,
+		ring ? ring->id : -1, ring ? ring->fctx->last_fence : 0,
 		gpu_read(gpu, REG_A5XX_RBBM_STATUS),
 		gpu_read(gpu, REG_A5XX_CP_RB_RPTR),
 		gpu_read(gpu, REG_A5XX_CP_RB_WPTR),
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 83c31b2ad865..17de46fc4bf2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1390,7 +1390,7 @@ static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
 
 	DRM_DEV_ERROR(&gpu->pdev->dev,
 		"gpu fault ring %d fence %x status %8.8X rb %4.4x/%4.4x ib1 %16.16llX/%4.4x ib2 %16.16llX/%4.4x\n",
-		ring ? ring->id : -1, ring ? ring->seqno : 0,
+		ring ? ring->id : -1, ring ? ring->fctx->last_fence : 0,
 		gpu_read(gpu, REG_A6XX_RBBM_STATUS),
 		gpu_read(gpu, REG_A6XX_CP_RB_RPTR),
 		gpu_read(gpu, REG_A6XX_CP_RB_WPTR),
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 45f2c6084aa7..6385ab06632f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -578,7 +578,7 @@ int adreno_gpu_state_get(struct msm_gpu *gpu, struct msm_gpu_state *state)
 
 		state->ring[i].fence = gpu->rb[i]->memptrs->fence;
 		state->ring[i].iova = gpu->rb[i]->iova;
-		state->ring[i].seqno = gpu->rb[i]->seqno;
+		state->ring[i].seqno = gpu->rb[i]->fctx->last_fence;
 		state->ring[i].rptr = get_rptr(adreno_gpu, gpu->rb[i]);
 		state->ring[i].wptr = get_wptr(gpu->rb[i]);
 
@@ -828,7 +828,7 @@ void adreno_dump_info(struct msm_gpu *gpu)
 
 		printk("rb %d: fence:    %d/%d\n", i,
 			ring->memptrs->fence,
-			ring->seqno);
+			ring->fctx->last_fence);
 
 		printk("rptr:     %d\n", get_rptr(adreno_gpu, ring));
 		printk("rb wptr:  %d\n", get_wptr(ring));
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 747b89aa9d13..9480bdf875db 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -534,7 +534,7 @@ static void hangcheck_handler(struct timer_list *t)
 	if (fence != ring->hangcheck_fence) {
 		/* some progress has been made.. ya! */
 		ring->hangcheck_fence = fence;
-	} else if (fence_before(fence, ring->seqno)) {
+	} else if (fence_before(fence, ring->fctx->last_fence)) {
 		/* no progress and not done.. hung! */
 		ring->hangcheck_fence = fence;
 		DRM_DEV_ERROR(dev->dev, "%s: hangcheck detected gpu lockup rb %d!\n",
@@ -542,13 +542,13 @@ static void hangcheck_handler(struct timer_list *t)
 		DRM_DEV_ERROR(dev->dev, "%s:     completed fence: %u\n",
 				gpu->name, fence);
 		DRM_DEV_ERROR(dev->dev, "%s:     submitted fence: %u\n",
-				gpu->name, ring->seqno);
+				gpu->name, ring->fctx->last_fence);
 
 		kthread_queue_work(gpu->worker, &gpu->recover_work);
 	}
 
 	/* if still more pending work, reset the hangcheck timer: */
-	if (fence_after(ring->seqno, ring->hangcheck_fence))
+	if (fence_after(ring->fctx->last_fence, ring->hangcheck_fence))
 		hangcheck_timer_reset(gpu);
 
 	/* workaround for missing irq: */
@@ -770,7 +770,7 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	msm_gpu_hw_init(gpu);
 
-	submit->seqno = ++ring->seqno;
+	submit->seqno = submit->hw_fence->seqno;
 
 	msm_rd_dump_submit(priv->rd, submit, NULL);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 2c0203fd6ce3..e47a42b1244a 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -291,7 +291,7 @@ static inline bool msm_gpu_active(struct msm_gpu *gpu)
 	for (i = 0; i < gpu->nr_rings; i++) {
 		struct msm_ringbuffer *ring = gpu->rb[i];
 
-		if (fence_after(ring->seqno, ring->memptrs->fence))
+		if (fence_after(ring->fctx->last_fence, ring->memptrs->fence))
 			return true;
 	}
 
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
index d8c63df4e9ca..2a5045abe46e 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.h
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
@@ -59,7 +59,6 @@ struct msm_ringbuffer {
 	spinlock_t submit_lock;
 
 	uint64_t iova;
-	uint32_t seqno;
 	uint32_t hangcheck_fence;
 	struct msm_rbmemptrs *memptrs;
 	uint64_t memptrs_iova;
-- 
2.35.1

