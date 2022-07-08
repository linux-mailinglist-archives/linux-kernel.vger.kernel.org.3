Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D65956B777
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbiGHKmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiGHKmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47582804BD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:42:16 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id cb12-20020a056830618c00b00616b871cef3so15928947otb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vbo3Wb82ZgGFHuwV12svaEHQLDH9O7wKe6jY6HWRXhY=;
        b=8EUPg3/5EaiUHN0vnZcJQmvXjQMJx9fkbtfkcLCkttmkRKUoEq/QZ0tU1kqgMA9Znj
         7CH06w+uvLiTkjglzeH70bA8hBynPieg/xJMqMrr5end3xRtzfB1ea+HdBYMEMtHHg3E
         d4ULA48+9JF7O0mgZR/7EgZSshMG0mLSJr0Su2xG9FkSoE+LSHJlFmIM+zZQ06xschlf
         nbxjNaCCAiwGGXk6nKP7ukIjZgEThIdS3LiVE8m2xJ4rq/rpxV0wvpZdGmty9UGFlc+i
         egOU8pqd0eAvAFaz6Kq46h89paq6RFnYgQ4aKtgbNhlXIIiYbPsbnRTZt64/Qf0uTerb
         egSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vbo3Wb82ZgGFHuwV12svaEHQLDH9O7wKe6jY6HWRXhY=;
        b=TD5GSBhvmb3YpE3RO5CIXpxa5GDIQqjZFIw1Gn/Q6lG9IHv739KPiUkWT5HVSJ/Csr
         S/NuMBTZDWjQhPIfDnqiVcvwcthnr+oIoWt0ezKaMTYl2FKUoadOhK/+74TmIeAiZQDD
         w7pZAewM4OfLHzXobBD6BFOpPtuMQBUSM/DjQCB8tshYGimKi59aJ5ngMIzVh5oovv4l
         LUqioUUA1UiGwxvLpn9UBhg/L45pezvAJkGo1S70c2KfmZ5D7HWTUUxYAAnStpWT7ycG
         Oh6P+lMCMOrFmYG53yATQHGGGTB5sSRhcirv0ia8zWRASXpGOKYek3sjZWFyMF2gsZLk
         +IpQ==
X-Gm-Message-State: AJIora/oD4li1bTuXKtdsJSVZB/IRh1gDxcm8BN+e1u8unb5Ee1mMfy8
        3en0oxqr53R0gR50uESZVFWBEA==
X-Google-Smtp-Source: AGRyM1tzbbpdDVYyEDXf5c332NybbUnnkr9zj7NhM5LflklG4ao6rMqDCvNezrG82Bl3sUy0/D2GSw==
X-Received: by 2002:a05:6830:438a:b0:616:f238:1562 with SMTP id s10-20020a056830438a00b00616f2381562mr1217862otv.111.1657276935550;
        Fri, 08 Jul 2022 03:42:15 -0700 (PDT)
Received: from eze-laptop ([186.13.97.246])
        by smtp.gmail.com with ESMTPSA id 127-20020aca0785000000b00334c2e81dfbsm9219460oih.0.2022.07.08.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:42:15 -0700 (PDT)
Date:   Fri, 8 Jul 2022 07:42:06 -0300
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
Subject: Re: [PATCH v11 11/17] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Message-ID: <YsgJ/i/93Hr4CpY+@eze-laptop>
References: <20220706093803.158810-1-benjamin.gaignard@collabora.com>
 <20220706093803.158810-12-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706093803.158810-12-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin, Jernej,

On Wed, Jul 06, 2022 at 11:37:57AM +0200, Benjamin Gaignard wrote:
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
> version 11:
> - Be more verbose about num_entry_point_offsets field usage.
> 
>  .../userspace-api/media/v4l/ext-ctrls-codec.rst   | 15 +++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c         |  5 +++++
>  include/media/hevc-ctrls.h                        |  5 ++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index c2e0adece613..59e751c38d06 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -3010,6 +3010,13 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      * - __u32
>        - ``data_bit_offset``
>        - Offset (in bits) to the video data in the current slice data.
> +    * - __u32
> +      - ``num_entry_point_offsets``
> +      - Specifies the number of entry point offset syntax elements in the slice header.

Given this field really matches the syntax element (thanks for the
clarification), I would suggest keeping it simpler,
maybe something along these lines:

""
Specifies the number of entry point offset syntax elements in the slice header.
When the driver supports it, the ``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS``
must be set.
""

> +        This field must be set even if V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
> +        control isn't used. Additionally, if entry point offsets control is needed
> +        and if submitting multiple slices at once, length of entry point offsets
> +        array must be sum of num_entry_point_offsets of all slices in that job.

>      * - __u8
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

I would add Jernej's clarification about the length of the control
here, where the control is documented.

""
This control is a dynamically sized array. The number of entry point
offsets is reported by the ``elems`` field.
This bitstream parameter is defined according to :ref:`hevc`.
They are described in section 7.4.7.1 "General slice segment header
semantics" of the specification.
When multiple slices are submitted in a request, the length
of this array must be the sum of num_entry_point_offsets
of all the slices in the request.
""

Hopefully this is clearer to application developers?

Thanks!
Ezequiel

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
