Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE27F471B9C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 17:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhLLQj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 11:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhLLQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 11:39:27 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B8C061714;
        Sun, 12 Dec 2021 08:39:26 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 13so20480277ljj.11;
        Sun, 12 Dec 2021 08:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I/KGHR66/uoO7zyvDC3r34YM2SXZEMEA1Z2R9AMuiVI=;
        b=SpXhfGTNVDWxv1L8OBD3nfxBRI+YaGfP8LLKHWfyfHcLNPyY2jNM8AQel/C81KzzVk
         6UQNc/kXX99KIwigiJRruiCTi0d6/ff+olw+Gf5zvzoW/gcqdxZujH8b9McTxgOCrb39
         uUFc9eLHR2ZMr8zEgukfb9Ma1tEdY8NF2UI8pM9Y8Zx16XonQpeSZPpK/XB4uAhLuuTd
         /hFnHL+HgOt2Q5XhvcMtbuQUlDPJMr5Z1wA533BbZl/xqhkbj2IAvB28h8m+uh2knAa5
         wHGwKVuRfNek4IutOWAJBVxwMK9lxY9xt8phoY4O4ZlSeGkrj8lnzD6zNc+VXIM1BlQc
         dHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I/KGHR66/uoO7zyvDC3r34YM2SXZEMEA1Z2R9AMuiVI=;
        b=5LzjF+giLok9vRHs0doLQb4WlDwg72SeOX1K240ySxczRTvXQNCxZshKCvyJ52Ac+e
         BcS8QvGxPdUDlwL/yyiMV3D+whhL1fiAXkBdDzn4gVXCAmsy9CSWCorjBGG5sZc1UR+a
         CIPrxmdo5m6RsUxtZEUQJ0I8e3n7W7C+yu7/fcA7CR+rqm/LXHPPXHgaOPgguj7VNRPW
         9/kypu4zfQB7V1CzZPJGFYSvEWfTosgzKyaWvG4Uxo1uQXczh1/OpHEPIIIc4wkghYG4
         ZhJKz34WUymLzOrqeBrpkI2IaBzZWt7uszYIueORzKTzu5ngrhg3c+WvFpJhi4dQ/UhP
         UKgg==
X-Gm-Message-State: AOAM53363Rdl3/iHNxQ40ZcXLGZDzOkJPI3MFOmjMydLqm+ZZz5wxQFv
        FNtdPWbZP3RFcreZs6O1gpw=
X-Google-Smtp-Source: ABdhPJzTQAArmKZ/OQ/icHIFWtYpG6BLP248muVMqgvUkMc49Bwo4DvEWRik66fHDavEdrW3MQtbcg==
X-Received: by 2002:a2e:a806:: with SMTP id l6mr25003083ljq.126.1639327164088;
        Sun, 12 Dec 2021 08:39:24 -0800 (PST)
Received: from localhost.localdomain (public-nat-10.vpngate.v4.open.ad.jp. [219.100.37.242])
        by smtp.gmail.com with ESMTPSA id u7sm1110936lja.58.2021.12.12.08.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 08:39:23 -0800 (PST)
From:   Vladimir Lypak <vladimir.lypak@gmail.com>
To:     Vladimir Lypak <vladimir.lypak@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/msm/a5xx: Add support for Adreno 506 GPU
Date:   Sun, 12 Dec 2021 16:03:16 +0000
Message-Id: <20211212160333.980343-1-vladimir.lypak@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This GPU is found on SoCs such as MSM8953 (650 MHz), SDM450 (600 MHz),
SDM632 (725 MHz).

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
---
Changes since v1:
- don't change behaviour for other GPU revisions
- also setup CP_PROTECT for SMMU
- correct formatting
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c      | 39 +++++++++++++---------
 drivers/gpu/drm/msm/adreno/adreno_device.c | 18 ++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  5 +++
 3 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 5e2750eb3810..894881d273b8 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -441,7 +441,7 @@ void a5xx_set_hwcg(struct msm_gpu *gpu, bool state)
 	const struct adreno_five_hwcg_regs *regs;
 	unsigned int i, sz;
 
-	if (adreno_is_a508(adreno_gpu)) {
+	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu)) {
 		regs = a50x_hwcg;
 		sz = ARRAY_SIZE(a50x_hwcg);
 	} else if (adreno_is_a509(adreno_gpu) || adreno_is_a512(adreno_gpu)) {
@@ -485,7 +485,7 @@ static int a5xx_me_init(struct msm_gpu *gpu)
 	OUT_RING(ring, 0x00000000);
 
 	/* Specify workarounds for various microcode issues */
-	if (adreno_is_a530(adreno_gpu)) {
+	if (adreno_is_a506(adreno_gpu) || adreno_is_a530(adreno_gpu)) {
 		/* Workaround for token end syncs
 		 * Force a WFI after every direct-render 3D mode draw and every
 		 * 2D mode 3 draw
@@ -620,8 +620,16 @@ static int a5xx_ucode_init(struct msm_gpu *gpu)
 
 static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	int ret;
 
+	/*
+	 * Adreno 506 have CPZ Retention feature and doesn't require
+	 * to resume zap shader
+	 */
+	if (adreno_is_a506(adreno_gpu))
+		return 0;
+
 	ret = qcom_scm_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
 	if (ret)
 		DRM_ERROR("%s: zap-shader resume failed: %d\n",
@@ -733,9 +741,10 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 		0x00100000 + adreno_gpu->gmem - 1);
 	gpu_write(gpu, REG_A5XX_UCHE_GMEM_RANGE_MAX_HI, 0x00000000);
 
-	if (adreno_is_a508(adreno_gpu) || adreno_is_a510(adreno_gpu)) {
+	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu) ||
+	    adreno_is_a510(adreno_gpu)) {
 		gpu_write(gpu, REG_A5XX_CP_MEQ_THRESHOLDS, 0x20);
-		if (adreno_is_a508(adreno_gpu))
+		if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu))
 			gpu_write(gpu, REG_A5XX_CP_MERCIU_SIZE, 0x400);
 		else
 			gpu_write(gpu, REG_A5XX_CP_MERCIU_SIZE, 0x20);
@@ -751,7 +760,7 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 		gpu_write(gpu, REG_A5XX_CP_ROQ_THRESHOLDS_1, 0x40201B16);
 	}
 
