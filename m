Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA14F6CB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiDFVbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbiDFVbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:31:21 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497B6286A63
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:36:26 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id f3so3219933qvz.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=iVD51S2fZB/T43/yzpgAein+LxkO4Y3OqFseZyJMNZY=;
        b=wIJ8NfE+AUWtM7lH+STs2g9OB2TaiQtjIGgsEZBrh+stbAhC7caz0JwPUkoIZGBlrs
         LB1DrPwrXYi0rIY7X35P/zoqWV7fHvjo7aRUMs4TyMz6S/vFUghNVJsR3/tEqYaWbeIS
         SpSzxsCOvUNm/1PF0AI/mVEvKzQZuddwJpTN/xCCPEwtKXsE8pXWY9SDXnRGt7hd+v5d
         7aVh+a6lRIdvCCaTyTO3bvNDQa8edsj39IO4UFF22UDLrQkDlAZSf+4U3HgEfZo+IVo2
         A/ZuTqF9mp4LAlL/TjngKMj4c7waWzoSFDpDwXInm8b9twE/3nTPedXH8SU6BjtHTO0m
         X7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=iVD51S2fZB/T43/yzpgAein+LxkO4Y3OqFseZyJMNZY=;
        b=p6QBS2ZlYwo+KPYeM4DfSK9QgMh+gg4pbF8AhRs1f8G4rTLJNDqEI5c/K2sD3+hiCL
         f/Oi7GaQdfA6THMUBtLJrIqYblU7qTEQIeOFZnLJ9CUs16Mi6b+ZNA0HM7Ewcf2s0h19
         dAkOSniEGzILJLNYBjC502ZThwtYi33Tef/jygfO6qVPV81YtctII9a29P0c45Nlfi6F
         dfNOTgXX+BDcUGPwOUvSXcoAcLACl6FwFtJ6W3x3afVDhRJKmU3BL5Az399skft5sq83
         qfyTsE9oDGy/l50y+6mhWKIgM2LfSRQX/VE7TYtsjhOc2zRurHl+iLGzdHbwTLjB/9io
         TEEw==
X-Gm-Message-State: AOAM531l5VQdWpTxJLDQTOkfyqHlsxod5HP+atTv71Jd7OZXKzVHrlxQ
        8KI6uVEtYlNA4TF8M2QI68wRtA==
X-Google-Smtp-Source: ABdhPJyoTFpHdhAeiRuppAcSOH9NzY3ELjSpzTBbQkgV2JktrDoVuHlUfQFgR+UzclY5mKXxVmknUQ==
X-Received: by 2002:a05:6214:508a:b0:440:f824:3d55 with SMTP id kk10-20020a056214508a00b00440f8243d55mr9112081qvb.26.1649277385279;
        Wed, 06 Apr 2022 13:36:25 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id e15-20020a05622a110f00b002e1ed105652sm12804883qty.2.2022.04.06.13.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 13:36:24 -0700 (PDT)
Message-ID: <ace60e1553ca73997f454ccea12c4540cddd3dc8.camel@ndufresne.ca>
Subject: Re: [PATCH v4 14/15] media: uapi: Change data_bit_offset definition
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk
Date:   Wed, 06 Apr 2022 16:36:17 -0400
In-Reply-To: <20220228140838.622021-15-benjamin.gaignard@collabora.com>
References: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
         <20220228140838.622021-15-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 28 f=C3=A9vrier 2022 =C3=A0 15:08 +0100, Benjamin Gaignard a =C3=
=A9crit=C2=A0:
> 'F.7.3.6.1 General slice segment header syntax' section of HEVC
> specification describes that a slice header always end byte aligned,
> therefore we only need to provide the data offset in byte.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 4 ++--
>  drivers/staging/media/sunxi/cedrus/cedrus_h265.c          | 2 +-
>  include/media/hevc-ctrls.h                                | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/=
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 1aa2a7399e76..c8602c1e706e 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2986,8 +2986,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>        - ``bit_size``
>        - Size (in bits) of the current slice data.
>      * - __u32
> -      - ``data_bit_offset``
> -      - Offset (in bits) to the video data in the current slice data.
> +      - ``data_byte_offset``
> +      - Offset (in bytes) to the video data in the current slice data.
>      * - __u32
>        - ``num_entry_point_offsets``
>        - Specifies the number of entry point offset syntax elements in th=
e slice header.
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h265.c
> index 8ab2d9c6f048..3e43b7cc2f57 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -405,7 +405,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>  	/* Initialize bitstream access. */
>  	cedrus_write(dev, VE_DEC_H265_TRIGGER, VE_DEC_H265_TRIGGER_INIT_SWDEC);
> =20
> -	cedrus_h265_skip_bits(dev, slice_params->data_bit_offset);
> +	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset / 8);

Did you mean the following instead ?

+	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8);

> =20
>  	/* Bitstream parameters. */
> =20
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index c50205083573..51bdf38ea0c3 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -296,7 +296,7 @@ struct v4l2_hevc_pred_weight_table {
>   * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>   *
>   * @bit_size: size (in bits) of the current slice data
> - * @data_bit_offset: offset (in bits) to the video data in the current s=
lice data
> + * @data_byte_offset: offset (in bytes) to the video data in the current=
 slice data
>   * @num_entry_point_offsets: specifies the number of entry point offset =
syntax
>   *			     elements in the slice header.
>   * @nal_unit_type: specifies the coding type of the slice (B, P or I)
> @@ -340,7 +340,7 @@ struct v4l2_hevc_pred_weight_table {
>   */
>  struct v4l2_ctrl_hevc_slice_params {
>  	__u32	bit_size;
> -	__u32	data_bit_offset;
> +	__u32	data_byte_offset;
>  	__u32	num_entry_point_offsets;
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>  	__u8	nal_unit_type;

