Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC85A488D71
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 01:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbiAJAEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 19:04:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35202 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbiAJAE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 19:04:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5732EB80D85
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC289C36AE3;
        Mon, 10 Jan 2022 00:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641773065;
        bh=PWKIkbXBfD+HvZ/yIzak40cPKEIuHj+7a313VJ1aOtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ITNupEULzaY++Vf9XJeFydwuEqtYbtmWm51BJwBXpy9Olld8NvCRySbxavw07c+P0
         t6Uv3Vr6RIPo+NsENBLPqNQunGdt3vYmNI/++1sKWe9JCkd/zKO/OXH6DvyAYahDkE
         cni93dw6K8W3LJjxqOb+XGyMSIgIgrq8TaKgSk/gaKSxfBUlW5Ypfh5h9RXGdzUh6B
         04tajbAT5fgjzE0EO9zRCtBajkmD4onYGXe0Y0DPsipoAXmbxRE+l4ugCn0zJDALkZ
         H2n4lvoslZVmRl6/luFFo3tkb3W8aIYu/CCVGEi5b5+DJx4WHlBhz88gAr6PVLuB+C
         uPUPjc2WTnSBg==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/6] tracing: Remove redundant trigger_ops params
Date:   Sun,  9 Jan 2022 18:04:10 -0600
Message-Id: <256da8e5e9f9c780ad20f13893ac356b9265f8f9.1641772260.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1641772259.git.zanussi@kernel.org>
References: <cover.1641772259.git.zanussi@kernel.org>
In-Reply-To: <cover.1641772259.git.zanussi@kernel.org>
References: <cover.1641772259.git.zanussi@kernel.org>
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
 kernel/trace/trace_events_hist.c    | 27 +++++++----------
 kernel/trace/trace_events_trigger.c | 46 +++++++++++------------------
 4 files changed, 35 insertions(+), 59 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index fd2334771bdc..8072f57331dc 100644
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
 				      char *glob, char *cmd,
@@ -1589,8 +1587,7 @@ extern void event_enable_unregister_trigger(char *glob,
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
index f5c8dc1a5b5f..f8270214ee96 100644
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
index f9f7fd9ecc3d..98e6b579b39f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5230,7 +5230,7 @@ static void hist_trigger_show(struct seq_file *m,
 		seq_puts(m, "\n\n");
 
 	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data->ops, data);
+	data->ops->print(m, data);
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
@@ -5599,7 +5599,6 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 }
 
 static int event_hist_trigger_print(struct seq_file *m,
-				    struct event_trigger_ops *ops,
 				    struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
@@ -5707,8 +5706,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 	return 0;
 }
 
-static int event_hist_trigger_init(struct event_trigger_ops *ops,
-				   struct event_trigger_data *data)
+static int event_hist_trigger_init(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 
@@ -5736,8 +5734,7 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	}
 }
 
-static void event_hist_trigger_free(struct event_trigger_ops *ops,
-				    struct event_trigger_data *data)
+static void event_hist_trigger_free(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 
@@ -5766,25 +5763,23 @@ static struct event_trigger_ops event_hist_trigger_ops = {
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
@@ -5971,7 +5966,7 @@ static int hist_register_trigger(char *glob,
 	}
 
 	if (data->ops->init) {
-		ret = data->ops->init(data->ops, data);
+		ret = data->ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -6089,7 +6084,7 @@ static void hist_unregister_trigger(char *glob,
 	}
 
 	if (unregistered && test->ops->free)
-		test->ops->free(test->ops, test);
+		test->ops->free(test);
 
 	if (hist_data->enable_timestamps) {
 		if (!hist_data->remove || unregistered)
@@ -6142,7 +6137,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 			if (hist_data->enable_timestamps)
 				tracing_set_filter_buffering(file->tr, false);
 			if (test->ops->free)
-				test->ops->free(test->ops, test);
+				test->ops->free(test);
 		}
 	}
 }
@@ -6420,7 +6415,7 @@ static void hist_enable_unreg_all(struct trace_event_file *file)
 			update_cond_flag(file);
 			trace_event_trigger_enable_disable(file, 0);
 			if (test->ops->free)
-				test->ops->free(test->ops, test);
+				test->ops->free(test);
 		}
 	}
 }
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 2ab5837bc141..2a51db416cee 100644
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
@@ -616,7 +612,7 @@ static void unregister_trigger(char *glob,
 	}
 
 	if (unregistered && data->ops->free)
