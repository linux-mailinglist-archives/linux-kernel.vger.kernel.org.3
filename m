Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A839474B50
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbhLNS5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhLNS5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:57:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3DFC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:57:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B15E7B81C55
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 18:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231B5C34604;
        Tue, 14 Dec 2021 18:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639508262;
        bh=yE2q+xnkfSNyw3eRPs9WaUSPN7vUF0dmIhBs7LZbHFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=WDVm4PlZfU1kFZH8ntsQ2KM/QhZyYrbvHgz3bKnNV1bGCXyHO4YuzyNJsWpe+OV6S
         BmhD5gmqCPUvf/wZ+n7TJA4RyDng5lA8K+FL4l5pYQG7kh40K1JlwIcrdn+l9/zIqo
         Ec4eIIQuhW2xXI53JXmZwVK7aL5xsF3xUOMZV1PDBIusZcocZLUcaj+HOZ4pqwCs9e
         Ug0uA8sWzyQ3Qsxw1kNjpPgPOCiPZZnZmkmx+P1yz5YdJ1UGx7TCMtcAReJGVoMizx
         9+6Vcv9/GldGHAnueoaZZRInNjlqKFChf8CUUbJwkx9OYDKpZxGt7olit4OsyhX/Zi
         DyHM622OZIrgw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] tracing: Change event_trigger_ops func() to trigger()
Date:   Tue, 14 Dec 2021 12:57:30 -0600
Message-Id: <36ab812e3ee74ee03ae0043fda41a858ee728c00.1639507505.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1639507505.git.zanussi@kernel.org>
References: <cover.1639507505.git.zanussi@kernel.org>
In-Reply-To: <cover.1639507505.git.zanussi@kernel.org>
References: <cover.1639507505.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the func() callback on event_trigger_ops is too generic
and is easily confused with other callbacks with that name, so change
it to something that reflects its actual purpose.

In this case, the main purpose of the callback is to implement an
event trigger, so call it trigger() instead.

Also add some more documentation to event_trigger_ops describing the
callbacks a bit better.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.h                | 19 ++++++++++++++----
 kernel/trace/trace_eprobe.c         |  2 +-
 kernel/trace/trace_events_hist.c    | 12 ++++++------
 kernel/trace/trace_events_trigger.c | 30 ++++++++++++++---------------
 4 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 25bd5706ef0b..1a73659222d4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1619,10 +1619,20 @@ extern int register_trigger_hist_enable_disable_cmds(void);
  * The methods in this structure provide per-event trigger hooks for
  * various trigger operations.
  *
+ * The @init and @free methods are used during trigger setup and
+ * teardown, typically called from an event_command's @parse()
+ * function implementation.
+ *
+ * The @print method is used to print the trigger spec.
+ *
+ * The @trigger method is the function that actually implements the
+ * trigger and is called in the context of the triggering event
+ * whenever that event occurs.
+ *
  * All the methods below, except for @init() and @free(), must be
  * implemented.
  *
- * @func: The trigger 'probe' function called when the triggering
+ * @trigger: The trigger 'probe' function called when the triggering
  *	event occurs.  The data passed into this callback is the data
  *	that was supplied to the event_command @reg() function that
  *	registered the trigger (see struct event_command) along with
