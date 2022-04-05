Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED60F4F4923
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391007AbiDEWEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457699AbiDEQgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:36:17 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCB868FA4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:34:18 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c4so12017966qtx.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=I/7fitWwUYRa/nqxsZSRCzVOnNeUu3PD11UtZsLnRJ8=;
        b=eXZM6SKAlG+lAu6DXMz0sNq8+3x6aYl++T7wY9L9wjz1bsH5phqCK2DQ4KhyhsdbTR
         xoOG6pNZxAAjGVj2wo6ipFZB0UDbtux/XY5aS40SzMsbtNyGKFy4Wf+RnWANBa45OBkj
         M411he/1j6Q99+Zg8Bo6kKTVHrGLysaisisuWhVLff4EtpzxPjSj7C1hSP9lQylHyXyT
         DtSrwhn4uFKCOjB76Lf3K40r+zykMnDW4OhUp/f5f6Y30y5uGnr8W3JNmYCapfttjzWV
         msg7Df5Apq1xQ74Ut0MACShwSxzHqO1Eh3v6bmvNLtpzE8NCIXdnR7tpwrHCX5rCtoY0
         4guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=I/7fitWwUYRa/nqxsZSRCzVOnNeUu3PD11UtZsLnRJ8=;
        b=eI8g8AVKpubwrciJLuuMi8hlb6YnxtHWNZqfDun95cvneCbEpPxv1A76fB1bwZrmbe
         O9MmCK70/jerR34JVDlhvEHE9C60GuPLIrIYVIlWpeTkEmsYUWBqiAbrDbb3kiApWTzU
         DexCYQ4IJuhBpJ6kK2PJk9Gk/AKlvav1RPsW5ViML0uOV0fKaQKwqN4y3MX4MiH8l5PA
         yKvOHkBzoG1MCX5qvrbNdUG7RGhscVSIyyvVELGtCdCfib2JsEeWifjrKXaXYQ1QiCnl
         MkDGk3k2EaW8V0avi3KyALBN+X7cctXqKCiYQP4WOmJ/McM0x+LWrqCbkBpWD0Oau2A8
         1h/g==
X-Gm-Message-State: AOAM532+R1Q1+KE/Bct5hnBQsprILpCU7UtGwld1bjs3+wuyl8MEy5HB
        QuWE5iQtnpNIFp4RWLfXUpU7WA==
X-Google-Smtp-Source: ABdhPJxAZNT5a4c4cN4qPiLdupD1Ba4oT6l2c+SQFCUCdQYqO3W6EIwMWe+bc2JiS3wplzw5gW1qhw==
X-Received: by 2002:a05:620a:4256:b0:67e:87a1:ffdd with SMTP id w22-20020a05620a425600b0067e87a1ffddmr2715567qko.647.1649176457567;
        Tue, 05 Apr 2022 09:34:17 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id w1-20020ac857c1000000b002e1e899badesm10552149qta.72.2022.04.05.09.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 09:34:17 -0700 (PDT)
Message-ID: <9c2279c2be98162ef5e986546ef3f680570a2cfe.camel@ndufresne.ca>
Subject: Re: [PATCH] media: Add P010 video format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, p.zabel@pengutronix.de,
        kernel@collabora.com
Date:   Tue, 05 Apr 2022 12:34:16 -0400
In-Reply-To: <YktNur601fjyCt9i@eze-laptop>
References: <20220404090116.353034-1-benjamin.gaignard@collabora.com>
         <YktNur601fjyCt9i@eze-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 04 avril 2022 =C3=A0 16:57 -0300, Ezequiel Garcia a =C3=A9crit=C2=
=A0:
> On Mon, Apr 04, 2022 at 11:01:16AM +0200, Benjamin Gaignard wrote:
> > P010 is a YUV format with 10-bits per pixel with interleaved UV.
> >=20
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>=20
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>=20
> > ---
> > Note that P010 is already known in GStreamer, only the mapping with
> > v4l2 pixel format is missing.
> >=20
> > This patch has been acked in this series but never merged:
> > https://patchwork.kernel.org/project/linux-rockchip/patch/2021061813152=
6.566762-5-benjamin.gaignard@collabora.com/
> > After rebased it on v5.18-rc1, resend in standalone mode.
> >=20
> >  .../media/v4l/pixfmt-yuv-planar.rst           | 76 +++++++++++++++++++
> >  drivers/media/v4l2-core/v4l2-common.c         |  1 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
> >  include/uapi/linux/videodev2.h                |  1 +
> >  4 files changed, 79 insertions(+)
> >=20
> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rs=
t b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > index 8dff5906639b..6d65c8ac44f0 100644
> > --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > @@ -102,6 +102,13 @@ All components are stored with the same number of =
bits per component.
> >        - 64x32 tiles
> > =20
> >          Horizontal Z order
> > +    * - V4L2_PIX_FMT_P010
> > +      - 'P010'
> > +      - 16
> > +      - 4:2:0
> > +      - Cb, Cr
> > +      - No
> > +      - Linear
> >      * - V4L2_PIX_FMT_NV12MT_16X16
> >        - 'VM12'
> >        - 8
> > @@ -171,6 +178,7 @@ horizontally.
> >  .. _V4L2-PIX-FMT-NV21:
> >  .. _V4L2-PIX-FMT-NV12M:
> >  .. _V4L2-PIX-FMT-NV21M:
> > +.. _V4L2-PIX-FMT-P010:
> > =20
> >  NV12, NV21, NV12M and NV21M
> >  ---------------------------
> > @@ -519,6 +527,74 @@ number of lines as the luma plane.
> >        - Cb\ :sub:`33`
> >        - Cr\ :sub:`33`
> > =20
> > +.. _V4L2_PIX_FMT_P010:
> > +
> > +P010
> > +----
> > +
> > +The number of bytes in one luminance row must be divisible by 16,
> > +which means there will be padded 0 in the right edge when necessary.

