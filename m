Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25AA47844F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhLQEv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhLQEv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:51:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 20:51:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F5CE62019
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 04:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1D4C36AE1;
        Fri, 17 Dec 2021 04:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639716714;
        bh=M1N1IeB3qtmdnIAcwJrYz4o6behmTa4LjP8Jd44NvGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vB56YO8O+sIgARHCSLPB0FbuTpP0GYznDbT7yx6HYyAGwT/bUyq/Ye9f5fbJNVTP4
         zgf33FK3yuEXziYvRFj017AXkrWo93X2V2sQHQa3MF6xNppqNhXMvZRVxOUCO1YbPW
         6D6QqqOSNRixn4oQ9N9RhARC6SR4Zd4Ec4N/GvImP03Z+FKNwn5bV39JHkr+ZlYCog
         01d3+WxOBHk0UFJ8Z5SEyAD3eiAcjDRHksCRjdvYJ4qg7mU6x5o9BNxycOLdXFBYaz
         pQynXzZEQU7ZV7O4PUqQAYUBMBGyVkbRsbVLkYu52PNnzFdazewvIFLWJkyt8IcN0r
         cAAf8jpOcPJ/A==
Date:   Fri, 17 Dec 2021 13:51:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        zanussi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v6 1/5] trace: Add trace any kernel object
Message-Id: <20211217135149.db5ee4b1b110c845739106d4@kernel.org>
In-Reply-To: <20211129164951.220511-2-xiehuan09@gmail.com>
References: <20211129164951.220511-1-xiehuan09@gmail.com>
        <20211129164951.220511-2-xiehuan09@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 00:49:47 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Introduce objtrace trigger to get the execution flow by tracing
> any kernel object in the kernel parameter.

Here, please add simple usage (no need to add output) since we can
see only this comment after merging this on git log.
If you run `git log -- kernel/trace/` and search "tracing: Add ",
then you can see more examples to add a new feature. ;)

What would you think this?
-----
Introduce objtrace trigger to get the call flow by tracing
any kernel object in the function parameter.

The objtrace trigger makes a list of the target object address from
the given event parameter, and records all kernel function calls
which has the object address in its parameter.

User can identify the kernel call flow related to the object easily.

Syntax:
...

Usage:
...
-----

> 
> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> ---
>  include/linux/trace_events.h        |   1 +
>  kernel/trace/Kconfig                |  10 +
>  kernel/trace/Makefile               |   1 +
>  kernel/trace/trace.h                |   8 +
>  kernel/trace/trace_entries.h        |  17 +
>  kernel/trace/trace_events_trigger.c |   1 +
>  kernel/trace/trace_object.c         | 534 ++++++++++++++++++++++++++++
>  kernel/trace/trace_output.c         |  40 +++
>  8 files changed, 612 insertions(+)
>  create mode 100644 kernel/trace/trace_object.c
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 2d167ac3452c..54baec78ce62 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -684,6 +684,7 @@ enum event_trigger_type {
>  	ETT_EVENT_HIST		= (1 << 4),
>  	ETT_HIST_ENABLE		= (1 << 5),
>  	ETT_EVENT_EPROBE	= (1 << 6),
> +	ETT_TRACE_OBJECT	= (1 << 7),
>  };
>  
>  extern int filter_match_preds(struct event_filter *filter, void *rec);
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 420ff4bc67fd..f69761cbfaaa 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -237,6 +237,16 @@ config FUNCTION_PROFILER
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
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 38715aa6cfdf..46a1301ac47a 100644
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
> @@ -469,6 +470,7 @@ extern void __ftrace_bad_type(void);
>  			  TRACE_GRAPH_RET);		\
>  		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
>  			  TRACE_FUNC_REPEATS);				\
> +		IF_ASSIGN(var, ent, struct trace_object_entry, TRACE_OBJECT);\
>  		__ftrace_bad_type();					\
>  	} while (0)
>  
> @@ -1531,6 +1533,12 @@ static inline int register_trigger_hist_cmd(void) { return 0; }
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
> index 3d5c07239a2a..da2d871fa809 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1687,6 +1687,7 @@ __init int register_trigger_cmds(void)
>  	register_trigger_enable_disable_cmds();
>  	register_trigger_hist_enable_disable_cmds();
>  	register_trigger_hist_cmd();
> +	register_trigger_object_cmd();
>  
>  	return 0;
>  }
> diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
> new file mode 100644
> index 000000000000..83fccd587b63
> --- /dev/null
> +++ b/kernel/trace/trace_object.c
> @@ -0,0 +1,534 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * trace the kernel object in the kernel function parameter
> + * Copyright (C) 2021 Jeff Xie <xiehuan09@gmail.com>
> + */
> +
> +#define pr_fmt(fmt) "trace_object: " fmt
> +
> +#include "trace_output.h"
> +#include <linux/freelist.h>
> +
> +static DEFINE_PER_CPU(atomic_t, trace_object_event_disable);

