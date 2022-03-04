Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3194CCB0E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbiCDA7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbiCDA7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:59:37 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE52C148641;
        Thu,  3 Mar 2022 16:58:46 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s1so6328934plg.12;
        Thu, 03 Mar 2022 16:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytOUMOh2Tl97mA0t3dQsH3Iaw7ED9UKYQDbSghK/IvU=;
        b=qnWebqhmSUN2ykTGUf5NTGC9LCvr+AxTNFXJu8gTvei+C0TZShSzxePPZm7Wqb8oKu
         p0XL3K9zoXOAsJH9E8WSNm5eD5YR6oMlsSIH/VZ3tiSnk7hldIXhPodDdn4oyZLa7DRQ
         jzqLepvs/hee3JAuRuGKbWkv0BAbVLHbhX2xsxZhDgVfrHcaCzLfBSp01nVM2M/WwXuE
         6UPnB3nqXDdCLIhc2z0d5wTt7Zc/QZf8uXa6KlTKQj+MapHlod28Wv8d616WA8+YA3le
         /U9QJwCerQW1owPiZ1BC3s1t5AazoD+rAyuk98+nYEfqT0oS1cMz/2XTH8awyJQxwRbH
         KOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytOUMOh2Tl97mA0t3dQsH3Iaw7ED9UKYQDbSghK/IvU=;
        b=jACtqLPNgkKvdEOkVCZGnbKPfHll44lzeTIa6h+3sXBA24kTba8yLM2/2vXwAR/qkd
         7nfrsEfodjVBQhsFAIKmz5Wylh3H/N0fV65hV5sNOu3mYvn4dGYYoDbEBJRVr6afFVwr
         v5HRSTlE/2dth7Y6aRCRQP0Kr0a8XKQ9xNoDv7AWInneptaPlnOlKwPMPLI4k2Op8W8k
         v7aYwwT3NL08QE6dTogw7rgFjNOGahpNzQufkT75v2PkUO6cZVSQu5lax9aPNZjDCpTi
         B4fwu9BWw6cwo1uMaqoPa3f9SMxn98LkGVXnAtTXPw5hB+UHRncyiTjXA67HSjCKtIwq
         zdHg==
X-Gm-Message-State: AOAM532MQkcaYMxlmWAEgkHfwhqlmqPtk1KUlNsbIxNK598AwSR5vSex
        JIS2mxJeuVVPIsRlRDKyh50=
X-Google-Smtp-Source: ABdhPJyCXY7a6lQyt3Ie6M7z9kn6VnY+6lt2SmSEFxRfGXPOW76jUqZw9+9eP/LElBrlpQJzSTLQVg==
X-Received: by 2002:a17:90a:a502:b0:1bc:8dd6:a859 with SMTP id a2-20020a17090aa50200b001bc8dd6a859mr8121797pjq.46.1646355526407;
        Thu, 03 Mar 2022 16:58:46 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id s33-20020a056a0017a100b004bf85a94ef2sm3873451pfg.183.2022.03.03.16.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:58:45 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Emma Anholt <emma@anholt.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] drm/msm: Add SET_PARAM ioctl
Date:   Thu,  3 Mar 2022 16:52:15 -0800
Message-Id: <20220304005317.776110-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304005317.776110-1-robdclark@gmail.com>
References: <20220304005317.776110-1-robdclark@gmail.com>
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

