Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3C4E7DBA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiCYUB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiCYUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:01:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1146209A4E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:51:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v4so8408188pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oTqzv2UPtujHVYpyZcLI/63OCpmQDxQw7bKSYRwCs5k=;
        b=wv7nxNPLSfH619eceF5nO0VS9wqz79VjQTUAQpN7SWrxh2GL9x9E+GVi60fcwHo3rO
         mwzAevP90yjtLlAINPGdqxxh8PjOgSjNiOv0oKuJaMNrEqK0SCTs+t041AdIStpzuszN
         e24MxfM7syCr9vtmSJQxyo4u5PWOBLhU2aLm92RKBJC2PoD6NkB/GCkBuGlUBt0Z0K+n
         euBVSnCemWbG73hwLgDodtT3ZnQ6ECLp0N1MQe4jC8eTWbTdE1Lxr7bKmF4A42aOHKpj
         fTzF0lAMb3EmT8lPN57v15yS7zOTX1vGvSNEkZZXlf3AGoLYzTGALPrisrlHLBTEd8Un
         TwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTqzv2UPtujHVYpyZcLI/63OCpmQDxQw7bKSYRwCs5k=;
        b=CcTSPkCloXBPiVcfxJurMmKyvUVYkHJ73a6RHNg66HWzg+BPF5Pq2rigrnzAyjGRrr
         vpyvu8ot4vuh3IzknYKeL3gN0wGbr3yKCxliO+FWAPg/Rs0ZQpe2lVaOHS6t+zIOLR5D
         XubjcfVSjJZHHx1sVVZld0tHmByZfRjVggsl+SUrIOpG7BDSapZf16Yu3kGk0OzI8mhI
         +GP3T4kUN+/C7+NuamAm9e78FEXEjy7uFcjrKldwyP1AYi8fNpfzSaujlxbpQ0h3/XfD
         tyJyNZOa0zBflJ2pfqR9D/tasWB0ee4b6KTwNQklZmMDuGisBm5OZNl5BQSz4YXUmXGG
         m3HQ==
X-Gm-Message-State: AOAM5314nEfVmkn7kmtWIIGljs0/BYLnqANeofzNcrZN52TT0aCL9wGg
        A5c3omOPy4vKX4F8sflg/601TEtQGDmFzA==
X-Google-Smtp-Source: ABdhPJybadkw3hViCU03N1XlVUOkzDRcipdFGM9hD1BMpGH5sZQ1+Hoxn/p+NpUFwUKE9f/jeD0/Fw==
X-Received: by 2002:a17:902:e846:b0:154:3d19:c5ae with SMTP id t6-20020a170902e84600b001543d19c5aemr13313141plg.87.1648237890581;
        Fri, 25 Mar 2022 12:51:30 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c63-20020a624e42000000b004fa9ee41b7bsm7264857pfb.217.2022.03.25.12.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:51:29 -0700 (PDT)
Date:   Fri, 25 Mar 2022 13:51:27 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Subject: Re: [RFC PATCH v4 4/4] remoteproc: virtio: Create platform device
 for the remoteproc_virtio
Message-ID: <20220325195127.GD3576184@p14s>
References: <20220314170126.2333996-1-arnaud.pouliquen@foss.st.com>
 <20220314170126.2333996-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314170126.2333996-5-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 06:01:26PM +0100, Arnaud Pouliquen wrote:
