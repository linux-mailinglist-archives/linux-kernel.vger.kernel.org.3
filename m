Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8B550E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 04:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbiFTCFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 22:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiFTCFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 22:05:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C52FB85C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 19:05:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o18so1414765plg.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 19:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/NEZACDreD5/kFOTQykdARX+TUeMas4sy46Zc+L3y0Q=;
        b=TCF68MVhY0ntDGChZ53Wsmn7nr9LZ+kzvP8UxGUQv4tVxXZpFQkE6oLrcf+H3fgGtH
         vX/V8/iVd2XGsqBQgH7bcw+hvMxe+nxR6QKo382LUwtL1L81MqD6uDz4g72s9FEg68eR
         kGxJgdtFoCQz7BrJt5FIZ5TNTYMOYpnwCKnHkT4ddKOT83j6tEa1ahn1pUQSL9sEOKQ+
         IC8gFERAOfExwhdDjOauLXZYl8zSffCa9x3mqbWuOBcA2oJpfoZSviLO2JWNY/qcCoK4
         TzeHIbvV2QzIhrVJK/lPj3UCjqc7hDYFVSNlzcrrDLvDlmeWYjrtiuFS6xUpzXzdmwcG
         PMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/NEZACDreD5/kFOTQykdARX+TUeMas4sy46Zc+L3y0Q=;
        b=d2K1UOE3I8YPew6NjM5FCKG9h80yNddqvZ8r1bT8GhQ25PCxRBLr9ee3wjJEvQAYgd
         v1RN2gI2vLEOLI0YOmf7RWsoDKt86k80lxpfYsYRyoNIo7VvLi8RBq5EXqBSIp3C+pPM
         PNp0OEQTDEa4kiQzvGNqSfSS4cknDiwOfvW2F76rIQGbZb9JgKc9erP1rXLgKBd9ogQf
         p5IEjD6mzp1Xw5XvKkwVIy84m5djLS7Qm+YGXrmXiZPY9rE8OU5jFgrb3tjSgx+8sXwV
         c2EzLXAhQnCjpmRxDvWjD34zML2gtSpzy8mS+arh32CepHluklB0RmfOI5jxs82oFAfG
         nUVA==
X-Gm-Message-State: AJIora9YdOfkM/BWzHMyhXHrp+04+WvSSWHEVDEpnpVd6sCtjcwHbEmG
        SkGPIYcuRxJuC9tgzP+Dzh66hJk1vtU=
X-Google-Smtp-Source: AGRyM1uZ+oor36sLfZqD+u1kAP8dbVtBgCEstbQpNCktOywOnv+jC11iHOInvMkAlRZM/w87yRSx9g==
X-Received: by 2002:a17:90b:1a81:b0:1e8:866c:6f78 with SMTP id ng1-20020a17090b1a8100b001e8866c6f78mr35368676pjb.44.1655690712457;
        Sun, 19 Jun 2022 19:05:12 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709027e4500b001679a4711d9sm7322488pln.162.2022.06.19.19.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 19:05:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.xiaokai@zte.com.cn
To:     hannes@cmpxchg.org
Cc:     ran.xiaokai@zte.com.cn, linux-kernel@vger.kernel.org,
        cgel <cgel@zte.com.cn>
Subject: [RFC PATCH] psi: introduce memory.pressure.stat
Date:   Mon, 20 Jun 2022 02:05:07 +0000
Message-Id: <20220620020507.935994-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: cgel <cgel@zte.com.cn>

Signed-off-by: cgel <cgel@zte.com.cn>
---
 include/linux/psi.h       |   7 +--
 include/linux/psi_types.h |  34 +++++++++++++
 kernel/cgroup/cgroup.c    |  11 ++++
 kernel/sched/psi.c        | 126 +++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 168 insertions(+), 10 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 7b3de73..163da43 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -19,10 +19,11 @@ void psi_init(void);
 void psi_task_change(struct task_struct *task, int clear, int set);
 
 void psi_memstall_tick(struct task_struct *task, int cpu);
-void psi_memstall_enter(unsigned long *flags);
-void psi_memstall_leave(unsigned long *flags);
+void psi_memstall_enter(unsigned long *flags, int mem_state);
+void psi_memstall_leave(unsigned long *flags, int mem_state);
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
+int psi_mem_pressure_stat_show(struct seq_file *m, void *v);
 
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgrp);
@@ -41,7 +42,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 
 static inline void psi_init(void) {}
 
