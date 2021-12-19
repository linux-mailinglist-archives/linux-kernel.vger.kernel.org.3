Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD3479EF5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 04:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhLSDHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 22:07:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44576 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhLSDHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 22:07:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97AFF60C82
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 03:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C997C36AE2;
        Sun, 19 Dec 2021 03:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639883249;
        bh=m4qyV1EFQ8n6BCfVj5RqzZgFkRHYpZpmFy1/KBkDpy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PIktscm6lR4OVDpV4u+eQDflFHfMHEI2I6Xo0tMHo+FyA3g3B4cts+MCHrHUjsDfS
         //ByaL9Y8SeEsD/2PZe0mnxmEO3yg6f/zMtZPiw9pmZsTsG2+1dUt6y8fo3LWHFnMn
         bN741z2Us42lLfz/t9iR2w9hIIEaXSv2JB2TRGWuaIX9TP29ahMfe8Oqkj7Ak4+lmZ
         A3hmpAaEfHOb2x83XQnmOjwk3MCrij6i8FbpBNE1Qa6Qsbnv5gFsM8gOaDopD3oj0z
         XhbDHsPEAprmKpPB/hNjrNcnYbduRRlK7kc30MfWdasI5ucBp+16WwGauKdey7Nhrq
         NaWIdyyxzSRCA==
Date:   Sun, 19 Dec 2021 12:07:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v6 1/5] trace: Add trace any kernel object
Message-Id: <20211219120723.df2a892e2b4b7caec8905503@kernel.org>
In-Reply-To: <CAEr6+EAn3+vWvp46mheO=MTetLyHXy-GDENtN8O6y+5T+Y-N7w@mail.gmail.com>
References: <20211129164951.220511-1-xiehuan09@gmail.com>
        <20211129164951.220511-2-xiehuan09@gmail.com>
        <20211217135149.db5ee4b1b110c845739106d4@kernel.org>
        <CAEr6+EAn3+vWvp46mheO=MTetLyHXy-GDENtN8O6y+5T+Y-N7w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 00:32:57 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Hi Masami,
