Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1699D4F329F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbiDEJis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 05:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbiDEIUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:20:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB8B3C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:18:48 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXgV63YyFz67ydH;
        Tue,  5 Apr 2022 16:17:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Apr 2022 10:18:46 +0200
Received: from [10.47.91.157] (10.47.91.157) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 09:18:45 +0100
Message-ID: <ba5aa606-54bf-e19f-39ba-a21998781a6c@huawei.com>
Date:   Tue, 5 Apr 2022 09:18:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/2] drivers/perf: hisi: Associate PMUs in SICL with
 CPUs online
To:     Qi Liu <liuqi115@huawei.com>, "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     Zhangshaokun <zhangshaokun@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220321070124.41338-1-liuqi115@huawei.com>
 <20220321070124.41338-2-liuqi115@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220321070124.41338-2-liuqi115@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.157]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 07:01, Qi Liu wrote:
> If a PMU is in SICL, we associate it with all CPUs online, rather

/s/in SICL/in a SICL/ [and all other places, including the code change], 
or maybe it is better mention "IO super cluster" as well for people who 
would not know or remember.

> than CPUs in the nearest SCCL.

You are not really saying why. I would mention that we do it as it is 
not appropiate to associate with a CPU die, and you can also mention 
problems that associating with a SICL creates.

Please also mention how changing FW definition is ok at this stage.

> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>   drivers/perf/hisilicon/hisi_uncore_pa_pmu.c | 18 +++++++-----------
>   drivers/perf/hisilicon/hisi_uncore_pmu.c    |  4 ++++
>   drivers/perf/hisilicon/hisi_uncore_pmu.h    |  1 +
>   3 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> index bad99d149172..54c604c0d404 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> @@ -258,13 +258,12 @@ static int hisi_pa_pmu_init_data(struct platform_device *pdev,
>   				   struct hisi_pmu *pa_pmu)
>   {
>   	/*
> -	 * Use the SCCL_ID and the index ID to identify the PA PMU,
> -	 * while SCCL_ID is the nearst SCCL_ID from this SICL and
> -	 * CPU core is chosen from this SCCL to manage this PMU.
> +	 * As PA PMU is in SICL, use the SICL_ID and the index ID

"a SICL"

> +	 * to identify the PA PMU.
>   	 */
>   	if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
> -				     &pa_pmu->sccl_id)) {
> -		dev_err(&pdev->dev, "Cannot read sccl-id!\n");
> +				     &pa_pmu->sicl_id)) {
> +		dev_err(&pdev->dev, "Cannot read sicl-id!\n");
>   		return -EINVAL;
>   	}
>   
> @@ -275,6 +274,7 @@ static int hisi_pa_pmu_init_data(struct platform_device *pdev,
>   	}
>   
>   	pa_pmu->ccl_id = -1;
> +	pa_pmu->sccl_id = -1;
>   
>   	pa_pmu->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(pa_pmu->base)) {
> @@ -399,13 +399,9 @@ static int hisi_pa_pmu_probe(struct platform_device *pdev)
>   	ret = hisi_pa_pmu_dev_probe(pdev, pa_pmu);
>   	if (ret)
>   		return ret;
> -	/*
> -	 * PA is attached in SICL and the CPU core is chosen to manage this
> -	 * PMU which is the nearest SCCL, while its SCCL_ID is greater than
> -	 * one with the SICL_ID.
> -	 */
> +
>   	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sicl%u_pa%u",
> -			      pa_pmu->sccl_id - 1, pa_pmu->index_id);
> +			      pa_pmu->sicl_id, pa_pmu->index_id);
>   	if (!name)
>   		return -ENOMEM;
>   
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index a738aeab5c04..31930166c34b 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -458,6 +458,10 @@ static bool hisi_pmu_cpu_is_associated_pmu(struct hisi_pmu *hisi_pmu)
>   {
>   	int sccl_id, ccl_id;
>   
> +	/* If SCCL_ID is -1, the PMU is in SICL and can be associated this PMU with any CPU */

too long, just have "The PMU is in a SICL and has no CPU affinity"

> +	if (hisi_pmu->sccl_id == -1)
> +		return true;
> +
>   	if (hisi_pmu->ccl_id == -1) {
>   		/* If CCL_ID is -1, the PMU only shares the same SCCL */
>   		hisi_read_sccl_and_ccl_id(&sccl_id, NULL);
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> index 7f5841d6f592..96eeddad55ff 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> @@ -81,6 +81,7 @@ struct hisi_pmu {
>   	struct device *dev;
>   	struct hlist_node node;
>   	int sccl_id;
> +	int sicl_id;
>   	int ccl_id;
>   	void __iomem *base;
>   	/* the ID of the PMU modules */

