Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE794C8EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiCAPZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiCAPZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:25:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46CC8A6EB;
        Tue,  1 Mar 2022 07:24:41 -0800 (PST)
Date:   Tue, 01 Mar 2022 15:24:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646148280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ERfytIpQNK7SkHd9GYMTD2TBzK1HOtV5+WAZ0qgTNoc=;
        b=remZcRIMno6lBUQvpp9TNX3tdhgMbDMOD51noUS1RZURtDkiy21n7/WuTl1SAL8Fu0wWdH
        leISLYoQMySbIyqrKbFot5a3YD/KGbiWc3tbJgF+4rFI+QRCkg+J3iyZmLRKgJ1XvhNxYj
        lPA9447WkL+QZV5RE1BWxWb12P9bxPSdVwp8cG9eh90yWC5myJpuYMWekTSHUGthdMnL99
        VXnDzVNLir13WhbVw2z8P5UYCCBw6RZ+n9fomXW0TFMAALyimfDVtDqU9Oabd1jTArLFLp
        UmtgHUJiLEw7G8trTrWKGJSDzUWOvLOcV9ewKt1pJTki/Mc/geCm7zEA8xU+Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646148280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ERfytIpQNK7SkHd9GYMTD2TBzK1HOtV5+WAZ0qgTNoc=;
        b=/k7o+7xD0jHcv9TnN1fUlaWPwk28RCxGSgPNiOiDmQA/uDBliSGsNw+Rs4ofJIjHb/3RlB
        mypsdKBVNAZzNcCQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/tracing: Don't re-read p->state when emitting
 sched_switch event
Cc:     Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220120162520.570782-2-valentin.schneider@arm.com>
References: <20220120162520.570782-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <164614827941.16921.4995078681021904041.tip-bot2@tip-bot2>
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

Commit-ID:     fa2c3254d7cfff5f7a916ab928a562d1165f17bb
Gitweb:        https://git.kernel.org/tip/fa2c3254d7cfff5f7a916ab928a562d1165f17bb
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 20 Jan 2022 16:25:19 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Mar 2022 16:18:39 +01:00

sched/tracing: Don't re-read p->state when emitting sched_switch event

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20220120162520.570782-2-valentin.schneider@arm.com
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
index f00132e..457c8a0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1620,10 +1620,10 @@ static inline pid_t task_pgrp_nr(struct task_struct *tsk)
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
 
@@ -1633,6 +1633,11 @@ static inline unsigned int task_state_index(struct task_struct *tsk)
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
index 9464048..65e7867 100644
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
index ef94612..3aafc15 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4836,7 +4836,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 {
 	struct rq *rq = this_rq();
 	struct mm_struct *mm = rq->prev_mm;
-	long prev_state;
+	unsigned int prev_state;
 
 	/*
 	 * The previous task will have left us with a preempt_count of 2
@@ -6300,7 +6300,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next);
+		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev_state, prev, next);
 
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 22061d3..19028e0 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -415,7 +415,9 @@ free:
 
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
index f9feb19..6762ae0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7347,7 +7347,9 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops)
 
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
index 3147614..2a19ea7 100644
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
index 870a08d..1829b4c 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1167,7 +1167,9 @@ thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
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
index e304196..993b0ed 100644
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
index 2402de5..46429f9 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -426,6 +426,7 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
 
 static void notrace
 probe_wakeup_sched_switch(void *ignore, bool preempt,
+			  unsigned int prev_state,
 			  struct task_struct *prev, struct task_struct *next)
 {
 	struct trace_array_cpu *data;
