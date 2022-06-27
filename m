Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C087255CC74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiF0LN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiF0LN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316626465;
        Mon, 27 Jun 2022 04:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A43613FB;
        Mon, 27 Jun 2022 11:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9029C3411D;
        Mon, 27 Jun 2022 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656328406;
        bh=kOe+ZhcP11eWXLacwrvNesOjOwoae4Ak+vHOGPJnpKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaODXz6BN4LkVrRa8wExQyp5zNoEFfl3QDgKn5M3Nr0x3L1Drpd0bL4k7yEUg4lOC
         vYff69Bch/L3eoNq6QkkwejWtzwwSMdw4YBvhHuQEsSdE/df65qU/VNMTRQ6G3uYa5
         ZoPn9rYu1BFkn30cUGLIDmGaUHAad/9YwjerBMdUGx7Oo86BV4cUEG1xhsxflkxRGp
         3tC5TlZ6aox3tRC/dg4Bp/KAriqisOMRiqeLi7tEzDD+SAOfI6qs0aESyltJC4Qe0J
         arl+qLhch9LfOZ+RdsnV5bw+buvayB3dNCUoJIWiiUsFzDet6/Z92sNRaKSybiI94w
         IR2yJf41Y6BKw==
Date:   Mon, 27 Jun 2022 12:13:20 +0100
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        acme@kernel.org, german.gomez@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: arm64: Add SVE vector granule register to
 user regs
Message-ID: <20220627111319.GG22095@willie-the-truck>
References: <20220517100743.3020667-1-james.clark@arm.com>
 <20220517100743.3020667-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517100743.3020667-2-james.clark@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:07:42AM +0100, James Clark wrote:
> Dwarf based unwinding in a function that pushes SVE registers onto
> the stack requires the unwinder to know the length of the SVE register
> to calculate the stack offsets correctly. This was added to the Arm
> specific Dwarf spec as the VG pseudo register[1].
> 
> Add the vector length at position 46 if it's requested by userspace and
> SVE is supported. If it's not supported then fail to open the event.
> 
> The vector length must be on each sample because it can be changed
> at runtime via a prctl or ptrace call. Also by adding it as a register
> rather than a separate attribute, minimal changes will be required in an
> unwinder that already indexes into the register list.
> 
> [1]: https://github.com/ARM-software/abi-aa/blob/main/aadwarf64/aadwarf64.rst
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  arch/arm64/include/uapi/asm/perf_regs.h |  7 +++++-
>  arch/arm64/kernel/perf_regs.c           | 30 +++++++++++++++++++++++--
>  drivers/perf/arm_pmu.c                  |  2 +-
>  3 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/uapi/asm/perf_regs.h b/arch/arm64/include/uapi/asm/perf_regs.h
> index d54daafa89e3..fd157f46727e 100644
> --- a/arch/arm64/include/uapi/asm/perf_regs.h
> +++ b/arch/arm64/include/uapi/asm/perf_regs.h
> @@ -36,6 +36,11 @@ enum perf_event_arm_regs {
>  	PERF_REG_ARM64_LR,
>  	PERF_REG_ARM64_SP,
>  	PERF_REG_ARM64_PC,
> -	PERF_REG_ARM64_MAX,
> +
> +	/* Extended/pseudo registers */
> +	PERF_REG_ARM64_VG = 46, // SVE Vector Granule
> +
> +	PERF_REG_ARM64_MAX = PERF_REG_ARM64_PC + 1,
> +	PERF_REG_ARM64_EXTENDED_MAX = PERF_REG_ARM64_VG + 1

I think you can leave PERF_REG_ARM64_MAX alone and just add:

	PERF_REG_ARM64_VG = 46,
	PERF_REG_ARM64_EXTENDED_MAX,

no?

>  };
>  #endif /* _ASM_ARM64_PERF_REGS_H */
> diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
> index f6f58e6265df..b4eece3eb17d 100644
> --- a/arch/arm64/kernel/perf_regs.c
> +++ b/arch/arm64/kernel/perf_regs.c
> @@ -9,9 +9,27 @@
>  #include <asm/perf_regs.h>
>  #include <asm/ptrace.h>
>  
> +static u64 perf_ext_regs_value(int idx)
> +{
> +	switch (idx) {
> +	case PERF_REG_ARM64_VG:
> +		if (WARN_ON_ONCE(!system_supports_sve()))
> +			return 0;
> +
> +		/*
> +		 * Vector granule is current length in bits of SVE registers
> +		 * divided by 64.
> +		 */
> +		return (task_get_sve_vl(current) * 8) / 64;

Is 'current' the right thing to use here? We pass the regs everywhere else,
so I'd prefer to stick with that if possible.

> +	default:
> +		WARN_ON_ONCE(true);
> +		return 0;
> +	}
> +}
> +
>  u64 perf_reg_value(struct pt_regs *regs, int idx)
>  {
> -	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM64_MAX))
> +	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM64_EXTENDED_MAX))
>  		return 0;
>  
>  	/*
> @@ -51,6 +69,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  	if ((u32)idx == PERF_REG_ARM64_PC)
>  		return regs->pc;
>  
> +	if ((u32)idx >= PERF_REG_ARM64_MAX)
> +		return perf_ext_regs_value(idx);
> +
>  	return regs->regs[idx];
>  }
>  
> @@ -58,7 +79,12 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  
>  int perf_reg_validate(u64 mask)
>  {
> -	if (!mask || mask & REG_RESERVED)
> +	u64 reserved_mask = REG_RESERVED;
> +
> +	if (system_supports_sve())
> +		reserved_mask &= ~(1ULL << PERF_REG_ARM64_VG);
> +
> +	if (!mask || mask & reserved_mask)
>  		return -EINVAL;
>  
>  	return 0;
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 59d3980b8ca2..3f07df5a7e95 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -894,7 +894,7 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
>  		 * pmu::filter_match callback and pmu::event_init group
>  		 * validation).
>  		 */
> -		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS,
> +		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS,

How does userspace know this capability is available? Should we advertise
the set of extended registers that we support, rather than make this a
one-trick pony for the vector length?

Also, you don't appear to #define PERF_REG_EXTENDED_MASK so I don't
understand how userspace is supposed to interact with this. Won't
has_extended_regs() always return false?

Will
