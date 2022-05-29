Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8825553700F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiE2GqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiE2GqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:46:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A97ABF6B;
        Sat, 28 May 2022 23:46:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd25so9908734edb.3;
        Sat, 28 May 2022 23:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyInGOLt3LUJpHp1w3a8kuRatWQLVXNGEF7OJk8UZn0=;
        b=di3eI8nT4rPvpQgrvKCo66bQiJTim3pb4QXNUGyucu323KxX3NYom0PRf7MrWKouHG
         VqZ2Q8nF0Y7txXk/VgSPSLO1v0LT8MfR/0P5o0nsz+hKmQQg7YHxRHI7P2Wl+SHXbsbc
         Nj+iY0VHUByqaxSPSJbl+m5R/XNx09fl4o6uPr78SPO/GTJ4CGsAZLfPHczkVv2o3YL7
         oHpSUrbYRio8MviwsB0oZs6frEJUaH8m7BcA+4th8bJRjBMeuWZdiErrhxcbcMgYobPM
         QQVbgH6COeJs2/fTKuNQdYbK3XIPhXHju6TdHEHr7nb9+bcqwkWFtj4YWCHKejn3z+h9
         7/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyInGOLt3LUJpHp1w3a8kuRatWQLVXNGEF7OJk8UZn0=;
        b=rAi1GlDLW0ccoCJ6DxgQjb/CCBlPL+3EutQH5XoYlTNVyvFfmo1ECWH1HLUZoRUs26
         v0OXbthbtm8/na43aenUykLnGBJ0gFrj3Ppi2uLz0GMoEJcpdFKb8Oea5dy7W4EbM8tn
         +cVWKWnSTDqGJoqq5MvJzG/IcNtN5aGhHL5/N7F5+2YHJgvfKW+BBPYsouVVRLGJ68MX
         DDEEQHBRY0/BNXpb3PWy3BCBn0y3JJS8I8CSeO6nKc+N8jF8j8413R0IqmTAKFD4K09O
         h9IJ22iTQdszHkKQ/ywN4i5QAosW8D8GgoaeiRrwjI0YfwkQhH9dMCxF/ZZeyfzYtXwa
         fdxA==
X-Gm-Message-State: AOAM530dQEOmrjVRtJj1FoQppuFXEdfe79ArFLTJ0dRMjua1peXo0lxQ
        43Hviv2RzVYpddXviRa3m5A=
X-Google-Smtp-Source: ABdhPJyldPXrVrrzBiRnmkAs2y2y9lUTmwq32apd8VNmd2DLFYdkooavc52iMINHQhCFYZZ4c0DZrA==
X-Received: by 2002:aa7:c79a:0:b0:42a:762e:769c with SMTP id n26-20020aa7c79a000000b0042a762e769cmr52595235eds.155.1653806759075;
        Sat, 28 May 2022 23:45:59 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906590d00b006f3ef214db3sm2967222ejq.25.2022.05.28.23.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 23:45:58 -0700 (PDT)
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
Subject: Re: [PATCH v6 16/17] media: uapi: Change data_bit_offset definition
Date:   Sun, 29 May 2022 08:45:57 +0200
Message-ID: <3175529.44csPzL39Z@kista>
In-Reply-To: <20220527143134.3360174-17-benjamin.gaignard@collabora.com>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com> <20220527143134.3360174-17-benjamin.gaignard@collabora.com>
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

Dne petek, 27. maj 2022 ob 16:31:33 CEST je Benjamin Gaignard napisal(a):
> 'F.7.3.6.1 General slice segment header syntax' section of HEVC
> specification describes that a slice header always end aligned on
> byte boundary, therefore we only need to provide the data offset in bytes.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 4 ++--
>  drivers/staging/media/sunxi/cedrus/cedrus_h265.c          | 2 +-
>  include/media/hevc-ctrls.h                                | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 48a8825a001b..37079581c661 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -3008,8 +3008,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>        - ``bit_size``
>        - Size (in bits) of the current slice data.
>      * - __u32
> -      - ``data_bit_offset``
> -      - Offset (in bits) to the video data in the current slice data.
> +      - ``data_byte_offset``
> +      - Offset (in bytes) to the video data in the current slice data.
>      * - __u32
>        - ``num_entry_point_offsets``
>        - Specifies the number of entry point offset syntax elements in the 
slice header.
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/
staging/media/sunxi/cedrus/cedrus_h265.c
> index 411601975124..835454239f73 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -405,7 +405,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>  	/* Initialize bitstream access. */
>  	cedrus_write(dev, VE_DEC_H265_TRIGGER, 
VE_DEC_H265_TRIGGER_INIT_SWDEC);
>  
> -	cedrus_h265_skip_bits(dev, slice_params->data_bit_offset);
> +	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8);

While it's true that actual data starts on 8-bit aligned address, Cedrus for 
some reason needs offset which points at the end of the header, before 
alignment. There is very simple way to determine that, but unfortunately this 
means reading source buffer.

In short, above code won't work. I'll provide a fix.

Best regards,
Jernej

>  
>  	/* Bitstream parameters. */
>  
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index 9abca1a75bd4..936ff693967b 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -312,7 +312,7 @@ struct v4l2_hevc_pred_weight_table {
>   * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>   *
>   * @bit_size: size (in bits) of the current slice data
> - * @data_bit_offset: offset (in bits) to the video data in the current slice 
data
> + * @data_byte_offset: offset (in bytes) to the video data in the current 
slice data
>   * @num_entry_point_offsets: specifies the number of entry point offset syntax
>   *			     elements in the slice header.
>   * @nal_unit_type: specifies the coding type of the slice (B, P or I)
> @@ -356,7 +356,7 @@ struct v4l2_hevc_pred_weight_table {
>   */
>  struct v4l2_ctrl_hevc_slice_params {
>  	__u32	bit_size;
> -	__u32	data_bit_offset;
> +	__u32	data_byte_offset;
>  	__u32	num_entry_point_offsets;
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>  	__u8	nal_unit_type;
> -- 
> 2.32.0
> 
> 


