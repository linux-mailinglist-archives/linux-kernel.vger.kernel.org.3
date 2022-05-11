Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B27524061
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348873AbiEKWpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiEKWpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:45:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6747DE8D;
        Wed, 11 May 2022 15:45:42 -0700 (PDT)
Date:   Wed, 11 May 2022 22:45:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652309139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RyO7ROotNJHQFAXixR358Xc2zA+QdzoD7iDT/kL0sE=;
        b=wiq+yCko3kLUJYKmz2Fgo8dNgjFiFanW5im2B/ukhp0o8q26gDK7Id+rreGZqgAaOT5SRo
        p5ykXHHFCiu+gNLFPDfjFURHhrFQVyQzkCCTyQvEujOHYMfHt0daWRaoZucvdNMkUvX45h
        hC4MM2IQ8y30nDKtQbCSXHp7JMcr3IFeSNUTgdz05eNZpzXbJLH1xr4KzfywAHqjvxfzr6
        23fEabJouPAEVxMG7FZjR2iHUiG1DdaoLLCPr2sZP+4z9T1EVj8G4I4p6ACHXj8UCY9q19
        MEnQ08mh5ugpfhHxLYcRajtmwXS+ZrSUjamXN50BLf4F7OFdfpFqnEZE8ubD6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652309139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RyO7ROotNJHQFAXixR358Xc2zA+QdzoD7iDT/kL0sE=;
        b=0kje6s7vsBNTaD4u8XRzc0yvT90E6FAEh+UYrRS78h3zBhtdanCgo6/oMsLW2x0t9UDRlz
        jOpqSDQDykUjoGBA==
From:   "tip-bot2 for Delyan Kratunov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/tracing: Append prev_state to tp args instead
Cc:     Delyan Kratunov <delyank@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <c8a6930dfdd58a4a5755fc01732675472979732b.camel@fb.com>
References: <c8a6930dfdd58a4a5755fc01732675472979732b.camel@fb.com>
MIME-Version: 1.0
Message-ID: <165230913750.4207.4162492159806543933.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9c2136be0878c88c53dea26943ce40bb03ad8d8d
Gitweb:        https://git.kernel.org/tip/9c2136be0878c88c53dea26943ce40bb03ad8d8d
Author:        Delyan Kratunov <delyank@fb.com>
AuthorDate:    Wed, 11 May 2022 18:28:36 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 12 May 2022 00:37:11 +02:00

sched/tracing: Append prev_state to tp args instead

Commit fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting
sched_switch event, 2022-01-20) added a new prev_state argument to the
sched_switch tracepoint, before the prev task_struct pointer.

This reordering of arguments broke BPF programs that use the raw
tracepoint (e.g. tp_btf programs). The type of the second argument has
changed and existing programs that assume a task_struct* argument
(e.g. for bpf_task_storage access) will now fail to verify.

If we instead append the new argument to the end, all existing programs
would continue to work and can conditionally extract the prev_state
argument on supported kernel versions.

