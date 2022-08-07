Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF758BBC9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiHGQIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 12:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHGQI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 12:08:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C3E31A;
        Sun,  7 Aug 2022 09:08:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d7so6568583pgc.13;
        Sun, 07 Aug 2022 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=5LZXNn7pnpmQJ9fitC0ymrlN4xtjBHI2SmcGn+8C2hU=;
        b=MlaYW+6iOUFKWzQ+Rbg9UNxvCteOXhlxwIiJRJ6hjtXeWXtVnr34mlZJr3TzkZtGyu
         WiYG1+YiWdu21dvUEGqW8+gOsjDojLAW6g+DJB9C6e0mJP1J1+lZUQ8Zwbcvtnqb8S44
         EgZ4S3b5mgGfJtsr6pN803E0HPlosIV34N1fGNVkaFYW2vwdqQ3zAxoZCF8q0Y1iMYNW
         QCqzcjeaAZHk7HnQqQsZ4qiQ19vqIWIcCYtKb9jMd/LIvMzX+eSNXk8MUaTL0HF94WXo
         qbci2YS384PoSkwu0Na4O9xjlY0T0upgzUPdqdp35jDwA7W5jXqw7CPcgz/RXu7aWrtH
         LVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5LZXNn7pnpmQJ9fitC0ymrlN4xtjBHI2SmcGn+8C2hU=;
        b=p/pOxleZllcjT9d8VKrD3WPGItloc0G2J4/kwoAzt4WTyvsou8Uu2XH3kJ6lPdLQHQ
         1wEB1qnHclIGCKf77JJUwutMMrAinrKf3VwWFZ5SOyjM3Cl7i3ZB05qoBkiyzateEShK
         RptiIzPwCgUXeRnyXcK7Oc27/nlQ3E5kQhy8xqtSi5y7cIUNQsHO0JwziV90PwDSna1k
         0X8XnZ1BzaNwU8hBSx5fcq4/55XWHDv1IUYJXcHgNJhWbyQC4he2JgT1lEy6RuR+mQj2
         ElRggzCFhUTrLfxRWGCcCJRuyYrFDBFG/J04VzquElZ1g/3efe4jPhHPQ5vPK1k0Y68v
         1u+g==
X-Gm-Message-State: ACgBeo0tagSXB3yicqYDH/5bBOcQLwkM05YCeKleCdNkaQ0xTH00pBPv
        r90AmlK5eMSxkON2odHVBAfXw1aPMaw=
X-Google-Smtp-Source: AA6agR4ovtqBAWw/GdrxlybKf+QUZMi07LtPvSAXrIFSiyw7Do2MuwxwOAUK1JFh656lYB/iHLMa3g==
X-Received: by 2002:a05:6a00:22c8:b0:52d:586f:19c3 with SMTP id f8-20020a056a0022c800b0052d586f19c3mr14778379pfj.80.1659888508416;
        Sun, 07 Aug 2022 09:08:28 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090a075600b001f21f5c81a5sm8930336pje.19.2022.08.07.09.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 09:08:27 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/msm: Move hangcheck timer restart
Date:   Sun,  7 Aug 2022 09:09:00 -0700
Message-Id: <20220807160901.2353471-1-robdclark@gmail.com>
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

Don't directly restart the hangcheck timer from the timer handler, but
instead start it after the recover_worker replays remaining jobs.

If the kthread is blocked for other reasons, there is no point to
immediately restart the timer.  Fixes a random symptom of the problem
fixed in the next patch.

v2: Keep the hangcheck timer restart in the timer handler in the case
    where we aren't scheduling recover_worker

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index fba85f894314..6762001d9945 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -328,6 +328,7 @@ find_submit(struct msm_ringbuffer *ring, uint32_t fence)
 }
 
 static void retire_submits(struct msm_gpu *gpu);
+static void hangcheck_timer_reset(struct msm_gpu *gpu);
 
 static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
 {
@@ -420,6 +421,8 @@ static void recover_worker(struct kthread_work *work)
 	}
 
 	if (msm_gpu_active(gpu)) {
+		bool restart_hangcheck = false;
+
 		/* retire completed submits, plus the one that hung: */
 		retire_submits(gpu);
 
@@ -436,10 +439,15 @@ static void recover_worker(struct kthread_work *work)
 			unsigned long flags;
 
 			spin_lock_irqsave(&ring->submit_lock, flags);
-			list_for_each_entry(submit, &ring->submits, node)
+			list_for_each_entry(submit, &ring->submits, node) {
 				gpu->funcs->submit(gpu, submit);
+				restart_hangcheck = true;
+			}
 			spin_unlock_irqrestore(&ring->submit_lock, flags);
 		}
+
+		if (restart_hangcheck)
+			hangcheck_timer_reset(gpu);
 	}
 
 	mutex_unlock(&gpu->lock);
@@ -498,6 +506,7 @@ static void hangcheck_handler(struct timer_list *t)
 	struct drm_device *dev = gpu->dev;
 	struct msm_ringbuffer *ring = gpu->funcs->active_ring(gpu);
 	uint32_t fence = ring->memptrs->fence;
+	bool restart_hangcheck = true;
 
 	if (fence != ring->hangcheck_fence) {
 		/* some progress has been made.. ya! */
@@ -513,10 +522,16 @@ static void hangcheck_handler(struct timer_list *t)
 				gpu->name, ring->fctx->last_fence);
 
 		kthread_queue_work(gpu->worker, &gpu->recover_work);
+
+		/* If we do recovery, we want to defer restarting the hangcheck
+		 * timer until recovery completes and the remaining non-guilty
+		 * jobs are re-played.
+		 */
+		restart_hangcheck = false;
 	}
 
 	/* if still more pending work, reset the hangcheck timer: */
-	if (fence_after(ring->fctx->last_fence, ring->hangcheck_fence))
+	if (restart_hangcheck && fence_after(ring->fctx->last_fence, ring->hangcheck_fence))
 		hangcheck_timer_reset(gpu);
 
 	/* workaround for missing irq: */
-- 
2.36.1

