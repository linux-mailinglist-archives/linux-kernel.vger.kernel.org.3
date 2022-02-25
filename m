Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEFA4C4ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiBYTa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiBYTa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:30:56 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE791D8A85;
        Fri, 25 Feb 2022 11:30:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j22so5911012wrb.13;
        Fri, 25 Feb 2022 11:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R8shBGs0xvbEf4vx5NZReydgFypsbc3de/+ZCzaiR2E=;
        b=VVM/8a75ABhkKmRJJIwhaXEvArZfMt3dvbS7CqOdKCBVVBt1qzeWi55V4ss0vRqr14
         aN2ImDbOdmMiXQvl4ARuc0DFlCWkS4tiFSWRTtFRCTDxZEj3+axfRiDLrurte3bpA79S
         hdTJxjaeQe/nZj9J559sPvQO/w3inwrDv9WV3hKmCkdyJ101fMXUJ/epCyMD7BeJCyAv
         zPC8KZVX5kmad7qLe1ovmClvmeqK/TtA+VIahV6l8wAEXdRKB6PIc9FvgBfF7AlELkBf
         OXs8mmok8IgvZKdlrNKXHu/l8wjxETL45m+Qqy+9JWkV5RNiI0YdjYE019N4DJRewquA
         kDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R8shBGs0xvbEf4vx5NZReydgFypsbc3de/+ZCzaiR2E=;
        b=5NGu1oIHH+hIchFgtIBii/SSPMGjoVrg8qBsgpzDtLeO/F54qNWJ2k4MGsY5S02Ybh
         pKKdTDMkUCbedX38YPm9bA7l1EW5YOnh6h5znS7QTrHWKltncc0QxsHCFfTG8na3/AlK
         wx3O6Sa6Ga6VeXBXebHAgX/+oAm4X3DLYqWBlJYFiTvKibX/Ft4SxmMc+piP71dIVP6B
         2bVFoVcCdsQfMgg8b4ojC8TSMGYwldVAW6nVHdbyDEWs0iXgjvQhDIxaXtWIkVVpNmts
         dK5D5BNm5YWog67hR2JWj8B74xvWKI+mFbx+Gd+njjHhATryAfBoRPw2fj4rkjC9czBs
         bJYQ==
X-Gm-Message-State: AOAM530PyTBosESnKvWdkD9/UTj9KDpkb66lcWIPXdE/raqbtkiDVvzk
        f2GwqeZ7pSM5yktMuNCPONE=
X-Google-Smtp-Source: ABdhPJzBJzujrOY+0fy4FstovGsWmv/slnYe1nePTYS/NXxZTWP+cPUiFaU7gMm22CSae8z2/Eet+g==
X-Received: by 2002:a5d:6241:0:b0:1ed:b534:e04e with SMTP id m1-20020a5d6241000000b001edb534e04emr7505916wrv.68.1645817422236;
        Fri, 25 Feb 2022 11:30:22 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c410500b0037bc3e4b526sm6591199wmi.7.2022.02.25.11.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:30:21 -0800 (PST)
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
Subject: Re: [PATCH v3 09/14] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
Date:   Fri, 25 Feb 2022 20:30:20 +0100
Message-ID: <4378293.LvFx2qVVIh@kista>
In-Reply-To: <20220225164600.1044663-10-benjamin.gaignard@collabora.com>
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com> <20220225164600.1044663-10-benjamin.gaignard@collabora.com>
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

Dne petek, 25. februar 2022 ob 17:45:55 CET je Benjamin Gaignard napisal(a):
> The number of 'entry point offset' could be very variable.
> Rather than use a large static array define a v4l2 dynamic array
> of integer control.

I suggest we should be more specific and say U32 (V4L2_CTRL_TYPE_U32).

> The number of entry point offsets is reported by the elems field.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../userspace-api/media/v4l/ext-ctrls-codec.rst          | 9 +++++++++
>  include/media/hevc-ctrls.h                               | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 44a268a948c0..71f7dc1c1ccd 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -3128,6 +3128,15 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>  
>      \normalsize
>  
> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``

Here you have OFFSETS (plural) ...

> +    Specifies the i-th entry point offset in bytes and is represented by
> +    offset_len_minus1 plus 1 bits.

You probably mean entry_point_offset_minus1? offset_len_minus1 just tells how 
much bits need to be read for each element and it's not important for actual 
decoding.

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
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index 3016c1abb1d0..3f8a67924df3 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -20,6 +20,7 @@
>  #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE + 
1012)
>  #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 
1015)
>  #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET (V4L2_CID_CODEC_BASE + 
1017)

... and here you have OFFSET (singlular). I suggest plural form to be used in 
all places, including subject line of this commit.

Additionally, it would be nice if control is initialized, like so:
https://github.com/jernejsk/linux-1/commit/
f938e162cd8dd77c9f6f1b248d80144840a37bce

Best regards,
Jernej

>  
>  /* enum v4l2_ctrl_type type values */
>  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> -- 
> 2.32.0
> 
> 


