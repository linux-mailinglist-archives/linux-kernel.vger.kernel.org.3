Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7E04DBBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbiCQAac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353403AbiCQAa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:30:27 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396A1CB02;
        Wed, 16 Mar 2022 17:29:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q19so1401191pgm.6;
        Wed, 16 Mar 2022 17:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKSIvXkqxKLFm6MnEgEDHDzqzUeFog6pmD8CweFsghI=;
        b=fK5C0D6wt92zw/V7ISzNnKi4SqjYgu4ZQdD090gSE0mlYaTHhCaEsvuPel6xmJE9OH
         QVSgyOYMF1lmGUjny0cY+z0vrS9kJoAmZvh9Xdj7mnVa9Vztg/Dk3dKUAz8NhGYC8DEn
         kmYi3JmbRN9ervwY3YqJ/KVs77YAWBWzZ4JwmLaT0c+FudlB/mIiBxzwHuIk3sYpanc9
         IRWMgSsBJQ1/qHDtkmog8Em9FGbNrYy90X5Xiu2GtnZaN0s+NDDyE+xYsTS44CDU4Abf
         nIqe+aAeIhOuZ0oaB3AwWsZWpNDsFHj+uzwo04C6A9IycBw5S/haN8LFzKnlJ/dlZsPK
         as7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKSIvXkqxKLFm6MnEgEDHDzqzUeFog6pmD8CweFsghI=;
        b=MeWHfVN4ZMkzb1LJRFcDrEW8ezBXFt+z4vNo1LI/8ol6ibFMnOIBSxkvqhVnwtfuzn
         B1dY6CwrCARcmpez8aSEYzY1+rqMCNIYIkBE/8LNFX2aA8Y+T2K9VtsC0/nYAC/ZXWCC
         /5BpvJO0kso8yQRtbTICTsAocMTycENOi5IlKWOWsQWYvepofgEjKYon8sZ3HqIltMdW
         3emmmIFjv96jjNrJw3lXqbjbsh665RI4Z6DOQPHur55BWuPgNySfxeEUwU2KJzohJ7Mc
         vDHDGVDQFVIbs/AgR3ZcW1rrN8guOK813KavighAMZCYNqIVn6KjsUCyCZPHKuJ/VIjm
         M7cg==
X-Gm-Message-State: AOAM530Xp4qF+xMYrE/B5yuA7MRSEAOolaEzVOhkEeq7z2+iUVw7jAjc
        qwK1xCRDa8L4ZbpXDexqv3PKiXdFZc4=
X-Google-Smtp-Source: ABdhPJws2yciiCk0JB+zECpgQIpT79AGYFUcJramWhAX+xOChjfaW3HF+RJ5Cg/C8zb0jJ4t0EcUNA==
X-Received: by 2002:a05:6a00:c93:b0:4f7:c76:921f with SMTP id a19-20020a056a000c9300b004f70c76921fmr1780365pfv.73.1647476951441;
        Wed, 16 Mar 2022 17:29:11 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id t7-20020a056a0021c700b004f7916d44bcsm4523879pfj.220.2022.03.16.17.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 17:29:10 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] drm/msm: Split out helper to get comm/cmdline
Date:   Wed, 16 Mar 2022 17:29:44 -0700
Message-Id: <20220317002950.193449-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317002950.193449-1-robdclark@gmail.com>
References: <20220317002950.193449-1-robdclark@gmail.com>
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

