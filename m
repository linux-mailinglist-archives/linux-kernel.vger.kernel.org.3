Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A024A57587D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbiGOAFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241063AbiGOAFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:05:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E8735B6;
        Thu, 14 Jul 2022 17:05:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A2DB69DA;
        Fri, 15 Jul 2022 02:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1657843510;
        bh=eUrWlueduRgSkr9QAPg6mJaG55bmEBeshRDPqeUsPhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+ys3+MLbVdT5iTS6NTWCpHz2R2ecFFLvH78hMoP1bCBqV2mo10mZexYRSrVHjbYU
         GWBBMHR6M0jGcPcPiCqI/Nzq2TqdHia5FWD5f6IlWXqxDTqAmebfa/q0yV+gzc68RV
         BI5KJTGx+8rBVCIso+Dsuboay3jPlBa6SC4PgyVw=
Date:   Fri, 15 Jul 2022 03:04:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, jernej.skrabec@gmail.com,
        knaerzche@gmail.com, kernel@collabora.com,
        bob.beckett@collabora.com, ezequiel@vanguardiasur.com.ar,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, Jonas Karlman <jonas@kwiboo.se>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 1/6] media: v4l2: Add NV15 pixel format
Message-ID: <YtCvF+kAfeiTduW+@pendragon.ideasonboard.com>
References: <20220713162449.133738-1-sebastian.fricke@collabora.com>
 <20220713162449.133738-2-sebastian.fricke@collabora.com>
 <Ys8OzDzXmmCHI9qb@pendragon.ideasonboard.com>
 <acded11db2957b4e9d4f8df44f82dc1babe7aae0.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acded11db2957b4e9d4f8df44f82dc1babe7aae0.camel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:02:38AM -0400, Nicolas Dufresne wrote:
> Le mercredi 13 juillet 2022 à 21:28 +0300, Laurent Pinchart a écrit :
> > Hi Sebastian and Jonas,
> > 
> > Thank you for the patch.
> > 
> > On Wed, Jul 13, 2022 at 06:24:46PM +0200, Sebastian Fricke wrote:
> > > From: Jonas Karlman <jonas@kwiboo.se>
> > > 
> > > Add the NV15 pixel format used by the Rockchip Video Decoder for 10-bit
> > > buffers.
> > > 
> > > NV15 is a packed 10-bit 4:2:0 Y/CbCr format similar to P010 and P210 but
> > > has no padding between components. Instead, luminance and chrominance
> > > samples are grouped into 4s so that each group is packed into an integer
> > > number of bytes:
> > > 
> > > YYYY = UVUV = 4 * 10 bits = 40 bits = 5 bytes
> > > 
> > > The '15' suffix refers to the optimum effective bits per pixel which is
> > > achieved when the total number of luminance samples is a multiple of 8
> > > for NV15.
> > > 
> > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > > ---
> > >  .../media/v4l/pixfmt-yuv-planar.rst           | 53 +++++++++++++++++++
> > >  drivers/media/v4l2-core/v4l2-common.c         |  2 +
> > >  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
> > >  include/uapi/linux/videodev2.h                |  1 +
> > >  4 files changed, 57 insertions(+)
> > > 
> > > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > > index a900ff66911a..42ab3fe4667f 100644
> > > --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > > +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > > @@ -79,6 +79,13 @@ All components are stored with the same number of bits per component.
> > >        - Cr, Cb
> > >        - Yes
> > >        - Linear
> > > +    * - V4L2_PIX_FMT_NV15
> > > +      - 'NV15'
> > > +      - 15
> > > +      - 4:2:0
> > > +      - Cb, Cr
> > > +      - Yes
> > > +      - Linear
> > >      * - V4L2_PIX_FMT_NV12M
> > >        - 'NM12'
> > >        - 8
> > > @@ -176,6 +183,7 @@ horizontally.
> > >  
> > >  .. _V4L2-PIX-FMT-NV12:
> > >  .. _V4L2-PIX-FMT-NV21:
> > > +.. _V4L2-PIX-FMT-NV15:
> > >  .. _V4L2-PIX-FMT-NV12M:
> > >  .. _V4L2-PIX-FMT-NV21M:
> > >  .. _V4L2-PIX-FMT-P010:
> > > @@ -570,6 +578,51 @@ Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian ord
> > >        - Cb\ :sub:`11`
> > >        - Cr\ :sub:`11`
> > >  
> > > +.. _V4L2_PIX_FMT_NV15:
> > > +
> > > +NV15
> > > +----
> > > +
> > > +Like P010 but a packed 10-bit 4:2:0 semi-planar Y/CbCr format without padding between components.
> > 
> > "packed 10-bit semi-planar" sounds confusing, as "packed YUV" usually
> > refers to YUYV-style formats, but I'm not sure how to express that
> > better.
> 
> Perhaps:
> 
> "Similar to P010 (10-bit 4:":0 semi-planer Y/CbCr), though unlike P010, the
> there is not padding between components."
> 
> > > +Instead, luminance and chrominance samples are grouped into 4s so that each group is packed into an integer
> > > +number of bytes:
> > 
> > Could you please wrap the description at 80 columns ?
> > 
> > > +YYYY = UVUV = 4 * 10 bits = 40 bits = 5 bytes
> > > +
> > > +.. flat-table:: Sample 4x4 NV15 Image
> > > +    :header-rows:  0
> > > +    :stub-columns: 0
> > > +
> > > +    * - start + 0:
> > > +      - Y'\ :sub:`00`
> > > +      - Y'\ :sub:`01`
> > > +      - Y'\ :sub:`02`
> > > +      - Y'\ :sub:`03`
> > > +    * - start + 8:
> > > +      - Y'\ :sub:`10`
> > > +      - Y'\ :sub:`11`
> > > +      - Y'\ :sub:`12`
> > > +      - Y'\ :sub:`13`
> > > +    * - start + 16:
> > > +      - Y'\ :sub:`20`
> > > +      - Y'\ :sub:`21`
> > > +      - Y'\ :sub:`22`
> > > +      - Y'\ :sub:`23`
> > > +    * - start + 24:
> > > +      - Y'\ :sub:`30`
> > > +      - Y'\ :sub:`31`
> > > +      - Y'\ :sub:`32`
> > > +      - Y'\ :sub:`33`
> > > +    * - start + 32:
> > > +      - Cb\ :sub:`00`
> > > +      - Cr\ :sub:`00`
> > > +      - Cb\ :sub:`01`
> > > +      - Cr\ :sub:`01`
> > > +    * - start + 40:
> > > +      - Cb\ :sub:`10`
> > > +      - Cr\ :sub:`10`
> > > +      - Cb\ :sub:`11`
> > > +      - Cr\ :sub:`11`
> > 
> > This doesn't look right. You need to describe the data at the bit level,
> > so show how the 10-bit samples are packed into bytes.
> 
> A word of NV15 is 40 bits, so 1 word of NV12 is 5 bytes, 4 pixels. I believe
> there is no choice here but to describe 4 pixels for Y plane, and 4 pixels for
> CbCr plane. This might be a bit big though.

