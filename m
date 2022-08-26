Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D5C5A28CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbiHZNr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344378AbiHZNpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:45:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B5943E73;
        Fri, 26 Aug 2022 06:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7FE6B82F84;
        Fri, 26 Aug 2022 13:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8466CC433D6;
        Fri, 26 Aug 2022 13:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661521520;
        bh=/wCO+8NSsd2IYaROtKGfH5tdFKHXG6nMlG+xYwW1HJk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oZUROb8qX+9vmEmC4yo3jFzm26WdhONdNte9Nj1h7bIjlxeM0fdO/WkSUsg2SmV5I
         FGlDnvy9isRLKMkqtfXr6i6Oh8WMQzZSttVt2iIaHtC9/Z4jsHYGl9+O9/METg+xFH
         PsL8XHqVghg+eFaG4Tn8YTHEdDIT7wOBHtTEou6eM8vP6aOX/TqQN9DLLkCXVRTMaY
         7EnAsvKAyq6PqBURbknt42CUz9ZuWEQ+PlCXayS5d7UUBZa3YJSX2BlofCs+JqWPyb
         DUsbjGkYUwFVWA9c7ql/21r+TBd8gSrjmkzo66Nnxc+guBh2RSTZbzaDyKrKu+fCdB
         94IqVvvTF2dvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1FF0F5C03F3; Fri, 26 Aug 2022 06:45:20 -0700 (PDT)
Date:   Fri, 26 Aug 2022 06:45:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] rcu: Simplify the code logic of rcu_init_nohz()
Message-ID: <20220826134520.GS6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220825092311.179-1-thunder.leizhen@huawei.com>
 <20220825092311.179-2-thunder.leizhen@huawei.com>
 <20220825172654.GP6159@paulmck-ThinkPad-P17-Gen-1>
 <43370a3c-8c7a-c7c7-ac2b-bec2bf6c8728@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43370a3c-8c7a-c7c7-ac2b-bec2bf6c8728@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 09:42:11AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/8/26 1:26, Paul E. McKenney wrote:
> > On Thu, Aug 25, 2022 at 05:23:11PM +0800, Zhen Lei wrote:
> >> When CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or CONFIG_NO_HZ_FULL=y, additional
> >> CPUs need to be added to 'rcu_nocb_mask'. But 'rcu_nocb_mask' may be not
> >> available now, due to 'rcu_nocbs' is not specified. Check and initialize
> >> 'rcu_nocb_mask' before using it. This code simplification strictly follows
> >> this logic, compared with old implementations, unnecessary crossovers are
> >> avoided and easy to understand.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > 
> > Much nicer, thank you!
> > 
> > As usual, I could not resist the urge to wordsmith.  Could you please
> > check to make sure that I did not mess anything up?
> 
> Okay, thank you very much. The boot option name "rcu_nocb_mask=" is
> incorrect, should be "rcu_nocbs=".

Good eyes, thank you!  I will fix this on the next rebase.

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > commit 4ac3b3d1a19943b1522c0b1d0895aefbb80ec294
> > Author: Zhen Lei <thunder.leizhen@huawei.com>
> > Date:   Thu Aug 25 17:23:11 2022 +0800
> > 
> >     rcu: Simplify rcu_init_nohz() cpumask handling
> >     
> >     In kernels built with either CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or
> >     CONFIG_NO_HZ_FULL=y, additional CPUs must be added to rcu_nocb_mask.
> >     Except that kernels booted without the rcu_nocb_mask= will not have
> 
> rcu_nocb_mask=   ---->  rcu_nocbs=
> 
> >     allocated rcu_nocb_mask.  And the current rcu_init_nohz() function uses
> >     its need_rcu_nocb_mask and offload_all local variables to track the
> >     rcu_nocb and nohz_full state.
> >     
> >     But there is a much simpler approach, namely creating a cpumask pointer
> >     to track the default and then using cpumask_available() to check the
> >     rcu_nocb_mask state.  This commit takes this approach, thereby simplifying
> >     and shortening the rcu_init_nohz() function.
> >     
> >     Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
> > +#elif defined(CONFIG_NO_HZ_FULL)
> > +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> > +		cpumask = tick_nohz_full_mask;
> > +#endif
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
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
