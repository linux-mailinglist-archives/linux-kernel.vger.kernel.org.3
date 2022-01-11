Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F75A48B3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbiAKRbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbiAKRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF3C061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:31:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B5E5B81C3A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15DFC36AF8;
        Tue, 11 Jan 2022 17:31:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzK-00326Y-4Q;
        Tue, 11 Jan 2022 12:31:14 -0500
Message-ID: <20220111173113.972059408@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:30:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 04/31] tracing: Add helper functions to simplify event_command.parse()
 callback handling
References: <20220111173030.999527342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

The event_command.parse() callback is responsible for parsing and
registering triggers.  The existing command implementions for this
callback duplicate a lot of the same code, so to clean up and
consolidate those implementations, introduce a handful of helper
functions for implementors to use.

This also makes it easier for new commands to be implemented and
allows them to focus more on the customizations they provide rather
than obscuring and complicating it with boilerplate code.

Link: https://lkml.kernel.org/r/c1ff71f594d45177706571132bd3119491097221.1641823001.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.h                |  24 ++
 kernel/trace/trace_events_trigger.c | 342 ++++++++++++++++++++++++++++
 2 files changed, 366 insertions(+)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 22a1e8635acf..d038ddbf1bea 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1610,6 +1610,30 @@ get_named_trigger_data(struct event_trigger_data *data);
 extern int register_event_command(struct event_command *cmd);
 extern int unregister_event_command(struct event_command *cmd);
 extern int register_trigger_hist_enable_disable_cmds(void);
