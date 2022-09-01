Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669A75A9ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiIASRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiIASRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:17:17 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA947B1F4;
        Thu,  1 Sep 2022 11:17:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E14DE6CD;
        Thu,  1 Sep 2022 20:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662056233;
        bh=vM4kNuawJRlFDMSYNJFOYcifKa4oGwA3zJmZKGA9lXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ko1tq0hiyKSoljpQcW3qg0t7V8ACMCU267KcqdRZukWHbRKXndoVPGhatxzZ5HuX0
         XfsqBVXH9Cg6cspzG+XYBCqe9rVQv3rNO8mNNqxUy0962sRUzy66m9y2K5KHTyiM/4
         LJpD8BgkEPDdNvZEPuRZs6GPFunAue2+wC9ToB9U=
Date:   Thu, 1 Sep 2022 21:17:01 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 6/6] media: sun6i-csi: Add support for hooking to the
 isp devices
Message-ID: <YxD3HfWIvzdgyRZh@pendragon.ideasonboard.com>
References: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
 <20220826184144.605605-7-paul.kocialkowski@bootlin.com>
 <YwlMsAG/vPUTNd4o@pendragon.ideasonboard.com>
 <YxDH0jZE1laFnfcu@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxDH0jZE1laFnfcu@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Sep 01, 2022 at 04:55:14PM +0200, Paul Kocialkowski wrote:
> On Sat 27 Aug 22, 01:44, Laurent Pinchart wrote:
> > On Fri, Aug 26, 2022 at 08:41:44PM +0200, Paul Kocialkowski wrote:
> > > In order to use the isp and csi together, both devices need to be
> > > parented to the same v4l2 and media devices. We use the isp as
> > > top-level device and let the csi code hook to its v4l2 and media
> > > devices when async subdev registration takes place.
> > 
> > Have you considered the option of making the CSI the master device, with
> > the ISP registering an async subdev instead ?
> 
> Yes I did consider it but the issue is that some platforms using these drivers
> have 2 CSI blocks and always 1 ISP block that can be fed from either CSI.
> So if we want to have a single media device where we can switch the ISP between
> the two CSIs, the only choice is to have the media/v4l2 devices registered
> by the ISP driver.

Indeed.

> For the next generation it would be absolutely necessary to have a single driver
> using the component framework instead of separate drivers because the number of
> components and routing capabilities are much more complex.

Not the component framework please :-) But we do need something, I
agree. There's a media device allocator API that was meant to care for
this kind of use cases, but I'm not happy with the implementation, we
need something better. We can discuss it later once you'll have a need
for that.

> > I'm also wondering, what will happen if userspace tries to capture from
> > both the CSI output and the ISP output at the same time ?
> 
> Well there's a media link to select where the sun6i-csi-bridge data should
> flow, so if it's routed to the sun6i-isp-proc instead of sun6i-csi-capture
> it should fail when trying to capture via sun6i-csi.
> 
> I'll double-check that this is actually the case, but I think
> media_pipeline_start in sun6i_csi_capture_start_streaming should error out
> in this case.

OK, that sounds good.

