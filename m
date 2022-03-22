Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201814E3E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbiCVMLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiCVMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:11:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A428282D14
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:10:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s8so17926883pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWAdje7WFQnGpq+Kzbn3GFOKshIOo6IyB5vnvj78tbI=;
        b=eOeCiva+YFC5KtCUmdL7oCrHAm0F5xnJHvxasgCVLhR2oKzsPlmqbCsN6WokyH2cPE
         tXIXGeR04d8WAfEPmG0Npz1hUgzLXWLcqaIglC1ZDXNWaSnNADdQZLBdUOESRTU/eLh5
         uuONzqNv2NOmfZmLkQ2JSsksRj9VDmHnV3HULmOnkUkP64/eA7oQk4LTFQilSvrj7NYT
         ngxTCWNaR2BqyBX4prH/K49v5Tva17Vaq25gGteX1aZfgNhrAEvf8PBhSXSPm49OziaL
         dEDC1JR2fbTBaeowrAOYg4XB9Nw4SCxM8jetPxTXTHJt2iJpKVDdpD4oo26yMRz+D9wn
         RSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWAdje7WFQnGpq+Kzbn3GFOKshIOo6IyB5vnvj78tbI=;
        b=gAUrmr4A9+cR/aP3xcFAenDEjgdEp/Oa+dHXYf8bOqdZfsxSHJj5O226In/vzA5ieB
         x57BYLcC4jE3oRclFAEFObZ1DZG+ix0KehJ6kV9Tp/tjnYk5ftUD6CKSZIVe+Gn2jhBv
         74I11p6kpJBbQDesQ2pq/ujiKUQY/gkznz5Pp1258uWw82J780GavkRIS8S6wINolmVE
         V/uHcZFsneSJEPVlzG4VRrsP3x/Rvf8HTX5T6NnhXERm4E6uuUG1q000dHRIWGwcRwxy
         HzmlFz4LlkcKWkgdUZM64kFhvGL5L222pg7+zZigo+qpFn/nzJWSLhQBqAlSmhAHifPq
         vRzQ==
X-Gm-Message-State: AOAM5328/YeXgKinxLsd4x0rWENnCAucxaR7utbIbQZcm4ByOSBwBKep
        TLiPfEV2V4G2IsjVoMHtLFm0sQ==
X-Google-Smtp-Source: ABdhPJx+oCjdIGMKD+idwjDEPk2ce0on0bR+XsYYx/UwuotY0mRWSSSEXnV/dWWYRThCqC4ZOy3qcQ==
X-Received: by 2002:a62:f205:0:b0:4fa:8461:421f with SMTP id m5-20020a62f205000000b004fa8461421fmr15556436pfh.4.1647951001679;
        Tue, 22 Mar 2022 05:10:01 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e62:3990:75d0:8573:b73c:e6b4])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm24833850pfj.112.2022.03.22.05.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:10:00 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 2/6] perf/core: Introduce percpu perf_cgroup
Date:   Tue, 22 Mar 2022 20:08:30 +0800
Message-Id: <20220322120834.98637-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322120834.98637-1-zhouchengming@bytedance.com>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although we don't have incosistency problem any more, we can
have other problem like:

CPU1					CPU2
(in context_switch)			(attach running task)
					prev->cgroups = cgrp2
perf_cgroup_sched_switch(prev, next)
	cgrp2 == cgrp2 is True

If perf_cgroup of prev task changes from cgrp1 to cgrp2,
perf_cgroup_sched_switch() will skip perf_cgroup_switch(),
so the CPU would still schedule the cgrp1 events, but we should
schedule the cgrp2 events.

The reason of this problem is that we shouldn't use the changeable
prev->cgroups to decide whether skip perf_cgroup_switch().

This patch introduces a percpu perf_cgroup to cache the perf_cgroup
that scheduled in cpuctxes, which later used to compare with the
perf_cgroup of next task to decide whether skip perf_cgroup_switch().

Since the perf_cgroup_switch() can be called after the context switch,
the cgroup events might be scheduled already. So we put the comparison
of perf_cgroups in perf_cgroup_switch(), and delete the unused function
perf_cgroup_sched_switch().

We must clear the percpu perf_cgroup cache when the last cgroup event
disabled.

Fixes: a8d757ef076f ("perf events: Fix slow and broken cgroup context switch code")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 63 ++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8b5cf2aedfe6..848a3bfa9513 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -826,6 +826,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 	}
 }
 
+static DEFINE_PER_CPU(struct perf_cgroup *, cpu_perf_cgroup);
 static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
 
 /*
@@ -833,6 +834,7 @@ static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
  */
 static void perf_cgroup_switch(struct task_struct *task)
 {
+	struct perf_cgroup *cgrp;
 	struct perf_cpu_context *cpuctx, *tmp;
 	struct list_head *list;
 	unsigned long flags;
@@ -843,11 +845,21 @@ static void perf_cgroup_switch(struct task_struct *task)
 	 */
 	local_irq_save(flags);
 
+	cgrp = perf_cgroup_from_task(task, NULL);
+	if (cgrp == __this_cpu_read(cpu_perf_cgroup))
+		goto out;
+
+	__this_cpu_write(cpu_perf_cgroup, cgrp);
+
 	list = this_cpu_ptr(&cgrp_cpuctx_list);
 	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
 		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
 
 		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+
+		if (cpuctx->cgrp == cgrp)
+			continue;
+
 		perf_pmu_disable(cpuctx->ctx.pmu);
 
 		cpu_ctx_sched_out(cpuctx, EVENT_ALL);
@@ -855,14 +867,11 @@ static void perf_cgroup_switch(struct task_struct *task)
 		 * must not be done before ctxswout due
 		 * to event_filter_match() in event_sched_out()
 		 */
-		cpuctx->cgrp = perf_cgroup_from_task(task,
-						     &cpuctx->ctx);
+		cpuctx->cgrp = cgrp;
 		/*
 		 * set cgrp before ctxsw in to allow
 		 * event_filter_match() to not have to pass
 		 * task around
-		 * we pass the cpuctx->ctx to perf_cgroup_from_task()
-		 * because cgroup events are only per-cpu
 		 */
 		cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
 
@@ -870,35 +879,10 @@ static void perf_cgroup_switch(struct task_struct *task)
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 	}
 
+out:
 	local_irq_restore(flags);
 }
 
-static inline void perf_cgroup_sched_switch(struct task_struct *task,
-					    struct task_struct *next)
-{
-	struct perf_cgroup *cgrp1;
-	struct perf_cgroup *cgrp2 = NULL;
-
-	rcu_read_lock();
-	/*
-	 * we come here when we know perf_cgroup_events > 0
-	 * we do not need to pass the ctx here because we know
-	 * we are holding the rcu lock
-	 */
-	cgrp1 = perf_cgroup_from_task(task, NULL);
-	cgrp2 = perf_cgroup_from_task(next, NULL);
-
-	/*
-	 * only schedule out current cgroup events if we know
-	 * that we are switching to a different cgroup. Otherwise,
-	 * do no touch the cgroup events.
-	 */
-	if (cgrp1 != cgrp2)
-		perf_cgroup_switch(task);
-
-	rcu_read_unlock();
-}
-
 static int perf_cgroup_ensure_storage(struct perf_event *event,
 				struct cgroup_subsys_state *css)
 {
@@ -1035,6 +1019,9 @@ perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *c
 		cpuctx->cgrp = NULL;
 
 	list_del(&cpuctx->cgrp_cpuctx_entry);
+
+	if (list_empty(per_cpu_ptr(&cgrp_cpuctx_list, event->cpu)))
+		__this_cpu_write(cpu_perf_cgroup, NULL);
 }
 
 #else /* !CONFIG_CGROUP_PERF */
@@ -1062,11 +1049,6 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
 {
 }
 
-static inline void perf_cgroup_sched_switch(struct task_struct *task,
-					    struct task_struct *next)
-{
-}
-
 static inline int perf_cgroup_connect(pid_t pid, struct perf_event *event,
 				      struct perf_event_attr *attr,
 				      struct perf_event *group_leader)
@@ -1080,11 +1062,6 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 {
 }
 
-static inline void
-perf_cgroup_sched_switch(struct task_struct *task, struct task_struct *next)
-{
-}
-
 static inline u64 perf_cgroup_event_time(struct perf_event *event)
 {
 	return 0;
@@ -1104,6 +1081,10 @@ static inline void
 perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *ctx)
 {
 }
+
+static void perf_cgroup_switch(struct task_struct *task)
+{
+}
 #endif
 
 /*
@@ -3625,7 +3606,7 @@ void __perf_event_task_sched_out(struct task_struct *task,
 	 * cgroup event are system-wide mode only
 	 */
 	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
-		perf_cgroup_sched_switch(task, next);
+		perf_cgroup_switch(next);
 }
 
 /*
-- 
2.20.1

