Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B25536F38
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 05:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiE2DfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 23:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiE2DfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 23:35:05 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD725FDA
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 20:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653795304; x=1685331304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTLeVtdGiqXGjUTVh45e9aj+QkquVDKFMRh70PnS8TM=;
  b=yog10ebn+JiiAh+4J5XF4+x+rdQdZbf1LvH9XEXugiBzQwYOD0AAbhZ3
   sLKVtVY14zNvcoMIBcByvXMGXTcN4zcabkuW7Kg0YwVH3fYd1B1v+CTjV
   VBQ9rdmQAseAHZWiSsrDBf9wL1EzYSxS2a/7reuX/AtF5EpzOUoQz9npq
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 May 2022 20:35:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 20:35:03 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 28 May 2022 20:35:03 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 28 May 2022 20:35:01 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v2 1/2] tracing: auto generate event name when create a group of events
Date:   Sun, 29 May 2022 11:34:53 +0800
Message-ID: <1653795294-19764-2-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653795294-19764-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1653795294-19764-1-git-send-email-quic_linyyuan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when create a specific group of trace events,
take kprobe event as example, user must use the following format:
p:GRP/EVENT [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS],
which means user must enter EVENT name, one example is: echo
'p:usb_gadget/config_usb_cfg_link config_usb_cfg_link $arg1' >>
kprobe_events, it is not simple if there are too many entries
because the event name is same as symbol name.

This change allows user to specify no EVENT name, format changed as:
p:GRP/ [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS],
it will generate event name automatically and one example is:
echo 'p:usb_gadget/ config_usb_cfg_link $arg1' >> kprobe_events.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
v2: fix review comments in V1:
    change TP_ENAME_EMPTTY to TP_ENAME_EMPTY,
    add some space,
    document the macros return by traceprobe_parse_event_name(),
    updatea commit description.

 Documentation/trace/kprobetrace.rst  |  8 ++++----
 Documentation/trace/uprobetracer.rst |  8 ++++----
 kernel/trace/trace_dynevent.c        |  2 +-
 kernel/trace/trace_eprobe.c          | 20 ++++++++++++--------
 kernel/trace/trace_kprobe.c          | 19 ++++++++++++-------
 kernel/trace/trace_probe.c           |  9 ++++++++-
 kernel/trace/trace_probe.h           |  4 ++++
 kernel/trace/trace_uprobe.c          | 15 ++++++++++-----
 8 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index b175d88..4274cc6 100644
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
index a8e5938..3a1797d7 100644
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
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index e34e8182..033248d 100644
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
index 7d44785..13cd7fc 100644
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
+	char grp_buf[MAX_EVENT_NAME_LEN];
 	int ret = 0;
 	int i;
 
@@ -866,14 +868,17 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	trace_probe_log_init("event_probe", argc, argv);
 
+	ret = TP_ENAME_EMPTY;
 	event = strchr(&argv[0][1], ':');
 	if (event) {
 		event++;
-		ret = traceprobe_parse_event_name(&event, &group, buf1,
+		ret = traceprobe_parse_event_name(&event, &group, grp_buf,
 						  event - argv[0]);
-		if (ret)
+		if (ret < 0)
 			goto parse_error;
-	} else {
+	}
+
+	if (ret == TP_ENAME_EMPTY || ret == TP_ENAME_GROUP) {
 		strscpy(buf1, argv[1], MAX_EVENT_NAME_LEN);
 		sanitize_event_name(buf1);
 		event = buf1;
@@ -882,9 +887,8 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		goto parse_error;
 
 	sys_event = argv[1];
-	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2,
-					  sys_event - argv[1]);
-	if (ret || !sys_name)
+	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
+	if (ret != TP_ENAME_GROUP_EVENT)
 		goto parse_error;
 	if (!is_good_name(sys_event) || !is_good_name(sys_name))
 		goto parse_error;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 47cebef..55822b6 100644
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
+	char grp_buf[MAX_EVENT_NAME_LEN];
 	unsigned int flags = TPARG_FL_KERNEL;
 
 	switch (argv[0][0]) {
@@ -832,12 +834,15 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	}
 
 	trace_probe_log_set_index(0);
+	ret = TP_ENAME_EMPTY;
 	if (event) {
-		ret = traceprobe_parse_event_name(&event, &group, buf,
+		ret = traceprobe_parse_event_name(&event, &group, grp_buf,
 						  event - argv[0]);
-		if (ret)
+		if (ret < 0)
 			goto parse_error;
-	} else {
+	}
+
+	if (ret == TP_ENAME_EMPTY || ret == TP_ENAME_GROUP) {
 		/* Make a new event name */
 		if (symbol)
 			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_%ld",
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 80863c6..7fd50ab 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -257,6 +257,9 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 	}
 	len = strlen(event);
 	if (len == 0) {
+		if (slash)
+			return TP_ENAME_GROUP;
+
 		trace_probe_log_err(offset, NO_EVENT_NAME);
 		return -EINVAL;
 	} else if (len > MAX_EVENT_NAME_LEN) {
@@ -267,7 +270,11 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 		trace_probe_log_err(offset, BAD_EVENT_NAME);
 		return -EINVAL;
 	}
-	return 0;
+
+	if (slash)
+		return TP_ENAME_GROUP_EVENT;
+
+	return TP_ENAME_EVENT;
 }
 
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 92cc149..7390669 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -364,6 +364,10 @@ extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
 int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 				char *buf, int offset);
+#define TP_ENAME_GROUP_EVENT	0 /* GRP/EVENT format, user defined group and event name */
+#define TP_ENAME_EVENT		1 /* EVENT format, user defined event name, default group */
+#define TP_ENAME_GROUP		2 /* GRP/ format, user defined group name, auto event name */
+#define TP_ENAME_EMPTY		3 /* default group and auto event name */
 
 enum probe_print_type {
 	PROBE_PRINT_NORMAL,
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9711589..bc32361 100644
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
+	char grp_buf[MAX_EVENT_NAME_LEN];
 	enum probe_print_type ptype;
 	struct path path;
 	unsigned long offset, ref_ctr_offset;
@@ -644,12 +646,15 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	/* setup a probe */
 	trace_probe_log_set_index(0);
+	ret = TP_ENAME_EMPTY;
 	if (event) {
-		ret = traceprobe_parse_event_name(&event, &group, buf,
+		ret = traceprobe_parse_event_name(&event, &group, grp_buf,
 						  event - argv[0]);
-		if (ret)
+		if (ret < 0)
 			goto fail_address_parse;
-	} else {
+	}
+
+	if (ret == TP_ENAME_EMPTY || ret == TP_ENAME_GROUP) {
 		char *tail;
 		char *ptr;
 
-- 
2.7.4

