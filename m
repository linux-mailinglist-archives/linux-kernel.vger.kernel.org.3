Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA2B487FE3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiAHAVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiAHAVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:21:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64DEC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:21:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 552B362030
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 00:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22156C36AE5;
        Sat,  8 Jan 2022 00:21:16 +0000 (UTC)
Date:   Fri, 7 Jan 2022 19:21:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jeff Xie <xiehuan09@gmail.com>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v6 1/5] trace: Add trace any kernel object
Message-ID: <20220107192114.3389b5a0@gandalf.local.home>
In-Reply-To: <20211219120723.df2a892e2b4b7caec8905503@kernel.org>
References: <20211129164951.220511-1-xiehuan09@gmail.com>
        <20211129164951.220511-2-xiehuan09@gmail.com>
        <20211217135149.db5ee4b1b110c845739106d4@kernel.org>
        <CAEr6+EAn3+vWvp46mheO=MTetLyHXy-GDENtN8O6y+5T+Y-N7w@mail.gmail.com>
        <20211219120723.df2a892e2b4b7caec8905503@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply, I'm currently unemployed (for another week) and
was spending all my time renovating my office. I finished my office and I'm
now trying to get back up to speed.

On Sun, 19 Dec 2021 12:07:23 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> > > > +#include "trace_output.h"
> > > > +#include <linux/freelist.h>
> > > > +
> > > > +static DEFINE_PER_CPU(atomic_t, trace_object_event_disable);  
> > >
> > > atomic_t is for atomic operation which must be shared among cpus. On the
> > > other hand, per-cpu variable is used for the core-local storage or flags,
> > > other cpus never touch it. Thus the per-cpu atomic_t is very strange.
> > >  
> > 
> > From the patch V1, I cloned it from the  function_test_events_call()
> > in kernel/trace/trace_events.c
> > 
> > commit: 9ea21c1ecdb35ecdcac5fd9d95f62a1f6a7ffec0
> > tracing/events: perform function tracing in event selftests
> > Author:     Steven Rostedt <srostedt@redhat.com>  
> 
> Hmm, OK.

Ug, showing me my skeletons in my closet! That commit is from 2009, where I
didn't know any better ;-)

> 
> > 
> > It should be to prevent being preempted by the interrupt context in
> > the process of adding one  
> 
> Yeah, I think so.
> 
> The commit says "some bugs" but it is not sure what actually needs to be
> cared.
> 
>     tracing/events: perform function tracing in event selftests
>     
>     We can find some bugs in the trace events if we stress the writes as well.
>     The function tracer is a good way to stress the events.
> 
> Steve, can you tell me what was the problem?
> 
> I think we don't need per-cpu atomic_t because the counter is increment
> and decrement. Thus when quiting the nested ftrace handler on the same CPU,
> the counter comes back to the same value. We don't need to care about
> atomic increment.
> 
> I mean, if we use the normal per-cpu "unsigned int" as a counter, the
> operation of "counter++" becomes;

Yes, that was from the days of being extra paranoid. A simple counter would
work, with a barrier() in place such that gcc doesn't cause any issues.

I may have to go back and revisit all that code and clean it up a bit.

> 
> load counter to reg1
> [1]
> reg1 = reg1 + 1
> store reg1 to counter
> 
> And if an interrupt occurs at [1], the following happens.
> 
> load counter to reg1 # counter = 0
> 
>   (interrupt - save reg1)
>   load counter to reg1  # counter = 0
>   reg1 = reg1 + 1
>   store reg1 to counter  # counter = 1
>   ...
>   load counter to reg1  # counter = 1
>   reg1 = reg1 - 1
>   store reg1 to counter  # counter = 0
>   (iret - restore reg1)
> 
> reg1 = reg1 + 1
> store reg1 to counter
> 
> So, even if the operation is not atomic, there seems no problem.
> What else scenario we have to worry?
> 
> (BTW, what is the ftrace_test_recursion_trylock()? Is that also
> for detecting nesting case??)

Yes, the ftrace_test_recursion_trylock() is for finding recursions.

The above code is from the early days of ftrace, and was only used in
testing at boot up. It's not something to copy from ;-)

> 
> > > > +static DEFINE_RAW_SPINLOCK(object_spin_lock);
> > > > +static struct trace_event_file event_trace_file;
> > > > +static const int max_args_num = 6;
> > > > +static const int max_obj_pool = 10;
> > > > +static atomic_t trace_object_ref;
> > > > +static int exit_trace_object(void);
> > > > +static int init_trace_object(void);
> > > > +  
> > >
> > > Please add more comments to the code itself. Explain why this is needed
> > > and how it works for which case. That will lead deeper understanding.
> > >  
> > 
> > I agree, I will add more comments in the next version.
> >   
> > > > +struct object_instance {
> > > > +     void *object;
> > > > +     struct freelist_node free_list;
> > > > +     struct list_head active_list;
> > > > +};
> > > > +
> > > > +struct obj_pool {
> > > > +     struct freelist_head free_list;
> > > > +     struct list_head active_list;
> > > > +};
> > > > +static struct obj_pool *obj_pool;
> > > > +
> > > > +static bool object_exist(void *obj)
> > > > +{
> > > > +     struct object_instance *inst;
> > > > +     bool ret = false;
> > > > +
> > > > +     list_for_each_entry_rcu(inst, &obj_pool->active_list, active_list) {
> > > > +             if (inst->object == obj) {
> > > > +                     ret = true;
> > > > +                     goto out;
> > > > +             }
> > > > +     }
> > > > +out:
> > > > +     return ret;

BTW, the above really should be:

static bool object_exist(void *obj)
{
	struct object_instance *inst;

	list_for_each_entry_rcu(inst, &obj_pool->active_list, active_list) {
		if (inst->object == obj)
			return true;
	}
	return false;
}

-- Steve

