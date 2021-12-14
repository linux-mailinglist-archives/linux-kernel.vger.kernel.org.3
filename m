Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073C2474AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhLNSaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhLNSaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:30:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539D2C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:30:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h24so15086055pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=adse3EIR35Uf+lf66SvUeI3tyqQCADIho0L/iNAPaOs=;
        b=qBMehjJwxPsyNRCu6BeQsrQMuteZkbI4V8dw4VGGSpMy7H/RGx6Ia1ywuQbx6b5L5+
         iV92o1OTjOa4ZAzX4owZUK8wxeCbrxf2ew4txpuLibpxDE7kwFEH3jE3xkc4G+KD/UW+
         u2D+QTGRxSIjWLrFZJcSpXXDvtLTq3WbhvFUz632qtRa35epe/SAIODkRwNZDJdiMYRu
         9zYSa/UHpGwgC33sOafJk0D6cNuj31uvUWha5+/dfNZ/3PL2qhOEKwny/NwKLTRpUxrb
         Lu8XprrJs6kwbpwXQ/jzxWzl0dLYeB75SJSVN0R16Opcol1IwbxhdkaKZ6mU9ABnfs0F
         Yi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=adse3EIR35Uf+lf66SvUeI3tyqQCADIho0L/iNAPaOs=;
        b=jH2D3JOr0I4OGsZeOM+ZjiU95lOiCJZyL+oaTmGP5BUtDHMBcehBrktPj4bbTh8zVv
         8TyeKdZVwv1HnW5EZCr9wskcUJrtjrwAXor2iFGtzdwtHjroI59pqwIimmy4X1aUfWYP
         vVLO7L/Mr4BynDKZwiow3uweQgho/9xg8nSGOiGyhDFwwHcpDFuOLK4F07a2A2Ak9VFL
         dm/pE4wk5n+Hv/QrgklygMTXaMAu1aD8mrN79qynjlE4XXRgIMPslW07v6cWEkuLfUE5
         4vEEfyHgP/gBTDdOPdtLmA3tsXyw+Z3pO6yDZICba513ivCRXGX9RjQUxxD9WnRp3JLJ
         B86g==
X-Gm-Message-State: AOAM533rNKei1UFttAhhbhu0kO043LKCb8k+zA02syg2GdX9JMN0jOU2
        SA6qu7l49LbJ3V0SpqyLMfU+QA==
X-Google-Smtp-Source: ABdhPJw0gzcdzcZQ0+5+cP7HWwjrBHGKYkf/ItZ4YiR+W8E4GMIRP8FbSR/YQnKLgeB0RSoH8a6sVA==
X-Received: by 2002:a17:902:e74a:b0:142:114c:1f1e with SMTP id p10-20020a170902e74a00b00142114c1f1emr7491424plf.78.1639506614701;
        Tue, 14 Dec 2021 10:30:14 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s28sm542173pfg.147.2021.12.14.10.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:30:13 -0800 (PST)
Date:   Tue, 14 Dec 2021 11:30:10 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/9] Use IDR to maintain all the enabled sources'
 paths.
Message-ID: <20211214183010.GA1549991@p14s>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
 <20211209141543.21314-2-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209141543.21314-2-quic_jinlmao@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mao,

