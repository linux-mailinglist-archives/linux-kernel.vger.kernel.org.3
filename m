Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A9C4AA2E6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348169AbiBDWMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:12:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55660 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346694AbiBDWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:12:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DBA86199F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 22:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354D9C004E1;
        Fri,  4 Feb 2022 22:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644012739;
        bh=y1dpcwaROiGNIsdVFNTBw0iucvP+KvehfPTvsCdkpjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SWtE4mmD/c+3cOTfA0RIAsJqgcEyvo8bSkb0VyNeVB7nE107L5tESG91ZPTWFpOFT
         bfjocuAZO+SPH6fnT5yNwd0aToSRe2ZK2FYUr3Xm6rKcI0WJdToHC8dMzvAO2zpQ1A
         KxG8iPIgzXccenq+e4HO958bMcH5r4D5Iu7U4SLdn7UyKhkzbnEaJe4TbbZ+qz8KEY
         8Vy3YqXirYeqcgoi8dkQjWpDJR3OtcC0TaO6IQhn5HVk32ulTeAcxcRCrzX2ImNjgL
         JK11Re9uZY0Qk5aEMn/zFhnr+xroiFggkelWmqyOGL9wsqGPNMS2l/hJQWIPBqspyk
         6xF+gQsLe48Dg==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/4] tracing: Separate hist state updates from hist registration
Date:   Fri,  4 Feb 2022 16:12:07 -0600
Message-Id: <211b2cd3e3d7e00f4f8ad45ef8b33063da6a7e05.1644010576.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1644010575.git.zanussi@kernel.org>
References: <cover.1644010575.git.zanussi@kernel.org>
In-Reply-To: <cover.1644010575.git.zanussi@kernel.org>
References: <cover.1644010575.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hist_register_trigger() handles both new hist registration as well as
existing hist registration through event_command.reg().

Adding a new function, existing_hist_update_only(), that checks and
updates existing histograms and exits after doing so allows the
confusing logic in event_hist_trigger_parse() to be simplified.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 66 +++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 28604e17bc73..bc52b03be11a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5926,6 +5926,48 @@ static bool hist_trigger_match(struct event_trigger_data *data,
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
@@ -5954,19 +5996,11 @@ static int hist_register_trigger(char *glob,
 
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
@@ -6005,8 +6039,6 @@ static int hist_register_trigger(char *glob,
 
 	if (named_data)
 		destroy_hist_data(hist_data);
-
-	ret++;
  out:
 	return ret;
 }
@@ -6274,14 +6306,12 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
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
2.17.1

