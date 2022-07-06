Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4DA5686C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiGFLhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiGFLhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:37:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F40237E9;
        Wed,  6 Jul 2022 04:37:15 -0700 (PDT)
Date:   Wed, 06 Jul 2022 11:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657107433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnFEP30906b4Edt/fgcggscUXaptYq0c9bLgh4Tdzhc=;
        b=rpHEDvzPLv92TMiq83i2+Dqpoi7t+Y4lHYO3LBIVSNiuxFMKzmQo/aG29gaDt1DmBrTRUW
        TW7E781q4PfpkVtA3Q7yxXW5B0969+KoUSl8SRaHYWa5nJbJiiR8hxcSElyN5pQJYr6mta
        z+6Bgo4ZYQG7bF0B7E9Jmh/jUhoREYmBPFX+QD0ZQx49HqlfdkjQmBRkRqrjUoPT4oGqY1
        e3AdlTO0LrheOJMGqsLAEjpehom5mmKDkGceY1K3okEQXiXyKXNlTnaHFW9GX5xpGnAEy8
        bIGooSGS/lvw9RpZfMFSwMzfQ7HlVw8oprz9eCGUWCDytRcz47a0phyJGosbAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657107433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnFEP30906b4Edt/fgcggscUXaptYq0c9bLgh4Tdzhc=;
        b=QNGZkdqzbfn1ASjeaL29ytqfctOM3RVvldyO+0OgqQCvnZzadlLEGt4P23K7HGv7S5j1JS
        ifQJxDQNE/ty1mAQ==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: add forced idle accounting for cgroups
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220629211426.3329954-1-joshdon@google.com>
References: <20220629211426.3329954-1-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <165710743261.15455.2981731024307596274.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1fcf54deb767d474181ad7cf33c92bb2a33607fb
Gitweb:        https://git.kernel.org/tip/1fcf54deb767d474181ad7cf33c92bb2a33607fb
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Wed, 29 Jun 2022 14:14:26 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 04 Jul 2022 09:23:07 +02:00

sched/core: add forced idle accounting for cgroups

4feee7d1260 previously added per-task forced idle accounting. This patch
extends this to also include cgroups.

rstat is used for cgroup accounting, except for the root, which uses
kcpustat in order to bypass the need for doing an rstat flush when
reading root stats.

Only cgroup v2 is supported. Similar to the task accounting, the cgroup
accounting requires that schedstats is enabled.

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lkml.kernel.org/r/20220629211426.3329954-1-joshdon@google.com
---
 include/linux/cgroup-defs.h |  4 +++-
 include/linux/kernel_stat.h |  7 ++++++-
 kernel/cgroup/rstat.c       | 44 +++++++++++++++++++++++++++++++-----
 kernel/sched/core_sched.c   |  6 ++++-
 kernel/sched/cputime.c      | 15 ++++++++++++-
 5 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1bfcfb1..025fd0e 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -287,6 +287,10 @@ struct css_set {
 
 struct cgroup_base_stat {
 	struct task_cputime cputime;
+
+#ifdef CONFIG_SCHED_CORE
+	u64 forceidle_sum;
+#endif
 };
 
 /*
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 69ae6b2..ddb5a35 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -28,6 +28,9 @@ enum cpu_usage_stat {
 	CPUTIME_STEAL,
 	CPUTIME_GUEST,
 	CPUTIME_GUEST_NICE,
+#ifdef CONFIG_SCHED_CORE
+	CPUTIME_FORCEIDLE,
+#endif
 	NR_STATS,
 };
 
@@ -115,4 +118,8 @@ extern void account_process_tick(struct task_struct *, int user);
 
 extern void account_idle_ticks(unsigned long ticks);
 
+#ifdef CONFIG_SCHED_CORE
+extern void __account_forceidle_time(struct task_struct *tsk, u64 delta);
+#endif
+
 #endif /* _LINUX_KERNEL_STAT_H */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 24b5c2a..feb5938 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -310,6 +310,9 @@ static void cgroup_base_stat_add(struct cgroup_base_stat *dst_bstat,
 	dst_bstat->cputime.utime += src_bstat->cputime.utime;
 	dst_bstat->cputime.stime += src_bstat->cputime.stime;
 	dst_bstat->cputime.sum_exec_runtime += src_bstat->cputime.sum_exec_runtime;
+#ifdef CONFIG_SCHED_CORE
+	dst_bstat->forceidle_sum += src_bstat->forceidle_sum;
+#endif
 }
 
 static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
@@ -318,6 +321,9 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 	dst_bstat->cputime.utime -= src_bstat->cputime.utime;
 	dst_bstat->cputime.stime -= src_bstat->cputime.stime;
 	dst_bstat->cputime.sum_exec_runtime -= src_bstat->cputime.sum_exec_runtime;
+#ifdef CONFIG_SCHED_CORE
+	dst_bstat->forceidle_sum -= src_bstat->forceidle_sum;
+#endif
 }
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
@@ -398,6 +404,11 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
 	case CPUTIME_SOFTIRQ:
 		rstatc->bstat.cputime.stime += delta_exec;
 		break;
