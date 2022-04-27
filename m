Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106A05122F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiD0TmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiD0Tj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B841FB72
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DB733CE253B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECCEC385AF;
        Wed, 27 Apr 2022 19:36:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSq-002Ipn-4X;
        Wed, 27 Apr 2022 15:36:40 -0400
Message-ID: <20220427193639.970466555@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 03/21] tracing: Remove redundant trigger_ops params
References: <20220427193623.529296556@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Since event_trigger_data contains the .ops trigger_ops field, there's
no reason to pass the trigger_ops separately. Remove it as a param
from functions whenever event_trigger_data is passed.

Link: https://lkml.kernel.org/r/9856c9bc81bde57077f5b8d6f8faa47156c6354a.1644010575.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                | 14 +++------
 kernel/trace/trace_eprobe.c         |  7 ++---
 kernel/trace/trace_events_hist.c    | 29 ++++++++----------
 kernel/trace/trace_events_trigger.c | 46 +++++++++++------------------
 4 files changed, 36 insertions(+), 60 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2bc8036b0659..f3e4cd1bb60e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1573,10 +1573,8 @@ struct enable_trigger_data {
 };
 
 extern int event_enable_trigger_print(struct seq_file *m,
-				      struct event_trigger_ops *ops,
-				      struct event_trigger_data *data);
-extern void event_enable_trigger_free(struct event_trigger_ops *ops,
 				      struct event_trigger_data *data);
+extern void event_enable_trigger_free(struct event_trigger_data *data);
 extern int event_enable_trigger_parse(struct event_command *cmd_ops,
 				      struct trace_event_file *file,
 				      char *glob, char *cmd, char *param);
@@ -1587,8 +1585,7 @@ extern void event_enable_unregister_trigger(char *glob,
 					    struct event_trigger_data *test,
 					    struct trace_event_file *file);
 extern void trigger_data_free(struct event_trigger_data *data);
-extern int event_trigger_init(struct event_trigger_ops *ops,
-			      struct event_trigger_data *data);
+extern int event_trigger_init(struct event_trigger_data *data);
 extern int trace_event_trigger_enable_disable(struct trace_event_file *file,
 					      int trigger_enable);
 extern void update_cond_flag(struct trace_event_file *file);
@@ -1687,12 +1684,9 @@ struct event_trigger_ops {
 					   struct trace_buffer *buffer,
 					   void *rec,
 					   struct ring_buffer_event *rbe);
-	int			(*init)(struct event_trigger_ops *ops,
-					struct event_trigger_data *data);
-	void			(*free)(struct event_trigger_ops *ops,
-					struct event_trigger_data *data);
+	int			(*init)(struct event_trigger_data *data);
+	void			(*free)(struct event_trigger_data *data);
 	int			(*print)(struct seq_file *m,
-					 struct event_trigger_ops *ops,
 					 struct event_trigger_data *data);
 };
 
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 541aa13581b9..9b3dfc9da067 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -511,20 +511,17 @@ __eprobe_trace_func(struct eprobe_data *edata, void *rec)
  * functions are just stubs to fulfill what is needed to use the trigger
  * infrastructure.
  */
-static int eprobe_trigger_init(struct event_trigger_ops *ops,
-			       struct event_trigger_data *data)
+static int eprobe_trigger_init(struct event_trigger_data *data)
 {
 	return 0;
 }
 
-static void eprobe_trigger_free(struct event_trigger_ops *ops,
-				struct event_trigger_data *data)
+static void eprobe_trigger_free(struct event_trigger_data *data)
 {
 
 }
 
 static int eprobe_trigger_print(struct seq_file *m,
-				struct event_trigger_ops *ops,
 				struct event_trigger_data *data)
 {
 	/* Do not print eprobe event triggers */
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b18d00905eae..40a7e5582dfb 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5252,7 +5252,7 @@ static void hist_trigger_show(struct seq_file *m,
 		seq_puts(m, "\n\n");
 
 	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data->ops, data);
+	data->ops->print(m, data);
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
@@ -5484,7 +5484,7 @@ static void hist_trigger_debug_show(struct seq_file *m,
 		seq_puts(m, "\n\n");
 
 	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data->ops, data);
+	data->ops->print(m, data);
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
@@ -5621,7 +5621,6 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 }
 
 static int event_hist_trigger_print(struct seq_file *m,
-				    struct event_trigger_ops *ops,
 				    struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
@@ -5729,8 +5728,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 	return 0;
 }
 
