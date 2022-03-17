Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941D74DCBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiCQQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiCQQwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:52:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F52E20A959;
        Thu, 17 Mar 2022 09:51:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so5991094pjp.3;
        Thu, 17 Mar 2022 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vW5Zdse1i3pRk6JU03o69YBRQdnNrRsS1PGNiisfl5M=;
        b=VlfKEeP+lPdePeKU8PdVRkkgvOHIozbxDklQW5RKq5pXFemsT6Cf3M2cwZjeBUvhyC
         K7tWVuNdcwDpFRS8aMY8jQC0KTzr/RC5B2HURb4adYQ2bgH/GRhu04Pr7/RQsV46xKgE
         3iDvnjFkbtLbvSXCFdV/a5t4dCkxGbRQwH1Gf3YSWMQuHa2JXQpew0i5PoyvnlQfE2+Z
         lS4V7ZmrFJf0gz8+bA+qYBTpHuNhwpphB+DRWw/C1KCGTzksJHYS5wNyXFJ7cXyjwxGW
         sxoFZYEn7YPEcQs4LxHHUfsh52BaDWZMvbI5nIF7uH4nldWToIRBu2yTw6Zjqf2SEdBJ
         pF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vW5Zdse1i3pRk6JU03o69YBRQdnNrRsS1PGNiisfl5M=;
        b=tD2Hk4hKgOLh+2pMG4vIxMyDnkCeaaSythJj3n1+YZgz0XTNJ0gFJU6X8sM3lnt77a
         i4jFwG6xg4qNlxb6STcveS4qXzfNHiFmFcuuUoOYV9+iSLl/NMZHjHXeicwqO86FtSuF
         6VV3uTlp7EgTo42JaZA7HolDnpqitF3G69QIUTVnmZU0PGgp79S35v8nh/froOGEJFBL
         Px9zlOUSj7uDhBBDk84ssZL1S27Z+gdewDjesRAbnFNe+5rYzmxIOdQKh1jUSSmV2X6g
         5v1turiuhULLTi6ScZMH/yhe0lYHxgjOHlgqZfzeBUa7gW339kfJxVxxOd5yFii0xznK
         Mjjw==
X-Gm-Message-State: AOAM531OD1STC/XjDuTjLdCJ/0GXWZuawINjGKbpmMAD8+LpbwOKmN6T
        31YB08yrKWVJlb17QMTGyk8=
X-Google-Smtp-Source: ABdhPJwzfNHMhilqewg28u1p/XeMTqVQpkFPp+iX2u9jn4UWu6MQ4JepFS2j8iTvJWI0Fz6NCN2M3w==
X-Received: by 2002:a17:902:8644:b0:153:9f01:2090 with SMTP id y4-20020a170902864400b001539f012090mr6003326plt.101.1647535872996;
        Thu, 17 Mar 2022 09:51:12 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id l18-20020a056a00141200b004f75395b2cesm7324243pfu.150.2022.03.17.09.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 09:51:11 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Emma Anholt <emma@anholt.net>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] drm/msm: Add support for pointer params
Date:   Thu, 17 Mar 2022 09:51:38 -0700
Message-Id: <20220317165144.222101-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317165144.222101-1-robdclark@gmail.com>
References: <20220317165144.222101-1-robdclark@gmail.com>
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

The 64b value field is already suffient to hold a pointer instead of
immediate, but we also need a length field.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 12 ++++++++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  4 ++--
 drivers/gpu/drm/msm/msm_drv.c           |  8 ++++----
 drivers/gpu/drm/msm/msm_gpu.h           |  4 ++--
 drivers/gpu/drm/msm/msm_rd.c            |  5 +++--
 include/uapi/drm/msm_drm.h              |  2 ++
 6 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 9efc84929be0..3d307b34854d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -229,10 +229,14 @@ adreno_iommu_create_address_space(struct msm_gpu *gpu,
 }
 
 int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
-		     uint32_t param, uint64_t *value)
+		     uint32_t param, uint64_t *value, uint32_t *len)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 
+	/* No pointer params yet */
+	if (*len != 0)
+		return -EINVAL;
+
 	switch (param) {
 	case MSM_PARAM_GPU_ID:
 		*value = adreno_gpu->info->revn;
@@ -284,8 +288,12 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 }
 
 int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
