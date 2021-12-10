Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42261470324
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242424AbhLJOyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:54:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38962 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbhLJOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:54:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F955CE2B72;
        Fri, 10 Dec 2021 14:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1281DC00446;
        Fri, 10 Dec 2021 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639147873;
        bh=chBWh/Xd3Bt3/c17zjYLEg77CE7lBlfktiHYiBFYyu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E0946bzqlPP3PJN7nLMrO3GB3zgHibERcdeMt19HFw2H4UbsKeObRGpn1ccF8EgpX
         QxeJtIeAvm66cTsENJduadLGDWfJ+abqn9YKEmQIw7WIFl3qho6M8rJ/X8Ml+6E1g1
         FowB1veIPf7ya8ahcXdkUXp7RWcnqatTHOB66ulowqWXG4xJF1DIDpUFWe0V3tHG3h
         SUmp5Uupj+5wbUPQP1YTCaGAoQ3e7ILWxj97QmiRG5QJCxxB7zkcPgR2HVMG8LB6Gx
         X7ZTwTkzr+jWwHgdDQ8NXUS2oq5jXmYueNrPFOOiuj+uzEYhxSFWcfLgXiojliWYCd
         ntEpo2jbT9rXg==
Date:   Fri, 10 Dec 2021 23:51:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/13] user_events: Optimize writing events by only
 copying data once
Message-Id: <20211210235110.f674dd81e27bdedb231826a2@kernel.org>
In-Reply-To: <20211209223210.1818-10-beaub@linux.microsoft.com>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
        <20211209223210.1818-10-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beau,

