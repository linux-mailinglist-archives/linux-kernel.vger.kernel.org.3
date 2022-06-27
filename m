Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB2855CF25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiF0Kgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiF0Kgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:36:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A333263CE;
        Mon, 27 Jun 2022 03:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E4F06131C;
        Mon, 27 Jun 2022 10:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9970C341C7;
        Mon, 27 Jun 2022 10:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656326209;
        bh=jw/6dXyDZLTUJ21l+deT08KuMf4GaaSvLsod7UKrR6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gej+QJ29I1aVQ0in5+h6CTyM1AJwsSd1wjIVglnNqBiXcxZ1nxFRfjfSzE2t4ZIHt
         373xNwYELGb4OqWttNKElwmhIE0woH7PiFzyBZCLQZ0JCKFhagV6N6tAf16ljaKBgV
         vaTFbc3hPE0HIBqLzyEF8K/WEIw3p9NnlSly4c4Uwyk3Blvq0+cfRUQagSU9osvLDm
         /kXP+X3UeQxCR10BcCTpnGcblRk3YcL8rSBjfqMt/yyrLSKqjXdsN40w+4AVfhWhMc
         2qgr0z+ii1J+ZwbDMwbdLHhR4531a55DNVrC/OIEtQXVmruI5k8HToBnAg/QW+Coef
         D/xArNnIHnMng==
Date:   Mon, 27 Jun 2022 11:36:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     suzuki.poulose@arm.com, robin.murphy@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sudeep.holla@arm.com,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
Subject: Re: [RESEND PATCH v3 1/2] perf: coresight_pmu: Add support for ARM
 CoreSight PMU driver
Message-ID: <20220627103642.GB22095@willie-the-truck>
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
 <20220621055035.31766-2-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621055035.31766-2-bwicaksono@nvidia.com>
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

On Tue, Jun 21, 2022 at 12:50:34AM -0500, Besar Wicaksono wrote:
> Add support for ARM CoreSight PMU driver framework and interfaces.
> The driver provides generic implementation to operate uncore PMU based
> on ARM CoreSight PMU architecture. The driver also provides interface
> to get vendor/implementation specific information, for example event
> attributes and formating.
> 
> The specification used in this implementation can be found below:
>  * ACPI Arm Performance Monitoring Unit table:
>         https://developer.arm.com/documentation/den0117/latest
>  * ARM Coresight PMU architecture:
>         https://developer.arm.com/documentation/ihi0091/latest
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/perf/Kconfig                          |    2 +
>  drivers/perf/Makefile                         |    1 +
>  drivers/perf/coresight_pmu/Kconfig            |   11 +
>  drivers/perf/coresight_pmu/Makefile           |    6 +
>  .../perf/coresight_pmu/arm_coresight_pmu.c    | 1312 +++++++++++++++++
>  .../perf/coresight_pmu/arm_coresight_pmu.h    |  177 +++
>  7 files changed, 1510 insertions(+)
>  create mode 100644 drivers/perf/coresight_pmu/Kconfig
>  create mode 100644 drivers/perf/coresight_pmu/Makefile
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.c
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.h
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d1105343bc2..22184f8883da 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1212,6 +1212,7 @@ CONFIG_PHY_UNIPHIER_USB3=y
>  CONFIG_PHY_TEGRA_XUSB=y
>  CONFIG_PHY_AM654_SERDES=m
>  CONFIG_PHY_J721E_WIZ=m
> +CONFIG_ARM_CORESIGHT_PMU=y
>  CONFIG_ARM_SMMU_V3_PMU=m
>  CONFIG_FSL_IMX8_DDR_PMU=m
>  CONFIG_QCOM_L2_PMU=y
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 1e2d69453771..c4e7cd5b4162 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -192,4 +192,6 @@ config MARVELL_CN10K_DDR_PMU
>  	  Enable perf support for Marvell DDR Performance monitoring
>  	  event on CN10K platform.
>  
> +source "drivers/perf/coresight_pmu/Kconfig"
> +
>  endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 57a279c61df5..4126a04b5583 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
>  obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
>  obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
>  obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
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

ACPI_APMT doesn't exist in my tree. What's missing here?

Will
