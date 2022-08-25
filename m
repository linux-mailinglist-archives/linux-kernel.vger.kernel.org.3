Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6E5A168D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbiHYQUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242949AbiHYQT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A5960E4;
        Thu, 25 Aug 2022 09:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3A7E61B1C;
        Thu, 25 Aug 2022 16:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59430C433D6;
        Thu, 25 Aug 2022 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661444396;
        bh=wMIb7TlZdcwyLiaZmnquyJLiHA7ulJUUDLB8EVnte+A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=C73d5/tsVaWSFF0g7PVuXHJ2acgs7TN3d86yGo/bsNxswEzP/vjwt6U1kieyEh6fF
         0+Rn7SUocLLZi/yD0lMzoj3a2rvGDi03C8caNLUAq0hTAjqN85TPIC2tCRTbTOW1As
         lMZcRwVKTW2HJQTI7PW+TzsdR+5gXrq6vWyYYtajRleHbYWj9kmEu8jkbbj6bocTEB
         1XXqXun4IOdg375VpI38nkUZeWKOsxdIoH2WhKcoI1y1mIdSNyW5OHQi0U7iGiQxdW
         BWVOb0M4ieSX3qvAq5KGhE2IZHACFsIyBpynvpN7QNz4FFkiSXuCueKJEBZIToatsp
         qmZRamyigzAcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E957B5C055A; Thu, 25 Aug 2022 09:19:55 -0700 (PDT)
Date:   Thu, 25 Aug 2022 09:19:55 -0700
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
Subject: Re: [PATCH v4 2/2] rcu: Simplify the code logic of rcu_init_nohz()
Message-ID: <20220825161955.GO6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220817014253.1982-1-thunder.leizhen@huawei.com>
 <20220817014253.1982-3-thunder.leizhen@huawei.com>
 <20220822163512.GG6159@paulmck-ThinkPad-P17-Gen-1>
 <ccfdb4f1-3384-254e-7dff-25645bd7f02d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccfdb4f1-3384-254e-7dff-25645bd7f02d@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 08:13:00PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/8/23 0:35, Paul E. McKenney wrote:
> > On Wed, Aug 17, 2022 at 09:42:53AM +0800, Zhen Lei wrote:
> >> When CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or CONFIG_NO_HZ_FULL=y, additional
> >> CPUs need to be added to 'rcu_nocb_mask'. But 'rcu_nocb_mask' may be not
> >> available now, due to 'rcu_nocbs' is not specified. Check and initialize
> >> 'rcu_nocb_mask' before using it. This code simplification strictly follows
> >> this logic, compared with old implementations, unnecessary crossovers are
> >> avoided and easy to understand.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > 
> > This looks like a nice simplification, but I will wait for your response
> > on Patch 1/1 before trying it out.
> 
> How about I post v5 and just do this simplification? Patch 1/2 seems to require
> further discussion and in-depth analysis, which may take a long time.

Excellent choice, thank you!


							Thanx, Paul

> >> ---
> >>  kernel/rcu/tree_nocb.h | 32 +++++++++-----------------------
> >>  1 file changed, 9 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> >> index ff763e7dc53551f..3c59b12f4465af1 100644
> >> --- a/kernel/rcu/tree_nocb.h
> >> +++ b/kernel/rcu/tree_nocb.h
> >> @@ -1209,44 +1209,30 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
> >>  void __init rcu_init_nohz(void)
> >>  {
> >>  	int cpu;
> >> -	bool need_rcu_nocb_mask = false;
> >> -	bool offload_all = false;
> >>  	struct rcu_data *rdp;
> >> +	const struct cpumask *cpumask = NULL;
> >>  
> >>  #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> >> -	if (!cpumask_available(rcu_nocb_mask)) {
> >> -		need_rcu_nocb_mask = true;
> >> -		offload_all = true;
> >> -	}
> >> -#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
> >> -
> >> -#if defined(CONFIG_NO_HZ_FULL)
> >> -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
> >> -		need_rcu_nocb_mask = true;
> >> -		offload_all = false; /* NO_HZ_FULL has its own mask. */
> >> -	}
> >> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
> >> +	cpumask = cpu_possible_mask;
> >> +#elif defined(CONFIG_NO_HZ_FULL)
> >> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> >> +		cpumask = tick_nohz_full_mask;
> >> +#endif
> >>  
> >> -	if (need_rcu_nocb_mask) {
> >> +	if (cpumask) {
> >>  		if (!cpumask_available(rcu_nocb_mask)) {
> >>  			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
> >>  				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
> >>  				return;
> >>  			}
> >>  		}
> >> +
> >> +		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
> >>  	}
> >>  
> >>  	if (!cpumask_available(rcu_nocb_mask))
> >>  		return;
> >>  
> >> -#if defined(CONFIG_NO_HZ_FULL)
> >> -	if (tick_nohz_full_running)
> >> -		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
> >> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
> >> -
> >> -	if (offload_all)
> >> -		cpumask_setall(rcu_nocb_mask);
> >> -
> >>  	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
> >>  		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
> >>  		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
> >> -- 
> >> 2.25.1
> >>
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
