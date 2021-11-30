Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4C4640A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbhK3Vuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344975AbhK3VuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:50:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B182C061399
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2180AB81D01
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9E3C53FCC;
        Tue, 30 Nov 2021 21:46:37 +0000 (UTC)
Date:   Tue, 30 Nov 2021 16:46:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: Add helper functions to simplify
 event_command callback handling
Message-ID: <20211130164634.61438802@gandalf.local.home>
In-Reply-To: <73a337f341f89c7d56a8958ee09d6c2a738393e3.1637700535.git.zanussi@kernel.org>
References: <cover.1637700535.git.zanussi@kernel.org>
        <73a337f341f89c7d56a8958ee09d6c2a738393e3.1637700535.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 14:53:53 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> The event_command.func() callback is responsible for parsing and
> registering triggers.  The existing command implementions for this
> callback duplicate a lot of the same code, so to clean up and
> consolidate those implementations, introduce a handful of helper
> functions for implementors to use.
> 
> This also makes it easier for new commands to be implemented and
> allows them to focus more on the customizations they provide rather
> than obscuring and complicating it with boilerplate code.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>

Thanks for the update Tom!

> ---
>  kernel/trace/trace.h                |  23 +++
>  kernel/trace/trace_events_trigger.c | 286 ++++++++++++++++++++++++++++
>  2 files changed, 309 insertions(+)
> 
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 6b60ab9475ed..66cc32aca2e8 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1594,6 +1594,29 @@ get_named_trigger_data(struct event_trigger_data *data);
>  extern int register_event_command(struct event_command *cmd);
>  extern int unregister_event_command(struct event_command *cmd);
>  extern int register_trigger_hist_enable_disable_cmds(void);
> +extern bool event_trigger_check_remove(char *cmd);
> +extern bool event_trigger_empty_param(char *param);
> +extern int event_trigger_separate_filter(char **trigger, char **param, bool param_required);
> +extern struct event_trigger_data *
> +event_trigger_alloc(struct event_command *cmd_ops,
> +		    char *cmd,
> +		    char *param,
> +		    void *private_data);
> +extern int event_trigger_parse_num(char *trigger,
> +				   struct event_trigger_data *trigger_data);
> +extern int event_trigger_set_filter(struct event_command *cmd_ops,
> +				    struct trace_event_file *file,
> +				    char *param,
> +				    struct event_trigger_data *trigger_data);
> +extern void event_trigger_reset_filter(struct event_command *cmd_ops,
> +				       struct event_trigger_data *trigger_data);
> +extern int event_trigger_register(struct event_command *cmd_ops,
> +				  struct trace_event_file *file,
> +				  char *glob,
> +				  char *cmd,
> +				  char *trigger,
> +				  struct event_trigger_data *trigger_data,
> +				  int *n_registered);
>  
>  /**
>   * struct event_trigger_ops - callbacks for trace event triggers
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 3d5c07239a2a..a873f4e8be04 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -621,6 +621,292 @@ static void unregister_trigger(char *glob, struct event_trigger_ops *ops,
>  		data->ops->free(data->ops, data);
>  }
>  
> +/*
> + * Event trigger parsing helper functions.
> + *
> + * These functions help make it easier to write an event trigger
> + * parsing function i.e. the struct event_command.func() callback
> + * function responsible for parsing and registering a trigger command
> + * written to the 'trigger' file.
> + *
> + * There are a few different categories of event trigger covered by
> + * these helpers:
> + *
> + *  - triggers that don't require a parameter e.g. traceon
> + *  - triggers that do require a parameter e.g. enable_event and hist
> + *  - triggers that though they may not require a param may support an
> + *    optional 'n' param (n = number of times the trigger should fire)
> + *    e.g.: traceon:5 or enable_event:sys:event:n
> + *  - triggers that do not support an 'n' param e.g. hist
> + *
> + * These functions can be used or ignored as necessary - it all
> + * depends on the complexity of the trigger, and the granularity of
> + * the functions supported reflects the fact that some implementations
> + * may need to customize certain aspects of their implementations and
> + * won't need certain functions.  For instance, the hist trigger
> + * implementation doesn't use event_trigger_separate_filter() because
> + * it has special requirements for handling the filter.
> + */
> +
> +/**
> + * event_trigger_check_remove - check whether an event trigger specifies remove
> + * @glob: The trigger command string, with optional remove(!) operator
> + *
> + * The event trigger callback implementations pass in 'glob' as a
> + * parameter.  This is the command name either with or without a
> + * remove(!)  operator.  This function simply parses the glob and
> + * determines whether the command corresponds to a trigger removal or
> + * a trigger addition.
> + *
> + * Return: true if this is a remove command, false otherwise
> + */
> +bool event_trigger_check_remove(char *glob)

			const char *glob ?

