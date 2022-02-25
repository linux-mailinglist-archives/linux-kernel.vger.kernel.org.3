Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA36A4C4B60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243352AbiBYQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243120AbiBYQwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:52:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0918022311E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:52:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78B6361990
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBD5C340F8;
        Fri, 25 Feb 2022 16:52:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nNdpK-00B8KE-V3;
        Fri, 25 Feb 2022 11:52:18 -0500
Message-ID: <20220225165218.795842827@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 25 Feb 2022 11:51:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [for-linus][PATCH 04/13] eprobes: Remove redundant event type information
References: <20220225165151.824659113@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Currently, the event probes save the type of the event they are attached
to when recording the event. For example:

  # echo 'e:switch sched/sched_switch prev_state=$prev_state prev_prio=$prev_prio next_pid=$next_pid next_prio=$next_prio' > dynamic_events
  # cat events/eprobes/switch/format

 name: switch
 ID: 1717
 format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:unsigned int __probe_type;        offset:8;       size:4; signed:0;
        field:u64 prev_state;   offset:12;      size:8; signed:0;
        field:u64 prev_prio;    offset:20;      size:8; signed:0;
        field:u64 next_pid;     offset:28;      size:8; signed:0;
        field:u64 next_prio;    offset:36;      size:8; signed:0;

 print fmt: "(%u) prev_state=0x%Lx prev_prio=0x%Lx next_pid=0x%Lx next_prio=0x%Lx", REC->__probe_type, REC->prev_state, REC->prev_prio, REC->next_pid, REC->next_prio

The __probe_type adds 4 bytes to every event.

One of the reasons for creating eprobes is to limit what is traced in an
event to be able to limit what is written into the ring buffer. Having
this redundant 4 bytes to every event takes away from this.

The event that is recorded can be retrieved from the event probe itself,
that is available when the trace is happening. For user space tools, it
could simply read the dynamic_event file to find the event they are for.
So there is really no reason to write this information into the ring
buffer for every event.

Link: https://lkml.kernel.org/r/20220218190057.2f5a19a8@gandalf.local.home

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h        |  1 -
 kernel/trace/trace_eprobe.c | 16 +++++++---------
 kernel/trace/trace_probe.c  | 10 +++++-----
 kernel/trace/trace_probe.h  |  1 -
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d038ddbf1bea..c5b09c31e077 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -136,7 +136,6 @@ struct kprobe_trace_entry_head {
 
 struct eprobe_trace_entry_head {
 	struct trace_entry	ent;
-	unsigned int		type;
 };
 
 struct kretprobe_trace_entry_head {
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 191db32dec46..541aa13581b9 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -242,7 +242,6 @@ static int trace_eprobe_tp_arg_update(struct trace_eprobe *ep, int i)
 
 static int eprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret;
 	struct eprobe_trace_entry_head field;
 	struct trace_probe *tp;
 
@@ -250,8 +249,6 @@ static int eprobe_event_define_fields(struct trace_event_call *event_call)
 	if (WARN_ON_ONCE(!tp))
 		return -ENOENT;
 
-	DEFINE_FIELD(unsigned int, type, FIELD_STRING_TYPE, 0);
-
 	return traceprobe_define_arg_fields(event_call, sizeof(field), tp);
 }
 
@@ -270,7 +267,9 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
 	struct trace_event_call *pevent;
 	struct trace_event *probed_event;
 	struct trace_seq *s = &iter->seq;
+	struct trace_eprobe *ep;
 	struct trace_probe *tp;
+	unsigned int type;
 
 	field = (struct eprobe_trace_entry_head *)iter->ent;
 	tp = trace_probe_primary_from_call(
@@ -278,15 +277,18 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
 	if (WARN_ON_ONCE(!tp))
 		goto out;
 
+	ep = container_of(tp, struct trace_eprobe, tp);
+	type = ep->event->event.type;
+
 	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
-	probed_event = ftrace_find_event(field->type);
+	probed_event = ftrace_find_event(type);
 	if (probed_event) {
 		pevent = container_of(probed_event, struct trace_event_call, event);
 		trace_seq_printf(s, "%s.%s", pevent->class->system,
 				 trace_event_name(pevent));
 	} else {
-		trace_seq_printf(s, "%u", field->type);
+		trace_seq_printf(s, "%u", type);
 	}
 
 	trace_seq_putc(s, ')');
@@ -498,10 +500,6 @@ __eprobe_trace_func(struct eprobe_data *edata, void *rec)
 		return;
 
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
-	if (edata->ep->event)
-		entry->type = edata->ep->event->event.type;
-	else
-		entry->type = 0;
 	store_trace_args(&entry[1], &edata->ep->tp, rec, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 73d90179b51b..80863c6508e5 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -871,15 +871,15 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 	switch (ptype) {
 	case PROBE_PRINT_NORMAL:
 		fmt = "(%lx)";
-		arg = "REC->" FIELD_STRING_IP;
+		arg = ", REC->" FIELD_STRING_IP;
 		break;
 	case PROBE_PRINT_RETURN:
 		fmt = "(%lx <- %lx)";
-		arg = "REC->" FIELD_STRING_FUNC ", REC->" FIELD_STRING_RETIP;
+		arg = ", REC->" FIELD_STRING_FUNC ", REC->" FIELD_STRING_RETIP;
 		break;
 	case PROBE_PRINT_EVENT:
-		fmt = "(%u)";
-		arg = "REC->" FIELD_STRING_TYPE;
+		fmt = "";
+		arg = "";
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -903,7 +903,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 					parg->type->fmt);
 	}
 
-	pos += snprintf(buf + pos, LEN_OR_ZERO, "\", %s", arg);
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"%s", arg);
 
 	for (i = 0; i < tp->nr_args; i++) {
 		parg = tp->args + i;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 99e7a5df025e..92cc149af0fd 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -38,7 +38,6 @@
 #define FIELD_STRING_IP		"__probe_ip"
 #define FIELD_STRING_RETIP	"__probe_ret_ip"
 #define FIELD_STRING_FUNC	"__probe_func"
-#define FIELD_STRING_TYPE	"__probe_type"
 
 #undef DEFINE_FIELD
 #define DEFINE_FIELD(type, item, name, is_signed)			\
-- 
2.34.1
