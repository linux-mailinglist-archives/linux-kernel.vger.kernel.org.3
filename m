Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30754D4D46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344202AbiCJPO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345000AbiCJPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:12:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7030102406;
        Thu, 10 Mar 2022 07:08:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 681011692;
        Thu, 10 Mar 2022 07:08:40 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E7833F7D7;
        Thu, 10 Mar 2022 07:08:39 -0800 (PST)
Date:   Thu, 10 Mar 2022 15:08:38 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     yangyicong@hisilicon.com, Sudeep Holla <sudeep.holla@arm.com>,
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
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] arch_topology: obtain cpu capacity using
 information from CPPC
Message-ID: <YioUdqMmma49nIJq@arm.com>
References: <20220302180913.13229-1-ionela.voinescu@arm.com>
 <20220302180913.13229-3-ionela.voinescu@arm.com>
 <4283eacf-6eab-b2f5-07f2-d19fad134277@huawei.com>
 <YijJzekA1nFEs3nz@arm.com>
 <477748c7-ae9e-712b-90ad-b04a6767a996@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477748c7-ae9e-712b-90ad-b04a6767a996@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 Mar 2022 at 14:39:12 (+0800), Yicong Yang wrote:
> On 2022/3/9 23:37, Ionela Voinescu wrote:
> > Hi Yicong,
> > 
> > On Wednesday 09 Mar 2022 at 18:21:30 (+0800), Yicong Yang wrote:
> >> Hi Ionela,
[..]
> >> Out of curiosity, since we have raw capacity now on ACPI system, seems we
> >> are able to scale the capacity with freq_factor now? looked into
> >> register_cpufreq_notifier().
> >>
> > 
> > The freq_factor is only used for DT systems where one provides
> > "capacity-dmips-mhz" in DT. This entry actually represents DMIPS/MHz.
> > 
> > So the freq_factor, set to:
> > 
> > per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
> > 
> > is used to obtain the performance at the maximum frequency, basically
> > DMIPS = (Dhrystone) million instructions per second, by multiplying this
> > raw value from DT with the freq_factor. After this, all these value for
> > each CPU type are normalized on a scale [0, 1024], resulting in what we
> > call CPU capacity.
> > 
> 
> Thanks for the illustration. I can understand what DT does as it's defined
> clearly in [1]. The CPUs in the system may have different capacity-dmips-mhz
> as well as frequency so we first obtain the DMIPS/MHz and then scaled it with
> the max frequency.
> 
> > For ACPI systems freq_factor will have the default value of 1 when we
> > call topology_normalize_cpu_scale(), as the performance value obtained
> > from _CPC is already representative for the highest frequency of the CPU
> > and not performance/Hz as we get from DT. Therefore, we are not and
> > should not use a freq_factor here.
> > 
> > Hopefully I understood your question correctly.
> > 
> 
> Seems we have different meaning of raw capacity on DT based and ACPI based system.
> On DT based system it doesn't consider the max frequency of each CPU so we need
> to take the frequency into account later. But on ACPI based system the max perf
> has already take the max frequency into account and we don't need to consider
> the frequency differences among the CPUs. If so, the comment [2] is no more
> correct as we don't need to scale the capcity according to the frequnecy but
> not because that we cannot get the raw cpu capacity on ACPI based system.
> 

Correct! I've fixed that comment in v4 [1].

> The CPUs on ACPI based system may also have different DMIPS and maximum frequency,
> the same with the DT based system. Is it possible to keep consistence with
> what DT does? As defined by the spec[3], the CPPC aims to "maintaining a performance
> definition that backs a continuous, abstract, unit-less performance scale" and
> "leaves the definition of the exact performance metric to the platform." So is it
> possible we can also interpret it as "capacity-dmips-mhz"?

I don't believe so because of:

"Platforms must use the same performance scale for all processors in the
system. On platforms with heterogeneous processors, the performance
characteristics of all processors may not be identical. In this case, the
platform must synthesize a performance scale that adjusts for differences
in processors, such that any two processors running the same workload at
the same performance level will complete in approximately the same time."

So IMO, given this description, it's not appropriate to provide/use
capacity-dmips-mhz "performance levels" in _CPC. To have a very simple
example, let's assume we have a system with two CPUs of the same u-arch
but one of them is clocked at 1GHz while the other is clocked at 2GHz
(fixed frequency for both). If we are to run a theoretical benchmark on
both we would get 50% on the first and 100% on the second (considering we
normalize the performance scores on a scale [0, 100%]). So we could have
50 and 100 as highest performance levels in _CPC, if one uses a system
wide performance scale as described in the specification.

But if we convert those values to DMIPS/MHz we would get the same value
for both CPUs. But if we provide this same value as highest performance
level in _CPC for both we break the rule of "running the same workload
at the same performance level will complete in approximately the same
time."

> Then to scale the cpu with max frequency provided by cpufreq, for example
> cppc_cpufreq. I'm not sure I'm right and understand it correctly, please
> correct me if I'm wrong.

All frequency information on ACPI system is optional so even if one
would ever want to do something like the above, one might not know what
is the maximum frequency of a CPU. I believe the tendency in recent
systems (even DT based) is the opposite - to hide frequency information
(usually only known to firmware) and only work with abstract performance
scales. So likely in the future is the DT path that might change.

> For this series, the arm64 part works and based on 5.17-rc7 I tested this on qemu
> with modified DSDT:
> 
> estuary:/$ cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf
> 10000
> 10000
> 10000
> 10000
> 5000
> 5000
> 5000
> 5000
> estuary:/$ cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 1024
> 1024
> 1024
> 1024
> 512
> 512
> 512
> 512
> 
> If needed
> 
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> 

[1] https://lore.kernel.org/lkml/20220310145451.15596-1-ionela.voinescu@arm.com/T/#u

Many thanks,
Ionela.

> [1] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/arm/cpu-capacity.txt#L43
> [2] https://github.com/torvalds/linux/blob/3bf7edc84a9eb4007dd9a0cb8878a7e1d5ec6a3b/drivers/base/arch_topology.c#L390
> [3] https://uefi.org/specs/ACPI/6.4/08_Processor_Configuration_and_Control/declaring-processors.html#collaborative-processor-performance-control
> 
> Thanks.
> 
> > Thanks,
> > Ionela.
> > 
> >> [1] https://lore.kernel.org/lkml/Yh5OAsYVBWWko+CH@arm.com/
> >>
> >> Thanks,
> >> Yicong
> > .
> > 
