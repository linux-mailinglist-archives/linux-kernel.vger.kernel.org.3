Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5731E57A91E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbiGSVlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiGSVlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:41:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D831F2019E;
        Tue, 19 Jul 2022 14:41:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 010E71576;
        Tue, 19 Jul 2022 14:41:38 -0700 (PDT)
Received: from [10.57.42.173] (unknown [10.57.42.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C38E63F70D;
        Tue, 19 Jul 2022 14:41:36 -0700 (PDT)
Message-ID: <d3f3d49e-015d-9419-e98b-115c67b258ea@arm.com>
Date:   Tue, 19 Jul 2022 22:41:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 04/13] coresight: etm4x: Update ETM4 driver to use
 Trace ID API
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <20220704081149.16797-5-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220704081149.16797-5-mike.leach@linaro.org>
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
> The trace ID API is now used to allocate trace IDs for ETM4.x / ETE
> devices.
> 
> For perf sessions, these will be allocated on enable, and released on
> disable.
> 
> For sysfs sessions, these will be allocated on enable, but only released
> on reset. This allows the sysfs session to interrogate the Trace ID used
> after the session is over - maintaining functional consistency with the
> previous allocation scheme.
> 
> The trace ID will also be allocated on read of the mgmt/trctraceid file.
> This ensures that if perf or sysfs read this before enabling trace, the
> value will be the one used for the trace session.
> 
> Trace ID initialisation is removed from the _probe() function.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   .../coresight/coresight-etm4x-core.c          | 65 +++++++++++++++++--
>   .../coresight/coresight-etm4x-sysfs.c         | 32 ++++++++-
>   drivers/hwtracing/coresight/coresight-etm4x.h |  3 +
>   3 files changed, 91 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 87299e99dabb..3f4f7ddd14ec 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -42,6 +42,7 @@
>   #include "coresight-etm4x-cfg.h"
>   #include "coresight-self-hosted-trace.h"
>   #include "coresight-syscfg.h"
> +#include "coresight-trace-id.h"
>   
>   static int boot_enable;
>   module_param(boot_enable, int, 0444);
> @@ -234,6 +235,38 @@ static int etm4_trace_id(struct coresight_device *csdev)
>   	return drvdata->trcid;
>   }
>   
> +int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
> +{
> +	int trace_id;
> +
> +	/*
> +	 * This will allocate a trace ID to the cpu,
> +	 * or return the one currently allocated.
> +	 */
> +	spin_lock(&drvdata->spinlock);
> +	trace_id = drvdata->trcid;
> +	if (!trace_id) {
> +		trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
> +		if (trace_id > 0)
> +			drvdata->trcid = (u8)trace_id;
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +
> +	if (trace_id <= 0)
> +		pr_err("Failed to allocate trace ID for %s on CPU%d\n",
> +		       dev_name(&drvdata->csdev->dev), drvdata->cpu);

dev_err(&drvdata->csdev->dev, ....);

> +
> +	return trace_id;
> +}
> +
> +void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
> +{
> +	spin_lock(&drvdata->spinlock);
> +	coresight_trace_id_put_cpu_id(drvdata->cpu);
> +	drvdata->trcid = 0;
> +	spin_unlock(&drvdata->spinlock);
> +}
> +
>   struct etm4_enable_arg {
>   	struct etmv4_drvdata *drvdata;
>   	int rc;
> @@ -715,9 +748,18 @@ static int etm4_enable_perf(struct coresight_device *csdev,
>   	ret = etm4_parse_event_config(csdev, event);
>   	if (ret)
>   		goto out;
> +
> +	/* allocate a trace ID */
> +	ret =  etm4_read_alloc_trace_id(drvdata);
> +	if (ret < 0)
> +		goto out;
> +
>   	/* And enable it */
>   	ret = etm4_enable_hw(drvdata);
>   
> +	/* failed to enable */
> +	if (ret)
> +		etm4_release_trace_id(drvdata);
>   out:
>   	return ret;
>   }
> @@ -737,6 +779,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
>   			return ret;
>   	}
>   
> +	/* allocate a trace ID */
> +	ret = etm4_read_alloc_trace_id(drvdata);
> +	if (ret < 0)
> +		return ret;
> +
>   	spin_lock(&drvdata->spinlock);
>   
>   	/*
> @@ -754,6 +801,8 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
>   
>   	if (!ret)
>   		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
> +	else
> +		etm4_release_trace_id(drvdata);
>   	return ret;
>   }
>   
> @@ -881,6 +930,9 @@ static int etm4_disable_perf(struct coresight_device *csdev,
>   	/* TRCVICTLR::SSSTATUS, bit[9] */
>   	filters->ssstatus = (control & BIT(9));
>   
> +	/* release trace ID - this may pend release if perf session is still active */
> +	etm4_release_trace_id(drvdata);
> +
>   	return 0;
>   }
>   
> @@ -906,6 +958,13 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
>   	spin_unlock(&drvdata->spinlock);
>   	cpus_read_unlock();
>   
> +	/*
> +	 * unlike for perf session - we only release trace IDs when resetting
> +	 * sysfs. This permits sysfs users to read the trace ID after the trace
> +	 * session has completed. This maintains operational behaviour with
> +	 * prior trace id allocation method
> +	 */
> +
>   	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
>   }
>   
> @@ -1548,11 +1607,6 @@ static int etm4_dying_cpu(unsigned int cpu)
>   	return 0;
>   }
>   
> -static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
> -{
> -	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
> -}
> -
>   static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
>   {
>   	int i, ret = 0;
> @@ -1957,7 +2011,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>   	if (!desc.name)
>   		return -ENOMEM;
>   
> -	etm4_init_trace_id(drvdata);
>   	etm4_set_default(&drvdata->config);
>   
>   	pdata = coresight_get_platform_data(dev);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 6ea8181816fc..c7f896a020d9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -266,10 +266,11 @@ static ssize_t reset_store(struct device *dev,
>   	config->vmid_mask0 = 0x0;
>   	config->vmid_mask1 = 0x0;
>   
> -	drvdata->trcid = drvdata->cpu + 1;
> -
>   	spin_unlock(&drvdata->spinlock);
>   
> +	/* for sysfs - only release trace id when resetting */
> +	etm4_release_trace_id(drvdata);
> +
>   	cscfg_csdev_reset_feats(to_coresight_device(dev));
>   
>   	return size;
> @@ -2363,6 +2364,31 @@ static struct attribute *coresight_etmv4_attrs[] = {
>   	NULL,
>   };
>   
> +/*
> + * Trace ID allocated dynamically on enable - but also allocate on read
> + * in case sysfs or perf read before enable to ensure consistent metadata
> + * information for trace decode
> + */
> +static ssize_t trctraceid_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	int trace_id;
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	trace_id = etm4_read_alloc_trace_id(drvdata);
> +	if (trace_id < 0)
> +		return trace_id;
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%x\n", trace_id);

nit: sysfs_emit(buf, "0x%x\n", trace_id);


> +}
> +
> +/* mgmt group uses extended attributes - no standard macro available */

That doesn't prevent us from using dev_attribute for traceid.
In the end, mgmt group is a collection of "struct attribute *".
All it matters is for the "show" function to decode how to print
the value from the "attribute".

You should be able to use DEVICE_ATTR_RO here ...

> +static struct dev_ext_attribute dev_attr_trctraceid = {
> +		__ATTR(trctraceid, 0444, trctraceid_show, NULL),
> +		(void *)(unsigned long)TRCTRACEIDR > +};
> +

... and get rid of this. Otherwise looks fine to me.

Suzuki


>   struct etmv4_reg {
>   	struct coresight_device *csdev;
>   	u32 offset;
> @@ -2499,7 +2525,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
>   	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
>   	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
>   	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
> -	coresight_etm4x_reg(trctraceid, TRCTRACEIDR),
> +	&dev_attr_trctraceid.attr.attr,
>   	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
>   	NULL,
>   };
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 33869c1d20c3..e0a9d334375d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -1094,4 +1094,7 @@ static inline bool etm4x_is_ete(struct etmv4_drvdata *drvdata)
>   {
>   	return drvdata->arch >= ETM_ARCH_ETE;
>   }
> +
> +int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata);
> +void etm4_release_trace_id(struct etmv4_drvdata *drvdata);
>   #endif

