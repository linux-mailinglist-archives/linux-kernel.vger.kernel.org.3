Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70974DCBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiCQQwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbiCQQwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:52:32 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0064820C18E;
        Thu, 17 Mar 2022 09:51:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s8so7233583pfk.12;
        Thu, 17 Mar 2022 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKSIvXkqxKLFm6MnEgEDHDzqzUeFog6pmD8CweFsghI=;
        b=bUGk2Wp+U7vNMRDQf8jdXaKMmj/UyBkl6QWCzCJeio9r9gAN+TQGqAVsWKT/hb0awj
         rPgPl1CbtTcSQJUk1xm2/RaUqJhFJj1TgduuN+wp4/PpmRWYouaJZSvyZGUxvivjVecf
         hZcjtHDt8QRRLK7gs/9tgMz41L9vCTOHw75Bo2ptMcdzUD0WiSJWVFWcKQtveTG3o9QT
         hM46O9AT68fo/Y5AlvlaKYNP5+q4xk/uqZBMDtMJ/fbbEXHFmHx/IMKq4WHUbumvMurm
         jxbO/lVPfDT7DKtSBeYENQAghy5PT5d8ygaVSo3/Mq7xQul2lHKdZAPOwGDjUhXNNqBT
         hkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKSIvXkqxKLFm6MnEgEDHDzqzUeFog6pmD8CweFsghI=;
        b=B/r+6cyGdJdrIMvazSj4wx4WgB/6YJZ1Z4rq2ERbxOzgUH0yn4/eiCIqEX2doxmBVo
         gZtKuiUh1UQ3JErwFKopB89GGWLlZ3skM9SA28YLGul/Cg/zdQp6tswduRrt/6xhW7nC
         EI7SrX3SKM1BrlkDSix+9zwgdLga7Ynh7rW3Se9UGdMur+We9Z1PWAP2/s9z2td+jt/0
         OYEC4yTuABoSWFT6bqAJoo92NJztK1k1Fb2oEQmZPfwUEF8GCJ5o5AKH3IO5vJim9xFh
         IhKfgCJj8pDrkGvswNjHa+Fy/zlH3z7YRIlrsnFd3UEnBmNUAYJE1Pi+zfRVgk+c7tbp
         6RDQ==
X-Gm-Message-State: AOAM531ORuHqIBrE0kitxu48kSmVHGcWfwGVQ7thyFv3gqs5peNtPFxW
        eThzdM6Zf9ZPsRFO7HaD0oMLaXRC9ks=
X-Google-Smtp-Source: ABdhPJxSo7vijSrAXyA9Xt6LaQJ3VguWil2NyOTQvpUudA2xCjPQHwFiQKBx4wdZad9KFOfWTZnJLA==
X-Received: by 2002:a63:f00e:0:b0:373:9fdb:ce03 with SMTP id k14-20020a63f00e000000b003739fdbce03mr4476237pgh.518.1647535875515;
        Thu, 17 Mar 2022 09:51:15 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id t71-20020a63784a000000b00380a9f7367asm6048611pgc.77.2022.03.17.09.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 09:51:14 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] drm/msm: Split out helper to get comm/cmdline
Date:   Thu, 17 Mar 2022 09:51:39 -0700
Message-Id: <20220317165144.222101-3-robdclark@gmail.com>
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

Deduplicate this from fault_worker and recover_worker.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 8fe4aee96aa9..4ec62b601adc 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -362,6 +362,20 @@ find_submit(struct msm_ringbuffer *ring, uint32_t fence)
 
 static void retire_submits(struct msm_gpu *gpu);
 
+static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
+{
+	struct task_struct *task;
+
+	task = get_pid_task(submit->pid, PIDTYPE_PID);
+	if (!task)
+		return;
+
+	*comm = kstrdup(task->comm, GFP_KERNEL);
+	*cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
+
+	put_task_struct(task);
+}
+
 static void recover_worker(struct kthread_work *work)
 {
 	struct msm_gpu *gpu = container_of(work, struct msm_gpu, recover_work);
@@ -378,18 +392,11 @@ static void recover_worker(struct kthread_work *work)
 
 	submit = find_submit(cur_ring, cur_ring->memptrs->fence + 1);
 	if (submit) {
-		struct task_struct *task;
-
 		/* Increment the fault counts */
 		submit->queue->faults++;
 		submit->aspace->faults++;
 
-		task = get_pid_task(submit->pid, PIDTYPE_PID);
-		if (task) {
-			comm = kstrdup(task->comm, GFP_KERNEL);
-			cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
-			put_task_struct(task);
-		}
+		get_comm_cmdline(submit, &comm, &cmd);
 
 		if (comm && cmd) {
 			DRM_DEV_ERROR(dev->dev, "%s: offending task: %s (%s)\n",
@@ -478,14 +485,7 @@ static void fault_worker(struct kthread_work *work)
 		goto resume_smmu;
 
 	if (submit) {
-		struct task_struct *task;
-
-		task = get_pid_task(submit->pid, PIDTYPE_PID);
-		if (task) {
-			comm = kstrdup(task->comm, GFP_KERNEL);
-			cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
-			put_task_struct(task);
-		}
+		get_comm_cmdline(submit, &comm, &cmd);
 
 		/*
 		 * When we get GPU iova faults, we can get 1000s of them,
-- 
2.35.1

