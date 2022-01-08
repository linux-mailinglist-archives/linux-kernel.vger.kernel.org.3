Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17D488542
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 19:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiAHSJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 13:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiAHSJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 13:09:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6719C06173F;
        Sat,  8 Jan 2022 10:09:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id hv15so1844920pjb.5;
        Sat, 08 Jan 2022 10:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpENl1wlwqcfbBT73rctGeiDbGEPDlZ8miqyZA+HW/A=;
        b=Dadc/cXPO0Uubd/3MkatQs1U4WERUA3XCupDgrJmGVsJIwvpDXnqEeetn63+ka7T6Z
         QJYYtuWQ5Gyrir8ulQHyjWOX0EnHqHvClV0uivmDk7DPOB7iZRL6wlcZIglDpjtOJ1su
         +W99NY5LlfFCa7TGy62ZQFZTX88A0anOL/loyhDqYjjitMGy92fcAVjzSMnBVdlt7yDE
         94MyLMx/eNiHmh8ipu6YCC6PkDl1WMt9c9uXODNhAR5deTV37UvygLEdopJp7mibuvN6
         knAv7q0CKzIOYCT7fetCaRQb7VFAyZT45H84lTcSs7ZqxIxoj3u2UdaLqu3DiBYylpPp
         iPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpENl1wlwqcfbBT73rctGeiDbGEPDlZ8miqyZA+HW/A=;
        b=a1FxggYFVw4/snXtsPwtSefNrM8v7bmcmFwMMafr9w0sMVi8Xg49irY4B/GLJMaRFh
         wkkXDlD82u1Zsbm3nGsaZnx6ke+AfHlGHEu/zfPZb7bunDSSGnW3jAKwMmAp0nq3zgVh
         TyxfP+FIf1KDEiGenwHpc6D+6BmU6FnBJyk2AdHWXjqOh9UAWlpPnykxYLQ1EatPa5a7
         nFvqRFbCBNcxcFT6zEmhHQlhKVhwUK1nAzXPMK4cncRMnAxMPzE/ZZri047O8x8yVPQG
         stM7zVt05892iwHl2HxKRMY6EysykcYsHD8NDivd3Xzg0G3YlEj5IjuFsZnBBAh1glq0
         Rqaw==
X-Gm-Message-State: AOAM532ajfDdyjMFK1ICNY2+lwyTDYtX8Jp6GMjNsGMwHJyGtUY6CsKj
        PEFbNvCC6MZ50OiqYTwS8K4=
X-Google-Smtp-Source: ABdhPJx4ZDShbND64UCj+uvq1tWaXe/Sn2QWDwmlo3FJc5MoNWsmz0nVsKR3UQiVl1O+Xbl8i6SO9g==
X-Received: by 2002:a17:902:e749:b0:148:f083:3905 with SMTP id p9-20020a170902e74900b00148f0833905mr68561286plf.136.1641665369257;
        Sat, 08 Jan 2022 10:09:29 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id ng7sm2564668pjb.41.2022.01.08.10.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 10:09:28 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] drm/msm/gpu: Cancel idle/boost work on suspend
Date:   Sat,  8 Jan 2022 10:09:11 -0800
Message-Id: <20220108180913.814448-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220108180913.814448-1-robdclark@gmail.com>
References: <20220108180913.814448-1-robdclark@gmail.com>
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

