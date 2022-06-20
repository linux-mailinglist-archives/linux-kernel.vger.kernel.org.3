Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC01551DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346899AbiFTOXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243428AbiFTOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:23:12 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E927B1CFF6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:38:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w24so1918476pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c8YNw1AleDZr2PgcXBhEM7JfMjjHuOpHKDXWjOhlNaw=;
        b=NQA4GcofMjP/frNXBBOrnusbRPnqkJzpAV+TwSGUR6XkzjG1YefzDaoyCM5nOb3R/S
         Qt1hrfFY5awS7RH6VtmEMQAXWbGgp++CeODwj1K3M+4Z4P9Pv+h+RPOi1JTZs8uzQG8E
         SvoPpeUvszsxZtnYgmQMqoa9LiZgDHUm9weN+jleoxoRk7I4lZ5NS417RMXg3OlQqhuD
         p/sexx0YI4xeNg0u5JoETXShwcgthGw4eOHK7JxQsplXYpaFWqiqdySB7sOukHtjmGkS
         LD9/NEQmCWXRkcWnsQy67FIUNggDlSJ5MH0gE1VRyyBxpc70EBsLJ7LmoI3Tv85LvhkK
         6gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c8YNw1AleDZr2PgcXBhEM7JfMjjHuOpHKDXWjOhlNaw=;
        b=fl0NkAGdcapL0kz3sK5CJWMAdZrVVwYBKPxyS5Ruzpzc7Cn1q7u6Dxv0C+uOyYC72N
         k1yXdB8iPIqkMx8IN/2mvfregly3+5T3U9sTdiD4ZUR0ZhC/4nXUhY8CPDCigfopack0
         5I6cJND7Q364kFcatWAicwCMy8HmNgrNfPXNOR3CFhjCqU+BGrQPE0KHmMuavXRmqltw
         CG3K9rKcu6HvvdaNvJ8eaXphOdlMttXvS/U4hQNyHQ/AdmyucdUifOWcwMoDC0PcqDZE
         tmMw9GhRYtBBTMXqWwa1hdbkaO/KtMP6d8zmACKy7XDutzmkThx60h7tqmRiImSxxHh1
         2SoQ==
X-Gm-Message-State: AJIora/DZZ92D16OES7no5P7JUrtQHjXqEtaL+Q1c6VRgmUx7lyQq/Uq
        LrfT+TdFS6VSNiLAcO0COWFyWQ==
X-Google-Smtp-Source: AGRyM1uihOPoXbHX0hLu10A3bgsC/489Z4HmLLQCnEaqwEdg/xmxP1bUYD4BL/DpWVLVLxR5uKWkJg==
X-Received: by 2002:a17:90b:4b02:b0:1e2:ff51:272a with SMTP id lx2-20020a17090b4b0200b001e2ff51272amr26892705pjb.56.1655732289696;
        Mon, 20 Jun 2022 06:38:09 -0700 (PDT)
Received: from [10.4.96.127] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id u123-20020a626081000000b00522d329e36esm9438354pfb.140.2022.06.20.06.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 06:38:09 -0700 (PDT)
Message-ID: <cf13647f-6bb6-34d5-c6b6-41a7500a9612@bytedance.com>
Date:   Mon, 20 Jun 2022 21:37:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
Content-Language: en-US
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com, feng.tang@intel.com
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
 <20220609120622.47724-2-yangyicong@hisilicon.com>
 <e000b124-afd4-28e1-fde2-393b0e38ce19@amd.com>
 <81fbcadb-a58d-2cef-9c05-154555ec1d68@huawei.com>
 <6bf4f032-7d07-d4a4-4f5a-28f3871131c0@amd.com>
 <b87ddfd7a8dd418edfcdbad22a4fc1e9ef03109a.camel@linux.intel.com>
 <5638aed5-bbd0-a74e-759f-0de51e3651f7@amd.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <5638aed5-bbd0-a74e-759f-0de51e3651f7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/20/22 7:20 PM, K Prateek Nayak Wrote:
> Hello Tim,
> 
> Thank you for looking into this.
> 
> On 6/17/2022 10:20 PM, Tim Chen wrote:
>> On Fri, 2022-06-17 at 17:50 +0530, K Prateek Nayak wrote:
>>>
>>>
>>> --
>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index e9f3dc6dcbf4..97a3895416ab 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -1750,12 +1750,12 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>>>   	return sd;
>>>   }
>>>   
>>> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>> +DECLARE_PER_CPU(int, sd_share_id);
>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>>   DECLARE_PER_CPU(int, sd_llc_size);
>>>   DECLARE_PER_CPU(int, sd_llc_id);
>>> -DECLARE_PER_CPU(int, sd_share_id);
>>>   DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>>> -DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>>> --
>>>
>>> The System-map of each kernel is as follows:
>>>
>>> - On "tip"
>>>
>>> 0000000000020518 D sd_asym_cpucapacity
>>> 0000000000020520 D sd_asym_packing
>>> 0000000000020528 D sd_numa
>>> 0000000000020530 D sd_llc_shared
>>> 0000000000020538 D sd_llc_id
>>> 000000000002053c D sd_llc_size
>>> -------------------------------------------- 64B Cacheline Boundary
>>> 0000000000020540 D sd_llc
>>>
>>> - On "tip + Patch 1 only" and "tip + both patches"
>>>
>>> 0000000000020518 D sd_asym_cpucapacity
>>> 0000000000020520 D sd_asym_packing
>>> 0000000000020528 D sd_numa
>>> 0000000000020530 D sd_cluster     <-----
>>> 0000000000020538 D sd_llc_shared
>>> -------------------------------------------- 64B Cacheline Boundary
>>> 0000000000020540 D sd_share_id    <-----
>>> 0000000000020544 D sd_llc_id
>>> 0000000000020548 D sd_llc_size
>>> 0000000000020550 D sd_llc
>>>
>>>
>>> - On "tip + both patches (Move declaration to top)"
>>>
>>> 0000000000020518 D sd_asym_cpucapacity
>>> 0000000000020520 D sd_asym_packing
>>> 0000000000020528 D sd_numa
>>> 0000000000020530 D sd_llc_shared
>>> 0000000000020538 D sd_llc_id
>>> 000000000002053c D sd_llc_size
>>> -------------------------------------------- 64B Cacheline Boundary
>>> 0000000000020540 D sd_llc
>>
>> Wonder if it will help to try keep sd_llc and sd_llc_size into the same
>> cache line.  They are both used in the wake up path.
> 
> We are still evaluating keeping which set of variables on the same
> cache line will provide the best results.
> 
> I would have expected the two kernel variants - "tip" and the
> "tip + both patches (Move declaration to top)" - to give similar results
> as their System map for all the old variables remain the same and the
> addition of "sd_share_id" and "sd_cluster: fit in the gap after "sd_llc".
> However, now we see a regression for higher number of client.
> 
> This probably hints that access to "sd_cluster" variable in Patch 2 and
> bringing in the extra cache line could be responsible for the regression
> we see with "tip + both patches (Move declaration to top)"
> 
>>
>>
>>> 0000000000020548 D sd_share_id    <-----
>>> 0000000000020550 D sd_cluster     <-----
>>>
>>>> Or change the layout a bit to see if there's any difference,
>>>> like:
>>>>
>>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>>>   DEFINE_PER_CPU(int, sd_llc_size);
>>>>   DEFINE_PER_CPU(int, sd_llc_id);
>>>>   DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>>>> +DEFINE_PER_CPU(int, sd_share_id);
>>>> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>>>
>>>> I need to further look into it and have some tests on a SMT machine. Would you mind to share
>>>> the kernel config as well? I'd like to compare the config as well.
>>>
>>> I've attached the kernel config used to build the test kernel
>>> to this mail.
>>>
>>>> Thanks,
>>>> Yicong
>>>
>>> We are trying to debug the issue using perf and find an optimal
>>> arrangement of the per cpu declarations to get the relevant data
>>> used in the wakeup path on the same 64B cache line.
>>
>> A check of perf c2c profile difference between tip and the move new declarations to
>> the top case could be useful.  It may give some additional clues of possibel
>> false sharing issues.
> 
> Thank you for the suggestion. We are currently looking at perf counter
> data to see how the cache efficiency has changed between the two kernels.
> We suspect that the need for the data in the other cache line too in the
> wakeup path is resulting in higher cache misses in the levels closer to
> the core.
> 
> I don't think it is a false sharing problem as these per CPU data are
> set when the system first boots up and will only be change again during
> a CPU hotplug operation. However, it might be beneficial to see the c2c
> profile if perf counters don't indicate anything out of the ordinary.
> 

Would it be possible if any other frequent-written variables share
same cacheline with these per-cpu data causing false sharing? What
about making all these sd_* data DEFINE_PER_CPU_READ_MOSTLY?

