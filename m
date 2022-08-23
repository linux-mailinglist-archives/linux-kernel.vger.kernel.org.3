Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C26C59E5BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243376AbiHWPJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243309AbiHWPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:09:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891F4107758;
        Tue, 23 Aug 2022 05:39:15 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MBnlC3xpmzlVpd;
        Tue, 23 Aug 2022 19:56:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 20:00:08 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 20:00:07 +0800
Subject: Re: [PATCH v4 1/2] rcu: Eliminate rcu_state.nocb_is_setup
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
 <20220817014253.1982-2-thunder.leizhen@huawei.com>
 <20220822163411.GF6159@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <89bd14ea-6980-4857-9e2a-9d89c94e88a7@huawei.com>
Date:   Tue, 23 Aug 2022 20:00:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220822163411.GF6159@paulmck-ThinkPad-P17-Gen-1>
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



On 2022/8/23 0:34, Paul E. McKenney wrote:
> On Wed, Aug 17, 2022 at 09:42:52AM +0800, Zhen Lei wrote:
>> 'rcu_state.nocb_is_setup' is initialized to true only if 'rcu_nocb_mask'
>> successfully allocates memory. So it can be replaced by
>> 'cpumask_available(rcu_nocb_mask)'. More importantly, the latter is more
>> intuitive, and it has been used in several places.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> One of the implementations of cpumask_available() does indeed check
> for NULL.  But here is the other one:
> 
> static inline bool cpumask_available(cpumask_var_t mask)
> {
> 	return true;
> }

Thanks for the heads-up.

> 
> So I have to ask...  In a kernel built with CONFIG_CPUMASK_OFFSTACK=n,
> will this change really work?

Yes, I run the test cases on arm64, which does not turn on option
CONFIG_CPUMASK_OFFSTACK by default.

I've listed a combination of build options in the cover-letter. In
this case, cpumask_empty(rcu_nocb_mask) is true.
----
CONFIG_NO_HZ_FULL=n, CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=n, cmdline without rcu_nocbs
[    0.000000] rcu:     Offload RCU callbacks from CPUs: (none).
----

> 
> Another important question is "Do all of the existing uses of
> cpumask_available() really work?"  Yes, I do believe that they do

The only functional change caused by this patch is:
For clarity, CONFIG_RCU_NOCB_CPU=y and CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=n are
omitted from the following conditions.

When
  CONFIG_NO_HZ_FULL=n and boot cmdline without 'rcu_nocbs='.
or
  CONFIG_NO_HZ_FULL=y and boot cmdline without 'nohz_full='.

The rdp->nocb_gp_kthread and rdp->nocb_cb_kthread threads are still created.

But we have provided EXPORT_SYMBOL_GPL functions rcu_nocb_cpu_deoffload() and
rcu_nocb_cpu_offload(), which can dynamically modify 'rcu_nocb_mask'. So it
seems appropriate to prepare these threads in advance. Of course, it looks like
only 'rcutorture' currently uses these two functions now.

Otherwise, we can do some optimization:
If none of the CPUs in a 'nocb_gp' group is marked in rcu_nocb_mask, this
grouping does not need to create corresponding threads "rcuog/%d" and "rcuo%c/%d".

And in rcu_init_nohz():
-       if (!rcu_state.nocb_is_setup)
+       if (!cpumask_available(rcu_nocb_mask) || cpumask_empty(rcu_nocb_mask))
                return;



> work, but it would be good to get another set of eyes on that code.
> "All software developers are blind!"  ;-)
> 
> 							Thanx, Paul
> 
>> ---
>>  kernel/rcu/tree.h      | 1 -
>>  kernel/rcu/tree_nocb.h | 8 +++-----
>>  2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>> index d4a97e40ea9c3e2..06f659c63d2d192 100644
>> --- a/kernel/rcu/tree.h
>> +++ b/kernel/rcu/tree.h
>> @@ -375,7 +375,6 @@ struct rcu_state {
>>  	arch_spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
>>  						/* Synchronize offline with */
>>  						/*  GP pre-initialization. */
>> -	int nocb_is_setup;			/* nocb is setup from boot */
>>  };
>>  
>>  /* Values for rcu_state structure's gp_flags field. */
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index 0a5f0ef41484518..ff763e7dc53551f 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -69,7 +69,6 @@ static int __init rcu_nocb_setup(char *str)
>>  			cpumask_setall(rcu_nocb_mask);
>>  		}
>>  	}
>> -	rcu_state.nocb_is_setup = true;
>>  	return 1;
>>  }
>>  __setup("rcu_nocbs", rcu_nocb_setup);
>> @@ -1215,7 +1214,7 @@ void __init rcu_init_nohz(void)
>>  	struct rcu_data *rdp;
>>  
>>  #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
>> -	if (!rcu_state.nocb_is_setup) {
>> +	if (!cpumask_available(rcu_nocb_mask)) {
>>  		need_rcu_nocb_mask = true;
>>  		offload_all = true;
>>  	}
>> @@ -1235,10 +1234,9 @@ void __init rcu_init_nohz(void)
>>  				return;
>>  			}
>>  		}
>> -		rcu_state.nocb_is_setup = true;
>>  	}
>>  
>> -	if (!rcu_state.nocb_is_setup)
>> +	if (!cpumask_available(rcu_nocb_mask))
>>  		return;
>>  
>>  #if defined(CONFIG_NO_HZ_FULL)
>> @@ -1299,7 +1297,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
>>  	struct task_struct *t;
>>  	struct sched_param sp;
>>  
>> -	if (!rcu_scheduler_fully_active || !rcu_state.nocb_is_setup)
>> +	if (!rcu_scheduler_fully_active || !cpumask_available(rcu_nocb_mask))
>>  		return;
>>  
>>  	/* If there already is an rcuo kthread, then nothing to do. */
>> -- 
>> 2.25.1
>>
> .
> 

-- 
Regards,
  Zhen Lei
