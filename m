Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE52D528DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbiEPTJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiEPTJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:09:03 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE3393D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:09:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id m1so12984830qkn.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=MBgGsqXRsf0ss9YPrcM3j4TAcafmynw6Sjbjw2Xm7MU=;
        b=eNm4jTu8IBICugoj/+C4OWwwRGbJps37e1bc0wdQgflhYUzhfabjBW0bOf24GAS/Uh
         rrErujKmAkqu27iyqPB03kmClSrniTBk1A+fIBvqXfnnY5WavmI1lN1A3Jd3RE19wkIO
         jA/12chDl3M5zNYLi0+GxnYNdAHn1rsNYzZt5VhtsliEOXDLozaNlYCfUTtG8Dc8UQpU
         CEiJhoM6515tknJp5V6UXSE0UsrccrCzb46sphHInvQ4ePBYv0MHaG3cNDRU7F6/uax4
         VBtEf9EyNN7Yw5UNM9vB6qMD/LSAKfXMSrUYdto1ncJlEv78g+OEmxyAEXuiS13Ot+//
         viSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=MBgGsqXRsf0ss9YPrcM3j4TAcafmynw6Sjbjw2Xm7MU=;
        b=1/3QE2PgS1XBdE3m98r322KcaWyhS21Be1VMYx0mkRsJ+2mfqFIedGB/toYXxJDbTa
         zBGWkxaPUl1GTPVNKIxle4uzhojMQLugHkYgTQOW1ponqeQQRfHV5GaQOzazUSqXc1yN
         KeS/8eUVwwbJaqUSOiUQDURjo3oYuwtMD14czPRSx0r66kK5ANRAErPkHbdSPt1nQUTZ
         CYOa40JCTcdfjlv6g4f4sWRAf6qxDZgxFJd9AksFFR86clFV3VdE/5auRcEgOQAGk/Sk
         gSwFQLndhX60N5gpbwVWzBQHPHSW8J6LnLv4L8xiZ1tXz1tjZh/XnVTWKKg7l//jTowV
         JnYA==
X-Gm-Message-State: AOAM5330tTvKARN73PkStiwJITfJfpEp9pq8Pop9xUec5cG1Y856DiUG
        8ipcmExSbOc3VwlViPpx4onwgg==
X-Google-Smtp-Source: ABdhPJzDJxYD13FIG1o/1C66Twk8iCZ4vuFZ4rZ2QOG5V3S8GIchre6N/bVFW4y+ZeD1yXmnFl7hNg==
X-Received: by 2002:a37:63cc:0:b0:6a0:c68b:b06d with SMTP id x195-20020a3763cc000000b006a0c68bb06dmr13179031qkb.90.1652728141046;
        Mon, 16 May 2022 12:09:01 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id x2-20020a376302000000b0069fc13ce1e8sm6174549qkb.25.2022.05.16.12.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 12:09:00 -0700 (PDT)
Message-ID: <bff48ad7ec42344d81b930babda7777615171148.camel@ndufresne.ca>
Subject: Re: [PATCH] media: hantro: Be more accurate on pixel formats
 step_width constraints
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
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
Date:   Mon, 16 May 2022 15:08:58 -0400
In-Reply-To: <20220516141142.591549-1-benjamin.gaignard@collabora.com>
References: <20220516141142.591549-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
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

Hi Benjamin,

thanks for your patch, but see below, perhaps something you could improve..=
.

Le lundi 16 mai 2022 =C3=A0 16:11 +0200, Benjamin Gaignard a =C3=A9crit=C2=
=A0:
> On Hantro G2 decoder on IMX8MQ strides requirements aren't the same
> for NV12_4L4 and NV12 pixel formats. The first one use a 4 bytes padding
> while the last one needs 8 bytes.
> To be sure to provide the correct stride in all cases we need:
> - to relax the constraints on codec formats so set step_width to 4
> - use capture queue format and not the output queue format when applying
>   the pixel format constraints.
> - put the correct step_width constraints on each pixel format.

From v4l2_apply_frmsize_constraints() point of view, 8 bytes is a sub-set o=
f 4
bytes. The application can request larger then coded size width/height afte=
r
this change and you'd still get a broken render. The reason is that it look=
s
like the tile mode has more constraints then what
v4l2_apply_frmsize_constraints(). It seems like from your description that =
the
width/height must match the coded size (+plus the alignment). For this reas=
on, I
think you need when using tile mode validate the that the width/height pass=
ed to
v4l2_apply_frmsize_constraints() matched the coded size from the header
structure rather then user provided size passed in S_FMT.

regards,
Nicolas

>=20
> With this SAODBLK_A_MainConcept_4 and SAODBLK_B_MainConcept_4 conformance
> tests files are correctly decoded with both NV12 and NV12_4L4 pixel forma=
ts.
> These two files have a resolution of 1016x760.
> If step_width =3D 16 for the both pixel formats the selected capture
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
>  drivers/staging/media/hantro/hantro_v4l2.c    |  2 +-
>  drivers/staging/media/hantro/imx8m_vpu_hw.c   | 40 +++++++++++++++++--
>  .../staging/media/hantro/rockchip_vpu_hw.c    | 32 +++++++++++++++
>  .../staging/media/hantro/sama5d4_vdec_hw.c    | 16 ++++++++
>  drivers/staging/media/hantro/sunxi_vpu_hw.c   | 16 ++++++++
>  5 files changed, 101 insertions(+), 5 deletions(-)
>=20
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

