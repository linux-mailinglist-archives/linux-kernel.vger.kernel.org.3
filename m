Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044215B0252
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIGLFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiIGLE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EAC248C9;
        Wed,  7 Sep 2022 04:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEEFC617F3;
        Wed,  7 Sep 2022 11:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10CBC433C1;
        Wed,  7 Sep 2022 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662548696;
        bh=MJgqsVkRfIKuwIgQcwb+dz9X2Z8vLriYnzUgjcVmsBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkPXWr/7zggNTVLJZO0c1tpgf5VD/cEhwLpHQaJlpKWkCTZTBe2KDUFaFoy1LpQ14
         e/OBwcQRIf6OILRtmQeqNib9N8Xro9RYPHurKmEB6l4TRynWApEOO/IJvCk9mziAzt
         D1GsgZYglejd5hDpokHrHReSZTr4zKNwsIKrMs1ImDptx64wC85bPqaa+vCUijPzwl
         udkBPwDYYS7SinAiyl0q9hfTXL9i3scMwNwhV5pT8YpmACXvQ/L8d4oaGVvk8Xw3Fh
         wxmZpa6u1+jO3fNO59u5a8T+8FZFnPxzbjF6q6/ghgd9e4rbZScTEF0YU12gXjybUG
         1fYJuHI31xEFw==
Date:   Wed, 7 Sep 2022 13:04:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] rcu: Simplify rcu_init_nohz() cpumask handling
Message-ID: <20220907110452.GA195440@lothringen>
References: <20220901131436.986-1-thunder.leizhen@huawei.com>
 <20220901131436.986-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901131436.986-2-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:14:35PM +0800, Zhen Lei wrote:
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
>  kernel/rcu/tree_nocb.h | 35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 0a5f0ef41484518..8b6dceeabde0b4d 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1210,45 +1210,34 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>  void __init rcu_init_nohz(void)
>  {
>  	int cpu;
> -	bool need_rcu_nocb_mask = false;
> -	bool offload_all = false;
>  	struct rcu_data *rdp;
> -
> -#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> -	if (!rcu_state.nocb_is_setup) {
> -		need_rcu_nocb_mask = true;
> -		offload_all = true;
> -	}
> -#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
> +	const struct cpumask *cpumask = NULL;
>  
>  #if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
> -		need_rcu_nocb_mask = true;
> -		offload_all = false; /* NO_HZ_FULL has its own mask. */
> -	}
> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> +		cpumask = tick_nohz_full_mask;
> +#endif
> +
> +#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> +	if (!rcu_state.nocb_is_setup && !cpumask)
> +		cpumask = cpu_possible_mask;
> +#endif

Good, and it can even use a simple condition:

if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) &&
    !rcu_state.nocb_is_setup && !cpumask)
    cpumask = cpu_possible_mask;


Acked-by: Frederic Weisbecker <frederic@kernel.org>


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
> 2.25.1
> 
