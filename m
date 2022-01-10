Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA1489B02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiAJOE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:04:28 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50190 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiAJOEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:04:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 67A5CCE138B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471E4C36AF3;
        Mon, 10 Jan 2022 14:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641823461;
        bh=+ghuVjxt7IGWnTnXmpCM+zMDS9tD9lEnGr5PcOt4+E0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NYlJYg2m85dUYv10IQzIn7dNIwUaJqFeMkjEx1FCET1/lxL0l+W+6pJWIHhul8pFd
         UN0zmmaz+EsIyMqsmqPZU5PrnA8Yw5GdgE9sTNd8XUIvnip7inllic4Ur0O1OyOS4n
         9bvyUj73lHoeyx3c1daWZsUFeGm94toIFdnrdY20wv7Tj026V+ZZJOZvfMq6EfSC4Q
         SgNqXs+9m+aLufFF0evrpO+sQSM7BfnGNOF631BnDhR69u/yUDf1dyelsC21AGfSFa
         hXdt5l4R/oJBOtsLIkXm1uOj9Q1vV+j6eEZpsg/uuswLHbT2KFUIW7KH8rbjeMewpf
         UnF3j6eeegJKw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 1/6] tracing: Change event_command func() to parse()
Date:   Mon, 10 Jan 2022 08:04:11 -0600
Message-Id: <7784e321840752ed88aac0b349c0c685fc9247b1.1641823001.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1641823001.git.zanussi@kernel.org>
References: <cover.1641823001.git.zanussi@kernel.org>
In-Reply-To: <cover.1641823001.git.zanussi@kernel.org>
References: <cover.1641823001.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the func() callback on event_command is too generic and is
easily confused with other callbacks with that name, so change it to
something that reflects its actual purpose.

In this case, the main purpose of the callback is to parse an event
command, so call it parse() instead.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.h                | 19 +++++++++++-------
 kernel/trace/trace_eprobe.c         |  8 ++++----
 kernel/trace/trace_events_hist.c    | 26 ++++++++++++-------------
 kernel/trace/trace_events_trigger.c | 30 ++++++++++++++---------------
 4 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8bd1a815ce90..25bd5706ef0b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1578,9 +1578,9 @@ extern int event_enable_trigger_print(struct seq_file *m,
 				      struct event_trigger_data *data);
 extern void event_enable_trigger_free(struct event_trigger_ops *ops,
 				      struct event_trigger_data *data);
