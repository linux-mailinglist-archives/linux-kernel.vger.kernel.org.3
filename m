Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642875954C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiHPIOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiHPIOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:14:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29BADAA05;
        Mon, 15 Aug 2022 23:22:15 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6LYP6CCmzXdjj;
        Tue, 16 Aug 2022 14:18:01 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 14:22:12 +0800
CC:     <yangyicong@hisilicon.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <Frank.li@nxp.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <zhangshaokun@hisilicon.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <konrad.dybcio@somainline.org>,
        <khuong@os.amperecomputing.com>, <john.garry@huawei.com>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] drivers/perf: Change WARN_ON() to dev_err() on
 irq_set_affinity() failure
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220815092815.11597-1-yangyicong@huawei.com>
 <20220815103958.000016c9@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <7102b6dc-1721-46cd-bdb4-a3d39e12a82b@huawei.com>
Date:   Tue, 16 Aug 2022 14:22:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220815103958.000016c9@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/15 17:39, Jonathan Cameron wrote:
> On Mon, 15 Aug 2022 17:28:15 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The WARN_ON() on irq_set_affinity() failure is misused according to the [1]
>> and may crash people's box unintentionally. This may also be redundant since
>> in the failure case we may also trigger the WARN and dump the stack in the
>> perf core[2] for a second time.
>>
>> So change the WARN_ON() to dev_err() to just print the failure message.
>>
>> [1] https://github.com/torvalds/linux/blob/master/include/asm-generic/bug.h#L74
>> [2] https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L313
>>
>> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
>> [https://lore.kernel.org/lkml/YuOi3i0XHV++z1YI@kroah.com/]
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Looks like progress in a sensible direction to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Kind of unrelated question inline.
> 

Thanks for the quick review! replies below.

>>
> 
> 
>> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
>> index 00d4c45a8017..05e1b3e274d7 100644
>> --- a/drivers/perf/arm_smmuv3_pmu.c
>> +++ b/drivers/perf/arm_smmuv3_pmu.c
>> @@ -646,7 +646,8 @@ static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>>  
>>  	perf_pmu_migrate_context(&smmu_pmu->pmu, cpu, target);
>>  	smmu_pmu->on_cpu = target;
>> -	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(target)));
>> +	if (irq_set_affinity(smmu_pmu->irq, cpumask_of(target)))
>> +		dev_err(smmu_pmu->dev, "Failed to set interrupt affinity\n");
>>  
>>  	return 0;
>>  }
>> @@ -892,7 +893,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>  
>>  	/* Pick one CPU to be the preferred one to use */
>>  	smmu_pmu->on_cpu = raw_smp_processor_id();
>> -	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
>> +	if (irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)))
>> +		dev_err(dev, "Failed to set interrupt affinity\n");
> 
> In this case we have the option to fail probe.  Failing to set affinity means
> we are broken anyway, so perhaps that is cleaner than carrying on.
> 

This patch only switch the way on error notification with no functional change intended.
So if we need to change the behaviour here it should be in a separate patch. Indeed I'm
not sure it's necessary to fail probe here since we can use the pmu if it fails here.

> As a side note, I wonder if other drivers could benefit from what I think
> is a micro optimization to short cut calling the hp handlers when the
> decision of which CPU is easy...
> 

It seems sensible to me but may differ in differenct pmu drivers since they may need the
hp handlers called. Needs more check.

Thanks.

>>  
>>  	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
>>  					       &smmu_pmu->node);
> .
> 