On Thu,  9 Dec 2021 14:32:06 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Pass iterator through to probes to allow copying data directly to the
> probe buffers instead of taking multiple copies. Enables eBPF user and
> raw iterator types out to programs for no-copy scenarios.
> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  kernel/trace/trace_events_user.c | 102 ++++++++++++++++++++++---------
>  1 file changed, 74 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 807db0af74fb..1d29f6ec907d 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -41,6 +41,10 @@
>  #define MAX_FIELD_ARRAY_SIZE (2 * PAGE_SIZE)
>  #define MAX_FIELD_ARG_NAME 256
>  
> +#define MAX_BPF_COPY_SIZE PAGE_SIZE
> +#define MAX_STACK_BPF_DATA 512
> +#define copy_nofault copy_from_iter_nocache
> +
>  static char *register_page_data;
>  
>  static DEFINE_MUTEX(reg_mutex);
> @@ -78,8 +82,7 @@ struct user_event_refs {
>  	struct user_event *events[];
>  };
>  
> -typedef void (*user_event_func_t) (struct user_event *user,
> -				   void *data, u32 datalen,
> +typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
>  				   void *tpdata);
>  
>  static int user_event_parse(char *name, char *args, char *flags,
> @@ -515,7 +518,7 @@ static struct user_event *find_user_event(char *name, u32 *outkey)
>  /*
>   * Writes the user supplied payload out to a trace file.
>   */
> -static void user_event_ftrace(struct user_event *user, void *data, u32 datalen,
> +static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
>  			      void *tpdata)
>  {
>  	struct trace_event_file *file;
> @@ -531,41 +534,85 @@ static void user_event_ftrace(struct user_event *user, void *data, u32 datalen,
>  
>  	/* Allocates and fills trace_entry, + 1 of this is data payload */
>  	entry = trace_event_buffer_reserve(&event_buffer, file,
> -					   sizeof(*entry) + datalen);
> +					   sizeof(*entry) + i->count);
>  
>  	if (unlikely(!entry))
>  		return;
>  
> -	memcpy(entry + 1, data, datalen);
> +	if (unlikely(!copy_nofault(entry + 1, i->count, i))) {
> +		__trace_event_discard_commit(event_buffer.buffer,
> +					     event_buffer.event);
> +		return;
> +	}
>  
>  	trace_event_buffer_commit(&event_buffer);
>  }
>  
>  #ifdef CONFIG_PERF_EVENTS
> +static void user_event_bpf(struct user_event *user, struct iov_iter *i)
> +{
> +	struct user_bpf_context context;
> +	struct user_bpf_iter bpf_i;
> +	char fast_data[MAX_STACK_BPF_DATA];
> +	void *temp = NULL;
> +
> +	if ((user->flags & FLAG_BPF_ITER) && iter_is_iovec(i)) {
> +		/* Raw iterator */
> +		context.data_type = USER_BPF_DATA_ITER;
> +		context.data_len = i->count;
> +		context.iter = &bpf_i;
> +
> +		bpf_i.iov_offset = i->iov_offset;
> +		bpf_i.iov = i->iov;
> +		bpf_i.nr_segs = i->nr_segs;
> +	} else if (i->nr_segs == 1 && iter_is_iovec(i)) {
> +		/* Single buffer from user */
> +		context.data_type = USER_BPF_DATA_USER;
> +		context.data_len = i->count;
> +		context.udata = i->iov->iov_base + i->iov_offset;
> +	} else {
> +		/* Multi buffer from user */
> +		struct iov_iter copy = *i;
> +		size_t copy_size = min(i->count, (size_t)MAX_BPF_COPY_SIZE);
> +
> +		context.data_type = USER_BPF_DATA_KERNEL;
> +		context.kdata = fast_data;
> +
> +		if (unlikely(copy_size > sizeof(fast_data))) {
> +			temp = kmalloc(copy_size, GFP_NOWAIT);
> +
> +			if (temp)
> +				context.kdata = temp;
> +			else
> +				copy_size = sizeof(fast_data);
> +		}
> +
> +		context.data_len = copy_nofault(context.kdata,
> +						copy_size, &copy);
> +	}
> +
> +	trace_call_bpf(&user->call, &context);
> +
> +	kfree(temp);
> +}
> +
>  /*
>   * Writes the user supplied payload out to perf ring buffer or eBPF program.
>   */
> -static void user_event_perf(struct user_event *user, void *data, u32 datalen,
> +static void user_event_perf(struct user_event *user, struct iov_iter *i,
>  			    void *tpdata)
>  {
>  	struct hlist_head *perf_head;
>  
> -	if (bpf_prog_array_valid(&user->call)) {
> -		struct user_bpf_context context = {0};
> -
> -		context.data_len = datalen;
> -		context.data_type = USER_BPF_DATA_KERNEL;
> -		context.kdata = data;
> -
> -		trace_call_bpf(&user->call, &context);
> -	}
> +	if (bpf_prog_array_valid(&user->call))
> +		user_event_bpf(user, i);
>  
>  	perf_head = this_cpu_ptr(user->call.perf_events);
>  
>  	if (perf_head && !hlist_empty(perf_head)) {
>  		struct trace_entry *perf_entry;
>  		struct pt_regs *regs;
> -		size_t size = sizeof(*perf_entry) + datalen;
> +		size_t size = sizeof(*perf_entry) + i->count;
>  		int context;
>  
>  		perf_entry = perf_trace_buf_alloc(ALIGN(size, 8),
> @@ -576,7 +623,10 @@ static void user_event_perf(struct user_event *user, void *data, u32 datalen,
>  
>  		perf_fetch_caller_regs(regs);
>  
> -		memcpy(perf_entry + 1, data, datalen);
> +		if (unlikely(!copy_nofault(perf_entry + 1, i->count, i))) {
> +			perf_swevent_put_recursion_context(context);
> +			return;
> +		}
>  
>  		perf_trace_buf_submit(perf_entry, size, context,
>  				      user->call.event.type, 1, regs,
> @@ -1009,32 +1059,28 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
>  	if (likely(atomic_read(&tp->key.enabled) > 0)) {
>  		struct tracepoint_func *probe_func_ptr;
>  		user_event_func_t probe_func;
> +		struct iov_iter copy;
>  		void *tpdata;
> -		void *kdata;
> -		u32 datalen;
>  
> -		kdata = kmalloc(i->count, GFP_KERNEL);
> -
> -		if (unlikely(!kdata))
> -			return -ENOMEM;
> -
> -		datalen = copy_from_iter(kdata, i->count, i);
> +		if (unlikely(iov_iter_fault_in_readable(i, i->count)))
> +			return -EFAULT;
>  
>  		rcu_read_lock_sched();
> +		pagefault_disable();

Since the pagefault_disable() may have unexpected side effect,
I think it should be used really limited area, e.g. around
actual memory access function.
Can we move this around the copy_nofault()?

Thank you,
>  
>  		probe_func_ptr = rcu_dereference_sched(tp->funcs);
>  
>  		if (probe_func_ptr) {
>  			do {
> +				copy = *i;
>  				probe_func = probe_func_ptr->func;
>  				tpdata = probe_func_ptr->data;
> -				probe_func(user, kdata, datalen, tpdata);
> +				probe_func(user, &copy, tpdata);
>  			} while ((++probe_func_ptr)->func);
>  		}
>  
> +		pagefault_enable();
>  		rcu_read_unlock_sched();
> -
> -		kfree(kdata);
>  	}
>  
>  	return ret;
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