@@ -1651,9 +1661,10 @@ extern int register_trigger_hist_enable_disable_cmds(void);
  *	(see trace_event_triggers.c).
  */
 struct event_trigger_ops {
-	void			(*func)(struct event_trigger_data *data,
-					struct trace_buffer *buffer, void *rec,
-					struct ring_buffer_event *rbe);
+	void			(*trigger)(struct event_trigger_data *data,
+					   struct trace_buffer *buffer,
+					   void *rec,
+					   struct ring_buffer_event *rbe);
 	int			(*init)(struct event_trigger_ops *ops,
 					struct event_trigger_data *data);
 	void			(*free)(struct event_trigger_ops *ops,
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 84d5bfa34a99..6d363fd8a1e4 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -543,7 +543,7 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
 }
 
 static struct event_trigger_ops eprobe_trigger_ops = {
-	.func			= eprobe_trigger_func,
+	.trigger		= eprobe_trigger_func,
 	.print			= eprobe_trigger_print,
 	.init			= eprobe_trigger_init,
 	.free			= eprobe_trigger_free,
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 89bbbbd3a3f5..229ce5c2dfd3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5759,7 +5759,7 @@ static void event_hist_trigger_free(struct event_trigger_ops *ops,
 }
 
 static struct event_trigger_ops event_hist_trigger_ops = {
-	.func			= event_hist_trigger,
+	.trigger		= event_hist_trigger,
 	.print			= event_hist_trigger_print,
 	.init			= event_hist_trigger_init,
 	.free			= event_hist_trigger_free,
@@ -5793,7 +5793,7 @@ static void event_hist_trigger_named_free(struct event_trigger_ops *ops,
 }
 
 static struct event_trigger_ops event_hist_trigger_named_ops = {
-	.func			= event_hist_trigger,
+	.trigger		= event_hist_trigger,
 	.print			= event_hist_trigger_print,
 	.init			= event_hist_trigger_named_init,
 	.free			= event_hist_trigger_named_free,
@@ -6383,28 +6383,28 @@ hist_enable_count_trigger(struct event_trigger_data *data,
 }
 
 static struct event_trigger_ops hist_enable_trigger_ops = {
-	.func			= hist_enable_trigger,
+	.trigger		= hist_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
 static struct event_trigger_ops hist_enable_count_trigger_ops = {
-	.func			= hist_enable_count_trigger,
+	.trigger		= hist_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
 static struct event_trigger_ops hist_disable_trigger_ops = {
-	.func			= hist_enable_trigger,
+	.trigger		= hist_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
 static struct event_trigger_ops hist_disable_count_trigger_ops = {
-	.func			= hist_enable_count_trigger,
+	.trigger		= hist_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 15aae07cbe61..24aceeb50dc0 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -68,7 +68,7 @@ event_triggers_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (!rec) {
-			data->ops->func(data, buffer, rec, event);
+			data->ops->trigger(data, buffer, rec, event);
 			continue;
 		}
 		filter = rcu_dereference_sched(data->filter);
@@ -78,7 +78,7 @@ event_triggers_call(struct trace_event_file *file,
 			tt |= data->cmd_ops->trigger_type;
 			continue;
 		}
-		data->ops->func(data, buffer, rec, event);
+		data->ops->trigger(data, buffer, rec, event);
 	}
 	return tt;
 }
@@ -106,7 +106,7 @@ event_triggers_post_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (data->cmd_ops->trigger_type & tt)
-			data->ops->func(data, NULL, NULL, NULL);
+			data->ops->trigger(data, NULL, NULL, NULL);
 	}
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
@@ -1023,28 +1023,28 @@ traceoff_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
 }
 
 static struct event_trigger_ops traceon_trigger_ops = {
-	.func			= traceon_trigger,
+	.trigger		= traceon_trigger,
 	.print			= traceon_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
 static struct event_trigger_ops traceon_count_trigger_ops = {
-	.func			= traceon_count_trigger,
+	.trigger		= traceon_count_trigger,
 	.print			= traceon_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
 static struct event_trigger_ops traceoff_trigger_ops = {
-	.func			= traceoff_trigger,
+	.trigger		= traceoff_trigger,
 	.print			= traceoff_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
 static struct event_trigger_ops traceoff_count_trigger_ops = {
-	.func			= traceoff_count_trigger,
+	.trigger		= traceoff_count_trigger,
 	.print			= traceoff_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
@@ -1135,14 +1135,14 @@ snapshot_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
 }
 
 static struct event_trigger_ops snapshot_trigger_ops = {
-	.func			= snapshot_trigger,
+	.trigger		= snapshot_trigger,
 	.print			= snapshot_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
 static struct event_trigger_ops snapshot_count_trigger_ops = {
-	.func			= snapshot_count_trigger,
+	.trigger		= snapshot_count_trigger,
 	.print			= snapshot_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
@@ -1226,14 +1226,14 @@ stacktrace_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
 }
 
 static struct event_trigger_ops stacktrace_trigger_ops = {
-	.func			= stacktrace_trigger,
+	.trigger		= stacktrace_trigger,
 	.print			= stacktrace_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
 static struct event_trigger_ops stacktrace_count_trigger_ops = {
-	.func			= stacktrace_count_trigger,
+	.trigger		= stacktrace_count_trigger,
 	.print			= stacktrace_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
@@ -1353,28 +1353,28 @@ void event_enable_trigger_free(struct event_trigger_ops *ops,
 }
 
 static struct event_trigger_ops event_enable_trigger_ops = {
-	.func			= event_enable_trigger,
+	.trigger		= event_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
 static struct event_trigger_ops event_enable_count_trigger_ops = {
-	.func			= event_enable_count_trigger,
+	.trigger		= event_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
 static struct event_trigger_ops event_disable_trigger_ops = {
-	.func			= event_enable_trigger,
+	.trigger		= event_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
 static struct event_trigger_ops event_disable_count_trigger_ops = {
-	.func			= event_enable_count_trigger,
+	.trigger		= event_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
-- 
2.17.1

