Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F76D52CEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiESIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiESIwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:52:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3C3562BC1;
        Thu, 19 May 2022 01:52:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55F3215A1;
        Thu, 19 May 2022 01:52:07 -0700 (PDT)
Received: from [10.57.35.249] (unknown [10.57.35.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E14CF3F73D;
        Thu, 19 May 2022 01:52:04 -0700 (PDT)
Message-ID: <67628f62-5081-ba64-cdf6-7410928ba2c2@arm.com>
Date:   Thu, 19 May 2022 09:52:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] perf: coresight_pmu: Add support for ARM CoreSight
 PMU driver
To:     Besar Wicaksono <bwicaksono@nvidia.com>, robin.murphy@arm.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sudeep.holla@arm.com,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220515163044.50055-1-bwicaksono@nvidia.com>
 <20220515163044.50055-2-bwicaksono@nvidia.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220515163044.50055-2-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2022 17:30, Besar Wicaksono wrote:
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
>   .../perf/coresight_pmu/arm_coresight_pmu.c    | 1267 +++++++++++++++++
>   .../perf/coresight_pmu/arm_coresight_pmu.h    |  171 +++
>   7 files changed, 1459 insertions(+)
>   create mode 100644 drivers/perf/coresight_pmu/Kconfig
>   create mode 100644 drivers/perf/coresight_pmu/Makefile
>   create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.c
>   create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.h
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2ca8b1b336d2..8f2120182b25 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1196,6 +1196,7 @@ CONFIG_PHY_UNIPHIER_USB3=y
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
> index 000000000000..36ac77ab85cd
> --- /dev/null
> +++ b/drivers/perf/coresight_pmu/arm_coresight_pmu.c
> @@ -0,0 +1,1267 @@
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
> + * CoreSight PMU devices are named as arm_coresight_pmu<node_id> where <node_id>
> + * is APMT node id. The description of the device, like the identifier,

Please see my comment below, near coresight_pmu_alloc().

> + * supported events, and formats can be found in sysfs
> + * /sys/bus/event_source/devices/arm_coresight_pmu<node_id>
> + *
> + * The user should refer to the vendor technical documentation to get details
> + * about the supported events.
> + *
> + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> + *
> + */

...

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
> +	pmu->name =
> +		devm_kasprintf(dev, GFP_KERNEL, PMUNAME "%u", apmt_node->id);

Could we not name this "<vendor>_<ipname>_pmu" ? Or even let the 
"implementor" name it ? After all, for a *normal user*, all it matters
is how to find a PMU device for my xyz IP.
The coresight_pmu architecture is there to make the life easier for the
software driver and the hardware implementation. We don't need to 
necessarily pass on this abstraction to an end-user and learn how to 
figure out which "arm_*_pmu<N>" is my PCIe, or SMMU or xyz instance.

Suzuki
