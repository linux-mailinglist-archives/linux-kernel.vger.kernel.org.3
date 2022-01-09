Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5523E48871B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 01:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiAIAyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 19:54:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54474 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiAIAyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 19:54:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C308B8095C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 00:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23081C36AE9;
        Sun,  9 Jan 2022 00:54:08 +0000 (UTC)
Date:   Sat, 8 Jan 2022 19:54:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] tracing: Have existing event_command.parse()
 implementations use helpers
Message-ID: <20220108195406.0c4f659d@gandalf.local.home>
In-Reply-To: <f043571a0b7ccc0eb524f87b63c520a460e59baf.1639507505.git.zanussi@kernel.org>
References: <cover.1639507505.git.zanussi@kernel.org>
        <f043571a0b7ccc0eb524f87b63c520a460e59baf.1639507505.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 12:57:32 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> index da103826f27e..e6a48e8c79eb 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -973,7 +973,7 @@ int event_trigger_register(struct event_command *cmd_ops,
>   * @file: The trace_event_file associated with the event
>   * @glob: The raw string used to register the trigger
>   * @cmd: The cmd portion of the string used to register the trigger
> - * @param: The params portion of the string used to register the trigger
> + * @param_and_filter: The param and filter portion of the string used to register the trigger
>   *
>   * Common implementation for event command parsing and trigger
>   * instantiation.
> @@ -986,94 +986,53 @@ int event_trigger_register(struct event_command *cmd_ops,
>  static int
>  event_trigger_parse(struct event_command *cmd_ops,
>  		    struct trace_event_file *file,
> -		    char *glob, char *cmd, char *param)
> +		    char *glob, char *cmd, char *param_and_filter)
>  {
>  	struct event_trigger_data *trigger_data;
>  	struct event_trigger_ops *trigger_ops;
> -	char *trigger = NULL;
> -	char *number;
> +	char *param, *filter;
> +	bool remove;
>  	int ret;
>  
> -	/* separate the trigger from the filter (t:n [if filter]) */
> -	if (param && isdigit(param[0])) {
> -		trigger = strsep(&param, " \t");
> -		if (param) {
> -			param = skip_spaces(param);
> -			if (!*param)
> -				param = NULL;
> -		}
> -	}
> +	remove = event_trigger_check_remove(glob);
>  
> -	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);

Did you mean to remove the assignment of trigger_ops here?

> +	ret = event_trigger_separate_filter(param_and_filter, &param, &filter, false);
> +	if (ret)
> +		return ret;
>  
>  	ret = -ENOMEM;
> -	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
> +	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, file);
>  	if (!trigger_data)
>  		goto out;
>  
> -	trigger_data->count = -1;
> -	trigger_data->ops = trigger_ops;
> -	trigger_data->cmd_ops = cmd_ops;
> -	trigger_data->private_data = file;
> -	INIT_LIST_HEAD(&trigger_data->list);
> -	INIT_LIST_HEAD(&trigger_data->named_list);
> -
> -	if (glob[0] == '!') {
> +	if (remove) {
>  		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);

It's still used here and below.

I get a warning on this.

Thanks,

-- Steve

>  		kfree(trigger_data);
