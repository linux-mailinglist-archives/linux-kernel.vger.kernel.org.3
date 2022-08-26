Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA95A1E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiHZBmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiHZBma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:42:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A09DB3B27;
        Thu, 25 Aug 2022 18:42:29 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDMws2Q1tzGpqw;
        Fri, 26 Aug 2022 09:40:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 09:42:13 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 09:42:12 +0800
Subject: Re: [PATCH v5 1/1] rcu: Simplify the code logic of rcu_init_nohz()
To:     <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220825092311.179-1-thunder.leizhen@huawei.com>
 <20220825092311.179-2-thunder.leizhen@huawei.com>
 <20220825172654.GP6159@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <43370a3c-8c7a-c7c7-ac2b-bec2bf6c8728@huawei.com>
Date:   Fri, 26 Aug 2022 09:42:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220825172654.GP6159@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/26 1:26, Paul E. McKenney wrote:
> On Thu, Aug 25, 2022 at 05:23:11PM +0800, Zhen Lei wrote:
>> When CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or CONFIG_NO_HZ_FULL=y, additional
>> CPUs need to be added to 'rcu_nocb_mask'. But 'rcu_nocb_mask' may be not
>> available now, due to 'rcu_nocbs' is not specified. Check and initialize
>> 'rcu_nocb_mask' before using it. This code simplification strictly follows
>> this logic, compared with old implementations, unnecessary crossovers are
>> avoided and easy to understand.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Much nicer, thank you!
> 
> As usual, I could not resist the urge to wordsmith.  Could you please
> check to make sure that I did not mess anything up?

Okay, thank you very much. The boot option name "rcu_nocb_mask=" is
incorrect, should be "rcu_nocbs=".

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

rcu_nocb_mask=   ---->  rcu_nocbs=

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
> .
> 

-- 
Regards,
  Zhen Lei