-	if (adreno_is_a508(adreno_gpu))
+	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu))
 		gpu_write(gpu, REG_A5XX_PC_DBG_ECO_CNTL,
 			  (0x100 << 11 | 0x100 << 22));
 	else if (adreno_is_a509(adreno_gpu) || adreno_is_a510(adreno_gpu) ||
@@ -769,8 +778,8 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 	 * Disable the RB sampler datapath DP2 clock gating optimization
 	 * for 1-SP GPUs, as it is enabled by default.
 	 */
-	if (adreno_is_a508(adreno_gpu) || adreno_is_a509(adreno_gpu) ||
-	    adreno_is_a512(adreno_gpu))
+	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu) ||
+	    adreno_is_a509(adreno_gpu) || adreno_is_a512(adreno_gpu))
 		gpu_rmw(gpu, REG_A5XX_RB_DBG_ECO_CNTL, 0, (1 << 9));
 
 	/* Disable UCHE global filter as SP can invalidate/flush independently */
@@ -851,9 +860,9 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 	/* UCHE */
 	gpu_write(gpu, REG_A5XX_CP_PROTECT(16), ADRENO_PROTECT_RW(0xE80, 16));
 
-	if (adreno_is_a508(adreno_gpu) || adreno_is_a509(adreno_gpu) ||
-	    adreno_is_a510(adreno_gpu) || adreno_is_a512(adreno_gpu) ||
-	    adreno_is_a530(adreno_gpu))
+	if (adreno_is_a506(adreno_gou) || adreno_is_a508(adreno_gpu) ||
+	    adreno_is_a509(adreno_gpu) || adreno_is_a510(adreno_gpu) ||
+	    adreno_is_a512(adreno_gpu) || adreno_is_a530(adreno_gpu))
 		gpu_write(gpu, REG_A5XX_CP_PROTECT(17),
 			ADRENO_PROTECT_RW(0x10000, 0x8000));
 
@@ -895,8 +904,7 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 	if (ret)
 		return ret;
 
-	if (!(adreno_is_a508(adreno_gpu) || adreno_is_a509(adreno_gpu) ||
-	      adreno_is_a510(adreno_gpu) || adreno_is_a512(adreno_gpu)))
+	if (adreno_is_a530(adreno_gpu) || adreno_is_a540(adreno_gpu))
 		a5xx_gpmu_ucode_init(gpu);
 
 	ret = a5xx_ucode_init(gpu);
@@ -1338,7 +1346,7 @@ static int a5xx_pm_resume(struct msm_gpu *gpu)
 	if (ret)
 		return ret;
 
-	/* Adreno 508, 509, 510, 512 needs manual RBBM sus/res control */
+	/* Adreno 506, 508, 509, 510, 512 needs manual RBBM sus/res control */
 	if (!(adreno_is_a530(adreno_gpu) || adreno_is_a540(adreno_gpu))) {
 		/* Halt the sp_input_clk at HM level */
 		gpu_write(gpu, REG_A5XX_RBBM_CLOCK_CNTL, 0x00000055);
@@ -1381,8 +1389,9 @@ static int a5xx_pm_suspend(struct msm_gpu *gpu)
 	u32 mask = 0xf;
 	int i, ret;
 
-	/* A508, A510 have 3 XIN ports in VBIF */
-	if (adreno_is_a508(adreno_gpu) || adreno_is_a510(adreno_gpu))
+	/* A506, A508, A510 have 3 XIN ports in VBIF */
+	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu) ||
+	    adreno_is_a510(adreno_gpu))
 		mask = 0x7;
 
 	/* Clear the VBIF pipe before shutting down */
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 2a6ce76656aa..eada4de8b46e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -131,6 +131,24 @@ static const struct adreno_info gpulist[] = {
 		.gmem  = (SZ_1M + SZ_512K),
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.init  = a4xx_gpu_init,
+	}, {
+		.rev   = ADRENO_REV(5, 0, 6, ANY_ID),
+		.revn = 506,
+		.name = "A506",
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+		},
+		.gmem = (SZ_128K + SZ_8K),
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
+			  ADRENO_QUIRK_LMLOADKILL_DISABLE,
+		.init = a5xx_gpu_init,
+		.zapfw = "a506_zap.mdt",
 	}, {
 		.rev   = ADRENO_REV(5, 0, 8, ANY_ID),
 		.revn = 508,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 225c277a6223..427a96d81280 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -201,6 +201,11 @@ static inline int adreno_is_a430(struct adreno_gpu *gpu)
        return gpu->revn == 430;
 }
 
+static inline int adreno_is_a506(struct adreno_gpu *gpu)
+{
+	return gpu->revn == 506;
+}
+
 static inline int adreno_is_a508(struct adreno_gpu *gpu)
 {
 	return gpu->revn == 508;
-- 
2.33.1

