Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9F49071F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiAQL00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:26:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233787AbiAQL0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642418784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hCRPzS0b9fO1aUQG00rfUWcI+FfCnT3rsBRE+zuY/mc=;
        b=Lm6iCHBL36naiB13XPS+B1HiAyr0xIkLDBafiyWEjC4OJ9lr2bBjO1+8X6mgbX/A8J+Wdd
        /DYIU0w7T7V/5lmUWXt0fEfluQKkG8iPJF6v7LYcXMy3BDLvoSGC6WeNgVvSFpybpn+28z
        rICJgxeHmVPGMjyCgRhN9AMPDfWe4ns=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-mH2AKTYwPNOYsRuI3rukKA-1; Mon, 17 Jan 2022 06:26:23 -0500
X-MC-Unique: mH2AKTYwPNOYsRuI3rukKA-1
Received: by mail-ed1-f69.google.com with SMTP id bs4-20020a056402304400b004032af6b7ebso675685edb.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hCRPzS0b9fO1aUQG00rfUWcI+FfCnT3rsBRE+zuY/mc=;
        b=TONRUNik0qYgbXH9fdOLs1DhGd4bksbqaMH67ZTX9o9yBcJ1Bwlp685qE8Lus2qVEs
         7UR3AQLS+L0rAVQ3I3Ix+CqL2cwSkvDguEQ55Xng1bIPUaU2J114hAfBXVFAA8Ms8SFy
         au7+R/ZGqjXZO55FkxYio3EJHH6cDqf4A3MYSw+57s9L6yeQk1/5Ui0EeMMrnvp0Fbct
         TYiwuFS1P01YnPt5AqBsBqz1vPMDRsdIGK8cF7prSxqJz9VVJ6fFOzBv2qx7qZFDX7WK
         nwTMBIP9VRIF4aRM/GlAgzEh8PNIYt+Z0ylzGHQfURljCtAREvnVx8uRt47caI/gZdOA
         QKhQ==
X-Gm-Message-State: AOAM532nmhODSevj98KsLbFkk9azzelaoDXGArxdzI3oObD45fBvGYf/
        gJTcV7pAQvT5tKUuHc7vdd3GUOpWR+PBo7KmO2pzN8+Tw2GSkrSD0f2Bn53/+QMUiOKgCh3+2J8
        9M3liMK9C7UcjI+7Nhmyl21oRTGJBl9hBMC9dTbRB
X-Received: by 2002:a05:6402:8c6:: with SMTP id d6mr11545704edz.316.1642418781948;
        Mon, 17 Jan 2022 03:26:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxg5vobUV7dNBE7CG8tVBUW7vJFnHj88+RsIITMjb2KuVWM6kksN0Hqyw5WeKOeCwMqBjqcyjvvi7ctlImuW6k=
X-Received: by 2002:a05:6402:8c6:: with SMTP id d6mr11545690edz.316.1642418781648;
 Mon, 17 Jan 2022 03:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20211111195904.618253-1-wander@redhat.com> <20211111195904.618253-2-wander@redhat.com>
 <YY3GY8ZSH5ACaZZS@google.com> <CAAq0SUkeP0WcVBLmYXAyUxOuRDB3b4brgVsAYF90G+6pYrF4eA@mail.gmail.com>
 <20211112145755.GX641268@paulmck-ThinkPad-P17-Gen-1> <20220107185334.GA3360783@paulmck-ThinkPad-P17-Gen-1>
 <CAAq0SUm8TTaSWGmkmC90T3H0ePwv_td6Qn4t+__8k2C6QGEJMQ@mail.gmail.com> <YdwUFEF0JuaZR6I8@alley>
