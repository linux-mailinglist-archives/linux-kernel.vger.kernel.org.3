Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E903C470807
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245079AbhLJSHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:07:32 -0500
Received: from linux.microsoft.com ([13.77.154.182]:37512 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245071AbhLJSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:07:31 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0CDCE20B717A;
        Fri, 10 Dec 2021 10:03:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CDCE20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639159436;
        bh=OaHMFQmPJpG/dqW0wHAtvBdJkEwYBKMkEh8ljXqiJKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PTd2u1XVEynL3EppoYxN/7eU87QMRa2OCtElPMJL7JUevouhadRUfqqh338OtzKb3
         1oqXg3Ulz3t4DnGjPChgu1U8lPexDGAx+fSwH4sMV3fAL7TUNwEFRCFb1SkieuSY4n
         2Osl7ldmCn5EPzkwnUTWz//TYfayUUfwuw6nyUPQ=
Date:   Fri, 10 Dec 2021 10:03:54 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211210180354.GB2131@kbox>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
 <20211209223210.1818-3-beaub@linux.microsoft.com>
 <20211210194358.e590d49a1620df7345f9f679@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210194358.e590d49a1620df7345f9f679@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 07:43:58PM +0900, Masami Hiramatsu wrote:
> Hi Beau,
> 
> Thanks for updating the patch! I have some comments below.
> 
> On Thu,  9 Dec 2021 14:31:59 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> [..]
> > +#define USER_EVENTS_PREFIX_LEN (sizeof(USER_EVENTS_PREFIX)-1)
> > +
> > +#define FIELD_DEPTH_TYPE 0
> > +#define FIELD_DEPTH_NAME 1
> > +#define FIELD_DEPTH_SIZE 2
> > +
> > +/*
> > + * Limits how many trace_event calls user processes can create:
> > + * Must be multiple of PAGE_SIZE.
> > + */
> > +#define MAX_PAGES 1
> > +#define MAX_EVENTS (MAX_PAGES * PAGE_SIZE)
> > +
> > +/* Limit how long of an event name plus args within the subsystem. */
> > +#define MAX_EVENT_DESC 512
> > +#define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
> > +#define MAX_FIELD_ARRAY_SIZE (2 * PAGE_SIZE)
> 
> I don't recommend to record the event which size is more than a page size...
> Maybe 256 entries?
> It is also better to limit the total size of the event and the number
> of fields (arguments).
> 
> Steve, can we write such a big event data on the trace buffer?
> 

This moved to 1024 in part 12 when validation was added.

> [..]
> > +
> > +static int user_field_array_size(const char *type)
> > +{
> > +	const char *start = strchr(type, '[');
> > +	char val[8];
> > +	int size = 0;
> > +
> > +	if (start == NULL)
> > +		return -EINVAL;
> > +
> > +	start++;
> > +
> > +	while (*start != ']' && size < (sizeof(val) - 1))
> > +		val[size++] = *start++;
> > +
> > +	if (*start != ']')
> > +		return -EINVAL;
> > +
> > +	val[size] = 0;
> 
> It's '\0', not 0.

Both evaluate to 0, is this a style thing?

For example, argv_split does this same thing ;)

> 
> If I were you, I just use strlcpy(val, start, sizeof(val)), and
> strchr(val, ']'). Sometimes using standard libc function will
> be easer to understand what it does. :)
> 

Sure good idea.

[..]

