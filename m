Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC34B5746CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiGNIeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGNIeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:34:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A5F3A484
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:34:18 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lk7602w41zlVlS;
        Thu, 14 Jul 2022 16:32:40 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 16:34:09 +0800
CC:     <yangyicong@hisilicon.com>, Josh Don <joshdon@google.com>,
        Chen Yu <yu.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
From:   Yicong Yang <yangyicong@huawei.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <8e7d75d4-613e-f35e-e932-323789666fb1@huawei.com>
 <4dde05be-8470-5984-0a30-ba077b9fe6bd@bytedance.com>
 <e8a59a8f-1e0c-2bb6-2d1b-4e76f5c511f5@huawei.com>
 <5df03ae2-6c5d-aa38-4a4d-632c0f484140@bytedance.com>
 <ab909cde-5e1e-a91e-473a-97dd2bd46e63@huawei.com>
Message-ID: <86582457-06eb-b239-37e5-7d46fade8a6f@huawei.com>
Date:   Thu, 14 Jul 2022 16:34:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ab909cde-5e1e-a91e-473a-97dd2bd46e63@huawei.com>
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

On 2022/7/14 16:16, Yicong Yang wrote:
> On 2022/7/14 16:00, Abel Wu wrote:
>>
>> On 7/14/22 3:15 PM, Yicong Yang Wrote:
>>> On 2022/7/14 14:58, Abel Wu wrote:
>>>>
>>>> On 7/14/22 2:19 PM, Yicong Yang Wrote:
>>>>> On 2022/7/12 16:20, Abel Wu wrote:
>>>>>> When SIS_UTIL is enabled, SIS domain scan will be skipped if
>>>>>> the LLC is overloaded. Since the overloaded status is checked
>>>>>> in the load balancing at LLC level, the interval is llc_size
>>>>>> miliseconds. The duration might be long enough to affect the
>>>>>> overall system throughput if idle cores are out of reach in
>>>>>> SIS domain scan.
>>>>>>
>>>>>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>>>>>> ---
>>>>>>    kernel/sched/fair.c | 15 +++++++++------
>>>>>>    1 file changed, 9 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>>> index a78d2e3b9d49..cd758b3616bd 100644
>>>>>> --- a/kernel/sched/fair.c
>>>>>> +++ b/kernel/sched/fair.c
>>>>>> @@ -6392,16 +6392,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>>>>        struct sched_domain *this_sd;
>>>>>>        u64 time = 0;
>>>>>>    -    this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>>>>>> -    if (!this_sd)
>>>>>> -        return -1;
>>>>>> -
>>>>>>        cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>>>>>    -    if (sched_feat(SIS_PROP) && !has_idle_core) {
>>>>>> +    if (has_idle_core)
>>>>>> +        goto scan;
>>>>>> +
>>>>>> +    if (sched_feat(SIS_PROP)) {
>>>>>>            u64 avg_cost, avg_idle, span_avg;
>>>>>>            unsigned long now = jiffies;
>>>>>>    +        this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>>>>>> +        if (!this_sd)
>>>>>> +            return -1;
>>>>>> +
>>>>>
>>>>> I don't follow the change here. True that this_sd is used only in SIS_PROP, but it seems irrelevant with your
>>>>> commit. Does the position of this make any performance difference?
>>>>
>>>> No, this change doesn't make much difference to performance. Are
>>>> you suggesting that I should make this a separate patch?
>>>>
>>>
>>> It just makes me think that dereference is unnecessary if this_cpu and target locates in
>>> the same LLC, since it's already been passed. But since you noticed no difference it may
>>> have little effect. :)
>>>
>>
>> Hmm.. Not exactly. The sched-domains are cpu private

>>, and this_cpu can be in another LLC than target.

This is not the condition I meant to, I would have thought it would make some sense only when they're in
the same LLC. Anyway since no difference for dereference or not, it doesn't matter at all.
Thanks for the explanation.

>> .
> 
> yes. you're right. sorry for get this messed.
> 
> .
> 
