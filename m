Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1058C71E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiHHLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiHHLEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:04:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8FC14091
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:04:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f28so7801802pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFgIL4xu1jYaeQ3o92prjVPs2tt3tKhzJurHXG1zK+o=;
        b=mCn/FUv8vJn3gM6TWAH7m0EZ0zSqeK/a3/8rhqv+87kOgowTq51ILVa8RPtQ4CJ4e0
         +oAxuhaBJwC6Y2w9xm0tcIArMne+5pSc3BOXm1Kg+AK2J+YdoVwEKs3dMBp/6CaIXs8G
         maC4pXIGM8GFtTPqdn7//qVcjblHL0NBdkagTz45mlfa2Nwgxuzz3OEwUV42DGUkL7hc
         Hw1CZoPTI0jN3JI6hnb5qsK2orPYPLWKu7k15zZ2B3cIgymfdVNnTuyIvE33uxvqGbTH
         YN7JCpiRk/a9kv5LE3JcRzAmAzR42UgfSRuAqWxbRWhD5g9y/yPfY5rfh3m4nAZLP6Tl
         ub5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CFgIL4xu1jYaeQ3o92prjVPs2tt3tKhzJurHXG1zK+o=;
        b=ynhe33BaobXvmAaJ3tI6ul6QlTcTLLpa+LTZmJWwLrBtZpFdJoUg9hoPHri6etLHhH
         SzsE9ry991S27RBSpPatwTUUrglhGJdHtWKEa8ykC5y68z2Bixe7thtpZkOZ4IGyOSYp
         LS1qRiRQE5bbSz9RGvRhTvU8iSyGhxVt22EFp/1Rjn9TS6vsigWzm+dqPtNUIOWn8Fjg
         fIB5SUVybVlsptnIgEInPxpPTvn1n4pugxo6wOfWx7BFe4qWo2YcXRYH3TPMnp2+OoS4
         rtGfg85VSbX/SCogbm9iVH00MlfXAS0d2uaRsnhkQQI+vAuVm1QEVYO9I7AbnIsofrmN
         I36A==
X-Gm-Message-State: ACgBeo3VI9oCAtcViA4yA7pKns3gwI2/eyGzD8Q2b6pjJx9r2M47xu0o
        jNXrOtjVy+FyHzMoBY4h3dutJQ==
X-Google-Smtp-Source: AA6agR7tRjncfSmTCS6i6FXwFGDHhpSti35ZJAmns5pKoWT2V+5P7OjJ7+Pu0qaMl2oBoTfBN7dGvQ==
X-Received: by 2002:a63:8bc3:0:b0:41d:4b74:b975 with SMTP id j186-20020a638bc3000000b0041d4b74b975mr6368442pge.309.1659956670430;
        Mon, 08 Aug 2022 04:04:30 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7978c000000b0052dbad1ea2esm8393180pfp.6.2022.08.08.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:04:30 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 01/10] sched/psi: fix periodic aggregation shut off
Date:   Mon,  8 Aug 2022 19:03:32 +0800
Message-Id: <20220808110341.15799-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808110341.15799-1-zhouchengming@bytedance.com>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to wake periodic aggregation work back up if the
task change is the aggregation worker itself going to sleep, or
we'll ping-pong forever.

Previously, we would use psi_task_change() in psi_dequeue() when
task going to sleep, so this check was put in psi_task_change().

But commit 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
defer task sleep handling to psi_task_switch(), won't go through
psi_task_change() anymore.

So this patch move this check to psi_task_switch().

Fixes: 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a337f3e35997..115a7e52fa23 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -800,7 +800,6 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
-	bool wake_clock = true;
 	void *iter = NULL;
 	u64 now;
 
@@ -810,19 +809,9 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	psi_flags_change(task, clear, set);
 
 	now = cpu_clock(cpu);
-	/*
-	 * Periodic aggregation shuts off if there is a period of no
-	 * task changes, so we wake it back up if necessary. However,
-	 * don't do this if the task change is the aggregation worker
-	 * itself going to sleep, or we'll ping-pong forever.
-	 */
-	if (unlikely((clear & TSK_RUNNING) &&
-		     (task->flags & PF_WQ_WORKER) &&
-		     wq_worker_last_func(task) == psi_avgs_work))
-		wake_clock = false;
 
 	while ((group = iterate_groups(task, &iter)))
-		psi_group_change(group, cpu, clear, set, now, wake_clock);
+		psi_group_change(group, cpu, clear, set, now, true);
 }
 
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
@@ -858,6 +847,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 	if (prev->pid) {
 		int clear = TSK_ONCPU, set = 0;
+		bool wake_clock = true;
 
 		/*
 		 * When we're going to sleep, psi_dequeue() lets us
@@ -871,13 +861,23 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 				clear |= TSK_MEMSTALL_RUNNING;
 			if (prev->in_iowait)
 				set |= TSK_IOWAIT;
+
+			/*
+			 * Periodic aggregation shuts off if there is a period of no
+			 * task changes, so we wake it back up if necessary. However,
+			 * don't do this if the task change is the aggregation worker
+			 * itself going to sleep, or we'll ping-pong forever.
+			 */
+			if (unlikely((prev->flags & PF_WQ_WORKER) &&
+				     wq_worker_last_func(prev) == psi_avgs_work))
+				wake_clock = false;
 		}
 
 		psi_flags_change(prev, clear, set);
 
 		iter = NULL;
 		while ((group = iterate_groups(prev, &iter)) && group != common)
-			psi_group_change(group, cpu, clear, set, now, true);
+			psi_group_change(group, cpu, clear, set, now, wake_clock);
 
 		/*
 		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
@@ -886,7 +886,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		if (sleep) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = iterate_groups(prev, &iter))
-				psi_group_change(group, cpu, clear, set, now, true);
+				psi_group_change(group, cpu, clear, set, now, wake_clock);
 		}
 	}
 }
-- 
2.36.1

