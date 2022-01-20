Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D317849524E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376980AbiATQZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:25:54 -0500
Received: from foss.arm.com ([217.140.110.172]:44032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376977AbiATQZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:25:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8D0611FB;
        Thu, 20 Jan 2022 08:25:52 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 51B593F73D;
        Thu, 20 Jan 2022 08:25:50 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH v3 1/2] sched/tracing: Don't re-read p->state when emitting sched_switch event
Date:   Thu, 20 Jan 2022 16:25:19 +0000
Message-Id: <20220120162520.570782-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120162520.570782-1-valentin.schneider@arm.com>
References: <20220120162520.570782-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit

  c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")

the following sequence becomes possible:

		      p->__state = TASK_INTERRUPTIBLE;
		      __schedule()
			deactivate_task(p);
  ttwu()
    READ !p->on_rq
    p->__state=TASK_WAKING
			trace_sched_switch()
			  __trace_sched_switch_state()
			    task_state_index()
			      return 0;

TASK_WAKING isn't in TASK_REPORT, so the task appears as TASK_RUNNING in
the trace event.

Prevent this by pushing the value read from __schedule() down the trace
event.

Reported-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched.h             | 11 ++++++++---
 include/trace/events/sched.h      | 11 +++++++----
 kernel/sched/core.c               |  4 ++--
 kernel/trace/fgraph.c             |  4 +++-
 kernel/trace/ftrace.c             |  4 +++-
 kernel/trace/trace_events.c       |  8 ++++++--
 kernel/trace/trace_osnoise.c      |  4 +++-
 kernel/trace/trace_sched_switch.c |  1 +
 kernel/trace/trace_sched_wakeup.c |  1 +
 9 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2e261adb8ea..d00837d12b9d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1616,10 +1616,10 @@ static inline pid_t task_pgrp_nr(struct task_struct *tsk)
 #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
 #define TASK_REPORT_MAX		(TASK_REPORT_IDLE << 1)
 
-static inline unsigned int task_state_index(struct task_struct *tsk)
+static inline unsigned int __task_state_index(unsigned int tsk_state,
+					      unsigned int tsk_exit_state)
 {
-	unsigned int tsk_state = READ_ONCE(tsk->__state);
-	unsigned int state = (tsk_state | tsk->exit_state) & TASK_REPORT;
+	unsigned int state = (tsk_state | tsk_exit_state) & TASK_REPORT;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(TASK_REPORT_MAX);
 
@@ -1629,6 +1629,11 @@ static inline unsigned int task_state_index(struct task_struct *tsk)
 	return fls(state);
 }
 
+static inline unsigned int task_state_index(struct task_struct *tsk)
+{
+	return __task_state_index(READ_ONCE(tsk->__state), tsk->exit_state);
+}
+
 static inline char task_index_to_char(unsigned int state)
 {
 	static const char state_char[] = "RSDTtXZPI";
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 94640482cfe7..65e786756321 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -187,7 +187,9 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
 	     TP_ARGS(p));
 
 #ifdef CREATE_TRACE_POINTS
-static inline long __trace_sched_switch_state(bool preempt, struct task_struct *p)
+static inline long __trace_sched_switch_state(bool preempt,
+					      unsigned int prev_state,
+					      struct task_struct *p)
 {
 	unsigned int state;
 
@@ -208,7 +210,7 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 	 * it for left shift operation to get the correct task->state
 	 * mapping.
 	 */
-	state = task_state_index(p);
+	state = __task_state_index(prev_state, p->exit_state);
 
 	return state ? (1 << (state - 1)) : state;
 }
@@ -220,10 +222,11 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 TRACE_EVENT(sched_switch,
 
 	TP_PROTO(bool preempt,
+		 unsigned int prev_state,
 		 struct task_struct *prev,
 		 struct task_struct *next),
 
-	TP_ARGS(preempt, prev, next),
+	TP_ARGS(preempt, prev_state, prev, next),
 
 	TP_STRUCT__entry(
 		__array(	char,	prev_comm,	TASK_COMM_LEN	)
@@ -239,7 +242,7 @@ TRACE_EVENT(sched_switch,
 		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		__entry->prev_pid	= prev->pid;
 		__entry->prev_prio	= prev->prio;
-		__entry->prev_state	= __trace_sched_switch_state(preempt, prev);
+		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe53e510e711..a8799a2d8546 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4822,7 +4822,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 {
 	struct rq *rq = this_rq();
 	struct mm_struct *mm = rq->prev_mm;
-	long prev_state;
+	unsigned int prev_state;
 
 	/*
 	 * The previous task will have left us with a preempt_count of 2
@@ -6287,7 +6287,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next);
+		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev_state, prev, next);
 
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 22061d38fc00..19028e072cdb 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -415,7 +415,9 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
 
 static void
 ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
-			struct task_struct *prev, struct task_struct *next)
+				unsigned int prev_state,
+				struct task_struct *prev,
+				struct task_struct *next)
 {
 	unsigned long long timestamp;
 	int index;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 30bc880c3849..e296ddeec99f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7311,7 +7311,9 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops)
 
 static void
 ftrace_filter_pid_sched_switch_probe(void *data, bool preempt,
-		    struct task_struct *prev, struct task_struct *next)
+				     unsigned int prev_state,
+				     struct task_struct *prev,
+				     struct task_struct *next)
 {
 	struct trace_array *tr = data;
 	struct trace_pid_list *pid_list;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4021b9a79f93..6ddc6cc0d5d5 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -759,7 +759,9 @@ void trace_event_follow_fork(struct trace_array *tr, bool enable)
 
 static void
 event_filter_pid_sched_switch_probe_pre(void *data, bool preempt,
-		    struct task_struct *prev, struct task_struct *next)
+					unsigned int prev_state,
+					struct task_struct *prev,
+					struct task_struct *next)
 {
 	struct trace_array *tr = data;
 	struct trace_pid_list *no_pid_list;
@@ -783,7 +785,9 @@ event_filter_pid_sched_switch_probe_pre(void *data, bool preempt,
 
 static void
 event_filter_pid_sched_switch_probe_post(void *data, bool preempt,
-		    struct task_struct *prev, struct task_struct *next)
+					 unsigned int prev_state,
+					 struct task_struct *prev,
+					 struct task_struct *next)
 {
 	struct trace_array *tr = data;
 	struct trace_pid_list *no_pid_list;
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 7520d43aed55..a8a2d17f858c 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1168,7 +1168,9 @@ thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
  * used to record the beginning and to report the end of a thread noise window.
  */
 static void
-trace_sched_switch_callback(void *data, bool preempt, struct task_struct *p,
+trace_sched_switch_callback(void *data, bool preempt,
+			    unsigned int prev_state,
+			    struct task_struct *p,
 			    struct task_struct *n)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index e304196d7c28..993b0ed10d8c 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -22,6 +22,7 @@ static DEFINE_MUTEX(sched_register_mutex);
 
 static void
 probe_sched_switch(void *ignore, bool preempt,
+		   unsigned int prev_state,
 		   struct task_struct *prev, struct task_struct *next)
 {
 	int flags;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 2402de520eca..46429f9a96fa 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -426,6 +426,7 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
 
 static void notrace
 probe_wakeup_sched_switch(void *ignore, bool preempt,
+			  unsigned int prev_state,
 			  struct task_struct *prev, struct task_struct *next)
 {
 	struct trace_array_cpu *data;
-- 
2.25.1

