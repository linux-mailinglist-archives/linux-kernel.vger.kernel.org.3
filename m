Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6884556743C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiGEQ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGEQ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:28:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C944518353
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:28:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so13103372pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dkJGfHe/DruH+yNZnEoZ2rO+RTZETE6CsEiEU+sQltI=;
        b=B/M7CqvaqnoTzoDxLxvBjerHXIER+XkC1uyFxNbgBrcqQ1l/JEqAzE3uGHCedCHMMu
         ZzTcCTfYPOZBu7Ori51W5Vpc6J+TdmRcOt+7dSl8xQ+aih3AtABsmzdO3WL019Z7NsVv
         YOE43Y+76+okaqp6Yjt1228PA6OZYtv2l+1CuokE/KG0CFgS+ig4V5A4SIJ2opfi4PsD
         paH3ARn6C7DUMRMOpe8JZ2HinLfyRgPRbhKnl2uhc+UuAKWp3R9cS+bB5f3FHJc1etK9
         atBGxCJ2zXDZI9jj3ufDVXEGaqHluL10jadxl/Wi8LCrbxuLZj32mcBCE3kil/w1YfnZ
         ltyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dkJGfHe/DruH+yNZnEoZ2rO+RTZETE6CsEiEU+sQltI=;
        b=8EoMtgthpkYNOtDhUZ6zH3OhbMjP6oGKz1/+GbDTZU9PLe8a63VwPQNc90BHQ8fSXL
         FLEqP0n3Qf9o3wO11mJfeykwgZNnhIGn0Wxzw7K/f6nrgIocnQyDoVyoC28zu8yOabxX
         TBQaytKzA5VRPYX90LJtDtNj53t4OMn7XaHpkRay53G7Dof70AbAmt6r17u7fNun/Aha
         wA+DCiWL0dEtKrlFIf2sJ+i6ddyOnCWb6p5zLpdolR8BqOJfqPa1i3R1xof/SI++mABZ
         GYhB5zjf5lLqOeUS6Bf9XWdsYOPuCnLVi4gKcsc9tVPXhgjZoQR/uUWN4176FXCBJSvU
         oo3A==
X-Gm-Message-State: AJIora+d+NWQHWmht1OYEoJHqDlKEx1dj578BIMzrk3q6tQ7QbQiB7Nv
        plF5tUYfqmil59B+l5JNlORxyQ==
X-Google-Smtp-Source: AGRyM1uLkTVYs4Pn7a22feaUTvlUhj6sPjcMpJtDHTua7rC2uS6XT22QiDoiBiIkLNdtKs/tmoH3bg==
X-Received: by 2002:a17:903:185:b0:16a:6113:c01 with SMTP id z5-20020a170903018500b0016a61130c01mr44310620plg.113.1657038534255;
        Tue, 05 Jul 2022 09:28:54 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a4-20020a62bd04000000b00525714c3e07sm23021221pff.48.2022.07.05.09.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:28:52 -0700 (PDT)
Date:   Tue, 5 Jul 2022 10:28:50 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Subject: Re: [PATCH v6 4/4] remoteproc: virtio: Create platform device for
 the remoteproc_virtio
Message-ID: <20220705162850.GE2440144@p14s>
References: <20220603163158.612513-1-arnaud.pouliquen@foss.st.com>
 <20220603163158.612513-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603163158.612513-5-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 06:31:58PM +0200, Arnaud Pouliquen wrote:
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

Function rproc_rvdev_remove_device() no longer exists.

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
> Updates vs previous revision (based on Mathieu Poirier's comments):
>   - remoteteproc_virtio:
>     - remove debug print on probe and remove
>     - remove wriong comment on put_device(&rproc->dev), the get is
>       already commented
>   - remoteproc_core:
>     - fix dev_err() device parameter.
> ---
>  drivers/remoteproc/remoteproc_core.c     |  12 +-
>  drivers/remoteproc/remoteproc_internal.h |   3 -
>  drivers/remoteproc/remoteproc_virtio.c   | 141 ++++++++++++-----------
>  include/linux/remoteproc.h               |   6 +-
>  4 files changed, 81 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index bd6d3f2decc6..81c4deef2895 100644
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
> @@ -506,9 +507,12 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>  	rvdev_data.rsc_offset = offset;
>  	rvdev_data.rsc = rsc;
>  
> -	rvdev = rproc_rvdev_add_device(rproc, &rvdev_data);
> -	if (IS_ERR(rvdev))
> -		return PTR_ERR(rvdev);
> +	pdev = platform_device_register_data(dev, "rproc-virtio", rvdev_data.index, &rvdev_data,
> +					     sizeof(rvdev_data));
> +	if (IS_ERR(pdev)) {
> +		dev_err(dev, "failed to create rproc-virtio device\n");
> +		return PTR_ERR(pdev);
> +	}
>  
>  	return 0;
>  }
> @@ -1248,7 +1252,7 @@ void rproc_resource_cleanup(struct rproc *rproc)
>  
>  	/* clean up remote vdev entries */
>  	list_for_each_entry_safe(rvdev, rvtmp, &rproc->rvdevs, node)
> -		kref_put(&rvdev->refcount, rproc_vdev_release);
> +		platform_device_unregister(rvdev->pdev);
>  
>  	rproc_coredump_cleanup(rproc);
>  }
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 2c4358ad63ca..0608052d1120 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -45,10 +45,7 @@ int rproc_of_parse_firmware(struct device *dev, int index,
>  			    const char **fw_name);
>  
>  /* from remoteproc_virtio.c */
> -struct rproc_vdev *rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data);
> -void rproc_rvdev_remove_device(struct rproc_vdev *rvdev);

Stale.

I am done reviewing this set.

Thanks,
Mathieu

>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> -void rproc_vdev_release(struct kref *ref);
>  
>  /* from remoteproc_debugfs.c */
>  void rproc_remove_trace_file(struct dentry *tfile);
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index ccc95d4e42cf..06d2131dad11 100644
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
> +		dev_warn(dev, "can't remove vdev child device: %d\n", ret);
>  }
>  
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
> -}
> -
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
> @@ -577,21 +548,30 @@ rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
>  
>  	rproc_add_subdev(rproc, &rvdev->subdev);
>  
> -	return rvdev;
> +	/*
> +	 * We're indirectly making a non-temporary copy of the rproc pointer
> +	 * here, because the platform device or the vdev device will indirectly
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
> -void rproc_vdev_release(struct kref *ref)
> +static int rproc_virtio_remove(struct platform_device *pdev)
>  {
> -	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
> -	struct rproc_vring *rvring;
> +	struct rproc_vdev *rvdev = dev_get_drvdata(&pdev->dev);
>  	struct rproc *rproc = rvdev->rproc;
> +	struct rproc_vring *rvring;
>  	int id;
>  
>  	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> @@ -601,5 +581,26 @@ void rproc_vdev_release(struct kref *ref)
>  
>  	rproc_remove_subdev(rproc, &rvdev->subdev);
>  	rproc_remove_rvdev(rvdev);
> -	device_unregister(&rvdev->dev);
> +
> +	of_reserved_mem_device_release(&pdev->dev);
> +
> +	put_device(&rproc->dev);
> +
> +	return 0;
>  }
> +
> +/* Platform driver */
> +static const struct of_device_id rproc_virtio_match[] = {
> +	{ .compatible = "virtio,rproc", },
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
> index 7c943f0a2fc4..64b9809d0ec1 100644
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
> 2.24.3
> 
