Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB856739D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiGEP5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiGEP5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:57:04 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559831104
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:57:03 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k2so2726603vsc.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xXIsY10ET5FEFKF3G4OcJ3/8ndHHuqSid2cjX5joZmQ=;
        b=g1x7BaAqhd6x69R/k1BZRf3X+y+rS2pLS3Hwradlnj6HjaeZBVkqyV/UhXkxXHNBDK
         BSWAJt7ZO4vCviL8WEz8uksKu+U8a44ETRuKO4M7/wE3DvGune9KzB4Fog5S9g5Len1O
         7jcChHzfNb4JK/II8sYqRDFEd0dIIPa0EPMSJ3OFP+9AMNIzHscoAeiAbCblPuAg0Tao
         ZxdTlU2veZmst8rxCXVe1q6Uy4fuRp45+l58biA3zD3wWJcK/lZB5c8hU+je4S2yDjMg
         nAlcf8W9LXWIN2Y0izBO4AvM5aCTOmnHSc+63vPYh2AxYn5C+kC+k3Yb/m8xQ3gVlkgf
         ObhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xXIsY10ET5FEFKF3G4OcJ3/8ndHHuqSid2cjX5joZmQ=;
        b=Q1C/fQvtsZUYF6T5ygV2BBhiZse+1hTOgWSuguKlHgxl/aj2Yu23MCCJoDqFTSCVRQ
         LyOUsAoOFO5rdzJyUsf3n/XI8dPXV/a2qWV8qgjaiBapY5WYoBekYarFbNmgSnyC7BL2
         gY/VODWof2Fmiev0tS6Ucp05bYOxyu+GPxL8CoabMZg6anDWRBqKKoHHMKAPZnO/Ysn+
         gAUGFpbCEwv/A7hBDmCNBIMUYJEbv4TD+C88ciVEw2CTffhpcTkb4ilfUk76TT23euFT
         759wblHgeDD2aT2yX9+/YB2DuCAm+XWXgHVAc98Wxo3d7WH8hqxu3uzvHjs6uqVkgcRx
         b6wQ==
X-Gm-Message-State: AJIora/jBqBW6dMJN9TCpsdtd1ZWS6aKabv0m4LvcbDY4YdRNAhIflCR
        TbL9dwHbJoOiI3DiO3nIFOMXjQ==
X-Google-Smtp-Source: AGRyM1ufhZVvPzEYcoGlVRXFPjqlcb43XSTMh3ipZHif1NpbOZf720bwsHvctl6L+waGLOv+uW9jSg==
X-Received: by 2002:a05:6102:2742:b0:354:4bde:c8ed with SMTP id p2-20020a056102274200b003544bdec8edmr18831541vsu.78.1657036620966;
        Tue, 05 Jul 2022 08:57:00 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id a126-20020a1f9884000000b00371cb939c99sm3642078vke.32.2022.07.05.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 08:57:00 -0700 (PDT)
Date:   Tue, 5 Jul 2022 12:56:54 -0300
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
Subject: Re: [PATCH v10 16/17] media: uapi: Change data_bit_offset definition
Message-ID: <YsRfRlQxSw0624mP@eze-laptop>
References: <20220705085420.272912-1-benjamin.gaignard@collabora.com>
 <20220705085420.272912-17-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705085420.272912-17-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 10:54:19AM +0200, Benjamin Gaignard wrote:
> 'F.7.3.6.1 General slice segment header syntax' section of HEVC
> specification describes that a slice header always end aligned on
> byte boundary, therefore we only need to provide the data offset in bytes.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Makes sense and it matches what other CODEC ABIs.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel

> ---
>  .../media/v4l/ext-ctrls-codec.rst             |  4 ++--
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 19 ++++++++++++++++++-
>  .../staging/media/sunxi/cedrus/cedrus_video.c |  1 -
>  include/media/hevc-ctrls.h                    |  4 ++--
>  4 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 889e2bcffde6..af5cb4e4ef73 100644
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
>        - Specifies the number of entry point offset syntax elements in the slice header.
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> index 411601975124..7b67cb4621cf 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -317,6 +317,8 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>  	u32 chroma_log2_weight_denom;
>  	u32 output_pic_list_index;
>  	u32 pic_order_cnt[2];
> +	u8 *padding;
> +	int count;
>  	u32 reg;
>  
>  	sps = run->h265.sps;
> @@ -405,7 +407,22 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>  	/* Initialize bitstream access. */
>  	cedrus_write(dev, VE_DEC_H265_TRIGGER, VE_DEC_H265_TRIGGER_INIT_SWDEC);
>  
> -	cedrus_h265_skip_bits(dev, slice_params->data_bit_offset);
> +	/*
> +	 * Cedrus expects that bitstream pointer is actually at the end of the slice header
> +	 * instead of start of slice data. Padding is 8 bits at most (one bit set to 1 and
> +	 * at most seven bits set to 0), so we have to inspect only one byte before slice data.
> +	 */
> +	padding = (u8 *)vb2_plane_vaddr(&run->src->vb2_buf, 0) +
> +		slice_params->data_byte_offset - 1;
> +
> +	for (count = 0; count < 8; count++)
> +		if (*padding & (1 << count))
> +			break;
> +
> +	/* Include the one bit. */
> +	count++;
> +
> +	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8 - count);
>  
>  	/* Bitstream parameters. */
>  
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> index 33726175d980..66714609b577 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> @@ -568,7 +568,6 @@ int cedrus_queue_init(void *priv, struct vb2_queue *src_vq,
>  
>  	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
>  	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> -	src_vq->dma_attrs = DMA_ATTR_NO_KERNEL_MAPPING;
>  	src_vq->drv_priv = ctx;
>  	src_vq->buf_struct_size = sizeof(struct cedrus_buffer);
>  	src_vq->ops = &cedrus_qops;
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index 7358cbfc3e4d..c89029b3c5da 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -310,7 +310,7 @@ struct v4l2_hevc_pred_weight_table {
>   * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>   *
>   * @bit_size: size (in bits) of the current slice data
> - * @data_bit_offset: offset (in bits) to the video data in the current slice data
> + * @data_byte_offset: offset (in bytes) to the video data in the current slice data
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
