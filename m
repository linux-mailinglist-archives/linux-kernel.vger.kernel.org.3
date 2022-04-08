Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02894F9F0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiDHVUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiDHVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939821C1E73
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 046A561FAD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 21:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF43C385A5;
        Fri,  8 Apr 2022 21:18:10 +0000 (UTC)
Date:   Fri, 8 Apr 2022 17:18:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: make tp_printk work on syscall tracepoints
Message-ID: <20220408171808.762c5c8b@gandalf.local.home>
In-Reply-To: <20220329163931.710555-4-xiehuan09@gmail.com>
References: <20220329163931.710555-1-xiehuan09@gmail.com>
        <20220329163931.710555-4-xiehuan09@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 00:39:31 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

First, patch 1 and 2 can be folded into this patch. Making something
"available for future use" is not a reason to break up patches. It will not
help in bisecting, and its not something to be backported.

Next, the tracing subsystem follows the "Capitalize first letter" for
subjects:

 "tracing: Make tp_printk work on syscall tracepoints"

> Adding printk for syscall tracepoints for the tp_printk work.

Need to add much more content to the above. Your cover letter would work.

    Currently the tp_printk option has no effect on syscall tracepoint.
    When adding the kernel option parameter tp_printk, then:

    echo 1 > /sys/kernel/debug/tracing/events/syscalls/enable

    When running any application, no trace information is printed on the
    terminal.

    Now added printk for syscall tracepoints.

As commit logs should be self explanatory per commit. The cover letter was,
but this patch was lacking.


> 
> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> ---
>  kernel/trace/trace_syscalls.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index f755bde42fd0..9798122166d3 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -290,6 +290,25 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
>  	return ret;
>  }
>  
> +static void syscall_output_printk(struct trace_entry *ent,
> +		struct trace_event_file *trace_file, struct trace_array *tr)
> +{
> +	unsigned long flags;
> +	struct trace_iterator *iter = tracepoint_print_iter;
> +	struct trace_event *event = &trace_file->event_call->event;
> +
> +	spin_lock_irqsave(&tracepoint_iter_lock, flags);
> +
> +	trace_seq_init(&iter->seq);
> +	iter->ent = ent;
> +	iter->tr = tr;
> +	event->funcs->trace(iter, 0, event);
> +	trace_seq_putc(&iter->seq, 0);
> +	pr_info("%s", iter->seq.buffer);
> +
> +	spin_unlock_irqrestore(&tracepoint_iter_lock, flags);
> +}
> +
>  static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>  {
>  	struct trace_array *tr = data;
> @@ -333,6 +352,9 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>  	syscall_get_arguments(current, regs, args);
>  	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
>  
> +	if (static_key_false(&tracepoint_printk_key.key))
> +		syscall_output_printk(&entry->ent, trace_file, tr);
> +
>  	event_trigger_unlock_commit(trace_file, buffer, event, entry,
>  				    trace_ctx);


>  }
> @@ -376,6 +398,9 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
>  	entry->nr = syscall_nr;
>  	entry->ret = syscall_get_return_value(current, regs);
>  
> +	if (static_key_false(&tracepoint_printk_key.key))
> +		syscall_output_printk(&entry->ent, trace_file, tr);
> +

Instead of reimplementing the logic, just convert the syscall code to use,
trace_event_buffer_reserve() and trace_event_buffer_commit(), and then you
not only get tp_printk() for syscalls, but also other features as well.

-- Steve


>  	event_trigger_unlock_commit(trace_file, buffer, event, entry,
>  				    trace_ctx);
>  }

