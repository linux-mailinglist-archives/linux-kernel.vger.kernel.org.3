Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7002F59CF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiHWDPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiHWDOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:14:47 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A4350198
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:14:42 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 10so9953092iou.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=k1tX+ZbUdF03T5VtJ8Jt7LwJ5Z2g+Fw58Un+X9nHhXc=;
        b=VgkQ2YZ9MV2sL20MeBgM+yktyD8vRBViJq7qYqIp6xpNRpoAyTiIl/i8dGxB9tT8jS
         TxYtNuTHt7KWqeEDNhEosY1IkWyDIWPXoGOxUstMpWsg4+tiVET0feKQpCRKUcV40sFq
         tM2krRC6EpW/TbAPwFCDFfrlCx3UI19/gMGes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=k1tX+ZbUdF03T5VtJ8Jt7LwJ5Z2g+Fw58Un+X9nHhXc=;
        b=cFGdsrFJABmTYxrUTn4FgR2t3w9EMCpGBAwjlAyrNcpYKWllilgaA3MnDyLdQLQT3c
         fhX9oPQK9sSaITRSdHXw2XCrS/Hrlk8vrwDKyJzu64QKmVUSSKx7yAbTU1DP8fPH/jSJ
         9wqJWrpMJ9yM1Mh9JFnioWEjkGMUkl+WOWModUYCdKn5jvzUdczLekZWeT1JuMP4e4Y6
         oe4V/T/tnKTEQyGTN8HMsEZgGazhlTF1lfBehgx4BddjDqgaa+6Bgtax22DOHXWXVybA
         Jyjekap8eqrfhtNphcHPvBbGLHdIhq/JqhB5thDZCa3XU+oL9guowzzMLjkaEOJPMPVS
         L+SQ==
X-Gm-Message-State: ACgBeo3rFDsljQZAn0MAHE7KTWsIxUU8hl9I6PI0CxjFYnVcI46bMbdf
        kdbixPvWwsTvnaFEadMCZJ3odCD1IU5+LmMNGagh/+qEIAQ=
X-Google-Smtp-Source: AA6agR4/kXJa7I8Po5qtsZBqG+SYCbfzDvTP+K5FlNviAv2rK7n0yytdDyZh2DR4oy885HIsBrglJaxbDoxmbFi4rx4=
X-Received: by 2002:a05:6638:378c:b0:343:447e:e6e2 with SMTP id
 w12-20020a056638378c00b00343447ee6e2mr10324712jal.118.1661224481194; Mon, 22
 Aug 2022 20:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220822021520.6996-1-kernelfans@gmail.com> <20220822021520.6996-7-kernelfans@gmail.com>
 <CAEXW_YRH11xFg-0nQfvv59SMFCW=SNTEEL0oHJKTs1X45wGr7w@mail.gmail.com> <YwQzyMlY6fa2WrM5@piliu.users.ipa.redhat.com>
In-Reply-To: <YwQzyMlY6fa2WrM5@piliu.users.ipa.redhat.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 22 Aug 2022 23:14:29 -0400
Message-ID: <CAEXW_YTJGqmi15itkPBNt_=Pj6PNG7aXWxq02UWQZ7rzj2mTiA@mail.gmail.com>
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
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

On Mon, Aug 22, 2022 at 9:56 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Mon, Aug 22, 2022 at 02:08:38PM -0400, Joel Fernandes wrote:
> > On Sun, Aug 21, 2022 at 10:16 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> > >
> > > In order to support parallel, rcu_state.n_online_cpus should be
> > > atomic_dec()
> >
> > What does Parallel mean? Is that some kexec terminology?
> >
>
> 'Parallel' means concurrent. It is not a kexec terminology, instead,
> should be SMP.

Ah ok! Makes sense. Apologies to be the word-police here, but you
probably could reword it to "In order to support parallel offlining"
or some such.

 - Joel



>
> Thanks,
>
>         Pingfan
>
>
> > Thanks,
> >
> >  - Joel
> >
> > >
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Steven Price <steven.price@arm.com>
> > > Cc: "Peter Zijlstra
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > > To: linux-kernel@vger.kernel.org
> > > To: rcu@vger.kernel.org
> > > ---
> > >  kernel/cpu.c      | 1 +
> > >  kernel/rcu/tree.c | 3 ++-
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > > index 1261c3f3be51..90debbe28e85 100644
> > > --- a/kernel/cpu.c
> > > +++ b/kernel/cpu.c
> > > @@ -1872,6 +1872,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
> > >                 .name                   = "RCU/tree:prepare",
> > >                 .startup.single         = rcutree_prepare_cpu,
> > >                 .teardown.single        = rcutree_dead_cpu,
> > > +               .support_kexec_parallel = true,
> > >         },
> > >         /*
> > >          * On the tear-down path, timers_dead_cpu() must be invoked
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 79aea7df4345..07d31e16c65e 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2168,7 +2168,8 @@ int rcutree_dead_cpu(unsigned int cpu)
> > >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > >                 return 0;
> > >
> > > -       WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> > > +       /* Hot remove path allows parallel, while Hot add races against remove on lock */
> > > +       atomic_dec((atomic_t *)&rcu_state.n_online_cpus);
> > >         /* Adjust any no-longer-needed kthreads. */
> > >         rcu_boost_kthread_setaffinity(rnp, -1);
> > >         // Stop-machine done, so allow nohz_full to disable tick.
> > > --
> > > 2.31.1
> > >