-static int event_hist_trigger_init(struct event_trigger_ops *ops,
-				   struct event_trigger_data *data)
+static int event_hist_trigger_init(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 
@@ -5758,8 +5756,7 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	}
 }
 
-static void event_hist_trigger_free(struct event_trigger_ops *ops,
-				    struct event_trigger_data *data)
+static void event_hist_trigger_free(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 
@@ -5788,25 +5785,23 @@ static struct event_trigger_ops event_hist_trigger_ops = {
 	.free			= event_hist_trigger_free,
 };
 
-static int event_hist_trigger_named_init(struct event_trigger_ops *ops,
-					 struct event_trigger_data *data)
+static int event_hist_trigger_named_init(struct event_trigger_data *data)
 {
 	data->ref++;
 
 	save_named_trigger(data->named_data->name, data);
 
-	event_hist_trigger_init(ops, data->named_data);
+	event_hist_trigger_init(data->named_data);
 
 	return 0;
 }
 
-static void event_hist_trigger_named_free(struct event_trigger_ops *ops,
-					  struct event_trigger_data *data)
+static void event_hist_trigger_named_free(struct event_trigger_data *data)
 {
 	if (WARN_ON_ONCE(data->ref <= 0))
 		return;
 
-	event_hist_trigger_free(ops, data->named_data);
+	event_hist_trigger_free(data->named_data);
 
 	data->ref--;
 	if (!data->ref) {
@@ -5993,7 +5988,7 @@ static int hist_register_trigger(char *glob,
 	}
 
 	if (data->ops->init) {
-		ret = data->ops->init(data->ops, data);
+		ret = data->ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -6111,7 +6106,7 @@ static void hist_unregister_trigger(char *glob,
 	}
 
 	if (unregistered && test->ops->free)
-		test->ops->free(test->ops, test);
+		test->ops->free(test);
 
 	if (hist_data->enable_timestamps) {
 		if (!hist_data->remove || unregistered)
@@ -6164,7 +6159,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 			if (hist_data->enable_timestamps)
 				tracing_set_filter_buffering(file->tr, false);
 			if (test->ops->free)
-				test->ops->free(test->ops, test);
+				test->ops->free(test);
 		}
 	}
 }
@@ -6458,7 +6453,7 @@ static void hist_enable_unreg_all(struct trace_event_file *file)
 			update_cond_flag(file);
 			trace_event_trigger_enable_disable(file, 0);
 			if (test->ops->free)
-				test->ops->free(test->ops, test);
+				test->ops->free(test);
 		}
 	}
 }
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index ea13679054a8..32202175875d 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -188,7 +188,7 @@ static int trigger_show(struct seq_file *m, void *v)
 	}
 
 	data = list_entry(v, struct event_trigger_data, list);
-	data->ops->print(m, data->ops, data);
+	data->ops->print(m, data);
 
 	return 0;
 }
