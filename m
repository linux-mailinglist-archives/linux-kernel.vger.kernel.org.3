Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE035A948E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiIAKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiIAKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:25:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6791F50186;
        Thu,  1 Sep 2022 03:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BAD60CE2593;
        Thu,  1 Sep 2022 10:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE11C433C1;
        Thu,  1 Sep 2022 10:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662027921;
        bh=PN3FomO+q3LE0xpN/GpHPVrc4NdHCaXmL5EIAz0Wq94=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SqGFkJtOFY+NJPULVrhX5tzXLhGaRsNZ2aMoxbg1vgThInmTHSAr9PjmWeTVSCAX4
         sc64pBmB0IHAQAZVPuGjZa6Zk8UsW6Ji6FVRuxmZANA8H3bVpRL7t4k+4UlN7MieW+
         6+wyXJDg1BKu+e0QG1pR3A0tXVFBdNPunsa84D5r9CFOXJIX23PS37LBjjmIRZ5m9N
         FIykHJkZGAUJYFtVN5SjMrDKX7yATaVPBfbRjqG8UvrTM8E3vKnCH9wCc46gc4gbQZ
         rJYuGwysjKiORenfmzlMjVfy6rnHIU/Wa3jq5xaF+IDfiYbrzJVOpyhZIclxbuRk+z
         cgzfKut9jLoVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BB5985C06C8; Thu,  1 Sep 2022 03:25:20 -0700 (PDT)
Date:   Thu, 1 Sep 2022 03:25:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH rcu 3/3] rcu: Simplify rcu_init_nohz() cpumask handling
Message-ID: <20220901102520.GQ6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220831181040.GA2694278@paulmck-ThinkPad-P17-Gen-1>
 <20220831181044.2694488-3-paulmck@kernel.org>
 <20220901091557.GA101341@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901091557.GA101341@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 11:15:57AM +0200, Frederic Weisbecker wrote:
> On Wed, Aug 31, 2022 at 11:10:44AM -0700, Paul E. McKenney wrote:
> > From: Zhen Lei <thunder.leizhen@huawei.com>
> > 
> > In kernels built with either CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or
> > CONFIG_NO_HZ_FULL=y, additional CPUs must be added to rcu_nocb_mask.
> > Except that kernels booted without the rcu_nocbs= will not have
> > allocated rcu_nocb_mask.  And the current rcu_init_nohz() function uses
> > its need_rcu_nocb_mask and offload_all local variables to track the
> > rcu_nocb and nohz_full state.
> > 
> > But there is a much simpler approach, namely creating a cpumask pointer
> > to track the default and then using cpumask_available() to check the
> > rcu_nocb_mask state.  This commit takes this approach, thereby simplifying
> > and shortening the rcu_init_nohz() function.
> > 
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree_nocb.h | 32 +++++++++-----------------------
> >  1 file changed, 9 insertions(+), 23 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 0a5f0ef414845..c8167be2288fa 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1210,45 +1210,31 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
> >  void __init rcu_init_nohz(void)
> >  {
> >  	int cpu;
> > -	bool need_rcu_nocb_mask = false;
> > -	bool offload_all = false;
> >  	struct rcu_data *rdp;
> > +	const struct cpumask *cpumask = NULL;
> >  
> >  #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> > -	if (!rcu_state.nocb_is_setup) {
> > -		need_rcu_nocb_mask = true;
> > -		offload_all = true;
> > -	}
> > -#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
> > -
> > -#if defined(CONFIG_NO_HZ_FULL)
> > -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
> > -		need_rcu_nocb_mask = true;
> > -		offload_all = false; /* NO_HZ_FULL has its own mask. */
> > -	}
> > -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
> > +	cpumask = cpu_possible_mask;
> 
> You're missing the rcu_state.nocb_is_setup check, so
> CONFIG_RCU_NOCB_CPU_DEFAULT_ALL will now always override the rcu_nocbs=
> parameter (should be the other way around).

This is indeed a problem, so especially thank you for looking this over!

I will revert this patch.

> > +#elif defined(CONFIG_NO_HZ_FULL)
> > +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> > +		cpumask = tick_nohz_full_mask;
> > +#endif
> 
> A subtle behaviour difference here too: CONFIG_RCU_NOCB_CPU_DEFAULT_ALL will
> now override nohz_full=
> 
> I don't mind, it's probably what we want in the end, but the changelog should
> tell about it, or even better, this should be a separate change.

Good point.  Perhaps the key point is that if there is nohz_full=,
rcu_nocbs=, and CONFIG_RCU_NOCB_CPU_DEFAULT_ALL, we still need rcu_nocbs=
to include at least those bits set by nohz_full=.

Are there any other constraints?

Zhen Lei, please feel free to submit an updated patch.

							Thanx, Paul

> Thanks.
> 
> >  
> > -	if (need_rcu_nocb_mask) {
> > +	if (cpumask) {
> >  		if (!cpumask_available(rcu_nocb_mask)) {
> >  			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
> >  				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
> >  				return;
> >  			}
> >  		}
> > +
> > +		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
> >  		rcu_state.nocb_is_setup = true;
> >  	}
> >  
> >  	if (!rcu_state.nocb_is_setup)
> >  		return;
> >  
> > -#if defined(CONFIG_NO_HZ_FULL)
> > -	if (tick_nohz_full_running)
> > -		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
> > -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
> > -
> > -	if (offload_all)
> > -		cpumask_setall(rcu_nocb_mask);
> > -
> >  	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
> >  		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
> >  		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
