Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A15575335
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbiGNQoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbiGNQnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:43:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79126CFC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AF52B82743
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ADAC34115;
        Thu, 14 Jul 2022 16:43:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oC1w3-004lWW-Uv;
        Thu, 14 Jul 2022 12:43:31 -0400
Message-ID: <20220714164331.792493750@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 Jul 2022 12:43:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [for-next][PATCH 21/23] tracing: Auto generate event name when creating a group of events
References: <20220714164256.403842845@goodmis.org>
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

From: Linyu Yuan <quic_linyyuan@quicinc.com>

Currently when creating a specific group of trace events,
take kprobe event as example, the user must use the following format:
p:GRP/EVENT [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS],
which means user must enter EVENT name, one example is:

  echo 'p:usb_gadget/config_usb_cfg_link config_usb_cfg_link $arg1' >> kprobe_events

It is not simple if there are too many entries because the event name is
the same as symbol name.

This change allows user to specify no EVENT name, format changed as:

   p:GRP/ [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]

It will generate event name automatically and one example is:

  echo 'p:usb_gadget/ config_usb_cfg_link $arg1' >> kprobe_events.

Link: https://lore.kernel.org/all/1656296348-16111-4-git-send-email-quic_linyyuan@quicinc.com/

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/kprobetrace.rst  |  8 ++++----
 Documentation/trace/uprobetracer.rst |  8 ++++----
 kernel/trace/trace.c                 |  8 ++++----
 kernel/trace/trace_dynevent.c        |  2 +-
 kernel/trace/trace_eprobe.c          | 25 +++++++++++++------------
 kernel/trace/trace_kprobe.c          | 16 ++++++++++------
 kernel/trace/trace_probe.c           |  4 ++++
 kernel/trace/trace_uprobe.c          | 12 ++++++++----
 8 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index b175d88f31eb..4274cc6a2f94 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -28,10 +28,10 @@ Synopsis of kprobe_events
 -------------------------
 ::
 
-  p[:[GRP/]EVENT] [MOD:]SYM[+offs]|MEMADDR [FETCHARGS]	: Set a probe
-  r[MAXACTIVE][:[GRP/]EVENT] [MOD:]SYM[+0] [FETCHARGS]	: Set a return probe
-  p:[GRP/]EVENT] [MOD:]SYM[+0]%return [FETCHARGS]	: Set a return probe
-  -:[GRP/]EVENT						: Clear a probe
+  p[:[GRP/][EVENT]] [MOD:]SYM[+offs]|MEMADDR [FETCHARGS]	: Set a probe
+  r[MAXACTIVE][:[GRP/][EVENT]] [MOD:]SYM[+0] [FETCHARGS]	: Set a return probe
+  p[:[GRP/][EVENT]] [MOD:]SYM[+0]%return [FETCHARGS]	: Set a return probe
+  -:[GRP/][EVENT]						: Clear a probe
 
  GRP		: Group name. If omitted, use "kprobes" for it.
  EVENT		: Event name. If omitted, the event name is generated
diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
index a8e5938f609e..3a1797d707f4 100644
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -26,10 +26,10 @@ Synopsis of uprobe_tracer
 -------------------------
 ::
 
-  p[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a uprobe
-  r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
-  p[:[GRP/]EVENT] PATH:OFFSET%return [FETCHARGS] : Set a return uprobe (uretprobe)
-  -:[GRP/]EVENT                           : Clear uprobe or uretprobe event
+  p[:[GRP/][EVENT]] PATH:OFFSET [FETCHARGS] : Set a uprobe
+  r[:[GRP/][EVENT]] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
+  p[:[GRP/][EVENT]] PATH:OFFSET%return [FETCHARGS] : Set a return uprobe (uretprobe)
+  -:[GRP/][EVENT]                           : Clear uprobe or uretprobe event
 
   GRP           : Group name. If omitted, "uprobes" is the default value.
   EVENT         : Event name. If omitted, the event name is generated based
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8dd54627075..7eb5bce62500 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5569,13 +5569,13 @@ static const char readme_msg[] =
 #endif
 #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
 	"\t  accepts: event-definitions (one definition per line)\n"
-	"\t   Format: p[:[<group>/]<event>] <place> [<args>]\n"
-	"\t           r[maxactive][:[<group>/]<event>] <place> [<args>]\n"
+	"\t   Format: p[:[<group>/][<event>]] <place> [<args>]\n"
+	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t           s:[synthetic/]<event> <field> [<field>]\n"
 #endif
-	"\t           e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]\n"
-	"\t           -:[<group>/]<event>\n"
+	"\t           e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]\n"
+	"\t           -:[<group>/][<event>]\n"
 #ifdef CONFIG_KPROBE_EVENTS
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
   "place (kretprobe): [<module>:]<symbol>[+<offset>]%return|<memaddr>\n"
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 076b447a1b88..154996684fb5 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -101,7 +101,7 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		event = p + 1;
 		*p = '\0';
 	}
