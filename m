Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC14BC9DA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242838AbiBSSdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:33:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242395AbiBSSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:33:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04163FD86;
        Sat, 19 Feb 2022 10:32:53 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso11411063pjl.4;
        Sat, 19 Feb 2022 10:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ho+ShHSlRTiwiHcCktxOaPTKqD2bl9+yC4MofqkpwpY=;
        b=giFCShna2q/R17eoMXv6LwCithIiEpJbvhl6Yx4tbCRFrA0ZXvwkd15ms6ZHmqWWzz
         YA+aQbQw2a3dX2rvOWIfHsGHB/SFrIZQX8k6Z7zJrSMkmLH6gSgvHDBfZwvNtvZZOnSJ
         EEysyM5S2RGNWrnbM+8BbFy3b+098oK9ljiAhrQBEgfCSL0rKCgUsDFYE2+bWzMAGtwi
         agEco/RtWHtzPiHo17M9MIbtYUjzkJ6v7he4nWl1b414Yq113hsgDeH/bm+kk8HXBksm
         /ZGR1/U/YiQRXGKp7a9oU69Mw7sPhrKghOvxpneJmrov+mafQZ8vxePwG53Fe2EMtFEV
         7i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ho+ShHSlRTiwiHcCktxOaPTKqD2bl9+yC4MofqkpwpY=;
        b=pIu+t3BmVJfy4xAgJC8ui3EDhHqQXETmC6N7t1+1ZZfG0tiKpj4E+IJmX0x/yrKpdo
         D1axqqhx63MiLeuHegHtQettLGc/84kjd5mY6AIPfXtNiRZpsF1wgP/kJ0jY5n3qzE53
         dRVo4gnLhrbNTjjBNQMQnqMtvz5Gr7D3rypAGFjZAMR0dpDqpEk562wkLqw2dwJ5Hk/K
         u21x5KX5Fgd2qUal5YKvpIAO0709RiiJdinWiJsx6s3bXdWilP8nipgZeh0Es/Yns//z
         XBYBS3Ov/wDPe5R1g0ul1JFM4jp2hSf64vXsJ6wAN68Nr8Y/uEbu8S8XzFh3+c9gpVTH
         v/DA==
X-Gm-Message-State: AOAM530TOT8OsmHqfz+j5tUsHaMLSr8EgJ+usiFJbqdAEpmp9InjdyMM
        nleTIcDjUOQ+Kjh+P0LvRCk=
X-Google-Smtp-Source: ABdhPJzcLjLhI9T6Bv/5mPlgmypgthYLZzt+55Wz3I3DeyDSYTitxUVAdEplMyFb1VFIugqIWtpX4A==
X-Received: by 2002:a17:902:b60e:b0:14d:7a55:2efb with SMTP id b14-20020a170902b60e00b0014d7a552efbmr12623201pls.124.1645295573393;
        Sat, 19 Feb 2022 10:32:53 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id h5sm7428494pfi.18.2022.02.19.10.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 10:32:52 -0800 (PST)
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
Subject: [PATCH] drm/msm/gpu: Fix crash on devices without devfreq support
Date:   Sat, 19 Feb 2022 10:33:10 -0800
Message-Id: <20220219183310.557435-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 31 +++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 9bf319be11f6..26a3669a97b3 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -83,12 +83,17 @@ static struct devfreq_dev_profile msm_devfreq_profile = {
 static void msm_devfreq_boost_work(struct kthread_work *work);
 static void msm_devfreq_idle_work(struct kthread_work *work);
 
+static bool has_devfreq(struct msm_gpu *gpu)
+{
+	return !!gpu->funcs->gpu_busy;
+}
+
 void msm_devfreq_init(struct msm_gpu *gpu)
 {
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 
 	/* We need target support to do devfreq */
-	if (!gpu->funcs->gpu_busy)
+	if (!has_devfreq(gpu))
 		return;
 
 	dev_pm_qos_add_request(&gpu->pdev->dev, &df->idle_freq,
@@ -149,6 +154,9 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
 {
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 
+	if (!has_devfreq(gpu))
+		return;
+
 	devfreq_cooling_unregister(gpu->cooling);
 	dev_pm_qos_remove_request(&df->boost_freq);
 	dev_pm_qos_remove_request(&df->idle_freq);
@@ -156,16 +164,24 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
 
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
@@ -185,6 +201,9 @@ void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor)
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 	uint64_t freq;
 
+	if (!has_devfreq(gpu))
+		return;
+
 	freq = get_freq(gpu);
 	freq *= factor;
 
@@ -207,7 +226,7 @@ void msm_devfreq_active(struct msm_gpu *gpu)
 	struct devfreq_dev_status status;
 	unsigned int idle_time;
 
-	if (!df->devfreq)
+	if (!has_devfreq(gpu))
 		return;
 
 	/*
@@ -253,7 +272,7 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
 {
 	struct msm_gpu_devfreq *df = &gpu->devfreq;
 
-	if (!df->devfreq)
+	if (!has_devfreq(gpu))
 		return;
 
 	msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
-- 
2.34.1

