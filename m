Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C644C4FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiBYU0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiBYU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:26:16 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5A3214F9C;
        Fri, 25 Feb 2022 12:25:44 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso9422350pjk.1;
        Fri, 25 Feb 2022 12:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lUd+xZAKJJHoe9D7RQA/pZ2AmCeV2h3Ce3KRsQg4sk=;
        b=fijKrYtfpmrdrja8jb2xqsFUhkGrM+Xd9yOxFTvq2cUK1yOb1JDPb/7mZxZCTGTlVp
         or/3KFg98OY1z6OieyVWXnyvsUiyDf1ReKfldsj1vWcsjnB/6r8bq6nYs358lDUPUPfg
         FsL4XuLRd+i7f1vKlb25zwif6VDf8JVvNurFChw0kM7D279qmnBYnFCWdN5xth6kLov9
         B4QzvRImz76XdXzlAGfAuKHO4yg/q0c0GnA2W/xhkgGGKF220BLyBvVcRu8WTAxtdN+P
         fMCYjvRN3fYZz3HaeggtFZYj6s6QiKLiDfm5VZIdfcUFTfSf/Iyg2m5da/5v1snk94aV
         aPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lUd+xZAKJJHoe9D7RQA/pZ2AmCeV2h3Ce3KRsQg4sk=;
        b=n26wkJ2Hk47kgg4FBVekcpPKO66vEVRKVlW7SpfDRbXLmG25lpAo+P4r0vmdf0+UAQ
         5u91Pz9O7rGQY7yOd+Hsd2iJn4Ks14N+gSTxK5THHG49hHuDtMoNxsHfm0mIXTehmBKW
         m7oUhVcvBEDk45zjrO4Xz7AN/mn+bmQzYvhvtibzjafvrHOqSbHXCR1KMtsE6fq0Oq6E
         3rNE3MuejHy4SCjePtBi1AkegEooUXp520LfNedwKyci4EN8M2F29qQ5H3supwnyqvwT
         6vN5qx4Onp3hoistmj6Dxq1tOMvF8PzG7oWhjiUWzSS/AMF+JStbWYmg0N3TWc08chU7
         ktWw==
X-Gm-Message-State: AOAM532Wt9HTCC+GGzEgrC4FJ/C6UrlCbw5/D8H5bdwXVkC+o6PcXEnD
        tx78xd1GtEGpxhaXEF1GN2A=
X-Google-Smtp-Source: ABdhPJzFA0qrEcvplkRqdFSMgM4vfiiT1hbhUfa3olOIIPYiwsYAIRxUM0ic1jUapdIfftO0hJSnTw==
X-Received: by 2002:a17:90b:216:b0:1bc:5d68:e7aa with SMTP id fy22-20020a17090b021600b001bc5d68e7aamr4866160pjb.57.1645820743524;
        Fri, 25 Feb 2022 12:25:43 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id b3-20020a056a00114300b004e099ec2871sm4209159pfm.154.2022.02.25.12.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:25:42 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/msm: Expose client engine utilization via fdinfo
Date:   Fri, 25 Feb 2022 12:26:14 -0800
Message-Id: <20220225202614.225197-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225202614.225197-1-robdclark@gmail.com>
References: <20220225202614.225197-1-robdclark@gmail.com>
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

Similar to AMD commit
874442541133 ("drm/amdgpu: Add show_fdinfo() interface"), using the
infrastructure added in previous patches, we add basic client info
and GPU engine utilisation for msm.

Example output:

	# cat /proc/`pgrep glmark2`/fdinfo/6
	pos:	0
	flags:	02400002
	mnt_id:	21
	ino:	162
	drm-driver:	msm
	drm-client-id:	7
	drm-engine-gpu:	1734371319 ns
	drm-cycles-gpu:	1153645024

See also: https://patchwork.freedesktop.org/patch/468505/

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 17 ++++++++++++++++-
 drivers/gpu/drm/msm/msm_gpu.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.h | 19 +++++++++++++++++++
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 16f37f3d9061..fdf401e6f09e 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -911,7 +911,22 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_QUERY, msm_ioctl_submitqueue_query, DRM_RENDER_ALLOW),
 };
 
