Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C013462BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhK3EmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhK3EmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:42:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E6EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 20:39:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D3036CE17DE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B07C53FC1;
        Tue, 30 Nov 2021 04:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638247137;
        bh=Bl65PJ9eC4lGhHxi4qfWi5h8s33X1+eFTvAGOwCX+Lk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CPXRb2VrWGwMWRLTdr1lerPRUpBExeFJLeG8WV52zAwXnbADOYrmb6/IjpF9qZhSD
         wTS/nS4e7xKl/9L02/t6Kakm6/jwbwx+irGxLrqOUm9/y+5asYrb+PDsNMobJlXX7y
         PypFEoX4vKIGBTkNtH/jQa/Q3kgcW1OeUMICTJBJEYU3wR64DYFUYu98DWJ4dUYjZR
         +ULsPUvTdE72bTlwiReLMw+YPNQAGc45HN5GCyUujvfUrAR3BRUhjyWGcQA9oyW5H4
         rL9uYJJHATv+ZvczRi4R9OB3RgFNQ49wONoVzvwrQK1uBsdwNNEpNo50IZYICs9imT
         x4g0Lpfps1x7A==
Date:   Tue, 30 Nov 2021 13:38:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 4/5] tracing/kprobes: Do not open code event reserve
 logic
Message-Id: <20211130133852.d32d55f73a3103c8941fa639@kernel.org>
In-Reply-To: <20211130024319.257430762@goodmis.org>
References: <20211130023945.789683928@goodmis.org>
        <20211130024319.257430762@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 21:39:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> As kprobe events use trace_event_buffer_commit() to commit the event to
> the ftrace ring buffer, for consistency, it should use
> trace_event_buffer_reserve() to allocate it, as the two functions are
> related.

OK, I got the rule.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, what should be used for trace_event_buffer_lock_reserve() as a pair call?

Thanks!

> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_kprobe.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 33272a7b6912..d10c01948e68 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1383,17 +1383,11 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
>  	if (trace_trigger_soft_disabled(trace_file))
>  		return;
>  
> -	fbuffer.trace_ctx = tracing_gen_ctx();
> -	fbuffer.trace_file = trace_file;
> -
>  	dsize = __get_data_size(&tk->tp, regs);
>  
> -	fbuffer.event =
> -		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
> -					call->event.type,
> -					sizeof(*entry) + tk->tp.size + dsize,
> -					fbuffer.trace_ctx);
> -	if (!fbuffer.event)
> +	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
> +					   sizeof(*entry) + tk->tp.size + dsize);
> +	if (!entry)
>  		return;
>  
>  	fbuffer.regs = regs;
> @@ -1430,16 +1424,11 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
>  	if (trace_trigger_soft_disabled(trace_file))
>  		return;
>  
> -	fbuffer.trace_ctx = tracing_gen_ctx();
> -	fbuffer.trace_file = trace_file;
> -
>  	dsize = __get_data_size(&tk->tp, regs);
> -	fbuffer.event =
> -		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
> -					call->event.type,
> -					sizeof(*entry) + tk->tp.size + dsize,
> -					fbuffer.trace_ctx);
> -	if (!fbuffer.event)
> +
> +	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
> +					   sizeof(*entry) + tk->tp.size + dsize);
> +	if (!entry)
>  		return;
>  
>  	fbuffer.regs = regs;
> -- 
> 2.33.0


-- 
Masami Hiramatsu <mhiramat@kernel.org>
