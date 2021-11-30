Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3987C462A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhK3Chl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbhK3Chj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:37:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A17AC06174A;
        Mon, 29 Nov 2021 18:34:20 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D71C68F0;
        Tue, 30 Nov 2021 03:34:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638239658;
        bh=mGg6TZcY1dGuMzIJjUbiQmB/IPFXRomlqxwTRoSfIzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CiTfbzGGYOm1HMCuhbjq3mckZwClXoIj0gDZQSvRYE2sWdCM3yL4KI5Ytot5/fSuL
         Cr137XfofVpzKmh6qaHnJDW12SfGvLK+JvOJ+QHxZtChG9KbmN2o4Hs8iBkL+UKIo+
         EDI1SN4Tknx9MxKSDYkXhVIoehQdbU+03XxdV7ig=
Date:   Tue, 30 Nov 2021 04:33:53 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: Add 16-bit Bayer formats
Message-ID: <YaWNkcljqIR6BSdZ@pendragon.ideasonboard.com>
References: <20211019114718.827400-1-dorota.czaplejewicz@puri.sm>
 <163820077159.3059017.10242072140890692995@Monstersaurus>
 <20211129170356.7258d6db.dorota.czaplejewicz@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211129170356.7258d6db.dorota.czaplejewicz@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dorota,

On Mon, Nov 29, 2021 at 05:05:23PM +0100, Dorota Czaplejewicz wrote:
> On Mon, 29 Nov 2021 15:46:11 +0000 Kieran Bingham wrote:
> > Quoting Dorota Czaplejewicz (2021-10-19 12:59:29)
> > > 16-bit bayer formats are used by the i.MX driver.  
> > 
> > Can we expand upon this at all?
> > 
> > The Subject says "Add 16-bit Bayer formats" but this isn't adding the
> > format, it's purely extending the v4l2_format_info table with the
> > information for that format which is otherwise missing.
>
> What do you suggest for a better commit message? My reasoning was that
> I'm adding entries to a table.

The format is defined by V4L2 but isn't present in that table. I'd state
the this patch is fixing an oversight, and reference the commit that
forgot to add these formats in a Fixes: tag. While at it, I'd also add
at least the 14bpp Bayer formats, and possibly the packed formats too.

> > I wonder what other formats are missing from that table too?
> > 
> > > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > > ---
> > > Hello,
> > > 
> > > While working on the i.MX8 video driver, I discovered that
> > > `v4l2_fill_pixfmt` will fail when using 10-bit sensor formats.
> > > (For background, see the conversation at
> > > https://lkml.org/lkml/2021/10/17/93 .)
> > > 
> > > It appears that the video hardware will fill a 16-bit-per-pixel
> > > buffer when fed 10-bit-per-pixel Bayer data, making
> > > `v4l2_fill_pixfmt` effectively broken for this case.  
> > 
> > This statement is confusing to me. Are you saying you're programming the
> > hardware with 10 bit, and it's using 16 bits per pixel to store that
> > data? (Which is simply 'unpacked' I think ?)
>
> I know the sensor I'm dealing with sends 10-bit data. I'm observing
> that the data arriving at this stage of the pipeline is encoded with
> 16 bits per pixel. As far as I understand, that's what i.MX8 does at
> some stage of the MIPI/CSI2 pipeline by design, but I can't elaborate
> at the moment, and I don't think it affects the validity of the
> addition.

Is the 10 bit data stored in the MSB or LSB of the 2 bytes ?

> > > This change adds the relevant entries to the format info structure.
> > > 
> > > Difference in behaviour observed using the i846 driver on the Librem 5.
> > > 
> > > Regards,
> > > Dorota Czaplejewicz
> > > 
> > >  drivers/media/v4l2-core/v4l2-common.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> > > index 04af03285a20..d2e61538e979 100644
> > > --- a/drivers/media/v4l2-core/v4l2-common.c
> > > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > > @@ -309,6 +309,10 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
> > >                 { .format = V4L2_PIX_FMT_SGBRG12,       .pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> > >                 { .format = V4L2_PIX_FMT_SGRBG12,       .pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> > >                 { .format = V4L2_PIX_FMT_SRGGB12,       .pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> > > +               { .format = V4L2_PIX_FMT_SBGGR16,       .pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> > > +               { .format = V4L2_PIX_FMT_SGBRG16,       .pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> > > +               { .format = V4L2_PIX_FMT_SGRBG16,       .pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> > > +               { .format = V4L2_PIX_FMT_SRGGB16,       .pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },  
> > 
> > This looks right as far as I can see though, so for the change, and
> > ideally with the commit message improved to be clearer about the
> > content and reasoning for the change:
> > 
> > Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Thanks!
> 
> > >         };
> > >         unsigned int i;
> > >  

-- 
Regards,

Laurent Pinchart
