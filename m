Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF3A47BB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhLUHgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:36:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50558 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhLUHgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:36:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 835D661166
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A321AC36AE2;
        Tue, 21 Dec 2021 07:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640072170;
        bh=/hzNCPNil+d2z+5t9HQNki6RxLHeexeIGFcMdgZDZmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dIIQriIx4hqJQtZuOaZXhwa7y+MkXJKRybp5CkeqKsrRgFUk4o6XTJ7LokImN+sfm
         KJkrjya6f1oKc8I8N18osWboo8J+nuOeXGSveTfJSOWCV68Gwdc8rS+kbZXL1OyPua
         3wsinXgr6VAU7Tq2xPx6IYaXj65emApMlHG5ha9BZst7sCvkJ9ikI7VkEcYWP2GNRO
         1EnsaAuG3Q4+CwS0GuoGlgCgJ8A+xB0td0NW1I///yiPQpbHGbN2VEo2h94/JXrPzI
         cl6UijlOz85xx9pJz7G8oNvzkCYpOi8bxMnKP/JnbAyfgIOXSHVSXSPkAvO/7CtlOp
         JxoxSoMaVuNew==
Date:   Tue, 21 Dec 2021 16:36:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v6 1/5] trace: Add trace any kernel object
Message-Id: <20211221163606.be53698d89ce08a272810ae1@kernel.org>
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

Hi Jeff,

On Sat, 18 Dec 2021 00:32:57 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

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
> I agree, I will add it.

BTW, I have another better solution for object pool. If the
object pool size is fixed (of course to avoid performance overhead,
it should be small enough) and it can not avoid using spinlock, 
it is better to use fixed-size array. That makes the implementation
much simpler.

static struct object_instance {
	void *obj;	/* trace object */
	// add offset in the next patch	
} traced_obj[MAX_TRACE_OBJECT];

static atomic_t num_traced_obj;
static DEFINE_RAW_SPINLOCK(trace_obj_lock);

static void set_trace_object(void *obj)
{
	...

	raw_spin_lock_irqsave(&trace_obj_lock, flags);
	if (num_traced_obj == MAX_TRACED_OBJECT)
		goto out;

	traced_obj[num_traced_obj].obj = obj;
	smp_wmb();	// make sure the num_traced_obj update always appears after trace_obj update. 
	num_traced_obj++;
out:
	raw_spin_unlock_irqrestore(&trace_obj_lock, flags);
}

static bool object_exist(void *obj)
{
	...
	max = num_traced_obj;
	smp_rmb();	// then the num_traced_obj will cap the max.
	for (i = 0; i < max; i++) {
		if (traced_obj[i].obj == obj)
			return true;
	}
	return false;
}

static inline void free_object_pool(void)
{
	num_traced_obj = 0;
	memset(traced_obj, 0, sizeof(traced_obj));
}

Sorry if I confuse you but I think you shouldn't take a time on those unneeded
complexity. :)


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

Maybe you can use ftrace_test_recursion_trylock(), as kprobe_ftrace_handler()
does.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
