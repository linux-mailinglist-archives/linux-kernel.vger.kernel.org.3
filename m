Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8304F476B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355895AbiDEVLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572950AbiDERYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:24:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E8114012
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:22:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id kw18so63115pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=laM1f/S71ICTL1TD1U0zhVuyMXNKqPVUGfM/offuIZM=;
        b=v6TAHchqQbMhtlkYPAVee+zEOJ7r+t4eI6tYYWRuTywqS36cFphNgDrVD2Py6XO6JX
         VqVqFyCEJAg2aw7CJslt3nqlFx81BF3E6tLmTlsaQjarngYqzmm8sT6g447AvBw77Z5K
         I2PccuFl5jGkRBZHJDgt2sm12C++Pjc/9pFZck3PyK/KOXhyAbqf8fLn5Ua3qjdp37zM
         Nc8eAAIpD6uTCyuozjMAAFaNufKrmpmr5eKyJ2rr8TfYTnwNMvTZS+FJLWLRQZl2Xhl/
         sQk1Dip9c/vYXWFsv4jxalhD2V0TQAeUzvtvhCvCzMRbUfelvRrG6h5duA9+D/e8sF+z
         8Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=laM1f/S71ICTL1TD1U0zhVuyMXNKqPVUGfM/offuIZM=;
        b=KoQOWEqP4UX0o0VIuCDSNVusiQxbFm6aJXGoPRKU3ognMH6rzXBA+X1Weu+ajCcmsR
         l4EDNtiGj7gwwKTaV7JxHIIi8Opcq+hYle0ZqAqlcLSpjF0syYL24XY409MmPBQ72onZ
         HwJXEuObFLrI2RblZJ3vLfQlJWLFZWQRXRyHARWUEXbANnDQ51rm9ggOm4G13Y3W0xc8
         oTbSgunR1nNYSkLGWmdIBLtsP6t21KeRQ7oGKx3c/nnLjl29mQFODlmrVOUgUJJBLOFO
         Pa4uMTkxhaihn/7er4GkdUvLeSHqm58Aj3tvCSTMQ91hZC6IvVbWdaOqVqGLqHByL2Pm
         fgBA==
X-Gm-Message-State: AOAM530/p4JiasZ18mPtcc3OYWQL3oLHX0TuRjfBMC6LbSs24qDpOG3Y
        VNYq1sGH+L2zfyjos+6ihXRfOA==
X-Google-Smtp-Source: ABdhPJxEYOml8rHEZLl5woVjHpWk88FIVHHT7m9ZkuZBSDa3BCoF2H5aNhHmPrs6HKu5yGlfFr3kKA==
X-Received: by 2002:a17:90b:3e8b:b0:1c7:852d:e843 with SMTP id rj11-20020a17090b3e8b00b001c7852de843mr5255268pjb.244.1649179324572;
        Tue, 05 Apr 2022 10:22:04 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090ad3c400b001c65ba76911sm2989210pjw.3.2022.04.05.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:22:03 -0700 (PDT)
Date:   Tue, 5 Apr 2022 11:22:00 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org
Subject: Re: [PATCH 05/10] coresight: etm3x: Use trace ID API to allocate IDs
Message-ID: <20220405172200.GB4151723@p14s>
References: <20220308205000.27646-1-mike.leach@linaro.org>
 <20220308205000.27646-6-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308205000.27646-6-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 08:49:55PM +0000, Mike Leach wrote:
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
>  drivers/hwtracing/coresight/coresight-etm.h   |  2 +
>  .../coresight/coresight-etm3x-core.c          | 72 ++++++++++++++++---
>  .../coresight/coresight-etm3x-sysfs.c         | 28 +++-----
>  3 files changed, 71 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
> index f3ab96eaf44e..3667428d38b6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm.h
> +++ b/drivers/hwtracing/coresight/coresight-etm.h
> @@ -287,4 +287,6 @@ int etm_get_trace_id(struct etm_drvdata *drvdata);
>  void etm_set_default(struct etm_config *config);
>  void etm_config_trace_mode(struct etm_config *config);
>  struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
> +int etm_read_alloc_trace_id(struct etm_drvdata *drvdata);
> +void etm_release_trace_id(struct etm_drvdata *drvdata);
>  #endif
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 7d413ba8b823..98213503bd09 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -32,6 +32,7 @@
>  
>  #include "coresight-etm.h"
>  #include "coresight-etm-perf.h"
> +#include "coresight-trace-id.h"
>  
>  /*
>   * Not really modular but using module_param is the easiest way to
> @@ -490,18 +491,57 @@ static int etm_trace_id(struct coresight_device *csdev)
>  	return etm_get_trace_id(drvdata);
>  }
>  
> +int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
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
> +		drvdata->traceid = (u8)trace_id;
> +		spin_unlock(&drvdata->spinlock);
> +	} else {
> +		pr_err("Failed to allocate trace ID for %s on CPU%d\n",
> +		       dev_name(&drvdata->csdev->dev), drvdata->cpu);
> +	}
> +	return trace_id;
> +}
> +
> +void etm_release_trace_id(struct etm_drvdata *drvdata)
> +{
> +	coresight_trace_id_put_cpu_id(drvdata->cpu,
> +				      coresight_get_trace_id_map());
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->traceid = 0;
> +	spin_unlock(&drvdata->spinlock);
> +}
> +
>  static int etm_enable_perf(struct coresight_device *csdev,
>  			   struct perf_event *event)
>  {
>  	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	int ret;
>  
>  	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
>  		return -EINVAL;
>  
> +	ret = etm_read_alloc_trace_id(drvdata);
> +	if (ret < 0)
> +		return ret;
>

For etm4x, this was done after etm_parse_event_config().  Please do the same
here.


>  	/* Configure the tracer based on the session's specifics */
>  	etm_parse_event_config(drvdata, event);
>  	/* And enable it */
> -	return etm_enable_hw(drvdata);
> +	ret = etm_enable_hw(drvdata);
> +
> +	if (ret)
> +		etm_release_trace_id(drvdata);
> +	return ret;
>  }
>  
>  static int etm_enable_sysfs(struct coresight_device *csdev)
> @@ -510,6 +550,10 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
>  	struct etm_enable_arg arg = { };
>  	int ret;
>  
> +	ret = etm_read_alloc_trace_id(drvdata);
> +	if (ret < 0)
> +		return ret;
> +

