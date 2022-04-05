Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24C04F50C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843230AbiDFBkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572958AbiDER1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:27:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EC18389
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:25:18 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c2so11548967pga.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JThxN3YQ6Zf+pLkY5Zt80QDrJIFQKIt8/YfNiENnZF8=;
        b=MreWEiuJ6o2ixbibHbRwUwRn4ya0RezBs8dGAMh1KmHHR8mUxUjS/uxYMHvgsoUnGB
         vuc8qZ91YZHzCJVjEuaOlgoPF8y4gHnO/+cSsAsstSxEFAIU/pse7ckWfOWw7PMC+Tuy
         /1oNeDMM3nx/Xfy7j3QWjGeeL+72bPdRkj0lAkF2gQFVe4HMYmpIn2lLBUHIJjp7oTfa
         3dmteXnNwI9/iz9qLeM5AkQ24/4Yx6jthzekAHDPdBuQkfK7G1pGCGXRdJ4tRVptJnTE
         Yz8kYfTbI2/VkgVMDC0HM6XINM3nASb/mBfqXlFW0rW9o0d2QNKJKr3z8ajA2cXf6gli
         OL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JThxN3YQ6Zf+pLkY5Zt80QDrJIFQKIt8/YfNiENnZF8=;
        b=nJyNqEMuxK+re3Xl5UM4Vv/FuPoaEG5lzQy/2aMNZl6C6/mF6zjpBlxhiol+0mxieu
         /dnNyDd9dxYYx4KV0SVQAGDilHPT2tgaQHj1mjXX1gPSSEDMRXGeNS0naynRK8vVpuKL
         x3shQyWwWwAZju6rMlEBy1E6YeJr54ItrwP8I89qWWGtCEJmGonsht9JsMGBNlC2zqYm
         WArxqfAM3LnuJUqJKX6oPde1AnYwsWfuVRccXhD/Y1M5EjRhS2rCLRWvPrZ3YgCPTT8N
         4HqJW76ri8dAaKmu+q66rptmv+3elhHFRCyqcTiU/pWS5HYcdyQ5k/oNOdzsN7WfaHGB
         79mA==
X-Gm-Message-State: AOAM531ZoXjRT5rh1eEwOvIF37Hwz0gJdlb/ukMpPLNSa3gOzT9/atYZ
        R0kSKzsDvY3FRCqDYYqPBpS0rg==
X-Google-Smtp-Source: ABdhPJyUqvvqo786nXRYDjlTsm2uQAdJMVTnSbFdwsL9HhQtdRybsAgvv0At19XEa+dgh13raxVRVA==
X-Received: by 2002:a05:6a00:b51:b0:4fa:ece9:15e4 with SMTP id p17-20020a056a000b5100b004faece915e4mr4625127pfo.27.1649179517799;
        Tue, 05 Apr 2022 10:25:17 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y3-20020a056a00190300b004fa2411bb92sm17056294pfi.93.2022.04.05.10.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:25:16 -0700 (PDT)
Date:   Tue, 5 Apr 2022 11:25:14 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org
Subject: Re: [PATCH 04/10] coresight: etm4x: Use trace ID API to dynamically
 allocate trace ID
