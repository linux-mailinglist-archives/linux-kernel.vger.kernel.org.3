Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42C34D05B1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbiCGRvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiCGRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:51:12 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B666225597;
        Mon,  7 Mar 2022 09:50:16 -0800 (PST)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KC5ZR42sjz6GD3Q;
        Tue,  8 Mar 2022 01:49:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 18:50:14 +0100
Received: from [10.47.81.176] (10.47.81.176) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Mar
 2022 17:50:13 +0000
Message-ID: <816e5d86-9d7d-5762-d1d7-afcd0ee34af3@huawei.com>
Date:   Mon, 7 Mar 2022 17:50:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 1/2] drivers/perf: hisi: Add Support for CPA PMU
To:     "liuqi (BA)" <liuqi115@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <acme@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20220224111129.41416-1-liuqi115@huawei.com>
 <20220224111129.41416-2-liuqi115@huawei.com>
 <8cdc2c64-0a89-b807-56f6-2ea67a41a641@huawei.com>
 <a051968a-b90d-3707-fb60-f6a446fc79e7@huawei.com>
In-Reply-To: <a051968a-b90d-3707-fb60-f6a446fc79e7@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.81.176]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +
>>> +static void hisi_cpa_pmu_stop_counters(struct hisi_pmu *cpa_pmu)
>>> +{
>>> +    u32 val;
>>> +
>>> +    val = readl(cpa_pmu->base + CPA_PERF_CTRL);
>>> +    val &= ~(CPA_PERF_CTRL_EN);
>>> +    writel(val, cpa_pmu->base + CPA_PERF_CTRL);
>>> +}
>>> +
>>> +static void hisi_cpa_pmu_disable_pm(struct hisi_pmu *cpa_pmu)
>>
>> this seems unique for this new driver - why do we need to disable PM?
>>
> CPA PMU doesn't work under power mangement state, so we need to disable 
> PM before using CPA PMU.

OK, so you need to disable something related to PM to use the HW. But 
why do it when you enable the counter? I mean, can we just do it once 
when we probe the HW? Why is it even enabled at all?

> 
>>> +{
>>> +    u32 val;
>>> +
>>> +    val = readl(cpa_pmu->base + CPA_CFG_REG);
>>> +    val |= CPA_PM_CTRL;
>>> +    writel(val, cpa_pmu->base + CPA_CFG_REG);
>>> +}
>>> +
>>> +static void hisi_cpa_pmu_enable_pm(struct hisi_pmu *cpa_pmu)
>>> +{
>>> +    u32 val;
>>> +
>>> +    val = readl(cpa_pmu->base + CPA_CFG_REG);
>>> +    val &= ~CPA_PM_CTRL;
>>
>> nit: you use () in hisi_cpa_pmu_stop_counters(), but not here, so 
>> please be consistent
>>
> ]

...

>>> +static int hisi_cpa_pmu_init_data(struct platform_device *pdev,
>>> +                  struct hisi_pmu *cpa_pmu)
>>> +{
>>> +    if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
>>> +                     &cpa_pmu->sccl_id)) {
>>> +        dev_err(&pdev->dev, "Can not read cpa_pmu sccl-id\n");
>>
>> strange that the FW uses "scl-id" but driver uses sccl_id (I am 
>> talking about sccl vs scl difference)
>>
> yes... these two names means the same thing, maybe could use a cleanup 
> patch to keep them consistent.
> 
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    cpa_pmu->ccl_id = -1;
>>> +
>>> +    if (device_property_read_u32(&pdev->dev, "hisilicon,idx-id",
>>> +                     &cpa_pmu->index_id)) {
>>> +        dev_err(&pdev->dev, "Cannot read idx-id\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    cpa_pmu->base = devm_platform_ioremap_resource(pdev, 0);
>>> +    if (IS_ERR(cpa_pmu->base))
>>> +        return PTR_ERR(cpa_pmu->base);
>>> +
>>> +    cpa_pmu->identifier = readl(cpa_pmu->base + CPA_VERSION);
>>> +
>>> +    return 0;
>>> +}
>>> +

...

>>> +static int hisi_cpa_pmu_probe(struct platform_device *pdev)
>>> +{
>>> +    struct hisi_pmu *cpa_pmu;
>>> +    char *name;
>>> +    int ret;
>>> +
>>> +    cpa_pmu = devm_kzalloc(&pdev->dev, sizeof(*cpa_pmu), GFP_KERNEL);
>>> +    if (!cpa_pmu)
>>> +        return -ENOMEM;
>>> +
>>> +    ret = hisi_cpa_pmu_dev_probe(pdev, cpa_pmu);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
>>> +                       &cpa_pmu->node);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    name = devm_kasprintf(&pdev->dev, GFP_KERNEL, 
>>> "hisi_sicl%d_cpa%u", cpa_pmu->sccl_id - 1,
>>
>> sorry, but I still don't like this "- 1". From checking the chat on 
>> v1, my impression was that you agreed with me on this one.
>>
> 
> sorry, maybe I didn't express it clearly.
> CPA PMU is on IO die,

Then it is quite strange to provide the sccl id and not some sicl id 
(since it is in the IO die)

  but BIOS give CPA PMU driver the sccl-id of
> adjacent CPU die (as we need this sccl-id to pass 
> hisi_pmu_cpu_is_associated_pmu() and find the associated cpu).


Is the PMU only ever used by one SCCL? Or can more than one SCCL access? 
If so, is there a special affinity to one particular SCCL?

> so, when naming CPA PMU, we use the sccl-id supported by BIOS to get the 
> sicl-id of IO die which CPA PMU located in, that is: cpa_pmu->sccl_id - 1.
> 
>>> +                  cpa_pmu->index_id);

Thanks,
John
