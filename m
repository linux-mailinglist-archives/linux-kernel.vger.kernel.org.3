Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC84A988F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358477AbiBDLsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:48:42 -0500
Received: from foss.arm.com ([217.140.110.172]:38584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbiBDLsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:48:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 255CE1480;
        Fri,  4 Feb 2022 03:48:41 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5C8C3F40C;
        Fri,  4 Feb 2022 03:48:39 -0800 (PST)
Date:   Fri, 4 Feb 2022 11:48:35 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, ashoks@broadcom.com
Subject: Re: [PATCH] perf/arm64: fix mapping for HW_BRANCH_INSTRUCTIONS on
 PMUv3
Message-ID: <Yf0Sk5dT4HXviI+M@FVFF77S0Q05N>
References: <20220204073940.1258263-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204073940.1258263-1-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

On Thu, Feb 03, 2022 at 11:39:40PM -0800, Stephane Eranian wrote:
> With the existing code, the following command:
> 
> $ perf stat -e branches sleep 0
>  Performance counter stats for 'sleep 0':
>    <not supported>      branches
> 
> on N1 core (pmuv3).

This is definitely not ideal. :(

> This is due to the fact that the mapping for the generic event is wrong.

I don't think that's quite true; more detail below. This is certainly *messy*
though.

> It is using ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED which is not implemented
> on N1 (and most likely on any PMUv3 implementations). However, there is
> another supported event ARMV8_PMUV3_PERFCTR_BR_RETIRED measuring the same
> condition.

I have a couple of concerns here:

1) Both PC_WRITE_RETIRED and BR_RETIRED are OPTIONAL (though the Arm strongly
   recommends that BR_RETIRED is implemented), so CPUs may exist which only
   support one of the two, or both.
 
   So as-is, this patch may break working support for CPUs which have
   PC_WRITE_RETIRED but not BR_RETIRED.

   IIUC we should be able to detect whether either are implemented by looking
   at PMCEID, and we could take that into account when mapping the event.

2) IIUC (even with ARMv8.6) there is a potential semantic difference between
   PC_WRITE_RETIRED and BR_RETIRED, in that e.g. PC_WRITE_RETIRED must include
   exception returns while this is IMPLEMENTATION DEFINED for BR_RETIRED.

   I guess this might not matter all that much given the precise definition of
   "Software change of the PC" is IMPLEMENTATION DEFINED, but I don't think
   it's true that the two events count "the same condition", and we should be
   more explicit about that.

> This patch switches the mapping to ARMV8_PMUV3_PERFCTR_BR_RETIRED so that
> the perf stat command above works.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/arm64/kernel/perf_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cab678ed6618..ec2b98343a0b 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -45,7 +45,7 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
>  	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
>  	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
>  	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
> -	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
> +	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_BR_RETIRED,

As above, I don't think we can unconditionally make this change, and instead
should have the mapping function take PMCEID into account to map the event (or
bail out if we don't know a suitable event is implemented).

Thanks,
Mark.

>  	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
>  	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
>  	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
> -- 
> 2.35.0.263.gb82422642f-goog
> 
