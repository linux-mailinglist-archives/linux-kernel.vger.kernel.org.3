Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A874AB8EE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245652AbiBGKi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiBGKft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:35:49 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A9BC043181;
        Mon,  7 Feb 2022 02:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644230148; x=1675766148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xm+zj6goisuqCJN2ekKk7zV6UfCUht5ppayoqpY1lLo=;
  b=TOVul1DDBBd2MCO69CZRt9h9bxhT9NSeU7KwTzucRmAoX7fdycwZFXpJ
   Ydx+l7fsHgCbzZFhFRXEeubHEAnpltS06H5wfVMO0qFIfborHp1TSb0/g
   pCp8G6jdqAFE74nj8PcOHj3G/gHDUIN3yJAsUtSHmi5AbqxY+vC6MzUNH
   AdOgEh3uh5wYj6vBrupMlxIXqBTM++8tzy3jJWKkvoKAOL3OSSdI3MTkp
   XAIKPVfzWpTANld1GoS9qTknsmsnez2y1PniTjZgDcabZT28zTtmeLDX8
   tLhkSq8LfcNsKARA8K2fagi/rhOpmPgWqUhnnl67sgNLXj4vP8jGu5GJY
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21929419"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Feb 2022 11:35:46 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Feb 2022 11:35:46 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Feb 2022 11:35:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644230146; x=1675766146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xm+zj6goisuqCJN2ekKk7zV6UfCUht5ppayoqpY1lLo=;
  b=MmbSuvaegsMgPBJuepzfmivdIWkhZRna2n4Sqnjr58yzD+JhcLGtv8Da
   ueAxG3BIZGHNXvzzAeTZ8QVH4WXn5cJjpjy4YUVIdQpwJ+uWgdAvzuXRh
   s77PdtYuDJcdZ1qXZ+fqflP+SaMJfDHTVIDIwhuCktlW7wc3Y3xIWIxDC
   Fw0JQLpC7FvCC7knWNrsuxtrI3Bb5WSWQVWMvN+LVuAKsrVnOEKEzE3+J
   zgtoZdUei70cHA+trHpDLVTPEElSCXbxSHoV7Zxh0tkhtKVdfT6LM9Mmn
   ykTNl0643snNyPSqBd0QTm4MUkqjQsMYkzRPi9LYGetXrcxWAf4S3DMpO
   A==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21929418"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Feb 2022 11:35:46 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DFB01280065;
        Mon,  7 Feb 2022 11:35:45 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH 7/8] media: imx: utils: Add more Bayer formats
Date:   Mon, 07 Feb 2022 11:35:45 +0100
Message-ID: <822120126.0ifERbkFSE@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Yf3vmMP6EfjyeXOb@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com> <20220204121514.2762676-8-alexander.stein@ew.tq-group.com> <Yf3vmMP6EfjyeXOb@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Am Samstag, 5. Februar 2022, 04:31:36 CET schrieb Laurent Pinchart:
> Hi Alexander,
> 
> Thank you for the patch.
> 
> On Fri, Feb 04, 2022 at 01:15:13PM +0100, Alexander Stein wrote:
> > Without this the ioctl VIDIOC_ENUM_FMT will not list the 10/12/14-Bit
> > Bayer formats. This in return results in
> > "v4l2-ctl --set-fmt-video pixelformat='RG10'" failing to set the
> > pixelformat as it is not enumerated as supported format.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> Do IPUv3-based SoCs support 10-, 12- and 14-bit formats ? If so,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I'm no expert regarding IPUv3. But according to i.MX6D/Q RM Rev4 apparently 
there is difference between Bayer format or "Generic data" 
(CSI0_SENS_DATA_FORMAT: b011). Data width is set independently in 
CSI0_DATA_WIDTH where 10-, 12- and 14-bit is supported (even the odd ones in 
bewteen).
I don't know if I got the right place, but [1] seems to do the mapping for 
IPUv3 what imx7_csi_configure() is doing for CSI on imx7/8. The 
MEDIA_BUS_FMT_Sxxxx14_1X14 formats are not added to the list yet though, but 
that is a different matter.
Unless someone objects I'm going forwards with this patch.

Regards,
Alexander

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
drivers/gpu/ipu-v3/ipu-csi.c#n302

> > ---
> > This adds the following formats to `v4l2-ctl --list-formats`
> > [...]
> > 
> >         [18]: 'BG10' (10-bit Bayer BGBG/GRGR)
> >         [19]: 'GB10' (10-bit Bayer GBGB/RGRG)
> >         [20]: 'BA10' (10-bit Bayer GRGR/BGBG)
> >         [21]: 'RG10' (10-bit Bayer RGRG/GBGB)
> >         [22]: 'BG12' (12-bit Bayer BGBG/GRGR)
> >         [23]: 'GB12' (12-bit Bayer GBGB/RGRG)
> >         [24]: 'BA12' (12-bit Bayer GRGR/BGBG)
> >         [25]: 'RG12' (12-bit Bayer RGRG/GBGB)
> >         [26]: 'BG14' (14-bit Bayer BGBG/GRGR)
> >         [27]: 'GB14' (14-bit Bayer GBGB/RGRG)
> >         [28]: 'GR14' (14-bit Bayer GRGR/BGBG)
> >         [29]: 'RG14' (14-bit Bayer RGRG/GBGB)
> > 
> > [...]
> > 
> >  drivers/staging/media/imx/imx-media-utils.c | 72 +++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> > 
> > diff --git a/drivers/staging/media/imx/imx-media-utils.c
> > b/drivers/staging/media/imx/imx-media-utils.c index
> > e0a256a08c3b..ea56c82d3b32 100644
> > --- a/drivers/staging/media/imx/imx-media-utils.c
> > +++ b/drivers/staging/media/imx/imx-media-utils.c
> > @@ -130,6 +130,78 @@ static const struct imx_media_pixfmt pixel_formats[]
> > = {> 
> >  		.cs     = IPUV3_COLORSPACE_RGB,
> >  		.bpp    = 8,
> >  		.bayer  = true,
> > 
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SBGGR10,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR10_1X10),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 10,
> > +		.bayer  = true,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SGBRG10,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG10_1X10),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 10,
> > +		.bayer  = true,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SGRBG10,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG10_1X10),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 10,
> > +		.bayer  = true,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SRGGB10,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB10_1X10),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 10,
> > +		.bayer  = true,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SBGGR12,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR12_1X12),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 12,
> > +		.bayer  = true,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SGBRG12,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG12_1X12),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 12,
> > +		.bayer  = true,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SGRBG12,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG12_1X12),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 12,
> > +		.bayer  = true,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SRGGB12,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB12_1X12),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 12,
> > +		.bayer  = true,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SBGGR14,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR14_1X14),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 14,
> > +		.bayer  = true,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SGBRG14,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG14_1X14),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 14,
> > +		.bayer  = true,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SGRBG14,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG14_1X14),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 14,
> > +		.bayer  = true,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_SRGGB14,
> > +		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB14_1X14),
> > +		.cs     = IPUV3_COLORSPACE_RGB,
> > +		.bpp    = 14,
> > +		.bayer  = true,
> > 
> >  	}, {
> >  	
> >  		.fourcc = V4L2_PIX_FMT_SBGGR16,
> >  		.codes  = IMX_BUS_FMTS(




