Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0086473349
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbhLMR6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:58:23 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45956 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbhLMR6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:58:20 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4240D20B7179;
        Mon, 13 Dec 2021 09:58:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4240D20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639418300;
        bh=r9WlcxTL4YZZ9U3VZb2UJStcUmXB1O9oL3PmHpSJEU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMrQwW/5gn7q5tGspQpVuYydFQ+E0Xj2uZWMydNkUgKwFrGJ2nlk636T88P+o9kih
         mb1T6ymemqyiE6bFaOv1Yggz1ViGEKxehdwj/+qPtcGQNUnfdHOkx20kv8u1uSx9eV
         ehPFHEziMQdPcpgWARSeD72G9tTNn2H07Pb1xBKg=
Date:   Mon, 13 Dec 2021 09:58:14 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211213175814.GA10270@kbox>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
 <20211209223210.1818-3-beaub@linux.microsoft.com>
 <20211210194358.e590d49a1620df7345f9f679@kernel.org>
 <20211210180354.GB2131@kbox>
 <20211213132439.5c23b44fde761cbcb1369584@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213132439.5c23b44fde761cbcb1369584@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 01:24:39PM +0900, Masami Hiramatsu wrote:
> Hi Beau,
> 
> On Fri, 10 Dec 2021 10:03:54 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > On Fri, Dec 10, 2021 at 07:43:58PM +0900, Masami Hiramatsu wrote:
> > > Hi Beau,
> > > 
> > > Thanks for updating the patch! I have some comments below.
> > > 
> > > On Thu,  9 Dec 2021 14:31:59 -0800
> > > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > > 
> > > [..]
> > > > +#define USER_EVENTS_PREFIX_LEN (sizeof(USER_EVENTS_PREFIX)-1)
> > > > +
> > > > +#define FIELD_DEPTH_TYPE 0
> > > > +#define FIELD_DEPTH_NAME 1
> > > > +#define FIELD_DEPTH_SIZE 2
> > > > +
> > > > +/*
> > > > + * Limits how many trace_event calls user processes can create:
> > > > + * Must be multiple of PAGE_SIZE.
> > > > + */
> > > > +#define MAX_PAGES 1
> > > > +#define MAX_EVENTS (MAX_PAGES * PAGE_SIZE)
> > > > +
> > > > +/* Limit how long of an event name plus args within the subsystem. */
> > > > +#define MAX_EVENT_DESC 512
> > > > +#define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
> > > > +#define MAX_FIELD_ARRAY_SIZE (2 * PAGE_SIZE)
> > > 
> > > I don't recommend to record the event which size is more than a page size...
> > > Maybe 256 entries?
> > > It is also better to limit the total size of the event and the number
> > > of fields (arguments).
> > > 
> > > Steve, can we write such a big event data on the trace buffer?
> > > 
> > 
> > This moved to 1024 in part 12 when validation was added.
> 
> OK, then it should be done in this patch.
> 

Sure thing.

