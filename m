Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC4E562DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiGAIWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbiGAIVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:21:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BA871BC9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:21:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r1so1692409plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jb0snNKbqdGMcNSHmZUstipe/vA8ntyU7tLSAh8qCE4=;
        b=EmWdXESfxTD6CClfgXeW3XMNSv/G8xk8QvfxlF5biP6edTuTajQaVQMVDMpOdy7Fuv
         MwktxJ+WJTVnMxJhs1Gt4E6SyL9e0EQF3iWsiK/Aifv7j0qHi6OiVTmSQ1dunx/oI6ty
         bY8yGaJDED/u5I76xENmYt5NI3WaoCl+80vM3DMnJWlKurKeE2tZ6SzpuqU3dfPSRHJh
         E7NAgHUpWVjxfDsLEWGa636YIKIemPdqiFQEgVykN8HoNsjUSMcIIQPW5sDXdqkWtnmU
         8+9h5nbQKWOjn7ZdmKio1PcWeIPAzY0nvAROsypuOs3sPOZvKhBZLZLJx4jsTf4+bhcg
         sgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jb0snNKbqdGMcNSHmZUstipe/vA8ntyU7tLSAh8qCE4=;
        b=DHt2LsI0V0R4LeUNMxqkpVn+5j2tj+BYdRQ9j45rUTWbN4jL48J/WMAw7wK3tjCOh4
         FoXg2918XjV6FLJyf57ivXSNwCt9+bKbtcTOYXpGcSHBHzt9aI0Mq+EKfKK5V2Sfhekd
         tBD2O5mjh3jeQ1ew8SzVX2q+MwaNXaUPdHxU5yUb0Zimw9T/3AbEeO6DOy91LdGuJMGE
         WXnAIristaK8Z8ACH3hgN7+fhS77rl7oF9sIgbUN3a8FTONhU5IONNZw2bPUhhyzT+h7
         Z+jRIk/J08hLF/aC6jjiEakaz/F0SHlDrGh0Y5oce3OAQUmN4KPwTSoLGRaecGttyruu
         az3w==
X-Gm-Message-State: AJIora+8Mb5jDmroRdVt+H8rdLLCb3wtV1P2p8jlStnuP03x7uinNEl3
        rsHiUBK2v8YGr8CpLfNTrcMFLQ==
X-Google-Smtp-Source: AGRyM1u7YOcVYA6e7JC8Afc3cO0uF+FowHj00X8PP+5fdNddz6P/PTLix/S0GqoELPlK91hqfqoM/g==
X-Received: by 2002:a17:90a:e2c5:b0:1ec:ea7f:a85c with SMTP id fr5-20020a17090ae2c500b001ecea7fa85cmr15486494pjb.232.1656663684098;
        Fri, 01 Jul 2022 01:21:24 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b0016a35649186sm14830427pln.195.2022.07.01.01.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 14/30] drm/msm: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:09 +0530
Message-Id: <31b74e43d3af263e1b943bca1dd3debe885521d8.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  8 ++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 10 +++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  6 +++++-
 drivers/gpu/drm/msm/dp/dp_ctrl.c        |  6 +++++-
 drivers/gpu/drm/msm/dsi/dsi_host.c      |  6 +++++-
 5 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index c424e9a37669..6ebb5a28c501 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1723,10 +1723,14 @@ static void check_speed_bin(struct device *dev)
 {
 	struct nvmem_cell *cell;
 	u32 val;
+	struct dev_pm_opp_config config = {
+		.supported_hw = &val,
+		.supported_hw_count = 1,
+	};
 
 	/*
 	 * If the OPP table specifies a opp-supported-hw property then we have
-	 * to set something with dev_pm_opp_set_supported_hw() or the table
+	 * to set something with dev_pm_opp_set_config() or the table
 	 * doesn't get populated so pick an arbitrary value that should
 	 * ensure the default frequencies are selected but not conflict with any
 	 * actual bins
@@ -1748,7 +1752,7 @@ static void check_speed_bin(struct device *dev)
 		nvmem_cell_put(cell);
 	}
 
-	devm_pm_opp_set_supported_hw(dev, &val, 1);
+	devm_pm_opp_set_config(dev, &config);
 }
 
 struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 42ed9a3c4905..82801311f7d4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1800,6 +1800,10 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
 	u32 supp_hw = UINT_MAX;
 	u32 speedbin;
 	int ret;
+	struct dev_pm_opp_config config = {
+		.supported_hw = &supp_hw,
+		.supported_hw_count = 1,
+	};
 
 	ret = adreno_read_speedbin(dev, &speedbin);
 	/*
@@ -1818,11 +1822,7 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
 	supp_hw = fuse_to_supp_hw(dev, rev, speedbin);
 
 done:
-	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
-	if (ret)
-		return ret;
-
-	return 0;
+	return devm_pm_opp_set_config(dev, &config);
 }
 
 static const struct adreno_gpu_funcs funcs = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index e23e2552e802..2213ce52d2fa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1215,12 +1215,16 @@ static int dpu_kms_init(struct drm_device *ddev)
 	struct dev_pm_opp *opp;
 	int ret = 0;
 	unsigned long max_freq = ULONG_MAX;
+	struct dev_pm_opp_config config = {
+		.clk_names = (const char *[]){ "core" },
+		.clk_count = 1,
+	};
 
 	dpu_kms = devm_kzalloc(&pdev->dev, sizeof(*dpu_kms), GFP_KERNEL);
 	if (!dpu_kms)
 		return -ENOMEM;
 
-	ret = devm_pm_opp_set_clkname(dev, "core");
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret)
 		return ret;
 	/* OPP table is optional */
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index b7f5b8d3bbd6..0c8fc151b4be 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2022,6 +2022,10 @@ struct dp_ctrl *dp_ctrl_get(struct device *dev, struct dp_link *link,
 {
 	struct dp_ctrl_private *ctrl;
 	int ret;
+	struct dev_pm_opp_config config = {
+		.clk_names = (const char *[]){ "ctrl_link" },
+		.clk_count = 1,
+	};
 
 	if (!dev || !panel || !aux ||
 	    !link || !catalog) {
@@ -2035,7 +2039,7 @@ struct dp_ctrl *dp_ctrl_get(struct device *dev, struct dp_link *link,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	ret = devm_pm_opp_set_clkname(dev, "ctrl_link");
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret) {
 		dev_err(dev, "invalid DP OPP table in device tree\n");
 		/* caller do PTR_ERR(opp_table) */
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index a95d5df52653..35b6722d1cf9 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2034,6 +2034,10 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 	struct msm_dsi_host *msm_host = NULL;
 	struct platform_device *pdev = msm_dsi->pdev;
 	int ret;
+	struct dev_pm_opp_config config = {
+		.clk_names = (const char *[]){ "byte" },
+		.clk_count = 1,
+	};
 
 	msm_host = devm_kzalloc(&pdev->dev, sizeof(*msm_host), GFP_KERNEL);
 	if (!msm_host) {
@@ -2095,7 +2099,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 		goto fail;
 	}
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "byte");
+	ret = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (ret)
 		return ret;
 	/* OPP table is optional */
-- 
2.31.1.272.g89b43f80a514

