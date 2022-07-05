Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF44656742F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiGEQ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGEQ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:26:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E301582F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:26:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w185so8253841pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AcEyGq5iTudW+EyQzfl6xO/PUWDCha48Rbl9GKgejco=;
        b=Y/rKdp9pWvtdxCFg/U+bOJRiPvp6D30Lv97gUnI2NzYhooHs+T6ZOvT2HxIstez8e4
         klDVy3nMQTmqF7CtxqgZssUmbidUOCo9lEV4ioUQiZZzVNTu9ADJ4DIFDZSjq+VtSxK7
         +vL0bPkVuRH/L4w7ozPAFtQf0qyjptCXWvjsYEd811KQRUre1urnyz/6i1hn9DkTinua
         7ArM9MjdDsv5YURqLoL3a25nUwD6qrVEw/y0ON2cILnRsYi0yIZUhgxJYtkc6yMDq1Cs
         9cPwaOETvTw7T43mjJdktrz5/BwBZShwsUeNVX9/eosnCIFGVGsGRm5hWORZclfECCGw
         MUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AcEyGq5iTudW+EyQzfl6xO/PUWDCha48Rbl9GKgejco=;
        b=BwPy2GIGJAlHXHiMxgVACnHXtFFNbqtyM1gIQU5qyvRRqfn0ruphg21MuFnO1t8iRf
         uanp13LzSKhbPRIZLpRdTdUSmQMOo4uABYy4g9a7CV3bGc7Iy1ocnKAlYs8h4lFXTOgP
         D/zHPqPkHFODrjo0UStpj0dSSJdTRU9/73NXUXB334IVERcg/Y1z7DMnmB/AbrvdHRMk
         j44ViiGPDYvLixu9UON8jN3M+KrBMvjT0kRU+XDer2hCDyZ9yXi/OQCyo6ZURowzaIgj
         gmR+7X79LeChYjsCqZGFEtE0QBEunUuyirdH/SsOubcFqBv9MyJkohdWjsvCx3OL3OC7
         KuRA==
X-Gm-Message-State: AJIora+M90Ea1qEEcPjYwb+4IlusbTmZJmSmyDNJi82iNlpzvf7+z6nZ
        hG5HxIQOsUaGAVfGefkr/R6XJA==
X-Google-Smtp-Source: AGRyM1tVj2LfoK1WsvOrfL0gb1Ee1438G7d0r8DC6/7lNZp9I7J+fPEwSR0aOlIYFHFGs0p91nMVEw==
X-Received: by 2002:a63:8249:0:b0:412:722e:9d2c with SMTP id w70-20020a638249000000b00412722e9d2cmr3176964pgd.106.1657038365626;
        Tue, 05 Jul 2022 09:26:05 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z15-20020a6553cf000000b003fadd680908sm22603797pgr.83.2022.07.05.09.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:26:04 -0700 (PDT)
Date:   Tue, 5 Jul 2022 10:26:01 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Subject: Re: [RFC PATCH v5 3/4] remoteproc: Move rproc_vdev management to
 remoteproc_virtio.c
Message-ID: <20220705162601.GC2440144@p14s>
References: <20220406095446.1187968-1-arnaud.pouliquen@foss.st.com>
 <20220406095446.1187968-4-arnaud.pouliquen@foss.st.com>
 <20220705160722.GB2440144@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705160722.GB2440144@p14s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 10:07:22AM -0600, Mathieu Poirier wrote:
> On Wed, Apr 06, 2022 at 11:54:45AM +0200, Arnaud Pouliquen wrote:
> > Move functions related to the management of the rproc_vdev
> > structure in the remoteproc_virtio.c.
> > The aim is to decorrelate as possible the virtio management from
> > the core part.
> > 
> > Due to the strong correlation between the vrings and the resource table
> > the rproc_alloc/parse/free_vring functions are kept in the remoteproc core.
> > 
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > 
> > ---
> > Update vs previous revision:
> >  - clean up bad rproc_free_vring call in rproc_vdev_release
> 
> Stale comment.  What has changed in this revision is that
> rproc_rvdev_remove_device() has been dropped.

Void the comments for this patch.  I was looking at this earlier revision to
compare with the current v6.  Please find my comments there.

