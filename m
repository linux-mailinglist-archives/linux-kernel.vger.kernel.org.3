Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00A8470FE2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 02:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbhLKBgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 20:36:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45060 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhLKBgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 20:36:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C64A8B82A7E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 01:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A96C00446;
        Sat, 11 Dec 2021 01:32:41 +0000 (UTC)
Date:   Fri, 10 Dec 2021 20:32:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing: Account bottom half disabled sections.
Message-ID: <20211210203240.43a8e7eb@gandalf.local.home>
In-Reply-To: <YbO5H+H3dwLoIVka@linutronix.de>
References: <YbO5H+H3dwLoIVka@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 21:31:27 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Disabling only bottom halves via local_bh_disable() disables also
> preemption but this remains invisible to tracing. On a CONFIG_PREEMPT
> kernel one might wonder why there is no scheduling happening despite the
> N flag in the trace. The reason might be the a rcu_read_lock_bh()
> section.
> 
> Add a 'b' to the tracing output if in task context with disabled bottom
> halves.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/trace_events.h | 1 +
>  kernel/trace/trace.c         | 6 ++++--
>  kernel/trace/trace_output.c  | 3 +++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 2d167ac3452c5..a2af7e1156eac 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -172,6 +172,7 @@ enum trace_flag_type {
>  	TRACE_FLAG_SOFTIRQ		= 0x10,
>  	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
>  	TRACE_FLAG_NMI			= 0x40,
> +	TRACE_FLAG_BH_OFF		= 0x80,
>  };
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 88de94da596b1..dca48d556ee5a 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2601,6 +2601,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
>  		trace_flags |= TRACE_FLAG_HARDIRQ;
>  	if (in_serving_softirq())
>  		trace_flags |= TRACE_FLAG_SOFTIRQ;
> +	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
> +		trace_flags |= TRACE_FLAG_BH_OFF;
>  
>  	if (tif_need_resched())
>  		trace_flags |= TRACE_FLAG_NEED_RESCHED;
> @@ -4185,7 +4187,7 @@ static void print_lat_help_header(struct seq_file *m)
>  	seq_puts(m, "#                    _------=> CPU#            \n"
>  		    "#                   / _-----=> irqs-off        \n"
>  		    "#                  | / _----=> need-resched    \n"
> -		    "#                  || / _---=> hardirq/softirq \n"
> +		    "#                  || / _---=> hardirq/softirq/BH-disables\n"
>  		    "#                  ||| / _--=> preempt-depth   \n"
>  		    "#                  |||| / _-=> migrate-disable \n"
>  		    "#                  ||||| /     delay           \n"
> @@ -4226,7 +4228,7 @@ static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file
>  
>  	seq_printf(m, "#                            %.*s  _-----=> irqs-off\n", prec, space);
>  	seq_printf(m, "#                            %.*s / _----=> need-resched\n", prec, space);
> -	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq\n", prec, space);
> +	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq/BH-disabled\n", prec, space);

So I went to update the documentation on this, and realized that this is
wrong. Really, we want this in the irqs-off section probably.

Note, the above is to show we are running in a hardirq or softirq context.
But BH-disabled does not match that. Should this be with irqs-off being:

 d - irqs are disabled
 b - BH is disabled?
 D - irqs and BH is disabled?

-- Steve


>  	seq_printf(m, "#                            %.*s|| / _--=> preempt-depth\n", prec, space);
>  	seq_printf(m, "#                            %.*s||| / _-=> migrate-disable\n", prec, space);
>  	seq_printf(m, "#                            %.*s|||| /     delay\n", prec, space);
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 3547e7176ff79..6be644d35ec30 100644