@@ -432,7 +432,6 @@ event_trigger_print(const char *name, struct seq_file *m,
 
 /**
  * event_trigger_init - Generic event_trigger_ops @init implementation
- * @ops: The trigger ops associated with the trigger
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger initialization.
@@ -442,8 +441,7 @@ event_trigger_print(const char *name, struct seq_file *m,
  *
  * Return: 0 on success, errno otherwise
  */
-int event_trigger_init(struct event_trigger_ops *ops,
-		       struct event_trigger_data *data)
+int event_trigger_init(struct event_trigger_data *data)
 {
 	data->ref++;
 	return 0;
@@ -451,7 +449,6 @@ int event_trigger_init(struct event_trigger_ops *ops,
 
 /**
  * event_trigger_free - Generic event_trigger_ops @free implementation
- * @ops: The trigger ops associated with the trigger
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger de-initialization.
@@ -460,8 +457,7 @@ int event_trigger_init(struct event_trigger_ops *ops,
  * implementations.
  */
 static void
-event_trigger_free(struct event_trigger_ops *ops,
-		   struct event_trigger_data *data)
+event_trigger_free(struct event_trigger_data *data)
 {
 	if (WARN_ON_ONCE(data->ref <= 0))
 		return;
@@ -515,7 +511,7 @@ clear_event_triggers(struct trace_array *tr)
 			trace_event_trigger_enable_disable(file, 0);
 			list_del_rcu(&data->list);
 			if (data->ops->free)
-				data->ops->free(data->ops, data);
+				data->ops->free(data);
 		}
 	}
 }
@@ -581,7 +577,7 @@ static int register_trigger(char *glob,
 	}
 
 	if (data->ops->init) {
-		ret = data->ops->init(data->ops, data);
+		ret = data->ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -629,7 +625,7 @@ static void unregister_trigger(char *glob,
 	}
 
 	if (unregistered && data->ops->free)
-		data->ops->free(data->ops, data);
+		data->ops->free(data);
 }
 
 /*
@@ -1049,14 +1045,14 @@ event_trigger_parse(struct event_command *cmd_ops,
 
  out_reg:
 	/* Up the trigger_data count to make sure reg doesn't free it on failure */
-	event_trigger_init(trigger_ops, trigger_data);
+	event_trigger_init(trigger_data);
 
 	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
 	if (ret)
 		goto out_free;
 
 	/* Down the counter of trigger_data or free it if not used anymore */
-	event_trigger_free(trigger_ops, trigger_data);
+	event_trigger_free(trigger_data);
  out:
 	return ret;
 
@@ -1382,16 +1378,14 @@ traceoff_count_trigger(struct event_trigger_data *data,
 }
 
 static int
-traceon_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
-		      struct event_trigger_data *data)
+traceon_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
 	return event_trigger_print("traceon", m, (void *)data->count,
 				   data->filter_str);
 }
 
 static int
-traceoff_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
-		       struct event_trigger_data *data)
+traceoff_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
 	return event_trigger_print("traceoff", m, (void *)data->count,
 				   data->filter_str);
@@ -1502,8 +1496,7 @@ register_snapshot_trigger(char *glob,
 }
 
 static int
-snapshot_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
-		       struct event_trigger_data *data)
+snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
 	return event_trigger_print("snapshot", m, (void *)data->count,
 				   data->filter_str);
@@ -1598,8 +1591,7 @@ stacktrace_count_trigger(struct event_trigger_data *data,
 }
 
 static int
-stacktrace_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
-			 struct event_trigger_data *data)
+stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
 	return event_trigger_print("stacktrace", m, (void *)data->count,
 				   data->filter_str);
@@ -1689,7 +1681,6 @@ event_enable_count_trigger(struct event_trigger_data *data,
 }
 
 int event_enable_trigger_print(struct seq_file *m,
-			       struct event_trigger_ops *ops,
 			       struct event_trigger_data *data)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
@@ -1714,8 +1705,7 @@ int event_enable_trigger_print(struct seq_file *m,
 	return 0;
 }
 
-void event_enable_trigger_free(struct event_trigger_ops *ops,
-			       struct event_trigger_data *data)
+void event_enable_trigger_free(struct event_trigger_data *data)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
@@ -1843,7 +1833,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	}
 
 	/* Up the trigger_data count to make sure nothing frees it on failure */
-	event_trigger_init(trigger_ops, trigger_data);
+	event_trigger_init(trigger_data);
 
 	if (trigger) {
 		number = strsep(&trigger, ":");
@@ -1887,7 +1877,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	if (ret)
 		goto out_disable;
 
-	event_trigger_free(trigger_ops, trigger_data);
+	event_trigger_free(trigger_data);
  out:
 	return ret;
 
@@ -1898,7 +1888,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
-	event_trigger_free(trigger_ops, trigger_data);
+	event_trigger_free(trigger_data);
 	kfree(enable_data);
 	goto out;
 }
@@ -1926,7 +1916,7 @@ int event_enable_register_trigger(char *glob,
 	}
 
 	if (data->ops->init) {
-		ret = data->ops->init(data->ops, data);
+		ret = data->ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -1969,7 +1959,7 @@ void event_enable_unregister_trigger(char *glob,
 	}
 
 	if (unregistered && data->ops->free)
-		data->ops->free(data->ops, data);
+		data->ops->free(data);
 }
 
 static struct event_trigger_ops *
-- 
2.35.1
