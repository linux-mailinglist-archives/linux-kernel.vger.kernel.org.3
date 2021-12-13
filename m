Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97AD472DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbhLMNqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:46:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57330 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhLMNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:46:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACBAD60FF3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1844BC34601;
        Mon, 13 Dec 2021 13:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639403205;
        bh=L8Ws9gnYQG6T1Ti22xGFdxh/kW7egR1co9xBDixrWVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TtfGWQoC1Q0S9Rbh/ILGnPgIuOwh3JGLzjVUxGZYLNhpQ4+JmFGhqlB37j6lM5GCi
         z/6QIkgXhqScZ1Sf2nNPJHohCKeAkiq4d3jCTCjM0KRUzWI2WFNiiK6AuEBuNjn1Vz
         SluWUlXVv2w/eeC8sdLiF+rlxMhq+VYkm50Woy1d09tzy6f7wfsN+VKnNSnMXkZyh2
         9CuPRpB1LcIz3A3tqaDKYIwGkHbIvyK0clIoMV+xTHG810+1yiZkB7jGLSh8iopp4E
         VpkUPSi02wRwMjgENUoyY6rjkDaIzUgI3qGmAj/m4aoY2ciHayvBm/t+RKNPk7GoWw
         9OG/pnaktdg7A==
Date:   Mon, 13 Dec 2021 22:46:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] tracing: Add helper functions to simplify
 event_command.parse() callback handling
Message-Id: <20211213224641.565ec75ffccca6fc8783c035@kernel.org>
In-Reply-To: <4579e8fbf60ca9f471a3ff680ffc5c469be83f06.1639170140.git.zanussi@kernel.org>
References: <cover.1639170140.git.zanussi@kernel.org>
        <4579e8fbf60ca9f471a3ff680ffc5c469be83f06.1639170140.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Fri, 10 Dec 2021 15:16:24 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> +/*
> + * Event trigger parsing helper functions.
> + *
> + * These functions help make it easier to write an event trigger
> + * parsing function i.e. the struct event_command.parse() callback
> + * function responsible for parsing and registering a trigger command
> + * written to the 'trigger' file.
> + *
> + * A trigger command (or just 'trigger' for short) takes the form:
> + *   [trigger] [if filter]
> + *
> + * The struct event_command.parse() callback (and other struct
> + * event_command functions) refer to several components of a trigger
> + * command.  Those same components are referenced by the event trigger
> + * parsing helper functions defined below.  These components are:
> + *
> + *   cmd     - the trigger command name
> + *   glob    - the trigger command name optionally prefaced with '!'
> + *   param   - text remaining after the command is stripped of cmd and ':'
> + *   filter  - the optional filter text following (and including) 'if'
> + *
> + * To illustrate the use of these componenents, here are some concrete
> + * examples. For the following triggers:
> + *
> + *   echo 'traceon:5 if pid == 0' > trigger
> + *     - 'traceon' is both cmd and glob
> + *     - '5 if pid == 0' is the param
> + *     - 'if pid == 0' is the filter

I would like to know why both 'param' and 'filter' has "if pid == 0".
I thought that part is (generic) filter and not a parameter.

If I missed any discussion on this point, sorry about that.

> + *
> + *   echo 'enable_event:sys:event:n' > trigger
> + *     - 'enable_event' is both cmd and glob
> + *     - 'sys:event:n' is the param
> + *     - there is no filter
> + *
> + *   echo 'hist:keys=pid if prio > 50' > trigger
> + *     - 'hist' is both cmd and glob
> + *     - 'keys=pid if prio > 50' is the param
> + *     - 'if prio > 50' is the filter
> + *
> + *   echo '!enable_event:sys:event:n' > trigger
> + *     - 'enable_event' the cmd
> + *     - '!enable_event' is the glob
> + *     - 'sys:event:n' is the param
> + *     - there is no filter
> + *
> + *   echo 'traceoff' > trigger
> + *     - 'traceoff' is both cmd and glob
> + *     - there is no param
> + *     - there is no filter
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
> +bool event_trigger_check_remove(const char *glob)
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
> +bool event_trigger_empty_param(const char *param)
> +{
> +	return !param;
> +}
> +
> +/**
> + * event_trigger_separate_filter - separate an event trigger from a filter
> + * @param: The param string containing trigger and possibly filter
> + * @trigger: outparam, will be filled with a pointer to the trigger
> + * @filter: outparam, will be filled with a pointer to the filter
> + * @param_required: Specifies whether or not the param string is required
> + *
> + * Given a param string of the form '[trigger] [if filter]', this
> + * function separates the filter from the trigger and returns the
> + * trigger in *trigger and the filter in *filter.  Either the *trigger
> + * or the *filter may be set to NULL by this function - if not set to
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
> + *
> + * Return: 0 on success, errno otherwise
> + */
> +int event_trigger_separate_filter(char *param_and_filter, char **param,
> +				  char **filter, bool param_required)
> +{
> +	int ret = 0;
> +
> +	*param = *filter = NULL;
> +
> +	if (!param_and_filter) {
> +		if (param_required)
> +			ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Here we check for an optional param. The only legal
> +	 * optional param is :n, and if that's the case, continue
> +	 * below. Otherwise we assume what's left is a filter and
> +	 * return it as the filter string for the caller to deal with.
> +	 */
> +	if (!param_required && param_and_filter && !isdigit(param_and_filter[0])) {
> +		*filter = param_and_filter;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Separate the param from the filter (param [if filter]).
> +	 * Here we have either an optional :n param or a required
> +	 * param and an optional filter.
> +	 */
> +	*param = strsep(&param_and_filter, " \t");
> +	if (!*param) {
> +		ret = -EINVAL;

This seems not happen because this means "!param_and_filter" and
that is already checked at the entry of this function.

> +		goto out;
> +	}
> +
> +	/*
> +	 * Here we have a filter, though it may be empty.
> +	 */
> +	if (param_and_filter) {
> +		*filter = skip_spaces(param_and_filter);
> +		if (!**filter)
> +			*filter = NULL;
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

Does this mean trigger parameter?

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

Does this work with '!enable_event:sys:event:n' case?
(we need to find the last parameter.)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
