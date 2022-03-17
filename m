Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0DE4DCBC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbiCQQwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbiCQQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:52:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E7520C2C9;
        Thu, 17 Mar 2022 09:51:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m22so5417987pja.0;
        Thu, 17 Mar 2022 09:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=morR5sm8z9pnyy1KkY8kjo/wAR7FEyx0daIfh3/D6sA=;
        b=EWtjmT7pTP3SeoDp8sW+ozfYHAhBX3Xl/GnFDItw2NZ3ePFqDrotlayFQQ450LMKB6
         18A33bR4cvBUfbh1V+k+feW8v4sEYGNeiLMzB3YBoMMYAD1Z4cYnZ2chowE79Hfq7BLz
         9aCaWCELis141P5ObHZXraaizkT7m7zHbIYf7bcltai0wbpwm3QfIbYlfMZ4yM0HzTo+
         vF3HcN7No3PIX5WxPiEufmiFVbcnx5oiJn+qLZGF0pllxHdKbZzxcV37fOP+DOqhynY4
         NqSfa5tlM2/EOw4vi2KHp25KR902/YDT7yuHwpeoZDDcSAAmLI3JdwhJ6is561aDRHUm
         SWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=morR5sm8z9pnyy1KkY8kjo/wAR7FEyx0daIfh3/D6sA=;
        b=IkbR0603LryHtSFvGluweHGo2/0rDJp5K4uHovvS3PVlSt713QvrgBDJmyDIBstl3p
         raTidxaemuDzgRfVkJMLww/IOD3psaBumS4gOZqoFh5uGwkyuiPQwJG9q7ew3CvwKxAp
         tRdkZANbywxSCdrandmtJtoSGjekUAfgJ48uqdPtSqwCpulxI/P0eUQaNOgP+fH6AOeb
         odGCXyjt7caLd9YpQ7IKhEAdipd1kyicwFk/NyJz/PbjiZxaHtNYZQCfxGEpLbQM0ps2
         2phNZdV2fZ+R1DtYaK1n/1N4Xg+bjs5gJFmsD+0epYunoYn4SY/PGZAaYkAnD067EQw2
         kccA==
X-Gm-Message-State: AOAM531BnHeM/MUPgXBWwN4g16HxMg7isKU1jqElkkR7qQqtaNERQmp3
        l1lGiet0ghKnId/58sRxE34=
X-Google-Smtp-Source: ABdhPJzXmOILB5Wbq0oNnzGhvgVCeJQ6JjR+4t8h3dPCLhxhvTcVLX/EpMuPNGjCYSH3cADf6U/anQ==
X-Received: by 2002:a17:902:c94e:b0:151:a988:f3dd with SMTP id i14-20020a170902c94e00b00151a988f3ddmr6143070pla.142.1647535879288;
        Thu, 17 Mar 2022 09:51:19 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b004fa2830a03esm3134711pfw.200.2022.03.17.09.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 09:51:18 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Emma Anholt <emma@anholt.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] drm/msm: Add a way to override processes comm/cmdline
Date:   Thu, 17 Mar 2022 09:51:40 -0700
Message-Id: <20220317165144.222101-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317165144.222101-1-robdclark@gmail.com>
References: <20220317165144.222101-1-robdclark@gmail.com>
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

In the cause of using the GPU via virtgpu, the host side process is
really a sort of proxy, and not terribly interesting from the PoV of
crash/fault logging.  Add a way to override these per process so that
we can see the guest process's name.

v2: Handle kmalloc failure, add comment to explain kstrdup returns
    NULL if passed NULL [Dan Carpenter]

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 43 +++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.c           | 12 +++++--
 drivers/gpu/drm/msm/msm_gpu.h           |  6 ++++
 drivers/gpu/drm/msm/msm_submitqueue.c   |  2 ++
 include/uapi/drm/msm_drm.h              |  2 ++
 5 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 3d307b34854d..45f2c6084aa7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -290,11 +290,48 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		     uint32_t param, uint64_t value, uint32_t len)
 {
-	/* No pointer params yet */
-	if (len != 0)
-		return -EINVAL;
+	switch (param) {
+	case MSM_PARAM_COMM:
+	case MSM_PARAM_CMDLINE:
+		/* kstrdup_quotable_cmdline() limits to PAGE_SIZE, so
+		 * that should be a reasonable upper bound
+		 */
+		if (len > PAGE_SIZE)
+			return -EINVAL;
+		break;
+	default:
+		if (len != 0)
+			return -EINVAL;
+	}
 
 	switch (param) {
+	case MSM_PARAM_COMM:
+	case MSM_PARAM_CMDLINE: {
+		char *str, **paramp;
+
+		str = kmalloc(len + 1, GFP_KERNEL);
+		if (!str)
+			return -ENOMEM;
+
+		if (copy_from_user(str, u64_to_user_ptr(value), len)) {
+			kfree(str);
+			return -EFAULT;
+		}
+
+		/* Ensure string is null terminated: */
+		str[len] = '\0';
+
+		if (param == MSM_PARAM_COMM) {
+			paramp = &ctx->comm;
+		} else {
+			paramp = &ctx->cmdline;
+		}
+
+		kfree(*paramp);
+		*paramp = str;
+
+		return 0;
+	}
 	case MSM_PARAM_SYSPROF:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 4ec62b601adc..747b89aa9d13 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -364,14 +364,22 @@ static void retire_submits(struct msm_gpu *gpu);
 
 static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
 {
+	struct msm_file_private *ctx = submit->queue->ctx;
 	struct task_struct *task;
 
+	/* Note that kstrdup will return NULL if argument is NULL: */
+	*comm = kstrdup(ctx->comm, GFP_KERNEL);
+	*cmd  = kstrdup(ctx->cmdline, GFP_KERNEL);
+
 	task = get_pid_task(submit->pid, PIDTYPE_PID);
 	if (!task)
 		return;
 
-	*comm = kstrdup(task->comm, GFP_KERNEL);
-	*cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
+	if (!*comm)
+		*comm = kstrdup(task->comm, GFP_KERNEL);
+
+	if (!*cmd)
+		*cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
 
 	put_task_struct(task);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index c28c2ad9f52e..2c0203fd6ce3 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -355,6 +355,12 @@ struct msm_file_private {
 	 */
 	int sysprof;
 
+	/** comm: Overridden task comm, see MSM_PARAM_COMM */
+	char *comm;
+
+	/** cmdline: Overridden task cmdline, see MSM_PARAM_CMDLINE */
+	char *cmdline;
+
 	/**
 	 * elapsed:
 	 *
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 79b6ccd6ce64..f486a3cd4e55 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -61,6 +61,8 @@ void __msm_file_private_destroy(struct kref *kref)
 	}
 
 	msm_gem_address_space_put(ctx->aspace);
+	kfree(ctx->comm);
+	kfree(ctx->cmdline);
 	kfree(ctx);
 }
 
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 0aa1a8cb4e0d..794ad1948497 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -82,6 +82,8 @@ struct drm_msm_timespec {
 #define MSM_PARAM_FAULTS     0x09  /* RO */
 #define MSM_PARAM_SUSPENDS   0x0a  /* RO */
 #define MSM_PARAM_SYSPROF    0x0b  /* WO: 1 preserves perfcntrs, 2 also disables suspend */
+#define MSM_PARAM_COMM       0x0c  /* WO: override for task->comm */
+#define MSM_PARAM_CMDLINE    0x0d  /* WO: override for task cmdline */
 
 /* For backwards compat.  The original support for preemption was based on
  * a single ring per priority level so # of priority levels equals the #
-- 
2.35.1

