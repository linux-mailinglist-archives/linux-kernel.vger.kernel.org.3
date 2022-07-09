Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460AE56C76C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 08:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiGIGAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 02:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGIGA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 02:00:26 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E876C7CB4E;
        Fri,  8 Jul 2022 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657346425; x=1688882425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XGQbLWmmXvctI4HYl9j46qsii5iPHrQ4eKepFp+Nbs8=;
  b=uff26fSVlT1SH+lIoueRw/RffWzdTFOIt9gqQURM88eeeFe/THaqgD47
   5uwwWNyfa7qIj2dbzx/o0OpirVllA0OxGPeMSJuHVFZZojXO4ykoaNy8O
   ee6Vx3k9h/rTJQ3rOKwV7qyIDPkhKB1iCf0f7tWE92eSHuLBnkwAvvBPK
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Jul 2022 23:00:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 23:00:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 23:00:24 -0700
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 23:00:18 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Douglas Anderson" <dianders@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/7] drm/msm: Ensure cx gdsc collapse during recovery
Date:   Sat, 9 Jul 2022 11:29:32 +0530
Message-ID: <20220709112837.v2.4.I510084ecc82b2efe42dd904fea595cdec99058b2@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657346375-1461-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1657346375-1461-1-git-send-email-quic_akhilpo@quicinc.com>
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

To improve our chance of a successful recovery, we should ensure that
cx headswitch collapses. Cx headswitch might be kept enabled through a
vote from another driver like iommu or even another hardware subsystem.
So, poll the cx gdscr register to ensure that it collapses during
recovery.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

(no changes since v1)

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 13 ++++++++++++-
 drivers/gpu/drm/msm/msm_gpu.c         |  4 ++++
 drivers/gpu/drm/msm/msm_gpu.h         |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 7ed347c..9aaa469 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1257,11 +1257,15 @@ static void a6xx_dump(struct msm_gpu *gpu)
 #define VBIF_RESET_ACK_TIMEOUT	100
 #define VBIF_RESET_ACK_MASK	0x00f0
 
+#define CX_GDSCR_OFFSET	0x106c
+#define CX_GDSC_ON_MASK	BIT(31)
+
 static void a6xx_recover(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
-	int i;
+	int i, ret;
+	u32 val;
 
 	adreno_dump_info(gpu);
 
@@ -1288,6 +1292,13 @@ static void a6xx_recover(struct msm_gpu *gpu)
 	/* And the final one from recover worker */
 	pm_runtime_put_sync(&gpu->pdev->dev);
 
+	if (gpu->gpucc_io) {
+		ret = readl_poll_timeout(gpu->gpucc_io + CX_GDSCR_OFFSET, val,
+			!(val & CX_GDSC_ON_MASK), 100, 500000);
+		if (ret)
+			DRM_DEV_INFO(&gpu->pdev->dev, "cx gdsc didn't collapse\n");
+	}
+
 	for (i = gpu->active_submits; i > 0; i--)
 		pm_runtime_get(&gpu->pdev->dev);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index aa6f34f..7ada0785 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -865,6 +865,10 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		goto fail;
 	}
 
+	gpu->gpucc_io = msm_ioremap(pdev, "gpucc");
+	if (IS_ERR(gpu->gpucc_io))
+		gpu->gpucc_io = NULL;
+
 	/* Get Interrupt: */
 	gpu->irq = platform_get_irq(pdev, 0);
 	if (gpu->irq < 0) {
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 4d935fe..1fe498f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -226,6 +226,7 @@ struct msm_gpu {
 	int global_faults;
 
 	void __iomem *mmio;
+	void __iomem *gpucc_io;
 	int irq;
 
 	struct msm_gem_address_space *aspace;
-- 
2.7.4

