Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4577A489B03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiAJOEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:04:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50202 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiAJOE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:04:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D084ECE1323
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA99EC36AE9;
        Mon, 10 Jan 2022 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641823464;
        bh=B5zWgXsQcgRT6W6IUP5g8RBZV0TrOHQBpoOF4CxU7E4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CLy3X7KDRF4YPY5dq+mWYwdjzXpxWVABZ94bXSdPEfkaNjYBpJMAr2fb9UQojVNf1
         HdzQX4QRUjUpK2ufOogSMEkWp/73bZwp0YjGwYigPioJD1iI5lFZD0WDJ8oaltcInI
         Qojca7iJVbEO+OTOI6GkLcs8IYANCycvuQ2k+HcDPJ053uiwO5bXi+4ioKyBIcvZBV
         1FMOiFgNpiQM8EwpMPb5YoSz69ElzfSGDRBXdUIeGyIZjCkWok1Lu7H2hUlI0V/h3P
         bkV0S7/y3drssaW370LwKRW4EWQmYHqOi4fBjysHipj4pbtaqd8C1v7NxCgKd6c3eJ
         inDm9xUicgfGw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/6] tracing: Remove ops param from event_command reg()/unreg() callbacks
Date:   Mon, 10 Jan 2022 08:04:13 -0600
Message-Id: <4c6f2a41820452f9cacddc7634ad442928aa2aa6.1641823001.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1641823001.git.zanussi@kernel.org>
References: <cover.1641823001.git.zanussi@kernel.org>
In-Reply-To: <cover.1641823001.git.zanussi@kernel.org>
References: <cover.1641823001.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event_trigger_ops for an event_command are already accessible via
event_trigger_data.ops so remove the redundant ops from the callback.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.h                |  4 ----
 kernel/trace/trace_eprobe.c         | 12 ++++++------
 kernel/trace/trace_events_hist.c    | 10 +++++-----
 kernel/trace/trace_events_trigger.c | 22 +++++++++-------------
 4 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1a73659222d4..7d981af10b8f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1582,11 +1582,9 @@ extern int event_enable_trigger_parse(struct event_command *cmd_ops,
 				      struct trace_event_file *file,
 				      char *glob, char *cmd, char *param);
 extern int event_enable_register_trigger(char *glob,
-					 struct event_trigger_ops *ops,
 					 struct event_trigger_data *data,
 					 struct trace_event_file *file);
 extern void event_enable_unregister_trigger(char *glob,
-					    struct event_trigger_ops *ops,
 					    struct event_trigger_data *test,
 					    struct trace_event_file *file);
 extern void trigger_data_free(struct event_trigger_data *data);
@@ -1763,11 +1761,9 @@ struct event_command {
 					 char *glob, char *cmd,
 					 char *param_and_filter);
 	int			(*reg)(char *glob,
-				       struct event_trigger_ops *ops,
 				       struct event_trigger_data *data,
 				       struct trace_event_file *file);
 	void			(*unreg)(char *glob,
-					 struct event_trigger_ops *ops,
 					 struct event_trigger_data *data,
 					 struct trace_event_file *file);
 	void			(*unreg_all)(struct trace_event_file *file);
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 6d363fd8a1e4..191db32dec46 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -556,16 +556,16 @@ static int eprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 	return -1;
 }
 
-static int eprobe_trigger_reg_func(char *glob, struct event_trigger_ops *ops,
-				 struct event_trigger_data *data,
-				 struct trace_event_file *file)
+static int eprobe_trigger_reg_func(char *glob,
+				   struct event_trigger_data *data,
+				   struct trace_event_file *file)
 {
 	return -1;
 }
 
-static void eprobe_trigger_unreg_func(char *glob, struct event_trigger_ops *ops,
-				    struct event_trigger_data *data,
-				    struct trace_event_file *file)
+static void eprobe_trigger_unreg_func(char *glob,
+				      struct event_trigger_data *data,
+				      struct trace_event_file *file)
 {
 
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 229ce5c2dfd3..5e6a988a8a51 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5910,7 +5910,7 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 	return true;
 }
 
-static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
+static int hist_register_trigger(char *glob,
 				 struct event_trigger_data *data,
 				 struct trace_event_file *file)
 {
@@ -6062,7 +6062,7 @@ static bool hist_trigger_check_refs(struct event_trigger_data *data,
 	return false;
 }
 
-static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
+static void hist_unregister_trigger(char *glob,
 				    struct event_trigger_data *data,
 				    struct trace_event_file *file)
 {
@@ -6262,7 +6262,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 			goto out_free;
 		}
 
-		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
+		cmd_ops->unreg(glob+1, trigger_data, file);
 		se_name = trace_event_name(file->event_call);
 		se = find_synth_event(se_name);
 		if (se)
@@ -6271,7 +6271,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		goto out_free;
 	}
 
