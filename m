Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1B4463175
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbhK3KsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:48:08 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51724 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhK3Kr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:47:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id F3DCD1F41ACB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638269076; bh=eSZ7o7VCNGc2NKwSgiEknvg/3h8O8PDXcvqISABo3Fo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d4F1kAdHZMOAjYBeeRqQM+fMTL9El5GpwjSbdxWLLsMovm4vN8AUrSTy+ajxiZakl
         wIMNFYF+3eEyuW0+O9FVp06//cayGZTu5qV9YW9AtkZYFBhNgCJdHVgNDfo6P3wnX9
         GlR+q+uPg//Fd/vdjW76UfRYghHMUwKCoagnWRofOhfEZTkPcnv4kXbZlz2LuOfG11
         EWEH1dNb8ERjg/aU0d8zlntuFk0PS2C1ZJA4awDJE9ipxJOdSU3acav80F/gRZ2hnI
         /0115lazhGh7r8YfSSOfcozMDfNZSoSYqLtNeHKofhnIO+lJ6SS5DXwe2Vgn3B8/pj
         LyCJl/ar0FQbw==
Subject: Re: [PATCH v2 5/9] media: hantro: move postproc enablement for old
 cores
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
 <20211129182633.480021-6-jernej.skrabec@gmail.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <5e21d81b-15a7-08e9-1c8c-7d626ffa1506@collabora.com>
Date:   Tue, 30 Nov 2021 11:44:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129182633.480021-6-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

W dniu 29.11.2021 o 19:26, Jernej Skrabec pisze:
> Older G2 cores, like that in Allwinner H6, seem to have issue with
> latching postproc register values if this is first thing done in job.
> Moving that to the end solves the issue.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   drivers/staging/media/hantro/hantro.h     | 2 ++
>   drivers/staging/media/hantro/hantro_drv.c | 9 ++++++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
> index 83ed25d9657b..06d0f3597694 100644
> --- a/drivers/staging/media/hantro/hantro.h
> +++ b/drivers/staging/media/hantro/hantro.h
> @@ -75,6 +75,7 @@ struct hantro_irq {
>    * @num_regs:			number of register range names in the array
>    * @double_buffer:		core needs double buffering
>    * @legacy_regs:		core uses legacy register set
> + * @late_postproc:		postproc must be set up at the end of the job
>    */
>   struct hantro_variant {
>   	unsigned int enc_offset;
> @@ -98,6 +99,7 @@ struct hantro_variant {
>   	int num_regs;
>   	unsigned int double_buffer : 1;
>   	unsigned int legacy_regs : 1;
> +	unsigned int late_postproc : 1;
>   };
>   
>   /**
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 770f4ce71d29..33bf78be145b 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -130,7 +130,7 @@ void hantro_start_prepare_run(struct hantro_ctx *ctx)
>   	v4l2_ctrl_request_setup(src_buf->vb2_buf.req_obj.req,
>   				&ctx->ctrl_handler);
>   
> -	if (!ctx->is_encoder) {
> +	if (!ctx->is_encoder && !ctx->dev->variant->late_postproc) {
>   		if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
>   			hantro_postproc_enable(ctx);
>   		else
> @@ -142,6 +142,13 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
>   {
>   	struct vb2_v4l2_buffer *src_buf;
>   
> +	if (!ctx->is_encoder && ctx->dev->variant->late_postproc) {
> +		if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
> +			hantro_postproc_enable(ctx);
> +		else
> +			hantro_postproc_disable(ctx);
> +	}
> +
>   	src_buf = hantro_get_src_buf(ctx);
>   	v4l2_ctrl_request_complete(src_buf->vb2_buf.req_obj.req,
>   				   &ctx->ctrl_handler);
> 

