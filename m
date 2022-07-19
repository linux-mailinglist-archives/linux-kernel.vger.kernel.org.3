Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4198B57A5C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiGSRvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbiGSRvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:51:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EA27564D4;
        Tue, 19 Jul 2022 10:51:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 931091570;
        Tue, 19 Jul 2022 10:51:37 -0700 (PDT)
Received: from [10.57.42.173] (unknown [10.57.42.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 609693F766;
        Tue, 19 Jul 2022 10:51:35 -0700 (PDT)
Message-ID: <5875dacd-1431-210f-485d-0d47a3d3066f@arm.com>
Date:   Tue, 19 Jul 2022 18:51:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/13] coresight: stm: Update STM driver to use Trace
 ID API
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <20220704081149.16797-4-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220704081149.16797-4-mike.leach@linaro.org>
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

On 04/07/2022 09:11, Mike Leach wrote:
> Updates the STM driver to use the trace ID allocation API.
> This uses the _system_id calls to allocate an ID on device poll,
> and release on device remove.
> 
> The sysfs access to the STMTRACEIDR register has been changed from RW
> to RO. Having this value as writable is not appropriate for the new
> Trace ID scheme - and had potential to cause errors in the previous
> scheme if values clashed with other sources.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>



> ---
>   drivers/hwtracing/coresight/coresight-stm.c | 41 +++++++--------------
>   1 file changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index bb14a3a8a921..9ef3e923a930 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -31,6 +31,7 @@
>   #include <linux/stm.h>
>   
>   #include "coresight-priv.h"
> +#include "coresight-trace-id.h"
>   
>   #define STMDMASTARTR			0xc04
>   #define STMDMASTOPR			0xc08
> @@ -615,24 +616,7 @@ static ssize_t traceid_show(struct device *dev,
>   	val = drvdata->traceid;
>   	return sprintf(buf, "%#lx\n", val);
>   }
> -
> -static ssize_t traceid_store(struct device *dev,
> -			     struct device_attribute *attr,
> -			     const char *buf, size_t size)
> -{
> -	int ret;
> -	unsigned long val;
> -	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -
> -	ret = kstrtoul(buf, 16, &val);
> -	if (ret)
> -		return ret;
> -
> -	/* traceid field is 7bit wide on STM32 */
> -	drvdata->traceid = val & 0x7f;
> -	return size;
> -}
> -static DEVICE_ATTR_RW(traceid);
> +static DEVICE_ATTR_RO(traceid);
>   
>   #define coresight_stm_reg(name, offset)	\
>   	coresight_simple_reg32(struct stm_drvdata, name, offset)
> @@ -819,14 +803,6 @@ static void stm_init_default_data(struct stm_drvdata *drvdata)
>   	 */
>   	drvdata->stmsper = ~0x0;
>   
> -	/*
> -	 * The trace ID value for *ETM* tracers start at CPU_ID * 2 + 0x10 and
> -	 * anything equal to or higher than 0x70 is reserved.  Since 0x00 is
> -	 * also reserved the STM trace ID needs to be higher than 0x00 and
> -	 * lowner than 0x10.
> -	 */
> -	drvdata->traceid = 0x1;
> -
>   	/* Set invariant transaction timing on all channels */
>   	bitmap_clear(drvdata->chs.guaranteed, 0, drvdata->numsp);
>   }
> @@ -854,7 +830,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
>   
>   static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>   {
> -	int ret;
> +	int ret, trace_id;
>   	void __iomem *base;
>   	struct device *dev = &adev->dev;
>   	struct coresight_platform_data *pdata = NULL;
> @@ -938,12 +914,22 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>   		goto stm_unregister;
>   	}
>   
> +	trace_id = coresight_trace_id_get_system_id();
> +	if (trace_id < 0) {
> +		ret = trace_id;
> +		goto cs_unregister;
> +	}
> +	drvdata->traceid = (u8)trace_id;
> +
>   	pm_runtime_put(&adev->dev);
>   
>   	dev_info(&drvdata->csdev->dev, "%s initialized\n",
>   		 (char *)coresight_get_uci_data(id));
>   	return 0;
>   
> +cs_unregister:
> +	coresight_unregister(drvdata->csdev);
> +
>   stm_unregister:
>   	stm_unregister_device(&drvdata->stm);
>   	return ret;
> @@ -953,6 +939,7 @@ static void stm_remove(struct amba_device *adev)
>   {
>   	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>   
> +	coresight_trace_id_put_system_id(drvdata->traceid);

This makes think that, we should add a WARN_ON() in

	coresight_trace_id_put_system_id(id)
	{

		WARN_ON(!coresight_trace_id_is_used(id));

	}

Anyways, for this patch:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

