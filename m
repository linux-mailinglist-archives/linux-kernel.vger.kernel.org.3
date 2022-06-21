Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92385553F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 01:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355172AbiFUXpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 19:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiFUXpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 19:45:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AF3313B0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:45:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h82-20020a25d055000000b00668b6a4ee32so11162551ybg.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OeZ1TPP4UVsB1asb0DIA2kotVKNpvnWh+JASl2wR8Ns=;
        b=BFp5nG/nqwJ0SFAw4Eg1f9y9zVw8lXPsLnw0nRJUkaUn7rLJOh5clLOmMBe2A75ptr
         RH/QjGlgaeg3zPYHs37orlBV5caZNXumOCBQ/tJEupcG3QmtqszTG9iv7PswREGrjzF8
         uEa7CncQRXDPU9KPfnfPkHz8+Sn+nkPNIdyUtolUy3w+CCeI3Ym7uTuITkMjtUdR7wwe
         DfxcP3MoyxWQ9bMWcxBJ5DRbHRjrx+OPSnuEZee2dkOOhIxDujBfu2Uv0KXavTYP3slw
         vNcb05LNdjEK3ZcNlG+weJToAVb5g7n5HFNSoE3Ym/UAy8tC5QcTK98pwnv0DBZM370D
         phNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OeZ1TPP4UVsB1asb0DIA2kotVKNpvnWh+JASl2wR8Ns=;
        b=b1b28wbWYp/udtRptX9iJXvpwcsTzpvtAw8DZ1JB810GxhDGut9IoLCaPJmNlOA7o/
         JL/z+7kJqSQgphQ0Y/URkXp9X/zzI0dbmgp5dlBOfFTzm0mw2WwApPU6lEofD57EGN8I
         q7MAPc6eM1DNUjCYQoBBAyDsKDMwJ9PJbsbsZDEfRMwyK156ztiaX4+eH3B9UBYORCdk
         IFl09vic8RctrDwGQ5gO/41Wr6Z2QbGHVbEDEZY8T7zjkG+cQC9TO18pEMiGMzZNGUtd
         0QcNfcfNvOZqO7zt+OO4st2izF9xSnNfFundQdhFbcvdJErBaJNxOmdUXr71iJz9AgB/
         PfkQ==
X-Gm-Message-State: AJIora/QBRiVPv1qgF6B7ZDeExa5BdwALmLuPN6LO5ifHJ+5Rh90yHC/
        N7fWoup8JkK+wndxuCo/rGOW0UKkV2Hy
X-Google-Smtp-Source: AGRyM1uYenwp+AG0ERf5ihu7H0hYKmiAK9w6eU3aEfO8uIbLmENLNzxmcX1EWl1LCHjFe7ZjLfCUVB1QSmGB
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:9725:1fd6:6f9c:fbb8])
 (user=joshdon job=sendgmr) by 2002:a25:8e09:0:b0:664:f501:c66f with SMTP id
 p9-20020a258e09000000b00664f501c66fmr784358ybl.210.1655855101930; Tue, 21 Jun
 2022 16:45:01 -0700 (PDT)
Date:   Tue, 21 Jun 2022 16:44:43 -0700
Message-Id: <20220621234443.3506529-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v3] sched/core: add forced idle accounting for cgroups
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>,
        Josh Don <joshdon@google.com>
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
v3: Fix build error, and revert back to  __schedstat_*
v2: Per Tejun's suggestion, move the forceidle stat to cgroup_base_stat
directly.

 include/linux/cgroup-defs.h |  4 ++++
 include/linux/kernel_stat.h |  7 ++++++
 kernel/cgroup/rstat.c       | 44 ++++++++++++++++++++++++++++++++-----
 kernel/sched/core_sched.c   |  6 ++++-
 kernel/sched/cputime.c      | 15 +++++++++++++
 5 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1bfcfb1af352..025fd0e84a31 100644
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
index 69ae6b278464..ddb5a358fd82 100644
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
index 24b5c2ab5598..504478522df7 100644
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
+	seq_printf(seq, "forceidle_usec %llu\n", forceidle_time);
+#endif
 }
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 38a2cec21014..5103502da7ba 100644
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
index 78a233d43757..95fc77853743 100644
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
-- 
2.37.0.rc0.104.g0611611a94-goog