> +{
> +	return (glob && glob[0] == '!') ? true : false;
> +}
> +
> +/**
> + * event_trigger_empty_param - check whether the param is empty
> + * @param: The trigger param string
> + *
> + * The event trigger callback implementations pass in 'param' as a
> + * parameter.  This corresponds to the string following the command
> + * name minus the command name.  This function can be called by a
> + * callback implementation for any command that requires a param; a
> + * callback that doesn't require a param can ignore it.
> + *
> + * Return: true if this is an empty param, false otherwise
> + */
> +bool event_trigger_empty_param(char *param)

			const char *param ?
> +{
> +	return !param;
> +}
> +
> +/**
> + * event_trigger_separate_filter - separate an event trigger from a filter
> + * @trigger: outparam, will be filled with a pointer to the trigger
> + * @param: The param string, will contain the filter after this is called
> + * @param_required: Specifies whether or not the param string is required
> + *

Let's not make this more confusing then it has to be. Let's pass in the
input parameter as a separate value. Because I'm totally confused by what
is an input and what is an output.

	(char *param, char **trigger, char **filter, ..

?


> + * Given a param string of the form '[trigger] [if filter]', this
> + * function separates the filter from the trigger and returns the
> + * trigger in *trigger and the filter in *param.  Either the *trigger
> + * or the *param may be set to NULL by this function - if not set to
> + * NULL, they will contain strings corresponding to the trigger and
> + * filter.
> + *
> + * There are two cases that need to be handled with respect to the
> + * passed-in param: either the param is required, or it is not
> + * required.  If @param_required is set, and there's no param, it will
> + * return -EINVAL.  If @param_required is not set and there's a param
> + * that starts with a number, that corresponds to the case of a
> + * trigger with :n (n = number of times the trigger should fire) and
> + * the parsing continues normally; otherwise the function just returns
> + * and assumes param just contains a filter and there's nothing else
> + * to do.

I'm not sure how the number is parsed here.

Really, getting rid of having two different ops that are attached to each
other should be cleaned up first. At least change their internal names.

We have: struct event_command that has

	int			(*func)(struct event_command *cmd_ops,
					struct trace_event_file *file,
					char *glob, char *cmd, char *params);

And

	struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);

Where it returns event_tigger_ops that has:

	void			(*func)(struct event_trigger_data *data,
					struct trace_buffer *buffer, void *rec,
					struct ring_buffer_event *rbe);

So when I see:  ops->func() I have no clue what func that is!

Let's first rename one of them, and that way it is easier to know what is
going on. There's a lot of magic here that is hard to follow.

> + *
> + * Return: 0 on success, errno otherwise
> + */
> +int event_trigger_separate_filter(char **trigger, char **param, bool param_required)
> +{
> +	int ret = 0;
> +
> +	*trigger = NULL;
> +
> +	if (!*param) {
> +		if (param_required)
> +			ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* the only legal optional param is :n */
> +	if (!param_required && *param && !isdigit(*param[0]))
> +		goto out;

How does *param[0] end up pointing to a number? If it was:

 trigger:n if filter

?

The event_trigger_parse_num() is called after this.

> +
> +	/* separate the trigger from the filter (trigger [if filter]) */
> +	*trigger = strsep(param, " \t");
> +	if (!*trigger) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (*param) {
> +		*param = skip_spaces(*param);
> +		if (!**param)
> +			*param = NULL;
> +	}
> +out:
> +	return ret;
> +}
> +
> +/**
> + * event_trigger_alloc - allocate and init event_trigger_data for a trigger
> + * @cmd_ops: The event_command operations for the trigger
> + * @cmd: The cmd string
> + * @param: The param string
> + * @private_data: User data to associate with the event trigger
> + *
> + * Allocate an event_trigger_data instance and initialize it.  The
> + * @cmd_ops are used along with the @cmd and @param to get the
> + * trigger_ops to assign to the event_trigger_data.  @private_data can
> + * also be passed in and associated with the event_trigger_data.
> + *
> + * Use event_trigger_free() to free an event_trigger_data object.
> + *
> + * Return: The trigger_data object success, NULL otherwise
> + */
> +struct event_trigger_data *event_trigger_alloc(struct event_command *cmd_ops,
> +					       char *cmd,
> +					       char *param,
> +					       void *private_data)
> +{
> +	struct event_trigger_data *trigger_data;
> +	struct event_trigger_ops *trigger_ops;
> +
> +	trigger_ops = cmd_ops->get_trigger_ops(cmd, param);
> +
> +	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
> +	if (!trigger_data)
> +		return NULL;
> +
> +	trigger_data->count = -1;
> +	trigger_data->ops = trigger_ops;
> +	trigger_data->cmd_ops = cmd_ops;
> +	trigger_data->private_data = private_data;
> +
> +	INIT_LIST_HEAD(&trigger_data->list);
> +	INIT_LIST_HEAD(&trigger_data->named_list);
> +	RCU_INIT_POINTER(trigger_data->filter, NULL);
> +
> +	return trigger_data;
> +}
> +
> +/**
> + * event_trigger_parse_num - parse and return the number param for a trigger
> + * @trigger: The trigger string
> + * @trigger_data: The trigger_data for the trigger
> + *
> + * Parse the :n (n = number of times the trigger should fire) param
> + * and set the count variable in the trigger_data to the parsed count.
> + *
> + * Return: 0 on success, errno otherwise
> + */
> +int event_trigger_parse_num(char *trigger,
> +			    struct event_trigger_data *trigger_data)
> +{
> +	char *number;
> +	int ret = 0;
> +
> +	if (trigger) {
> +		number = strsep(&trigger, ":");
> +
> +		if (!strlen(number))
> +			return -EINVAL;
> +
> +		/*
> +		 * We use the callback data field (which is a pointer)
> +		 * as our counter.
> +		 */
> +		ret = kstrtoul(number, 0, &trigger_data->count);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * event_trigger_set_filter - set an event trigger's filter
> + * @cmd_ops: The event_command operations for the trigger
> + * @file: The event file for the trigger's event
> + * @param: The string containing the filter
> + * @trigger_data: The trigger_data for the trigger
> + *
> + * Set the filter for the trigger.  If the filter is NULL, just return
> + * without error.
> + *
> + * Return: 0 on success, errno otherwise
> + */
> +int event_trigger_set_filter(struct event_command *cmd_ops,
> +			     struct trace_event_file *file,
> +			     char *param,
> +			     struct event_trigger_data *trigger_data)
> +{
> +	if (param && cmd_ops->set_filter)
> +		return cmd_ops->set_filter(param, trigger_data, file);
> +
> +	return 0;
> +}
> +
> +/**
> + * event_trigger_reset_filter - reset an event trigger's filter
> + * @cmd_ops: The event_command operations for the trigger
> + * @trigger_data: The trigger_data for the trigger
> + *
> + * Reset the filter for the trigger to no filter.
> + */
> +void event_trigger_reset_filter(struct event_command *cmd_ops,
> +				struct event_trigger_data *trigger_data)
> +{
> +	if (cmd_ops->set_filter)
> +		cmd_ops->set_filter(NULL, trigger_data, NULL);
> +}
> +
> +/**
> + * event_trigger_register - register an event trigger
> + * @cmd_ops: The event_command operations for the trigger
> + * @file: The event file for the trigger's event
> + * @glob: The trigger command string, with optional remove(!) operator
> + * @cmd: The cmd string
> + * @param: The param string
> + * @trigger_data: The trigger_data for the trigger
> + * @n_registered: optional outparam, the number of triggers registered
> + *
> + * Register and event trigger.  The @cmd_ops are used along with the

    "Register an event trigger"

-- Steve

> + * @cmd and @param to get the trigger_ops to pass to the
> + * cmd_ops->reg() function which actually does the registration. The
> + * cmd_ops->reg() function returns the number of triggers registered,
> + * which is assigned to n_registered, if n_registered is non-NULL.
> + *
> + * Return: 0 on success, errno otherwise
> + */
> +int event_trigger_register(struct event_command *cmd_ops,
> +			   struct trace_event_file *file,
> +			   char *glob,
> +			   char *cmd,
> +			   char *param,
> +			   struct event_trigger_data *trigger_data,
> +			   int *n_registered)
> +{
> +	struct event_trigger_ops *trigger_ops;
> +	int ret;
> +
> +	if (n_registered)
> +		*n_registered = 0;
> +
> +	trigger_ops = cmd_ops->get_trigger_ops(cmd, param);
> +
> +	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> +	/*
> +	 * The above returns on success the # of functions enabled,
> +	 * but if it didn't find any functions it returns zero.
> +	 * Consider no functions a failure too.
> +	 */
> +	if (!ret) {
> +		cmd_ops->unreg(glob, trigger_ops, trigger_data, file);
> +		ret = -ENOENT;
> +	} else if (ret > 0) {
> +		if (n_registered)
> +			*n_registered = ret;
> +		/* Just return zero, not the number of enabled functions */
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * End event trigger parsing helper functions.
> + */
> +
>  /**
>   * event_trigger_callback - Generic event_command @func implementation
>   * @cmd_ops: The command ops, used for trigger registration