+extern bool event_trigger_check_remove(const char *glob);
+extern bool event_trigger_empty_param(const char *param);
+extern int event_trigger_separate_filter(char *param_and_filter, char **param,
+					 char **filter, bool param_required);
+extern struct event_trigger_data *
+event_trigger_alloc(struct event_command *cmd_ops,
+		    char *cmd,
+		    char *param,
+		    void *private_data);
+extern int event_trigger_parse_num(char *trigger,
+				   struct event_trigger_data *trigger_data);
+extern int event_trigger_set_filter(struct event_command *cmd_ops,
+				    struct trace_event_file *file,
+				    char *param,
+				    struct event_trigger_data *trigger_data);
+extern void event_trigger_reset_filter(struct event_command *cmd_ops,
+				       struct event_trigger_data *trigger_data);
+extern int event_trigger_register(struct event_command *cmd_ops,
+				  struct trace_event_file *file,
+				  char *glob,
+				  char *cmd,
+				  char *trigger,
+				  struct event_trigger_data *trigger_data,
+				  int *n_registered);
 
 /**
  * struct event_trigger_ops - callbacks for trace event triggers
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index d40b857db572..d00fee705f9c 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -619,6 +619,348 @@ static void unregister_trigger(char *glob,
 		data->ops->free(data->ops, data);
 }
 
+/*
+ * Event trigger parsing helper functions.
+ *
+ * These functions help make it easier to write an event trigger
+ * parsing function i.e. the struct event_command.parse() callback
+ * function responsible for parsing and registering a trigger command
+ * written to the 'trigger' file.
+ *
+ * A trigger command (or just 'trigger' for short) takes the form:
+ *   [trigger] [if filter]
+ *
+ * The struct event_command.parse() callback (and other struct
+ * event_command functions) refer to several components of a trigger
+ * command.  Those same components are referenced by the event trigger
+ * parsing helper functions defined below.  These components are:
+ *
+ *   cmd               - the trigger command name
+ *   glob              - the trigger command name optionally prefaced with '!'
+ *   param_and_filter  - text following cmd and ':'
+ *   param             - text following cmd and ':' and stripped of filter
+ *   filter            - the optional filter text following (and including) 'if'
+ *
+ * To illustrate the use of these componenents, here are some concrete
+ * examples. For the following triggers:
+ *
+ *   echo 'traceon:5 if pid == 0' > trigger
+ *     - 'traceon' is both cmd and glob
+ *     - '5 if pid == 0' is the param_and_filter
+ *     - '5' is the param
+ *     - 'if pid == 0' is the filter
+ *
+ *   echo 'enable_event:sys:event:n' > trigger
+ *     - 'enable_event' is both cmd and glob
+ *     - 'sys:event:n' is the param_and_filter
+ *     - 'sys:event:n' is the param
+ *     - there is no filter
+ *
+ *   echo 'hist:keys=pid if prio > 50' > trigger
+ *     - 'hist' is both cmd and glob
+ *     - 'keys=pid if prio > 50' is the param_and_filter
+ *     - 'keys=pid' is the param
+ *     - 'if prio > 50' is the filter
+ *
+ *   echo '!enable_event:sys:event:n' > trigger
+ *     - 'enable_event' the cmd
+ *     - '!enable_event' is the glob
+ *     - 'sys:event:n' is the param_and_filter
+ *     - 'sys:event:n' is the param
+ *     - there is no filter
+ *
+ *   echo 'traceoff' > trigger
+ *     - 'traceoff' is both cmd and glob
+ *     - there is no param_and_filter
+ *     - there is no param
+ *     - there is no filter
+ *
+ * There are a few different categories of event trigger covered by
+ * these helpers:
+ *
+ *  - triggers that don't require a parameter e.g. traceon
+ *  - triggers that do require a parameter e.g. enable_event and hist
+ *  - triggers that though they may not require a param may support an
+ *    optional 'n' param (n = number of times the trigger should fire)
+ *    e.g.: traceon:5 or enable_event:sys:event:n
+ *  - triggers that do not support an 'n' param e.g. hist
+ *
+ * These functions can be used or ignored as necessary - it all
+ * depends on the complexity of the trigger, and the granularity of
+ * the functions supported reflects the fact that some implementations
+ * may need to customize certain aspects of their implementations and
+ * won't need certain functions.  For instance, the hist trigger
+ * implementation doesn't use event_trigger_separate_filter() because
+ * it has special requirements for handling the filter.
+ */
+
+/**
+ * event_trigger_check_remove - check whether an event trigger specifies remove
+ * @glob: The trigger command string, with optional remove(!) operator
+ *
+ * The event trigger callback implementations pass in 'glob' as a
+ * parameter.  This is the command name either with or without a
+ * remove(!)  operator.  This function simply parses the glob and
+ * determines whether the command corresponds to a trigger removal or
+ * a trigger addition.
+ *
+ * Return: true if this is a remove command, false otherwise
+ */
+bool event_trigger_check_remove(const char *glob)
+{
+	return (glob && glob[0] == '!') ? true : false;
+}
+
+/**
+ * event_trigger_empty_param - check whether the param is empty
+ * @param: The trigger param string
+ *
+ * The event trigger callback implementations pass in 'param' as a
+ * parameter.  This corresponds to the string following the command
+ * name minus the command name.  This function can be called by a
+ * callback implementation for any command that requires a param; a
+ * callback that doesn't require a param can ignore it.
+ *
+ * Return: true if this is an empty param, false otherwise
+ */
+bool event_trigger_empty_param(const char *param)
+{
+	return !param;
+}
+
+/**
+ * event_trigger_separate_filter - separate an event trigger from a filter
+ * @param: The param string containing trigger and possibly filter
+ * @trigger: outparam, will be filled with a pointer to the trigger
+ * @filter: outparam, will be filled with a pointer to the filter
+ * @param_required: Specifies whether or not the param string is required
+ *
+ * Given a param string of the form '[trigger] [if filter]', this
+ * function separates the filter from the trigger and returns the
+ * trigger in *trigger and the filter in *filter.  Either the *trigger
+ * or the *filter may be set to NULL by this function - if not set to
+ * NULL, they will contain strings corresponding to the trigger and
+ * filter.
+ *
+ * There are two cases that need to be handled with respect to the
+ * passed-in param: either the param is required, or it is not
+ * required.  If @param_required is set, and there's no param, it will
+ * return -EINVAL.  If @param_required is not set and there's a param
+ * that starts with a number, that corresponds to the case of a
+ * trigger with :n (n = number of times the trigger should fire) and
+ * the parsing continues normally; otherwise the function just returns
+ * and assumes param just contains a filter and there's nothing else
+ * to do.
+ *
+ * Return: 0 on success, errno otherwise
+ */
+int event_trigger_separate_filter(char *param_and_filter, char **param,
+				  char **filter, bool param_required)
+{
+	int ret = 0;
+
+	*param = *filter = NULL;
+
+	if (!param_and_filter) {
+		if (param_required)
+			ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Here we check for an optional param. The only legal
+	 * optional param is :n, and if that's the case, continue
+	 * below. Otherwise we assume what's left is a filter and
+	 * return it as the filter string for the caller to deal with.
+	 */
+	if (!param_required && param_and_filter && !isdigit(param_and_filter[0])) {
+		*filter = param_and_filter;
+		goto out;
+	}
+
+	/*
+	 * Separate the param from the filter (param [if filter]).
+	 * Here we have either an optional :n param or a required
+	 * param and an optional filter.
+	 */
+	*param = strsep(&param_and_filter, " \t");
+
+	/*
+	 * Here we have a filter, though it may be empty.
+	 */
+	if (param_and_filter) {
+		*filter = skip_spaces(param_and_filter);
+		if (!**filter)
+			*filter = NULL;
+	}
+out:
+	return ret;
+}
+
+/**
+ * event_trigger_alloc - allocate and init event_trigger_data for a trigger
+ * @cmd_ops: The event_command operations for the trigger
+ * @cmd: The cmd string
+ * @param: The param string
+ * @private_data: User data to associate with the event trigger
+ *
+ * Allocate an event_trigger_data instance and initialize it.  The
+ * @cmd_ops are used along with the @cmd and @param to get the
+ * trigger_ops to assign to the event_trigger_data.  @private_data can
+ * also be passed in and associated with the event_trigger_data.
+ *
+ * Use event_trigger_free() to free an event_trigger_data object.
+ *
+ * Return: The trigger_data object success, NULL otherwise
+ */
+struct event_trigger_data *event_trigger_alloc(struct event_command *cmd_ops,
+					       char *cmd,
+					       char *param,
+					       void *private_data)
+{
+	struct event_trigger_data *trigger_data;
+	struct event_trigger_ops *trigger_ops;
+
+	trigger_ops = cmd_ops->get_trigger_ops(cmd, param);
+
+	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
+	if (!trigger_data)
+		return NULL;
+
+	trigger_data->count = -1;
+	trigger_data->ops = trigger_ops;
+	trigger_data->cmd_ops = cmd_ops;
+	trigger_data->private_data = private_data;
+
+	INIT_LIST_HEAD(&trigger_data->list);
+	INIT_LIST_HEAD(&trigger_data->named_list);
+	RCU_INIT_POINTER(trigger_data->filter, NULL);
+
+	return trigger_data;
+}
+
+/**
+ * event_trigger_parse_num - parse and return the number param for a trigger
+ * @param: The param string
+ * @trigger_data: The trigger_data for the trigger
+ *
+ * Parse the :n (n = number of times the trigger should fire) param
+ * and set the count variable in the trigger_data to the parsed count.
+ *
+ * Return: 0 on success, errno otherwise
+ */
+int event_trigger_parse_num(char *param,
+			    struct event_trigger_data *trigger_data)
+{
+	char *number;
+	int ret = 0;
+
+	if (param) {
+		number = strsep(&param, ":");
+
+		if (!strlen(number))
+			return -EINVAL;
+
+		/*
+		 * We use the callback data field (which is a pointer)
+		 * as our counter.
+		 */
+		ret = kstrtoul(number, 0, &trigger_data->count);
+	}
+
+	return ret;
+}
+
+/**
+ * event_trigger_set_filter - set an event trigger's filter
+ * @cmd_ops: The event_command operations for the trigger
+ * @file: The event file for the trigger's event
+ * @param: The string containing the filter
+ * @trigger_data: The trigger_data for the trigger
+ *
+ * Set the filter for the trigger.  If the filter is NULL, just return
+ * without error.
+ *
+ * Return: 0 on success, errno otherwise
+ */
+int event_trigger_set_filter(struct event_command *cmd_ops,
+			     struct trace_event_file *file,
+			     char *param,
+			     struct event_trigger_data *trigger_data)
+{
+	if (param && cmd_ops->set_filter)
+		return cmd_ops->set_filter(param, trigger_data, file);
+
+	return 0;
+}
+
+/**
+ * event_trigger_reset_filter - reset an event trigger's filter
+ * @cmd_ops: The event_command operations for the trigger
+ * @trigger_data: The trigger_data for the trigger
+ *
+ * Reset the filter for the trigger to no filter.
+ */
+void event_trigger_reset_filter(struct event_command *cmd_ops,
+				struct event_trigger_data *trigger_data)
+{
+	if (cmd_ops->set_filter)
+		cmd_ops->set_filter(NULL, trigger_data, NULL);
+}
+
+/**
+ * event_trigger_register - register an event trigger
+ * @cmd_ops: The event_command operations for the trigger
+ * @file: The event file for the trigger's event
+ * @glob: The trigger command string, with optional remove(!) operator
+ * @cmd: The cmd string
+ * @param: The param string
+ * @trigger_data: The trigger_data for the trigger
+ * @n_registered: optional outparam, the number of triggers registered
+ *
+ * Register an event trigger.  The @cmd_ops are used to call the
+ * cmd_ops->reg() function which actually does the registration. The
+ * cmd_ops->reg() function returns the number of triggers registered,
+ * which is assigned to n_registered, if n_registered is non-NULL.
+ *
+ * Return: 0 on success, errno otherwise
+ */
+int event_trigger_register(struct event_command *cmd_ops,
+			   struct trace_event_file *file,
+			   char *glob,
+			   char *cmd,
+			   char *param,
+			   struct event_trigger_data *trigger_data,
+			   int *n_registered)
+{
+	int ret;
+
+	if (n_registered)
+		*n_registered = 0;
+
+	ret = cmd_ops->reg(glob, trigger_data, file);
+	/*
+	 * The above returns on success the # of functions enabled,
+	 * but if it didn't find any functions it returns zero.
+	 * Consider no functions a failure too.
+	 */
+	if (!ret) {
+		cmd_ops->unreg(glob, trigger_data, file);
+		ret = -ENOENT;
+	} else if (ret > 0) {
+		if (n_registered)
+			*n_registered = ret;
+		/* Just return zero, not the number of enabled functions */
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * End event trigger parsing helper functions.
+ */
+
 /**
  * event_trigger_parse - Generic event_command @parse implementation
  * @cmd_ops: The command ops, used for trigger registration
-- 
2.33.0