-	if (event[0] == '\0') {
+	if (!system && event[0] == '\0') {
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 8979cb9ec37a..a30f21499e81 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -125,6 +125,7 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
 	 * We match the following:
 	 *  event only			- match all eprobes with event name
 	 *  system and event only	- match all system/event probes
+	 *  system only			- match all system probes
 	 *
 	 * The below has the above satisfied with more arguments:
 	 *
@@ -143,7 +144,7 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
 		return false;
 
 	/* Must match the event name */
-	if (strcmp(trace_probe_name(&ep->tp), event) != 0)
+	if (event[0] != '\0' && strcmp(trace_probe_name(&ep->tp), event) != 0)
 		return false;
 
 	/* No arguments match all */
@@ -848,7 +849,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 {
 	/*
 	 * Argument syntax:
-	 *      e[:[GRP/]ENAME] SYSTEM.EVENT [FETCHARGS]
+	 *      e[:[GRP/][ENAME]] SYSTEM.EVENT [FETCHARGS]
 	 * Fetch args:
 	 *  <name>=$<field>[:TYPE]
 	 */
@@ -858,6 +859,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	struct trace_eprobe *ep = NULL;
 	char buf1[MAX_EVENT_NAME_LEN];
 	char buf2[MAX_EVENT_NAME_LEN];
+	char gbuf[MAX_EVENT_NAME_LEN];
 	int ret = 0;
 	int i;
 
@@ -869,25 +871,24 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	event = strchr(&argv[0][1], ':');
 	if (event) {
 		event++;
-		ret = traceprobe_parse_event_name(&event, &group, buf1,
+		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
 			goto parse_error;
-	} else {
-		strscpy(buf1, argv[1], MAX_EVENT_NAME_LEN);
-		sanitize_event_name(buf1);
-		event = buf1;
 	}
-	if (!is_good_name(event) || !is_good_name(group))
-		goto parse_error;
 
 	trace_probe_log_set_index(1);
 	sys_event = argv[1];
-	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2,
-					  sys_event - argv[1]);
-	if (ret || !sys_name)
+	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
+	if (!sys_event || !sys_name)
 		goto parse_error;
 
+	if (!event) {
+		strscpy(buf1, argv[1], MAX_EVENT_NAME_LEN);
+		sanitize_event_name(buf1);
+		event = buf1;
+	}
+
 	mutex_lock(&event_mutex);
 	event_call = find_and_get_event(sys_name, sys_event);
 	ep = alloc_event_probe(group, event, event_call, argc - 2);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a245ea673715..23f7f0ec4f4c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -163,7 +163,8 @@ static bool trace_kprobe_match(const char *system, const char *event,
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
 
-	return strcmp(trace_probe_name(&tk->tp), event) == 0 &&
+	return (event[0] == '\0' ||
+		strcmp(trace_probe_name(&tk->tp), event) == 0) &&
 	    (!system || strcmp(trace_probe_group_name(&tk->tp), system) == 0) &&
 	    trace_kprobe_match_command_head(tk, argc, argv);
 }
@@ -708,11 +709,11 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	/*
 	 * Argument syntax:
 	 *  - Add kprobe:
-	 *      p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]
+	 *      p[:[GRP/][EVENT]] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]
 	 *  - Add kretprobe:
-	 *      r[MAXACTIVE][:[GRP/]EVENT] [MOD:]KSYM[+0] [FETCHARGS]
+	 *      r[MAXACTIVE][:[GRP/][EVENT]] [MOD:]KSYM[+0] [FETCHARGS]
 	 *    Or
-	 *      p:[GRP/]EVENT] [MOD:]KSYM[+0]%return [FETCHARGS]
+	 *      p[:[GRP/][EVENT]] [MOD:]KSYM[+0]%return [FETCHARGS]
 	 *
 	 * Fetch args:
 	 *  $retval	: fetch return value
@@ -739,6 +740,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	long offset = 0;
 	void *addr = NULL;
 	char buf[MAX_EVENT_NAME_LEN];
+	char gbuf[MAX_EVENT_NAME_LEN];
 	unsigned int flags = TPARG_FL_KERNEL;
 
 	switch (argv[0][0]) {
@@ -833,11 +835,13 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 
 	trace_probe_log_set_index(0);
 	if (event) {
-		ret = traceprobe_parse_event_name(&event, &group, buf,
+		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
 			goto parse_error;
-	} else {
+	}
+
+	if (!event) {
 		/* Make a new event name */
 		if (symbol)
 			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_%ld",
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 80863c6508e5..850a88abd33b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -257,6 +257,10 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 	}
 	len = strlen(event);
 	if (len == 0) {
+		if (slash) {
+			*pevent = NULL;
+			return 0;
+		}
 		trace_probe_log_err(offset, NO_EVENT_NAME);
 		return -EINVAL;
 	} else if (len > MAX_EVENT_NAME_LEN) {
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c3dc4f859a6b..a3fec28961d6 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -312,7 +312,8 @@ static bool trace_uprobe_match(const char *system, const char *event,
 {
 	struct trace_uprobe *tu = to_trace_uprobe(ev);
 
-	return strcmp(trace_probe_name(&tu->tp), event) == 0 &&
+	return (event[0] == '\0' ||
+		strcmp(trace_probe_name(&tu->tp), event) == 0) &&
 	   (!system || strcmp(trace_probe_group_name(&tu->tp), system) == 0) &&
 	   trace_uprobe_match_command_head(tu, argc, argv);
 }
@@ -532,7 +533,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 
 /*
  * Argument syntax:
- *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET[%return][(REF)] [FETCHARGS]
+ *  - Add uprobe: p|r[:[GRP/][EVENT]] PATH:OFFSET[%return][(REF)] [FETCHARGS]
  */
 static int __trace_uprobe_create(int argc, const char **argv)
 {
@@ -540,6 +541,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
 	char *arg, *filename, *rctr, *rctr_end, *tmp;
 	char buf[MAX_EVENT_NAME_LEN];
+	char gbuf[MAX_EVENT_NAME_LEN];
 	enum probe_print_type ptype;
 	struct path path;
 	unsigned long offset, ref_ctr_offset;
@@ -644,11 +646,13 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	/* setup a probe */
 	trace_probe_log_set_index(0);
 	if (event) {
-		ret = traceprobe_parse_event_name(&event, &group, buf,
+		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
 			goto fail_address_parse;
-	} else {
+	}
+
+	if (!event) {
 		char *tail;
 		char *ptr;
 
-- 
2.35.1
