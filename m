Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC18158C73B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242828AbiHHLGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbiHHLFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:05:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E61514D2B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:05:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so8741633pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgu0QebApDasttKV3uGy+5ar/hOmMsIwTE7SF/rUsQE=;
        b=JQAfgMqTw1Wij8iFsPNSvejYSeAmgSkLt4FTBNAQfJJz6xO0iZLYdaLQsJBxP/qmyG
         gHZ3Ei3C58TnGKPQNLjxv1tzHeYev80QU7LKN9qCwi9oEFml9xpyDRuhtekGLAZtbrRR
         OwykBPrFL9pJitjJRrCW1AhRYCW0G0Mz54X+WpshocbCa1Wp4QuBaR0Wc6+i8lHgzffY
         ZvCYBpUXUoyi1anfoTbnoUJzwGvnNYqw0ZexB6uvUPhzxn9SZaaObTBErCu9CDZp65jd
         mcDur1rEwRPwOkOacd/1Iw5VCCLMGJib50ZXPMNWsH284FcJ2BzlRyGhA0WvZY/hpHJr
         5mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgu0QebApDasttKV3uGy+5ar/hOmMsIwTE7SF/rUsQE=;
        b=WeisWjosJ4IpX12bL9mP19faGtFAOHNHXtxZLRZDOC7yrXcz8XQjyE1uh44bNqMxoR
         CL6kTR++ClrUJvWIQ1axDW5UVKNcISX0/c2xK6hhdHLnNiSGNrp1J6BnfwCwphyTIOa1
         YOiHCz7XKy1pibTU6I7Q+2nM+0Isf/b1c16QtnNsJK+2Ez+t/CJ7RdHJsly7IylzqRcB
         asau9sbPn3anvWBHuI4elNEYd0Ex6KwolDDSLTg4odgrzd/ZZ+agnXjMSk1NejDUudFR
         rLMaI7o2fvQrHzfGxVa5ewFftXoRgVDOqRm3lefQ9tdaWviX1XYd/9X57OePuHg42eYF
         qOIA==
X-Gm-Message-State: ACgBeo1XClCxspV/imZCRYhvGa6xA8NQc5xOWwCASxktLqWcKIbBPNcC
        pu+BRr9HHMjc/ttR+0b4Dyu39A==
X-Google-Smtp-Source: AA6agR7QRD8QV8oQ0lebhQrjGgnbIJTfLXmW6Y9k2ZDa83FrSr/HRZ3TFY9D/tzmq7opX7MyAW3uvA==
X-Received: by 2002:a17:902:e744:b0:16e:f6c2:3731 with SMTP id p4-20020a170902e74400b0016ef6c23731mr18328588plf.104.1659956730459;
        Mon, 08 Aug 2022 04:05:30 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7978c000000b0052dbad1ea2esm8393180pfp.6.2022.08.08.04.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:05:30 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 10/10] sched/psi: cache parent psi_group to speed up groups iterate
Date:   Mon,  8 Aug 2022 19:03:41 +0800
Message-Id: <20220808110341.15799-11-zhouchengming@bytedance.com>
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

We use iterate_groups() to iterate each level psi_group to update
PSI stats, which is a very hot path.

In current code, iterate_groups() have to use multiple branches and
cgroup_parent() to get parent psi_group for each level, which is not
very efficient.

