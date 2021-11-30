Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED1E464040
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbhK3Vej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:34:39 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56518 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhK3Vef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:34:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E68DCE1C63
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCBDC53FCC;
        Tue, 30 Nov 2021 21:31:12 +0000 (UTC)
Date:   Tue, 30 Nov 2021 16:31:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] tracing: Have existing event_command
 implementations use helpers
Message-ID: <20211130163110.492a0df3@gandalf.local.home>
In-Reply-To: <2b451d62e0b1a12fc99391dfdda9be2d8e9ca499.1637700535.git.zanussi@kernel.org>
References: <cover.1637700535.git.zanussi@kernel.org>
        <2b451d62e0b1a12fc99391dfdda9be2d8e9ca499.1637700535.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 14:53:54 -0600
Tom Zanussi <zanussi@kernel.org> wrote:


> index a873f4e8be04..1d1716d5bee2 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -931,89 +931,47 @@ event_trigger_callback(struct event_command *cmd_ops,
>  	struct event_trigger_data *trigger_data;
>  	struct event_trigger_ops *trigger_ops;
>  	char *trigger = NULL;
> -	char *number;
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
> +	ret = event_trigger_separate_filter(&trigger, &param, false);
> +	if (ret)
> +		return ret;
>  
>  	ret = -ENOMEM;
> -	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
> +	trigger_data = event_trigger_alloc(cmd_ops, cmd, trigger, file);
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
> -		kfree(trigger_data);

How is trigger_data freed on error here?

-- Steve

>  		ret = 0;
>  		goto out;
>  	}
>  
> -	if (trigger) {
> -		number = strsep(&trigger, ":");
> -
> -		ret = -EINVAL;
> -		if (!strlen(number))
> -			goto out_free;
> -
> -		/*
> -		 * We use the callback data field (which is a pointer)
> -		 * as our counter.
> -		 */
> -		ret = kstrtoul(number, 0, &trigger_data->count);
> -		if (ret)
> -			goto out_free;
> -	}
> -
> -	if (!param) /* if param is non-empty, it's supposed to be a filter */
> -		goto out_reg;
> -
> -	if (!cmd_ops->set_filter)
> -		goto out_reg;
> +	ret = event_trigger_parse_num(trigger, trigger_data);
> +	if (ret)
> +		goto out_free;
>  
> -	ret = cmd_ops->set_filter(param, trigger_data, file);
> +	ret = event_trigger_set_filter(cmd_ops, file, param, trigger_data);
>  	if (ret < 0)
>  		goto out_free;
>  
> - out_reg:
>  	/* Up the trigger_data count to make sure reg doesn't free it on failure */
>  	event_trigger_init(trigger_ops, trigger_data);
> -	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> -	/*
> -	 * The above returns on success the # of functions enabled,
> -	 * but if it didn't find any functions it returns zero.
> -	 * Consider no functions a failure too.
> -	 */
> -	if (!ret) {
> -		cmd_ops->unreg(glob, trigger_ops, trigger_data, file);
> -		ret = -ENOENT;
> -	} else if (ret > 0)
> -		ret = 0;
> +
> +	ret = event_trigger_register(cmd_ops, file, glob, cmd, trigger, trigger_data, NULL);
> +	if (ret)
> +		goto out_free;
>  
>  	/* Down the counter of trigger_data or free it if not used anymore */
>  	event_trigger_free(trigger_ops, trigger_data);
>   out:
>  	return ret;
> -
>   out_free:
> -	if (cmd_ops->set_filter)
> -		cmd_ops->set_filter(NULL, trigger_data, NULL);
> +	event_trigger_reset_filter(cmd_ops, trigger_data);
>  	kfree(trigger_data);
>  	goto out;
>  }
> 
