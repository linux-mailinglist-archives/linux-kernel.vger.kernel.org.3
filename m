Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA3E4D65DA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350210AbiCKQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350191AbiCKQPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:15:40 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083511D06F5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:26 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f20-20020a05600c155400b00389d73ceb43so1222641wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gGDDU2Ei4o4n5rRc9Fl7x+xD8gsBmPHZg9Xz6lcqQr4=;
        b=hD43wxXy6cLQaiXbqvSCujqNLqOLjVk+fi3fsycX+agewdbDj9KgK+s2Fo72/QDrb4
         uG6emQs6lWjzfpq+WPeCgQR5wrEFHVDxyRC+NU3rk2ASu7SXYH3VA6kVBZ7n2wGAMhay
         AhDiLx2ghDZGS3/oBpfUDnuBqN0KIHwbRWRSnDVqfIUfQtcCjQFAhpzHXLwAjcQtC2JK
         vFHSH4KziT62Y4X5yeVgWg+aglb3l9zqPduDVnBySkUUJ+f87F+EYMTCHWbMmDsVXTYR
         SVVXHCqvItGtbnWIiV+CmrK5Dk6peHnI8Pz/TAwn/azygq0OSJVka7//v8HRLz3h5cGa
         0xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gGDDU2Ei4o4n5rRc9Fl7x+xD8gsBmPHZg9Xz6lcqQr4=;
        b=Qu3oc2/pm0UoEt7fIGo97ieon8thIDx9JME9oWt8+q/vA8dFkypZyAoMWt8Xt98xbR
         oO184xyHwKWbWeW0mh6weGXefQ8ympryg5HmncXead3nMVQvgq8t9HVTkOqpuKYIf6ZB
         NO1ZFlSrvJJKnLEfmGBaKgFDVLSDDvEPKc1ML8dzeNMYMcQKeBptRQeXmGJ4QDnOFC7y
         G3dKojTBrgGj/7vE6+mkR1oGabSTgnxB+GoxdQm7CVOc5JMUR6vXTWMLf7SClQev6VWz
         mu1OiZbrPogdEkL6lerU/YO8rN4J7y8CNh8CEecw+lZyAqZDpx4wfyPwziZkVQesZa8o
         V81Q==
X-Gm-Message-State: AOAM532JzkYTHARIsbnb8tm7MA04kX3X9YzNOVEcVObhyseEeqZLAKPr
        LTNx8KhB1hotwS1EG2Z6UNb6Tw==
X-Google-Smtp-Source: ABdhPJxO+w9VkJ1FBjPMKZLThI/FF+KsuvbdSFy1CitXuc3sICEswshGp9+0cHx2nyHh3bIl2lpiyw==
X-Received: by 2002:a7b:c042:0:b0:389:7336:158b with SMTP id u2-20020a7bc042000000b003897336158bmr8279837wmc.15.1647015264428;
        Fri, 11 Mar 2022 08:14:24 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70d9:405c:a1e4:4d23])
        by smtp.gmail.com with ESMTPSA id 4-20020a056000154400b00203812ca383sm6464137wry.78.2022.03.11.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:14:22 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC 5/6] sched/fair: Take into account latency nice at wakeup
Date:   Fri, 11 Mar 2022 17:14:05 +0100
Message-Id: <20220311161406.23497-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220311161406.23497-1-vincent.guittot@linaro.org>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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
1            1.450(+/- 0.60%)      1.376(+/- 0.54%) + 5%
4            1.537(+/- 1.75%)      1.335(+/- 1.81%) +13%
8            1.414(+/- 1.91%)      1.348(+/- 1.88%) + 5%
16           1.423(+/- 1.65%)      1.374(+/- 0.58%) + 3%

hackbench -p -l (2560 / group) -g group
group
1            1.416(+/- 3.45%)      0.886(+/- 0.54%) +37%
4            1.634(+/- 7.14%)      0.888(+/- 5.40%) +45%
8            1.449(+/- 2.14%)      0.804(+/- 4.55%) +44%
16           0.917(+/- 4.12%)      0.777(+/- 1.41%) +15%

By deacreasing the latency prio, we reduce the number of preemption at
wakeup and help hackbench making progress.

Test results of nice latency impact on short live load like cyclictest
while competing with heavy load like hackbench:

hackbench -l 10000 -g group &
cyclictest --policy other -D 5 -q -n
        latency 0           latency -20
group   min  avg    max     min  avg    max
0       16    17     28      15   17     27
1       61   382  10603      63   89   4628
4       52   437  15455      54   98  16238
8       56   728  38499      61  125  28983
16      53  1215  52207      61  183  80751

group = 0 means that hackbench is not running.

The avg is significantly improved with nice latency -20 especially with
large number of groups but min and max remain quite similar. If we add the
histogram parameters to get details of latency, we have :

hackbench -l 10000 -g 16 &
cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
              latency 0    latency -20
