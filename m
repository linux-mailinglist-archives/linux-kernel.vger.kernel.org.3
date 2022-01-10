Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D73488E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 03:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbiAJCAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 21:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbiAJCAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 21:00:50 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178B2C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 18:00:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h10so13752522wrb.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 18:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUQbMhLHdNK/9lp67bZllvKEzRmLoDwxJTqw4ktkG9s=;
        b=Efgkksg1NElOtfMl4UrueFiZH1d/QvdkdyZpSA5sV41zTPxnEOsbnl0sjJN4roZtkn
         r6FCd3Rb/8E7iCZgKDHbjsdrFYyKJlyjeoTbKV4yeZeLh+YcxkXFB1aMB13v8wdGepft
         mGBtkj/94hGc8dU2x6yt9qazWiPJg8yueJpeDj7EDz3Zc6t3GNDR+51SNRUwFPivaUIo
         mIAFJalPh7YtZNxTaFZimqNG5wPRpGa6/potucHt57E7C6/XvoMuAxgqcRhcdq4n6dbV
         8IhttKdMhXeGPHMAtKfa1crZgia7FYM7AZ2RVxWpcUEjiIOUu8lwVXYyo6JOu2NM9cCa
         zIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUQbMhLHdNK/9lp67bZllvKEzRmLoDwxJTqw4ktkG9s=;
        b=0pVTgM1MN+DPJ0x26edStAnn05TeT0RMB/Y0Uw6PoooI2KhuAI+yyBsTb7F9ytBrNh
         590sp3NfjF9VDfNZ2SwpW6j0GOiFKBr5xY3zMuai8RdoAut1OJWjr0TYx7IwFy9JO9Ip
         W/Xb9Lv/dr3LLBQB0YF1fbHs0ijM8rC1ivj8PIkHcwWNDKDPm3JKfNqEs+N4O3UuvMOY
         jnaqo7NS6hWpQJXoO8NaVcXj5kkV9cEZ3RjdKA9rrxKDzvAPJe+plKtxrOwst6e0quV9
         c3tHAYCPrIIUby6cg5zpIhbQbA2u42MxzFzBw3YkV702e7UwVoL9/Xvx6uvJ7BVCHZFl
         FO9A==
X-Gm-Message-State: AOAM531k0K2xL3vORtDA05pKamKU29IskKmkTBZhbpNd6WvxRtIJuJnE
        mGqo7YV7A6Q/RdDzBzfkGNDigwEgIYIbSLXSqET0PjCBUPXluCPk
X-Google-Smtp-Source: ABdhPJxmTMxPrTg9v736mkR7O4jiyAFhNlsp7bftuoUgSmwINMsd1yitPPYMlLn4dxSy+a94+6ElKHILWAblmG9zQEY=
X-Received: by 2002:a05:6000:11c9:: with SMTP id i9mr4875509wrx.544.1641780048703;
 Sun, 09 Jan 2022 18:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20211129164951.220511-1-xiehuan09@gmail.com> <20211129164951.220511-2-xiehuan09@gmail.com>
 <20211217135149.db5ee4b1b110c845739106d4@kernel.org> <CAEr6+EAn3+vWvp46mheO=MTetLyHXy-GDENtN8O6y+5T+Y-N7w@mail.gmail.com>
 <20211219120723.df2a892e2b4b7caec8905503@kernel.org> <20220107192114.3389b5a0@gandalf.local.home>
In-Reply-To: <20220107192114.3389b5a0@gandalf.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 10 Jan 2022 10:00:37 +0800
Message-ID: <CAEr6+EAn3NZ+1P+yD6HHMmLHBtASOdVXHd64hY2xQyrLNddb-Q@mail.gmail.com>
Subject: Re: [RFC][PATCH v6 1/5] trace: Add trace any kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Welcome back and look forward to playing this patch set with you again
in 2022 ;-)

Thank you and Masima for your guidance on this patchset in 2021. I
learned a lot.


