Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0759E561
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbiHWOuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242167AbiHWOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:50:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0372A2F1F7A;
        Tue, 23 Aug 2022 05:13:56 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MBp1n0b3jz1N7M7;
        Tue, 23 Aug 2022 20:09:33 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 20:13:01 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 20:13:01 +0800
Subject: Re: [PATCH v4 2/2] rcu: Simplify the code logic of rcu_init_nohz()
To:     <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220817014253.1982-1-thunder.leizhen@huawei.com>
 <20220817014253.1982-3-thunder.leizhen@huawei.com>
 <20220822163512.GG6159@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ccfdb4f1-3384-254e-7dff-25645bd7f02d@huawei.com>
Date:   Tue, 23 Aug 2022 20:13:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220822163512.GG6159@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2022/8/23 0:35, Paul E. McKenney wrote:
> On Wed, Aug 17, 2022 at 09:42:53AM +0800, Zhen Lei wrote:
>> When CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or CONFIG_NO_HZ_FULL=y, additional
>> CPUs need to be added to 'rcu_nocb_mask'. But 'rcu_nocb_mask' may be not
>> available now, due to 'rcu_nocbs' is not specified. Check and initialize
>> 'rcu_nocb_mask' before using it. This code simplification strictly follows
>> this logic, compared with old implementations, unnecessary crossovers are
>> avoided and easy to understand.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> This looks like a nice simplification, but I will wait for your response
> on Patch 1/1 before trying it out.

How about I post v5 and just do this simplification? Patch 1/2 seems to require
further discussion and in-depth analysis, which may take a long time.

> 
> 							Thanx, Paul
> 
>> ---
>>  kernel/rcu/tree_nocb.h | 32 +++++++++-----------------------
>>  1 file changed, 9 insertions(+), 23 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index ff763e7dc53551f..3c59b12f4465af1 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -1209,44 +1209,30 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>>  void __init rcu_init_nohz(void)
>>  {
>>  	int cpu;
>> -	bool need_rcu_nocb_mask = false;
>> -	bool offload_all = false;
>>  	struct rcu_data *rdp;
>> +	const struct cpumask *cpumask = NULL;
>>  
>>  #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
>> -	if (!cpumask_available(rcu_nocb_mask)) {
>> -		need_rcu_nocb_mask = true;
>> -		offload_all = true;
>> -	}
>> -#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
>> -
>> -#if defined(CONFIG_NO_HZ_FULL)
>> -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
>> -		need_rcu_nocb_mask = true;
>> -		offload_all = false; /* NO_HZ_FULL has its own mask. */
>> -	}
>> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
>> +	cpumask = cpu_possible_mask;
>> +#elif defined(CONFIG_NO_HZ_FULL)
>> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
>> +		cpumask = tick_nohz_full_mask;
>> +#endif
>>  
>> -	if (need_rcu_nocb_mask) {
>> +	if (cpumask) {
>>  		if (!cpumask_available(rcu_nocb_mask)) {
>>  			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
>>  				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
>>  				return;
>>  			}
>>  		}
>> +
>> +		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
>>  	}
>>  
>>  	if (!cpumask_available(rcu_nocb_mask))
>>  		return;
>>  
>> -#if defined(CONFIG_NO_HZ_FULL)
>> -	if (tick_nohz_full_running)
>> -		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
>> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
>> -
>> -	if (offload_all)
>> -		cpumask_setall(rcu_nocb_mask);
>> -
>>  	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
>>  		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
>>  		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
>> -- 
>> 2.25.1
>>
> .
> 

-- 
Regards,
  Zhen Lei
