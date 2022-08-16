Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86CF595617
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiHPJXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiHPJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:22:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB1BFAA7;
        Tue, 16 Aug 2022 00:37:32 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6NFc11jZzlVxF;
        Tue, 16 Aug 2022 15:34:28 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 15:37:30 +0800
CC:     <yangyicong@hisilicon.com>, <will@kernel.org>, <Frank.li@nxp.com>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <zhangshaokun@hisilicon.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <konrad.dybcio@somainline.org>,
        <khuong@os.amperecomputing.com>, <john.garry@huawei.com>,
        <jonathan.cameron@huawei.com>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] drivers/perf: Change WARN_ON() to dev_err() on
 irq_set_affinity() failure
To:     Mark Rutland <mark.rutland@arm.com>
References: <20220815092815.11597-1-yangyicong@huawei.com>
 <YvotEZigh0+I/RIb@FVFF77S0Q05N>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <2e0c3a14-d308-dfd2-debe-8a52a3db47cc@huawei.com>
Date:   Tue, 16 Aug 2022 15:37:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YvotEZigh0+I/RIb@FVFF77S0Q05N>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/8/15 19:25, Mark Rutland wrote:
> On Mon, Aug 15, 2022 at 05:28:15PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The WARN_ON() on irq_set_affinity() failure is misused according to the [1]
>> and may crash people's box unintentionally. This may also be redundant since
>> in the failure case we may also trigger the WARN and dump the stack in the
>> perf core[2] for a second time.
> 
> In what way do you think are these misused? I can't immediately see what you
> think applies from [1].

As commented by irq_set_affinity() it "Fails if cpumask does not contain an online
 CPU" which means we passed an invalid input, I think which violiates the "Do not
use these macros when checking for invalid external inputs".

> 
> In perf we rely upon interrupt affinity to enforce serialization in a few
> places, so if we fail to set the interrupt affinity there are a number of
> things which could go wrong (e.g. memory corruption, and all the fun that could
> result from that). We use WARN_ON() to catch that early.
> 

If we'd like to catch this failure information early maybe a dev_err() should be
enough to indicate this.

> I can't immediately see how [2] is relevant, since that's in the context of an
> IPI handler, and this patch affects the affinity of the PMU HW IRQ handler.
> 

I think it's relevant (please correct me) as when I debug another pmu driver using
MSI interrupt[*], I found I'll trigger the WARN() in [2] if the interrupt is not
bind to the CPU which start trace. So I think it's required to handle the interrupt
on the same CPU start the trace otherwise the "context" is mismatched.

[*] https://lore.kernel.org/lkml/20220721130116.43366-3-yangyicong@huawei.com/

Thanks.

