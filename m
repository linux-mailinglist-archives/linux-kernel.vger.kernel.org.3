Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F764A7F48
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 07:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbiBCG0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 01:26:06 -0500
Received: from foss.arm.com ([217.140.110.172]:53246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234224AbiBCG0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 01:26:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2252B113E;
        Wed,  2 Feb 2022 22:26:05 -0800 (PST)
Received: from [10.163.44.35] (unknown [10.163.44.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5D933F774;
        Wed,  2 Feb 2022 22:26:02 -0800 (PST)
Subject: Re: [PATCH] coresight: trbe: Move check for kernelspace unmapped at
 EL0 to probe
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org
References: <20220201122212.3009461-1-sudeep.holla@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <01a43ba2-a633-f215-a688-2bda293b5a47@arm.com>
Date:   Thu, 3 Feb 2022 11:55:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220201122212.3009461-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/22 5:52 PM, Sudeep Holla wrote:
> Currently with the check present in the module initialisation, it shouts
> on all the systems irrespective of presence of coresight trace buffer
> extensions.

IIUC a system with CONFIG_CORESIGHT_TRBE enabled but without a TRBE DT
i.e "arm,trace-buffer-extension" complains about kernel space unmapping
at EL0 (even though it does not even really have TRBE HW to initialize).

> 
> Similar to Arm SPE perf driver, move the check for kernelspace unmapping
> when running at EL0 to the device probe instead of module initialisation.

Makes sense.

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: coresight@lists.linaro.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 276862c07e32..3fe2ce1ba5bf 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1423,6 +1423,11 @@ static int arm_trbe_device_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int ret;
>  

Could you please add a similar comment like SPE driver regarding how
the TRBE buffer will be inaccessible, if kernel gets unmapped at EL0
and trace capture will terminate.

> +	if (arm64_kernel_unmapped_at_el0()) {
> +		pr_err("TRBE wouldn't work if kernel gets unmapped at EL0\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
> @@ -1484,11 +1489,6 @@ static int __init arm_trbe_init(void)
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
