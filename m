Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0E1489705
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbiAJLKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:10:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47872 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244454AbiAJLKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:10:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 45263210FC;
        Mon, 10 Jan 2022 11:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641813013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hj6wH53FRxcN+GV7FqzWIopkqdw+w0zOlSoOwQcADwU=;
        b=oqbvkJ7HrfjSjT2uvTEMRrUoPTClqulBohITpbqdHBEZG0JhNLHv0hA1cm/1a54MEPoHA0
        5B742QA9lYCPLnThMuRJ0iff4B006HU4WeHLaifTZd4ClCsi6DkWVJ+dHaJ85u83WEjIsH
        GYRraVP8thE8+wA6wTLLt6MZ8DaExDw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CAA12A3B84;
        Mon, 10 Jan 2022 11:10:12 +0000 (UTC)
Date:   Mon, 10 Jan 2022 12:10:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Wander Costa <wcosta@redhat.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by
 slow console devices
Message-ID: <YdwUFEF0JuaZR6I8@alley>
References: <20211111195904.618253-1-wander@redhat.com>
 <20211111195904.618253-2-wander@redhat.com>
 <YY3GY8ZSH5ACaZZS@google.com>
 <CAAq0SUkeP0WcVBLmYXAyUxOuRDB3b4brgVsAYF90G+6pYrF4eA@mail.gmail.com>
 <20211112145755.GX641268@paulmck-ThinkPad-P17-Gen-1>
 <20220107185334.GA3360783@paulmck-ThinkPad-P17-Gen-1>
 <CAAq0SUm8TTaSWGmkmC90T3H0ePwv_td6Qn4t+__8k2C6QGEJMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SUm8TTaSWGmkmC90T3H0ePwv_td6Qn4t+__8k2C6QGEJMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-01-07 17:16:23, Wander Costa wrote:
> On Fri, Jan 7, 2022 at 4:03 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Nov 12, 2021 at 06:57:55AM -0800, Paul E. McKenney wrote:
> > > On Fri, Nov 12, 2021 at 11:42:39AM -0300, Wander Costa wrote:
> > > > On Thu, Nov 11, 2021 at 10:42 PM Sergey Senozhatsky
> > > > <senozhatsky@chromium.org> wrote:
> > > > >
> > > > > On (21/11/11 16:59), Wander Lairson Costa wrote:
> > > > > >
> > > > > > If we have a reasonable large dataset to flush in the printk ring
> > > > > > buffer in the presence of a slow console device (like a serial port
> > > > > > with a low baud rate configured), the RCU stall detector may report
> > > > > > warnings.
> > > > > >
> > > > > > This patch suppresses RCU stall warnings while flushing the ring buffer
> > > > > > to the console.
> > > > > >
> > > > > [..]
> > > > > > +extern int rcu_cpu_stall_suppress;
> > > > > > +
> > > > > > +static void rcu_console_stall_suppress(void)
> > > > > > +{
> > > > > > +     if (!rcu_cpu_stall_suppress)
> > > > > > +             rcu_cpu_stall_suppress = 4;
> > > > > > +}
> > > > > > +
> > > > > > +static void rcu_console_stall_unsuppress(void)
> > > > > > +{
> > > > > > +     if (rcu_cpu_stall_suppress == 4)
> > > > > > +             rcu_cpu_stall_suppress = 0;
> > > > > > +}
> > > > > > +
> > > > > >  /**
> > > > > >   * console_unlock - unlock the console system
> > > > > >   *
> > > > > > @@ -2634,6 +2648,9 @@ void console_unlock(void)
> > > > > >        * and cleared after the "again" goto label.
> > > > > >        */
> > > > > >       do_cond_resched = console_may_schedule;
> > > > > > +
> > > > > > +     rcu_console_stall_suppress();
> > > > > > +
> > > > > >  again:
> > > > > >       console_may_schedule = 0;
> > > > > >
> > > > > > @@ -2645,6 +2662,7 @@ void console_unlock(void)
> > > > > >       if (!can_use_console()) {
> > > > > >               console_locked = 0;
> > > > > >               up_console_sem();
> > > > > > +             rcu_console_stall_unsuppress();
> > > > > >               return;
> > > > > >       }
> > > > > >
> > > > > > @@ -2716,8 +2734,10 @@ void console_unlock(void)
> > > > > >
> > > > > >               handover = console_lock_spinning_disable_and_check();
> > > > > >               printk_safe_exit_irqrestore(flags);
> > > > > > -             if (handover)
> > > > > > +             if (handover) {
> > > > > > +                     rcu_console_stall_unsuppress();
> > > > > >                       return;
> > > > > > +             }
> > > > > >
> > > > > >               if (do_cond_resched)
> > > > > >                       cond_resched();
> > > > > > @@ -2738,6 +2758,8 @@ void console_unlock(void)
> > > > > >       retry = prb_read_valid(prb, next_seq, NULL);
> > > > > >       if (retry && console_trylock())
> > > > > >               goto again;
> > > > > > +
> > > > > > +     rcu_console_stall_unsuppress();
> > > > > >  }
> > > > >
> > > > > May be we can just start touching watchdogs from printing routine?
> > > > >
> > > > Hrm, console_unlock is called from vprintk_emit [0] with preemption
> > > > disabled. and it already has the logic implemented to call
> > > > cond_resched when possible [1].
> > > >
> > > > [0] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2244
> > > > [1] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2719
> > >
> > > So when we are having problems is when console_may_schedule == 0?
> >
> > Just following up...  Any progress on this?  The ability to suppress RCU
> > CPU stall warnings due to console slowness would likely be valuable to
> > quite a few people.
> >
> 
> My understanding is that the consensus is that the proper fix is the
> printk threads

Yes. The stalls are real. printk() could cause even livelockups or
slow down the entire system. It is good to know when it happens.


> currently under work and it wouldn't take long before
> it is ready to review.

It is hard to predict. It might be ready within half a year but
it might also take much longer time. It is not that trivial.
We need to make sure that the messages get out when the system
is in troubles and kthreads are not scheduled :-(

Best Regards,
Petr
