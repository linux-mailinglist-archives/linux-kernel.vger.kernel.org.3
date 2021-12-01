Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65014465944
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353629AbhLAWee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353610AbhLAWeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:34:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAB2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 14:30:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65EE0B82172
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 22:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53BCC53FCC;
        Wed,  1 Dec 2021 22:30:55 +0000 (UTC)
Date:   Wed, 1 Dec 2021 17:30:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] [RFC] tracing: Read and write to ring buffers
 with custom sub buffer size
Message-ID: <20211201173054.6e44d099@gandalf.local.home>
In-Reply-To: <20211125175253.186422-6-tz.stoyanov@gmail.com>
References: <20211125175253.186422-1-tz.stoyanov@gmail.com>
        <20211125175253.186422-6-tz.stoyanov@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 19:52:53 +0200
"Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 867a220b4ef2..5fcf5e9cba76 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2740,9 +2740,11 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
>  {
>  	struct ring_buffer_event *entry;
>  	struct trace_array *tr = trace_file->tr;
> +	int page_size;
>  	int val;
>  
>  	*current_rb = tr->array_buffer.buffer;
> +	page_size = ring_buffer_subbuf_size_get(*current_rb);
>  
>  	if (!tr->no_filter_buffering_ref &&
>  	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
> @@ -2764,7 +2766,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
>  		 * is still quicker than no copy on match, but having
>  		 * to discard out of the ring buffer on a failed match.
>  		 */
> -		int max_len = PAGE_SIZE - struct_size(entry, array, 1);
> +		int max_len = page_size - struct_size(entry, array, 1);

OK, so this is not part of the ring buffer, and is always going to be
PAGE_SIZE.

The temp buffer is allocated from trace_buffered_event_enable() which does:

	for_each_tracing_cpu(cpu) {
		page = alloc_pages_node(cpu_to_node(cpu),
					GFP_KERNEL | __GFP_NORETRY, 0);
		if (!page)
			goto failed;

		event = page_address(page);
		memset(event, 0, sizeof(*event));

		per_cpu(trace_buffered_event, cpu) = event;

		preempt_disable();
		if (cpu == smp_processor_id() &&
		    __this_cpu_read(trace_buffered_event) !=
		    per_cpu(trace_buffered_event, cpu))
			WARN_ON_ONCE(1);
		preempt_enable();
	}

That allocates one page per CPU to store as a temp buffer.

This must always be PAGE_SIZE.

-- Steve


>  
>  		val = this_cpu_inc_return(trace_buffered_event_cnt);
>  
> @@ -8004,6 +8006,8 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
>  {
>  	struct ftrace_buffer_info *info = filp->private_data;
>  	struct trace_iterator *iter = &info->iter;
> +	void *trace_data;
> +	int page_size;
>  	ssize_t ret = 0;
>  	ssize_t size;
>  
> @@ -8015,6 +8019,8 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
>  		return -EBUSY;
>  #endif
>  
> +	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
> +
>  	if (!info->spare) {
>  		info->spare = ring_buffer_alloc_read_page(iter->array_buffer->buffer,
>  							  iter->cpu_file);
> @@ -8029,13 +8035,13 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
>  		return ret;
>  
>  	/* Do we have previous read data to read? */
> -	if (info->read < PAGE_SIZE)
> +	if (info->read < page_size)
>  		goto read;
>  
>   again:
>  	trace_access_lock(iter->cpu_file);
>  	ret = ring_buffer_read_page(iter->array_buffer->buffer,
> -				    &info->spare,
> +				    info->spare,
>  				    count,
>  				    iter->cpu_file, 0);
>  	trace_access_unlock(iter->cpu_file);
> @@ -8056,11 +8062,11 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
>  
>  	info->read = 0;
>   read:
> -	size = PAGE_SIZE - info->read;
> +	size = page_size - info->read;
>  	if (size > count)
>  		size = count;
> -
> -	ret = copy_to_user(ubuf, info->spare + info->read, size);
> +	trace_data = ring_buffer_read_page_data(info->spare);
> +	ret = copy_to_user(ubuf, trace_data + info->read, size);
>  	if (ret == size)
>  		return -EFAULT;
>  
> @@ -8165,6 +8171,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  		.spd_release	= buffer_spd_release,
>  	};
>  	struct buffer_ref *ref;
> +	int page_size;
>  	int entries, i;
>  	ssize_t ret = 0;
>  
> @@ -8173,13 +8180,14 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  		return -EBUSY;
>  #endif
>  
> -	if (*ppos & (PAGE_SIZE - 1))
> +	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
> +	if (*ppos & (page_size - 1))
>  		return -EINVAL;
>  
> -	if (len & (PAGE_SIZE - 1)) {
> -		if (len < PAGE_SIZE)
> +	if (len & (page_size - 1)) {
> +		if (len < page_size)
>  			return -EINVAL;
> -		len &= PAGE_MASK;
> +		len &= (~(page_size - 1));
>  	}
>  
>  	if (splice_grow_spd(pipe, &spd))
> @@ -8189,7 +8197,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  	trace_access_lock(iter->cpu_file);
>  	entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
>  
> -	for (i = 0; i < spd.nr_pages_max && len && entries; i++, len -= PAGE_SIZE) {
> +	for (i = 0; i < spd.nr_pages_max && len && entries; i++, len -= page_size) {
>  		struct page *page;
>  		int r;
>  
> @@ -8210,7 +8218,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  		}
>  		ref->cpu = iter->cpu_file;
>  
> -		r = ring_buffer_read_page(ref->buffer, &ref->page,
> +		r = ring_buffer_read_page(ref->buffer, ref->page,
>  					  len, iter->cpu_file, 1);
>  		if (r < 0) {
>  			ring_buffer_free_read_page(ref->buffer, ref->cpu,
> @@ -8219,14 +8227,14 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  			break;
>  		}
>  
> -		page = virt_to_page(ref->page);
> +		page = virt_to_page(ring_buffer_read_page_data(ref->page));
>  
>  		spd.pages[i] = page;
> -		spd.partial[i].len = PAGE_SIZE;
> +		spd.partial[i].len = page_size;
>  		spd.partial[i].offset = 0;
>  		spd.partial[i].private = (unsigned long)ref;
>  		spd.nr_pages++;
> -		*ppos += PAGE_SIZE;
> +		*ppos += page_size;
>  
>  		entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
>  	}
