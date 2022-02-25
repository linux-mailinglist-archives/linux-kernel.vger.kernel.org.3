Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826524C516D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiBYWUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiBYWUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:20:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86A418BA45;
        Fri, 25 Feb 2022 14:20:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p4so2438350wmg.1;
        Fri, 25 Feb 2022 14:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTS+vdOLNEtuza3u9nDhaixZUNOOZbTdgomv7CKNLF4=;
        b=SXgyAvFnFra/fR4DJESytpsMaUTvY21HthuoqYvKOrg0PyrUcXt6ewNHxv2zDDAGr8
         GZadX+MPBcrBm9HoIvjpRPhLei9BXZB8lMd0Zn+hQDsnq7an+3dD0IHfNmkH8wWy4GMb
         p27PGjnuUYu3DPWflmJbFvnITlgK2V+W4Jpu4VT2tPSdYU7MZWAPEhN5LipUuJemb03r
         6ga2rMaIgX+w7XQ0i91gyYkeR9zPdsiF594wxij4e0sK/mmzYW6ZAa5C0s2hOMP+MGZq
         ZR6THMkkgc6MI2o0BHdaIP0vwfz90nrZbffIvqq7Hz1PTOQJWt2HGrXCjSfdqh26ky6k
         VsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTS+vdOLNEtuza3u9nDhaixZUNOOZbTdgomv7CKNLF4=;
        b=aQ0vjIXVZKsWwJJy0LXSrEMXExn6JoQX1O+YibCeBLPIwQpiRbKHdceEPTMNzWCPhV
         a8o6qY5Xf6qU0Kmum54MeX8x1nn0grvVPHmZiPZYTpI3Kzc91AjZq6pnSfR0dLtNrovo
         sWa0UZPgU/Xuxio4WNFvFMM1Vgyo2LgPbzMfo5NkUS+HE11nY6RBbFA8JfMwHmvR1VKz
         1qe2YqMbCNEt1yUfGKsvTNNnYUyyb5WT40LosSh1jpO+ckFvUVLxNdK2iGVZd6dX63za
         NDymWE0WHe2Ny0zaYPwh+oeLbWsmS+E95Ft2FrnKjphcTTPsVV9G4nDQpwoWXCkffTlh
         gngw==
X-Gm-Message-State: AOAM531orvKwycOo9IGqbjtpXOm3xxJxholl7gGOyG+no/b5ULi7cDBV
        aPJPiJe4yc0pcTEM9B7EncY=
X-Google-Smtp-Source: ABdhPJxXDy2hhQtQpNi/FBFusiryvxHcxYnYAJBOAW9NmfxlvRKKkFXSZmurKwBpTpQZuw2EITs5Zw==
X-Received: by 2002:a1c:f616:0:b0:37d:1e1c:f90a with SMTP id w22-20020a1cf616000000b0037d1e1cf90amr4238740wmc.148.1645827599107;
        Fri, 25 Feb 2022 14:19:59 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm9753190wmq.40.2022.02.25.14.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 14:19:27 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jonas@kwiboo.se, nicolas@ndufresne.ca,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v3 05/14] media: uapi: HEVC: Rename HEVC stateless controls with STATELESS prefix
