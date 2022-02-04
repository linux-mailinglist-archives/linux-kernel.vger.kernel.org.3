Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985D24AA2E8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347638AbiBDWM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:12:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56956 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346216AbiBDWMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:12:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6CD1B83938
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 22:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A8AC004E1;
        Fri,  4 Feb 2022 22:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644012736;
        bh=+2HpRRHAX64zavC0oxxdhTf2E3AVpFDY+I85D/cs/3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=tvvK8yj0M+OQ/EL+dVgeYUh8+v3/K16lwTN5iOwFy8DAmRRcVaFvbJL3Qwe+PtYIx
         vlyUNzkH69ykVbP0oYn7hMuGPtbR1WvWt9eK1trCC74xy36DSBIDTmXMo72oo0uXry
         JYIDN/iCeobVgwdFnfkSqKmK6x9Jil4RZrshoZ6mjLamSGrgY/zT8FD1PZ6lQcSrWM
         5JH8l6jEUHLkrjFJd0Axu1p9/vIRSAlI4AcBD0CwfreY+ljEGiBxzoWgUaGs5mxg8N
         fSh9M3zoOEcnG41fAeF7tg5AAAXm+Fg/euMQQRsrjf7FyyiLdAxLSxH2SJEgrl53gy
         W83Zsap09Snqg==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/4] tracing: Remove redundant trigger_ops params
Date:   Fri,  4 Feb 2022 16:12:05 -0600
Message-Id: <9856c9bc81bde57077f5b8d6f8faa47156c6354a.1644010575.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1644010575.git.zanussi@kernel.org>
References: <cover.1644010575.git.zanussi@kernel.org>
In-Reply-To: <cover.1644010575.git.zanussi@kernel.org>
References: <cover.1644010575.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since event_trigger_data contains the .ops trigger_ops field, there's
no reason to pass the trigger_ops separately. Remove it as a param
from functions whenever event_trigger_data is passed.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.h                | 14 +++------
 kernel/trace/trace_eprobe.c         |  7 ++---
 kernel/trace/trace_events_hist.c    | 29 ++++++++----------
 kernel/trace/trace_events_trigger.c | 46 +++++++++++------------------
 4 files changed, 36 insertions(+), 60 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 835f1e3d9924..2e9d4919b367 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1574,10 +1574,8 @@ struct enable_trigger_data {
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
@@ -1588,8 +1586,7 @@ extern void event_enable_unregister_trigger(char *glob,
 					    struct event_trigger_data *test,
 					    struct trace_event_file *file);
 extern void trigger_data_free(struct event_trigger_data *data);
-extern int event_trigger_init(struct event_trigger_ops *ops,
-			      struct event_trigger_data *data);
+extern int event_trigger_init(struct event_trigger_data *data);
 extern int trace_event_trigger_enable_disable(struct trace_event_file *file,
 					      int trigger_enable);
 extern void update_cond_flag(struct trace_event_file *file);
@@ -1688,12 +1685,9 @@ struct event_trigger_ops {
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
index 191db32dec46..328b5f7c0039 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -513,20 +513,17 @@ __eprobe_trace_func(struct eprobe_data *edata, void *rec)
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
index 8df815bc0ac5..2ec27500a030 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5249,7 +5249,7 @@ static void hist_trigger_show(struct seq_file *m,
 		seq_puts(m, "\n\n");
 
 	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data->ops, data);
+	data->ops->print(m, data);
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
@@ -5481,7 +5481,7 @@ static void hist_trigger_debug_show(struct seq_file *m,
 		seq_puts(m, "\n\n");
 
 	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data->ops, data);
+	data->ops->print(m, data);
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
@@ -5618,7 +5618,6 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 }
 
 static int event_hist_trigger_print(struct seq_file *m,
-				    struct event_trigger_ops *ops,
 				    struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
@@ -5726,8 +5725,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 	return 0;
 }
 
-static int event_hist_trigger_init(struct event_trigger_ops *ops,
-				   struct event_trigger_data *data)
+static int event_hist_trigger_init(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 
@@ -5755,8 +5753,7 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	}
 }
 
-static void event_hist_trigger_free(struct event_trigger_ops *ops,
-				    struct event_trigger_data *data)
+static void event_hist_trigger_free(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 
@@ -5785,25 +5782,23 @@ static struct event_trigger_ops event_hist_trigger_ops = {
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
@@ -5990,7 +5985,7 @@ static int hist_register_trigger(char *glob,
 	}
 
 	if (data->ops->init) {
-		ret = data->ops->init(data->ops, data);
+		ret = data->ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -6108,7 +6103,7 @@ static void hist_unregister_trigger(char *glob,
 	}
 
 	if (unregistered && test->ops->free)
-		test->ops->free(test->ops, test);
+		test->ops->free(test);
 
 	if (hist_data->enable_timestamps) {
 		if (!hist_data->remove || unregistered)
@@ -6161,7 +6156,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 			if (hist_data->enable_timestamps)
 				tracing_set_filter_buffering(file->tr, false);
 			if (test->ops->free)
-				test->ops->free(test->ops, test);
+				test->ops->free(test);
 		}
 	}
 }
@@ -6455,7 +6450,7 @@ static void hist_enable_unreg_all(struct trace_event_file *file)
 			update_cond_flag(file);
 			trace_event_trigger_enable_disable(file, 0);
 			if (test->ops->free)
-				test->ops->free(test->ops, test);
+				test->ops->free(test);
 		}
 	}
 }
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 0ab86b5449d7..e87b1b88900e 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -174,7 +174,7 @@ static int trigger_show(struct seq_file *m, void *v)
 	}
 
 	data = list_entry(v, struct event_trigger_data, list);
