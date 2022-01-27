Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539E049D8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiA0DF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:05:56 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35876 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiA0DF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:05:56 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JklnV6ZyDzccj6;
        Thu, 27 Jan 2022 11:05:02 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 11:05:53 +0800
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <song.bao.hua@hisilicon.com>, <guodong.xu@linaro.org>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-3-yangyicong@hisilicon.com>
 <f2617aa806df6d64718a7cb5b41bafe593bccda3.camel@linux.intel.com>
 <b793e565-670d-cc66-6947-7d927ebcb8b3@huawei.com>
 <95f82bf3524289bfbcaeee6e83b6dac48ed07f25.camel@linux.intel.com>
 <62bbdd77f70f7b46a044685668e33fb031812c38.camel@linux.intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <4d4099d8-e890-9e56-c395-5f521d98081a@huawei.com>
Date:   Thu, 27 Jan 2022 11:05:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <62bbdd77f70f7b46a044685668e33fb031812c38.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/27 10:36, Tim Chen wrote:
> On Wed, 2022-01-26 at 18:30 -0800, Tim Chen wrote:
>> On Thu, 2022-01-27 at 10:02 +0800, Yicong Yang wrote:
>>> On 2022/1/27 9:14, Tim Chen wrote:
>>>> On Wed, 2022-01-26 at 16:09 +0800, Yicong Yang wrote:
>>>>> From: Barry Song <song.bao.hua@hisilicon.com>
>>>>>
>>>>> For platforms having clusters like Kunpeng920, CPUs within the
>>>>> same
>>>>> cluster have lower latency when synchronizing and accessing
>>>>> shared
>>>>> resources like cache. Thus, this patch tries to find an idle
>>>>> cpu
>>>>> within the cluster of the target CPU before scanning the whole
>>>>> LLC
>>>>> to gain lower latency.
>>>>>
>>>>> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so
>>>>> this
>>>>> patch doesn't consider SMT for this moment.
>>>>>
>>>>> Testing has been done on Kunpeng920 by pinning tasks to one
>>>>> numa
>>>>> and two numa. On Kunpeng920, Each numa has 8 clusters and each
>>>>> cluster has 4 CPUs.
>>>>>
>>>>> With this patch, We noticed enhancement on tbench within one
>>>>> numa or cross two numa.
>>>>>
>>>>> On numa 0:
>>>>>                             5.17-rc1                patched
>>>>> Hmean     1        324.73 (   0.00%)      378.01 *  16.41%*
>>>>> Hmean     2        645.36 (   0.00%)      754.63 *  16.93%*
>>>>> Hmean     4       1302.09 (   0.00%)     1507.54 *  15.78%*
>>>>> Hmean     8       2612.03 (   0.00%)     2982.57 *  14.19%*
>>>>> Hmean     16      5307.12 (   0.00%)     5886.66 *  10.92%*
>>>>> Hmean     32      9354.22 (   0.00%)     9908.13 *   5.92%*
>>>>> Hmean     64      7240.35 (   0.00%)     7278.78 *   0.53%*
>>>>> Hmean     128     6186.40 (   0.00%)     6187.85 (   0.02%)
>>>>>
>>>>> On numa 0-1:
>>>>>                             5.17-rc1                patched
>>>>> Hmean     1        320.01 (   0.00%)      378.44 *  18.26%*
>>>>> Hmean     2        643.85 (   0.00%)      752.52 *  16.88%*
>>>>> Hmean     4       1287.36 (   0.00%)     1505.62 *  16.95%*
>>>>> Hmean     8       2564.60 (   0.00%)     2955.29 *  15.23%*
>>>>> Hmean     16      5195.69 (   0.00%)     5814.74 *  11.91%*
>>>>> Hmean     32      9769.16 (   0.00%)    10872.63 *  11.30%*
>>>>> Hmean     64     15952.50 (   0.00%)    17281.98 *   8.33%*
>>>>> Hmean     128    13113.77 (   0.00%)    13895.20 *   5.96%*
>>>>> Hmean     256    10997.59 (   0.00%)    11244.69 *   2.25%*
>>>>> Hmean     512    14623.60 (   0.00%)    15526.25 *   6.17%*
>>>>>
>>>>> This will also help to improve the MySQL. With MySQL server
>>>>> running on numa 0 and client running on numa 1, both QPS and
>>>>> latency is imporved on read-write case:
>>>>>                         5.17-rc1        patched
>>>>> QPS-16threads        143333.2633    145077.4033(+1.22%)
>>>>> QPS-24threads        195085.9367    202719.6133(+3.91%)
>>>>> QPS-32threads        241165.6867      249020.74(+3.26%)
>>>>> QPS-64threads        244586.8433    253387.7567(+3.60%)
>>>>> avg-lat-16threads           2.23           2.19(+1.19%)
>>>>> avg-lat-24threads           2.46           2.36(+3.79%)
>>>>> avg-lat-36threads           2.66           2.57(+3.26%)
>>>>> avg-lat-64threads           5.23           5.05(+3.44%)
>>>>>
>>>>> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>>>>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>>> ---
>>>>>  kernel/sched/fair.c | 46
>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>> ----
>>>>>  1 file changed, 42 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index 5146163bfabb..2f84a933aedd 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -6262,12 +6262,46 @@ static inline int
>>>>> select_idle_smt(struct
>>>>> task_struct *p, struct sched_domain *sd
>>>>>  
>>>>>  #endif /* CONFIG_SCHED_SMT */
>>>>>  
>>>>> +#ifdef CONFIG_SCHED_CLUSTER
>>>>> +/*
>>>>> + * Scan the cluster domain for idle CPUs and clear cluster
>>>>> cpumask
>>>>> after scanning
>>>>> + */
>>>>> +static inline int scan_cluster(struct task_struct *p, int
>>>>> prev_cpu,
>>>>> int target)
>>>>> +{
>>>>> +	struct cpumask *cpus =
>>>>> this_cpu_cpumask_var_ptr(select_idle_mask);
>>>>> +	struct sched_domain *sd =
>>>>> rcu_dereference(per_cpu(sd_cluster,
>>>>> target));
>>>>> +	int cpu, idle_cpu;
>>>>> +
>>>>> +	/* TODO: Support SMT case while a machine with both
>>>>> cluster and
>>>>> SMT born */
>>>>
>>>> This is probably a clearer comment
>>>>
>>>> 	/* TODO: Support SMT system with cluster topology */
>>>>
>>>>> +	if (!sched_smt_active() && sd) {
>>>>> +		for_each_cpu_and(cpu, cpus,
>>>>> sched_domain_span(sd)) {
>>>>> +			idle_cpu = __select_idle_cpu(cpu, p);
>>>>>   */
>>>>> -static int select_idle_cpu(struct task_struct *p, struct
>>>>> sched_domain *sd, bool has_idle_core, int target)
>>>>> +static int select_idle_cpu(struct task_struct *p, struct
>>>>> sched_domain *sd, bool has_idle_core, int prev_cpu, int target)
>>>>>  {
>>>>>  	struct cpumask *cpus =
>>>>> this_cpu_cpumask_var_ptr(select_idle_mask);
>>>>>  	int i, cpu, idle_cpu = -1, nr = INT_MAX;
>>>>> @@ -6282,6 +6316,10 @@ static int select_idle_cpu(struct
>>>>> task_struct
>>>>> *p, struct sched_domain *sd, bool
>>>>>  
>>>>>  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>>>>  
>>>>> +	idle_cpu = scan_cluster(p, prev_cpu, target);
>>>>
>>>> Shouldn't "cpus" from 
>>>>
>>>> cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>>>
>>>> be passed to scan_cluster, to make sure that the cpu returned is 
>>>> in the affinity mask of the task? I don't see p->cpus_ptr
>>>> being checked in scan_cluster to make sure the cpu found is in
>>>> the
>>>> affinity mask.
>>>>
>>>
>>> The cpus scanned in scan_cluster() is the intersection of
>>> select_idle_mask and sched_domain_span(cluster_sd), and
>>> we limited the select_idle_mask in the tasks' affinity mask
>>> before we enter scan_cluster() here.
>>
>> Ah, I missed the fact that cpus point to the select_idle_mask.
>>
> 
> I think it will be easier to read the code if you pass "cpus" directly
> to scan cluster, rather than making this implicit, and having this
> assignment 
> 
> *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> 
> again in scan_cluster.

sure. It does look more readable and I think we can change to that. :)

Thanks.
