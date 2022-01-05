Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27FF485173
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiAEKvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:51:53 -0500
Received: from foss.arm.com ([217.140.110.172]:43294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234716AbiAEKvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:51:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F8FE1042;
        Wed,  5 Jan 2022 02:51:52 -0800 (PST)
Received: from [10.163.72.138] (unknown [10.163.72.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3E4B3F5A1;
        Wed,  5 Jan 2022 02:51:49 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 2/4] coresight: trbe: Work around the ignored system
 register writes
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1641359159-22726-1-git-send-email-anshuman.khandual@arm.com>
 <1641359159-22726-3-git-send-email-anshuman.khandual@arm.com>
 <0020da84-ce90-f269-27e1-6a6c90f6317b@arm.com>
Message-ID: <464d0ab9-1d72-a0da-73e9-4eeccfc784c6@arm.com>
Date:   Wed, 5 Jan 2022 16:21:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0020da84-ce90-f269-27e1-6a6c90f6317b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/22 3:31 PM, Suzuki K Poulose wrote:
> Hi Anshuman
> 
> On 05/01/2022 05:05, Anshuman Khandual wrote:
>> TRBE implementations affected by Arm erratum #2064142 might fail to write
>> into certain system registers after the TRBE has been disabled. Under some
>> conditions after TRBE has been disabled, writes into certain TRBE registers
>> TRBLIMITR_EL1, TRBPTR_EL1, TRBBASER_EL1, TRBSR_EL1 and TRBTRG_EL1 will be
>> ignored and not be effected.
>>
>> Work around this problem in the TRBE driver by executing TSB CSYNC and DSB
>> just after the trace collection has stopped and before performing a system
>> register write to one of the affected registers. This adds a new cpu errata
>> in arm64 errata framework and also updates TRBE driver as required.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   Documentation/arm64/silicon-errata.rst       |  2 +
>>   arch/arm64/Kconfig                           | 18 +++++++
>>   arch/arm64/kernel/cpu_errata.c               |  9 ++++
>>   arch/arm64/tools/cpucaps                     |  1 +
>>   drivers/hwtracing/coresight/coresight-trbe.c | 54 ++++++++++++++------
>>   drivers/hwtracing/coresight/coresight-trbe.h |  8 ---
>>   6 files changed, 68 insertions(+), 24 deletions(-)
> 
> I think it may be a good idea to split the patch into
> two parts :
> 
> - arm64 kernel part. (cpucap defintions and detection)
> - trbe driver part
> 
> So that it is easier to merge these series upstream to
> avoid conflicts.

Sure, will do.

> 
>>
>> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
>> index 5342e895fb60..c9b30e6c2b6c 100644
>> --- a/Documentation/arm64/silicon-errata.rst
>> +++ b/Documentation/arm64/silicon-errata.rst
>> @@ -52,6 +52,8 @@ stable kernels.
>>   | Allwinner      | A64/R18         | UNKNOWN1        | SUN50I_ERRATUM_UNKNOWN1     |
>>   +----------------+-----------------+-----------------+-----------------------------+
>>   +----------------+-----------------+-----------------+-----------------------------+
>> +| ARM            | Cortex-A510     | #2064142        | ARM64_ERRATUM_2064142       |
>> ++----------------+-----------------+-----------------+-----------------------------+
>>   | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
>>   +----------------+-----------------+-----------------+-----------------------------+
>>   | ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index c4207cf9bb17..2105b68d88db 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -778,6 +778,24 @@ config ARM64_ERRATUM_2224489
>>           If unsure, say Y.
>>   +config ARM64_ERRATUM_2064142
>> +    bool "Cortex-A510: 2064142: workaround TRBE register writes while disabled"
>> +    depends on CORESIGHT_TRBE
>> +    default y
>> +    help
>> +      This option adds the workaround for ARM Cortex-A510 erratum 2064142.
>> +
>> +      Affected Cortex-A510 core might fail to write into system registers after the
>> +      TRBE has been disabled. Under some conditions after the TRBE has been disabled
>> +      writes into TRBE registers TRBLIMITR_EL1, TRBPTR_EL1, TRBBASER_EL1, TRBSR_EL1,
>> +      and TRBTRG_EL1 will be ignored and will not be effected.
>> +
>> +      Work around this in the driver by executing TSB CSYNC and DSB after collection
>> +      is stopped and before performing a system register write to one of the affected
>> +      registers.
>> +
>> +      If unsure, say Y.
>> +
>>   config CAVIUM_ERRATUM_22375
>>       bool "Cavium erratum 22375, 24313"
>>       default y
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index 9e1c1aef9ebd..cbb7d5a9aee7 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -597,6 +597,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>>           .type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
>>           CAP_MIDR_RANGE_LIST(trbe_write_out_of_range_cpus),
>>       },
>> +#endif
>> +#ifdef CONFIG_ARM64_ERRATUM_2064142
>> +    {
>> +        .desc = "ARM erratum 2064142",
>> +        .capability = ARM64_WORKAROUND_2064142,
>> +
>> +        /* Cortex-A510 r0p0 - r0p2 */
>> +        ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
>> +    },
>>   #endif
>>       {
>>       }
>> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
>> index 870c39537dd0..fca3cb329e1d 100644
>> --- a/arch/arm64/tools/cpucaps
>> +++ b/arch/arm64/tools/cpucaps
>> @@ -55,6 +55,7 @@ WORKAROUND_1418040
>>   WORKAROUND_1463225
>>   WORKAROUND_1508412
>>   WORKAROUND_1542419
>> +WORKAROUND_2064142
>>   WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>>   WORKAROUND_TSB_FLUSH_FAILURE
>>   WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 276862c07e32..ec24b62b2cec 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -91,10 +91,12 @@ struct trbe_buf {
>>    */
>>   #define TRBE_WORKAROUND_OVERWRITE_FILL_MODE    0
>>   #define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE    1
>> +#define TRBE_WORKAROUND_SYSREG_WRITE_FAILURE    2
>>     static int trbe_errata_cpucaps[] = {
>>       [TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
>>       [TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
>> +    [TRBE_WORKAROUND_SYSREG_WRITE_FAILURE] = ARM64_WORKAROUND_2064142,
> 
> super minor nit: TRBE_NEEDS_DRAIN_AFTER_DISABLE
>>>       -1,        /* Sentinel, must be the last entry */
>>   };
>>   @@ -167,6 +169,11 @@ static inline bool trbe_may_write_out_of_range(struct trbe_cpudata *cpudata)
>>       return trbe_has_erratum(cpudata, TRBE_WORKAROUND_WRITE_OUT_OF_RANGE);
>>   }
>>   +static inline bool trbe_may_fail_sysreg_write(struct trbe_cpudata *cpudata)
>> +{
> 
> minor nit: trbe_needs_drain_after_disable() ?

Changing this helper name and its index above would reflect actual
workaround implemented, instead of the errata which it is trying
to solve. Although the series has already broken that convention
in the last patch with trbe_is_broken() and TRBE_IS_BROKEN. If we
are going with TRBE_<work around required> format, I will have to
change the next workaround patch as well.

> 
> Either ways, the patch looks good to me.> 
> Suzuki
