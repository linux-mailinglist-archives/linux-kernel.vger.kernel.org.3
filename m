Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E1D4CB9C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiCCJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiCCJCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:02:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49277177759;
        Thu,  3 Mar 2022 01:02:09 -0800 (PST)
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K8Q1r484Qzdflf;
        Thu,  3 Mar 2022 17:00:48 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 17:02:06 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 3 Mar
 2022 17:02:05 +0800
Subject: Re: [PATCH v2 1/2] drivers/perf: hisi: Add Support for CPA PMU
To:     John Garry <john.garry@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <acme@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20220224111129.41416-1-liuqi115@huawei.com>
 <20220224111129.41416-2-liuqi115@huawei.com>
 <8cdc2c64-0a89-b807-56f6-2ea67a41a641@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <a051968a-b90d-3707-fb60-f6a446fc79e7@huawei.com>
Date:   Thu, 3 Mar 2022 17:02:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8cdc2c64-0a89-b807-56f6-2ea67a41a641@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks for the comments. some replies inline.

On 2022/2/28 17:56, John Garry wrote:
> On 24/02/2022 11:11, Qi Liu wrote:
>> On HiSilicon Hip09 platform, there is a CPA(Coherency Protocol Agent) on
>> each SICL (Super I/O Cluster) which implements packet format translation,
>> route parsing and traffic statistic.
>>
>> CPA PMU has separate PMU registers which the driver can program freely
> 
> I am not sure what you mean by program freely. Most IO mem drivers have 
> registers which we can program.
> 
I'll drop these ambiguous description, thanks.

