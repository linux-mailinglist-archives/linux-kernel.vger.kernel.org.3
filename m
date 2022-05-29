Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213F3537008
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiE2Gk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiE2Gk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:40:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5A713FAB;
        Sat, 28 May 2022 23:40:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gh17so15533992ejc.6;
        Sat, 28 May 2022 23:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oONO6WQdQgiLZe2yfgF19dnfhBaN0Q0QQXJTQuPSQa8=;
        b=WizP0tOLHFY2yYYJCUAc+dzaT/eZPmgMpaFlUYgvZAMBFE/p0Iquf/FGynlmmRkOjt
         3+AR2mjyEt/qwhUwIq7q/6+xvi6BytIzDWrBg5mQb6oj24pdk5OX+x6j6bn3Pd6CAgER
         L8sIoMSJyH9wAtf17fer0voGdtRUbEm6Byd3wiB6zVVHIDL02lJ9HtAJdQq3rG5gFzZT
         PuYfvWcc5VTN5PT3GMtaLzKTHNsvOld5+vqVGabqgdPJa03VZHXzx7tRPLCF0tlV6mXb
         E+/ug4zfhyi5dL+ane1xbUBKF39AAfLZ9PhFKvkKK6FhzaYKiQ6VKBXGs0kcKycZ2oRd
         dByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oONO6WQdQgiLZe2yfgF19dnfhBaN0Q0QQXJTQuPSQa8=;
        b=zEBCHlIN4DskYa90E0U0a4wHtC92wd4S/Fjtzp88YvIl04Wv0mVHNDQqzlE58W5K1Z
         /QxKrfLQt7skxp/G9+uqXQ5BWJbzVzTfzUwKoojp3VgTjDVnhDcwTeDRWwwDhLy6XAnM
         bH1MErxGexP7/uE5OS+Kim8jV5iOy1Z0tRE+Pl4+JtBvaxaIrFfZv66/W+zxWGtElGoF
         vW4f9TGtqIlHl8SwkxVfqylUXBZ3fSpDJGSN0G62uPwFxtumWCf5d2jlERYK5UhM3fgp
         O4b6vJ1uKx/9k3wcxG3Gt0um8rZA/Cdp7VoXnsz+NzhR4hop+hGG8NMDLMoT0Aks1ceG
         kZ2g==
X-Gm-Message-State: AOAM532LOR/71wJ0J9M4zQO8QFOn6mLM/G91GFea4tJlsxmoYmfjSXeI
        4z5DQ4ETz4GtiRWfiCQ/MZg=
X-Google-Smtp-Source: ABdhPJwQZX9JGZTHf0Ls6o78Dj++YxB0y0nggFjPkGyaUDGcMUrkrEdxaFhvrLzEpGC8rcKttE/1MA==
X-Received: by 2002:a17:907:8a16:b0:6ff:794c:c368 with SMTP id sc22-20020a1709078a1600b006ff794cc368mr123709ejc.673.1653806422012;
        Sat, 28 May 2022 23:40:22 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id a21-20020a50f0d5000000b0042dce73168csm301350edm.13.2022.05.28.23.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 23:40:21 -0700 (PDT)
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
Subject: Re: [PATCH v6 11/17] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Date:   Sun, 29 May 2022 08:40:19 +0200
Message-ID: <2102641.irdbgypaU6@kista>
In-Reply-To: <20220527143134.3360174-12-benjamin.gaignard@collabora.com>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com> <20220527143134.3360174-12-benjamin.gaignard@collabora.com>
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

Hi!

This series looks very good and I plan to test it shortly on Cedrus, but I 
have one major concern below.

Dne petek, 27. maj 2022 ob 16:31:28 CEST je Benjamin Gaignard napisal(a):
> The number of 'entry point offset' can be very variable.
> Instead of using a large static array define a v4l2 dynamic array
> of U32 (V4L2_CTRL_TYPE_U32).
> The number of entry point offsets is reported by the elems field
> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
> field.

Slice control by itself is variable length array, so you would actually need 
2D variable array for entry points which is not supported. However, easy 
workaround for that is to flatten 2D array to 1D and either have another slice 
control field which would tell first entry point index for convenience or let 
driver calculate it by adding up all num_entry_point_offsets of previous 
slices.

Hans, what do you think?

Note, it seems that H265 decoding on Cedrus still works without entry points, 
so this problem can be solved later. I'm not sure what we lose with that but 
it was suggested that this could influence speed or error resilience or both. 
However, I think we're close to solve it, so I'd like to do that now.

Best regards,
Jernej

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 +++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
>  include/media/hevc-ctrls.h                            |  5 ++++-
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 0796b1563daa..05228e280f66 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      * - __u32
>        - ``data_bit_offset``
>        - Offset (in bits) to the video data in the current slice data.
> +    * - __u32
> +      - ``num_entry_point_offsets``
> +      - Specifies the number of entry point offset syntax elements in the 
slice header.
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
>      Specifies the HEVC scaling matrix parameters used for the scaling 
process
>      for transform coefficients.
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-
core/v4l2-ctrls-defs.c
> index d594efbcbb93..e22921e7ea61 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return 
"HEVC Decode Parameters";
>  	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return 
"HEVC Decode Mode";
>  	case V4L2_CID_STATELESS_HEVC_START_CODE:		return 
"HEVC Start Code";
> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return 
"HEVC Entry Point Offsets";
>  
>  	/* Colorimetry controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! 
*/
> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum 
v4l2_ctrl_type *type,
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
> index a3c829ef531a..1319cb99ae3f 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -20,6 +20,7 @@
>  #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE 
+ 1012)
>  #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 1015)
>  #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_BASE + 
1017)
>  
>  /* enum v4l2_ctrl_type type values */
>  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> @@ -318,6 +319,8 @@ struct v4l2_hevc_pred_weight_table {
>   *
>   * @bit_size: size (in bits) of the current slice data
>   * @data_bit_offset: offset (in bits) to the video data in the current slice 
data
> + * @num_entry_point_offsets: specifies the number of entry point offset syntax
> + *			     elements in the slice header.
>   * @nal_unit_type: specifies the coding type of the slice (B, P or I)
>   * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier for the 
NAL unit
>   * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> @@ -360,7 +363,7 @@ struct v4l2_hevc_pred_weight_table {
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
> 