> > > As a result v4l2/media device setup is only called when the ISP
> > > is missing and the capture device is registered after the devices
> > > are hooked. The bridge subdev and its notifier are registered
> > > without any device when the ISP is available. Top-level pointers
> > > for the devices are introduced to either redirect to the hooked ones
> > > (isp available) or the registered ones (isp missing).
> > > 
> > > Also keep track of whether the capture node was setup or not to
> > > avoid cleaning up resources when it wasn't.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 45 +++++++++++++++----
> > >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  7 +++
> > >  .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 32 +++++++++++--
> > >  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 19 ++++++--
> > >  .../sunxi/sun6i-csi/sun6i_csi_capture.h       |  1 +
> > >  5 files changed, 89 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > index b16166cba2ef..0bac89d8112f 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > @@ -26,6 +26,18 @@
> > >  
> > >  /* ISP */
> > >  
> > > +int sun6i_csi_isp_complete(struct sun6i_csi_device *csi_dev,
> > > +			   struct v4l2_device *v4l2_dev)
> > > +{
> > > +	if (csi_dev->v4l2_dev && csi_dev->v4l2_dev != v4l2_dev)
> > > +		return -EINVAL;
> > > +
> > > +	csi_dev->v4l2_dev = v4l2_dev;
> > > +	csi_dev->media_dev = v4l2_dev->mdev;
> > > +
> > > +	return sun6i_csi_capture_setup(csi_dev);
> > > +}
> > > +
> > >  static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
> > >  {
> > >  	struct device *dev = csi_dev->dev;
> > > @@ -95,6 +107,9 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
> > >  		goto error_media;
> > >  	}
> > >  
> > > +	csi_dev->v4l2_dev = v4l2_dev;
> > > +	csi_dev->media_dev = media_dev;
> > > +
> > >  	return 0;
> > >  
> > >  error_media:
> > > @@ -323,17 +338,27 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
> > >  	if (ret)
> > >  		goto error_resources;
> > >  
> > > -	ret = sun6i_csi_v4l2_setup(csi_dev);
> > > -	if (ret)
> > > -		goto error_resources;
> > > +	/*
> > > +	 * Register our own v4l2 and media devices when there is no ISP around.
> > > +	 * Otherwise the ISP will use async subdev registration with our bridge,
> > > +	 * which will provide v4l2 and media devices that are used to register
> > > +	 * the video interface.
> > > +	 */
> > > +	if (!csi_dev->isp_available) {
> > > +		ret = sun6i_csi_v4l2_setup(csi_dev);
> > > +		if (ret)
> > > +			goto error_resources;
> > > +	}
> > >  
> > >  	ret = sun6i_csi_bridge_setup(csi_dev);
> > >  	if (ret)
> > >  		goto error_v4l2;
> > >  
> > > -	ret = sun6i_csi_capture_setup(csi_dev);
> > > -	if (ret)
> > > -		goto error_bridge;
> > > +	if (!csi_dev->isp_available) {
> > > +		ret = sun6i_csi_capture_setup(csi_dev);
> > > +		if (ret)
> > > +			goto error_bridge;
> > > +	}
> > >  
> > >  	return 0;
> > >  
> > > @@ -341,7 +366,8 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
> > >  	sun6i_csi_bridge_cleanup(csi_dev);
> > >  
> > >  error_v4l2:
> > > -	sun6i_csi_v4l2_cleanup(csi_dev);
> > > +	if (!csi_dev->isp_available)
> > > +		sun6i_csi_v4l2_cleanup(csi_dev);
> > >  
> > >  error_resources:
> > >  	sun6i_csi_resources_cleanup(csi_dev);
> > > @@ -355,7 +381,10 @@ static int sun6i_csi_remove(struct platform_device *pdev)
> > >  
> > >  	sun6i_csi_capture_cleanup(csi_dev);
> > >  	sun6i_csi_bridge_cleanup(csi_dev);
> > > -	sun6i_csi_v4l2_cleanup(csi_dev);
> > > +
> > > +	if (!csi_dev->isp_available)
> > > +		sun6i_csi_v4l2_cleanup(csi_dev);
> > > +
> > >  	sun6i_csi_resources_cleanup(csi_dev);
> > >  
> > >  	return 0;
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > index 8e232cd91ebe..bc3f0dae35df 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > @@ -36,6 +36,8 @@ struct sun6i_csi_v4l2 {
> > >  
> > >  struct sun6i_csi_device {
> > >  	struct device			*dev;
> > > +	struct v4l2_device		*v4l2_dev;
> > > +	struct media_device		*media_dev;
> > >  
> > >  	struct sun6i_csi_v4l2		v4l2;
> > >  	struct sun6i_csi_bridge		bridge;
> > > @@ -53,4 +55,9 @@ struct sun6i_csi_variant {
> > >  	unsigned long	clock_mod_rate;
> > >  };
> > >  
> > > +/* ISP */
> > > +
> > > +int sun6i_csi_isp_complete(struct sun6i_csi_device *csi_dev,
> > > +			   struct v4l2_device *v4l2_dev);
> > > +
> > >  #endif
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> > > index 492f93b0db28..86d20c1c35ed 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> > > @@ -653,6 +653,7 @@ sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifier,
> > >  	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
> > >  	struct sun6i_csi_bridge_source *source = bridge_async_subdev->source;
> > >  	bool enabled;
> > > +	int ret;
> > >  
> > >  	switch (source->endpoint.base.port) {
> > >  	case SUN6I_CSI_PORT_PARALLEL:
> > > @@ -667,6 +668,16 @@ sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifier,
> > >  
> > >  	source->subdev = remote_subdev;
> > >  
> > > +	if (csi_dev->isp_available) {
> > > +		/*
> > > +		 * Hook to the first available remote subdev to get v4l2 and
> > > +		 * media devices and register the capture device then.
> > > +		 */
> > > +		ret = sun6i_csi_isp_complete(csi_dev, remote_subdev->v4l2_dev);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	return sun6i_csi_bridge_link(csi_dev, SUN6I_CSI_BRIDGE_PAD_SINK,
> > >  				     remote_subdev, enabled);
> > >  }
> > > @@ -679,6 +690,9 @@ sun6i_csi_bridge_notifier_complete(struct v4l2_async_notifier *notifier)
> > >  			     bridge.notifier);
> > >  	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
> > >  
> > > +	if (csi_dev->isp_available)
> > > +		return 0;
> > > +
> > >  	return v4l2_device_register_subdev_nodes(v4l2_dev);
> > >  }
> > >  
> > > @@ -752,7 +766,7 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
> > >  {
> > >  	struct device *dev = csi_dev->dev;
> > >  	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
> > > -	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
> > > +	struct v4l2_device *v4l2_dev = csi_dev->v4l2_dev;
> > >  	struct v4l2_subdev *subdev = &bridge->subdev;
> > >  	struct v4l2_async_notifier *notifier = &bridge->notifier;
> > >  	struct media_pad *pads = bridge->pads;
> > > @@ -793,7 +807,11 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
> > >  
> > >  	/* V4L2 Subdev */
> > >  
> > > -	ret = v4l2_device_register_subdev(v4l2_dev, subdev);
> > > +	if (csi_dev->isp_available)
> > > +		ret = v4l2_async_register_subdev(subdev);
> > > +	else
> > > +		ret = v4l2_device_register_subdev(v4l2_dev, subdev);
> > > +
> > >  	if (ret) {
> > >  		dev_err(dev, "failed to register v4l2 subdev: %d\n", ret);
> > >  		goto error_media_entity;
> > > @@ -810,7 +828,10 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
> > >  	sun6i_csi_bridge_source_setup(csi_dev, &bridge->source_mipi_csi2,
> > >  				      SUN6I_CSI_PORT_MIPI_CSI2, NULL);
> > >  
> > > -	ret = v4l2_async_nf_register(v4l2_dev, notifier);
> > > +	if (csi_dev->isp_available)
> > > +		ret = v4l2_async_subdev_nf_register(subdev, notifier);
> > > +	else
> > > +		ret = v4l2_async_nf_register(v4l2_dev, notifier);
> > >  	if (ret) {
> > >  		dev_err(dev, "failed to register v4l2 async notifier: %d\n",
> > >  			ret);
> > > @@ -822,7 +843,10 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
> > >  error_v4l2_async_notifier:
> > >  	v4l2_async_nf_cleanup(notifier);
> > >  
> > > -	v4l2_device_unregister_subdev(subdev);
> > > +	if (csi_dev->isp_available)
> > > +		v4l2_async_unregister_subdev(subdev);
> > > +	else
> > > +		v4l2_device_unregister_subdev(subdev);
> > >  
> > >  error_media_entity:
> > >  	media_entity_cleanup(&subdev->entity);
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> > > index c9e7526b84c4..69ea1cbaea0c 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> > > @@ -570,7 +570,7 @@ static int sun6i_csi_capture_buffer_prepare(struct vb2_buffer *buffer)
> > >  {
> > >  	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(buffer->vb2_queue);
> > >  	struct sun6i_csi_capture *capture = &csi_dev->capture;
> > > -	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
> > > +	struct v4l2_device *v4l2_dev = csi_dev->v4l2_dev;
> > >  	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(buffer);
> > >  	unsigned long size = capture->format.fmt.pix.sizeimage;
> > >  
> > > @@ -889,7 +889,7 @@ static int sun6i_csi_capture_link_validate(struct media_link *link)
> > >  	struct video_device *video_dev =
> > >  		media_entity_to_video_device(link->sink->entity);
> > >  	struct sun6i_csi_device *csi_dev = video_get_drvdata(video_dev);
> > > -	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
> > > +	struct v4l2_device *v4l2_dev = csi_dev->v4l2_dev;
> > >  	const struct sun6i_csi_capture_format *capture_format;
> > >  	const struct sun6i_csi_bridge_format *bridge_format;
> > >  	unsigned int capture_width, capture_height;
> > > @@ -971,7 +971,7 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
> > >  {
> > >  	struct sun6i_csi_capture *capture = &csi_dev->capture;
> > >  	struct sun6i_csi_capture_state *state = &capture->state;
> > > -	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
> > > +	struct v4l2_device *v4l2_dev = csi_dev->v4l2_dev;
> > >  	struct v4l2_subdev *bridge_subdev = &csi_dev->bridge.subdev;
> > >  	struct video_device *video_dev = &capture->video_dev;
> > >  	struct vb2_queue *queue = &capture->queue;
> > > @@ -980,6 +980,10 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
> > >  	struct v4l2_pix_format *pix_format = &format->fmt.pix;
> > >  	int ret;
> > >  
> > > +	/* This may happen with multiple bridge notifier bound calls. */
> > > +	if (state->setup)
> > > +		return 0;
> > > +
> > >  	/* State */
> > >  
> > >  	INIT_LIST_HEAD(&state->queue);
> > > @@ -1055,6 +1059,7 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
> > >  	ret = media_create_pad_link(&bridge_subdev->entity,
> > >  				    SUN6I_CSI_BRIDGE_PAD_SOURCE,
> > >  				    &video_dev->entity, 0,
> > > +				    csi_dev->isp_available ? 0 :
> > >  				    MEDIA_LNK_FL_ENABLED |
> > >  				    MEDIA_LNK_FL_IMMUTABLE);
> > >  	if (ret < 0) {
> > > @@ -1065,6 +1070,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
> > >  		goto error_video_device;
> > >  	}
> > >  
> > > +	state->setup = true;
> > > +
> > >  	return 0;
> > >  
> > >  error_video_device:
> > > @@ -1083,7 +1090,13 @@ void sun6i_csi_capture_cleanup(struct sun6i_csi_device *csi_dev)
> > >  	struct sun6i_csi_capture *capture = &csi_dev->capture;
> > >  	struct video_device *video_dev = &capture->video_dev;
> > >  
> > > +	/* This may happen if async registration failed to complete. */
> > > +	if (!capture->state.setup)
> > > +		return;
> > > +
> > >  	vb2_video_unregister_device(video_dev);
> > >  	media_entity_cleanup(&video_dev->entity);
> > >  	mutex_destroy(&capture->lock);
> > > +
> > > +	capture->state.setup = false;
> > >  }
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> > > index 29893cf96f6b..3ee5ccefbd10 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> > > @@ -45,6 +45,7 @@ struct sun6i_csi_capture_state {
> > >  
> > >  	unsigned int			sequence;
> > >  	bool				streaming;
> > > +	bool				setup;
> > >  };
> > >  
> > >  struct sun6i_csi_capture {

-- 
Regards,

Laurent Pinchart
