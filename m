Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE31E487D94
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 21:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiAGUQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 15:16:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231179AbiAGUQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 15:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641586597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jIOuETv60OLIh8NoHknh0mvZ4GXriyFZYoxi3A/oUeA=;
        b=e3DyhjejpvwqUQc15g+EZoC3DXMr3W87RuWvmgHS/w8c4iM0vZZgJyv/uB5x3qEYOTIREV
        N45CyltNi1hh97JKPe6N9IJy3QA/FVI2y2cmWHcTtqp0yt4bSc7Dht3xUwNmlVtqn2Gmgf
        1uHHFZ2MA5nsj1pEPztJtnrsk7YyAzw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-8J88jRJiPEahYGU-Gy3XhQ-1; Fri, 07 Jan 2022 15:16:36 -0500
X-MC-Unique: 8J88jRJiPEahYGU-Gy3XhQ-1
Received: by mail-ed1-f72.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso5522888edd.22
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 12:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIOuETv60OLIh8NoHknh0mvZ4GXriyFZYoxi3A/oUeA=;
        b=Q/MyeYpaWFUm55XzIPo410mfQCguJ44qlNNt/KCioDIYlRqRQ4/RX/GHRuzcVlzYTk
         cMVlUS2D0hZy0+kUFiqzrYKJKRK4KxUA5OJa2lsF9tze9goMDTkGnHvChF6hRCUB4yr8
         Q06D7SuVQWJ1zByZyjllIwQqiT6gclr8qHgzlbjXKiFu08C5TNrGlqPp+y9jU3gyHSJ0
         uT49VtkR3xqXURSbVt+0XTPvjI8an5dGuZbW6e2GjFtqQxW5Ie2N27jou1ZHnGsLQnCu
         vmCFhBsjHtmCff7Gt/sV22hdrqotPNqtJeSGZQrgkpvQAM3KhbTmGNK0FZxD6sKG2yvy
         B3JA==
X-Gm-Message-State: AOAM530x4DtxilSf5UV2RHWmBuEM+rjWPOBFGHQ+//nb0Ep+cf4UY9o7
        /z7uSWlj34u8AHX0tKZ/uy56UKgAN8B12k7p3IOe2v+piwknysRGabAfVDZJ33o6eUeLN4jyhHh
        a0R0h4Ix+OC8rdWKhHKCmYaJWTe2X+dsCK6NOrp2I
X-Received: by 2002:a17:906:c155:: with SMTP id dp21mr50587096ejc.450.1641586595379;
        Fri, 07 Jan 2022 12:16:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqVQFmLIhT6FFxWXKsM9AAGmh6EJ8sfuqKm4VJPrQ7l/b94SgirnXFYRGT1zs3XdqSWy91oHS74Wq7UwG2guc=
X-Received: by 2002:a17:906:c155:: with SMTP id dp21mr50587086ejc.450.1641586595197;
 Fri, 07 Jan 2022 12:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20211111195904.618253-1-wander@redhat.com> <20211111195904.618253-2-wander@redhat.com>
 <YY3GY8ZSH5ACaZZS@google.com> <CAAq0SUkeP0WcVBLmYXAyUxOuRDB3b4brgVsAYF90G+6pYrF4eA@mail.gmail.com>
 <20211112145755.GX641268@paulmck-ThinkPad-P17-Gen-1> <20220107185334.GA3360783@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220107185334.GA3360783@paulmck-ThinkPad-P17-Gen-1>
From:   Wander Costa <wcosta@redhat.com>
Date:   Fri, 7 Jan 2022 17:16:23 -0300
Message-ID: <CAAq0SUm8TTaSWGmkmC90T3H0ePwv_td6Qn4t+__8k2C6QGEJMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by slow
 console devices
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 4:03 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Nov 12, 2021 at 06:57:55AM -0800, Paul E. McKenney wrote:
> > On Fri, Nov 12, 2021 at 11:42:39AM -0300, Wander Costa wrote:
> > > On Thu, Nov 11, 2021 at 10:42 PM Sergey Senozhatsky
> > > <senozhatsky@chromium.org> wrote:
> > > >
> > > > On (21/11/11 16:59), Wander Lairson Costa wrote:
> > > > >
> > > > > If we have a reasonable large dataset to flush in the printk ring
> > > > > buffer in the presence of a slow console device (like a serial port
> > > > > with a low baud rate configured), the RCU stall detector may report
> > > > > warnings.
> > > > >
> > > > > This patch suppresses RCU stall warnings while flushing the ring buffer
> > > > > to the console.
> > > > >
> > > > [..]
> > > > > +extern int rcu_cpu_stall_suppress;
> > > > > +
> > > > > +static void rcu_console_stall_suppress(void)
> > > > > +{
> > > > > +     if (!rcu_cpu_stall_suppress)
> > > > > +             rcu_cpu_stall_suppress = 4;
> > > > > +}
> > > > > +
> > > > > +static void rcu_console_stall_unsuppress(void)
> > > > > +{
> > > > > +     if (rcu_cpu_stall_suppress == 4)
> > > > > +             rcu_cpu_stall_suppress = 0;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * console_unlock - unlock the console system
> > > > >   *
> > > > > @@ -2634,6 +2648,9 @@ void console_unlock(void)
> > > > >        * and cleared after the "again" goto label.
> > > > >        */
> > > > >       do_cond_resched = console_may_schedule;
> > > > > +
> > > > > +     rcu_console_stall_suppress();
> > > > > +
> > > > >  again:
> > > > >       console_may_schedule = 0;
> > > > >
> > > > > @@ -2645,6 +2662,7 @@ void console_unlock(void)
> > > > >       if (!can_use_console()) {
> > > > >               console_locked = 0;
> > > > >               up_console_sem();
> > > > > +             rcu_console_stall_unsuppress();
> > > > >               return;
> > > > >       }
> > > > >
> > > > > @@ -2716,8 +2734,10 @@ void console_unlock(void)
> > > > >
> > > > >               handover = console_lock_spinning_disable_and_check();
> > > > >               printk_safe_exit_irqrestore(flags);
> > > > > -             if (handover)
> > > > > +             if (handover) {
> > > > > +                     rcu_console_stall_unsuppress();
> > > > >                       return;
> > > > > +             }
> > > > >
> > > > >               if (do_cond_resched)
> > > > >                       cond_resched();
> > > > > @@ -2738,6 +2758,8 @@ void console_unlock(void)
> > > > >       retry = prb_read_valid(prb, next_seq, NULL);
> > > > >       if (retry && console_trylock())
> > > > >               goto again;
> > > > > +
> > > > > +     rcu_console_stall_unsuppress();
> > > > >  }
> > > >
> > > > May be we can just start touching watchdogs from printing routine?
> > > >
> > > Hrm, console_unlock is called from vprintk_emit [0] with preemption
> > > disabled. and it already has the logic implemented to call
> > > cond_resched when possible [1].
> > >
> > > [0] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2244
> > > [1] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2719
> >
> > So when we are having problems is when console_may_schedule == 0?
>
> Just following up...  Any progress on this?  The ability to suppress RCU
> CPU stall warnings due to console slowness would likely be valuable to
> quite a few people.
>

My understanding is that the consensus is that the proper fix is the
printk threads currently under work and it wouldn't take long before
it is ready to review.

