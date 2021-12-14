Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E6C474B51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhLNS55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:57:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59778 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbhLNS5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:57:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03B1B616BD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 18:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A650C34604;
        Tue, 14 Dec 2021 18:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639508266;
        bh=fgtmrFSTA7TJUXtwIdEVHtlp4eKpbTqNfKG+PWAa6Lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ekVJOkoD39JP4KDLv3V3sLXffbp/IQnExdt4LzW6uhMu1V23/mIjb6WOoZRZHRFfR
         TEOEeAWuw0QHM04RNzo0nAEhEzvk320WOBZE3cmU+kGf1/nxTSA6xlBVUMr7MpOsPL
         fIAS8FuyaunMH/q0yZTfj14fbXWYUDBi1Lid/asQ6PmgADglR0+SkuvKts1CqJKOTd
         teMpbsUdNI04lDvLr5zCrn4qJwxBcBzCcyg9PQupyLGFnAgH4JXkm3qaVAQC+8qd6i
         EMvnCdSp9bgXDCz7lRApZLVRb9SeykG2heKL4J9ubKs8ryABuP56KVDdxpmyEH8EJj
         dDE5jq9xCE0Tw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] tracing: Have existing event_command.parse() implementations use helpers
Date:   Tue, 14 Dec 2021 12:57:32 -0600
Message-Id: <f043571a0b7ccc0eb524f87b63c520a460e59baf.1639507505.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1639507505.git.zanussi@kernel.org>
References: <cover.1639507505.git.zanussi@kernel.org>
In-Reply-To: <cover.1639507505.git.zanussi@kernel.org>
References: <cover.1639507505.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the existing event_command.parse() implementations by having
them make use of the helper functions previously introduced.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.h                |   3 +-
 kernel/trace/trace_eprobe.c         |   3 +-
 kernel/trace/trace_events_hist.c    |  75 +++++-------
 kernel/trace/trace_events_trigger.c | 176 ++++++++--------------------
 4 files changed, 81 insertions(+), 176 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 440afe2ab763..9387ea2759a5 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1580,7 +1580,8 @@ extern void event_enable_trigger_free(struct event_trigger_ops *ops,
 				      struct event_trigger_data *data);
 extern int event_enable_trigger_parse(struct event_command *cmd_ops,
 				      struct trace_event_file *file,
-				      char *glob, char *cmd, char *param);
+				      char *glob, char *cmd,
+				      char *param_and_filter);
 extern int event_enable_register_trigger(char *glob,
 					 struct event_trigger_ops *ops,
 					 struct event_trigger_data *data,
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 6d363fd8a1e4..78f14ff6b99c 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -551,7 +551,8 @@ static struct event_trigger_ops eprobe_trigger_ops = {
 
 static int eprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 				    struct trace_event_file *file,
-				    char *glob, char *cmd, char *param)
+				    char *glob, char *cmd,
+				    char *param_and_filter)
 {
 	return -1;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 229ce5c2dfd3..e810a10ef8b7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2763,7 +2763,8 @@ static char *find_trigger_filter(struct hist_trigger_data *hist_data,
 static struct event_command trigger_hist_cmd;
 static int event_hist_trigger_parse(struct event_command *cmd_ops,
 				    struct trace_event_file *file,
-				    char *glob, char *cmd, char *param);
+				    char *glob, char *cmd,
+				    char *param_and_filter);
 
 static bool compatible_keys(struct hist_trigger_data *target_hist_data,
 			    struct hist_trigger_data *hist_data,
@@ -6148,48 +6149,49 @@ static void hist_unreg_all(struct trace_event_file *file)
 
 static int event_hist_trigger_parse(struct event_command *cmd_ops,
 				    struct trace_event_file *file,
-				    char *glob, char *cmd, char *param)
+				    char *glob, char *cmd,
+				    char *param_and_filter)
 {
 	unsigned int hist_trigger_bits = TRACING_MAP_BITS_DEFAULT;
 	struct event_trigger_data *trigger_data;
 	struct hist_trigger_attrs *attrs;
 	struct event_trigger_ops *trigger_ops;
 	struct hist_trigger_data *hist_data;
+	char *param, *filter, *p, *start;
 	struct synth_event *se;
 	const char *se_name;
-	bool remove = false;
-	char *trigger, *p, *start;
+	int n_registered;
+	bool remove;
 	int ret = 0;
 
 	lockdep_assert_held(&event_mutex);
 
 	if (glob && strlen(glob)) {
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
@@ -6199,24 +6201,24 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	} while (p);
 
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
 
@@ -6229,29 +6231,15 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
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
@@ -6271,18 +6259,14 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		goto out_free;
 	}
 
-	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
-	/*
-	 * The above returns on success the # of triggers registered,
-	 * but if it didn't register any it returns zero.  Consider no
-	 * triggers registered a failure too.
-	 */
-	if (!ret) {
+	ret = event_trigger_register(cmd_ops, file, glob, cmd, param, trigger_data, &n_registered);
+	if (ret)
+		goto out_free;
+	if ((ret == 0) && (n_registered == 0)) {
 		if (!(attrs->pause || attrs->cont || attrs->clear))
 			ret = -ENOENT;
 		goto out_free;
-	} else if (ret < 0)
-		goto out_free;
+	}
 
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
@@ -6316,8 +6300,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
  out_unreg:
 	cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
  out_free:
-	if (cmd_ops->set_filter)
-		cmd_ops->set_filter(NULL, trigger_data, NULL);
+	event_trigger_reset_filter(cmd_ops, trigger_data);
 
 	remove_hist_vars(hist_data);
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index da103826f27e..e6a48e8c79eb 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -973,7 +973,7 @@ int event_trigger_register(struct event_command *cmd_ops,
  * @file: The trace_event_file associated with the event
  * @glob: The raw string used to register the trigger
  * @cmd: The cmd portion of the string used to register the trigger
- * @param: The params portion of the string used to register the trigger
+ * @param_and_filter: The param and filter portion of the string used to register the trigger
  *
  * Common implementation for event command parsing and trigger
  * instantiation.
@@ -986,94 +986,53 @@ int event_trigger_register(struct event_command *cmd_ops,
 static int
 event_trigger_parse(struct event_command *cmd_ops,
 		    struct trace_event_file *file,
-		    char *glob, char *cmd, char *param)
+		    char *glob, char *cmd, char *param_and_filter)
 {
 	struct event_trigger_data *trigger_data;
 	struct event_trigger_ops *trigger_ops;
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
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
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
 	event_trigger_init(trigger_ops, trigger_data);
-	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
-	/*
-	 * The above returns on success the # of functions enabled,
-	 * but if it didn't find any functions it returns zero.
-	 * Consider no functions a failure too.
-	 */
-	if (!ret) {
-		cmd_ops->unreg(glob, trigger_ops, trigger_data, file);
-		ret = -ENOENT;
-	} else if (ret > 0)
-		ret = 0;
+
+	ret = event_trigger_register(cmd_ops, file, glob, cmd, param, trigger_data, NULL);
+	if (ret)
+		goto out_free;
 
 	/* Down the counter of trigger_data or free it if not used anymore */
 	event_trigger_free(trigger_ops, trigger_data);
  out:
 	return ret;
-
  out_free:
-	if (cmd_ops->set_filter)
-		cmd_ops->set_filter(NULL, trigger_data, NULL);
+	event_trigger_reset_filter(cmd_ops, trigger_data);
 	kfree(trigger_data);
 	goto out;
 }
@@ -1728,39 +1687,34 @@ static struct event_trigger_ops event_disable_count_trigger_ops = {
 
 int event_enable_trigger_parse(struct event_command *cmd_ops,
 			       struct trace_event_file *file,
-			       char *glob, char *cmd, char *param)
+			       char *glob, char *cmd, char *param_and_filter)
 {
 	struct trace_event_file *event_enable_file;
 	struct enable_trigger_data *enable_data;
 	struct event_trigger_data *trigger_data;
 	struct event_trigger_ops *trigger_ops;
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
@@ -1776,31 +1730,26 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 #else
 	enable = strcmp(cmd, ENABLE_EVENT_STR) == 0;
 #endif
-	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
+	trigger_ops = cmd_ops->get_trigger_ops(cmd, param);
 
 	ret = -ENOMEM;
-	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
-	if (!trigger_data)
-		goto out;
-
 	enable_data = kzalloc(sizeof(*enable_data), GFP_KERNEL);
 	if (!enable_data) {
 		kfree(trigger_data);
 		goto out;
 	}
 
-	trigger_data->count = -1;
-	trigger_data->ops = trigger_ops;
-	trigger_data->cmd_ops = cmd_ops;
-	INIT_LIST_HEAD(&trigger_data->list);
-	RCU_INIT_POINTER(trigger_data->filter, NULL);
-
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
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
 		kfree(trigger_data);
 		kfree(enable_data);
@@ -1811,33 +1760,14 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	/* Up the trigger_data count to make sure nothing frees it on failure */
 	event_trigger_init(trigger_ops, trigger_data);
 
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
@@ -1848,30 +1778,20 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	ret = trace_event_enable_disable(event_enable_file, 1, 1);
 	if (ret < 0)
 		goto out_put;
-	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
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
+	ret = event_trigger_register(cmd_ops, file, glob, cmd, param, trigger_data, NULL);
+	if (ret)
 		goto out_disable;
-	/* Just return zero, not the number of enabled functions */
-	ret = 0;
+
 	event_trigger_free(trigger_ops, trigger_data);
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
 	event_trigger_free(trigger_ops, trigger_data);
 	kfree(enable_data);
 	goto out;
-- 
2.17.1

