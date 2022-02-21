Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7694BDDCD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378146AbiBUOl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:41:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiBUOlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:41:51 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 65585205DB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:41:28 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1645454488; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=p5fSy22XpnYg/qkZPNTCKNOdQsFz5ZJ8/zg2XSRsI0A=; b=jdAo9aB02lD9BsME/jub81PwCjeLb8gnK9LlOuTqCxGegptgasShKfnWtUPismzmfuUGYUDe
 n7jo/vey4d+CXd2pkbPAxM6u6PPsOLdVVeV7O/2CbDTrzxTujZj9TdyaoO35ehpa39UvBhYN
 bLVEvXZTDTXU8WHgKLsgAWOJ6ZA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6213a4973047cf1c0ab476cc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Feb 2022 14:41:27
 GMT
Sender: quic_akhilpo=quicinc.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8AF9CC4363B; Mon, 21 Feb 2022 14:41:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
Received: from hyd-lnxbld559.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3DF4C43617;
        Mon, 21 Feb 2022 14:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C3DF4C43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=quicinc.com
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/msm/adreno: Generate name from chipid for 7c3
Date:   Mon, 21 Feb 2022 20:10:59 +0530
Message-Id: <20220221201039.2.I9436e0e300f76b2e6c34136a0b902e8cfd73e0d6@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645454462-27867-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1645454462-27867-1-git-send-email-quic_akhilpo@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a gpu name which is sprintf'ed from the chipid for 7c3 gpu instead of
hardcoding one. This helps to avoid code churn in case of a gpu rename.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

 drivers/gpu/drm/msm/adreno/adreno_device.c |  1 -
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index fb26193..89cfd84 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -318,7 +318,6 @@ static const struct adreno_info gpulist[] = {
 		.hwcg = a660_hwcg,
 	}, {
 		.rev = ADRENO_REV(6, 3, 5, ANY_ID),
-		.name = "Adreno 7c Gen 3",
 		.fw = {
 			[ADRENO_FW_SQE] = "a660_sqe.fw",
 			[ADRENO_FW_GMU] = "a660_gmu.bin",
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f33cfa4..158bbf7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -929,12 +929,22 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	struct adreno_platform_config *config = dev->platform_data;
 	struct msm_gpu_config adreno_gpu_config  = { 0 };
 	struct msm_gpu *gpu = &adreno_gpu->base;
+	struct adreno_rev *rev = &config->rev;
+	const char *gpu_name;
+	static char name[8];
 
 	adreno_gpu->funcs = funcs;
 	adreno_gpu->info = adreno_info(config->rev);
 	adreno_gpu->gmem = adreno_gpu->info->gmem;
 	adreno_gpu->revn = adreno_gpu->info->revn;
-	adreno_gpu->rev = config->rev;
+	adreno_gpu->rev = *rev;
+
+	gpu_name = adreno_gpu->info->name;
+	if (!gpu_name) {
+		sprintf(name, "%d.%d.%d.%d", rev->core, rev->major, rev->minor,
+				rev->patchid);
+		gpu_name = name;
+	}
 
 	adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
 
@@ -948,7 +958,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	pm_runtime_enable(dev);
 
 	return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
-			adreno_gpu->info->name, &adreno_gpu_config);
+			gpu_name, &adreno_gpu_config);
 }
 
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
-- 
2.7.4

