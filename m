Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F8488510
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiAHRnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiAHRnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:43:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE1EC061746;
        Sat,  8 Jan 2022 09:43:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so10820217pji.3;
        Sat, 08 Jan 2022 09:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ICsCpVLEUVmCQJoR3FiShTO8fbKm/U8/ekB8Jz2QGI=;
        b=duIxRD681jGxbZtbxAjkijAXRws7Isk96YI5RuN3WdFwU9EujJxBKG23k1pSyf0pZ+
         /WS3RW3lU/vBXb/tvdlwr5E1Q7oOV+ASKijQzKHBXOlXKeYuMntlhI8Kip2ionkmF0Fm
         DrIi14tTcrOW4e4xnafjG+563wh0f+L28TF7OQnukQygOjqsz+rUZoFdNFqtjlQ3z4ks
         CodP9E7op8jf4izk5Hfb0WlffjmvbX6+ctUmBm+Q2y3fQ5xFB8bjNEypj/AcZQ4A8M9B
         bXTNnNHxgyCnDNHhHM0X/4IwgGD1mOFO3JBurQSblJrDAXg42KU13TGk/EFF0OsI1Tto
         prEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ICsCpVLEUVmCQJoR3FiShTO8fbKm/U8/ekB8Jz2QGI=;
        b=fsq1OnDwAXcDyUOR62ihTjZLaMGIAUhfOMe7G3DsLAuk5G7/wNyzXB2NSkLWBJ37Hr
         wolCzXfwM4ggEcdGYtYdKY+Jf73NShdOgEJx7aa6gYLW3AETwfhg1j3CZuNvKpvwB23/
         HYwL+99wk0+2UU19AbDPQpq0lykEcc8ew6a1c7ZmLLKdS6HAKbcxGwpbmKlipx7GLcTw
         rAJIfu0xee2WmUecIb9U1FEXZEsfsZjtSplLPUbMuICqY+QUcK6Y/uGItBtl+Cmx+BWE
         Eip8idMwbFeaWGf4SFi6PlLNMQFheVdGhS6fpE3ppSJz9WWeFLEQ8/aCTOdJY2zOJWwY
         blJw==
X-Gm-Message-State: AOAM533VEPdWbI/WbxhKg2/Pp6va+wig/blpXdE4CHfmsylLO0pkuSI5
        SbKcTx+HoD6L5HHajAK607w=
X-Google-Smtp-Source: ABdhPJzekASgi4oEnbLVoWwPftexK59nXAM7GtBGPgWq3ZioqjNjB0ehb3p1uMfrNvHhTeEtAkhfcQ==
X-Received: by 2002:a17:902:6948:b0:149:f187:e601 with SMTP id k8-20020a170902694800b00149f187e601mr12161547plt.81.1641663779948;
        Sat, 08 Jan 2022 09:42:59 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id z13sm2032943pgi.75.2022.01.08.09.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 09:42:59 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/msm/gpu: Cancel idle/boost work on suspend
Date:   Sat,  8 Jan 2022 09:42:47 -0800
Message-Id: <20220108174249.811872-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220108174249.811872-1-robdclark@gmail.com>
References: <20220108174249.811872-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

With system suspend using pm_runtime_force_suspend() we can't rely on
the pm_runtime_get_if_in_use() trick to deal with devfreq callbacks
after (or racing with) suspend.  So flush any pending idle or boost
work in the suspend path.

v2: s/ret/remaining [sboyd], and switch to using active_submits count
    to ensure we aren't racing with submit cleanup (and devfreq idle
    work getting scheduled, etc)

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 62405e980925..9bf319be11f6 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -133,6 +133,18 @@ void msm_devfreq_init(struct msm_gpu *gpu)
 			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 }
 
+static void cancel_idle_work(struct msm_gpu_devfreq *df)
+{
+	hrtimer_cancel(&df->idle_work.timer);
+	kthread_cancel_work_sync(&df->idle_work.work);
+}
+
+static void cancel_boost_work(struct msm_gpu_devfreq *df)
+{
+	hrtimer_cancel(&df->boost_work.timer);
+	kthread_cancel_work_sync(&df->boost_work.work);
+}
+
 void msm_devfreq_cleanup(struct msm_gpu *gpu)
 {
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
@@ -152,7 +164,12 @@ void msm_devfreq_resume(struct msm_gpu *gpu)
 
 void msm_devfreq_suspend(struct msm_gpu *gpu)
 {
-	devfreq_suspend_device(gpu->devfreq.devfreq);
+	struct msm_gpu_devfreq *df = &gpu->devfreq;
+
+	devfreq_suspend_device(df->devfreq);
+
+	cancel_idle_work(df);
+	cancel_boost_work(df);
 }
 
 static void msm_devfreq_boost_work(struct kthread_work *work)
@@ -196,7 +213,7 @@ void msm_devfreq_active(struct msm_gpu *gpu)
 	/*
 	 * Cancel any pending transition to idle frequency:
 	 */
-	hrtimer_cancel(&df->idle_work.timer);
+	cancel_idle_work(df);
 
 	idle_time = ktime_to_ms(ktime_sub(ktime_get(), df->idle_time));
 
-- 
2.33.1

