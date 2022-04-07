Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068E94F8031
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiDGNNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343687AbiDGNMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:12:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468EE37019
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:10:47 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KZ1sz461fz68029;
        Thu,  7 Apr 2022 21:08:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 7 Apr 2022 15:10:45 +0200
Received: from [10.47.80.129] (10.47.80.129) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 14:10:44 +0100
Message-ID: <dff7fcdf-2582-40e3-2740-eddbdaae71c5@huawei.com>
Date:   Thu, 7 Apr 2022 14:10:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 2/2] drivers/perf: hisi: Add Support for CPA PMU
To:     Qi Liu <liuqi115@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
References: <20220407124617.54521-1-liuqi115@huawei.com>
 <20220407124617.54521-3-liuqi115@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220407124617.54521-3-liuqi115@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.129]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 13:46, Qi Liu wrote:
> On HiSilicon Hip09 platform, there is a CPA (Coherency Protocol Agent) on
> each SICL (Super I/O Cluster) which implements packet format translation,
> route parsing and traffic statistics.
> 
> CPA PMU has 8 PMU counters and interrupt is supported to handle counter
> overflow. Let's support its driver under the framework of HiSilicon PMU
> driver.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>

This looks ok, but I still have a few nitpicks. Regardless,

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   drivers/perf/hisilicon/Makefile              |   2 +-
>   drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c | 401 +++++++++++++++++++
>   include/linux/cpuhotplug.h                   |   1 +
>   3 files changed, 403 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
> 
> diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
> index 506ed39e3266..6be83517acaa 100644
> --- a/drivers/perf/hisilicon/Makefile
> +++ b/drivers/perf/hisilicon/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o hisi_uncore_l3c_pmu.o \
>   			  hisi_uncore_hha_pmu.o hisi_uncore_ddrc_pmu.o hisi_uncore_sllc_pmu.o \
> -			  hisi_uncore_pa_pmu.o
> +			  hisi_uncore_pa_pmu.o hisi_uncore_cpa_pmu.o
>   
>   obj-$(CONFIG_HISI_PCIE_PMU) += hisi_pcie_pmu.o
> diff --git a/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
> new file mode 100644
> index 000000000000..d6b8e4037076
> --- /dev/null
> +++ b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * HiSilicon SoC CPA(Coherency Protocol Agent) hardware event counters support
> + *
> + * Copyright (C) 2022 HiSilicon Limited
> + * Author: Qi Liu <liuqi115@huawei.com>
> + *
> + * This code is based on the uncore PMUs like arm-cci and arm-ccn.
> + */
> +
> +#define pr_fmt(fmt) "cpa pmu: " fmt

comment: you could add "hisi" but maybe it becomes too long

