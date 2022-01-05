Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58548522E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiAEL7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:59:47 -0500
Received: from foss.arm.com ([217.140.110.172]:43880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239893AbiAEL7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:59:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20E7A1FB;
        Wed,  5 Jan 2022 03:59:34 -0800 (PST)
Received: from [10.57.85.117] (unknown [10.57.85.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D179F3F5A1;
        Wed,  5 Jan 2022 03:59:32 -0800 (PST)
Message-ID: <adbe2a0a-4ed8-4b86-453d-94fec96757e2@arm.com>
Date:   Wed, 5 Jan 2022 11:59:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 4/4] coresight: trbe: Workaround TRBE trace data
 corruption
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1641359159-22726-1-git-send-email-anshuman.khandual@arm.com>
 <1641359159-22726-5-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1641359159-22726-5-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2022 05:05, Anshuman Khandual wrote:
> TRBE implementations affected by Arm erratum #1902691 might corrupt trace
> data or deadlock, when it's being written into the memory. Workaround this
> problem in the driver, by preventing TRBE initialization on affected cpus.
> This adds a new cpu errata in arm64 errata framework and also updates TRBE
> driver as required.
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
>   Documentation/arm64/silicon-errata.rst       |  2 ++
>   arch/arm64/Kconfig                           | 16 ++++++++++++++++
>   arch/arm64/kernel/cpu_errata.c               |  9 +++++++++
>   arch/arm64/tools/cpucaps                     |  1 +
>   drivers/hwtracing/coresight/coresight-trbe.c | 12 ++++++++++++
>   5 files changed, 40 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index e0ef3e9a4b8b..50018f60c4d4 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -56,6 +56,8 @@ stable kernels.
>   +----------------+-----------------+-----------------+-----------------------------+
>   | ARM            | Cortex-A510     | #2038923        | ARM64_ERRATUM_2038923       |
>   +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-A510     | #1902691        | ARM64_ERRATUM_1902691       |
> ++----------------+-----------------+-----------------+-----------------------------+
>   | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
>   +----------------+-----------------+-----------------+-----------------------------+
>   | ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 026e34fb6fad..1ea5c3b4aac0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -819,6 +819,22 @@ config ARM64_ERRATUM_2038923
>   
>   	  If unsure, say Y.
>   
> +config ARM64_ERRATUM_1902691
> +	bool "Cortex-A510: 1902691: workaround TRBE trace corruption"
> +	depends on CORESIGHT_TRBE
> +	default y
> +	help
> +	  This option adds the workaround for ARM Cortex-A510 erratum 1902691.
> +
> +	  Affected Cortex-A510 core might cause trace data corruption, when being written
> +	  into the memory. Effectively TRBE is broken and hence cannot be used to capture
> +	  trace data.
> +
> +	  Work around this problem in the driver by just preventing TRBE initialization on
> +	  affected cpus.
> +
> +	  If unsure, say Y.
> +

It might be better to add :

"The firmware must have disabled the access to TRBE for the kernel on 
such implementations. This will cover the kernel for any firmware that
doesn't do this already"


>   config CAVIUM_ERRATUM_22375
>   	bool "Cavium erratum 22375, 24313"
>   	default y
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 60b0c1f1d912..a3336dfb5a8a 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -615,6 +615,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {	
>   		/* Cortex-A510 r0p0 - r0p2 */
>   		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
>   	},
> +#endif
> +#ifdef CONFIG_ARM64_ERRATUM_1902691
> +	{
> +		.desc = "ARM erratum 1902691",
> +		.capability = ARM64_WORKAROUND_1902691,
> +
> +		/* Cortex-A510 r0p0 - r0p1 */
> +		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 1)
> +	},
>   #endif
>   	{
>   	}
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 45a06d36d080..e7719e8f18de 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -57,6 +57,7 @@ WORKAROUND_1508412
>   WORKAROUND_1542419
>   WORKAROUND_2064142
>   WORKAROUND_2038923
> +WORKAROUND_1902691
>   WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>   WORKAROUND_TSB_FLUSH_FAILURE
>   WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 0689c6dab96d..b9b4e34fac15 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -93,12 +93,14 @@ struct trbe_buf {
>   #define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE	1
>   #define TRBE_WORKAROUND_SYSREG_WRITE_FAILURE	2
>   #define TRBE_WORKAROUND_CORRUPTION_WITH_ENABLE	3
> +#define TRBE_IS_BROKEN	4
>   
>   static int trbe_errata_cpucaps[] = {
>   	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
>   	[TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
>   	[TRBE_WORKAROUND_SYSREG_WRITE_FAILURE] = ARM64_WORKAROUND_2064142,
>   	[TRBE_WORKAROUND_CORRUPTION_WITH_ENABLE] = ARM64_WORKAROUND_2038923,
> +	[TRBE_IS_BROKEN] = ARM64_WORKAROUND_1902691,
>   	-1,		/* Sentinel, must be the last entry */
>   };
>   
> @@ -181,6 +183,11 @@ static inline bool trbe_may_corrupt_with_enable(struct trbe_cpudata *cpudata)
>   	return trbe_has_erratum(cpudata, TRBE_WORKAROUND_CORRUPTION_WITH_ENABLE);
>   }
>   
> +static inline bool trbe_is_broken(struct trbe_cpudata *cpudata)
> +{
> +	return trbe_has_erratum(cpudata, TRBE_IS_BROKEN);
> +}
> +
>   static int trbe_alloc_node(struct perf_event *event)
>   {
>   	if (event->cpu == -1)
> @@ -1291,6 +1298,11 @@ static void arm_trbe_probe_cpu(void *info)
>   	 */
>   	trbe_check_errata(cpudata);
>   
> +	if (trbe_is_broken(cpudata)) {
> +		pr_err("TRBE might corrupt the trace on cpu %d\n", cpu);

It may be better to say:

		"Disabling TRBE on CPU%d due to erratum"

Otherwise looks good to me.

Suzuki