> Define a platform driver to manage the remoteproc virtio device as
> a platform devices.
> 
> The platform device allows to pass rproc_vdev_data platform data to
> specify properties that are stored in the rproc_vdev structure.
> 
> Such approach will allow to preserve legacy remoteproc virtio device
> creation but also to probe the device using device tree mechanism.
> 
> remoteproc_virtio.c update:
>   - Add rproc_virtio_driver platform driver. The probe/remove ops replace
>     the rproc_rvdev_add_device/rproc_rvdev_remove_device functions.
>   - All reference to the rvdev->dev has been updated to rvdev-pdev->dev.
>   - rproc_rvdev_release is removed as associated to the rvdev device.
>   - The use of rvdev->kref counter is replaced by get/put_device on the
>     remoteproc virtio platform device.
>   - The vdev device no longer increments rproc device counter.
>     increment/decrement is done in rproc_virtio_probe/rproc_virtio_remove
>     function in charge of the vrings allocation/free.
> 
> remoteproc_core.c update:
>   Migrate from the rvdev device to the rvdev platform device.
>   From this patch, when a vdev resource is found in the resource table
>   the remoteproc core register a platform device.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> Update vs previous revision:
>   - remove useless platform_get_drvdata call in  rproc_handle_vdev function.
>     This call was a leftover from a previous version of the patch.
> ---
>  drivers/remoteproc/remoteproc_core.c     |  13 +-
>  drivers/remoteproc/remoteproc_internal.h |   3 -
>  drivers/remoteproc/remoteproc_virtio.c   | 151 +++++++++++------------
>  include/linux/remoteproc.h               |   6 +-
>  4 files changed, 83 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index c05c721c1f18..3cd624de8856 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -478,6 +478,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>  	struct device *dev = &rproc->dev;
>  	struct rproc_vdev *rvdev;
>  	struct rproc_vdev_data rvdev_data;
> +	struct platform_device *pdev;
>  
>  	/* make sure resource isn't truncated */
>  	if (struct_size(rsc, vring, rsc->num_of_vrings) + rsc->config_len >
> @@ -506,9 +507,13 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>  	rvdev_data.rsc_offset = offset;
>  	rvdev_data.rsc = rsc;
>  
> -	rvdev = rproc_rvdev_add_device(rproc, &rvdev_data);
> -	if (IS_ERR(rvdev))
> -		return PTR_ERR(rvdev);
> +	pdev = platform_device_register_data(dev, "rproc-virtio", rvdev_data.index, &rvdev_data,
> +					     sizeof(rvdev_data));
> +	if (IS_ERR(pdev)) {
> +		dev_err(rproc->dev.parent,
> +			"failed to create rproc-virtio device\n");
> +		return PTR_ERR(pdev);
> +	}

This patchset looks much cleaner now.  I'll take a final look at V5 and then we
can move on to the next installment.

Thanks,
Mathieu

>  
>  	return 0;
>  }
> @@ -1248,7 +1253,7 @@ void rproc_resource_cleanup(struct rproc *rproc)
>  
>  	/* clean up remote vdev entries */
>  	list_for_each_entry_safe(rvdev, rvtmp, &rproc->rvdevs, node)
> -		kref_put(&rvdev->refcount, rproc_vdev_release);
> +		platform_device_unregister(rvdev->pdev);
>  
>  	rproc_coredump_cleanup(rproc);
>  }
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index ba8ba36561f4..c8914002d0c9 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -45,10 +45,7 @@ int rproc_of_parse_firmware(struct device *dev, int index,
>  			    const char **fw_name);
>  
>  /* from remoteproc_virtio.c */
> -struct rproc_vdev *rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data);
> -void rproc_rvdev_remove_device(struct rproc_vdev *rvdev);
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> -void rproc_vdev_release(struct kref *ref);
>  
>  /* from remoteproc_debugfs.c */
>  void rproc_remove_trace_file(struct dentry *tfile);
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 581c3dd13cd4..e734067174f1 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -13,6 +13,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/export.h>
> +#include <linux/of_platform.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/remoteproc.h>
>  #include <linux/virtio.h>
> @@ -46,7 +47,11 @@ static int copy_dma_range_map(struct device *to, struct device *from)
>  
>  static struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
>  {
> -	return container_of(vdev->dev.parent, struct rproc_vdev, dev);
> +	struct platform_device *pdev;
> +
> +	pdev = container_of(vdev->dev.parent, struct platform_device, dev);
> +
> +	return platform_get_drvdata(pdev);
>  }
>  
>  static  struct rproc *vdev_to_rproc(struct virtio_device *vdev)
> @@ -341,13 +346,10 @@ static void rproc_virtio_dev_release(struct device *dev)
>  {
>  	struct virtio_device *vdev = dev_to_virtio(dev);
>  	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
> -	struct rproc *rproc = vdev_to_rproc(vdev);
>  
>  	kfree(vdev);
>  
> -	kref_put(&rvdev->refcount, rproc_vdev_release);
> -
> -	put_device(&rproc->dev);
> +	put_device(&rvdev->pdev->dev);
>  }
>  
>  /**
> @@ -363,7 +365,7 @@ static void rproc_virtio_dev_release(struct device *dev)
>  static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  {
>  	struct rproc *rproc = rvdev->rproc;
> -	struct device *dev = &rvdev->dev;
> +	struct device *dev = &rvdev->pdev->dev;
>  	struct virtio_device *vdev;
>  	struct rproc_mem_entry *mem;
>  	int ret;
> @@ -433,18 +435,8 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  	vdev->dev.parent = dev;
>  	vdev->dev.release = rproc_virtio_dev_release;
>  
> -	/*
> -	 * We're indirectly making a non-temporary copy of the rproc pointer
> -	 * here, because drivers probed with this vdev will indirectly
> -	 * access the wrapping rproc.
> -	 *
> -	 * Therefore we must increment the rproc refcount here, and decrement
> -	 * it _only_ when the vdev is released.
> -	 */
> -	get_device(&rproc->dev);
> -
>  	/* Reference the vdev and vring allocations */
> -	kref_get(&rvdev->refcount);
> +	get_device(dev);
>  
>  	ret = register_virtio_device(vdev);
>  	if (ret) {
> @@ -486,78 +478,57 @@ static int rproc_vdev_do_start(struct rproc_subdev *subdev)
>  static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
>  {
>  	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
> +	struct device *dev = &rvdev->pdev->dev;
>  	int ret;
>  
> -	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
> +	ret = device_for_each_child(dev, NULL, rproc_remove_virtio_dev);
>  	if (ret)
> -		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n", ret);
> -}
> -
> -/**
> - * rproc_rvdev_release() - release the existence of a rvdev
> - *
> - * @dev: the subdevice's dev
> - */
> -static void rproc_rvdev_release(struct device *dev)
> -{
> -	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
> -
> -	of_reserved_mem_device_release(dev);
> -
> -	kfree(rvdev);
> +		dev_warn(dev, "can't remove vdev child device: %d\n", ret);
>  }
>  
> -struct rproc_vdev *
> -rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
> +static int rproc_virtio_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
> +	struct rproc_vdev_data *rvdev_data = dev->platform_data;
>  	struct rproc_vdev *rvdev;
> -	struct fw_rsc_vdev *rsc = rvdev_data->rsc;
> -	char name[16];
> +	struct rproc *rproc = container_of(dev->parent, struct rproc, dev);
> +	struct fw_rsc_vdev *rsc;
>  	int i, ret;
>  
> -	rvdev = kzalloc(sizeof(*rvdev), GFP_KERNEL);
> -	if (!rvdev)
> -		return ERR_PTR(-ENOMEM);
> +	if (!rvdev_data)
> +		return -EINVAL;
>  
> -	kref_init(&rvdev->refcount);
> +	rvdev = devm_kzalloc(dev, sizeof(*rvdev), GFP_KERNEL);
> +	if (!rvdev)
> +		return -ENOMEM;
>  
>  	rvdev->id = rvdev_data->id;
>  	rvdev->rproc = rproc;
>  	rvdev->index = rvdev_data->index;
>  
> -	/* Initialise vdev subdevice */
> -	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> -	rvdev->dev.parent = &rproc->dev;
> -	rvdev->dev.release = rproc_rvdev_release;
> -	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> -	dev_set_drvdata(&rvdev->dev, rvdev);
> -
> -	ret = device_register(&rvdev->dev);
> -	if (ret) {
> -		put_device(&rvdev->dev);
> -		return ERR_PTR(ret);
> -	}
> -
> -	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
> +	ret = copy_dma_range_map(dev, rproc->dev.parent);
>  	if (ret)
> -		goto free_rvdev;
> +		return ret;
>  
>  	/* Make device dma capable by inheriting from parent's capabilities */
> -	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
> +	set_dma_ops(dev, get_dma_ops(rproc->dev.parent));
>  
> -	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
> -					   dma_get_mask(rproc->dev.parent));
> +	ret = dma_coerce_mask_and_coherent(dev, dma_get_mask(rproc->dev.parent));
>  	if (ret) {
> -		dev_warn(&rvdev->dev,
> -			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> +		dev_warn(dev, "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
>  			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
>  	}
>  
> +	platform_set_drvdata(pdev, rvdev);
> +	rvdev->pdev = pdev;
> +
> +	rsc = rvdev_data->rsc;
> +
>  	/* parse the vrings */
>  	for (i = 0; i < rsc->num_of_vrings; i++) {
>  		ret = rproc_parse_vring(rvdev, rsc, i);
>  		if (ret)
> -			goto free_rvdev;
> +			return ret;
>  	}
>  
>  	/* remember the resource offset*/
> @@ -577,18 +548,30 @@ rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
>  
>  	rproc_add_subdev(rproc, &rvdev->subdev);
>  
> -	return rvdev;
> +	dev_dbg(dev, "virtio dev %d added\n",  rvdev->index);
> +
> +	/*
> +	 * We're indirectly making a non-temporary copy of the rproc pointer
> +	 * here, because the platform devicer or the vdev device will indirectly
> +	 * access the wrapping rproc.
> +	 *
> +	 * Therefore we must increment the rproc refcount here, and decrement
> +	 * it _only_ on platform remove.
> +	 */
> +	get_device(&rproc->dev);
> +
> +	return 0;
>  
>  unwind_vring_allocations:
>  	for (i--; i >= 0; i--)
>  		rproc_free_vring(&rvdev->vring[i]);
> -free_rvdev:
> -	device_unregister(&rvdev->dev);
> -	return ERR_PTR(ret);
> +
> +	return ret;
>  }
>  
> -void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
> +static int rproc_virtio_remove(struct platform_device *pdev)
>  {
> +	struct rproc_vdev *rvdev = dev_get_drvdata(&pdev->dev);
>  	struct rproc *rproc = rvdev->rproc;
>  	struct rproc_vring *rvring;
>  	int id;
> @@ -600,19 +583,29 @@ void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
>  
>  	rproc_remove_subdev(rproc, &rvdev->subdev);
>  	rproc_remove_rvdev(rvdev);
> -	device_unregister(&rvdev->dev);
> -}
>  
> -void rproc_vdev_release(struct kref *ref)
> -{
> -	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
> -	struct rproc_vring *rvring;
> -	int id;
> +	of_reserved_mem_device_release(&pdev->dev);
>  
> -	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> -		rvring = &rvdev->vring[id];
> -		rproc_free_vring(rvring);
> -	}
> +	dev_dbg(&pdev->dev, "virtio dev %d removed\n",  rvdev->index);
>  
> -	rproc_rvdev_remove_device(rvdev);
> +	/* The remote proc device can be removed */
> +	put_device(&rproc->dev);
> +
> +	return 0;
>  }
> +
> +/* Platform driver */
> +static const struct of_device_id rproc_virtio_match[] = {
> +	{ .compatible = "rproc-virtio", },
> +	{},
> +};
> +
> +static struct platform_driver rproc_virtio_driver = {
> +	.probe		= rproc_virtio_probe,
> +	.remove		= rproc_virtio_remove,
> +	.driver		= {
> +		.name	= "rproc-virtio",
> +		.of_match_table	= rproc_virtio_match,
> +	},
> +};
> +builtin_platform_driver(rproc_virtio_driver);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 93a1d0050fbc..31577d6b405d 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -616,9 +616,8 @@ struct rproc_vring {
>  
>  /**
>   * struct rproc_vdev - remoteproc state for a supported virtio device
> - * @refcount: reference counter for the vdev and vring allocations
>   * @subdev: handle for registering the vdev as a rproc subdevice
> - * @dev: device struct used for reference count semantics
> + * @pdev: remoteproc virtio platform device
>   * @id: virtio device id (as in virtio_ids.h)
>   * @node: list node
>   * @rproc: the rproc handle
> @@ -627,10 +626,9 @@ struct rproc_vring {
>   * @index: vdev position versus other vdev declared in resource table
>   */
>  struct rproc_vdev {
> -	struct kref refcount;
>  
>  	struct rproc_subdev subdev;
> -	struct device dev;
> +	struct platform_device *pdev;
>  
>  	unsigned int id;
>  	struct list_head node;
> -- 
> 2.25.1
> 
