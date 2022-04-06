Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2D34F5F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiDFN3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiDFN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:27:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F7C5F8F1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:57:51 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KY6zR06WPzDqKX;
        Wed,  6 Apr 2022 09:55:30 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 09:57:49 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 6 Apr
 2022 09:57:49 +0800
Subject: Re: [PATCH v3 2/2] drivers/perf: hisi: Add Support for CPA PMU
To:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     Zhangshaokun <zhangshaokun@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220321070124.41338-1-liuqi115@huawei.com>
 <20220321070124.41338-3-liuqi115@huawei.com>
 <823dedd5-38e2-21a9-cd4f-1ba966af902d@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <c189bc40-b73c-5653-2717-0dabdd4ec964@huawei.com>
Date:   Wed, 6 Apr 2022 09:57:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <823dedd5-38e2-21a9-cd4f-1ba966af902d@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
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

On 2022/4/5 16:28, John Garry wrote:
> On 21/03/2022 07:01, Qi Liu wrote:
>> On HiSilicon Hip09 platform, there is a CPA(Coherency Protocol Agent) on
> 
> leave whitespace before '('
> 
ok, will fix this.
>> each SICL (Super I/O Cluster) which implements packet format translation,
>> route parsing and traffic statistic.
> 
> statistics
will fix this, thanks.
> 
>>
>> CPA PMU has 8 PMU counters and interrupt is supported to handle counter
>> overflow. Let's support its driver under the framework of HiSilicon PMU
>> driver.
>>
> 
> Generally this looks ok, just some small comments to consider.
> 
> Thanks,
> John
> 
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   drivers/perf/hisilicon/Makefile              |   2 +-
>>   drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c | 400 +++++++++++++++++++
>>   include/linux/cpuhotplug.h                   |   1 +
>>   3 files changed, 402 insertions(+), 1 deletion(-)
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
>> index 000000000000..3f1d9c3f99fe
>> --- /dev/null
>> +++ b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
>> @@ -0,0 +1,400 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * HiSilicon SoC CPA(Coherency Protocol Agent) uncore hardware event 
>> counters support
> 
> I am not sure why we even mention uncore for something which is not in a 
> SCCL
> 

we metion uncore as it use hisi_uncore_pmu framework, I'll drop this 
next time.
>> + *
>> + * Copyright (C) 2022 HiSilicon Limited
>> + * Author: Qi Liu <liuqi115@huawei.com>
>> + *
>> + * This code is based on the uncore PMUs like arm-cci and arm-ccn.
>> + */
>> +
[...]
>> +
>> +static int hisi_cpa_pmu_init_data(struct platform_device *pdev,
>> +                  struct hisi_pmu *cpa_pmu)
>> +{
>> +    if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
>> +                     &cpa_pmu->sicl_id)) {
>> +        dev_err(&pdev->dev, "Can not read cpa_pmu sicl-id\n");
> 
> I don't think that you need to mention "cpa_pmu"

will drop it.

> 
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (device_property_read_u32(&pdev->dev, "hisilicon,idx-id",
>> +                     &cpa_pmu->index_id)) {
>> +        dev_err(&pdev->dev, "Cannot read idx-id\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    cpa_pmu->ccl_id = -1;
>> +    cpa_pmu->sccl_id = -1;
>> +    cpa_pmu->base = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(cpa_pmu->base))
>> +        return PTR_ERR(cpa_pmu->base);
>> +
>> +    cpa_pmu->identifier = readl(cpa_pmu->base + CPA_VERSION);
>> +
>> +    return 0;
>> +}
>> +

[...]

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
>> +
>> +    /* Power Management should be disabled before using CPA PMU. */
>> +    hisi_cpa_pmu_disable_pm(cpa_pmu);
> 
> maybe you can move this earlier in the probe, before registering
> 
got it, will do this.

>> +    return ret;
>> +}
>> +
>> +static int hisi_cpa_pmu_remove(struct platform_device *pdev)
>> +{
>> +    struct hisi_pmu *cpa_pmu = platform_get_drvdata(pdev);
>> +
>> +    hisi_cpa_pmu_enable_pm(cpa_pmu);
> 
> why do we do this?

restore CPA registers after remove CPA PMU driver, as we disable pmu in 
probe function.

> 
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
> 
> you don't mention failed
> 
> And mostly we use lowercase for the driver name and maybe consider using 
> pr_fmt
> 
got it, will fix this next time.

Thanks,
Qi
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
