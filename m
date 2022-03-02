Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579664CABB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbiCBRaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243986AbiCBR3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:29:45 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 32C2DD21F0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:28:26 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1646242106; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=RcAP0xOznlDSrZCrcvpydNufYdQBrPVOjepaStXxHr8=; b=LMa6g2iOjzA/G3fFx6WZtdZhWc+gMwB0lMMZ/8/hhLwkXCHNPuWcfDrToYoHqQgTkT79kctD
 D/98aifqrR8X1sRrSPMjw6fxl2I2whBpbahuTRa9IGRNoEDekJ+QJPi1KgUOi1+Ab96YNiVX
 tyo9iu3lIal2m4X5on7wSDx8z4Y=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 621fa938ea5f8dddb5487d1a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Mar 2022 17:28:24
 GMT
Sender: quic_akhilpo=quicinc.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4541C43638; Wed,  2 Mar 2022 17:28:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_H2,RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
Received: from hyd-lnxbld559.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09A54C43635;
        Wed,  2 Mar 2022 17:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 09A54C43635
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=quicinc.com
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sean Paul <sean@poorly.run>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wang Qing <wangqing@vivo.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/10] drm/msm/a6xx: Propagate OOB set error
Date:   Wed,  2 Mar 2022 22:57:32 +0530
Message-Id: <20220302225551.v1.6.I7f93862e5dfa6eb1cc3e6d3d4e5e83022a491a94@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646242056-2456-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1646242056-2456-1-git-send-email-quic_akhilpo@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate OOB set error to higher level so that a coredump is captured
followed by recovery sequence.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 33 ++++++++++++++++++++-------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 19 ++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index f121d798..66ae509 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -133,7 +133,7 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
 		A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
 }
 
-void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
+int a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
@@ -145,7 +145,7 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
 	gpu_freq = dev_pm_opp_get_freq(opp);
 
 	if (gpu_freq == gmu->freq)
-		return;
+		return 0;
 
 	for (perf_index = 0; perf_index < gmu->nr_gpu_freqs - 1; perf_index++)
 		if (gpu_freq == gmu->gpu_freqs[perf_index])
@@ -161,13 +161,13 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
 	 * bring up the power if it isn't already active
 	 */
 	if (pm_runtime_get_if_in_use(gmu->dev) == 0)
-		return;
+		return 0;
 
 	if (!gmu->legacy) {
-		a6xx_hfi_set_freq(gmu, perf_index);
+		ret = a6xx_hfi_set_freq(gmu, perf_index);
 		dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
 		pm_runtime_put(gmu->dev);
-		return;
+		return ret;
 	}
 
 	gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
@@ -182,15 +182,17 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
 	gmu_write(gmu, REG_A6XX_GMU_DCVS_BW_SETTING, 0xff);
 
 	/* Set and clear the OOB for DCVS to trigger the GMU */
-	a6xx_gmu_set_oob(gmu, GMU_OOB_DCVS_SET);
+	ret = a6xx_gmu_set_oob(gmu, GMU_OOB_DCVS_SET);
 	a6xx_gmu_clear_oob(gmu, GMU_OOB_DCVS_SET);
 
-	ret = gmu_read(gmu, REG_A6XX_GMU_DCVS_RETURN);
-	if (ret)
+	if (!ret && gmu_read(gmu, REG_A6XX_GMU_DCVS_RETURN)) {
 		dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
+		ret = -EINVAL;
+	}
 
 	dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
 	pm_runtime_put(gmu->dev);
+	return ret;
 }
 
 unsigned long a6xx_gmu_get_freq(struct msm_gpu *gpu)
@@ -353,11 +355,13 @@ int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_GMU2HOST_INTR_INFO, val,
 		val & (1 << ack), 100, 10000);
 
-	if (ret)
+	if (ret) {
 		DRM_DEV_ERROR(gmu->dev,
 			"Timeout waiting for GMU OOB set %s: 0x%x\n",
 				a6xx_gmu_oob_bits[state].name,
 				gmu_read(gmu, REG_A6XX_GMU_GMU2HOST_INTR_INFO));
+		return -ETIMEDOUT;
+	}
 
 	/* Clear the acknowledge interrupt */
 	gmu_write(gmu, REG_A6XX_GMU_GMU2HOST_INTR_CLR, 1 << ack);
@@ -922,18 +926,21 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 	a6xx_gmu_rpmh_off(gmu);
 }
 
-static void a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
+static int a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
 {
 	struct dev_pm_opp *gpu_opp;
 	unsigned long gpu_freq = gmu->gpu_freqs[gmu->current_perf_index];
+	int ret;
 
 	gpu_opp = dev_pm_opp_find_freq_exact(&gpu->pdev->dev, gpu_freq, true);
 	if (IS_ERR(gpu_opp))
-		return;
+		return PTR_ERR(gpu_opp);
 
 	gmu->freq = 0; /* so a6xx_gmu_set_freq() doesn't exit early */
-	a6xx_gmu_set_freq(gpu, gpu_opp);
+	ret = a6xx_gmu_set_freq(gpu, gpu_opp);
 	dev_pm_opp_put(gpu_opp);
+
+	return ret;
 }
 
 static void a6xx_gmu_set_initial_bw(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
@@ -1018,7 +1025,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	enable_irq(gmu->hfi_irq);
 
 	/* Set the GPU to the current freq */
-	a6xx_gmu_set_initial_freq(gpu, gmu);
+	ret = a6xx_gmu_set_initial_freq(gpu, gmu);
 
 out:
 	/* On failure, shut down the GMU to leave it in a good state */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8c3cb31..fdfc5c4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -890,7 +890,7 @@ static int hw_init(struct msm_gpu *gpu)
 	int ret;
 
 	/* Make sure the GMU keeps the GPU on while we set it up */
-	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
+	 ret = a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 
@@ -1570,11 +1570,18 @@ static int a6xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	int ret;
 
 	mutex_lock(&a6xx_gpu->gmu.lock);
 
 	/* Force the GPU power on so we can read this register */
-	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
+	ret = a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
+	if (ret) {
+		mutex_unlock(&a6xx_gpu->gmu.lock);
+		a6xx_gpu->gmu.hung = true;
+		kthread_queue_work(gpu->worker, &gpu->recover_work);
+		return ret;
+	}
 
 	*value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER_LO,
 			    REG_A6XX_CP_ALWAYS_ON_COUNTER_HI);
@@ -1650,10 +1657,16 @@ static void a6xx_gpu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	int ret;
 
 	mutex_lock(&a6xx_gpu->gmu.lock);
-	a6xx_gmu_set_freq(gpu, opp);
+	ret = a6xx_gmu_set_freq(gpu, opp);
 	mutex_unlock(&a6xx_gpu->gmu.lock);
+
+	if (ret) {
+		a6xx_gpu->gmu.hung = true;
+		kthread_queue_work(gpu->worker, &gpu->recover_work);
+	}
 }
 
 static struct msm_gem_address_space *
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 2599443..391ff76 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -77,7 +77,7 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu);
 
-void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp);
+int a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp);
 unsigned long a6xx_gmu_get_freq(struct msm_gpu *gpu);
 
 void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
-- 
2.7.4