>> and
>> interrupt is supported to handle counter overflow. Let's support its 
>> driver
>> under the framework of HiSilicon uncore PMU driver.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   drivers/perf/hisilicon/Makefile              |   2 +-
>>   drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c | 401 +++++++++++++++++++
>>   include/linux/cpuhotplug.h                   |   1 +
>>   3 files changed, 403 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
>>
>> diff --git a/drivers/perf/hisilicon/Makefile 
>> b/drivers/perf/hisilicon/Makefile
>> index 506ed39e3266..6be83517acaa 100644
>> --- a/drivers/perf/hisilicon/Makefile
>> +++ b/drivers/perf/hisilicon/Makefile
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o hisi_uncore_l3c_pmu.o \
>>                 hisi_uncore_hha_pmu.o hisi_uncore_ddrc_pmu.o 
>> hisi_uncore_sllc_pmu.o \
>> -              hisi_uncore_pa_pmu.o
>> +              hisi_uncore_pa_pmu.o hisi_uncore_cpa_pmu.o
>>   obj-$(CONFIG_HISI_PCIE_PMU) += hisi_pcie_pmu.o
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c 
>> b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
>> new file mode 100644
>> index 000000000000..00573719f148
>> --- /dev/null
>> +++ b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
>> @@ -0,0 +1,401 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * HiSilicon SoC CPA(Coherency Protocol Agent) uncore Hardware event 
>> counters support
> 
> /s/Hardware/hardware/
> 
ok, will fix this.
>> + *
>> + * Copyright (C) 2022 HiSilicon Limited
>> + * Author: Qi Liu <liuqi115@huawei.com>
>> + *
>> + * This code is based on the uncore PMUs like arm-cci and arm-ccn.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/bug.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/list.h>
>> +#include <linux/smp.h>
>> +
>> +#include "hisi_uncore_pmu.h"
>> +
>> +/* CPA register definition */
>> +#define CPA_PERF_CTRL        0x1c00
>> +#define CPA_EVENT_CTRL        0x1c04
>> +#define CPA_INT_MASK        0x1c70
>> +#define CPA_INT_STATUS        0x1c78
>> +#define CPA_INT_CLEAR        0x1c7c
>> +#define CPA_EVENT_TYPE0        0x1c80
>> +#define CPA_VERSION        0x1cf0
>> +#define CPA_CNT0_LOWER        0x1d00
>> +#define CPA_CFG_REG        0x0534
>> +
>> +/* CPA operation command */
>> +#define CPA_PERF_CTRL_EN    BIT_ULL(0)
>> +#define CPA_EVTYPE_MASK        0xffUL
>> +#define CPA_PM_CTRL        BIT_ULL(9)
>> +
>> +/* CPA has 8-counters */
>> +#define CPA_NR_COUNTERS        0x8
>> +#define CPA_COUNTER_BITS    64
>> +#define CPA_NR_EVENTS        0xff
>> +#define CPA_REG_OFFSET        0x8
>> +
>> +static u32 hisi_cpa_pmu_get_counter_offset(int idx)
>> +{
>> +    return (CPA_CNT0_LOWER + idx * CPA_REG_OFFSET);
>> +}
>> +
>> +static u64 hisi_cpa_pmu_read_counter(struct hisi_pmu *cpa_pmu,
>> +                     struct hw_perf_event *hwc)
>> +{
>> +    return readq(cpa_pmu->base + 
>> hisi_cpa_pmu_get_counter_offset(hwc->idx));
>> +}
>> +
>> +static void hisi_cpa_pmu_write_counter(struct hisi_pmu *cpa_pmu,
>> +                       struct hw_perf_event *hwc, u64 val)
>> +{
>> +    writeq(val, cpa_pmu->base + 
>> hisi_cpa_pmu_get_counter_offset(hwc->idx));
>> +}
>> +
>> +static void hisi_cpa_pmu_write_evtype(struct hisi_pmu *cpa_pmu, int 
>> idx, u32 type)
>> +{
>> +    u32 reg, reg_idx, shift, val;
>> +
>> +    /*
>> +     * Select the appropriate event select register(CPA_EVENT_TYPE0/1).
>> +     * There are 2 event select registers for the 8 hardware counters.
>> +     * Event code is 8-bits and for the former 4 hardware counters,
>> +     * CPA_EVENT_TYPE0 is chosen. For the latter 4 hardware counters,
>> +     * CPA_EVENT_TYPE1 is chosen.
>> +     */
>> +    reg = CPA_EVENT_TYPE0 + (idx / 4) * 4;
>> +    reg_idx = idx % 4;
>> +    shift = CPA_REG_OFFSET * reg_idx;
>> +
>> +    /* Write event code to CPA_EVENT_TYPEx Register */
>> +    val = readl(cpa_pmu->base + reg);
>> +    val &= ~(CPA_EVTYPE_MASK << shift);
>> +    val |= type << shift;
>> +    writel(val, cpa_pmu->base + reg);
>> +}
>> +
>> +static void hisi_cpa_pmu_start_counters(struct hisi_pmu *cpa_pmu)
>> +{
>> +    u32 val;
>> +
>> +    val = readl(cpa_pmu->base + CPA_PERF_CTRL);
>> +    val |= CPA_PERF_CTRL_EN;
>> +    writel(val, cpa_pmu->base + CPA_PERF_CTRL);
>> +}
>> +
>> +static void hisi_cpa_pmu_stop_counters(struct hisi_pmu *cpa_pmu)
>> +{
>> +    u32 val;
>> +
>> +    val = readl(cpa_pmu->base + CPA_PERF_CTRL);
>> +    val &= ~(CPA_PERF_CTRL_EN);
>> +    writel(val, cpa_pmu->base + CPA_PERF_CTRL);
>> +}
>> +
>> +static void hisi_cpa_pmu_disable_pm(struct hisi_pmu *cpa_pmu)
> 
> this seems unique for this new driver - why do we need to disable PM?
> 
CPA PMU doesn't work under power mangement state, so we need to disable 
PM before using CPA PMU.

