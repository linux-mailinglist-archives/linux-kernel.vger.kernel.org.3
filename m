Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAD24857E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbiAESF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242651AbiAESF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:05:28 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B288C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:05:28 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 200so36175001pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 10:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MeOAoCPYCMAS03NMK5FT9IOH4xI01JHtqGdi4oXBEZc=;
        b=YlsWA6qYnCazBrn4jPFl2aS1N0OojH5q0Kopc6nrJatN0uKTGXl2fI8mvYnNQJICSq
         I1rUcxBUJYurTkG0eX8Pwc38jTPMi0co3LGPFsWDrx9XcpYupTI1wpr2bFqnWpIRUM1P
         rVfTp56IQgdhfDbPtaHMs6gDsK1eGGZRMbJBIfJQttiw+f6b+XQr8d9p5muGWaZ/2gPK
         Jl1yd18WgBHzKML2j4HCrWNGaINxfoTu+QVXa0DAaF6D9WYprjAf05cwrW+ZyApKmUQN
         y6VysdQ3PPiuNgo5IXNig3h+0XDf/KT1vPj0kIXd06+81Tt/fM9hVSUqNwiAcFNTabhr
         8nZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MeOAoCPYCMAS03NMK5FT9IOH4xI01JHtqGdi4oXBEZc=;
        b=35+5lxbwDRyvmp35i0zgyJTNU7MLMAnptUi/uufT6S4wMQBbU2E1Nz/Fk+2HU8XK+3
         yvIwHdpWVNTUIRa/w0i0fkH4gV++4rBwOQW3rWYab88g/2Ya9Q93h6DsTOdIdhJ8rpYC
         rurEnGuZDJH/kwb3YhIPubh/D/bn2Xyom6t9kWFxb7Cu0LXXZzXJ8vgaZSVdVsXLr9ko
         doI+9dQl+9r5mbhL++z0HMr6oUH23VC+u2bBgBb0pOU2g3eqlJWDo+RNyxup8ZhrSIpL
         u+gfhJ4Ez8Tf14hJooYURBqX6uPqLifBlZ9GwPslcTbS0jfeGfFK10fJcghkTWXPIbA2
         hHyA==
X-Gm-Message-State: AOAM533flHZjlhEy9Qk5AovgGjtwh6J8MaVPe9psANB4L5t5ZZ9sJwOn
        THB56SK3ox9IECR3v0CnK/J6kQ==
X-Google-Smtp-Source: ABdhPJzjgNhV8sILtvoBvEl953Rr3Jao1tADL5uKBWruu1T3xMU+fgHr8nyDkzcYJRgHzwRC9TLdIQ==
X-Received: by 2002:a62:b503:0:b0:4bc:657e:cfa6 with SMTP id y3-20020a62b503000000b004bc657ecfa6mr26162926pfe.25.1641405928061;
        Wed, 05 Jan 2022 10:05:28 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k8sm3291224pjs.53.2022.01.05.10.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 10:05:27 -0800 (PST)
Date:   Wed, 5 Jan 2022 11:05:24 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RFC PATCH v2 1/6] remoteproc: core: Introduce virtio device
 add/remove functions
Message-ID: <20220105180524.GA597001@p14s>
References: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
 <20211222082349.30378-2-arnaud.pouliquen@foss.st.com>
 <20220104190810.GB540353@p14s>
 <9f047c7b-a91c-9600-cdaf-7984ad7666f3@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f047c7b-a91c-9600-cdaf-7984ad7666f3@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 09:05:21AM +0100, Arnaud POULIQUEN wrote:
> Hello Mathieu,
> 
> On 1/4/22 8:08 PM, Mathieu Poirier wrote:
> > Good morning,
> > 
> > On Wed, Dec 22, 2021 at 09:23:44AM +0100, Arnaud Pouliquen wrote:
> > > In preparation of the migration of the management of rvdev in
> > > remoteproc_virtio.c, this patch spins off new functions to manage the
> > > remoteproc virtio device.
> > > 
> > > The rproc_rvdev_add_device and rproc_rvdev_remove_device will be
> > > moved to remoteproc_virtio.c.
> > > 
> > > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > > ---
> > > update vs previous revision:
> > >   - update according to the rebase from v15-rc1 to v16-rc1
> > >   - split patch to introduce rproc_register_rvdev and rproc_unregister_rvdev
> > >     function in a separate patch
> > > ---
> > >   drivers/remoteproc/remoteproc_core.c | 94 +++++++++++++++++-----------
> > >   1 file changed, 57 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index 69f51acf235e..d1f1c5c25bd7 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -484,6 +484,61 @@ static int copy_dma_range_map(struct device *to, struct device *from)
> > >   	return 0;
> > >   }
> > > +static int rproc_rvdev_add_device(struct rproc_vdev *rvdev)
> > > +{
> > > +	struct rproc *rproc = rvdev->rproc;
> > > +	char name[16];
> > > +	int ret;
> > > +
> > > +	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> > > +	rvdev->dev.parent = &rproc->dev;
> > > +	rvdev->dev.release = rproc_rvdev_release;
> > > +	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> > > +	dev_set_drvdata(&rvdev->dev, rvdev);
> > > +
> > > +	ret = device_register(&rvdev->dev);
> > > +	if (ret) {
> > > +		put_device(&rvdev->dev);
> > > +		return ret;
> > > +	}
> > 
> > Registering the device here is a problem...  If device_register() fails
> > put_device() is called and we return, only to call device_unregister() on the
> > same device in rproc_handle_vdev().
> > 
> > Moreover in rproc_handle_vdev(), device_unregister() is called in the error
> > path but device_register() is called here in rproc_rvdev_add_device().  This
> > introduces coupling between the two functions, making it hard to maintain from
> > hereon.
> 
> Very relevant, I need to rework the error management.
> 
> > 
> > I suggest calling device_register() in rproc_handle_vdev() after
> > rproc_rvdev_add_device() has returned successfully.
> 
> One of the goals of this patchset is to move the device_register in
> remote_proc_virtio.c
> Doing this would not go in this direction.
>
> I need to test but following could be an alternative:
> - Call rproc_rvdev_remove_device in rproc_handle_vdev in case of error.
> - Remove the put_device in rproc_rvdev_add_device.
>

Right, some kind of rework is needed.  I offered a simple solution but something
more involved is likely required.

> => This would be aligned with patch [6/6] implementation
> with rproc_virtio_register_device/rproc_virtio_unregister_device...
> 
> Thanks,
> Arnaud
> 
> > 
> > More comments to come tomorrow.
> > 
> > Thanks,
> > Mathieu
> > 
> > > +	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
> > > +	if (ret)
> > > +		goto free_rvdev;
> > > +
> > > +	/* Make device dma capable by inheriting from parent's capabilities */
> > > +	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
> > > +
> > > +	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
> > > +					   dma_get_mask(rproc->dev.parent));
> > > +	if (ret) {
> > > +		dev_warn(&rvdev->dev,
> > > +			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> > > +			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
> > > +	}
> > > +
> > > +	list_add_tail(&rvdev->node, &rproc->rvdevs);
> > > +
> > > +	rvdev->subdev.start = rproc_vdev_do_start;
> > > +	rvdev->subdev.stop = rproc_vdev_do_stop;
> > > +
> > > +	rproc_add_subdev(rproc, &rvdev->subdev);
> > > +
> > > +	return 0;
> > > +
> > > +free_rvdev:
> > > +	device_unregister(&rvdev->dev);
> > > +	return ret;
> > > +}
> > > +
> > > +static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
> > > +{
> > > +	struct rproc *rproc = rvdev->rproc;
> > > +
> > > +	rproc_remove_subdev(rproc, &rvdev->subdev);
> > > +	list_del(&rvdev->node);
> > > +	device_unregister(&rvdev->dev);
> > > +}
> > > +
> > >   /**
> > >    * rproc_handle_vdev() - handle a vdev fw resource
> > >    * @rproc: the remote processor
> > > @@ -519,7 +574,6 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> > >   	struct device *dev = &rproc->dev;
> > >   	struct rproc_vdev *rvdev;
> > >   	int i, ret;
> > > -	char name[16];
> > >   	/* make sure resource isn't truncated */
> > >   	if (struct_size(rsc, vring, rsc->num_of_vrings) + rsc->config_len >
> > > @@ -553,34 +607,10 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> > >   	rvdev->rproc = rproc;
> > >   	rvdev->index = rproc->nb_vdev++;
> > > -	/* Initialise vdev subdevice */
> > > -	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> > > -	rvdev->dev.parent = &rproc->dev;
> > > -	rvdev->dev.release = rproc_rvdev_release;
> > > -	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> > > -	dev_set_drvdata(&rvdev->dev, rvdev);
> > > -
> > > -	ret = device_register(&rvdev->dev);
> > > -	if (ret) {
> > > -		put_device(&rvdev->dev);
> > > -		return ret;
> > > -	}
> > > -
> > > -	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
> > > +	ret = rproc_rvdev_add_device(rvdev);
> > >   	if (ret)
> > >   		goto free_rvdev;
> > > -	/* Make device dma capable by inheriting from parent's capabilities */
> > > -	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
> > > -
> > > -	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
> > > -					   dma_get_mask(rproc->dev.parent));
> > > -	if (ret) {
> > > -		dev_warn(dev,
> > > -			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> > > -			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
> > > -	}
> > > -
> > >   	/* parse the vrings */
> > >   	for (i = 0; i < rsc->num_of_vrings; i++) {
> > >   		ret = rproc_parse_vring(rvdev, rsc, i);
> > > @@ -598,13 +628,6 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> > >   			goto unwind_vring_allocations;
> > >   	}
> > > -	list_add_tail(&rvdev->node, &rproc->rvdevs);
> > > -
> > > -	rvdev->subdev.start = rproc_vdev_do_start;
> > > -	rvdev->subdev.stop = rproc_vdev_do_stop;
> > > -
> > > -	rproc_add_subdev(rproc, &rvdev->subdev);
> > > -
> > >   	return 0;
> > >   unwind_vring_allocations:
> > > @@ -619,7 +642,6 @@ void rproc_vdev_release(struct kref *ref)
> > >   {
> > >   	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
> > >   	struct rproc_vring *rvring;
> > > -	struct rproc *rproc = rvdev->rproc;
> > >   	int id;
> > >   	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> > > @@ -627,9 +649,7 @@ void rproc_vdev_release(struct kref *ref)
> > >   		rproc_free_vring(rvring);
> > >   	}
> > > -	rproc_remove_subdev(rproc, &rvdev->subdev);
> > > -	list_del(&rvdev->node);
> > > -	device_unregister(&rvdev->dev);
> > > +	rproc_rvdev_remove_device(rvdev);
> > >   }
> > >   /**
> > > -- 
> > > 2.17.1
> > > 
