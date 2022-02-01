Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E364A6132
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbiBAQQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbiBAQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:16:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B1C061714;
        Tue,  1 Feb 2022 08:16:18 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m7so558891pjk.0;
        Tue, 01 Feb 2022 08:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=soKMugPn64vQ/cfc9qI0s3Cw/G/MYetWeT20PxsquF4=;
        b=h3bPV0//plQxMZfuT+9RNiWxNYKrtEB83JukyF6bReF1l/KWFtaNff26CfLlGcSqce
         UO12LUvG5IKcYpA6gZyImS7dHlz97uDuPbonID3vUo9yKEnvATNCX8VKuxO5Whrm7no+
         r+Unjy0evx78N2PGYxUkJIWg6WQFtbLgVF5UqTGbh6ZoRVrbBAtbhJL6gJM7SVwBfBT5
         9fg6IkCw3xYyTAjTGGtOxZ7K0pkg2su87bDZTkpNRHiqcPOe5R4eUI+ONpLliHYaj6E9
         bHLL6ktgqGvCuZzomRPWFbEQc4qwJqPh02kxb58YRDlTD6VwaWaYr0LBGS812pwAL+pc
         Nj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=soKMugPn64vQ/cfc9qI0s3Cw/G/MYetWeT20PxsquF4=;
        b=huh9ybjPYE9v5iuTBryTJOVs2+9Ra6V9Daqz32HFi+kjBHsQcV/0nUDCT1ZCjFIeqW
         QMEObIU4kbQVbbmAk5U/RikA+TwJkjuwyf7vnvCk1dEzk9kM2WB2yvnbsbHm7lgdn4E1
         tzHau6cKudhDMCozaEwlmB+Ba5hGqOLvMxwBZfgkDAxYmMbtbOMMToSAgAqOxxjdMwgn
         Wx4nLF/6rDhzcMjT/Vodb5+3JDWKXcX9d9MfHCytWS7D7dPj7AfZbpQQ9jxZW6VOhWx0
         h8w3n0fW1fOCNhFRpl1Nm0Q1xrjHLexYWCGj/4NPbGOxR8Swl9Iv30sA5QoqLMwKUjKc
         Uhiw==
X-Gm-Message-State: AOAM533D8atiy7TmN7pZ3v93oWaq81ATEyBHYVqDZaNAGnH65Kg5fD1D
        EirxbhTYFTK5sHrjGyIlHaQ=
X-Google-Smtp-Source: ABdhPJyxK0MpVj2a1YNiDWbtzm8rzXl8lp2pT9v7xwVfV932u5By8bLQxW4ej3tKDuokrBkV4OGciA==
X-Received: by 2002:a17:902:bf01:: with SMTP id bi1mr26784360plb.87.1643732177929;
        Tue, 01 Feb 2022 08:16:17 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id d22sm15617930pfl.71.2022.02.01.08.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 08:16:16 -0800 (PST)
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
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/msm/gpu: Track global faults per address-space
Date:   Tue,  1 Feb 2022 08:16:12 -0800
Message-Id: <20220201161618.778455-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201161618.778455-1-robdclark@gmail.com>
References: <20220201161618.778455-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Other processes don't need to know about faults that they are isolated
from by virtue of address space isolation.  They are only interested in
whether some of their state might have been corrupted.

But to be safe, also track unattributed faults.  This case should really
never happen unless there is a kernel bug (and that would never happen,
right?)

v2: Instead of adding a new param, just change the behavior of the
    existing param to match what userspace actually wants [anholt]

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/5934
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 drivers/gpu/drm/msm/msm_gem.h           | 3 +++
 drivers/gpu/drm/msm/msm_gpu.c           | 8 +++++++-
 drivers/gpu/drm/msm/msm_gpu.h           | 5 ++++-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index caa9076197de..58dfb23cf2af 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -269,7 +269,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		*value = 0;
 		return 0;
 	case MSM_PARAM_FAULTS:
-		*value = gpu->global_faults;
+		*value = gpu->global_faults + ctx->aspace->faults;
 		return 0;
 	case MSM_PARAM_SUSPENDS:
 		*value = gpu->suspend_count;
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
index 2c1049c0ea14..942bf41403ff 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -370,8 +370,8 @@ static void recover_worker(struct kthread_work *work)
 		struct task_struct *task;
 
 		/* Increment the fault counts */
-		gpu->global_faults++;
 		submit->queue->faults++;
+		submit->aspace->faults++;
 
 		task = get_pid_task(submit->pid, PIDTYPE_PID);
 		if (task) {
@@ -389,6 +389,12 @@ static void recover_worker(struct kthread_work *work)
 		} else {
 			msm_rd_dump_submit(priv->hangrd, submit, NULL);
 		}
+	} else {
+		/*
+		 * We couldn't attribute this fault to any particular context,
+		 * so increment the global fault count instead.
+		 */
+		gpu->global_faults++;
 	}
 
 	/* Record the crash state */
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index ba8407231340..c99627fc99dd 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -200,7 +200,10 @@ struct msm_gpu {
 	/* does gpu need hw_init? */
 	bool needs_hw_init;
 
-	/* number of GPU hangs (for all contexts) */
+	/**
+	 * global_faults: number of GPU hangs not attributed to a particular
+	 * address space
+	 */
 	int global_faults;
 
 	void __iomem *mmio;
-- 
2.34.1