> 
> Thanks for your review.
> 
> On Fri, Dec 17, 2021 at 12:51 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 30 Nov 2021 00:49:47 +0800
> > Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > > Introduce objtrace trigger to get the execution flow by tracing
> > > any kernel object in the kernel parameter.
> >
> > Here, please add simple usage (no need to add output) since we can
> > see only this comment after merging this on git log.
> > If you run `git log -- kernel/trace/` and search "tracing: Add ",
> > then you can see more examples to add a new feature. ;)
> >
> > What would you think this?
> > -----
> > Introduce objtrace trigger to get the call flow by tracing
> > any kernel object in the function parameter.
> >
> > The objtrace trigger makes a list of the target object address from
> > the given event parameter, and records all kernel function calls
> > which has the object address in its parameter.
> >
> > User can identify the kernel call flow related to the object easily.
> >
> > Syntax:
> > ...
> >
> > Usage:
> > ...
> 
> I agree, I will add it.
> 
> > -----
> >
> > >
> > > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > > ---
> > >  include/linux/trace_events.h        |   1 +
> > >  kernel/trace/Kconfig                |  10 +
> > >  kernel/trace/Makefile               |   1 +
> > >  kernel/trace/trace.h                |   8 +
> > >  kernel/trace/trace_entries.h        |  17 +
> > >  kernel/trace/trace_events_trigger.c |   1 +
> > >  kernel/trace/trace_object.c         | 534 ++++++++++++++++++++++++++++
> > >  kernel/trace/trace_output.c         |  40 +++
> > >  8 files changed, 612 insertions(+)
> > >  create mode 100644 kernel/trace/trace_object.c
> > >
> > > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > > index 2d167ac3452c..54baec78ce62 100644
> > > --- a/include/linux/trace_events.h
> > > +++ b/include/linux/trace_events.h
> > > @@ -684,6 +684,7 @@ enum event_trigger_type {
> > >       ETT_EVENT_HIST          = (1 << 4),
> > >       ETT_HIST_ENABLE         = (1 << 5),
> > >       ETT_EVENT_EPROBE        = (1 << 6),
> > > +     ETT_TRACE_OBJECT        = (1 << 7),
> > >  };
> > >
> > >  extern int filter_match_preds(struct event_filter *filter, void *rec);
> > > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > > index 420ff4bc67fd..f69761cbfaaa 100644
> > > --- a/kernel/trace/Kconfig
> > > +++ b/kernel/trace/Kconfig
> > > @@ -237,6 +237,16 @@ config FUNCTION_PROFILER
> > >
> > >         If in doubt, say N.
> > >
> > > +config TRACE_OBJECT
> > > +     bool "Trace kernel object in function parameter"
> > > +     depends on FUNCTION_TRACER
> > > +     depends on HAVE_FUNCTION_ARG_ACCESS_API
> > > +     select TRACING
> > > +     default y
> > > +     help
> > > +      You can trace the kernel object in the kernel function parameter.
> > > +      The kernel object is dynamically specified via event trigger.
> > > +
> > >  config STACK_TRACER
> > >       bool "Trace max stack"
> > >       depends on HAVE_FUNCTION_TRACER
> > > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > > index bedc5caceec7..b924b8e55922 100644
> > > --- a/kernel/trace/Makefile
> > > +++ b/kernel/trace/Makefile
> > > @@ -67,6 +67,7 @@ obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
> > >  obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
> > >  obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
> > >  obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += fgraph.o
> > > +obj-$(CONFIG_TRACE_OBJECT) += trace_object.o
> > >  ifeq ($(CONFIG_BLOCK),y)
> > >  obj-$(CONFIG_EVENT_TRACING) += blktrace.o
> > >  endif
> > > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > > index 38715aa6cfdf..46a1301ac47a 100644
> > > --- a/kernel/trace/trace.h
> > > +++ b/kernel/trace/trace.h
> > > @@ -54,6 +54,7 @@ enum trace_type {
> > >       TRACE_TIMERLAT,
> > >       TRACE_RAW_DATA,
> > >       TRACE_FUNC_REPEATS,
> > > +     TRACE_OBJECT,
> > >
> > >       __TRACE_LAST_TYPE,
> > >  };
> > > @@ -469,6 +470,7 @@ extern void __ftrace_bad_type(void);
> > >                         TRACE_GRAPH_RET);             \
> > >               IF_ASSIGN(var, ent, struct func_repeats_entry,          \
> > >                         TRACE_FUNC_REPEATS);                          \
> > > +             IF_ASSIGN(var, ent, struct trace_object_entry, TRACE_OBJECT);\
> > >               __ftrace_bad_type();                                    \
> > >       } while (0)
> > >
> > > @@ -1531,6 +1533,12 @@ static inline int register_trigger_hist_cmd(void) { return 0; }
> > >  static inline int register_trigger_hist_enable_disable_cmds(void) { return 0; }
> > >  #endif
> > >
> > > +#ifdef CONFIG_TRACE_OBJECT
> > > +extern int register_trigger_object_cmd(void);
> > > +#else
> > > +static inline int register_trigger_object_cmd(void) { return 0; }
> > > +#endif
> > > +
> > >  extern int register_trigger_cmds(void);
> > >  extern void clear_event_triggers(struct trace_array *tr);
> > >
> > > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> > > index cd41e863b51c..bb120d9498a9 100644
> > > --- a/kernel/trace/trace_entries.h
> > > +++ b/kernel/trace/trace_entries.h
> > > @@ -401,3 +401,20 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
> > >                __entry->context,
> > >                __entry->timer_latency)
> > >  );
> > > +
> > > +/*
> > > + * trace object entry:
> > > + */
> > > +FTRACE_ENTRY(object, trace_object_entry,
> > > +
> > > +     TRACE_OBJECT,
> > > +
> > > +     F_STRUCT(
> > > +             __field(        unsigned long,          ip              )
> > > +             __field(        unsigned long,          parent_ip       )
> > > +             __field(        unsigned long,          object          )
> > > +     ),
> > > +
> > > +     F_printk(" %ps <-- %ps object:%lx\n",
> > > +              (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
> > > +);
> > > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> > > index 3d5c07239a2a..da2d871fa809 100644
> > > --- a/kernel/trace/trace_events_trigger.c
> > > +++ b/kernel/trace/trace_events_trigger.c
> > > @@ -1687,6 +1687,7 @@ __init int register_trigger_cmds(void)
> > >       register_trigger_enable_disable_cmds();
> > >       register_trigger_hist_enable_disable_cmds();
> > >       register_trigger_hist_cmd();
> > > +     register_trigger_object_cmd();
> > >
> > >       return 0;
> > >  }
> > > diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
> > > new file mode 100644
> > > index 000000000000..83fccd587b63
> > > --- /dev/null
> > > +++ b/kernel/trace/trace_object.c
> > > @@ -0,0 +1,534 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * trace the kernel object in the kernel function parameter
> > > + * Copyright (C) 2021 Jeff Xie <xiehuan09@gmail.com>
> > > + */
> > > +
> > > +#define pr_fmt(fmt) "trace_object: " fmt
> > > +
> > > +#include "trace_output.h"
> > > +#include <linux/freelist.h>
> > > +
> > > +static DEFINE_PER_CPU(atomic_t, trace_object_event_disable);
> >
> > atomic_t is for atomic operation which must be shared among cpus. On the
> > other hand, per-cpu variable is used for the core-local storage or flags,
> > other cpus never touch it. Thus the per-cpu atomic_t is very strange.
> >
> 
> From the patch V1, I cloned it from the  function_test_events_call()
> in kernel/trace/trace_events.c
> 
> commit: 9ea21c1ecdb35ecdcac5fd9d95f62a1f6a7ffec0
> tracing/events: perform function tracing in event selftests
> Author:     Steven Rostedt <srostedt@redhat.com>

Hmm, OK.

> 
> It should be to prevent being preempted by the interrupt context in
> the process of adding one

Yeah, I think so.

The commit says "some bugs" but it is not sure what actually needs to be
cared.

    tracing/events: perform function tracing in event selftests
    
    We can find some bugs in the trace events if we stress the writes as well.
    The function tracer is a good way to stress the events.

Steve, can you tell me what was the problem?

I think we don't need per-cpu atomic_t because the counter is increment
and decrement. Thus when quiting the nested ftrace handler on the same CPU,
the counter comes back to the same value. We don't need to care about
atomic increment.

I mean, if we use the normal per-cpu "unsigned int" as a counter, the
operation of "counter++" becomes;

load counter to reg1
[1]
reg1 = reg1 + 1
store reg1 to counter

And if an interrupt occurs at [1], the following happens.

load counter to reg1 # counter = 0

  (interrupt - save reg1)
  load counter to reg1  # counter = 0
  reg1 = reg1 + 1
  store reg1 to counter  # counter = 1
  ...
  load counter to reg1  # counter = 1
  reg1 = reg1 - 1
  store reg1 to counter  # counter = 0
  (iret - restore reg1)

reg1 = reg1 + 1
store reg1 to counter

So, even if the operation is not atomic, there seems no problem.
What else scenario we have to worry?

(BTW, what is the ftrace_test_recursion_trylock()? Is that also
for detecting nesting case??)

> > > +static DEFINE_RAW_SPINLOCK(object_spin_lock);
> > > +static struct trace_event_file event_trace_file;
> > > +static const int max_args_num = 6;
> > > +static const int max_obj_pool = 10;
> > > +static atomic_t trace_object_ref;
> > > +static int exit_trace_object(void);
> > > +static int init_trace_object(void);
> > > +
> >
> > Please add more comments to the code itself. Explain why this is needed
> > and how it works for which case. That will lead deeper understanding.
> >
> 
> I agree, I will add more comments in the next version.
> 
> > > +struct object_instance {
> > > +     void *object;
> > > +     struct freelist_node free_list;
> > > +     struct list_head active_list;
> > > +};
> > > +
> > > +struct obj_pool {
> > > +     struct freelist_head free_list;
> > > +     struct list_head active_list;
> > > +};
> > > +static struct obj_pool *obj_pool;
> > > +
> > > +static bool object_exist(void *obj)
> > > +{
> > > +     struct object_instance *inst;
> > > +     bool ret = false;
> > > +
> > > +     list_for_each_entry_rcu(inst, &obj_pool->active_list, active_list) {
> > > +             if (inst->object == obj) {
> > > +                     ret = true;
> > > +                     goto out;
> > > +             }
> > > +     }
> > > +out:
> > > +     return ret;
> > > +}
> > > +
> > > +static bool object_empty(void)
> > > +{
> > > +     return list_empty(&obj_pool->active_list);
> > > +}
> > > +
> > > +static void set_trace_object(void *obj)
> > > +{
> > > +     struct freelist_node *fn;
> > > +     struct object_instance *ins;
> > > +     unsigned long flags;
> > > +
> > > +     if (in_nmi())
> > > +             return;
> > > +
> > > +     if (!obj)
> > > +             return;
> > > +
> > > +     if (object_exist(obj))
> > > +             return;
> > > +
> > > +     fn = freelist_try_get(&obj_pool->free_list);
> > > +     if (!fn) {
> > > +             trace_printk("object_pool is full, can't trace object:0x%px\n", obj);
> > > +             return;
> > > +     }
> > > +
> > > +     ins = container_of(fn, struct object_instance, free_list);
> > > +     ins->object = obj;
> > > +
> > > +     raw_spin_lock_irqsave(&object_spin_lock, flags);
> > > +     list_add_rcu(&ins->active_list, &obj_pool->active_list);
> > > +     raw_spin_unlock_irqrestore(&object_spin_lock, flags);
> >
> > Please add a comment that why this spinlock is needed here and why
> > other operation doesn't need it.
> 
> (Only this place has write operations, and it cannot be concurrent)

Yes and such comment helps us when objtrace supports "del" command too. :)

> I agree, I will add it.
> 
> > > +}
> > > +
> > > +static inline void free_free_list_objects(struct freelist_head *head)
> > > +{
> > > +
> > > +     struct object_instance *inst;
> > > +     struct freelist_node *node = head->head;
> > > +
> > > +     while (node) {
> > > +             inst = container_of(node, struct object_instance, free_list);
> > > +             node = node->next;
> > > +             kfree(inst);
> >
> > Note that this is safe only if this free_list is no more accessed.
> >
> 
> Maybe it need to use rcu to handle it , I will think about how to  fix
> it in the next version.

Yes, what you need is a synchronize_rcu().

> 
> > > +     }
> > > +}
> > > +
> > > +static inline void free_active_list_objects(struct list_head *head)
> > > +{
> > > +     struct object_instance *inst;
> > > +
> > > +     list_for_each_entry_rcu(inst, head, active_list)
> > > +             kfree(inst);
> >
> > No, you can not do this, since the 'inst' is still on the active_list.
> > Before freeing the 'inst', you need to do list_del_rcu().
> > Moreover, the 'inst' might be still accessed from the callbacks,
> > you can not directly free it.
> >
> > RCU ensures that looping on a list can be done safely before and after
> > removing/adding a node, but not ensure it is freeable soon, because
> > someone still looking the node.
> >
> > I guess you may expect that all callbacks are stopped after calling
> 
> Yes you guessed it right ;-)
> 
> > unregister_ftrace_function(&trace_ops);
> >
> > but that is wrong. That don't synchronize the callbacks (= wait
> > for finishing all running callbacks).
> > So, you should use synchronize_rcu() after that.
> 
> Thanks,  I will fix it.

