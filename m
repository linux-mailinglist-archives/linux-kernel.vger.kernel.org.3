Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C513A587F49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiHBPve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbiHBPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:51:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6718382;
        Tue,  2 Aug 2022 08:51:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so15806298pjl.0;
        Tue, 02 Aug 2022 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FlC/bVN5qW7CT1CMAFt2x0HFIxhESZPM94joMv7rafM=;
        b=evbmRmyO/2+6RJ8/YJry12RHQKfHTrzxGc4UpXeZiB+6x6VMHvdsW+Hml5aWSUMWr6
         t1QvkmZTCGcB7M3M73EQ1alGAugs9B4J5K96GjfPpVvWI052CTibRhV+jBuuyp6Rqcx0
         Qaget8gCqyN1xaOimZURmkWthQu6ejcX+f1Hr68GpjrG+zSAuWCfFuqrNVXEiwJ4FlV7
         gkk5U5eOoIqBe+YN4DC1BwjZBbuqzu8VuK51rYMuBXgloD+TokdPWEraW64oSx1epTk2
         VOiB0RubwU0c/j6l1y35t2UHpPhp6KKkwMnL8raxTZm70tgINrIi8Hd9w61dv4uYXZxX
         v77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FlC/bVN5qW7CT1CMAFt2x0HFIxhESZPM94joMv7rafM=;
        b=zNKNQvMxIaPtdV2+tbjd28v6HTOdLAHXXCtS6kGmR0Mvpqo5FlG8SaO/ci5wO/BPGC
         07p8ibhS2ksbZcZ9jekb24YrQyOFpeFdwGry+kDDBeHsX4YFnsWt+TkwwyzDySkKtXlW
         CGoimCrcIEconNf7NmOOOnaCtCspgK25Jo3jgPS5uCP/W6igTzgs2z/oPBPLTnfIXRyR
         WAh/5TrlnG10xJ0HgF6WanS55txgWAtnYDKXBZPe5kKYv56sHSNJWrjdC1f3zx2La6tB
         TmCjiPufkfvXOMz1h3ZOlQcVAr2Qn8Tfg2q8AsfvtOvN3nkKQSIBq4+3LpkgqF2XIURN
         9sRw==
X-Gm-Message-State: ACgBeo3JNQ75/6CDICl0s20jjq9bMqR4iR44Ae1dI12ZiMA6bIfZbeZW
        QrWmPDLGpxTv20TMjrKIPw0=
X-Google-Smtp-Source: AA6agR7IYOquDSmc/HYkIRdC61n3AqniQbgtQGM8PmI0u+AJIiq0w4H/Dh1mgtBAyFYSYRq/TrPpiA==
X-Received: by 2002:a17:903:328e:b0:16e:fa5f:37ae with SMTP id jh14-20020a170903328e00b0016efa5f37aemr6936035plb.148.1659455483649;
        Tue, 02 Aug 2022 08:51:23 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902900100b0016c46ff9741sm11905866plp.67.2022.08.02.08.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:51:22 -0700 (PDT)
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
Subject: [PATCH v4 02/15] drm/msm: Small submit cleanup
Date:   Tue,  2 Aug 2022 08:51:35 -0700
Message-Id: <20220802155152.1727594-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220802155152.1727594-1-robdclark@gmail.com>
References: <20220802155152.1727594-1-robdclark@gmail.com>
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

