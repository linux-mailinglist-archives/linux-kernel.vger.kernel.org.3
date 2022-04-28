Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4274B513E29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352681AbiD1VzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352489AbiD1Vy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:54:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCA82C121
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1F016200C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17965C385BE;
        Thu, 28 Apr 2022 21:51:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nkC33-003Mbu-4w;
        Thu, 28 Apr 2022 17:51:41 -0400
Message-ID: <20220428215140.989667850@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 28 Apr 2022 17:51:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jakob Koschel <jakobkoschel@gmail.com>
Subject: [for-next][PATCH 7/8] tracing: Replace usage of found with dedicated list iterator variable
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lkml.kernel.org/r/20220427170734.819891-4-jakobkoschel@gmail.com

Cc: Ingo Molnar <mingo@redhat.com>
Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c    | 15 +++++++--------
 kernel/trace/trace_events_trigger.c | 24 +++++++++++-------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fe10179893c1..038dc591545d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6117,20 +6117,19 @@ static void hist_unregister_trigger(char *glob,
 				    struct event_trigger_data *data,
 				    struct trace_event_file *file)
 {
+	struct event_trigger_data *test = NULL, *iter, *named_data = NULL;
 	struct hist_trigger_data *hist_data = data->private_data;
-	struct event_trigger_data *test, *named_data = NULL;
-	bool unregistered = false;
 
 	lockdep_assert_held(&event_mutex);
 
 	if (hist_data->attrs->name)
 		named_data = find_named_trigger(hist_data->attrs->name);
 
-	list_for_each_entry(test, &file->triggers, list) {
-		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
-			if (!hist_trigger_match(data, test, named_data, false))
+	list_for_each_entry(iter, &file->triggers, list) {
+		if (iter->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			if (!hist_trigger_match(data, iter, named_data, false))
 				continue;
-			unregistered = true;
+			test = iter;
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 			update_cond_flag(file);
@@ -6138,11 +6137,11 @@ static void hist_unregister_trigger(char *glob,
 		}
 	}
 
-	if (unregistered && test->ops->free)
+	if (test && test->ops->free)
 		test->ops->free(test);
 
 	if (hist_data->enable_timestamps) {
-		if (!hist_data->remove || unregistered)
+		if (!hist_data->remove || test)
 			tracing_set_filter_buffering(file->tr, false);
 	}
 }
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 62c44dab8f46..21592bed2e89 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -609,14 +609,13 @@ static void unregister_trigger(char *glob,
 			       struct event_trigger_data *test,
 			       struct trace_event_file *file)
 {
-	struct event_trigger_data *data;
-	bool unregistered = false;
+	struct event_trigger_data *data = NULL, *iter;
 
 	lockdep_assert_held(&event_mutex);
 
-	list_for_each_entry(data, &file->triggers, list) {
-		if (data->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
-			unregistered = true;
+	list_for_each_entry(iter, &file->triggers, list) {
+		if (iter->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
+			data = iter;
 			list_del_rcu(&data->list);
 			trace_event_trigger_enable_disable(file, 0);
 			update_cond_flag(file);
@@ -624,7 +623,7 @@ static void unregister_trigger(char *glob,
 		}
 	}
 
-	if (unregistered && data->ops->free)
+	if (data && data->ops->free)
 		data->ops->free(data);
 }
 
@@ -1870,19 +1869,18 @@ void event_enable_unregister_trigger(char *glob,
 				     struct trace_event_file *file)
 {
 	struct enable_trigger_data *test_enable_data = test->private_data;
+	struct event_trigger_data *data = NULL, *iter;
 	struct enable_trigger_data *enable_data;
-	struct event_trigger_data *data;
-	bool unregistered = false;
 
 	lockdep_assert_held(&event_mutex);
 
-	list_for_each_entry(data, &file->triggers, list) {
-		enable_data = data->private_data;
+	list_for_each_entry(iter, &file->triggers, list) {
+		enable_data = iter->private_data;
 		if (enable_data &&
-		    (data->cmd_ops->trigger_type ==
+		    (iter->cmd_ops->trigger_type ==
 		     test->cmd_ops->trigger_type) &&
 		    (enable_data->file == test_enable_data->file)) {
-			unregistered = true;
+			data = iter;
 			list_del_rcu(&data->list);
 			trace_event_trigger_enable_disable(file, 0);
 			update_cond_flag(file);
@@ -1890,7 +1888,7 @@ void event_enable_unregister_trigger(char *glob,
 		}
 	}
 
-	if (unregistered && data->ops->free)
+	if (data && data->ops->free)
 		data->ops->free(data);
 }
 
-- 
2.35.1
