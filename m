Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1233E4C4E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiBYTRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiBYTRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:17:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E04621CD26;
        Fri, 25 Feb 2022 11:16:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r10so5947055wrp.3;
        Fri, 25 Feb 2022 11:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Vvd7tKZQOnediXpXRzDG+ltIVQnv7bxEtfZI2RY0JA=;
        b=GFvpyfhpP4lZ6/NkJU6ikofdfk7gpO2WU29fa6dqlyWnlNJ6s6EOI/cQQuQqkYaXuK
         j2IksD5n5REA85yMe1g9chdlHAaeWZbXxgxt+54+LCtVNGKKR77r4KOleYJs3TUrMzgS
         KStr09G77anCiNEoGlM2AIwtaDMW1jBac/9QGQxNb9QILFZLEOVmkWJQiez98LKtIbQf
         vXc9+QOTTGnnGtkLJ5sIvaXWvaDR2Z1WwEP+nC4FjQ7CbPCm9VCQj4gBtZjISUfivUgT
         8VFh9SaYPLDC0nfkkeCpCgTwt9v/2HOjEihb6hPhp7HAT1dQrTHe+bKRU4msjSLzLxqa
         dPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Vvd7tKZQOnediXpXRzDG+ltIVQnv7bxEtfZI2RY0JA=;
        b=HoBM6w6SWw158iVp/4FxyNxqTy9pfE+PSkswBlpZveJeP8KAWM2YFLKwU53fYFuFI7
         vEEDx/2Tn1DlsJZLf4Apg8vL9BlC9UXV6u/NwmryXgF40n6oDjGljLrWtPWjWehJ4X6O
         jM7/Fji/VsbfYepgJEKbFUuJGIyB/a816XKN7l5/lz4cD6AmMtGPgUX6uCvrUgdqv6jl
         p0llvTX/BsiqENO0D3F9Piy77fshP+Sy8xitFxmYDbRfohguyaw7RKn3L5I4oyCNS5rH
         MK89ekgC1TMBk+lSbjEKLLHI/xDcO44deyGswWSRuz4H5bi+JIcoy036ifZOM79jJbYp
         D0SA==
X-Gm-Message-State: AOAM532YZgMgDAX03Z9Cfkf8nw/Z26Kvr9OQNLmaWScZgd1I6QLVJDy8
        7D21joyGEO0y3osfdhmLJrM=
X-Google-Smtp-Source: ABdhPJxZCUqPbir6SAi1fciYqMtPVQYBtApd/DUlx8j4DWD/xaEIUpojUNBQbHf+CMMYpq1j3zcvaw==
X-Received: by 2002:a5d:6da6:0:b0:1ea:75c7:77f0 with SMTP id u6-20020a5d6da6000000b001ea75c777f0mr7206509wrs.566.1645816600684;
        Fri, 25 Feb 2022 11:16:40 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id c4-20020adfed84000000b001e5b8d5b8dasm4430781wro.36.2022.02.25.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:16:40 -0800 (PST)
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
Subject: Re: [PATCH v3 12/14] media: uapi: Create a dedicated header for Hantro control
Date:   Fri, 25 Feb 2022 20:16:38 +0100
Message-ID: <2617680.mvXUDI8C0e@kista>
In-Reply-To: <20220225164600.1044663-13-benjamin.gaignard@collabora.com>
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com> <20220225164600.1044663-13-benjamin.gaignard@collabora.com>
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

