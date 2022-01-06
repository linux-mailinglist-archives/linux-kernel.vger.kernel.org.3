Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755B2486991
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbiAFSPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbiAFSPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:15:08 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C542C061212;
        Thu,  6 Jan 2022 10:15:08 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id l15so3025856pls.7;
        Thu, 06 Jan 2022 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9aRT+BKtfoUra9B8cP6tf0Fs3h6BVFB+BuyDyjwYyis=;
        b=Umg7a1l870g0diH/9R9A4xgzQInP7pCMmNMxws7RaWkbkeqIBLknKWpyw1kthFU6s3
         1GJNrDSkmI1kxrbt/Y+4ettK5mu56e84+6V9mCf2cmZEt1Kn5wm7rqor9n9IkAGeksHd
         Y0/HcNp2EkY1YoA3VryJrjgbbriRvjrzpIpkxS2VGInWxz5lijvuxK3tK57nlCay4l6h
         khwcnI5k2hWNIqd1p+zuWneFmfv4EfkCbmrSyJdwBl4BHbIPMtAEwRdYPIIMaIsD0DdE
         wdbKI/RriL2uViUiNbIPIVWDHjFDsAL3hQ1lKC4nf7YwdF+e9yepOaiSR3RwwDktr7s3
         2A7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aRT+BKtfoUra9B8cP6tf0Fs3h6BVFB+BuyDyjwYyis=;
        b=sKYu+nDGl/L58Zfet3yHzmFu+o8919G9EJTWDzlDolqxUwlQl3L1uMSvbMOFFI+ieL
         9h6rE5r1W0vpoKgaZlC1E7w/eeUjbIvZz6+4vfdE5ZKNxKondZQNf2p0Uzmo0Q0ZcYOz
         aj+WCrzXwvIjM9NJWaXzGzy9TzBD3R6XVU5KqiGbNjVyAqb8qtaJd763/ceJJIXIFiaJ
         as5sDyv2fw6U2p38siCxcd1stuOkV4kLZGm2KSt22CidxpTns2za610bVZiaiQw7+BZN
         pMTGy4O8EqumrD+8DOf9K3fDe2+bElm2p6Og6Z+VgbZqRXkAgmUZiUEVYorGlVvWJvSb
         329g==
X-Gm-Message-State: AOAM533IM774JkZJu8fsfxal0pezQlmUNuh+SwIW0wM4ak3OxG8lzSJe
        9TzVZD8hxUFfu/d+03LPYT4=
X-Google-Smtp-Source: ABdhPJw0rL4+omUtSR47k3TXWKN/FskQ6U50lGHp2Fvucua0WK/BEfsE68Leus4rIk9/IMmCJN+fBQ==
X-Received: by 2002:a17:90b:4b0c:: with SMTP id lx12mr11581984pjb.146.1641492908127;
        Thu, 06 Jan 2022 10:15:08 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id i4sm3025524pjj.30.2022.01.06.10.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:15:07 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm/gpu: Wait for idle before suspending
Date:   Thu,  6 Jan 2022 10:14:46 -0800
Message-Id: <20220106181449.696988-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220106181449.696988-1-robdclark@gmail.com>
References: <20220106181449.696988-1-robdclark@gmail.com>
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
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.c              | 3 +++
 drivers/gpu/drm/msm/msm_gpu.h              | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 93005839b5da..b677ca3fd75e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -611,6 +611,15 @@ static int adreno_resume(struct device *dev)
 static int adreno_suspend(struct device *dev)
 {
 	struct msm_gpu *gpu = dev_to_gpu(dev);
+	int ret = 0;
+
+	ret = wait_event_timeout(gpu->retire_event,
+				 !msm_gpu_active(gpu),
+				 msecs_to_jiffies(1000));
+	if (ret == 0) {
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

