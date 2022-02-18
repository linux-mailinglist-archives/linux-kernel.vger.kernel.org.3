Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86024BB3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiBRIHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:07:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiBRIHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:07:37 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC51D0F3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:07:18 -0800 (PST)
Received: from kwepemi100023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K0PQn2sMPzdZLc;
        Fri, 18 Feb 2022 16:06:09 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100023.china.huawei.com (7.221.188.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 16:07:16 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Feb
 2022 16:07:16 +0800
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
 <edefd1ea-10d5-0aaf-8235-27766afa2e75@huawei.com>
 <28ac81fe-3c8c-0469-45c5-a2b4c6a730f7@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <f0d98ab8-dcce-7cbd-7802-c818d11676f3@huawei.com>
Date:   Fri, 18 Feb 2022 16:07:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <28ac81fe-3c8c-0469-45c5-a2b4c6a730f7@huawei.com>
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


HiJohn,
On 2022/2/18 2:11, John Garry wrote:
> On 16/02/2022 03:16, liuqi (BA) wrote:
>>>>
>>>> +    name = devm_kasprintf(&pdev->dev, GFP_KERNEL, 
>>>> "hisi_sicl%d_cpa%u", cpa_pmu->sccl_id - 1,
>>>
>>> why subtract 1? Looks dangerous if sccl_id == 0
>> As CPA PMU is on SICL, and id of SICL is 1 smaller than id of adjacent 
>> SCCL. SCCL id in our Hip09 platform is set as 1, 3.... so, a 
>> reasonable sccl-id will never be 0.
> 
> I think that you need to view the HW IP independent of the SoC, and not 
> get into the practice of relying on these things. Anyway, doesn't the 
> sccl_id come from ACPI DSD (so we can set as we want)?
> 

Yes, sccl_id in driver is read from ACPI DSD, and is checked in
hisi_pmu_cpu_is_associated_pmu().
>>
>> Parameters sccl_id is read from ACPI, and is checked in 
>> hisi_pmu_cpu_is_associated_pmu(), so we could make sure that sccl_id 
>> here is reasonable and is not 0.
>>
>>
>>>
>>>> +                  cpa_pmu->index_id);
>>>> +
>>>> +    cpa_pmu->pmu = (struct pmu) {
>>>> +        .name        = name,
>>>> +        .module        = THIS_MODULE,
>>>> +        .task_ctx_nr    = perf_invalid_context,
>>>> +        .event_init    = hisi_uncore_pmu_event_init,
>>>> +        .pmu_enable    = hisi_uncore_pmu_enable,
>>>> +        .pmu_disable    = hisi_uncore_pmu_disable,
>>>> +        .add        = hisi_uncore_pmu_add,
>>>> +        .del        = hisi_uncore_pmu_del,
>>>> +        .start        = hisi_uncore_pmu_start,
>>>> +        .stop        = hisi_uncore_pmu_stop,
>>>> +        .read        = hisi_uncore_pmu_read,
>>>> +        .attr_groups    = cpa_pmu->pmu_events.attr_groups,
>>>> +        .capabilities    = PERF_PMU_CAP_NO_EXCLUDE,
>>>> +    };
>>>> +
>>>> +    ret = perf_pmu_register(&cpa_pmu->pmu, name, -1);
>>>> +    if (ret) {
>>>> +        dev_err(cpa_pmu->dev, "CPA PMU register failed\n");
>>>> +        cpuhp_state_remove_instance_nocalls(
>>>> +            CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE, &cpa_pmu->node);
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int hisi_cpa_pmu_remove(struct platform_device *pdev)
>>>> +{
>>>> +    struct hisi_pmu *cpa_pmu = platform_get_drvdata(pdev);
>>>> +
>>>> +    perf_pmu_unregister(&cpa_pmu->pmu);
>>>> + 
>>>> cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
>>>> +                        &cpa_pmu->node);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static struct platform_driver hisi_cpa_pmu_driver = {
>>>> +    .driver = {
>>>> +        .name = "hisi_cpa_pmu",
>>>> +        .acpi_match_table = ACPI_PTR(hisi_cpa_pmu_acpi_match),
>>>> +        .suppress_bind_attrs = true,
>>>> +    },
>>>> +    .probe = hisi_cpa_pmu_probe,
>>>> +    .remove = hisi_cpa_pmu_remove,
>>>> +};
>>>> +
>>>> +static int __init hisi_cpa_pmu_module_init(void)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
>>>> +                      "AP_PERF_ARM_HISI_CPA_ONLINE",
>>>> +                      hisi_uncore_pmu_online_cpu,
>>>> +                      hisi_uncore_pmu_offline_cpu);
>>>> +    if (ret) {
>>>> +        pr_err("CPA PMU: setup hotplug: %d\n", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    ret = platform_driver_register(&hisi_cpa_pmu_driver);
>>>> +    if (ret)
>>>> +        cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE);
>>>
>>> I am not being totally serious, but this pattern of registering a CPU 
>>> hotplug handler and then a driver is so common that we could nearly 
>>> add a wrapper for it.
>>>
>>
>> Hi John, do you mean somthing like this?
>>
>> in hisi_uncore_pmu.c:
>>
>> int hisi_uncore_pmu_module_init(enum cpuhp_state state, const char 
>> *name, struct platform_driver *drv)
>> {
>>      int ret;
>>
>>      ret = cpuhp_setup_state_multi(state, name, 
>> hisi_uncore_pmu_online_cpu,
>>                        hisi_uncore_pmu_offline_cpu);
>>      if (ret) {
>>          pr_err("%s: setup hotplug: %d\n", drv->driver.name, ret);
>>          return ret;
>>      }
>>
>>      ret = platform_driver_register(drv);
>>      if (ret)
>>          cpuhp_remove_multi_state(state);
>>
>>      return ret;
>> }
>>
>> in hisi_uncore_cpa_pmu.c:
>>
>> static int __init hisi_cpa_pmu_module_init(void)
>> {
>>      int ret;
>>
>>      ret = hisi_uncore_pmu_module_init(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
>>                        "AP_PERF_ARM_HISI_CPA_ONLINE",
>>                        &hisi_cpa_pmu_driver);
>>
>>      return ret;
>> }
>> module_init(hisi_cpa_pmu_module_init);
> 
> Sure, but I'm talking about going further and having this as 
> drivers/perf or even platform_device.h helper:
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c 
> b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> index 62299ab5a9be..22f635260a5f 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> @@ -562,26 +562,11 @@ static struct platform_driver hisi_ddrc_pmu_driver 
> = {
>       .remove = hisi_ddrc_pmu_remove,
>   };
> 
> -static int __init hisi_ddrc_pmu_module_init(void)
> -{
> -    int ret;
> -
> -    ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
> -                      "AP_PERF_ARM_HISI_DDRC_ONLINE",
> -                      hisi_uncore_pmu_online_cpu,
> -                      hisi_uncore_pmu_offline_cpu);
> -    if (ret) {
> -        pr_err("DDRC PMU: setup hotplug, ret = %d\n", ret);
> -        return ret;
> -    }
> -
> -    ret = platform_driver_register(&hisi_ddrc_pmu_driver);
> -    if (ret)
> -        cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE);
> +module_platform_driver_cpu_hotplug(hisi_ddrc_pmu_driver,
> +                AP_PERF_ARM_HISI_DDRC_ONLINE,
> +                hisi_uncore_pmu_online_cpu,
> +                hisi_uncore_pmu_online_cpu);
> 
> -    return ret;
> -}
> -module_init(hisi_ddrc_pmu_module_init);
> 
>   static void __exit hisi_ddrc_pmu_module_exit(void)
>   {
> diff --git a/include/linux/platform_device.h 
> b/include/linux/platform_device.h
> index 7c96f169d274..d0816dfc0637 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -261,6 +261,28 @@ static inline void platform_set_drvdata(struct 
> platform_device *pdev,
>   #define builtin_platform_driver(__platform_driver) \
>       builtin_driver(__platform_driver, platform_driver_register)
> 
> +#define module_platform_driver_cpu_hotplug(__platform_driver, 
> cpuhp_state, online, offline) \
> +static int __init 
> __module_platform_driver_cpu_hotplug##_init(void)        \
> +{                                        \
> +    int ret;                                \
> +    ret = cpuhp_setup_state_multi(CPUHP_##cpuhp_state,            \
> +                      "##cpuhp_state",                \
> +                      online,                    \
> +                      offline);                    \
> +    if (ret) {                                \
> +        pr_err("setup hotplug, ret = %d\n", ret);        \
> +        return ret;                            \
> +    }                                    \
> +                                        \
> +    ret = platform_driver_register(&__platform_driver);            \
> +    if (ret)                                \
> +        cpuhp_remove_multi_state(CPUHP_##cpuhp_state);            \
> +                                        \
> +    return ret;                                \
> +}                                        \
> +module_init(__module_platform_driver_cpu_hotplug##_init);
> +
> +

got it, I think we could make another patch to do these cleanup.

Thanks,
Qi
>   /* module_platform_driver_probe() - Helper macro for drivers that 
> don't do
>    * anything special in module init/exit.  This eliminates a lot of
>    * boilerplate.  Each module may only use this macro once, and
