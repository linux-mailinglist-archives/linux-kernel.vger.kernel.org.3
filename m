Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A17455F417
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiF2DW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiF2DWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:22:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61719581
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 20:22:43 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LXmtd1M5bzhYWQ;
        Wed, 29 Jun 2022 11:20:25 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 11:22:41 +0800
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <guodong.xu@linaro.org>, <hesham.almatary@huawei.com>,
        <john.garry@huawei.com>, <shenyang39@huawei.com>,
        <feng.tang@intel.com>
Subject: Re: [PATCH v4 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
 <20220609120622.47724-2-yangyicong@hisilicon.com>
 <e000b124-afd4-28e1-fde2-393b0e38ce19@amd.com>
 <81fbcadb-a58d-2cef-9c05-154555ec1d68@huawei.com>
 <6bf4f032-7d07-d4a4-4f5a-28f3871131c0@amd.com>
 <b87ddfd7a8dd418edfcdbad22a4fc1e9ef03109a.camel@linux.intel.com>
 <5638aed5-bbd0-a74e-759f-0de51e3651f7@amd.com>
 <cf13647f-6bb6-34d5-c6b6-41a7500a9612@bytedance.com>
 <3db2443d-3c30-703d-d4c1-b184eccbf3b5@amd.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <1f3158f3-9c17-d229-2b28-e2e60b3a5db5@huawei.com>
Date:   Wed, 29 Jun 2022 11:22:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <3db2443d-3c30-703d-d4c1-b184eccbf3b5@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/28 19:55, K Prateek Nayak wrote:
> Hello Abel,
> 
> Thank you for looking into this issue.
> 
> tl;dr
> 
> We have found two variables that need to be
> co-located on the same cache line to restore tbench
> performance.
> 
> As this issue is unrelated to the functionality of
> the patch, it should not hold this patch series from
> landing given the performance improvements seen on
> systems with CPU clusters.
> 
> The results of our analysis are discussed in
> detail below.
> 
> On 6/20/2022 7:07 PM, Abel Wu wrote:
>>
>> On 6/20/22 7:20 PM, K Prateek Nayak Wrote:
>>> Hello Tim,
>>>
>>> Thank you for looking into this.
>>>
>>> On 6/17/2022 10:20 PM, Tim Chen wrote:
>>>> On Fri, 2022-06-17 at 17:50 +0530, K Prateek Nayak wrote:
>>>>>
>>>>>
>>>>> -- 
>>>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>>>> index e9f3dc6dcbf4..97a3895416ab 100644
>>>>> --- a/kernel/sched/sched.h
>>>>> +++ b/kernel/sched/sched.h
>>>>> @@ -1750,12 +1750,12 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>>>>>       return sd;
>>>>>   }
>>>>>   +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>>>> +DECLARE_PER_CPU(int, sd_share_id);
>>>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>>>>   DECLARE_PER_CPU(int, sd_llc_size);
>>>>>   DECLARE_PER_CPU(int, sd_llc_id);
>>>>> -DECLARE_PER_CPU(int, sd_share_id);
>>>>>   DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>>>>> -DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>>>>> -- 
>>>>>
>>>>> The System-map of each kernel is as follows:
>>>>>
>>>>> - On "tip"
>>>>>
>>>>> 0000000000020518 D sd_asym_cpucapacity
>>>>> 0000000000020520 D sd_asym_packing
>>>>> 0000000000020528 D sd_numa
>>>>> 0000000000020530 D sd_llc_shared
>>>>> 0000000000020538 D sd_llc_id
>>>>> 000000000002053c D sd_llc_size
>>>>> -------------------------------------------- 64B Cacheline Boundary
>>>>> 0000000000020540 D sd_llc
>>>>>
>>>>> - On "tip + Patch 1 only" and "tip + both patches"
>>>>>
>>>>> 0000000000020518 D sd_asym_cpucapacity
>>>>> 0000000000020520 D sd_asym_packing
>>>>> 0000000000020528 D sd_numa
>>>>> 0000000000020530 D sd_cluster     <-----
>>>>> 0000000000020538 D sd_llc_shared
>>>>> -------------------------------------------- 64B Cacheline Boundary
>>>>> 0000000000020540 D sd_share_id    <-----
>>>>> 0000000000020544 D sd_llc_id
>>>>> 0000000000020548 D sd_llc_size
>>>>> 0000000000020550 D sd_llc
>>>>>
>>>>>
>>>>> - On "tip + both patches (Move declaration to top)"
>>>>>
>>>>> 0000000000020518 D sd_asym_cpucapacity
>>>>> 0000000000020520 D sd_asym_packing
>>>>> 0000000000020528 D sd_numa
>>>>> 0000000000020530 D sd_llc_shared
>>>>> 0000000000020538 D sd_llc_id
>>>>> 000000000002053c D sd_llc_size
>>>>> -------------------------------------------- 64B Cacheline Boundary
>>>>> 0000000000020540 D sd_llc
>>>>
>>>> Wonder if it will help to try keep sd_llc and sd_llc_size into the same
>>>> cache line.  They are both used in the wake up path.
>>>
>>> We are still evaluating keeping which set of variables on the same
>>> cache line will provide the best results.
>>>
>>> I would have expected the two kernel variants - "tip" and the
>>> "tip + both patches (Move declaration to top)" - to give similar results
>>> as their System map for all the old variables remain the same and the
>>> addition of "sd_share_id" and "sd_cluster: fit in the gap after "sd_llc".
>>> However, now we see a regression for higher number of client.
>>>
>>> This probably hints that access to "sd_cluster" variable in Patch 2 and
>>> bringing in the extra cache line could be responsible for the regression
>>> we see with "tip + both patches (Move declaration to top)"
>>>
>>>>
>>>>
>>>>> 0000000000020548 D sd_share_id    <-----
>>>>> 0000000000020550 D sd_cluster     <-----
>>>>>
>>>>>> Or change the layout a bit to see if there's any difference,
>>>>>> like:
>>>>>>
>>>>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>>>>>   DEFINE_PER_CPU(int, sd_llc_size);
>>>>>>   DEFINE_PER_CPU(int, sd_llc_id);
>>>>>>   DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>>>>>> +DEFINE_PER_CPU(int, sd_share_id);
>>>>>> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>>>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>>>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>>>>>
>>>>>> I need to further look into it and have some tests on a SMT machine. Would you mind to share
>>>>>> the kernel config as well? I'd like to compare the config as well.
>>>>>
>>>>> I've attached the kernel config used to build the test kernel
>>>>> to this mail.
>>>>>
>>>>>> Thanks,
>>>>>> Yicong
>>>>>
>>>>> We are trying to debug the issue using perf and find an optimal
>>>>> arrangement of the per cpu declarations to get the relevant data
>>>>> used in the wakeup path on the same 64B cache line.
>>>>
>>>> A check of perf c2c profile difference between tip and the move new declarations to
>>>> the top case could be useful.  It may give some additional clues of possibel
>>>> false sharing issues.
>>>
>>> Thank you for the suggestion. We are currently looking at perf counter
>>> data to see how the cache efficiency has changed between the two kernels.
>>> We suspect that the need for the data in the other cache line too in the
>>> wakeup path is resulting in higher cache misses in the levels closer to
>>> the core.
>>>
>>> I don't think it is a false sharing problem as these per CPU data are
>>> set when the system first boots up and will only be change again during
>>> a CPU hotplug operation. However, it might be beneficial to see the c2c
>>> profile if perf counters don't indicate anything out of the ordinary.
>>>
>>
>> Would it be possible if any other frequent-written variables share
>> same cacheline with these per-cpu data causing false sharing? 
> 
> This indeed seems to be the case. I'll leave the
> detailed analysis below.
> 

