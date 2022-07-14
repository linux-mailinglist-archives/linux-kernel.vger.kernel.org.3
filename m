Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0A2574E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiGNNC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiGNNCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:02:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D742E5B06F;
        Thu, 14 Jul 2022 06:02:51 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A7F2B6601A18;
        Thu, 14 Jul 2022 14:02:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657803770;
        bh=Q9m4rZgHtaJu/hM5+jUFITzSjwt+QT6jxgLSuBjVwbw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M2Bdub/AA4vXJA2+m4dEeVYDUdO7bmtDyl4iTUXR1W/ep0qEWutaIsI02DHKjRuOI
         6BUvCMUAb3PAZgf8eC6h/d3Y+S16mbpkG274Ete5N2iBiEAlKtXmmv/dFwb8h2K122
         GYaR2Kf1JPYgBsohIETiiCwkem/lr1oOY/YJRR0d4IaBm0uj9YKQ0P5c33hCWT/J1Y
         FedLu2TriGuNFb+aH8L4HerdEk+x0g+q5yfkkbY0i1oppTpr+o3X9kn1C0U+uk00z1
         mnRA3MiqPQzSmH1m+vcZrbrTdrN77YSaw8xc42V7396Lk2Z9dWdxLAR1jcHQXtRlGl
         wX83mdRoUOEVA==
Message-ID: <acded11db2957b4e9d4f8df44f82dc1babe7aae0.camel@collabora.com>
Subject: Re: [PATCH 1/6] media: v4l2: Add NV15 pixel format
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     linux-media@vger.kernel.org, jernej.skrabec@gmail.com,
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
Date:   Thu, 14 Jul 2022 09:02:38 -0400
In-Reply-To: <Ys8OzDzXmmCHI9qb@pendragon.ideasonboard.com>
References: <20220713162449.133738-1-sebastian.fricke@collabora.com>
         <20220713162449.133738-2-sebastian.fricke@collabora.com>
         <Ys8OzDzXmmCHI9qb@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 13 juillet 2022 =C3=A0 21:28 +0300, Laurent Pinchart a =C3=A9cr=
it=C2=A0:
> Hi Sebastian and Jonas,
>=20
> Thank you for the patch.
>=20
> On Wed, Jul 13, 2022 at 06:24:46PM +0200, Sebastian Fricke wrote:
> > From: Jonas Karlman <jonas@kwiboo.se>
> >=20
> > Add the NV15 pixel format used by the Rockchip Video Decoder for 10-bit
> > buffers.
> >=20
> > NV15 is a packed 10-bit 4:2:0 Y/CbCr format similar to P010 and P210 bu=
t
> > has no padding between components. Instead, luminance and chrominance
> > samples are grouped into 4s so that each group is packed into an intege=
r
> > number of bytes:
> >=20
> > YYYY =3D UVUV =3D 4 * 10 bits =3D 40 bits =3D 5 bytes
> >=20
> > The '15' suffix refers to the optimum effective bits per pixel which is
> > achieved when the total number of luminance samples is a multiple of 8
> > for NV15.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > ---
> >  .../media/v4l/pixfmt-yuv-planar.rst           | 53 +++++++++++++++++++
> >  drivers/media/v4l2-core/v4l2-common.c         |  2 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
> >  include/uapi/linux/videodev2.h                |  1 +
> >  4 files changed, 57 insertions(+)
> >=20
> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rs=
t b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > index a900ff66911a..42ab3fe4667f 100644
> > --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > @@ -79,6 +79,13 @@ All components are stored with the same number of bi=
ts per component.
> >        - Cr, Cb
> >        - Yes
> >        - Linear
> > +    * - V4L2_PIX_FMT_NV15
> > +      - 'NV15'
> > +      - 15
> > +      - 4:2:0
> > +      - Cb, Cr
> > +      - Yes
> > +      - Linear
> >      * - V4L2_PIX_FMT_NV12M
> >        - 'NM12'
> >        - 8
> > @@ -176,6 +183,7 @@ horizontally.
> > =20
> >  .. _V4L2-PIX-FMT-NV12:
> >  .. _V4L2-PIX-FMT-NV21:
> > +.. _V4L2-PIX-FMT-NV15:
> >  .. _V4L2-PIX-FMT-NV12M:
> >  .. _V4L2-PIX-FMT-NV21M:
> >  .. _V4L2-PIX-FMT-P010:
> > @@ -570,6 +578,51 @@ Data in the 10 high bits, zeros in the 6 low bits,=
 arranged in little endian ord
> >        - Cb\ :sub:`11`
> >        - Cr\ :sub:`11`
> > =20
> > +.. _V4L2_PIX_FMT_NV15:
> > +
> > +NV15
> > +----
> > +
> > +Like P010 but a packed 10-bit 4:2:0 semi-planar Y/CbCr format without =
padding between components.
>=20
> "packed 10-bit semi-planar" sounds confusing, as "packed YUV" usually
> refers to YUYV-style formats, but I'm not sure how to express that
> better.

Perhaps:

"Similar to P010 (10-bit 4:":0 semi-planer Y/CbCr), though unlike P010, the
there is not padding between components."

>=20
> > +Instead, luminance and chrominance samples are grouped into 4s so that=
 each group is packed into an integer
