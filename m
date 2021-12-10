Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A2F46FEE2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbhLJKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhLJKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:47:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3076FC061746;
        Fri, 10 Dec 2021 02:44:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6649B82763;
        Fri, 10 Dec 2021 10:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB4EC00446;
        Fri, 10 Dec 2021 10:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639133041;
        bh=gLwVsj0h7I27KQSagp/X3RmrFEo7I3V//9PuDxqpjXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rqMB1PiL2v5aU0q51LvJTX8e+ba4u+AE1tQSqPTmG0Ah9ovgvxvD9VDxegLjK2Nkr
         xhz4TJZFRor/0nSh27NoeYi7a+zIKwIXUbeu+aIOvRKFdxEw63NXho6lspT/+XEYPe
         blDf+1QlJuThyvhOs8NwIk9tMlTN7v9Wm/Jq2Sx83nlOHpXNsagbiARKOKyXQzYqCt
         NbLLCQ6g+2FPjTnHbN42jlrUxKDI1ci0yh25DzuVYWTLQLqMXVCAhtZYkpGLsUATVt
         ROf4XZPWISU8NH3xD+9CjX2YDgr5PCmamgJwUFR55niun/oGjVhaUyfourttEVzFH4
         SqdmbvUOckelg==
Date:   Fri, 10 Dec 2021 19:43:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-Id: <20211210194358.e590d49a1620df7345f9f679@kernel.org>
In-Reply-To: <20211209223210.1818-3-beaub@linux.microsoft.com>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
        <20211209223210.1818-3-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beau,

Thanks for updating the patch! I have some comments below.

On Thu,  9 Dec 2021 14:31:59 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

[..]
> +#define USER_EVENTS_PREFIX_LEN (sizeof(USER_EVENTS_PREFIX)-1)
> +
> +#define FIELD_DEPTH_TYPE 0
> +#define FIELD_DEPTH_NAME 1
> +#define FIELD_DEPTH_SIZE 2
> +
> +/*
> + * Limits how many trace_event calls user processes can create:
> + * Must be multiple of PAGE_SIZE.
> + */
> +#define MAX_PAGES 1
> +#define MAX_EVENTS (MAX_PAGES * PAGE_SIZE)
> +
> +/* Limit how long of an event name plus args within the subsystem. */
> +#define MAX_EVENT_DESC 512
> +#define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
> +#define MAX_FIELD_ARRAY_SIZE (2 * PAGE_SIZE)

I don't recommend to record the event which size is more than a page size...
Maybe 256 entries?
It is also better to limit the total size of the event and the number
of fields (arguments).

Steve, can we write such a big event data on the trace buffer?

[..]
> +
> +static int user_field_array_size(const char *type)
> +{
> +	const char *start = strchr(type, '[');
> +	char val[8];
> +	int size = 0;
> +
> +	if (start == NULL)
> +		return -EINVAL;
> +
> +	start++;
> +
> +	while (*start != ']' && size < (sizeof(val) - 1))
> +		val[size++] = *start++;
> +
> +	if (*start != ']')
> +		return -EINVAL;
> +
> +	val[size] = 0;

It's '\0', not 0.

If I were you, I just use strlcpy(val, start, sizeof(val)), and
strchr(val, ']'). Sometimes using standard libc function will
be easer to understand what it does. :)