> > +static int user_event_add_field(struct user_event *user, const char *type,
> > +				const char *name, int offset, int size,
> > +				int is_signed, int filter_type)
> > +{
> > +	struct ftrace_event_field *field;
> > +
> > +	field = kmalloc(sizeof(*field), GFP_KERNEL);
> > +
> > +	if (!field)
> > +		return -ENOMEM;
> > +
> > +	field->type = type;
> > +	field->name = name;
> > +	field->offset = offset;
> > +	field->size = size;
> > +	field->is_signed = is_signed;
> > +	field->filter_type = filter_type;
> > +
> > +	list_add(&field->link, &user->fields);
> 
> I recommend to use list_add_tail() here so that when accessing the
> list of field without reverse order. (I found this in [4/13])
> 

If I did that, wouldn't that mean the format file in tracefs now has the
arguments printed in reverse order they were added?

> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Parses the values of a field within the description
> > + * Format: type name [size]
> 
> Hmm, don't you accept redundant spaces and tabs?
> If this accepts the redundant spaces/tabs, I recommend you to use
> argv_split() instead of strpbrk() etc. e.g.
> 
> 	int argc, name_idx = 0, size;
> 	int ret = -EINVAL;
> 	char **argv;
> 
> 	argv = argv_split(GFP_KERNEL, field, &argc);
> 	if (!argv)
> 		return -ENOMEM;
> 
> 	if (!strcmp(argv[pos], "__data_loc") ||
> 	    !strcmp(argv[pos], "__rel_loc")) {
> 		if (++pos >= argc)
> 			goto error;
> 	}
> 	if (!strcmp(argv[pos], "unsigned")) {
> 		if (++pos >= argc)
> 			goto error;
> 	} else if (!strcmp(argv[pos], "struct")) {
> 		is_struct = true;
> 		if (++pos >= argc)
> 			goto error;
> 	}
> 	if (++pos >= argc)
> 		goto error;
> 	name_idx = pos++;
> 	if (pos < argc) {	// size
> 		if (!is_struct)
> 			goto error;
> 		if (kstrtou32(argv[pos++], 10, &size))
> 			goto error;
> 	} else
> 		size = user_field_size(argv[name_idx - 1]);
> 
> 	if (pos != argc)
> 		goto error;
> 	
> 	// note that type index is always 0 and size must be converted.
> 	user_event_add_field(user, argv, name_idx, saved_offset, size,
> 				    type[0] != 'u', FILTER_OTHER);
> 
> 	ret = 0;
> error:
> 	argv_free(argv);
> 	return ret;
> 
> (This also requires to simplify user_field_size() and remove FIELD_DEPTH_*)
> What would you think?
> 	

The code currently does not support duplicate spaces after the first
non-whitespace.

We do copy the string before this, so how this is written would do a
double allocation. If the argv_split was moved higher in the callchain
then I could move to this.

If you feel strongly about this, I don't have a problem moving to this
pattern. Let me know if you feel strongly about it.

> > +
> > +/*
> > + * Register callback for our events from tracing sub-systems.
> > + */
> > +static int user_event_reg(struct trace_event_call *call,
> > +			  enum trace_reg type,
> > +			  void *data)
> > +{
> > +	struct user_event *user = (struct user_event *)call->data;
> > +	int ret = 0;
> > +
> > +	if (!user)
> > +		return -ENOENT;
> > +
> > +	switch (type) {
> > +	case TRACE_REG_REGISTER:
> > +		ret = tracepoint_probe_register(call->tp,
> > +						call->class->probe,
> > +						data);
> > +		if (!ret)
> > +			goto inc;
> > +		break;
> > +
> > +	case TRACE_REG_UNREGISTER:
> > +		tracepoint_probe_unregister(call->tp,
> > +					    call->class->probe,
> > +					    data);
> > +		goto dec;
> > +
> > +#ifdef CONFIG_PERF_EVENTS
> > +	case TRACE_REG_PERF_REGISTER:
> > +	case TRACE_REG_PERF_UNREGISTER:
> > +	case TRACE_REG_PERF_OPEN:
> > +	case TRACE_REG_PERF_CLOSE:
> > +	case TRACE_REG_PERF_ADD:
> > +	case TRACE_REG_PERF_DEL:
> > +		break;
> > +#endif
> 
> At this moment (in this patch), you can just add a default case,
> or just ignore it, because it does nothing.
> 

Yeah, I was trying to avoid the warning that resulted if I just ignored
them.

> > +	}
> > +
> > +	return ret;
> > +inc:
> > +	atomic_inc(&user->refcnt);
> > +	update_reg_page_for(user);
> > +	return 0;
> > +dec:
> > +	update_reg_page_for(user);
> > +	atomic_dec(&user->refcnt);
> > +	return 0;
> > +}
> > +
> 
> [..]
> > +/*
> > + * Validates the user payload and writes via iterator.
> > + */
> > +static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
> > +{
> > +	struct user_event_refs *refs;
> > +	struct user_event *user = NULL;
> > +	struct tracepoint *tp;
> > +	ssize_t ret = i->count;
> > +	int idx;
> > +
> > +	if (unlikely(copy_from_iter(&idx, sizeof(idx), i) != sizeof(idx)))
> > +		return -EFAULT;
> > +
> > +	rcu_read_lock_sched();
> > +
> > +	refs = rcu_dereference_sched(file->private_data);
> > +
> > +	/*
> > +	 * The refs->events array is protected by RCU, and new items may be
> > +	 * added. But the user retrieved from indexing into the events array
> > +	 * shall be immutable while the file is opened.
> > +	 */
> > +	if (likely(refs && idx < refs->count))
> > +		user = refs->events[idx];
> > +
> > +	rcu_read_unlock_sched();
> > +
> > +	if (unlikely(user == NULL))
> > +		return -ENOENT;
> > +
> > +	tp = &user->tracepoint;
> > +
> > +	/*
> > +	 * It's possible key.enabled disables after this check, however
> > +	 * we don't mind if a few events are included in this condition.
> > +	 */
> > +	if (likely(atomic_read(&tp->key.enabled) > 0)) {
> > +		struct tracepoint_func *probe_func_ptr;
> > +		user_event_func_t probe_func;
> > +		void *tpdata;
> > +		void *kdata;
> > +		u32 datalen;
> > +
> > +		kdata = kmalloc(i->count, GFP_KERNEL);
> > +
> > +		if (unlikely(!kdata))
> > +			return -ENOMEM;
> > +
> > +		datalen = copy_from_iter(kdata, i->count, i);
> 
> Don't we need to add this datalen to ret?
> 

ret is set to the bytes that were given by the user to avoid multiple
writes from occuring for the same data if the data was paged out (or if
the event isn't enabled at that time for whatever reason).

Since seek/partial writes are not supported, I don't believe we want to
do that.

> > +
> > +		rcu_read_lock_sched();
> > +
> > +		probe_func_ptr = rcu_dereference_sched(tp->funcs);
> > +
> > +		if (probe_func_ptr) {
> > +			do {
> > +				probe_func = probe_func_ptr->func;
> > +				tpdata = probe_func_ptr->data;
> > +				probe_func(user, kdata, datalen, tpdata);
> > +			} while ((++probe_func_ptr)->func);
> > +		}
> > +
> > +		rcu_read_unlock_sched();
> > +
> > +		kfree(kdata);
> > +	}
> > +
> > +	return ret;
> > +}
> 
> Thank you,
> 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
