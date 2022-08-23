Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA09A59CE26
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbiHWB4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiHWB4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:56:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BA15A8AE;
        Mon, 22 Aug 2022 18:56:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v4so10991556pgi.10;
        Mon, 22 Aug 2022 18:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=52uLVVw4OD/MmnAgXUgrzEyWZqqpz4jQXVq1BITqiTU=;
        b=J5SQdoMUfy8QU0dk3BdI3XN/7CWq638jbVqtMJmfc8Rv/swC03KFQGhCJPYl01e/fy
         lZR1ndXFZilVMiE8IJQN6qSNc4kMborGgVUXhe1v3s4eYdsYQP3wE/c9RdbYELQWp3y3
         8C/wTdHjZpedwxprIFeEfBuZhYTY/nyBNOc+v2LAb2SSyayeTAN/jjhigPT1iY9rKDYb
         PbwV3YZrxzAUxYfKdddGnqhIUQPlfNeZk4B7hAxPNnGEbUYrnVhhiDPF6Fjdvqrc49ta
         wZsyVqrVSt2KW7ecmuSTlp5u1A7PePrqTHgk2Kax75rsk9t3jUOchp0iZ/htqYUxhvHa
         stow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=52uLVVw4OD/MmnAgXUgrzEyWZqqpz4jQXVq1BITqiTU=;
        b=VNvx2t66vrQcHiV9mjgbg2oX8wMAf077khau9jn0N1upTDP+9EnzDMOzIyAEQY/jAp
         QvWYk543zUlmkiRa3ECreWLI61V8f9+5NuxMriHgPh5ocTX1mCQK4A4q7feA+zMdGeu2
         qc07DjWNHe8giEq/omm+YXeTtwukg0SkNsHML+KmArO8QuXsD4POqX23NC+AZ9pmV8zP
         ZGS6+Z9HaYhkA6fgyq+zD68rQFIcFsjWvPbvuMKFLRx3RDFFIRTZT7lrB3wGH6J/g2mD
         BWsEdrqk+lOTVqHPSBc0x7c6RLEYxxz42X5vG+5D2q1c58KipsF04uBNiweqiMQJg669
         boFw==
X-Gm-Message-State: ACgBeo2PxSbtVXCou9eTWkzDtKu5vv3Y3ZcGTAcnZCgFxHrw1T39uxUA
        WUT77BfOWEYi9CBM6iq7gw==
X-Google-Smtp-Source: AA6agR7h7xSl/z3TGVwSD54jfHeZ1CgXBYOv2hr/Tr1j+C3lpBiHRt+LHdC1q+/p4ujI+KkcOYXNpA==
X-Received: by 2002:a65:57c1:0:b0:42a:aaf6:c3b3 with SMTP id q1-20020a6557c1000000b0042aaaf6c3b3mr6722639pgr.26.1661219793120;
        Mon, 22 Aug 2022 18:56:33 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902780b00b001714fa07b74sm2100918pll.108.2022.08.22.18.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 18:56:32 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:56:24 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
Message-ID: <YwQzyMlY6fa2WrM5@piliu.users.ipa.redhat.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
 <20220822021520.6996-7-kernelfans@gmail.com>
 <CAEXW_YRH11xFg-0nQfvv59SMFCW=SNTEEL0oHJKTs1X45wGr7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRH11xFg-0nQfvv59SMFCW=SNTEEL0oHJKTs1X45wGr7w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 02:08:38PM -0400, Joel Fernandes wrote:
> On Sun, Aug 21, 2022 at 10:16 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > In order to support parallel, rcu_state.n_online_cpus should be
> > atomic_dec()
> 
> What does Parallel mean? Is that some kexec terminology?
> 

'Parallel' means concurrent. It is not a kexec terminology, instead,
should be SMP.

Thanks,

	Pingfan


> Thanks,
> 
>  - Joel
> 
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Steven Price <steven.price@arm.com>
> > Cc: "Peter Zijlstra
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > To: linux-kernel@vger.kernel.org
> > To: rcu@vger.kernel.org
> > ---
> >  kernel/cpu.c      | 1 +
> >  kernel/rcu/tree.c | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 1261c3f3be51..90debbe28e85 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1872,6 +1872,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
> >                 .name                   = "RCU/tree:prepare",
> >                 .startup.single         = rcutree_prepare_cpu,
> >                 .teardown.single        = rcutree_dead_cpu,
> > +               .support_kexec_parallel = true,
> >         },
> >         /*
> >          * On the tear-down path, timers_dead_cpu() must be invoked
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 79aea7df4345..07d31e16c65e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2168,7 +2168,8 @@ int rcutree_dead_cpu(unsigned int cpu)
> >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> >                 return 0;
> >
> > -       WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> > +       /* Hot remove path allows parallel, while Hot add races against remove on lock */
> > +       atomic_dec((atomic_t *)&rcu_state.n_online_cpus);
> >         /* Adjust any no-longer-needed kthreads. */
> >         rcu_boost_kthread_setaffinity(rnp, -1);
> >         // Stop-machine done, so allow nohz_full to disable tick.
> > --
> > 2.31.1
> >
