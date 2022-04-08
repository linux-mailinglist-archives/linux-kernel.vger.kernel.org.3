Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586AC4F8CB5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiDHBtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiDHBtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:49:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407B08B6E5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:47:47 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZLj01wVfzdZMS;
        Fri,  8 Apr 2022 09:47:16 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 09:47:45 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 09:47:44 +0800
Subject: Re: [PATCH v4 2/2] drivers/perf: hisi: Add Support for CPA PMU
To:     John Garry <john.garry@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>
References: <20220407124617.54521-1-liuqi115@huawei.com>
 <20220407124617.54521-3-liuqi115@huawei.com>
 <dff7fcdf-2582-40e3-2740-eddbdaae71c5@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <87415de4-9c6c-be77-f8a5-069e14873c31@huawei.com>
Date:   Fri, 8 Apr 2022 09:47:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <dff7fcdf-2582-40e3-2740-eddbdaae71c5@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/7 21:10, John Garry wrote:
> On 07/04/2022 13:46, Qi Liu wrote:
>> On HiSilicon Hip09 platform, there is a CPA (Coherency Protocol Agent) on
>> each SICL (Super I/O Cluster) which implements packet format translation,
>> route parsing and traffic statistics.
>>
>> CPA PMU has 8 PMU counters and interrupt is supported to handle counter
>> overflow. Let's support its driver under the framework of HiSilicon PMU
>> driver.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> 
> This looks ok, but I still have a few nitpicks. Regardless,
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
>

Hi John,

Thanks for the comments. some replies inline.

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
>> index 000000000000..d6b8e4037076
>> --- /dev/null
>> +++ b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
>> @@ -0,0 +1,401 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * HiSilicon SoC CPA(Coherency Protocol Agent) hardware event 
>> counters support
>> + *
>> + * Copyright (C) 2022 HiSilicon Limited
>> + * Author: Qi Liu <liuqi115@huawei.com>
>> + *
>> + * This code is based on the uncore PMUs like arm-cci and arm-ccn.
>> + */
>> +
>> +#define pr_fmt(fmt) "cpa pmu: " fmt
> 
> comment: you could add "hisi" but maybe it becomes too long
> 
yes, so we'll keep "cpa pmu" here, thanks.
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

[...]
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
>> +    /* Power Management should be disabled before using CPA PMU. */
>> +    hisi_cpa_pmu_disable_pm(cpa_pmu);
>> +
> 
> nit: we call hisi_cpa_pmu_enable_pm() in the remove function to restore 
> to the same state as we had before loading the driver. However we don't 
> do the same for a failed probe later.
> 
thanks, I'll add this next version.

>> +    ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
>> +                       &cpa_pmu->node);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    name = devm_kasprintf(&pdev->dev, GFP_KERNEL, 
>> "hisi_sicl%d_cpa%u", cpa_pmu->sicl_id,
>> +                  cpa_pmu->index_id);
> 
> nit: should check non-NULL here
> 
got it, will add this, thanks.
Qi
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
>> +        dev_err(cpa_pmu->dev, "PMU register failed\n");
>> +        cpuhp_state_remove_instance_nocalls(
>> +            CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE, &cpa_pmu->node);
>> +        return ret;
>> +    }
>> +
>> +    platform_set_drvdata(pdev, cpa_pmu);
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
>> +    hisi_cpa_pmu_enable_pm(cpa_pmu);
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
>> +        pr_err("setup hotplug failed: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = platform_driver_register(&hisi_cpa_pmu_driver);
>> +    if (ret)
>> +        cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE);
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