In-Reply-To: <YdwUFEF0JuaZR6I8@alley>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 17 Jan 2022 08:26:10 -0300
Message-ID: <CAAq0SUkjtAWUrmFG6sZ8a7V9kjBhrcTZ848kKmJEuuntoC_evg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by slow
 console devices
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 8:10 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Fri 2022-01-07 17:16:23, Wander Costa wrote:
> > On Fri, Jan 7, 2022 at 4:03 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Nov 12, 2021 at 06:57:55AM -0800, Paul E. McKenney wrote:
> > > > On Fri, Nov 12, 2021 at 11:42:39AM -0300, Wander Costa wrote:
> > > > > On Thu, Nov 11, 2021 at 10:42 PM Sergey Senozhatsky
> > > > > <senozhatsky@chromium.org> wrote:
> > > > > >
> > > > > > On (21/11/11 16:59), Wander Lairson Costa wrote:
> > > > > > >
> > > > > > > If we have a reasonable large dataset to flush in the printk ring
> > > > > > > buffer in the presence of a slow console device (like a serial port
> > > > > > > with a low baud rate configured), the RCU stall detector may report
> > > > > > > warnings.
> > > > > > >
> > > > > > > This patch suppresses RCU stall warnings while flushing the ring buffer
> > > > > > > to the console.
> > > > > > >
> > > > > > [..]
> > > > > > > +extern int rcu_cpu_stall_suppress;
> > > > > > > +
> > > > > > > +static void rcu_console_stall_suppress(void)
> > > > > > > +{
> > > > > > > +     if (!rcu_cpu_stall_suppress)
> > > > > > > +             rcu_cpu_stall_suppress = 4;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void rcu_console_stall_unsuppress(void)
> > > > > > > +{
> > > > > > > +     if (rcu_cpu_stall_suppress == 4)
> > > > > > > +             rcu_cpu_stall_suppress = 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  /**
> > > > > > >   * console_unlock - unlock the console system
> > > > > > >   *
> > > > > > > @@ -2634,6 +2648,9 @@ void console_unlock(void)
> > > > > > >        * and cleared after the "again" goto label.
> > > > > > >        */
> > > > > > >       do_cond_resched = console_may_schedule;
> > > > > > > +
> > > > > > > +     rcu_console_stall_suppress();
> > > > > > > +
> > > > > > >  again:
> > > > > > >       console_may_schedule = 0;
> > > > > > >
> > > > > > > @@ -2645,6 +2662,7 @@ void console_unlock(void)
> > > > > > >       if (!can_use_console()) {
> > > > > > >               console_locked = 0;
> > > > > > >               up_console_sem();
> > > > > > > +             rcu_console_stall_unsuppress();
> > > > > > >               return;
> > > > > > >       }
> > > > > > >
> > > > > > > @@ -2716,8 +2734,10 @@ void console_unlock(void)
> > > > > > >
> > > > > > >               handover = console_lock_spinning_disable_and_check();
> > > > > > >               printk_safe_exit_irqrestore(flags);
> > > > > > > -             if (handover)
> > > > > > > +             if (handover) {
> > > > > > > +                     rcu_console_stall_unsuppress();
> > > > > > >                       return;
> > > > > > > +             }
> > > > > > >
> > > > > > >               if (do_cond_resched)
> > > > > > >                       cond_resched();
> > > > > > > @@ -2738,6 +2758,8 @@ void console_unlock(void)
> > > > > > >       retry = prb_read_valid(prb, next_seq, NULL);
> > > > > > >       if (retry && console_trylock())
> > > > > > >               goto again;
> > > > > > > +
> > > > > > > +     rcu_console_stall_unsuppress();
> > > > > > >  }
> > > > > >
> > > > > > May be we can just start touching watchdogs from printing routine?
> > > > > >
> > > > > Hrm, console_unlock is called from vprintk_emit [0] with preemption
> > > > > disabled. and it already has the logic implemented to call
> > > > > cond_resched when possible [1].
> > > > >
> > > > > [0] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2244
> > > > > [1] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2719
> > > >
> > > > So when we are having problems is when console_may_schedule == 0?
> > >
> > > Just following up...  Any progress on this?  The ability to suppress RCU
> > > CPU stall warnings due to console slowness would likely be valuable to
> > > quite a few people.
> > >
> >
> > My understanding is that the consensus is that the proper fix is the
> > printk threads
>
> Yes. The stalls are real. printk() could cause even livelockups or
> slow down the entire system. It is good to know when it happens.
>
>
> > currently under work and it wouldn't take long before
> > it is ready to review.
>
> It is hard to predict. It might be ready within half a year but
> it might also take much longer time. It is not that trivial.
> We need to make sure that the messages get out when the system
> is in troubles and kthreads are not scheduled :-(
>

I am not sure what the policy is regarding temporary fixes, but since
we don't know when
printk threads will be ready for merge, there are real false positives
this patch fixes. Is it possible to land this patch in the meantime?
I understand that people might want to see these reports in some use
cases. Maybe if I add a build option to this feature?

> Best Regards,
> Petr
>

