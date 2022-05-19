Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC052D74E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbiESPUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiESPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:20:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D64F4C1EC8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:20:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A48614BF;
        Thu, 19 May 2022 08:20:13 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.25.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 831E33F66F;
        Thu, 19 May 2022 08:20:11 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panfrost: Job should reference MMU not file_priv
Date:   Thu, 19 May 2022 16:20:03 +0100
Message-Id: <20220519152003.81081-1-steven.price@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a while now it's been allowed for a MMU context to outlive it's
corresponding panfrost_priv, however the job structure still references
panfrost_priv to get hold of the MMU context. If panfrost_priv has been
freed this is a use-after-free which I've been able to trigger resulting
in a splat.

To fix this, drop the reference to panfrost_priv in the job structure
and add a direct reference to the MMU structure which is what's actually
needed.

Fixes: 7fdc48cc63a3 ("drm/panfrost: Make sure MMU context lifetime is not bound to panfrost_priv")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 5 +++--
 drivers/gpu/drm/panfrost/panfrost_job.c | 6 +++---
 drivers/gpu/drm/panfrost/panfrost_job.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 7fcbc2a5b6cd..087e69b98d06 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -233,6 +233,7 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
 	struct panfrost_device *pfdev = dev->dev_private;
+	struct panfrost_file_priv *file_priv = file->driver_priv;
 	struct drm_panfrost_submit *args = data;
 	struct drm_syncobj *sync_out = NULL;
 	struct panfrost_job *job;
@@ -262,12 +263,12 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 	job->jc = args->jc;
 	job->requirements = args->requirements;
 	job->flush_id = panfrost_gpu_get_latest_flush_id(pfdev);
-	job->file_priv = file->driver_priv;
+	job->mmu = file_priv->mmu;
 
 	slot = panfrost_job_get_slot(job);
 
 	ret = drm_sched_job_init(&job->base,
-				 &job->file_priv->sched_entity[slot],
+				 &file_priv->sched_entity[slot],
 				 NULL);
 	if (ret)
 		goto out_put_job;
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index fda5871aebe3..7c4208476fbd 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -201,7 +201,7 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 		return;
 	}
 
-	cfg = panfrost_mmu_as_get(pfdev, job->file_priv->mmu);
+	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
 
 	job_write(pfdev, JS_HEAD_NEXT_LO(js), lower_32_bits(jc_head));
 	job_write(pfdev, JS_HEAD_NEXT_HI(js), upper_32_bits(jc_head));
@@ -435,7 +435,7 @@ static void panfrost_job_handle_err(struct panfrost_device *pfdev,
 		job->jc = 0;
 	}
 
-	panfrost_mmu_as_put(pfdev, job->file_priv->mmu);
+	panfrost_mmu_as_put(pfdev, job->mmu);
 	panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
 
 	if (signal_fence)
@@ -456,7 +456,7 @@ static void panfrost_job_handle_done(struct panfrost_device *pfdev,
 	 * happen when we receive the DONE interrupt while doing a GPU reset).
 	 */
 	job->jc = 0;
-	panfrost_mmu_as_put(pfdev, job->file_priv->mmu);
+	panfrost_mmu_as_put(pfdev, job->mmu);
 	panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
 
 	dma_fence_signal_locked(job->done_fence);
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index 77e6d0e6f612..8becc1ba0eb9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -17,7 +17,7 @@ struct panfrost_job {
 	struct kref refcount;
 
 	struct panfrost_device *pfdev;
-	struct panfrost_file_priv *file_priv;
+	struct panfrost_mmu *mmu;
 
 	/* Fence to be signaled by IRQ handler when the job is complete. */
 	struct dma_fence *done_fence;
-- 
2.30.2

