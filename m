Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994CA525922
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359813AbiEMAyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241356AbiEMAyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:54:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2EF28B862
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:54:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l26-20020a25ad5a000000b0064adb7991f6so5987738ybe.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9WYd2rtxaDZCyqlU8hrUJ4izuxc3n01UNTUNj7G5bxQ=;
        b=jzpCDIymhebkWy+KOqWXx2Df8k+EPty6MegJfzM5H3XE/cKGodeWAwVB2DNDKoS8yo
         TiiU9Vsc60VHEXTkLXEcgAXnyAGwhavNYbsu7sGppoHJkisMsjxGVP7gbAEfIZ5aY3DF
         5S1Ufm8uom4XPXISu7PLFP/X7wjxe89iD2UnnGR8rN8BicMOiI7skOs2YhMaXdEzmvFG
         RUKxn+vGHysPaBFOm9JhBVrzPBgWzFF2xeb91O1o+imOrxXVuMUUW2+3vWB86uBCncVK
         zXKED400kmrNBjDfeEXp1FP4Y+ZQx1LoAmdHIEg1VxE3IoKbmFo9sMVFu91uT/3yWDbz
         5Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9WYd2rtxaDZCyqlU8hrUJ4izuxc3n01UNTUNj7G5bxQ=;
        b=OPPmyBrDIADDGyefTiI0DF7rohI2QUCSK8DBS7HmK6p9qcOBj9m1bPvd2drJ+2vx2/
         bDJFv5NvFaySb1wNlbCE6U4u4aCr33z6NFCtjkVeAzjeM5nmmEl5bf/0R2zixyqVwpuc
         t/csTXf8Jx7ZTaiKDIXkgewQGdmhwkWIwbKvELqZIFOr+scwTEazaza/hsrVJwtl1HAe
         N/0ElVKqIOXZzgNe8dFRDuaN4bALFGFrwC/QLnRifsAfT2RwjoHP2gOnI1prwXhF+cWg
         G0tLEMv8po+5c6qAIkVtTfwRQghwMPVbZRFyrwMVggec5qqu/IOjqdDUJvCoTgv/XZGA
         Kqdw==
X-Gm-Message-State: AOAM531dr/V+GrgorG7klCO51Z5kEoEeG1nVT1ci+hRmhXuRba6+JA1G
        Slp7T4/xqKwfPotKYevGPzGH/YxODrc5
X-Google-Smtp-Source: ABdhPJxQWkEFy79Kpxf2yha4fRhd91dMDnCakmbtQ6tZu3VqMI7tYo73lzA8q+Wm2ut/mv6iZJeP7G1b6304
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:23eb:d421:68f0:28e2])
 (user=joshdon job=sendgmr) by 2002:a25:3cd:0:b0:64a:b29a:9539 with SMTP id
 196-20020a2503cd000000b0064ab29a9539mr2482475ybd.534.1652403290679; Thu, 12
 May 2022 17:54:50 -0700 (PDT)
Date:   Thu, 12 May 2022 17:54:27 -0700
Message-Id: <20220513005427.2507335-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH] sched/core: add forced idle accounting for cgroups
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4feee7d1260 previously added per-task forced idle accounting. This patch
extends this to also include cgroups.

rstat is used for cgroup accounting, except for the root, which uses
kcpustat in order to bypass the need for doing an rstat flush when
reading root stats.

Only cgroup v2 is supported. Similar to the task accounting, the cgroup
accounting requires that schedstats is enabled.

Signed-off-by: Josh Don <joshdon@google.com>
---
 include/linux/kernel_stat.h |  1 +
 kernel/sched/core.c         | 15 ++++++++-
 kernel/sched/core_sched.c   | 62 +++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h        | 18 +++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 69ae6b278464..2e9b3c7d2f18 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -28,6 +28,7 @@ enum cpu_usage_stat {
 	CPUTIME_STEAL,
 	CPUTIME_GUEST,
 	CPUTIME_GUEST_NICE,
+	CPUTIME_FORCEIDLE,
 	NR_STATS,
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 48cfad152b86..a29cb4029818 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10828,12 +10828,18 @@ static struct cftype cpu_legacy_files[] = {
 	{ }	/* Terminate */
 };
 
+static void cpu_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+{
+	sched_core_rstat_flush(css_tg(css), cpu);
+}
+
 static int cpu_extra_stat_show(struct seq_file *sf,
 			       struct cgroup_subsys_state *css)
 {
+	struct task_group __maybe_unused *tg = css_tg(css);
+
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
-		struct task_group *tg = css_tg(css);
 		struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
 		u64 throttled_usec, burst_usec;
 
@@ -10851,6 +10857,12 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 			   throttled_usec, cfs_b->nr_burst, burst_usec);
 	}
 #endif
