Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B74B5646
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbiBNQbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:31:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiBNQbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:31:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A37960D89;
        Mon, 14 Feb 2022 08:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644856270; x=1676392270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/rNAITY1+98uvbGAZzlsiQlo0IS/4Nq0dkDRoszUuaY=;
  b=BeuZIttaCaix2+ct0TPYPBEyQC5sz40+DMQIYdYcq/4mtdQyNYrnkGdS
   MnxTVBuM1PFfdiFlnmDoFkwN4S1toC6KZ/idsbmWMLTAx9P2pBmXpCnZ7
   ixgqWiZTpCqNXmzNMZMd28GEoRVehuSM2aAoZmpYzXA7AnLB4ejo8iGmt
   2FEAePObj3qo4z93ToQr1M/dNJ3Koz6l6qz9f8slVv5gyu3q+UDdtEndK
   S3JXn1YMGiL4k73rePaZtGy4mtRD+W1fzZnm7C29rHNWdDLnVrJr+oV7I
   4pQ5MpHlkOO9HH/2Gog18PSK/+oIMF2XUhRMGa/zg3BJquZbsZUbwv4e5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250071302"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="250071302"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 08:31:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="603341808"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 08:31:04 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C7AE6201DB;
        Mon, 14 Feb 2022 18:31:01 +0200 (EET)
Date:   Mon, 14 Feb 2022 18:31:01 +0200
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
Subject: Re: [PATCH v2 21/66] media: sun6i-csi: Always set exclusive module
 clock rate
Message-ID: <YgqDxWwUeVQu+05O@paasikivi.fi.intel.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-22-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-22-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for the patchbomb.

On Sat, Feb 05, 2022 at 07:53:44PM +0100, Paul Kocialkowski wrote:
> In some situations the default rate of the module clock is not the
> required one for operation (for example when reconfiguring the clock
> tree to use a different parent). As a result, always set the correct
> rate for the clock (and take care of cleanup).
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 54 ++++++++++++++-----
>  1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index 8155e9560164..2355088fdc37 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -856,28 +849,53 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
>  		return PTR_ERR(csi_dev->clk_ram);
>  	}
>  
> +	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> +		clk_mod_rate = 300000000;
> +	else
> +		clk_mod_rate = 297000000;

This would be nice to put in OF match data.

Of course the driver did this already before the patch. The approach still
scales badly.

-- 
Regards,

Sakari Ailus