atomic_t is for atomic operation which must be shared among cpus. On the
other hand, per-cpu variable is used for the core-local storage or flags,
other cpus never touch it. Thus the per-cpu atomic_t is very strange.

> +static DEFINE_RAW_SPINLOCK(object_spin_lock);
> +static struct trace_event_file event_trace_file;
> +static const int max_args_num = 6;
> +static const int max_obj_pool = 10;
> +static atomic_t trace_object_ref;
> +static int exit_trace_object(void);
> +static int init_trace_object(void);
> +

Please add more comments to the code itself. Explain why this is needed
and how it works for which case. That will lead deeper understanding.

> +struct object_instance {
> +	void *object;
> +	struct freelist_node free_list;
> +	struct list_head active_list;
> +};
> +
> +struct obj_pool {
> +	struct freelist_head free_list;
> +	struct list_head active_list;
> +};
> +static struct obj_pool *obj_pool;
> +
> +static bool object_exist(void *obj)
> +{
> +	struct object_instance *inst;
> +	bool ret = false;
> +
> +	list_for_each_entry_rcu(inst, &obj_pool->active_list, active_list) {
> +		if (inst->object == obj) {
> +			ret = true;
> +			goto out;
> +		}
> +	}
> +out:
> +	return ret;
> +}
> +
> +static bool object_empty(void)
> +{
> +	return list_empty(&obj_pool->active_list);
> +}
> +
> +static void set_trace_object(void *obj)
> +{
> +	struct freelist_node *fn;
> +	struct object_instance *ins;
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
> +	fn = freelist_try_get(&obj_pool->free_list);
> +	if (!fn) {
> +		trace_printk("object_pool is full, can't trace object:0x%px\n", obj);
> +		return;
> +	}
> +
> +	ins = container_of(fn, struct object_instance, free_list);
> +	ins->object = obj;
> +
> +	raw_spin_lock_irqsave(&object_spin_lock, flags);
> +	list_add_rcu(&ins->active_list, &obj_pool->active_list);
> +	raw_spin_unlock_irqrestore(&object_spin_lock, flags);

Please add a comment that why this spinlock is needed here and why
other operation doesn't need it.

> +}
> +
> +static inline void free_free_list_objects(struct freelist_head *head)
> +{
> +
> +	struct object_instance *inst;
> +	struct freelist_node *node = head->head;
> +
> +	while (node) {
> +		inst = container_of(node, struct object_instance, free_list);
> +		node = node->next;
> +		kfree(inst);

Note that this is safe only if this free_list is no more accessed.

> +	}
> +}
> +
> +static inline void free_active_list_objects(struct list_head *head)
> +{
> +	struct object_instance *inst;
> +
> +	list_for_each_entry_rcu(inst, head, active_list)
> +		kfree(inst);

No, you can not do this, since the 'inst' is still on the active_list.
Before freeing the 'inst', you need to do list_del_rcu().
Moreover, the 'inst' might be still accessed from the callbacks,
you can not directly free it.

RCU ensures that looping on a list can be done safely before and after
removing/adding a node, but not ensure it is freeable soon, because
someone still looking the node.

I guess you may expect that all callbacks are stopped after calling

unregister_ftrace_function(&trace_ops);

but that is wrong. That don't synchronize the callbacks (= wait
for finishing all running callbacks).
So, you should use synchronize_rcu() after that.