> BTW, real maximum limitation is defined in the kernel/trace/ring_buffer.c
> (I'm not sure why this is not defined in the header...)
> 
> -----
> #define BUF_PAGE_SIZE (PAGE_SIZE - BUF_PAGE_HDR_SIZE)
> 
> /* Max payload is BUF_PAGE_SIZE - header (8bytes) */
> #define BUF_MAX_DATA_SIZE (BUF_PAGE_SIZE - (sizeof(u32) * 2))
> -----
> 
> > 
> > > [..]
> > > > +
> > > > +static int user_field_array_size(const char *type)
> > > > +{
> > > > +	const char *start = strchr(type, '[');
> > > > +	char val[8];
> > > > +	int size = 0;
> > > > +
> > > > +	if (start == NULL)
> > > > +		return -EINVAL;
> > > > +
> > > > +	start++;
> > > > +
> > > > +	while (*start != ']' && size < (sizeof(val) - 1))
> > > > +		val[size++] = *start++;
> > > > +
> > > > +	if (*start != ']')
> > > > +		return -EINVAL;
> > > > +
> > > > +	val[size] = 0;
> > > 
> > > It's '\0', not 0.
> > 
> > Both evaluate to 0, is this a style thing?
> > 
> > For example, argv_split does this same thing ;)
> 
> 
> Oops, OK. That is the style thing for clarify what you are doing.
> (not initializing the element, but terminating the string)
> 

Ok, I've moved it to '\0' to show intention.

> > > 
> > > If I were you, I just use strlcpy(val, start, sizeof(val)), and
> > > strchr(val, ']'). Sometimes using standard libc function will
> > > be easer to understand what it does. :)
> > > 
> > 
> > Sure good idea.
> > 
> > [..]
> > 
> > > > +static int user_event_add_field(struct user_event *user, const char *type,
> > > > +				const char *name, int offset, int size,
> > > > +				int is_signed, int filter_type)
> > > > +{
> > > > +	struct ftrace_event_field *field;
> > > > +
> > > > +	field = kmalloc(sizeof(*field), GFP_KERNEL);
> > > > +
> > > > +	if (!field)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	field->type = type;
> > > > +	field->name = name;
> > > > +	field->offset = offset;
> > > > +	field->size = size;
> > > > +	field->is_signed = is_signed;
> > > > +	field->filter_type = filter_type;
> > > > +
> > > > +	list_add(&field->link, &user->fields);
> > > 
> > > I recommend to use list_add_tail() here so that when accessing the
> > > list of field without reverse order. (I found this in [4/13])
> > > 
> > 
> > If I did that, wouldn't that mean the format file in tracefs now has the
> > arguments printed in reverse order they were added?
> 
> Ah, sorry. It was my misunderstanding. I found that the trace_event
> expects the fields are chained in the reverse order.
> (e.g. trace_event_get_offsets())
> 
> BTW, I think the current implementation is confusing. For example,
> trace_event_get_offsets() needs a redundant explanation;
> ---
>         /*
>          * head->next points to the last field with the largest offset,
>          * since it was added last by trace_define_field()
>          */
>         tail = list_first_entry(head, struct ftrace_event_field, link);
> ---
> If the list is sorted in normal order, it doesn't need
> such explanation, just do "tail = list_last_entry(...)"
> 
> > 
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Parses the values of a field within the description
> > > > + * Format: type name [size]
> > > 
> > > Hmm, don't you accept redundant spaces and tabs?
> > > If this accepts the redundant spaces/tabs, I recommend you to use
> > > argv_split() instead of strpbrk() etc. e.g.
> > > 
> > > 	int argc, name_idx = 0, size;
> > > 	int ret = -EINVAL;
> > > 	char **argv;
> > > 
> > > 	argv = argv_split(GFP_KERNEL, field, &argc);
> > > 	if (!argv)
> > > 		return -ENOMEM;
> > > 
> > > 	if (!strcmp(argv[pos], "__data_loc") ||
> > > 	    !strcmp(argv[pos], "__rel_loc")) {
> > > 		if (++pos >= argc)
> > > 			goto error;
> > > 	}
> > > 	if (!strcmp(argv[pos], "unsigned")) {
> > > 		if (++pos >= argc)
> > > 			goto error;
> > > 	} else if (!strcmp(argv[pos], "struct")) {
> > > 		is_struct = true;
> > > 		if (++pos >= argc)
> > > 			goto error;
> > > 	}
> > > 	if (++pos >= argc)
> > > 		goto error;
> > > 	name_idx = pos++;
> > > 	if (pos < argc) {	// size
> > > 		if (!is_struct)
> > > 			goto error;
> > > 		if (kstrtou32(argv[pos++], 10, &size))
> > > 			goto error;
> > > 	} else
> > > 		size = user_field_size(argv[name_idx - 1]);
> > > 
> > > 	if (pos != argc)
> > > 		goto error;
> > > 	
> > > 	// note that type index is always 0 and size must be converted.
> > > 	user_event_add_field(user, argv, name_idx, saved_offset, size,
> > > 				    type[0] != 'u', FILTER_OTHER);
> > > 
> > > 	ret = 0;
> > > error:
> > > 	argv_free(argv);
> > > 	return ret;
> > > 
> > > (This also requires to simplify user_field_size() and remove FIELD_DEPTH_*)
> > > What would you think?
> > > 	
> > 
> > The code currently does not support duplicate spaces after the first
> > non-whitespace.
> > 
> > We do copy the string before this, so how this is written would do a
> > double allocation. If the argv_split was moved higher in the callchain
> > then I could move to this.
> 
> If it works and simplifies, I'm OK. But I thought the syntax required to
> split a user string by ';' at first, and split each field by spaces. So I
> put the argv_split() here. And anyway, this is not a hot path. I think
> avoiding allocation is not such a big matter.
> 

I'd prefer to get this set of patches in somewhere before reworking
large amounts of it if possible.

It seems like a good idea to have a general way of getting a dyn_event
string parsed out into trace_event fields. That way all parsing components
have the same behaviors, etc.

The proposed approach simplifies some things and makes other things more
complex. For example, if a type is '__data_loc unsigned char[]' there are
now 3 pointers: '__data_loc', 'unsigned' and 'char[]'.

This makes it so I can no longer just point the trace_event's field to
the string, I now need in those cases to join them back up. And because
they aren't from the original pointer, I need to now track which
pointers need to be freed when freeing each field (unless all are always
copied, which feels wasteful).

I'm not worried so much about allocation time, since this is not a hot
path (but it is under a global lock). I took the fact that trace_event
allocates fields internally out of a cache to mean that someone at
sometime did care about either allocation time or fragmentation.

As the patch stands now, there is only a single allocation, all types,
names, etc on the fields are close together in memory for each event.
While this is not required, it is a nice attribute of this approach vs
alloc everything into it's own block (that may or may not be close).

> > 
> > If you feel strongly about this, I don't have a problem moving to this
> > pattern. Let me know if you feel strongly about it.
> 
> I just hope to support duplicate spaces/tabs, since I guess that
> users may want to write the field definition with indentation.
> 
> (Recently I hit a similar issue on another software. No one duplicates
> visible separators, but spaces/tabs. :( )
> 
>  

I get that, I think it would be great if there was a general way to
parse things. That way systems that utilize dyn_event have consistent
behavior across them. Several comments in this series have been around
this area, to the point that it would save the next person a lot of time
if a common mechanism existed for parsing and type sizes, etc.

> > > > +
> > > > +/*
> > > > + * Register callback for our events from tracing sub-systems.
> > > > + */
> > > > +static int user_event_reg(struct trace_event_call *call,
> > > > +			  enum trace_reg type,
> > > > +			  void *data)
> > > > +{
> > > > +	struct user_event *user = (struct user_event *)call->data;
> > > > +	int ret = 0;
> > > > +
> > > > +	if (!user)
> > > > +		return -ENOENT;
> > > > +
> > > > +	switch (type) {
> > > > +	case TRACE_REG_REGISTER:
> > > > +		ret = tracepoint_probe_register(call->tp,
> > > > +						call->class->probe,
> > > > +						data);
> > > > +		if (!ret)
> > > > +			goto inc;
> > > > +		break;
> > > > +
> > > > +	case TRACE_REG_UNREGISTER:
> > > > +		tracepoint_probe_unregister(call->tp,
> > > > +					    call->class->probe,
> > > > +					    data);
> > > > +		goto dec;
> > > > +
> > > > +#ifdef CONFIG_PERF_EVENTS
> > > > +	case TRACE_REG_PERF_REGISTER:
> > > > +	case TRACE_REG_PERF_UNREGISTER:
> > > > +	case TRACE_REG_PERF_OPEN:
> > > > +	case TRACE_REG_PERF_CLOSE:
> > > > +	case TRACE_REG_PERF_ADD:
> > > > +	case TRACE_REG_PERF_DEL:
> > > > +		break;
> > > > +#endif
> > > 
> > > At this moment (in this patch), you can just add a default case,
> > > or just ignore it, because it does nothing.
> > > 
> > 
> > Yeah, I was trying to avoid the warning that resulted if I just ignored
> > them.
> 
> Ah, then that's OK.
> 
> > 
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > +inc:
> > > > +	atomic_inc(&user->refcnt);
> > > > +	update_reg_page_for(user);
> > > > +	return 0;
> > > > +dec:
> > > > +	update_reg_page_for(user);
> > > > +	atomic_dec(&user->refcnt);
> > > > +	return 0;
> > > > +}
> > > > +
> > > 
> > > [..]
> > > > +/*
> > > > + * Validates the user payload and writes via iterator.
> > > > + */
> > > > +static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
> > > > +{
> > > > +	struct user_event_refs *refs;
> > > > +	struct user_event *user = NULL;
> > > > +	struct tracepoint *tp;
> > > > +	ssize_t ret = i->count;
> > > > +	int idx;
> > > > +
> > > > +	if (unlikely(copy_from_iter(&idx, sizeof(idx), i) != sizeof(idx)))
> > > > +		return -EFAULT;
> > > > +
> > > > +	rcu_read_lock_sched();
> > > > +
> > > > +	refs = rcu_dereference_sched(file->private_data);
> > > > +
> > > > +	/*
> > > > +	 * The refs->events array is protected by RCU, and new items may be
> > > > +	 * added. But the user retrieved from indexing into the events array
> > > > +	 * shall be immutable while the file is opened.
> > > > +	 */
> > > > +	if (likely(refs && idx < refs->count))
> > > > +		user = refs->events[idx];
> > > > +
> > > > +	rcu_read_unlock_sched();
> > > > +
> > > > +	if (unlikely(user == NULL))
> > > > +		return -ENOENT;
> > > > +
> > > > +	tp = &user->tracepoint;
> > > > +
> > > > +	/*
> > > > +	 * It's possible key.enabled disables after this check, however
> > > > +	 * we don't mind if a few events are included in this condition.
> > > > +	 */
> > > > +	if (likely(atomic_read(&tp->key.enabled) > 0)) {
> > > > +		struct tracepoint_func *probe_func_ptr;
> > > > +		user_event_func_t probe_func;
> > > > +		void *tpdata;
> > > > +		void *kdata;
> > > > +		u32 datalen;
> > > > +
> > > > +		kdata = kmalloc(i->count, GFP_KERNEL);
> > > > +
> > > > +		if (unlikely(!kdata))
> > > > +			return -ENOMEM;
> > > > +
> > > > +		datalen = copy_from_iter(kdata, i->count, i);
> > > 
> > > Don't we need to add this datalen to ret?
> > > 
> > 
> > ret is set to the bytes that were given by the user to avoid multiple
> > writes from occuring for the same data if the data was paged out (or if
> > the event isn't enabled at that time for whatever reason).
> > 
> > Since seek/partial writes are not supported, I don't believe we want to
> > do that.
> 
> OK, got it.
> 
> Thank you,
> 
> > 
> > > > +
> > > > +		rcu_read_lock_sched();
> > > > +
> > > > +		probe_func_ptr = rcu_dereference_sched(tp->funcs);
> > > > +
> > > > +		if (probe_func_ptr) {
> > > > +			do {
> > > > +				probe_func = probe_func_ptr->func;
> > > > +				tpdata = probe_func_ptr->data;
> > > > +				probe_func(user, kdata, datalen, tpdata);
> > > > +			} while ((++probe_func_ptr)->func);
> > > > +		}
> > > > +
> > > > +		rcu_read_unlock_sched();
> > > > +
> > > > +		kfree(kdata);
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > +}
> > > 
> > > Thank you,
> > > 
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks,
-Beau