It was always expected to have a use for this some day, so we left a
placeholder.  Now we do.  (And I expect another use in the not too
distant future when we start allowing userspace to allocate GPU iova.)

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c   |  1 +
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c   |  1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c   |  1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 +++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  2 ++
 drivers/gpu/drm/msm/msm_drv.c           | 20 ++++++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  2 ++
 include/uapi/drm/msm_drm.h              | 27 ++++++++++++++-----------
 10 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index 22e8295a5e2b..6c9a747eb4ad 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -471,6 +471,7 @@ static u32 a2xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 static const struct adreno_gpu_funcs funcs = {
 	.base = {
 		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
 		.hw_init = a2xx_hw_init,
 		.pm_suspend = msm_gpu_pm_suspend,
 		.pm_resume = msm_gpu_pm_resume,
diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 2e481e2692ba..0ab0e1dd8bbb 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -486,6 +486,7 @@ static u32 a3xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 static const struct adreno_gpu_funcs funcs = {
 	.base = {
 		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
 		.hw_init = a3xx_hw_init,
 		.pm_suspend = msm_gpu_pm_suspend,
 		.pm_resume = msm_gpu_pm_resume,
diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
index c5524d6e8705..0c6b2a6d0b4c 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
@@ -621,6 +621,7 @@ static u32 a4xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 static const struct adreno_gpu_funcs funcs = {
 	.base = {
 		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
 		.hw_init = a4xx_hw_init,
 		.pm_suspend = a4xx_pm_suspend,
 		.pm_resume = a4xx_pm_resume,
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 3d28fcf841a6..407f50a15faa 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1700,6 +1700,7 @@ static uint32_t a5xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 static const struct adreno_gpu_funcs funcs = {
 	.base = {
 		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
 		.hw_init = a5xx_hw_init,
 		.pm_suspend = a5xx_pm_suspend,
 		.pm_resume = a5xx_pm_resume,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 7d23c741db4a..237c2e7a7baa 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1800,6 +1800,7 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
 static const struct adreno_gpu_funcs funcs = {
 	.base = {
 		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
 		.hw_init = a6xx_hw_init,
 		.pm_suspend = a6xx_pm_suspend,
 		.pm_resume = a6xx_pm_resume,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 15c8997b7251..6a37d409653b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -283,6 +283,16 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 	}
 }
 
+int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
+		     uint32_t param, uint64_t value)
+{
+	switch (param) {
+	default:
+		DBG("%s: invalid param: %u", gpu->name, param);
+		return -EINVAL;
+	}
+}
+
 const struct firmware *
 adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
 {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index b1ee453d627d..0490c5fbb780 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -282,6 +282,8 @@ static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
 
 int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		     uint32_t param, uint64_t *value);
+int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
+		     uint32_t param, uint64_t value);
 const struct firmware *adreno_request_fw(struct adreno_gpu *adreno_gpu,
 		const char *fwname);
 struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index fdf401e6f09e..ca9a8a866292 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -614,6 +614,25 @@ static int msm_ioctl_get_param(struct drm_device *dev, void *data,
 				     args->param, &args->value);
 }
 
+static int msm_ioctl_set_param(struct drm_device *dev, void *data,
+		struct drm_file *file)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+	struct drm_msm_param *args = data;
+	struct msm_gpu *gpu;
+
+	if (args->pipe != MSM_PIPE_3D0)
+		return -EINVAL;
+
+	gpu = priv->gpu;
+
+	if (!gpu)
+		return -ENXIO;
+
+	return gpu->funcs->set_param(gpu, file->driver_priv,
+				     args->param, args->value);
+}
+
 static int msm_ioctl_gem_new(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
@@ -899,6 +918,7 @@ static int msm_ioctl_submitqueue_close(struct drm_device *dev, void *data,
 
 static const struct drm_ioctl_desc msm_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(MSM_GET_PARAM,    msm_ioctl_get_param,    DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(MSM_SET_PARAM,    msm_ioctl_set_param,    DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(MSM_GEM_NEW,      msm_ioctl_gem_new,      DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(MSM_GEM_INFO,     msm_ioctl_gem_info,     DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(MSM_GEM_CPU_PREP, msm_ioctl_gem_cpu_prep, DRM_RENDER_ALLOW),
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index ad4fe05dee03..fde9a29f884e 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -45,6 +45,8 @@ struct msm_gpu_config {
 struct msm_gpu_funcs {
 	int (*get_param)(struct msm_gpu *gpu, struct msm_file_private *ctx,
 			 uint32_t param, uint64_t *value);
+	int (*set_param)(struct msm_gpu *gpu, struct msm_file_private *ctx,
+			 uint32_t param, uint64_t value);
 	int (*hw_init)(struct msm_gpu *gpu);
 	int (*pm_suspend)(struct msm_gpu *gpu);
 	int (*pm_resume)(struct msm_gpu *gpu);
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 6cd45a7f6947..a1bb2a17a8b9 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -67,16 +67,20 @@ struct drm_msm_timespec {
 	__s64 tv_nsec;         /* nanoseconds */
 };
 
-#define MSM_PARAM_GPU_ID     0x01
-#define MSM_PARAM_GMEM_SIZE  0x02
-#define MSM_PARAM_CHIP_ID    0x03
-#define MSM_PARAM_MAX_FREQ   0x04
-#define MSM_PARAM_TIMESTAMP  0x05
-#define MSM_PARAM_GMEM_BASE  0x06
-#define MSM_PARAM_PRIORITIES 0x07  /* The # of priority levels */
-#define MSM_PARAM_PP_PGTABLE 0x08  /* => 1 for per-process pagetables, else 0 */
-#define MSM_PARAM_FAULTS     0x09
-#define MSM_PARAM_SUSPENDS   0x0a
+/* Below "RO" indicates a read-only param, "WO" indicates write-only, and
+ * "RW" indicates a param that can be both read (GET_PARAM) and written
+ * (SET_PARAM)
+ */
+#define MSM_PARAM_GPU_ID     0x01  /* RO */
+#define MSM_PARAM_GMEM_SIZE  0x02  /* RO */
+#define MSM_PARAM_CHIP_ID    0x03  /* RO */
+#define MSM_PARAM_MAX_FREQ   0x04  /* RO */
+#define MSM_PARAM_TIMESTAMP  0x05  /* RO */
+#define MSM_PARAM_GMEM_BASE  0x06  /* RO */
+#define MSM_PARAM_PRIORITIES 0x07  /* RO: The # of priority levels */
+#define MSM_PARAM_PP_PGTABLE 0x08  /* RO: Deprecated, always returns zero */
+#define MSM_PARAM_FAULTS     0x09  /* RO */
+#define MSM_PARAM_SUSPENDS   0x0a  /* RO */
 
 /* For backwards compat.  The original support for preemption was based on
  * a single ring per priority level so # of priority levels equals the #
@@ -335,9 +339,7 @@ struct drm_msm_submitqueue_query {
 };
 
 #define DRM_MSM_GET_PARAM              0x00
-/* placeholder:
 #define DRM_MSM_SET_PARAM              0x01
- */
 #define DRM_MSM_GEM_NEW                0x02
 #define DRM_MSM_GEM_INFO               0x03
 #define DRM_MSM_GEM_CPU_PREP           0x04
@@ -353,6 +355,7 @@ struct drm_msm_submitqueue_query {
 #define DRM_MSM_SUBMITQUEUE_QUERY      0x0C
 
 #define DRM_IOCTL_MSM_GET_PARAM        DRM_IOWR(DRM_COMMAND_BASE + DRM_MSM_GET_PARAM, struct drm_msm_param)
+#define DRM_IOCTL_MSM_SET_PARAM        DRM_IOW (DRM_COMMAND_BASE + DRM_MSM_SET_PARAM, struct drm_msm_param)
 #define DRM_IOCTL_MSM_GEM_NEW          DRM_IOWR(DRM_COMMAND_BASE + DRM_MSM_GEM_NEW, struct drm_msm_gem_new)
 #define DRM_IOCTL_MSM_GEM_INFO         DRM_IOWR(DRM_COMMAND_BASE + DRM_MSM_GEM_INFO, struct drm_msm_gem_info)
 #define DRM_IOCTL_MSM_GEM_CPU_PREP     DRM_IOW (DRM_COMMAND_BASE + DRM_MSM_GEM_CPU_PREP, struct drm_msm_gem_cpu_prep)
-- 
2.35.1

