Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E28C522EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbiEKIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243909AbiEKIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:45:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DFE6201330;
        Wed, 11 May 2022 01:45:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 499EF106F;
        Wed, 11 May 2022 01:45:01 -0700 (PDT)
Received: from [10.57.1.137] (unknown [10.57.1.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185D63F73D;
        Wed, 11 May 2022 01:44:58 -0700 (PDT)
Message-ID: <6fcc2358-b029-fa01-cf06-aa040f53cf83@arm.com>
Date:   Wed, 11 May 2022 09:44:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 0/2] perf: ARM CoreSight PMU support
To:     Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Besar Wicaksono <bwicaksono@nvidia.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220509092843.GB26264@willie-the-truck>
 <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
 <20220510110742.ievkihggndpms3fn@bogus>
 <20220510111318.GD27557@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220510111318.GD27557@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 12:13, Will Deacon wrote:
> On Tue, May 10, 2022 at 12:07:42PM +0100, Sudeep Holla wrote:
>> On Mon, May 09, 2022 at 11:02:23AM +0100, Suzuki K Poulose wrote:
>>> Cc: Mike Williams, Mathieu Poirier
>>> On 09/05/2022 10:28, Will Deacon wrote:
>>>> On Sun, May 08, 2022 at 07:28:08PM -0500, Besar Wicaksono wrote:
>>>>>    arch/arm64/configs/defconfig                  |    1 +
>>>>>    drivers/perf/Kconfig                          |    2 +
>>>>>    drivers/perf/Makefile                         |    1 +
>>>>>    drivers/perf/coresight_pmu/Kconfig            |   10 +
>>>>>    drivers/perf/coresight_pmu/Makefile           |    7 +
>>>>>    .../perf/coresight_pmu/arm_coresight_pmu.c    | 1317 +++++++++++++++++
>>>>>    .../perf/coresight_pmu/arm_coresight_pmu.h    |  147 ++
>>>>>    .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  300 ++++
>>>>>    .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
>>>>>    9 files changed, 1802 insertions(+)
>>>>
>>>> How does this interact with all the stuff we have under
>>>> drivers/hwtracing/coresight/?
>>>
>>> Absolutely zero, except for the name. The standard
>>> is named "CoreSight PMU" which is a bit unfortunate,
>>> given the only link, AFAIU, with the "CoreSight" architecture
>>> is the Lock Access Register(LAR). For reference, the
>>> drivers/hwtracing/coresight/ is purely "CoreSight" self-hosted
>>> tracing and the PMU is called "cs_etm" (expands to coresight etm).
>>> Otherwise the standard doesn't have anything to do with what
>>> exists already in the kernel.
> 
> That's... a poor naming choice! But good, if it's entirely separate then I
> don't have to worry about that. Just wanted to make sure we're not going to
> get tangled up in things like ROM tables and Coresight power domains for
> these things.
> 
>>> One potential recommendation for the name is, "Arm PMU"  (The ACPI table is
>>> named Arm PMU Table). But then that could be clashing with the armv8_pmu
>>> :-(.
>>>
>>> Some of the other options are :
>>>
>>> "Arm Generic PMU"
>>> "Arm Uncore PMU"
>>
>> I wasn't sure on this if there is any restriction on usage of this on Arm
>> and hence didn't make the suggestion. But if allowed, this would be my
>> choice too.
> 
> We'd taken to calling them "System" PMUS in the past, so maybe just stick
> with that? I think "Uncore" is Intel terminology so it's probably best to

I thought about that, but there are some IPs named "System Profilers" 
(e.g., on Juno board) which could be easily confused. But I hope their
population in the name space is much less. So, I am happy with that
choice. The only other concern is, it doesn't indicate it supports PMUs
that are compliant to a given Arm Standard. i.e., people could think of 
this as a "single type" of PMU.
So, I am wondering if something like "Arm Standard PMU" makes any sense ?

Also, I hope the drivers would choose a name indicating the "type"  -
<vendor>_<type>_pmu (e.g., nvidia_pcie_pmu, arm_smmuv3_pmu etc) while 
registering their PMU. That way it is clearer for the PMU while the
base device could be arm_system_pmu_0 etc.

Suzuki


> avoid it for non-Intel parts.
> 
> Will

