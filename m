Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEDE5252B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356541AbiELQgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356538AbiELQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:36:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF5C31DE3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:36:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i5so7995141wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZ+cPXjmqfKw6LKdcOiouNM9M6CBtUVVz2k9yXqujII=;
        b=LX9Fkr7EQnY8W5Qv2qxOxP8aCz3OOa64JUi3eeH/tGC+2qsuq6fPSylaf64XlOVVlV
         WxZstwMG+8qcxLe2++EGRC5nQGvoO/7Q/hVueiUBxATfAaoHyPMihthyOjYbjN2YXDc3
         LyZGThDxrWPmr1uaM+786K/V+Bv5lJfSeiWOsabWPADr0R0E7sLcpCyr/xwv+8FVx7Bh
         koOCu801fj3g9iV4ysv1StxH9qlKW+XUAIJHIP0ZgtMjnayUfWlihPdq4bqRv4cYx4LN
         u0FcYRIpHTdXmFZhhekrrnNT0tGqf1yDyyij7bTYXIuhU5oHwZ7nhnQ9jdJYiAitKw3y
         gN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZ+cPXjmqfKw6LKdcOiouNM9M6CBtUVVz2k9yXqujII=;
        b=sypni5G6cPbPM/pdlheP1Sd59TmxbglPH7/aOg8zIwCqXYicJ4CRFNGh6aCX5k80P7
         +n1eHacbvG8/bmaRto6JrB3Du1U6k+oZaFspg33CvMyMBtH/2pWEU32ZGJpy9uJ1QcSg
         IrKV9EhUZRE3gvK7K6SVyp0qZu3kq29gjf4pAJobqiJ+7h6LqMm0j1Zc0ZQPQGTZCuQR
         zCD+DLxPpg40HR9ZJXEVVexE+TSg+XWg0VTDdeIm/44d2ERViJtGn8nt+pxgLCiyFlDf
         ItZGrBO/mzvi7AgKOwiC09AZfXuRa9qRQ9+KgpxALtGui3bQ7lsAtSyNxHH3EdQ/OESw
         DB+g==
X-Gm-Message-State: AOAM531DwdbOzimLQRZMFtaTkuu7PIDdLfcVz68De5TYN9bG+bYuUaUp
        rGOLhYvVkNQbZe8H+WR5bNingQ==
X-Google-Smtp-Source: ABdhPJxe0lnU0gggw+cBKiJWFidl3tjZJIpUHtSMKXYqD8FfeUQkyoPj4uQt0mY7lvEAKK8gAFUWZg==
X-Received: by 2002:a5d:5441:0:b0:20a:cdc0:6e90 with SMTP id w1-20020a5d5441000000b0020acdc06e90mr467256wrv.566.1652373360011;
        Thu, 12 May 2022 09:36:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:253e:ae0a:544b:2cb1])
        by smtp.gmail.com with ESMTPSA id j25-20020adfa799000000b0020c5253d8dbsm21814wrc.39.2022.05.12.09.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:35:59 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 5/7] sched/fair: Take into account latency nice at wakeup
Date:   Thu, 12 May 2022 18:35:32 +0200
Message-Id: <20220512163534.2572-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220512163534.2572-1-vincent.guittot@linaro.org>
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account the nice latency priority of a thread when deciding to
preempt the current running thread. We don't want to provide more CPU
bandwidth to a thread but reorder the scheduling to run latency sensitive
task first whenever possible.

As long as a thread didn't use its bandwidth, it will be able to preempt
the current thread.

At the opposite, a thread with a low latency priority will preempt current
thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
wait for the tick to get its sched slice.

                                   curr vruntime
                                       |
                      sysctl_sched_wakeup_granularity
                                   <-->
----------------------------------|----|-----------------------|---------------
                                  |    |<--------------------->
                                  |    .  sysctl_sched_latency
                                  |    .
default/current latency entity    |    .
                                  |    .
1111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-
se preempts curr at wakeup ------>|<- se doesn't preempt curr -----------------
                                  |    .
                                  |    .
                                  |    .
