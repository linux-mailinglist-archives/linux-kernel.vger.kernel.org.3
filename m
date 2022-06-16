Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17154DC88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359633AbiFPIK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358831AbiFPIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:10:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853995D1B9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:10:54 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LNvw04yRfzjXf3;
        Thu, 16 Jun 2022 16:09:20 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 16:10:52 +0800
CC:     <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <guodong.xu@linaro.org>, <hesham.almatary@huawei.com>,
        <john.garry@huawei.com>, <shenyang39@huawei.com>
Subject: Re: [PATCH v4 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
 <20220609120622.47724-2-yangyicong@hisilicon.com>
 <e000b124-afd4-28e1-fde2-393b0e38ce19@amd.com>
 <Yqn+K08JFRgtR3eY@BLR-5CG11610CF.amd.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <ce4b3fd8-70db-b427-9087-bbff78eb9e2e@huawei.com>
Date:   Thu, 16 Jun 2022 16:10:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <Yqn+K08JFRgtR3eY@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/15 23:43, Gautham R. Shenoy wrote:
> On Wed, Jun 15, 2022 at 07:49:22PM +0530, K Prateek Nayak wrote:
> 
> [..snip..]
> 
>>
>> - Bisecting:
>>
>> When we ran the tests with only Patch 1 of the series, the
>> regression was visible and the numbers were worse.
>>
>> Clients:       tip                     cluster              Patch 1 Only
>>     8    3263.81 (0.00 pct)      3086.81 (-5.42 pct)     3018.63 (-7.51 pct)
>>    16    6011.19 (0.00 pct)      5360.28 (-10.82 pct)    4869.26 (-18.99 pct)
>>    32    12058.31 (0.00 pct)     8769.08 (-27.27 pct)    8159.60 (-32.33 pct)
>>    64    21258.21 (0.00 pct)     19021.09 (-10.52 pct)   13161.92 (-38.08 pct)
>>
>> We further bisected the hunks to narrow down the cause to the per CPU
>> variable declarations. 
>>
>>
>>>
>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index 01259611beb9..b9bcfcf8d14d 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -1753,7 +1753,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>>>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>>  DECLARE_PER_CPU(int, sd_llc_size);
>>>  DECLARE_PER_CPU(int, sd_llc_id);
>>> +DECLARE_PER_CPU(int, sd_share_id);
>>>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>>> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>
>> The main reason for the regression seems to be the above declarations.
> 
> I think you meant that the regressions are due to the DEFINE_PER_CPU()
> instances from the following hunk:
> 
>>> @@ -664,6 +664,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
>>>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>>  DEFINE_PER_CPU(int, sd_llc_size);
>>>  DEFINE_PER_CPU(int, sd_llc_id);
>>> +DEFINE_PER_CPU(int, sd_share_id);
>>> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>>>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>>
> 
> 
> The System.map diff for these variables between tip vs tip +
> cluster-sched-v4 on your test system looks as follows:
> 
>  0000000000020520 D sd_asym_packing
>  0000000000020528 D sd_numa
> -0000000000020530 D sd_llc_shared
> -0000000000020538 D sd_llc_id
> -000000000002053c D sd_llc_size
> -0000000000020540 D sd_llc
> +0000000000020530 D sd_cluster
> +0000000000020538 D sd_llc_shared

looks like below are in another cacheline (for 64B cacheline)?
while previous sd_llc_id and sd_llc_shared are in the same.

> +0000000000020540 D sd_share_id
> +0000000000020544 D sd_llc_id
> +0000000000020548 D sd_llc_size
> +0000000000020550 D sd_llc
> 
> The allocations are in the reverse-order of the definitions.
> 
> That perhaps explains why you no longer see the regression when you
> define the sd_share_id and sd_cluster per-cpu definitions at the
> beginning as indicated by the following
> 
>> - Move the declarations of sd_share_id and sd_cluster to the top
>>
>>   Clients:       tip                    Patch 1            Patch 1 (Declarion on Top)
>>     8      3255.69 (0.00 pct)      3018.63 (-7.28 pct)     3072.30 (-5.63 pct)
>>    16      6092.67 (0.00 pct)      4869.26 (-20.08 pct)    5586.59 (-8.30 pct)
>>    32      11156.56 (0.00 pct)     8159.60 (-26.86 pct)    11184.17 (0.24 pct)
>>    64      21019.97 (0.00 pct)     13161.92 (-37.38 pct)   20289.70 (-3.47 pct)
> 
> 
> --
> Thanks and Regards
> gautham.
> .
> 
