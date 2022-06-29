Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0069F560B73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiF2VOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiF2VOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:14:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4D43EA99
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:14:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3177608c4a5so137253537b3.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JkyjHjPdtkclm0+uDLujhsk5SWKIJ65+tfNQvDnfTDg=;
        b=la00TFKPKdX5y6e/J4PidIx0KvRtla/rNZDlcJotoF/aRdBrzZBAMTYq93AHmjkOvH
         yZLO2RPbXfQbLfBLviw1JJvsQMgMfxVttdm4edh/ycjDF2V4G+p/4E03fyN9MhoRkjT8
         YMDlKOixsrqB819E25xpVfpA4h+Xma9K7pLnbNO4YNHqs3Iux9CT2tY7ay/TBvKafFlM
         /idWaFGi352lCoKMIMlRCvnZ7ZqxOYIkx56kCIZmCQZQ2wIGZ0qMDOhqg2hL+oBk6db0
         KJ/nziNfEMZJd1SM2VX2XT5OmFiNDPfXczYFYiZnLRfXeozylL9N0HzKiPtK0sQUnUxw
         Xp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JkyjHjPdtkclm0+uDLujhsk5SWKIJ65+tfNQvDnfTDg=;
        b=ia6OLiWEKBTDANeW6jqFOfvDd2ofxsVQZa/SwZQp032QF6Dh1llnrttwRw+MLgiieh
         q7KBZy9tWf9BD+FG5UQ1bxwYdcvclC0cXiklJbSHOCQw5Oo6ohY0O0QPBxdyTLvKkg47
         g4HdF/1pfO5Gx4f2x9rRWDnb4iLnzmR1m1wF05egDgM8veOEJpUv2hKhbnmkOQqibPHA
         dxyIaB8aTbIHtPXr/V3iURpMYjuFIYk4kVOxbMXibZ5UZT4Wb6pbVnDe2xc+NMHOthP/
         eH0Jfa0WR6siSSoDMnVa28FJibo+Heznf6euDTloEQvnhLKoaeYaRtG4ZaFaSI6aQl11
         FszQ==
X-Gm-Message-State: AJIora8X4R8f6sPFxh2KWhjUZoTl3Ckh2X2y6Fq7bGvoh1CeTpUd2SX6
        5RD3Ot8CdF53I/GyirAoR0AgVMV6lx3B
X-Google-Smtp-Source: AGRyM1tq830+v7T5vpblx3/ckdnFNfLn5FkjO8ydOgqBW70ycsN8PoLDnY0vk1vG+764DD6lrzOZ1qzuWG7F
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:4585:eb52:4688:ecde])
 (user=joshdon job=sendgmr) by 2002:a81:5002:0:b0:317:b1c4:e10b with SMTP id
 e2-20020a815002000000b00317b1c4e10bmr6313678ywb.120.1656537291845; Wed, 29
 Jun 2022 14:14:51 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:14:26 -0700
Message-Id: <20220629211426.3329954-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4] sched/core: add forced idle accounting for cgroups
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
Acked-by: Tejun Heo <tj@kernel.org>
---
v4: Replace 'forceidle_usec' with 'core_sched.force_idle_usec'
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
index 24b5c2ab5598..feb59380c896 100644
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
2.37.0.rc0.161.g10f37bed90-goog

