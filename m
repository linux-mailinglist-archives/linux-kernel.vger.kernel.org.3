Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D2555C1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiF0IQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiF0IQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:16:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395E1626D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:16:50 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LWgX16K3ZzkWtn;
        Mon, 27 Jun 2022 16:15:29 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 16:16:33 +0800
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <guodong.xu@linaro.org>, <hesham.almatary@huawei.com>,
        <john.garry@huawei.com>, <shenyang39@huawei.com>
Subject: Re: [PATCH v4 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <tim.c.chen@linux.intel.com>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
 <20220609120622.47724-3-yangyicong@hisilicon.com>
 <9cf43b10-85a2-1a83-057f-c43be339265e@bytedance.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <3105c9d4-9707-e9a3-47e5-c63095fa46e2@huawei.com>
Date:   Mon, 27 Jun 2022 16:16:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <9cf43b10-85a2-1a83-057f-c43be339265e@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/6/26 20:13, Abel Wu wrote:
> 
> On 6/9/22 8:06 PM, Yicong Yang Wrote:
>> From: Barry Song <song.bao.hua@hisilicon.com>
>>
>> For platforms having clusters like Kunpeng920, CPUs within the same cluster
>> have lower latency when synchronizing and accessing shared resources like
>> cache. Thus, this patch tries to find an idle cpu within the cluster of the
>> target CPU before scanning the whole LLC to gain lower latency.
>>
>> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so this patch
>> doesn't consider SMT for this moment.
>>
>> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
>> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
>>
>> With this patch, We noticed enhancement on tbench within one numa or cross
>> two numa.
>>
>> On numa 0:
>>                              5.19-rc1                patched
>> Hmean     1        350.27 (   0.00%)      406.88 *  16.16%*
>> Hmean     2        702.01 (   0.00%)      808.22 *  15.13%*
>> Hmean     4       1405.14 (   0.00%)     1614.34 *  14.89%*
>> Hmean     8       2830.53 (   0.00%)     3169.02 *  11.96%*
>> Hmean     16      5597.95 (   0.00%)     6224.20 *  11.19%*
>> Hmean     32     10537.38 (   0.00%)    10524.97 *  -0.12%*
>> Hmean     64      8366.04 (   0.00%)     8437.41 *   0.85%*
>> Hmean     128     7060.87 (   0.00%)     7150.25 *   1.27%*
>>
>> On numa 0-1:
>>                              5.19-rc1                patched
>> Hmean     1        346.11 (   0.00%)      408.47 *  18.02%*
>> Hmean     2        693.34 (   0.00%)      805.78 *  16.22%*
>> Hmean     4       1384.96 (   0.00%)     1602.49 *  15.71%*
>> Hmean     8       2699.45 (   0.00%)     3069.98 *  13.73%*
>> Hmean     16      5327.11 (   0.00%)     5688.19 *   6.78%*
>> Hmean     32     10019.10 (   0.00%)    11862.56 *  18.40%*
>> Hmean     64     13850.57 (   0.00%)    17748.54 *  28.14%*
>> Hmean     128    12498.25 (   0.00%)    15541.59 *  24.35%*
>> Hmean     256    11195.77 (   0.00%)    13854.06 *  23.74%*
>>
>> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   kernel/sched/fair.c | 44 +++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 41 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 77b2048a9326..6d173e196ad3 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6327,6 +6327,40 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>>     #endif /* CONFIG_SCHED_SMT */
>>   +#ifdef CONFIG_SCHED_CLUSTER
>> +/*
>> + * Scan the cluster domain for idle CPUs and clear cluster cpumask after scanning
>> + */
>> +static inline int scan_cluster(struct task_struct *p, struct cpumask *cpus,
>> +                   int target, int *nr)
>> +{
>> +    struct sched_domain *sd = rcu_dereference(per_cpu(sd_cluster, target));
>> +    int cpu, idle_cpu;
>> +
>> +    /* TODO: Support SMT system with cluster topology */
>> +    if (!sched_smt_active() && sd) {
>> +        for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
>> +            if (!--*nr)
>> +                break;
> 
> return -1;
> :)
> 

thanks for the comment. If we've run out of nr the select_idle_cpu() will stop scanning as well,
so it's unnecessary to clear the mask of cluster cpus and just return.
