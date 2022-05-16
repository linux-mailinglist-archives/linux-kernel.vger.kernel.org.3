Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFB252870E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbiEPObM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244456AbiEPOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:30:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6440110AE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:30:52 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L21rR0f8wz6H6vH;
        Mon, 16 May 2022 22:30:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 16:30:50 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 15:30:49 +0100
Date:   Mon, 16 May 2022 15:30:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chen Jun <chenjun102@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <xuqiang36@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 1/1] perf: hisi: Extract hisi_pmu_init
Message-ID: <20220516153048.00007f62@Huawei.com>
In-Reply-To: <20220516131601.48383-1-chenjun102@huawei.com>
References: <20220516131601.48383-1-chenjun102@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 13:16:01 +0000
Chen Jun <chenjun102@huawei.com> wrote:

> Extract the initialization code of hisi_pmu->pmu into a function
> 
> Signed-off-by: Chen Jun <chenjun102@huawei.com>

Hi Chen Jun,

If you are going to do this (and I think the stats speak for it being
a good idea), then also look at whether the various exports and
header definitions for the callbacks are all needed any more.

I checked just hisi_uncore_pmu_del and that one at least is
private to hisi_uncore_pmu.c after this patch.
With those cleaned up as well the argument for removing this duplication
will be even stronger!

Thanks,

Jonathan

