Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDD2527694
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbiEOJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 05:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiEOJZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:25:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC2A14014
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:25:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652606707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4XtisG/QIREPsnJEdLXyqk0YnrYvE81FBAyBoTVMhvU=;
        b=KdNO6k1nWhJujr3OrQBoTMPxMyO0hwvbJy+5quB0tOvj5C957EEAKEBS7qCC10GoXR58kl
        7YUTGjbxfhm7Og2Em00NnGg8ljsTL0Ml8QgH1ydGJAMHvrTAJSuEQxMj1HpUVhoJjicfE+
        5uWs1CqGmNtOsDKHHw3sNW1XSPBKSgtBmlY6XOWIvEJ7kj6SMHdYxSSx/ul5l2uA+wHzHF
        7kEaZdYbMHBAu7v5YDarLS12LXY86gzQE5Dcn5oSgKzMcpBB0prln0kpBTws7uGSiO9+0o
        X13onIARAnPoqVGjNZeAJFEkyabrqk6L3nx9jvTJVyIEmTDSGWBkCiguoqiztw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652606707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4XtisG/QIREPsnJEdLXyqk0YnrYvE81FBAyBoTVMhvU=;
        b=yNbY3cTDp0zIKu1Bm/sS9UHRvSOvFqm6k1Bi5NdqnC3/acRBCqfgb1MuEyg16I1EN3sNWs
        4BMu1Jm6wbDzhsAg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v5.18-rc7
References: <165260667543.920532.17932536291158599837.tglx@xen13>
Message-ID: <165260667688.920532.9348188301647885947.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 15 May 2022 11:25:07 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-202=
2-05-15

up to:  9c2136be0878: sched/tracing: Append prev_state to tp args instead


The recent expansion of the sched switch tracepoint inserted a new argument
in the middle of the arguments. This reordering broke BPF programs which
relied on the old argument list. While tracepoints are not considered
stable ABI, it's not trivial to make BPF cope with such a change, but it's
being worked on. For now restore the original argument order and move the
new argument to the end of the argument list.

Thanks,

	tglx

------------------>
Delyan Kratunov (1):
      sched/tracing: Append prev_state to tp args instead


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
index 65e786756321..fbb99a61f714 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -222,11 +222,11 @@ static inline long __trace_sched_switch_state(bool pree=
mpt,
 TRACE_EVENT(sched_switch,
=20
 	TP_PROTO(bool preempt,
-		 unsigned int prev_state,
 		 struct task_struct *prev,
-		 struct task_struct *next),
+		 struct task_struct *next,
+		 unsigned int prev_state),
=20
-	TP_ARGS(preempt, prev_state, prev, next),
+	TP_ARGS(preempt, prev, next, prev_state),
=20
 	TP_STRUCT__entry(
 		__array(	char,	prev_comm,	TASK_COMM_LEN	)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..d58c0389eb23 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6382,7 +6382,7 @@ static void __sched notrace __schedule(unsigned int sch=
ed_mode)
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
=20
-		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev_state, prev, next);
+		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
=20
 		/* Also unlocks the rq: */
 		rq =3D context_switch(rq, prev, next, &rf);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8f4fb328133a..a7e84c8543cb 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -404,9 +404,9 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stac=
k **ret_stack_list)
=20
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
index 4f1d2f5e7263..af899b058c8d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7420,9 +7420,9 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *op=
s)
=20
 static void
 ftrace_filter_pid_sched_switch_probe(void *data, bool preempt,
-				     unsigned int prev_state,
 				     struct task_struct *prev,
-				     struct task_struct *next)
+				     struct task_struct *next,
+				     unsigned int prev_state)
 {
 	struct trace_array *tr =3D data;
 	struct trace_pid_list *pid_list;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e11e167b7809..f97de82d1342 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -773,9 +773,9 @@ void trace_event_follow_fork(struct trace_array *tr, bool=
 enable)
=20
 static void
 event_filter_pid_sched_switch_probe_pre(void *data, bool preempt,
-					unsigned int prev_state,
 					struct task_struct *prev,
-					struct task_struct *next)
+					struct task_struct *next,
+					unsigned int prev_state)
 {
 	struct trace_array *tr =3D data;
 	struct trace_pid_list *no_pid_list;
@@ -799,9 +799,9 @@ event_filter_pid_sched_switch_probe_pre(void *data, bool =
preempt,
=20
 static void
 event_filter_pid_sched_switch_probe_post(void *data, bool preempt,
-					 unsigned int prev_state,
 					 struct task_struct *prev,
-					 struct task_struct *next)
+					 struct task_struct *next,
+					 unsigned int prev_state)
 {
 	struct trace_array *tr =3D data;
 	struct trace_pid_list *no_pid_list;
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index e9ae1f33a7f0..afb92e2f0aea 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1168,9 +1168,9 @@ thread_exit(struct osnoise_variables *osn_var, struct t=
ask_struct *t)
  */
 static void
 trace_sched_switch_callback(void *data, bool preempt,
-			    unsigned int prev_state,
 			    struct task_struct *p,
-			    struct task_struct *n)
+			    struct task_struct *n,
+			    unsigned int prev_state)
 {
 	struct osnoise_variables *osn_var =3D this_cpu_osn_var();
=20
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_swi=
tch.c
index 45796d8bd4b2..c9ffdcfe622e 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -22,8 +22,8 @@ static DEFINE_MUTEX(sched_register_mutex);
=20
 static void
 probe_sched_switch(void *ignore, bool preempt,
-		   unsigned int prev_state,
-		   struct task_struct *prev, struct task_struct *next)
+		   struct task_struct *prev, struct task_struct *next,
+		   unsigned int prev_state)
 {
 	int flags;
=20
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wak=
eup.c
index 46429f9a96fa..330aee1c1a49 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -426,8 +426,8 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
=20
 static void notrace
 probe_wakeup_sched_switch(void *ignore, bool preempt,
-			  unsigned int prev_state,
-			  struct task_struct *prev, struct task_struct *next)
+			  struct task_struct *prev, struct task_struct *next,
+			  unsigned int prev_state)
 {
 	struct trace_array_cpu *data;
 	u64 T0, T1, delta;
diff --git a/samples/trace_events/trace_custom_sched.h b/samples/trace_events=
/trace_custom_sched.h
index 9fdd8e7c2a45..951388334a3f 100644
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
=20
-	TP_ARGS(preempt, prev_state, prev, next),
+	TP_ARGS(preempt, prev, next, prev_state),
=20
 	/*
 	 * The next fields are where the customization happens.

