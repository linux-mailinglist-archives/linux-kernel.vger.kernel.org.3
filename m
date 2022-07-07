Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D7456A0E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiGGLHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiGGLHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:07:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E14C65726A;
        Thu,  7 Jul 2022 04:07:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D09A1063;
        Thu,  7 Jul 2022 04:07:38 -0700 (PDT)
Received: from [10.57.86.163] (unknown [10.57.86.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B94613F66F;
        Thu,  7 Jul 2022 04:07:34 -0700 (PDT)
Message-ID: <73dafe08-d1f1-90b6-995e-7d38e9e1dce7@arm.com>
Date:   Thu, 7 Jul 2022 12:07:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [RESEND PATCH v3 1/2] perf: coresight_pmu: Add support for ARM
 CoreSight PMU driver
To:     Besar Wicaksono <bwicaksono@nvidia.com>, robin.murphy@arm.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sudeep.holla@arm.com,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
 <20220621055035.31766-2-bwicaksono@nvidia.com>
In-Reply-To: <20220621055035.31766-2-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2022 06:50, Besar Wicaksono wrote:
> Add support for ARM CoreSight PMU driver framework and interfaces.
> The driver provides generic implementation to operate uncore PMU based
> on ARM CoreSight PMU architecture. The driver also provides interface
> to get vendor/implementation specific information, for example event
> attributes and formating.
> 
> The specification used in this implementation can be found below:
>   * ACPI Arm Performance Monitoring Unit table:
>          https://developer.arm.com/documentation/den0117/latest
>   * ARM Coresight PMU architecture:
>          https://developer.arm.com/documentation/ihi0091/latest
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>   arch/arm64/configs/defconfig                  |    1 +
>   drivers/perf/Kconfig                          |    2 +
>   drivers/perf/Makefile                         |    1 +
>   drivers/perf/coresight_pmu/Kconfig            |   11 +
>   drivers/perf/coresight_pmu/Makefile           |    6 +
>   .../perf/coresight_pmu/arm_coresight_pmu.c    | 1312 +++++++++++++++++
>   .../perf/coresight_pmu/arm_coresight_pmu.h    |  177 +++
>   7 files changed, 1510 insertions(+)
>   create mode 100644 drivers/perf/coresight_pmu/Kconfig
>   create mode 100644 drivers/perf/coresight_pmu/Makefile
>   create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.c
>   create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.h
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d1105343bc2..22184f8883da 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1212,6 +1212,7 @@ CONFIG_PHY_UNIPHIER_USB3=y
>   CONFIG_PHY_TEGRA_XUSB=y
>   CONFIG_PHY_AM654_SERDES=m
>   CONFIG_PHY_J721E_WIZ=m
> +CONFIG_ARM_CORESIGHT_PMU=y
>   CONFIG_ARM_SMMU_V3_PMU=m
>   CONFIG_FSL_IMX8_DDR_PMU=m
>   CONFIG_QCOM_L2_PMU=y
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 1e2d69453771..c4e7cd5b4162 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -192,4 +192,6 @@ config MARVELL_CN10K_DDR_PMU
>   	  Enable perf support for Marvell DDR Performance monitoring
>   	  event on CN10K platform.
>   
> +source "drivers/perf/coresight_pmu/Kconfig"
> +
>   endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 57a279c61df5..4126a04b5583 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
>   obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
>   obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
>   obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
> +obj-$(CONFIG_ARM_CORESIGHT_PMU) += coresight_pmu/
> diff --git a/drivers/perf/coresight_pmu/Kconfig b/drivers/perf/coresight_pmu/Kconfig
> new file mode 100644
> index 000000000000..89174f54c7be
> --- /dev/null
> +++ b/drivers/perf/coresight_pmu/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> +
> +config ARM_CORESIGHT_PMU
> +	tristate "ARM Coresight PMU"
> +	depends on ACPI
> +	depends on ACPI_APMT || COMPILE_TEST
> +	help
> +	  Provides support for Performance Monitoring Unit (PMU) events based on
> +	  ARM CoreSight PMU architecture.
> \ No newline at end of file
> diff --git a/drivers/perf/coresight_pmu/Makefile b/drivers/perf/coresight_pmu/Makefile
> new file mode 100644
> index 000000000000..a2a7a5fbbc16
> --- /dev/null
> +++ b/drivers/perf/coresight_pmu/Makefile
> @@ -0,0 +1,6 @@
> +# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> +#
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_ARM_CORESIGHT_PMU) += \
> +	arm_coresight_pmu.o
> diff --git a/drivers/perf/coresight_pmu/arm_coresight_pmu.c b/drivers/perf/coresight_pmu/arm_coresight_pmu.c
> new file mode 100644
> index 000000000000..ba52cc592b2d
> --- /dev/null
> +++ b/drivers/perf/coresight_pmu/arm_coresight_pmu.c
> @@ -0,0 +1,1312 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM CoreSight PMU driver.
> + *
> + * This driver adds support for uncore PMU based on ARM CoreSight Performance
> + * Monitoring Unit Architecture. The PMU is accessible via MMIO registers and
> + * like other uncore PMUs, it does not support process specific events and
> + * cannot be used in sampling mode.
> + *
> + * This code is based on other uncore PMUs like ARM DSU PMU. It provides a
> + * generic implementation to operate the PMU according to CoreSight PMU
> + * architecture and ACPI ARM PMU table (APMT) documents below:
> + *   - ARM CoreSight PMU architecture document number: ARM IHI 0091 A.a-00bet0.
> + *   - APMT document number: ARM DEN0117.
> + * The description of the PMU, like the PMU device identification, available
> + * events, and configuration options, is vendor specific. The driver provides
> + * interface for vendor specific code to get this information. This allows the
> + * driver to be shared with PMU from different vendors.
> + *
> + * The CoreSight PMU devices can be named using implementor specific format, or
> + * with default naming format: arm_<apmt node type>_pmu_<numeric id>.

---

> + * The description of the device, like the identifier, supported events, and
> + * formats can be found in sysfs
> + * /sys/bus/event_source/devices/arm_<apmt node type>_pmu_<numeric id>

I don't think the above is needed. This is true for all PMU devices.

> + *
> + * The user should refer to the vendor technical documentation to get details
> + * about the supported events.
> + *
> + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/cacheinfo.h>
> +#include <linux/ctype.h>
> +#include <linux/interrupt.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <acpi/processor.h>
> +
> +#include "arm_coresight_pmu.h"
> +
> +#define PMUNAME "arm_system_pmu"
> +

If we have decied to call this arm_system_pmu, (which I am perfectly
happy with), could we please stick to that name for functions that we
export ?

e.g, s/coresight_pmu_sysfs_event_show/arm_system_pmu_event_show()/

> +#define CORESIGHT_CPUMASK_ATTR(_name, _config)				\
> +	CORESIGHT_EXT_ATTR(_name, coresight_pmu_cpumask_show,		\
> +			   (unsigned long)_config)
> +
> +/*
> + * Register offsets based on CoreSight Performance Monitoring Unit Architecture
> + * Document number: ARM-ECM-0640169 00alp6
> + */
> +#define PMEVCNTR_LO					0x0
> +#define PMEVCNTR_HI					0x4
> +#define PMEVTYPER					0x400
> +#define PMCCFILTR					0x47C
> +#define PMEVFILTR					0xA00
> +#define PMCNTENSET					0xC00
> +#define PMCNTENCLR					0xC20
> +#define PMINTENSET					0xC40
> +#define PMINTENCLR					0xC60
> +#define PMOVSCLR					0xC80
> +#define PMOVSSET					0xCC0
> +#define PMCFGR						0xE00
> +#define PMCR						0xE04
> +#define PMIIDR						0xE08
> +
> +/* PMCFGR register field */
> +#define PMCFGR_NCG_SHIFT				28
> +#define PMCFGR_NCG_MASK					0xf

Please could we instead do :

	PMCFGR_NCG					GENMASK(31, 28)
and similarly for all the other fields and use :

	FIELD_PREP(), FIELD_GET() helpers ?

> +#define PMCFGR_HDBG					BIT(24)
> +#define PMCFGR_TRO					BIT(23)
> +#define PMCFGR_SS					BIT(22)
> +#define PMCFGR_FZO					BIT(21)
> +#define PMCFGR_MSI					BIT(20)
> +#define PMCFGR_UEN					BIT(19)
> +#define PMCFGR_NA					BIT(17)
> +#define PMCFGR_EX					BIT(16)
> +#define PMCFGR_CCD					BIT(15)
> +#define PMCFGR_CC					BIT(14)
> +#define PMCFGR_SIZE_SHIFT				8
> +#define PMCFGR_SIZE_MASK				0x3f
> +#define PMCFGR_N_SHIFT					0
> +#define PMCFGR_N_MASK					0xff
> +
> +/* PMCR register field */
> +#define PMCR_TRO					BIT(11)
> +#define PMCR_HDBG					BIT(10)
> +#define PMCR_FZO					BIT(9)
> +#define PMCR_NA						BIT(8)
> +#define PMCR_DP						BIT(5)
> +#define PMCR_X						BIT(4)
> +#define PMCR_D						BIT(3)
> +#define PMCR_C						BIT(2)
> +#define PMCR_P						BIT(1)
> +#define PMCR_E						BIT(0)
> +
> +/* PMIIDR register field */
> +#define PMIIDR_IMPLEMENTER_MASK				0xFFF
> +#define PMIIDR_PRODUCTID_MASK				0xFFF
> +#define PMIIDR_PRODUCTID_SHIFT				20
> +
> +/* Each SET/CLR register supports up to 32 counters. */
> +#define CORESIGHT_SET_CLR_REG_COUNTER_NUM		32
> +#define CORESIGHT_SET_CLR_REG_COUNTER_SHIFT		5

minor nits:

Could we rename sucht that s/CORESIGHT/PMU ? Without the PMU, it could
be confused as a CORESIGHT architecture specific thing.

Also

  #define CORESIGHT_SET_CLR_REG_COUNTER_NUM	(1 < 
CORESIGHT_SET_CLR_REG_COUNTER_SHIFT)