> +}
> +
> +static inline void free_object_pool(void)
> +{
> +	free_free_list_objects(&obj_pool->free_list);
> +	free_active_list_objects(&obj_pool->active_list);

BTW, did you also ensure all the trigger callback has been done?
set_trace_object() has a small time window when the object_instance
is not linked to both of the free_list and the active_list.
Thus you have to make sure that the function is never called while
this function. (How to do it? please write the comment about it)

> +	kfree(obj_pool);
> +}
> +
> +
> +static int init_object_pool(void)
> +{
> +	struct object_instance *inst;
> +	int i, ret = 0;
> +
> +	obj_pool = kzalloc(sizeof(*obj_pool), GFP_KERNEL);
> +	if (!obj_pool) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	INIT_LIST_HEAD(&obj_pool->active_list);
> +
> +	for (i = 0; i < max_obj_pool; i++) {
> +		inst = kzalloc(sizeof(*inst), GFP_KERNEL);
> +		if (!inst) {
> +			free_object_pool();
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		freelist_add(&inst->free_list, &obj_pool->free_list);
> +	}
> +out:
> +	return ret;
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
> +	struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> +	unsigned long obj;
> +	long disabled;
> +	int cpu, n;
> +
> +	preempt_disable_notrace();
> +
> +	cpu = raw_smp_processor_id();
> +	disabled = atomic_inc_return(&per_cpu(trace_object_event_disable, cpu));

So what is the purpose of this check? (are there any issue if the same
cpu reenter here?)

> +
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

Please add a comment why don't you break the loop after finding
any trace object here.

> +	}
> +
> +out:
> +	atomic_dec(&per_cpu(trace_object_event_disable, cpu));
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
> +
> +	struct ftrace_event_field *field = data->private_data;
> +	void *obj = NULL;
> +
> +	memcpy(&obj, rec + field->offset, sizeof(obj));
> +	set_trace_object(obj);
> +}
> +

/* This is clone of event_trigger_free(). */