So far in GStreamer we have met two form of P010. One has the short stored =
in
little endian, and the other in big endian. Its probably visible in the tab=
le
here (sorry can't read tables from text), but it could be nice to put that =
in
words if not part of the format name.


Microfost seems to only define "little endian" variation.

https://docs.microsoft.com/en-us/windows/win32/medfound/10-bit-and-16-bit-y=
uv-video-formats

> > +
> > +.. raw:: latex
> > +
> > +    \begingroup
> > +    \small
> > +    \setlength{\tabcolsep}{2pt}
> > +
> > +.. tabularcolumns:: |p{2.6cm}|p{0.70cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|=
p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.2=
2cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|p{0.22cm}|
> > +
> > +.. flat-table:: P010 16 Bits per component
> > +    :header-rows:  2
> > +    :stub-columns: 0
> > +
> > +    * - Identifier
> > +      - Code
> > +      - :cspan:`7` Byte 0 in memory
> > +
> > +      - :cspan:`7` Byte 1
> > +    * -
> > +      -
> > +      - 7
> > +      - 6
> > +      - 5
> > +      - 4
> > +      - 3
> > +      - 2
> > +      - 1
> > +      - 0
> > +
> > +      - 7
> > +      - 6
> > +      - 5
> > +      - 4
> > +      - 3
> > +      - 2
> > +      - 1
> > +      - 0
> > +    * - ``V4L2_PIX_FMT_P010``
> > +      - 'P010'
> > +
> > +      - Y\ :sub:`9`
> > +      - Y\ :sub:`8`
> > +      - Y\ :sub:`7`
> > +      - Y\ :sub:`6`
> > +      - Y\ :sub:`5`
> > +      - Y\ :sub:`4`
> > +      - Y\ :sub:`3`
> > +      - Y\ :sub:`2`
> > +
> > +      - Y\ :sub:`1`
> > +      - Y\ :sub:`0`
> > +      - 0
> > +      - 0
> > +      - 0
> > +      - 0
> > +      - 0
> > +      - 0
> > +
> > +.. raw:: latex
> > +
> > +    \endgroup
> > =20
> >  Fully Planar YUV Formats
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2=
-core/v4l2-common.c
> > index df34b2a283bc..1e38ad8906a2 100644
> > --- a/drivers/media/v4l2-core/v4l2-common.c
> > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > @@ -266,6 +266,7 @@ const struct v4l2_format_info *v4l2_format_info(u32=
 format)
> >  		{ .format =3D V4L2_PIX_FMT_NV61,    .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .hdiv =
=3D 2, .vdiv =3D 1 },
> >  		{ .format =3D V4L2_PIX_FMT_NV24,    .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .hdiv =
=3D 1, .vdiv =3D 1 },
> >  		{ .format =3D V4L2_PIX_FMT_NV42,    .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .hdiv =
=3D 1, .vdiv =3D 1 },
> > +		{ .format =3D V4L2_PIX_FMT_P010,    .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 2, 2, 0, 0 }, .hdiv =
=3D 2, .vdiv =3D 1 },
> > =20
> >  		{ .format =3D V4L2_PIX_FMT_YUV410,  .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 3, .bpp =3D { 1, 1, 1, 0 }, .hdiv =
=3D 4, .vdiv =3D 4 },
> >  		{ .format =3D V4L2_PIX_FMT_YVU410,  .pixel_enc =3D V4L2_PIXEL_ENC_YU=
V, .mem_planes =3D 1, .comp_planes =3D 3, .bpp =3D { 1, 1, 1, 0 }, .hdiv =
=3D 4, .vdiv =3D 4 },
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-=
core/v4l2-ioctl.c
> > index 96e307fe3aab..e14d7e1a038e 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1301,6 +1301,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc =
*fmt)
> >  	case V4L2_PIX_FMT_NV61:		descr =3D "Y/CrCb 4:2:2"; break;
> >  	case V4L2_PIX_FMT_NV24:		descr =3D "Y/CbCr 4:4:4"; break;
> >  	case V4L2_PIX_FMT_NV42:		descr =3D "Y/CrCb 4:4:4"; break;
> > +	case V4L2_PIX_FMT_P010:		descr =3D "10-bit Y/CrCb 4:2:0"; break;
> >  	case V4L2_PIX_FMT_NV12_4L4:	descr =3D "Y/CbCr 4:2:0 (4x4 Linear)"; br=
eak;
> >  	case V4L2_PIX_FMT_NV12_16L16:	descr =3D "Y/CbCr 4:2:0 (16x16 Linear)"=
; break;
> >  	case V4L2_PIX_FMT_NV12_32L32:   descr =3D "Y/CbCr 4:2:0 (32x32 Linear=
)"; break;
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index 4c09969e7112..2e451c454db3 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -601,6 +601,7 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/=
CrCb 4:2:2  */
> >  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/=
CbCr 4:4:4  */
> >  #define V4L2_PIX_FMT_NV42    v4l2_fourcc('N', 'V', '4', '2') /* 24  Y/=
CrCb 4:4:4  */
> > +#define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 15  Y/=
CbCr 4:2:0 10-bit per pixel*/
> > =20
> >  /* two non contiguous planes - one Y, one Cr + Cb interleaved  */
> >  #define V4L2_PIX_FMT_NV12M   v4l2_fourcc('N', 'M', '1', '2') /* 12  Y/=
CbCr 4:2:0  */
> > --=20
> > 2.32.0
> >=20

