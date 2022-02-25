Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEDF4C4EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiBYTYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiBYTYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:24:12 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id CBBCB1D8316
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:23:39 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1645817019; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=XlQOgqUg+qM4j70seDDgBCK3GOdeY/KDt3HMzK3r7eU=; b=HE+qn7QCQADUHlTZ4tcjOR4RT8bMbETHd6+IEiSbRtXpSOmbQe/YmmQB3WwlQJ+9OOXzBVrH
 MQE7GDWVozCkf17m0ZU0FbbdehxRurcxtOioCH9iuPFru6OQnVWt1grfjGbWGcOOGRfvB/5v
 ccWf3NvMr74Kkc4bEL0HsKFJAHE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 62192c576f8d3f1389bd1e86 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Feb 2022 19:21:59
 GMT
Sender: quic_akhilpo=quicinc.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 784F0C43616; Fri, 25 Feb 2022 19:21:58 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FC54C43618;
        Fri, 25 Feb 2022 19:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2FC54C43618
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
Subject: [PATCH v2 2/5] drm/msm/adreno: Generate name from chipid for 7c3
Date:   Sat, 26 Feb 2022 00:51:29 +0530
Message-Id: <20220226005021.v2.2.I9436e0e300f76b2e6c34136a0b902e8cfd73e0d6@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645816893-22815-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1645816893-22815-1-git-send-email-quic_akhilpo@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a gpu name which is sprintf'ed from the chipid for 7c3 gpu instead of
hardcoding one. This helps to avoid code churn in case of a gpu rename.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

Changes in v2:
- use devm_kasprintf() to generate gpu name (Rob)

 drivers/gpu/drm/msm/adreno/adreno_device.c |  1 -
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 15 +++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

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
index f33cfa4..d9d0c13 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -929,12 +929,23 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	struct adreno_platform_config *config = dev->platform_data;
 	struct msm_gpu_config adreno_gpu_config  = { 0 };
 	struct msm_gpu *gpu = &adreno_gpu->base;
+	struct adreno_rev *rev = &config->rev;
+	const char *gpu_name;
 
 	adreno_gpu->funcs = funcs;
 	adreno_gpu->info = adreno_info(config->rev);
 	adreno_gpu->gmem = adreno_gpu->info->gmem;
 	adreno_gpu->revn = adreno_gpu->info->revn;
-	adreno_gpu->rev = config->rev;
+	adreno_gpu->rev = *rev;
+
+	gpu_name = adreno_gpu->info->name;
+	if (!gpu_name) {
+		gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%d.%d.%d.%d",
+				rev->core, rev->major, rev->minor,
+				rev->patchid);
+		if (!gpu_name)
+			return -ENOMEM;
+	}
 
 	adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
 
@@ -948,7 +959,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	pm_runtime_enable(dev);
 
 	return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
-			adreno_gpu->info->name, &adreno_gpu_config);
+			gpu_name, &adreno_gpu_config);
 }
 
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
-- 
2.7.4

