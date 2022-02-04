Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC24AA2E5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346332AbiBDWMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:12:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55586 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346216AbiBDWMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:12:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF1AF618C4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 22:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8FAC340EF;
        Fri,  4 Feb 2022 22:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644012735;
        bh=twNjX80CKflf33wosDQ9W9fbrpqLmS/TvMAWZC6DVv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=QYjf6MaQKCgVxlOuPoqJZhJ5f7nqvNgaSEhFQ3eRfv0Y8xotqPRCgIF1bLOrNUqBl
         YDcfNuvSgbB0zM7kQh5E9ZOUpmcy2+s/YBc+DUCPdDiAQM/fJrH2jRjvgD2snVU8fj
         o2z0ayIW1JrFwe7vce3qZ63EFZJxokNzUZjwfXtsQ/iCInDtAKAxsBl+34BxnYGyci
         WtNFWbuFQmFuHf6RF4A3h8lg7hlcMspFx/SV3FmyiZHL16kDmUGz/XaamLVUrjtPJh
         Y4djIfVh1PgfqdC3yRlNiolyA66YPnjyYmpF06jAhPbUhd97GSa5qlM9AZQFDUaNbA
         y+o3Sp4MdO9JQ==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/4] tracing: Remove logic for registering multiple event triggers at a time
Date:   Fri,  4 Feb 2022 16:12:04 -0600
Message-Id: <6149fec7a139d93e84fa4535672fb5bef88006b0.1644010575.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1644010575.git.zanussi@kernel.org>
References: <cover.1644010575.git.zanussi@kernel.org>
In-Reply-To: <cover.1644010575.git.zanussi@kernel.org>
References: <cover.1644010575.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code for registering triggers assumes it's possible to register more
than one trigger at a time.  In fact, it's unimplemented and there
doesn't seem to be a reason to do that.

Remove the n_registered param from event_trigger_register() and fix up
callers.

Doing so simplifies the logic in event_trigger_register to the point
that it just becomes a wrapper calling event_command.reg().

It also removes the problematic call to event_command.unreg() in case
of failure.  A new function, event_trigger_unregister() is also added
for callers to call themselves.

