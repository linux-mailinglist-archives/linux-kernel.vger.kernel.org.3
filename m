Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B7567308
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiGEPqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiGEPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:45:42 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13911B7B3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:45:32 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id i186so12295541vsc.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/dhXhbOglhCLbSQDWsXDPYparhLE1UyWYSan+fY72i0=;
        b=aGB34TXr33CLWOLjdKvfCju7OjM/UO5amLzuwBXZ0J1SSAyfC9D4I6vkLkZk2EhdlH
         QbZJTQxpIvWW/WQ7ckhUADeP7SBc5Yxt/dGisYHHSDAY5xj+oWR7XNNW1+/YoXUfaJ9B
         mMEaJ6I+4tGjCTXJ0iUxJvWAfQ5Q6RiNf50A5InDLx0J/15XI0TbbY5yDyMzmzBkL7LP
         cH5pczG97jFSprtJ8CAaflQxV/LhDz5b/L+NzsxXTkeGJMsGyQsusUMhczRBwwFrxbwB
         Xy8ZtkTJAH2jaybfcFM3ULz73YH6N7FQg9vrLMdTQHfinveU09l5p8FbXTtc/OKj2nHX
         eMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dhXhbOglhCLbSQDWsXDPYparhLE1UyWYSan+fY72i0=;
        b=U/FRREEwwLY0DXIAK5sNBw/Aa7yfoxDZGL8Rss2ZCgZ0diYDFgAaIUvhxIJGzHVJ1y
         F/QqjIomDDrdWjZhrzv3H6Q0+YEMId9Ap230/bcncDrspio95z/AoV7N1j8FPKGZMSni
         hNwlXe7XdRdyxeaM2VqlIk0HdNI5WdBm7IJebRf2Y7RcUIUUqcWbGrsk8JHbaCpjAqHS
         Qk/EUpEniDtyydHEYi7yDUz5CxHOAuznKh65Wt9bIfXeVDh+q6w08UUqmj2mCSqBeKGh
         UgFaOCCasR/krUpjPFmjvtFvKEYaI+g9h7v91AbKlX94uXUYlsKbrm1b5rTROc0nAFuW
         8TXA==
X-Gm-Message-State: AJIora9PNZEIk7bx/9eB3NzbxgZV3zyJoAr8YiKoCSvqgFcy6mAJcD2O
        GnudrO5QQaKYUFgN+nfDoKqszA==
X-Google-Smtp-Source: AGRyM1tzyAc3cX2djRO5+2Tz5crNgXY742v+srlhhk6HdKdupDTNP9iR+752QyStL0SwjfQtn2Hs3Q==
X-Received: by 2002:a67:ec08:0:b0:354:3c03:3a29 with SMTP id d8-20020a67ec08000000b003543c033a29mr19190218vso.22.1657035931874;
        Tue, 05 Jul 2022 08:45:31 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id s23-20020a67f4d7000000b003567174ede3sm4875203vsn.16.2022.07.05.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 08:45:31 -0700 (PDT)
Date:   Tue, 5 Jul 2022 12:45:26 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v10 11/17] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Message-ID: <YsRclobW7gL/Dtlr@eze-laptop>
References: <20220705085420.272912-1-benjamin.gaignard@collabora.com>
 <20220705085420.272912-12-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705085420.272912-12-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On Tue, Jul 05, 2022 at 10:54:14AM +0200, Benjamin Gaignard wrote:
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
> ---
>  .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 +++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
>  include/media/hevc-ctrls.h                            |  5 ++++-
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index db0df7d9f27c..8df8d7fdfe70 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      * - __u32
>        - ``data_bit_offset``
>        - Offset (in bits) to the video data in the current slice data.
> +    * - __u32
> +      - ``num_entry_point_offsets``
> +      - Specifies the number of entry point offset syntax elements in the slice header.

This looks underdocumented. Somewhere in the docs it should be mentioned
that the field 'num_entry_point_offsets' is linked to the control
V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS.

Thanks,
Ezequiel

>      * - __u8
>        - ``nal_unit_type``
>        - Specifies the coding type of the slice (B, P or I).
> @@ -3150,6 +3153,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
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
>      Specifies the HEVC scaling matrix parameters used for the scaling process
>      for transform coefficients.
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index d594efbcbb93..e22921e7ea61 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return "HEVC Decode Parameters";
>  	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return "HEVC Decode Mode";
>  	case V4L2_CID_STATELESS_HEVC_START_CODE:		return "HEVC Start Code";
> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return "HEVC Entry Point Offsets";
>  
>  	/* Colorimetry controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
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
>  #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE + 1012)
>  #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 1015)
>  #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_BASE + 1017)
>  
>  /* enum v4l2_ctrl_type type values */
>  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> @@ -316,6 +317,8 @@ struct v4l2_hevc_pred_weight_table {
>   *
>   * @bit_size: size (in bits) of the current slice data
>   * @data_bit_offset: offset (in bits) to the video data in the current slice data
> + * @num_entry_point_offsets: specifies the number of entry point offset syntax
> + *			     elements in the slice header.
>   * @nal_unit_type: specifies the coding type of the slice (B, P or I)
>   * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier for the NAL unit
>   * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> @@ -358,7 +361,7 @@ struct v4l2_hevc_pred_weight_table {
>  struct v4l2_ctrl_hevc_slice_params {
>  	__u32	bit_size;
>  	__u32	data_bit_offset;
> -
> +	__u32	num_entry_point_offsets;
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>  	__u8	nal_unit_type;
>  	__u8	nuh_temporal_id_plus1;
> -- 
> 2.32.0
> 
