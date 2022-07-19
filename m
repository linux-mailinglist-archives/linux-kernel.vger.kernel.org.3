Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003A3579594
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbiGSIve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiGSIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:51:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64A2460EF;
        Tue, 19 Jul 2022 01:51:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 845131424;
        Tue, 19 Jul 2022 01:51:30 -0700 (PDT)
Received: from [10.32.33.51] (e121896.warwick.arm.com [10.32.33.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9CC3F73D;
        Tue, 19 Jul 2022 01:51:27 -0700 (PDT)
Message-ID: <5fcf1a6f-c8fb-c296-992e-18aae8874095@arm.com>
Date:   Tue, 19 Jul 2022 09:51:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   James Clark <james.clark@arm.com>
Subject: Re: [PATCH v2 1/2] perf: arm64: Add SVE vector granule register to
 user regs
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        acme@kernel.org, german.gomez@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220517100743.3020667-1-james.clark@arm.com>
 <20220517100743.3020667-2-james.clark@arm.com>
 <20220627111319.GG22095@willie-the-truck>
Content-Language: en-US
In-Reply-To: <20220627111319.GG22095@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/2022 12:13, Will Deacon wrote:
> On Tue, May 17, 2022 at 11:07:42AM +0100, James Clark wrote:
>> Dwarf based unwinding in a function that pushes SVE registers onto
>> the stack requires the unwinder to know the length of the SVE register
>> to calculate the stack offsets correctly. This was added to the Arm
>> specific Dwarf spec as the VG pseudo register[1].
>>
>> Add the vector length at position 46 if it's requested by userspace and
>> SVE is supported. If it's not supported then fail to open the event.
>>
>> The vector length must be on each sample because it can be changed
>> at runtime via a prctl or ptrace call. Also by adding it as a register
>> rather than a separate attribute, minimal changes will be required in an
>> unwinder that already indexes into the register list.
>>
>> [1]: https://github.com/ARM-software/abi-aa/blob/main/aadwarf64/aadwarf64.rst
>>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  arch/arm64/include/uapi/asm/perf_regs.h |  7 +++++-
>>  arch/arm64/kernel/perf_regs.c           | 30 +++++++++++++++++++++++--
>>  drivers/perf/arm_pmu.c                  |  2 +-
>>  3 files changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/uapi/asm/perf_regs.h b/arch/arm64/include/uapi/asm/perf_regs.h
>> index d54daafa89e3..fd157f46727e 100644
>> --- a/arch/arm64/include/uapi/asm/perf_regs.h
>> +++ b/arch/arm64/include/uapi/asm/perf_regs.h
>> @@ -36,6 +36,11 @@ enum perf_event_arm_regs {
>>  	PERF_REG_ARM64_LR,
>>  	PERF_REG_ARM64_SP,
>>  	PERF_REG_ARM64_PC,
>> -	PERF_REG_ARM64_MAX,
>> +
>> +	/* Extended/pseudo registers */
>> +	PERF_REG_ARM64_VG = 46, // SVE Vector Granule
>> +
>> +	PERF_REG_ARM64_MAX = PERF_REG_ARM64_PC + 1,
>> +	PERF_REG_ARM64_EXTENDED_MAX = PERF_REG_ARM64_VG + 1

Hi Will,

Apologies for the late reply, I was on a long break.

> 
> I think you can leave PERF_REG_ARM64_MAX alone and just add:
> 
> 	PERF_REG_ARM64_VG = 46,
> 	PERF_REG_ARM64_EXTENDED_MAX,
> 
> no?

Yes that would be the same. I was going for consistency with 
arch/powerpc/include/uapi/asm/perf_regs.h which did it this way,
possibly so that ..._MAX could always be found at the end.

But I'm happy to simplify it. Although this change has already
made it onto Perf's copy of this header for v5.19-rc5. It can
still be changed but I'm not sure if that fact changes your
preference for this?

> 
>>  };
>>  #endif /* _ASM_ARM64_PERF_REGS_H */
>> diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
>> index f6f58e6265df..b4eece3eb17d 100644
>> --- a/arch/arm64/kernel/perf_regs.c
>> +++ b/arch/arm64/kernel/perf_regs.c
>> @@ -9,9 +9,27 @@
>>  #include <asm/perf_regs.h>
>>  #include <asm/ptrace.h>
>>  
>> +static u64 perf_ext_regs_value(int idx)
>> +{
>> +	switch (idx) {
>> +	case PERF_REG_ARM64_VG:
>> +		if (WARN_ON_ONCE(!system_supports_sve()))
>> +			return 0;
>> +
>> +		/*
>> +		 * Vector granule is current length in bits of SVE registers
>> +		 * divided by 64.
>> +		 */
>> +		return (task_get_sve_vl(current) * 8) / 64;
> 
> Is 'current' the right thing to use here? We pass the regs everywhere else,
> so I'd prefer to stick with that if possible.

I did try that to start with but it required either a change to 'struct pt_regs'
which didn't feel right, or adding an additional struct to be passed around in
the core perf code.

Ultimately for userspace samples, 'current' is used anyway:

  	regs_user->regs = task_pt_regs(current);
	regs_user->abi = perf_reg_abi(current);

The reason prepare_sample() and then output_sample() are called separately is
to get the total size of the sample ahead of outputting it, but
this is already taken into account with registers without storing them because
the number of set bits are counted, not the number of saved registers.

I also referenced get_ext_regs_value() in arch/powerpc/perf/perf_regs.c which
doesn't change any function signatures or structs and just grabs whichever
current extra register was needed.

So TLDR: yes it would be possible to save the register somewhere and
pass it around, but it would be the saved version of 'current' anyway,
and it would require much bigger changes.

I can make the change if you like if it's easier to judge by seeing what it
would look like?

> 
>> +	default:
>> +		WARN_ON_ONCE(true);
>> +		return 0;
>> +	}
>> +}
>> +
>>  u64 perf_reg_value(struct pt_regs *regs, int idx)
>>  {
>> -	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM64_MAX))
>> +	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM64_EXTENDED_MAX))
>>  		return 0;
>>  
>>  	/*
>> @@ -51,6 +69,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>  	if ((u32)idx == PERF_REG_ARM64_PC)
>>  		return regs->pc;
>>  
>> +	if ((u32)idx >= PERF_REG_ARM64_MAX)
>> +		return perf_ext_regs_value(idx);
>> +
>>  	return regs->regs[idx];
>>  }
>>  
>> @@ -58,7 +79,12 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>  
>>  int perf_reg_validate(u64 mask)
>>  {
>> -	if (!mask || mask & REG_RESERVED)
>> +	u64 reserved_mask = REG_RESERVED;
>> +
>> +	if (system_supports_sve())
>> +		reserved_mask &= ~(1ULL << PERF_REG_ARM64_VG);
>> +
>> +	if (!mask || mask & reserved_mask)
>>  		return -EINVAL;
>>  
>>  	return 0;
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index 59d3980b8ca2..3f07df5a7e95 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -894,7 +894,7 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
>>  		 * pmu::filter_match callback and pmu::event_init group
>>  		 * validation).
>>  		 */
>> -		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS,
>> +		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS,
> 
> How does userspace know this capability is available? 

