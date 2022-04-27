Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06A85122DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiD0TkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiD0Tjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E4126D9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA34C61B65
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516F6C385B6;
        Wed, 27 Apr 2022 19:36:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSq-002IqL-AQ;
        Wed, 27 Apr 2022 15:36:40 -0400
Message-ID: <20220427193640.158530404@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 04/21] tracing: Have existing event_command.parse() implementations use
 helpers
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

Simplify the existing event_command.parse() implementations by having
them make use of the helper functions previously introduced.

Link: https://lkml.kernel.org/r/b353e3427a81f9d3adafd98fd7d73e78a8209f43.1644010576.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                |   3 +-
 kernel/trace/trace_eprobe.c         |   3 +-
 kernel/trace/trace_events_hist.c    |  64 +++++-------
 kernel/trace/trace_events_trigger.c | 150 ++++++++--------------------
 4 files changed, 69 insertions(+), 151 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f3e4cd1bb60e..ff816fb41e48 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1577,7 +1577,8 @@ extern int event_enable_trigger_print(struct seq_file *m,
 extern void event_enable_trigger_free(struct event_trigger_data *data);
 extern int event_enable_trigger_parse(struct event_command *cmd_ops,
 				      struct trace_event_file *file,
-				      char *glob, char *cmd, char *param);
+				      char *glob, char *cmd,
+				      char *param_and_filter);
 extern int event_enable_register_trigger(char *glob,
 					 struct event_trigger_data *data,
 					 struct trace_event_file *file);
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 9b3dfc9da067..b045fa9f276c 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -546,7 +546,8 @@ static struct event_trigger_ops eprobe_trigger_ops = {
 
 static int eprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 				    struct trace_event_file *file,
-				    char *glob, char *cmd, char *param)
+				    char *glob, char *cmd,
+				    char *param_and_filter)
 {
 	return -1;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 40a7e5582dfb..1b71bdb0bcb1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2785,7 +2785,8 @@ static char *find_trigger_filter(struct hist_trigger_data *hist_data,
 static struct event_command trigger_hist_cmd;
 static int event_hist_trigger_parse(struct event_command *cmd_ops,
 				    struct trace_event_file *file,
-				    char *glob, char *cmd, char *param);
+				    char *glob, char *cmd,
+				    char *param_and_filter);
 
 static bool compatible_keys(struct hist_trigger_data *target_hist_data,
 			    struct hist_trigger_data *hist_data,
@@ -6166,17 +6167,17 @@ static void hist_unreg_all(struct trace_event_file *file)
 
 static int event_hist_trigger_parse(struct event_command *cmd_ops,
 				    struct trace_event_file *file,
-				    char *glob, char *cmd, char *param)
+				    char *glob, char *cmd,
+				    char *param_and_filter)
 {
 	unsigned int hist_trigger_bits = TRACING_MAP_BITS_DEFAULT;
 	struct event_trigger_data *trigger_data;
 	struct hist_trigger_attrs *attrs;
-	struct event_trigger_ops *trigger_ops;
 	struct hist_trigger_data *hist_data;
+	char *param, *filter, *p, *start;
 	struct synth_event *se;
 	const char *se_name;
-	bool remove = false;
-	char *trigger, *p, *start;
+	bool remove;
 	int ret = 0;
 
 	lockdep_assert_held(&event_mutex);
@@ -6185,31 +6186,30 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	if (strlen(glob)) {
 		hist_err_clear();
-		last_cmd_set(file, param);
+		last_cmd_set(file, param_and_filter);
 	}
 
-	if (!param)
-		return -EINVAL;
+	remove = event_trigger_check_remove(glob);
 
-	if (glob[0] == '!')
-		remove = true;
+	if (event_trigger_empty_param(param_and_filter))
+		return -EINVAL;
 
 	/*
 	 * separate the trigger from the filter (k:v [if filter])
 	 * allowing for whitespace in the trigger
 	 */
-	p = trigger = param;
+	p = param = param_and_filter;
 	do {
 		p = strstr(p, "if");
 		if (!p)
 			break;
-		if (p == param)
+		if (p == param_and_filter)
 			return -EINVAL;
 		if (*(p - 1) != ' ' && *(p - 1) != '\t') {
 			p++;
 			continue;
 		}
-		if (p >= param + strlen(param) - (sizeof("if") - 1) - 1)
+		if (p >= param_and_filter + strlen(param_and_filter) - (sizeof("if") - 1) - 1)
 			return -EINVAL;
 		if (*(p + sizeof("if") - 1) != ' ' && *(p + sizeof("if") - 1) != '\t') {
 			p++;
@@ -6219,24 +6219,24 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	} while (1);
 
 	if (!p)
-		param = NULL;
+		filter = NULL;
 	else {
 		*(p - 1) = '\0';
-		param = strstrip(p);
-		trigger = strstrip(trigger);
+		filter = strstrip(p);
+		param = strstrip(param);
 	}
 
 	/*
 	 * To simplify arithmetic expression parsing, replace occurrences of
 	 * '.sym-offset' modifier with '.symXoffset'
 	 */
-	start = strstr(trigger, ".sym-offset");
+	start = strstr(param, ".sym-offset");
 	while (start) {
 		*(start + 4) = 'X';
 		start = strstr(start + 11, ".sym-offset");
 	}
 
-	attrs = parse_hist_trigger_attrs(file->tr, trigger);
+	attrs = parse_hist_trigger_attrs(file->tr, param);
 	if (IS_ERR(attrs))
 		return PTR_ERR(attrs);
 
@@ -6249,29 +6249,15 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		return PTR_ERR(hist_data);
 	}
 
-	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
-
-	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
+	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, hist_data);
 	if (!trigger_data) {
 		ret = -ENOMEM;
 		goto out_free;
 	}
 
-	trigger_data->count = -1;
-	trigger_data->ops = trigger_ops;
-	trigger_data->cmd_ops = cmd_ops;
-
-	INIT_LIST_HEAD(&trigger_data->list);
-	RCU_INIT_POINTER(trigger_data->filter, NULL);
-
-	trigger_data->private_data = hist_data;
-
-	/* if param is non-empty, it's supposed to be a filter */
-	if (param && cmd_ops->set_filter) {
-		ret = cmd_ops->set_filter(param, trigger_data, file);
-		if (ret < 0)
-			goto out_free;
-	}
+	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
+	if (ret < 0)
+		goto out_free;
 
 	if (remove) {
 		if (!have_hist_trigger_match(trigger_data, file))
@@ -6298,8 +6284,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		if (!(attrs->pause || attrs->cont || attrs->clear))
 			ret = -ENOENT;
 		goto out_free;
-	} else if (ret < 0)
-		goto out_free;
+	}
 
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
@@ -6331,8 +6316,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
  out_unreg:
 	event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
  out_free:
