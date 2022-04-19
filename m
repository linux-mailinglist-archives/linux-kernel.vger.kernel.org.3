Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5363D506202
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344344AbiDSCRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiDSCRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F5C26AC9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CA5E614A8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E90DC385A7;
        Tue, 19 Apr 2022 02:14:33 +0000 (UTC)
Date:   Mon, 18 Apr 2022 22:14:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] trace: Add trace any kernel object
Message-ID: <20220418214400.2ab7f932@rorschach.local.home>
In-Reply-To: <20220204035644.734878-2-xiehuan09@gmail.com>
References: <20220204035644.734878-1-xiehuan09@gmail.com>
        <20220204035644.734878-2-xiehuan09@gmail.com>
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

On Fri,  4 Feb 2022 11:56:41 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Introduce objtrace trigger to get the call flow by tracing any kernel
> object in the function parameter.
> 
> The objtrace trigger makes a list of the target object address from
> the given event parameter, and records all kernel function calls
> which has the object address in its parameter.
> 
> Syntax:
> 	objtrace:add:obj[:count][if <filter>]
> 
> Usage:
> 	# echo 'p bio_add_page arg1=$arg1' > kprobe_events
> 	# cd events/kprobes/p_bio_add_page_0
> 	# echo 'objtrace:add:arg1:1 if comm == "cat"' > ./trigger
> 	# cat /test.txt

OK, so patch one only does the object and not the more useful "value"
field. That comes in patch 2.