> +
> +/* The number of 32-bit SET/CLR register that can be supported. */
> +#define CORESIGHT_SET_CLR_REG_MAX_NUM ((PMCNTENCLR - PMCNTENSET) / sizeof(u32))
> +
> +static_assert((CORESIGHT_SET_CLR_REG_MAX_NUM *
> +	       CORESIGHT_SET_CLR_REG_COUNTER_NUM) >=
> +	      CORESIGHT_PMU_MAX_HW_CNTRS);
> +
> +/* Convert counter idx into SET/CLR register number. */
> +#define CORESIGHT_IDX_TO_SET_CLR_REG_ID(idx)				\
> +	(idx >> CORESIGHT_SET_CLR_REG_COUNTER_SHIFT)
> +
> +/* Convert counter idx into SET/CLR register bit. */
> +#define CORESIGHT_IDX_TO_SET_CLR_REG_BIT(idx)				\
> +	(idx & (CORESIGHT_SET_CLR_REG_COUNTER_NUM - 1))

super minor nit:

	COUNTER_TO_SET_CLR_REG_IDX
	COUNTER_TO_SET_CLR_REG_BIT ?

I don't see a need for prefixing them with CORESIGHT and making them 
unnecessary longer.

> +
> +#define CORESIGHT_ACTIVE_CPU_MASK			0x0
> +#define CORESIGHT_ASSOCIATED_CPU_MASK			0x1
> +
> +
> +/* Check if field f in flags is set with value v */
> +#define CHECK_APMT_FLAG(flags, f, v) \
> +	((flags & (ACPI_APMT_FLAGS_ ## f)) == (ACPI_APMT_FLAGS_ ## f ## _ ## v))
> +
> +static unsigned long coresight_pmu_cpuhp_state;
> +
> +/*
> + * In CoreSight PMU architecture, all of the MMIO registers are 32-bit except
> + * counter register. The counter register can be implemented as 32-bit or 64-bit
> + * register depending on the value of PMCFGR.SIZE field. For 64-bit access,
> + * single-copy 64-bit atomic support is implementation defined. APMT node flag
> + * is used to identify if the PMU supports 64-bit single copy atomic. If 64-bit
> + * single copy atomic is not supported, the driver treats the register as a pair
> + * of 32-bit register.
> + */
> +
> +/*
> + * Read 64-bit register as a pair of 32-bit registers using hi-lo-hi sequence.
> + */
> +static u64 read_reg64_hilohi(const void __iomem *addr)
> +{
> +	u32 val_lo, val_hi;
> +	u64 val;
> +
> +	/* Use high-low-high sequence to avoid tearing */
> +	do {
> +		val_hi = readl(addr + 4);
> +		val_lo = readl(addr);
> +	} while (val_hi != readl(addr + 4));
> +
> +	val = (((u64)val_hi << 32) | val_lo);
> +
> +	return val;
> +}
> +
> +/* Check if PMU supports 64-bit single copy atomic. */
> +static inline bool support_atomic(const struct coresight_pmu *coresight_pmu)

minor nit: supports_64bit_atomics() ?

> +{
> +	return CHECK_APMT_FLAG(coresight_pmu->apmt_node->flags, ATOMIC, SUPP);
> +}
> +
> +/* Check if cycle counter is supported. */
> +static inline bool support_cc(const struct coresight_pmu *coresight_pmu)

minor nit: supports_cycle_counter() ?

> +{
> +	return (coresight_pmu->pmcfgr & PMCFGR_CC);
> +}
> +
> +/* Get counter size. */
> +static inline u32 pmcfgr_size(const struct coresight_pmu *coresight_pmu)


Please could we change this  to

	counter_size(const struct coresight_pmu *coresight_pmu)
{
	/* Counter size is PMCFGR_SIZE + 1 */
	return FIELD_GET(PMCFGR_SIZE, pmu->pmcfgr) + 1;
}

and also add :

u64 counter_mask(..)
{
	return GENMASK_ULL(counter_size(pmu) - 1, 0);
}

See more on this below.

> +{
> +	return (coresight_pmu->pmcfgr >> PMCFGR_SIZE_SHIFT) & PMCFGR_SIZE_MASK;
> +}



> +/* Check if counter is implemented as 64-bit register. */
> +static inline bool
> +use_64b_counter_reg(const struct coresight_pmu *coresight_pmu)
> +{
> +	return (pmcfgr_size(coresight_pmu) > 31);
> +}
> +
> +/* Get number of counters, minus one. */
> +static inline u32 pmcfgr_n(const struct coresight_pmu *coresight_pmu)
> +{
> +	return (coresight_pmu->pmcfgr >> PMCFGR_N_SHIFT) & PMCFGR_N_MASK;
> +}
> +
> +ssize_t coresight_pmu_sysfs_event_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr =
> +		container_of(attr, struct dev_ext_attribute, attr);
> +	return sysfs_emit(buf, "event=0x%llx\n",
> +			  (unsigned long long)eattr->var);
> +}
> +EXPORT_SYMBOL_GPL(coresight_pmu_sysfs_event_show);


> +
> +/* Default event list. */
> +static struct attribute *coresight_pmu_event_attrs[] = {
> +	CORESIGHT_EVENT_ATTR(cycles, CORESIGHT_PMU_EVT_CYCLES_DEFAULT),
> +	NULL,
> +};
> +
> +struct attribute **
> +coresight_pmu_get_event_attrs(const struct coresight_pmu *coresight_pmu)
> +{
> +	return coresight_pmu_event_attrs;
> +}
> +EXPORT_SYMBOL_GPL(coresight_pmu_get_event_attrs);
> +
> +umode_t coresight_pmu_event_attr_is_visible(struct kobject *kobj,
> +					    struct attribute *attr, int unused)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct coresight_pmu *coresight_pmu =
> +		to_coresight_pmu(dev_get_drvdata(dev));
> +	struct perf_pmu_events_attr *eattr;
> +
> +	eattr = container_of(attr, typeof(*eattr), attr.attr);
> +
> +	/* Hide cycle event if not supported */
> +	if (!support_cc(coresight_pmu) &&
> +	    eattr->id == CORESIGHT_PMU_EVT_CYCLES_DEFAULT) {
> +		return 0;
> +	}
> +
> +	return attr->mode;
> +}
> +EXPORT_SYMBOL_GPL(coresight_pmu_event_attr_is_visible);
> +
> +ssize_t coresight_pmu_sysfs_format_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct dev_ext_attribute *eattr =
> +		container_of(attr, struct dev_ext_attribute, attr);
> +	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
> +}
> +EXPORT_SYMBOL_GPL(coresight_pmu_sysfs_format_show);
> +
> +static struct attribute *coresight_pmu_format_attrs[] = {
> +	CORESIGHT_FORMAT_EVENT_ATTR,
> +	CORESIGHT_FORMAT_FILTER_ATTR,
> +	NULL,
> +};
> +
> +struct attribute **
> +coresight_pmu_get_format_attrs(const struct coresight_pmu *coresight_pmu)
> +{
> +	return coresight_pmu_format_attrs;
> +}
> +EXPORT_SYMBOL_GPL(coresight_pmu_get_format_attrs);
> +
> +u32 coresight_pmu_event_type(const struct perf_event *event)
> +{
> +	return event->attr.config & CORESIGHT_EVENT_MASK;
> +}
> +EXPORT_SYMBOL_GPL(coresight_pmu_event_type);