-		data->ops->free(data->ops, data);
+		data->ops->free(data);
 }
 
 /*
@@ -1014,14 +1010,14 @@ event_trigger_parse(struct event_command *cmd_ops,
 		goto out_free;
 
 	/* Up the trigger_data count to make sure reg doesn't free it on failure */
-	event_trigger_init(trigger_data->ops, trigger_data);
+	event_trigger_init(trigger_data);
 
 	ret = event_trigger_register(cmd_ops, file, glob, cmd, param, trigger_data, NULL);
 	if (ret)
 		goto out_free;
 
 	/* Down the counter of trigger_data or free it if not used anymore */
-	event_trigger_free(trigger_data->ops, trigger_data);
+	event_trigger_free(trigger_data);
  out:
 	return ret;
  out_free:
@@ -1305,16 +1301,14 @@ traceoff_count_trigger(struct event_trigger_data *data,
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
@@ -1425,8 +1419,7 @@ register_snapshot_trigger(char *glob,
 }
 
 static int
-snapshot_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
-		       struct event_trigger_data *data)
+snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
 	return event_trigger_print("snapshot", m, (void *)data->count,
 				   data->filter_str);
@@ -1516,8 +1509,7 @@ stacktrace_count_trigger(struct event_trigger_data *data,
 }
 
 static int
-stacktrace_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
-			 struct event_trigger_data *data)
+stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
 	return event_trigger_print("stacktrace", m, (void *)data->count,
 				   data->filter_str);
@@ -1607,7 +1599,6 @@ event_enable_count_trigger(struct event_trigger_data *data,
 }
 
 int event_enable_trigger_print(struct seq_file *m,
-			       struct event_trigger_ops *ops,
 			       struct event_trigger_data *data)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
@@ -1632,8 +1623,7 @@ int event_enable_trigger_print(struct seq_file *m,
 	return 0;
 }
 
-void event_enable_trigger_free(struct event_trigger_ops *ops,
-			       struct event_trigger_data *data)
+void event_enable_trigger_free(struct event_trigger_data *data)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
@@ -1746,7 +1736,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	}
 
 	/* Up the trigger_data count to make sure nothing frees it on failure */
-	event_trigger_init(trigger_data->ops, trigger_data);
+	event_trigger_init(trigger_data);
 
 	ret = event_trigger_parse_num(param, trigger_data);
 	if (ret)
@@ -1771,7 +1761,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	if (ret)
 		goto out_disable;
 
-	event_trigger_free(trigger_data->ops, trigger_data);
+	event_trigger_free(trigger_data);
  out:
 	return ret;
  out_disable:
@@ -1780,7 +1770,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	trace_event_put_ref(event_enable_file->event_call);
  out_free:
 	event_trigger_reset_filter(cmd_ops, trigger_data);
-	event_trigger_free(trigger_data->ops, trigger_data);
+	event_trigger_free(trigger_data);
 	kfree(enable_data);
 	goto out;
 }
@@ -1808,7 +1798,7 @@ int event_enable_register_trigger(char *glob,
 	}
 
 	if (data->ops->init) {
-		ret = data->ops->init(data->ops, data);
+		ret = data->ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -1852,7 +1842,7 @@ void event_enable_unregister_trigger(char *glob,
 	}
 
 	if (unregistered && data->ops->free)
-		data->ops->free(data->ops, data);
+		data->ops->free(data);
 }
 
 static struct event_trigger_ops *
-- 
2.17.1

