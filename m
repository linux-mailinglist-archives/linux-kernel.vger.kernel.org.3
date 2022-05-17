Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3877552A981
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351566AbiEQRmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351561AbiEQRm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:42:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581D41262B;
        Tue, 17 May 2022 10:42:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 438721F449B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652809343;
        bh=2gNja2jzXINTHL1DpfULvc1b1SM/D/Au4dGjglcuCgI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=b4Z5DzT+sf3HQ6039HxlUUoC+65ISIxA11E5wbSvgBkdUEGSSKNJ7K81Le/5JC9Pq
         xA1F6Gyv1+3/SWUYoHU/9xE4a3ScTonl45OU1MENWs0YNOaBxPhdBaCVsqKmQAanMh
         05Xwm9WRCu1feB2FllaNwAQOCJF5d2rgG1cqjDUV8Bv3/SygCBYX08O7y+Kgq3Kxik
         MPqu1XP2MlodjgGiyCa+fNfdWpBq/t7Lxqz6et2/OoTcWJlc9yk5hiFHs8JeDT3PcS
         VDIOmZfUZNPgZEtOGWM3QxT2jn0JnHrioAfAIY3jNwzRVY/QneD7lVGcQGcOLjk6P+
         2DY4PdrWv61DA==
Message-ID: <db9149100bbed9efecc54d9a39dc57862d49cd23.camel@collabora.com>
Subject: Re: [PATCH v2] media: hantro: Be more accurate on pixel formats
 step_width constraints
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, heiko@sntech.de, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     kernel@pengutronix.de, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, kernel@collabora.com
Date:   Tue, 17 May 2022 13:42:11 -0400
In-Reply-To: <20220517122629.522211-1-benjamin.gaignard@collabora.com>
References: <20220517122629.522211-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
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

Le mardi 17 mai 2022 =C3=A0 14:26 +0200, Benjamin Gaignard a =C3=A9crit=C2=
=A0:
> On Hantro G2 decoder on IMX8MQ strides requirements aren't the same
> for NV12_4L4 and NV12 pixel formats. The first one use a 4 bytes padding
> while the last one needs 8 bytes.
> To be sure to provide the correct stride in all cases we need:
> - to relax the constraints on codec formats so set step_width to 4
> - use capture queue format and not the output queue format when applying
>   the pixel format constraints.
> - put the correct step_width constraints on each pixel format.
>=20
> Move HEVC SPS validation in hantro_hevc.c to be able to perform it
> when setting sps control and when starting to decode the bitstream.
> Add a new test in HEVC SPS validation function to check if resolution
> is still matching the hardware constraints.
>=20
> With this SAODBLK_A_MainConcept_4 and SAODBLK_B_MainConcept_4 conformance
> tests files are correctly decoded with both NV12 and NV12_4L4 pixel forma=
ts.
> These two files have a resolution of 1016x760.
> If step_width =3D 16 for the both pixel formats the selected capture

Did you mean is instead of =3D ? Are you missing "and" somewhere in this se=
ntence
?

