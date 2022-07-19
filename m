Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B2557A4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiGSRSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbiGSRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:18:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BD547BBA;
        Tue, 19 Jul 2022 10:18:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 70so14187544pfx.1;
        Tue, 19 Jul 2022 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlC/bVN5qW7CT1CMAFt2x0HFIxhESZPM94joMv7rafM=;
        b=Lbh9s2g13yWjWLtBl9Kt+y6e/wC7cxwUw0b8qgyetirgPr8MtFwaBiRdowAbjr4uJK
         kTO3y4+wcOAp7ZZF40dQLLcP6evHJT6rG3ScpXx4yRZeYjw2f/bUPOSQ9I4tlWq+FbUC
         eAXROc7sM1ARDls+UL+rhGeVLDi5bWRTAi9S3iyAN154lL7+dpHc8qBylOYj1+c7aCfz
         5cL5ivG+GJKgSb2JtJlLqodYm5cjm/MJv+12se0IFlj+eQeGgORGY5UFbYHX3054Bbfy
         AzYCgxhb7DicKjHDnJbzHY3bRKQD+UEXgVF7goioHti+ZkZb6COpqupPMtDBeJTIYeUX
         RtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlC/bVN5qW7CT1CMAFt2x0HFIxhESZPM94joMv7rafM=;
        b=RwIhrw6oJCvNT4QmtB64j/ZMQTOcIflIEboUm4F25pp1tsYL8DqBNRvUTyjYYz2Voo
         RIyoiv5pd1zek4XuvLwC0eITVfiDDQP0Vgt/bcF0osKJ7aXIqpB1+R91L2aWadk8fnfM
         t8+zUs15Hp47wngO7m5yCOTLZ1Sq6TcXpPBEXbch7tiWHAPE4uJpFY4TL8BiN9qqtDAg
         xl4+h8o5Pxx3EY89oTcJbl82zb+yWIHdsc/nZXtMiOEBrkDVVgthpXncYLnQsb8x+CHk
         WfPHq6aiI57N8IVJ58Rp+FNKw19NRCnV5E2iyFYUrMEaBeqWR8tvw3kdOr9SJChp/vgV
         c94w==
X-Gm-Message-State: AJIora9zcYojKDZ9xFg29aGAMztUjiUYFfDkPdXCQ5W9I2ABvShAvz3p
        PUFfA5kGZ5tBYNc6oy8ikydzrscMchM=
X-Google-Smtp-Source: AGRyM1siWuYUVeXLva8EenGWnt/QaLz7KxaosG9gsqAREN8dt9Zd9ETzrsWVj+JjxqdhNtz0s5msDg==
X-Received: by 2002:a05:6a00:158e:b0:52a:e628:8b3b with SMTP id u14-20020a056a00158e00b0052ae6288b3bmr35372045pfk.80.1658251123786;
        Tue, 19 Jul 2022 10:18:43 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id w13-20020a1709029a8d00b0016a4db13435sm11809538plp.191.2022.07.19.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:18:42 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/13] drm/msm: Small submit cleanup
Date:   Tue, 19 Jul 2022 10:18:46 -0700
Message-Id: <20220719171900.289265-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220719171900.289265-1-robdclark@gmail.com>
References: <20220719171900.289265-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Move more initialization into submit_create().

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index b7c61a99d274..c7819781879c 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -26,6 +26,7 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 		struct msm_gpu_submitqueue *queue, uint32_t nr_bos,
 		uint32_t nr_cmds)
 {
+	static atomic_t ident = ATOMIC_INIT(0);
 	struct msm_gem_submit *submit;
 	uint64_t sz;
 	int ret;
@@ -52,9 +53,13 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 	submit->gpu = gpu;
 	submit->cmd = (void *)&submit->bos[nr_bos];
 	submit->queue = queue;
+	submit->pid = get_pid(task_pid(current));
 	submit->ring = gpu->rb[queue->ring_nr];
 	submit->fault_dumped = false;
 
+	/* Get a unique identifier for the submission for logging purposes */
+	submit->ident = atomic_inc_return(&ident) - 1;
+
 	INIT_LIST_HEAD(&submit->node);
 
 	return submit;
@@ -718,7 +723,6 @@ static void msm_process_post_deps(struct msm_submit_post_dep *post_deps,
 int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
-	static atomic_t ident = ATOMIC_INIT(0);
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_msm_gem_submit *args = data;
 	struct msm_file_private *ctx = file->driver_priv;
@@ -729,10 +733,9 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct msm_submit_post_dep *post_deps = NULL;
 	struct drm_syncobj **syncobjs_to_reset = NULL;
 	int out_fence_fd = -1;
-	struct pid *pid = get_pid(task_pid(current));
 	bool has_ww_ticket = false;
 	unsigned i;
-	int ret, submitid;
+	int ret;
 
 	if (!gpu)
 		return -ENXIO;
@@ -764,12 +767,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (!queue)
 		return -ENOENT;
 
-	/* Get a unique identifier for the submission for logging purposes */
-	submitid = atomic_inc_return(&ident) - 1;
-
 	ring = gpu->rb[queue->ring_nr];
-	trace_msm_gpu_submit(pid_nr(pid), ring->id, submitid,
-		args->nr_bos, args->nr_cmds);
 
 	if (args->flags & MSM_SUBMIT_FENCE_FD_OUT) {
 		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
@@ -783,13 +781,13 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (IS_ERR(submit))
 		return PTR_ERR(submit);
 
+	trace_msm_gpu_submit(pid_nr(submit->pid), ring->id, submit->ident,
+		args->nr_bos, args->nr_cmds);
+
 	ret = mutex_lock_interruptible(&queue->lock);
 	if (ret)
 		goto out_post_unlock;
 
-	submit->pid = pid;
-	submit->ident = submitid;
-
 	if (args->flags & MSM_SUBMIT_SUDO)
 		submit->in_rb = true;
 
-- 
2.36.1

