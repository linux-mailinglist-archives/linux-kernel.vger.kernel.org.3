Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D4959B556
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 18:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiHUQDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 12:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiHUQD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 12:03:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4B660C2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 09:03:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1702B80B94
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 16:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866F1C433D6;
        Sun, 21 Aug 2022 16:03:19 +0000 (UTC)
Date:   Sun, 21 Aug 2022 12:03:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>
Subject: [GIT PULL] tracing: Fixes for v6.0-rc1
Message-ID: <20220821120334.036a533e@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Various fixes for tracing:

 - Suppress the errors that is_signed_type() causes static analysis tools

 - Fix a return value of traceprobe_parse_event_name()

 - Fix NULL pointer dereference from failed ftrace enabling

 - Fix NULL pointer dereference when asking for registers from eprobes

 - Make eprobes consistent with kprobes/uprobes, filters and histograms


Please pull the latest trace-v6.0-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v6.0-rc1

Tag SHA1: e29cad9f0ae9b811dfb20fe56a4ab80f7e858e3a
Head SHA1: 2a64880ed7589361fec95f30065d433842c0d450


Bart Van Assche (1):
      tracing: Suppress sparse warnings triggered by is_signed_type()

Lukas Bulwahn (1):
      tracing: React to error return from traceprobe_parse_event_name()

Steven Rostedt (Google) (7):
      tracing/perf: Fix double put of trace event when init fails
      tracing/eprobes: Do not allow eprobes to use $stack, or % for regs
      tracing/eprobes: Do not hardcode $comm as a string
      tracing/eprobes: Fix reading of string fields
      tracing/eprobes: Have event probes be consistent with kprobes and uprobes
      tracing/probes: Have kprobes and uprobes use $COMM too
      tracing: Have filter accept "common_cpu" to be consistent

Yang Jihong (1):
      ftrace: Fix NULL pointer dereference in is_ftrace_trampoline when ftrace is dead

----
 include/linux/trace_events.h    | 12 ++++++
 kernel/trace/ftrace.c           | 10 +++++
 kernel/trace/trace_eprobe.c     | 93 +++++++++++++++++++++++++++++++++++++----
 kernel/trace/trace_event_perf.c |  7 ++--
 kernel/trace/trace_events.c     |  1 +
 kernel/trace/trace_probe.c      | 29 ++++++++-----
 6 files changed, 131 insertions(+), 21 deletions(-)
---------------------------
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index b18759a673c6..b60347a0ccde 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -814,7 +814,19 @@ extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
 
+/*
+ * There is no known way to check signedness of __bitwise types without
+ * triggering a sparse warning. Hence the #ifdef __CHECKER__.
+ *
+ * Since there is another definition of is_signed_type() in <linux/overflow.h>,
+ * undefine is_signed_type() before redefining it.
+ */
+#undef is_signed_type
+#ifdef __CHECKER__
+#define is_signed_type(type)	0
+#else
 #define is_signed_type(type)	(((type)(-1)) < (type)1)
+#endif
 
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 601ccf1b2f09..4baa99363b16 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2937,6 +2937,16 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 
 	ftrace_startup_enable(command);
 
+	/*
+	 * If ftrace is in an undefined state, we just remove ops from list
+	 * to prevent the NULL pointer, instead of totally rolling it back and
+	 * free trampoline, because those actions could cause further damage.
+	 */
+	if (unlikely(ftrace_disabled)) {
+		__unregister_ftrace_function(ops);
+		return -ENODEV;
+	}
+
 	ops->flags &= ~FTRACE_OPS_FL_ADDING;
 
 	return 0;
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 4a0e9d927443..1783e3478912 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -227,6 +227,7 @@ static int trace_eprobe_tp_arg_update(struct trace_eprobe *ep, int i)
 	struct probe_arg *parg = &ep->tp.args[i];
 	struct ftrace_event_field *field;
 	struct list_head *head;
+	int ret = -ENOENT;
 
 	head = trace_get_fields(ep->event);
 	list_for_each_entry(field, head, link) {
@@ -236,9 +237,20 @@ static int trace_eprobe_tp_arg_update(struct trace_eprobe *ep, int i)
 			return 0;
 		}
 	}
