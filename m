Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71E6560A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiF2TO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiF2TOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:14:49 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BFE3CA5D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:14:46 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id q18-20020a9d7c92000000b00616b27cda7cso11287785otn.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eRvm4rDKmcEwBbyuwqdiLOYlQxia+jN6V897QRefdLU=;
        b=L4InWoTsn6Ktys0sawYAPemhPMW/VXMH5wMvdPN/pkmSDn9hNd7667tes6wDEswIyP
         APqL7zS9gB4bGUDGZJ4BTHZjwb24nmkF77U9ur/1eAmk3ka4AV6Akj8p7P8nayFiIQNj
         +fYNFjAl6TgVnSN0TFfMd6aNcukgKZHrtFZylwK9uTS+Swc1wkr56lRppUhpgv9yBlzz
         A03B+r2BtlQEzo9LQ3T/Gq9YDZvxTQ5+yGJkL9lmgueicuJvP2HO9PODecXYsmbsM63l
         GFfuHqyNm/3kmoJiyjrgupP6mhAWMJ760UTt0uVgaPcJSEPqbSTnn+4jk6hQcL74A1HM
         qVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eRvm4rDKmcEwBbyuwqdiLOYlQxia+jN6V897QRefdLU=;
        b=Ah9nUDLymfCuun2By7+LP3XxuyrUQUTKYTsqpQK19CmLHWA8aZic3BgATXWZPTKicK
         d/tG/qoW+HGQWCp/ZOJFHHV7zsB6Z0eHkm7h830u1dtRMMCHy37EqsMpt6R8lxcV65an
         9Wa8r5H3BP29MVi9L7LjThBKjwiIF1JVA87KErvaWHZabayah4IhUl3yrdPm8n0b5e4l
         zqyWAGLUHMEUqWEXYhxBnkNqKu5xkGhpRdh88ftfeKdIYoQ4ey4okB6T/KWkQ/Hvr8us
         DSn5fLFOyNSfX7wl7a3AhvBOiG/ty8gQudAzb2BPEJ/qZJHnz99cdoxJCHxd/KahXdSn
         0nNA==
X-Gm-Message-State: AJIora+pPW5QRRiWDKzgYavjlHnKXz4wVG6t22cKuF93QXl4oCRM0P3F
        Ih61Opo4ClCXoDaOeVRUkK8Erg==
X-Google-Smtp-Source: AGRyM1szpNbg71NbMlEOjlyo2a2vZG7dvYgtoZ+JqfGK1PvPW4R6BGZcZ87hUHjQLSpaX5EOLTHiCg==
X-Received: by 2002:a9d:bf6:0:b0:616:d0fe:8b7b with SMTP id 109-20020a9d0bf6000000b00616d0fe8b7bmr2248941oth.19.1656530086223;
        Wed, 29 Jun 2022 12:14:46 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id z23-20020a544597000000b003342a70fd59sm8874989oib.10.2022.06.29.12.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:14:45 -0700 (PDT)
Date:   Wed, 29 Jun 2022 16:14:40 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
        nicolas.dufresne@collabora.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 5/7] media: hantro: postproc: Properly calculate
 chroma offset
Message-ID: <YrykoFpa5RvZV60V@eze-laptop>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
 <20220616202513.351039-6-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616202513.351039-6-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Thu, Jun 16, 2022 at 10:25:11PM +0200, Jernej Skrabec wrote:
> Currently chroma offset calculation assumes only 1 byte per luma, with
> no consideration for stride.
> 
> Take necessary information from destination pixel format which makes
> calculation completely universal.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel

> ---
>  drivers/staging/media/hantro/hantro_postproc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_postproc.c b/drivers/staging/media/hantro/hantro_postproc.c
> index 8933b4af73ed..a0928c508434 100644
> --- a/drivers/staging/media/hantro/hantro_postproc.c
> +++ b/drivers/staging/media/hantro/hantro_postproc.c
> @@ -113,12 +113,14 @@ static void hantro_postproc_g2_enable(struct hantro_ctx *ctx)
>  {
>  	struct hantro_dev *vpu = ctx->dev;
>  	struct vb2_v4l2_buffer *dst_buf;
> -	size_t chroma_offset = ctx->dst_fmt.width * ctx->dst_fmt.height;
>  	int down_scale = down_scale_factor(ctx);
> +	size_t chroma_offset;
>  	dma_addr_t dst_dma;
>  
>  	dst_buf = hantro_get_dst_buf(ctx);
>  	dst_dma = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
> +	chroma_offset = ctx->dst_fmt.plane_fmt[0].bytesperline *
> +			ctx->dst_fmt.height;
>  
>  	if (down_scale) {
>  		hantro_reg_write(vpu, &g2_down_scale_e, 1);
> -- 
> 2.36.1
> 
