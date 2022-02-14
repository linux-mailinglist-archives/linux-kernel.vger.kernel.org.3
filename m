Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DAB4B573A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242633AbiBNQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:42:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiBNQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:42:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D6765413;
        Mon, 14 Feb 2022 08:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644856869; x=1676392869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7HBTbIry5i2v3ofkv2rXvDfAR5tIt7kfIF4pEaiDFA4=;
  b=IH/bJyZY5Mz0S+AiNEkFTm17xkYJQ4sRxlCgr0VjRUgnIWyb/bSTcCRb
   q5L5AKb3IxzCB7vUYbV8EBeLjWSEez9gma7cSaIYcL2IcoX6MlYloIN7M
   JLY7TZs9BfU08MEs45MT9pUMG50BJtFGDAewbEkflvj59z/y23lMMqTbq
   xZMBYuv71y4c+qyXV4Zi6wyr24FZBoZRE3ldhuYwxKw48a+68y/6Bzape
   9zor1xpQTP4DrOurcqrEutUTwvkIecw/LTzc00vIWQ42mZxrXUvvQEzR0
   u2mHjAlPQQ0NCrJjMJnrDxLXHgDoJOZBK3zScMdJXPk6+LD41+RHx9wxu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="274698976"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="274698976"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 08:41:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="587266599"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 08:40:58 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 962A1201DB;
        Mon, 14 Feb 2022 18:40:56 +0200 (EET)
Date:   Mon, 14 Feb 2022 18:40:56 +0200
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
Subject: Re: [PATCH v2 27/66] media: sun6i-csi: Add media ops with link
 notify callback
Message-ID: <YgqGGJJ0oVQgRoNy@paasikivi.fi.intel.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-28-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-28-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for the update.

On Sat, Feb 05, 2022 at 07:53:50PM +0100, Paul Kocialkowski wrote:
> In order to keep the power use count fields balanced when link changes
> happen between v4l2_pipeline_pm_get/set calls (in open/close),
> the link_notify media operation callback needs to be registered.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index 6f04f86504bf..c8fe31cc38b5 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -23,6 +23,7 @@
>  #include <linux/sched.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <media/v4l2-mc.h>
>  
>  #include "sun6i_csi.h"
>  #include "sun6i_csi_reg.h"
> @@ -574,6 +575,12 @@ void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable)
>  			   CSI_CAP_CH0_VCAP_ON);
>  }
>  
> +/* Media */
> +
> +static const struct media_device_ops sun6i_csi_media_ops = {
> +	.link_notify = v4l2_pipeline_link_notify,

Do you really need this?

Drivers should instead rely on runtime PM nowadays.

<URL:https://hverkuil.home.xs4all.nl/spec/driver-api/camera-sensor.html#power-management>

> +};
> +
>  /* V4L2 */
>  
>  static int sun6i_csi_link_entity(struct sun6i_csi_device *csi_dev,
> @@ -683,6 +690,7 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
>  	snprintf(media_dev->bus_info, sizeof(media_dev->bus_info),
>  		 "platform:%s", dev_name(dev));
>  	media_dev->hw_revision = 0;
> +	media_dev->ops = &sun6i_csi_media_ops;
>  	media_dev->dev = dev;
>  
>  	media_device_init(media_dev);

-- 
Kind regards,

Sakari Ailus
