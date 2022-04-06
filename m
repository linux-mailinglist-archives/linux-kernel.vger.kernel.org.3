Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED9A4F63E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiDFPo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbiDFPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:43:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3162D4E5B2F;
        Wed,  6 Apr 2022 06:11:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id BEA0F1F448EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649250670;
        bh=HVSLEwbeNCSnRDzdZpPEXUqj6thaF6OV8UOGSpYxWow=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bnzTxJwSJGH38S+tVlH2/LWfpFQRa8MkqadrdJk7uV06gDjC0GlSM2NVRglux42NV
         tuxRCa1kNAg0oi4QNgrmt3IYCh2/qOF8EvGVHgUz9KJ7OZQrxhz8tLIcBqpOHtPdK7
         AThjvWR2o13f7jSoM64oPaZ/wtOQ0w9E0EEo9eabO3rE1lqwdYwviswIeWHTmaM3hz
         0ILNcmyL3s1xG7U3BmjSefSwqfXyWkABUnvCvW7orNHgW2b70zHrMJOKvjaePD2BUZ
         q2ZPIOwElLBrjIdQCeb8q2t/YQZH1+ph7zP7t1dl6UKY7jpvx4BqDFaOhKdsw8Gr/4
         cUsebuoZ/K9pw==
Message-ID: <d8a737d52aa93f559123ab795ba67c668c81163e.camel@collabora.com>
Subject: Re: [PATCH v3 16/24] media: rkvdec: h264: Validate and use pic
 width and height in mbs
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev
Date:   Wed, 06 Apr 2022 09:10:59 -0400
In-Reply-To: <20220405204426.259074-17-nicolas.dufresne@collabora.com>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
         <20220405204426.259074-17-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 05 avril 2022 =C3=A0 16:44 -0400, Nicolas Dufresne a =C3=A9crit=C2=
=A0:
> From: Jonas Karlman <jonas@kwiboo.se>
>=20
> The width and height in macroblocks is currently configured based on OUTP=
UT
> buffer resolution, this works for frame pictures but can cause issues for
> field pictures.
>=20
> When frame_mbs_only_flag is 0 the height in mbs should be height of
> the field instead of height of frame.
>=20
> Validate pic_width_in_mbs_minus1 and pic_height_in_map_units_minus1
> against OUTPUT buffer resolution and use these values to configure HW.
> The validation is happening in both try_ctrt() and start() since it is
> otherwise possible to trick the driver during initialization by changing
> the OUTPUT format after having set a valid control.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 78 ++++++++++++++++------
>  1 file changed, 59 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging=
/media/rkvdec/rkvdec-h264.c
> index 0dcbcb1bac80..f081b476340f 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -672,8 +672,16 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
>  		  LOG2_MAX_PIC_ORDER_CNT_LSB_MINUS4);
>  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZER=
O),
>  		  DELTA_PIC_ORDER_ALWAYS_ZERO_FLAG);
> -	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.width, 16), PIC_WIDTH_=
IN_MBS);
> -	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.height, 16), PIC_HEIGH=
T_IN_MBS);
> +
> +	/* Use the SPS values since they are already in macroblocks
> +	 * dimensions, height can be field height (halved) if
> +	 * V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY is not set and also it allows
> +	 * decoding smaller images into larger allocation which can be used
> +	 * to implementing SVC spatial layer support.
> +	 */
> +	WRITE_PPS(sps->pic_width_in_mbs_minus1 + 1, PIC_WIDTH_IN_MBS);
> +	WRITE_PPS(sps->pic_height_in_map_units_minus1 + 1, PIC_HEIGHT_IN_MBS);
> +
>  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY),
>  		  FRAME_MBS_ONLY_FLAG);
>  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD),
> @@ -1035,13 +1043,59 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec_c=
tx *ctx,
>  	return 0;
>  }
> =20
> +static int rkvdec_h264_validate_sps(struct rkvdec_ctx *ctx,
> +				    const struct v4l2_ctrl_h264_sps *sps)
> +{
> +	unsigned int width, height;
> +	/*
> +	 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
> +	 * but it's currently broken in the driver.
> +	 * Reject them for now, until it's fixed.
> +	 */
> +	if (sps->chroma_format_idc > 1)
> +		/* Only 4:0:0 and 4:2:0 are supported */
> +		return -EINVAL;
> +	if (sps->bit_depth_luma_minus8 !=3D sps->bit_depth_chroma_minus8)
> +		/* Luma and chroma bit depth mismatch */
> +		return -EINVAL;
> +	if (sps->bit_depth_luma_minus8 !=3D 0)
> +		/* Only 8-bit is supported */
> +		return -EINVAL;
> +
> +	width =3D (sps->pic_width_in_mbs_minus1 + 1) * 16;
> +	height =3D (sps->pic_height_in_map_units_minus1 + 1) * 16;
> +
> +	/* when frame_mbs_only_flag is not set, this is field height,
> +	 * which is half the final height (see (7-18) in the
> +	 * specification)
> +	 */
> +	if (!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY))
> +		height *=3D 2;
> +
> +	if (width > ctx->coded_fmt.fmt.pix_mp.width ||
> +	    height > ctx->coded_fmt.fmt.pix_mp.height)
> +		return -EINVAL;

I forgot to add traces for these as suggestion by Ezequiel in my review. I =
think
the patch is still acceptable as-is, I can later make a patchset on that
specific subject. I'll would add trace for validation taking place in the
generic control code, making this all much more consistent (and a smoother
experience for developers).

> +
> +	return 0;
> +}
> +
>  static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
>  {
>  	struct rkvdec_dev *rkvdec =3D ctx->dev;
>  	struct rkvdec_h264_priv_tbl *priv_tbl;
>  	struct rkvdec_h264_ctx *h264_ctx;
> +	struct v4l2_ctrl *ctrl;
>  	int ret;
> =20
> +	ctrl =3D v4l2_ctrl_find(&ctx->ctrl_hdl,
> +			      V4L2_CID_STATELESS_H264_SPS);
> +	if (!ctrl)
> +		return -EINVAL;
> +
> +	ret =3D rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
> +	if (ret)
> +		return ret;
> +
>  	h264_ctx =3D kzalloc(sizeof(*h264_ctx), GFP_KERNEL);
>  	if (!h264_ctx)
>  		return -ENOMEM;
> @@ -1139,23 +1193,9 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
> =20
>  static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl=
 *ctrl)
>  {
> -	if (ctrl->id =3D=3D V4L2_CID_STATELESS_H264_SPS) {
> -		const struct v4l2_ctrl_h264_sps *sps =3D ctrl->p_new.p_h264_sps;
> -		/*
> -		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
> -		 * but it's currently broken in the driver.
> -		 * Reject them for now, until it's fixed.
> -		 */
> -		if (sps->chroma_format_idc > 1)
> -			/* Only 4:0:0 and 4:2:0 are supported */
> -			return -EINVAL;
> -		if (sps->bit_depth_luma_minus8 !=3D sps->bit_depth_chroma_minus8)
> -			/* Luma and chroma bit depth mismatch */
> -			return -EINVAL;
> -		if (sps->bit_depth_luma_minus8 !=3D 0)
> -			/* Only 8-bit is supported */
> -			return -EINVAL;
> -	}
> +	if (ctrl->id =3D=3D V4L2_CID_STATELESS_H264_SPS)
> +		return rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
> +
>  	return 0;
>  }
> =20
> --=20
> 2.34.1
>=20
>=20