-		     uint32_t param, uint64_t value)
+		     uint32_t param, uint64_t value, uint32_t len)
 {
+	/* No pointer params yet */
+	if (len != 0)
+		return -EINVAL;
+
 	switch (param) {
 	case MSM_PARAM_SYSPROF:
 		if (!capable(CAP_SYS_ADMIN))
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 0490c5fbb780..ab3b5ef80332 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -281,9 +281,9 @@ static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
 }
 
 int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
-		     uint32_t param, uint64_t *value);
+		     uint32_t param, uint64_t *value, uint32_t *len);
 int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
-		     uint32_t param, uint64_t value);
+		     uint32_t param, uint64_t value, uint32_t len);
 const struct firmware *adreno_request_fw(struct adreno_gpu *adreno_gpu,
 		const char *fwname);
 struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 780f9748aaaf..a5eed5738ac8 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -610,7 +610,7 @@ static int msm_ioctl_get_param(struct drm_device *dev, void *data,
 	/* for now, we just have 3d pipe.. eventually this would need to
 	 * be more clever to dispatch to appropriate gpu module:
 	 */
-	if (args->pipe != MSM_PIPE_3D0)
+	if ((args->pipe != MSM_PIPE_3D0) || (args->pad != 0))
 		return -EINVAL;
 
 	gpu = priv->gpu;
@@ -619,7 +619,7 @@ static int msm_ioctl_get_param(struct drm_device *dev, void *data,
 		return -ENXIO;
 
 	return gpu->funcs->get_param(gpu, file->driver_priv,
-				     args->param, &args->value);
+				     args->param, &args->value, &args->len);
 }
 
 static int msm_ioctl_set_param(struct drm_device *dev, void *data,
@@ -629,7 +629,7 @@ static int msm_ioctl_set_param(struct drm_device *dev, void *data,
 	struct drm_msm_param *args = data;
 	struct msm_gpu *gpu;
 
-	if (args->pipe != MSM_PIPE_3D0)
+	if ((args->pipe != MSM_PIPE_3D0) || (args->pad != 0))
 		return -EINVAL;
 
 	gpu = priv->gpu;
@@ -638,7 +638,7 @@ static int msm_ioctl_set_param(struct drm_device *dev, void *data,
 		return -ENXIO;
 
 	return gpu->funcs->set_param(gpu, file->driver_priv,
-				     args->param, args->value);
+				     args->param, args->value, args->len);
 }
 
 static int msm_ioctl_gem_new(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index a84140055920..c28c2ad9f52e 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -44,9 +44,9 @@ struct msm_gpu_config {
  */
 struct msm_gpu_funcs {
 	int (*get_param)(struct msm_gpu *gpu, struct msm_file_private *ctx,
-			 uint32_t param, uint64_t *value);
+			 uint32_t param, uint64_t *value, uint32_t *len);
 	int (*set_param)(struct msm_gpu *gpu, struct msm_file_private *ctx,
-			 uint32_t param, uint64_t value);
+			 uint32_t param, uint64_t value, uint32_t len);
 	int (*hw_init)(struct msm_gpu *gpu);
 	int (*pm_suspend)(struct msm_gpu *gpu);
 	int (*pm_resume)(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index 9d835331f214..a92ffde53f0b 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -180,6 +180,7 @@ static int rd_open(struct inode *inode, struct file *file)
 	struct msm_gpu *gpu = priv->gpu;
 	uint64_t val;
 	uint32_t gpu_id;
+	uint32_t zero = 0;
 	int ret = 0;
 
 	if (!gpu)
@@ -200,12 +201,12 @@ static int rd_open(struct inode *inode, struct file *file)
 	 *
 	 * Note: These particular params do not require a context
 	 */
-	gpu->funcs->get_param(gpu, NULL, MSM_PARAM_GPU_ID, &val);
+	gpu->funcs->get_param(gpu, NULL, MSM_PARAM_GPU_ID, &val, &zero);
 	gpu_id = val;
 
 	rd_write_section(rd, RD_GPU_ID, &gpu_id, sizeof(gpu_id));
 
-	gpu->funcs->get_param(gpu, NULL, MSM_PARAM_CHIP_ID, &val);
+	gpu->funcs->get_param(gpu, NULL, MSM_PARAM_CHIP_ID, &val, &zero);
 	rd_write_section(rd, RD_CHIP_ID, &val, sizeof(val));
 
 out:
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 07efc8033492..0aa1a8cb4e0d 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -95,6 +95,8 @@ struct drm_msm_param {
 	__u32 pipe;           /* in, MSM_PIPE_x */
 	__u32 param;          /* in, MSM_PARAM_x */
 	__u64 value;          /* out (get_param) or in (set_param) */
+	__u32 len;            /* zero for non-pointer params */
+	__u32 pad;            /* must be zero */
 };
 
 /*
-- 
2.35.1