Dne petek, 25. februar 2022 ob 17:45:58 CET je Benjamin Gaignard napisal(a):
> Hantro hardware needs a dedicated v4l2 control to perform HEVC
> decoding. Move it to a dedicated header file to prepare HEVC
> uAPI un-staging.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../userspace-api/media/drivers/hantro.rst    |  5 -----
>  drivers/staging/media/hantro/hantro_drv.c     |  1 +
>  include/media/hevc-ctrls.h                    | 13 -------------
>  include/uapi/linux/hantro-media.h             | 19 +++++++++++++++++++
>  include/uapi/linux/v4l2-controls.h            |  5 +++++
>  5 files changed, 25 insertions(+), 18 deletions(-)
>  create mode 100644 include/uapi/linux/hantro-media.h
> 
> diff --git a/Documentation/userspace-api/media/drivers/hantro.rst b/
Documentation/userspace-api/media/drivers/hantro.rst
> index cd9754b4e005..78dcd2a44a03 100644
> --- a/Documentation/userspace-api/media/drivers/hantro.rst
> +++ b/Documentation/userspace-api/media/drivers/hantro.rst
> @@ -12,8 +12,3 @@ The Hantro video decoder driver implements the following 
driver-specific control
>      to before syntax element "slice_temporal_mvp_enabled_flag".
>      If IDR, the skipped bits are just "pic_output_flag"
>      (separate_colour_plane_flag is not supported).
> -
> -.. note::
> -
> -        This control is not yet part of the public kernel API and
> -        it is expected to change.
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/
media/hantro/hantro_drv.c
> index 6f58c259d8fc..783a92a38c8e 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/hantro-media.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index cbf41d180fe9..f29298c8c2f8 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -443,17 +443,4 @@ struct v4l2_ctrl_hevc_scaling_matrix {
>  	__u8	scaling_list_dc_coef_32x32[2];
>  };
>  
> -/*  MPEG-class control IDs specific to the Hantro driver as defined by V4L2 
*/
> -#define V4L2_CID_CODEC_HANTRO_BASE				
(V4L2_CTRL_CLASS_CODEC | 0x1200)
> -/*
> - * V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP -
> - * the number of data (in bits) to skip in the
> - * slice segment header.
> - * If non-IDR, the bits to be skipped go from syntax element 
"pic_output_flag"
> - * to before syntax element "slice_temporal_mvp_enabled_flag".
> - * If IDR, the skipped bits are just "pic_output_flag"
> - * (separate_colour_plane_flag is not supported).
> - */
> -#define V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP	
(V4L2_CID_CODEC_HANTRO_BASE + 0)
> -
>  #endif
> diff --git a/include/uapi/linux/hantro-media.h b/include/uapi/linux/hantro-
media.h
> new file mode 100644
> index 000000000000..b4e7ab7e6452
> --- /dev/null
> +++ b/include/uapi/linux/hantro-media.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

I get
error: include/uapi/linux/hantro-media.h: missing "WITH Linux-syscall-note" 
for SPDX-License-Identifier
make[1]: *** [scripts/Makefile.headersinst:63: usr/include/linux/hantro-
media.h] Error 1

when installing headers.

Best regards,
Jernej

> +
> +#ifndef __UAPI_HANTRO_MEDIA_H__
> +#define __UAPI_HANTRO_MEDIA_H__
> +
> +#include <linux/v4l2-controls.h>
> +
> +/*
> + * V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP -
> + * the number of data (in bits) to skip in the
> + * slice segment header.
> + * If non-IDR, the bits to be skipped go from syntax element 
"pic_output_flag"
> + * to before syntax element "slice_temporal_mvp_enabled_flag".
> + * If IDR, the skipped bits are just "pic_output_flag"
> + * (separate_colour_plane_flag is not supported).
> + */
> +#define V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP	
(V4L2_CID_USER_HANTRO_BASE + 0)
> +
> +#endif /* __UAPI_HANTRO_MEDIA_H__ */
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-
controls.h
> index c8e0f84d204d..d56a1c7fb91d 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -218,6 +218,11 @@ enum v4l2_colorfx {
>   * We reserve 16 controls for this driver.
>   */
>  #define V4L2_CID_USER_ALLEGRO_BASE		(V4L2_CID_USER_BASE + 
0x1170)
> +/*
> + * The base for Hantro driver controls.
> + * We reserve 128 controls for this driver.
> + */
> +#define V4L2_CID_USER_HANTRO_BASE		(V4L2_CID_USER_BASE + 
0x1180)
>  
>  /* MPEG-class control IDs */
>  /* The MPEG controls are applicable to all codec controls
> -- 
> 2.32.0
> 
> 


