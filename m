Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A687502E54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbiDORh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241652AbiDORhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:37:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1892E52E59;
        Fri, 15 Apr 2022 10:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4A23B82E8D;
        Fri, 15 Apr 2022 17:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50095C385A7;
        Fri, 15 Apr 2022 17:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650044116;
        bh=NPrGWJY2+pB2s2+LkmyQ4Z6jS31r4u+B6OdBspv9xGw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KXOdvc2h2TyoULPQhTsialNWWsR/RBbznma5YHiYT4MBRnUTxdS4U9yblSqXLFkAK
         DSKJMUFTR5vJfcPh7babHlTcQrZ0Ohs2FkCbbxjFB1KsLuH6wyNxsKGXi23mb3r5d4
         X8wusGaCGCqKuXxhTw1kK4XW0IK/BcfIG9I+rDpYakqy6IDlfL488Ve4t/izlfIvOT
         9N0A2j0y259EozQ4tK6B7FJx64zc6frNsn1X6adCdpqlN9EmiPc81odPsTL8DziPjE
         fqUq6FZ0WAb/HA+OOLEA5/gA6nF9j9zEu6jNRsx3ZK4Pezf34AuuzwN9cWCVQb2HEj
         YWRagMMCiTMcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EA2945C04C8; Fri, 15 Apr 2022 10:35:15 -0700 (PDT)
Date:   Fri, 15 Apr 2022 10:35:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        rushikesh.s.kadam@intel.com, vineethrp@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v3] rcu/nocb: Add an option to offload all CPUs on boot
Message-ID: <20220415173515.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220415160224.1904505-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415160224.1904505-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 04:02:24PM +0000, Joel Fernandes (Google) wrote:
> From: Joel Fernandes <joel@joelfernandes.org>

Much better, thank you!

> On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> which ends up not offloading any CPU. This patch removes a dependency
> from the bootloader having to know about RCU, about how many CPUs the
> system has, and about how to provide the mask.

The "about how many CPUs the system has" does not apply to current
mainline, in which "rcu_nocbs=0-N" says to offload all CPUs.  It can be
added back in for a backport to v5.10.  ;-)

> With the new option enabled, all CPUs will be offloaded on boot.
> 
> Signed-off-by: Joel Fernandes <joel@joelfernandes.org>

I second Joel's call for testing and add to that a call for additional
review.

My thought is to queue this after some independent testing.

> ---
> v2 was forcing the option to override no_cbs=
> v3 is back to v1 but with a config option defaulting to 'n'.
> 
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  kernel/rcu/Kconfig                              | 13 +++++++++++++
>  kernel/rcu/tree_nocb.h                          | 16 ++++++++++++++--
>  3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f5a27f067db9..7648a7dd335e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4398,6 +4398,9 @@
>  			no-callback mode from boot but the mode may be
>  			toggled at runtime via cpusets.
>  
> +			Note that this argument takes precedence over
> +			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.

Very good, thank you!

Do we want to say the same about nohz_full?  Or am I misreading the
code below?

> +
>  	rcu_nocb_poll	[KNL]
>  			Rather than requiring that offloaded CPUs
>  			(specified by rcu_nocbs= above) explicitly
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index bf8e341e75b4..2f8bd694ed85 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -223,6 +223,19 @@ config RCU_NOCB_CPU
>  	  Say Y here if you need reduced OS jitter, despite added overhead.
>  	  Say N here if you are unsure.
>  
> +config RCU_NOCB_CPU_DEFAULT_ALL
> +	bool "Offload RCU callback processing from all CPUs by default"
> +	depends on RCU_NOCB_CPU

The needed dependency on RCU_EXPERT is provided transitively via
RCU_NOCB_CPU, so this should be OK.  (To check, build a .config file,
queue this patch, and do "make oldconfig".  If any questions are asked,
a change is needed.)

> +	default n
> +	help
> +	  Use this option to offload callback processing from all CPUs
> +	  by default, in the absence of the rcu_nocbs boot parameter.

And also in the absence of the nohz_full boot parameter, correct?

> +	  This also avoids the need to use any boot parameters to achieve
> +	  the effect of offloading all CPUs on boot.
> +
> +	  Say Y here if you want offload all CPUs by default on boot.
> +	  Say N here if you are unsure.
> +
>  config TASKS_TRACE_RCU_READ_MB
>  	bool "Tasks Trace RCU readers use memory barriers in user and idle"
>  	depends on RCU_EXPERT
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index eeafb546a7a0..673fa0d1f801 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1165,12 +1165,21 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>  void __init rcu_init_nohz(void)
>  {
>  	int cpu;
> -	bool need_rcu_nocb_mask = false;
> +	bool need_rcu_nocb_mask = false, offload_all = false;

Please use the extra line to perserve alphabetical order.  (I do know
about inverse tree, though I have no idea why it is considered to be a
good thing.)

>  	struct rcu_data *rdp;
>  
> +#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> +	if (!rcu_nocb_is_setup) {
> +		need_rcu_nocb_mask = true;
> +		offload_all = true;
> +	}
> +#endif

It would be nice to be able to use IS_ENABLED() here and below, but that
is a separate issue.  For one thing, need_rcu_nocb_mask would need to
be defined unconditionally.  So this is fine as it is for this patch.

> +
>  #if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
> +	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask)) {
>  		need_rcu_nocb_mask = true;
> +		offload_all = false; /* NO_HZ_FULL has its own mask. */

This is good, and is also why I am asking for the addition of nohz_full
above.

> +	}
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
>  	if (need_rcu_nocb_mask) {
> @@ -1191,6 +1200,9 @@ void __init rcu_init_nohz(void)
>  		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
> +	if (offload_all)
> +		cpumask_setall(rcu_nocb_mask);
> +
>  	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
>  		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
>  		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
> -- 
> 2.36.0.rc0.470.gd361397f0d-goog
> 
