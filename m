Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320094F9D53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiDHSzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiDHSzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:55:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A343B9396;
        Fri,  8 Apr 2022 11:53:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 4BC421F473B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649444012;
        bh=r1uTA7u5ZuBHwJEYWmnZvWNMO0Xo6FFVj0EubH+YtL8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EJS6kkAybGAyLEkOzvKZh2fHTuNEdkEE+Ex+3qrvSsAZhQ97MVT27SOT+RkuBLMUX
         znygWl9zx1gXJbSdl5xK/rU+TJ/xbcP+hAg7lq2v6UucrPUJfYVUJ0R5llQcz93WC8
         T3zPcxkuvtXod9cWJ6SmV4a7DGlg3mywiIxuAaJ5YwlUUVxYvbmm0NDtPg2FEeKAdt
         Mie+pssSYeft3zi7Bb26OBcaX0BNxV1U13dyROoqPeiEwLXnpuW4abIxkatu/T4/L7
         285bmIhO01AeomMxQFI3bG9F4cjVY29kBwdwmJsiWgHa8DRh7DXlcmgfVcm0+Y5kmF
         LLchSBfC5EMSg==
Message-ID: <3179e400d52704d11dd150bf4270dab4c1064cad.camel@collabora.com>
Subject: Re: [PATCH v5 09/17] media: uapi: HEVC: Define
 V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a dynamic array
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        sebastian.fricke@collabora.com
Date:   Fri, 08 Apr 2022 14:53:20 -0400
In-Reply-To: <20220407152940.738159-10-benjamin.gaignard@collabora.com>
References: <20220407152940.738159-1-benjamin.gaignard@collabora.com>
         <20220407152940.738159-10-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 07 avril 2022 =C3=A0 17:29 +0200, Benjamin Gaignard a =C3=A9crit=
=C2=A0:
> Make explicit that V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control is
> a dynamic array control type.
> Some drivers may be able to receive multiple slices in one control
> to improve decoding performance.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
>  include/media/hevc-ctrls.h                                | 3 +++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/=
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 7fcc6c2bac4c..1aaf3b84b584 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2964,6 +2964,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      These bitstream parameters are defined according to :ref:`hevc`.
>      They are described in section 7.4.7 "General slice segment header
>      semantics" of the specification.
> +    This control is a dynamically sized 1-dimensional array,
> +    V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
> =20
>  .. c:type:: v4l2_ctrl_hevc_slice_params
> =20
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index 96a9b71d1def..28049e1a8a07 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -314,6 +314,9 @@ struct v4l2_hevc_pred_weight_table {
>  /**
>   * v4l2_ctrl_hevc_slice_params - HEVC slice parameters
>   *
> + * This control is a dynamically sized 1-dimensional array,
> + * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
> + *

I'm not sure about this comment, but I'm sure you forgot:


--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1505,6 +1505,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum
v4l2_ctrl_type *type,
                break;
        case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:
                *type =3D V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS;
+               *flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
                break;
        case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:
                *type =3D V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX;

Also, in AV1 we have V4L2_AV1_MAX_TILE_COUNT, which can be used in cfg.dims=
,
something the driver will actually set. We could have

#define V4L2_HEVC_MAX_TILE_COUNT 600

And drives can set:

   .dims =3D { V4L2_HEVC_MAX_TILE_COUNT },

In the control config.

>   * @bit_size: size (in bits) of the current slice data
>   * @data_bit_offset: offset (in bits) to the video data in the current s=
lice data
>   * @nal_unit_type: specifies the coding type of the slice (B, P or I)

