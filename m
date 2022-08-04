Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815A589CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbiHDNci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239905AbiHDNca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:32:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E1B045041
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:32:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5773311FB;
        Thu,  4 Aug 2022 06:32:24 -0700 (PDT)
Received: from [10.1.29.39] (FVFF763DQ05P.cambridge.arm.com [10.1.29.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636753F67D;
        Thu,  4 Aug 2022 06:32:22 -0700 (PDT)
Message-ID: <e5465f6f-d602-b4c3-e049-f25d0d1f3124@arm.com>
Date:   Thu, 4 Aug 2022 14:32:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] coresight: etm4x: Fix crash observed on Qcom ETM parts
 with 'Low power override'
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220803191236.3037591-1-bhupesh.sharma@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220803191236.3037591-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,


On 03/08/2022 20:12, Bhupesh Sharma wrote:
> Some Qualcomm ETM implementations require skipping powering up
> the trace unit, as the ETMs are in the same power domain as
> their CPU cores.
> 
> Via commit 5214b563588e ("coresight: etm4x: Add support for
> sysreg only devices"), the setting of 'skip_power_up' flag was
> moved after the 'etm4_init_arch_data' function is called, whereas
> the flag value is itself used inside the function. This causes
> a crash when ETM mode 'Low-power state behavior override' is set
> on some Qualcomm parts.
> 
> Fix the same.
> 

Thanks for the patch. The patch is correct. But please see my comment
below.

> Fixes: 5214b563588e ("coresight: etm4x: Add support for sysreg only devices")
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index d39660a3e50c..cf6254b87fd5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1943,6 +1943,16 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>   	init_arg.csa = &desc.access;
>   	init_arg.pid = etm_pid;
>   
> +	/*
> +	 * Some Qualcomm implementations require skipping powering up the trace unit,
> +	 * as the ETMs are in the same power domain as their CPU cores.
> +	 *
> +	 * Since the 'skip_power_up' flag is used inside 'etm4_init_arch_data' function,
> +	 * initialize it before the function is called.
> +	 */
> +	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> +		drvdata->skip_power_up = true;
> +
>   	if (smp_call_function_single(drvdata->cpu,
>   				etm4_init_arch_data,  &init_arg, 1))
>   		dev_err(dev, "ETM arch init failed\n");
> @@ -1951,8 +1961,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>   		return -EINVAL;
>   
>   	/* TRCPDCR is not accessible with system instructions. */
> -	if (!desc.access.io_mem ||
> -	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> +	if (!desc.access.io_mem)
>   		drvdata->skip_power_up = true;
>   

Please could you move this setting into "etm4_init_sysreg_access()" ? It 
looks a bit odd to split the check in the same function. Moving this to
the sysreg_access() makes it explicit.

Suzuki



>   	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);