+#ifdef CONFIG_SCHED_CORE
+	case CPUTIME_FORCEIDLE:
+		rstatc->bstat.forceidle_sum += delta_exec;
+		break;
+#endif
 	default:
 		break;
 	}
@@ -411,8 +422,9 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
  * with how it is done by __cgroup_account_cputime_field for each bit of
  * cpu time attributed to a cgroup.
  */
-static void root_cgroup_cputime(struct task_cputime *cputime)
+static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 {
+	struct task_cputime *cputime = &bstat->cputime;
 	int i;
 
 	cputime->stime = 0;
@@ -438,6 +450,10 @@ static void root_cgroup_cputime(struct task_cputime *cputime)
 		cputime->sum_exec_runtime += user;
 		cputime->sum_exec_runtime += sys;
 		cputime->sum_exec_runtime += cpustat[CPUTIME_STEAL];
+
+#ifdef CONFIG_SCHED_CORE
+		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
+#endif
 	}
 }
 
@@ -445,27 +461,43 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
 	u64 usage, utime, stime;
-	struct task_cputime cputime;
+	struct cgroup_base_stat bstat;
+#ifdef CONFIG_SCHED_CORE
+	u64 forceidle_time;
+#endif
 
 	if (cgroup_parent(cgrp)) {
 		cgroup_rstat_flush_hold(cgrp);
 		usage = cgrp->bstat.cputime.sum_exec_runtime;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
 			       &utime, &stime);
+#ifdef CONFIG_SCHED_CORE
+		forceidle_time = cgrp->bstat.forceidle_sum;
+#endif
 		cgroup_rstat_flush_release();
 	} else {
-		root_cgroup_cputime(&cputime);
-		usage = cputime.sum_exec_runtime;
-		utime = cputime.utime;
-		stime = cputime.stime;
+		root_cgroup_cputime(&bstat);
+		usage = bstat.cputime.sum_exec_runtime;
+		utime = bstat.cputime.utime;
+		stime = bstat.cputime.stime;
+#ifdef CONFIG_SCHED_CORE
+		forceidle_time = bstat.forceidle_sum;
+#endif
 	}
 
 	do_div(usage, NSEC_PER_USEC);
 	do_div(utime, NSEC_PER_USEC);
 	do_div(stime, NSEC_PER_USEC);
+#ifdef CONFIG_SCHED_CORE
+	do_div(forceidle_time, NSEC_PER_USEC);
+#endif
 
 	seq_printf(seq, "usage_usec %llu\n"
 		   "user_usec %llu\n"
 		   "system_usec %llu\n",
 		   usage, utime, stime);
+
+#ifdef CONFIG_SCHED_CORE
+	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
+#endif
 }
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 38a2cec..5103502 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -277,7 +277,11 @@ void __sched_core_account_forceidle(struct rq *rq)
 		if (p == rq_i->idle)
 			continue;
 
-		__schedstat_add(p->stats.core_forceidle_sum, delta);
+		/*
+		 * Note: this will account forceidle to the current cpu, even
+		 * if it comes from our SMT sibling.
+		 */
+		__account_forceidle_time(p, delta);
 	}
 }
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 78a233d..95fc778 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -226,6 +226,21 @@ void account_idle_time(u64 cputime)
 		cpustat[CPUTIME_IDLE] += cputime;
 }
 
+
+#ifdef CONFIG_SCHED_CORE
+/*
+ * Account for forceidle time due to core scheduling.
+ *
+ * REQUIRES: schedstat is enabled.
+ */
+void __account_forceidle_time(struct task_struct *p, u64 delta)
+{
+	__schedstat_add(p->stats.core_forceidle_sum, delta);
+
+	task_group_account_field(p, CPUTIME_FORCEIDLE, delta);
+}
+#endif
+
 /*
  * When a guest is interrupted for a longer amount of time, missed clock
  * ticks are not redelivered later. Due to that, this function may on