> Thanks,
> Mark.
> 
>>
>> So change the WARN_ON() to dev_err() to just print the failure message.
>>
>> [1] https://github.com/torvalds/linux/blob/master/include/asm-generic/bug.h#L74
>> [2] https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L313
>>
>> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
>> [https://lore.kernel.org/lkml/YuOi3i0XHV++z1YI@kroah.com/]
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/perf/arm-ccn.c                   | 5 +++--
>>  drivers/perf/arm_dmc620_pmu.c            | 3 ++-
>>  drivers/perf/arm_smmuv3_pmu.c            | 6 ++++--
>>  drivers/perf/fsl_imx8_ddr_perf.c         | 3 ++-
>>  drivers/perf/hisilicon/hisi_pcie_pmu.c   | 6 ++++--
>>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 6 ++++--
>>  drivers/perf/qcom_l2_pmu.c               | 8 ++++++--
>>  drivers/perf/xgene_pmu.c                 | 6 ++++--
>>  8 files changed, 29 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
>> index 728d13d8e98a..83abd909ba49 100644
>> --- a/drivers/perf/arm-ccn.c
>> +++ b/drivers/perf/arm-ccn.c
>> @@ -1210,8 +1210,9 @@ static int arm_ccn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>>  		return 0;
>>  	perf_pmu_migrate_context(&dt->pmu, cpu, target);
>>  	dt->cpu = target;
>> -	if (ccn->irq)
>> -		WARN_ON(irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)));
>> +	if (ccn->irq && irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)))
>> +		dev_err(ccn->dev, "Failed to set interrupt affinity\n");
>> +
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
>> index 280a6ae3e27c..b59d3d9eb779 100644
>> --- a/drivers/perf/arm_dmc620_pmu.c
>> +++ b/drivers/perf/arm_dmc620_pmu.c
>> @@ -621,7 +621,8 @@ static int dmc620_pmu_cpu_teardown(unsigned int cpu,
>>  		perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
>>  	mutex_unlock(&dmc620_pmu_irqs_lock);
>>  
>> -	WARN_ON(irq_set_affinity(irq->irq_num, cpumask_of(target)));
>> +	if (irq_set_affinity(irq->irq_num, cpumask_of(target)))
>> +		dev_err(dmc620_pmu->pmu.dev, "Failed to set interrupt affinity\n");
>>  	irq->cpu = target;
>>  
>>  	return 0;
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
>>  
>>  	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
>>  					       &smmu_pmu->node);
>> diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
>> index 8e058e08fe81..c44192e2d9db 100644
>> --- a/drivers/perf/fsl_imx8_ddr_perf.c
>> +++ b/drivers/perf/fsl_imx8_ddr_perf.c
>> @@ -671,7 +671,8 @@ static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
>>  	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
>>  	pmu->cpu = target;
>>  
>> -	WARN_ON(irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu)));
>> +	if (irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu)))
>> +		dev_err(pmu->dev, "Failed to set interrupt affinity\n");
>>  
>>  	return 0;
>>  }
>> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> index 21771708597d..90aed9e51396 100644
>> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> @@ -655,7 +655,8 @@ static int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
>>  
>>  	if (pcie_pmu->on_cpu == -1) {
>>  		pcie_pmu->on_cpu = cpu;
>> -		WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)));
>> +		if (irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)))
>> +			pci_err(pcie_pmu->pdev, "Failed to set interrupt affinity\n");
>>  	}
>>  
>>  	return 0;
>> @@ -681,7 +682,8 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>>  	perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
>>  	/* Use this CPU for event counting */
>>  	pcie_pmu->on_cpu = target;
>> -	WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(target)));
>> +	if (irq_set_affinity(pcie_pmu->irq, cpumask_of(target)))
>> +		pci_err(pcie_pmu->pdev, "Failed to set interrupt affinity\n");
>>  
>>  	return 0;
>>  }
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
>> index fbc8a93d5eac..74397b5ec889 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
>> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
>> @@ -492,7 +492,8 @@ int hisi_uncore_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
>>  	hisi_pmu->on_cpu = cpu;
>>  
>>  	/* Overflow interrupt also should use the same CPU */
>> -	WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(cpu)));
>> +	if (irq_set_affinity(hisi_pmu->irq, cpumask_of(cpu)))
>> +		dev_err(hisi_pmu->dev, "Failed to set interrupt affinity\n");
>>  
>>  	return 0;
>>  }
>> @@ -525,7 +526,8 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>>  	perf_pmu_migrate_context(&hisi_pmu->pmu, cpu, target);
>>  	/* Use this CPU for event counting */
>>  	hisi_pmu->on_cpu = target;
>> -	WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(target)));
>> +	if (irq_set_affinity(hisi_pmu->irq, cpumask_of(target)))
>> +		dev_err(hisi_pmu->dev, "Failed to set interrupt affinity\n");
>>  
>>  	return 0;
>>  }
>> diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
>> index 30234c261b05..c6fe01c7e637 100644
>> --- a/drivers/perf/qcom_l2_pmu.c
>> +++ b/drivers/perf/qcom_l2_pmu.c
>> @@ -793,7 +793,9 @@ static int l2cache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
>>  	cpumask_set_cpu(cpu, &l2cache_pmu->cpumask);
>>  	cluster_pmu_reset();
>>  
>> -	WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(cpu)));
>> +	if (irq_set_affinity(cluster->irq, cpumask_of(cpu)))
>> +		dev_err(&l2cache_pmu->pdev->dev,
>> +			"Failed to set interrupt affinity\n");
>>  	enable_irq(cluster->irq);
>>  
>>  	return 0;
>> @@ -831,7 +833,9 @@ static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>>  	perf_pmu_migrate_context(&l2cache_pmu->pmu, cpu, target);
>>  	cluster->on_cpu = target;
>>  	cpumask_set_cpu(target, &l2cache_pmu->cpumask);
>> -	WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(target)));
>> +	if (irq_set_affinity(cluster->irq, cpumask_of(target)))
>> +		dev_err(&l2cache_pmu->pdev->dev,
>> +			"Failed to set interrupt affinity\n");
>>  
>>  	return 0;
>>  }
>> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
>> index 0c32dffc7ede..f31e678fdb69 100644
>> --- a/drivers/perf/xgene_pmu.c
>> +++ b/drivers/perf/xgene_pmu.c
>> @@ -1790,7 +1790,8 @@ static int xgene_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
>>  		cpumask_set_cpu(cpu, &xgene_pmu->cpu);
>>  
>>  	/* Overflow interrupt also should use the same CPU */
>> -	WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
>> +	if (irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu))
>> +		dev_err(xgene_pmu->dev, "Failed to set interrupt affinity\n");
>>  
>>  	return 0;
>>  }
>> @@ -1823,7 +1824,8 @@ static int xgene_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>>  
>>  	cpumask_set_cpu(target, &xgene_pmu->cpu);
>>  	/* Overflow interrupt also should use the same CPU */
>> -	WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
>> +	if (irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu))
>> +		dev_err(xgene_pmu->dev, "Failed to set interrupt affinity\n");
>>  
>>  	return 0;
>>  }
>> -- 
>> 2.24.0
>>
> .
> 