On Sat, Jan 8, 2022 at 8:21 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Sorry for the late reply, I'm currently unemployed (for another week) and
> was spending all my time renovating my office. I finished my office and I'm
> now trying to get back up to speed.
>
> On Sun, 19 Dec 2021 12:07:23 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>
> > > > > +#include "trace_output.h"
> > > > > +#include <linux/freelist.h>
> > > > > +
> > > > > +static DEFINE_PER_CPU(atomic_t, trace_object_event_disable);
> > > >
> > > > atomic_t is for atomic operation which must be shared among cpus. On the
> > > > other hand, per-cpu variable is used for the core-local storage or flags,
> > > > other cpus never touch it. Thus the per-cpu atomic_t is very strange.
> > > >
> > >
> > > From the patch V1, I cloned it from the  function_test_events_call()
> > > in kernel/trace/trace_events.c
> > >
> > > commit: 9ea21c1ecdb35ecdcac5fd9d95f62a1f6a7ffec0
> > > tracing/events: perform function tracing in event selftests
> > > Author:     Steven Rostedt <srostedt@redhat.com>
> >
> > Hmm, OK.
>
> Ug, showing me my skeletons in my closet! That commit is from 2009, where I
> didn't know any better ;-)
>
> >
> > >
> > > It should be to prevent being preempted by the interrupt context in
> > > the process of adding one
> >
> > Yeah, I think so.
> >
> > The commit says "some bugs" but it is not sure what actually needs to be
> > cared.
> >
> >     tracing/events: perform function tracing in event selftests
> >
> >     We can find some bugs in the trace events if we stress the writes as well.
> >     The function tracer is a good way to stress the events.
> >
> > Steve, can you tell me what was the problem?
> >
> > I think we don't need per-cpu atomic_t because the counter is increment
> > and decrement. Thus when quiting the nested ftrace handler on the same CPU,
> > the counter comes back to the same value. We don't need to care about
> > atomic increment.
> >
> > I mean, if we use the normal per-cpu "unsigned int" as a counter, the
> > operation of "counter++" becomes;
>
> Yes, that was from the days of being extra paranoid. A simple counter would
> work, with a barrier() in place such that gcc doesn't cause any issues.
>
> I may have to go back and revisit all that code and clean it up a bit.
>
> >
> > load counter to reg1
> > [1]
> > reg1 = reg1 + 1
> > store reg1 to counter
> >
> > And if an interrupt occurs at [1], the following happens.
> >
> > load counter to reg1 # counter = 0
> >
> >   (interrupt - save reg1)
> >   load counter to reg1  # counter = 0
> >   reg1 = reg1 + 1
> >   store reg1 to counter  # counter = 1
> >   ...
> >   load counter to reg1  # counter = 1
> >   reg1 = reg1 - 1
> >   store reg1 to counter  # counter = 0
> >   (iret - restore reg1)
> >
> > reg1 = reg1 + 1
> > store reg1 to counter
> >
> > So, even if the operation is not atomic, there seems no problem.
> > What else scenario we have to worry?
> >
> > (BTW, what is the ftrace_test_recursion_trylock()? Is that also
> > for detecting nesting case??)
>
> Yes, the ftrace_test_recursion_trylock() is for finding recursions.
>
> The above code is from the early days of ftrace, and was only used in
> testing at boot up. It's not something to copy from ;-)
>
> >
> > > > > +static DEFINE_RAW_SPINLOCK(object_spin_lock);
> > > > > +static struct trace_event_file event_trace_file;
> > > > > +static const int max_args_num = 6;
> > > > > +static const int max_obj_pool = 10;
> > > > > +static atomic_t trace_object_ref;
> > > > > +static int exit_trace_object(void);
> > > > > +static int init_trace_object(void);
> > > > > +
> > > >
> > > > Please add more comments to the code itself. Explain why this is needed
> > > > and how it works for which case. That will lead deeper understanding.
> > > >
> > >
> > > I agree, I will add more comments in the next version.
> > >
> > > > > +struct object_instance {
> > > > > +     void *object;
> > > > > +     struct freelist_node free_list;
> > > > > +     struct list_head active_list;
> > > > > +};
> > > > > +
> > > > > +struct obj_pool {
> > > > > +     struct freelist_head free_list;
> > > > > +     struct list_head active_list;
> > > > > +};
> > > > > +static struct obj_pool *obj_pool;
> > > > > +
> > > > > +static bool object_exist(void *obj)
> > > > > +{
> > > > > +     struct object_instance *inst;
> > > > > +     bool ret = false;
> > > > > +
> > > > > +     list_for_each_entry_rcu(inst, &obj_pool->active_list, active_list) {
> > > > > +             if (inst->object == obj) {
> > > > > +                     ret = true;
> > > > > +                     goto out;
> > > > > +             }
> > > > > +     }
> > > > > +out:
> > > > > +     return ret;
>
> BTW, the above really should be:
>
> static bool object_exist(void *obj)
> {
>         struct object_instance *inst;
>
>         list_for_each_entry_rcu(inst, &obj_pool->active_list, active_list) {
>                 if (inst->object == obj)
>                         return true;
>         }
>         return false;
> }

Thanks. Masami suggested that it is better to use fixed-size array,
I will be ready to send the next version.

> -- Steve
>
---
JeffXie
