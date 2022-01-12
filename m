Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDE548C2D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352748AbiALLGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:06:09 -0500
Received: from foss.arm.com ([217.140.110.172]:58528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352740AbiALLGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:06:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D96351FB;
        Wed, 12 Jan 2022 03:06:06 -0800 (PST)
Received: from [10.163.66.26] (unknown [10.163.66.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F3413F774;
        Wed, 12 Jan 2022 03:06:04 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: errata: Update ARM64_ERRATUM_[2119858|2224489]
 with Cortex-X2 ranges
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <1641980099-20315-1-git-send-email-anshuman.khandual@arm.com>
 <1641980099-20315-3-git-send-email-anshuman.khandual@arm.com>
 <Yd6uTCwjzDdBrtGI@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <73b5cc05-4318-8eb8-bc3a-84af1ad6145c@arm.com>
Date:   Wed, 12 Jan 2022 16:36:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yd6uTCwjzDdBrtGI@FVFF77S0Q05N>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/22 4:02 PM, Mark Rutland wrote:
> Hi Anshuman,
> 
> On Wed, Jan 12, 2022 at 03:04:59PM +0530, Anshuman Khandual wrote:
>> Errata ARM64_ERRATUM_[2119858|2224489] also affect some Cortex-X2 ranges as
>> well. Lets update these errata definition and detection to accommodate all
>> new Cortex-X2 based cpu MIDR ranges.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/Kconfig             | 12 ++++++------
>>  arch/arm64/kernel/cpu_errata.c |  2 ++
>>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> I think you've misssed Documentation/arm64/silicon-errata.rst -- for other
> common errata we add lines for each affected part, e.g. as we do for
> ARM64_ERRATUM_1418040.

Sure, will do. I guess Cortex-X2 lines will come just after Cortex-A710
but before Neoverse-N1.

+----------------+-----------------+-----------------+-----------------------------+
| ARM            | Cortex-A710     | #2224489        | ARM64_ERRATUM_2224489       |
+----------------+-----------------+-----------------+-----------------------------+
>
>
+----------------+-----------------+-----------------+-----------------------------+
| ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
+----------------+-----------------+-----------------+-----------------------------+


> 
> Other than that, this looks good to me!
> 
> Thanks,
> Mark.
> 
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index c4207cf9bb17..d8046c832225 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -671,14 +671,14 @@ config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>>  	bool
>>  
>>  config ARM64_ERRATUM_2119858
>> -	bool "Cortex-A710: 2119858: workaround TRBE overwriting trace data in FILL mode"
>> +	bool "Cortex-A710/X2: 2119858: workaround TRBE overwriting trace data in FILL mode"
>>  	default y
>>  	depends on CORESIGHT_TRBE
>>  	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>>  	help
>> -	  This option adds the workaround for ARM Cortex-A710 erratum 2119858.
>> +	  This option adds the workaround for ARM Cortex-A710/X2 erratum 2119858.
>>  
>> -	  Affected Cortex-A710 cores could overwrite up to 3 cache lines of trace
>> +	  Affected Cortex-A710/X2 cores could overwrite up to 3 cache lines of trace
>>  	  data at the base of the buffer (pointed to by TRBASER_EL1) in FILL mode in
>>  	  the event of a WRAP event.
>>  
>> @@ -761,14 +761,14 @@ config ARM64_ERRATUM_2253138
>>  	  If unsure, say Y.
>>  
>>  config ARM64_ERRATUM_2224489
>> -	bool "Cortex-A710: 2224489: workaround TRBE writing to address out-of-range"
>> +	bool "Cortex-A710/X2: 2224489: workaround TRBE writing to address out-of-range"
>>  	depends on CORESIGHT_TRBE
>>  	default y
>>  	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
>>  	help
>> -	  This option adds the workaround for ARM Cortex-A710 erratum 2224489.
>> +	  This option adds the workaround for ARM Cortex-A710/X2 erratum 2224489.
>>  
>> -	  Affected Cortex-A710 cores might write to an out-of-range address, not reserved
>> +	  Affected Cortex-A710/X2 cores might write to an out-of-range address, not reserved
>>  	  for TRBE. Under some conditions, the TRBE might generate a write to the next
>>  	  virtually addressed page following the last page of the TRBE address space
>>  	  (i.e., the TRBLIMITR_EL1.LIMIT), instead of wrapping around to the base.
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index 9e1c1aef9ebd..29cc062a4153 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -347,6 +347,7 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
>>  #endif
>>  #ifdef CONFIG_ARM64_ERRATUM_2119858
>>  	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
>> +	MIDR_RANGE(MIDR_CORTEX_X2, 0, 0, 2, 0),
>>  #endif
>>  	{},
>>  };
>> @@ -371,6 +372,7 @@ static struct midr_range trbe_write_out_of_range_cpus[] = {
>>  #endif
>>  #ifdef CONFIG_ARM64_ERRATUM_2224489
>>  	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
>> +	MIDR_RANGE(MIDR_CORTEX_X2, 0, 0, 2, 0),
>>  #endif
>>  	{},
>>  };
>> -- 
>> 2.20.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
