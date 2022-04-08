Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D44F4F97EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiDHOYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiDHOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:24:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4365AE52;
        Fri,  8 Apr 2022 07:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DEECB82B33;
        Fri,  8 Apr 2022 14:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3651C385A8;
        Fri,  8 Apr 2022 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649427753;
        bh=wqwNWjFCQv2uKOQH0N9XEjIi+ply5xjP2/rcog9fdME=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eG4BUp59OLKBuhz3H+N8kfCu/EmsQlar6kqueci+Ww+6bDJsP0SSzaq4WmeVa9uq8
         fnB0bQFU5jBI0XPB2u3Xop3cc7RtgGjoil7vfoPq7yl4WdRe5lkUVp8wr79o7PCWIN
         aA6tTZEJ97WAMUDnnFwfwPWv1pFECiurciLaRDkKxX5J1DsGVgzPEszugxXfXD9yA0
         E/aRwMvvi8Q8pF1267tvEnZevVpFH4/XKmftRcbW2HPE74zAhip/Qud5awS93yTaKH
         oSYlML4oCy5t4FF7WDm263UnAiT6v+77aMj2Z6F90wkJjYZ62ZkIqTHy0kg6xoOxzv
         +V/0AX9zEJw5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 862DC5C0176; Fri,  8 Apr 2022 07:22:32 -0700 (PDT)
Date:   Fri, 8 Apr 2022 07:22:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220407210734.2548973-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407210734.2548973-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 09:07:33PM +0000, Joel Fernandes wrote:
> On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> which ends up not offloading any CPU. This patch removes yet another
> dependency from the bootloader having to know about RCU, about how many
> CPUs the system has, and about how to provide the mask. Basically, I
> think we should stop pretending that the user knows what they are doing :).
> In other words, if NO_CB_CPU is enabled, lets make use of it.
> 
> My goal is to make RCU as zero-config as possible with sane defaults. If
> user wants to provide rcu_nocbs= or nohz_full= options, then those will
> take precedence and this patch will have no effect.
> 
> I tested providing rcu_nocbs= option, ensuring that is preferred over this.

Unless something has changed, this would change behavior relied upon
the enterprise distros.  Last I checked, they want to supply a single
binary, as evidenced by the recent CONFIG_PREEMPT_DYNAMIC Kconfig option,
and they also want the default to be non-offloaded.  That is, given a
kernel built with CONFIG_RCU_NOCB_CPU=y and without either a nohz_full
or a nocbs_cpu boot parameter, all of the CPUs must be non-offloaded.

So for me to push this to mainline, I need an ack from someone from each
of the enterprise distros, and each of those someones needs to understand
the single-binary strategy used by the corresponding distro.

And is it really all -that- hard to specify an additional boot parameter
across ChromeOS devices?  Android seems to manage it.  ;-)

							Thanx, Paul

> Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_nocb.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index eeafb546a7a0..607fbf843467 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1165,12 +1165,25 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>  void __init rcu_init_nohz(void)
>  {
>  	int cpu;
> -	bool need_rcu_nocb_mask = false;
> +	bool need_rcu_nocb_mask = false, set_nocb_mask_all = false;
>  	struct rcu_data *rdp;
>  
> +	/*
> +	 * In case rcu_nocbs= was not passed on the kernel command line,
> +	 * provide a sane default by offloading all CPUs. This provides a
> +	 * sane default for rcu_nocbs and prevents users overlooking these
> +	 * details.
> +	 */
> +	if (!rcu_nocb_is_setup) {
> +		need_rcu_nocb_mask = true;
> +		set_nocb_mask_all = true;
> +	}
> +
>  #if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
> +	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask)) {
>  		need_rcu_nocb_mask = true;
> +		set_nocb_mask_all = false; /* NO_HZ_FULL provides its own mask. */
> +	}
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
>  	if (need_rcu_nocb_mask) {
> @@ -1191,6 +1204,9 @@ void __init rcu_init_nohz(void)
>  		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
> +	if (set_nocb_mask_all)
> +		cpumask_setall(rcu_nocb_mask);
> +
>  	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
>  		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
>  		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
> -- 
> 2.35.1.1178.g4f1659d476-goog
> 
