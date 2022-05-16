Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9DD527B62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 03:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbiEPB3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 21:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiEPB3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 21:29:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED01113D4E;
        Sun, 15 May 2022 18:29:12 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L1hRG6072zGpqF;
        Mon, 16 May 2022 09:26:18 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 09:29:11 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 09:29:10 +0800
Subject: Re: [PATCH] rcu/nocb: Delete local variable 'need_rcu_nocb_mask' in
 rcu_init_nohz()
To:     <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220426073626.967-1-thunder.leizhen@huawei.com>
 <20220513150556.GH1790663@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5b8cfec7-198e-1e6c-6ab7-b6bea747c621@huawei.com>
Date:   Mon, 16 May 2022 09:29:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220513150556.GH1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/13 23:05, Paul E. McKenney wrote:
> On Tue, Apr 26, 2022 at 03:36:26PM +0800, Zhen Lei wrote:
>> The local variable 'need_rcu_nocb_mask' is true only if CONFIG_NO_HZ_FULL
>> is defined. So branch "if (need_rcu_nocb_mask)" can be moved within the
>> scope of "#if defined(CONFIG_NO_HZ_FULL)". At this point, using variable
>> 'need_rcu_nocb_mask' is not necessary, so delete it.
>>
>> No functional changes, but the code looks a little more concise.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> First, please accept my apologies for the late reply and for the
> overly active spam filters.
> 
> One question below.
> 
> 							Thanx, Paul
> 
>> ---
>>  kernel/rcu/tree_nocb.h | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index 636d0546a4e932e..1e334e217f0afb7 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -1165,15 +1165,10 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>>  void __init rcu_init_nohz(void)
>>  {
>>  	int cpu;
>> -	bool need_rcu_nocb_mask = false;
>>  	struct rcu_data *rdp;
>>  
>>  #if defined(CONFIG_NO_HZ_FULL)
>> -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
>> -		need_rcu_nocb_mask = true;
>> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
>> -
>> -	if (need_rcu_nocb_mask) {
> 
> Could you please test this on a kernel built with CONFIG_NO_HZ_FULL=n
> and CONFIG_RCU_NOCB_CPU=y?  If that works, please add an explanation

OK, I will test it.

> of why it works to the commit log above and repost the patch.

Sorry, If I had written pseudocode in the commit log, it would have been clear, as below:

-----------------before-----------------
        bool need_rcu_nocb_mask = false;

#if defined(CONFIG_NO_HZ_FULL)
        if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
                need_rcu_nocb_mask = true;      <----	//Move it here, then delete all 'need_rcu_nocb_mask' related code
#endif /* #if defined(CONFIG_NO_HZ_FULL) */          |
                                                     |
        if (need_rcu_nocb_mask) {                    |  //Can only be true above
                ...                             -----
        }

-----------------after-----------------
#if defined(CONFIG_NO_HZ_FULL)
        if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
                ...
	}
#endif /* #if defined(CONFIG_NO_HZ_FULL) */

I'm doing clean up on the premise that the original code is correct.


> 
>> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
>>  		if (!cpumask_available(rcu_nocb_mask)) {
>>  			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
>>  				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
>> @@ -1182,6 +1177,7 @@ void __init rcu_init_nohz(void)
>>  		}
>>  		rcu_nocb_is_setup = true;
>>  	}
>> +#endif /* #if defined(CONFIG_NO_HZ_FULL) */
>>  
>>  	if (!rcu_nocb_is_setup)
>>  		return;
>> -- 
>> 2.26.0.106.g9fadedd
>>
> .
> 

-- 
Regards,
  Zhen Lei
