Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9566E4D4144
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiCJGkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiCJGkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:40:16 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C771D8CDA9;
        Wed,  9 Mar 2022 22:39:14 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KDfWd57tkzdb2m;
        Thu, 10 Mar 2022 14:37:49 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 14:39:12 +0800
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
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <477748c7-ae9e-712b-90ad-b04a6767a996@huawei.com>
Date:   Thu, 10 Mar 2022 14:39:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YijJzekA1nFEs3nz@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/3/9 23:37, Ionela Voinescu wrote:
> Hi Yicong,
> 
> On Wednesday 09 Mar 2022 at 18:21:30 (+0800), Yicong Yang wrote:
>> Hi Ionela,
>>
>> On 2022/3/3 2:09, Ionela Voinescu wrote:
>>> Define topology_init_cpu_capacity_cppc() to use highest performance
>>> values from _CPC objects to obtain and set maximum capacity information
>>> for each CPU. acpi_cppc_processor_probe() is a good point at which to
>>> trigger the initialization of CPU (u-arch) capacity values, as at this
>>> point the highest performance values can be obtained from each CPU's
>>> _CPC objects. Architectures can therefore use this functionality
>>> through arch_init_invariance_cppc().
>>>
>>> The performance scale used by CPPC is a unified scale for all CPUs in
>>> the system. Therefore, by obtaining the raw highest performance values
>>> from the _CPC objects, and normalizing them on the [0, 1024] capacity
>>> scale, used by the task scheduler, we obtain the CPU capacity of each
>>> CPU.
>>>
>>
>> So we're going to use highest performance rather than nominal performance,
>> and I checked the discussion in v2 [1]. Maybe we should also document this
>> in sched-capacity.rst that where scheduler get the capacity from on ACPI
>> based system? Currently we only have DT part but after this patch it's
>> also supported on ACPI based system.
>>
> 
> It's a very good point. I'll send a separate patch for this with added
> information in "3.1 CPU capacity" in sched-capacity.rst. I'll send this
> separate and not with the rebase that Rafael requested to avoid
> confusing things.
> 

sure. it's up to you. thanks.

>> Out of curiosity, since we have raw capacity now on ACPI system, seems we
>> are able to scale the capacity with freq_factor now? looked into
>> register_cpufreq_notifier().
>>
> 
> The freq_factor is only used for DT systems where one provides
> "capacity-dmips-mhz" in DT. This entry actually represents DMIPS/MHz.
> 
> So the freq_factor, set to:
> 
> per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
> 
> is used to obtain the performance at the maximum frequency, basically
> DMIPS = (Dhrystone) million instructions per second, by multiplying this
> raw value from DT with the freq_factor. After this, all these value for
> each CPU type are normalized on a scale [0, 1024], resulting in what we
> call CPU capacity.
> 

Thanks for the illustration. I can understand what DT does as it's defined
clearly in [1]. The CPUs in the system may have different capacity-dmips-mhz
as well as frequency so we first obtain the DMIPS/MHz and then scaled it with
the max frequency.

> For ACPI systems freq_factor will have the default value of 1 when we
> call topology_normalize_cpu_scale(), as the performance value obtained
> from _CPC is already representative for the highest frequency of the CPU
> and not performance/Hz as we get from DT. Therefore, we are not and
> should not use a freq_factor here.
> 
> Hopefully I understood your question correctly.
> 

Seems we have different meaning of raw capacity on DT based and ACPI based system.
On DT based system it doesn't consider the max frequency of each CPU so we need
to take the frequency into account later. But on ACPI based system the max perf
has already take the max frequency into account and we don't need to consider
the frequency differences among the CPUs. If so, the comment [2] is no more
correct as we don't need to scale the capcity according to the frequnecy but
not because that we cannot get the raw cpu capacity on ACPI based system.

The CPUs on ACPI based system may also have different DMIPS and maximum frequency,
the same with the DT based system. Is it possible to keep consistence with
what DT does? As defined by the spec[3], the CPPC aims to "maintaining a performance
definition that backs a continuous, abstract, unit-less performance scale" and
"leaves the definition of the exact performance metric to the platform." So is it
possible we can also interpret it as "capacity-dmips-mhz"? Then to scale the cpu
with max frequency provided by cpufreq, for example cppc_cpufreq. I'm not sure I'm
right and understand it correctly, please correct me if I'm wrong.

For this series, the arm64 part works and based on 5.17-rc7 I tested this on qemu
with modified DSDT:

estuary:/$ cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf
10000
10000
10000
10000
5000
5000
5000
5000
estuary:/$ cat /sys/devices/system/cpu/cpu*/cpu_capacity
1024
1024
1024
1024
512
512
512
512

If needed

Tested-by: Yicong Yang <yangyicong@hisilicon.com>

[1] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/arm/cpu-capacity.txt#L43
[2] https://github.com/torvalds/linux/blob/3bf7edc84a9eb4007dd9a0cb8878a7e1d5ec6a3b/drivers/base/arch_topology.c#L390
[3] https://uefi.org/specs/ACPI/6.4/08_Processor_Configuration_and_Control/declaring-processors.html#collaborative-processor-performance-control

Thanks.

> Thanks,
> Ionela.
> 
>> [1] https://lore.kernel.org/lkml/Yh5OAsYVBWWko+CH@arm.com/
>>
>> Thanks,
>> Yicong
> .
> 