> 
> > ---
> >  drivers/remoteproc/remoteproc_core.c     | 162 +----------------------
> >  drivers/remoteproc/remoteproc_internal.h |  11 +-
> >  drivers/remoteproc/remoteproc_virtio.c   | 159 +++++++++++++++++++++-
> >  3 files changed, 167 insertions(+), 165 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 081bea39daf4..bd6d3f2decc6 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -23,9 +23,7 @@
> >  #include <linux/panic_notifier.h>
> >  #include <linux/slab.h>
> >  #include <linux/mutex.h>
> > -#include <linux/dma-map-ops.h>
> >  #include <linux/dma-mapping.h>
> > -#include <linux/dma-direct.h> /* XXX: pokes into bus_dma_range */
> >  #include <linux/firmware.h>
> >  #include <linux/string.h>
> >  #include <linux/debugfs.h>
> > @@ -383,7 +381,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
> >  	return 0;
> >  }
> >  
> > -static int
> > +int
> >  rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i)
> >  {
> >  	struct rproc *rproc = rvdev->rproc;
> > @@ -434,164 +432,17 @@ void rproc_free_vring(struct rproc_vring *rvring)
> >  	}
> >  }
> >  
> > -static int rproc_vdev_do_start(struct rproc_subdev *subdev)
> > -{
> > -	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
> > -
> > -	return rproc_add_virtio_dev(rvdev, rvdev->id);
> > -}
> > -
> > -static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
> > -{
> > -	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
> > -	int ret;
> > -
> > -	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
> > -	if (ret)
> > -		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n", ret);
> > -}
> > -
> > -/**
> > - * rproc_rvdev_release() - release the existence of a rvdev
> > - *
> > - * @dev: the subdevice's dev
> > - */
> > -static void rproc_rvdev_release(struct device *dev)
> > -{
> > -	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
> > -
> > -	of_reserved_mem_device_release(dev);
> > -
> > -	kfree(rvdev);
> > -}
> > -
> > -static int copy_dma_range_map(struct device *to, struct device *from)
> > -{
> > -	const struct bus_dma_region *map = from->dma_range_map, *new_map, *r;
> > -	int num_ranges = 0;
> > -
> > -	if (!map)
> > -		return 0;
> > -
> > -	for (r = map; r->size; r++)
> > -		num_ranges++;
> > -
> > -	new_map = kmemdup(map, array_size(num_ranges + 1, sizeof(*map)),
> > -			  GFP_KERNEL);
> > -	if (!new_map)
> > -		return -ENOMEM;
> > -	to->dma_range_map = new_map;
> > -	return 0;
> > -}
> > -
> > -static void rproc_add_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
> > +void rproc_add_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
> >  {
> >  	if (rvdev && rproc)
> >  		list_add_tail(&rvdev->node, &rproc->rvdevs);
> >  }
> >  
> > -static void rproc_remove_rvdev(struct rproc_vdev *rvdev)
> > +void rproc_remove_rvdev(struct rproc_vdev *rvdev)
> >  {
> >  	if (rvdev)
> >  		list_del(&rvdev->node);
> >  }
> > -
> > -static struct rproc_vdev *
> > -rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
> > -{
> > -	struct rproc_vdev *rvdev;
> > -	struct fw_rsc_vdev *rsc = rvdev_data->rsc;
> > -	char name[16];
> > -	int i, ret;
> > -
> > -	rvdev = kzalloc(sizeof(*rvdev), GFP_KERNEL);
> > -	if (!rvdev)
> > -		return ERR_PTR(-ENOMEM);
> > -
> > -	kref_init(&rvdev->refcount);
> > -
> > -	rvdev->id = rvdev_data->id;
> > -	rvdev->rproc = rproc;
> > -	rvdev->index = rvdev_data->index;
> > -
> > -	/* Initialise vdev subdevice */
> > -	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> > -	rvdev->dev.parent = &rproc->dev;
> > -	rvdev->dev.release = rproc_rvdev_release;
> > -	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> > -	dev_set_drvdata(&rvdev->dev, rvdev);
> > -
> > -	ret = device_register(&rvdev->dev);
> > -	if (ret) {
> > -		put_device(&rvdev->dev);
> > -		return ERR_PTR(ret);
> > -	}
> > -
> > -	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
> > -	if (ret)
> > -		goto free_rvdev;
> > -
> > -	/* Make device dma capable by inheriting from parent's capabilities */
> > -	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
> > -
> > -	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
> > -					   dma_get_mask(rproc->dev.parent));
> > -	if (ret) {
> > -		dev_warn(&rvdev->dev,
> > -			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> > -			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
> > -	}
> > -
> > -	/* parse the vrings */
> > -	for (i = 0; i < rsc->num_of_vrings; i++) {
> > -		ret = rproc_parse_vring(rvdev, rsc, i);
> > -		if (ret)
> > -			goto free_rvdev;
> > -	}
> > -
> > -	/* remember the resource offset*/
> > -	rvdev->rsc_offset = rvdev_data->rsc_offset;
> > -
> > -	/* allocate the vring resources */
> > -	for (i = 0; i < rsc->num_of_vrings; i++) {
> > -		ret = rproc_alloc_vring(rvdev, i);
> > -		if (ret)
> > -			goto unwind_vring_allocations;
> > -	}
> > -
> > -	rproc_add_rvdev(rproc, rvdev);
> > -
> > -	rvdev->subdev.start = rproc_vdev_do_start;
> > -	rvdev->subdev.stop = rproc_vdev_do_stop;
> > -
> > -	rproc_add_subdev(rproc, &rvdev->subdev);
> > -
> > -	return rvdev;
> > -
> > -unwind_vring_allocations:
> > -	for (i--; i >= 0; i--)
> > -		rproc_free_vring(&rvdev->vring[i]);
> > -free_rvdev:
> > -	device_unregister(&rvdev->dev);
> > -	return ERR_PTR(ret);
> > -}
> > -
> > -static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
> > -{
> > -	struct rproc *rproc = rvdev->rproc;
> > -	struct rproc_vring *rvring;
> > -	int id;
> > -
> > -	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> > -		rvring = &rvdev->vring[id];
> > -		rproc_free_vring(rvring);
> > -	}
> > -
> > -	rproc_remove_subdev(rproc, &rvdev->subdev);
> > -	rproc_remove_rvdev(rvdev);
> > -	device_unregister(&rvdev->dev);
> > -}
> > -
> >  /**
> >   * rproc_handle_vdev() - handle a vdev fw resource
> >   * @rproc: the remote processor
> > @@ -662,13 +513,6 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> >  	return 0;
> >  }
> >  
> > -void rproc_vdev_release(struct kref *ref)
> > -{
> > -	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
> > -
> > -	rproc_rvdev_remove_device(rvdev);
> > -}
> > -
> >  /**
> >   * rproc_handle_trace() - handle a shared trace buffer resource
> >   * @rproc: the remote processor
> > diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> > index 99f2ff88079f..f82f9a5378ae 100644
> > --- a/drivers/remoteproc/remoteproc_internal.h
> > +++ b/drivers/remoteproc/remoteproc_internal.h
> > @@ -41,14 +41,14 @@ struct rproc_vdev_data {
> >  
> >  /* from remoteproc_core.c */
> >  void rproc_release(struct kref *kref);
> > -irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> > -void rproc_vdev_release(struct kref *ref);
> >  int rproc_of_parse_firmware(struct device *dev, int index,
> >  			    const char **fw_name);
> >  
> >  /* from remoteproc_virtio.c */
> > -int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id);
> > -int rproc_remove_virtio_dev(struct device *dev, void *data);
> > +struct rproc_vdev *rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data);
> > +void rproc_rvdev_remove_device(struct rproc_vdev *rvdev);
> 
> Stale
> 
> > +irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> > +void rproc_vdev_release(struct kref *ref);
> >  
> >  /* from remoteproc_debugfs.c */
> >  void rproc_remove_trace_file(struct dentry *tfile);
> > @@ -98,6 +98,7 @@ static inline void  rproc_char_device_remove(struct rproc *rproc)
> >  
> >  void rproc_free_vring(struct rproc_vring *rvring);
> >  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
> > +int rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i);
> >  
> >  phys_addr_t rproc_va_to_pa(void *cpu_addr);
> >  int rproc_trigger_recovery(struct rproc *rproc);
> > @@ -110,6 +111,8 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
> >  						       const struct firmware *fw);
> >  struct rproc_mem_entry *
> >  rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
> > +void rproc_add_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev);
> > +void rproc_remove_rvdev(struct rproc_vdev *rvdev);
> >  
> >  static inline int rproc_prepare_device(struct rproc *rproc)
> >  {
> > diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> > index 70ab496d0431..e2e796ab2fd8 100644
> > --- a/drivers/remoteproc/remoteproc_virtio.c
> > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > @@ -9,7 +9,9 @@
> >   * Brian Swetland <swetland@google.com>
> >   */
> >  
> > +#include <linux/dma-direct.h>
> >  #include <linux/dma-map-ops.h>
> > +#include <linux/dma-mapping.h>
> >  #include <linux/export.h>
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/remoteproc.h>
> > @@ -23,6 +25,25 @@
> >  
> >  #include "remoteproc_internal.h"
> >  
> > +static int copy_dma_range_map(struct device *to, struct device *from)
> > +{
> > +	const struct bus_dma_region *map = from->dma_range_map, *new_map, *r;
> > +	int num_ranges = 0;
> > +
> > +	if (!map)
> > +		return 0;
> > +
> > +	for (r = map; r->size; r++)
> > +		num_ranges++;
> > +
> > +	new_map = kmemdup(map, array_size(num_ranges + 1, sizeof(*map)),
> > +			  GFP_KERNEL);
> > +	if (!new_map)
> > +		return -ENOMEM;
> > +	to->dma_range_map = new_map;
> > +	return 0;
> > +}
> > +
> >  static struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
> >  {
> >  	return container_of(vdev->dev.parent, struct rproc_vdev, dev);
> > @@ -339,7 +360,7 @@ static void rproc_virtio_dev_release(struct device *dev)
> >   *
> >   * Return: 0 on success or an appropriate error value otherwise
> >   */
> > -int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
> > +static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
> >  {
> >  	struct rproc *rproc = rvdev->rproc;
> >  	struct device *dev = &rvdev->dev;
> > @@ -447,10 +468,144 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
> >   *
> >   * Return: 0
> >   */
> > -int rproc_remove_virtio_dev(struct device *dev, void *data)
> > +static int rproc_remove_virtio_dev(struct device *dev, void *data)
> >  {
> >  	struct virtio_device *vdev = dev_to_virtio(dev);
> >  
> >  	unregister_virtio_device(vdev);
> >  	return 0;
> >  }
> > +
> > +static int rproc_vdev_do_start(struct rproc_subdev *subdev)
> > +{
> > +	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
> > +
> > +	return rproc_add_virtio_dev(rvdev, rvdev->id);
> > +}
> > +
> > +static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
> > +{
> > +	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
> > +	int ret;
> > +
> > +	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
> > +	if (ret)
> > +		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n", ret);
> > +}
> > +
> > +/**
> > + * rproc_rvdev_release() - release the existence of a rvdev
> > + *
> > + * @dev: the subdevice's dev
> > + */
> > +static void rproc_rvdev_release(struct device *dev)
> > +{
> > +	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
> > +
> > +	of_reserved_mem_device_release(dev);
> > +
> > +	kfree(rvdev);
> > +}
> > +
> > +struct rproc_vdev *
> > +rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
> > +{
> > +	struct rproc_vdev *rvdev;
> > +	struct fw_rsc_vdev *rsc = rvdev_data->rsc;
> > +	char name[16];
> > +	int i, ret;
> > +
> > +	rvdev = kzalloc(sizeof(*rvdev), GFP_KERNEL);
> > +	if (!rvdev)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	kref_init(&rvdev->refcount);
> > +
> > +	rvdev->id = rvdev_data->id;
> > +	rvdev->rproc = rproc;
> > +	rvdev->index = rvdev_data->index;
> > +
> > +	/* Initialise vdev subdevice */
> > +	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> > +	rvdev->dev.parent = &rproc->dev;
> > +	rvdev->dev.release = rproc_rvdev_release;
> > +	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> > +	dev_set_drvdata(&rvdev->dev, rvdev);
> > +
> > +	ret = device_register(&rvdev->dev);
> > +	if (ret) {
> > +		put_device(&rvdev->dev);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
> > +	if (ret)
> > +		goto free_rvdev;
> > +
> > +	/* Make device dma capable by inheriting from parent's capabilities */
> > +	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
> > +
> > +	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
> > +					   dma_get_mask(rproc->dev.parent));
> > +	if (ret) {
> > +		dev_warn(&rvdev->dev,
> > +			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> > +			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
> > +	}
> > +
> > +	/* parse the vrings */
> > +	for (i = 0; i < rsc->num_of_vrings; i++) {
> > +		ret = rproc_parse_vring(rvdev, rsc, i);
> > +		if (ret)
> > +			goto free_rvdev;
> > +	}
> > +
> > +	/* remember the resource offset*/
> > +	rvdev->rsc_offset = rvdev_data->rsc_offset;
> > +
> > +	/* allocate the vring resources */
> > +	for (i = 0; i < rsc->num_of_vrings; i++) {
> > +		ret = rproc_alloc_vring(rvdev, i);
> > +		if (ret)
> > +			goto unwind_vring_allocations;
> > +	}
> > +
> > +	rproc_add_rvdev(rproc, rvdev);
> > +
> > +	rvdev->subdev.start = rproc_vdev_do_start;
> > +	rvdev->subdev.stop = rproc_vdev_do_stop;
> > +
> > +	rproc_add_subdev(rproc, &rvdev->subdev);
> > +
> > +	return rvdev;
> > +
> > +unwind_vring_allocations:
> > +	for (i--; i >= 0; i--)
> > +		rproc_free_vring(&rvdev->vring[i]);
> > +free_rvdev:
> > +	device_unregister(&rvdev->dev);
> > +	return ERR_PTR(ret);
> > +}
> > +
> > +void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
> > +{
> > +	struct rproc *rproc = rvdev->rproc;
> > +	struct rproc_vring *rvring;
> > +	int id;
> > +
> > +	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> > +		rvring = &rvdev->vring[id];
> > +		rproc_free_vring(rvring);
> > +	}
> > +
> > +	rproc_remove_subdev(rproc, &rvdev->subdev);
> > +	rproc_remove_rvdev(rvdev);
> > +	device_unregister(&rvdev->dev);
> > +}
> > +
> > +void rproc_vdev_release(struct kref *ref)
> > +{
> > +	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
> > +
> > +	rproc_rvdev_remove_device(rvdev);
> > +}
> > -- 
> > 2.25.1
> > 
