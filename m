Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A20E544F2D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbiFIOeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbiFIOeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:34:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFFC31750A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:34:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z17so21230966pff.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+wGSWx5rEpsgmi4hQGx7HlbHSxy52WR8UStPyNrzxo=;
        b=Mf5PqduKe8vF51h+9aatjv7dQZh61xwzCf3FP3+ZjcQysGr9xL6cg5cp3dRur46HOl
         oqnMHRfnjKRHek2s3UNpi3H+lwZgPXjoZ9bXkxt+/DsDSgneq0mkld9/10q3zdVUEw8n
         /BiAOaPAuAdyVhgyLtYYMWH6P21wI1PXuiwW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+wGSWx5rEpsgmi4hQGx7HlbHSxy52WR8UStPyNrzxo=;
        b=JGNSXdUchJbQpjZZndYubsMd3q4JW8OD2S/sISmuMXttNNwQty4VM7nbH/c2WOdAR/
         5w45ON2s5AuiDEvDb/cRynDsBAa4oFpSgtIULMThh1F6KF7OtLf/xIbYpZ0zdW0cvnek
         OJGG8QUzyOhJOsmos3s5lmebe58pFeia5Z2VgIQggGWMCI3gYeUinc1xUeqciaMW8f+K
         df3gyzyBbYhbyuaT6bgpkP7CR6o5+WfYUF6wDu1yTnAvSoANyZjv/nv0IFW5JdTv2xtN
         IoM4lIsZ4Az4OGSpui+QJ1mkq72ZmXU8G//Bpule5XO4s86DUGtIMI4+aHAfKMKQRUe1
         g6sA==
X-Gm-Message-State: AOAM530lxJjH42BPfcsIbgXoSLZXuycktf5vWwTNI665JuWWG7ainD2a
        /SLY6WC156iS7C7gXf8jlSa2/g==
X-Google-Smtp-Source: ABdhPJy8SxaE59iJ2xQ/JffGvrDKCf2I2syIiyTxswm9wtZ4HWH2Kfbsudisov+hdfl6zmxEHFkyKg==
X-Received: by 2002:a63:f04e:0:b0:3ff:af9d:5387 with SMTP id s14-20020a63f04e000000b003ffaf9d5387mr3910816pgj.514.1654785242609;
        Thu, 09 Jun 2022 07:34:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:4732:8bcf:1bc2:ec84])
        by smtp.gmail.com with ESMTPSA id g2-20020aa79f02000000b005185407eda5sm17420543pfr.44.2022.06.09.07.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 07:34:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Sean Paul <sean@poorly.run>, Wang Qing <wangqing@vivo.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: Grab the GPU runtime in a6xx routines, not the GMU one
Date:   Thu,  9 Jun 2022 07:33:33 -0700
Message-Id: <20220609073317.1.Ie846c5352bc307ee4248d7cab998ab3016b85d06@changeid>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From testing on sc7180-trogdor devices, reading the GMU registers
needs the GMU clocks to be enabled. Those clocks get turned on in
a6xx_gmu_resume(). Confusingly enough, that function is called as a
result of the runtime_pm of the GPU "struct device", not the GMU
"struct device".

Let's grab a reference to the correct device. Incidentally, this makes
us match the a5xx routine more closely.

This is easily shown to fix crashes that happen if we change the GPU's
pm_runtime usage to not use autosuspend. It's also believed to fix
some long tail GPU crashes even with autosuspend.

NOTE: the crashes I've seen were fixed by _only_ fixing
a6xx_gpu_busy(). However, I believe that the same arguments should be
made to a6xx_gmu_set_freq() so I've changed that function too.

Fixes: eadf79286a4b ("drm/msm: Check for powered down HW in the devfreq callbacks")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 +++---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 9f76f5b15759..b79ad2e0649c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -129,13 +129,13 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
 	 * This can get called from devfreq while the hardware is idle. Don't
 	 * bring up the power if it isn't already active
 	 */
-	if (pm_runtime_get_if_in_use(gmu->dev) == 0)
+	if (pm_runtime_get_if_in_use(&gpu->pdev->dev) == 0)
 		return;
 
 	if (!gmu->legacy) {
 		a6xx_hfi_set_freq(gmu, perf_index);
 		dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
-		pm_runtime_put(gmu->dev);
+		pm_runtime_put(&gpu->pdev->dev);
 		return;
 	}
 
@@ -159,7 +159,7 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
 		dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
 
 	dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
-	pm_runtime_put(gmu->dev);
+	pm_runtime_put(&gpu->pdev->dev);
 }
 
 unsigned long a6xx_gmu_get_freq(struct msm_gpu *gpu)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 841e47a0b06b..87568d0b6ef8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1659,7 +1659,7 @@ static u64 a6xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
 	*out_sample_rate = 19200000;
 
 	/* Only read the gpu busy if the hardware is already active */
-	if (pm_runtime_get_if_in_use(a6xx_gpu->gmu.dev) == 0)
+	if (pm_runtime_get_if_in_use(&gpu->pdev->dev) == 0)
 		return 0;
 
 	busy_cycles = gmu_read64(&a6xx_gpu->gmu,
@@ -1667,7 +1667,7 @@ static u64 a6xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
 			REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H);
 
 
-	pm_runtime_put(a6xx_gpu->gmu.dev);
+	pm_runtime_put(&gpu->pdev->dev);
 
 	return busy_cycles;
 }
-- 
2.36.1.255.ge46751e96f-goog