low latency entity                |    .
                                   ---------------------->|
                               % of sysctl_sched_latency  |
1111111111111111111111111111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-
preempt ------------------------------------------------->|<- do not preempt --
                                  |    .
                                  |    .
                                  |    .
high latency entity               |    .
         |<-----------------------|    .
         | % of sysctl_sched_latency   .
111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1
preempt->|<- se doesn't preempt curr ------------------------------------------

Tests results of nice latency impact on heavy load like hackbench:

hackbench -l (2560 / group) -g group
group        latency 0             latency 19
1            1.399(+/- 1.27%)      1.357(+/- 1.48%) + 3%
4            1.422(+/- 4.69%)      1.267(+/- 2.39%) +11%
8            1.334(+/- 2.92%)      1.290(+/- 0.92%) + 3%
16           1.353(+/- 1.37%)      1.310(+/- 0.35%) + 3%

hackbench -p -l (2560 / group) -g group
group
1            1.450(+/- 9.14%)      0.853(+/- 3.23%) +41%
4            1.539(+/- 6.41%)      0.754(+/- 3.96%) +51%
8            1.380(+/- 8.04%)      0.687(+/- 5.30%) +50%
16           0.774(+/- 6.30%)      0.688(+/- 3.11%) +11%

By deacreasing the latency prio, we reduce the number of preemption at
wakeup and help hackbench making progress.

Test results of nice latency impact on short live load like cyclictest
while competing with heavy load like hackbench:

hackbench -l 10000 -g group &
cyclictest --policy other -D 5 -q -n
        latency 0           latency -20
group   min  avg    max     min  avg    max
0       15    18     28      17   17     27
1       65   386   9154      62   92   6268
4       63   447  14623      54   93   7655
8       63   847  43705      49  124  26500
16      53  1081  66523      44  199  30185

group = 0 means that hackbench is not running.

The avg is significantly improved with nice latency -20 especially with
large number of groups but min and max remain quite similar. If we add the
histogram parameters to get details of latency, we have :

hackbench -l 10000 -g 16 &
cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
              latency 0    latency -20
Min Latencies:    63           62
Avg Latencies:  1129          132
Max Latencies: 71331        16762
50% latencies:    92           85
75% latencies:   622           90
85% latencies:  1038           93
90% latencies:  1371           96
95% latencies:  5304          100
99% latencies: 17329          137

With percentile details, we see the benefit of nice latency -20 as
1% of the latencies stays above 137us whereas the default latency has
got 25% are above 322us and 15% over the 1ms.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

For v1, it has been discussed the opportunity to take into account latency_prio
in other places than check_preempt_wakeup().
The fast wakeup path is mainly about quickly looking for an idle CPU and I
don't see any place where the added complexity would provide obvious benefit.
The only place could be wake_affine_weight when we already compare the load;
here we could also check latency_nice prio of current tasks.
The slow path is mainly/only used for exec and fork and I wonder if there is
cases where we would like a newly forked task to preempt current one as soon
as possible as an example.
So I haven't add any new place that takes into account latency_prio for now.


 include/linux/sched.h |  4 ++-
 init/init_task.c      |  2 +-
 kernel/sched/core.c   | 34 +++++++++++++++++----
 kernel/sched/debug.c  |  2 +-
 kernel/sched/fair.c   | 69 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h  | 12 ++++++++
 6 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 34c6c9c2797c..d991cbd972ea 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -560,6 +560,8 @@ struct sched_entity {
 	unsigned long			runnable_weight;
 #endif
 
+	int				latency_weight;
+
 #ifdef CONFIG_SMP
 	/*
 	 * Per entity load average tracking.
@@ -775,7 +777,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
-	int				latency_nice;
+	int				latency_prio;
 
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
diff --git a/init/init_task.c b/init/init_task.c
index 225d11a39bc9..e98c71f24981 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,7 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
-	.latency_nice	= DEFAULT_LATENCY_NICE,
+	.latency_prio	= NICE_WIDTH - 20,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2c0f782a9089..ff020b99625c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1308,6 +1308,11 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	}
 }
 
+static void set_latency_weight(struct task_struct *p)
+{
+	p->se.latency_weight = sched_latency_to_weight[p->latency_prio];
+}
+
 #ifdef CONFIG_UCLAMP_TASK
 /*
  * Serializes updates of utilization clamp values
@@ -4474,7 +4479,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->prio = current->normal_prio;
 
 	/* Propagate the parent's latency requirements to the child as well */
-	p->latency_nice = current->latency_nice;
+	p->latency_prio = current->latency_prio;
 
 	uclamp_fork(p);
 
@@ -4492,7 +4497,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
-		p->latency_nice = DEFAULT_LATENCY_NICE;
+		p->latency_prio = NICE_TO_LATENCY(0);
+		set_latency_weight(p);
+
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
@@ -7207,7 +7214,8 @@ static void __setscheduler_latency(struct task_struct *p,
 		const struct sched_attr *attr)
 {
 	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
-		p->latency_nice = attr->sched_latency_nice;
+		p->latency_prio = NICE_TO_LATENCY(attr->sched_latency_nice);
+		set_latency_weight(p);
 	}
 }
 
