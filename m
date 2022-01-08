Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF1488540
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 19:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiAHSJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 13:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiAHSJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 13:09:28 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD447C06173F;
        Sat,  8 Jan 2022 10:09:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so16630204pjj.2;
        Sat, 08 Jan 2022 10:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFqHoeQilXb3XVVfc7GOCibLlaYPqe3j1vav/t/7llQ=;
        b=fTKxkIDEJZqrfqc3Pi+rck561tYjb5h0sGMB2Mf7UMnw9CrIEk+8A75WS4vQimcSHS
         X+Cr+wvtIv3lb36sbX1bnKX0RTaBVqUN19ooCQXiWoBWH0aEefotABPmeBUUD3gVKwbF
         vXyYyXZ+TeAEb4Hc3b5I/HRSPlXnnf+MNdUSpRPZSofqL7G0apNsS4ZqSHDc5AOaTBvK
         gE9Nj+0rMGs5hXlLl+nw1U/Lc8Wj7qre02pvLTFntHcdN4X3QtIeAGVJhOFOdGd6bCPk
         2/Tq65hc7XpzdqWpdMZC9C5+fcsVkdx+6Ov/a4KpnCoqlVtYSGoC6/ICAD61cKizd7Xd
         U5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFqHoeQilXb3XVVfc7GOCibLlaYPqe3j1vav/t/7llQ=;
        b=7UNLSX4YjcPAczDZhcbX19SMaSGZlnXetzsXxF+l44cR4SLHu9W697Yk646h9L4C4X
         lJ93XeGUPaXmsIUGTOjsWf0dhGMOulvFPmb0fnkVktrsZmry29kescsNnVdpF9di+plO
         HPPSKjeSBFTKJJlWBs8P8DdJas70JcfP6JElwLAYsn3NTZihYGe+QmUD1m72KxUHqQwC
         3729iLIbCHbqGj6qGZOogUcqKqDO7TLe32ayzkpuJ5EYaMD5ffr5zlHsuWn+77qUSoBj
         vd48K8gR8NhD6FynE/splPKSDILRxs+mTkhEzP+AhkJlxCmG0cxGaLDdIowe/9z0u5iK
         5kCQ==
X-Gm-Message-State: AOAM532jqXoa3CQJgjeUOu2aPiPaD0FpyINKaY8yTwP4dU7I8fV7tXFI
        SerWhuMDBFJ5t5wkfMybJ8M=
X-Google-Smtp-Source: ABdhPJxv8ir157x45LY0R4X7fwf+5QoK8coHgSyQZ9D5c/EZnvOCkENrRVwFdu0L4GV3FNgT4S5E9Q==
X-Received: by 2002:a63:370b:: with SMTP id e11mr285326pga.558.1641665367406;
        Sat, 08 Jan 2022 10:09:27 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id j22sm2653781pfj.29.2022.01.08.10.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 10:09:26 -0800 (PST)
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
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] drm/msm/gpu: Wait for idle before suspending
Date:   Sat,  8 Jan 2022 10:09:10 -0800
Message-Id: <20220108180913.814448-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220108180913.814448-1-robdclark@gmail.com>
References: <20220108180913.814448-1-robdclark@gmail.com>
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

v2: s/ret/remaining [sboyd], and switch to using active_submits count
    to ensure we aren't racing with submit cleanup (and devfreq idle
    work getting scheduled, etc)
v3: fix inverted logic

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.c              |  3 +++
 drivers/gpu/drm/msm/msm_gpu.h              |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 93005839b5da..fb261930ad1c 100644
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
+				       active_submits(gpu) == 0,
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