Thanks, it maybe hard to notice. Since the synchronize_rcu() is a time
taking operation, trace_event subsystem carefully chooses the calling
point. (e.g. where all user specified operation was done)

> > > +}
> > > +
> > > +static inline void free_object_pool(void)
> > > +{
> > > +     free_free_list_objects(&obj_pool->free_list);
> > > +     free_active_list_objects(&obj_pool->active_list);
> >
> > BTW, did you also ensure all the trigger callback has been done?
> > set_trace_object() has a small time window when the object_instance
> > is not linked to both of the free_list and the active_list.
> > Thus you have to make sure that the function is never called while
> > this function. (How to do it? please write the comment about it)
> 
> I ignored this small time window, maybe use the rcu can handle it, I
> will think about how to fix it.
> 
> > > +     kfree(obj_pool);
> > > +}
> > > +
> > > +
> > > +static int init_object_pool(void)
> > > +{
> > > +     struct object_instance *inst;
> > > +     int i, ret = 0;
> > > +
> > > +     obj_pool = kzalloc(sizeof(*obj_pool), GFP_KERNEL);
> > > +     if (!obj_pool) {
> > > +             ret = -ENOMEM;
> > > +             goto out;
> > > +     }
> > > +
> > > +     INIT_LIST_HEAD(&obj_pool->active_list);
> > > +
> > > +     for (i = 0; i < max_obj_pool; i++) {
> > > +             inst = kzalloc(sizeof(*inst), GFP_KERNEL);
> > > +             if (!inst) {
> > > +                     free_object_pool();
> > > +                     ret = -ENOMEM;
> > > +                     goto out;
> > > +             }
> > > +             freelist_add(&inst->free_list, &obj_pool->free_list);
> > > +     }
> > > +out:
> > > +     return ret;
> > > +}
> > > +
> > > +static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> > > +                              unsigned long object)
> > > +{
> > > +
> > > +     struct trace_buffer *buffer;
> > > +     struct ring_buffer_event *event;
> > > +     struct trace_object_entry *entry;
> > > +     int pc;
> > > +
> > > +     pc = preempt_count();
> > > +     event = trace_event_buffer_lock_reserve(&buffer, &event_trace_file,
> > > +                     TRACE_OBJECT, sizeof(*entry), pc);
> > > +     if (!event)
> > > +             return;
> > > +     entry   = ring_buffer_event_data(event);
> > > +     entry->ip                       = ip;
> > > +     entry->parent_ip                = parent_ip;
> > > +     entry->object                   = object;
> > > +
> > > +     event_trigger_unlock_commit(&event_trace_file, buffer, event,
> > > +             entry, pc);
> > > +}
> > > +
> > > +static void
> > > +trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> > > +             struct ftrace_ops *op, struct ftrace_regs *fregs)
> > > +{
> > > +     struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> > > +     unsigned long obj;
> > > +     long disabled;
> > > +     int cpu, n;
> > > +
> > > +     preempt_disable_notrace();
> > > +
> > > +     cpu = raw_smp_processor_id();
> > > +     disabled = atomic_inc_return(&per_cpu(trace_object_event_disable, cpu));
> >
> > So what is the purpose of this check? (are there any issue if the same
> > cpu reenter here?)
> >
> 
> There may be an interrupt context that can preempt it. I am not yet
> sure whether the cpu reenter  will affect it.
> I will debug and test it. (Referred from function_test_events_call())

I think what you need is ftrace_test_recursion_trylock(). Please
check the "Protect your callback" section in Documentation/trace/ftrace-uses.rst.

> 
> > > +
> > > +     if (disabled != 1)
> > > +             goto out;
> > > +
> > > +     if (object_empty())
> > > +             goto out;
> > > +
> > > +     for (n = 0; n < max_args_num; n++) {
> > > +             obj = regs_get_kernel_argument(pt_regs, n);
> > > +             if (object_exist((void *)obj))
> > > +                     submit_trace_object(ip, parent_ip, obj);
> >
> > Please add a comment why don't you break the loop after finding
> > any trace object here.
> >
> (because the parameters of a function may match multiple objects)
> I will add the comment in the next version.

good :)

> 
> > > +     }
> > > +
> > > +out:
> > > +     atomic_dec(&per_cpu(trace_object_event_disable, cpu));
> > > +     preempt_enable_notrace();
> > > +}
> > > +
> > > +static struct ftrace_ops trace_ops = {
> > > +     .func  = trace_object_events_call,
> > > +     .flags = FTRACE_OPS_FL_SAVE_REGS,
> > > +};
> > > +
> > > +static void
> > > +trace_object_trigger(struct event_trigger_data *data,
> > > +                struct trace_buffer *buffer,  void *rec,
> > > +                struct ring_buffer_event *event)
> > > +{
> > > +
> > > +     struct ftrace_event_field *field = data->private_data;
> > > +     void *obj = NULL;
> > > +
> > > +     memcpy(&obj, rec + field->offset, sizeof(obj));
> > > +     set_trace_object(obj);
> > > +}
> > > +
> >
> > /* This is clone of event_trigger_free(). */
> >
> > > +static void
> > > +trace_object_trigger_free(struct event_trigger_ops *ops,
> > > +                struct event_trigger_data *data)
> > > +{
> > > +     if (WARN_ON_ONCE(data->ref <= 0))
> > > +             return;
> > > +
> > > +     data->ref--;
> > > +     if (!data->ref)
> > > +             trigger_data_free(data);
> > > +}
> > > +
> > > +static void
> > > +trace_object_count_trigger(struct event_trigger_data *data,
> > > +                      struct trace_buffer *buffer, void *rec,
> > > +                      struct ring_buffer_event *event)
> > > +{
> > > +     if (!data->count)
> > > +             return;
> > > +
> > > +     if (data->count != -1)
> > > +             (data->count)--;
> > > +
> > > +     trace_object_trigger(data, buffer, rec, event);
> > > +}
> > > +
> >
> > /* This is the clone of event_trigger_init() */
> >
> > > +static int event_object_trigger_init(struct event_trigger_ops *ops,
> > > +                    struct event_trigger_data *data)
> > > +{
> > > +     data->ref++;
> > > +     return 0;
> > > +}
> >
> >
> > At this moment, I think cloning those functions are OK. But after merged
> > and enough tested, trigger should expose these functions and this
> > should use it.
> 
> I agree.
> 
> >
> > BTW, it seems you are sharing the trace object active_list (obj_pool::active_list)
> > among all object trace triggers. This means if user sets one objtrace trigger
> > on 2 events and remove from one event, the active_list still have the object
> > which sets by the event we removed. If it is correct, I think this should be
> > noted in the document.
> > Something like;
> >
> > Note that currently this is not designed to trace objects of different types
> > at the same time. You must set an objtrace trigger to only one event, or
> > you must carefully choose the same type object when you set the objtrace on
> > differnt events. Also, the traced object list is not cleared unless all
> > triggers are removed.
> >
> Thanks, I agree, I will add it.
> >
> > > +
> > > +static int
> > > +event_trigger_print(const char *name, struct seq_file *m,
> > > +                 void *data, char *filter_str)
> > > +{
> > > +     long count = (long)data;
> > > +
> > > +     seq_puts(m, name);
> > > +
> > > +     if (count == -1)
> > > +             seq_puts(m, ":unlimited");
> > > +     else
> > > +             seq_printf(m, ":count=%ld", count);
> > > +
> > > +     if (filter_str)
> > > +             seq_printf(m, " if %s\n", filter_str);
> > > +     else
> > > +             seq_putc(m, '\n');
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int
> > > +trace_object_trigger_print(struct seq_file *m, struct event_trigger_ops *ops,
> > > +                      struct event_trigger_data *data)
> > > +{
> > > +     return event_trigger_print("objtrace", m, (void *)data->count,
> > > +                                data->filter_str);
> > > +}
> > > +
> > > +static struct event_trigger_ops objecttrace_trigger_ops = {
> > > +     .func                   = trace_object_trigger,
> > > +     .print                  = trace_object_trigger_print,
> > > +     .init                   = event_object_trigger_init,
> > > +     .free                   = trace_object_trigger_free,
> > > +};
> > > +
> > > +static struct event_trigger_ops objecttrace_count_trigger_ops = {
> > > +     .func                   = trace_object_count_trigger,
> > > +     .print                  = trace_object_trigger_print,
> > > +     .init                   = event_object_trigger_init,
> > > +     .free                   = trace_object_trigger_free,
> > > +};
> > > +
> > > +static struct event_trigger_ops *
> > > +objecttrace_get_trigger_ops(char *cmd, char *param)
> > > +{
> > > +     return param ? &objecttrace_count_trigger_ops : &objecttrace_trigger_ops;
> > > +}
> > > +
> > > +static int register_object_trigger(char *glob, struct event_trigger_ops *ops,
> > > +                         struct event_trigger_data *data,
> > > +                         struct trace_event_file *file)
> > > +{
> > > +     struct event_trigger_data *test;
> > > +     int ret = 0;
> > > +
> > > +     lockdep_assert_held(&event_mutex);
> > > +
> > > +     list_for_each_entry(test, &file->triggers, list) {
> > > +             if (test->cmd_ops->trigger_type == data->cmd_ops->trigger_type) {
> > > +                     ret = -EEXIST;
> > > +                     goto out;
> > > +             }
> > > +     }
> > > +
> > > +     if (data->ops->init) {
> > > +             ret = data->ops->init(data->ops, data);
> > > +             if (ret < 0)
> > > +                     goto out;
> > > +     }
> > > +
> > > +     list_add_rcu(&data->list, &file->triggers);
> > > +     ret++;
> > > +
> > > +     update_cond_flag(file);
> > > +     if (trace_event_trigger_enable_disable(file, 1) < 0) {
> > > +             list_del_rcu(&data->list);
> > > +             update_cond_flag(file);
> > > +             ret--;
> > > +     }
> > > +     init_trace_object();
> > > +out:
> > > +     return ret;
> > > +}
> > > +
> > > +static void unregister_object_trigger(char *glob, struct event_trigger_ops *ops,
> > > +                            struct event_trigger_data *test,
> > > +                            struct trace_event_file *file)
> > > +{
> > > +     struct event_trigger_data *data;
> > > +     bool unregistered = false;
> > > +
> > > +     lockdep_assert_held(&event_mutex);
> > > +
> > > +     list_for_each_entry(data, &file->triggers, list) {
> > > +             if (data->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
> > > +                     unregistered = true;
> > > +                     list_del_rcu(&data->list);
> > > +                     trace_event_trigger_enable_disable(file, 0);
> > > +                     update_cond_flag(file);
> > > +                     break;
> > > +             }
> > > +     }
> > > +
> > > +     if (unregistered && data->ops->free) {
> > > +             data->ops->free(data->ops, data);
> > > +             exit_trace_object();
> > > +     }
> >
> > isn't this the following? Can you skip exit_trace_object()
> > if data->ops->free == NULL?
> >
> >         if (unregistered) {
> >                 if (data->ops->free)
> >                         data->ops->free(data->ops, data);
> >                 exit_trace_object();
> >         }
> 
> Thanks, this one would be better, although data->ops->free  is not
> empty at the moment.
> 
>

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
