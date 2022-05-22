Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6D5304F5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 19:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349787AbiEVReT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 13:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbiEVReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 13:34:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3AA2DD4F;
        Sun, 22 May 2022 10:34:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [86.8.200.222])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 483AE45F;
        Sun, 22 May 2022 19:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1653240852;
        bh=7MpQyQtc2TVtgxChF+m8fe8kdSmQrvHBDgzor7SU3ZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b76UBaw56+3iTwuNMjpS/go4euO+izOU1tmFouq9rysNYQ9Zltpuf0/gJGefURTnc
         bHx15JyuHsc5CFaBVT7a2qcha1xufhVJFmqnpbxxNOqAAc1veniaDJql3+Czh/HqFs
         g+ky4DRRl1oPH+McPckf21DmeFO4P8OLNpMZdwI8=
Date:   Sun, 22 May 2022 20:34:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
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
Subject: Re: [PATCH v3 3/4] staging: media: Add support for the Allwinner A31
 ISP
Message-ID: <Yop0DGOo1ky2dfnv@pendragon.ideasonboard.com>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-4-paul.kocialkowski@bootlin.com>
 <YmqFQSRBsqs4ghNQ@valkosipuli.retiisi.eu>
 <Ymqk89e+mn/1kLLx@aptenodytes>
 <YmsCJicyzf+Bz98y@valkosipuli.retiisi.eu>
 <YoesXywA4yzBDSwU@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoesXywA4yzBDSwU@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, May 20, 2022 at 04:57:35PM +0200, Paul Kocialkowski wrote:
> On Fri 29 Apr 22, 00:07, Sakari Ailus wrote:
> > On Thu, Apr 28, 2022 at 04:30:11PM +0200, Paul Kocialkowski wrote:
> > > Hi Sakari,
> > > 
> > > On Thu 28 Apr 22, 15:14, Sakari Ailus wrote:
> > > > Hi Paul,
> > > > 
> > > > Thanks for the set.
> > > > 
> > > > A few comments below.
> > > 
> > > Thanks a lot for your review!
> > 
> > You're welcome!
> > 
> > ...
> > 
> > > > I understand this is an online ISP. How do you schedule the video buffer
> > > > queues? Say, what happens if it's time to set up buffers for a frame and
> > > > there's a buffer queued in the parameter queue but not in the image data
> > > > queue? Or the other way around?
> > > 
> > > The ISP works in a quite atypical way, with a DMA buffer that is used to
> > > hold upcoming parameters (including buffer addresses) and a bit in a "direct"
> > > register to schedule the update of the parameters at next vsync.
> > > 
> > > The update (setting the bit) is triggered whenever new parameters are
> > > submitted via the params video device or whenever there's a capture buffer
> > > available in the capture video device.
> > > 
> > > So you don't particularly need to have one parameter buffer matching a capture
> > > buffer, the two can be updated independently. Of course, a capture buffer will
> > > only be returned after another buffer becomes active.
> > 
> > This also means it's not possible to associate a capture buffer to a
> > parameter buffer by other means than timing --- which is unreliable. The
> > request API would allow that but it's not free of issues either.
> 
> Yes the request API seems like a good fit for this. Note that the returned
> sequence number in dequeued buffers for the capture and meta video devices
> should match though, so userspace still has a way to know which captured buffer
> used parameters from which meta params buffer.
> 
> > Alternatively, I think in this case you could always require the capture
> > buffer and grab a parameter buffer when it's available. As ISPs are
> > generally requiring device specific control software, this shouldn't be a
> > problem really.
> 
> I think this is pretty much what happens already.
> 
> > I wonder what Laurent thinks.

If parameters buffers are optional, I think the request API should be
used, otherwise we won't be able to ensure per-frame control. The
alternative is to make the parameter buffer mandatory for every frame,
even if no parameters have changed. Or maybe that's the case already ?

