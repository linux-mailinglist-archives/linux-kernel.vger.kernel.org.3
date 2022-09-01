Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4A25A9EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiIASPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiIASPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:15:21 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F433423;
        Thu,  1 Sep 2022 11:15:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 96F5C6CD;
        Thu,  1 Sep 2022 20:15:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662056100;
        bh=zRBz0GUyRGTxcADlcmJSiGE78jaeWQ5MWIZCKWdpg9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxeZCtoherm0RTZ5pf1+4qwa+MUrepmLXoCB4lbxK8Wqftsdg9ZErsiZmXcfidAlt
         mqrkIYfjgKajGwXoC067yGf7ao9xRIZURJHkRYGU8gsr3OXozm8XCPbR/TQsjb8r4L
         rS9b0Eud84d3MrbXXnsgu3/JQW+JYTnPbNaJptgo=
Date:   Thu, 1 Sep 2022 21:14:49 +0300
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
Subject: Re: [PATCH v6 5/6] media: sun6i-csi: Detect the availability of the
 ISP
Message-ID: <YxD2maSZhkotqMiL@pendragon.ideasonboard.com>
References: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
 <20220826184144.605605-6-paul.kocialkowski@bootlin.com>
 <YwlLsKaEOoXdqRK0@pendragon.ideasonboard.com>
 <YxDLhPMibhXO1oU/@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxDLhPMibhXO1oU/@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Sep 01, 2022 at 05:11:00PM +0200, Paul Kocialkowski wrote:
> On Sat 27 Aug 22, 01:39, Laurent Pinchart wrote:
> > On Fri, Aug 26, 2022 at 08:41:43PM +0200, Paul Kocialkowski wrote:
> > > Add a helper to detect whether the ISP is available and connected
> > > and store the indication in a driver-wide variable.
> > 
> > This sounds like it would be a global variable, while it's stored in the
> > driver-specific device structure.
> 
> Okay I can clarify the commit message here.
> 
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++++++++
> > >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
> > >  2 files changed, 36 insertions(+)
> > > 
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > index 00521f966cee..b16166cba2ef 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > @@ -24,6 +24,35 @@
> > >  #include "sun6i_csi_capture.h"
> > >  #include "sun6i_csi_reg.h"
> > >  
> > > +/* ISP */
> > > +
> > > +static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
> > > +{
> > > +	struct device *dev = csi_dev->dev;
> > > +	struct fwnode_handle *handle = NULL;
> > 
> > No need to initialize this to NULL.
> 
> Indeed.
> 
> > > +
> > > +	/* ISP is not available if disabled in kernel config. */
> > > +	if (!IS_ENABLED(CONFIG_VIDEO_SUN6I_ISP))
> > > +		return 0;
> > 
> > Hmmm... The ISP driver may be disabled when compiling the sun6i-csi
> > driver, but later enabled and deployed. Disabling ISP support silently
> > like this could be confusing. Could it be better to move this check
> > after the graph check, and print a warning message in this case ?
> 
> Yeah I'm not too surprised corner cases like this can exist.
> Agreed that printing a warning message would be good, but I don't follow the
> point of moving the check later on. Do you have something in mind there?

I meant that the warning should only be printed of there's an endpoint
connected to the ISP, so I'd first check if the endpoint is present,
return 0 if it isn't, and then check if the ISP driver is enabled and
print a warning if it isn't.

> > > +
> > > +	/*
> > > +	 * ISP is not available if not connected via fwnode graph.
> > > +	 * This weill also check that the remote parent node is available.
> > 
> > s/weill/will/
> 
> Good catch, thanks!
> 
> > 	 * ISP is not available if not connected via fwnode graph. This will
> > 	 * also check that the remote parent node is available.
> > 
> > > +	 */
> > > +	handle = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
> > > +						 SUN6I_CSI_PORT_ISP, 0,
> > > +						 FWNODE_GRAPH_ENDPOINT_NEXT);
> > > +	if (!handle)
> > > +		return 0;
> > > +
> > > +	fwnode_handle_put(handle);
> > > +
> > > +	dev_info(dev, "ISP link is available\n");
> > 
> > You could make that a debug message, it's not crucial information that
> > needs to be printed when the driver is loaded. If you prefer keeping an
> > info message, then I'd move it to the probe function and print that the
> > CSI has been probed, and indicate in that message if the ISP is
> > available.
> 
> You're right, let's make this debug. It's more the opposite case that is worth
> a warning message.
> 
> > > +	csi_dev->isp_available = true;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /* Media */
> > >  
> > >  static const struct media_device_ops sun6i_csi_media_ops = {
> > > @@ -290,6 +319,10 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	ret = sun6i_csi_isp_detect(csi_dev);
> > > +	if (ret)
> > > +		goto error_resources;
> > > +
> > >  	ret = sun6i_csi_v4l2_setup(csi_dev);
> > >  	if (ret)
> > >  		goto error_resources;
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > index e611bdd6e9b2..8e232cd91ebe 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > @@ -21,6 +21,7 @@
> > >  enum sun6i_csi_port {
> > >  	SUN6I_CSI_PORT_PARALLEL		= 0,
> > >  	SUN6I_CSI_PORT_MIPI_CSI2	= 1,
> > > +	SUN6I_CSI_PORT_ISP		= 2,
> > >  };
> > >  
> > >  struct sun6i_csi_buffer {
> > > @@ -44,6 +45,8 @@ struct sun6i_csi_device {
> > >  	struct clk			*clock_mod;
> > >  	struct clk			*clock_ram;
> > >  	struct reset_control		*reset;
> > > +
> > > +	bool				isp_available;
> > >  };
> > >  
> > >  struct sun6i_csi_variant {

-- 
Regards,

Laurent Pinchart
