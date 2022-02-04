Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FE64A9270
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356615AbiBDCuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:50:37 -0500
Received: from foss.arm.com ([217.140.110.172]:35958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356697AbiBDCuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:50:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B2AB147A;
        Thu,  3 Feb 2022 18:50:32 -0800 (PST)
Received: from [10.163.45.195] (unknown [10.163.45.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88AFD3F774;
        Thu,  3 Feb 2022 18:50:28 -0800 (PST)
Subject: Re: [PATCH v2] coresight: trbe: Move check for kernel page table
 isolation from EL0 to probe
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org
References: <20220203190159.3145272-1-sudeep.holla@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ede31a2c-2d5b-88bd-9687-848eee2a0040@arm.com>
Date:   Fri, 4 Feb 2022 08:20:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220203190159.3145272-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/22 12:31 AM, Sudeep Holla wrote:
> Currently with the check present in the module initialisation, it shouts
> on all the systems irrespective of presence of coresight trace buffer
> extensions.
> 
> Similar to Arm SPE perf driver, move the check for kernel page table
> isolation from  EL0 to the device probe stage instead of the module
> initialisation so that it complains only on the systems that support TRBE.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: coresight@lists.linaro.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> v1[1]->v2:
> 	- Added comment about trace capture being not possible with kernel
> 	  page table isolation
> [1] https://lore.kernel.org/r/20220201122212.3009461-1-sudeep.holla@arm.com
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 276862c07e32..3e37a63cb7d2 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1423,6 +1423,12 @@ static int arm_trbe_device_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int ret;
>  
> +	/* Trace capture is not possible with kernel page table isolation */
> +	if (arm64_kernel_unmapped_at_el0()) {
> +		pr_err("TRBE wouldn't work if kernel gets unmapped at EL0\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
> @@ -1484,11 +1490,6 @@ static int __init arm_trbe_init(void)
>  {
>  	int ret;
>  
> -	if (arm64_kernel_unmapped_at_el0()) {
> -		pr_err("TRBE wouldn't work if kernel gets unmapped at EL0\n");
> -		return -EOPNOTSUPP;
> -	}
> -
>  	ret = platform_driver_register(&arm_trbe_driver);
>  	if (!ret)
>  		return 0;
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
