Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC55122E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiD0Tk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiD0Tjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD5CB65
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BFED61B6B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2E6C385B2;
        Wed, 27 Apr 2022 19:36:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSp-002IpF-Un;
        Wed, 27 Apr 2022 15:36:39 -0400
Message-ID: <20220427193639.789369760@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 02/21] tracing: Remove logic for registering multiple event triggers at a
 time
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

Link: https://lkml.kernel.org/r/6149fec7a139d93e84fa4535672fb5bef88006b0.1644010575.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                |  9 +--
 kernel/trace/trace_events_hist.c    | 17 ++---
 kernel/trace/trace_events_trigger.c | 96 ++++++++++-------------------
 3 files changed, 45 insertions(+), 77 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 07d990270e2a..2bc8036b0659 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1629,10 +1629,11 @@ extern void event_trigger_reset_filter(struct event_command *cmd_ops,
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
index 44db5ba9cabb..b18d00905eae 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6287,7 +6287,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 			goto out_free;
 		}
 
-		cmd_ops->unreg(glob+1, trigger_data, file);
+		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		se_name = trace_event_name(file->event_call);
 		se = find_synth_event(se_name);
 		if (se)
@@ -6296,13 +6296,10 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
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
@@ -6331,15 +6328,13 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
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
index 7eb9d04f1c2e..ea13679054a8 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -587,13 +587,12 @@ static int register_trigger(char *glob,
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
@@ -927,48 +926,37 @@ void event_trigger_reset_filter(struct event_command *cmd_ops,
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
@@ -1027,7 +1015,7 @@ event_trigger_parse(struct event_command *cmd_ops,
 	INIT_LIST_HEAD(&trigger_data->named_list);
 
 	if (glob[0] == '!') {
-		cmd_ops->unreg(glob+1, trigger_data, file);
+		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		kfree(trigger_data);
 		ret = 0;
 		goto out;
@@ -1062,17 +1050,10 @@ event_trigger_parse(struct event_command *cmd_ops,
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
@@ -1854,7 +1835,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	trigger_data->private_data = enable_data;
 
 	if (glob[0] == '!') {
-		cmd_ops->unreg(glob+1, trigger_data, file);
+		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		kfree(trigger_data);
 		kfree(enable_data);
 		ret = 0;
@@ -1901,19 +1882,11 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
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
@@ -1959,13 +1932,12 @@ int event_enable_register_trigger(char *glob,
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
2.35.1
