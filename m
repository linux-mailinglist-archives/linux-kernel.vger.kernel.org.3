Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF2F53BD91
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiFBRv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiFBRv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:51:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D142CE3A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:51:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n13-20020a17090a394d00b001e30a60f82dso10091561pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vv7eYXtOhI6dlrpYgRmIAgCrd1Ur+ScrHRSATRsCav4=;
        b=AlIHmwUgamfyzEvRvmDGbGCgxGR/PhwGRXe4IB61mXP3HImpSkgX9kRrbAICVR+ghy
         Ek4PagHAsji6mIwgfXrMSXN/ViZUrkQy5AJ+/Uf33hCu9+Cy6d+TnuP2LQ5OjAnfvllv
         aN1jQ1bLWVira2FTogK1h9Mo5gtH/kX2zuWYPVmXo+nyZae4VlI/YhswYfVQG6vZyddn
         Enmv6dY5AkXoti54Ei6vuB7kHJSX3PE3SUpJ6qCYSdW7fa43pF7UUn2edwQ/8ye0ichA
         Pjii6gUb9i1jnQpQH8G2XTbs3FVwMYmfSCf8um5ugXyH40CpZc5X93z1nhRDfW4rLs+0
         scfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vv7eYXtOhI6dlrpYgRmIAgCrd1Ur+ScrHRSATRsCav4=;
        b=5s7pYyOHdqrxa/e7NeZP0binXT3Ir3pYApqnILBYuBnR8fvTejVxwB5xW/vddeX7Nl
         lHDJWBAHjk1p5ihOgbiyOfma3GJpITvnb4ZGIVEcxAxQFZFVxWE3ttRrzsUOrUm45dBt
         Xyba9qjopDVa2v/BDIuhCb9n1JeAIhPsH6s7YVaUuryfWOmBs6Lc3JVAO/OTqO3GXGwc
         yGbay4DV0W7ft2sjQx53gjXTmq7hTAL5uv6BFotdUVPWImsSEuZvIqP//ZsHegwP3f9h
         a85Fyz+/3QZP/mG1VETWrhj3YEe0Cx9hjQjeYfno9w+hKo4dVTZMHjsAFj9l11RyOmLw
         aDww==
X-Gm-Message-State: AOAM5309jx/EtQ2JlymnSE5HGTpOf7WJLm0tiieOC+VORLxCluWrLgSx
        nL861gj94px2UvgIrfX46caG8g==
X-Google-Smtp-Source: ABdhPJwO5Bifz9Muu0xwswCUCph988l7DOX4OvcEHZMxsQVh9gLjQcamW3sY5fDoOlOM7XRcNC7DnQ==
X-Received: by 2002:a17:902:8c98:b0:15f:3e78:dc43 with SMTP id t24-20020a1709028c9800b0015f3e78dc43mr6091906plo.120.1654192315734;
        Thu, 02 Jun 2022 10:51:55 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78054000000b0050dc7628140sm3839334pfm.26.2022.06.02.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 10:51:54 -0700 (PDT)
Date:   Thu, 2 Jun 2022 11:51:52 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Subject: Re: [RFC PATCH v5 1/4] remoteproc: core: Introduce virtio device
 add/remove functions
Message-ID: <20220602175152.GF531268@p14s>
References: <20220406095446.1187968-1-arnaud.pouliquen@foss.st.com>
 <20220406095446.1187968-2-arnaud.pouliquen@foss.st.com>
 <20220601172945.GC531268@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601172945.GC531268@p14s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 11:29:45AM -0600, Mathieu Poirier wrote:
