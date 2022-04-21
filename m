Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602EE50A6BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390609AbiDURQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiDURQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:16:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F3049F16
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:13:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so6303795wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t9kx/kpBHIRHJF5Ta8VXVNIlkSe6PaiEDU5Ov3KqXBk=;
        b=d4B1RMfWECwtoWYYvT65Wgr5vxqjzt3ftXOaVgpq7ZkpLJIMv0UX/vF5PcCtGMmZ96
         Lcmrvhpwa17FjzkPXncVded4mGmRbYdXqGaXsML0hbLT98CzeRdb1Jg0S0Y/MaIWotdI
         AVO04YOupaanZC6EHBfjicyIUkBiqJndp+kD+UpxCm0JOuRKTSAMNHnf9hNgQmJ8ZIyS
         e1RCUqAVs0FBpVBuYTWkKcaVHk/SDcx7+d3Yy8vxy8/3+W2XFOoq3Jd+vLL8azyINu+y
         qnRxplo6Gb1esD+Gjpibu1LoahVr4bqdAMgUt9gBi1HK9CsGaSDfPRdob0gxUtf1Q08h
         85Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t9kx/kpBHIRHJF5Ta8VXVNIlkSe6PaiEDU5Ov3KqXBk=;
        b=4BQFJrl1lX2PhSX/iW19w+/192jLFU+bvO83wt9sZV13dh+G5ylZwEj5E3iU1RdBBY
         Io2MJiP2nbUEoZ/RPo0KJFaNtGtmJjPJH+QK1d0JZ/tt6Wb8BpU1mFt490W4xwcupmt0
         /ALifsMLyYRyj01mHHjavrtB2IMCOkZqexwIPhcZnhpzcW+pn7cs6yQvkBVrm3FSRSLI
         cTM4n2/ZwVn+qSW1doJ9CF8/ZdJxVAKXSZHaI3GDNh26OXN8COMxQbpeLAoBhLvzzEqn
         rSwlGXKgURH4o+YRUo/UZv54zmd6/WtTIZwVmPcf5c0snbp4J4eIPMBJWvPVL4zPmeJQ
         67iw==
X-Gm-Message-State: AOAM531f+8ZpYRIgSv7H3U+X+TsF8tJJ8ir8DIUIblvespsScCqfzxEa
        GVQHbxqJgr9eIMf+v7HAQgAGkQ==
X-Google-Smtp-Source: ABdhPJx94l//WJnxf1x9I9ICVu3B7WTWZyYnYQFGGftuQa3e2LPt/atN6vGk0psS2bdMi48D2aYoIg==
X-Received: by 2002:a05:600c:19cd:b0:392:1419:9d2 with SMTP id u13-20020a05600c19cd00b00392141909d2mr9673336wmq.64.1650561191512;
        Thu, 21 Apr 2022 10:13:11 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d45cb000000b0020a810f7726sm2674852wrs.5.2022.04.21.10.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:13:10 -0700 (PDT)
Date:   Thu, 21 Apr 2022 18:12:45 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        sven@svenpeter.dev, robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] iommu/virtio: Clean up bus_set_iommu()
Message-ID: <YmGQjYZMtaqSf87a@myrica>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <4db34a35e07f3741a658465045b78c96a569c591.1649935679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db34a35e07f3741a658465045b78c96a569c591.1649935679.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 01:42:41PM +0100, Robin Murphy wrote:
> Stop calling bus_set_iommu() since it's now unnecessary, and simplify
> the probe failure path accordingly.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 25be4b822aa0..371f8657c0ce 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -7,7 +7,6 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/amba/bus.h>
>  #include <linux/delay.h>
>  #include <linux/dma-iommu.h>
>  #include <linux/dma-map-ops.h>

<linux/platform_device.h> isn't needed anymore either. In any case it
looks great, thanks

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

and tested on QEMU (so only PCI for now)


> @@ -1146,26 +1145,6 @@ static int viommu_probe(struct virtio_device *vdev)
>  
>  	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
>  
> -#ifdef CONFIG_PCI
> -	if (pci_bus_type.iommu_ops != &viommu_ops) {
> -		ret = bus_set_iommu(&pci_bus_type, &viommu_ops);
> -		if (ret)
> -			goto err_unregister;
> -	}
> -#endif
> -#ifdef CONFIG_ARM_AMBA
> -	if (amba_bustype.iommu_ops != &viommu_ops) {
> -		ret = bus_set_iommu(&amba_bustype, &viommu_ops);
> -		if (ret)
> -			goto err_unregister;
> -	}
> -#endif
> -	if (platform_bus_type.iommu_ops != &viommu_ops) {
> -		ret = bus_set_iommu(&platform_bus_type, &viommu_ops);
> -		if (ret)
> -			goto err_unregister;
> -	}
> -
>  	vdev->priv = viommu;
>  
>  	dev_info(dev, "input address: %u bits\n",
> @@ -1174,9 +1153,6 @@ static int viommu_probe(struct virtio_device *vdev)
>  
>  	return 0;
>  
> -err_unregister:
> -	iommu_device_sysfs_remove(&viommu->iommu);
> -	iommu_device_unregister(&viommu->iommu);
>  err_free_vqs:
>  	vdev->config->del_vqs(vdev);
>  
> -- 
> 2.28.0.dirty
> 
