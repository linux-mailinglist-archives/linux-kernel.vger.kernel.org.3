Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433E955CBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbiF0PeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiF0Pdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:33:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AF01A39B;
        Mon, 27 Jun 2022 08:33:52 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A9F666015C9;
        Mon, 27 Jun 2022 16:33:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656344030;
        bh=WzLxqB/YMSV3d8PSEanjQ/qOkirN2jSeH7M6yPLb6bY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Kiw/fpDfzNHiUkjVs5KgG9+JKq/bEnX5sBvOJou4gARcDdyWQEWnOpE6wjVVzoT5R
         PKlViGOxmcFVp2K64r3AqSr7C+D+lYPib6ILwuYE6mGtJ3BE610P8ggr9TkqmQ3YQl
         GpXr8Jmr7yGCS34fBur97iMYWJdnQvN1XtskYxPPG/2zzOS/kbY7MEISCTzeTZE75p
         cuvLUFQx5TxlsLizuLMqGDxch++RQLBcNTy9dyi3pL4LPcsoVlfpxuQ1R20KwmyQIE
         nzmoBkV4nw/n65h/2D2lEH4/jkfOi/iI3dDispFKhCHkEN6UawbQqGRHuhEabZpRBm
         yTTGP/y8FRr/g==
Message-ID: <43f393d2dcdd0bfac66bfc420e9261d31b3ceedc.camel@collabora.com>
Subject: Re: [PATCH 1/4] media: mediatek: vcodec: dec: Fix 4K frame size
 enumeration
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Date:   Mon, 27 Jun 2022 11:33:39 -0400
In-Reply-To: <20220627112402.2332046-2-wenst@chromium.org>
References: <20220627112402.2332046-1-wenst@chromium.org>
         <20220627112402.2332046-2-wenst@chromium.org>
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

Le lundi 27 juin 2022 =C3=A0 19:23 +0800, Chen-Yu Tsai a =C3=A9crit=C2=A0:
> This partially reverts commit b018be06f3c7 ("media: mediatek: vcodec:
> Read max resolution from dec_capability"). In this commit, the maximum
> resolution ended up being a function of both the firmware capability and
> the current set format.
>=20
> However, frame size enumeration for output (coded) formats should not
> depend on the format set, but should return supported resolutions for
> the format requested by userspace.
>=20
> Fix this so that the driver returns the supported resolutions correctly,
> even if the instance only has default settings, or if the output format
> is currently set to VP8F, which does not support 4K.
>=20
> Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution from d=
ec_capability")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c    | 2 --
>  .../platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c    | 7 +++++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> index 5d6fdf18c3a6..fcb4b8131c49 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> @@ -595,8 +595,6 @@ static int vidioc_enum_framesizes(struct file *file, =
void *priv,
>  		fsize->type =3D V4L2_FRMSIZE_TYPE_STEPWISE;
>  		fsize->stepwise =3D dec_pdata->vdec_framesizes[i].stepwise;
> =20
> -		fsize->stepwise.max_width =3D ctx->max_width;
> -		fsize->stepwise.max_height =3D ctx->max_height;
>  		mtk_v4l2_debug(1, "%x, %d %d %d %d %d %d",
>  				ctx->dev->dec_capability,
>  				fsize->stepwise.min_width,
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_statel=
ess.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> index 16d55785d84b..9a4d3e3658aa 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
> @@ -360,6 +360,13 @@ static void mtk_vcodec_add_formats(unsigned int four=
cc,
> =20
>  		mtk_vdec_framesizes[count_framesizes].fourcc =3D fourcc;
>  		mtk_vdec_framesizes[count_framesizes].stepwise =3D stepwise_fhd;

While at it, can you constify stepwise_fhd, it is scary to think that someo=
ne
could modify it and cause big headache.

> +		if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED) &&
> +		    fourcc !=3D V4L2_PIX_FMT_VP8_FRAME) {
> +			mtk_vdec_framesizes[count_framesizes].stepwise.max_width =3D
> +				VCODEC_DEC_4K_CODED_WIDTH;
> +			mtk_vdec_framesizes[count_framesizes].stepwise.max_height =3D
> +				VCODEC_DEC_4K_CODED_HEIGHT;
> +		}
>  		num_framesizes++;
>  		break;
>  	case V4L2_PIX_FMT_MM21:

