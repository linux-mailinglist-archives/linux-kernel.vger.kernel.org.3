Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D2752F669
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354127AbiETXvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351624AbiETXvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:51:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E4760D95
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:51:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i17-20020a259d11000000b0064cd3084085so8414553ybp.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/stGQNozz5V8ZxaoJoUYmWkt2650UWUR5BTuTMQhVcc=;
        b=NJ7NjIJHlpowz+JfL9ai/1suG6Hi1I8ypXAV6Cu8lQY2KEo256KEZuwu7LUDmKiB2Y
         5Ux18dTA4YBTkHxmyYtMQ3JiaUR/578U6QdBJYn4AyBOjUYMPsCguArfQgSjDkHhQs4z
         VEZ3lqxR4VJEBkxBvNgIupKXK1uBJ6X3VpGraksQ7TWlPV3P1pqnDZGvoCP/XsaTSCsL
         iX2YtY55G/v/IkArAjqO/Q/KZTyYq6i+IHf1rgeQAjOY+udqayIIRmV2DruTw4RCgWjP
         kC3wMvMQ1fRcOcdkCmQi1jO18Mcm1mnI963TkCF/jvX81RvUHRwAj5YPhEfzzO7Sa5dV
         8rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/stGQNozz5V8ZxaoJoUYmWkt2650UWUR5BTuTMQhVcc=;
        b=1KKH0QUS+alP1qeCAjfzADkPz7SgQzWrARrsoZpyz8lDM+zTHJ848VdueBaUYtOBxK
         KaNV30Ln+/P14eIAcdjS2zOiQzWA91jVvuOrYDBt+rcz9g2vurA9Od9+ahUO5H0aLWm4
         qqAfUqQbnSDpuH56WCgLEpQxIxIqpCsQROoBYPouGZlNpfWw5/aMs6lAGr6iACtrQUMv
         5BuxbZtGizkUsKjTdzuWS84wO5LgciqVfUriEm38TTTrJ5OKN/tcGi5FjrylmOR2ZCnk
         dda1aV9jRZHsyr9ItgbJiHMEdl3pSINrM5LLEBfK64gobuTs3IgPEVXiGdMPidd7xC6u
         7QOQ==
X-Gm-Message-State: AOAM533ZisAd9zx2o2YH87XNm/jiMzAwQqrRckyOzxEIsT6k9PgLlPuB
        ssiv6Kt7/l6SaqnAMWcmPRdaexKu7QK/
X-Google-Smtp-Source: ABdhPJyaJEr7h3tfFxG4TXTNGXbQm1jTGaXXwg70TJIHHZqZbcmU/Eovy7+w//t4heTmIWu5D61vyi5xDS9e
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:d765:af15:7d42:5e08])
 (user=joshdon job=sendgmr) by 2002:a05:6902:136c:b0:649:81aa:5f7b with SMTP
 id bt12-20020a056902136c00b0064981aa5f7bmr11995294ybb.303.1653090707850; Fri,
 20 May 2022 16:51:47 -0700 (PDT)
Date:   Fri, 20 May 2022 16:51:38 -0700
Message-Id: <20220520235138.3140590-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v2] sched/core: add forced idle accounting for cgroups
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
v2: Per Tejun's suggestion, move the forceidle stat to cgroup_base_stat
directly.

 include/linux/cgroup-defs.h |  4 ++++
 include/linux/kernel_stat.h |  7 +++++++
 kernel/cgroup/rstat.c       | 40 +++++++++++++++++++++++++++++++------
 kernel/sched/core_sched.c   |  6 +++++-
 kernel/sched/cputime.c      | 11 ++++++++++
 5 files changed, 61 insertions(+), 7 deletions(-)

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
index 69ae6b278464..94f435ce1df0 100644
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
+extern void account_forceidle_time(struct task_struct *tsk, u64 delta);
+#endif
+
 #endif /* _LINUX_KERNEL_STAT_H */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 24b5c2ab5598..d873de6f8716 100644
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
 
@@ -445,27 +461,39 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
 	u64 usage, utime, stime;
-	struct task_cputime cputime;
+	struct cgroup_base_stat bstat;
+	u64 __maybe_unused forceidle_time;
 
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
+	do_div(forceidle_time, NSEC_PER_USEC);
 
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
index 38a2cec21014..ddef2b8ddf68 100644
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
+		account_forceidle_time(p, delta);
 	}
 }
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 78a233d43757..598d1026d629 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -226,6 +226,17 @@ void account_idle_time(u64 cputime)
 		cpustat[CPUTIME_IDLE] += cputime;
 }
 
+
+#ifdef CONFIG_SCHED_CORE
+/* Account for forceidle time due to core scheduling. */
+void account_forceidle_time(struct task_struct *p, u64 delta)
+{
+	schedstat_add(p->stats.core_forceidle_sum, delta);
+
+	task_group_account_field(p, CPUTIME_FORCEIDLE, delta);
+}
+#endif
+
 /*
  * When a guest is interrupted for a longer amount of time, missed clock
  * ticks are not redelivered later. Due to that, this function may on
-- 
2.36.1.124.g0e6072fb45-goog