Fixes: fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting sched_switch event, 2022-01-20)
Signed-off-by: Delyan Kratunov <delyank@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/c8a6930dfdd58a4a5755fc01732675472979732b.camel@fb.com
---
 include/trace/events/sched.h              | 6 +++---
 kernel/sched/core.c                       | 2 +-
 kernel/trace/fgraph.c                     | 4 ++--
 kernel/trace/ftrace.c                     | 4 ++--
 kernel/trace/trace_events.c               | 8 ++++----
 kernel/trace/trace_osnoise.c              | 4 ++--
 kernel/trace/trace_sched_switch.c         | 4 ++--
 kernel/trace/trace_sched_wakeup.c         | 4 ++--
 samples/trace_events/trace_custom_sched.h | 6 +++---
 9 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 65e7867..fbb99a6 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -222,11 +222,11 @@ static inline long __trace_sched_switch_state(bool preempt,
 TRACE_EVENT(sched_switch,
 
 	TP_PROTO(bool preempt,
-		 unsigned int prev_state,
 		 struct task_struct *prev,
-		 struct task_struct *next),
+		 struct task_struct *next,
+		 unsigned int prev_state),
 
-	TP_ARGS(preempt, prev_state, prev, next),
+	TP_ARGS(preempt, prev, next, prev_state),
 
 	TP_STRUCT__entry(
 		__array(	char,	prev_comm,	TASK_COMM_LEN	)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaab..d58c038 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6382,7 +6382,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev_state, prev, next);
+		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
 
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8f4fb32..a7e84c8 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -404,9 +404,9 @@ free:
 
 static void
 ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
-				unsigned int prev_state,
 				struct task_struct *prev,
-				struct task_struct *next)
+				struct task_struct *next,
+				unsigned int prev_state)
 {
 	unsigned long long timestamp;
 	int index;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f1d2f5..af899b0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7420,9 +7420,9 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops)
 
 static void
 ftrace_filter_pid_sched_switch_probe(void *data, bool preempt,
-				     unsigned int prev_state,
 				     struct task_struct *prev,
-				     struct task_struct *next)
+				     struct task_struct *next,
+				     unsigned int prev_state)
 {
 	struct trace_array *tr = data;
 	struct trace_pid_list *pid_list;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e11e167..f97de82 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -773,9 +773,9 @@ void trace_event_follow_fork(struct trace_array *tr, bool enable)
 
 static void
 event_filter_pid_sched_switch_probe_pre(void *data, bool preempt,
-					unsigned int prev_state,
 					struct task_struct *prev,
-					struct task_struct *next)
+					struct task_struct *next,
+					unsigned int prev_state)
 {
 	struct trace_array *tr = data;
 	struct trace_pid_list *no_pid_list;
@@ -799,9 +799,9 @@ event_filter_pid_sched_switch_probe_pre(void *data, bool preempt,
 
 static void
 event_filter_pid_sched_switch_probe_post(void *data, bool preempt,
-					 unsigned int prev_state,
 					 struct task_struct *prev,
-					 struct task_struct *next)
+					 struct task_struct *next,
+					 unsigned int prev_state)
 {
 	struct trace_array *tr = data;
 	struct trace_pid_list *no_pid_list;
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index e9ae1f3..afb92e2 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1168,9 +1168,9 @@ thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
  */
 static void
 trace_sched_switch_callback(void *data, bool preempt,
-			    unsigned int prev_state,
 			    struct task_struct *p,
-			    struct task_struct *n)
+			    struct task_struct *n,
+			    unsigned int prev_state)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
 
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 45796d8..c9ffdcf 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -22,8 +22,8 @@ static DEFINE_MUTEX(sched_register_mutex);
 
 static void
 probe_sched_switch(void *ignore, bool preempt,
-		   unsigned int prev_state,
-		   struct task_struct *prev, struct task_struct *next)
+		   struct task_struct *prev, struct task_struct *next,
+		   unsigned int prev_state)
 {
 	int flags;
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 46429f9..330aee1 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -426,8 +426,8 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
 
 static void notrace
 probe_wakeup_sched_switch(void *ignore, bool preempt,
-			  unsigned int prev_state,
-			  struct task_struct *prev, struct task_struct *next)
+			  struct task_struct *prev, struct task_struct *next,
+			  unsigned int prev_state)
 {
 	struct trace_array_cpu *data;
 	u64 T0, T1, delta;
diff --git a/samples/trace_events/trace_custom_sched.h b/samples/trace_events/trace_custom_sched.h
index 9fdd8e7..9513883 100644
--- a/samples/trace_events/trace_custom_sched.h
+++ b/samples/trace_events/trace_custom_sched.h
@@ -25,11 +25,11 @@ TRACE_CUSTOM_EVENT(sched_switch,
 	 * that the custom event is using.
 	 */
 	TP_PROTO(bool preempt,
-		 unsigned int prev_state,
 		 struct task_struct *prev,
-		 struct task_struct *next),
+		 struct task_struct *next,
+		 unsigned int prev_state),
 
-	TP_ARGS(preempt, prev_state, prev, next),
+	TP_ARGS(preempt, prev, next, prev_state),
 
 	/*
 	 * The next fields are where the customization happens.