-DEFINE_DRM_GEM_FOPS(fops);
+static void msm_fop_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct drm_file *file = f->private_data;
+	struct drm_device *dev = file->minor->dev;
+	struct msm_drm_private *priv = dev->dev_private;
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	if (!priv->gpu)
+		return;
+
+	msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, &p);
+}
+
+DEFINE_DRM_GEM_FOPS(fops,
+	.show_fdinfo = msm_fop_show_fdinfo,
+);
 
 static const struct drm_driver msm_driver = {
 	.driver_features    = DRIVER_GEM |
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 173ebd449f2f..6302f3fe564b 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -4,6 +4,8 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include "drm/drm_drv.h"
+
 #include "msm_gpu.h"
 #include "msm_gem.h"
 #include "msm_mmu.h"
@@ -146,6 +148,15 @@ int msm_gpu_pm_suspend(struct msm_gpu *gpu)
 	return 0;
 }
 
+void msm_gpu_show_fdinfo(struct msm_gpu *gpu, struct msm_file_private *ctx,
+			 struct drm_printer *p)
+{
+	drm_printf(p, "drm-driver:\t%s\n", gpu->dev->driver->name);
+	drm_printf(p, "drm-client-id:\t%u\n", ctx->seqno);
+	drm_printf(p, "drm-engine-gpu:\t%llu ns\n", ctx->elapsed_ns);
+	drm_printf(p, "drm-cycles-gpu:\t%llu\n", ctx->cycles);
+}
+
 int msm_gpu_hw_init(struct msm_gpu *gpu)
 {
 	int ret;
@@ -643,7 +654,7 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 {
 	int index = submit->seqno % MSM_GPU_SUBMIT_STATS_COUNT;
 	volatile struct msm_gpu_submit_stats *stats;
-	u64 elapsed, clock = 0;
+	u64 elapsed, clock = 0, cycles;
 	unsigned long flags;
 
 	stats = &ring->memptrs->stats[index];
@@ -651,12 +662,17 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 	elapsed = (stats->alwayson_end - stats->alwayson_start) * 10000;
 	do_div(elapsed, 192);
 
+	cycles = stats->cpcycles_end - stats->cpcycles_start;
+
 	/* Calculate the clock frequency from the number of CP cycles */
 	if (elapsed) {
-		clock = (stats->cpcycles_end - stats->cpcycles_start) * 1000;
+		clock = cycles * 1000;
 		do_div(clock, elapsed);
 	}
 
+	submit->queue->ctx->elapsed_ns += elapsed;
+	submit->queue->ctx->cycles     += cycles;
+
 	trace_msm_gpu_submit_retired(submit, elapsed, clock,
 		stats->alwayson_start, stats->alwayson_end);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 696e2ed8a236..ad4fe05dee03 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -328,6 +328,22 @@ struct msm_file_private {
 	struct kref ref;
 	int seqno;
 
+	/**
+	 * elapsed:
+	 *
+	 * The total (cumulative) elapsed time GPU was busy with rendering
+	 * from this context in ns.
+	 */
+	uint64_t elapsed_ns;
+
+	/**
+	 * cycles:
+	 *
+	 * The total (cumulative) GPU cycles elapsed attributed to this
+	 * context.
+	 */
+	uint64_t cycles;
+
 	/**
 	 * entities:
 	 *
@@ -511,6 +527,9 @@ static inline void gpu_write64(struct msm_gpu *gpu, u32 lo, u32 hi, u64 val)
 int msm_gpu_pm_suspend(struct msm_gpu *gpu);
 int msm_gpu_pm_resume(struct msm_gpu *gpu);
 
+void msm_gpu_show_fdinfo(struct msm_gpu *gpu, struct msm_file_private *ctx,
+			 struct drm_printer *p);
+
 int msm_submitqueue_init(struct drm_device *drm, struct msm_file_private *ctx);
 struct msm_gpu_submitqueue *msm_submitqueue_get(struct msm_file_private *ctx,
 		u32 id);
-- 
2.35.1