> 
> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> ---
>  include/linux/trace_events.h        |   1 +
>  kernel/trace/Kconfig                |  10 +
>  kernel/trace/Makefile               |   1 +
>  kernel/trace/trace.c                |   3 +
>  kernel/trace/trace.h                |   8 +
>  kernel/trace/trace_entries.h        |  17 +
>  kernel/trace/trace_events_trigger.c |   1 +
>  kernel/trace/trace_object.c         | 515 ++++++++++++++++++++++++++++
>  kernel/trace/trace_output.c         |  40 +++
>  9 files changed, 596 insertions(+)
>  create mode 100644 kernel/trace/trace_object.c
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 70c069aef02c..3ccdbc1d25dd 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -685,6 +685,7 @@ enum event_trigger_type {
>  	ETT_EVENT_HIST		= (1 << 4),
>  	ETT_HIST_ENABLE		= (1 << 5),
>  	ETT_EVENT_EPROBE	= (1 << 6),
> +	ETT_TRACE_OBJECT	= (1 << 7),
>  };
>  
>  extern int filter_match_preds(struct event_filter *filter, void *rec);
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index a5eb5e7fd624..c51b7eb1508d 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -250,6 +250,16 @@ config FUNCTION_PROFILER
>  
>  	  If in doubt, say N.
>  
> +config TRACE_OBJECT
> +	bool "Trace kernel object in function parameter"
> +	depends on FUNCTION_TRACER
> +	depends on HAVE_FUNCTION_ARG_ACCESS_API
> +	select TRACING
> +	default y
> +	help
> +	 You can trace the kernel object in the kernel function parameter.
> +	 The kernel object is dynamically specified via event trigger.
> +
>  config STACK_TRACER
>  	bool "Trace max stack"
>  	depends on HAVE_FUNCTION_TRACER
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index bedc5caceec7..b924b8e55922 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
>  obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
>  obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
>  obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += fgraph.o
> +obj-$(CONFIG_TRACE_OBJECT) += trace_object.o
>  ifeq ($(CONFIG_BLOCK),y)
>  obj-$(CONFIG_EVENT_TRACING) += blktrace.o
>  endif
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a734d5ae34c8..b4513c2bbd52 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5605,6 +5605,9 @@ static const char readme_msg[] =
>  	"\t            enable_hist:<system>:<event>\n"
>  	"\t            disable_hist:<system>:<event>\n"
>  #endif
> +#ifdef CONFIG_TRACE_OBJECT
> +	"\t            objtrace:add:obj[:count][if <filter>]\n"
> +#endif
>  #ifdef CONFIG_STACKTRACE
>  	"\t\t    stacktrace\n"
>  #endif
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 0f5e22238cd2..8b66515a36d5 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -54,6 +54,7 @@ enum trace_type {
>  	TRACE_TIMERLAT,
>  	TRACE_RAW_DATA,
>  	TRACE_FUNC_REPEATS,
> +	TRACE_OBJECT,
>  
>  	__TRACE_LAST_TYPE,
>  };
> @@ -472,6 +473,7 @@ extern void __ftrace_bad_type(void);
>  			  TRACE_GRAPH_RET);		\
>  		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
>  			  TRACE_FUNC_REPEATS);				\
> +		IF_ASSIGN(var, ent, struct trace_object_entry, TRACE_OBJECT);\
>  		__ftrace_bad_type();					\
>  	} while (0)
>  
> @@ -1537,6 +1539,12 @@ static inline int register_trigger_hist_cmd(void) { return 0; }
>  static inline int register_trigger_hist_enable_disable_cmds(void) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_TRACE_OBJECT
> +extern int register_trigger_object_cmd(void);
> +#else
> +static inline int register_trigger_object_cmd(void) { return 0; }
> +#endif
> +
>  extern int register_trigger_cmds(void);
>  extern void clear_event_triggers(struct trace_array *tr);
>  
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index cd41e863b51c..bb120d9498a9 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -401,3 +401,20 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
>  		 __entry->context,
>  		 __entry->timer_latency)
>  );
> +
> +/*
> + * trace object entry:
> + */
> +FTRACE_ENTRY(object, trace_object_entry,
> +
> +	TRACE_OBJECT,
> +
> +	F_STRUCT(
> +		__field(	unsigned long,		ip		)
> +		__field(	unsigned long,		parent_ip	)
> +		__field(	unsigned long,		object		)
> +	),
> +
> +	F_printk(" %ps <-- %ps object:%lx\n",
> +		 (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
> +);
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index d00fee705f9c..c3371a6902af 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -2025,6 +2025,7 @@ __init int register_trigger_cmds(void)
>  	register_trigger_enable_disable_cmds();
>  	register_trigger_hist_enable_disable_cmds();
>  	register_trigger_hist_cmd();
> +	register_trigger_object_cmd();
>  
>  	return 0;
>  }
> diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
> new file mode 100644
> index 000000000000..540e387c613a
> --- /dev/null
> +++ b/kernel/trace/trace_object.c
> @@ -0,0 +1,515 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * trace the kernel object in the kernel function parameter
> + * Copyright (C) 2021 Jeff Xie <xiehuan09@gmail.com>
> + */
> +
> +#define pr_fmt(fmt) "trace_object: " fmt
> +
> +#include "trace_output.h"
> +
> +#define MAX_TRACED_OBJECT 5
> +#define OBJTRACE_CMD_LEN  10

The len should at least be a multiple of word size. 16?

> +static DEFINE_PER_CPU(unsigned int, trace_object_event_disable);
> +static DEFINE_RAW_SPINLOCK(trace_obj_lock);
> +static struct trace_event_file event_trace_file;

You do not want to use a global "event_trace_file". And the writes
should be done in the instance (trace_array) that the trigger was added
to. That is, if someone does:

  # mkdir instances/foo
  # echo 'objtrace:add:arg1:1 if comm == "cat"' > instances/foo/events/kprobes/p_bio_add_page_0/trigger

Then the tracing should happen in the instance/foo/trace and not at the
toplevel trace file.

> +static const int max_args_num = 6;
> +static atomic_t trace_object_ref;
> +static atomic_t num_traced_obj;
> +static int exit_trace_object(void);
> +static int init_trace_object(void);
> +
> +static struct object_instance {
> +	void *obj;

Either have a pointer to the trace_array that the object is for here,
or we can have each trace array have a max of 5 objects and add it to
the trace_array when it is created.

> +} traced_obj[MAX_TRACED_OBJECT];
> +
> +/* objtrace private data */
> +struct objtrace_trigger_data {
> +	struct ftrace_event_field *field;
> +	char objtrace_cmd[OBJTRACE_CMD_LEN];
> +};
> +
> +static bool object_exist(void *obj)
> +{
> +	int i, max;
> +
> +	max = atomic_read(&num_traced_obj);
> +	smp_rmb();
> +	for (i = 0; i < max; i++) {
> +		if (traced_obj[i].obj == obj)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool object_empty(void)
> +{
> +	return !atomic_read(&num_traced_obj);
> +}
> +
> +static void set_trace_object(void *obj)
> +{
> +	unsigned long flags;
> +
> +	if (in_nmi())
> +		return;
> +
> +	if (!obj)
> +		return;
> +
> +	if (object_exist(obj))
> +		return;
> +
> +	/* only this place has write operations */
> +	raw_spin_lock_irqsave(&trace_obj_lock, flags);
> +	if (atomic_read(&num_traced_obj) == MAX_TRACED_OBJECT) {
> +		trace_printk("object_pool is full, can't trace object:0x%px\n", obj);

You can't use trace_printk(). That will trigger a nasty message in
dmesg. You can use trace_array_printk_buf() instead.

> +		goto out;
> +	}
> +	traced_obj[atomic_read(&num_traced_obj)].obj = obj;
> +	/* make sure the num_traced_obj update always appears after traced_obj update */
> +	smp_wmb();
> +	atomic_inc(&num_traced_obj);
> +out:
> +	raw_spin_unlock_irqrestore(&trace_obj_lock, flags);
> +}
> +
> +static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> +				 unsigned long object)
> +{
> +
> +	struct trace_buffer *buffer;
> +	struct ring_buffer_event *event;
> +	struct trace_object_entry *entry;
> +	int pc;
> +
> +	pc = preempt_count();
> +	event = trace_event_buffer_lock_reserve(&buffer, &event_trace_file,
> +			TRACE_OBJECT, sizeof(*entry), pc);

We should not be using trace_event_buffer_lock_reserver() here, as it
is expected to be done for trace events, not unique data like this.
This is more like the function tracer, and use
trace_buffer_lock_reserve() instead.

> +	if (!event)
> +		return;
> +	entry   = ring_buffer_event_data(event);
> +	entry->ip                       = ip;
> +	entry->parent_ip                = parent_ip;
> +	entry->object			= object;
> +
> +	event_trigger_unlock_commit(&event_trace_file, buffer, event,
> +		entry, pc);
> +}
> +
> +static void
> +trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> +		struct ftrace_ops *op, struct ftrace_regs *fregs)
> +{

So the op can hold data, which we should allocate it so that there is
one ftrace_ops per trace_array (like function tracing does). May need
callbacks from mkdir and rmdir in trace.c. But the trace_array (tr)
will hold the buffer you want to write to. Or at the very least, the
object can hold it.


> +	struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> +	unsigned long obj;
> +	unsigned int disabled;
> +	int n;
> +
> +	preempt_disable_notrace();
> +
> +	disabled = this_cpu_inc_return(trace_object_event_disable);

If we make this list per instance, we will only want to disable the
instance.

> +	if (disabled != 1)
> +		goto out;
> +
> +	if (object_empty())
> +		goto out;
> +
> +	for (n = 0; n < max_args_num; n++) {
> +		obj = regs_get_kernel_argument(pt_regs, n);
> +		if (object_exist((void *)obj))
> +			submit_trace_object(ip, parent_ip, obj);
> +	/* The parameters of a function may match multiple objects */
> +	}
> +out:
> +	this_cpu_dec(trace_object_event_disable);
> +	preempt_enable_notrace();
> +}
> +
> +static struct ftrace_ops trace_ops = {
> +	.func  = trace_object_events_call,
> +	.flags = FTRACE_OPS_FL_SAVE_REGS,
> +};
> +
> +static void
> +trace_object_trigger(struct event_trigger_data *data,
> +		   struct trace_buffer *buffer,  void *rec,
> +		   struct ring_buffer_event *event)
> +{
> +	struct objtrace_trigger_data *obj_data = data->private_data;
> +	struct ftrace_event_field *field;
> +	void *obj = NULL;
> +
> +	field = obj_data->field;
> +	memcpy(&obj, rec + field->offset, sizeof(obj));
> +	set_trace_object(obj);
> +}
> +
> +static void
> +trace_object_trigger_free(struct event_trigger_ops *ops,
> +		   struct event_trigger_data *data)
> +{
> +	if (WARN_ON_ONCE(data->ref <= 0))
> +		return;
> +
> +	data->ref--;
> +	if (!data->ref) {
> +		kfree(data->private_data);
> +		trigger_data_free(data);
> +	}
> +}
> +
> +static void
> +trace_object_count_trigger(struct event_trigger_data *data,
> +			 struct trace_buffer *buffer, void *rec,
> +			 struct ring_buffer_event *event)
> +{
> +	if (!data->count)
> +		return;
> +
> +	if (data->count != -1)
> +		(data->count)--;
> +
> +	trace_object_trigger(data, buffer, rec, event);
> +}
> +
> +static int event_object_trigger_init(struct event_trigger_ops *ops,
> +		       struct event_trigger_data *data)
> +{
> +	data->ref++;
> +	return 0;
> +}
> +
> +static int
> +event_trigger_print(const char *name, struct seq_file *m,
> +		void *data, char *filter_str, void *objtrace_data)
> +{
> +	long count = (long)data;
> +	struct objtrace_trigger_data *obj_data = objtrace_data;
> +
> +	seq_puts(m, name);
> +
> +	seq_printf(m, ":%s", obj_data->objtrace_cmd);
> +	seq_printf(m, ":%s", obj_data->field->name);
> +
> +	if (count == -1)
> +		seq_puts(m, ":unlimited");
> +	else
> +		seq_printf(m, ":count=%ld", count);
> +
> +	if (filter_str)
> +		seq_printf(m, " if %s\n", filter_str);
> +	else
> +		seq_putc(m, '\n');
> +
> +	return 0;
> +}
> +
> +static int
> +trace_object_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
> +			 struct event_trigger_data *data)
> +{
> +	return event_trigger_print("objtrace", m, (void *)data->count,
> +				   data->filter_str, data->private_data);
> +}
> +
> +static struct event_trigger_ops objecttrace_trigger_ops = {
> +	.trigger		= trace_object_trigger,
> +	.print			= trace_object_trigger_print,
> +	.init			= event_object_trigger_init,
> +	.free			= trace_object_trigger_free,
> +};
> +
> +static struct event_trigger_ops objecttrace_count_trigger_ops = {
> +	.trigger		= trace_object_count_trigger,
> +	.print			= trace_object_trigger_print,
> +	.init			= event_object_trigger_init,
> +	.free			= trace_object_trigger_free,
> +};
> +
> +static struct event_trigger_ops *
> +objecttrace_get_trigger_ops(char *cmd, char *param)
> +{
> +	return param ? &objecttrace_count_trigger_ops : &objecttrace_trigger_ops;
> +}
> +
> +static int register_object_trigger(char *glob,
> +			    struct event_trigger_data *data,
> +			    struct trace_event_file *file)
> +{
> +	struct event_trigger_data *test;
> +	int ret = 0;
> +
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(test, &file->triggers, list) {
> +		if (test->cmd_ops->trigger_type == data->cmd_ops->trigger_type) {
> +			ret = -EEXIST;

This should just be "return -EEXIST", but you probably just copied this
from register_trigger() which does it like this as well. I'll need to
go fix that.

> +			goto out;
> +		}
> +	}
> +
> +	if (data->ops->init) {
> +		ret = data->ops->init(data->ops, data);
> +		if (ret < 0)

			return ret;

works too, but again, this is just a copy of an existing function that
has the useless goto as well.

> +			goto out;
> +	}
> +
> +	list_add_rcu(&data->list, &file->triggers);
> +	ret++;
> +
> +	update_cond_flag(file);
> +	if (trace_event_trigger_enable_disable(file, 1) < 0) {
> +		list_del_rcu(&data->list);
> +		update_cond_flag(file);
> +		ret--;
> +	}

OK, so this is pretty much identical to "register_tigger()" in
trace_events_trigger() except for the init below. We should probably
just make the register_trigger() global and reuse it here.

> +	init_trace_object();
> +out:
> +	return ret;
> +}
> +
> +static void unregister_object_trigger(char *glob,
> +			       struct event_trigger_data *test,
> +			       struct trace_event_file *file)
> +{
> +	struct event_trigger_data *data;
> +	bool unregistered = false;
> +
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(data, &file->triggers, list) {
> +		if (data->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
> +			unregistered = true;
> +			list_del_rcu(&data->list);
> +			trace_event_trigger_enable_disable(file, 0);
> +			update_cond_flag(file);
> +			break;
> +		}
> +	}
> +
> +	if (unregistered) {
> +		if (data->ops->free)
> +			data->ops->free(data->ops, data);
> +		exit_trace_object();
> +	}
> +}
> +
> +static bool field_exist(struct trace_event_file *file,
> +			struct event_command *cmd_ops,
> +			const char *field_name)
> +{
> +	struct event_trigger_data *data;
> +	struct objtrace_trigger_data *obj_data;
> +
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(data, &file->triggers, list) {
> +		if (data->cmd_ops->trigger_type == cmd_ops->trigger_type) {
> +			obj_data = data->private_data;
> +			if (!strcmp(obj_data->field->name, field_name))
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static int
> +event_object_trigger_parse(struct event_command *cmd_ops,
> +		       struct trace_event_file *file,
> +		       char *glob, char *cmd, char *param)
> +{
> +	struct event_trigger_data *trigger_data;
> +	struct event_trigger_ops *trigger_ops;
> +	struct objtrace_trigger_data *obj_data;
> +	struct trace_event_call *call;
> +	struct ftrace_event_field *field;
> +	char *objtrace_cmd;
> +	char *trigger = NULL;
> +	char *arg;
> +	char *number;
> +	int ret;
> +	bool remove = false;
> +
> +	ret = -EINVAL;
> +	if (!param)
> +		goto out;

So this is also copied mostly from event_tigger_parse, and has the
unneeded gotos as well.

We need to consolidate the code a bit, and add helper functions to
share between them, instead of just cut and pasting and tweaking.
That's a maintenance nightmare.

> +
> +	/* separate the trigger from the filter (c:a:n [if filter]) */
> +	trigger = strsep(&param, " \t");
> +	if (!trigger)
> +		goto out;
> +	if (param) {
> +		param = skip_spaces(param);
> +		if (!*param)
> +			param = NULL;
> +	}
> +
> +	objtrace_cmd = strsep(&trigger, ":");
> +	if (!objtrace_cmd || strcmp(objtrace_cmd, "add"))
> +		goto out;
> +
> +	arg = strsep(&trigger, ":");
> +	if (!arg)
> +		goto out;
> +	call = file->event_call;
> +	field = trace_find_event_field(call, arg);
> +	if (!field)
> +		goto out;
> +
> +	if (field->size != sizeof(void *))
> +		goto out;

We need to add error messages to write to the error log when things
like this fail. Users will have no idea what happened.

> +
> +	if (glob[0] == '!')
> +		remove = true;
> +
> +	if (remove && !field_exist(file, cmd_ops, field->name))
> +	goto out;

Bad indentation.

> +	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
> +	ret = -ENOMEM;
> +	obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
> +	if (!obj_data)
> +		goto out;
> +	obj_data->field = field;
> +	snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);
> +
> +	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
> +	if (!trigger_data) {
> +		kfree(obj_data);
> +		goto out;
> +	}
> +
> +	trigger_data->count = -1;
> +	trigger_data->ops = trigger_ops;
> +	trigger_data->cmd_ops = cmd_ops;
> +	trigger_data->private_data = obj_data;
> +	INIT_LIST_HEAD(&trigger_data->list);
> +	INIT_LIST_HEAD(&trigger_data->named_list);
> +
> +	if (remove) {
> +		cmd_ops->unreg(glob+1, trigger_data, file);
> +		kfree(obj_data);
> +		kfree(trigger_data);
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	if (trigger) {
> +		number = strsep(&trigger, ":");
> +
> +		ret = -EINVAL;
> +		if (!strlen(number))
> +			goto out_free;
> +
> +		/*
> +		 * We use the callback data field (which is a pointer)
> +		 * as our counter.
> +		 */
> +		ret = kstrtoul(number, 0, &trigger_data->count);
> +		if (ret)
> +			goto out_free;
> +	}
> +
> +	if (!param) /* if param is non-empty, it's supposed to be a filter */
> +		goto out_reg;
> +
> +	if (!cmd_ops->set_filter)
> +		goto out_reg;
> +
> +	ret = cmd_ops->set_filter(param, trigger_data, file);
> +	if (ret < 0)
> +		goto out_free;
> +
> + out_reg:
> +	/* Up the trigger_data count to make sure reg doesn't free it on failure */
> +	event_object_trigger_init(trigger_ops, trigger_data);
> +	ret = cmd_ops->reg(glob, trigger_data, file);
> +	/*
> +	 * The above returns on success the # of functions enabled,
> +	 * but if it didn't find any functions it returns zero.
> +	 * Consider no functions a failure too.
> +	 */
> +	if (!ret) {
> +		cmd_ops->unreg(glob, trigger_data, file);
> +		ret = -ENOENT;
> +	} else if (ret > 0)
> +		ret = 0;
> +
> +	/* Down the counter of trigger_data or free it if not used anymore */
> +	trace_object_trigger_free(trigger_ops, trigger_data);
> + out:
> +	return ret;
> +
> + out_free:
> +	if (cmd_ops->set_filter)
> +		cmd_ops->set_filter(NULL, trigger_data, NULL);
> +	kfree(obj_data);
> +	kfree(trigger_data);
> +	goto out;
> +}
> +
> +static struct event_command trigger_object_cmd = {
> +	.name			= "objtrace",
> +	.trigger_type		= ETT_TRACE_OBJECT,
> +	.flags			= EVENT_CMD_FL_NEEDS_REC,
> +	.parse			= event_object_trigger_parse,
> +	.reg			= register_object_trigger,
> +	.unreg			= unregister_object_trigger,
> +	.get_trigger_ops	= objecttrace_get_trigger_ops,
> +	.set_filter		= set_trigger_filter,
> +};
> +
> +__init int register_trigger_object_cmd(void)
> +{
> +	int ret;
> +
> +	ret = register_event_command(&trigger_object_cmd);
> +	WARN_ON(ret < 0);
> +
> +	return ret;
> +}
> +
> +static int init_trace_object(void)
> +{
> +	int ret;
> +
> +	if (atomic_inc_return(&trace_object_ref) != 1) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	event_trace_file.tr = top_trace_array();
> +	if (WARN_ON(!event_trace_file.tr)) {
> +		ret = -1;
> +		atomic_dec(&trace_object_ref);
> +		goto out;
> +	}
> +	ret = register_ftrace_function(&trace_ops);
> +out:
> +	return ret;
> +}
> +
> +static int exit_trace_object(void)
> +{
> +	int ret;
> +
> +	if (WARN_ON_ONCE(atomic_read(&trace_object_ref) <= 0)) {

No reason for the goto out. This shuold be:

	if (WARN_ON_ONCE(atomic_read(&trace_object_ref) <= 0))
		return -1;

> +		ret = -1;
> +		goto out;
> +	}
> +
> +	if (atomic_dec_return(&trace_object_ref) != 0) {

And this:

	if (atomic_dec_return(&trace_object_ref) != 0)
		return 0;

goto's should only be used if there's something to be "undone". But I
see you copied code that had this done incorrectly as well.

So that's my first pass at reviewing the code. It looks promising, but
I think there's still a lot more to do to get it up to par with what is
expected for the kernel.

-- Steve


> +		ret = 0;
> +		goto out;
> +	}
> +
> +	ret = unregister_ftrace_function(&trace_ops);
> +	if (ret) {
> +		pr_err("can't unregister ftrace for trace object\n");
> +		goto out;
> +	}
> +	atomic_set(&num_traced_obj, 0);
> +out:
> +	return ret;
> +}
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 8aa493d25c73..265428154638 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1547,6 +1547,45 @@ static struct trace_event trace_func_repeats_event = {
>  	.funcs		= &trace_func_repeats_funcs,
>  };
>  
> +/* TRACE_OBJECT */
> +static enum print_line_t trace_object_print(struct trace_iterator *iter, int flags,
> +					struct trace_event *event)
> +{
> +	struct trace_object_entry *field;
> +	struct trace_seq *s = &iter->seq;
> +
> +	trace_assign_type(field, iter->ent);
> +	print_fn_trace(s, field->ip, field->parent_ip, flags);
> +	trace_seq_printf(s, " object:0x%lx", field->object);
> +	trace_seq_putc(s, '\n');
> +
> +	return trace_handle_return(s);
> +}
> +
> +static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags,
> +				      struct trace_event *event)
> +{
> +	struct trace_object_entry *field;
> +
> +	trace_assign_type(field, iter->ent);
> +
> +	trace_seq_printf(&iter->seq, "%lx %lx\n",
> +			 field->ip,
> +			 field->parent_ip);
> +
> +	return trace_handle_return(&iter->seq);
> +}
> +
> +static struct trace_event_functions trace_object_funcs = {
> +	.trace		= trace_object_print,
> +	.raw		= trace_object_raw,
> +};
> +
> +static struct trace_event trace_object_event = {
> +	.type		= TRACE_OBJECT,
> +	.funcs		= &trace_object_funcs,
> +};
> +
>  static struct trace_event *events[] __initdata = {
>  	&trace_fn_event,
>  	&trace_ctx_event,
> @@ -1561,6 +1600,7 @@ static struct trace_event *events[] __initdata = {
>  	&trace_timerlat_event,
>  	&trace_raw_data_event,
>  	&trace_func_repeats_event,
> +	&trace_object_event,
>  	NULL
>  };
>  

