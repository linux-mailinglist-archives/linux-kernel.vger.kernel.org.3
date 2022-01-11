Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB548B3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbiAKRbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344280AbiAKRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76708C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:31:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCAA1B81C35
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F10C36AF3;
        Tue, 11 Jan 2022 17:31:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzJ-00325S-Oo;
        Tue, 11 Jan 2022 12:31:13 -0500
Message-ID: <20220111173113.602918922@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:30:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 02/31] tracing: Change event_trigger_ops func() to trigger()
References: <20220111173030.999527342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

The name of the func() callback on event_trigger_ops is too generic
and is easily confused with other callbacks with that name, so change
it to something that reflects its actual purpose.

In this case, the main purpose of the callback is to implement an
event trigger, so call it trigger() instead.

Also add some more documentation to event_trigger_ops describing the
callbacks a bit better.

Link: https://lkml.kernel.org/r/36ab812e3ee74ee03ae0043fda41a858ee728c00.1641823001.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.h                | 19 ++++++++++++++----
 kernel/trace/trace_eprobe.c         |  2 +-
 kernel/trace/trace_events_hist.c    | 12 ++++++------
 kernel/trace/trace_events_trigger.c | 30 ++++++++++++++---------------
 4 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3b2b1bfc686f..13f23082f256 100644
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
2.33.0