> +#include <linux/acpi.h>
> +#include <linux/bug.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/list.h>
> +#include <linux/smp.h>
> +
> +#include "hisi_uncore_pmu.h"
> +
> +/* CPA register definition */
> +#define CPA_PERF_CTRL		0x1c00
> +#define CPA_EVENT_CTRL		0x1c04
> +#define CPA_INT_MASK		0x1c70
> +#define CPA_INT_STATUS		0x1c78
> +#define CPA_INT_CLEAR		0x1c7c
> +#define CPA_EVENT_TYPE0		0x1c80
> +#define CPA_VERSION		0x1cf0
> +#define CPA_CNT0_LOWER		0x1d00
> +#define CPA_CFG_REG		0x0534
> +
> +/* CPA operation command */
> +#define CPA_PERF_CTRL_EN	BIT_ULL(0)
> +#define CPA_EVTYPE_MASK		0xffUL
> +#define CPA_PM_CTRL		BIT_ULL(9)
> +
> +/* CPA has 8-counters */
> +#define CPA_NR_COUNTERS		0x8
> +#define CPA_COUNTER_BITS	64
> +#define CPA_NR_EVENTS		0xff
> +#define CPA_REG_OFFSET		0x8
> +
> +static u32 hisi_cpa_pmu_get_counter_offset(int idx)
> +{
> +	return (CPA_CNT0_LOWER + idx * CPA_REG_OFFSET);
> +}
> +
> +static u64 hisi_cpa_pmu_read_counter(struct hisi_pmu *cpa_pmu,
> +				     struct hw_perf_event *hwc)
> +{
> +	return readq(cpa_pmu->base + hisi_cpa_pmu_get_counter_offset(hwc->idx));
> +}
> +
> +static void hisi_cpa_pmu_write_counter(struct hisi_pmu *cpa_pmu,
> +				       struct hw_perf_event *hwc, u64 val)
> +{
> +	writeq(val, cpa_pmu->base + hisi_cpa_pmu_get_counter_offset(hwc->idx));
> +}
> +
> +static void hisi_cpa_pmu_write_evtype(struct hisi_pmu *cpa_pmu, int idx, u32 type)
> +{
> +	u32 reg, reg_idx, shift, val;
> +
> +	/*
> +	 * Select the appropriate event select register(CPA_EVENT_TYPE0/1).
> +	 * There are 2 event select registers for the 8 hardware counters.
> +	 * Event code is 8-bits and for the former 4 hardware counters,
> +	 * CPA_EVENT_TYPE0 is chosen. For the latter 4 hardware counters,
> +	 * CPA_EVENT_TYPE1 is chosen.
> +	 */
> +	reg = CPA_EVENT_TYPE0 + (idx / 4) * 4;
> +	reg_idx = idx % 4;
> +	shift = CPA_REG_OFFSET * reg_idx;
> +
> +	/* Write event code to CPA_EVENT_TYPEx Register */
> +	val = readl(cpa_pmu->base + reg);
> +	val &= ~(CPA_EVTYPE_MASK << shift);
> +	val |= type << shift;
> +	writel(val, cpa_pmu->base + reg);
> +}
> +
> +static void hisi_cpa_pmu_start_counters(struct hisi_pmu *cpa_pmu)
> +{
> +	u32 val;
> +
> +	val = readl(cpa_pmu->base + CPA_PERF_CTRL);
> +	val |= CPA_PERF_CTRL_EN;
> +	writel(val, cpa_pmu->base + CPA_PERF_CTRL);
> +}
> +
> +static void hisi_cpa_pmu_stop_counters(struct hisi_pmu *cpa_pmu)
> +{
> +	u32 val;
> +
> +	val = readl(cpa_pmu->base + CPA_PERF_CTRL);
> +	val &= ~(CPA_PERF_CTRL_EN);
> +	writel(val, cpa_pmu->base + CPA_PERF_CTRL);
> +}
> +
> +static void hisi_cpa_pmu_disable_pm(struct hisi_pmu *cpa_pmu)
> +{
> +	u32 val;
> +
> +	val = readl(cpa_pmu->base + CPA_CFG_REG);
> +	val |= CPA_PM_CTRL;
> +	writel(val, cpa_pmu->base + CPA_CFG_REG);
> +}
> +
> +static void hisi_cpa_pmu_enable_pm(struct hisi_pmu *cpa_pmu)
> +{
> +	u32 val;
> +
> +	val = readl(cpa_pmu->base + CPA_CFG_REG);
> +	val &= ~(CPA_PM_CTRL);
> +	writel(val, cpa_pmu->base + CPA_CFG_REG);
> +}
> +
> +static void hisi_cpa_pmu_enable_counter(struct hisi_pmu *cpa_pmu, struct hw_perf_event *hwc)
> +{
> +	u32 val;
> +
> +	/* Enable counter index in CPA_EVENT_CTRL register */
> +	val = readl(cpa_pmu->base + CPA_EVENT_CTRL);
> +	val |= 1 << hwc->idx;
> +	writel(val, cpa_pmu->base + CPA_EVENT_CTRL);
> +}
> +
> +static void hisi_cpa_pmu_disable_counter(struct hisi_pmu *cpa_pmu, struct hw_perf_event *hwc)
> +{
> +	u32 val;
> +
> +	/* Clear counter index in CPA_EVENT_CTRL register */
> +	val = readl(cpa_pmu->base + CPA_EVENT_CTRL);
> +	val &= ~(1UL << hwc->idx);
> +	writel(val, cpa_pmu->base + CPA_EVENT_CTRL);
> +}
> +
> +static void hisi_cpa_pmu_enable_counter_int(struct hisi_pmu *cpa_pmu, struct hw_perf_event *hwc)
> +{
> +	u32 val;
> +
> +	/* Write 0 to enable interrupt */
> +	val = readl(cpa_pmu->base + CPA_INT_MASK);
> +	val &= ~(1UL << hwc->idx);
> +	writel(val, cpa_pmu->base + CPA_INT_MASK);
> +}
> +
> +static void hisi_cpa_pmu_disable_counter_int(struct hisi_pmu *cpa_pmu, struct hw_perf_event *hwc)
> +{
> +	u32 val;
> +
> +	/* Write 1 to mask interrupt */
> +	val = readl(cpa_pmu->base + CPA_INT_MASK);
> +	val |= 1 << hwc->idx;
> +	writel(val, cpa_pmu->base + CPA_INT_MASK);
> +}
> +
> +static u32 hisi_cpa_pmu_get_int_status(struct hisi_pmu *cpa_pmu)
> +{
> +	return readl(cpa_pmu->base + CPA_INT_STATUS);
> +}
> +
> +static void hisi_cpa_pmu_clear_int_status(struct hisi_pmu *cpa_pmu, int idx)
> +{
> +	writel(1 << idx, cpa_pmu->base + CPA_INT_CLEAR);
> +}
> +
> +static const struct acpi_device_id hisi_cpa_pmu_acpi_match[] = {
> +	{ "HISI0281", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, hisi_cpa_pmu_acpi_match);
> +
> +static int hisi_cpa_pmu_init_data(struct platform_device *pdev,
> +				  struct hisi_pmu *cpa_pmu)
> +{
> +	if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
> +				     &cpa_pmu->sicl_id)) {
> +		dev_err(&pdev->dev, "Can not read sicl-id\n");
> +		return -EINVAL;
> +	}
> +
> +	if (device_property_read_u32(&pdev->dev, "hisilicon,idx-id",
> +				     &cpa_pmu->index_id)) {
> +		dev_err(&pdev->dev, "Cannot read idx-id\n");
> +		return -EINVAL;
> +	}
> +
> +	cpa_pmu->ccl_id = -1;
> +	cpa_pmu->sccl_id = -1;
> +	cpa_pmu->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(cpa_pmu->base))
> +		return PTR_ERR(cpa_pmu->base);
> +
> +	cpa_pmu->identifier = readl(cpa_pmu->base + CPA_VERSION);
> +
> +	return 0;
> +}
> +
> +static struct attribute *hisi_cpa_pmu_format_attr[] = {
> +	HISI_PMU_FORMAT_ATTR(event, "config:0-15"),
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_cpa_pmu_format_group = {
> +	.name = "format",
> +	.attrs = hisi_cpa_pmu_format_attr,
> +};
> +
> +static struct attribute *hisi_cpa_pmu_events_attr[] = {
> +	HISI_PMU_EVENT_ATTR(cpa_cycles,		0x00),
> +	HISI_PMU_EVENT_ATTR(cpa_p1_wr_dat,	0x61),
> +	HISI_PMU_EVENT_ATTR(cpa_p1_rd_dat,	0x62),
> +	HISI_PMU_EVENT_ATTR(cpa_p0_wr_dat,	0xE1),
> +	HISI_PMU_EVENT_ATTR(cpa_p0_rd_dat,	0xE2),
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_cpa_pmu_events_group = {
> +	.name = "events",
> +	.attrs = hisi_cpa_pmu_events_attr,
> +};
> +
> +static DEVICE_ATTR(cpumask, 0444, hisi_cpumask_sysfs_show, NULL);
> +
> +static struct attribute *hisi_cpa_pmu_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_cpa_pmu_cpumask_attr_group = {
> +	.attrs = hisi_cpa_pmu_cpumask_attrs,
> +};
> +
> +static struct device_attribute hisi_cpa_pmu_identifier_attr =
> +	__ATTR(identifier, 0444, hisi_uncore_pmu_identifier_attr_show, NULL);
> +
> +static struct attribute *hisi_cpa_pmu_identifier_attrs[] = {
> +	&hisi_cpa_pmu_identifier_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_cpa_pmu_identifier_group = {
> +	.attrs = hisi_cpa_pmu_identifier_attrs,
> +};
> +
> +static const struct attribute_group *hisi_cpa_pmu_attr_groups[] = {
> +	&hisi_cpa_pmu_format_group,
> +	&hisi_cpa_pmu_events_group,
> +	&hisi_cpa_pmu_cpumask_attr_group,
> +	&hisi_cpa_pmu_identifier_group,
> +	NULL
> +};
> +
> +static const struct hisi_uncore_ops hisi_uncore_cpa_pmu_ops = {
> +	.write_evtype           = hisi_cpa_pmu_write_evtype,
> +	.get_event_idx		= hisi_uncore_pmu_get_event_idx,
> +	.start_counters		= hisi_cpa_pmu_start_counters,
> +	.stop_counters		= hisi_cpa_pmu_stop_counters,
> +	.enable_counter		= hisi_cpa_pmu_enable_counter,
> +	.disable_counter	= hisi_cpa_pmu_disable_counter,
> +	.enable_counter_int	= hisi_cpa_pmu_enable_counter_int,
> +	.disable_counter_int	= hisi_cpa_pmu_disable_counter_int,
> +	.write_counter		= hisi_cpa_pmu_write_counter,
> +	.read_counter		= hisi_cpa_pmu_read_counter,
> +	.get_int_status		= hisi_cpa_pmu_get_int_status,
> +	.clear_int_status	= hisi_cpa_pmu_clear_int_status,
> +};
> +
> +static int hisi_cpa_pmu_dev_probe(struct platform_device *pdev,
> +				  struct hisi_pmu *cpa_pmu)
> +{
> +	int ret;
> +
> +	ret = hisi_cpa_pmu_init_data(pdev, cpa_pmu);
> +	if (ret)
> +		return ret;
> +
> +	ret = hisi_uncore_pmu_init_irq(cpa_pmu, pdev);
> +	if (ret)
> +		return ret;
> +
> +	cpa_pmu->counter_bits = CPA_COUNTER_BITS;
> +	cpa_pmu->check_event = CPA_NR_EVENTS;
> +	cpa_pmu->pmu_events.attr_groups = hisi_cpa_pmu_attr_groups;
> +	cpa_pmu->ops = &hisi_uncore_cpa_pmu_ops;
> +	cpa_pmu->num_counters = CPA_NR_COUNTERS;
> +	cpa_pmu->dev = &pdev->dev;
> +	cpa_pmu->on_cpu = -1;
> +
> +	return 0;
> +}
> +
> +static int hisi_cpa_pmu_probe(struct platform_device *pdev)
> +{
> +	struct hisi_pmu *cpa_pmu;
> +	char *name;
> +	int ret;
> +
> +	cpa_pmu = devm_kzalloc(&pdev->dev, sizeof(*cpa_pmu), GFP_KERNEL);
> +	if (!cpa_pmu)
> +		return -ENOMEM;
> +
> +	ret = hisi_cpa_pmu_dev_probe(pdev, cpa_pmu);
> +	if (ret)
> +		return ret;
> +
> +	/* Power Management should be disabled before using CPA PMU. */
> +	hisi_cpa_pmu_disable_pm(cpa_pmu);
> +

nit: we call hisi_cpa_pmu_enable_pm() in the remove function to restore 
to the same state as we had before loading the driver. However we don't 
do the same for a failed probe later.

> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
> +				       &cpa_pmu->node);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
> +		return ret;
> +	}
> +
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sicl%d_cpa%u", cpa_pmu->sicl_id,
> +			      cpa_pmu->index_id);

nit: should check non-NULL here

> +
> +	cpa_pmu->pmu = (struct pmu) {
> +		.name		= name,
> +		.module		= THIS_MODULE,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.event_init	= hisi_uncore_pmu_event_init,
> +		.pmu_enable	= hisi_uncore_pmu_enable,
> +		.pmu_disable	= hisi_uncore_pmu_disable,
> +		.add		= hisi_uncore_pmu_add,
> +		.del		= hisi_uncore_pmu_del,
> +		.start		= hisi_uncore_pmu_start,
> +		.stop		= hisi_uncore_pmu_stop,
> +		.read		= hisi_uncore_pmu_read,
> +		.attr_groups	= cpa_pmu->pmu_events.attr_groups,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +	};
> +
> +	ret = perf_pmu_register(&cpa_pmu->pmu, name, -1);
> +	if (ret) {
> +		dev_err(cpa_pmu->dev, "PMU register failed\n");
> +		cpuhp_state_remove_instance_nocalls(
> +			CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE, &cpa_pmu->node);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, cpa_pmu);
> +	return ret;
> +}
> +
> +static int hisi_cpa_pmu_remove(struct platform_device *pdev)
> +{
> +	struct hisi_pmu *cpa_pmu = platform_get_drvdata(pdev);
> +
> +	perf_pmu_unregister(&cpa_pmu->pmu);
> +	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
> +					    &cpa_pmu->node);
> +	hisi_cpa_pmu_enable_pm(cpa_pmu);
> +	return 0;
> +}
> +
> +static struct platform_driver hisi_cpa_pmu_driver = {
> +	.driver = {
> +		.name = "hisi_cpa_pmu",
> +		.acpi_match_table = ACPI_PTR(hisi_cpa_pmu_acpi_match),
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = hisi_cpa_pmu_probe,
> +	.remove = hisi_cpa_pmu_remove,
> +};
> +
> +static int __init hisi_cpa_pmu_module_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
> +				      "AP_PERF_ARM_HISI_CPA_ONLINE",
> +				      hisi_uncore_pmu_online_cpu,
> +				      hisi_uncore_pmu_offline_cpu);
> +	if (ret) {
> +		pr_err("setup hotplug failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&hisi_cpa_pmu_driver);
> +	if (ret)
> +		cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE);
> +
> +	return ret;
> +}
> +module_init(hisi_cpa_pmu_module_init);
> +
> +static void __exit hisi_cpa_pmu_module_exit(void)
> +{
> +	platform_driver_unregister(&hisi_cpa_pmu_driver);
> +	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE);
> +}
> +module_exit(hisi_cpa_pmu_module_exit);
> +
> +MODULE_DESCRIPTION("HiSilicon SoC CPA uncore PMU driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 411a428ace4d..d55063719904 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -220,6 +220,7 @@ enum cpuhp_state {
>   	CPUHP_AP_PERF_S390_SF_ONLINE,
>   	CPUHP_AP_PERF_ARM_CCI_ONLINE,
>   	CPUHP_AP_PERF_ARM_CCN_ONLINE,
> +	CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
>   	CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
>   	CPUHP_AP_PERF_ARM_HISI_HHA_ONLINE,
>   	CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,

