Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32EE51EBFE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 08:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiEHGc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 02:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiEHGcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 02:32:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5868F6451
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 23:29:00 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id s23so669979iog.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 23:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQKknHlDx72xx0B4nwvGp8Z3DerHVN3AD3DYjbUsQuI=;
        b=j4fnFCOWgizp9lpKRsc4ByfnvNzKiCiwnv9cssvueNHOT0hnDIBn0lh82BKcwzGdgC
         0pD2Vkqu9BTg5mlzfOKO1gmR6bii4v9ezaNyoTK8Ge9MGQclygivpTDgjfgUSPlI+Le+
         ybpceYmC+SDJEKW6Ntji4i1/t3M/KxXexB/MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQKknHlDx72xx0B4nwvGp8Z3DerHVN3AD3DYjbUsQuI=;
        b=5lI1pW/E2Hi84kez059ZBV7tpY8Shy3/sFQUe5PLMdSzkaQncYJJboSnzfEpO5R17v
         0P4kX4mRdsTj0ubGGT74xuaxfuwZwsZRBbtW6+c5epW0ghAhsfkbYD0yegPtwmsN2jEN
         SI60O833i8lZQAzaNGnEbIMbda9OF1vlThHNEaVmlzdE9FVK2ly1R6XH4NF5W/9PJZ0s
         uwf1xyuVUD2WJcfWpYXv7kYJUpKKPrfbPpYGi9YsvsWK1XI7Rn3V9duxiVAAGv0noUl3
         aaACtTSvsJCrFgxKn6V9mqnVLX03IqsNU4bT0DEfRHTYZoPKd+oAQxVxfnS2uCPQ0Om3
         0oKA==
X-Gm-Message-State: AOAM530PR6VPzuasChaCtmNzOeCZISWhZMlJHqNFy4NItnZgrxeEawqR
        Fikq6uYBJDZfgWZzEQcsPsnAT+hSyN8Se14oCmfboQ==
X-Google-Smtp-Source: ABdhPJxVXSiop4563gDD1XQWZK0LmMFpMgb9vJ9mZN1fFUXJPh0Ddj0EE324aTVz4nSoMTKr+HcSjIEfhX7MwAwGeoY=
X-Received: by 2002:a6b:1547:0:b0:64c:8bd4:acba with SMTP id
 68-20020a6b1547000000b0064c8bd4acbamr4265608iov.204.1651991339672; Sat, 07
 May 2022 23:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220505101641.28472-1-urezki@gmail.com> <20220505190915.GW1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnVLQozNFvgk3olP@pc638.lan> <20220506182425.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnY33nq5jl6FLFOu@pc638.lan> <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 8 May 2022 02:28:49 -0400
