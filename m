Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6552859D291
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiHWHsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241186AbiHWHsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:48:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E4E647FC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:48:03 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBh9M36H9znThn;
        Tue, 23 Aug 2022 15:45:43 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 15:48:01 +0800
CC:     <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <tim.c.chen@linux.intel.com>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <guodong.xu@linaro.org>, <hesham.almatary@huawei.com>,
        <john.garry@huawei.com>, <shenyang39@huawei.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>
Subject: Re: [PATCH v7 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Chen Yu <yu.c.chen@intel.com>
References: <20220822073610.27205-1-yangyicong@huawei.com>
 <20220822073610.27205-3-yangyicong@huawei.com>
 <YwRNXrBG9iq1jGZW@chenyu5-mobl1>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <53b1fc3c-b6a9-a4cb-433a-c5c6af1d1dac@huawei.com>
Date:   Tue, 23 Aug 2022 15:48:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YwRNXrBG9iq1jGZW@chenyu5-mobl1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/8/23 11:45, Chen Yu wrote:
> On 2022-08-22 at 15:36:10 +0800, Yicong Yang wrote:
>> From: Barry Song <song.bao.hua@hisilicon.com>
>>
>> For platforms having clusters like Kunpeng920, CPUs within the same cluster
>> have lower latency when synchronizing and accessing shared resources like
>> cache. Thus, this patch tries to find an idle cpu within the cluster of the
>> target CPU before scanning the whole LLC to gain lower latency.
>>
>> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
>> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
>>
>> With this patch, We noticed enhancement on tbench within one numa or cross
>> two numa.
>>
>> On numa 0:
>>                              6.0-rc1                patched
>> Hmean     1        351.20 (   0.00%)      396.45 *  12.88%*
>> Hmean     2        700.43 (   0.00%)      793.76 *  13.32%*
>> Hmean     4       1404.42 (   0.00%)     1583.62 *  12.76%*
>> Hmean     8       2833.31 (   0.00%)     3147.85 *  11.10%*
>> Hmean     16      5501.90 (   0.00%)     6089.89 *  10.69%*
>> Hmean     32     10428.59 (   0.00%)    10619.63 *   1.83%*
>> Hmean     64      8223.39 (   0.00%)     8306.93 *   1.02%*
>> Hmean     128     7042.88 (   0.00%)     7068.03 *   0.36%*
>>
>> On numa 0-1:
>>                              6.0-rc1                patched
>> Hmean     1        363.06 (   0.00%)      397.13 *   9.38%*
>> Hmean     2        721.68 (   0.00%)      789.84 *   9.44%*
>> Hmean     4       1435.15 (   0.00%)     1566.01 *   9.12%*
>> Hmean     8       2776.17 (   0.00%)     3007.05 *   8.32%*
>> Hmean     16      5471.71 (   0.00%)     6103.91 *  11.55%*
>> Hmean     32     10164.98 (   0.00%)    11531.81 *  13.45%*
>> Hmean     64     17143.28 (   0.00%)    20078.68 *  17.12%*
>> Hmean     128    14552.70 (   0.00%)    15156.41 *   4.15%*
>> Hmean     256    12827.37 (   0.00%)    13326.86 *   3.89%*
>>
>> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
>> in the code has not been tested but it supposed to work.
>>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> [https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
>> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> ---
>>  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
>>  kernel/sched/sched.h    |  2 ++
>>  kernel/sched/topology.c | 10 ++++++++++
>>  3 files changed, 39 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 914096c5b1ae..6fa77610d0f5 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6437,6 +6437,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>  		}
>>  	}
>>  
>> +	if (static_branch_unlikely(&sched_cluster_active)) {
>> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
>> +
>> +		if (sdc) {
>> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
> Looks good to me. One minor question, why don't we use
> cpumask_and(cpus, sched_domain_span(sdc), cpus);
>> +				if (!cpumask_test_cpu(cpu, cpus))
>> +					continue;
> so above check can be removed in each loop?

Since we'll need to recalculate the mask of rest CPUs to test in the LLC after scanning the cluster CPUs.

> Besides may I know what version this patch
> is based on? since I failed to apply the patch on v6.0-rc2. Other than that:
> 

It's on 6.0-rc1 when sent but can be cleanly rebased on rc2:

yangyicong@ubuntu:~/mainline_linux/linux_sub_workspace$ git log --oneline -3
0079c27ba265 (HEAD -> topost-cls-v7, topost-cls-v6) sched/fair: Scan cluster before scanning LLC in wake-up path
1ecb9e322bd7 sched: Add per_cpu cluster domain info and cpus_share_lowest_cache API
1c23f9e627a7 (tag: v6.0-rc2, origin/master, origin/HEAD, master) Linux 6.0-rc2

So I'm not sure where's the problem...

> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> 

Thanks!

> thanks,
> Chenyu
>> +
>> +				if (has_idle_core) {
>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
>> +					if ((unsigned int)i < nr_cpumask_bits)
>> +						return i;
>> +				} else {
>> +					if (--nr <= 0)
>> +						return -1;
>> +					idle_cpu = __select_idle_cpu(cpu, p);
>> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
>> +						return idle_cpu;
>> +				}
>> +			}
>> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
>> +		}
>> +	}
> .
> 
