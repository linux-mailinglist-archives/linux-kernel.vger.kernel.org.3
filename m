Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2564850D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbiAEKNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:13:12 -0500
Received: from foss.arm.com ([217.140.110.172]:42894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234106AbiAEKNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:13:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A7A61042;
        Wed,  5 Jan 2022 02:13:11 -0800 (PST)
Received: from [10.57.85.117] (unknown [10.57.85.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BEE33F774;
        Wed,  5 Jan 2022 02:13:09 -0800 (PST)
Message-ID: <77d59823-b975-e3ba-3aa4-fac5c61bb69f@arm.com>
Date:   Wed, 5 Jan 2022 10:13:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 3/4] coresight: trbe: Work around the invalid prohibited
 states
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1641359159-22726-1-git-send-email-anshuman.khandual@arm.com>
 <1641359159-22726-4-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1641359159-22726-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman

On 05/01/2022 05:05, Anshuman Khandual wrote:
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
> place. This adds a new cpu errata in arm64 errata framework and also
> updates TRBE driver as required.
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
>   Documentation/arm64/silicon-errata.rst       |  2 +
>   arch/arm64/Kconfig                           | 23 ++++++++++
>   arch/arm64/kernel/cpu_errata.c               |  9 ++++
>   arch/arm64/tools/cpucaps                     |  1 +
>   drivers/hwtracing/coresight/coresight-trbe.c | 47 +++++++++++++++-----
>   5 files changed, 72 insertions(+), 10 deletions(-)

As with the previous patch, it may be a good idea to split the
patch to arm64 and trbe parts.

> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index c9b30e6c2b6c..e0ef3e9a4b8b 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -54,6 +54,8 @@ stable kernels.
>   +----------------+-----------------+-----------------+-----------------------------+
>   | ARM            | Cortex-A510     | #2064142        | ARM64_ERRATUM_2064142       |
>   +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-A510     | #2038923        | ARM64_ERRATUM_2038923       |
> ++----------------+-----------------+-----------------+-----------------------------+
>   | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
>   +----------------+-----------------+-----------------+-----------------------------+
>   | ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 2105b68d88db..026e34fb6fad 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -796,6 +796,29 @@ config ARM64_ERRATUM_2064142
>   
>   	  If unsure, say Y.
>   
> +config ARM64_ERRATUM_2038923
> +	bool "Cortex-A510: 2038923: workaround TRBE corruption with enable"
> +	depends on CORESIGHT_TRBE
> +	default y
> +	help
> +	  This option adds the workaround for ARM Cortex-A510 erratum 2038923.
> +
> +	  Affected Cortex-A510 core might cause an inconsistent view on whether trace is
> +	  prohibited within the CPU. As a result, the trace buffer or trace buffer state
> +	  might be corrupted. This happens after TRBE buffer has been enabled by setting
> +	  TRBLIMITR_EL1.E, followed by just a single context synchronization event before
> +	  execution changes from a context, in which trace is prohibited to one where it
> +	  isn't, or vice versa. In these mentioned conditions, the view of whether trace
> +	  is prohibited is inconsistent between parts of the CPU, and the trace buffer or
> +	  the trace buffer state might be corrupted.
> +
> +	  Work around this in the driver by preventing an inconsistent view of whether the
> +	  trace is prohibited or not based on TRBLIMITR_EL1.E by immediately following a
> +	  change to TRBLIMITR_EL1.E with at least one ISB instruction before an ERET, or
> +	  two ISB instructions if no ERET is to take place.
> +
> +	  If unsure, say Y.
> +
>   config CAVIUM_ERRATUM_22375
>   	bool "Cavium erratum 22375, 24313"
>   	default y
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index cbb7d5a9aee7..60b0c1f1d912 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -607,6 +607,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>   		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
>   	},
>   #endif
> +#ifdef CONFIG_ARM64_ERRATUM_2038923
> +	{
> +		.desc = "ARM erratum 2038923",
> +		.capability = ARM64_WORKAROUND_2038923,
> +
> +		/* Cortex-A510 r0p0 - r0p2 */
> +		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
> +	},
> +#endif
>   	{
>   	}
>   };
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index fca3cb329e1d..45a06d36d080 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -56,6 +56,7 @@ WORKAROUND_1463225
>   WORKAROUND_1508412
>   WORKAROUND_1542419
>   WORKAROUND_2064142
> +WORKAROUND_2038923
>   WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>   WORKAROUND_TSB_FLUSH_FAILURE
>   WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index ec24b62b2cec..0689c6dab96d 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -92,11 +92,13 @@ struct trbe_buf {
>   #define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
>   #define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE	1
>   #define TRBE_WORKAROUND_SYSREG_WRITE_FAILURE	2
> +#define TRBE_WORKAROUND_CORRUPTION_WITH_ENABLE	3
>   
>   static int trbe_errata_cpucaps[] = {
>   	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
>   	[TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
>   	[TRBE_WORKAROUND_SYSREG_WRITE_FAILURE] = ARM64_WORKAROUND_2064142,
> +	[TRBE_WORKAROUND_CORRUPTION_WITH_ENABLE] = ARM64_WORKAROUND_2038923,
>   	-1,		/* Sentinel, must be the last entry */
>   };
>   
> @@ -174,6 +176,11 @@ static inline bool trbe_may_fail_sysreg_write(struct trbe_cpudata *cpudata)
>   	return trbe_has_erratum(cpudata, TRBE_WORKAROUND_SYSREG_WRITE_FAILURE);
>   }
>   
> +static inline bool trbe_may_corrupt_with_enable(struct trbe_cpudata *cpudata)
> +{

minor nit: trbe_needs_{ctxt_sync, isb}_after_enable() ?

> +	return trbe_has_erratum(cpudata, TRBE_WORKAROUND_CORRUPTION_WITH_ENABLE);
> +}
> +
>   static int trbe_alloc_node(struct perf_event *event)
>   {
>   	if (event->cpu == -1)
> @@ -187,6 +194,30 @@ static inline void trbe_drain_buffer(void)
>   	dsb(nsh);
>   }
>   
> +static inline void set_trbe_enabled(struct trbe_cpudata *cpudata)
> +{
> +	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);

minor nit: This implies we do the TRBE programming in the following
manner in the common case (i.e, TRBE enabled in the beginning of a
session).
   -> set TRBE LIMIT
   -> read TRBE LIMIT
   -> set TRBE ENABLED

Could we please optimize this ? I believe the buf->trbe_limit
must hold the LIMITR value at any point in time. And thus this
function could simply be :

set_trbe_enabled(trbe_buf)
{
	limitr = trbe_buf->limit | LIMITR_ENABLE
	write(limitr, TRBLIMITR_EL1);
	...
}

Otherwise looks good to me

Suzuki
