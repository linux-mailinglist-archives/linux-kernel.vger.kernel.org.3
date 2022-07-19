Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B157A92A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbiGSVpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiGSVpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:45:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 422791D5;
        Tue, 19 Jul 2022 14:45:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 821C21576;
        Tue, 19 Jul 2022 14:45:03 -0700 (PDT)
Received: from [10.57.42.173] (unknown [10.57.42.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 506003F70D;
        Tue, 19 Jul 2022 14:45:01 -0700 (PDT)
Message-ID: <36310209-f883-63b8-e0a4-f01509ad21d6@arm.com>
Date:   Tue, 19 Jul 2022 22:45:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 05/13] coresight: etm3x: Update ETM3 driver to use
 Trace ID API
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <20220704081149.16797-6-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220704081149.16797-6-mike.leach@linaro.org>
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
> Use the TraceID API to allocate ETM trace IDs dynamically.
> 
> As with the etm4x we allocate on enable / disable for perf,
> allocate on enable / reset for sysfs.
> 
> Additionally we allocate on sysfs file read as both perf and sysfs
> can read the ID before enabling the hardware.
> 
> Remove sysfs option to write trace ID - which is inconsistent with
> both the dynamic allocation method and the fixed allocation method
> previously used.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm.h   |  2 +
>   .../coresight/coresight-etm3x-core.c          | 68 +++++++++++++++++--
>   .../coresight/coresight-etm3x-sysfs.c         | 28 +++-----
>   3 files changed, 71 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
> index f3ab96eaf44e..3667428d38b6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm.h
> +++ b/drivers/hwtracing/coresight/coresight-etm.h
> @@ -287,4 +287,6 @@ int etm_get_trace_id(struct etm_drvdata *drvdata);
>   void etm_set_default(struct etm_config *config);
>   void etm_config_trace_mode(struct etm_config *config);
>   struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
> +int etm_read_alloc_trace_id(struct etm_drvdata *drvdata);
> +void etm_release_trace_id(struct etm_drvdata *drvdata);
>   #endif
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index d0ab9933472b..273f37be322b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -32,6 +32,7 @@
>   
>   #include "coresight-etm.h"
>   #include "coresight-etm-perf.h"
> +#include "coresight-trace-id.h"
>   
>   /*
>    * Not really modular but using module_param is the easiest way to
> @@ -490,18 +491,61 @@ static int etm_trace_id(struct coresight_device *csdev)
>   	return etm_get_trace_id(drvdata);
>   }
>   
> +int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
> +{
> +	int trace_id;
> +
> +	/*
> +	 * This will allocate a trace ID to the cpu,
> +	 * or return the one currently allocated.
> +	 */
> +	spin_lock(&drvdata->spinlock);
> +	trace_id = drvdata->traceid;
> +	if (!trace_id) {
> +		trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
> +		if (trace_id > 0)
> +			drvdata->traceid = (u8)trace_id;
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +
> +	if (trace_id <= 0)
> +		pr_err("Failed to allocate trace ID for %s on CPU%d\n",
> +		       dev_name(&drvdata->csdev->dev), drvdata->cpu);

dev_err(&drvdata->csdev->dev, ....)

> +
> +	return trace_id;
> +}
> +
> +void etm_release_trace_id(struct etm_drvdata *drvdata)
> +{
> +	spin_lock(&drvdata->spinlock);
> +	coresight_trace_id_put_cpu_id(drvdata->cpu);
> +	drvdata->traceid = 0;
> +	spin_unlock(&drvdata->spinlock);
> +}
> +
>   static int etm_enable_perf(struct coresight_device *csdev,
>   			   struct perf_event *event)
>   {
>   	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	int ret;
>   
>   	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
>   		return -EINVAL;
>   
>   	/* Configure the tracer based on the session's specifics */
>   	etm_parse_event_config(drvdata, event);
> +
> +	/* allocate a trace ID */
> +	ret = etm_read_alloc_trace_id(drvdata);
> +	if (ret < 0)
> +		return ret;
> +
>   	/* And enable it */
> -	return etm_enable_hw(drvdata);
> +	ret = etm_enable_hw(drvdata);
> +
> +	if (ret)
> +		etm_release_trace_id(drvdata);
> +	return ret;
>   }
>   
>   static int etm_enable_sysfs(struct coresight_device *csdev)
> @@ -510,6 +554,11 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
>   	struct etm_enable_arg arg = { };
>   	int ret;
>   
> +	/* allocate a trace ID */
> +	ret = etm_read_alloc_trace_id(drvdata);
> +	if (ret < 0)
> +		return ret;
> +
>   	spin_lock(&drvdata->spinlock);
>   
>   	/*
> @@ -532,6 +581,8 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
>   
>   	if (!ret)
>   		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
> +	else
> +		etm_release_trace_id(drvdata);
>   	return ret;
>   }
>   
> @@ -611,6 +662,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
>   	coresight_disclaim_device_unlocked(csdev);
>   
>   	CS_LOCK(drvdata->base);
> +
> +	etm_release_trace_id(drvdata);
>   }
>   
>   static void etm_disable_sysfs(struct coresight_device *csdev)
> @@ -635,6 +688,13 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
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
> @@ -781,11 +841,6 @@ static void etm_init_arch_data(void *info)
>   	CS_LOCK(drvdata->base);
>   }
>   
> -static void etm_init_trace_id(struct etm_drvdata *drvdata)
> -{
> -	drvdata->traceid = coresight_get_trace_id(drvdata->cpu);
> -}
> -
>   static int __init etm_hp_setup(void)
>   {
>   	int ret;
> @@ -871,7 +926,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>   	if (etm_arch_supported(drvdata->arch) == false)
>   		return -EINVAL;
>   
> -	etm_init_trace_id(drvdata);
>   	etm_set_default(&drvdata->config);
>   
>   	pdata = coresight_get_platform_data(dev);
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 68fcbf4ce7a8..962d6ac96d64 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -86,6 +86,8 @@ static ssize_t reset_store(struct device *dev,
>   
>   		etm_set_default(config);
>   		spin_unlock(&drvdata->spinlock);
> +		/* release trace id outside the spinlock as this fn uses it */
> +		etm_release_trace_id(drvdata);
>   	}
>   
>   	return size;
> @@ -1189,30 +1191,16 @@ static DEVICE_ATTR_RO(cpu);
>   static ssize_t traceid_show(struct device *dev,
>   			    struct device_attribute *attr, char *buf)
>   {
> -	unsigned long val;
> -	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -
> -	val = etm_get_trace_id(drvdata);
> -
> -	return sprintf(buf, "%#lx\n", val);
> -}
> -
> -static ssize_t traceid_store(struct device *dev,
> -			     struct device_attribute *attr,
> -			     const char *buf, size_t size)
> -{
> -	int ret;
> -	unsigned long val;
> +	int trace_id;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   
> -	ret = kstrtoul(buf, 16, &val);
> -	if (ret)
> -		return ret;
> +	trace_id = etm_read_alloc_trace_id(drvdata);
> +	if (trace_id < 0)
> +		return trace_id;
>   
> -	drvdata->traceid = val & ETM_TRACEID_MASK;
> -	return size;
> +	return sprintf(buf, "%#x\n", trace_id);

nit: while at this, please could we switch to sysfs_emit(). Rest looks
fine to me.

Suzuki
