Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1645486992
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbiAFSPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242633AbiAFSPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:15:10 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7ABC061245;
        Thu,  6 Jan 2022 10:15:10 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t32so3284403pgm.7;
        Thu, 06 Jan 2022 10:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpENl1wlwqcfbBT73rctGeiDbGEPDlZ8miqyZA+HW/A=;
        b=F09yhVw/miHkBPbi4ZUlYr4v+8jysbgt9gi1ewGjNnREmk2R3F7tVzYoSF1tvXfNWH
         unH8PPBeS0TlZp1ZTjWad/PIvqEPdCPWEcvhtXCGPZOzzqwfVq6OXC+LJa1xWijbJPqz
         rwunzxgZsmSP7FEWW9+2s4ldMauj+40newsjGyEzwiHXWbbFYVBBcTBlyI4d5W88lA6D
         O/cIXoglEpASRbpBcm4M6576cHGNv7JcqSXq/WwRYI8n1nEXxwXa/2cFUxB0AHSDKHkj
         8OQIf89HIKCwH+u34JrNSIRCUv+m+DNeFxN2/N4xh6yOSUMzPK1uCcV3EnM+uD35I59y
         b+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpENl1wlwqcfbBT73rctGeiDbGEPDlZ8miqyZA+HW/A=;
        b=0UKw8ToX1P4EUmdfDD5mf4TZvX5uM5h8UXp+PhnTHHyjg0NeljCUQjtTSJJk/etthM
         PxoBTQU9d6pwcZdqcNqniIiBAHTBFcut5/RWQAtoq2PXsLPDnjar9YKI9Ug4d4viz0ST
         0a0jRcYxaM5S7i7mkbeTcMMmGlKtMQEyjbeyC3a5c7WqxcH6PKd3W0UCj5XdNsUrwHxE
         /d/17ucKM4Y4SOrAFoltqbu1rnaQiMh5YtUry2JugDbik4Lx8nh+yeMWDuvrKuV8m+LU
         w9IgCjnncaLcX3YeJ8TFF9EAkNyo2g8bQ+OprnYBid9X+6s3AIQOvWg3lRfPO5qNt2Fy
         hJQA==
X-Gm-Message-State: AOAM533V6oR3oER6QbL4bptrScLqrfmvdLfwT34JrITA8mWmYWHa5VOX
        E0vGcefv5zVocgdXvXAQZus=
X-Google-Smtp-Source: ABdhPJwv7sVVNoZY8rfrc22AsxIsf7vwBPn1hePxXkzE5xqw9FRXjuAwrmj4inJU3E0t7U24/NgRsA==
X-Received: by 2002:a65:4c81:: with SMTP id m1mr54128291pgt.427.1641492910079;
        Thu, 06 Jan 2022 10:15:10 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id c11sm3359333pfv.85.2022.01.06.10.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:15:09 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm/gpu: Cancel idle/boost work on suspend
Date:   Thu,  6 Jan 2022 10:14:47 -0800
Message-Id: <20220106181449.696988-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220106181449.696988-1-robdclark@gmail.com>
References: <20220106181449.696988-1-robdclark@gmail.com>
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

