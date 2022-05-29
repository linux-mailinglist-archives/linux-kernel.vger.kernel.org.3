Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B6C53720A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiE2SEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiE2SEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:04:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9694B64BDE;
        Sun, 29 May 2022 11:04:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso8699854pjg.0;
        Sun, 29 May 2022 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5qx+pVGY2AgizlZabnmHPGmRzUWPgfS4YN8x6bBJwA=;
        b=jRdc7r1EDXy1ZDU+swfWq3BXpeFni65EXnItTebIJe2K4+KmFReH97TIyPkztBm7JH
         C+yOUq+DOISNXM7fhRFYunW3IFHhvrg86yV9VVaMyCEcz7Cen5Ws6G0SeHkGVQUGJGl+
         9obKy7fvwx8SfkwgJkkuay+3so8vVVAiOLh/0YtkhzBday8panVIf0ESXAtbLX1D8OTg
         wZABfKBA6y1FGkOLlisEAIU3Tve3Y9/OYuPVWPfjDm+sQUE357Hy0pC2ZSNb6FCXELxE
         TJ+pQRRZGslxsH0rLmekKr513xUXesULnKZXSNlTCJcV2QrHhuo+R7z+mcNeSqc2IF1R
         LKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5qx+pVGY2AgizlZabnmHPGmRzUWPgfS4YN8x6bBJwA=;
        b=3CLBwOqndWaBebYkrXzijHNIy8b2AxctVq3/mEfBCd83iI3vklBeHkYEWfzqkN/a9u
         qil61zPrsiDMtHV8BTURilOadB7hoE4Bdq7qGSyS8N74ktvXIkAQs8qSxWMchQ04X+HJ
         A22EpLzQtE7grzM9uVaXPJ2jCyZ7WRJjrrtbq83pFw7pu9iogx34cLVyMVeealFV9Ihx
         C/Esi/YktHbuJJyQzu0ijIn9HauHRAq6mrzaLgVUz8wWxgL9fHTk2Cket3+RHJ6gYir4
         66Lfc0pImhdckxzj2/CPcZKzzKilfLJp0MiXAAdl/SCEep3gclqzSGdNpqkpUAkDerAI
         5x2w==
X-Gm-Message-State: AOAM532UE2a2y2Vg/hh6IkaxRZMxxOK7rqQ7l5N+9btO0ueNYCaVjgLA
        v397zRRNR910puYBNgRweL8=
X-Google-Smtp-Source: ABdhPJxx8AwOCgmabpZSFVPzG7ycEcpG3xkuaN7+b45R+BYVaVarA8IwDTIISC4yM0SeICK1uHuA7g==
X-Received: by 2002:a17:902:b90b:b0:15f:bd0:18b5 with SMTP id bf11-20020a170902b90b00b0015f0bd018b5mr54152190plb.97.1653847462045;
        Sun, 29 May 2022 11:04:22 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709028f8900b0015e8d4eb2casm7439442plo.276.2022.05.29.11.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 11:04:20 -0700 (PDT)
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
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/msm/adreno: Allow larger address space size
Date:   Sun, 29 May 2022 11:04:23 -0700
Message-Id: <20220529180428.2577832-1-robdclark@gmail.com>
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

v2: Send the right version of the patch (ie. the one that actually
    compiles)

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
index 4e665c806a14..7b5f30881eee 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -21,6 +21,10 @@
 #include "msm_gem.h"
 #include "msm_mmu.h"
 
+static u64 address_space_size = 0;
+MODULE_PARM_DESC(address_space_size, "Override for size of processes private GPU address space");
+module_param(address_space_size, ullong, 0600);
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

