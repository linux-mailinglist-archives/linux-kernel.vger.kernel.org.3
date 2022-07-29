Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1B25855CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbiG2Tzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiG2Tzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:55:44 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F3E81480
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:55:43 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x11so4070208qts.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=lI7ivcAwRUifQnRI706c0+q8Lpzh40+rYKLKoU1I3oA=;
        b=qy/Ws0vsozgufqZWtXL2So+xVlSE6SGi5kFtkvmzaaaUA6pw/RkbUFS5Zigm83YVGi
         ox6/EDOITHju9acHoHBNF5GJjMNZwIn+seu1/hmrT05Pwdezn1CcbCcttGXXRZ5n7jRs
         zqZO9U6cPEN9Nf6021Lm1e9bcHKf97lWQ/HA0m/4cMBtZBkQGm60W6O8vimRYEms6Zer
         AwnEEzoFgGR0abgEviTkD5HQfZ4vL77+qiUvQ8w6MnCjm+/nDEyzebrASriyyrI4wNXz
         MXjfKq764z3kntKCkl8ctPRfMDtPkLY+7tuK5yF1ILgZEkPjAU8ihT2B6H/A939UMjTj
         T5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=lI7ivcAwRUifQnRI706c0+q8Lpzh40+rYKLKoU1I3oA=;
        b=lMgH4UDZ7+69RZqZILtF5zXkQRZF5gVys+VerjQQPygPRRAHCAAZ6n1GYGdi5xiCGq
         FoDWXFTQOve9EX/HbJCwGKeg5W+fECMpMQxtAmV0i0dIxFzqGZSOPtji+FtN2THiL/Ck
         Gk/ambfNlSBhXWvcF7NGdIok6zaeYYKyCBND08uq/vxiTFjHPWbowSj51K0RfR6SubtS
         eGe5OUsBNQ3TZSUtrN8UTmsDezhaJLF2KwlYeVJXZiLGrdS9UiHyCOmt9Q68CYaEWOiw
         n7H0lMhaCPWe0Sqdw0kxpXvJsBfj6pjA+LZqEdwyjvn3rANh2IhngoWzRTPkhfGTnZUe
         0YmQ==
X-Gm-Message-State: AJIora/xA69UhqMrKGXSUBxknUKL1MHd4p1AqvvMRYFVOkkSo1za15Fx
        3MfA9Xu/NLLPfFcc1ywtJTtYZg==
X-Google-Smtp-Source: AGRyM1sihhA5ZddLZrESE9GSeP9Ji0UMQqbh8Np5eaWnEHtLDvdLpVQGIvqn5AwYAh7DONLDcge0mA==
X-Received: by 2002:a05:622a:3cb:b0:31f:36f5:f6c8 with SMTP id k11-20020a05622a03cb00b0031f36f5f6c8mr4833145qtx.428.1659124542531;
        Fri, 29 Jul 2022 12:55:42 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id t7-20020a375f07000000b006af50b6f10csm3037958qkb.61.2022.07.29.12.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:55:42 -0700 (PDT)
Message-ID: <0bc68659aa225a0623751b82e9a8636d701cece9.camel@ndufresne.ca>
Subject: Re: [PATCH 1/4] media: add nv12_8l128 and nv12_10be_8l128 video
 format.
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 29 Jul 2022 15:55:40 -0400
In-Reply-To: <687fb73b648b897426899c6a313f35a5e2451d69.1659082839.git.ming.qian@nxp.com>
References: <cover.1659082839.git.ming.qian@nxp.com>
         <687fb73b648b897426899c6a313f35a5e2451d69.1659082839.git.ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 29 juillet 2022 =C3=A0 16:38 +0800, Ming Qian a =C3=A9crit=C2=
=A0:
> add contiguous nv12 tiled format nv12_8l128 and nv12_10be_8l128
>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

cheer,
Nicolas

> ---
>  .../userspace-api/media/v4l/pixfmt-yuv-planar.rst         | 8 ++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                      | 2 ++
>  include/uapi/linux/videodev2.h                            | 2 ++
>  3 files changed, 12 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 10b1feeb0b57..f1d5bb7b806d 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -273,7 +273,9 @@ of the luma plane.
>  .. _V4L2-PIX-FMT-NV12-16L16:
>  .. _V4L2-PIX-FMT-NV12-32L32:
>  .. _V4L2-PIX-FMT-NV12M-8L128:
> +.. _V4L2-PIX-FMT-NV12-8L128:
>  .. _V4L2-PIX-FMT-NV12M-10BE-8L128:
> +.. _V4L2-PIX-FMT-NV12-10BE-8L128:
>  .. _V4L2-PIX-FMT-MM21:
> =20
>  Tiled NV12
> @@ -319,6 +321,9 @@ pixels in 2D 8x128 tiles, and stores tiles linearly i=
n memory.
>  The image height must be aligned to a multiple of 128.
>  The layouts of the luma and chroma planes are identical.
> =20
> +``V4L2_PIX_FMT_NV12_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_8L128`` b=
ut stores
> +two planes in one memory.
> +
>  ``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` b=
ut stores
>  10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
>  the data is arranged in big endian order.
> @@ -334,6 +339,9 @@ byte 2: Y1(bits 3-0) Y2(bits 9-6)
>  byte 3: Y2(bits 5-0) Y3(bits 9-8)
>  byte 4: Y3(bits 7-0)
> =20
> +``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10BE=
_8L128`` but stores
> +two planes in one memory.
> +
>  ``V4L2_PIX_FMT_MM21`` store luma pixel in 16x32 tiles, and chroma pixels
>  in 16x16 tiles. The line stride must be aligned to a multiple of 16 and =
the
>  image height must be aligned to a multiple of 32. The number of luma and=
 chroma
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index c314025d977e..d973bd2ff750 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1444,7 +1444,9 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  	case V4L2_META_FMT_VIVID:       descr =3D "Vivid Metadata"; break;
>  	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr =3D "Rockchip ISP1 3A Paramete=
rs"; break;
>  	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr =3D "Rockchip ISP1 3A Statist=
ics"; break;
> +	case V4L2_PIX_FMT_NV12_8L128:	descr =3D "NV12 (8x128 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12M_8L128:	descr =3D "NV12M (8x128 Linear)"; break;
> +	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr =3D "10-bit NV12 (8x128 Linear=
, BE)"; break;
>  	case V4L2_PIX_FMT_NV12M_10BE_8L128:	descr =3D "10-bit NV12M (8x128 Line=
ar, BE)"; break;
> =20
>  	default:
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index cd66e01ed3c3..64f16490dd2b 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -655,6 +655,8 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12  Y=
/CbCr 4:2:0 16x16 tiles */
>  #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S', 'T', '1', '2') /* 12  Y=
/CbCr 4:2:0 32x32 tiles */
>  #define V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y/C=
bCr 4:2:0 10-bit 4x4 macroblocks */
> +#define V4L2_PIX_FMT_NV12_8L128       v4l2_fourcc('A', 'T', '1', '2') /*=
 Y/CbCr 4:2:0 8x128 tiles */
> +#define V4L2_PIX_FMT_NV12_10BE_8L128  v4l2_fourcc_be('A', 'X', '1', '2')=
 /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
> =20
>  /* Tiled YUV formats, non contiguous planes */
>  #define V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/Cb=
Cr 4:2:0 64x32 tiles */

