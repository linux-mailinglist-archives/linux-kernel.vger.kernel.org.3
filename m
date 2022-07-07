Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0956A7B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiGGQM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbiGGQMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:12:31 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935105727D;
        Thu,  7 Jul 2022 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657210312; x=1688746312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SF0+mltqMQO54WCs04EtSDjlOt+0NsQwSfvlvOiqPvk=;
  b=WtFcsMkQ4oHgljz7q9xInOpNcwHu0fmWjBKmHaDsMYplpDFiyR3p7NqC
   pVsVayQb/AFG1q0dNx8t/SRuMtt4i9ABmsQm7Em3igU+MhB5XuEb6ISwW
   kSmz8iQrxFpVJaOtzRd2v+xNgH6u0ehVhDrb6S3tX6tSdCuwbulzQ+iRV
   E=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Jul 2022 09:11:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 09:11:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 09:11:51 -0700
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 09:11:45 -0700
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
Subject: [PATCH 4/7] drm/msm: Ensure cx gdsc collapse during recovery
Date:   Thu, 7 Jul 2022 21:40:59 +0530
Message-ID: <20220707213950.4.I510084ecc82b2efe42dd904fea595cdec99058b2@changeid>
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

To improve our chance of a successful recovery, we should ensure that
cx headswitch collapses. Cx headswitch might be kept enabled through a
vote from another driver like iommu or even another hardware subsystem.
So, poll the cx gdscr register to ensure that it collapses during
recovery.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 13 ++++++++++++-
 drivers/gpu/drm/msm/msm_gpu.c         |  4 ++++
 drivers/gpu/drm/msm/msm_gpu.h         |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 57a7ad5..e956a13 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1189,11 +1189,15 @@ static void a6xx_dump(struct msm_gpu *gpu)
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
 
@@ -1220,6 +1224,13 @@ static void a6xx_recover(struct msm_gpu *gpu)
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
index 48171b6..29ee615 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -881,6 +881,10 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
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
index 6def008..07578778 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -217,6 +217,7 @@ struct msm_gpu {
 	int global_faults;
 
 	void __iomem *mmio;
+	void __iomem *gpucc_io;
 	int irq;
 
 	struct msm_gem_address_space *aspace;
-- 
2.7.4