-extern int event_enable_trigger_func(struct event_command *cmd_ops,
-				     struct trace_event_file *file,
-				     char *glob, char *cmd, char *param);
+extern int event_enable_trigger_parse(struct event_command *cmd_ops,
+				      struct trace_event_file *file,
+				      char *glob, char *cmd, char *param);
 extern int event_enable_register_trigger(char *glob,
 					 struct event_trigger_ops *ops,
 					 struct event_trigger_data *data,
@@ -1702,7 +1702,7 @@ struct event_trigger_ops {
  * All the methods below, except for @set_filter() and @unreg_all(),
  * must be implemented.
  *
- * @func: The callback function responsible for parsing and
+ * @parse: The callback function responsible for parsing and
  *	registering the trigger written to the 'trigger' file by the
  *	user.  It allocates the trigger instance and registers it with
  *	the appropriate trace event.  It makes use of the other
@@ -1737,15 +1737,20 @@ struct event_trigger_ops {
  *
  * @get_trigger_ops: The callback function invoked to retrieve the
  *	event_trigger_ops implementation associated with the command.
+ *	This callback function allows a single event_command to
+ *	support multiple trigger implementations via different sets of
+ *	event_trigger_ops, depending on the value of the @param
+ *	string.
  */
 struct event_command {
 	struct list_head	list;
 	char			*name;
 	enum event_trigger_type	trigger_type;
 	int			flags;
-	int			(*func)(struct event_command *cmd_ops,
-					struct trace_event_file *file,
-					char *glob, char *cmd, char *params);
+	int			(*parse)(struct event_command *cmd_ops,
+					 struct trace_event_file *file,
+					 char *glob, char *cmd,
+					 char *param_and_filter);
 	int			(*reg)(char *glob,
 				       struct event_trigger_ops *ops,
 				       struct event_trigger_data *data,
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 88487752d307..84d5bfa34a99 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -549,9 +549,9 @@ static struct event_trigger_ops eprobe_trigger_ops = {
 	.free			= eprobe_trigger_free,
 };
 
-static int eprobe_trigger_cmd_func(struct event_command *cmd_ops,
-				   struct trace_event_file *file,
-				   char *glob, char *cmd, char *param)
+static int eprobe_trigger_cmd_parse(struct event_command *cmd_ops,
+				    struct trace_event_file *file,
+				    char *glob, char *cmd, char *param)
 {
 	return -1;
 }
@@ -580,7 +580,7 @@ static struct event_command event_trigger_cmd = {
 	.name			= "eprobe",
 	.trigger_type		= ETT_EVENT_EPROBE,
 	.flags			= EVENT_CMD_FL_NEEDS_REC,
-	.func			= eprobe_trigger_cmd_func,
+	.parse			= eprobe_trigger_cmd_parse,
 	.reg			= eprobe_trigger_reg_func,
 	.unreg			= eprobe_trigger_unreg_func,
 	.unreg_all		= NULL,
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9b8da439149c..89bbbbd3a3f5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2761,9 +2761,9 @@ static char *find_trigger_filter(struct hist_trigger_data *hist_data,
 }
 
 static struct event_command trigger_hist_cmd;
-static int event_hist_trigger_func(struct event_command *cmd_ops,
-				   struct trace_event_file *file,
-				   char *glob, char *cmd, char *param);
+static int event_hist_trigger_parse(struct event_command *cmd_ops,
+				    struct trace_event_file *file,
+				    char *glob, char *cmd, char *param);
 
 static bool compatible_keys(struct hist_trigger_data *target_hist_data,
 			    struct hist_trigger_data *hist_data,
@@ -2966,8 +2966,8 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	var_hist->hist_data = hist_data;
 
 	/* Create the new histogram with our variable */
-	ret = event_hist_trigger_func(&trigger_hist_cmd, file,
-				      "", "hist", cmd);
+	ret = event_hist_trigger_parse(&trigger_hist_cmd, file,
+				       "", "hist", cmd);
 	if (ret) {
 		kfree(cmd);
 		kfree(var_hist->cmd);
@@ -5729,8 +5729,8 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	for (i = 0; i < hist_data->n_field_var_hists; i++) {
 		file = hist_data->field_var_hists[i]->hist_data->event_file;
 		cmd = hist_data->field_var_hists[i]->cmd;
-		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
-					      "!hist", "hist", cmd);
+		ret = event_hist_trigger_parse(&trigger_hist_cmd, file,
+					       "!hist", "hist", cmd);
 		WARN_ON_ONCE(ret < 0);
 	}
 }
@@ -6146,9 +6146,9 @@ static void hist_unreg_all(struct trace_event_file *file)
 	}
 }
 
-static int event_hist_trigger_func(struct event_command *cmd_ops,
-				   struct trace_event_file *file,
-				   char *glob, char *cmd, char *param)
+static int event_hist_trigger_parse(struct event_command *cmd_ops,
+				    struct trace_event_file *file,
+				    char *glob, char *cmd, char *param)
 {
 	unsigned int hist_trigger_bits = TRACING_MAP_BITS_DEFAULT;
 	struct event_trigger_data *trigger_data;
@@ -6331,7 +6331,7 @@ static struct event_command trigger_hist_cmd = {
 	.name			= "hist",
 	.trigger_type		= ETT_EVENT_HIST,
 	.flags			= EVENT_CMD_FL_NEEDS_REC,
-	.func			= event_hist_trigger_func,
+	.parse			= event_hist_trigger_parse,
 	.reg			= hist_register_trigger,
 	.unreg			= hist_unregister_trigger,
 	.unreg_all		= hist_unreg_all,
@@ -6446,7 +6446,7 @@ static void hist_enable_unreg_all(struct trace_event_file *file)
 static struct event_command trigger_hist_enable_cmd = {
 	.name			= ENABLE_HIST_STR,
 	.trigger_type		= ETT_HIST_ENABLE,
-	.func			= event_enable_trigger_func,
+	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.unreg_all		= hist_enable_unreg_all,
@@ -6457,7 +6457,7 @@ static struct event_command trigger_hist_enable_cmd = {
 static struct event_command trigger_hist_disable_cmd = {
 	.name			= DISABLE_HIST_STR,
 	.trigger_type		= ETT_HIST_ENABLE,
-	.func			= event_enable_trigger_func,
+	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.unreg_all		= hist_enable_unreg_all,
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 3d5c07239a2a..15aae07cbe61 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -245,7 +245,7 @@ int trigger_process_regex(struct trace_event_file *file, char *buff)
 	mutex_lock(&trigger_cmd_mutex);
 	list_for_each_entry(p, &trigger_commands, list) {
 		if (strcmp(p->name, command) == 0) {
-			ret = p->func(p, file, buff, command, next);
+			ret = p->parse(p, file, buff, command, next);
 			goto out_unlock;
 		}
 	}
@@ -622,7 +622,7 @@ static void unregister_trigger(char *glob, struct event_trigger_ops *ops,
 }
 
 /**
- * event_trigger_callback - Generic event_command @func implementation
+ * event_trigger_parse - Generic event_command @parse implementation
  * @cmd_ops: The command ops, used for trigger registration
  * @file: The trace_event_file associated with the event
  * @glob: The raw string used to register the trigger
@@ -632,15 +632,15 @@ static void unregister_trigger(char *glob, struct event_trigger_ops *ops,
  * Common implementation for event command parsing and trigger
  * instantiation.
  *
- * Usually used directly as the @func method in event command
+ * Usually used directly as the @parse method in event command
  * implementations.
  *
  * Return: 0 on success, errno otherwise
  */
 static int
-event_trigger_callback(struct event_command *cmd_ops,
-		       struct trace_event_file *file,
-		       char *glob, char *cmd, char *param)
+event_trigger_parse(struct event_command *cmd_ops,
+		    struct trace_event_file *file,
+		    char *glob, char *cmd, char *param)
 {
 	struct event_trigger_data *trigger_data;
 	struct event_trigger_ops *trigger_ops;
@@ -1069,7 +1069,7 @@ onoff_get_trigger_ops(char *cmd, char *param)
 static struct event_command trigger_traceon_cmd = {
 	.name			= "traceon",
 	.trigger_type		= ETT_TRACE_ONOFF,
-	.func			= event_trigger_callback,
+	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
 	.get_trigger_ops	= onoff_get_trigger_ops,
@@ -1080,7 +1080,7 @@ static struct event_command trigger_traceoff_cmd = {
 	.name			= "traceoff",
 	.trigger_type		= ETT_TRACE_ONOFF,
 	.flags			= EVENT_CMD_FL_POST_TRIGGER,
-	.func			= event_trigger_callback,
+	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
 	.get_trigger_ops	= onoff_get_trigger_ops,
@@ -1157,7 +1157,7 @@ snapshot_get_trigger_ops(char *cmd, char *param)
 static struct event_command trigger_snapshot_cmd = {
 	.name			= "snapshot",
 	.trigger_type		= ETT_SNAPSHOT,
-	.func			= event_trigger_callback,
+	.parse			= event_trigger_parse,
 	.reg			= register_snapshot_trigger,
 	.unreg			= unregister_trigger,
 	.get_trigger_ops	= snapshot_get_trigger_ops,
@@ -1249,7 +1249,7 @@ static struct event_command trigger_stacktrace_cmd = {
 	.name			= "stacktrace",
 	.trigger_type		= ETT_STACKTRACE,
 	.flags			= EVENT_CMD_FL_POST_TRIGGER,
-	.func			= event_trigger_callback,
+	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
 	.get_trigger_ops	= stacktrace_get_trigger_ops,
@@ -1380,9 +1380,9 @@ static struct event_trigger_ops event_disable_count_trigger_ops = {
 	.free			= event_enable_trigger_free,
 };
 
-int event_enable_trigger_func(struct event_command *cmd_ops,
-			      struct trace_event_file *file,
-			      char *glob, char *cmd, char *param)
+int event_enable_trigger_parse(struct event_command *cmd_ops,
+			       struct trace_event_file *file,
+			       char *glob, char *cmd, char *param)
 {
 	struct trace_event_file *event_enable_file;
 	struct enable_trigger_data *enable_data;
@@ -1628,7 +1628,7 @@ event_enable_get_trigger_ops(char *cmd, char *param)
 static struct event_command trigger_enable_cmd = {
 	.name			= ENABLE_EVENT_STR,
 	.trigger_type		= ETT_EVENT_ENABLE,
-	.func			= event_enable_trigger_func,
+	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.get_trigger_ops	= event_enable_get_trigger_ops,
@@ -1638,7 +1638,7 @@ static struct event_command trigger_enable_cmd = {
 static struct event_command trigger_disable_cmd = {
 	.name			= DISABLE_EVENT_STR,
 	.trigger_type		= ETT_EVENT_ENABLE,
-	.func			= event_enable_trigger_func,
+	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.get_trigger_ops	= event_enable_get_trigger_ops,
-- 
2.17.1