On Thu, Dec 09, 2021 at 10:15:35PM +0800, Mao Jinlong wrote:
> Use hash length of the source's device name to map to the pointer
> of the enabled path. Using IDR will be more efficient than using
> the list. And there could be other sources except STM and CPU etms
> in the new HWs. It is better to maintain all the paths together.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 76 +++++++-------------
>  1 file changed, 26 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 8a18c71df37a..cc6b6cabf85f 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -7,6 +7,7 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
> +#include <linux/idr.h>
>  #include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> @@ -26,6 +27,12 @@
>  static DEFINE_MUTEX(coresight_mutex);
>  static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
>  
> +/*
> + * Use IDR to map the hash length of the source's device name
> + * to the pointer of path for the source
> + */
> +static DEFINE_IDR(path_idr);
> +
>  /**
>   * struct coresight_node - elements of a path, from source to sink
>   * @csdev:	Address of an element.
> @@ -36,20 +43,6 @@ struct coresight_node {
>  	struct list_head link;
>  };
>  
> -/*
> - * When operating Coresight drivers from the sysFS interface, only a single
> - * path can exist from a tracer (associated to a CPU) to a sink.
> - */
> -static DEFINE_PER_CPU(struct list_head *, tracer_path);
> -
> -/*
> - * As of this writing only a single STM can be found in CS topologies.  Since
> - * there is no way to know if we'll ever see more and what kind of
> - * configuration they will enact, for the time being only define a single path
> - * for STM.
> - */
> -static struct list_head *stm_path;
> -
>  /*
>   * When losing synchronisation a new barrier packet needs to be inserted at the
>   * beginning of the data collected in a buffer.  That way the decoder knows that
> @@ -1088,10 +1081,11 @@ static int coresight_validate_source(struct coresight_device *csdev,
>  
>  int coresight_enable(struct coresight_device *csdev)
>  {
> -	int cpu, ret = 0;
> +	int ret = 0;
>  	struct coresight_device *sink;
>  	struct list_head *path;
>  	enum coresight_dev_subtype_source subtype;
> +	u32 hash;
>  
>  	subtype = csdev->subtype.source_subtype;
>  
> @@ -1133,26 +1127,14 @@ int coresight_enable(struct coresight_device *csdev)
>  	if (ret)
>  		goto err_source;
>  
> -	switch (subtype) {
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> -		/*
> -		 * When working from sysFS it is important to keep track
> -		 * of the paths that were created so that they can be
> -		 * undone in 'coresight_disable()'.  Since there can only
> -		 * be a single session per tracer (when working from sysFS)
> -		 * a per-cpu variable will do just fine.
> -		 */
> -		cpu = source_ops(csdev)->cpu_id(csdev);
> -		per_cpu(tracer_path, cpu) = path;
> -		break;
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> -		stm_path = path;
> -		break;
> -	default:
> -		/* We can't be here */
> -		break;
> -	}
> -
> +	/*
> +	 * Use the hash length of source's device name as ID
> +	 * and map the ID to the pointer of the path.
> +	 */
> +	hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
> +	ret = idr_alloc_u32(&path_idr, path, &hash, hash, GFP_KERNEL);
> +	if (ret)
> +		goto err_source;
>  out:
>  	mutex_unlock(&coresight_mutex);
>  	return ret;
> @@ -1168,8 +1150,9 @@ EXPORT_SYMBOL_GPL(coresight_enable);
>  
>  void coresight_disable(struct coresight_device *csdev)
>  {
> -	int cpu, ret;
> +	int ret;
>  	struct list_head *path = NULL;
> +	u32 hash;
>  
>  	mutex_lock(&coresight_mutex);
>  
> @@ -1180,21 +1163,13 @@ void coresight_disable(struct coresight_device *csdev)
>  	if (!csdev->enable || !coresight_disable_source(csdev))
>  		goto out;
>  
> -	switch (csdev->subtype.source_subtype) {
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> -		cpu = source_ops(csdev)->cpu_id(csdev);
> -		path = per_cpu(tracer_path, cpu);
> -		per_cpu(tracer_path, cpu) = NULL;
> -		break;
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> -		path = stm_path;
> -		stm_path = NULL;
> -		break;
> -	default:
> -		/* We can't be here */
> -		break;
> -	}
> +	hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
> +	/* Find the path by the hash length. */
> +	path = idr_find(&path_idr, hash);
> +	if (path == NULL)
> +		return;

Please add a dev_err() here as this should really not be happening.

>  
> +	idr_remove(&path_idr, hash);
>  	coresight_disable_path(path);
>  	coresight_release_path(path);
>  
> @@ -1779,6 +1754,7 @@ static int __init coresight_init(void)
>  
>  static void __exit coresight_exit(void)
>  {
> +	idr_destroy(&path_idr);

As far as I can tell this isn't needed.

>  	cscfg_exit();
>  	etm_perf_exit();
>  	bus_unregister(&coresight_bustype);
> -- 
> 2.17.1
> 