Message-ID: <20220405172514.GC4151723@p14s>
References: <20220308205000.27646-1-mike.leach@linaro.org>
 <20220308205000.27646-5-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308205000.27646-5-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 08:49:54PM +0000, Mike Leach wrote:
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
>  .../coresight/coresight-etm4x-core.c          | 63 +++++++++++++++++--
>  .../coresight/coresight-etm4x-sysfs.c         | 32 +++++++++-
>  drivers/hwtracing/coresight/coresight-etm4x.h |  3 +
>  3 files changed, 89 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 7f416a12000e..aa7ea5ad8b06 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -42,6 +42,7 @@
>  #include "coresight-etm4x-cfg.h"
>  #include "coresight-self-hosted-trace.h"
>  #include "coresight-syscfg.h"
> +#include "coresight-trace-id.h"
>  
>  static int boot_enable;
>  module_param(boot_enable, int, 0444);
> @@ -234,6 +235,36 @@ static int etm4_trace_id(struct coresight_device *csdev)
>  	return drvdata->trcid;
>  }
>  
> +int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
> +{
> +	int trace_id;
> +
> +	/*
> +	 * This will allocate a trace ID to the cpu,
> +	 * or return the one currently allocated.
> +	 */
> +	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu,
> +						 coresight_get_trace_id_map());
> +	if (trace_id > 0) {
> +		spin_lock(&drvdata->spinlock);
> +		drvdata->trcid = (u8)trace_id;
> +		spin_unlock(&drvdata->spinlock);
> +	} else {
> +		pr_err("Failed to allocate trace ID for %s on CPU%d\n",
> +		       dev_name(&drvdata->csdev->dev), drvdata->cpu);
> +	}
> +	return trace_id;
> +}
> +
> +void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
> +{
> +	coresight_trace_id_put_cpu_id(drvdata->cpu,
> +				      coresight_get_trace_id_map());
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->trcid = 0;
> +	spin_unlock(&drvdata->spinlock);
> +}
> +
>  struct etm4_enable_arg {
>  	struct etmv4_drvdata *drvdata;
>  	int rc;
> @@ -717,9 +748,18 @@ static int etm4_enable_perf(struct coresight_device *csdev,
>  	ret = etm4_parse_event_config(csdev, event);
>  	if (ret)
>  		goto out;
> +
> +	/* allocate a trace ID */
> +	ret =  etm4_read_alloc_trace_id(drvdata);
> +	if (ret < 0)
> +		goto out;
> +
>  	/* And enable it */
>  	ret = etm4_enable_hw(drvdata);
>  
> +	/* failed to enable */
> +	if (ret)
> +		etm4_release_trace_id(drvdata);
>  out:
>  	return ret;
>  }
> @@ -739,6 +779,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
>  			return ret;
>  	}
>  
> +	/* allocate a trace ID */
> +	ret = etm4_read_alloc_trace_id(drvdata);
> +	if (ret < 0)
> +		return ret;
> +
>  	spin_lock(&drvdata->spinlock);
>  
>  	/*
> @@ -756,6 +801,8 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
>  
>  	if (!ret)
>  		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
> +	else
> +		etm4_release_trace_id(drvdata);
>  	return ret;
>  }
>  
> @@ -883,6 +930,9 @@ static int etm4_disable_perf(struct coresight_device *csdev,
>  	/* TRCVICTLR::SSSTATUS, bit[9] */
>  	filters->ssstatus = (control & BIT(9));
>  
> +	/* release trace ID - this may pend release if perf session is still active */
> +	etm4_release_trace_id(drvdata);
> +
>  	return 0;
>  }
>  
> @@ -908,6 +958,13 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
>  	spin_unlock(&drvdata->spinlock);
>  	cpus_read_unlock();
>  
> +	/*
> +	 * unlike for perf session - we only release trace IDs when resetting
> +	 * sysfs. This permits sysfs users to read the trace ID after the trace
> +	 * session has completed. This maintains operational behaviour with
> +	 * prior trace id allocation method
> +	 */
> +
>  	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
>  }
>  
> @@ -1596,11 +1653,6 @@ static int etm4_dying_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
> -{
> -	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
> -}
> -
>  static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  {
>  	int i, ret = 0;
> @@ -2005,7 +2057,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>  	if (!desc.name)
>  		return -ENOMEM;
>  
> -	etm4_init_trace_id(drvdata);
>  	etm4_set_default(&drvdata->config);
>  
>  	pdata = coresight_get_platform_data(dev);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 21687cc1e4e2..bb69a203b833 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -266,10 +266,11 @@ static ssize_t reset_store(struct device *dev,
>  	config->vmid_mask0 = 0x0;
>  	config->vmid_mask1 = 0x0;
>  
> -	drvdata->trcid = drvdata->cpu + 1;
> -

That was really broken...  I'm surprised we never caught it before this
patchset. 

More comments to come tomorrow.

Thanks,
Mathieu

>  	spin_unlock(&drvdata->spinlock);
>  
> +	/* for sysfs - only release trace id when resetting */
> +	etm4_release_trace_id(drvdata);
> +
>  	cscfg_csdev_reset_feats(to_coresight_device(dev));
>  
>  	return size;
> @@ -2355,6 +2356,31 @@ static struct attribute *coresight_etmv4_attrs[] = {
>  	NULL,
>  };
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
> +}
> +
> +/* mgmt group uses extended attributes - no standard macro available */
> +static struct dev_ext_attribute dev_attr_trctraceid = {
> +		__ATTR(trctraceid, 0444, trctraceid_show, NULL),
> +		(void *)(unsigned long)TRCTRACEIDR
> +};
> +
>  struct etmv4_reg {
>  	struct coresight_device *csdev;
>  	u32 offset;
> @@ -2491,7 +2517,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
>  	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
>  	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
>  	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
> -	coresight_etm4x_reg(trctraceid, TRCTRACEIDR),
> +	&dev_attr_trctraceid.attr.attr,
>  	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
>  	NULL,
>  };
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 3c4d69b096ca..64976a00c839 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -1010,4 +1010,7 @@ static inline bool etm4x_is_ete(struct etmv4_drvdata *drvdata)
>  {
>  	return drvdata->arch >= ETM_ARCH_ETE;
>  }
> +
> +int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata);
> +void etm4_release_trace_id(struct etmv4_drvdata *drvdata);
>  #endif
> -- 
> 2.17.1
> 
