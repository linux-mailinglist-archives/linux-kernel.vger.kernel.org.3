Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC77487C76
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiAGSxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiAGSxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:53:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E581C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 10:53:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B4B461AFE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 18:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FAFC36AED;
        Fri,  7 Jan 2022 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641581615;
        bh=YQYKQfrCVjazS8G99udYRgnaScR6PMEJUv2tsSUVEWk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R2B37sPUzR6udDBPamAxRTXt7R3JiTHf65Wj7EkLf3XTnmwq9fGv9vERWdyYFLVJQ
         WhLiAZnTkeQBsKBpJltAjOuFrPWOArkmp8gfvf3v4SHk2OoSh031wHnYRb3lCEJlrn
         KhKoo8A+K3gtHnF3qcaHoUljKXRYgbuqxdKrvowCtZOmE9ktyKQZQcfUFadvlvTkS7
         MpTuish3CC4TIE1JhwnjgZ1BwGUtZZHsUSoc81u2LukEU/Dtz/NY2xG1lOl/Jtb3n8
         EeXl+etXZvO1FYP4d19Vf2w6RycDx+4UI/tlm2Ona/VRAZA6LHWfGj3XGqjLlSquVr
         UPJlRvgfuK4/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C1F3B5C08AA; Fri,  7 Jan 2022 10:53:34 -0800 (PST)
Date:   Fri, 7 Jan 2022 10:53:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wander Costa <wcosta@redhat.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by
 slow console devices
Message-ID: <20220107185334.GA3360783@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211111195904.618253-1-wander@redhat.com>
 <20211111195904.618253-2-wander@redhat.com>
 <YY3GY8ZSH5ACaZZS@google.com>
 <CAAq0SUkeP0WcVBLmYXAyUxOuRDB3b4brgVsAYF90G+6pYrF4eA@mail.gmail.com>
 <20211112145755.GX641268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112145755.GX641268@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 06:57:55AM -0800, Paul E. McKenney wrote:
> On Fri, Nov 12, 2021 at 11:42:39AM -0300, Wander Costa wrote:
> > On Thu, Nov 11, 2021 at 10:42 PM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > On (21/11/11 16:59), Wander Lairson Costa wrote:
> > > >
> > > > If we have a reasonable large dataset to flush in the printk ring
> > > > buffer in the presence of a slow console device (like a serial port
> > > > with a low baud rate configured), the RCU stall detector may report
> > > > warnings.
> > > >
> > > > This patch suppresses RCU stall warnings while flushing the ring buffer
> > > > to the console.
> > > >
> > > [..]
> > > > +extern int rcu_cpu_stall_suppress;
> > > > +
> > > > +static void rcu_console_stall_suppress(void)
> > > > +{
> > > > +     if (!rcu_cpu_stall_suppress)
> > > > +             rcu_cpu_stall_suppress = 4;
> > > > +}
> > > > +
> > > > +static void rcu_console_stall_unsuppress(void)
> > > > +{
> > > > +     if (rcu_cpu_stall_suppress == 4)
> > > > +             rcu_cpu_stall_suppress = 0;
> > > > +}
> > > > +
> > > >  /**
> > > >   * console_unlock - unlock the console system
> > > >   *
> > > > @@ -2634,6 +2648,9 @@ void console_unlock(void)
> > > >        * and cleared after the "again" goto label.
> > > >        */
> > > >       do_cond_resched = console_may_schedule;
> > > > +
> > > > +     rcu_console_stall_suppress();
> > > > +
> > > >  again:
> > > >       console_may_schedule = 0;
> > > >
> > > > @@ -2645,6 +2662,7 @@ void console_unlock(void)
> > > >       if (!can_use_console()) {
> > > >               console_locked = 0;
> > > >               up_console_sem();
> > > > +             rcu_console_stall_unsuppress();
> > > >               return;
> > > >       }
> > > >
> > > > @@ -2716,8 +2734,10 @@ void console_unlock(void)
> > > >
> > > >               handover = console_lock_spinning_disable_and_check();
> > > >               printk_safe_exit_irqrestore(flags);
> > > > -             if (handover)
> > > > +             if (handover) {
> > > > +                     rcu_console_stall_unsuppress();
> > > >                       return;
> > > > +             }
> > > >
> > > >               if (do_cond_resched)
> > > >                       cond_resched();
> > > > @@ -2738,6 +2758,8 @@ void console_unlock(void)
> > > >       retry = prb_read_valid(prb, next_seq, NULL);
> > > >       if (retry && console_trylock())
> > > >               goto again;
> > > > +
> > > > +     rcu_console_stall_unsuppress();
> > > >  }
> > >
> > > May be we can just start touching watchdogs from printing routine?
> > >
> > Hrm, console_unlock is called from vprintk_emit [0] with preemption
> > disabled. and it already has the logic implemented to call
> > cond_resched when possible [1].
> > 
> > [0] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2244
> > [1] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2719
> 
> So when we are having problems is when console_may_schedule == 0?

Just following up...  Any progress on this?  The ability to suppress RCU
CPU stall warnings due to console slowness would likely be valuable to
quite a few people.

							Thanx, Paul