This patch cache parent psi_group in struct psi_group, only need to get
psi_group of task itself first, then just use group->parent to iterate.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/psi_types.h |  1 +
 kernel/sched/psi.c        | 51 ++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index fced39e255aa..7459a47fcb1f 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -148,6 +148,7 @@ struct psi_trigger {
 
 struct psi_group {
 	bool enabled;
+	struct psi_group *parent;
 
 	/* Protects data used by the aggregator */
 	struct mutex avgs_lock;
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 9df1686ee02d..d3c1c49b9bcf 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -786,30 +786,22 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
 }
 
-static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
+static inline struct psi_group *task_psi_group(struct task_struct *task)
 {
-	if (*iter == &psi_system)
-		return NULL;
-
 #ifdef CONFIG_CGROUPS
 	if (static_branch_likely(&psi_cgroups_enabled)) {
-		struct cgroup *cgroup = NULL;
-
-		if (!*iter)
-			cgroup = task->cgroups->dfl_cgrp;
-		else
-			cgroup = cgroup_parent(*iter);
+		struct cgroup *cgroup = task_dfl_cgroup(task);
 
-		if (cgroup && cgroup_parent(cgroup)) {
-			*iter = cgroup;
+		if (cgroup && cgroup_parent(cgroup))
 			return cgroup_psi(cgroup);
-		}
 	}
 #endif
-	*iter = &psi_system;
 	return &psi_system;
 }
 
+#define for_each_psi_group(group) \
+	for (; group; group = group->parent)
+
 static void psi_flags_change(struct task_struct *task, int clear, int set)
 {
 	if (((task->psi_flags & set) ||
@@ -827,12 +819,11 @@ static void psi_flags_change(struct task_struct *task, int clear, int set)
 
 void psi_change_groups(struct task_struct *task, int clear, int set)
 {
+	struct psi_group *group = task_psi_group(task);
 	int cpu = task_cpu(task);
-	struct psi_group *group;
-	void *iter = NULL;
 	u64 now = cpu_clock(cpu);
 
-	while ((group = iterate_groups(task, &iter)))
+	for_each_psi_group(group)
 		psi_group_change(group, cpu, clear, set, now, true);
 }
 
@@ -850,7 +841,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 {
 	struct psi_group *group, *common = NULL;
 	int cpu = task_cpu(prev);
-	void *iter;
 	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
@@ -861,8 +851,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 * we reach the first common ancestor. Iterate @next's
 		 * ancestors only until we encounter @prev's ONCPU.
 		 */
-		iter = NULL;
-		while ((group = iterate_groups(next, &iter))) {
+		group = task_psi_group(next);
+		for_each_psi_group(group) {
 			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
 			    PSI_ONCPU) {
 				common = group;
@@ -903,9 +893,12 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 		psi_flags_change(prev, clear, set);
 
-		iter = NULL;
-		while ((group = iterate_groups(prev, &iter)) && group != common)
+		group = task_psi_group(prev);
+		for_each_psi_group(group) {
+			if (group == common)
+				break;
 			psi_group_change(group, cpu, clear, set, now, wake_clock);
+		}
 
 		/*
 		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
@@ -913,7 +906,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 */
 		if (sleep || unlikely(prev->in_memstall != next->in_memstall)) {
 			clear &= ~TSK_ONCPU;
-			for (; group; group = iterate_groups(prev, &iter))
+			for_each_psi_group(group)
 				psi_group_change(group, cpu, clear, set, now, wake_clock);
 		}
 	}
@@ -922,7 +915,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 void psi_account_irqtime(struct task_struct *task, u32 delta)
 {
 	int cpu = task_cpu(task);
-	void *iter = NULL;
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
 	u64 now;
@@ -932,7 +924,8 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 
 	now = cpu_clock(cpu);
 
-	while ((group = iterate_groups(task, &iter))) {
+	group = task_psi_group(task);
+	for_each_psi_group(group) {
 		groupc = per_cpu_ptr(group->pcpu, cpu);
 
 		write_seqcount_begin(&groupc->seq);
@@ -1010,6 +1003,8 @@ void psi_memstall_leave(unsigned long *flags)
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgroup)
 {
+	struct cgroup *parent;
+
 	if (!static_branch_likely(&psi_cgroups_enabled))
 		return 0;
 
@@ -1017,6 +1012,12 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 	if (!cgroup->psi.pcpu)
 		return -ENOMEM;
 	group_init(&cgroup->psi);
+
+	parent = cgroup_parent(cgroup);
+	if (parent && cgroup_parent(parent))
+		cgroup->psi.parent = cgroup_psi(parent);
+	else
+		cgroup->psi.parent = &psi_system;
 	return 0;
 }
 
-- 
2.36.1