> > +number of bytes:
>=20
> Could you please wrap the description at 80 columns ?
>=20
> > +YYYY =3D UVUV =3D 4 * 10 bits =3D 40 bits =3D 5 bytes
> > +
> > +.. flat-table:: Sample 4x4 NV15 Image
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +
> > +    * - start + 0:
> > +      - Y'\ :sub:`00`
> > +      - Y'\ :sub:`01`
> > +      - Y'\ :sub:`02`
> > +      - Y'\ :sub:`03`
> > +    * - start + 8:
> > +      - Y'\ :sub:`10`
> > +      - Y'\ :sub:`11`
> > +      - Y'\ :sub:`12`
> > +      - Y'\ :sub:`13`
> > +    * - start + 16:
> > +      - Y'\ :sub:`20`
> > +      - Y'\ :sub:`21`
> > +      - Y'\ :sub:`22`
> > +      - Y'\ :sub:`23`
> > +    * - start + 24:
> > +      - Y'\ :sub:`30`
> > +      - Y'\ :sub:`31`
> > +      - Y'\ :sub:`32`
> > +      - Y'\ :sub:`33`
> > +    * - start + 32:
> > +      - Cb\ :sub:`00`
> > +      - Cr\ :sub:`00`
> > +      - Cb\ :sub:`01`
> > +      - Cr\ :sub:`01`
> > +    * - start + 40:
> > +      - Cb\ :sub:`10`
> > +      - Cr\ :sub:`10`
> > +      - Cb\ :sub:`11`
> > +      - Cr\ :sub:`11`
>=20
> This doesn't look right. You need to describe the data at the bit level,
> so show how the 10-bit samples are packed into bytes.

A word of NV15 is 40 bits, so 1 word of NV12 is 5 bytes, 4 pixels. I believ=
e
there is no choice here but to describe 4 pixels for Y plane, and 4 pixels =
for
CbCr plane. This might be a bit big though.

>=20
> > +
> >  .. raw:: latex
> > =20
> >      \endgroup
> > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2=
-core/v4l2-common.c
> > index 1e38ad8906a2..23a0cb02ea3a 100644
> > --- a/drivers/media/v4l2-core/v4l2-common.c
> > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > @@ -262,6 +262,8 @@ const struct v4l2_format_info *v4l2_format_info(u32=
 format)
> >  		/* YUV planar formats */
> >  		{ .format =3D V4L2_PIX_FMT_NV12,    .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .hdiv =
=3D 2, .vdiv =3D 2 },
> >  		{ .format =3D V4L2_PIX_FMT_NV21,    .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .hdiv =
=3D 2, .vdiv =3D 2 },
> > +		{ .format =3D V4L2_PIX_FMT_NV15,    .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 5, 5, 0, 0 }, .hdiv =
=3D 2, .vdiv =3D 2,
> > +		  .block_w =3D { 4, 2, 0, 0 }, .block_h =3D { 1, 1, 0, 0 } },
> >  		{ .format =3D V4L2_PIX_FMT_NV16,    .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .hdiv =
=3D 2, .vdiv =3D 1 },
> >  		{ .format =3D V4L2_PIX_FMT_NV61,    .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .hdiv =
=3D 2, .vdiv =3D 1 },
> >  		{ .format =3D V4L2_PIX_FMT_NV24,    .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .hdiv =
=3D 1, .vdiv =3D 1 },
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-=
core/v4l2-ioctl.c
> > index e2526701294e..9e5510cb255e 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1302,6 +1302,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc =
*fmt)
> >  	case V4L2_PIX_FMT_M420:		descr =3D "YUV 4:2:0 (M420)"; break;
> >  	case V4L2_PIX_FMT_NV12:		descr =3D "Y/CbCr 4:2:0"; break;
> >  	case V4L2_PIX_FMT_NV21:		descr =3D "Y/CrCb 4:2:0"; break;
> > +	case V4L2_PIX_FMT_NV15:		descr =3D "10-bit Y/CbCr 4:2:0 (Packed)"; br=
eak;
> >  	case V4L2_PIX_FMT_NV16:		descr =3D "Y/CbCr 4:2:2"; break;
> >  	case V4L2_PIX_FMT_NV61:		descr =3D "Y/CrCb 4:2:2"; break;
> >  	case V4L2_PIX_FMT_NV24:		descr =3D "Y/CbCr 4:4:4"; break;
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index 5a73b92ffe4d..47ff34d6b79f 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -598,6 +598,7 @@ struct v4l2_pix_format {
> >  /* two planes -- one Y, one Cr + Cb interleaved  */
> >  #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/=
CbCr 4:2:0  */
> >  #define V4L2_PIX_FMT_NV21    v4l2_fourcc('N', 'V', '2', '1') /* 12  Y/=
CrCb 4:2:0  */
> > +#define V4L2_PIX_FMT_NV15    v4l2_fourcc('N', 'V', '1', '5') /* 15  Y/=
CbCr 4:2:0 10-bit packed */
> >  #define V4L2_PIX_FMT_NV16    v4l2_fourcc('N', 'V', '1', '6') /* 16  Y/=
CbCr 4:2:2  */
> >  #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/=
CrCb 4:2:2  */
> >  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/=
CbCr 4:4:4  */
>=20

