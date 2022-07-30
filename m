Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3066D5859CB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiG3Jls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiG3Jld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:41:33 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B301C103;
        Sat, 30 Jul 2022 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659174092; x=1690710092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3DzLtOnLizA1KXEFjj204k/vzORZplUFUM/scwb531k=;
  b=jPdt5usk6LJ7fLzYVzIwOBaefNgeXzpCzDYsoEeY/AL+/gfznY6GXlNB
   YSLtotXyqFGolgdmINhYPOz2CQPcuUAkhFC0YtQHXvpqmH+9GZEJdk08Y
   0CTqs4+d9thBYdU2E1OH5PSNoILlTdNMyxK8RGz9RJh3ziBXIG0mL0XJ+
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Jul 2022 02:41:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 02:41:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 02:41:31 -0700
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 02:41:26 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/8] drm/msm: Fix cx collapse issue during recovery
Date:   Sat, 30 Jul 2022 15:10:47 +0530
Message-ID: <20220730150952.v3.4.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some hardware logic under CX domain. For a successful
recovery, we should ensure cx headswitch collapses to ensure all the
stale states are cleard out. This is especially true to for a6xx family
where we can GMU co-processor.

Currently, cx doesn't collapse due to a devlink between gpu and its
smmu. So the *struct gpu device* needs to be runtime suspended to ensure
that the iommu driver removes its vote on cx gdsc.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

Changes in v3:
- Simplied the pm refcount drop since we have just a single refcount now
for all active submits

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 24 +++++++++++++++++++++---
 drivers/gpu/drm/msm/msm_gpu.c         |  4 +---
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 42ed9a3..1b049c5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1193,7 +1193,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
-	int i;
+	int i, active_submits;
 
 	adreno_dump_info(gpu);
 
@@ -1210,8 +1210,26 @@ static void a6xx_recover(struct msm_gpu *gpu)
 	 */
 	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
 
-	gpu->funcs->pm_suspend(gpu);
-	gpu->funcs->pm_resume(gpu);
+	pm_runtime_dont_use_autosuspend(&gpu->pdev->dev);
+
+	/* active_submit won't change until we make a submission */
+	mutex_lock(&gpu->active_lock);
+	active_submits = gpu->active_submits;
+	mutex_unlock(&gpu->active_lock);
+
+	/* Drop the rpm refcount from active submits */
+	if (active_submits)
+		pm_runtime_put(&gpu->pdev->dev);
+
+	/* And the final one from recover worker */
+	pm_runtime_put_sync(&gpu->pdev->dev);
+
+	pm_runtime_use_autosuspend(&gpu->pdev->dev);
+
+	if (active_submits)
+		pm_runtime_get(&gpu->pdev->dev);
+
+	pm_runtime_get_sync(&gpu->pdev->dev);
 
 	msm_gpu_hw_init(gpu);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 1945efb..07e55a6 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -426,9 +426,7 @@ static void recover_worker(struct kthread_work *work)
 		/* retire completed submits, plus the one that hung: */
 		retire_submits(gpu);
 
-		pm_runtime_get_sync(&gpu->pdev->dev);
 		gpu->funcs->recover(gpu);
-		pm_runtime_put_sync(&gpu->pdev->dev);
 
 		/*
 		 * Replay all remaining submits starting with highest priority
@@ -445,7 +443,7 @@ static void recover_worker(struct kthread_work *work)
 		}
 	}
 
-	pm_runtime_put_sync(&gpu->pdev->dev);
+	pm_runtime_put(&gpu->pdev->dev);
 
 	mutex_unlock(&gpu->lock);
 
-- 
2.7.4