Please add the same comment as in etm4_disable_sysfs() in etm_disable_sysfs().

>  	spin_lock(&drvdata->spinlock);
>  
>  	/*
> @@ -532,6 +576,8 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
>  
>  	if (!ret)
>  		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
> +	else
> +		etm_release_trace_id(drvdata);
>  	return ret;
>  }
>  
> @@ -611,6 +657,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
>  	coresight_disclaim_device_unlocked(csdev);
>  
>  	CS_LOCK(drvdata->base);
> +
> +	etm_release_trace_id(drvdata);
>  }
>  
>  static void etm_disable_sysfs(struct coresight_device *csdev)
> @@ -781,11 +829,6 @@ static void etm_init_arch_data(void *info)
>  	CS_LOCK(drvdata->base);
>  }
>  
> -static void etm_init_trace_id(struct etm_drvdata *drvdata)
> -{
> -	drvdata->traceid = coresight_get_trace_id(drvdata->cpu);
> -}
> -
>  static int __init etm_hp_setup(void)
>  {
>  	int ret;
> @@ -871,7 +914,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (etm_arch_supported(drvdata->arch) == false)
>  		return -EINVAL;
>  
> -	etm_init_trace_id(drvdata);
>  	etm_set_default(&drvdata->config);
>  
>  	pdata = coresight_get_platform_data(dev);
> @@ -891,10 +933,12 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(drvdata->csdev);
>  
>  	ret = etm_perf_symlink(drvdata->csdev, true);
> -	if (ret) {
> -		coresight_unregister(drvdata->csdev);
> -		return ret;
> -	}
> +	if (ret)
> +		goto cs_unregister;
> +
> +	ret = etm_read_alloc_trace_id(drvdata);
> +	if (ret < 0)
> +		goto cs_unregister;
>  
>  	etmdrvdata[drvdata->cpu] = drvdata;
>  
> @@ -907,6 +951,10 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  	}
>  
>  	return 0;
> +
> +cs_unregister:
> +	coresight_unregister(drvdata->csdev);
> +	return ret;
>  }
>  
>  static void clear_etmdrvdata(void *info)
> @@ -922,6 +970,8 @@ static void etm_remove(struct amba_device *adev)
>  
>  	etm_perf_symlink(drvdata->csdev, false);
>  
> +	etm_release_trace_id(drvdata);
> +
>  	/*
>  	 * Taking hotplug lock here to avoid racing between etm_remove and
>  	 * CPU hotplug call backs.
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index e8c7649f123e..3ee70b174240 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -86,6 +86,8 @@ static ssize_t reset_store(struct device *dev,
>  
>  		etm_set_default(config);
>  		spin_unlock(&drvdata->spinlock);
> +		/* release trace id outside the spinlock as this fn uses it */
> +		etm_release_trace_id(drvdata);
>  	}
>  
>  	return size;
> @@ -1189,30 +1191,16 @@ static DEVICE_ATTR_RO(cpu);
>  static ssize_t traceid_show(struct device *dev,
>  			    struct device_attribute *attr, char *buf)
>  {
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
>  	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
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
>  }
> -static DEVICE_ATTR_RW(traceid);
> +static DEVICE_ATTR_RO(traceid);
>  
>  static struct attribute *coresight_etm_attrs[] = {
>  	&dev_attr_nr_addr_cmp.attr,
> -- 
> 2.17.1
> 
