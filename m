Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8424D31E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiCIPi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCIPix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:38:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19D272191;
        Wed,  9 Mar 2022 07:37:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C04111688;
        Wed,  9 Mar 2022 07:37:51 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 644153F7F5;
        Wed,  9 Mar 2022 07:37:51 -0800 (PST)
Date:   Wed, 9 Mar 2022 15:37:49 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>, yangyicong@hisilicon.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] arch_topology: obtain cpu capacity using
 information from CPPC
Message-ID: <YijJzekA1nFEs3nz@arm.com>
References: <20220302180913.13229-1-ionela.voinescu@arm.com>
 <20220302180913.13229-3-ionela.voinescu@arm.com>
 <4283eacf-6eab-b2f5-07f2-d19fad134277@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4283eacf-6eab-b2f5-07f2-d19fad134277@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,

On Wednesday 09 Mar 2022 at 18:21:30 (+0800), Yicong Yang wrote:
> Hi Ionela,
> 
> On 2022/3/3 2:09, Ionela Voinescu wrote:
> > Define topology_init_cpu_capacity_cppc() to use highest performance
> > values from _CPC objects to obtain and set maximum capacity information
> > for each CPU. acpi_cppc_processor_probe() is a good point at which to
> > trigger the initialization of CPU (u-arch) capacity values, as at this
> > point the highest performance values can be obtained from each CPU's
> > _CPC objects. Architectures can therefore use this functionality
> > through arch_init_invariance_cppc().
> > 
> > The performance scale used by CPPC is a unified scale for all CPUs in
> > the system. Therefore, by obtaining the raw highest performance values
> > from the _CPC objects, and normalizing them on the [0, 1024] capacity
> > scale, used by the task scheduler, we obtain the CPU capacity of each
> > CPU.
> > 
> 
> So we're going to use highest performance rather than nominal performance,
> and I checked the discussion in v2 [1]. Maybe we should also document this
> in sched-capacity.rst that where scheduler get the capacity from on ACPI
> based system? Currently we only have DT part but after this patch it's
> also supported on ACPI based system.
> 

It's a very good point. I'll send a separate patch for this with added
information in "3.1 CPU capacity" in sched-capacity.rst. I'll send this
separate and not with the rebase that Rafael requested to avoid
confusing things.

> Out of curiosity, since we have raw capacity now on ACPI system, seems we
> are able to scale the capacity with freq_factor now? looked into
> register_cpufreq_notifier().
> 

The freq_factor is only used for DT systems where one provides
"capacity-dmips-mhz" in DT. This entry actually represents DMIPS/MHz.

So the freq_factor, set to:

per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;

is used to obtain the performance at the maximum frequency, basically
DMIPS = (Dhrystone) million instructions per second, by multiplying this
raw value from DT with the freq_factor. After this, all these value for
each CPU type are normalized on a scale [0, 1024], resulting in what we
call CPU capacity.

For ACPI systems freq_factor will have the default value of 1 when we
call topology_normalize_cpu_scale(), as the performance value obtained
from _CPC is already representative for the highest frequency of the CPU
and not performance/Hz as we get from DT. Therefore, we are not and
should not use a freq_factor here.

Hopefully I understood your question correctly.

Thanks,
Ionela.

> [1] https://lore.kernel.org/lkml/Yh5OAsYVBWWko+CH@arm.com/
> 
> Thanks,
> Yicong