It doesn't, this change is only needed kernel side because if a register
matching PERF_REG_EXTENDED_MASK is requested, the PMU has to have this
capability otherwise the perf_event_open is rejected.

> Should we advertise
> the set of extended registers that we support, rather than make this a
> one-trick pony for the vector length?

Maybe, this is another copy of what was done for extended registers on
Power and x86 where the event is attempted to be opened and if it works it's
assumed that it's supported:

	/*
	 * check if the pmu supports perf extended regs, before
	 * returning the register mask to sample.
	 */
	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
	if (fd != -1) {
		close(fd);
		mask |= extended_mask;
	}

I did something similar in user space for this change:

  https://www.spinics.net/lists/linux-perf-users/msg19569.html

Actually I also check HWCAP_SVE, which is not strictly necessary. I suppose
we could report the bitmask of which extended registers are supported. But
for me just trying to open the event works just as well.

> 
> Also, you don't appear to #define PERF_REG_EXTENDED_MASK so I don't
> understand how userspace is supposed to interact with this. Won't
> has_extended_regs() always return false?

Oops, nice catch. Yes I think I accidentally dropped this part but didn't
notice because it still works without it. If I add this, then the event doesn't
open unless PERF_PMU_CAP_EXTENDED_REGS is added, which is what I wanted:

  #define PERF_REG_EXTENDED_MASK (~((1ULL << PERF_REG_ARM64_VG) - 1))

So the only reason to use PERF_PMU_CAP_EXTENDED_REGS is for consistency and to
avoid changing PERF_REG_ARM64_MAX which could potentially break userspace
programs depending on it.

James

> 
> Will
