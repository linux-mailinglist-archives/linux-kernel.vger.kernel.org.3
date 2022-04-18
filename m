Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EBC505E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347570AbiDRTIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbiDRTIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:08:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6901FA77;
        Mon, 18 Apr 2022 12:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37AE3B81002;
        Mon, 18 Apr 2022 19:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA14C385A1;
        Mon, 18 Apr 2022 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650308754;
        bh=l5AZu4p913yhlM9YlGzSHsU5/m7VJnjdSIysIwJgpZI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TCP728Jj0lTig8elJLIqrRpQQagS6BSNDRQYcjFuui4mfn1158qML+l9epNxUqNeu
         caZ30VPkKgOyE8w45kuwiit5p1gq1b2I1viYPFNUW8zjbIz1ABEh7OaAZPXMrX5zDJ
         y39E5NWCAWqAUy9hcRCClC3dH+SUIvUsV2NpSSfmCjLbtnNBlxQkT0k6gkOoj0P79s
         tKM8YK1yueDToZfLxJMAxsmAfwVSPLfSbzkZL8LhpWm9fe5nU1zFxjxq6rgMRr1oaZ
         pUIBJXhqw7zEGuBKPr6yJlmUIYkHs1vV+hlrzrR/EJl+I5h7mq/mdxfNGviqI8dste
         72JdNWI+fu9aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 848E45C0848; Mon, 18 Apr 2022 12:05:54 -0700 (PDT)
Date:   Mon, 18 Apr 2022 12:05:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        rushikesh.s.kadam@intel.com, vineethrp@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v4] rcu/nocb: Add an option to offload all CPUs on boot
Message-ID: <20220418190554.GA2422745@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220418175403.2553842-1-joel@joelfernandes.org>
 <20220418190417.GW4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418190417.GW4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 12:04:17PM -0700, Paul E. McKenney wrote:
> On Mon, Apr 18, 2022 at 05:54:03PM +0000, Joel Fernandes (Google) wrote:
> > From: Joel Fernandes <joel@joelfernandes.org>
> > 
> > On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> > which ends up not offloading any CPU. This patch removes a dependency
> > from the bootloader having to know about RCU and about how to provide
> > the mask.
> > 
> > With the new option enabled, all CPUs will be offloaded on boot unless
> > rcu_nocbs= or rcu_nohz_full= kernel parameters provide a CPU list.
> > 
> > Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> 
> Much better, queued for review and testing, thank you!
> 
> I resolved a (trivial) conflict with -rcu's "dev" branch.  Could you
> please check the resolultion below in case my notion of "trivial" and/or
> "resolved" is excessively optimistic?

Ah, and please note that we also need ack and/or reviews for me to send
this to mainline.  Just in case you thought that I had forgotten.  ;-)

						Thanx, Paul

> ------------------------------------------------------------------------
> 
> commit 21b595e4233e6885bdea2819c206a470cc207ea5
> Author: Joel Fernandes <joel@joelfernandes.org>
> Date:   Mon Apr 18 17:54:03 2022 +0000
> 
>     rcu/nocb: Add an option to offload all CPUs on boot
>     
>     On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
>     which ends up not offloading any CPU. This patch removes a dependency
>     from the bootloader having to know about RCU and about how to provide
>     the mask.
>     
>     With the new option enabled, all CPUs will be offloaded on boot unless
>     rcu_nocbs= or rcu_nohz_full= kernel parameters provide a CPU list.
>     
>     [ paulmck: Forward-port to -rcu "dev" branch. ]
>     
>     Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 789ef586009b..1e82ecb7a649 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3572,6 +3572,9 @@
>  			just as if they had also been called out in the
>  			rcu_nocbs= boot parameter.
>  
> +			Note that this argument takes precedence over
> +			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
> +
>  	noiotrap	[SH] Disables trapped I/O port accesses.
>  
>  	noirqdebug	[X86-32] Disables the code which attempts to detect and
> @@ -4475,6 +4478,9 @@
>  			no-callback mode from boot but the mode may be
>  			toggled at runtime via cpusets.
>  
> +			Note that this argument takes precedence over
> +			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
> +
>  	rcu_nocb_poll	[KNL]
>  			Rather than requiring that offloaded CPUs
>  			(specified by rcu_nocbs= above) explicitly
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 1c630e573548..27aab870ae4c 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -262,6 +262,19 @@ config RCU_NOCB_CPU
>  	  Say Y here if you need reduced OS jitter, despite added overhead.
>  	  Say N here if you are unsure.
>  
> +config RCU_NOCB_CPU_DEFAULT_ALL
> +	bool "Offload RCU callback processing from all CPUs by default"
> +	depends on RCU_NOCB_CPU
> +	default n
> +	help
> +	  Use this option to offload callback processing from all CPUs
> +	  by default, in the absence of the rcu_nocbs or nohz_full boot
> +	  parameter. This also avoids the need to use any boot parameters
> +	  to achieve the effect of offloading all CPUs on boot.
> +
> +	  Say Y here if you want offload all CPUs by default on boot.
> +	  Say N here if you are unsure.
> +
>  config TASKS_TRACE_RCU_READ_MB
>  	bool "Tasks Trace RCU readers use memory barriers in user and idle"
>  	depends on RCU_EXPERT && TASKS_TRACE_RCU
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 46694e13398a..ef29220c805f 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1155,11 +1155,21 @@ void __init rcu_init_nohz(void)
>  {
>  	int cpu;
>  	bool need_rcu_nocb_mask = false;
> +	bool offload_all = false;
>  	struct rcu_data *rdp;
>  
> +#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> +	if (!rcu_nocb_is_setup) {
> +		need_rcu_nocb_mask = true;
> +		offload_all = true;
> +	}
> +#endif
> +
>  #if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
>  		need_rcu_nocb_mask = true;
> +		offload_all = false; /* NO_HZ_FULL has its own mask. */
> +	}
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
>  	if (need_rcu_nocb_mask) {
> @@ -1180,6 +1190,9 @@ void __init rcu_init_nohz(void)
>  		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
> +	if (offload_all)
> +		cpumask_setall(rcu_nocb_mask);
> +
>  	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
>  		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
>  		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
