Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6687F5A9D90
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiIAQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIAQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A07910541;
        Thu,  1 Sep 2022 09:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FCD61FCC;
        Thu,  1 Sep 2022 16:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529D0C433C1;
        Thu,  1 Sep 2022 16:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662051296;
        bh=7FYLfwjXAYaFsdwLNtKcqI4+Kia6WIEZKLw/kcERa2Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=F14e1LvLxOy8giklK/8qsg38dkTBva6gGBt+pI1HaoN0HUXr6xvSahc+4yUkv9623
         61kBwrE3dnT7hWoQbjHexbWdmxfqwPZGZJWa3SgTWIbc5VrczmVXLxK7/QDbFcenui
         K5LPsTl2oLnYPSa35YUf7TDdt4tSFeDHgrbp9Joc+FuwmUzfPevxx1d/+J7mY/Tj4Z
         pYr/2gycpFgG+d1I0zzdJETwTkhCkLRbvsQlGZ+yyiGfoZV8QynrzrdHVKnfl72/vk
         yVcptgwYR9neowiCPtWEWzIxB0ppbD9xTXL3cVP7y2iR0AzBw+EjoyI4JZy+LlKskb
         G5YxYCLU+NaFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E495B5C0691; Thu,  1 Sep 2022 09:54:55 -0700 (PDT)
Date:   Thu, 1 Sep 2022 09:54:55 -0700
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
Subject: Re: [PATCH v6 1/2] rcu: Simplify rcu_init_nohz() cpumask handling
Message-ID: <20220901165455.GB6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220901131436.986-1-thunder.leizhen@huawei.com>
 <20220901131436.986-2-thunder.leizhen@huawei.com>
 <4849b7c1-2fea-6f9f-31dc-c0408b32044e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4849b7c1-2fea-6f9f-31dc-c0408b32044e@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:25:06PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/9/1 21:14, Zhen Lei wrote:
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
> 
> Sorry, I forgot remove this "Signed-off-by".

Not a problem, especially given that in view of my oversight on the
previous version, I am going to let Frederic take first crack at this
version.  ;-)

							Thanx, Paul

> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree_nocb.h | 35 ++++++++++++-----------------------
> >  1 file changed, 12 insertions(+), 23 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 0a5f0ef41484518..8b6dceeabde0b4d 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1210,45 +1210,34 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
> >  void __init rcu_init_nohz(void)
> >  {
> >  	int cpu;
> > -	bool need_rcu_nocb_mask = false;
> > -	bool offload_all = false;
> >  	struct rcu_data *rdp;
> > -
> > -#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> > -	if (!rcu_state.nocb_is_setup) {
> > -		need_rcu_nocb_mask = true;
> > -		offload_all = true;
> > -	}
> > -#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
> > +	const struct cpumask *cpumask = NULL;
> >  
> >  #if defined(CONFIG_NO_HZ_FULL)
> > -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
> > -		need_rcu_nocb_mask = true;
> > -		offload_all = false; /* NO_HZ_FULL has its own mask. */
> > -	}
> > -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
> > +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> > +		cpumask = tick_nohz_full_mask;
> > +#endif
> > +
> > +#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> > +	if (!rcu_state.nocb_is_setup && !cpumask)
> > +		cpumask = cpu_possible_mask;
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
> > 
> 
> -- 
> Regards,
>   Zhen Lei
