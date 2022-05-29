Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDC753706C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 11:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiE2JTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 05:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiE2JTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 05:19:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41A157B0F;
        Sun, 29 May 2022 02:19:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c2so584931edf.5;
        Sun, 29 May 2022 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HEGRO1E10+wWKc//c336BxlasIWsJvKYVSCospJ4F4=;
        b=NFeH/wB/eb/HtoJC39Dm3B4prjToxAjJdwTsNJOe9dWWJ+fo6g8h9TELQSfd66nLHl
         PK6uoBPvMmgT03AEyKlRoCK+E9JAlvOlH9XXAF8+OYy1kXhwunmatNPnhK2iWoinreHQ
         C/2ZsUkeWV2x9df7bi89T5d/XPoVuHTH+iCgIhyLBKg8IcDdn/sPf7PhT7kpA68vCYXb
         XR/zPVFl7OKfTKnrPDbhdBb/icTC5fwU8yRkI8/SfnvEcXPe3GlPaQv86ZxDJOeLoMe9
         BH1fRW7FQbSQqTj+I/bPW+Oev5Ja8j6M6L1FAz66AEYWtsiIc/0BbzkNL5zTk8QZ/rbz
         taOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HEGRO1E10+wWKc//c336BxlasIWsJvKYVSCospJ4F4=;
        b=IIZkrXf14pzt3uGjX1t9PDkEaWq0pC5MegdLUNbz0fz6Ku1aY8gVcz3G/KR5sugw8b
         H11Oxrh2OGcEwdwk0R5tQZjqObRNSvrRlR0rWURmu+mDUj332DQxdbUZbzqQmZ2TtR9H
         zNOB4kxAmKudoVp2769bXYQEKG6gUtN8PX6kVo3PWhvmRxPT4ZDaVXe3yK63ooltuU5C
         fOSOkZ6Kr9Q2hM6EHqh+N0XW6vvOasRtiyM+ex2P9Qb0WFSjC/dmXkx+Sy+jImS7bPkY
         ZFVvBeZtgzbg0k3iQSjXZk4HArZhSh5KD9HDur/35yyYa53mlo+hMKbDrpVx0Qr+g3gq
         eHlQ==
X-Gm-Message-State: AOAM533ubWU8wNoZ0TMDldBaULn8YQPqhz4+kSSDvQIQlktCscRDaGnI
        0Dh+0GH6AkMO3g8fcdFpdxk=
X-Google-Smtp-Source: ABdhPJwr0AWqiMQ6Aco3OPjNeh8dOemUUp8N4NNr09EViJuMk78MqqxeUlqxu45lAQX8V3ZnKtB1Ow==
X-Received: by 2002:a50:fc06:0:b0:42b:c6d3:6ff0 with SMTP id i6-20020a50fc06000000b0042bc6d36ff0mr22105455edr.213.1653815954354;
        Sun, 29 May 2022 02:19:14 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id z20-20020a05640240d400b0042aad9edc9bsm4829999edb.71.2022.05.29.02.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 02:19:13 -0700 (PDT)
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
Subject: Re: [PATCH v6 09/17] media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a dynamic array
Date:   Sun, 29 May 2022 11:19:12 +0200
Message-ID: <2630478.mvXUDI8C0e@kista>
In-Reply-To: <20220527143134.3360174-10-benjamin.gaignard@collabora.com>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com> <20220527143134.3360174-10-benjamin.gaignard@collabora.com>
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

Dne petek, 27. maj 2022 ob 16:31:26 CEST je Benjamin Gaignard napisal(a):
> Make explicit that V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control is
> a dynamic array control type.
> Some drivers may be able to receive multiple slices in one control
> to improve decoding performance.
> 
> Define the max size of the dynamic that can driver can set in .dims = {}.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 6:
> - Set V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag automatically when using
>   V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control.
> - Add a define for max slices count
> 
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 1 +
>  include/media/hevc-ctrls.h                                | 5 +++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 06b967de140c..0796b1563daa 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2986,6 +2986,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      These bitstream parameters are defined according to :ref:`hevc`.
>      They are described in section 7.4.7 "General slice segment header
>      semantics" of the specification.
> +    This control is a dynamically sized 1-dimensional array,
> +    V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>  
>  .. c:type:: v4l2_ctrl_hevc_slice_params
>  
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-
core/v4l2-ctrls-defs.c
> index 9f55503cd3d6..d594efbcbb93 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1510,6 +1510,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum 
v4l2_ctrl_type *type,
>  		break;
>  	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:
>  		*type = V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS;
> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;

This change breaks Cedrus. I'll check what needs to be changed.

Best regards,
Jernej

>  		break;
>  	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:
>  		*type = V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX;
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index 0dbd5d681c28..140151609c96 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -311,9 +311,14 @@ struct v4l2_hevc_pred_weight_table {
>  #define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED 
(1ULL << 8)
>  #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << 
9)
>  
> +#define V4L2_HEVC_SLICE_MAX_COUNT	600
> +
>  /**
>   * v4l2_ctrl_hevc_slice_params - HEVC slice parameters
>   *
> + * This control is a dynamically sized 1-dimensional array,
> + * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
> + *
>   * @bit_size: size (in bits) of the current slice data
>   * @data_bit_offset: offset (in bits) to the video data in the current slice 
data
>   * @nal_unit_type: specifies the coding type of the slice (B, P or I)
> -- 
> 2.32.0
> 
> 


