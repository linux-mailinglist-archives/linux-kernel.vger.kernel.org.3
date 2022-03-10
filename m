Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC43C4D55A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbiCJXqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344840AbiCJXqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:46:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9A319E022;
        Thu, 10 Mar 2022 15:45:40 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a5so6476659pfv.2;
        Thu, 10 Mar 2022 15:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84Raz5JYKVeX/pUi+12Qa70UMUs/NibyW3b6HrH/7lY=;
        b=RIWCIMYLv6fAl3X5yNuGJ/ZhuuVr/0l9TPnu448skU2Fk/3Dd5CxT4a38n+h8IJrI0
         mUL+urptgd7ItaeuQrx16YN3HcVwrGQ5V/P3uZvlhW/2MX2PNw2KgZ9dqjC6ewvNi9Gy
         ssv1VBfyC56RqCVv5L90TaEfFpRctyF+Vwm+Y74O4CCV02XokyiQbjoJF7mAwUUj/yfN
         d/SSBZ5edruXH+IARzrbune3t+cTVvPOSofeG4QygAfOAmyOTZSkrIDOokc8zIVHzR4M
         KdKwn5BULrZW408bbHXjNVZOhh0xJoP4mf5iaZEBbEYnSX6EatPviXdw0oKJMGRyVAC5
         BgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84Raz5JYKVeX/pUi+12Qa70UMUs/NibyW3b6HrH/7lY=;
        b=21TRZO6tAG6D3XNUqdd+g5yzjxcL/Rr2z7oPuOG0B3Gy6btYzYnCHtIfKbPBjeSaJ/
         mqVqQVaXnvnvDpbJHAd8ojgLPb8Eqm4YmAQtqUZ0JYANjIxIQUfgDs6j4VhnBWmyTD2Q
         HfYSCDEgXr8MyxjX7UtLWnl8ZhsMO/TWmSxxWDtb75hPN+jVXk8enDSfSB/AIFLxujpL
         d0xfRx3b5jG5ZVkvb6g7XK5Aea681CeJkTMqOQyPhZR5VOcnfRNttvYewxT9O5A/DobR
         FOtDcY/HoCo9qoZDuQY4bxmgVRjD4vdlGyxmDxiOYxxpXAIAWnKVYiSFvrKx4Hxk1Tf/
         Nqmg==
X-Gm-Message-State: AOAM532mGQd47eEC8vZpeLWMEWzWE8Ku1UB1QwKSm6UFUiKj1Mc03GcP
        ZHQOYNa0eLg+SifRG6/L36o=
X-Google-Smtp-Source: ABdhPJxmw99IW2XBwcSNPKsasjmkkdChoRp9s2QpSC2oczo3xnYQMDiMHz4ROeXE5pNO8L79IYoaTQ==
X-Received: by 2002:a63:28d:0:b0:365:8e16:5c19 with SMTP id 135-20020a63028d000000b003658e165c19mr6158756pgc.579.1646955939174;
        Thu, 10 Mar 2022 15:45:39 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78047000000b004f7299bf685sm7917827pfm.91.2022.03.10.15.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:45:38 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] drm/msm/gpu: Park scheduler threads for system suspend
Date:   Thu, 10 Mar 2022 15:46:05 -0800
Message-Id: <20220310234611.424743-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310234611.424743-1-robdclark@gmail.com>
References: <20220310234611.424743-1-robdclark@gmail.com>
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

In the system suspend path, we don't want to be racing with the
scheduler kthreads pushing additional queued up jobs to the hw
queue (ringbuffer).  So park them first.  While we are at it,
move the wait for active jobs to complete into the new system-
suspend path.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 68 ++++++++++++++++++++--
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 8859834b51b8..0440a98988fc 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -619,22 +619,82 @@ static int active_submits(struct msm_gpu *gpu)
 static int adreno_runtime_suspend(struct device *dev)
 {
 	struct msm_gpu *gpu = dev_to_gpu(dev);
-	int remaining;
+
+	/*
+	 * We should be holding a runpm ref, which will prevent
+	 * runtime suspend.  In the system suspend path, we've
+	 * already waited for active jobs to complete.
+	 */
+	WARN_ON_ONCE(gpu->active_submits);
+
+	return gpu->funcs->pm_suspend(gpu);
+}
+
+static void suspend_scheduler(struct msm_gpu *gpu)
+{
+	int i;
+
+	/*
+	 * Shut down the scheduler before we force suspend, so that
+	 * suspend isn't racing with scheduler kthread feeding us
+	 * more work.
+	 *
+	 * Note, we just want to park the thread, and let any jobs
+	 * that are already on the hw queue complete normally, as
+	 * opposed to the drm_sched_stop() path used for handling
+	 * faulting/timed-out jobs.  We can't really cancel any jobs
+	 * already on the hw queue without racing with the GPU.
+	 */
+	for (i = 0; i < gpu->nr_rings; i++) {
+		struct drm_gpu_scheduler *sched = &gpu->rb[i]->sched;
+		kthread_park(sched->thread);
+	}
+}
+
+static void resume_scheduler(struct msm_gpu *gpu)
+{
+	int i;
+
+	for (i = 0; i < gpu->nr_rings; i++) {
+		struct drm_gpu_scheduler *sched = &gpu->rb[i]->sched;
+		kthread_unpark(sched->thread);
+	}
+}
+
+static int adreno_system_suspend(struct device *dev)
+{
+	struct msm_gpu *gpu = dev_to_gpu(dev);
+	int remaining, ret;
+
+	suspend_scheduler(gpu);
 
 	remaining = wait_event_timeout(gpu->retire_event,
 				       active_submits(gpu) == 0,
 				       msecs_to_jiffies(1000));
 	if (remaining == 0) {
 		dev_err(dev, "Timeout waiting for GPU to suspend\n");
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 
-	return gpu->funcs->pm_suspend(gpu);
+	ret = pm_runtime_force_suspend(dev);
+out:
+	if (ret)
+		resume_scheduler(gpu);
+
+	return ret;
 }
+
+static int adreno_system_resume(struct device *dev)
+{
+	resume_scheduler(dev_to_gpu(dev));
+	return pm_runtime_force_resume(dev);
+}
+
 #endif
 
 static const struct dev_pm_ops adreno_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(adreno_system_suspend, adreno_system_resume)
 	SET_RUNTIME_PM_OPS(adreno_runtime_suspend, adreno_runtime_resume, NULL)
 };
 
-- 
2.35.1

