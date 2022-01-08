Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A71E48850F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiAHRnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiAHRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:42:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C32C06173F;
        Sat,  8 Jan 2022 09:42:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id oa15so8047605pjb.4;
        Sat, 08 Jan 2022 09:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=veNRWhd9+NGqZRRMDLcIrsjMGAnTxrdP3S7rk+ZlgfU=;
        b=h+sGy/eTysAmDiqKOhe0GzUbOZkMkFUQdPzmwwbVGWGd7IqEJJ+DBFYw8M8ry23KTC
         ifE/0GgTUu9s7EzyzssiWvP4nkYXNqZK9NzYWlbgHrpgl/OPDkjCr+YcY73KbV3Ju6if
         +4eSMiCu6aOjsSk25W2xhuCAGAyKfyNQi3O6t20tFLmN0t+wFBwVR1LknFoxE4FsSxEr
         EWmYJz8o+2gTZpuJ1ZjPbckefManaHQuxl0d2KG+WbUkYvF01+XoSXd1dTAe1/o3skcY
         blYcHKpNJgwIwIW4I59VJ3TfZ0rcGEN+GTGlGVVCxlk/QIZnLLVHUYQKP6NTSTfj9Dse
         fk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veNRWhd9+NGqZRRMDLcIrsjMGAnTxrdP3S7rk+ZlgfU=;
        b=qklEejJJnVEopNsywsT/1lh8/FbPg8Z2payS5vrZiJUlNT7Vm6EAcQdhm3hoNu38Cl
         K0wvduahjO9EsxYiCGBqCXAFGncY1cPtF7y9mVb7Adi7XYJzEaL2wCr9Ugkix4hPIPI1
         aRbpdJHHtkgDI/zPU+Og8JmzcgGCUZSZavYuaE/FTCyEmy/9FHLv6URQwAaVZ8iNFtK9
         DA28dvDZ8Yq40lK0btXf7vO/Ng2RtR/0bT0Wa2I+LBrJ3o377vKMc/T5tiRJpmKkbNeA
         dI2dczrBIhAAWWyy9mOHdPG2VX2oubLB/ariHVSJV2txYGtYEtq4ua2nfwOm+tqwuqlX
         2FtQ==
X-Gm-Message-State: AOAM532rRGLDWYunZxLY4QhTU5dh+TYfiPZbjk5n4V8OFw1o8wzGyf1D
        KQ+UG83x8x3kGviBufxCyaqTYG7ev5w=
X-Google-Smtp-Source: ABdhPJzLG6YcdlMT6/5DHXdk+PAdEVn0gjWS5r+DP+b7NI/BVtWCJ+uV9mI/oAsyoJtmEeYVp4czKw==
X-Received: by 2002:a17:90b:3b4d:: with SMTP id ot13mr21694800pjb.127.1641663777822;
        Sat, 08 Jan 2022 09:42:57 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id y129sm2510964pfy.164.2022.01.08.09.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 09:42:56 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/msm/gpu: Wait for idle before suspending
Date:   Sat,  8 Jan 2022 09:42:46 -0800
Message-Id: <20220108174249.811872-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220108174249.811872-1-robdclark@gmail.com>
References: <20220108174249.811872-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

System suspend uses pm_runtime_force_suspend(), which cheekily bypasses
the runpm reference counts.  This doesn't actually work so well when the
GPU is active.  So add a reasonable delay waiting for the GPU to become
idle.

Alternatively we could just return -EBUSY in this case, but that has the
disadvantage of causing system suspend to fail.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.c              |  3 +++
 drivers/gpu/drm/msm/msm_gpu.h              |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 93005839b5da..a502ffafb739 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -608,9 +608,27 @@ static int adreno_resume(struct device *dev)
 	return gpu->funcs->pm_resume(gpu);
 }
 
+static int active_submits(struct msm_gpu *gpu)
+{
+	int active_submits;
+	mutex_lock(&gpu->active_lock);
+	active_submits = gpu->active_submits;
+	mutex_unlock(&gpu->active_lock);
+	return active_submits;
+}
+
 static int adreno_suspend(struct device *dev)
 {
 	struct msm_gpu *gpu = dev_to_gpu(dev);
+	int remaining;
+
+	remaining = wait_event_timeout(gpu->retire_event,
+				       active_submits(gpu) > 0,
+				       msecs_to_jiffies(1000));
+	if (remaining == 0) {
+		dev_err(dev, "Timeout waiting for GPU to suspend\n");
+		return -EBUSY;
+	}
 
 	return gpu->funcs->pm_suspend(gpu);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0f78c2615272..2c1049c0ea14 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -703,6 +703,8 @@ static void retire_submits(struct msm_gpu *gpu)
 			}
 		}
 	}
+
+	wake_up_all(&gpu->retire_event);
 }
 
 static void retire_worker(struct kthread_work *work)
@@ -848,6 +850,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	INIT_LIST_HEAD(&gpu->active_list);
 	mutex_init(&gpu->active_lock);
 	mutex_init(&gpu->lock);
+	init_waitqueue_head(&gpu->retire_event);
 	kthread_init_work(&gpu->retire_work, retire_worker);
 	kthread_init_work(&gpu->recover_work, recover_worker);
 	kthread_init_work(&gpu->fault_work, fault_worker);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 445c6bfd4b6b..92aa1e9196c6 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -230,6 +230,9 @@ struct msm_gpu {
 	/* work for handling GPU recovery: */
 	struct kthread_work recover_work;
 
+	/** retire_event: notified when submits are retired: */
+	wait_queue_head_t retire_event;
+
 	/* work for handling active-list retiring: */
 	struct kthread_work retire_work;
 
-- 
2.33.1