-static inline void psi_memstall_enter(unsigned long *flags) {}
+static inline void psi_memstall_enter(unsigned long *flags, int mem_state) {}
 static inline void psi_memstall_leave(unsigned long *flags) {}
 
 #ifdef CONFIG_CGROUPS
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 07aaf9b..8200623 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -9,6 +9,8 @@
 
 #ifdef CONFIG_PSI
 
+#define PSI_MASK(x)	((1UL << (x))-1)
+
 /* Tracked task states */
 enum psi_task_count {
 	NR_IOWAIT,
@@ -22,6 +24,10 @@ enum psi_task_count {
 #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
 #define TSK_RUNNING	(1 << NR_RUNNING)
 
+#define TSK_COUNT_MASK	PSI_MASK(NR_PSI_TASK_COUNTS)
+#define TSK_COUNT_SHIFT	8
+
+
 /* Resources that workloads could be stalled on */
 enum psi_res {
 	PSI_IO,
@@ -53,6 +59,27 @@ enum psi_aggregators {
 	NR_PSI_AGGREGATORS,
 };
 
+/* Causes for mem pressure */
+enum psi_memstall_states {
+	PSI_MEM_KSWAPD,
+	PSI_MEM_DRECALAIM,
+	PSI_MEM_KCOMPACTED,
+	PSI_MEM_DCOMPACT,
+	PSI_MEM_CGROUP,
+	PSI_MEM_SWAP,
+	PSI_MEM_WORKINGSET,
+	PSI_MEM_STATES,
+};
+
+#define TSK_MEMSTALL_SHIFT		8
+#define TSK_MEMSTALL_KSWAPD 	(1 << (PSI_MEM_KSWAPD + TSK_MEMSTALL_SHIFT))
+#define TSK_MEMSTALL_DRECLAIM 	(1 << (PSI_MEM_KCOMPACTED + TSK_MEMSTALL_SHIFT))
+#define TSK_MEMSTALL_KCOMPACTED 	(1 << (PSI_MEM_DCOMPACT + TSK_MEMSTALL_SHIFT))
+#define TSK_MEMSTALL_DCOMPACT 	(1 << (PSI_MEM_CGROUP + TSK_MEMSTALL_SHIFT))
+#define TSK_MEMSTALL_CGROUP 	(1 << (PSI_MEM_DRECALAIM + TSK_MEMSTALL_SHIFT))
+#define TSK_MEMSTALL_WORKINGSET 		(1 << (PSI_MEM_WORKINGSET + TSK_MEMSTALL_SHIFT))
+#define TSK_MEMSTALL_MASK	(PSI_MASK(TSK_MEMSTALL_SHIFT) << TSK_COUNT_SHIFT)
+
 struct psi_group_cpu {
 	/* 1st cacheline updated by the scheduler */
 
@@ -64,9 +91,11 @@ struct psi_group_cpu {
 
 	/* Aggregate pressure state derived from the tasks */
 	u32 state_mask;
+	u32 state_memstall;
 
 	/* Period time sampling buckets for each state of interest (ns) */
 	u32 times[NR_PSI_STATES];
+	u32 times_mem[PSI_MEM_STATES];
 
 	/* Time of last task change in this group (rq_clock) */
 	u64 state_start;
@@ -76,6 +105,7 @@ struct psi_group_cpu {
 	/* Delta detection against the sampling buckets */
 	u32 times_prev[NR_PSI_AGGREGATORS][NR_PSI_STATES]
 			____cacheline_aligned_in_smp;
+	u32 times_mem_prev[PSI_MEM_STATES];
 };
 
 /* PSI growth tracking window */
@@ -144,6 +174,10 @@ struct psi_group {
 	u64 total[NR_PSI_AGGREGATORS][NR_PSI_STATES - 1];
 	unsigned long avg[NR_PSI_STATES - 1][3];
 
+	u64 total_mems[PSI_MEM_STATES];
+	unsigned long avg_mems[PSI_MEM_STATES][3];
+	u64 avg_total_mems[PSI_MEM_STATES];
+
 	/* Monitor work control */
 	atomic_t poll_scheduled;
 	struct kthread_worker __rcu *poll_kworker;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 806fc9d..b50ab92 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3613,6 +3613,13 @@ static int cgroup_memory_pressure_show(struct seq_file *seq, void *v)
 
 	return psi_show(seq, psi, PSI_MEM);
 }
+static int cgroup_memory_pressure_stat_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgroup = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup->id == 1 ? &psi_system : &cgroup->psi;
+
+	return psi_mem_pressure_stat_show(seq, psi);
+}
 static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgroup = seq_css(seq)->cgroup;
@@ -4930,6 +4937,10 @@ static struct cftype cgroup_base_files[] = {
 		.poll = cgroup_pressure_poll,
 		.release = cgroup_pressure_release,
 	},
+	{
+		.name = "memory.pressure.stat",
+		.seq_show = cgroup_memory_pressure_stat_show,
+	},
 	{
 		.name = "cpu.pressure",
 		.seq_show = cgroup_cpu_pressure_show,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 9154e74..072d535 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -279,6 +279,35 @@ static void get_recent_times(struct psi_group *group, int cpu,
 	}
 }
 
+static void get_recent_mem_times(struct psi_group *group, int cpu, u32 *times_mem)
+{
+	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+	u64 now, state_start;
+	enum psi_memstall_states s;
+	unsigned int seq;
+	u32 state_mask;
+
+	do {
+		seq = read_seqcount_begin(&groupc->seq);
+		now = cpu_clock(cpu);
+		memcpy(times_mem, groupc->times_mem, sizeof(groupc->times_mem));
+		state_mask = groupc->state_mask;
+		state_start = groupc->state_start;
+	} while (read_seqcount_retry(&groupc->seq, seq));
+
+	for (s = 0; s < PSI_MEM_STATES; s++) {
+		u32 delta;
+
+		if (state_mask & (1 << s))
+			times_mem[s] += now - state_start;
+
+		delta = times_mem[s] - groupc->times_mem_prev[s];
+		groupc->times_mem_prev[s] = times_mem[s];
+
+		times_mem[s] = delta;
+	}
+}
+
 static void calc_avgs(unsigned long avg[3], int missed_periods,
 		      u64 time, u64 period)
 {
@@ -304,6 +333,7 @@ static void collect_percpu_times(struct psi_group *group,
 				 u32 *pchanged_states)
 {
 	u64 deltas[NR_PSI_STATES - 1] = { 0, };
+	u64 delta_mems[PSI_MEM_STATES - 1] = { 0, };
 	unsigned long nonidle_total = 0;
 	u32 changed_states = 0;
 	int cpu;
@@ -319,11 +349,16 @@ static void collect_percpu_times(struct psi_group *group,
 	 */
 	for_each_possible_cpu(cpu) {
 		u32 times[NR_PSI_STATES];
+		u32 times_mem[PSI_MEM_STATES];
+
 		u32 nonidle;
 		u32 cpu_changed_states;
 
 		get_recent_times(group, cpu, aggregator, times,
 				&cpu_changed_states);
+		if (times[PSI_MEM_SOME])
+			get_recent_mem_times(group, cpu, times_mem);
+
 		changed_states |= cpu_changed_states;
 
 		nonidle = nsecs_to_jiffies(times[PSI_NONIDLE]);
@@ -350,6 +385,10 @@ static void collect_percpu_times(struct psi_group *group,
 		group->total[aggregator][s] +=
 				div_u64(deltas[s], max(nonidle_total, 1UL));
 
+	for (s = 0; s < PSI_MEM_STATES - 1; s++)
+		group->total_mems[s] +=
+				div_u64(delta_mems[s], max(nonidle_total, 1UL));
+
 	if (pchanged_states)
 		*pchanged_states = changed_states;
 }
@@ -404,6 +443,16 @@ static u64 update_averages(struct psi_group *group, u64 now)
 		calc_avgs(group->avg[s], missed_periods, sample, period);
 	}
 
+	for (s = 0; s < PSI_MEM_STATES - 1; s++) {
+		u32 sample;
+
+		sample = group->total_mems[s] - group->avg_total_mems[s];
+		if (sample > period)
+			sample = period;
+		group->avg_total_mems[s] += sample;
+		calc_avgs(group->avg_mems[s], missed_periods, sample, period);
+	}
+
 	return avg_next_update;
 }
 
@@ -628,6 +677,7 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 {
 	u32 delta;
 	u64 now;
+	int state_memstall = groupc->state_memstall;
 
 	now = cpu_clock(cpu);
 	delta = now - groupc->state_start;
@@ -641,6 +691,7 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 
 	if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
 		groupc->times[PSI_MEM_SOME] += delta;
+		groupc->times_mem[state_memstall] += delta;
 		if (groupc->state_mask & (1 << PSI_MEM_FULL))
 			groupc->times[PSI_MEM_FULL] += delta;
 		else if (memstall_tick) {
@@ -676,7 +727,12 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
 	unsigned int t, m;
 	enum psi_states s;
 	u32 state_mask = 0;
+	u32 state_memstall = 0;
 
+	if (set & TSK_MEMSTALL) {
+		state_memstall = set & TSK_MEMSTALL_MASK;
+		set &= TSK_COUNT_MASK;
+	}
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
 	/*
@@ -714,7 +770,7 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
 			state_mask |= (1 << s);
 	}
 	groupc->state_mask = state_mask;
-
+	groupc->state_memstall = state_memstall;
 	write_seqcount_end(&groupc->seq);
 
 	return state_mask;
@@ -810,7 +866,7 @@ void psi_memstall_tick(struct task_struct *task, int cpu)
  * Marks the calling task as being stalled due to a lack of memory,
  * such as waiting for a refault or performing reclaim.
  */
-void psi_memstall_enter(unsigned long *flags)
+void psi_memstall_enter(unsigned long *flags, int mem_state)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -829,7 +885,7 @@ void psi_memstall_enter(unsigned long *flags)
 	rq = this_rq_lock_irq(&rf);
 
 	current->flags |= PF_MEMSTALL;
-	psi_task_change(current, 0, TSK_MEMSTALL);
+	psi_task_change(current, 0, TSK_MEMSTALL | mem_state);
 
 	rq_unlock_irq(rq, &rf);
 }
@@ -840,7 +896,7 @@ void psi_memstall_enter(unsigned long *flags)
  *
  * Marks the calling task as no longer stalled due to lack of memory.
  */
-void psi_memstall_leave(unsigned long *flags)
+void psi_memstall_leave(unsigned long *flags, int mem_state)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -858,7 +914,7 @@ void psi_memstall_leave(unsigned long *flags)
 	rq = this_rq_lock_irq(&rf);
 
 	current->flags &= ~PF_MEMSTALL;
-	psi_task_change(current, TSK_MEMSTALL, 0);
+	psi_task_change(current, TSK_MEMSTALL | mem_state, 0);
 
 	rq_unlock_irq(rq, &rf);
 }
@@ -974,6 +1030,53 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	return 0;
 }
 
+const char * const memstall_text[] = {
+	"kswapd",
+	"direct reclaim",
+	"kcompacted",
+	"direct compact",
+	"cgroup reclaim",
+	"swap",
+	"workingset",
+};
+
+int psi_mem_pressure_stat_show(struct seq_file *m, void *v)
+{
+	int s;
+	u64 now;
+	struct psi_group *group = &psi_system;
+
+	if (static_branch_likely(&psi_disabled))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&group->avgs_lock);
+	now = sched_clock();
+	collect_percpu_times(group, PSI_AVGS, NULL);
+	if (now >= group->avg_next_update)
+		group->avg_next_update = update_averages(group, now);
+	mutex_unlock(&group->avgs_lock);
+
+	for (s = 0; s < PSI_MEM_STATES; s++) {
+		unsigned long avg[3];
+		u64 total;
+		int w;
+
+		for (w = 0; w < 3; w++)
+			avg[w] = group->avg_mems[s][w];
+
+		total = div_u64(group->total_mems[PSI_AVGS], NSEC_PER_USEC);
+
+		seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu\n",
+			   memstall_text[s],
+			   LOAD_INT(avg[0]), LOAD_FRAC(avg[0]),
+			   LOAD_INT(avg[1]), LOAD_FRAC(avg[1]),
+			   LOAD_INT(avg[2]), LOAD_FRAC(avg[2]),
+			   total);
+	}
+
+	return 0;
+}
+
 static int psi_io_show(struct seq_file *m, void *v)
 {
 	return psi_show(m, &psi_system, PSI_IO);
@@ -998,7 +1101,10 @@ static int psi_memory_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, psi_memory_show, NULL);
 }
-
+static int psi_memory_stat_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, psi_mem_pressure_stat_show, NULL);
+}
 static int psi_cpu_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, psi_cpu_show, NULL);
@@ -1271,7 +1377,12 @@ static const struct file_operations psi_memory_fops = {
 	.poll           = psi_fop_poll,
 	.release        = psi_fop_release,
 };
-
+static const struct file_operations psi_memory_stat_fops = {
+	.open           = psi_memory_stat_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = psi_fop_release,
+};
 static const struct file_operations psi_cpu_fops = {
 	.open           = psi_cpu_open,
 	.read           = seq_read,
@@ -1286,6 +1397,7 @@ static int __init psi_proc_init(void)
 	proc_mkdir("pressure", NULL);
 	proc_create("pressure/io", 0, NULL, &psi_io_fops);
 	proc_create("pressure/memory", 0, NULL, &psi_memory_fops);
+	proc_create("pressure/memory_stat", 0, NULL, &psi_memory_stat_fops);
 	proc_create("pressure/cpu", 0, NULL, &psi_cpu_fops);
 	return 0;
 }
-- 
2.15.2

