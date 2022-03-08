Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28764D2068
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349163AbiCHStG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiCHStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:49:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE9549FB0;
        Tue,  8 Mar 2022 10:48:08 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d187so126278pfa.10;
        Tue, 08 Mar 2022 10:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kmwLyD/dNxW2RzhMW7TqKOPG19gcSG2VPjcZNJ8YJ7Y=;
        b=bBIeKK1bY+Eml8HcFIdHzNO9ls55ISByO+JR0/BKyKu7ETxiYU3wfkI+0nbsk12IeQ
         5LuDr9byAG4cZqgYdhaG6837t8v3xiTAufKyikjiVybPJ799E2pWHiXMbNTjTIp0a+iN
         KFveCYukqhXiBR9nlyEmoNxkT6j0F6SqRXU8QH01YNwaq5Cg5uyE09Ygt9XYV5SxD/oE
         kzzItxxjQDnQBV8jHhCjfIDR/l9j54XGRfFs1zqt9DEflfadd9Ahn1XN/u+RIJtucfHf
         hJhCIWNB4vAcRnI7W/ZPoDrp5yfwbZcdA04VWqt7CNq/bEjW1QpXLUqtRmfHqRFd3rPL
         JgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kmwLyD/dNxW2RzhMW7TqKOPG19gcSG2VPjcZNJ8YJ7Y=;
        b=CqxkiwD0F5nuJaa74WnBG/C53g9rsKdbt3/yIMTkWvHk0i38D1nS42yUKfGe5nJDh8
         fiWRnvxaYKDWLqUrozzbEVwmswmINopqGdRjeW5S2bT3PJwXo8kLRpxMI3PqwyiUk/A+
         fppsfvp/VsiXdlJA6d5qmY8hcg6Z/wpa/k6vTpiukiX4yrpUABXNv/T2cwkzT3P44OTl
         yTyGY052XvqkRhRL95IRxF8teJioWPsbehCBglafnhUGaSo50qj5BRKXJA1jx4ZKzOPH
         U6D3F7EID1SScXtUIqd1UCKY2TT2FsRsyeOYpiUApCjsKqmpgGKC+CVwXc9EzdrXqs34
         oEJA==
X-Gm-Message-State: AOAM533Z55wOQKYJYpGUPYCMwkfu6hO9/0JVOSZFGsba3IFbciu+uSKj
        q8sriclrOTLF2uTARLm72fg=
X-Google-Smtp-Source: ABdhPJy/k9PqwomI4wEWKZQhIW9f3ebpWevqKdxPWSDsy/ybougbJzb+jzvMb97y/bbV6CrPIntPgw==
X-Received: by 2002:a05:6a00:ad0:b0:4e1:2d96:2ab0 with SMTP id c16-20020a056a000ad000b004e12d962ab0mr19664621pfl.3.1646765287869;
        Tue, 08 Mar 2022 10:48:07 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id d15-20020a056a00198f00b004f7109da1c4sm7129643pfl.205.2022.03.08.10.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:48:06 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/gpu: Fix crash on devices without devfreq support (v2)
Date:   Tue,  8 Mar 2022 10:48:44 -0800
Message-Id: <20220308184844.1121029-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Avoid going down devfreq paths on devices where devfreq is not
initialized.

v2: Change has_devfreq() logic [Dmitry]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 30 ++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 9bf319be11f6..12641616acd3 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -83,6 +83,12 @@ static struct devfreq_dev_profile msm_devfreq_profile = {
 static void msm_devfreq_boost_work(struct kthread_work *work);
 static void msm_devfreq_idle_work(struct kthread_work *work);
 
+static bool has_devfreq(struct msm_gpu *gpu)
+{
+	struct msm_gpu_devfreq *df = &gpu->devfreq;
+	return !!df->devfreq;
+}
+
 void msm_devfreq_init(struct msm_gpu *gpu)
 {
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
@@ -149,6 +155,9 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
 {
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 
+	if (!has_devfreq(gpu))
+		return;
+
 	devfreq_cooling_unregister(gpu->cooling);
 	dev_pm_qos_remove_request(&df->boost_freq);
 	dev_pm_qos_remove_request(&df->idle_freq);
@@ -156,16 +165,24 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
 
 void msm_devfreq_resume(struct msm_gpu *gpu)
 {
-	gpu->devfreq.busy_cycles = 0;
-	gpu->devfreq.time = ktime_get();
+	struct msm_gpu_devfreq *df = &gpu->devfreq;
 
-	devfreq_resume_device(gpu->devfreq.devfreq);
+	if (!has_devfreq(gpu))
+		return;
+
+	df->busy_cycles = 0;
+	df->time = ktime_get();
+
+	devfreq_resume_device(df->devfreq);
 }
 
 void msm_devfreq_suspend(struct msm_gpu *gpu)
 {
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 
+	if (!has_devfreq(gpu))
+		return;
+
 	devfreq_suspend_device(df->devfreq);
 
 	cancel_idle_work(df);
@@ -185,6 +202,9 @@ void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor)
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 	uint64_t freq;
 
+	if (!has_devfreq(gpu))
+		return;
+
 	freq = get_freq(gpu);
 	freq *= factor;
 
@@ -207,7 +227,7 @@ void msm_devfreq_active(struct msm_gpu *gpu)
 	struct devfreq_dev_status status;
 	unsigned int idle_time;
 
-	if (!df->devfreq)
+	if (!has_devfreq(gpu))
 		return;
 
 	/*
@@ -253,7 +273,7 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
 {
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 
-	if (!df->devfreq)
+	if (!has_devfreq(gpu))
 		return;
 
 	msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
-- 
2.35.1