-	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
+	ret = cmd_ops->reg(glob, trigger_data, file);
 	/*
 	 * The above returns on success the # of triggers registered,
 	 * but if it didn't register any it returns zero.  Consider no
@@ -6314,7 +6314,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	return ret;
  out_unreg:
-	cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
+	cmd_ops->unreg(glob+1, trigger_data, file);
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 24aceeb50dc0..d40b857db572 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -540,7 +540,6 @@ void update_cond_flag(struct trace_event_file *file)
 /**
  * register_trigger - Generic event_command @reg implementation
  * @glob: The raw string used to register the trigger
- * @ops: The trigger ops associated with the trigger
  * @data: Trigger-specific data to associate with the trigger
  * @file: The trace_event_file associated with the event
  *
@@ -551,7 +550,7 @@ void update_cond_flag(struct trace_event_file *file)
  *
  * Return: 0 on success, errno otherwise
  */
-static int register_trigger(char *glob, struct event_trigger_ops *ops,
+static int register_trigger(char *glob,
 			    struct event_trigger_data *data,
 			    struct trace_event_file *file)
 {
@@ -589,7 +588,6 @@ static int register_trigger(char *glob, struct event_trigger_ops *ops,
 /**
  * unregister_trigger - Generic event_command @unreg implementation
  * @glob: The raw string used to register the trigger
- * @ops: The trigger ops associated with the trigger
  * @test: Trigger-specific data used to find the trigger to remove
  * @file: The trace_event_file associated with the event
  *
@@ -598,7 +596,7 @@ static int register_trigger(char *glob, struct event_trigger_ops *ops,
  * Usually used directly as the @unreg method in event command
  * implementations.
  */
-static void unregister_trigger(char *glob, struct event_trigger_ops *ops,
+static void unregister_trigger(char *glob,
 			       struct event_trigger_data *test,
 			       struct trace_event_file *file)
 {
@@ -673,7 +671,7 @@ event_trigger_parse(struct event_command *cmd_ops,
 	INIT_LIST_HEAD(&trigger_data->named_list);
 
 	if (glob[0] == '!') {
-		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
+		cmd_ops->unreg(glob+1, trigger_data, file);
 		kfree(trigger_data);
 		ret = 0;
 		goto out;
@@ -708,14 +706,14 @@ event_trigger_parse(struct event_command *cmd_ops,
  out_reg:
 	/* Up the trigger_data count to make sure reg doesn't free it on failure */
 	event_trigger_init(trigger_ops, trigger_data);
-	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
+	ret = cmd_ops->reg(glob, trigger_data, file);
 	/*
 	 * The above returns on success the # of functions enabled,
 	 * but if it didn't find any functions it returns zero.
 	 * Consider no functions a failure too.
 	 */
 	if (!ret) {
-		cmd_ops->unreg(glob, trigger_ops, trigger_data, file);
+		cmd_ops->unreg(glob, trigger_data, file);
 		ret = -ENOENT;
 	} else if (ret > 0)
 		ret = 0;
@@ -1116,14 +1114,14 @@ snapshot_count_trigger(struct event_trigger_data *data,
 }
 
 static int
-register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
+register_snapshot_trigger(char *glob,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
 	if (tracing_alloc_snapshot_instance(file->tr) != 0)
 		return 0;
 
-	return register_trigger(glob, ops, data, file);
+	return register_trigger(glob, data, file);
 }
 
 static int
@@ -1455,7 +1453,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	trigger_data->private_data = enable_data;
 
 	if (glob[0] == '!') {
-		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
+		cmd_ops->unreg(glob+1, trigger_data, file);
 		kfree(trigger_data);
 		kfree(enable_data);
 		ret = 0;
@@ -1502,7 +1500,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	ret = trace_event_enable_disable(event_enable_file, 1, 1);
 	if (ret < 0)
 		goto out_put;
-	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
+	ret = cmd_ops->reg(glob, trigger_data, file);
 	/*
 	 * The above returns on success the # of functions enabled,
 	 * but if it didn't find any functions it returns zero.
@@ -1532,7 +1530,6 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 }
 
 int event_enable_register_trigger(char *glob,
-				  struct event_trigger_ops *ops,
 				  struct event_trigger_data *data,
 				  struct trace_event_file *file)
 {
@@ -1574,7 +1571,6 @@ int event_enable_register_trigger(char *glob,
 }
 
 void event_enable_unregister_trigger(char *glob,
-				     struct event_trigger_ops *ops,
 				     struct event_trigger_data *test,
 				     struct trace_event_file *file)
 {
-- 
2.17.1

