Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7714DB16D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbiCPN2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbiCPN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:28:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237D60074;
        Wed, 16 Mar 2022 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647437250; x=1678973250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H3eR4ffkE3oVB+3S4NOOn5kmmmYiIAis+JFyVC1vbpw=;
  b=P3Ws47T2bKBbSeRULSuEwPm3kMr5/uapAOAwGnDUx6K45ZzQR2m29ZmO
   Y2KYswG8xbyKrFkOQFeaa+8ouLCwkQN/U2s94OtIihyj/8qz7MQMnENOt
   87P7ADIa6i0M5Zv6esN+/lOKJQXuvlIeGIIVvOIVXUvXJxHmvAv5L+2zw
   ldmP/l5XRfzii5nfuGLUtu+eRUrUwTmk7/Qhvnok0i35rQtcwWou6hRIm
   nOvnabEWlo5KxUbPsnjVu6mrlj1vszH4V3bJIa+TV9Ij4ehhfKnioNx+k
   O4mQa7PDB8SKV8oochnU+2gmHaQ2KE+EookRcDk9MVLgGBzyLmDa8vus/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256311786"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256311786"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 06:27:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="516331411"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 06:27:25 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 2EEEA20090;
        Wed, 16 Mar 2022 15:27:23 +0200 (EET)
Date:   Wed, 16 Mar 2022 15:27:23 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 5/9] media: sunxi: Add support for the A31 MIPI CSI-2
 controller
Message-ID: <YjHluwVnbPyHo1kp@paasikivi.fi.intel.com>
References: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
 <20220302220739.144303-6-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302220739.144303-6-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for the set.

On Wed, Mar 02, 2022 at 11:07:35PM +0100, Paul Kocialkowski wrote:
...
> +static int sun6i_mipi_csi2_s_stream(struct v4l2_subdev *subdev, int on)
> +{
> +	struct sun6i_mipi_csi2_device *csi2_dev = v4l2_get_subdevdata(subdev);
> +	struct v4l2_subdev *source_subdev = csi2_dev->bridge.source_subdev;
> +	union phy_configure_opts dphy_opts = { 0 };
> +	struct phy_configure_opts_mipi_dphy *dphy_cfg = &dphy_opts.mipi_dphy;
> +	struct v4l2_mbus_framefmt *mbus_format = &csi2_dev->bridge.mbus_format;
> +	const struct sun6i_mipi_csi2_format *format;
> +	struct phy *dphy = csi2_dev->dphy;
> +	struct device *dev = csi2_dev->dev;
> +	struct v4l2_ctrl *ctrl;
> +	unsigned int lanes_count =
> +		csi2_dev->bridge.endpoint.bus.mipi_csi2.num_data_lanes;
> +	unsigned long pixel_rate;
> +	/* Initialize to 0 to use both in disable label (ret != 0) and off. */
> +	int ret = 0;
> +
> +	if (!source_subdev)
> +		return -ENODEV;
> +
> +	if (!on) {
> +		v4l2_subdev_call(source_subdev, video, s_stream, 0);
> +		goto disable;
> +	}
> +
> +	/* Runtime PM */
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Sensor Pixel Rate */
> +
> +	ctrl = v4l2_ctrl_find(source_subdev->ctrl_handler, V4L2_CID_PIXEL_RATE);
> +	if (!ctrl) {
> +		dev_err(dev, "missing sensor pixel rate\n");
> +		ret = -ENODEV;
> +		goto error_pm;
> +	}
> +
> +	pixel_rate = (unsigned long)v4l2_ctrl_g_ctrl_int64(ctrl);
> +	if (!pixel_rate) {
> +		dev_err(dev, "missing (zero) sensor pixel rate\n");
> +		ret = -ENODEV;
> +		goto error_pm;
> +	}
> +
> +	/* D-PHY */
> +
> +	if (!lanes_count) {

I first thought this check could be moved to the beginning, but it's also
redundant. v4l2_fwnode_endpoint_parse() will check the configuration is
valid, i.e. the number of lanes is not zero.

But should you add checks to make sure the hardware supports what has been
configured? I'd do that right after parsing the endpoint.

And you only seem to be using the number of data lanes, nothing more. So
I'd store that, instead of the entire parsed v4l2_fwnode_endpoint.

The same applies to patch 8.

I think these could be done on top of this set after it is merged. Up to
you.

...

> +static int
> +sun6i_mipi_csi2_bridge_source_setup(struct sun6i_mipi_csi2_device *csi2_dev)
> +{
> +	struct v4l2_async_notifier *notifier = &csi2_dev->bridge.notifier;
> +	struct v4l2_fwnode_endpoint *endpoint = &csi2_dev->bridge.endpoint;
> +	struct v4l2_async_subdev *subdev_async;
> +	struct fwnode_handle *handle;
> +	struct device *dev = csi2_dev->dev;
> +	int ret;
> +
> +	handle = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> +						 FWNODE_GRAPH_ENDPOINT_NEXT);
> +	if (!handle)
> +		return -ENODEV;
> +
> +	endpoint->bus_type = V4L2_MBUS_CSI2_DPHY;
> +
> +	ret = v4l2_fwnode_endpoint_parse(handle, endpoint);
> +	if (ret)
> +		goto complete;
> +
> +	subdev_async = v4l2_async_nf_add_fwnode_remote(notifier, handle,
> +		struct v4l2_async_subdev);
> +	if (IS_ERR(subdev_async))
> +		ret = PTR_ERR(subdev_async);
> +
> +complete:
> +	fwnode_handle_put(handle);
> +
> +	return ret;
> +}

-- 
Kind regards,

Sakari Ailus
