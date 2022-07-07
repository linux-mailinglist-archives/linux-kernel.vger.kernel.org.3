Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710F656A7B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiGGQMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiGGQM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:12:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507BF57234;
        Thu,  7 Jul 2022 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657210307; x=1688746307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=PjK+PZByDhJInr5VJSdek3gudLVUzwq0d5oNXpz6Ros=;
  b=PS2nI/injzR/CscgBpHdyHJC1k0snF45uCk9/nT82ULJHoGLPqybNjM8
   80OLEGyYVUndwW18HWZJN6SLebcZcXsEkvRF33KS3w//uaX5whh0vdRgK
   lGqk1AdpnFKSamVPYh3WjvnbogqFii4cj43sRBPT+gxJsIbgyZp8258qY
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Jul 2022 09:11:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 09:11:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 09:11:45 -0700
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 09:11:40 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Jordan Crouse <jordan@cosmicpenguin.net>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] drm/msm: Fix cx collapse issue during recovery
Date:   Thu, 7 Jul 2022 21:40:58 +0530
Message-ID: <20220707213950.3.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657210262-17166-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1657210262-17166-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 16 ++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.c         |  2 --
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 42ed9a3..57a7ad5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1210,8 +1210,20 @@ static void a6xx_recover(struct msm_gpu *gpu)
 	 */
 	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
 
-	gpu->funcs->pm_suspend(gpu);
-	gpu->funcs->pm_resume(gpu);
+	/*
+	 * Now drop all the pm_runtime usage count to allow cx gdsc to collapse.
+	 * First drop the usage count from all active submits
+	 */
+	for (i = gpu->active_submits; i > 0; i--)
+		pm_runtime_put(&gpu->pdev->dev);
+
+	/* And the final one from recover worker */
+	pm_runtime_put_sync(&gpu->pdev->dev);
+
+	for (i = gpu->active_submits; i > 0; i--)
+		pm_runtime_get(&gpu->pdev->dev);
+
+	pm_runtime_get_sync(&gpu->pdev->dev);
 
 	msm_gpu_hw_init(gpu);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index f75ff4b..48171b6 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -444,9 +444,7 @@ static void recover_worker(struct kthread_work *work)
 		/* retire completed submits, plus the one that hung: */
 		retire_submits(gpu);
 
-		pm_runtime_get_sync(&gpu->pdev->dev);
 		gpu->funcs->recover(gpu);
-		pm_runtime_put_sync(&gpu->pdev->dev);
 
 		/*
 		 * Replay all remaining submits starting with highest priority
-- 
2.7.4