> On Wed, Apr 06, 2022 at 11:54:43AM +0200, Arnaud Pouliquen wrote:
> > In preparation of the migration of the management of rvdev in
> > remoteproc_virtio.c, this patch spins off new functions to manage the
> > remoteproc virtio device.
> >  - rproc_rvdev_add_device
> >  - rproc_rvdev_remove_device
> > 
> > The rproc_rvdev_add_device and rproc_rvdev_remove_device will be
> > moved to remoteproc_virtio.c.
> > 
> > The rproc_vdev_data structure is introduced to provide information for
> > the rvdev creation. This structure allows to manage the rvdev and vrings
> > allocation in the rproc_rvdev_add_device function.
> > 
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c     | 157 +++++++++++++----------
> >  drivers/remoteproc/remoteproc_internal.h |  15 +++
> >  2 files changed, 106 insertions(+), 66 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index c510125769b9..3a469220ac73 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -484,74 +484,23 @@ static int copy_dma_range_map(struct device *to, struct device *from)
> >  	return 0;
> >  }
> >  
> > -/**
> > - * rproc_handle_vdev() - handle a vdev fw resource
> > - * @rproc: the remote processor
> > - * @ptr: the vring resource descriptor
> > - * @offset: offset of the resource entry
> > - * @avail: size of available data (for sanity checking the image)
> > - *
> > - * This resource entry requests the host to statically register a virtio
> > - * device (vdev), and setup everything needed to support it. It contains
> > - * everything needed to make it possible: the virtio device id, virtio
> > - * device features, vrings information, virtio config space, etc...
> > - *
> > - * Before registering the vdev, the vrings are allocated from non-cacheable
> > - * physically contiguous memory. Currently we only support two vrings per
> > - * remote processor (temporary limitation). We might also want to consider
> > - * doing the vring allocation only later when ->find_vqs() is invoked, and
> > - * then release them upon ->del_vqs().
> > - *
> > - * Note: @da is currently not really handled correctly: we dynamically
> > - * allocate it using the DMA API, ignoring requested hard coded addresses,
> > - * and we don't take care of any required IOMMU programming. This is all
> > - * going to be taken care of when the generic iommu-based DMA API will be
> > - * merged. Meanwhile, statically-addressed iommu-based firmware images should
> > - * use RSC_DEVMEM resource entries to map their required @da to the physical
> > - * address of their base CMA region (ouch, hacky!).
> > - *
> > - * Return: 0 on success, or an appropriate error code otherwise
> > - */
> > -static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> > -			     int offset, int avail)
> > +static struct rproc_vdev *
> > +rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
> >  {
> > -	struct fw_rsc_vdev *rsc = ptr;
> > -	struct device *dev = &rproc->dev;
> >  	struct rproc_vdev *rvdev;
> > -	int i, ret;
> > +	struct fw_rsc_vdev *rsc = rvdev_data->rsc;
> >  	char name[16];
> > -
> > -	/* make sure resource isn't truncated */
> > -	if (struct_size(rsc, vring, rsc->num_of_vrings) + rsc->config_len >
> > -			avail) {
> > -		dev_err(dev, "vdev rsc is truncated\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* make sure reserved bytes are zeroes */
> > -	if (rsc->reserved[0] || rsc->reserved[1]) {
> > -		dev_err(dev, "vdev rsc has non zero reserved bytes\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	dev_dbg(dev, "vdev rsc: id %d, dfeatures 0x%x, cfg len %d, %d vrings\n",
> > -		rsc->id, rsc->dfeatures, rsc->config_len, rsc->num_of_vrings);
> > -
> > -	/* we currently support only two vrings per rvdev */
> > -	if (rsc->num_of_vrings > ARRAY_SIZE(rvdev->vring)) {
> > -		dev_err(dev, "too many vrings: %d\n", rsc->num_of_vrings);
> > -		return -EINVAL;
> > -	}
> > +	int i, ret;
> >  
> >  	rvdev = kzalloc(sizeof(*rvdev), GFP_KERNEL);
> >  	if (!rvdev)
> > -		return -ENOMEM;
> > +		return ERR_PTR(-ENOMEM);
> >  
> >  	kref_init(&rvdev->refcount);
> >  
> > -	rvdev->id = rsc->id;
> > +	rvdev->id = rvdev_data->id;
> >  	rvdev->rproc = rproc;
> > -	rvdev->index = rproc->nb_vdev++;
> > +	rvdev->index = rvdev_data->index;
> >  
> >  	/* Initialise vdev subdevice */
> >  	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> > @@ -563,7 +512,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> >  	ret = device_register(&rvdev->dev);
> >  	if (ret) {
> >  		put_device(&rvdev->dev);
> > -		return ret;
> > +		return ERR_PTR(ret);
> >  	}
> >  
> >  	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
> > @@ -576,7 +525,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> >  	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
> >  					   dma_get_mask(rproc->dev.parent));
> >  	if (ret) {
> > -		dev_warn(dev,
> > +		dev_warn(&rvdev->dev,
> >  			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> >  			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
> >  	}
> > @@ -589,7 +538,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> >  	}
> >  
> >  	/* remember the resource offset*/
> > -	rvdev->rsc_offset = offset;
> > +	rvdev->rsc_offset = rvdev_data->rsc_offset;
> >  
> >  	/* allocate the vring resources */
> >  	for (i = 0; i < rsc->num_of_vrings; i++) {
> > @@ -605,21 +554,20 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> >  
> >  	rproc_add_subdev(rproc, &rvdev->subdev);
> >  
> > -	return 0;
> > +	return rvdev;
> >  
> >  unwind_vring_allocations:
> >  	for (i--; i >= 0; i--)
> >  		rproc_free_vring(&rvdev->vring[i]);
> >  free_rvdev:
> >  	device_unregister(&rvdev->dev);
> > -	return ret;
> > +	return ERR_PTR(ret);
> >  }
> >  
> > -void rproc_vdev_release(struct kref *ref)
> > +static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
> >  {
> > -	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
> > -	struct rproc_vring *rvring;
> >  	struct rproc *rproc = rvdev->rproc;
> > +	struct rproc_vring *rvring;
> >  	int id;
> >  
> >  	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> > @@ -632,6 +580,83 @@ void rproc_vdev_release(struct kref *ref)
> >  	device_unregister(&rvdev->dev);
> >  }
> >  
> > +/**
> > + * rproc_handle_vdev() - handle a vdev fw resource
> > + * @rproc: the remote processor
> > + * @ptr: the vring resource descriptor
> > + * @offset: offset of the resource entry
> > + * @avail: size of available data (for sanity checking the image)
> > + *
> > + * This resource entry requests the host to statically register a virtio
> > + * device (vdev), and setup everything needed to support it. It contains
> > + * everything needed to make it possible: the virtio device id, virtio
> > + * device features, vrings information, virtio config space, etc...
> > + *
> > + * Before registering the vdev, the vrings are allocated from non-cacheable
> > + * physically contiguous memory. Currently we only support two vrings per
> > + * remote processor (temporary limitation). We might also want to consider
> > + * doing the vring allocation only later when ->find_vqs() is invoked, and
> > + * then release them upon ->del_vqs().
> > + *
> > + * Note: @da is currently not really handled correctly: we dynamically
> > + * allocate it using the DMA API, ignoring requested hard coded addresses,
> > + * and we don't take care of any required IOMMU programming. This is all
> > + * going to be taken care of when the generic iommu-based DMA API will be
> > + * merged. Meanwhile, statically-addressed iommu-based firmware images should
> > + * use RSC_DEVMEM resource entries to map their required @da to the physical
> > + * address of their base CMA region (ouch, hacky!).
> > + *
> > + * Return: 0 on success, or an appropriate error code otherwise
> > + */
> > +static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> > +			     int offset, int avail)
> > +{
> > +	struct fw_rsc_vdev *rsc = ptr;
> > +	struct device *dev = &rproc->dev;
> > +	struct rproc_vdev *rvdev;
> > +	struct rproc_vdev_data rvdev_data;
> > +
> > +	/* make sure resource isn't truncated */
> > +	if (struct_size(rsc, vring, rsc->num_of_vrings) + rsc->config_len >
> > +			avail) {
> > +		dev_err(dev, "vdev rsc is truncated\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* make sure reserved bytes are zeroes */
> > +	if (rsc->reserved[0] || rsc->reserved[1]) {
> > +		dev_err(dev, "vdev rsc has non zero reserved bytes\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_dbg(dev, "vdev rsc: id %d, dfeatures 0x%x, cfg len %d, %d vrings\n",
> > +		rsc->id, rsc->dfeatures, rsc->config_len, rsc->num_of_vrings);
> > +
> > +	/* we currently support only two vrings per rvdev */
> > +	if (rsc->num_of_vrings > ARRAY_SIZE(rvdev->vring)) {
> > +		dev_err(dev, "too many vrings: %d\n", rsc->num_of_vrings);
> > +		return -EINVAL;
> > +	}
> > +
> > +	rvdev_data.id = rsc->id;
> > +	rvdev_data.index = rproc->nb_vdev++;
> > +	rvdev_data.rsc_offset = offset;
> > +	rvdev_data.rsc = rsc;
> > +
> > +	rvdev = rproc_rvdev_add_device(rproc, &rvdev_data);
> > +	if (IS_ERR(rvdev))
> > +		return PTR_ERR(rvdev);
> > +
> > +	return 0;
> > +}
> > +
> > +void rproc_vdev_release(struct kref *ref)
> > +{
> > +	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
> > +
> > +	rproc_rvdev_remove_device(rvdev);

I understand that rproc_rvdev_remove_device() is created to counter balance
rproc_rvdev_add_device() but in this case it doesn't provide much.  Moreover it
is removed and rproc_vdev_release() renamed in patch 4, making that one more
complex than it should be.  As such please leave rproc_vdev_release() unchanged.

> > +}
> > +
> >  /**
> >   * rproc_handle_trace() - handle a shared trace buffer resource
> >   * @rproc: the remote processor
> > diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> > index 72d4d3d7d94d..99f2ff88079f 100644
> > --- a/drivers/remoteproc/remoteproc_internal.h
> > +++ b/drivers/remoteproc/remoteproc_internal.h
> > @@ -24,6 +24,21 @@ struct rproc_debug_trace {
> >  	struct rproc_mem_entry trace_mem;
> >  };
> >  
> > +/**
> > + * struct rproc_vdev_data - remoteproc virtio device data
> > + * @rsc_offset: offset of the vdev's resource entry
> > + * @id: virtio device id (as in virtio_ids.h)
> > + * @index: vdev position versus other vdev declared in resource table
> > + * @rsc: pointer to the vdev resource entry. Valid onlyduring vdev init as the resource can
> > + *       be cached by rproc.
> > + */
> > +struct rproc_vdev_data {
> > +	u32 rsc_offset;
> > +	unsigned int id;
> > +	unsigned int index;
> 
> rvdev->index is a u32 so rproc_vdev_data::index should also be a u32.
> 
> With the above:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

I'll take that back to see how the above refactoring fans out.

I am done reviewing this set.

Thanks,
Mathieu

> 
> 
> > +	struct fw_rsc_vdev *rsc;
> > +};
> > +
> >  /* from remoteproc_core.c */
> >  void rproc_release(struct kref *kref);
> >  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> > -- 
> > 2.25.1
> > 
