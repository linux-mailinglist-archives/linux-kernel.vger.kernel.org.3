Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE4F4D5DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiCKIn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiCKInY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:43:24 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888D11BA17E;
        Fri, 11 Mar 2022 00:42:21 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KFKCC5bTQzfYkj;
        Fri, 11 Mar 2022 16:40:55 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 16:42:19 +0800
CC:     <yangyicong@hisilicon.com>, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/3] arch_topology: obtain cpu capacity using
 information from CPPC
To:     Ionela Voinescu <ionela.voinescu@arm.com>
References: <20220302180913.13229-1-ionela.voinescu@arm.com>
 <20220302180913.13229-3-ionela.voinescu@arm.com>
 <4283eacf-6eab-b2f5-07f2-d19fad134277@huawei.com> <YijJzekA1nFEs3nz@arm.com>
 <477748c7-ae9e-712b-90ad-b04a6767a996@huawei.com> <YioUdqMmma49nIJq@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <1a18588b-c1a1-246f-01ae-dd431c7812d8@huawei.com>
Date:   Fri, 11 Mar 2022 16:42:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YioUdqMmma49nIJq@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/10 23:08, Ionela Voinescu wrote:
> On Thursday 10 Mar 2022 at 14:39:12 (+0800), Yicong Yang wrote:
>> On 2022/3/9 23:37, Ionela Voinescu wrote:
>>> Hi Yicong,
>>>
>>> On Wednesday 09 Mar 2022 at 18:21:30 (+0800), Yicong Yang wrote:
>>>> Hi Ionela,
> [..]
>>>> Out of curiosity, since we have raw capacity now on ACPI system, seems we
>>>> are able to scale the capacity with freq_factor now? looked into
>>>> register_cpufreq_notifier().
>>>>
>>>
>>> The freq_factor is only used for DT systems where one provides
>>> "capacity-dmips-mhz" in DT. This entry actually represents DMIPS/MHz.
>>>
>>> So the freq_factor, set to:
>>>
>>> per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
>>>
>>> is used to obtain the performance at the maximum frequency, basically
>>> DMIPS = (Dhrystone) million instructions per second, by multiplying this
>>> raw value from DT with the freq_factor. After this, all these value for
>>> each CPU type are normalized on a scale [0, 1024], resulting in what we
>>> call CPU capacity.
>>>
>>
>> Thanks for the illustration. I can understand what DT does as it's defined
>> clearly in [1]. The CPUs in the system may have different capacity-dmips-mhz
>> as well as frequency so we first obtain the DMIPS/MHz and then scaled it with
>> the max frequency.
>>
>>> For ACPI systems freq_factor will have the default value of 1 when we
>>> call topology_normalize_cpu_scale(), as the performance value obtained
>>> from _CPC is already representative for the highest frequency of the CPU
>>> and not performance/Hz as we get from DT. Therefore, we are not and
>>> should not use a freq_factor here.
>>>
>>> Hopefully I understood your question correctly.
>>>
>>
>> Seems we have different meaning of raw capacity on DT based and ACPI based system.
>> On DT based system it doesn't consider the max frequency of each CPU so we need
>> to take the frequency into account later. But on ACPI based system the max perf
>> has already take the max frequency into account and we don't need to consider
>> the frequency differences among the CPUs. If so, the comment [2] is no more
>> correct as we don't need to scale the capcity according to the frequnecy but
>> not because that we cannot get the raw cpu capacity on ACPI based system.
>>
> 
> Correct! I've fixed that comment in v4 [1].
> 
>> The CPUs on ACPI based system may also have different DMIPS and maximum frequency,
>> the same with the DT based system. Is it possible to keep consistence with
>> what DT does? As defined by the spec[3], the CPPC aims to "maintaining a performance
>> definition that backs a continuous, abstract, unit-less performance scale" and
>> "leaves the definition of the exact performance metric to the platform." So is it
>> possible we can also interpret it as "capacity-dmips-mhz"?
> 
> I don't believe so because of:
> 
> "Platforms must use the same performance scale for all processors in the
> system. On platforms with heterogeneous processors, the performance
> characteristics of all processors may not be identical. In this case, the
> platform must synthesize a performance scale that adjusts for differences
> in processors, such that any two processors running the same workload at
> the same performance level will complete in approximately the same time."
> 
> So IMO, given this description, it's not appropriate to provide/use
> capacity-dmips-mhz "performance levels" in _CPC. To have a very simple
> example, let's assume we have a system with two CPUs of the same u-arch
> but one of them is clocked at 1GHz while the other is clocked at 2GHz
> (fixed frequency for both). If we are to run a theoretical benchmark on
> both we would get 50% on the first and 100% on the second (considering we
> normalize the performance scores on a scale [0, 100%]). So we could have
> 50 and 100 as highest performance levels in _CPC, if one uses a system
> wide performance scale as described in the specification.
> 
> But if we convert those values to DMIPS/MHz we would get the same value
> for both CPUs. But if we provide this same value as highest performance
> level in _CPC for both we break the rule of "running the same workload
> at the same performance level will complete in approximately the same
> time."
> 

Thanks for the clarification. That sounds reasonable to me. :)

>> Then to scale the cpu with max frequency provided by cpufreq, for example
>> cppc_cpufreq. I'm not sure I'm right and understand it correctly, please
>> correct me if I'm wrong.
> 
> All frequency information on ACPI system is optional so even if one
> would ever want to do something like the above, one might not know what> is the maximum frequency of a CPU. I believe the tendency in recent

I doubt that. Even the frequency in the _CPC is optional, the kernel may
get the maximum frequency in other ways. On my platform it's gotten from
DMI, see cppc_cpufreq_perf_to_khz(). But I'm not sure for other cpufreq
drivers.

Thanks,
Yicong