Why do we need to export these ?

> +
> +u32 coresight_pmu_event_filter(const struct perf_event *event)
> +{
> +	return event->attr.config1 & CORESIGHT_FILTER_MASK;
> +}
> +EXPORT_SYMBOL_GPL(coresight_pmu_event_filter);
> +
> +static ssize_t coresight_pmu_identifier_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *page)
> +{
> +	struct coresight_pmu *coresight_pmu =
> +		to_coresight_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(page, "%s\n", coresight_pmu->identifier);
> +}
> +
> +static struct device_attribute coresight_pmu_identifier_attr =
> +	__ATTR(identifier, 0444, coresight_pmu_identifier_show, NULL);
> +
> +static struct attribute *coresight_pmu_identifier_attrs[] = {
> +	&coresight_pmu_identifier_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group coresight_pmu_identifier_attr_group = {
> +	.attrs = coresight_pmu_identifier_attrs,
> +};
> +
> +const char *
> +coresight_pmu_get_identifier(const struct coresight_pmu *coresight_pmu)
> +{
> +	const char *identifier =
> +		devm_kasprintf(coresight_pmu->dev, GFP_KERNEL, "%x",
> +			       coresight_pmu->impl.pmiidr);
> +	return identifier;
> +}
> +EXPORT_SYMBOL_GPL(coresight_pmu_get_identifier);
> +
> +static const char *coresight_pmu_type_str[ACPI_APMT_NODE_TYPE_COUNT] = {
> +    "mc",
> +    "smmu",
> +    "pcie",
> +    "acpi",
> +    "cache",
> +};
> +
> +const char *coresight_pmu_get_name(const struct coresight_pmu *coresight_pmu)
> +{
> +	struct device *dev;
> +	u8 pmu_type;
> +	char *name;
> +	char acpi_hid_string[ACPI_ID_LEN] = { 0 };
> +	static atomic_t pmu_idx[ACPI_APMT_NODE_TYPE_COUNT] = { 0 };
> +
> +	dev = coresight_pmu->dev;
> +	pmu_type = coresight_pmu->apmt_node->type;

Please could we use a variable to refer to the "coresight_pmu->apmt_node" ?
It helps with code reading below and also gives us a hint to the
type of that field, we refer multiple times below.

> +
> +	if (pmu_type >= ACPI_APMT_NODE_TYPE_COUNT) {
> +		dev_err(dev, "unsupported PMU type-%u\n", pmu_type);
> +		return NULL;
> +	}
> +
> +	if (pmu_type == ACPI_APMT_NODE_TYPE_ACPI) {
> +		memcpy(acpi_hid_string,
> +			&coresight_pmu->apmt_node->inst_primary,
> +			sizeof(coresight_pmu->apmt_node->inst_primary));
> +		name = devm_kasprintf(dev, GFP_KERNEL, "arm_%s_pmu_%s_%u",
> +				      coresight_pmu_type_str[pmu_type],
> +				      acpi_hid_string,
> +				      coresight_pmu->apmt_node->inst_secondary);
> +	} else {
> +		name = devm_kasprintf(dev, GFP_KERNEL, "arm_%s_pmu_%d",
> +				      coresight_pmu_type_str[pmu_type],
> +				      atomic_fetch_inc(&pmu_idx[pmu_type]));
> +	}
> +
> +	return name;
> +}
> +EXPORT_SYMBOL_GPL(coresight_pmu_get_name);
> +
> +static ssize_t coresight_pmu_cpumask_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct pmu *pmu = dev_get_drvdata(dev);
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(pmu);
> +	struct dev_ext_attribute *eattr =
> +		container_of(attr, struct dev_ext_attribute, attr);
> +	unsigned long mask_id = (unsigned long)eattr->var;
> +	const cpumask_t *cpumask;
> +
> +	switch (mask_id) {
> +	case CORESIGHT_ACTIVE_CPU_MASK:
> +		cpumask = &coresight_pmu->active_cpu;
> +		break;
> +	case CORESIGHT_ASSOCIATED_CPU_MASK:
> +		cpumask = &coresight_pmu->associated_cpus;
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return cpumap_print_to_pagebuf(true, buf, cpumask);
> +}
> +
> +static struct attribute *coresight_pmu_cpumask_attrs[] = {
> +	CORESIGHT_CPUMASK_ATTR(cpumask, CORESIGHT_ACTIVE_CPU_MASK),
> +	CORESIGHT_CPUMASK_ATTR(associated_cpus, CORESIGHT_ASSOCIATED_CPU_MASK),
> +	NULL,
> +};
> +
> +static struct attribute_group coresight_pmu_cpumask_attr_group = {
> +	.attrs = coresight_pmu_cpumask_attrs,
> +};
> +
> +static const struct coresight_pmu_impl_ops default_impl_ops = {
> +	.get_event_attrs	= coresight_pmu_get_event_attrs,
> +	.get_format_attrs	= coresight_pmu_get_format_attrs,
> +	.get_identifier		= coresight_pmu_get_identifier,
> +	.get_name		= coresight_pmu_get_name,
> +	.is_cc_event		= coresight_pmu_is_cc_event,
> +	.event_type		= coresight_pmu_event_type,
> +	.event_filter		= coresight_pmu_event_filter,
> +	.event_attr_is_visible	= coresight_pmu_event_attr_is_visible
> +};
> +
> +struct impl_match {
> +	u32 pmiidr;
> +	u32 mask;
> +	int (*impl_init_ops)(struct coresight_pmu *coresight_pmu); > +};
> +
> +static const struct impl_match impl_match[] = {
> +	{}
> +};
> +
> +static int coresight_pmu_init_impl_ops(struct coresight_pmu *coresight_pmu)
> +{
> +	int idx, ret;
> +	struct acpi_apmt_node *apmt_node = coresight_pmu->apmt_node;
> +	const struct impl_match *match = impl_match;
> +
> +	/*
> +	 * Get PMU implementer and product id from APMT node.
> +	 * If APMT node doesn't have implementer/product id, try get it
> +	 * from PMIIDR.
> +	 */
> +	coresight_pmu->impl.pmiidr =
> +		(apmt_node->impl_id) ? apmt_node->impl_id :
> +				       readl(coresight_pmu->base0 + PMIIDR);
> +
> +	/* Find implementer specific attribute ops. */
> +	for (idx = 0; match->pmiidr; match++, idx++) {

idx is unused, please remove it.

> +		if ((match->pmiidr & match->mask) ==
> +		    (coresight_pmu->impl.pmiidr & match->mask)) {
> +			ret = match->impl_init_ops(coresight_pmu);
> +			if (ret)
> +				return ret;
> +
> +			return 0;
> +		}
> +	}
> +
> +	/* We don't find implementer specific attribute ops, use default. */
> +	coresight_pmu->impl.ops = &default_impl_ops;
> +	return 0;
> +}
> +
> +static struct attribute_group *
> +coresight_pmu_alloc_event_attr_group(struct coresight_pmu *coresight_pmu)
> +{
> +	struct attribute_group *event_group;
> +	struct device *dev = coresight_pmu->dev;
> +
> +	event_group =
> +		devm_kzalloc(dev, sizeof(struct attribute_group), GFP_KERNEL);
> +	if (!event_group)
> +		return NULL;
> +
> +	event_group->name = "events";
> +	event_group->attrs =
> +		coresight_pmu->impl.ops->get_event_attrs(coresight_pmu);


Is it mandatory for the PMUs to implement get_event_attrs() and all the 
call backs ? Does it makes sense to check and optionally call it, if the
backend driver implements it ? Or at least we should make sure the 
required operations are filled in by backend.


> +	event_group->is_visible =
> +		coresight_pmu->impl.ops->event_attr_is_visible;
> +
> +	return event_group;
> +}
> +
> +static struct attribute_group *
> +coresight_pmu_alloc_format_attr_group(struct coresight_pmu *coresight_pmu)
> +{
> +	struct attribute_group *format_group;
> +	struct device *dev = coresight_pmu->dev;
> +
> +	format_group =
> +		devm_kzalloc(dev, sizeof(struct attribute_group), GFP_KERNEL);
> +	if (!format_group)
> +		return NULL;
> +
> +	format_group->name = "format";
> +	format_group->attrs =
> +		coresight_pmu->impl.ops->get_format_attrs(coresight_pmu);

Same as above.

> +
> +	return format_group;
> +}
> +
> +static struct attribute_group **
> +coresight_pmu_alloc_attr_group(struct coresight_pmu *coresight_pmu)
> +{
> +	const struct coresight_pmu_impl_ops *impl_ops;
> +	struct attribute_group **attr_groups = NULL;
> +	struct device *dev = coresight_pmu->dev;
> +	int ret;
> +
> +	ret = coresight_pmu_init_impl_ops(coresight_pmu);
> +	if (ret)
> +		return NULL;
> +
> +	impl_ops = coresight_pmu->impl.ops;
> +
> +	coresight_pmu->identifier = impl_ops->get_identifier(coresight_pmu);
> +	coresight_pmu->name = impl_ops->get_name(coresight_pmu);

If the implementor doesn't have a naming scheme, could we default to the
generic scheme ?  In gerneal, we could fall back to the "generic" 
callbacks here if the implementor doesn't provide a specific call back.
That way, we could skip the exporting a lot of the callbacks.

> +
> +	if (!coresight_pmu->name)
> +		return NULL;
> +
> +	attr_groups = devm_kzalloc(dev, 5 * sizeof(struct attribute_group *),
> +				   GFP_KERNEL);

nit: devm_kcalloc() ?

> +	if (!attr_groups)
> +		return NULL;
> +
> +	attr_groups[0] = coresight_pmu_alloc_event_attr_group(coresight_pmu);
> +	attr_groups[1] = coresight_pmu_alloc_format_attr_group(coresight_pmu);

What if one of the above returned NULL and you wouldn't get the 
following listed ?

> +	attr_groups[2] = &coresight_pmu_identifier_attr_group;
> +	attr_groups[3] = &coresight_pmu_cpumask_attr_group;
> +
> +	return attr_groups;
> +}
> +
> +static inline void
> +coresight_pmu_reset_counters(struct coresight_pmu *coresight_pmu)
> +{
> +	u32 pmcr = 0;
> +
> +	pmcr |= PMCR_P;
> +	pmcr |= PMCR_C;
> +	writel(pmcr, coresight_pmu->base0 + PMCR);
> +}
> +
> +static inline void
> +coresight_pmu_start_counters(struct coresight_pmu *coresight_pmu)
> +{
> +	u32 pmcr;
> +
> +	pmcr = PMCR_E;
> +	writel(pmcr, coresight_pmu->base0 + PMCR);

nit: Isn't it easier to read as p;:

	writel(PMCR_E, ...);
> +}
> +
> +static inline void
> +coresight_pmu_stop_counters(struct coresight_pmu *coresight_pmu)
> +{
> +	u32 pmcr;
> +
> +	pmcr = 0;
> +	writel(pmcr, coresight_pmu->base0 + PMCR);

Similar to above,
	writel(0, ...);
?

> +}
> +
> +static void coresight_pmu_enable(struct pmu *pmu)
> +{
> +	bool disabled;
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(pmu);
> +
> +	disabled = bitmap_empty(coresight_pmu->hw_events.used_ctrs,
> +				coresight_pmu->num_logical_counters);
> +
> +	if (disabled)
> +		return;
> +
> +	coresight_pmu_start_counters(coresight_pmu);
> +}
> +
> +static void coresight_pmu_disable(struct pmu *pmu)
> +{
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(pmu);
> +
> +	coresight_pmu_stop_counters(coresight_pmu);
> +}
> +
> +bool coresight_pmu_is_cc_event(const struct perf_event *event)
> +{
> +	return (event->attr.config == CORESIGHT_PMU_EVT_CYCLES_DEFAULT);
> +}
> +EXPORT_SYMBOL_GPL(coresight_pmu_is_cc_event);
> +
> +static int
> +coresight_pmu_get_event_idx(struct coresight_pmu_hw_events *hw_events,
> +			    struct perf_event *event)
> +{
> +	int idx;
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
> +
> +	if (support_cc(coresight_pmu)) {
> +		if (coresight_pmu->impl.ops->is_cc_event(event)) {
> +			/* Search for available cycle counter. */
> +			if (test_and_set_bit(coresight_pmu->cc_logical_idx,
> +					     hw_events->used_ctrs))
> +				return -EAGAIN;
> +
> +			return coresight_pmu->cc_logical_idx;
> +		}
> +
> +		/*
> +		 * Search a regular counter from the used counter bitmap.
> +		 * The cycle counter divides the bitmap into two parts. Search
> +		 * the first then second half to exclude the cycle counter bit.
> +		 */
> +		idx = find_first_zero_bit(hw_events->used_ctrs,
> +					  coresight_pmu->cc_logical_idx);
> +		if (idx >= coresight_pmu->cc_logical_idx) {
> +			idx = find_next_zero_bit(
> +				hw_events->used_ctrs,
> +				coresight_pmu->num_logical_counters,
> +				coresight_pmu->cc_logical_idx + 1);
> +		}
> +	} else {
> +		idx = find_first_zero_bit(hw_events->used_ctrs,
> +					  coresight_pmu->num_logical_counters);
> +	}
> +
> +	if (idx >= coresight_pmu->num_logical_counters)
> +		return -EAGAIN;
> +
> +	set_bit(idx, hw_events->used_ctrs);
> +
> +	return idx;
> +}
> +
> +static bool
> +coresight_pmu_validate_event(struct pmu *pmu,
> +			     struct coresight_pmu_hw_events *hw_events,
> +			     struct perf_event *event)
> +{
> +	if (is_software_event(event))
> +		return true;
> +
> +	/* Reject groups spanning multiple HW PMUs. */
> +	if (event->pmu != pmu)
> +		return false;
> +
> +	return (coresight_pmu_get_event_idx(hw_events, event) >= 0);
> +}
> +
> +/*
> + * Make sure the group of events can be scheduled at once
> + * on the PMU.
> + */
> +static bool coresight_pmu_validate_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +	struct coresight_pmu_hw_events fake_hw_events;
> +
> +	if (event->group_leader == event)
> +		return true;
> +
> +	memset(&fake_hw_events, 0, sizeof(fake_hw_events));
> +
> +	if (!coresight_pmu_validate_event(event->pmu, &fake_hw_events, leader))
> +		return false;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (!coresight_pmu_validate_event(event->pmu, &fake_hw_events,
> +						  sibling))
> +			return false;
> +	}
> +
> +	return coresight_pmu_validate_event(event->pmu, &fake_hw_events, event);
> +}
> +
> +static int coresight_pmu_event_init(struct perf_event *event)
> +{
> +	struct coresight_pmu *coresight_pmu;
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	coresight_pmu = to_coresight_pmu(event->pmu);
> +
> +	/*
> +	 * Following other "uncore" PMUs, we do not support sampling mode or
> +	 * attach to a task (per-process mode).
> +	 */
> +	if (is_sampling_event(event)) {
> +		dev_dbg(coresight_pmu->pmu.dev,
> +			"Can't support sampling events\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
> +		dev_dbg(coresight_pmu->pmu.dev,
> +			"Can't support per-task counters\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Make sure the CPU assignment is on one of the CPUs associated with
> +	 * this PMU.
> +	 */
> +	if (!cpumask_test_cpu(event->cpu, &coresight_pmu->associated_cpus)) {
> +		dev_dbg(coresight_pmu->pmu.dev,
> +			"Requested cpu is not associated with the PMU\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Enforce the current active CPU to handle the events in this PMU. */
> +	event->cpu = cpumask_first(&coresight_pmu->active_cpu);
> +	if (event->cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	if (!coresight_pmu_validate_group(event))
> +		return -EINVAL;
> +
> +	/*
> +	 * The logical counter id is tracked with hw_perf_event.extra_reg.idx.
> +	 * The physical counter id is tracked with hw_perf_event.idx.
> +	 * We don't assign an index until we actually place the event onto
> +	 * hardware. Use -1 to signify that we haven't decided where to put it
> +	 * yet.
> +	 */
> +	hwc->idx = -1;
> +	hwc->extra_reg.idx = -1;
> +	hwc->config_base = coresight_pmu->impl.ops->event_type(event);

nit: This is a bit confusing combined with with pmu->base0, when we
write the event config.

Could we use hwc->config instead ?

> +
> +	return 0;
> +}
> +
> +static inline u32 counter_offset(u32 reg_sz, u32 ctr_idx)
> +{
> +	return (PMEVCNTR_LO + (reg_sz * ctr_idx));
> +}
> +
> +static void coresight_pmu_write_counter(struct perf_event *event, u64 val)
> +{
> +	u32 offset;
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
> +
> +	if (use_64b_counter_reg(coresight_pmu)) {
> +		offset = counter_offset(sizeof(u64), event->hw.idx);
> +
> +		writeq(val, coresight_pmu->base1 + offset);
> +	} else {
> +		offset = counter_offset(sizeof(u32), event->hw.idx);
> +
> +		writel(lower_32_bits(val), coresight_pmu->base1 + offset);
> +	}
> +}
> +
> +static u64 coresight_pmu_read_counter(struct perf_event *event)
> +{
> +	u32 offset;
> +	const void __iomem *counter_addr;
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
> +
> +	if (use_64b_counter_reg(coresight_pmu)) {
> +		offset = counter_offset(sizeof(u64), event->hw.idx);
> +		counter_addr = coresight_pmu->base1 + offset;
> +
> +		return support_atomic(coresight_pmu) ?
> +			       readq(counter_addr) :
> +			       read_reg64_hilohi(counter_addr);
> +	}
> +
> +	offset = counter_offset(sizeof(u32), event->hw.idx);
> +	return readl(coresight_pmu->base1 + offset);
> +}
> +
> +/*
> + * coresight_pmu_set_event_period: Set the period for the counter.
> + *
> + * To handle cases of extreme interrupt latency, we program
> + * the counter with half of the max count for the counters.
> + */
> +static void coresight_pmu_set_event_period(struct perf_event *event)
> +{
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
> +	u64 val = GENMASK_ULL(pmcfgr_size(coresight_pmu), 0) >> 1;

Please could we add a helper to get the "counter mask" ? Otherwise this 
is a bit confusing. We would expect
   pmcfgr_size() = 64 for 64bit counters, but it is really 63 instead.
and that made me stare the GENMASK_ULL() and go back trace it down
to the spec. Please see my suggestion on the top to add counter_mask().

> +
> +	local64_set(&event->hw.prev_count, val);
> +	coresight_pmu_write_counter(event, val);
> +}
> +
> +static void coresight_pmu_enable_counter(struct coresight_pmu *coresight_pmu,
> +					 int idx)
> +{
> +	u32 reg_id, reg_bit, inten_off, cnten_off;
> +
> +	reg_id = CORESIGHT_IDX_TO_SET_CLR_REG_ID(idx);
> +	reg_bit = CORESIGHT_IDX_TO_SET_CLR_REG_BIT(idx);
> +
> +	inten_off = PMINTENSET + (4 * reg_id);
> +	cnten_off = PMCNTENSET + (4 * reg_id);
> +
> +	writel(BIT(reg_bit), coresight_pmu->base0 + inten_off);
> +	writel(BIT(reg_bit), coresight_pmu->base0 + cnten_off);
> +}
> +
> +static void coresight_pmu_disable_counter(struct coresight_pmu *coresight_pmu,
> +					  int idx)
> +{
> +	u32 reg_id, reg_bit, inten_off, cnten_off;
> +
> +	reg_id = CORESIGHT_IDX_TO_SET_CLR_REG_ID(idx);
> +	reg_bit = CORESIGHT_IDX_TO_SET_CLR_REG_BIT(idx);
> +
> +	inten_off = PMINTENCLR + (4 * reg_id);
> +	cnten_off = PMCNTENCLR + (4 * reg_id);
> +
> +	writel(BIT(reg_bit), coresight_pmu->base0 + cnten_off);
> +	writel(BIT(reg_bit), coresight_pmu->base0 + inten_off);
> +}
> +
> +static void coresight_pmu_event_update(struct perf_event *event)
> +{
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 delta, prev, now;
> +
> +	do {
> +		prev = local64_read(&hwc->prev_count);
> +		now = coresight_pmu_read_counter(event);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
> +
> +	delta = (now - prev) & GENMASK_ULL(pmcfgr_size(coresight_pmu), 0);
> +	local64_add(delta, &event->count);
> +}
> +
> +static inline void coresight_pmu_set_event(struct coresight_pmu *coresight_pmu,
> +					   struct hw_perf_event *hwc)
> +{
> +	u32 offset = PMEVTYPER + (4 * hwc->idx);
> +
> +	writel(hwc->config_base, coresight_pmu->base0 + offset);
> +}
> +
> +static inline void
> +coresight_pmu_set_ev_filter(struct coresight_pmu *coresight_pmu,
> +			    struct hw_perf_event *hwc, u32 filter)
> +{
> +	u32 offset = PMEVFILTR + (4 * hwc->idx);
> +
> +	writel(filter, coresight_pmu->base0 + offset);
> +}
> +
> +static inline void
> +coresight_pmu_set_cc_filter(struct coresight_pmu *coresight_pmu, u32 filter)
> +{
> +	u32 offset = PMCCFILTR;
> +
> +	writel(filter, coresight_pmu->base0 + offset);
> +}
> +
> +static void coresight_pmu_start(struct perf_event *event, int pmu_flags)
> +{
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u32 filter;
> +
> +	/* We always reprogram the counter */
> +	if (pmu_flags & PERF_EF_RELOAD)
> +		WARN_ON(!(hwc->state & PERF_HES_UPTODATE));
> +
> +	coresight_pmu_set_event_period(event);
> +
> +	filter = coresight_pmu->impl.ops->event_filter(event);
> +
> +	if (event->hw.extra_reg.idx == coresight_pmu->cc_logical_idx) {
> +		coresight_pmu_set_cc_filter(coresight_pmu, filter);
> +	} else {
> +		coresight_pmu_set_event(coresight_pmu, hwc);
> +		coresight_pmu_set_ev_filter(coresight_pmu, hwc, filter);
> +	}
> +
> +	hwc->state = 0;
> +
> +	coresight_pmu_enable_counter(coresight_pmu, hwc->idx);
> +}
> +
> +static void coresight_pmu_stop(struct perf_event *event, int pmu_flags)
> +{
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return;
> +
> +	coresight_pmu_disable_counter(coresight_pmu, hwc->idx);
> +	coresight_pmu_event_update(event);
> +
> +	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}
> +
> +static inline u32 to_phys_idx(struct coresight_pmu *coresight_pmu, u32 idx)
> +{
> +	return (idx == coresight_pmu->cc_logical_idx) ?
> +		       CORESIGHT_PMU_IDX_CCNTR : idx;
> +}
> +
> +static int coresight_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
> +	struct coresight_pmu_hw_events *hw_events = &coresight_pmu->hw_events;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +
> +	if (WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +					   &coresight_pmu->associated_cpus)))
> +		return -ENOENT;
> +
> +	idx = coresight_pmu_get_event_idx(hw_events, event);
> +	if (idx < 0)
> +		return idx;
> +
> +	hw_events->events[idx] = event;
> +	hwc->idx = to_phys_idx(coresight_pmu, idx);
> +	hwc->extra_reg.idx = idx;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	if (flags & PERF_EF_START)
> +		coresight_pmu_start(event, PERF_EF_RELOAD);
> +
> +	/* Propagate changes to the userspace mapping. */
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +
> +static void coresight_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
> +	struct coresight_pmu_hw_events *hw_events = &coresight_pmu->hw_events;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->extra_reg.idx;
> +
> +	coresight_pmu_stop(event, PERF_EF_UPDATE);
> +
> +	hw_events->events[idx] = NULL;
> +
> +	clear_bit(idx, hw_events->used_ctrs);
> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static void coresight_pmu_read(struct perf_event *event)
> +{
> +	coresight_pmu_event_update(event);
> +}
> +
> +static int coresight_pmu_alloc(struct platform_device *pdev,
> +			       struct coresight_pmu **coresight_pmu)
> +{
> +	struct acpi_apmt_node *apmt_node;
> +	struct device *dev;
> +	struct coresight_pmu *pmu;
> +
> +	dev = &pdev->dev;
> +	apmt_node = *(struct acpi_apmt_node **)dev_get_platdata(dev);
> +	if (!apmt_node) {
> +		dev_err(dev, "failed to get APMT node\n");
> +		return -ENOMEM;
> +	}
> +
> +	pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	*coresight_pmu = pmu;
> +
> +	pmu->dev = dev;
> +	pmu->apmt_node = apmt_node;
> +
> +	platform_set_drvdata(pdev, coresight_pmu);
> +
> +	return 0;
> +}
> +
> +static int coresight_pmu_init_mmio(struct coresight_pmu *coresight_pmu)
> +{
> +	struct device *dev;
> +	struct platform_device *pdev;
> +	struct acpi_apmt_node *apmt_node;
> +
> +	dev = coresight_pmu->dev;
> +	pdev = to_platform_device(dev);
> +	apmt_node = coresight_pmu->apmt_node;
> +
> +	/* Base address for page 0. */
> +	coresight_pmu->base0 = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(coresight_pmu->base0)) {
> +		dev_err(dev, "ioremap failed for page-0 resource\n");
> +		return PTR_ERR(coresight_pmu->base0);
> +	}
> +
> +	/* Base address for page 1 if supported. Otherwise point it to page 0. */
> +	coresight_pmu->base1 = coresight_pmu->base0;
> +	if (CHECK_APMT_FLAG(apmt_node->flags, DUAL_PAGE, SUPP)) {
> +		coresight_pmu->base1 = devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(coresight_pmu->base1)) {
> +			dev_err(dev, "ioremap failed for page-1 resource\n");
> +			return PTR_ERR(coresight_pmu->base1);
> +		}
> +	}
> +
> +	coresight_pmu->pmcfgr = readl(coresight_pmu->base0 + PMCFGR);
> +
> +	coresight_pmu->num_logical_counters = pmcfgr_n(coresight_pmu) + 1;
> +
> +	coresight_pmu->cc_logical_idx = CORESIGHT_PMU_MAX_HW_CNTRS;
> +
> +	if (support_cc(coresight_pmu)) {
> +		/*
> +		 * The last logical counter is mapped to cycle counter if
> +		 * there is a gap between regular and cycle counter. Otherwise,
> +		 * logical and physical have 1-to-1 mapping.
> +		 */
> +		coresight_pmu->cc_logical_idx =
> +			(coresight_pmu->num_logical_counters <=
> +			 CORESIGHT_PMU_IDX_CCNTR) ?
> +				coresight_pmu->num_logical_counters - 1 :
> +				CORESIGHT_PMU_IDX_CCNTR;
> +	}
> +
> +	coresight_pmu->num_set_clr_reg =
> +		DIV_ROUND_UP(coresight_pmu->num_logical_counters,
> +			 CORESIGHT_SET_CLR_REG_COUNTER_NUM);
> +
> +	coresight_pmu->hw_events.events =
> +		devm_kzalloc(dev,
> +			     sizeof(*coresight_pmu->hw_events.events) *
> +				     coresight_pmu->num_logical_counters,
> +			     GFP_KERNEL);
> +
> +	if (!coresight_pmu->hw_events.events)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static inline int
> +coresight_pmu_get_reset_overflow(struct coresight_pmu *coresight_pmu,
> +				 u32 *pmovs)
> +{
> +	int i;
> +	u32 pmovclr_offset = PMOVSCLR;
> +	u32 has_overflowed = 0;
> +
> +	for (i = 0; i < coresight_pmu->num_set_clr_reg; ++i) {
> +		pmovs[i] = readl(coresight_pmu->base1 + pmovclr_offset);
> +		has_overflowed |= pmovs[i];
> +		writel(pmovs[i], coresight_pmu->base1 + pmovclr_offset);
> +		pmovclr_offset += sizeof(u32);
> +	}
> +
> +	return has_overflowed != 0;
> +}
> +
> +static irqreturn_t coresight_pmu_handle_irq(int irq_num, void *dev)
> +{
> +	int idx, has_overflowed;
> +	struct perf_event *event;
> +	struct coresight_pmu *coresight_pmu = dev;
> +	u32 pmovs[CORESIGHT_SET_CLR_REG_MAX_NUM] = { 0 };
> +	bool handled = false;
> +
> +	coresight_pmu_stop_counters(coresight_pmu);
> +
> +	has_overflowed = coresight_pmu_get_reset_overflow(coresight_pmu, pmovs);
> +	if (!has_overflowed)
> +		goto done;
> +
> +	for_each_set_bit(idx, coresight_pmu->hw_events.used_ctrs,
> +			coresight_pmu->num_logical_counters) {
> +		event = coresight_pmu->hw_events.events[idx];
> +
> +		if (!event)
> +			continue;
> +
> +		if (!test_bit(event->hw.idx, (unsigned long *)pmovs))
> +			continue;
> +
> +		coresight_pmu_event_update(event);
> +		coresight_pmu_set_event_period(event);
> +
> +		handled = true;
> +	}
> +
> +done:
> +	coresight_pmu_start_counters(coresight_pmu);
> +	return IRQ_RETVAL(handled);
> +}
> +
> +static int coresight_pmu_request_irq(struct coresight_pmu *coresight_pmu)
> +{
> +	int irq, ret;
> +	struct device *dev;
> +	struct platform_device *pdev;
> +	struct acpi_apmt_node *apmt_node;
> +
> +	dev = coresight_pmu->dev;
> +	pdev = to_platform_device(dev);
> +	apmt_node = coresight_pmu->apmt_node;
> +
> +	/* Skip IRQ request if the PMU does not support overflow interrupt. */
> +	if (apmt_node->ovflw_irq == 0)
> +		return 0;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, coresight_pmu_handle_irq,
> +			       IRQF_NOBALANCING | IRQF_NO_THREAD, dev_name(dev),
> +			       coresight_pmu);
> +	if (ret) {
> +		dev_err(dev, "Could not request IRQ %d\n", irq);
> +		return ret;
> +	}
> +
> +	coresight_pmu->irq = irq;
> +
> +	return 0;
> +}
> +
> +static inline int coresight_pmu_find_cpu_container(int cpu, u32 container_uid)
> +{
> +	u32 acpi_uid;
> +	struct device *cpu_dev = get_cpu_device(cpu);
> +	struct acpi_device *acpi_dev = ACPI_COMPANION(cpu_dev);
> +
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	while (acpi_dev) {
> +		if (!strcmp(acpi_device_hid(acpi_dev),
> +			    ACPI_PROCESSOR_CONTAINER_HID) &&
> +		    !kstrtouint(acpi_device_uid(acpi_dev), 0, &acpi_uid) &&
> +		    acpi_uid == container_uid)
> +			return 0;
> +
> +		acpi_dev = acpi_dev->parent;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int coresight_pmu_get_cpus(struct coresight_pmu *coresight_pmu)
> +{
> +	struct acpi_apmt_node *apmt_node;
> +	int affinity_flag;
> +	int cpu;
> +
> +	apmt_node = coresight_pmu->apmt_node;
> +	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
> +
> +	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
> +		for_each_possible_cpu(cpu) {
> +			if (apmt_node->proc_affinity ==
> +			    get_acpi_id_for_cpu(cpu)) {

minor nit:

There is one another user of this reverse search for CPU by acpi_id.
See get_cpu_for_acpi_id() in arch/arm64/kernel/acpi_numa.c.

May be we should make that a generic helper and move it to common code.

> +				cpumask_set_cpu(
> +					cpu, &coresight_pmu->associated_cpus);
> +				break;
> +			}
> +		}
> +	} else {
> +		for_each_possible_cpu(cpu) {
> +			if (coresight_pmu_find_cpu_container(
> +				    cpu, apmt_node->proc_affinity))
> +				continue;
> +
> +			cpumask_set_cpu(cpu, &coresight_pmu->associated_cpus);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int coresight_pmu_register_pmu(struct coresight_pmu *coresight_pmu)
> +{
> +	int ret;
> +	struct attribute_group **attr_groups;
> +
> +	attr_groups = coresight_pmu_alloc_attr_group(coresight_pmu);
> +	if (!attr_groups) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	ret = cpuhp_state_add_instance(coresight_pmu_cpuhp_state,
> +				       &coresight_pmu->cpuhp_node);
> +	if (ret)
> +		return ret;
> +
> +	coresight_pmu->pmu = (struct pmu){
> +		.task_ctx_nr	= perf_invalid_context,
> +		.module		= THIS_MODULE,
> +		.pmu_enable	= coresight_pmu_enable,
> +		.pmu_disable	= coresight_pmu_disable,
> +		.event_init	= coresight_pmu_event_init,
> +		.add		= coresight_pmu_add,
> +		.del		= coresight_pmu_del,
> +		.start		= coresight_pmu_start,
> +		.stop		= coresight_pmu_stop,
> +		.read		= coresight_pmu_read,
> +		.attr_groups	= (const struct attribute_group **)attr_groups,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +	};
> +
> +	/* Hardware counter init */
> +	coresight_pmu_stop_counters(coresight_pmu);
> +	coresight_pmu_reset_counters(coresight_pmu);
> +
> +	ret = perf_pmu_register(&coresight_pmu->pmu, coresight_pmu->name, -1);
> +	if (ret) {
> +		cpuhp_state_remove_instance(coresight_pmu_cpuhp_state,
> +					    &coresight_pmu->cpuhp_node);
> +	}
> +
> +	return ret;
> +}
> +
> +static int coresight_pmu_device_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct coresight_pmu *coresight_pmu;
> +
> +	ret = coresight_pmu_alloc(pdev, &coresight_pmu);
> +	if (ret)
> +		return ret;
> +
> +	ret = coresight_pmu_init_mmio(coresight_pmu);
> +	if (ret)
> +		return ret;
> +
> +	ret = coresight_pmu_request_irq(coresight_pmu);
> +	if (ret)
> +		return ret;
> +
> +	ret = coresight_pmu_get_cpus(coresight_pmu);
> +	if (ret)
> +		return ret;
> +
> +	ret = coresight_pmu_register_pmu(coresight_pmu);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int coresight_pmu_device_remove(struct platform_device *pdev)
> +{
> +	struct coresight_pmu *coresight_pmu = platform_get_drvdata(pdev);
> +
> +	perf_pmu_unregister(&coresight_pmu->pmu);
> +	cpuhp_state_remove_instance(coresight_pmu_cpuhp_state,
> +				    &coresight_pmu->cpuhp_node);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver coresight_pmu_driver = {
> +	.driver = {
> +			.name = "arm-system-pmu",
> +			.suppress_bind_attrs = true,
> +		},
> +	.probe = coresight_pmu_device_probe,
> +	.remove = coresight_pmu_device_remove,
> +};
> +
> +static void coresight_pmu_set_active_cpu(int cpu,
> +					 struct coresight_pmu *coresight_pmu)
> +{
> +	cpumask_set_cpu(cpu, &coresight_pmu->active_cpu);
> +	WARN_ON(irq_set_affinity(coresight_pmu->irq,
> +				 &coresight_pmu->active_cpu));
> +}
> +
> +static int coresight_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct coresight_pmu *coresight_pmu =
> +		hlist_entry_safe(node, struct coresight_pmu, cpuhp_node);
> +
> +	if (!cpumask_test_cpu(cpu, &coresight_pmu->associated_cpus))
> +		return 0;
> +
> +	/* If the PMU is already managed, there is nothing to do */
> +	if (!cpumask_empty(&coresight_pmu->active_cpu))
> +		return 0;
> +
> +	/* Use this CPU for event counting */
> +	coresight_pmu_set_active_cpu(cpu, coresight_pmu);
> +
> +	return 0;
> +}
> +
> +static int coresight_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
> +{
> +	int dst;
> +	struct cpumask online_supported;
> +
> +	struct coresight_pmu *coresight_pmu =
> +		hlist_entry_safe(node, struct coresight_pmu, cpuhp_node);
> +
> +	/* Nothing to do if this CPU doesn't own the PMU */
> +	if (!cpumask_test_and_clear_cpu(cpu, &coresight_pmu->active_cpu))
> +		return 0;
> +
> +	/* Choose a new CPU to migrate ownership of the PMU to */
> +	cpumask_and(&online_supported, &coresight_pmu->associated_cpus,
> +		    cpu_online_mask);
> +	dst = cpumask_any_but(&online_supported, cpu);
> +	if (dst >= nr_cpu_ids)
> +		return 0;
> +
> +	/* Use this CPU for event counting */
> +	perf_pmu_migrate_context(&coresight_pmu->pmu, cpu, dst);
> +	coresight_pmu_set_active_cpu(dst, coresight_pmu);
> +
> +	return 0;
> +}
> +
> +static int __init coresight_pmu_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, PMUNAME,
> +				      coresight_pmu_cpu_online,
> +				      coresight_pmu_cpu_teardown);
> +	if (ret < 0)
> +		return ret;
> +	coresight_pmu_cpuhp_state = ret;
> +	return platform_driver_register(&coresight_pmu_driver);
> +}
> +
> +static void __exit coresight_pmu_exit(void)
> +{
> +	platform_driver_unregister(&coresight_pmu_driver);
> +	cpuhp_remove_multi_state(coresight_pmu_cpuhp_state);
> +}
> +
> +module_init(coresight_pmu_init);
> +module_exit(coresight_pmu_exit);
> diff --git a/drivers/perf/coresight_pmu/arm_coresight_pmu.h b/drivers/perf/coresight_pmu/arm_coresight_pmu.h
> new file mode 100644
> index 000000000000..88fb4cd3dafa
> --- /dev/null
> +++ b/drivers/perf/coresight_pmu/arm_coresight_pmu.h
> @@ -0,0 +1,177 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * ARM CoreSight PMU driver.
> + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> + *
> + */
> +
> +#ifndef __ARM_CORESIGHT_PMU_H__
> +#define __ARM_CORESIGHT_PMU_H__
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#define to_coresight_pmu(p) (container_of(p, struct coresight_pmu, pmu))
> +
> +#define CORESIGHT_EXT_ATTR(_name, _func, _config)			\
> +	(&((struct dev_ext_attribute[]){				\
> +		{							\
> +			.attr = __ATTR(_name, 0444, _func, NULL),	\
> +			.var = (void *)_config				\
> +		}							\
> +	})[0].attr.attr)
> +
> +#define CORESIGHT_FORMAT_ATTR(_name, _config)				\
> +	CORESIGHT_EXT_ATTR(_name, coresight_pmu_sysfs_format_show,	\
> +			   (char *)_config)
> +
> +#define CORESIGHT_EVENT_ATTR(_name, _config)				\
> +	PMU_EVENT_ATTR_ID(_name, coresight_pmu_sysfs_event_show, _config)
> +
> +
> +/* Default event id mask */
> +#define CORESIGHT_EVENT_MASK				0xFFFFFFFFULL

Please use GENMASK_ULL(), everywhere.

Thanks
Suzuki
