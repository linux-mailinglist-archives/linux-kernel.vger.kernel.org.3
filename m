Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959955818EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiGZRu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiGZRuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:50:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6422E9F3;
        Tue, 26 Jul 2022 10:50:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y1so5975667pja.4;
        Tue, 26 Jul 2022 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlC/bVN5qW7CT1CMAFt2x0HFIxhESZPM94joMv7rafM=;
        b=lXzjdsN32PhXqkrDLodQJiYabdGeabKkfzQw1VensvYY1zJOOS+QEI5YyIRMhNGXoT
         pHs/GX36xmorY938XjuhMWxgHapdStKjxc289lF7EIOEbFx7NWzbu7izN6YpbK27tM77
         korn4gG6q/X7QuvP9NSnmbo3d6F1cJeaOndpp/hlgXAbzFP8AUAwj/gunScewd9eRjn5
         hvk/4/JXE/oDBqn1vmDVE3as2y5TUNL2nQdJdcRyCATMZsEqTpFsSYG3wBX0xCvPejPe
         EpZhinW2oUmKok498uzkg/5RHQFa+U8vP/bn/tO3w84V+rQgGz4k2evkZl4+5iC6WJvV
         0pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlC/bVN5qW7CT1CMAFt2x0HFIxhESZPM94joMv7rafM=;
        b=wuyns9t75x3F7Si770jQAzmwpDlV8JjbOG2XDDSaSBZO84LpJBykq/y1ixoLgFOOy8
         DkvxsAhmODbX6jjkE3KP3LOlXMMH/ppLpai0WV5nanhI8bPYTFnjXOg0j2kGg/XAlOPM
         uppAE0WlJ8CELT3gTB7s6UbErrFaH8nvj93hKBBaeYimjidzkrL/ogcgJNGu/9bMsr3H
         JbgEqL+TwMiL7o+JcSAN79vzdHIMbvMOU22PboTn2XuoIEkYQwUnkBw1yUWakEX7Ywet
         Gz3f+x4XdlR8OQnj/tsE86+/fOexGPxWjTZM4bYb2dehfqMRy+FJ2TTEpeUxpF8mzTa1
         3ZrQ==
X-Gm-Message-State: AJIora+H04RIMHNzWI284IhgbS2OThigZSZPcqv8Ka9fVWysH4e9gF3u
        4j8HnoLhJRQxjDBGWA0OFZxaYg+ZOdM=
X-Google-Smtp-Source: AGRyM1vtvmbQYKQSy+Mtk23u2rAW4+pzs19Ai61kLpJPH1d+hFu89+tHRwM1n6n8Db3xSRKvHSMzmQ==
X-Received: by 2002:a17:902:ce8c:b0:16c:4be6:2536 with SMTP id f12-20020a170902ce8c00b0016c4be62536mr18100600plg.41.1658857820715;
        Tue, 26 Jul 2022 10:50:20 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b0016d6a471352sm5934135plg.6.2022.07.26.10.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:50:19 -0700 (PDT)
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
Subject: [PATCH v3 02/15] drm/msm: Small submit cleanup
Date:   Tue, 26 Jul 2022 10:50:26 -0700
Message-Id: <20220726175043.1027731-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220726175043.1027731-1-robdclark@gmail.com>
References: <20220726175043.1027731-1-robdclark@gmail.com>
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