> resolution is 1024x768 which is wrong for NV12_4L4 (which expect 1016x760=
)
> on Hantro G2 on IMX8MQ (but correct for NV12).
>=20
> For other variants than Hantro G2 on IMX8M keep the same step_width to av=
oid
> regressions.
>=20
> Fluster HEVC test score is now 128/147 vs 126/147 with the both pixel
> formats as decoder output.
> Fluster VP9 test score stay at 147/303.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 2:
> - Add a HEVC SPS validation function to be used when
>   setting the control and start decoding.
>   I hope that is what Nicolas expects in his remark on v1.
>=20
>  drivers/staging/media/hantro/hantro_drv.c     | 12 +++---
>  drivers/staging/media/hantro/hantro_hevc.c    | 28 +++++++++++++
>  drivers/staging/media/hantro/hantro_hw.h      |  2 +
>  drivers/staging/media/hantro/hantro_v4l2.c    |  2 +-
>  drivers/staging/media/hantro/imx8m_vpu_hw.c   | 40 +++++++++++++++++--
>  .../staging/media/hantro/rockchip_vpu_hw.c    | 32 +++++++++++++++
>  .../staging/media/hantro/sama5d4_vdec_hw.c    | 16 ++++++++
>  drivers/staging/media/hantro/sunxi_vpu_hw.c   | 16 ++++++++
>  8 files changed, 137 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/=
media/hantro/hantro_drv.c
> index 377dcc1d19de..5aac3a090480 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -253,6 +253,11 @@ queue_init(void *priv, struct vb2_queue *src_vq, str=
uct vb2_queue *dst_vq)
> =20
>  static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
> +	struct hantro_ctx *ctx;
> +
> +	ctx =3D container_of(ctrl->handler,
> +			   struct hantro_ctx, ctrl_handler);
> +
>  	if (ctrl->id =3D=3D V4L2_CID_STATELESS_H264_SPS) {
>  		const struct v4l2_ctrl_h264_sps *sps =3D ctrl->p_new.p_h264_sps;
> =20
> @@ -268,12 +273,7 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  	} else if (ctrl->id =3D=3D V4L2_CID_STATELESS_HEVC_SPS) {
>  		const struct v4l2_ctrl_hevc_sps *sps =3D ctrl->p_new.p_hevc_sps;
> =20
> -		if (sps->bit_depth_luma_minus8 !=3D sps->bit_depth_chroma_minus8)
> -			/* Luma and chroma bit depth mismatch */
> -			return -EINVAL;
> -		if (sps->bit_depth_luma_minus8 !=3D 0)
> -			/* Only 8-bit is supported */
> -			return -EINVAL;
> +		return hantro_hevc_validate_sps(ctx, sps);
>  	} else if (ctrl->id =3D=3D V4L2_CID_STATELESS_VP9_FRAME) {
>  		const struct v4l2_ctrl_vp9_frame *dec_params =3D ctrl->p_new.p_vp9_fra=
me;
> =20
> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging=
/media/hantro/hantro_hevc.c
> index 7fdec50dc853..6abef810b285 100644
> --- a/drivers/staging/media/hantro/hantro_hevc.c
> +++ b/drivers/staging/media/hantro/hantro_hevc.c
> @@ -154,6 +154,30 @@ static int tile_buffer_reallocate(struct hantro_ctx =
*ctx)
>  	return -ENOMEM;
>  }
> =20
> +int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_c=
trl_hevc_sps *sps)
> +{
> +	if (sps->bit_depth_luma_minus8 !=3D sps->bit_depth_chroma_minus8)
> +		/* Luma and chroma bit depth mismatch */
> +		return -EINVAL;
> +	if (sps->bit_depth_luma_minus8 !=3D 0)
> +		/* Only 8-bit is supported */
> +		return -EINVAL;
> +
> +	/* for tile pixel format check if the width and height match
> +	 * hardware constraints */
> +	if (ctx->vpu_dst_fmt->fourcc =3D=3D V4L2_PIX_FMT_NV12_4L4) {
> +		if (ctx->dst_fmt.width !=3D
> +		    ALIGN(sps->pic_width_in_luma_samples, ctx->vpu_dst_fmt->frmsize.st=
ep_width))
> +			return -EINVAL;
> +
> +		if (ctx->dst_fmt.height !=3D
> +		    ALIGN(sps->pic_height_in_luma_samples, ctx->vpu_dst_fmt->frmsize.s=
tep_height))
> +			return -EINVAL;

No action needed, just a question. Can we output tiled out of the PP ? If s=
o,
perhaps we could handle the alignment difference by enabling the PP even if
tiled. That would greatly help to handle compatibility between decoders and
encoders in the future.

> +	}
> +
> +	return 0;
> +}
> +
>  int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx)
>  {
>  	struct hantro_hevc_dec_hw_ctx *hevc_ctx =3D &ctx->hevc_dec;
> @@ -177,6 +201,10 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *c=
tx)
>  	if (WARN_ON(!ctrls->sps))
>  		return -EINVAL;
> =20
> +	ret =3D hantro_hevc_validate_sps(ctx, ctrls->sps);
> +	if (ret)
> +		return ret;
> +
>  	ctrls->pps =3D
>  		hantro_get_ctrl(ctx, V4L2_CID_STATELESS_HEVC_PPS);
>  	if (WARN_ON(!ctrls->pps))
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/m=
edia/hantro/hantro_hw.h
> index 994547fe41b9..0bba6378212d 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -341,6 +341,8 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *ct=
x);
>  void hantro_hevc_ref_init(struct hantro_ctx *ctx);
>  dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
>  int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t =
addr);
> +int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_c=
trl_hevc_sps *sps);
> +
> =20
>  static inline unsigned short hantro_vp9_num_sbs(unsigned short dimension=
)
>  {
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging=
/media/hantro/hantro_v4l2.c
> index 71a6279750bf..93d0dcf69f4a 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> @@ -260,7 +260,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ct=
x,
>  	} else if (ctx->is_encoder) {
>  		vpu_fmt =3D ctx->vpu_dst_fmt;
>  	} else {
> -		vpu_fmt =3D ctx->vpu_src_fmt;
> +		vpu_fmt =3D fmt;
>  		/*
>  		 * Width/height on the CAPTURE end of a decoder are ignored and
>  		 * replaced by the OUTPUT ones.
> diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/stagin=
g/media/hantro/imx8m_vpu_hw.c
> index 9802508bade2..b6b2bf65e56d 100644
> --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> @@ -83,6 +83,14 @@ static const struct hantro_fmt imx8m_vpu_postproc_fmts=
[] =3D {
>  		.fourcc =3D V4L2_PIX_FMT_YUYV,
>  		.codec_mode =3D HANTRO_MODE_NONE,
>  		.postprocessed =3D true,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 3840,

I remember seeing limits to 4096 instead in VSI documentation (UWHD). Just =
like
many hardcoded limits in this driver, perhaps the limits was copied from th=
e=20
white paper performance example. It would be weird that we can decode portr=
ait
UHD/FHD.

I think for this patch, what I'd like to see is the UDH and FHD limits to b=
e set
as a define. Since if we got them wrong, fixing them later after this patch
becomes a lot more work, as its copied over and over.

Everything else looks good to me know, thanks for the update.

> +			.step_width =3D MB_DIM,
> +			.min_height =3D 48,
> +			.max_height =3D 2160,
> +			.step_height =3D MB_DIM,
> +		},
>  	},
>  };
> =20
> @@ -90,6 +98,14 @@ static const struct hantro_fmt imx8m_vpu_dec_fmts[] =
=3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 3840,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D 48,
> +			.max_height =3D 2160,
> +			.step_height =3D MB_DIM,
> +		},
>  	},
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_MPEG2_SLICE,
> @@ -137,6 +153,14 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc=
_fmts[] =3D {
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.codec_mode =3D HANTRO_MODE_NONE,
>  		.postprocessed =3D true,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 3840,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D 48,
> +			.max_height =3D 2160,
> +			.step_height =3D MB_DIM,
> +		},
>  	},
>  };
> =20
> @@ -144,6 +168,14 @@ static const struct hantro_fmt imx8m_vpu_g2_dec_fmts=
[] =3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12_4L4,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 3840,
> +			.step_width =3D 4,
> +			.min_height =3D 48,
> +			.max_height =3D 2160,
> +			.step_height =3D 4,
> +		},
>  	},
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_HEVC_SLICE,
> @@ -152,10 +184,10 @@ static const struct hantro_fmt imx8m_vpu_g2_dec_fmt=
s[] =3D {
>  		.frmsize =3D {
>  			.min_width =3D 48,
>  			.max_width =3D 3840,
> -			.step_width =3D MB_DIM,
> +			.step_width =3D 4,
>  			.min_height =3D 48,
>  			.max_height =3D 2160,
> -			.step_height =3D MB_DIM,
> +			.step_height =3D 4,
>  		},
>  	},
>  	{
> @@ -165,10 +197,10 @@ static const struct hantro_fmt imx8m_vpu_g2_dec_fmt=
s[] =3D {
>  		.frmsize =3D {
>  			.min_width =3D 48,
>  			.max_width =3D 3840,
> -			.step_width =3D MB_DIM,
> +			.step_width =3D 4,
>  			.min_height =3D 48,
>  			.max_height =3D 2160,
> -			.step_height =3D MB_DIM,
> +			.step_height =3D 4,
>  		},
>  	},
>  };
> diff --git a/drivers/staging/media/hantro/rockchip_vpu_hw.c b/drivers/sta=
ging/media/hantro/rockchip_vpu_hw.c
> index fc96501f3bc8..efba7fcdf207 100644
> --- a/drivers/staging/media/hantro/rockchip_vpu_hw.c
> +++ b/drivers/staging/media/hantro/rockchip_vpu_hw.c
> @@ -63,6 +63,14 @@ static const struct hantro_fmt rockchip_vpu1_postproc_=
fmts[] =3D {
>  		.fourcc =3D V4L2_PIX_FMT_YUYV,
>  		.codec_mode =3D HANTRO_MODE_NONE,
>  		.postprocessed =3D true,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 1920,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D 48,
> +			.max_height =3D 1088,
> +			.step_height =3D MB_DIM,
> +		},
>  	},
>  };
> =20
> @@ -70,6 +78,14 @@ static const struct hantro_fmt rk3066_vpu_dec_fmts[] =
=3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 1920,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D 48,
> +			.max_height =3D 1088,
> +			.step_height =3D MB_DIM,
> +		},
>  	},
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_H264_SLICE,
> @@ -116,6 +132,14 @@ static const struct hantro_fmt rk3288_vpu_dec_fmts[]=
 =3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 4096,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D 48,
> +			.max_height =3D 2304,
> +			.step_height =3D MB_DIM,
> +		},
>  	},
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_H264_SLICE,
> @@ -162,6 +186,14 @@ static const struct hantro_fmt rk3399_vpu_dec_fmts[]=
 =3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 1920,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D 48,
> +			.max_height =3D 1088,
> +			.step_height =3D MB_DIM,
> +		},
>  	},
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_H264_SLICE,
> diff --git a/drivers/staging/media/hantro/sama5d4_vdec_hw.c b/drivers/sta=
ging/media/hantro/sama5d4_vdec_hw.c
> index b2fc1c5613e1..07ee804e706b 100644
> --- a/drivers/staging/media/hantro/sama5d4_vdec_hw.c
> +++ b/drivers/staging/media/hantro/sama5d4_vdec_hw.c
> @@ -16,6 +16,14 @@ static const struct hantro_fmt sama5d4_vdec_postproc_f=
mts[] =3D {
>  		.fourcc =3D V4L2_PIX_FMT_YUYV,
>  		.codec_mode =3D HANTRO_MODE_NONE,
>  		.postprocessed =3D true,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 1280,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D 48,
> +			.max_height =3D 720,
> +			.step_height =3D MB_DIM,
> +		},
>  	},
>  };
> =20
> @@ -23,6 +31,14 @@ static const struct hantro_fmt sama5d4_vdec_fmts[] =3D=
 {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 1280,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D 48,
> +			.max_height =3D 720,
> +			.step_height =3D MB_DIM,
> +		},
>  	},
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_MPEG2_SLICE,
> diff --git a/drivers/staging/media/hantro/sunxi_vpu_hw.c b/drivers/stagin=
g/media/hantro/sunxi_vpu_hw.c
> index c0edd5856a0c..c2392c08febb 100644
> --- a/drivers/staging/media/hantro/sunxi_vpu_hw.c
> +++ b/drivers/staging/media/hantro/sunxi_vpu_hw.c
> @@ -14,6 +14,14 @@ static const struct hantro_fmt sunxi_vpu_postproc_fmts=
[] =3D {
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.codec_mode =3D HANTRO_MODE_NONE,
>  		.postprocessed =3D true,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 3840,
> +			.step_width =3D 32,
> +			.min_height =3D 48,
> +			.max_height =3D 2160,
> +			.step_height =3D 32,
> +		},
>  	},
>  };
> =20
> @@ -21,6 +29,14 @@ static const struct hantro_fmt sunxi_vpu_dec_fmts[] =
=3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12_4L4,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> +		.frmsize =3D {
> +			.min_width =3D 48,
> +			.max_width =3D 3840,
> +			.step_width =3D 32,
> +			.min_height =3D 48,
> +			.max_height =3D 2160,
> +			.step_height =3D 32,
> +		},
>  	},
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_VP9_FRAME,
> --=20
> 2.32.0
>=20
>=20