+
+#ifdef CONFIG_SCHED_CORE
+	/* already updated stats via rstat flush */
+	seq_printf(sf, "forceidle_usec %llu\n",
+			sched_core_forceidle_sum(tg) / NSEC_PER_USEC);
+#endif
 	return 0;
 }
 
@@ -11031,6 +11043,7 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_online	= cpu_cgroup_css_online,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
+	.css_rstat_flush = cpu_cgroup_css_rstat_flush,
 	.css_extra_stat_show = cpu_extra_stat_show,
 	.fork		= cpu_cgroup_fork,
 	.can_attach	= cpu_cgroup_can_attach,
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 38a2cec21014..ccfeef6542dc 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -277,7 +277,16 @@ void __sched_core_account_forceidle(struct rq *rq)
 		if (p == rq_i->idle)
 			continue;
 
+		/* thread accounting */
 		__schedstat_add(p->stats.core_forceidle_sum, delta);
+
+		/* root accounting */
+		kcpustat_cpu(i).cpustat[CPUTIME_FORCEIDLE] += delta;
+
+		/* cgroup accounting */
+#ifdef CONFIG_FAIR_GROUP_SCHED
+		task_group(p)->cfs_rq[i]->forceidle_sum += delta;
+#endif
 	}
 }
 
@@ -292,4 +301,57 @@ void __sched_core_tick(struct rq *rq)
 	__sched_core_account_forceidle(rq);
 }
 
+void sched_core_rstat_flush(struct task_group *tg, int cpu)
+{
+	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
+	struct task_group *parent = tg->parent;
+	u64 delta, curr_sum;
+
+	/* root uses cpustat */
+	if (!parent)
+		return;
+
+	/*
+	 * Note: cgroup_rstat_lock protects cfs_rq->forceidle_sum_prev and
+	 * tg->{forceidle_sum, forceidle_sum_pending}.
+	 */
+
+	delta = tg->forceidle_sum_pending;
+	if (delta)
+		tg->forceidle_sum_pending = 0;
+
+	/* rq lock not held; value may change concurrently */
+	curr_sum = READ_ONCE(cfs_rq->forceidle_sum);
+	if (curr_sum != cfs_rq->forceidle_sum_prev) {
+		delta += curr_sum - cfs_rq->forceidle_sum_prev;
+		cfs_rq->forceidle_sum_prev = curr_sum;
+	}
+
+	if (!delta)
+		return;
+
+	tg->forceidle_sum += delta;
+	parent->forceidle_sum_pending += delta;
+}
+
+/* REQUIRES: If tg is not root, an rstat flush was recently done. */
+u64 sched_core_forceidle_sum(struct task_group *tg)
+{
+	if (!tg->parent) {
+		u64 sum = 0;
+		int i;
+
+		for_each_possible_cpu(i) {
+			struct kernel_cpustat kcpustat;
+
+			kcpustat_cpu_fetch(&kcpustat, i);
+			sum += kcpustat.cpustat[CPUTIME_FORCEIDLE];
+		}
+
+		return sum;
+	} else {
+		return tg->forceidle_sum;
+	}
+}
+
 #endif /* CONFIG_SCHEDSTATS */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7f338c53ce42..36bef97b9e2f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -425,6 +425,12 @@ struct task_group {
 	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif
 
+#ifdef CONFIG_SCHED_CORE
+	/* used with rstat */
+	u64			forceidle_sum;
+	u64			forceidle_sum_pending;
+#endif
+
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -526,6 +532,10 @@ struct cfs_rq {
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
 	u64			min_vruntime_fi;
+
+	/* for accounting with rstat */
+	u64			forceidle_sum;
+	u64			forceidle_sum_prev;
 #endif
 
 #ifndef CONFIG_64BIT
@@ -1849,12 +1859,20 @@ static inline void sched_core_tick(struct rq *rq)
 		__sched_core_tick(rq);
 }
 
+extern void sched_core_rstat_flush(struct task_group *tg, int cpu);
+
+extern u64 sched_core_forceidle_sum(struct task_group *tg);
+
 #else
 
 static inline void sched_core_account_forceidle(struct rq *rq) {}
 
 static inline void sched_core_tick(struct rq *rq) {}
 
+static inline void sched_core_rstat_flush(struct task_group *tg, int cpu) {}
+
+static inline u64 sched_core_forceidle_sum(struct task_group *tg) { return 0; }
+
 #endif /* CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS */
 
 #ifdef CONFIG_CGROUP_SCHED
-- 
2.36.0.512.ge40c2bad7a-goog