Message-ID: <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT context
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Alison Chaiken <achaiken@aurora.tech>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 7, 2022 at 6:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, May 07, 2022 at 11:11:58AM +0200, Uladzislau Rezki wrote:
> > > On Fri, May 06, 2022 at 06:22:26PM +0200, Uladzislau Rezki wrote:
> > > > > On Thu, May 05, 2022 at 12:16:41PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > > > Introduce a RCU_NOCB_CPU_CB_BOOST kernel option. So a user can
> > > > > > decide if an offloading has to be done in a high-prio context or
> > > > > > not. Please note an option depends on RCU_NOCB_CPU and RCU_BOOST
> > > > > > parameters and by default it is off.
> > > > > >
> > > > > > This patch splits the boosting preempted RCU readers and those
> > > > > > kthreads which directly responsible for driving expedited grace
> > > > > > periods forward with enabling/disabling the offloading from/to
> > > > > > SCHED_FIFO/SCHED_OTHER contexts.
> > > > > >
> > > > > > The main reason of such split is, for example on Android there
> > > > > > are some workloads which require fast expedited grace period to
> > > > > > be done whereas offloading in RT context can lead to starvation
> > > > > > and hogging a CPU for a long time what is not acceptable for
> > > > > > latency sensitive environment. For instance:
> > > > > >
> > > > > > <snip>
> > > > > > <...>-60 [006] d..1 2979.028717: rcu_batch_start: rcu_preempt CBs=34619 bl=270
> > > > > > <snip>
> > > > > >
> > > > > > invoking 34 619 callbacks will take time thus making other CFS
> > > > > > tasks waiting in run-queue to be starved due to such behaviour.
> > > > > >
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > >
> > > > > All good points!
> > > > >
> > > > > Some questions and comments below.
> > > > >
> > > > > Adding Sebastian on CC for his perspective.
> > > > >
> > > > >                                                 Thanx, Paul
> > > > >
> > > > > > ---
> > > > > >  kernel/rcu/Kconfig     | 14 ++++++++++++++
> > > > > >  kernel/rcu/tree.c      |  5 ++++-
> > > > > >  kernel/rcu/tree_nocb.h |  3 ++-
> > > > > >  3 files changed, 20 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > > > > index 27aab870ae4c..074630b94902 100644
> > > > > > --- a/kernel/rcu/Kconfig
> > > > > > +++ b/kernel/rcu/Kconfig
> > > > > > @@ -275,6 +275,20 @@ config RCU_NOCB_CPU_DEFAULT_ALL
> > > > > >         Say Y here if you want offload all CPUs by default on boot.
> > > > > >         Say N here if you are unsure.
> > > > > >
> > > > > > +config RCU_NOCB_CPU_CB_BOOST
> > > > > > +     bool "Perform offloading from real-time kthread"
> > > > > > +     depends on RCU_NOCB_CPU && RCU_BOOST
> > > > > > +     default n
> > > > >
> > > > > I understand that you need this to default to "n" on your systems.
> > > > > However, other groups already using callback offloading should not see
> > > > > a sudden change.  I don't see an Android-specific defconfig file, but
> > > > > perhaps something in drivers/android/Kconfig?
> > > > >
> > We saw a sudden change when the priority was lifted up for rcuop kthreads.
> > I would like to know the reason. As for Android, i would like to avoid
> > it to be Android specific. It is better just to enable boosting by
> > default for nocb kthreads.
>
> No, because that breaks an existing use case, which uses RCU_BOOST
> to avoid OOM on busy systems.
>
> > > > > One easy way to make this work would be to invert the sense of this
> > > > > Kconfig option ("RCU_NOCB_CB_NO_BOOST"?), continue having it default to
> > > > > "n", but then select it somewhere in drivers/android/Kconfig.  But I
> > > > > would not be surprised if there is a better way.
> >
> > In that situation probably we should just enable it by default.
>
> You are within your rights to cause it to be enabled by default -within-
> -Android-.  You are -not- within your rights to break other workloads.
>
> If ChromeOS needs it too, they too can enable it -within- -ChromeOS-.
>
> It is not -that- hard, guys!  ;-)

I think on the topic of RT, +Steven Rostedt should chime in as well
considering he wrote a good chunk of the RT scheduler ;-). Personally,
I feel the issue of "rcu callback offload" threads running as RT or
not should not be a matter of CONFIG option or the system in concern.
Instead it should be a function of how many callbacks there are to
run.  The reason I say this is, RT threads should not be doing a lot
of work anyway, lest they cause RT throttling and starvation of other
threads.

Also, I think it is wrong to assume that a certain kind of system will
always have a certain number of callbacks to process at a time. That
seems prone to poor design due to assumptions which may not always be
true.

Can we not have 2 sets of RCU offload threads, one which operate at RT
and only process few callbacks at a time, while another which is the
lower priority CFS offload thread - executes whenever there is a lot
of CBs pending? Just a thought.

Otherwise, I feel like we might be again proliferating CONFIG options
and increasing burden on the user to get it the CONFIG right.

thanks,

- Joel
