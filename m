Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE8534C33
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244620AbiEZJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiEZJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:04:45 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0955F77
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:04:44 -0700 (PDT)
X-UUID: f4745014d2db43658cbb45f51dcca748-20220526
X-Spam-Fingerprint: 0
X-GW-Reason: 13103
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HMTDkurrpnIDopoHlrqHmoLg=
X-Content-Feature: ica/max.line-size 103
        audit/email.address 1
X-CPASD-INFO: 6c18a69c4fab45259d9ed1d71faf4805@f7NrWI5pZ5NghqOug3h9b1mVaZWUXYS
        Gc6CBlmJoXFWVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3haVrWJFkaQ==
X-CLOUD-ID: 6c18a69c4fab45259d9ed1d71faf4805
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:165.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:293.0,IP:-3.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:-5.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5,
        AUF:7,DUF:41546,ACD:295,DCD:398,SL:0,EISP:0,AG:0,CFC:0.855,CFSR:0.037,UAT:0,R
        AF:2,IMG:-5.0,DFA:0,DTA:0,IBL:-5,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,EA
        F:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: f4745014d2db43658cbb45f51dcca748-20220526
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: f4745014d2db43658cbb45f51dcca748-20220526
X-User: huangbing@kylinos.cn
Received: from [172.20.108.189] [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <huangbing@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 516048628; Thu, 26 May 2022 16:35:58 +0800
Message-ID: <e4523195-b271-0b11-e297-5ca25cc23504@kylinos.cn>
Date:   Thu, 26 May 2022 16:32:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sche/fair: static cpumasks for load balance
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220523094216.1746504-1-huangbing@kylinos.cn>
 <20220525170434.GK2578@worktop.programming.kicks-ass.net>
From:   huangbing <huangbing@kylinos.cn>
In-Reply-To: <20220525170434.GK2578@worktop.programming.kicks-ass.net>
Content-Type: multipart/mixed;
        boundary="Add_By_Label_Mail_Nextpart_001"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Add_By_Label_Mail_Nextpart_001
Content-Type: text/plain;
Content-Transfer-Encoding: 7bit



On 5/26/22 01:04, Peter Zijlstra wrote:
> On Mon, May 23, 2022 at 05:42:16PM +0800, Bing Huang wrote:
>> The both cpu mask load_balance_mask and select_idle_mask just only used
>> in fair.c, but allocation in core.c in CONFIG_CPUMASK_OFFSTACK=y case,
>> and global via declare per cpu variations. More or less, it looks wired.
>>
>> Signed-off-by: Bing Huang <huangbing@kylinos.cn>
>> ---
>>   kernel/sched/core.c  | 13 +++----------
>>   kernel/sched/fair.c  | 18 ++++++++++++++++--
>>   kernel/sched/sched.h |  4 ++++
>>   3 files changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index d58c0389eb23..64934c5e236d 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -9448,9 +9448,6 @@ LIST_HEAD(task_groups);
>>   static struct kmem_cache *task_group_cache __read_mostly;
>>   #endif
>>   
>> -DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
>> -DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
>> -
>>   void __init sched_init(void)
>>   {
>>   	unsigned long ptr = 0;
>> @@ -9494,14 +9491,10 @@ void __init sched_init(void)
>>   
>>   #endif /* CONFIG_RT_GROUP_SCHED */
>>   	}
>> +
>>   #ifdef CONFIG_CPUMASK_OFFSTACK
>> -	for_each_possible_cpu(i) {
>> -		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
>> -			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>> -		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
>> -			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>> -	}
>> -#endif /* CONFIG_CPUMASK_OFFSTACK */
>> +	init_working_cpumask();
>> +#endif
> We already have init_sched_fair_class(), can't you use that?

OK, thanks for your review. I got it.

In addition, I notice that load_balance_mask and select_idle_mask are 
defined
in CONFIG_SMP=y case in fair.c, so could be they moved inside 
CONFIG_SMP, or just outside ?

>
>>   
>>   	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
>>   
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index a68482d66535..3a4b0dd1beb5 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5831,8 +5831,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   #ifdef CONFIG_SMP
>>   
>>   /* Working cpumask for: load_balance, load_balance_newidle. */
>> -DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
>> -DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
>> +static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
>> +static DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
>>   
>>   #ifdef CONFIG_NO_HZ_COMMON
>>   
>> @@ -7052,6 +7052,20 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>   }
>>   #endif /* CONFIG_SMP */
>>   
>> +#ifdef CONFIG_CPUMASK_OFFSTACK
>> +void __init init_working_cpumask(void)
>> +{
>> +	int i;
>> +
>> +	for_each_possible_cpu(i) {
>> +		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
>> +				cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>> +		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
>> +				cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>> +	}
>> +}
>> +#endif
> If you stick that #ifdef inside the function, you can remove it
> everwhere else. Less #ifdef is more better.
I will remove it, move them inside init_sched_fair_class().
