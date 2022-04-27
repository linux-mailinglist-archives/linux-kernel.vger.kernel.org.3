Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D395122F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiD0Tm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiD0Tj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7674410C8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF5A6B82951
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66276C385AE;
        Wed, 27 Apr 2022 19:36:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSq-002Iqt-GK;
        Wed, 27 Apr 2022 15:36:40 -0400
Message-ID: <20220427193640.337907450@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 05/21] tracing: Separate hist state updates from hist registration
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

hist_register_trigger() handles both new hist registration as well as
existing hist registration through event_command.reg().

Adding a new function, existing_hist_update_only(), that checks and
updates existing histograms and exits after doing so allows the
confusing logic in event_hist_trigger_parse() to be simplified.

Link: https://lkml.kernel.org/r/211b2cd3e3d7e00f4f8ad45ef8b33063da6a7e05.1644010576.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 66 +++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1b71bdb0bcb1..998dfe2162fc 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5929,6 +5929,48 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 	return true;
 }
 
+static bool existing_hist_update_only(char *glob,
+				      struct event_trigger_data *data,
+				      struct trace_event_file *file)
+{
+	struct hist_trigger_data *hist_data = data->private_data;
+	struct event_trigger_data *test, *named_data = NULL;
+	bool updated = false;
+
+	if (!hist_data->attrs->pause && !hist_data->attrs->cont &&
+	    !hist_data->attrs->clear)
+		goto out;
+
+	if (hist_data->attrs->name) {
+		named_data = find_named_trigger(hist_data->attrs->name);
+		if (named_data) {
+			if (!hist_trigger_match(data, named_data, named_data,
+						true))
+				goto out;
+		}
+	}
+
+	if (hist_data->attrs->name && !named_data)
+		goto out;
+
+	list_for_each_entry(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			if (!hist_trigger_match(data, test, named_data, false))
+				continue;
+			if (hist_data->attrs->pause)
+				test->paused = true;
+			else if (hist_data->attrs->cont)
+				test->paused = false;
+			else if (hist_data->attrs->clear)
+				hist_clear(test);
+			updated = true;
+			goto out;
+		}
+	}
+ out:
+	return updated;
+}
+
 static int hist_register_trigger(char *glob,
 				 struct event_trigger_data *data,
 				 struct trace_event_file *file)
@@ -5957,19 +5999,11 @@ static int hist_register_trigger(char *glob,
 
 	list_for_each_entry(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
-			if (!hist_trigger_match(data, test, named_data, false))
-				continue;
-			if (hist_data->attrs->pause)
-				test->paused = true;
-			else if (hist_data->attrs->cont)
-				test->paused = false;
-			else if (hist_data->attrs->clear)
-				hist_clear(test);
-			else {
+			if (hist_trigger_match(data, test, named_data, false)) {
 				hist_err(tr, HIST_ERR_TRIGGER_EEXIST, 0);
 				ret = -EEXIST;
+				goto out;
 			}
-			goto out;
 		}
 	}
  new:
@@ -6008,8 +6042,6 @@ static int hist_register_trigger(char *glob,
 
 	if (named_data)
 		destroy_hist_data(hist_data);
-
-	ret++;
  out:
 	return ret;
 }
@@ -6277,14 +6309,12 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		goto out_free;
 	}
 
-	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
-	if (ret)
+	if (existing_hist_update_only(glob, trigger_data, file))
 		goto out_free;
-	if (ret == 0) {
-		if (!(attrs->pause || attrs->cont || attrs->clear))
-			ret = -ENOENT;
+
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret < 0)
 		goto out_free;
-	}
 
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
-- 
2.35.1
