Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6325A1977
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiHYTYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiHYTYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:24:12 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7569C491C0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:24:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f4so15983196qkl.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=hG/uQjeenF9laNZRstG3Mh1nAcvyu+WUsb8wIqudLps=;
        b=da6sV/LXEbCSDT3rplDbvudBQePFpH+87Ia7Gy9AAmH08K2Qq5yiCb3+QH7Z1Em0a4
         9aKPA6LWq20RHSQVJL4NE9A0UoWp+j7NeclkATgLhFztxeG7v1gTaWhNM+fmGDkZeSLN
         r9PuUYfKc8ETu2eZAYWiDaZQZHvGbRNbIjml0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=hG/uQjeenF9laNZRstG3Mh1nAcvyu+WUsb8wIqudLps=;
        b=4RLWkdtywDPPUTi7fHFW8jEhDGv68kw0+ljx4NyhBN3hjprcLuvfqf0X5eIax9l4ec
         HPrKMC1WtOtQrjwuWCPI9BMbe1LiH28abmIRFvwXlxF3TUdBt59+fICf1ie0PgiQlxpX
         pbb/EoSpF5Mzcu6Tk6PqhbwsUBIlheo3WhVKOG+XQkDg0sOH8QEu5BQqsmFJKX2lvXe/
         qbfMHyM6SerbYThT2vdT0CEm4c8h4mmHUSHaJV34A6hwEq+zNpI9IOJ7T0QZzTeSetg0
         Qu7uJ7kCmJ8+ZJPlFjTYuz/LjtMmeXXJIh0fVMiAOvA8YpYggQgr3q5Fw+1dRObrLw+g
         3mzw==
X-Gm-Message-State: ACgBeo0S03aQcsRKGOaGMRyPsbuUsmN+r5S4bgrQlz4ST8rANGGjDq/r
        e4h0Zz1pN/GPXMZPwIedCjuypg==
X-Google-Smtp-Source: AA6agR7oJkUIBW7MW2DJlQRTeEEyOZgm3tbVc9+dZ5t+TxI0YM+OPZMFQnI6YFSG/ByASp8b18xgWQ==
X-Received: by 2002:a37:4d7:0:b0:6ba:c29a:c08f with SMTP id 206-20020a3704d7000000b006bac29ac08fmr4109973qke.669.1661455446580;
        Thu, 25 Aug 2022 12:24:06 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bw12-20020a05622a098c00b0031eddc83560sm15034809qtb.90.2022.08.25.12.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 12:24:06 -0700 (PDT)
Date:   Thu, 25 Aug 2022 19:24:05 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] rcu: Simplify the code logic of rcu_init_nohz()
Message-ID: <YwfMVTnjCt/gdArK@google.com>
References: <20220825092311.179-1-thunder.leizhen@huawei.com>
 <20220825092311.179-2-thunder.leizhen@huawei.com>
 <20220825172654.GP6159@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825172654.GP6159@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 10:26:54AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 25, 2022 at 05:23:11PM +0800, Zhen Lei wrote:
> > When CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or CONFIG_NO_HZ_FULL=y, additional
> > CPUs need to be added to 'rcu_nocb_mask'. But 'rcu_nocb_mask' may be not
> > available now, due to 'rcu_nocbs' is not specified. Check and initialize
> > 'rcu_nocb_mask' before using it. This code simplification strictly follows
> > this logic, compared with old implementations, unnecessary crossovers are
> > avoided and easy to understand.
> > 
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Much nicer, thank you!
> 
> As usual, I could not resist the urge to wordsmith.  Could you please
> check to make sure that I did not mess anything up?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 4ac3b3d1a19943b1522c0b1d0895aefbb80ec294
> Author: Zhen Lei <thunder.leizhen@huawei.com>
> Date:   Thu Aug 25 17:23:11 2022 +0800
> 
>     rcu: Simplify rcu_init_nohz() cpumask handling
>     
>     In kernels built with either CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or
>     CONFIG_NO_HZ_FULL=y, additional CPUs must be added to rcu_nocb_mask.
>     Except that kernels booted without the rcu_nocb_mask= will not have
>     allocated rcu_nocb_mask.  And the current rcu_init_nohz() function uses
>     its need_rcu_nocb_mask and offload_all local variables to track the
>     rcu_nocb and nohz_full state.
>     
>     But there is a much simpler approach, namely creating a cpumask pointer
>     to track the default and then using cpumask_available() to check the
>     rcu_nocb_mask state.  This commit takes this approach, thereby simplifying
>     and shortening the rcu_init_nohz() function.
>     
>     Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


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
> +#elif defined(CONFIG_NO_HZ_FULL)
> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> +		cpumask = tick_nohz_full_mask;
> +#endif
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