-	if (cmd_ops->set_filter)
-		cmd_ops->set_filter(NULL, trigger_data, NULL);
+	event_trigger_reset_filter(cmd_ops, trigger_data);
 
 	remove_hist_vars(hist_data);
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 32202175875d..62c44dab8f46 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -965,7 +965,7 @@ void event_trigger_unregister(struct event_command *cmd_ops,
  * @file: The trace_event_file associated with the event
  * @glob: The raw string used to register the trigger
  * @cmd: The cmd portion of the string used to register the trigger
- * @param: The params portion of the string used to register the trigger
+ * @param_and_filter: The param and filter portion of the string used to register the trigger
  *
  * Common implementation for event command parsing and trigger
  * instantiation.
@@ -978,72 +978,39 @@ void event_trigger_unregister(struct event_command *cmd_ops,
 static int
 event_trigger_parse(struct event_command *cmd_ops,
 		    struct trace_event_file *file,
-		    char *glob, char *cmd, char *param)
+		    char *glob, char *cmd, char *param_and_filter)
 {
 	struct event_trigger_data *trigger_data;
-	struct event_trigger_ops *trigger_ops;
-	char *trigger = NULL;
-	char *number;
+	char *param, *filter;
+	bool remove;
 	int ret;
 
-	/* separate the trigger from the filter (t:n [if filter]) */
-	if (param && isdigit(param[0])) {
-		trigger = strsep(&param, " \t");
-		if (param) {
-			param = skip_spaces(param);
-			if (!*param)
-				param = NULL;
-		}
-	}
+	remove = event_trigger_check_remove(glob);
 
-	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
+	ret = event_trigger_separate_filter(param_and_filter, &param, &filter, false);
+	if (ret)
+		return ret;
 
 	ret = -ENOMEM;
-	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
+	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, file);
 	if (!trigger_data)
 		goto out;
 
-	trigger_data->count = -1;
-	trigger_data->ops = trigger_ops;
-	trigger_data->cmd_ops = cmd_ops;
-	trigger_data->private_data = file;
-	INIT_LIST_HEAD(&trigger_data->list);
-	INIT_LIST_HEAD(&trigger_data->named_list);
-
-	if (glob[0] == '!') {
+	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		kfree(trigger_data);
 		ret = 0;
 		goto out;
 	}
 
-	if (trigger) {
-		number = strsep(&trigger, ":");
-
-		ret = -EINVAL;
-		if (!strlen(number))
-			goto out_free;
-
-		/*
-		 * We use the callback data field (which is a pointer)
-		 * as our counter.
-		 */
-		ret = kstrtoul(number, 0, &trigger_data->count);
-		if (ret)
-			goto out_free;
-	}
-
-	if (!param) /* if param is non-empty, it's supposed to be a filter */
-		goto out_reg;
-
-	if (!cmd_ops->set_filter)
-		goto out_reg;
+	ret = event_trigger_parse_num(param, trigger_data);
+	if (ret)
+		goto out_free;
 
-	ret = cmd_ops->set_filter(param, trigger_data, file);
+	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
 	if (ret < 0)
 		goto out_free;
 
- out_reg:
 	/* Up the trigger_data count to make sure reg doesn't free it on failure */
 	event_trigger_init(trigger_data);
 
@@ -1057,8 +1024,7 @@ event_trigger_parse(struct event_command *cmd_ops,
 	return ret;
 
  out_free:
-	if (cmd_ops->set_filter)
-		cmd_ops->set_filter(NULL, trigger_data, NULL);
+	event_trigger_reset_filter(cmd_ops, trigger_data);
 	kfree(trigger_data);
 	goto out;
 }
@@ -1752,39 +1718,33 @@ static struct event_trigger_ops event_disable_count_trigger_ops = {
 
 int event_enable_trigger_parse(struct event_command *cmd_ops,
 			       struct trace_event_file *file,
-			       char *glob, char *cmd, char *param)
+			       char *glob, char *cmd, char *param_and_filter)
 {
 	struct trace_event_file *event_enable_file;
 	struct enable_trigger_data *enable_data;
 	struct event_trigger_data *trigger_data;
-	struct event_trigger_ops *trigger_ops;
 	struct trace_array *tr = file->tr;
+	char *param, *filter;
+	bool enable, remove;
 	const char *system;
 	const char *event;
 	bool hist = false;
-	char *trigger;
-	char *number;
-	bool enable;
 	int ret;
 
-	if (!param)
-		return -EINVAL;
+	remove = event_trigger_check_remove(glob);
 
-	/* separate the trigger from the filter (s:e:n [if filter]) */
-	trigger = strsep(&param, " \t");
-	if (!trigger)
+	if (event_trigger_empty_param(param_and_filter))
 		return -EINVAL;
-	if (param) {
-		param = skip_spaces(param);
-		if (!*param)
-			param = NULL;
-	}
 
-	system = strsep(&trigger, ":");
-	if (!trigger)
+	ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
+	if (ret)
+		return ret;
+
+	system = strsep(&param, ":");
+	if (!param)
 		return -EINVAL;
 
-	event = strsep(&trigger, ":");
+	event = strsep(&param, ":");
 
 	ret = -EINVAL;
 	event_enable_file = find_event_file(tr, system, event);
@@ -1800,31 +1760,23 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 #else
 	enable = strcmp(cmd, ENABLE_EVENT_STR) == 0;
 #endif
-	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
-
 	ret = -ENOMEM;
-	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
-	if (!trigger_data)
-		goto out;
 
 	enable_data = kzalloc(sizeof(*enable_data), GFP_KERNEL);
-	if (!enable_data) {
-		kfree(trigger_data);
+	if (!enable_data)
 		goto out;
-	}
-
-	trigger_data->count = -1;
-	trigger_data->ops = trigger_ops;
-	trigger_data->cmd_ops = cmd_ops;
-	INIT_LIST_HEAD(&trigger_data->list);
-	RCU_INIT_POINTER(trigger_data->filter, NULL);
 
 	enable_data->hist = hist;
 	enable_data->enable = enable;
 	enable_data->file = event_enable_file;
-	trigger_data->private_data = enable_data;
 
-	if (glob[0] == '!') {
+	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, enable_data);
+	if (!trigger_data) {
+		kfree(enable_data);
+		goto out;
+	}
+
+	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		kfree(trigger_data);
 		kfree(enable_data);
@@ -1835,33 +1787,14 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	/* Up the trigger_data count to make sure nothing frees it on failure */
 	event_trigger_init(trigger_data);
 
-	if (trigger) {
-		number = strsep(&trigger, ":");
-
-		ret = -EINVAL;
-		if (!strlen(number))
-			goto out_free;
-
-		/*
-		 * We use the callback data field (which is a pointer)
-		 * as our counter.
-		 */
-		ret = kstrtoul(number, 0, &trigger_data->count);
-		if (ret)
-			goto out_free;
-	}
-
-	if (!param) /* if param is non-empty, it's supposed to be a filter */
-		goto out_reg;
-
-	if (!cmd_ops->set_filter)
-		goto out_reg;
+	ret = event_trigger_parse_num(param, trigger_data);
+	if (ret)
+		goto out_free;
 
-	ret = cmd_ops->set_filter(param, trigger_data, file);
+	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
 	if (ret < 0)
 		goto out_free;
 
- out_reg:
 	/* Don't let event modules unload while probe registered */
 	ret = trace_event_try_get_ref(event_enable_file->event_call);
 	if (!ret) {
@@ -1880,16 +1813,15 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	event_trigger_free(trigger_data);
  out:
 	return ret;
-
  out_disable:
 	trace_event_enable_disable(event_enable_file, 0, 1);
  out_put:
 	trace_event_put_ref(event_enable_file->event_call);
  out_free:
-	if (cmd_ops->set_filter)
-		cmd_ops->set_filter(NULL, trigger_data, NULL);
+	event_trigger_reset_filter(cmd_ops, trigger_data);
 	event_trigger_free(trigger_data);
 	kfree(enable_data);
+
 	goto out;
 }
 
-- 
2.35.1
