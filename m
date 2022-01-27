Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE749E880
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244370AbiA0RKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiA0RKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:10:50 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B5EC061714;
        Thu, 27 Jan 2022 09:10:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so8118624pjj.4;
        Thu, 27 Jan 2022 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlD0uRJ9ShmnWQiuwR1rRBKFKsGAC8qfNh6UyNqzvaU=;
        b=kubnWOZL+aTtTeB05GV/0bsf4ClyVseFikad5aocEUs3PoIY0lb9FtsNzVfQQzuh+M
         S15LuNnDMB4+hymrONSSYkHWZmFXCKNUQyNmY6Qd6z7cOviUE+LRsHVi4O87wIdFtXf1
         84nRrbaB2yQofnMAlbvCjUeTWcx+55/sW+DfKka+jcPbH39r12ITHUeXaMdHSD6eDDDo
         nbnNEW0lg0gRneJNPN2WyQm08PpsINdekKlG1MBKcYnOXpstkmBBzB7Ssp23fpCF/Ps2
         Xj11pKv+rKraH+08pqbCYurGL+jBbBoSeNin2r4+Eu6EDXIiKzTMn3V0rZsg6HDxUyq7
         9Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlD0uRJ9ShmnWQiuwR1rRBKFKsGAC8qfNh6UyNqzvaU=;
        b=GGvAjQVMg/p08vsesdwj5wmXfbK8oxVR2t6HV2nuVIz2PY5YFhdaTAxPXgbru4wD/u
         cfcDuDrwiPammeTZD7DNroc9geO4gZKcDMLTIElUEeOZJXA2KTgD2Vzu4BntPLBMrRMe
         9bwiLdsIn4FIQ6Dj4dMIzrymeHszCUDs38yqkhPW2EzeeeVuEza9VbsU6I5KXhqt86z/
         +u3k1EsORXj7MKKYAY4wHQU7by7sVd2lof1ixhGzqMvrPXc5lPbYcdhVJ0N8ssFtWEBF
         OmEOO1p7Lysi65+v99TavCwyAeH7sOlr9DnlkGCmV43W+7waJBNtGrdOnKROnDNvRYOM
         rFoQ==
X-Gm-Message-State: AOAM530itn38DC9wW9iM+2wUgd7/414bAicOMEXw7FmgehaCUcMIanug
        oCpaZRpngfXFc3uURxsvA1s=
X-Google-Smtp-Source: ABdhPJyRUd3v+/HA1W7kXU13TAEokjZV4wLu9/Wpd4bQD4Pzw29TXvTPiMnAmUSkn/rxoIIg6Gn+pQ==
X-Received: by 2002:a17:902:e803:: with SMTP id u3mr4014071plg.41.1643303450242;
        Thu, 27 Jan 2022 09:10:50 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id mm24sm3390444pjb.20.2022.01.27.09.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:10:49 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm/gpu: Add param to get address space faults
Date:   Thu, 27 Jan 2022 09:10:39 -0800
Message-Id: <20220127171045.541341-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127171045.541341-1-robdclark@gmail.com>
References: <20220127171045.541341-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Add a param so that userspace can query the fault count for faults that
might effect them (ie. any context sharing the same address space).

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 +++
 drivers/gpu/drm/msm/msm_drv.c           | 1 +
 drivers/gpu/drm/msm/msm_gem.h           | 3 +++
 drivers/gpu/drm/msm/msm_gpu.c           | 1 +
 include/uapi/drm/msm_drm.h              | 3 ++-
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index caa9076197de..05899c77ca38 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -271,6 +271,9 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 	case MSM_PARAM_FAULTS:
 		*value = gpu->global_faults;
 		return 0;
+	case MSM_PARAM_AS_FAULTS:
+		*value = ctx->aspace->faults;
+		return 0;
 	case MSM_PARAM_SUSPENDS:
 		*value = gpu->suspend_count;
 		return 0;
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 72060247e43c..39ab9a361d7f 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -41,6 +41,7 @@
  * - 1.6.0 - Syncobj support
  * - 1.7.0 - Add MSM_PARAM_SUSPENDS to access suspend count
  * - 1.8.0 - Add MSM_BO_CACHED_COHERENT for supported GPUs (a6xx)
+ * - 1.9.0 - Add MSM_PARAM_AS_FAULTS
  */
 #define MSM_VERSION_MAJOR	1
 #define MSM_VERSION_MINOR	8
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 54ca0817d807..af612add5264 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -35,6 +35,9 @@ struct msm_gem_address_space {
 	 * will be non-NULL:
 	 */
 	struct pid *pid;
+
+	/* @faults: the number of GPU hangs associated with this address space */
+	int faults;
 };
 
 struct msm_gem_vma {
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 2c1049c0ea14..1029a51cb016 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -372,6 +372,7 @@ static void recover_worker(struct kthread_work *work)
 		/* Increment the fault counts */
 		gpu->global_faults++;
 		submit->queue->faults++;
+		submit->aspace->faults++;
 
 		task = get_pid_task(submit->pid, PIDTYPE_PID);
 		if (task) {
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 6b8fffc28a50..b7d92868b945 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -75,8 +75,9 @@ struct drm_msm_timespec {
 #define MSM_PARAM_GMEM_BASE  0x06
 #define MSM_PARAM_PRIORITIES 0x07  /* The # of priority levels */
 #define MSM_PARAM_PP_PGTABLE 0x08  /* => 1 for per-process pagetables, else 0 */
-#define MSM_PARAM_FAULTS     0x09
+#define MSM_PARAM_FAULTS     0x09  /* global fault count */
 #define MSM_PARAM_SUSPENDS   0x0a
+#define MSM_PARAM_AS_FAULTS  0x0b  /* faults in any context sharing same address space */
 
 /* For backwards compat.  The original support for preemption was based on
  * a single ring per priority level so # of priority levels equals the #
-- 
2.34.1