-	data->ops->print(m, data->ops, data);
+	data->ops->print(m, data);
 
 	return 0;
 }
@@ -418,7 +418,6 @@ event_trigger_print(const char *name, struct seq_file *m,
 
 /**
  * event_trigger_init - Generic event_trigger_ops @init implementation
- * @ops: The trigger ops associated with the trigger
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger initialization.
@@ -428,8 +427,7 @@ event_trigger_print(const char *name, struct seq_file *m,
  *
  * Return: 0 on success, errno otherwise
  */
-int event_trigger_init(struct event_trigger_ops *ops,
-		       struct event_trigger_data *data)
+int event_trigger_init(struct event_trigger_data *data)
 {
 	data->ref++;
 	return 0;
@@ -437,7 +435,6 @@ int event_trigger_init(struct event_trigger_ops *ops,
 
 /**
  * event_trigger_free - Generic event_trigger_ops @free implementation
- * @ops: The trigger ops associated with the trigger
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger de-initialization.
@@ -446,8 +443,7 @@ int event_trigger_init(struct event_trigger_ops *ops,
  * implementations.
  */
 static void
-event_trigger_free(struct event_trigger_ops *ops,
-		   struct event_trigger_data *data)
+event_trigger_free(struct event_trigger_data *data)
 {
 	if (WARN_ON_ONCE(data->ref <= 0))
 		return;
@@ -501,7 +497,7 @@ clear_event_triggers(struct trace_array *tr)
 			trace_event_trigger_enable_disable(file, 0);
 			list_del_rcu(&data->list);
 			if (data->ops->free)
-				data->ops->free(data->ops, data);
+				data->ops->free(data);
 		}
 	}
 }
@@ -567,7 +563,7 @@ static int register_trigger(char *glob,
 	}
 
 	if (data->ops->init) {
-		ret = data->ops->init(data->ops, data);
+		ret = data->ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -615,7 +611,7 @@ static void unregister_trigger(char *glob,
 	}
 
 	if (unregistered && data->ops->free)
-		data->ops->free(data->ops, data);
+		data->ops->free(data);
 }
 
 /*
@@ -1035,14 +1031,14 @@ event_trigger_parse(struct event_command *cmd_ops,
 
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
 
@@ -1328,16 +1324,14 @@ traceoff_count_trigger(struct event_trigger_data *data,
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
@@ -1448,8 +1442,7 @@ register_snapshot_trigger(char *glob,
 }
 
 static int
-snapshot_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
-		       struct event_trigger_data *data)
+snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
 	return event_trigger_print("snapshot", m, (void *)data->count,
 				   data->filter_str);
@@ -1539,8 +1532,7 @@ stacktrace_count_trigger(struct event_trigger_data *data,
 }
 
 static int
-stacktrace_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
-			 struct event_trigger_data *data)
+stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
 	return event_trigger_print("stacktrace", m, (void *)data->count,
 				   data->filter_str);
@@ -1630,7 +1622,6 @@ event_enable_count_trigger(struct event_trigger_data *data,
 }
 
 int event_enable_trigger_print(struct seq_file *m,
-			       struct event_trigger_ops *ops,
 			       struct event_trigger_data *data)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
@@ -1655,8 +1646,7 @@ int event_enable_trigger_print(struct seq_file *m,
 	return 0;
 }
 
-void event_enable_trigger_free(struct event_trigger_ops *ops,
-			       struct event_trigger_data *data)
+void event_enable_trigger_free(struct event_trigger_data *data)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
@@ -1784,7 +1774,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	}
 
 	/* Up the trigger_data count to make sure nothing frees it on failure */
-	event_trigger_init(trigger_ops, trigger_data);
+	event_trigger_init(trigger_data);
 
 	if (trigger) {
 		number = strsep(&trigger, ":");
@@ -1828,7 +1818,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	if (ret)
 		goto out_disable;
 
-	event_trigger_free(trigger_ops, trigger_data);
+	event_trigger_free(trigger_data);
  out:
 	return ret;
 
@@ -1839,7 +1829,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
-	event_trigger_free(trigger_ops, trigger_data);
+	event_trigger_free(trigger_data);
 	kfree(enable_data);
 	goto out;
 }
@@ -1867,7 +1857,7 @@ int event_enable_register_trigger(char *glob,
 	}
 
 	if (data->ops->init) {
-		ret = data->ops->init(data->ops, data);
+		ret = data->ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -1910,7 +1900,7 @@ void event_enable_unregister_trigger(char *glob,
 	}
 
 	if (unregistered && data->ops->free)
-		data->ops->free(data->ops, data);
+		data->ops->free(data);
 }
 
 static struct event_trigger_ops *
-- 
2.17.1

