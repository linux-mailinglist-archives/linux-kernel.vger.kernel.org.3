Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C1953CA17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbiFCMhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiFCMhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:37:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E433A5E0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:37:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h19so10015087edj.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YrBwkRdvXLz7+jm3aOsGJs/0ErMfrv6pPp4W4cTpnsc=;
        b=lU6T2dV5ri5pmTMT6Mbiz1EQgTQhwZGxrRXAYVWfB5NmV8ZqAZj9v9QPOohoodr0b1
         79uyw1nq5zUmUdfya6dlH9RnoKW5316fqsCHXRZO4YgZM0zFDcwgyKdQzdl/fpMQkI9d
         eKjXAUS92LFIE+J0QlN+0m9sz2DLQsgM/tEGCa4Dfx/qwcVBRhtpue7pTyxslSjB/A1w
         o8jvBKpdYsQrusdrRo48AuRFgCFS+SPbyht3s+oOM+tQtiduLwZYb6rFFPEnzOI8Bg5B
         tFcIl99IE0mJ1/e6i1Fc562Zznby3G/gTt4XNAGyJTWbwernPIWzLeNRSi8H8U+1FHoc
         JrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YrBwkRdvXLz7+jm3aOsGJs/0ErMfrv6pPp4W4cTpnsc=;
        b=1fg62EEM4JTADwNZHZpAEjU1FJWYbChFEQtud1HQppjZ/cP5KfQJHLyMAXQ8b4iPQ/
         JKOYXWHpPzU6Qubu5BqtfCa9gYn5JRwYQdnMvvgMZiUqjlnPq9KnxYo4Zb/a/5Q0WYFb
         aUGwSL9CTjIo3xehymBAty3pyVQ1JLIUH31AfQrtJTz/uYdG0+P+rtWIws6q7LaF0tQ3
         CxJMjL/iwpwYFIC0M9N0eBdSewchB3lf5eJi8LD+NUWLNthADZwMVMesJMTzb/axHMHr
         jeLsqlyeXfg1/Wloc1qeCi1NuPpfmfaX2xIZGLXguBy9hX1ShaY0JdyoZqqBzTEsT2V5
         k4Rw==
X-Gm-Message-State: AOAM532RFUp0hlG+jfDq1nBQFKMOaSOAocz1T34jfqxWbgSp7boIbeG6
        uFMcMTou84uVjWeGdzUc7owa2HIWed0=
X-Google-Smtp-Source: ABdhPJxeCabJNbfYESsSsGF42ubf1R5Slv0JDKE/9PlNrQtqy1GE4Zsa18k3wAnt2ZmtPBrmuSNsjA==
X-Received: by 2002:a05:6402:4410:b0:427:ab6f:a39a with SMTP id y16-20020a056402441000b00427ab6fa39amr10621435eda.120.1654259867780;
        Fri, 03 Jun 2022 05:37:47 -0700 (PDT)
Received: from localhost.localdomain.info (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906660c00b0070e3f58ed5csm716120ejp.48.2022.06.03.05.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:37:47 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP)
Subject: [PATCH] drm/etnaviv: print offender task information on hangcheck recovery
Date:   Fri,  3 Jun 2022 14:37:05 +0200
Message-Id: <20220603123706.678320-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Track the pid per submit, so we can print the name and cmdline of
the task which submitted the batch that caused the gpu to hang.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.h        |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |  6 ++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c        | 18 +++++++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h        |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c      |  2 +-
 5 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
index 63688e6e4580..baa81cbf701a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
@@ -96,6 +96,7 @@ struct etnaviv_gem_submit {
 	int out_fence_id;
 	struct list_head node; /* GPU active submit list */
 	struct etnaviv_cmdbuf cmdbuf;
+	struct pid *pid;       /* submitting process */
 	bool runtime_resumed;
 	u32 exec_state;
 	u32 flags;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index 1ac916b24891..1491159d0d20 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -399,6 +399,9 @@ static void submit_cleanup(struct kref *kref)
 		mutex_unlock(&submit->gpu->fence_lock);
 		dma_fence_put(submit->out_fence);
 	}
+
+	put_pid(submit->pid);
+
 	kfree(submit->pmrs);
 	kfree(submit);
 }
@@ -422,6 +425,7 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct sync_file *sync_file = NULL;
 	struct ww_acquire_ctx ticket;
 	int out_fence_fd = -1;
+	struct pid *pid = get_pid(task_pid(current));
 	void *stream;
 	int ret;
 
@@ -519,6 +523,8 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 		goto err_submit_ww_acquire;
 	}
 
+	submit->pid = pid;
+
 	ret = etnaviv_cmdbuf_init(priv->cmdbuf_suballoc, &submit->cmdbuf,
 				  ALIGN(args->stream_size, 8) + 8);
 	if (ret)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 37018bc55810..7d9bf4673e2d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1045,12 +1045,28 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 }
 #endif
 
-void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
+void etnaviv_gpu_recover_hang(struct etnaviv_gem_submit *submit)
 {
+	struct etnaviv_gpu *gpu = submit->gpu;
+	char *comm = NULL, *cmd = NULL;
+	struct task_struct *task;
 	unsigned int i;
 
 	dev_err(gpu->dev, "recover hung GPU!\n");
 
+	task = get_pid_task(submit->pid, PIDTYPE_PID);
+	if (task) {
+		comm = kstrdup(task->comm, GFP_KERNEL);
+		cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
+		put_task_struct(task);
+	}
+
+	if (comm && cmd)
+		dev_err(gpu->dev, "offending task: %s (%s)\n", comm, cmd);
+
+	kfree(cmd);
+	kfree(comm);
+
 	if (pm_runtime_get_sync(gpu->dev) < 0)
 		goto pm_put;
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 85eddd492774..b3a0941d56fd 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -168,7 +168,7 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu);
 int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m);
 #endif
 
-void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu);
+void etnaviv_gpu_recover_hang(struct etnaviv_gem_submit *submit);
 void etnaviv_gpu_retire(struct etnaviv_gpu *gpu);
 int etnaviv_gpu_wait_fence_interruptible(struct etnaviv_gpu *gpu,
 	u32 fence, struct drm_etnaviv_timespec *timeout);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
index 72e2553fbc98..d29f467eee13 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -67,7 +67,7 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_job(struct drm_sched_job
 
 	/* get the GPU back into the init state */
 	etnaviv_core_dump(submit);
-	etnaviv_gpu_recover_hang(gpu);
+	etnaviv_gpu_recover_hang(submit);
 
 	drm_sched_resubmit_jobs(&gpu->sched);
 
-- 
2.36.1