> > > I hope this answers your concern!
> > > 
> > > [...]
> > > 
> > > > > +static int sun6i_isp_tables_setup(struct sun6i_isp_device *isp_dev)
> > > > > +{
> > > > > +	struct sun6i_isp_tables *tables = &isp_dev->tables;
> > > > > +	int ret;
> > > > > +
> > > > > +	/* Sizes are hardcoded for now but actually depend on the platform. */
> > > > 
> > > > Would it be cleaner to have them defined in a platform-specific way, e.g.
> > > > in a struct you obtain using device_get_match_data()?
> > > 
> > > Absolutely! I didn't do it at this stage since only one platform is supported
> > > but we could just as well introduce a variant structure already for the table
> > > sizes.
> > 
> > I think that would be nice already, especially if you know these are going
> > to be different. Otherwise macros could be an option.
> 
> Understood!
> 
> > ...
> > 
> > > > > +	ret = v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
> > > > 
> > > > I suppose you intend to add controls later on?
> > > 
> > > I might be wrong but I thought this was necessary to expose sensor controls
> > > registered by subdevs that end up attached to this v4l2 device.
> > > 
> > > I doubt the drivers itself will expose controls otherwise.
> > 
> > Now that this is an MC-enabled driver, the subdev controls should be
> > accessed through the subdev nodes only. Adding them to the video device's
> > control handler is quite hackish and not guaranteed to even work (as e.g.
> > multiple subdevs can have the same control).
> 
> Yes I was wondering what would happen in that case. I'll drop the ctrls
> handling in the next iteration then.
> 
> Paul
> 
> > ...
> > 
> > > > > +{
> > > > > +	struct sun6i_isp_device *isp_dev = video_drvdata(file);
> > > > > +	struct video_device *video_dev = &isp_dev->capture.video_dev;
> > > > > +	struct mutex *lock = &isp_dev->capture.lock;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (mutex_lock_interruptible(lock))
> > > > > +		return -ERESTARTSYS;
> > > > > +
> > > > > +	ret = v4l2_pipeline_pm_get(&video_dev->entity);
> > > > 
> > > > Do you need this?
> > > > 
> > > > Drivers should primarily depend on runtime PM, this is only needed for
> > > > compatibility reasons. Instead I'd like to see sensor drivers being moved
> > > > to runtime PM.
> > > 
> > > Yes it's still needed to support sensor drivers that don't use rpm yet.
> > 
> > To that I suggested adding runtime PM support for the affected sensors.
> > This doesn't seem to get done otherwise. E.g. ipu3-cio2 driver does not
> > call s_power() on sensor subdevs.
> > 
> > ...
> > 
> > > > > +	ret = video_register_device(video_dev, VFL_TYPE_VIDEO, -1);
> > > > > +	if (ret) {
> > > > > +		v4l2_err(v4l2_dev, "failed to register video device: %d\n",
> > > > > +			 ret);
> > > > > +		goto error_media_entity;
> > > > > +	}
> > > > > +
> > > > > +	v4l2_info(v4l2_dev, "device %s registered as %s\n", video_dev->name,
> > > > > +		  video_device_node_name(video_dev));
> > > > 
> > > > This isn't really driver specific. I'd drop it.
> > > 
> > > I agree but I see that many drivers are doing it and the information can
> > > actually be quite useful at times.
> > 
> > You can get that information using media-ctl -e 'entity name'.
> > 
> > I guess this could be also added to video_register_device() on debug level.
> > 
> > > > > +struct sun6i_isp_params_config_bdnf {
> > > > > +	__u8	in_dis_min; // 8
> > > > > +	__u8	in_dis_max; // 10
> > > > 
> > > > Are these default values or something else? Better documentation was in the
> > > > TODO.txt file already.
> > > 
> > > Yes that's the default register values, but these comments are and overlook on
> > > my side and should be removed.
> > 
> > I'm fine leaving these here. Just wondering. Up to you.

-- 
Regards,

Laurent Pinchart