The percpu variables seems won't be affected by the non-percpu variables as the
percpu section is already cacheline aligned. arm64's vmlinux.ld.S shows
PERCPU_SECTION(L1_CACHE_BYTES).

>> What
>> about making all these sd_* data DEFINE_PER_CPU_READ_MOSTLY?
>>
> 
> Making all the sd_* variables DEFINE_PER_CPU_READ_MOSTLY or
> placing all the sd_* variables on the same cache line doesn't
> help the regression. In fact, it makes it worse.
> 
> Following are the results on different test kernels:
> tip				- 5.19.0-rc2 tip
> 				  (commit: f3dd3f674555 "sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle")
> cluster				- tip + both the patches of the series
> Patch1				- tip + only Patch 1
> align_first (Patch 1) 		- tip + only Patch 1 + all sd_* variables in same cache line
> per_cpu_aigned_struct (Patch 1) - tip + only Patch 1 + all sd_* variables part of a per_cpu struct which is cacheline aligned
> 
> Clients:       tip                    cluster                 Patch1             align_first (Patch 1)       per_cpu_aigned_struct (Patch 1)
>     8    3263.81 (0.00 pct)      3086.81 (-5.42 pct)     3018.63 (-7.51 pct)     2993.65 (-8.27 pct)         1728.89 (-47.02 pct)
>    16    6011.19 (0.00 pct)      5360.28 (-10.82 pct)    4869.26 (-18.99 pct)    4820.18 (-19.81 pct)        3840.64 (-36.10 pct)
>    32    12058.31 (0.00 pct)     8769.08 (-27.27 pct)    8159.60 (-32.33 pct)    7868.82 (-34.74 pct)        7130.19 (-40.86 pct)
>    64    21258.21 (0.00 pct)     19021.09 (-10.52 pct)   13161.92 (-38.08 pct)   12327.86 (-42.00 pct)       12572.70 (-40.85 pct)
> 
> Following is the system map for the kernel variant "align_first (Patch 1)":
> 
> --
> 00000000000204c0 d sugov_cpu
>  ------------------------------------------------ 20500 (Cache Line Start)
> 0000000000020508 d root_cpuacct_cpuusage
> 0000000000020510 D cpufreq_update_util_data
>  ------------------------------------------------ 20540 (Cache Line Start)
> 0000000000020540 D sd_asym_cpucapacity                  
> 0000000000020548 D sd_asym_packing                      
> 0000000000020550 D sd_numa                              
> 0000000000020558 D sd_cluster                           
> 0000000000020560 D sd_llc_shared                        
> 0000000000020568 D sd_share_id                          
> 000000000002056c D sd_llc_id                            
> 0000000000020570 D sd_llc_size                          
> 0000000000020578 D sd_llc                               
>  ------------------------------------------------ 20580 (Cache Line Start)
> 0000000000020580 d wake_up_klogd_work
> 00000000000205a0 d printk_pending
> 00000000000205a4 d printk_count_nmi
> 00000000000205a5 d printk_count
> 00000000000205a8 d printk_context
>  ------------------------------------------------ 205c0 (Cache Line Start)
> 00000000000205c0 d rcu_tasks_trace__percpu
> --
> 
> At this point it was clear that one or more sd_* variable needs
> to be co-located with the per CPU variables in cache line starting
> at 20540. We began moving variable out of the cache line one by one
> to see which variable makes the difference as we found out that as
> long as root_cpuacct_cpuusage and sd_llc_id are on the same cache
> line, the results were equivalent of what we saw on the tip. As both
> the variables seem to be accesses very frequently, access to one will
> prime the cache line containing the other variable as well leading to
> better cache efficiency.
> 
> Placing root_cpuacct_cpuusage, sd_llc_id, sd_share_id, sd_llc_shared
> and sd_cluster on the same cache line, the results are as follows:
> 
> Kernel versions:
> tip					- 5.19.0-rc2 tip
> cluster					- tip + both the patches of the series
> cluster (Custom Layout)			- tip + both the patches of the series + reworked system map
> cluster (Custom Layout) + SIS_UTIL	- cluster (Custom Layout) + v4 of SIS_UTIL patchset by Chenyu
> 					  (https://lore.kernel.org/lkml/20220612163428.849378-1-yu.c.chen@intel.com/)
> 
> Clients:      tip                     cluster          cluster (Custom Layout)       cluster (Custom Layout)
>                                                                                             + SIS Util
>     1    444.41 (0.00 pct)       439.27 (-1.15 pct)      438.06 (-1.42 pct)             447.75 (0.75 pct)
>     2    879.23 (0.00 pct)       831.49 (-5.42 pct)      846.98 (-3.66 pct)             871.64 (-0.86 pct)
>     4    1648.83 (0.00 pct)      1608.07 (-2.47 pct)     1621.38 (-1.66 pct)            1656.34 (0.45 pct)
>     8    3263.81 (0.00 pct)      3086.81 (-5.42 pct)     3103.40 (-4.91 pct)     *      3227.88 (-1.10 pct)
>    16    6011.19 (0.00 pct)      5360.28 (-10.82 pct)    5838.04 (-2.88 pct)            6232.92 (3.68 pct)
>    32    12058.31 (0.00 pct)     8769.08 (-27.27 pct)    11577.73 (-3.98 pct)           11774.10 (-2.35 pct)
>    64    21258.21 (0.00 pct)     19021.09 (-10.52 pct)   19563.57 (-7.97 pct)    *      22044.93 (3.70 pct)
>   128    30795.27 (0.00 pct)     30861.34 (0.21 pct)     31705.47 (2.95 pct)            28986.14 (-5.87 pct)    *
>   256    25138.43 (0.00 pct)     24711.90 (-1.69 pct)    23929.42 (-4.80 pct)    *      43984.52 (74.96 pct)    [Known to be unstable without SIS_UTIL]
>   512    51287.93 (0.00 pct)     51855.55 (1.10 pct)     52278.33 (1.93 pct)            51511.51 (0.43 pct)
>  1024    53176.97 (0.00 pct)     52554.55 (-1.17 pct)    52995.27 (-0.34 pct)           52807.04 (-0.69 pct)
> 
> Chenyu's SIS_UTIL patch was merged today in the tip
> (commit: 70fb5ccf2ebb "sched/fair: Introduce SIS_UTIL to search idle CPU based on sum of util_avg")
> and seems to bring back performance to the same level
> as seen on the tip used during our testing.
> 
> The system map of the tested configuration labelled "Custom Layout"
> is as follows:
> 
> --
> 00000000000204c0 d sugov_cpu
>  ------------------------------------------------ 20500 (Cache Line Start)
> 0000000000020508 d root_cpuacct_cpuusage
> 0000000000020510 D cpufreq_update_util_data
> 0000000000020518 D sd_llc_id
> 000000000002051c D sd_share_id
> 0000000000020520 D sd_llc_shared
> 0000000000020528 D sd_cluster
> 0000000000020530 D sd_asym_cpucapacity
> 0000000000020538 D sd_asym_packing
>  ------------------------------------------------ 20540 (Cache Line Start)
> 0000000000020540 D sd_numa
> 0000000000020548 D sd_llc_size
> 0000000000020550 D sd_llc
> 0000000000020560 d wake_up_klogd_work
>  ------------------------------------------------ 20580 (Cache Line Start)
> 0000000000020580 d printk_pending
> 0000000000020584 d printk_count_nmi
> 0000000000020585 d printk_count
> 0000000000020588 d printk_context
>  ------------------------------------------------ 205c0 (Cache Line Start)
> 00000000000205c0 d rcu_tasks_trace__percpu
> --
> 

Thanks for the data. It looks sufficient to illustrate the issue. I'm still a little curious that
is it specific on Zen 3? Since I cannot get the Zen 3 machine so I tried to reproduce this on the a
AMD 7742 (2 x 64C/128T) and an Intel 6148 (2 x 40C/80T) machine with your config based on tip/sche/core
of commit f3dd3f674555 "sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle".
With cluster's percpu definition patch(the worst case) the root_cpuacct_cpuusage and sd_llc_id are
separated but make little difference to the tbench.

For 7742 with NPS = 1:					
	tip/sched/core				tip/sched/core-cls-percpu				
threads	iter-1	iter-2	iter-3	avg		iter-1	iter-2	iter-3	avg	
1	287.254	285.252	288.29	286.93		288.105	285.884	286.164	286.72   (-0.075%)
2	573.623	570.326	573.67	572.54		577.242	574.257	575.611	575.70   (0.553%)
4	1140.01	1135.54	1137.9	1137.82		1153.45	1146.66	1149.8	1149.97  (1.068%)
8	2232.73	2228.71	2237.47	2232.97		2280.83	2291.94	2287.55	2286.77  (2.409%)
16	4510.65	4465.2	4522.22	4499.36		4551.19	4573.85	4575.78	4566.94  (1.502%)
32	8432.43	8542.35	8404.7	8459.83		8627.4	8712.29	8764.53	8701.41  (2.856%)
64	16404.2	16464.7	15686.4	16185.10	15878.3	15638.3	15735.6	15750.73 (-2.684%)
128	23327.6	22767.4	21017.3	22370.77	23774.9	23733.2	21744.9	23084.33 (3.190%)

layout of core-cls-percpu:
0000000000020508 d root_cpuacct_cpuusage
0000000000020510 D cpufreq_update_util_data
0000000000020518 D sd_asym_cpucapacity
0000000000020520 D sd_asym_packing
0000000000020528 D sd_numa
0000000000020530 D sd_cluster
0000000000020538 D sd_llc_shared
---------------------------------boundary
0000000000020540 D sd_share_id
0000000000020544 D sd_llc_id
0000000000020548 D sd_llc_size
0000000000020550 D sd_llc

For 6148 with SNC disabled:
         tip/sched/core       tip/sched/core-cls-percpu
1        314.44 (   0.00%)      316.68 *   0.71%*
2        630.22 (   0.00%)      633.84 *   0.57%*
4       1260.70 (   0.00%)     1267.32 *   0.52%*
8       2475.31 (   0.00%)     2485.94 *   0.43%*
16      4684.03 (   0.00%)     4682.21 *  -0.04%*
32      7496.28 (   0.00%)     7360.41 *  -1.81%*
64      7981.56 (   0.00%)     7851.73 *  -1.63%*
128    15359.81 (   0.00%)    15255.68 *  -0.68%*
256    15104.31 (   0.00%)    15253.85 *   0.99%*
320    15146.47 (   0.00%)    15151.39 *   0.03%*

layout of core-cls-percpu:
0000000000020508 d root_cpuacct_cpuusage
0000000000020510 D cpufreq_update_util_data
0000000000020518 D sd_asym_cpucapacity
0000000000020520 D sd_asym_packing
0000000000020528 D sd_numa
0000000000020530 D sd_cluster
0000000000020538 D sd_llc_shared
---------------------------------boundary
0000000000020540 D sd_share_id
0000000000020544 D sd_llc_id
0000000000020548 D sd_llc_size
0000000000020550 D sd_llc


> The System-map is however dependent on multiple factors
> such as config options enabled, etc. which can change from
> build to build.
> Finding a permanent solution to the issue might take
> some more time.
> 
> Meanwhile, as this is an issue unrelated to the
> functionality of this patch, it should not block
> the landing of this patch series.
> Thank you everyone for your pointers and patience
> during this debug.
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks. Then I'll respin the patch.

Regards,
Yicong

