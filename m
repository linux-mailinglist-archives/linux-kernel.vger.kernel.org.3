Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9424ECE54
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351138AbiC3Uts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351109AbiC3Utn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:49:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CABE46B21;
        Wed, 30 Mar 2022 13:47:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bc27so18422267pgb.4;
        Wed, 30 Mar 2022 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g43LRxOPnuHcbyfQfDVoT6M8d2laa4QFWkHWb/Yu4qg=;
        b=EDj7+eTg1TCkYEULfp1MIR/SDGZ0rXOcFYFdpXrZl3dyOhLMllkDqxH5w6NCq/+ozh
         IvzMMurJ5Zb9xcmgqlBDONonrMbulUdRXYM+rR73Wl38EmF1IEDCmP8xV3dm6KYaWa0c
         tMBtuKWFQ8mqGqf4mgc+JhcHqkXY/Y9FBXy4yClMgazSZhiDdSOUZtEz7Tnw3P3MBP6x
         b9HDiuX//DJ06r1Brfeu/Fd8jR9TZotTOeZw/1LgpR/JZ2WQcy2vg7OMDV4CF2zgQIx1
         c1OsjNboj/1eD1aZz24tua2kVInPgU8fJkEHG8f0nvksMnaeyqDTkvFactksmCMW1IjZ
         afvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g43LRxOPnuHcbyfQfDVoT6M8d2laa4QFWkHWb/Yu4qg=;
        b=fycqwc10GUXYLEWIKEX1k3gAK1+NH/dnPqlcjAnmvCYgyI54nc6dZbzSfH50+xICyz
         8xg3Bpac0PNEeFGqB5Fqo01DAAHtxsbZpj6sAzVsMh1OXVYxAx6St2iyqexqsqhw580R
         BAGBFCO1wrL5j/hY4KGXhUIEb61QwKT2kBTyQkUlUnBCRn1SV5Hn3xW3elROsbAWz790
         4DR/NmI9jAJQ/XrTe00Iu/jfNgbXyEcwz6XTdj4n5dqqhdgugLNpWjBDvGyKCiAdcCk2
         +9sRvF/MieHMt1cS+pMPvzNeOPZQvN7AiEDn6veLUZp9+si36WNaiqjbdgtJ0rZf6Ww1
         DwEA==
X-Gm-Message-State: AOAM532DzqMED6yxBgVnvxHRZnMmKqo8A6eJ37gl48qzDaToBMR+QflP
        +bTvpcM0y9TMG5t1zfMOywE=
X-Google-Smtp-Source: ABdhPJzs6n1xh1i7+qLLrdd2K/konTPn+T9Q2ItRvfEIcXWKRpDoCWXZXzbTAnI6HcHmCkpTnnfRiw==
X-Received: by 2002:a05:6a00:e8e:b0:4fa:a52f:59cf with SMTP id bo14-20020a056a000e8e00b004faa52f59cfmr1475528pfb.84.1648673277619;
        Wed, 30 Mar 2022 13:47:57 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id o22-20020a056a0015d600b004fb03c903c3sm21474179pfu.71.2022.03.30.13.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:47:56 -0700 (PDT)
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
        Yangtao Li <tiny.windzz@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Emma Anholt <emma@anholt.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/10] drm/msm/gpu: Drop duplicate fence counter
Date:   Wed, 30 Mar 2022 13:47:47 -0700
Message-Id: <20220330204804.660819-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330204804.660819-1-robdclark@gmail.com>
References: <20220330204804.660819-1-robdclark@gmail.com>
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

