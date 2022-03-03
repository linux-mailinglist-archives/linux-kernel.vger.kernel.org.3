Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52194CC95A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiCCWow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiCCWot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:44:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C3F15928A;
        Thu,  3 Mar 2022 14:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646347442; x=1677883442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LGs61FMx3IeFD9eB7+GKLp/0tGX59gvBzS7laALfEFU=;
  b=ddfYk6zLewr44AgGkgnryfNqOwg4t31DsOhFNR4zkzSsDKNn12tE7ntx
   0IbIUol8cwEUrIFdUgIfI7sZoapOr0Cjagz//jnZowqRYF5jpZOdE+i+b
   P8J6Cwm9JqP6CdScMR9ewiixR/xLSwufB50GWYAUV3wNnqu6Xs1TpvU9v
   JeCG/Kj/L6a+jUxiytbf3/w1UhutbmgdPde0VhB5vCZ7jbZxQqYglSOgl
   5TIP3mM27UYeBDwr+c8SqmhcewpXq3fLhN2Vn+/2KJfFY2vM1UiEFgd8z
   xJYqksmtko7+dlb3oD66NQpiXcqKjoEkC8rzVppzANe+t0LXB3gc0cKf/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="252660211"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="252660211"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 14:44:02 -0800
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="642299153"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 14:43:57 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 33DDE20150;
        Fri,  4 Mar 2022 00:43:55 +0200 (EET)
Date:   Fri, 4 Mar 2022 00:43:55 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 30/66] media: sun6i-csi: Add bridge v4l2 subdev with
 port management
Message-ID: <YiFEq1liAnBy0fkq@paasikivi.fi.intel.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-31-paul.kocialkowski@bootlin.com>
 <YgqbqVRinNxQ8+WV@paasikivi.fi.intel.com>
 <Yh+GZv9/rKQ2WbI2@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh+GZv9/rKQ2WbI2@aptenodytes>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Mar 02, 2022 at 03:59:50PM +0100, Paul Kocialkowski wrote:
> > > +static int
> > > +sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifier,
> > > +				struct v4l2_subdev *remote_subdev,
> > > +				struct v4l2_async_subdev *async_subdev)
> > > +{
> > > +	struct sun6i_csi_device *csi_dev =
> > > +		container_of(notifier, struct sun6i_csi_device,
> > > +			     bridge.notifier);
> > > +	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
> > > +	struct sun6i_csi_bridge_source *source = NULL;
> > > +	struct fwnode_handle *fwnode = dev_fwnode(csi_dev->dev);
> > > +	struct fwnode_handle *handle = NULL;
> > > +	bool enabled;
> > > +	int ret;
> > > +
> > > +	while ((handle = fwnode_graph_get_next_endpoint(fwnode, handle))) {
> > 
> > I'd instead store the information you need here in struct sun6i_csi_bridge.
> > You could remove the loop here.
> 
> Is there a different method for matching a remote subdev to a local port?
> The rationale here is that I need the handle for fwnode_graph_parse_endpoint
> but cannot get that handle from the remote subdev's fwnode pointer directly.

You generally shouldn't try to match fwnodes here as the V4L2 async
framework has already done that job. This information can be found behind
the async_subdev pointer.

See e.g. drivers/media/pci/intel/ipu3/ipu3-cio2-main.c for an example.

> 
> > > +		struct fwnode_endpoint endpoint = { 0 };
> > > +		struct fwnode_handle *remote_fwnode;
> > > +
> > > +		remote_fwnode = fwnode_graph_get_remote_port_parent(handle);
> > > +		if (!remote_fwnode)
> > > +			continue;
> > > +
> > > +		if (remote_fwnode != remote_subdev->fwnode)
> > > +			goto next;
> > > +
> > > +		ret = fwnode_graph_parse_endpoint(handle, &endpoint);
> > > +		if (ret < 0)
> > > +			goto next;
> > > +
> > > +		switch (endpoint.port) {
> > > +		case SUN6I_CSI_PORT_PARALLEL:
> > > +			source = &bridge->source_parallel;
> > > +			enabled = true;
> > > +			break;
> > > +		default:
> > > +			break;
> > > +		}
> > > +
> > > +next:
> > > +		fwnode_handle_put(remote_fwnode);
> > > +	}
> > > +
> > > +	if (!source)
> > > +		return -EINVAL;
> > > +
> > > +	source->subdev = remote_subdev;
> > > +
> > > +	return sun6i_csi_bridge_link(csi_dev, SUN6I_CSI_BRIDGE_PAD_SINK,
> > > +				     remote_subdev, enabled);
> > > +}
> > > +
> > > +static int
> > > +sun6i_csi_bridge_notifier_complete(struct v4l2_async_notifier *notifier)
> > > +{
> > > +	struct sun6i_csi_device *csi_dev =
> > > +		container_of(notifier, struct sun6i_csi_device,
> > > +			     bridge.notifier);
> > > +
> > > +	return sun6i_csi_v4l2_complete(csi_dev);
> > 
> > You could call v4l2_device_register_subdev_nodes() here.
> 
> That's definitely what sun6i_csi_v4l2_complete does (the diff is probably not
> very clear). Note that the wrapper is extended later on to register the capture
> video device for the no-isp path.

I could be missing something... Do you need to call
sun6i_csi_v4l2_complete() in multiple places or not? If not, then I think
it'd be probably better to just move the code here.

> 
> Maybe the capture registration could be kept in sun6i_csi_probe for the non-isp
> path and then the wrapper wouldn't be needed. I don't mind either way.

-- 
Kind regards,

Sakari Ailus
