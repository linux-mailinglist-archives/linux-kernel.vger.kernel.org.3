Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F694FC782
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350385AbiDKWS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350490AbiDKWSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:18:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AC026553
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:16:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 5B7181F43242
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649715379;
        bh=5ktnqTbMMHX7JjM1x4kfTyCzWU6VswdmB+oOmMaUXzQ=;
        h=From:To:Cc:Subject:Date:From;
        b=SCUxpvTtvSXqWaPUjB3p6PQUx4FhVyGZ2c0qihVCWw4EXMUU5j3o95Y/RI6FRxFVO
         DRjJgN/kCr0Usnvzt93xXLas9CWlovnKwvQp3JpoLcuEcym9B8hdhjyfy43sPMIQr7
         iGpJ/+gqx5X8CoFxuPrO0V+rHA00TUWgF7pYNjPv86KUR87oAAJ7A8BO5a0PTtRo8M
         4ECAJ66QYoyj40TCXeH+E2vl1XoktxGH138Wb2KyjuYN/LIXy3Sts1Ze/FJD73peMr
         yTV97BwBjuFGGizXBz5ovkCxFnHvoSrfufsH2Vq2jnKWqPr3oXqrNRJo8UVj8J0BW9
         9EEBpICe2zp0Q==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1] drm/scheduler: Don't kill jobs in interrupt context
Date:   Tue, 12 Apr 2022 01:15:36 +0300
Message-Id: <20220411221536.283312-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt context can't sleep. Drivers like Panfrost and MSM are taking
mutex when job is released, and thus, that code can sleep. This results
into "BUG: scheduling while atomic" if locks are contented while job is
freed. There is no good reason for releasing scheduler's jobs in IRQ
context, hence use normal context to fix the trouble.

Cc: stable@vger.kernel.org
Fixes: 542cff7893a3 ("drm/sched: Avoid lockdep spalt on killing a processes")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 6 +++---
 include/drm/gpu_scheduler.h              | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 191c56064f19..6b25b2f4f5a3 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -190,7 +190,7 @@ long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
 }
 EXPORT_SYMBOL(drm_sched_entity_flush);
 
-static void drm_sched_entity_kill_jobs_irq_work(struct irq_work *wrk)
+static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)
 {
 	struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
 
@@ -207,8 +207,8 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
 	struct drm_sched_job *job = container_of(cb, struct drm_sched_job,
 						 finish_cb);
 
-	init_irq_work(&job->work, drm_sched_entity_kill_jobs_irq_work);
-	irq_work_queue(&job->work);
+	INIT_WORK(&job->work, drm_sched_entity_kill_jobs_work);
+	schedule_work(&job->work);
 }
 
 static struct dma_fence *
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 0fca8f38bee4..addb135eeea6 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -28,7 +28,7 @@
 #include <linux/dma-fence.h>
 #include <linux/completion.h>
 #include <linux/xarray.h>
-#include <linux/irq_work.h>
+#include <linux/workqueue.h>
 
 #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
 
@@ -295,7 +295,7 @@ struct drm_sched_job {
 	 */
 	union {
 		struct dma_fence_cb		finish_cb;
-		struct irq_work 		work;
+		struct work_struct 		work;
 	};
 
 	uint64_t			id;
-- 
2.35.1

