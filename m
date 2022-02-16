Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF204B7ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbiBPDRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:17:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243774AbiBPDRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:17:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADE034BA4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:16:51 -0800 (PST)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jz3401pgdz9sbb;
        Wed, 16 Feb 2022 11:15:12 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 11:16:49 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Feb
 2022 11:16:49 +0800
Subject: Re: [PATCH 1/2] drivers/perf: hisi: Add Support for CPA PMU
To:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
References: <20220214114228.40859-1-liuqi115@huawei.com>
 <20220214114228.40859-2-liuqi115@huawei.com>
 <6c7c9366-91e1-3b8e-8249-dec7973f3f98@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <edefd1ea-10d5-0aaf-8235-27766afa2e75@huawei.com>
Date:   Wed, 16 Feb 2022 11:16:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6c7c9366-91e1-3b8e-8249-dec7973f3f98@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks for the comments. some replies inline.

On 2022/2/15 18:47, John Garry wrote:
> On 14/02/2022 11:42, Qi Liu wrote:
>> On HiSilicon Hip09 platform, there is a CPA(Coherency Protocol Agent) on
>> each SICL (Super I/O Cluster) which implements packet format translation,
>> route parsing and traffic statistic.
>>
>> CPA PMU has separate PMU registers which the driver can program freely 
>> and
>> interrupt is supported to handle counter overflow. Let's support its 
>> driver
>> under the framework of HiSilicon uncore PMU driver.
>>
> 
> Any documentation required?

I think CPA PMU is used as PMUs described in 
Documentation/admin-guide/perf/hisi-pmu.rst, so doesn't need additional 
documents.

> 
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   drivers/perf/hisilicon/Makefile              |   2 +-
>>   drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c | 403 +++++++++++++++++++
>>   include/linux/cpuhotplug.h                   |   1 +
>>   3 files changed, 405 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
>>

[...]

>> +
>> +/* CPA register definition */
>> +#define CPA_PERF_CTRL        0x1C00
>> +#define CPA_EVENT_CTRL        0x1C04
>> +#define CPA_INT_MASK        0x1C70
>> +#define CPA_INT_STATUS        0x1C78
>> +#define CPA_INT_CLEAR        0x1C7C
>> +#define CPA_EVENT_TYPE0        0x1C80
>> +#define CPA_VERSION        0x1CF0
>> +#define CPA_CNT0_LOWER        0x1D00
>> +#define CPA_CFG_REG        0x0534
> 
> nit: some people prefer lower case for hex numbers, but not a big deal.
> 
thanks, I'll fix this, to keep the same with other uncore PMUs.
>> +
>> +/* CPA operation command */
>> +#define CPA_PERF_CTRL_EN    BIT_ULL(0)
>> +#define CPA_EVTYPE_MASK        0xFFUL
>> +#define CPA_PM_CTRL        BIT_ULL(9)
[...]
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
> 
> rounddown(,4) could be used, I think. Or something like it.

got it, thanks.
> 
>> +    reg_idx = idx % 4;
>> +    shift = CPA_REG_OFFSET * reg_idx;
>> +
>> +    /* Write event code to CPA_EVENT_TYPEx Register */
>> +    val = readl(cpa_pmu->base + reg);
>> +    val &= ~(CPA_EVTYPE_MASK << shift);
>> +    val |= (type << shift);
> 
> no need for ()
> 
got it, thanks.
>> +    writel(val, cpa_pmu->base + reg);
>> +}
>> +

[...]
>> +static int hisi_cpa_pmu_init_data(struct platform_device *pdev,
>> +                  struct hisi_pmu *cpa_pmu)
>> +{
>> +    if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
>> +                     &cpa_pmu->sccl_id)) {
>> +        dev_err(&pdev->dev, "Can not read cpa_pmu sccl-id\n");
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
>> +    if (IS_ERR(cpa_pmu->base)) {
>> +        dev_err(&pdev->dev, "ioremap failed for cpa_pmu resource\n");
> 
> I think that devm_platform_ioremap_resource() gives error messages already
> 
ah, yes, I'll delete this, thanks.
>> +        return PTR_ERR(cpa_pmu->base);
>> +    }
>> +
>> +    cpa_pmu->identifier = readl(cpa_pmu->base + CPA_VERSION);
>> +
>> +    return 0;
>> +}
>> +
[...]
>> +
>> +static struct attribute *hisi_cpa_pmu_events_attr[] = {
>> +    HISI_PMU_EVENT_ATTR(cpa_cycles,        0x00),
>> +    HISI_PMU_EVENT_ATTR(p1_wr_dat,        0x61),
>> +    HISI_PMU_EVENT_ATTR(p1_rd_dat,        0x62),
>> +    HISI_PMU_EVENT_ATTR(p0_wr_dat,        0xE1),
>> +    HISI_PMU_EVENT_ATTR(p0_rd_dat,        0xE2),
> 
> would it be better to prefix them all with cpa_? That might be 
> future-proofing any event alias clashes with other PMU types
> 
yes, will fix this, thanks.
>> +    NULL
>> +};
>> +

