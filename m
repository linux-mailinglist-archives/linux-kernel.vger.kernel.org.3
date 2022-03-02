Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681CF4C9FE1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiCBIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240234AbiCBIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:52:26 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4B6BB0BB;
        Wed,  2 Mar 2022 00:51:42 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B2C62A04;
        Wed,  2 Mar 2022 09:51:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646211099;
        bh=cbzPGIwgXJdg7L3y0VO7R5FjmCa4xay9OWwPMF71EJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3O8fi11Gp7hoTmSzMtUWa37EFrB/cKOrROkphix2NDKx30J/gcT2BsFswLGvuEY0
         y8hZn8JAKXwxMViZKN56dONwX2TATkgxIwWhsUb8+49nMVqoKxpIuZWc31bLIt+qSg
         QtN7oReI0oz9pRMYpzUV/6Hq2FsnfGAvBzacy+2Y=
Date:   Wed, 2 Mar 2022 10:51:27 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 63/66] staging: media: Add support for the Allwinner
 A31 ISP
Message-ID: <Yh8wD8lF2Hs+cxD7@pendragon.ideasonboard.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-64-paul.kocialkowski@bootlin.com>
 <YgFFxMd2htKvX0K1@pendragon.ideasonboard.com>
 <Yh5CuyEJ+WhIAzYm@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yh5CuyEJ+WhIAzYm@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Mar 01, 2022 at 04:58:51PM +0100, Paul Kocialkowski wrote:
> On Mon 07 Feb 22, 18:16, Laurent Pinchart wrote:
> > On Sat, Feb 05, 2022 at 07:54:26PM +0100, Paul Kocialkowski wrote:
> > > Some Allwinner platforms come with an Image Signal Processor, which
> > > supports various features in order to enhance and transform data
> > > received by image sensors into good-looking pictures. In most cases,
> > > the data is raw bayer, which gets internally converted to RGB and
> > > finally YUV, which is what the hardware produces.
> > > 
> > > This driver supports ISPs that are similar to the A31 ISP, which was
> > > the first standalone ISP found in Allwinner platforms. Simpler ISP
> > > blocks were found in the A10 and A20, where they are tied to a CSI
> > > controller. Newer generations of Allwinner SoCs (starting with the
> > > H6, H616, etc) come with a new camera subsystem and revised ISP.
> > > Even though these previous and next-generation ISPs are somewhat
> > > similar to the A31 ISP, they have enough significant differences to
> > > be out of the scope of this driver.
> > > 
> > > While the ISP supports many features, including 3A and many
> > > enhancement blocks, this implementation is limited to the following:
> > > - V3s (V3/S3) platform support;
> > > - Bayer media bus formats as input;
> > 
> > Greyscale formats would also be nice to have, if the hardware can
> > support that (it mostly just requires the ability to disable the CFA
> > interpolation).
> 
> As far as I know there's no support for grayscale, only bayer formats
> and YUV.
> 
> > > - Semi-planar YUV (NV12/NV21) as output;
> > 
> > Packed YUV would also be useful if the hardware supports it.
> 
> Same here, it only supports planar and semi-planar YUV as output.
> 
> > > - Debayering with per-component gain and offset configuration;
> > > - 2D noise filtering with configurable coefficients.
> > > 
> > > Since many features are missing from the associated uAPI, the driver
> > > is aimed to integrate staging until all features are properly
> > > described.
> > > 
> > > On the technical side, it uses the v4l2 and media controller APIs,
> > > with a video node for capture, a processor subdev and a video node
> > > for parameters submission. A specific uAPI structure and associated
> > > v4l2 meta format are used to configure parameters of the supported
> > > modules.
> > > 
> > > One particular thing about the hardware is that configuration for
> > > module registers needs to be stored in a DMA buffer and gets copied
> > > to actual registers by the hardware at the next vsync, when instructed
> > > by a flag. This is handled by the "state" mechanism in the driver.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/staging/media/sunxi/Kconfig           |   1 +
> > >  drivers/staging/media/sunxi/Makefile          |   1 +
> > >  drivers/staging/media/sunxi/sun6i-isp/Kconfig |  13 +
> > >  .../staging/media/sunxi/sun6i-isp/Makefile    |   4 +
> > >  .../staging/media/sunxi/sun6i-isp/sun6i_isp.c | 572 +++++++++++++
> > >  .../staging/media/sunxi/sun6i-isp/sun6i_isp.h |  86 ++
> > >  .../media/sunxi/sun6i-isp/sun6i_isp_capture.c | 751 ++++++++++++++++++
> > >  .../media/sunxi/sun6i-isp/sun6i_isp_capture.h |  78 ++
> > >  .../media/sunxi/sun6i-isp/sun6i_isp_params.c  | 573 +++++++++++++
> > >  .../media/sunxi/sun6i-isp/sun6i_isp_params.h  |  52 ++
> > >  .../media/sunxi/sun6i-isp/sun6i_isp_proc.c    | 599 ++++++++++++++
> > >  .../media/sunxi/sun6i-isp/sun6i_isp_proc.h    |  61 ++
> > >  .../media/sunxi/sun6i-isp/sun6i_isp_reg.h     | 275 +++++++
> > >  .../sunxi/sun6i-isp/uapi/sun6i-isp-config.h   |  43 +
> > 
> > Could you add a TODO file to list the issues that need to be fixed for
> > the driver to move out of staging ? I'll already propose one entry:
> > 
> > - Add support in libcamera
> 
> Maybe it would be good to narrow down what level of support you have in mind
> here. Just adding basic support fort the pipeline is probably doable, but
> developing complex 3A algorithms would require very significant effort and
> it would be a shame that this prevents the driver from leaving staging.
> 
> I think another obvious task would be to have a complete uAPI that reflects
> all modules that are part of the ISP.
> 
> What do you think?

The reason why I'd like to see libcamera support for the ISP driver is
to ensure that the kernel API is adequate for real use cases. The API
can be split in three parts:

- Pipeline configuration (this includes the media controller topology,
  link setting, subdev pad format/selection rectangle configuration,
  ...)
- ISP parameters
- ISP statistics

A pipeline handler implementation will cover the first parts. The second
and third parts need to be tested too, but we don't need to implement
every single feature. A very simple algorithm that demonstrates
statistics can be captured and ISP parameters can be set should be
enough to test and exercise the API in real scenarios. We're working on
making basic AE and AWB algorithm implementations generic (or at least
creating generic building blocks that can easily be assembled to create
those algorithms, as the ISP statistics and parameters are specific to
the ISP and thus require some ISP-specific code), so that should become
a fairly easy task soon. I expect most of the work to go in the pipeline
handler.

Does this sound fair to you ?

> > This isn't required to merge the driver in staging as long as ABI
> > compatibility doesn't need to be preserved until the driver is moved out
> > of staging.
> >
> > >  14 files changed, 3109 insertions(+)
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Kconfig
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Makefile
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.h
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.h
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.h
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.h
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h
> > >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-config.h
> > 
> > [snip]

-- 
Regards,

Laurent Pinchart
