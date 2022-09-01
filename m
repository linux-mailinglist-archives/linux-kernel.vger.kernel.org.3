Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B453D5A92ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiIAJQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiIAJQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:16:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194CE11E812;
        Thu,  1 Sep 2022 02:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC40061736;
        Thu,  1 Sep 2022 09:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3A0C433C1;
        Thu,  1 Sep 2022 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662023760;
        bh=EOXV8/cxgZ9U2fhKP5zijCVI58O0ja1whVreiypMn0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBTItFdg+aO72LMccCwXO/ZSbg5egTSitZro6yL2n+9DXVolU3x0MnXALco5OFeQr
         iaoi8KafwGvhV6pduixN0/SXolGBfmL96mbhNlPSwqCGpCztP17rr+WI2bispBaAuL
         HnZtLu7lwpUQXwdAFA6yt/VE5GI152rpfrnKftKJ0IsRddS9Ef1SzjKL34IT/IAYOr
         7euYVJ8U9LyWEjtVFGebbUR+aLaRwBtN8T8LX/bTbRBQMiigfgVIgAtm5Vyw3v+JeD
         9RhFuH+wr76XP16Pq0HrQ7vo0c2csCCBQfgrb5C1MDKQoIH/ujw+hYwsCyuqKVwes8
         1w0cxhJTIntdA==
Date:   Thu, 1 Sep 2022 11:15:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH rcu 3/3] rcu: Simplify rcu_init_nohz() cpumask handling
Message-ID: <20220901091557.GA101341@lothringen>
References: <20220831181040.GA2694278@paulmck-ThinkPad-P17-Gen-1>
 <20220831181044.2694488-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831181044.2694488-3-paulmck@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:10:44AM -0700, Paul E. McKenney wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> In kernels built with either CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or
> CONFIG_NO_HZ_FULL=y, additional CPUs must be added to rcu_nocb_mask.
> Except that kernels booted without the rcu_nocbs= will not have
> allocated rcu_nocb_mask.  And the current rcu_init_nohz() function uses
> its need_rcu_nocb_mask and offload_all local variables to track the
> rcu_nocb and nohz_full state.
> 
> But there is a much simpler approach, namely creating a cpumask pointer
> to track the default and then using cpumask_available() to check the
> rcu_nocb_mask state.  This commit takes this approach, thereby simplifying
> and shortening the rcu_init_nohz() function.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_nocb.h | 32 +++++++++-----------------------
>  1 file changed, 9 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 0a5f0ef414845..c8167be2288fa 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1210,45 +1210,31 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>  void __init rcu_init_nohz(void)
>  {
>  	int cpu;
> -	bool need_rcu_nocb_mask = false;
> -	bool offload_all = false;
>  	struct rcu_data *rdp;
> +	const struct cpumask *cpumask = NULL;
>  
>  #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> -	if (!rcu_state.nocb_is_setup) {
> -		need_rcu_nocb_mask = true;
> -		offload_all = true;
> -	}
> -#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
> -
> -#if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
> -		need_rcu_nocb_mask = true;
> -		offload_all = false; /* NO_HZ_FULL has its own mask. */
> -	}
> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
> +	cpumask = cpu_possible_mask;

You're missing the rcu_state.nocb_is_setup check, so
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL will now always override the rcu_nocbs=
parameter (should be the other way around).


> +#elif defined(CONFIG_NO_HZ_FULL)
> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> +		cpumask = tick_nohz_full_mask;
> +#endif

A subtle behaviour difference here too: CONFIG_RCU_NOCB_CPU_DEFAULT_ALL will
now override nohz_full=

I don't mind, it's probably what we want in the end, but the changelog should
tell about it, or even better, this should be a separate change.

Thanks.

>  
> -	if (need_rcu_nocb_mask) {
> +	if (cpumask) {
>  		if (!cpumask_available(rcu_nocb_mask)) {
>  			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
>  				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
>  				return;
>  			}
>  		}
> +
> +		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
>  		rcu_state.nocb_is_setup = true;
>  	}
>  
>  	if (!rcu_state.nocb_is_setup)
>  		return;
>  
> -#if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running)
> -		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
> -
> -	if (offload_all)
> -		cpumask_setall(rcu_nocb_mask);
> -
>  	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
>  		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
>  		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
> -- 
> 2.31.1.189.g2e36527f23
> 