I agree, it may not be the prettiest, but I'd rather have a larger table
than a format that is understood differently by different drivers. Been
there, done that, not again :-)

> > > +
> > >  .. raw:: latex
> > >  
> > >      \endgroup
> > > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> > > index 1e38ad8906a2..23a0cb02ea3a 100644
> > > --- a/drivers/media/v4l2-core/v4l2-common.c
> > > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > > @@ -262,6 +262,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
> > >  		/* YUV planar formats */
> > >  		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
> > >  		{ .format = V4L2_PIX_FMT_NV21,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
> > > +		{ .format = V4L2_PIX_FMT_NV15,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 5, 0, 0 }, .hdiv = 2, .vdiv = 2,
> > > +		  .block_w = { 4, 2, 0, 0 }, .block_h = { 1, 1, 0, 0 } },
> > >  		{ .format = V4L2_PIX_FMT_NV16,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
> > >  		{ .format = V4L2_PIX_FMT_NV61,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
> > >  		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > index e2526701294e..9e5510cb255e 100644
> > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > @@ -1302,6 +1302,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> > >  	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
> > >  	case V4L2_PIX_FMT_NV12:		descr = "Y/CbCr 4:2:0"; break;
> > >  	case V4L2_PIX_FMT_NV21:		descr = "Y/CrCb 4:2:0"; break;
> > > +	case V4L2_PIX_FMT_NV15:		descr = "10-bit Y/CbCr 4:2:0 (Packed)"; break;
> > >  	case V4L2_PIX_FMT_NV16:		descr = "Y/CbCr 4:2:2"; break;
> > >  	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
> > >  	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
> > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > > index 5a73b92ffe4d..47ff34d6b79f 100644
> > > --- a/include/uapi/linux/videodev2.h
> > > +++ b/include/uapi/linux/videodev2.h
> > > @@ -598,6 +598,7 @@ struct v4l2_pix_format {
> > >  /* two planes -- one Y, one Cr + Cb interleaved  */
> > >  #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
> > >  #define V4L2_PIX_FMT_NV21    v4l2_fourcc('N', 'V', '2', '1') /* 12  Y/CrCb 4:2:0  */
> > > +#define V4L2_PIX_FMT_NV15    v4l2_fourcc('N', 'V', '1', '5') /* 15  Y/CbCr 4:2:0 10-bit packed */
> > >  #define V4L2_PIX_FMT_NV16    v4l2_fourcc('N', 'V', '1', '6') /* 16  Y/CbCr 4:2:2  */
> > >  #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 4:2:2  */
> > >  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */

-- 
Regards,

Laurent Pinchart
