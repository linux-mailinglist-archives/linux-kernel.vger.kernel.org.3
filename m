Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF04F57E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiDFIZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381632AbiDFIZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:25:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D4110FC6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:37:44 -0700 (PDT)
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KY6Xs3t3QzgYP3;
        Wed,  6 Apr 2022 09:35:57 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 09:37:41 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 6 Apr
 2022 09:37:41 +0800
Subject: Re: [PATCH v3 1/2] drivers/perf: hisi: Associate PMUs in SICL with
 CPUs online
To:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     Zhangshaokun <zhangshaokun@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220321070124.41338-1-liuqi115@huawei.com>
 <20220321070124.41338-2-liuqi115@huawei.com>
 <ba5aa606-54bf-e19f-39ba-a21998781a6c@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <3243b077-1cca-9986-f587-362a46589aba@huawei.com>
Date:   Wed, 6 Apr 2022 09:37:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ba5aa606-54bf-e19f-39ba-a21998781a6c@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/4/5 16:18, John Garry wrote:
> On 21/03/2022 07:01, Qi Liu wrote:
>> If a PMU is in SICL, we associate it with all CPUs online, rather
> 
> /s/in SICL/in a SICL/ [and all other places, including the code change], 
> or maybe it is better mention "IO super cluster" as well for people who 
> would not know or remember.
> 
got it, will change these description, thanks.

>> than CPUs in the nearest SCCL.
> 
> You are not really saying why. I would mention that we do it as it is 
> not appropiate to associate with a CPU die, and you can also mention 
> problems that associating with a SICL creates.
> 
> Please also mention how changing FW definition is ok at this stage.

ok, I'll metion this next time.
> 
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   drivers/perf/hisilicon/hisi_uncore_pa_pmu.c | 18 +++++++-----------
>>   drivers/perf/hisilicon/hisi_uncore_pmu.c    |  4 ++++
>>   drivers/perf/hisilicon/hisi_uncore_pmu.h    |  1 +
>>   3 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c 
>> b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
>> index bad99d149172..54c604c0d404 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
>> +++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
>> @@ -258,13 +258,12 @@ static int hisi_pa_pmu_init_data(struct 
>> platform_device *pdev,
>>                      struct hisi_pmu *pa_pmu)
>>   {
>>       /*
>> -     * Use the SCCL_ID and the index ID to identify the PA PMU,
>> -     * while SCCL_ID is the nearst SCCL_ID from this SICL and
>> -     * CPU core is chosen from this SCCL to manage this PMU.
>> +     * As PA PMU is in SICL, use the SICL_ID and the index ID
> 
> "a SICL"

got it.
> 
>> +     * to identify the PA PMU.
>>        */
>>       if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
>> -                     &pa_pmu->sccl_id)) {
>> -        dev_err(&pdev->dev, "Cannot read sccl-id!\n");
>> +                     &pa_pmu->sicl_id)) {
>> +        dev_err(&pdev->dev, "Cannot read sicl-id!\n");
>>           return -EINVAL;
>>       }
>> @@ -275,6 +274,7 @@ static int hisi_pa_pmu_init_data(struct 
>> platform_device *pdev,
>>       }
>>       pa_pmu->ccl_id = -1;
>> +    pa_pmu->sccl_id = -1;
>>       pa_pmu->base = devm_platform_ioremap_resource(pdev, 0);
>>       if (IS_ERR(pa_pmu->base)) {
>> @@ -399,13 +399,9 @@ static int hisi_pa_pmu_probe(struct 
>> platform_device *pdev)
>>       ret = hisi_pa_pmu_dev_probe(pdev, pa_pmu);
>>       if (ret)
>>           return ret;
>> -    /*
>> -     * PA is attached in SICL and the CPU core is chosen to manage this
>> -     * PMU which is the nearest SCCL, while its SCCL_ID is greater than
>> -     * one with the SICL_ID.
>> -     */
>> +
>>       name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sicl%u_pa%u",
>> -                  pa_pmu->sccl_id - 1, pa_pmu->index_id);
>> +                  pa_pmu->sicl_id, pa_pmu->index_id);
>>       if (!name)
>>           return -ENOMEM;
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c 
>> b/drivers/perf/hisilicon/hisi_uncore_pmu.c
>> index a738aeab5c04..31930166c34b 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
>> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
>> @@ -458,6 +458,10 @@ static bool hisi_pmu_cpu_is_associated_pmu(struct 
>> hisi_pmu *hisi_pmu)
>>   {
>>       int sccl_id, ccl_id;
>> +    /* If SCCL_ID is -1, the PMU is in SICL and can be associated 
>> this PMU with any CPU */
> 
> too long, just have "The PMU is in a SICL and has no CPU affinity"

ok, will fix this.

Thanks,
Qi
> 
>> +    if (hisi_pmu->sccl_id == -1)
>> +        return true;
>> +
>>       if (hisi_pmu->ccl_id == -1) {
>>           /* If CCL_ID is -1, the PMU only shares the same SCCL */
>>           hisi_read_sccl_and_ccl_id(&sccl_id, NULL);
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h 
>> b/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> index 7f5841d6f592..96eeddad55ff 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> @@ -81,6 +81,7 @@ struct hisi_pmu {
>>       struct device *dev;
>>       struct hlist_node node;
>>       int sccl_id;
>> +    int sicl_id;
>>       int ccl_id;
>>       void __iomem *base;
>>       /* the ID of the PMU modules */
> 
> .