> +static void
> +trace_object_trigger_free(struct event_trigger_ops *ops,
> +		   struct event_trigger_data *data)
> +{
> +	if (WARN_ON_ONCE(data->ref <= 0))
> +		return;
> +
> +	data->ref--;
> +	if (!data->ref)
> +		trigger_data_free(data);
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

/* This is the clone of event_trigger_init() */

> +static int event_object_trigger_init(struct event_trigger_ops *ops,
> +		       struct event_trigger_data *data)
> +{
> +	data->ref++;
> +	return 0;
> +}


At this moment, I think cloning those functions are OK. But after merged
and enough tested, trigger should expose these functions and this
should use it.


BTW, it seems you are sharing the trace object active_list (obj_pool::active_list)
among all object trace triggers. This means if user sets one objtrace trigger
on 2 events and remove from one event, the active_list still have the object
which sets by the event we removed. If it is correct, I think this should be
noted in the document.
Something like;

Note that currently this is not designed to trace objects of different types
at the same time. You must set an objtrace trigger to only one event, or
you must carefully choose the same type object when you set the objtrace on
differnt events. Also, the traced object list is not cleared unless all
triggers are removed.


> +
> +static int
> +event_trigger_print(const char *name, struct seq_file *m,
> +		    void *data, char *filter_str)
> +{
> +	long count = (long)data;
> +
> +	seq_puts(m, name);
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
> +				   data->filter_str);
> +}
> +
> +static struct event_trigger_ops objecttrace_trigger_ops = {
> +	.func			= trace_object_trigger,
> +	.print			= trace_object_trigger_print,
> +	.init			= event_object_trigger_init,
> +	.free			= trace_object_trigger_free,
> +};
> +
> +static struct event_trigger_ops objecttrace_count_trigger_ops = {
> +	.func			= trace_object_count_trigger,
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
> +static int register_object_trigger(char *glob, struct event_trigger_ops *ops,
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
> +			goto out;
> +		}
> +	}
> +
> +	if (data->ops->init) {
> +		ret = data->ops->init(data->ops, data);
> +		if (ret < 0)
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
> +	init_trace_object();
> +out:
> +	return ret;
> +}
> +
> +static void unregister_object_trigger(char *glob, struct event_trigger_ops *ops,
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
> +	if (unregistered && data->ops->free) {
> +		data->ops->free(data->ops, data);
> +		exit_trace_object();
> +	}

isn't this the following? Can you skip exit_trace_object() 
if data->ops->free == NULL?

	if (unregistered) {
		if (data->ops->free)
			data->ops->free(data->ops, data);
		exit_trace_object();
	}

Thank you,


> +}
> +
> +static int
> +event_object_trigger_callback(struct event_command *cmd_ops,
> +		       struct trace_event_file *file,
> +		       char *glob, char *cmd, char *param)
> +{
> +	struct event_trigger_data *trigger_data;
> +	struct event_trigger_ops *trigger_ops;
> +	struct trace_event_call *call;
> +	struct ftrace_event_field *field;
> +	char *objtrace_cmd;
> +	char *trigger = NULL;
> +	char *arg;
> +	char *number;
> +	int ret;
> +
> +	ret = -EINVAL;
> +	if (!param)
> +		goto out;
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
> +
> +	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
> +
> +	ret = -ENOMEM;
> +	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
> +	if (!trigger_data)
> +		goto out;
> +
> +	trigger_data->count = -1;
> +	trigger_data->ops = trigger_ops;
> +	trigger_data->cmd_ops = cmd_ops;
> +	trigger_data->private_data = field;
> +	INIT_LIST_HEAD(&trigger_data->list);
> +	INIT_LIST_HEAD(&trigger_data->named_list);
> +
> +	if (glob[0] == '!') {
> +		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
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
> +	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> +	/*
> +	 * The above returns on success the # of functions enabled,
> +	 * but if it didn't find any functions it returns zero.
> +	 * Consider no functions a failure too.
> +	 */
> +	if (!ret) {
> +		cmd_ops->unreg(glob, trigger_ops, trigger_data, file);
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
> +	kfree(trigger_data);
> +	goto out;
> +}
> +
> +static struct event_command trigger_object_cmd = {
> +	.name			= "objtrace",
> +	.trigger_type		= ETT_TRACE_OBJECT,
> +	.flags			= EVENT_CMD_FL_NEEDS_REC,
> +	.func			= event_object_trigger_callback,
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
> +	ret = init_object_pool();
> +	if (ret)
> +		goto out;
> +
> +	event_trace_file.tr = top_trace_array();
> +	if (WARN_ON(!event_trace_file.tr)) {
> +		ret = -1;
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
> +	if (WARN_ON_ONCE(atomic_read(&trace_object_ref) <= 0))
> +		goto out;
> +
> +	if (atomic_dec_return(&trace_object_ref) != 0) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	ret = unregister_ftrace_function(&trace_ops);
> +	if (ret) {
> +		pr_err("can't unregister ftrace for trace object\n");
> +		goto out;
> +	}
> +	free_object_pool();
> +out:
> +	return ret;
> +}
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 3547e7176ff7..d747aed27104 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1543,6 +1543,45 @@ static struct trace_event trace_func_repeats_event = {
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
> @@ -1557,6 +1596,7 @@ static struct trace_event *events[] __initdata = {
>  	&trace_timerlat_event,
>  	&trace_raw_data_event,
>  	&trace_func_repeats_event,
> +	&trace_object_event,
>  	NULL
>  };
>  
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