+
+	/*
+	 * Argument not found on event. But allow for comm and COMM
+	 * to be used to get the current->comm.
+	 */
+	if (strcmp(parg->code->data, "COMM") == 0 ||
+	    strcmp(parg->code->data, "comm") == 0) {
+		parg->code->op = FETCH_OP_COMM;
+		ret = 0;
+	}
+
 	kfree(parg->code->data);
 	parg->code->data = NULL;
-	return -ENOENT;
+	return ret;
 }
 
 static int eprobe_event_define_fields(struct trace_event_call *event_call)
@@ -311,6 +323,27 @@ static unsigned long get_event_field(struct fetch_insn *code, void *rec)
 
 	addr = rec + field->offset;
 
+	if (is_string_field(field)) {
+		switch (field->filter_type) {
+		case FILTER_DYN_STRING:
+			val = (unsigned long)(rec + (*(unsigned int *)addr & 0xffff));
+			break;
+		case FILTER_RDYN_STRING:
+			val = (unsigned long)(addr + (*(unsigned int *)addr & 0xffff));
+			break;
+		case FILTER_STATIC_STRING:
+			val = (unsigned long)addr;
+			break;
+		case FILTER_PTR_STRING:
+			val = (unsigned long)(*(char *)addr);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return 0;
+		}
+		return val;
+	}
+
 	switch (field->size) {
 	case 1:
 		if (field->is_signed)
@@ -342,16 +375,38 @@ static unsigned long get_event_field(struct fetch_insn *code, void *rec)
 
 static int get_eprobe_size(struct trace_probe *tp, void *rec)
 {
+	struct fetch_insn *code;
 	struct probe_arg *arg;
 	int i, len, ret = 0;
 
 	for (i = 0; i < tp->nr_args; i++) {
 		arg = tp->args + i;
-		if (unlikely(arg->dynamic)) {
+		if (arg->dynamic) {
 			unsigned long val;
 
-			val = get_event_field(arg->code, rec);
-			len = process_fetch_insn_bottom(arg->code + 1, val, NULL, NULL);
+			code = arg->code;
+ retry:
+			switch (code->op) {
+			case FETCH_OP_TP_ARG:
+				val = get_event_field(code, rec);
+				break;
+			case FETCH_OP_IMM:
+				val = code->immediate;
+				break;
+			case FETCH_OP_COMM:
+				val = (unsigned long)current->comm;
+				break;
+			case FETCH_OP_DATA:
+				val = (unsigned long)code->data;
+				break;
+			case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
+				code++;
+				goto retry;
+			default:
+				continue;
+			}
+			code++;
+			len = process_fetch_insn_bottom(code, val, NULL, NULL);
 			if (len > 0)
 				ret += len;
 		}
@@ -369,8 +424,28 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 {
 	unsigned long val;
 
-	val = get_event_field(code, rec);
-	return process_fetch_insn_bottom(code + 1, val, dest, base);
+ retry:
+	switch (code->op) {
+	case FETCH_OP_TP_ARG:
+		val = get_event_field(code, rec);
+		break;
+	case FETCH_OP_IMM:
+		val = code->immediate;
+		break;
+	case FETCH_OP_COMM:
+		val = (unsigned long)current->comm;
+		break;
+	case FETCH_OP_DATA:
+		val = (unsigned long)code->data;
+		break;
+	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
+		code++;
+		goto retry;
+	default:
+		return -EILSEQ;
+	}
+	code++;
+	return process_fetch_insn_bottom(code, val, dest, base);
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
 
@@ -845,6 +920,10 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
 			trace_probe_log_err(0, BAD_ATTACH_ARG);
 	}
 
+	/* Handle symbols "@" */
+	if (!ret)
+		ret = traceprobe_update_arg(&ep->tp.args[i]);
+
 	return ret;
 }
 
@@ -883,7 +962,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	trace_probe_log_set_index(1);
 	sys_event = argv[1];
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
-	if (!sys_event || !sys_name) {
+	if (ret || !sys_event || !sys_name) {
 		trace_probe_log_err(0, NO_EVENT_INFO);
 		goto parse_error;
 	}
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a114549720d6..61e3a2620fa3 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -157,7 +157,7 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
 	int i;
 
 	if (--tp_event->perf_refcount > 0)
-		goto out;
+		return;
 
 	tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
 
@@ -176,8 +176,6 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
 			perf_trace_buf[i] = NULL;
 		}
 	}
-out:
-	trace_event_put_ref(tp_event);
 }
 
 static int perf_trace_event_open(struct perf_event *p_event)
@@ -241,6 +239,7 @@ void perf_trace_destroy(struct perf_event *p_event)
 	mutex_lock(&event_mutex);
 	perf_trace_event_close(p_event);
 	perf_trace_event_unreg(p_event);
+	trace_event_put_ref(p_event->tp_event);
 	mutex_unlock(&event_mutex);
 }
 
