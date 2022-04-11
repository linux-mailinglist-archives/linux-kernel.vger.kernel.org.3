Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5054FB5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbiDKIPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343602AbiDKIPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:15:04 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331BB3DDFD;
        Mon, 11 Apr 2022 01:12:50 -0700 (PDT)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5D23259D;
        Mon, 11 Apr 2022 10:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649664769;
        bh=0VhYaczbLXbhIz/P8q9GI8+HUZ1jnwY0l6SoEA5+fx8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tEKsOgPuTtmlrYFqi6at19GitGX5vo6zzXltTVLePPnQPwwf3y38Clha5q9xKinkA
         fRSeY77S2/y2NFDd+KjVYdGowgebEeXF+jeYBWH/dJHZ0TTrDZ35M4qXIPheVDrrg7
         YAu6Pm44dbYrZpF7h30ZKa1mD4Bnv3R44YS/TEYc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220411080120.26008-3-Ping-lei.Lin@mediatek.com>
References: <20220411080120.26008-1-Ping-lei.Lin@mediatek.com> <20220411080120.26008-3-Ping-lei.Lin@mediatek.com>
Subject: Re: [PATCH v2 2/2] media: v4l: Add H265 pixel format
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@arndb.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ming Qian <ming.qian@nxp.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, ping-lei.lin@mediatek.com,
        lecopzer.chen@mediatek.com, max.yan@mediatek.com,
        sherlock.chang@mediatek.com, tm.wu@mediatek.com,
        James_Lin <Ping-lei.Lin@mediatek.com>
To:     James_Lin <Ping-lei.Lin@mediatek.com>, linux-kernel@vger.kernel.org
Date:   Mon, 11 Apr 2022 09:12:46 +0100
Message-ID: <164966476674.22830.512211103923160119@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James_Lin (2022-04-11 09:01:20)
> Add H265 pixel format.
> So driver can recognize external camera devices=20
> whom use h265 to describe High Efficiency Video Coding method.
>=20
> Signed-off-by: James_Lin <Ping-lei.Lin@mediatek.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-compressed.rst      | 10 ++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                   |  1 +
>  include/uapi/linux/videodev2.h                         |  1 +
>  3 files changed, 12 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> index 967fc803ef94..75292aafe2eb 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> @@ -36,6 +36,16 @@ Compressed Formats
>        - MPEG multiplexed stream. The actual format is determined by
>         extended control ``V4L2_CID_MPEG_STREAM_TYPE``, see
>         :ref:`mpeg-control-id`.
> +    * .. _V4L2-PIX-FMT-H265:
> +
> +      - ``V4L2_PIX_FMT_H265``
> +      - 'H265'
> +      - H.265 Access Unit.
> +       The decoder expects one Access Unit per buffer.
> +       The encoder generates one Access Unit per buffer.
> +       If :ref:`VIDIOC_ENUM_FMT` reports ``V4L2_FMT_FLAG_CONTINUOUS_BYTE=
STREAM``
> +       then the decoder has no requirements since it can parse all the
> +       information from the raw bytestream.
>      * .. _V4L2-PIX-FMT-H264:
> =20
>        - ``V4L2_PIX_FMT_H264``
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 96e307fe3aab..aeaeb29307a4 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1402,6 +1402,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>                 case V4L2_PIX_FMT_JPEG:         descr =3D "JFIF JPEG"; br=
eak;
>                 case V4L2_PIX_FMT_DV:           descr =3D "1394"; break;
>                 case V4L2_PIX_FMT_MPEG:         descr =3D "MPEG-1/2/4"; b=
reak;
> +               case V4L2_PIX_FMT_H265:         descr =3D "H.265"; break;

I'd probably expect H265 to be sorted after H264 ? But I'm not sure this
list is sorted otherwise.

>                 case V4L2_PIX_FMT_H264:         descr =3D "H.264"; break;
>                 case V4L2_PIX_FMT_H264_NO_SC:   descr =3D "H.264 (No Star=
t Codes)"; break;
>                 case V4L2_PIX_FMT_H264_MVC:     descr =3D "H.264 MVC"; br=
eak;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 3768a0a80830..636e4236bfb8 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -691,6 +691,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_JPEG     v4l2_fourcc('J', 'P', 'E', 'G') /* JFIF JP=
EG     */
>  #define V4L2_PIX_FMT_DV       v4l2_fourcc('d', 'v', 's', 'd') /* 1394   =
       */
>  #define V4L2_PIX_FMT_MPEG     v4l2_fourcc('M', 'P', 'E', 'G') /* MPEG-1/=
2/4 Multiplexed */
> +#define V4L2_PIX_FMT_H265     v4l2_fourcc('H', '2', '6', '5') /* H265 wi=
th start codes */

Likewise.


>  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 wi=
th start codes */
>  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 =
without start codes */
>  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MV=
C */
> --=20
> 2.18.0
>
