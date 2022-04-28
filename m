Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD0513E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352635AbiD1VzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351789AbiD1Vy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:54:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDDC2E0AB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B292062008
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9A2C385C0;
        Thu, 28 Apr 2022 21:51:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nkC33-003McU-Aw;
        Thu, 28 Apr 2022 17:51:41 -0400
Message-ID: <20220428215141.173085779@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 28 Apr 2022 17:51:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jakob Koschel <jakobkoschel@gmail.com>
Subject: [for-next][PATCH 8/8] tracing: Remove check of list iterator against head past the loop
 body
References: <20220428215102.260147624@goodmis.org>
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

From: Jakob Koschel <jakobkoschel@gmail.com>

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lkml.kernel.org/r/20220427170734.819891-5-jakobkoschel@gmail.com

Cc: Ingo Molnar <mingo@redhat.com>
Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c       | 20 ++++++++++++--------
 kernel/trace/trace_eprobe.c | 14 ++++++++------
 kernel/trace/trace_events.c | 12 ++++++------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f1d2f5e7263..5c465e70d146 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4560,8 +4560,8 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 			       struct ftrace_probe_ops *probe_ops,
 			       void *data)
 {
+	struct ftrace_func_probe *probe = NULL, *iter;
 	struct ftrace_func_entry *entry;
-	struct ftrace_func_probe *probe;
 	struct ftrace_hash **orig_hash;
 	struct ftrace_hash *old_hash;
 	struct ftrace_hash *hash;
@@ -4580,11 +4580,13 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 
 	mutex_lock(&ftrace_lock);
 	/* Check if the probe_ops is already registered */
-	list_for_each_entry(probe, &tr->func_probes, list) {
-		if (probe->probe_ops == probe_ops)
+	list_for_each_entry(iter, &tr->func_probes, list) {
+		if (iter->probe_ops == probe_ops) {
+			probe = iter;
 			break;
+		}
 	}
-	if (&probe->list == &tr->func_probes) {
+	if (!probe) {
 		probe = kzalloc(sizeof(*probe), GFP_KERNEL);
 		if (!probe) {
 			mutex_unlock(&ftrace_lock);
@@ -4702,9 +4704,9 @@ int
 unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 				      struct ftrace_probe_ops *probe_ops)
 {
+	struct ftrace_func_probe *probe = NULL, *iter;
 	struct ftrace_ops_hash old_hash_ops;
 	struct ftrace_func_entry *entry;
-	struct ftrace_func_probe *probe;
 	struct ftrace_glob func_g;
 	struct ftrace_hash **orig_hash;
 	struct ftrace_hash *old_hash;
@@ -4732,11 +4734,13 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 
 	mutex_lock(&ftrace_lock);
 	/* Check if the probe_ops is already registered */
-	list_for_each_entry(probe, &tr->func_probes, list) {
-		if (probe->probe_ops == probe_ops)
+	list_for_each_entry(iter, &tr->func_probes, list) {
+		if (iter->probe_ops == probe_ops) {
+			probe = iter;
 			break;
+		}
 	}
-	if (&probe->list == &tr->func_probes)
+	if (!probe)
 		goto err_unlock_ftrace;
 
 	ret = -EINVAL;
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index b045fa9f276c..7d4478525c66 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -648,7 +648,7 @@ static struct trace_event_functions eprobe_funcs = {
 static int disable_eprobe(struct trace_eprobe *ep,
 			  struct trace_array *tr)
 {
-	struct event_trigger_data *trigger;
+	struct event_trigger_data *trigger = NULL, *iter;
 	struct trace_event_file *file;
 	struct eprobe_data *edata;
 
@@ -656,14 +656,16 @@ static int disable_eprobe(struct trace_eprobe *ep,
 	if (!file)
 		return -ENOENT;
 
-	list_for_each_entry(trigger, &file->triggers, list) {
-		if (!(trigger->flags & EVENT_TRIGGER_FL_PROBE))
+	list_for_each_entry(iter, &file->triggers, list) {
+		if (!(iter->flags & EVENT_TRIGGER_FL_PROBE))
 			continue;
-		edata = trigger->private_data;
-		if (edata->ep == ep)
+		edata = iter->private_data;
+		if (edata->ep == ep) {
+			trigger = iter;
 			break;
+		}
 	}
-	if (list_entry_is_head(trigger, &file->triggers, list))
+	if (!trigger)
 		return -ENODEV;
 
 	list_del_rcu(&trigger->list);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e4a442060707..78f313b7b315 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2279,8 +2279,8 @@ static struct dentry *
 event_subsystem_dir(struct trace_array *tr, const char *name,
 		    struct trace_event_file *file, struct dentry *parent)
 {
+	struct event_subsystem *system, *iter;
 	struct trace_subsystem_dir *dir;
-	struct event_subsystem *system;
 	struct dentry *entry;
 
 	/* First see if we did not already create this dir */
@@ -2294,13 +2294,13 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	}
 
 	/* Now see if the system itself exists. */
-	list_for_each_entry(system, &event_subsystems, list) {
-		if (strcmp(system->name, name) == 0)
+	system = NULL;
+	list_for_each_entry(iter, &event_subsystems, list) {
+		if (strcmp(iter->name, name) == 0) {
+			system = iter;
 			break;
+		}
 	}
-	/* Reset system variable when not found */
-	if (&system->list == &event_subsystems)
-		system = NULL;
 
 	dir = kmalloc(sizeof(*dir), GFP_KERNEL);
 	if (!dir)
-- 
2.35.1
