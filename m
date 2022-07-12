Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352DD571206
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiGLFzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLFzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:55:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1E983134F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:55:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0E2B143D;
        Mon, 11 Jul 2022 22:55:19 -0700 (PDT)
Received: from [10.162.42.8] (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14C933F73D;
        Mon, 11 Jul 2022 22:55:16 -0700 (PDT)
Message-ID: <8545ca2b-ece8-83e1-7709-8e483bced83b@arm.com>
Date:   Tue, 12 Jul 2022 11:25:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drivers/perf: arm_spe: Fix consistency of
 SYS_PMSCR_EL1.CX
Content-Language: en-US
To:     "itaru.kitayama@fujitsu.com" <itaru.kitayama@fujitsu.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "german.gomez@arm.com" <german.gomez@arm.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220712051404.2546851-1-anshuman.khandual@arm.com>
 <TYAPR01MB2031EDAB65B9F7514AE6C06081869@TYAPR01MB2031.jpnprd01.prod.outlook.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <TYAPR01MB2031EDAB65B9F7514AE6C06081869@TYAPR01MB2031.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/22 10:59, itaru.kitayama@fujitsu.com wrote:
> Anshuman,
> Do you make your git tree public so we can pull and examine?

Dont have a public git tree with this change, but it's just a single patch
which could be applied stand alone on current mainline release 5.19-rc6.
What is the problem ?
 
> 
> Thanks,
> Itaru.
> 
> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On Behalf Of Anshuman Khandual
> Sent: Tuesday, July 12, 2022 2:14 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: german.gomez@arm.com; james.clark@arm.com; suzuki.poulose@arm.com; Anshuman Khandual <anshuman.khandual@arm.com>; Will Deacon <will@kernel.org>; Mark Rutland <mark.rutland@arm.com>; linux-kernel@vger.kernel.org
> Subject: [PATCH] drivers/perf: arm_spe: Fix consistency of SYS_PMSCR_EL1.CX
> 
> The arm_spe_pmu driver will enable SYS_PMSCR_EL1.CX in order to add CONTEXT packets into the traces, if the owner of the perf event runs with required capabilities i.e CAP_PERFMON or CAP_SYS_ADMIN via perfmon_capable() helper.
> 
> The value of this bit is computed in the arm_spe_event_to_pmscr() function but the check for capabilities happens in the pmu event init callback i.e arm_spe_pmu_event_init(). This suggests that the value of the CX bit should remain consistent for the duration of the perf session.
> 
> However, the function arm_spe_event_to_pmscr() may be called later during the event start callback i.e arm_spe_pmu_start() when the "current" process is not the owner of the perf session, hence the CX bit setting is currently not consistent.
> 
> One way to fix this, is by caching the required value of the CX bit during the initialization of the PMU event, so that it remains consistent for the duration of the session. It uses currently unused 'event->hw.flags' element to cache perfmon_capable() value, which can be referred during event start callback to compute SYS_PMSCR_EL1.CX. This ensures consistent availability of context packets in the trace as per event owner capabilities.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.19-rc6 and built on an earlier version posted by German https://lore.kernel.org/all/20220117124432.3119132-1-german.gomez@arm.com/
> 
>  drivers/perf/arm_spe_pmu.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c index db670b265897..011e98428233 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -39,6 +39,26 @@
>  #include <asm/mmu.h>
>  #include <asm/sysreg.h>
>  
> +/*
> + * event.hw.flags remain unused for events created for this
> + * PMU driver. A single bit there i.e BIT(0), could be used
> + * to remember initiating process's perfmon_capable() value
> + * which can be subsequently used to enable SYS_PMSCR_EL.CX
> + * thus enabling context information in the trace.
> + */
> +#define SPE_PMU_HW_FLAGS_CX			BIT(0)
> +
> +static void event_hw_flags_set_cx(struct perf_event *event) {
> +	if (perfmon_capable())
> +		event->hw.flags |= SPE_PMU_HW_FLAGS_CX; }
> +
> +static bool event_hw_flags_has_cx(struct perf_event *event) {
> +	return !!(event->hw.flags & SPE_PMU_HW_FLAGS_CX); }
> +
>  #define ARM_SPE_BUF_PAD_BYTE			0
>  
>  struct arm_spe_pmu_buf {
> @@ -272,7 +292,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>  	if (!attr->exclude_kernel)
>  		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
>  
> -	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
> +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && 
> +event_hw_flags_has_cx(event))
>  		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
>  
>  	return reg;
> @@ -710,7 +730,8 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  
>  	reg = arm_spe_event_to_pmscr(event);
> -	if (!perfmon_capable() &&
> +	event_hw_flags_set_cx(event);
> +	if (!event_hw_flags_has_cx(event) &&
>  	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
>  		    BIT(SYS_PMSCR_EL1_CX_SHIFT) |
>  		    BIT(SYS_PMSCR_EL1_PCT_SHIFT))))
> --
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
