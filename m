Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199C955AD28
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiFYWzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiFYWzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:55:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EE313F44;
        Sat, 25 Jun 2022 15:55:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n10so5154606plp.0;
        Sat, 25 Jun 2022 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlC/bVN5qW7CT1CMAFt2x0HFIxhESZPM94joMv7rafM=;
        b=X0G2+tO3s8rijlHOZIm1HqX03Z7oJO9LhxGV9D2UTWjUAuxQ0r+Lyl5m3687mFL5Fv
         Ne52zwkO4YtHqPz7CTayfcV6kpclelKzUKINgRk2OD958fS2561i3yIgq+IXzcuEctrg
         rXa4otRJrRVbLEb079Gx3zKy8rNlKr4zJaQrVfl8ZEPQYRYp+QopjenMIvkzdtZjTBB7
         fYJiznLUULZepXiCoGoJFmV0AcEQ80i4Z6YSBbB5C7AB2RFmGAuh8tqc9+EeyGPC/sb4
         6SIkuDddhiIXVnThZJUnPybChTjKJ3ENZkvRR/C0kYGPLOi9OwP9QSIqvH7bstMx7E3T
         4LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlC/bVN5qW7CT1CMAFt2x0HFIxhESZPM94joMv7rafM=;
        b=OxBkEvu25ybg3Nr2EuhvELG2IWsurUq3B46j0LYkxk3WELySkXyO4Z/kK2AMznWEjW
         Kebi0a73msem+/e508/6LGI2dqy0NlLYrARQyxnbaaBhHRhbjXFUipgGf822mdVo9xxT
         okKrvgx8S1qulo+Q0oQ99MZ6xhBVF3Vitau1+MEMd/vMMbH0GuYpGIDWgKEGogYyS8OL
         TBJiv0PgSjxPIxi6fi58Cdf6uIh8DhpWoJMatt61M8Ei9PNkLiF8LHV5i5HGiZnEG99B
         wkaI42tlVmXtxXvuwpNzQQThVAUHE5uHNPvcPAbn6RqHoQ5Nqa+FnVKCRmBmfZbXYsjX
         qYww==
X-Gm-Message-State: AJIora8f3TmPWXDOXFintqwKrwc3Gcq/lhGYkarhBGQWJlfNa/zBySXY
        c5l/gOaPjuaiHCa+fQKMA+E=
X-Google-Smtp-Source: AGRyM1sCNGUFjm7dseoYys3hDPOUoh/GsGPOqE8zXpR/MxJHMeyjmk6Ct5u0YvcxwgnfIEAHnCIFyw==
X-Received: by 2002:a17:90b:1bc5:b0:1e3:3c67:37bf with SMTP id oa5-20020a17090b1bc500b001e33c6737bfmr6618252pjb.87.1656197707905;
        Sat, 25 Jun 2022 15:55:07 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id k22-20020a170902761600b00167942e0ee9sm4215566pll.61.2022.06.25.15.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:55:06 -0700 (PDT)
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
Subject: [PATCH 04/15] drm/msm: Small submit cleanup
Date:   Sat, 25 Jun 2022 15:54:39 -0700
Message-Id: <20220625225454.81039-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625225454.81039-1-robdclark@gmail.com>
References: <20220625225454.81039-1-robdclark@gmail.com>
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

