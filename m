Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15D559CF0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbiHWDCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbiHWDB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:01:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C745C9D4;
        Mon, 22 Aug 2022 20:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 332C1B81A03;
        Tue, 23 Aug 2022 03:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69BBC43470;
        Tue, 23 Aug 2022 03:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661223685;
        bh=cdJDXRIWTW/8wjvzlgdNdAomL6Qpg0Nri5tYiSOPmhM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PvrfzSj/YciPY/yB2jSUnAMRkVQNYF3UvHLoubupvCDCDwdwGqfN4WsXAeieGrxTI
         CLP/U+3Uk73iWKXykpvAMn+K5I4B7HIAsq2lDFcJCJehdgEkRcCrU+2CDmV5tEXnS1
         Iv3AhAJt0yWPvlKP/midjkLtJe4jI4J7GmO1X8f+3unUDVFEwxk3lEeb4aZb/pFPRP
         fxFutr5hg/A1oA6bZlQJvJy4dlOIG0I/RjW9y8eTUScIGqSgdnYE8HDL2gZUrFCzaN
         c5B3GUzA+NJRRSYOLQfazqere8hBquYcvX73m1vTEYkpa1DNhq6Di6BDGUXOInSPq6
         8Y2e2fMfC45hw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7341A5C05A0; Mon, 22 Aug 2022 20:01:25 -0700 (PDT)
Date:   Mon, 22 Aug 2022 20:01:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, boqun.feng@gmail.com
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
Message-ID: <20220823030125.GJ6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220822021520.6996-1-kernelfans@gmail.com>
 <20220822021520.6996-7-kernelfans@gmail.com>
 <20220822024528.GC6159@paulmck-ThinkPad-P17-Gen-1>
 <YwQygLBtzqwxuMIJ@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwQygLBtzqwxuMIJ@piliu.users.ipa.redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 09:50:56AM +0800, Pingfan Liu wrote:
> On Sun, Aug 21, 2022 at 07:45:28PM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 22, 2022 at 10:15:16AM +0800, Pingfan Liu wrote:
> > > In order to support parallel, rcu_state.n_online_cpus should be
> > > atomic_dec()
> > > 
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > 
> > I have to ask...  What testing have you subjected this patch to?
> > 
> 
> This patch subjects to [1]. The series aims to enable kexec-reboot in
> parallel on all cpu. As a result, the involved RCU part is expected to
> support parallel.

I understand (and even sympathize with) the expectation.  But results
sometimes diverge from expectations.  There have been implicit assumptions
in RCU about only one CPU going offline at a time, and I am not sure
that all of them have been addressed.  Concurrent CPU onlining has
been looked at recently here:

https://docs.google.com/document/d/1jymsaCPQ1PUDcfjIKm0UIbVdrJAaGX-6cXrmcfm0PRU/edit?usp=sharing

You did us atomic_dec() to make rcu_state.n_online_cpus decrementing be
atomic, which is good.  Did you look through the rest of RCU's CPU-offline
code paths and related code paths?

> [1]: https://lore.kernel.org/linux-arm-kernel/20220822021520.6996-3-kernelfans@gmail.com/T/#mf62352138d7b040fdb583ba66f8cd0ed1e145feb

Perhaps I am more blind than usual today, but I am not seeing anything
in this patch describing the testing.  At this point, I am thinking in
terms of making rcutorture test concurrent CPU offlining.

Thoughts?

							Thanx, Paul

> Thanks,
> 
> 	Pingfan
> 
> 
> > 							Thanx, Paul
> > 
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
> > >  		.name			= "RCU/tree:prepare",
> > >  		.startup.single		= rcutree_prepare_cpu,
> > >  		.teardown.single	= rcutree_dead_cpu,
> > > +		.support_kexec_parallel	= true,
> > >  	},
> > >  	/*
> > >  	 * On the tear-down path, timers_dead_cpu() must be invoked
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 79aea7df4345..07d31e16c65e 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2168,7 +2168,8 @@ int rcutree_dead_cpu(unsigned int cpu)
> > >  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > >  		return 0;
> > >  
> > > -	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> > > +	/* Hot remove path allows parallel, while Hot add races against remove on lock */
> > > +	atomic_dec((atomic_t *)&rcu_state.n_online_cpus);
> > >  	/* Adjust any no-longer-needed kthreads. */
> > >  	rcu_boost_kthread_setaffinity(rnp, -1);
> > >  	// Stop-machine done, so allow nohz_full to disable tick.
> > > -- 
> > > 2.31.1
> > > 
