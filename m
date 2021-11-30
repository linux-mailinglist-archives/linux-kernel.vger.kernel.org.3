Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66967462BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbhK3EoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:44:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41800 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhK3EoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:44:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3836B81696
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4633DC53FC1;
        Tue, 30 Nov 2021 04:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638247257;
        bh=OBE0b8QgbIdghOY9t72iqEJYQ3j6V6Eey09D6sXt1WI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cq4cj+gZSEtPll4kM9/txQGEJbc5mM9e+NTKSC/VMrZBcdRAwKRWsmpnQKoEtyIEA
         8HttajEoajV4dq3o2NPRIw2yuaGfhMQQKt0Gna18dz91G2f8ptH+uDkfVJSNGXipPp
         vvMOxefCwABy4b0tujtLEyHiXU54h7UY329bq1eTPcGu1O292zrNvp7hMVzLfEYBJv
         y9dKmNq211CY20JkA+IIKtwu8VAgEYc9gVQ85gd7uNHP8mPma36qZTl97eyP/99Ga/
         +CPZ1oiL1VQncix+klr085JQ5hOGJaPpvY+O7TCuUAVys7iMldY0AUpXPs801MW+5e
         MaGfQ9PtAN77w==
Date:   Tue, 30 Nov 2021 13:40:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 5/5] tracing/uprobes: Use trace_event_buffer_reserve()
 helper
Message-Id: <20211130134053.4115f0d97c683a1b021c1833@kernel.org>
In-Reply-To: <20211130024319.439953082@goodmis.org>
References: <20211130023945.789683928@goodmis.org>
        <20211130024319.439953082@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 21:39:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> To be consistent with kprobes and eprobes, use
> trace_event_buffer_reserver() and trace_event_buffer_commit(). This will
> ensure that any updates to trace events will also be implemented on uprobe
> events.
> 

Ah, event_trigger_unlock_commit() is the pair commit function. I got it.
Anyway, the pair of trace_event_buffer_reserve() and trace_event_buffer_commit()
should be used.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_uprobe.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index f5f0039d31e5..177717c4e74a 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -949,8 +949,8 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
>  				struct trace_event_file *trace_file)
>  {
>  	struct uprobe_trace_entry_head *entry;
> +	struct trace_event_buffer fbuffer;
>  	struct trace_buffer *buffer;
> -	struct ring_buffer_event *event;
>  	void *data;
>  	int size, esize;
>  	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
> @@ -965,12 +965,10 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
>  
>  	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
>  	size = esize + tu->tp.size + dsize;
> -	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
> -						call->event.type, size, 0);
> -	if (!event)
> +	entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
> +	if (!entry)
>  		return;
>  
> -	entry = ring_buffer_event_data(event);
>  	if (is_ret_probe(tu)) {
>  		entry->vaddr[0] = func;
>  		entry->vaddr[1] = instruction_pointer(regs);
> @@ -982,7 +980,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
>  
>  	memcpy(data, ucb->buf, tu->tp.size + dsize);
>  
> -	event_trigger_unlock_commit(trace_file, buffer, event, entry, 0);
> +	trace_event_buffer_commit(&fbuffer);
>  }
>  
>  /* uprobe handler */
> -- 
> 2.33.0


-- 
Masami Hiramatsu <mhiramat@kernel.org>