The changes to trace_events_hist.c simply allow compilation; a
separate patch follows which updates the hist triggers to work
correctly with the new changes.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.h                |  9 +--
 kernel/trace/trace_events_hist.c    | 17 ++---
 kernel/trace/trace_events_trigger.c | 96 ++++++++++-------------------
 3 files changed, 45 insertions(+), 77 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0f5e22238cd2..835f1e3d9924 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1630,10 +1630,11 @@ extern void event_trigger_reset_filter(struct event_command *cmd_ops,
 extern int event_trigger_register(struct event_command *cmd_ops,
 				  struct trace_event_file *file,
 				  char *glob,
-				  char *cmd,
-				  char *trigger,
-				  struct event_trigger_data *trigger_data,
-				  int *n_registered);
+				  struct event_trigger_data *trigger_data);
+extern void event_trigger_unregister(struct event_command *cmd_ops,
+				     struct trace_event_file *file,
+				     char *glob,
+				     struct event_trigger_data *trigger_data);
 
 /**
  * struct event_trigger_ops - callbacks for trace event triggers
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index be4a001a607f..8df815bc0ac5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6284,7 +6284,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 			goto out_free;
 		}
 
-		cmd_ops->unreg(glob+1, trigger_data, file);
+		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		se_name = trace_event_name(file->event_call);
 		se = find_synth_event(se_name);
 		if (se)
@@ -6293,13 +6293,10 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		goto out_free;
 	}
 
-	ret = cmd_ops->reg(glob, trigger_data, file);
-	/*
-	 * The above returns on success the # of triggers registered,
-	 * but if it didn't register any it returns zero.  Consider no
-	 * triggers registered a failure too.
-	 */
-	if (!ret) {
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret)
+		goto out_free;
+	if (ret == 0) {
 		if (!(attrs->pause || attrs->cont || attrs->clear))
 			ret = -ENOENT;
 		goto out_free;
@@ -6328,15 +6325,13 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	se = find_synth_event(se_name);
 	if (se)
 		se->ref++;
-	/* Just return zero, not the number of registered triggers */
-	ret = 0;
  out:
 	if (ret == 0)
 		hist_err_clear();
 
 	return ret;
  out_unreg:
-	cmd_ops->unreg(glob+1, trigger_data, file);
+	event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index d00fee705f9c..0ab86b5449d7 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -573,13 +573,12 @@ static int register_trigger(char *glob,
 	}
 
 	list_add_rcu(&data->list, &file->triggers);
-	ret++;
 
 	update_cond_flag(file);
-	if (trace_event_trigger_enable_disable(file, 1) < 0) {
+	ret = trace_event_trigger_enable_disable(file, 1);
+	if (ret < 0) {
 		list_del_rcu(&data->list);
 		update_cond_flag(file);
-		ret--;
 	}
 out:
 	return ret;
@@ -913,48 +912,37 @@ void event_trigger_reset_filter(struct event_command *cmd_ops,
  * @cmd_ops: The event_command operations for the trigger
  * @file: The event file for the trigger's event
  * @glob: The trigger command string, with optional remove(!) operator
- * @cmd: The cmd string
- * @param: The param string
  * @trigger_data: The trigger_data for the trigger
- * @n_registered: optional outparam, the number of triggers registered
  *
  * Register an event trigger.  The @cmd_ops are used to call the
- * cmd_ops->reg() function which actually does the registration. The
- * cmd_ops->reg() function returns the number of triggers registered,
- * which is assigned to n_registered, if n_registered is non-NULL.
+ * cmd_ops->reg() function which actually does the registration.
  *
  * Return: 0 on success, errno otherwise
  */
 int event_trigger_register(struct event_command *cmd_ops,
 			   struct trace_event_file *file,
 			   char *glob,
-			   char *cmd,
-			   char *param,
-			   struct event_trigger_data *trigger_data,
-			   int *n_registered)
+			   struct event_trigger_data *trigger_data)
 {
-	int ret;
-
-	if (n_registered)
-		*n_registered = 0;
-
-	ret = cmd_ops->reg(glob, trigger_data, file);
-	/*
-	 * The above returns on success the # of functions enabled,
-	 * but if it didn't find any functions it returns zero.
-	 * Consider no functions a failure too.
-	 */
-	if (!ret) {
-		cmd_ops->unreg(glob, trigger_data, file);
-		ret = -ENOENT;
-	} else if (ret > 0) {
-		if (n_registered)
-			*n_registered = ret;
-		/* Just return zero, not the number of enabled functions */
-		ret = 0;
-	}
+	return cmd_ops->reg(glob, trigger_data, file);
+}
 
-	return ret;
+/**
+ * event_trigger_unregister - unregister an event trigger
+ * @cmd_ops: The event_command operations for the trigger
+ * @file: The event file for the trigger's event
+ * @glob: The trigger command string, with optional remove(!) operator
+ * @trigger_data: The trigger_data for the trigger
+ *
+ * Unregister an event trigger.  The @cmd_ops are used to call the
+ * cmd_ops->unreg() function which actually does the unregistration.
+ */
+void event_trigger_unregister(struct event_command *cmd_ops,
+			      struct trace_event_file *file,
+			      char *glob,
+			      struct event_trigger_data *trigger_data)
+{
+	cmd_ops->unreg(glob, trigger_data, file);
 }
 
 /*
@@ -1013,7 +1001,7 @@ event_trigger_parse(struct event_command *cmd_ops,
 	INIT_LIST_HEAD(&trigger_data->named_list);
 
 	if (glob[0] == '!') {
-		cmd_ops->unreg(glob+1, trigger_data, file);
+		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		kfree(trigger_data);
 		ret = 0;
 		goto out;
@@ -1048,17 +1036,10 @@ event_trigger_parse(struct event_command *cmd_ops,
  out_reg:
 	/* Up the trigger_data count to make sure reg doesn't free it on failure */
 	event_trigger_init(trigger_ops, trigger_data);
-	ret = cmd_ops->reg(glob, trigger_data, file);
-	/*
-	 * The above returns on success the # of functions enabled,
-	 * but if it didn't find any functions it returns zero.
-	 * Consider no functions a failure too.
-	 */
-	if (!ret) {
-		cmd_ops->unreg(glob, trigger_data, file);
-		ret = -ENOENT;
-	} else if (ret > 0)
-		ret = 0;
+
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret)
+		goto out_free;
 
 	/* Down the counter of trigger_data or free it if not used anymore */
 	event_trigger_free(trigger_ops, trigger_data);
@@ -1795,7 +1776,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	trigger_data->private_data = enable_data;
 
 	if (glob[0] == '!') {
-		cmd_ops->unreg(glob+1, trigger_data, file);
+		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		kfree(trigger_data);
 		kfree(enable_data);
 		ret = 0;
@@ -1842,19 +1823,11 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	ret = trace_event_enable_disable(event_enable_file, 1, 1);
 	if (ret < 0)
 		goto out_put;
-	ret = cmd_ops->reg(glob, trigger_data, file);
-	/*
-	 * The above returns on success the # of functions enabled,
-	 * but if it didn't find any functions it returns zero.
-	 * Consider no functions a failure too.
-	 */
-	if (!ret) {
-		ret = -ENOENT;
-		goto out_disable;
-	} else if (ret < 0)
+
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret)
 		goto out_disable;
-	/* Just return zero, not the number of enabled functions */
-	ret = 0;
+
 	event_trigger_free(trigger_ops, trigger_data);
  out:
 	return ret;
@@ -1900,13 +1873,12 @@ int event_enable_register_trigger(char *glob,
 	}
 
 	list_add_rcu(&data->list, &file->triggers);
-	ret++;
 
 	update_cond_flag(file);
-	if (trace_event_trigger_enable_disable(file, 1) < 0) {
+	ret = trace_event_trigger_enable_disable(file, 1);
+	if (ret < 0) {
 		list_del_rcu(&data->list);
 		update_cond_flag(file);
-		ret--;
 	}
 out:
 	return ret;
-- 
2.17.1

