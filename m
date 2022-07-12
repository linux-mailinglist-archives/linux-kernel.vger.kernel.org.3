Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F45E57136B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiGLHtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiGLHtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:49:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 839ED9B562
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:49:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B30A21516;
        Tue, 12 Jul 2022 00:49:29 -0700 (PDT)
Received: from [10.1.29.134] (e127744.cambridge.arm.com [10.1.29.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 885A93F73D;
        Tue, 12 Jul 2022 00:49:27 -0700 (PDT)
Subject: Re: [PATCH] drivers/perf: arm_spe: Fix consistency of
 SYS_PMSCR_EL1.CX
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     james.clark@arm.com, suzuki.poulose@arm.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
References: <20220712051404.2546851-1-anshuman.khandual@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <42caa18b-6287-0cfe-90c6-e47ec1709154@arm.com>
Date:   Tue, 12 Jul 2022 08:49:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220712051404.2546851-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reworking the patch, Anshuman,

On 12/07/2022 06:14, Anshuman Khandual wrote:
> The arm_spe_pmu driver will enable SYS_PMSCR_EL1.CX in order to add CONTEXT
> packets into the traces, if the owner of the perf event runs with required
> capabilities i.e CAP_PERFMON or CAP_SYS_ADMIN via perfmon_capable() helper.
>
> The value of this bit is computed in the arm_spe_event_to_pmscr() function
> but the check for capabilities happens in the pmu event init callback i.e
> arm_spe_pmu_event_init(). This suggests that the value of the CX bit should
> remain consistent for the duration of the perf session.
>
> However, the function arm_spe_event_to_pmscr() may be called later during
> the event start callback i.e arm_spe_pmu_start() when the "current" process
> is not the owner of the perf session, hence the CX bit setting is currently
> not consistent.
>
> One way to fix this, is by caching the required value of the CX bit during
> the initialization of the PMU event, so that it remains consistent for the
> duration of the session. It uses currently unused 'event->hw.flags' element
> to cache perfmon_capable() value, which can be referred during event start
> callback to compute SYS_PMSCR_EL1.CX. This ensures consistent availability
> of context packets in the trace as per event owner capabilities.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

I'll add the Fixes tag, which I forgot to add in the prev version (I think it's the right one :)

Fixed: cea7d0d4a59b ("drivers/perf: Open access for CAP_PERFMON privileged process")

> ---
> This applies on v5.19-rc6 and built on an earlier version posted by German
> https://lore.kernel.org/all/20220117124432.3119132-1-german.gomez@arm.com/
>
>  drivers/perf/arm_spe_pmu.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index db670b265897..011e98428233 100644
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
> +static void event_hw_flags_set_cx(struct perf_event *event)
> +{
> +	if (perfmon_capable())
> +		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
> +}
> +
> +static bool event_hw_flags_has_cx(struct perf_event *event)
> +{
> +	return !!(event->hw.flags & SPE_PMU_HW_FLAGS_CX);
> +}
> +
>  #define ARM_SPE_BUF_PAD_BYTE			0
>  
>  struct arm_spe_pmu_buf {
> @@ -272,7 +292,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>  	if (!attr->exclude_kernel)
>  		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
>  
> -	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
> +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && event_hw_flags_has_cx(event))
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
