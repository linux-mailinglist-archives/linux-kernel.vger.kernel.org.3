Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C005371FC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiE2SCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiE2SCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:02:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D0606E4;
        Sun, 29 May 2022 11:02:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so8653278pjf.5;
        Sun, 29 May 2022 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzGOFoijegI6bs3FEJJIbalqohkJ7YI9mVcD9clwKWU=;
        b=nOnixLnoLQGUvPL5RyUQZOlPY6YE6sNEMHjYjB2IaYUrtzPoYguiyrl1YUq+Lsm927
         3EBZmxu4bAYfcWvSMuAlCYHftz433enDWNht0945TEX570r/w4uGZcaiKfU4ftm/cC4k
         X4xk50R+bxzTE6Hw7drKMu4JMci4MbvUyZL0dDer18d+WLPO7wxvuMM8IU5jraCPSOXH
         AWrwrCnl8DAxkxXrJc/+e+G8suJ5PFdL9F4Mks90Gbxs0MFal9IIERTRNIkjirUSgl/l
         qti86avstvKCwFK9ZxRE9FhIx/81oGc9m+klckALxDY553SU3F83RRqgoggrrzi4OAdj
         nQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzGOFoijegI6bs3FEJJIbalqohkJ7YI9mVcD9clwKWU=;
        b=EOF4j/IvRDGTsb6zrs0aSL8DDutBEYVM1GGaUnZiSFt5yL54Rdzez/jZOM3Ajql3nY
         JwWhON6qgkLh12/tN2AhAi/nHxc5TY8Hy2J8agjUqyH2PDZKmDf8L9IAvns3L2vLYVRm
         DRBrSuHCejEpdo2I3iDO6kGk+Y9vNqu9ogTIpP/SeEM4gcEyZi/3s1zS1JvhZs3PToHA
         yqwP74GaKySShSZXvhS+HnyzZT/HOKAOkyiKZIbdX/Mykr0yCksQxU34L+sWE8SBEowb
         FUnC6AS2AHKKFkSSNJ8H1we3tewZnQEJvk8i8j5lLlEGFNnW3NG3mE+uzgKXn50clODq
         HbyQ==
X-Gm-Message-State: AOAM5332SfRscCFXEVnrWtzLFZIIEyDjeAMqwSw4X+L4Av1hPM5Dx0m4
        9nqGocyXD0wTnaqSHauG7gc=
X-Google-Smtp-Source: ABdhPJwbxNlyttp4stVGRr/0qeiqK75I0bN48Jv5EpwxMjf2d4saFqSUqUJ4ZWtAGhl4CfHyPk5ouQ==
X-Received: by 2002:a17:902:b413:b0:15e:e6a8:b3e with SMTP id x19-20020a170902b41300b0015ee6a80b3emr52707916plr.24.1653847352869;
        Sun, 29 May 2022 11:02:32 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b0016370e1af6bsm7622714plh.128.2022.05.29.11.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 11:02:31 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Connor Abbott <cwabbott0@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Chia-I Wu <olvaffe@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/adreno: Allow larger address space size
Date:   Sun, 29 May 2022 11:02:25 -0700
Message-Id: <20220529180232.2576720-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The restriction to 4G was strictly to work around 64b math bug in some
versions of SQE firmware.  This appears to be fixed in a650+ SQE fw, so
allow a larger address space size on these devices.

Also, add a modparam override for debugging and igt.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  3 ++-
 drivers/gpu/drm/msm/adreno/adreno_device.c |  3 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 17 +++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  2 ++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 42ed9a3c4905..24932b2945ae 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1737,7 +1737,8 @@ a6xx_create_private_address_space(struct msm_gpu *gpu)
 		return ERR_CAST(mmu);
 
 	return msm_gem_address_space_create(mmu,
-		"gpu", 0x100000000ULL, SZ_4G);
+		"gpu", 0x100000000ULL,
+		adreno_private_address_space_size(gpu));
 }
 
 static uint32_t a6xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 89cfd84760d7..f3685130ce9b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -303,6 +303,7 @@ static const struct adreno_info gpulist[] = {
 		.init = a6xx_gpu_init,
 		.zapfw = "a650_zap.mdt",
 		.hwcg = a650_hwcg,
+		.address_space_size = SZ_16G,
 	}, {
 		.rev = ADRENO_REV(6, 6, 0, ANY_ID),
 		.revn = 660,
@@ -316,6 +317,7 @@ static const struct adreno_info gpulist[] = {
 		.init = a6xx_gpu_init,
 		.zapfw = "a660_zap.mdt",
 		.hwcg = a660_hwcg,
+		.address_space_size = SZ_16G,
 	}, {
 		.rev = ADRENO_REV(6, 3, 5, ANY_ID),
 		.fw = {
@@ -326,6 +328,7 @@ static const struct adreno_info gpulist[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.init = a6xx_gpu_init,
 		.hwcg = a660_hwcg,
+		.address_space_size = SZ_16G,
 	}, {
 		.rev = ADRENO_REV(6, 8, 0, ANY_ID),
 		.revn = 680,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 4e665c806a14..7bc96cbe6e95 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -21,6 +21,10 @@
 #include "msm_gem.h"
 #include "msm_mmu.h"
 
+static u64 address_space_size = 0;
+MODULE_PARM_DESC(address_space_size, "Override for size of processes private GPU address space");
+module_param(address_space_size, u64, 0600);
+
 static bool zap_available = true;
 
 static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
@@ -228,6 +232,19 @@ adreno_iommu_create_address_space(struct msm_gpu *gpu,
 	return aspace;
 }
 
+u64 adreno_private_address_space_size(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+
+	if (address_space_size)
+		return address_space_size;
+
+	if (adreno_gpu->info->address_space_size)
+		return adreno_gpu->info->address_space_size;
+
+	return SZ_4G;
+}
+
 int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		     uint32_t param, uint64_t *value, uint32_t *len)
 {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index ab3b5ef80332..0a4d45695dc7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -70,6 +70,7 @@ struct adreno_info {
 	const char *zapfw;
 	u32 inactive_period;
 	const struct adreno_reglist *hwcg;
+	u64 address_space_size;
 };
 
 const struct adreno_info *adreno_info(struct adreno_rev rev);
@@ -280,6 +281,7 @@ static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
 	       adreno_is_a660_family(gpu);
 }
 
+u64 adreno_private_address_space_size(struct msm_gpu *gpu);
 int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		     uint32_t param, uint64_t *value, uint32_t *len);
 int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
-- 
2.35.3

