Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C874A6130
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbiBAQQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbiBAQQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:16:14 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA32C061714;
        Tue,  1 Feb 2022 08:16:14 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso2983593pjm.4;
        Tue, 01 Feb 2022 08:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MnkWsxsvgV6jYlqjrCgNZZOUCGjYTcXq/86qZc0VO9M=;
        b=UBrDJDmLtPc0Wui/p8WtSn0X0DOXGqERJ0OBiM9RZY1a+CpAeLYVN+wktPLEfLGGIT
         GEHmrum1IBw5vL3uNkt4nIqnfC/W9sJBERsdJ2RYeBc4Hc2Kn1li78SZ8KhFAF7Ef/4P
         rdqUwnXElWHXRj+BdbP+LvlkjMtvBH8eSYWZx9OMEMl8hjcXyRUruJ1jLh0gQzpkvet6
         B319MiDnddh+0Ei1tHGQlX1YrT3WdKjyMi4A6CQHAeFN77ANF8Sy4khE+Zft9yfJUnQJ
         nobm1jDazoW3xqCiqfycvOE0BPyWJgvBdPE2IDFCBI7QOWgGjsxbdKpOCkABvYgep68h
         +7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MnkWsxsvgV6jYlqjrCgNZZOUCGjYTcXq/86qZc0VO9M=;
        b=Cnrop6D3QD7trK/nbYIl7yPgueO4QQWeCqzloUlhHzAtWnxNT82yDXcq+ogGh8sOMu
         +aoOOpyNbgQAj7GlZMcqq8K2Q2gzfatuZ/HcvnfeAO6astm2WOe8pQIYizsVvY/scpn0
         BopRHilDSCOQxxcSqkKFCdwepdYTmYIPFeyNXHIDbxEictrgVbI1F64L/Mr3Lquif3HU
         Bgeb7VTZbMBw/mpQmk+fr8/FKq84Mgo3a0+0UruxGFBAlCrmM4OwjV8vkS5/9aB+M5m8
         DYvdIhS4mLz+KvP/GMx1GFvuLWJcX2oDDE0Tdf0gUoyMpY/UilxWP72Cr5nnygTCJsn8
         qlAQ==
X-Gm-Message-State: AOAM531yhbZMdMKd7n6Pc7U/1kJCqyuxWgEOvWbPsZOFMHM7xto9HniN
        2RN3Pgw9ickyjtIs9grhjyY=
X-Google-Smtp-Source: ABdhPJzas4QP0D3ikc29XHmeyrMd+rn5viftGv/vHPmDifvADb4DEq1nXoSG2jHN2PdGQ3XPGpIIlQ==
X-Received: by 2002:a17:902:c40d:: with SMTP id k13mr25884655plk.151.1643732173932;
        Tue, 01 Feb 2022 08:16:13 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id 207sm16403918pgh.32.2022.02.01.08.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 08:16:12 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Emma Anholt <emma@anholt.net>,
        Yiwei Zhang <zzyiwei@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/msm/gpu: Add ctx to get_param()
Date:   Tue,  1 Feb 2022 08:16:11 -0800
Message-Id: <20220201161618.778455-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201161618.778455-1-robdclark@gmail.com>
References: <20220201161618.778455-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Prep work for next patch.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 ++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 3 ++-
 drivers/gpu/drm/msm/msm_drv.c           | 3 ++-
 drivers/gpu/drm/msm/msm_gpu.h           | 3 ++-
 drivers/gpu/drm/msm/msm_rd.c            | 6 ++++--
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f33cfa4ef1c8..caa9076197de 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -227,7 +227,8 @@ adreno_iommu_create_address_space(struct msm_gpu *gpu,
 	return aspace;
 }
 
-int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value)
+int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
+		     uint32_t param, uint64_t *value)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index cffabe7d33c1..432590036b31 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -279,7 +279,8 @@ static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
 	       adreno_is_a660_family(gpu);
 }
 
-int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value);
+int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
+		     uint32_t param, uint64_t *value);
 const struct firmware *adreno_request_fw(struct adreno_gpu *adreno_gpu,
 		const char *fwname);
 struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 555666e3f960..72060247e43c 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -763,7 +763,8 @@ static int msm_ioctl_get_param(struct drm_device *dev, void *data,
 	if (!gpu)
 		return -ENXIO;
 
-	return gpu->funcs->get_param(gpu, args->param, &args->value);
+	return gpu->funcs->get_param(gpu, file->driver_priv,
+				     args->param, &args->value);
 }
 
 static int msm_ioctl_gem_new(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 92aa1e9196c6..ba8407231340 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -42,7 +42,8 @@ struct msm_gpu_config {
  *    + z180_gpu
  */
 struct msm_gpu_funcs {
-	int (*get_param)(struct msm_gpu *gpu, uint32_t param, uint64_t *value);
+	int (*get_param)(struct msm_gpu *gpu, struct msm_file_private *ctx,
+			 uint32_t param, uint64_t *value);
 	int (*hw_init)(struct msm_gpu *gpu);
 	int (*pm_suspend)(struct msm_gpu *gpu);
 	int (*pm_resume)(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index 7e4d6460719e..dd3605b46264 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -197,13 +197,15 @@ static int rd_open(struct inode *inode, struct file *file)
 
 	/* the parsing tools need to know gpu-id to know which
 	 * register database to load.
+	 *
+	 * Note: These particular param does not require a context
 	 */
-	gpu->funcs->get_param(gpu, MSM_PARAM_GPU_ID, &val);
+	gpu->funcs->get_param(gpu, NULL, MSM_PARAM_GPU_ID, &val);
 	gpu_id = val;
 
 	rd_write_section(rd, RD_GPU_ID, &gpu_id, sizeof(gpu_id));
 
-	gpu->funcs->get_param(gpu, MSM_PARAM_CHIP_ID, &val);
+	gpu->funcs->get_param(gpu, NULL, MSM_PARAM_CHIP_ID, &val);
 	rd_write_section(rd, RD_CHIP_ID, &val, sizeof(val));
 
 out:
-- 
2.34.1

