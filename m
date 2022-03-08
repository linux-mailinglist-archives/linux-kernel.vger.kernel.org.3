Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB144D1373
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbiCHJdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiCHJdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:33:12 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106832ECB;
        Tue,  8 Mar 2022 01:32:12 -0800 (PST)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KCVPV4QP4z9sYS;
        Tue,  8 Mar 2022 17:28:30 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 17:32:10 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 17:32:10 +0800
Subject: Re: [PATCH v2 1/2] drivers/perf: hisi: Add Support for CPA PMU
To:     John Garry <john.garry@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <acme@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20220224111129.41416-1-liuqi115@huawei.com>
 <20220224111129.41416-2-liuqi115@huawei.com>
 <8cdc2c64-0a89-b807-56f6-2ea67a41a641@huawei.com>
 <a051968a-b90d-3707-fb60-f6a446fc79e7@huawei.com>
 <816e5d86-9d7d-5762-d1d7-afcd0ee34af3@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <9a5db958-2fef-ff5e-c83f-394039e5bd0e@huawei.com>
Date:   Tue, 8 Mar 2022 17:32:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <816e5d86-9d7d-5762-d1d7-afcd0ee34af3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
On 2022/3/8 1:50, John Garry wrote:
> 
>>>> +
>>>> +static void hisi_cpa_pmu_stop_counters(struct hisi_pmu *cpa_pmu)
>>>> +{
>>>> +    u32 val;
>>>> +
>>>> +    val = readl(cpa_pmu->base + CPA_PERF_CTRL);
>>>> +    val &= ~(CPA_PERF_CTRL_EN);
>>>> +    writel(val, cpa_pmu->base + CPA_PERF_CTRL);
>>>> +}
>>>> +
>>>> +static void hisi_cpa_pmu_disable_pm(struct hisi_pmu *cpa_pmu)
>>>
>>> this seems unique for this new driver - why do we need to disable PM?
>>>
>> CPA PMU doesn't work under power mangement state, so we need to 
>> disable PM before using CPA PMU.
> 
> OK, so you need to disable something related to PM to use the HW. But 
> why do it when you enable the counter? I mean, can we just do it once 
> when we probe the HW? Why is it even enabled at all?
> 
>>

PM is enabled by default. yes, we could disable it in probe function and 
restore in remove function, I'll change this in next version.

Thanks,
Qi
>>>> +{
>>>> +    u32 val;
>>>> +
>>>> +    val = readl(cpa_pmu->base + CPA_CFG_REG);
>>>> +    val |= CPA_PM_CTRL;
>>>> +    writel(val, cpa_pmu->base + CPA_CFG_REG);
>>>> +}
>>>> +
>>>> +static void hisi_cpa_pmu_enable_pm(struct hisi_pmu *cpa_pmu)
>>>> +{
>>>> +    u32 val;
>>>> +
>>>> +    val = readl(cpa_pmu->base + CPA_CFG_REG);
>>>> +    val &= ~CPA_PM_CTRL;
>>>
>>> nit: you use () in hisi_cpa_pmu_stop_counters(), but not here, so 
>>> please be consistent
>>>
>> ]
> 
> ...
> 
>>>> +static int hisi_cpa_pmu_init_data(struct platform_device *pdev,
>>>> +                  struct hisi_pmu *cpa_pmu)
>>>> +{
>>>> +    if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
>>>> +                     &cpa_pmu->sccl_id)) {
>>>> +        dev_err(&pdev->dev, "Can not read cpa_pmu sccl-id\n");
>>>
>>> strange that the FW uses "scl-id" but driver uses sccl_id (I am 
>>> talking about sccl vs scl difference)
>>>
>> yes... these two names means the same thing, maybe could use a cleanup 
>> patch to keep them consistent.
>>
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    cpa_pmu->ccl_id = -1;
>>>> +
>>>> +    if (device_property_read_u32(&pdev->dev, "hisilicon,idx-id",
>>>> +                     &cpa_pmu->index_id)) {
>>>> +        dev_err(&pdev->dev, "Cannot read idx-id\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    cpa_pmu->base = devm_platform_ioremap_resource(pdev, 0);
>>>> +    if (IS_ERR(cpa_pmu->base))
>>>> +        return PTR_ERR(cpa_pmu->base);
>>>> +
>>>> +    cpa_pmu->identifier = readl(cpa_pmu->base + CPA_VERSION);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
> 
> ...
> 
>>>> +static int hisi_cpa_pmu_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct hisi_pmu *cpa_pmu;
>>>> +    char *name;
>>>> +    int ret;
>>>> +
>>>> +    cpa_pmu = devm_kzalloc(&pdev->dev, sizeof(*cpa_pmu), GFP_KERNEL);
>>>> +    if (!cpa_pmu)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    ret = hisi_cpa_pmu_dev_probe(pdev, cpa_pmu);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
>>>> +                       &cpa_pmu->node);
>>>> +    if (ret) {
>>>> +        dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    name = devm_kasprintf(&pdev->dev, GFP_KERNEL, 
>>>> "hisi_sicl%d_cpa%u", cpa_pmu->sccl_id - 1,
>>>
>>> sorry, but I still don't like this "- 1". From checking the chat on 
>>> v1, my impression was that you agreed with me on this one.
>>>
>>
>> sorry, maybe I didn't express it clearly.
>> CPA PMU is on IO die,
> 
> Then it is quite strange to provide the sccl id and not some sicl id 
> (since it is in the IO die)
> 
>   but BIOS give CPA PMU driver the sccl-id of
>> adjacent CPU die (as we need this sccl-id to pass 
>> hisi_pmu_cpu_is_associated_pmu() and find the associated cpu).
> 
> 
> Is the PMU only ever used by one SCCL? Or can more than one SCCL access? 
> If so, is there a special affinity to one particular SCCL?
> 
>> so, when naming CPA PMU, we use the sccl-id supported by BIOS to get 
>> the sicl-id of IO die which CPA PMU located in, that is: 
>> cpa_pmu->sccl_id - 1.
>>
>>>> +                  cpa_pmu->index_id);
> 
> Thanks,
> John
> .
