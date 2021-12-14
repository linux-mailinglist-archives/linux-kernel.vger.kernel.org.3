Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF17474267
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhLNMWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhLNMWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:22:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073D5C061574;
        Tue, 14 Dec 2021 04:22:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B96DB818C7;
        Tue, 14 Dec 2021 12:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7106C34605;
        Tue, 14 Dec 2021 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639484569;
        bh=jtSbLpLidICr6sr83NY1+a4EwUXa2Kj6rtq92VlkTAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEz1SLgIpf5iqugJe8tBFcegn3WW9LXHv0Hbnnmq7yICD+EA/brh6IG3gyfYOGck+
         i12rx6FtZcFzeAoAsX7PnJX9ItX2OjHO93xcuWFGY7AowfFpEOJCzqMV6mjqWc8NsM
         YZR6QALZ5vm9MqxdOJoQnSLJuIIrY0U/oUnn7iz17JJM2Mc4681Ab6F32rwvnI2nDi
         l/5dSLvf7VaS13uqezbV/XomBWgRRp9Aa8IQD/X+olewXpuIH4R3maIJnBXK3eSLaN
         5o7EhrluJ9y4pNqsnDStrSZ3QWjcKt9W2KTdmNL44k0KlRuOBPUAoi8BRYaLRTmXWv
         TjNKVUgso5pWg==
Date:   Tue, 14 Dec 2021 12:22:43 +0000
From:   Will Deacon <will@kernel.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, bbhushan2@marvell.com,
        sgoutham@marvell.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] drivers: perf: Add LLC-TAD perf counter support
Message-ID: <20211214122242.GA14247@willie-the-truck>
References: <20211115043506.6679-1-bbudiredla@marvell.com>
 <20211115043506.6679-2-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115043506.6679-2-bbudiredla@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:05:05AM +0530, Bhaskara Budiredla wrote:
> This driver adds support for Last-level cache tag-and-data unit
> (LLC-TAD) PMU that is featured in some of the Marvell's CN10K
> infrastructure silicons.
> 
> The LLC is divided into 2N slices distributed across N Mesh tiles
> in a single-socket configuration. The driver always configures the
> same counter for all of the TADs. The user would end up effectively
> reserving one of eight counters in every TAD to look across all TADs.
> The occurrences of events are aggregated and presented to the user
> at the end of an application run. The driver does not provide a way
> for the user to partition TADs so that different TADs are used for
> different applications.
> 
> The event counters are zeroed to start event counting to avoid any
> rollover issues. TAD perf counters are 64-bit, so it's not currently
> possible to overflow event counters at current mesh and core
> frequencies.
> 
> To measure tad pmu events use perf tool stat command. For instance:
> 
> perf stat -e tad_dat_msh_in_dss,tad_req_msh_out_any <application>
> perf stat -e tad_alloc_any,tad_hit_any,tad_tag_rd <application>
> 
> Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
> ---
>  drivers/perf/Kconfig                 |   7 +
>  drivers/perf/Makefile                |   1 +
>  drivers/perf/marvell_cn10k_tad_pmu.c | 429 +++++++++++++++++++++++++++
>  3 files changed, 437 insertions(+)
>  create mode 100644 drivers/perf/marvell_cn10k_tad_pmu.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 77522e5efe11..53b8fa554343 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -137,6 +137,13 @@ config ARM_DMC620_PMU
>  	  Support for PMU events monitoring on the ARM DMC-620 memory
>  	  controller.
>  
> +config MARVELL_CN10K_TAD_PMU
> +	tristate "Marvell CN10K LLC-TAD PMU"
> +	depends on ARM64 || (COMPILE_TEST && 64BIT)
> +	help
> +	  Provides support for Last-Level cache Tag-and-data Units (LLC-TAD)
> +	  performance monitors on CN10K family silicons.
> +
>  source "drivers/perf/hisilicon/Kconfig"
>  
>  endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 5260b116c7da..2db5418d5b0a 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>  obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
>  obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
> +obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
> new file mode 100644
> index 000000000000..250dd4c52d70
> --- /dev/null
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> @@ -0,0 +1,429 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell CN10K LLC-TAD perf driver
> + *
> + * Copyright (C) 2021 Marvell
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "tad_pmu: " fmt
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +
> +#define TAD_PFC_OFFSET		0x0
> +#define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
> +#define TAD_PRF_OFFSET		0x100
> +#define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
> +#define TAD_PRF_CNTSEL_MASK	0xFF
> +#define TAD_MAX_COUNTERS	8
> +
> +#define to_tad_pmu(p) (container_of(p, struct tad_pmu, pmu))
> +
> +struct tad_region {
> +	void __iomem	*base;
> +};
> +
> +struct tad_pmu {
> +	struct pmu pmu;
> +	struct tad_region *regions;
> +	u32 region_cnt;
> +	unsigned int cpu;
> +	struct hlist_node node;
> +	struct perf_event *events[TAD_MAX_COUNTERS];
> +	DECLARE_BITMAP(counters_map, TAD_MAX_COUNTERS);
> +};
> +
> +static int tad_pmu_cpuhp_state;
> +
> +static void tad_pmu_event_counter_read(struct perf_event *event)
> +{
> +	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u32 counter_idx = hwc->idx;
> +	u64 prev, new;
> +	int i;
> +
> +	do {
> +		prev = local64_read(&hwc->prev_count);
> +		for (i = 0, new = 0; i < tad_pmu->region_cnt; i++)
> +			new += readq(tad_pmu->regions[i].base +
> +				     TAD_PFC(counter_idx));
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, new) != prev);

I plan to queue this as-is, but I did remark on the previous version that
this loop is needlessly expensive. Why are you not using readq_relaxed() and
why are you doing that _inside_ the cmpxchg() loop?

Will