> +
> +	if (kstrtouint(val, 0, &size))
> +		return -EINVAL;
> +
> +	if (size > MAX_FIELD_ARRAY_SIZE)
> +		return -EINVAL;
> +
> +	return size;
> +}
> +
> +static int user_field_size(const char *type)
> +{
> +	/* long is not allowed from a user, since it's ambigious in size */
> +	if (strcmp(type, "s64") == 0)
> +		return sizeof(s64);
> +	if (strcmp(type, "u64") == 0)
> +		return sizeof(u64);
> +	if (strcmp(type, "s32") == 0)
> +		return sizeof(s32);
> +	if (strcmp(type, "u32") == 0)
> +		return sizeof(u32);
> +	if (strcmp(type, "int") == 0)
> +		return sizeof(int);
> +	if (strcmp(type, "unsigned int") == 0)
> +		return sizeof(unsigned int);
> +	if (strcmp(type, "s16") == 0)
> +		return sizeof(s16);
> +	if (strcmp(type, "u16") == 0)
> +		return sizeof(u16);
> +	if (strcmp(type, "short") == 0)
> +		return sizeof(short);
> +	if (strcmp(type, "unsigned short") == 0)
> +		return sizeof(unsigned short);
> +	if (strcmp(type, "s8") == 0)
> +		return sizeof(s8);
> +	if (strcmp(type, "u8") == 0)
> +		return sizeof(u8);
> +	if (strcmp(type, "char") == 0)
> +		return sizeof(char);
> +	if (strcmp(type, "unsigned char") == 0)
> +		return sizeof(unsigned char);
> +	if (str_has_prefix(type, "char["))
> +		return user_field_array_size(type);
> +	if (str_has_prefix(type, "unsigned char["))
> +		return user_field_array_size(type);
> +	if (str_has_prefix(type, "__data_loc "))
> +		return sizeof(u32);
> +	if (str_has_prefix(type, "__rel_loc "))
> +		return sizeof(u32);
> +
> +	/* Uknown basic type, error */
> +	return -EINVAL;
> +}
> +
> +static void user_event_destroy_fields(struct user_event *user)
> +{
> +	struct ftrace_event_field *field, *next;
> +	struct list_head *head = &user->fields;
> +
> +	list_for_each_entry_safe(field, next, head, link) {
> +		list_del(&field->link);
> +		kfree(field);
> +	}
> +}
> +
> +static int user_event_add_field(struct user_event *user, const char *type,
> +				const char *name, int offset, int size,
> +				int is_signed, int filter_type)
> +{
> +	struct ftrace_event_field *field;
> +
> +	field = kmalloc(sizeof(*field), GFP_KERNEL);
> +
> +	if (!field)
> +		return -ENOMEM;
> +
> +	field->type = type;
> +	field->name = name;
> +	field->offset = offset;
> +	field->size = size;
> +	field->is_signed = is_signed;
> +	field->filter_type = filter_type;
> +
> +	list_add(&field->link, &user->fields);

I recommend to use list_add_tail() here so that when accessing the
list of field without reverse order. (I found this in [4/13])

> +
> +	return 0;
> +}
> +
> +/*
> + * Parses the values of a field within the description
> + * Format: type name [size]

Hmm, don't you accept redundant spaces and tabs?
If this accepts the redundant spaces/tabs, I recommend you to use
argv_split() instead of strpbrk() etc. e.g.

	int argc, name_idx = 0, size;
	int ret = -EINVAL;
	char **argv;

	argv = argv_split(GFP_KERNEL, field, &argc);
	if (!argv)
		return -ENOMEM;

	if (!strcmp(argv[pos], "__data_loc") ||
	    !strcmp(argv[pos], "__rel_loc")) {
		if (++pos >= argc)
			goto error;
	}
	if (!strcmp(argv[pos], "unsigned")) {
		if (++pos >= argc)
			goto error;
	} else if (!strcmp(argv[pos], "struct")) {
		is_struct = true;
		if (++pos >= argc)
			goto error;
	}
	if (++pos >= argc)
		goto error;
	name_idx = pos++;
	if (pos < argc) {	// size
		if (!is_struct)
			goto error;
		if (kstrtou32(argv[pos++], 10, &size))
			goto error;
	} else
		size = user_field_size(argv[name_idx - 1]);

	if (pos != argc)
		goto error;
	
	// note that type index is always 0 and size must be converted.
	user_event_add_field(user, argv, name_idx, saved_offset, size,
				    type[0] != 'u', FILTER_OTHER);

	ret = 0;
error:
	argv_free(argv);
	return ret;

(This also requires to simplify user_field_size() and remove FIELD_DEPTH_*)
What would you think?
	
> + */
> +static int user_event_parse_field(char *field, struct user_event *user,
> +				  u32 *offset)
> +{
> +	char *part, *type, *name;
> +	u32 depth = 0, saved_offset = *offset;
> +	int len, size = -EINVAL;
> +	bool is_struct = false;
> +
> +	field = skip_spaces(field);
> +
> +	if (*field == 0)
> +		return 0;
> +
> +	/* Handle types that have a space within */
> +	len = str_has_prefix(field, "unsigned ");
> +	if (len)
> +		goto skip_next;
> +
> +	len = str_has_prefix(field, "struct ");
> +	if (len) {
> +		is_struct = true;
> +		goto skip_next;
> +	}
> +
> +	len = str_has_prefix(field, "__data_loc unsigned ");
> +	if (len)
> +		goto skip_next;
> +
> +	len = str_has_prefix(field, "__data_loc ");
> +	if (len)
> +		goto skip_next;
> +
> +	len = str_has_prefix(field, "__rel_loc unsigned ");
> +	if (len)
> +		goto skip_next;
> +
> +	len = str_has_prefix(field, "__rel_loc ");
> +	if (len)
> +		goto skip_next;
> +
> +	goto parse;
> +skip_next:
> +	type = field;
> +	field = strpbrk(field + len, " ");
> +
> +	if (field == NULL)
> +		return -EINVAL;
> +
> +	*field++ = 0;
> +	depth++;
> +parse:
> +	while ((part = strsep(&field, " ")) != NULL) {
> +		switch (depth++) {
> +		case FIELD_DEPTH_TYPE:
> +			type = part;
> +			break;
> +		case FIELD_DEPTH_NAME:
> +			name = part;
> +			break;
> +		case FIELD_DEPTH_SIZE:
> +			if (!is_struct)
> +				return -EINVAL;
> +
> +			if (kstrtou32(part, 10, &size))
> +				return -EINVAL;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (depth < FIELD_DEPTH_SIZE)
> +		return -EINVAL;
> +
> +	if (depth == FIELD_DEPTH_SIZE)
> +		size = user_field_size(type);
> +
> +	if (size == 0)
> +		return -EINVAL;
> +
> +	if (size < 0)
> +		return size;
> +
> +	*offset = saved_offset + size;
> +
> +	return user_event_add_field(user, type, name, saved_offset, size,
> +				    type[0] != 'u', FILTER_OTHER);
> +}

[..]
> +
> +/*
> + * Register callback for our events from tracing sub-systems.
> + */
> +static int user_event_reg(struct trace_event_call *call,
> +			  enum trace_reg type,
> +			  void *data)
> +{
> +	struct user_event *user = (struct user_event *)call->data;
> +	int ret = 0;
> +
> +	if (!user)
> +		return -ENOENT;
> +
> +	switch (type) {
> +	case TRACE_REG_REGISTER:
> +		ret = tracepoint_probe_register(call->tp,
> +						call->class->probe,
> +						data);
> +		if (!ret)
> +			goto inc;
> +		break;
> +
> +	case TRACE_REG_UNREGISTER:
> +		tracepoint_probe_unregister(call->tp,
> +					    call->class->probe,
> +					    data);
> +		goto dec;
> +
> +#ifdef CONFIG_PERF_EVENTS
> +	case TRACE_REG_PERF_REGISTER:
> +	case TRACE_REG_PERF_UNREGISTER:
> +	case TRACE_REG_PERF_OPEN:
> +	case TRACE_REG_PERF_CLOSE:
> +	case TRACE_REG_PERF_ADD:
> +	case TRACE_REG_PERF_DEL:
> +		break;
> +#endif

At this moment (in this patch), you can just add a default case,
or just ignore it, because it does nothing.

> +	}
> +
> +	return ret;
> +inc:
> +	atomic_inc(&user->refcnt);
> +	update_reg_page_for(user);
> +	return 0;
> +dec:
> +	update_reg_page_for(user);
> +	atomic_dec(&user->refcnt);
> +	return 0;
> +}
> +

[..]
> +/*
> + * Validates the user payload and writes via iterator.
> + */
> +static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
> +{
> +	struct user_event_refs *refs;
> +	struct user_event *user = NULL;
> +	struct tracepoint *tp;
> +	ssize_t ret = i->count;
> +	int idx;
> +
> +	if (unlikely(copy_from_iter(&idx, sizeof(idx), i) != sizeof(idx)))
> +		return -EFAULT;
> +
> +	rcu_read_lock_sched();
> +
> +	refs = rcu_dereference_sched(file->private_data);
> +
> +	/*
> +	 * The refs->events array is protected by RCU, and new items may be
> +	 * added. But the user retrieved from indexing into the events array
> +	 * shall be immutable while the file is opened.
> +	 */
> +	if (likely(refs && idx < refs->count))
> +		user = refs->events[idx];
> +
> +	rcu_read_unlock_sched();
> +
> +	if (unlikely(user == NULL))
> +		return -ENOENT;
> +
> +	tp = &user->tracepoint;
> +
> +	/*
> +	 * It's possible key.enabled disables after this check, however
> +	 * we don't mind if a few events are included in this condition.
> +	 */
> +	if (likely(atomic_read(&tp->key.enabled) > 0)) {
> +		struct tracepoint_func *probe_func_ptr;
> +		user_event_func_t probe_func;
> +		void *tpdata;
> +		void *kdata;
> +		u32 datalen;
> +
> +		kdata = kmalloc(i->count, GFP_KERNEL);
> +
> +		if (unlikely(!kdata))
> +			return -ENOMEM;
> +
> +		datalen = copy_from_iter(kdata, i->count, i);

Don't we need to add this datalen to ret?

> +
> +		rcu_read_lock_sched();
> +
> +		probe_func_ptr = rcu_dereference_sched(tp->funcs);
> +
> +		if (probe_func_ptr) {
> +			do {
> +				probe_func = probe_func_ptr->func;
> +				tpdata = probe_func_ptr->data;
> +				probe_func(user, kdata, datalen, tpdata);
> +			} while ((++probe_func_ptr)->func);
> +		}
> +
> +		rcu_read_unlock_sched();
> +
> +		kfree(kdata);
> +	}
> +
> +	return ret;
> +}

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
