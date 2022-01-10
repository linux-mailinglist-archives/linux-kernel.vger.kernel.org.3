Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA7648982E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245153AbiAJMAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:00:15 -0500
Received: from foss.arm.com ([217.140.110.172]:33488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245174AbiAJL7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:59:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8CA42B;
        Mon, 10 Jan 2022 03:59:41 -0800 (PST)
Received: from [10.163.72.167] (unknown [10.163.72.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21C463F5A1;
        Mon, 10 Jan 2022 03:59:38 -0800 (PST)
Subject: Re: [PATCH V2 5/7] coresight: trbe: Work around the ignored system
 register writes
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1641517808-5735-1-git-send-email-anshuman.khandual@arm.com>
 <1641517808-5735-6-git-send-email-anshuman.khandual@arm.com>
 <0ce7622a-0c61-ea80-6c53-0388a8b620fe@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3d549672-5e03-9f36-1331-49ff4dcb3edd@arm.com>
Date:   Mon, 10 Jan 2022 17:29:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0ce7622a-0c61-ea80-6c53-0388a8b620fe@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/22 4:33 PM, Suzuki K Poulose wrote:
> On 07/01/2022 01:10, Anshuman Khandual wrote:
>> TRBE implementations affected by Arm erratum #2064142 might fail to write
>> into certain system registers after the TRBE has been disabled. Under some
>> conditions after TRBE has been disabled, writes into certain TRBE registers
>> TRBLIMITR_EL1, TRBPTR_EL1, TRBBASER_EL1, TRBSR_EL1 and TRBTRG_EL1 will be
>> ignored and not be effected.
>>
>> Work around this problem in the TRBE driver by executing TSB CSYNC and DSB
>> just after the trace collection has stopped and before performing a system
>> register write to one of the affected registers. This just updates the TRBE
>> driver as required.
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
>>   arch/arm64/Kconfig                           |  2 +-
>>   drivers/hwtracing/coresight/coresight-trbe.c | 54 ++++++++++++++------
>>   drivers/hwtracing/coresight/coresight-trbe.h |  8 ---
>>   3 files changed, 39 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index f1651cb71ef3..b6d62672bf7d 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -780,7 +780,7 @@ config ARM64_ERRATUM_2224489
>>     config ARM64_ERRATUM_2064142
>>       bool "Cortex-A510: 2064142: workaround TRBE register writes while disabled"
>> -    depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
>> +    depends on CORESIGHT_TRBE
>>       default y
>>       help
>>         This option adds the workaround for ARM Cortex-A510 erratum 2064142.
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 276862c07e32..850e9fca6847 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -91,10 +91,12 @@ struct trbe_buf {
>>    */
>>   #define TRBE_WORKAROUND_OVERWRITE_FILL_MODE    0
>>   #define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE    1
>> +#define TRBE_NEEDS_DRAIN_AFTER_DISABLE        2
>>     static int trbe_errata_cpucaps[] = {
>>       [TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
>>       [TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
>> +    [TRBE_NEEDS_DRAIN_AFTER_DISABLE] = ARM64_WORKAROUND_2064142,
>>       -1,        /* Sentinel, must be the last entry */
>>   };
>>   @@ -167,6 +169,11 @@ static inline bool trbe_may_write_out_of_range(struct trbe_cpudata *cpudata)
>>       return trbe_has_erratum(cpudata, TRBE_WORKAROUND_WRITE_OUT_OF_RANGE);
>>   }
>>   +static inline bool trbe_needs_drain_after_disable(struct trbe_cpudata *cpudata)
>> +{
>> +    return trbe_has_erratum(cpudata, TRBE_NEEDS_DRAIN_AFTER_DISABLE);
>> +}
>> +
>>   static int trbe_alloc_node(struct perf_event *event)
>>   {
>>       if (event->cpu == -1)
>> @@ -174,30 +181,42 @@ static int trbe_alloc_node(struct perf_event *event)
>>       return cpu_to_node(event->cpu);
>>   }
>>   -static void trbe_drain_buffer(void)
>> +static inline void trbe_drain_buffer(void)
>>   {
>>       tsb_csync();
>>       dsb(nsh);
>>   }
>>   -static void trbe_drain_and_disable_local(void)
>> +static inline void set_trbe_disabled(struct trbe_cpudata *cpudata)
>>   {
>>       u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>>   -    trbe_drain_buffer();
>> -
>>       /*
>>        * Disable the TRBE without clearing LIMITPTR which
>>        * might be required for fetching the buffer limits.
>>        */
>>       trblimitr &= ~TRBLIMITR_ENABLE;
>>       write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>> +
>> +    /*
>> +     * Errata affected TRBE implementation will need TSB CSYNC and
>> +     * DSB in order to prevent subsequent writes into certain TRBE
>> +     * system registers from being ignored and not effected.
>> +     */
> 
> minor nit: This comment could be moved to the definition of the
> function "trbe_needs_drain_after_disable()" to make more sense.
> The name is implicit here indicating, why we are doing a drain.

Sure, will move the comment just before the function definition.

> 
> Either ways:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