@@ -7341,7 +7349,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
 			return -EINVAL;
 		/* Use the same security checks as NICE */
-		if (attr->sched_latency_nice < p->latency_nice &&
+		if (attr->sched_latency_nice < LATENCY_TO_NICE(p->latency_prio) &&
 		    !capable(CAP_SYS_NICE))
 			return -EPERM;
 	}
@@ -7381,7 +7389,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
-		    attr->sched_latency_nice != p->latency_nice)
+		    attr->sched_latency_nice != LATENCY_TO_NICE(p->latency_prio))
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
@@ -7922,7 +7930,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	get_params(p, &kattr);
 	kattr.sched_flags &= SCHED_FLAG_ALL;
 
-	kattr.sched_latency_nice = p->latency_nice;
+	kattr.sched_latency_nice = LATENCY_TO_NICE(p->latency_prio);
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
@@ -11117,6 +11125,20 @@ const u32 sched_prio_to_wmult[40] = {
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
 
+/*
+ * latency weight for wakeup preemption
+ */
+const int sched_latency_to_weight[40] = {
+ /* -20 */      1024,       973,       922,       870,       819,
+ /* -15 */       768,       717,       666,       614,       563,
+ /* -10 */       512,       461,       410,       358,       307,
+ /*  -5 */       256,       205,       154,       102,       51,
+ /*   0 */	   0,       -51,      -102,      -154,      -205,
+ /*   5 */      -256,      -307,      -358,      -410,      -461,
+ /*  10 */      -512,      -563,      -614,      -666,      -717,
+ /*  15 */      -768,      -819,      -870,      -922,      -973,
+};
+
 void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
         trace_sched_update_nr_running_tp(rq, count);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a3f7876217a6..06aaa0c81d4b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1042,7 +1042,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #endif
 	P(policy);
 	P(prio);
-	P(latency_nice);
+	P(latency_prio);
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc9f6e94c84e..3af74f1a79ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5619,6 +5619,35 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
+static void set_next_buddy(struct sched_entity *se);
+
+static void check_preempt_from_idle(struct cfs_rq *cfs, struct sched_entity *se)
+{
+	struct sched_entity *next;
+
+	if (se->latency_weight <= 0)
+		return;
+
+	if (cfs->nr_running <= 1)
+		return;
+	/*
+	 * When waking from idle, we don't need to check to preempt at wakeup
+	 * the idle thread and don't set next buddy as a candidate for being
+	 * picked in priority.
+	 * In case of simultaneous wakeup from idle, the latency sensitive tasks
+	 * lost opportunity to preempt non sensitive tasks which woke up
+	 * simultaneously.
+	 */
+
+	if (cfs->next)
+		next = cfs->next;
+	else
+		next = __pick_first_entity(cfs);
+
+	if (next && wakeup_preempt_entity(next, se) == 1)
+		set_next_buddy(se);
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -5712,6 +5741,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		update_overutilized_status(rq);
 
+	if (rq->curr == rq->idle)
+		check_preempt_from_idle(cfs_rq_of(&p->se), &p->se);
+
 enqueue_throttle:
 	if (cfs_bandwidth_used()) {
 		/*
@@ -5733,8 +5765,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	hrtick_update(rq);
 }
 
-static void set_next_buddy(struct sched_entity *se);
-
 /*
  * The dequeue_task method is called before nr_running is
  * decreased. We remove the task from the rbtree and
@@ -6991,6 +7021,37 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 }
 #endif /* CONFIG_SMP */
 
+static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se)
+{
+	int latency_weight = se->latency_weight;
+	long thresh = sysctl_sched_latency;
+
+	/*
+	 * A positive latency weigth means that the sched_entity has latency
+	 * requirement that needs to be evaluated versus other entity.
+	 * Otherwise, use the latency weight to evaluate how much scheduling
+	 * delay is acceptable by se.
+	 */
+	if ((se->latency_weight > 0) || (curr->latency_weight > 0))
+		latency_weight -= curr->latency_weight;
+
+	if (!latency_weight)
+		return 0;
+
+	if (sched_feat(GENTLE_FAIR_SLEEPERS))
+		thresh >>= 1;
+
+	/*
+	 * Clamp the delta to stay in the scheduler period range
+	 * [-sysctl_sched_latency:sysctl_sched_latency]
+	 */
+	latency_weight = clamp_t(long, latency_weight,
+				-1 * NICE_LATENCY_WEIGHT_MAX,
+				NICE_LATENCY_WEIGHT_MAX);
+
+	return (thresh * latency_weight) >> NICE_LATENCY_SHIFT;
+}
+
 static unsigned long wakeup_gran(struct sched_entity *se)
 {
 	unsigned long gran = sysctl_sched_wakeup_granularity;
@@ -7030,6 +7091,9 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 {
 	s64 gran, vdiff = curr->vruntime - se->vruntime;
 
+	/* Take into account latency priority */
+	vdiff += wakeup_latency_gran(curr, se);
+
 	if (vdiff <= 0)
 		return -1;
 
@@ -7138,6 +7202,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		return;
 
 	update_curr(cfs_rq_of(se));
+
 	if (wakeup_preempt_entity(se, pse) == 1) {
 		/*
 		 * Bias pick_next to pick the sched entity that is
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 271ecd37c13d..831b2c8feff1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -134,6 +134,17 @@ extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
  * Default tasks should be treated as a task with latency_nice = 0.
  */
 #define DEFAULT_LATENCY_NICE	0
+#define DEFAULT_LATENCY_PRIO	(DEFAULT_LATENCY_NICE + LATENCY_NICE_WIDTH/2)
+
+/*
+ * Convert user-nice values [ -20 ... 0 ... 19 ]
+ * to static latency [ 0..39 ],
+ * and back.
+ */
+#define NICE_TO_LATENCY(nice)	((nice) + DEFAULT_LATENCY_PRIO)
+#define LATENCY_TO_NICE(prio)	((prio) - DEFAULT_LATENCY_PRIO)
+#define NICE_LATENCY_SHIFT	(SCHED_FIXEDPOINT_SHIFT)
+#define NICE_LATENCY_WEIGHT_MAX	(1L << NICE_LATENCY_SHIFT)
 
 /*
  * Increase resolution of nice-level calculations for 64-bit architectures.
@@ -2078,6 +2089,7 @@ static_assert(WF_TTWU == SD_BALANCE_WAKE);
 
 extern const int		sched_prio_to_weight[40];
 extern const u32		sched_prio_to_wmult[40];
+extern const int		sched_latency_to_weight[40];
 
 /*
  * {de,en}queue flags:
-- 
2.17.1