Date:   Fri, 25 Feb 2022 23:19:09 +0100
Message-ID: <12960392.uLZWGnKmhe@kista>
In-Reply-To: <20220225164600.1044663-6-benjamin.gaignard@collabora.com>
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com> <20220225164600.1044663-6-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 25. februar 2022 ob 17:45:51 CET je Benjamin Gaignard napisal(a):
> Change HEVC  stateless controls names to V4L2_CID_STATELESS_HEVC instead
> of V4L2_CID_MPEG_VIDEO_HEVC be coherent with v4l2 naming convention.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/v4l/ext-ctrls-codec.rst             | 26 +++++++--------
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c     | 32 +++++++++----------
>  drivers/staging/media/hantro/hantro_drv.c     | 26 +++++++--------
>  drivers/staging/media/hantro/hantro_hevc.c    |  8 ++---
>  drivers/staging/media/sunxi/cedrus/cedrus.c   | 24 +++++++-------
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   | 10 +++---
>  include/media/hevc-ctrls.h                    | 26 +++++++--------
>  7 files changed, 76 insertions(+), 76 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index b83d45202916..262ad4f3c1f4 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2639,7 +2639,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>  
>  .. _v4l2-mpeg-hevc:
>  
> -``V4L2_CID_MPEG_VIDEO_HEVC_SPS (struct)``
> +``V4L2_CID_STATELESS_HEVC_SPS (struct)``
>      Specifies the Sequence Parameter Set fields (as extracted from the
>      bitstream) for the associated HEVC slice data.
>      These bitstream parameters are defined according to :ref:`hevc`.
> @@ -2792,7 +2792,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>  
>      \normalsize
>  
> -``V4L2_CID_MPEG_VIDEO_HEVC_PPS (struct)``
> +``V4L2_CID_STATELESS_HEVC_PPS (struct)``
>      Specifies the Picture Parameter Set fields (as extracted from the
>      bitstream) for the associated HEVC slice data.
>      These bitstream parameters are defined according to :ref:`hevc`.
> @@ -2945,7 +2945,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>  
>      \normalsize
>  
> -``V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS (struct)``
> +``V4L2_CID_STATELESS_HEVC_SLICE_PARAMS (struct)``
>      Specifies various slice-specific parameters, especially from the NAL unit
>      header, general slice segment header and weighted prediction parameter
>      parts of the bitstream.
> @@ -3110,7 +3110,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>  
>      \normalsize
>  
> -``V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX (struct)``
> +``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>      Specifies the HEVC scaling matrix parameters used for the scaling 
process
>      for transform coefficients.
>      These matrix and parameters are defined according to :ref:`hevc`.
> @@ -3260,7 +3260,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>  
>      \normalsize
>  
> -``V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE (enum)``
> +``V4L2_CID_STATELESS_HEVC_DECODE_MODE (enum)``
>      Specifies the decoding mode to use. Currently exposes slice-based and
>      frame-based decoding but new modes might be added later on.
>      This control is used as a modifier for V4L2_PIX_FMT_HEVC_SLICE
> @@ -3275,7 +3275,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>         This menu control is not yet part of the public kernel API and
>         it is expected to change.
>  
> -.. c:type:: v4l2_mpeg_video_hevc_decode_mode
> +.. c:type:: v4l2_stateless_hevc_decode_mode
>  
>  .. raw:: latex
>  
> @@ -3288,11 +3288,11 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      :stub-columns: 0
>      :widths:       1 1 2
>  
> -    * - ``V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED``
> +    * - ``V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED``
>        - 0
>        - Decoding is done at the slice granularity.
>          The OUTPUT buffer must contain a single slice.
> -    * - ``V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED``
> +    * - ``V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED``
>        - 1
>        - Decoding is done at the frame granularity.
>          The OUTPUT buffer must contain all slices needed to decode the
> @@ -3302,7 +3302,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>  
>      \normalsize
>  
> -``V4L2_CID_MPEG_VIDEO_HEVC_START_CODE (enum)``
> +``V4L2_CID_STATELESS_HEVC_START_CODE (enum)``
>      Specifies the HEVC slice start code expected for each slice.
>      This control is used as a modifier for V4L2_PIX_FMT_HEVC_SLICE
>      pixel format. Applications that support V4L2_PIX_FMT_HEVC_SLICE
> @@ -3316,7 +3316,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>         This menu control is not yet part of the public kernel API and
>         it is expected to change.
>  
> -.. c:type:: v4l2_mpeg_video_hevc_start_code
> +.. c:type:: v4l2_stateless_hevc_start_code
>  
>  .. tabularcolumns:: |p{9.2cm}|p{0.6cm}|p{7.5cm}|
>  
> @@ -3325,13 +3325,13 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      :stub-columns: 0
>      :widths:       1 1 2
>  
> -    * - ``V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE``
> +    * - ``V4L2_STATELESS_HEVC_START_CODE_NONE``
>        - 0
>        - Selecting this value specifies that HEVC slices are passed
>          to the driver without any start code. The bitstream data should be
>          according to :ref:`hevc` 7.3.1.1 General NAL unit syntax, hence
>          contains emulation prevention bytes when required.
> -    * - ``V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B``
> +    * - ``V4L2_STATELESS_HEVC_START_CODE_ANNEX_B``
>        - 1
>        - Selecting this value specifies that HEVC slices are expected
>          to be prefixed by Annex B start codes. According to :ref:`hevc`
> @@ -3364,7 +3364,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      This provides a bitmask which consists of bits [0, LTR_COUNT-1].
>      This is applicable to the H264 and HEVC encoders.
>  
> -``V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS (struct)``
> +``V4L2_CID_STATELESS_HEVC_DECODE_PARAMS (struct)``
>      Specifies various decode parameters, especially the references picture 
order
>      count (POC) for all the lists (short, long, before, current, after) and 
the
>      number of entries for each of them.
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-
core/v4l2-ctrls-defs.c
> index 54ca4e6b820b..00cb08083514 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -699,9 +699,9 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		return hevc_tier;
>  	case V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE:
>  		return hevc_loop_filter_mode;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE:
> +	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:
>  		return hevc_decode_mode;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:
> +	case V4L2_CID_STATELESS_HEVC_START_CODE:
>  		return hevc_start_code;
>  	case V4L2_CID_CAMERA_ORIENTATION:
>  		return camera_orientation;
> @@ -995,13 +995,13 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_MPEG_VIDEO_HEVC_SIZE_OF_LENGTH_FIELD:	return 
"HEVC Size of Length Field";
>  	case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:	return 
"Reference Frames for a P-Frame";
>  	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:		
return "Prepend SPS and PPS to IDR";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SPS:			
return "HEVC Sequence Parameter Set";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_PPS:			
return "HEVC Picture Parameter Set";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS:		return 
"HEVC Slice Parameters";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX:		
return "HEVC Scaling Matrix";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS:		
return "HEVC Decode Parameters";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE:		return "HEVC 
Decode Mode";
> -	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:		return 
"HEVC Start Code";
> +	case V4L2_CID_STATELESS_HEVC_SPS:			return 
"HEVC Sequence Parameter Set";
> +	case V4L2_CID_STATELESS_HEVC_PPS:			return 
"HEVC Picture Parameter Set";
> +	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:		return 
"HEVC Slice Parameters";
> +	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:		return 
"HEVC Scaling Matrix";
> +	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return "HEVC 
Decode Parameters";
> +	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return "HEVC 
Decode Mode";
> +	case V4L2_CID_STATELESS_HEVC_START_CODE:		return 
"HEVC Start Code";

