Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6B489839
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245209AbiAJMDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:03:41 -0500
Received: from foss.arm.com ([217.140.110.172]:33522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245184AbiAJMDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:03:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D15172B;
        Mon, 10 Jan 2022 04:03:31 -0800 (PST)
Received: from [10.57.85.117] (unknown [10.57.85.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E3B03F5A1;
        Mon, 10 Jan 2022 04:03:30 -0800 (PST)
Message-ID: <c0f062ea-6c05-0ff1-297e-1ed8a5ed8666@arm.com>
Date:   Mon, 10 Jan 2022 12:03:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH V2 6/7] coresight: trbe: Work around the invalid
 prohibited states
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1641517808-5735-1-git-send-email-anshuman.khandual@arm.com>
 <1641517808-5735-7-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1641517808-5735-7-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 01:10, Anshuman Khandual wrote:
> TRBE implementations affected by Arm erratum #2038923 might get TRBE into
> an inconsistent view on whether trace is prohibited within the CPU. As a
> result, the trace buffer or trace buffer state might be corrupted. This
> happens after TRBE buffer has been enabled by setting TRBLIMITR_EL1.E,
> followed by just a single context synchronization event before execution
> changes from a context, in which trace is prohibited to one where it isn't,
> or vice versa. In these mentioned conditions, the view of whether trace is
> prohibited is inconsistent between parts of the CPU, and the trace buffer
> or the trace buffer state might be corrupted.
> 
> Work around this problem in the TRBE driver by preventing an inconsistent
> view of whether the trace is prohibited or not based on TRBLIMITR_EL1.E by
> immediately following a change to TRBLIMITR_EL1.E with at least one ISB
> instruction before an ERET, or two ISB instructions if no ERET is to take
> place. This just updates the TRBE driver as required.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/Kconfig                           |  2 +-
>   drivers/hwtracing/coresight/coresight-trbe.c | 48 +++++++++++++++-----
>   2 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b6d62672bf7d..209e481acf0d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -798,7 +798,7 @@ config ARM64_ERRATUM_2064142
>   
>   config ARM64_ERRATUM_2038923
>   	bool "Cortex-A510: 2038923: workaround TRBE corruption with enable"
> -	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
> +	depends on CORESIGHT_TRBE
>   	default y
>   	help
>   	  This option adds the workaround for ARM Cortex-A510 erratum 2038923.
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 850e9fca6847..c4cc529749f8 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -92,11 +92,13 @@ struct trbe_buf {
>   #define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
>   #define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE	1
>   #define TRBE_NEEDS_DRAIN_AFTER_DISABLE		2
> +#define TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE	3
>   
>   static int trbe_errata_cpucaps[] = {
>   	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
>   	[TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
>   	[TRBE_NEEDS_DRAIN_AFTER_DISABLE] = ARM64_WORKAROUND_2064142,
> +	[TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE] = ARM64_WORKAROUND_2038923,
>   	-1,		/* Sentinel, must be the last entry */
>   };
>   
> @@ -174,6 +176,11 @@ static inline bool trbe_needs_drain_after_disable(struct trbe_cpudata *cpudata)
>   	return trbe_has_erratum(cpudata, TRBE_NEEDS_DRAIN_AFTER_DISABLE);
>   }
>   
> +static inline bool trbe_needs_ctxt_sync_after_enable(struct trbe_cpudata *cpudata)
> +{
> +	return trbe_has_erratum(cpudata, TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE);
> +}
> +
>   static int trbe_alloc_node(struct perf_event *event)
>   {
>   	if (event->cpu == -1)
> @@ -187,6 +194,28 @@ static inline void trbe_drain_buffer(void)
>   	dsb(nsh);
>   }
>   
> +static inline void set_trbe_enabled(struct trbe_cpudata *cpudata, u64 trblimitr)
> +{
> +	/*
> +	 * Enable the TRBE without clearing LIMITPTR which
> +	 * might be required for fetching the buffer limits.
> +	 */
> +	trblimitr |= TRBLIMITR_ENABLE;
> +	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
> +
> +	/* Synchronize the TRBE enable event */
> +	isb();
> +
> +	/*
> +	 * Errata affected TRBE implementation will need an additional
> +	 * context synchronization in order to prevent an inconsistent
> +	 * TRBE prohibited region view on the CPU which could possibly
> +	 * corrupt the TRBE buffer or the TRBE state.
> +	 */
> +	if (trbe_needs_ctxt_sync_after_enable(cpudata))
> +		isb();
> +}

Similar to the previous patch, we may move the comment to the function
where it is defined.

Either ways:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
