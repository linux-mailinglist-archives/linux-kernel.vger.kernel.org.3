Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1345647CDB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbhLVHzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:55:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34796 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243081AbhLVHzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:55:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94DABB81A5F;
        Wed, 22 Dec 2021 07:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB812C36AE5;
        Wed, 22 Dec 2021 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640159716;
        bh=PcyMfPm8L3SEgEPVRJGQxYDpD26Sf6GBRQUZgl/SWMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=prI0au14tTuT7qGIvQYDaEa79XEBkCYFlrafkrgnKa0wIXQda9jF3dHMVa430UB62
         DPaCXQhGM4rRaqkNM0JDVx/Ds7YvckKpYOn6a+ynTglBNq7IAJ5Z2Mk++9mt3D/b4e
         97fJASrpk5h72WhyiCZ0u9y8NoNLSlAhFdV5HjUkVM0DY8bM+1guuuVjdzumt7eyyN
         2etDzDMvN05uB6sSa8UjeC04O56KDNpsvgfqPd7AyULVgS+cAiCD36InD+g2CpIgA2
         etQmQonSxGW/VonBAxDYuZ3b3TKityp3wvrqMKNihu+4D+zY8NHDlebuO5iAtPLr1w
         uGIwqctHbdxmA==
Date:   Wed, 22 Dec 2021 16:55:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/12] user_events: Add basic perf and eBPF support
Message-Id: <20211222165512.616e5af0c39f5461c3ee693b@kernel.org>
In-Reply-To: <20211216173511.10390-5-beaub@linux.microsoft.com>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
        <20211216173511.10390-5-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 09:35:03 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Adds support to write out user_event data to perf_probe/perf files as
> well as to any attached eBPF program.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  kernel/trace/trace_events_user.c | 72 +++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 9859e62b9838..cc30d1fcbb63 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -550,6 +550,50 @@ static void user_event_ftrace(struct user_event *user, void *data, u32 datalen,
>  	trace_event_buffer_commit(&event_buffer);
>  }
>  
> +#ifdef CONFIG_PERF_EVENTS
> +/*
> + * Writes the user supplied payload out to perf ring buffer or eBPF program.
> + */
> +static void user_event_perf(struct user_event *user, void *data, u32 datalen,
> +			    void *tpdata)
> +{
> +	struct hlist_head *perf_head;
> +
> +	if (bpf_prog_array_valid(&user->call)) {
> +		struct user_bpf_context context = {0};
> +
> +		context.data_len = datalen;
> +		context.data_type = USER_BPF_DATA_KERNEL;
> +		context.kdata = data;
> +
> +		trace_call_bpf(&user->call, &context);
> +	}
> +
> +	perf_head = this_cpu_ptr(user->call.perf_events);
> +
> +	if (perf_head && !hlist_empty(perf_head)) {
> +		struct trace_entry *perf_entry;
> +		struct pt_regs *regs;
> +		size_t size = sizeof(*perf_entry) + datalen;
> +		int context;
> +
> +		perf_entry = perf_trace_buf_alloc(ALIGN(size, 8),
> +						  &regs, &context);
> +
> +		if (unlikely(!perf_entry))
> +			return;
> +
> +		perf_fetch_caller_regs(regs);
> +
> +		memcpy(perf_entry + 1, data, datalen);
> +
> +		perf_trace_buf_submit(perf_entry, size, context,
> +				      user->call.event.type, 1, regs,
> +				      perf_head, NULL);
> +	}
> +}
> +#endif
> +
>  /*
>   * Update the register page that is shared between user processes.
>   */
> @@ -572,6 +616,10 @@ static void update_reg_page_for(struct user_event *user)
>  
>  				if (probe_func == user_event_ftrace)
>  					status |= EVENT_STATUS_FTRACE;
> +#ifdef CONFIG_PERF_EVENTS
> +				else if (probe_func == user_event_perf)
> +					status |= EVENT_STATUS_PERF;
> +#endif
>  				else
>  					status |= EVENT_STATUS_OTHER;
>  			} while ((++probe_func_ptr)->func);
> @@ -611,8 +659,27 @@ static int user_event_reg(struct trace_event_call *call,
>  					    data);
>  		goto dec;
>  
> -	default:
> +#ifdef CONFIG_PERF_EVENTS
> +	case TRACE_REG_PERF_REGISTER:
> +		ret = tracepoint_probe_register(call->tp,
> +						call->class->perf_probe,
> +						data);
> +		if (!ret)
> +			goto inc;
> +		break;
> +
> +	case TRACE_REG_PERF_UNREGISTER:
> +		tracepoint_probe_unregister(call->tp,
> +					    call->class->perf_probe,
> +					    data);
> +		goto dec;
> +
> +	case TRACE_REG_PERF_OPEN:
> +	case TRACE_REG_PERF_CLOSE:
> +	case TRACE_REG_PERF_ADD:
> +	case TRACE_REG_PERF_DEL:
>  		break;
> +#endif
>  	}
>  
>  	return ret;
> @@ -864,6 +931,9 @@ static int user_event_parse(char *name, char *args, char *flags,
>  	user->class.get_fields = user_event_get_fields;
>  	user->class.reg = user_event_reg;
>  	user->class.probe = user_event_ftrace;
> +#ifdef CONFIG_PERF_EVENTS
> +	user->class.perf_probe = user_event_perf;
> +#endif
>  
>  	mutex_lock(&event_mutex);
>  	ret = user_event_trace_register(user);
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