These shouldbe now moved under "/* Stateless Codec controls */" section.

Note, description for V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS is missing, 
but that should be a part of another patch (one that introduces that CID).

Best regards,
Jernej

>  
>  	/* CAMERA controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! 
*/
> @@ -1355,8 +1355,8 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum 
v4l2_ctrl_type *type,
>  	case V4L2_CID_MPEG_VIDEO_HEVC_SIZE_OF_LENGTH_FIELD:
>  	case V4L2_CID_MPEG_VIDEO_HEVC_TIER:
>  	case V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE:
> -	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE:
> -	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:
> +	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:
> +	case V4L2_CID_STATELESS_HEVC_START_CODE:
>  	case V4L2_CID_STATELESS_H264_DECODE_MODE:
>  	case V4L2_CID_STATELESS_H264_START_CODE:
>  	case V4L2_CID_CAMERA_ORIENTATION:
> @@ -1493,19 +1493,19 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum 
v4l2_ctrl_type *type,
>  	case V4L2_CID_STATELESS_VP8_FRAME:
>  		*type = V4L2_CTRL_TYPE_VP8_FRAME;
>  		break;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SPS:
> +	case V4L2_CID_STATELESS_HEVC_SPS:
>  		*type = V4L2_CTRL_TYPE_HEVC_SPS;
>  		break;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_PPS:
> +	case V4L2_CID_STATELESS_HEVC_PPS:
>  		*type = V4L2_CTRL_TYPE_HEVC_PPS;
>  		break;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS:
> +	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:
>  		*type = V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS;
>  		break;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX:
> +	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:
>  		*type = V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX;
>  		break;
> -	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS:
> +	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
>  		*type = V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
>  		break;
>  	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/
media/hantro/hantro_drv.c
> index dc768884cb79..6f58c259d8fc 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -255,7 +255,7 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  		if (sps->bit_depth_luma_minus8 != 0)
>  			/* Only 8-bit is supported */
>  			return -EINVAL;
> -	} else if (ctrl->id == V4L2_CID_MPEG_VIDEO_HEVC_SPS) {
> +	} else if (ctrl->id == V4L2_CID_STATELESS_HEVC_SPS) {
>  		const struct v4l2_ctrl_hevc_sps *sps = ctrl-
>p_new.p_hevc_sps;
>  
>  		if (sps->bit_depth_luma_minus8 != sps-
>bit_depth_chroma_minus8)
> @@ -428,18 +428,18 @@ static const struct hantro_ctrl controls[] = {
>  	}, {
>  		.codec = HANTRO_HEVC_DECODER,
>  		.cfg = {
> -			.id = V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE,
> -			.min = 
V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
> -			.max = 
V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
> -			.def = 
V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
> +			.id = V4L2_CID_STATELESS_HEVC_DECODE_MODE,
> +			.min = 
V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
> +			.max = 
V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
> +			.def = 
V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
>  		},
>  	}, {
>  		.codec = HANTRO_HEVC_DECODER,
>  		.cfg = {
> -			.id = V4L2_CID_MPEG_VIDEO_HEVC_START_CODE,
> -			.min = 
V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
> -			.max = 
V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
> -			.def = 
V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
> +			.id = V4L2_CID_STATELESS_HEVC_START_CODE,
> +			.min = 
V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
> +			.max = 
V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
> +			.def = 
V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
>  		},
>  	}, {
>  		.codec = HANTRO_HEVC_DECODER,
> @@ -459,23 +459,23 @@ static const struct hantro_ctrl controls[] = {
>  	}, {
>  		.codec = HANTRO_HEVC_DECODER,
>  		.cfg = {
> -			.id = V4L2_CID_MPEG_VIDEO_HEVC_SPS,
> +			.id = V4L2_CID_STATELESS_HEVC_SPS,
>  			.ops = &hantro_ctrl_ops,
>  		},
>  	}, {
>  		.codec = HANTRO_HEVC_DECODER,
>  		.cfg = {
> -			.id = V4L2_CID_MPEG_VIDEO_HEVC_PPS,
> +			.id = V4L2_CID_STATELESS_HEVC_PPS,
>  		},
>  	}, {
>  		.codec = HANTRO_HEVC_DECODER,
>  		.cfg = {
> -			.id = 
V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS,
> +			.id = V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
>  		},
>  	}, {
>  		.codec = HANTRO_HEVC_DECODER,
>  		.cfg = {
> -			.id = 
V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX,
> +			.id = V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
>  		},
>  	}, {
>  		.codec = HANTRO_HEVC_DECODER,
> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/
media/hantro/hantro_hevc.c
> index b49a41d7ae91..b6ec86d03d91 100644
> --- a/drivers/staging/media/hantro/hantro_hevc.c
> +++ b/drivers/staging/media/hantro/hantro_hevc.c
> @@ -201,22 +201,22 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx 
*ctx)
>  	hantro_start_prepare_run(ctx);
>  
>  	ctrls->decode_params =
> -		hantro_get_ctrl(ctx, 
V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS);
> +		hantro_get_ctrl(ctx, 
V4L2_CID_STATELESS_HEVC_DECODE_PARAMS);
>  	if (WARN_ON(!ctrls->decode_params))
>  		return -EINVAL;
>  
>  	ctrls->scaling =
> -		hantro_get_ctrl(ctx, 
V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX);
> +		hantro_get_ctrl(ctx, 
V4L2_CID_STATELESS_HEVC_SCALING_MATRIX);
>  	if (WARN_ON(!ctrls->scaling))
>  		return -EINVAL;
>  
>  	ctrls->sps =
> -		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_SPS);
> +		hantro_get_ctrl(ctx, V4L2_CID_STATELESS_HEVC_SPS);
>  	if (WARN_ON(!ctrls->sps))
>  		return -EINVAL;
>  
>  	ctrls->pps =
> -		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_PPS);
> +		hantro_get_ctrl(ctx, V4L2_CID_STATELESS_HEVC_PPS);
>  	if (WARN_ON(!ctrls->pps))
>  		return -EINVAL;
>  
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/
media/sunxi/cedrus/cedrus.c
> index 4a4b714b0f26..e0428163f82c 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -42,7 +42,7 @@ static int cedrus_try_ctrl(struct v4l2_ctrl *ctrl)
>  		if (sps->bit_depth_luma_minus8 != 0)
>  			/* Only 8-bit is supported */
>  			return -EINVAL;
> -	} else if (ctrl->id == V4L2_CID_MPEG_VIDEO_HEVC_SPS) {
> +	} else if (ctrl->id == V4L2_CID_STATELESS_HEVC_SPS) {
>  		const struct v4l2_ctrl_hevc_sps *sps = ctrl-
>p_new.p_hevc_sps;
>  		struct cedrus_ctx *ctx = container_of(ctrl->handler, 
struct cedrus_ctx, hdl);
>  
> @@ -164,42 +164,42 @@ static const struct cedrus_control cedrus_controls[] = 
{
>  	},
>  	{
>  		.cfg = {
> -			.id	= V4L2_CID_MPEG_VIDEO_HEVC_SPS,
> +			.id	= V4L2_CID_STATELESS_HEVC_SPS,
>  			.ops	= &cedrus_ctrl_ops,
>  		},
>  		.codec		= CEDRUS_CODEC_H265,
>  	},
>  	{
>  		.cfg = {
> -			.id	= V4L2_CID_MPEG_VIDEO_HEVC_PPS,
> +			.id	= V4L2_CID_STATELESS_HEVC_PPS,
>  		},
>  		.codec		= CEDRUS_CODEC_H265,
>  	},
>  	{
>  		.cfg = {
> -			.id	= 
V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS,
> +			.id	= 
V4L2_CID_STATELESS_HEVC_SLICE_PARAMS,
>  		},
>  		.codec		= CEDRUS_CODEC_H265,
>  	},
>  	{
>  		.cfg = {
> -			.id	= 
V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX,
> +			.id	= 
V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
>  		},
>  		.codec		= CEDRUS_CODEC_H265,
>  	},
>  	{
>  		.cfg = {
> -			.id	= 
V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE,
> -			.max	= 
V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED,
> -			.def	= 
V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED,
> +			.id	= 
V4L2_CID_STATELESS_HEVC_DECODE_MODE,
> +			.max	= 
V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
> +			.def	= 
V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
>  		},
>  		.codec		= CEDRUS_CODEC_H265,
>  	},
>  	{
>  		.cfg = {
> -			.id	= 
V4L2_CID_MPEG_VIDEO_HEVC_START_CODE,
> -			.max	= 
V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE,
> -			.def	= 
V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE,
> +			.id	= 
V4L2_CID_STATELESS_HEVC_START_CODE,
> +			.max	= 
V4L2_STATELESS_HEVC_START_CODE_NONE,
> +			.def	= 
V4L2_STATELESS_HEVC_START_CODE_NONE,
>  		},
>  		.codec		= CEDRUS_CODEC_H265,
>  	},
> @@ -211,7 +211,7 @@ static const struct cedrus_control cedrus_controls[] = {
>  	},
>  	{
>  		.cfg = {
> -			.id = 
V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS,
> +			.id = V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
>  		},
>  		.codec		= CEDRUS_CODEC_H265,
>  	},
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/
staging/media/sunxi/cedrus/cedrus_dec.c
> index a16c1422558f..f6be4ae72ee2 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> @@ -65,15 +65,15 @@ void cedrus_device_run(void *priv)
>  
>  	case V4L2_PIX_FMT_HEVC_SLICE:
>  		run.h265.sps = cedrus_find_control_data(ctx,
> -			V4L2_CID_MPEG_VIDEO_HEVC_SPS);
> +			V4L2_CID_STATELESS_HEVC_SPS);
>  		run.h265.pps = cedrus_find_control_data(ctx,
> -			V4L2_CID_MPEG_VIDEO_HEVC_PPS);
> +			V4L2_CID_STATELESS_HEVC_PPS);
>  		run.h265.slice_params = cedrus_find_control_data(ctx,
> -			V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS);
> +			V4L2_CID_STATELESS_HEVC_SLICE_PARAMS);
>  		run.h265.decode_params = cedrus_find_control_data(ctx,
> -			V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS);
> +			V4L2_CID_STATELESS_HEVC_DECODE_PARAMS);
>  		run.h265.scaling_matrix = cedrus_find_control_data(ctx,
> -			V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX);
> +			V4L2_CID_STATELESS_HEVC_SCALING_MATRIX);
>  		break;
>  
>  	case V4L2_PIX_FMT_VP8_FRAME:
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index a329e086a89a..b3540167df9e 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -16,13 +16,13 @@
>  /* The pixel format isn't stable at the moment and will likely be renamed. 
*/
>  #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC 
parsed slices */
>  
> -#define V4L2_CID_MPEG_VIDEO_HEVC_SPS		(V4L2_CID_CODEC_BASE + 
1008)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_PPS		(V4L2_CID_CODEC_BASE + 
1009)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS	(V4L2_CID_CODEC_BASE + 
1010)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX	(V4L2_CID_CODEC_BASE + 
1011)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE + 
1012)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 
1015)
> -#define V4L2_CID_MPEG_VIDEO_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 
1016)
> +#define V4L2_CID_STATELESS_HEVC_SPS		(V4L2_CID_CODEC_BASE + 
1008)
> +#define V4L2_CID_STATELESS_HEVC_PPS		(V4L2_CID_CODEC_BASE + 
1009)
> +#define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS	(V4L2_CID_CODEC_BASE + 
1010)
> +#define V4L2_CID_STATELESS_HEVC_SCALING_MATRIX	(V4L2_CID_CODEC_BASE + 
1011)
> +#define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE + 
1012)
> +#define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 
1015)
> +#define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
>  
>  /* enum v4l2_ctrl_type type values */
>  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> @@ -31,14 +31,14 @@
>  #define V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX 0x0123
>  #define V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS 0x0124
>  
> -enum v4l2_mpeg_video_hevc_decode_mode {
> -	V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED,
> -	V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
> +enum v4l2_stateless_hevc_decode_mode {
> +	V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
> +	V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
>  };
>  
> -enum v4l2_mpeg_video_hevc_start_code {
> -	V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE,
> -	V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
> +enum v4l2_stateless_hevc_start_code {
> +	V4L2_STATELESS_HEVC_START_CODE_NONE,
> +	V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
>  };
>  
>  #define V4L2_HEVC_SLICE_TYPE_B	0
> -- 
> 2.32.0
> 
> 


