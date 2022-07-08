Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9AD56B1F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbiGHE7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbiGHE7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:59:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4E376EAD;
        Thu,  7 Jul 2022 21:59:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sb34so35764761ejc.11;
        Thu, 07 Jul 2022 21:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbzU1NEw9jssixWhWJrvAWfUIVJG59WeLpo6y3ejNL8=;
        b=ZWDRcARnh37E7hLpPiJw+bSbMNdnbTvwSIG8mJQuN9AJLUetbtk70FdGBlQgFPRZcG
         eCHryFyoOT2l6irvv4WjXHqUMJrc+CAvCGHhJiYS8bh+8GMQvdAG8icBHZNmsfal/sFQ
         3JGbAb2ZaC37PYZ00KpCj9J3uDvZDxkmOmfBMNGW0BqnYFOmBN6KWwuxxmDIXJ2Jd8BY
         eJLxh5CjUDjSHKra9WClVwi21aMVLk5/2g+oAoAKr+fOsKcehl1cmIrn4ERhl6Lw9G8M
         E12aylIE90bli3DwOzaMe0BJNU8sgAwjc+v4WTYuhAI9A730h4hEOh4YDdTwbUlGp6Kc
         w+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbzU1NEw9jssixWhWJrvAWfUIVJG59WeLpo6y3ejNL8=;
        b=JmrQ3MiG5DpY7IpRop2VO+j2Yn6OfXOPutq4ll9GPbBGap5EGnFFaYT719ovI5tZy2
         GDUVbTm7/B5TYxz8JV+4h7jKbrplaEeeC1MouK87uqXH/aHJ6jROWur/T0y6LXvhp1Lz
         FLad0sIRunRx/l0VcaHhrkplGqgfWECKaCKUyi33C8h0J1j8I3GH6U1N40id8JV/1VZc
         rmlzeiIEZQ57feafLcYr6VwFUb/9TagpMbAXWxadmCSoDnXENwtCPq3A9TYC6zFdHI3r
         9Ag9/jsyGE0yZ1esbTR7zzRHGlUg1tVPvybwNais9dUS8sVK5exgIem/D4KNSVWseLGt
         3tBA==
X-Gm-Message-State: AJIora+rrTdViKXfZexSDp95+lAXVxctE4LvsHBBhhHDE/aGjXk+VP4G
        8XfWQGXENgjanjsL0PonfnE=
X-Google-Smtp-Source: AGRyM1tB1j1dl+dJsTCR1/AayROaNRUAdCtoaXF2DONWEedudqNFFhQj8RHgrNXfonLTu2a8K6WC2g==
X-Received: by 2002:a17:906:20c6:b0:718:cc95:ccaf with SMTP id c6-20020a17090620c600b00718cc95ccafmr1676983ejc.714.1657256389600;
        Thu, 07 Jul 2022 21:59:49 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709063d2a00b0072ae8fb13e6sm2553165ejf.126.2022.07.07.21.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 21:59:49 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v11 11/17] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Date:   Fri, 08 Jul 2022 06:59:47 +0200
Message-ID: <4722279.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20220706093803.158810-12-benjamin.gaignard@collabora.com>
References: <20220706093803.158810-1-benjamin.gaignard@collabora.com> <20220706093803.158810-12-benjamin.gaignard@collabora.com>
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

Hi Benjamin,

Dne sreda, 06. julij 2022 ob 11:37:57 CEST je Benjamin Gaignard napisal(a):
> The number of 'entry point offset' can be very variable.
> Instead of using a large static array define a v4l2 dynamic array
> of U32 (V4L2_CTRL_TYPE_U32).
> The number of entry point offsets is reported by the elems field
> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
> field.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Clarification looks good to me :)

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> version 11:
> - Be more verbose about num_entry_point_offsets field usage.
> 
>  .../userspace-api/media/v4l/ext-ctrls-codec.rst   | 15 +++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c         |  5 +++++
>  include/media/hevc-ctrls.h                        |  5 ++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst index
> c2e0adece613..59e751c38d06 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -3010,6 +3010,13 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      * - __u32
>        - ``data_bit_offset``
>        - Offset (in bits) to the video data in the current slice data.
> +    * - __u32
> +      - ``num_entry_point_offsets``
> +      - Specifies the number of entry point offset syntax elements in the
> slice header. +        This field must be set even if
> V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS +        control isn't used.
> Additionally, if entry point offsets control is needed +        and if
> submitting multiple slices at once, length of entry point offsets +       
> array must be sum of num_entry_point_offsets of all slices in that job. * -
> __u8
>        - ``nal_unit_type``
>        - Specifies the coding type of the slice (B, P or I).
> @@ -3150,6 +3157,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> 
>      \normalsize
> 
> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
> +    Specifies entry point offsets in bytes.
> +    This control is a dynamically sized array. The number of entry point
> +    offsets is reported by the ``elems`` field.
> +    This bitstream parameter is defined according to :ref:`hevc`.
> +    They are described in section 7.4.7.1 "General slice segment header
> +    semantics" of the specification.
> +
>  ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>      Specifies the HEVC scaling matrix parameters used for the scaling
> process for transform coefficients.
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c index
> d594efbcbb93..e22921e7ea61 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return 
"HEVC Decode
> Parameters"; case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return 
"HEVC Decode
> Mode"; case V4L2_CID_STATELESS_HEVC_START_CODE:		return 
"HEVC Start Code";
> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return 
"HEVC Entry
> Point Offsets";
> 
>  	/* Colorimetry controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! 
*/
> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum
> v4l2_ctrl_type *type, case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
>  		*type = V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
>  		break;
> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
> +		*type = V4L2_CTRL_TYPE_U32;
> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> +		break;
>  	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
>  		*type = V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
>  		break;
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index a372c184689e..3a6601a46ced 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -20,6 +20,7 @@
>  #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE 
+ 1012)
>  #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 1015)
>  #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_BASE +
> 1017)
> 
>  /* enum v4l2_ctrl_type type values */
>  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> @@ -316,6 +317,8 @@ struct v4l2_hevc_pred_weight_table {
>   *
>   * @bit_size: size (in bits) of the current slice data
>   * @data_bit_offset: offset (in bits) to the video data in the current
> slice data + * @num_entry_point_offsets: specifies the number of entry
> point offset syntax + *			     elements in the slice 
header.
>   * @nal_unit_type: specifies the coding type of the slice (B, P or I)
>   * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier for the
> NAL unit * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> @@ -358,7 +361,7 @@ struct v4l2_hevc_pred_weight_table {
>  struct v4l2_ctrl_hevc_slice_params {
>  	__u32	bit_size;
>  	__u32	data_bit_offset;
> -
> +	__u32	num_entry_point_offsets;
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>  	__u8	nal_unit_type;
>  	__u8	nuh_temporal_id_plus1;