Min Latencies:    63           62
Avg Latencies:  1397          218
Max Latencies: 44926        42291
50% latencies:   100           98
75% latencies:   762          116
85% latencies:  1118          126
90% latencies:  1540          130
95% latencies:  5610          138
99% latencies: 13738          266

With percentile details, we see the benefit of nice latency -20 as
1% of the latencies stays above 266us whereas the default latency has
got 25% are above 762us and 10% over the 1ms.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  4 ++-
 init/init_task.c      |  2 +-
 kernel/sched/core.c   | 32 +++++++++++++++++++----
 kernel/sched/debug.c  |  2 +-
 kernel/sched/fair.c   | 60 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h  | 12 +++++++++
 6 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2aa889a59054..9aeb157e819b 100644
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
@@ -779,7 +781,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
-	int				latency_nice;
+	int				latency_prio;
 
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
diff --git a/init/init_task.c b/init/init_task.c
index 2afa249c253b..e98c71f24981 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,7 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
-	.latency_nice	= 0,
+	.latency_prio	= NICE_WIDTH - 20,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f8b102a75c4..547b0da01efe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1241,6 +1241,11 @@ static void set_load_weight(struct task_struct *p, bool update_load)
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
@@ -4394,7 +4399,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->prio = current->normal_prio;
 
 	/* Propagate the parent's latency requirements to the child as well */
-	p->latency_nice = current->latency_nice;
+	p->latency_prio = current->latency_prio;
 
 	uclamp_fork(p);
 
@@ -4412,7 +4417,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
-		p->latency_nice = DEFAULT_LATENCY_NICE;
+		p->latency_prio = NICE_TO_LATENCY(0);
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
@@ -4420,6 +4425,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->sched_reset_on_fork = 0;
 	}
 
+	/* Once latency_prio is set, update the latency weight */
+	set_latency_weight(p);
+
 	if (dl_prio(p->prio))
 		return -EAGAIN;
 	else if (rt_prio(p->prio))
@@ -7361,7 +7369,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
 			return -EINVAL;
 		/* Use the same security checks as NICE */
-		if (attr->sched_latency_nice < p->latency_nice &&
+		if (attr->sched_latency_nice < LATENCY_TO_NICE(p->latency_prio) &&
 		    !capable(CAP_SYS_NICE))
 			return -EPERM;
 	}
@@ -7401,7 +7409,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
-		    attr->sched_latency_nice != p->latency_nice)
+		    attr->sched_latency_nice != LATENCY_TO_NICE(p->latency_prio))
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
@@ -7942,7 +7950,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	get_params(p, &kattr);
 	kattr.sched_flags &= SCHED_FLAG_ALL;
 
-	kattr.sched_latency_nice = p->latency_nice;
+	kattr.sched_latency_nice = LATENCY_TO_NICE(p->latency_prio);
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
@@ -10954,6 +10962,20 @@ const u32 sched_prio_to_wmult[40] = {
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
index 5d76a8927888..253e52ec73fb 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1043,7 +1043,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #endif
 	P(policy);
 	P(prio);
-	P(latency_nice);
+	P(latency_prio);
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5c4bfffe8c2c..506c482a0e48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5555,6 +5555,35 @@ static int sched_idle_cpu(int cpu)
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
@@ -5648,6 +5677,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		update_overutilized_status(rq);
 
+	if (rq->curr == rq->idle)
+		check_preempt_from_idle(cfs_rq_of(&p->se), &p->se);
+
 enqueue_throttle:
 	if (cfs_bandwidth_used()) {
 		/*
@@ -5669,8 +5701,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	hrtick_update(rq);
 }
 
-static void set_next_buddy(struct sched_entity *se);
-
 /*
  * The dequeue_task method is called before nr_running is
  * decreased. We remove the task from the rbtree and
@@ -6970,6 +7000,27 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 }
 #endif /* CONFIG_SMP */
 
+static long wakeup_latency_gran(int latency_weight)
+{
+	long thresh = sysctl_sched_latency;
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
@@ -7008,6 +7059,10 @@ static int
 wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 {
 	s64 gran, vdiff = curr->vruntime - se->vruntime;
+	int latency_weight = se->latency_weight - curr->latency_weight;
+
+	latency_weight = min(latency_weight, se->latency_weight);
+	vdiff += wakeup_latency_gran(latency_weight);
 
 	if (vdiff <= 0)
 		return -1;
@@ -7117,6 +7172,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		return;
 
 	update_curr(cfs_rq_of(se));
+
 	if (wakeup_preempt_entity(se, pse) == 1) {
 		/*
 		 * Bias pick_next to pick the sched entity that is
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 456ad2159eb1..dd92aa9c36f9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -122,6 +122,17 @@ extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
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
@@ -2098,6 +2109,7 @@ static_assert(WF_TTWU == SD_BALANCE_WAKE);
 
 extern const int		sched_prio_to_weight[40];
 extern const u32		sched_prio_to_wmult[40];
+extern const int		sched_latency_to_weight[40];
 
 /*
  * {de,en}queue flags:
-- 
2.17.1

