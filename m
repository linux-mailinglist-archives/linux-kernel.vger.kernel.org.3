Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069DB550608
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 18:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbiFRQLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 12:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 12:11:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D354514D2C;
        Sat, 18 Jun 2022 09:11:11 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so5469407pjm.4;
        Sat, 18 Jun 2022 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFb7npL4PD4+dNt9TMTKGSDFvw0QWZrqS2iKTnt24Qw=;
        b=hLhs6nAB8Hj6nYs4Z6utsnyy8MWbills7fP/TW/3nHVEFwGxZE3uILPVG//7PAsoOP
         FDKau/L/oPiGMdtJtfANdKCEO6NoYggtAVDcwXYJEXIgzN9pduWhELjUYPN+MqIs1Yf0
         ubIEOvHM12hoGS1qxraVPSqWzUiuz7MJ88epzc1IsaCwrc3e54pbCV/WNWWqgAj7qUW6
         MkOnlfaVMcLyEr9BZYblqPp9hRM//8OJMGKv/Uhd+V1Cpap3Nw9HXf/F1Fcu1IWLT3SG
         JL3EAeNqZgoMU2/qn5M2muSUxr4nfBxROPYv731sZnMSRCSjgh5Nt++VCfRSqx9LnEip
         JkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFb7npL4PD4+dNt9TMTKGSDFvw0QWZrqS2iKTnt24Qw=;
        b=ezs/+AcJlUChE+dSaekPHheQxzKK0WdDiKfBDzotqMdZN0ZZDzAjhkZAMQqTYQnIK6
         drhf8y2Odja9axJhxZCnxBfqUZDQkvW6y+TAHPOyyR8RqrSKEgfOWMZ7jkmGqiMlPaO7
         7hw9P8rBx3SVvBBvqjOJGMXQypcOwPNkn4WQuUJJFRrqoTj64XG0Ms2ebVabAufAXIK8
         D9h+wx/19i25diyXD+QDB6anqUyWTZd3UXpWqv3EPYrI9HvPpYtGYm0OfV8f80F8rrA5
         wZ/J4q+BwFaU2p72/iDaZAMWSMJv2VCPmRUzL7IDmxL/HgVUb4NOYDlFZC4Ig4lvCd9s
         riOQ==
X-Gm-Message-State: AJIora8yYM2rFrZof1YcC7HS7h1ibNtbCUlomepXVlEI06uzinXnZ+O1
        cIYgA4rdu8dlVTaho1KS9pI=
X-Google-Smtp-Source: AGRyM1tQp1nTafx9dq2YTmnYdD/C7xbKbhSjuD5YDOyAYVynK+I6eyhgcjMjerVikMi2TnQ78p5YAA==
X-Received: by 2002:a17:902:e54b:b0:166:50b6:a0a0 with SMTP id n11-20020a170902e54b00b0016650b6a0a0mr15169227plf.30.1655568671225;
        Sat, 18 Jun 2022 09:11:11 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0015e8d4eb29csm5490525pln.230.2022.06.18.09.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 09:11:09 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/msm: Drop update_fences()
Date:   Sat, 18 Jun 2022 09:11:18 -0700
Message-Id: <20220618161120.3451993-1-robdclark@gmail.com>
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

I noticed while looking at some traces, that we could miss calls to
msm_update_fence(), as the irq could have raced with retire_submits()
which could have already popped the last submit on a ring out of the
queue of in-flight submits.  But walking the list of submits in the
irq handler isn't really needed, as dma_fence_is_signaled() will dtrt.
So lets just drop it entirely.

v2: use spin_lock_irqsave/restore as we are no longer protected by the
    spin_lock_irqsave/restore() in update_fences()

Reported-by: Steev Klimaszewski <steev@kali.org>
Fixes: 95d1deb02a9c ("drm/msm/gem: Add fenced vma unpin")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
---
 drivers/gpu/drm/msm/msm_fence.c |  8 +++++---
 drivers/gpu/drm/msm/msm_gpu.c   | 22 ++--------------------
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
index 3df255402a33..38e3323bc232 100644
--- a/drivers/gpu/drm/msm/msm_fence.c
+++ b/drivers/gpu/drm/msm/msm_fence.c
@@ -46,12 +46,14 @@ bool msm_fence_completed(struct msm_fence_context *fctx, uint32_t fence)
 		(int32_t)(*fctx->fenceptr - fence) >= 0;
 }
 
-/* called from workqueue */
+/* called from irq handler and workqueue (in recover path) */
 void msm_update_fence(struct msm_fence_context *fctx, uint32_t fence)
 {
-	spin_lock(&fctx->spinlock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fctx->spinlock, flags);
 	fctx->completed_fence = max(fence, fctx->completed_fence);
-	spin_unlock(&fctx->spinlock);
+	spin_unlock_irqrestore(&fctx->spinlock, flags);
 }
 
 struct msm_fence {
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 244511f85044..cedc88cf8083 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -164,24 +164,6 @@ int msm_gpu_hw_init(struct msm_gpu *gpu)
 	return ret;
 }
 
-static void update_fences(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
-		uint32_t fence)
-{
-	struct msm_gem_submit *submit;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ring->submit_lock, flags);
-	list_for_each_entry(submit, &ring->submits, node) {
-		if (fence_after(submit->seqno, fence))
-			break;
-
-		msm_update_fence(submit->ring->fctx,
-			submit->hw_fence->seqno);
-		dma_fence_signal(submit->hw_fence);
-	}
-	spin_unlock_irqrestore(&ring->submit_lock, flags);
-}
-
 #ifdef CONFIG_DEV_COREDUMP
 static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
 		size_t count, void *data, size_t datalen)
@@ -438,7 +420,7 @@ static void recover_worker(struct kthread_work *work)
 		if (ring == cur_ring)
 			fence++;
 
-		update_fences(gpu, ring, fence);
+		msm_update_fence(ring->fctx, fence);
 	}
 
 	if (msm_gpu_active(gpu)) {
@@ -736,7 +718,7 @@ void msm_gpu_retire(struct msm_gpu *gpu)
 	int i;
 
 	for (i = 0; i < gpu->nr_rings; i++)
-		update_fences(gpu, gpu->rb[i], gpu->rb[i]->memptrs->fence);
+		msm_update_fence(gpu->rb[i]->fctx, gpu->rb[i]->memptrs->fence);
 
 	kthread_queue_work(gpu->worker, &gpu->retire_work);
 	update_sw_cntrs(gpu);
-- 
2.36.1