>> +{
>> +    u32 val;
>> +
>> +    val = readl(cpa_pmu->base + CPA_CFG_REG);
>> +    val |= CPA_PM_CTRL;
>> +    writel(val, cpa_pmu->base + CPA_CFG_REG);
>> +}
>> +
>> +static void hisi_cpa_pmu_enable_pm(struct hisi_pmu *cpa_pmu)
>> +{
>> +    u32 val;
>> +
>> +    val = readl(cpa_pmu->base + CPA_CFG_REG);
>> +    val &= ~CPA_PM_CTRL;
> 
> nit: you use () in hisi_cpa_pmu_stop_counters(), but not here, so please 
> be consistent
> 

got it, I'll pay attention to this. thanks.
>> +    writel(val, cpa_pmu->base + CPA_CFG_REG);
>> +}
>> +
>> +static void hisi_cpa_pmu_enable_counter(struct hisi_pmu *cpa_pmu, 
>> struct hw_perf_event *hwc)
>> +{
>> +    u32 val;
>> +
>> +    /* Enable counter index in CPA_EVENT_CTRL register */
>> +    val = readl(cpa_pmu->base + CPA_EVENT_CTRL);
>> +    val |= 1 << hwc->idx;
>> +    writel(val, cpa_pmu->base + CPA_EVENT_CTRL);
>> +
>> +    /* Power management should be disabled before counting. */
>> +    hisi_cpa_pmu_disable_pm(cpa_pmu);
>> +}
>> +
>> +static void hisi_cpa_pmu_disable_counter(struct hisi_pmu *cpa_pmu, 
>> struct hw_perf_event *hwc)
>> +{
>> +    u32 val;
>> +
>> +    hisi_cpa_pmu_enable_pm(cpa_pmu);
>> +
>> +    /* Clear counter index in CPA_EVENT_CTRL register */
>> +    val = readl(cpa_pmu->base + CPA_EVENT_CTRL);
>> +    val &= ~(1UL << hwc->idx);
>> +    writel(val, cpa_pmu->base + CPA_EVENT_CTRL);
>> +}
>> +
>> +static void hisi_cpa_pmu_enable_counter_int(struct hisi_pmu *cpa_pmu, 
>> struct hw_perf_event *hwc)
>> +{
>> +    u32 val;
>> +
>> +    /* Write 0 to enable interrupt */
>> +    val = readl(cpa_pmu->base + CPA_INT_MASK);
>> +    val &= ~(1UL << hwc->idx);
>> +    writel(val, cpa_pmu->base + CPA_INT_MASK);
>> +}
>> +
>> +static void hisi_cpa_pmu_disable_counter_int(struct hisi_pmu 
>> *cpa_pmu, struct hw_perf_event *hwc)
>> +{
>> +    u32 val;
>> +
>> +    /* Write 1 to mask interrupt */
>> +    val = readl(cpa_pmu->base + CPA_INT_MASK);
>> +    val |= 1 << hwc->idx;
>> +    writel(val, cpa_pmu->base + CPA_INT_MASK);
>> +}
>> +
>> +static u32 hisi_cpa_pmu_get_int_status(struct hisi_pmu *cpa_pmu)
>> +{
>> +    return readl(cpa_pmu->base + CPA_INT_STATUS);
>> +}
>> +
>> +static void hisi_cpa_pmu_clear_int_status(struct hisi_pmu *cpa_pmu, 
>> int idx)
>> +{
>> +    writel(1 << idx, cpa_pmu->base + CPA_INT_CLEAR);
>> +}
>> +
>> +static const struct acpi_device_id hisi_cpa_pmu_acpi_match[] = {
>> +    { "HISI0281", },
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, hisi_cpa_pmu_acpi_match);
>> +
>> +static int hisi_cpa_pmu_init_data(struct platform_device *pdev,
>> +                  struct hisi_pmu *cpa_pmu)
>> +{
>> +    if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
>> +                     &cpa_pmu->sccl_id)) {
>> +        dev_err(&pdev->dev, "Can not read cpa_pmu sccl-id\n");
> 
> strange that the FW uses "scl-id" but driver uses sccl_id (I am talking 
> about sccl vs scl difference)
> 
yes... these two names means the same thing, maybe could use a cleanup 
patch to keep them consistent.

>> +        return -EINVAL;
>> +    }
>> +
>> +    cpa_pmu->ccl_id = -1;
>> +
>> +    if (device_property_read_u32(&pdev->dev, "hisilicon,idx-id",
>> +                     &cpa_pmu->index_id)) {
>> +        dev_err(&pdev->dev, "Cannot read idx-id\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    cpa_pmu->base = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(cpa_pmu->base))
>> +        return PTR_ERR(cpa_pmu->base);
>> +
>> +    cpa_pmu->identifier = readl(cpa_pmu->base + CPA_VERSION);
>> +
>> +    return 0;
>> +}
>> +
>> +static struct attribute *hisi_cpa_pmu_format_attr[] = {
>> +    HISI_PMU_FORMAT_ATTR(event, "config:0-15"),
>> +    NULL
>> +};
>> +
>> +static const struct attribute_group hisi_cpa_pmu_format_group = {
>> +    .name = "format",
>> +    .attrs = hisi_cpa_pmu_format_attr,
>> +};
>> +
>> +static struct attribute *hisi_cpa_pmu_events_attr[] = {
>> +    HISI_PMU_EVENT_ATTR(cpa_cycles,        0x00),
>> +    HISI_PMU_EVENT_ATTR(cpa_p1_wr_dat,    0x61),
>> +    HISI_PMU_EVENT_ATTR(cpa_p1_rd_dat,    0x62),
>> +    HISI_PMU_EVENT_ATTR(cpa_p0_wr_dat,    0xE1),
>> +    HISI_PMU_EVENT_ATTR(cpa_p0_rd_dat,    0xE2),
> 
> nit: you were using lower case for hex numbers elsewhere
> 
>> +    NULL
>> +};
>> +
>> +static const struct attribute_group hisi_cpa_pmu_events_group = {
>> +    .name = "events",
>> +    .attrs = hisi_cpa_pmu_events_attr,
>> +};
>> +
>> +static DEVICE_ATTR(cpumask, 0444, hisi_cpumask_sysfs_show, NULL);
>> +
>> +static struct attribute *hisi_cpa_pmu_cpumask_attrs[] = {
>> +    &dev_attr_cpumask.attr,
>> +    NULL
>> +};
>> +
>> +static const struct attribute_group hisi_cpa_pmu_cpumask_attr_group = {
>> +    .attrs = hisi_cpa_pmu_cpumask_attrs,
>> +};
>> +
>> +static struct device_attribute hisi_cpa_pmu_identifier_attr =
>> +    __ATTR(identifier, 0444, hisi_uncore_pmu_identifier_attr_show, 
>> NULL);
>> +
>> +static struct attribute *hisi_cpa_pmu_identifier_attrs[] = {
>> +    &hisi_cpa_pmu_identifier_attr.attr,
>> +    NULL
>> +};
>> +
>> +static const struct attribute_group hisi_cpa_pmu_identifier_group = {
>> +    .attrs = hisi_cpa_pmu_identifier_attrs,
>> +};
>> +
>> +static const struct attribute_group *hisi_cpa_pmu_attr_groups[] = {
>> +    &hisi_cpa_pmu_format_group,
>> +    &hisi_cpa_pmu_events_group,
>> +    &hisi_cpa_pmu_cpumask_attr_group,
>> +    &hisi_cpa_pmu_identifier_group,
>> +    NULL
>> +};
>> +
>> +static const struct hisi_uncore_ops hisi_uncore_cpa_pmu_ops = {
>> +    .write_evtype           = hisi_cpa_pmu_write_evtype,
>> +    .get_event_idx        = hisi_uncore_pmu_get_event_idx,
>> +    .start_counters        = hisi_cpa_pmu_start_counters,
>> +    .stop_counters        = hisi_cpa_pmu_stop_counters,
>> +    .enable_counter        = hisi_cpa_pmu_enable_counter,
>> +    .disable_counter    = hisi_cpa_pmu_disable_counter,
>> +    .enable_counter_int    = hisi_cpa_pmu_enable_counter_int,
>> +    .disable_counter_int    = hisi_cpa_pmu_disable_counter_int,
>> +    .write_counter        = hisi_cpa_pmu_write_counter,
>> +    .read_counter        = hisi_cpa_pmu_read_counter,
>> +    .get_int_status        = hisi_cpa_pmu_get_int_status,
>> +    .clear_int_status    = hisi_cpa_pmu_clear_int_status,
>> +};
>> +
>> +static int hisi_cpa_pmu_dev_probe(struct platform_device *pdev,
>> +                  struct hisi_pmu *cpa_pmu)
>> +{
>> +    int ret;
>> +
>> +    ret = hisi_cpa_pmu_init_data(pdev, cpa_pmu);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = hisi_uncore_pmu_init_irq(cpa_pmu, pdev);
>> +    if (ret)
>> +        return ret;
>> +
>> +    cpa_pmu->counter_bits = CPA_COUNTER_BITS;
>> +    cpa_pmu->check_event = CPA_NR_EVENTS;
>> +    cpa_pmu->pmu_events.attr_groups = hisi_cpa_pmu_attr_groups;
>> +    cpa_pmu->ops = &hisi_uncore_cpa_pmu_ops;
>> +    cpa_pmu->num_counters = CPA_NR_COUNTERS;
>> +    cpa_pmu->dev = &pdev->dev;
>> +    cpa_pmu->on_cpu = -1;
>> +
>> +    return 0;
>> +}
>> +
>> +static int hisi_cpa_pmu_probe(struct platform_device *pdev)
>> +{
>> +    struct hisi_pmu *cpa_pmu;
>> +    char *name;
>> +    int ret;
>> +
>> +    cpa_pmu = devm_kzalloc(&pdev->dev, sizeof(*cpa_pmu), GFP_KERNEL);
>> +    if (!cpa_pmu)
>> +        return -ENOMEM;
>> +
>> +    ret = hisi_cpa_pmu_dev_probe(pdev, cpa_pmu);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
>> +                       &cpa_pmu->node);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    name = devm_kasprintf(&pdev->dev, GFP_KERNEL, 
>> "hisi_sicl%d_cpa%u", cpa_pmu->sccl_id - 1,
> 
> sorry, but I still don't like this "- 1". From checking the chat on v1, 
> my impression was that you agreed with me on this one.
> 

sorry, maybe I didn't express it clearly.
CPA PMU is on IO die, but BIOS give CPA PMU driver the sccl-id of 
adjacent CPU die (as we need this sccl-id to pass 
hisi_pmu_cpu_is_associated_pmu() and find the associated cpu).
so, when naming CPA PMU, we use the sccl-id supported by BIOS to get the 
sicl-id of IO die which CPA PMU located in, that is: cpa_pmu->sccl_id - 1.

>> +                  cpa_pmu->index_id);
>> +
>> +    cpa_pmu->pmu = (struct pmu) {
>> +        .name        = name,
>> +        .module        = THIS_MODULE,
>> +        .task_ctx_nr    = perf_invalid_context,
>> +        .event_init    = hisi_uncore_pmu_event_init,
>> +        .pmu_enable    = hisi_uncore_pmu_enable,
>> +        .pmu_disable    = hisi_uncore_pmu_disable,
>> +        .add        = hisi_uncore_pmu_add,
>> +        .del        = hisi_uncore_pmu_del,
>> +        .start        = hisi_uncore_pmu_start,
>> +        .stop        = hisi_uncore_pmu_stop,
>> +        .read        = hisi_uncore_pmu_read,
>> +        .attr_groups    = cpa_pmu->pmu_events.attr_groups,
>> +        .capabilities    = PERF_PMU_CAP_NO_EXCLUDE,
>> +    };
>> +
>> +    ret = perf_pmu_register(&cpa_pmu->pmu, name, -1);
>> +    if (ret) {
>> +        dev_err(cpa_pmu->dev, "CPA PMU register failed\n");
> 
> I don't think that you need to mention "CPA PMU", as the driver name is 
> included in dev_err() prints

got it, will fix this.

Thanks,
Qi
> 
>> +        cpuhp_state_remove_instance_nocalls(
>> +            CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE, &cpa_pmu->node);
>> +        return ret;
>> +    }
>> +
>> +    platform_set_drvdata(pdev, cpa_pmu);
>> +    return ret;
>> +}
>> +
> 
> 
> Thanks,
> John
> .