[...]
>> +static const struct attribute_group *hisi_cpa_pmu_attr_groups[] = {
>> +    &hisi_cpa_pmu_format_group,
>> +    &hisi_cpa_pmu_events_group,
>> +    &hisi_cpa_pmu_cpumask_attr_group,
>> +    &hisi_cpa_pmu_identifier_group,
>> +    NULL,
> 
> nit: no need to ',' on sentinel
> 
  will fix this, thanks.
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
> 
> nit: I don't see the need for this separate function. One issue is that 
> we need to study the code there to see if we're missing some tidy-up if 
> the hisi_uncore_pmu_init_irq call fails, below.

hisi_cpa_init_data() is used to get data(including base address, 
sci-id..) from ACPI, and it doesn't need tidy-up, so I think it will be 
clearer as a separate function, thanks.
> 
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
>> +    platform_set_drvdata(pdev, cpa_pmu);
> 
> nit: normally we do this at the end, right?
> 
yes, I'll fix this, thanks.

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
> why subtract 1? Looks dangerous if sccl_id == 0
As CPA PMU is on SICL, and id of SICL is 1 smaller than id of adjacent 
SCCL. SCCL id in our Hip09 platform is set as 1, 3.... so, a reasonable 
sccl-id will never be 0.

Parameters sccl_id is read from ACPI, and is checked in 
hisi_pmu_cpu_is_associated_pmu(), so we could make sure that sccl_id 
here is reasonable and is not 0.


> 
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
>> +        cpuhp_state_remove_instance_nocalls(
>> +            CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE, &cpa_pmu->node);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int hisi_cpa_pmu_remove(struct platform_device *pdev)
>> +{
>> +    struct hisi_pmu *cpa_pmu = platform_get_drvdata(pdev);
>> +
>> +    perf_pmu_unregister(&cpa_pmu->pmu);
>> +    
>> cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
>> +                        &cpa_pmu->node);
>> +    return 0;
>> +}
>> +
>> +static struct platform_driver hisi_cpa_pmu_driver = {
>> +    .driver = {
>> +        .name = "hisi_cpa_pmu",
>> +        .acpi_match_table = ACPI_PTR(hisi_cpa_pmu_acpi_match),
>> +        .suppress_bind_attrs = true,
>> +    },
>> +    .probe = hisi_cpa_pmu_probe,
>> +    .remove = hisi_cpa_pmu_remove,
>> +};
>> +
>> +static int __init hisi_cpa_pmu_module_init(void)
>> +{
>> +    int ret;
>> +
>> +    ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
>> +                      "AP_PERF_ARM_HISI_CPA_ONLINE",
>> +                      hisi_uncore_pmu_online_cpu,
>> +                      hisi_uncore_pmu_offline_cpu);
>> +    if (ret) {
>> +        pr_err("CPA PMU: setup hotplug: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = platform_driver_register(&hisi_cpa_pmu_driver);
>> +    if (ret)
>> +        cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE);
> 
> I am not being totally serious, but this pattern of registering a CPU 
> hotplug handler and then a driver is so common that we could nearly add 
> a wrapper for it.
> 

Hi John, do you mean somthing like this?

in hisi_uncore_pmu.c:

int hisi_uncore_pmu_module_init(enum cpuhp_state state, const char 
*name, struct platform_driver *drv)
{
	int ret;

	ret = cpuhp_setup_state_multi(state, name, hisi_uncore_pmu_online_cpu,
				      hisi_uncore_pmu_offline_cpu);
	if (ret) {
		pr_err("%s: setup hotplug: %d\n", drv->driver.name, ret);
		return ret;
	}

	ret = platform_driver_register(drv);
	if (ret)
		cpuhp_remove_multi_state(state);

	return ret;
}

in hisi_uncore_cpa_pmu.c:

static int __init hisi_cpa_pmu_module_init(void)
{
	int ret;

	ret = hisi_uncore_pmu_module_init(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
					  "AP_PERF_ARM_HISI_CPA_ONLINE",
					  &hisi_cpa_pmu_driver);

	return ret;
}
module_init(hisi_cpa_pmu_module_init);

Thanks,
Qi

>> +
>> +    return ret;
>> +}
>> +module_init(hisi_cpa_pmu_module_init);
>> +
>> +static void __exit hisi_cpa_pmu_module_exit(void)
>> +{
>> +    platform_driver_unregister(&hisi_cpa_pmu_driver);
>> +    cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE);
>> +}
>> +module_exit(hisi_cpa_pmu_module_exit);
>> +
>> +MODULE_DESCRIPTION("HiSilicon SoC CPA uncore PMU driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index 411a428ace4d..d55063719904 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -220,6 +220,7 @@ enum cpuhp_state {
>>       CPUHP_AP_PERF_S390_SF_ONLINE,
>>       CPUHP_AP_PERF_ARM_CCI_ONLINE,
>>       CPUHP_AP_PERF_ARM_CCN_ONLINE,
>> +    CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
>>       CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
>>       CPUHP_AP_PERF_ARM_HISI_HHA_ONLINE,
>>       CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
> 
> .