@@ -292,6 +291,7 @@ void perf_kprobe_destroy(struct perf_event *p_event)
 	mutex_lock(&event_mutex);
 	perf_trace_event_close(p_event);
 	perf_trace_event_unreg(p_event);
+	trace_event_put_ref(p_event->tp_event);
 	mutex_unlock(&event_mutex);
 
 	destroy_local_trace_kprobe(p_event->tp_event);
@@ -347,6 +347,7 @@ void perf_uprobe_destroy(struct perf_event *p_event)
 	mutex_lock(&event_mutex);
 	perf_trace_event_close(p_event);
 	perf_trace_event_unreg(p_event);
+	trace_event_put_ref(p_event->tp_event);
 	mutex_unlock(&event_mutex);
 	destroy_local_trace_uprobe(p_event->tp_event);
 }
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 181f08186d32..0356cae0cf74 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -176,6 +176,7 @@ static int trace_define_generic_fields(void)
 
 	__generic_field(int, CPU, FILTER_CPU);
 	__generic_field(int, cpu, FILTER_CPU);
+	__generic_field(int, common_cpu, FILTER_CPU);
 	__generic_field(char *, COMM, FILTER_COMM);
 	__generic_field(char *, comm, FILTER_COMM);
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 850a88abd33b..36dff277de46 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -283,7 +283,14 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 	int ret = 0;
 	int len;
 
-	if (strcmp(arg, "retval") == 0) {
+	if (flags & TPARG_FL_TPOINT) {
+		if (code->data)
+			return -EFAULT;
+		code->data = kstrdup(arg, GFP_KERNEL);
+		if (!code->data)
+			return -ENOMEM;
+		code->op = FETCH_OP_TP_ARG;
+	} else if (strcmp(arg, "retval") == 0) {
 		if (flags & TPARG_FL_RETURN) {
 			code->op = FETCH_OP_RETVAL;
 		} else {
@@ -307,7 +314,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 			}
 		} else
 			goto inval_var;
-	} else if (strcmp(arg, "comm") == 0) {
+	} else if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
 		code->op = FETCH_OP_COMM;
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	} else if (((flags & TPARG_FL_MASK) ==
@@ -323,13 +330,6 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 		code->op = FETCH_OP_ARG;
 		code->param = (unsigned int)param - 1;
 #endif
-	} else if (flags & TPARG_FL_TPOINT) {
-		if (code->data)
-			return -EFAULT;
-		code->data = kstrdup(arg, GFP_KERNEL);
-		if (!code->data)
-			return -ENOMEM;
-		code->op = FETCH_OP_TP_ARG;
 	} else
 		goto inval_var;
 
@@ -384,6 +384,11 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		break;
 
 	case '%':	/* named register */
+		if (flags & TPARG_FL_TPOINT) {
+			/* eprobes do not handle registers */
+			trace_probe_log_err(offs, BAD_VAR);
+			break;
+		}
 		ret = regs_query_register_offset(arg + 1);
 		if (ret >= 0) {
 			code->op = FETCH_OP_REG;
@@ -617,9 +622,11 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 
 	/*
 	 * Since $comm and immediate string can not be dereferenced,
-	 * we can find those by strcmp.
+	 * we can find those by strcmp. But ignore for eprobes.
 	 */
-	if (strcmp(arg, "$comm") == 0 || strncmp(arg, "\\\"", 2) == 0) {
+	if (!(flags & TPARG_FL_TPOINT) &&
+	    (strcmp(arg, "$comm") == 0 || strcmp(arg, "$COMM") == 0 ||
+	     strncmp(arg, "\\\"", 2) == 0)) {
 		/* The type of $comm must be "string", and not an array. */
 		if (parg->count || (t && strcmp(t, "string")))
 			goto out;
