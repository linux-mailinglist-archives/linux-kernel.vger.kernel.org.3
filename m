Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3131C59B7C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiHVCpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiHVCpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:45:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37D1237F0;
        Sun, 21 Aug 2022 19:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CCDCB80E73;
        Mon, 22 Aug 2022 02:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA07C433C1;
        Mon, 22 Aug 2022 02:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661136329;
        bh=9DoVkMv/J4CWe1/n0DfS0XzvLsqqe3ypdRlHnBOZjGs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uBie9i+W5Ni/kDs3unghJ2RGF0MbI5WSvHAfJHQXFv5nSAdzhaz33XKjVb0o6ZVVz
         EI3xUWs3RZAciIT72PLm7nYOM5l6Bmzz1XM0/ccW3c/5/Ij4trq2wuXr4izKVY1INy
         VmTmaiwfhWDPRvkZwR47psEevZjnKSP3Na9m502Sz/XfBUYPVwqDBpzojzxqH71dzD
         +Ouwal/mK36O1A5ldPx5InCH0PAiiAR4CH3f1sD69GwkZVeavGgsO8IJ+FYifKpPiY
         qKwYh/H0SMTsjPM0irLrxu7vlejsyBqbR0i0F2q/fuRROwbjIu3iyQ6ou3NWVsaGxP
         ubu1MEVXQGGsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E058D5C03F8; Sun, 21 Aug 2022 19:45:28 -0700 (PDT)
Date:   Sun, 21 Aug 2022 19:45:28 -0700
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
Message-ID: <20220822024528.GC6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220822021520.6996-1-kernelfans@gmail.com>
 <20220822021520.6996-7-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822021520.6996-7-kernelfans@gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:15:16AM +0800, Pingfan Liu wrote:
> In order to support parallel, rcu_state.n_online_cpus should be
> atomic_dec()
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>

I have to ask...  What testing have you subjected this patch to?

							Thanx, Paul

> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Price <steven.price@arm.com>
> Cc: "Peter Zijlstra
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> To: linux-kernel@vger.kernel.org
> To: rcu@vger.kernel.org
> ---
>  kernel/cpu.c      | 1 +
>  kernel/rcu/tree.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 1261c3f3be51..90debbe28e85 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1872,6 +1872,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
>  		.name			= "RCU/tree:prepare",
>  		.startup.single		= rcutree_prepare_cpu,
>  		.teardown.single	= rcutree_dead_cpu,
> +		.support_kexec_parallel	= true,
>  	},
>  	/*
>  	 * On the tear-down path, timers_dead_cpu() must be invoked
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 79aea7df4345..07d31e16c65e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2168,7 +2168,8 @@ int rcutree_dead_cpu(unsigned int cpu)
>  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
>  		return 0;
>  
> -	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> +	/* Hot remove path allows parallel, while Hot add races against remove on lock */
> +	atomic_dec((atomic_t *)&rcu_state.n_online_cpus);
>  	/* Adjust any no-longer-needed kthreads. */
>  	rcu_boost_kthread_setaffinity(rnp, -1);
>  	// Stop-machine done, so allow nohz_full to disable tick.
> -- 
> 2.31.1
> 
