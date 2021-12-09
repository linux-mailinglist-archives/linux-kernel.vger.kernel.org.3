Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8730946F3E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhLIT3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLIT3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:29:34 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709E4C061746;
        Thu,  9 Dec 2021 11:26:00 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 133so5944142pgc.12;
        Thu, 09 Dec 2021 11:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AkH8G74nuWliFsm56RBshmsnPHnGtaW2iQYxsG6KvQw=;
        b=Q4FTRkOslqkiYzs3+L+pSSEDFqt2hwbAbCHgGrusaS25Te/F1xLyzKgOHvu5ZGUFtl
         D+VxfsGK/ZOTstV5sEeTmwNjppmlfAbdvX+BrDm3GqG8OK0vAdVTgt2KM/73Lilk3hBb
         MaHdU8aTPgunUuzcdCFWU96rZP6ujD4iORQZidXzkZ6L3thNwT9MDq53i2M9QGMAWd5y
         SdTHPge5DyFSSdJXFZx/UY6fX29pgV1Ar4FlDQEtwPdxgexgBbN5bCOqB7Yj9PUvJK4Z
         UD666kuGXIh8aM2aTO88ErtQ+p2v4pFt03NMJxANn5VWD7kntlrD+hpi7fDw7fXlkTSL
         lDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AkH8G74nuWliFsm56RBshmsnPHnGtaW2iQYxsG6KvQw=;
        b=UMG/GI+brPFN4LxcQr7GtRI9pWFG6DXEO+oPU7Lzc6bq5DcqrHlEjNamK0Sry63RQc
         IyCa6VMtRnYuQselyd2pAsJWwZA2Wf35Wn96hl2qXnMoh2pLuYoFqBl5eBIAx/4NMh/m
         mce/Slc+7I9n8Gt4jTkNDEniSwE7MDBYc5vWevdf3VxliVAm8N16orgS5RW5r6cwCop9
         PyNmEB2cq9iPhoUp7iXoQyEPyetXBVSViVEiV+UcZP7iI8jb1jVSk+w5Th7Z+pukkup3
         rN9yBNlZ0ZV2zAW/CQfnKqiFSQQE7p8prAYOWNnVCLwKSBJuRGfnRUGiZKlgzaUDEre0
         B2QA==
X-Gm-Message-State: AOAM533PIooyOswHXLLUsfYKBSl8Q7siEqEe8VYOSLsQPhl7/arBDOFg
        ixqTts9B/Co4IB/IAsrDZ08=
X-Google-Smtp-Source: ABdhPJydqKflGOi1hge6N+O2b3mSxiXuASG9UA2XUCgDxjYLtu6lIBMKfmCnDSSHCzjQQZ+uk1Qx9A==
X-Received: by 2002:a63:4f42:: with SMTP id p2mr36200370pgl.381.1639077959882;
        Thu, 09 Dec 2021 11:25:59 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id pc1sm11107656pjb.5.2021.12.09.11.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:25:58 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: Skip crashdumper state if GPU needs_hw_init
Date:   Thu,  9 Dec 2021 11:31:13 -0800
Message-Id: <20211209193118.1163248-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

I am seeing some crash logs which imply that we are trying to use
crashdumper hw to read back GPU state when the GPU isn't initialized.
This doesn't go well (for example, GPU could be in 32b address mode
and ignoring the upper bits of buffer that it is trying to dump state
to).

I'm not *quite* sure how we get into this state in the first place,
but lets not make a bad situation worse by triggering iova fault
crashes.

While we're at it, also add the information about whether the GPU is
initialized to the devcore dump to make this easier to see in the
logs (which makes the WARN_ON() redundant and even harmful because
it fills up the small bit of dmesg we get with the crash report).

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 9 ++++++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     | 1 -
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index bdd0059a81ff..55f443328d8e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -49,6 +49,8 @@ struct a6xx_gpu_state {
 	s32 hfi_queue_history[2][HFI_HISTORY_SZ];
 
 	struct list_head objs;
+
+	bool gpu_initialized;
 };
 
 static inline int CRASHDUMP_WRITE(u64 *in, u32 reg, u32 val)
@@ -1001,7 +1003,8 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 	 * write out GPU state, so we need to skip this when the SMMU is
 	 * stalled in response to an iova fault
 	 */
-	if (!stalled && !a6xx_crashdumper_init(gpu, &_dumper)) {
+	if (!stalled && !gpu->needs_hw_init &&
+	    !a6xx_crashdumper_init(gpu, &_dumper)) {
 		dumper = &_dumper;
 	}
 
@@ -1018,6 +1021,8 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 	if (snapshot_debugbus)
 		a6xx_get_debugbus(gpu, a6xx_state);
 
+	a6xx_state->gpu_initialized = !gpu->needs_hw_init;
+
 	return  &a6xx_state->base;
 }
 
@@ -1246,6 +1251,8 @@ void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 	if (IS_ERR_OR_NULL(state))
 		return;
 
+	drm_printf(p, "gpu-initialized: %d\n", a6xx_state->gpu_initialized);
+
 	adreno_show(gpu, state, p);
 
 	drm_puts(p, "gmu-log:\n");
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 47cb40bdbd43..f33cfa4ef1c8 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -504,7 +504,6 @@ int adreno_gpu_state_get(struct msm_gpu *gpu, struct msm_gpu_state *state)
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	int i, count = 0;
 
-	WARN_ON(gpu->needs_hw_init);
 	WARN_ON(!mutex_is_locked(&gpu->lock));
 
 	kref_init(&state->ref);
-- 
2.33.1

