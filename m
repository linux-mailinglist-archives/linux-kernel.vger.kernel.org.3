Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40D752659F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381674AbiEMPGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380167AbiEMPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654A957104;
        Fri, 13 May 2022 08:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 022A66227D;
        Fri, 13 May 2022 15:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CECC34116;
        Fri, 13 May 2022 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652454357;
        bh=RNc8u9ThJH7emKt6pvxyKswC95AUnEUd1+i+cdRt+pc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LXryLq0rlIPlE+j+5fFMCNgWqos+FgCVpvHSaLcuAOHapYooy0Ovdual4ULDHcv1u
         hJFvCB/ETnvlUtqZJ51+Yr9nogmPiTzAkSOWdLhosbicR+dl/3nB7Ix7Ckaxf7BHIG
         ACY9LPH6EyAhOviHsa6n2yGqsLY8qTRRIgzcuGeYlLIbdiApYKD/PHZofIe/qUfUOl
         ChhQoLbRK5xU1gWNFfK7pgOODYEddkGI6iPftKP2vth8WrSysv5t82wqjIz3WCy20F
         8fCbUSjRduO1b0YQjAlFXvgLgdq7ehIX2zosZSyocaBHyDj4Xl0bGoXgAHTzY3jD12
         UEoyNYwPWluvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D5F315C034D; Fri, 13 May 2022 08:05:56 -0700 (PDT)
Date:   Fri, 13 May 2022 08:05:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Delete local variable 'need_rcu_nocb_mask' in
 rcu_init_nohz()
Message-ID: <20220513150556.GH1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220426073626.967-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426073626.967-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:36:26PM +0800, Zhen Lei wrote:
> The local variable 'need_rcu_nocb_mask' is true only if CONFIG_NO_HZ_FULL
> is defined. So branch "if (need_rcu_nocb_mask)" can be moved within the
> scope of "#if defined(CONFIG_NO_HZ_FULL)". At this point, using variable
> 'need_rcu_nocb_mask' is not necessary, so delete it.
> 
> No functional changes, but the code looks a little more concise.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

First, please accept my apologies for the late reply and for the
overly active spam filters.

One question below.

							Thanx, Paul

> ---
>  kernel/rcu/tree_nocb.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 636d0546a4e932e..1e334e217f0afb7 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1165,15 +1165,10 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>  void __init rcu_init_nohz(void)
>  {
>  	int cpu;
> -	bool need_rcu_nocb_mask = false;
>  	struct rcu_data *rdp;
>  
>  #if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> -		need_rcu_nocb_mask = true;
> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
> -
> -	if (need_rcu_nocb_mask) {

Could you please test this on a kernel built with CONFIG_NO_HZ_FULL=n
and CONFIG_RCU_NOCB_CPU=y?  If that works, please add an explanation
of why it works to the commit log above and repost the patch.

> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
>  		if (!cpumask_available(rcu_nocb_mask)) {
>  			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
>  				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
> @@ -1182,6 +1177,7 @@ void __init rcu_init_nohz(void)
>  		}
>  		rcu_nocb_is_setup = true;
>  	}
> +#endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
>  	if (!rcu_nocb_is_setup)
>  		return;
> -- 
> 2.26.0.106.g9fadedd
> 
