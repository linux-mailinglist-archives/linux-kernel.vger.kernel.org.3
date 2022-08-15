Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05266592D58
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbiHOJkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242063AbiHOJkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:40:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D501F2D4;
        Mon, 15 Aug 2022 02:40:03 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M5q1V1fVHz67yfJ;
        Mon, 15 Aug 2022 17:37:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:40:00 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 15 Aug
 2022 10:40:00 +0100
Date:   Mon, 15 Aug 2022 10:39:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>, <Frank.li@nxp.com>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <zhangshaokun@hisilicon.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <konrad.dybcio@somainline.org>,
        <khuong@os.amperecomputing.com>, <john.garry@huawei.com>,
        <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] drivers/perf: Change WARN_ON() to dev_err() on
 irq_set_affinity() failure
Message-ID: <20220815103958.000016c9@huawei.com>
In-Reply-To: <20220815092815.11597-1-yangyicong@huawei.com>
References: <20220815092815.11597-1-yangyicong@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 17:28:15 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The WARN_ON() on irq_set_affinity() failure is misused according to the [1]
> and may crash people's box unintentionally. This may also be redundant since
> in the failure case we may also trigger the WARN and dump the stack in the
> perf core[2] for a second time.
> 
> So change the WARN_ON() to dev_err() to just print the failure message.
> 
> [1] https://github.com/torvalds/linux/blob/master/include/asm-generic/bug.h#L74
> [2] https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L313
> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> [https://lore.kernel.org/lkml/YuOi3i0XHV++z1YI@kroah.com/]
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Looks like progress in a sensible direction to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Kind of unrelated question inline.

>


> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 00d4c45a8017..05e1b3e274d7 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -646,7 +646,8 @@ static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  
>  	perf_pmu_migrate_context(&smmu_pmu->pmu, cpu, target);
>  	smmu_pmu->on_cpu = target;
> -	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(target)));
> +	if (irq_set_affinity(smmu_pmu->irq, cpumask_of(target)))
> +		dev_err(smmu_pmu->dev, "Failed to set interrupt affinity\n");
>  
>  	return 0;
>  }
> @@ -892,7 +893,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>  
>  	/* Pick one CPU to be the preferred one to use */
>  	smmu_pmu->on_cpu = raw_smp_processor_id();
> -	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
> +	if (irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)))
> +		dev_err(dev, "Failed to set interrupt affinity\n");

In this case we have the option to fail probe.  Failing to set affinity means
we are broken anyway, so perhaps that is cleaner than carrying on.

As a side note, I wonder if other drivers could benefit from what I think
is a micro optimization to short cut calling the hp handlers when the
decision of which CPU is easy...

>  
>  	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
>  					       &smmu_pmu->node);