> ---
>  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 16 +---------------
>  drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 16 +---------------
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 16 +---------------
>  drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   | 16 +---------------
>  drivers/perf/hisilicon/hisi_uncore_pmu.c      | 18 ++++++++++++++++++
>  drivers/perf/hisilicon/hisi_uncore_pmu.h      |  2 ++
>  drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 15 +--------------
>  7 files changed, 25 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> index 62299ab5a9be..50d0c0a2f1fe 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> @@ -516,21 +516,7 @@ static int hisi_ddrc_pmu_probe(struct platform_device *pdev)
>  				      "hisi_sccl%u_ddrc%u", ddrc_pmu->sccl_id,
>  				      ddrc_pmu->index_id);
>  
> -	ddrc_pmu->pmu = (struct pmu) {
> -		.name		= name,
> -		.module		= THIS_MODULE,
> -		.task_ctx_nr	= perf_invalid_context,
> -		.event_init	= hisi_uncore_pmu_event_init,
> -		.pmu_enable	= hisi_uncore_pmu_enable,
> -		.pmu_disable	= hisi_uncore_pmu_disable,
> -		.add		= hisi_uncore_pmu_add,
> -		.del		= hisi_uncore_pmu_del,
> -		.start		= hisi_uncore_pmu_start,
> -		.stop		= hisi_uncore_pmu_stop,
> -		.read		= hisi_uncore_pmu_read,
> -		.attr_groups	= ddrc_pmu->pmu_events.attr_groups,
> -		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> -	};
> +	hisi_pmu_init(&ddrc_pmu->pmu, name, ddrc_pmu->pmu_events.attr_groups, THIS_MODULE);
>  
>  	ret = perf_pmu_register(&ddrc_pmu->pmu, name, -1);
>  	if (ret) {
> diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> index 393513150106..13017b3412a5 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> @@ -519,21 +519,7 @@ static int hisi_hha_pmu_probe(struct platform_device *pdev)
>  
>  	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_hha%u",
>  			      hha_pmu->sccl_id, hha_pmu->index_id);
> -	hha_pmu->pmu = (struct pmu) {
> -		.name		= name,
> -		.module		= THIS_MODULE,
> -		.task_ctx_nr	= perf_invalid_context,
> -		.event_init	= hisi_uncore_pmu_event_init,
> -		.pmu_enable	= hisi_uncore_pmu_enable,
> -		.pmu_disable	= hisi_uncore_pmu_disable,
> -		.add		= hisi_uncore_pmu_add,
> -		.del		= hisi_uncore_pmu_del,
> -		.start		= hisi_uncore_pmu_start,
> -		.stop		= hisi_uncore_pmu_stop,
> -		.read		= hisi_uncore_pmu_read,
> -		.attr_groups	= hha_pmu->pmu_events.attr_groups,
> -		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> -	};
> +	hisi_pmu_init(&hha_pmu->pmu, name, hha_pmu->pmu_events.attr_groups, THIS_MODULE);
>  
>  	ret = perf_pmu_register(&hha_pmu->pmu, name, -1);
>  	if (ret) {
> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> index 560ab964c8b5..2995f3630d49 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> @@ -557,21 +557,7 @@ static int hisi_l3c_pmu_probe(struct platform_device *pdev)
>  	 */
>  	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_l3c%u",
>  			      l3c_pmu->sccl_id, l3c_pmu->ccl_id);
> -	l3c_pmu->pmu = (struct pmu) {
> -		.name		= name,
> -		.module		= THIS_MODULE,
> -		.task_ctx_nr	= perf_invalid_context,
> -		.event_init	= hisi_uncore_pmu_event_init,
> -		.pmu_enable	= hisi_uncore_pmu_enable,
> -		.pmu_disable	= hisi_uncore_pmu_disable,
> -		.add		= hisi_uncore_pmu_add,
> -		.del		= hisi_uncore_pmu_del,
> -		.start		= hisi_uncore_pmu_start,
> -		.stop		= hisi_uncore_pmu_stop,
> -		.read		= hisi_uncore_pmu_read,
> -		.attr_groups	= l3c_pmu->pmu_events.attr_groups,
> -		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> -	};
> +	hisi_pmu_init(&l3c_pmu->pmu, name, l3c_pmu->pmu_events.attr_groups, THIS_MODULE);
>  
>  	ret = perf_pmu_register(&l3c_pmu->pmu, name, -1);
>  	if (ret) {
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> index bad99d149172..2103fb5ee7bb 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> @@ -416,21 +416,7 @@ static int hisi_pa_pmu_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	pa_pmu->pmu = (struct pmu) {
> -		.module		= THIS_MODULE,
> -		.task_ctx_nr	= perf_invalid_context,
> -		.event_init	= hisi_uncore_pmu_event_init,
> -		.pmu_enable	= hisi_uncore_pmu_enable,
> -		.pmu_disable	= hisi_uncore_pmu_disable,
> -		.add		= hisi_uncore_pmu_add,
> -		.del		= hisi_uncore_pmu_del,
> -		.start		= hisi_uncore_pmu_start,
> -		.stop		= hisi_uncore_pmu_stop,
> -		.read		= hisi_uncore_pmu_read,
> -		.attr_groups    = pa_pmu->pmu_events.attr_groups,
> -		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> -	};
> -
> +	hisi_pmu_init(&pa_pmu->pmu, name, pa_pmu->pmu_events.attr_groups, THIS_MODULE);
>  	ret = perf_pmu_register(&pa_pmu->pmu, name, -1);
>  	if (ret) {
>  		dev_err(pa_pmu->dev, "PMU register failed, ret = %d\n", ret);
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index 358e4e284a62..5dd2694dbdf8 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -527,4 +527,22 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  }
>  EXPORT_SYMBOL_GPL(hisi_uncore_pmu_offline_cpu);
>  
> +void hisi_pmu_init(struct pmu *pmu, const char *name,
> +		const struct attribute_group **attr_groups, struct module *module)
> +{
> +	pmu->name               = name;
> +	pmu->module             = module;
> +	pmu->task_ctx_nr        = perf_invalid_context;
> +	pmu->event_init         = hisi_uncore_pmu_event_init;
> +	pmu->pmu_enable         = hisi_uncore_pmu_enable;
> +	pmu->pmu_disable        = hisi_uncore_pmu_disable;
> +	pmu->add                = hisi_uncore_pmu_add;
> +	pmu->del                = hisi_uncore_pmu_del;
> +	pmu->start              = hisi_uncore_pmu_start;
> +	pmu->stop               = hisi_uncore_pmu_stop;
> +	pmu->read               = hisi_uncore_pmu_read;
> +	pmu->attr_groups        = attr_groups;
> +}
> +EXPORT_SYMBOL_GPL(hisi_pmu_init);
> +
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> index 7f5841d6f592..6e2523e4aa36 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> @@ -120,4 +120,6 @@ ssize_t hisi_uncore_pmu_identifier_attr_show(struct device *dev,
>  int hisi_uncore_pmu_init_irq(struct hisi_pmu *hisi_pmu,
>  			     struct platform_device *pdev);
>  
> +void hisi_pmu_init(struct pmu *pmu, const char *name,
> +		const struct attribute_group **attr_groups, struct module *module);
>  #endif /* __HISI_UNCORE_PMU_H__ */
> diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> index 6aedc303ff56..b9c79f17230c 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> @@ -445,20 +445,7 @@ static int hisi_sllc_pmu_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	sllc_pmu->pmu = (struct pmu) {
> -		.module		= THIS_MODULE,
> -		.task_ctx_nr	= perf_invalid_context,
> -		.event_init	= hisi_uncore_pmu_event_init,
> -		.pmu_enable	= hisi_uncore_pmu_enable,
> -		.pmu_disable	= hisi_uncore_pmu_disable,
> -		.add		= hisi_uncore_pmu_add,
> -		.del		= hisi_uncore_pmu_del,
> -		.start		= hisi_uncore_pmu_start,
> -		.stop		= hisi_uncore_pmu_stop,
> -		.read		= hisi_uncore_pmu_read,
> -		.attr_groups    = sllc_pmu->pmu_events.attr_groups,
> -		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> -	};
> +	hisi_pmu_init(&sllc_pmu->pmu, name, sllc_pmu->pmu_events.attr_groups, THIS_MODULE);
>  
>  	ret = perf_pmu_register(&sllc_pmu->pmu, name, -1);
>  	if (ret) {

