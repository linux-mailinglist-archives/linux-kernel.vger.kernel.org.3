Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1804C4677DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352141AbhLCNOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbhLCNOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:14:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE425C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:11:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y13so11167413edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 05:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ABl0NtQNaMGaQ7u4z+8cjzybRMFdvc0PrfMVxIShPwM=;
        b=M7I3rJ/rQcixRj353yYPU1q/z/if4icwPYrGYLp/Sqqb4IfDr1Mv6Nl/eTkTEFBz0b
         q4Zr9iS4JEThqS8u4LeNIFPPhd7jNFKNTAajlplzamu0CuwuLsUSLYzsJE/25U/V7TfK
         yY7gSBPHJfT1m60VLh7uSmjRdm6hEACA37UH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ABl0NtQNaMGaQ7u4z+8cjzybRMFdvc0PrfMVxIShPwM=;
        b=TFgtWDr2pH90WYqkwNnfGMFGnXxzRuhb7GLk73CR0YrMbWzYzyerHK4gew4Mjgib/p
         o3NF2p1Z4k17aXScuGjuq6TS1VwHPhiTrjICsXQRSzXnLzLHfhnekx+P1TIdcD/pUAiZ
         AG/9a1DNtgmZq9gt3shg9yyz5t+RfMlGRTRUY6ziKLFRJoMmYjoaKhx8TM0qbb4rSIpO
         eyV+e3TJdw57oB0fEyZ/podfM2AEx40RKY0EfKYM25EEiDJ8mjaRXeB7Ba+trGyGZkGV
         68C6Zi9NgmOaX0TXeggJ2lABMYOeBmaH93nU3oSnb1KpVmgLIxS7j+cZmulUaXHsSdd5
         Wv3w==
X-Gm-Message-State: AOAM533n/6V83cLqvxqpG3KPrmenxD1UDPpIPOUOjcKgzoY2TRRoElTD
        hJUSjHMQXI/ZAxtmiCFfC/7LlQ==
X-Google-Smtp-Source: ABdhPJzSmlmWvbiEmXEPSA7O+FJ1Awnby9k+OXFzA8WIIrrbPxAAvYhKN7AQdDaD+EPzmlPP3kEnjg==
X-Received: by 2002:a17:907:3f9d:: with SMTP id hr29mr24089850ejc.369.1638537087469;
        Fri, 03 Dec 2021 05:11:27 -0800 (PST)
Received: from gmail.com ([100.104.168.197])
        by smtp.gmail.com with ESMTPSA id og14sm1907799ejc.107.2021.12.03.05.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:11:27 -0800 (PST)
Date:   Fri, 3 Dec 2021 14:11:20 +0100
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     "kyrie.wu" <kyrie.wu@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com,
        irui.wang@mediatek.com
Subject: Re: [PATCH V1, 5/6] media: mtk-jpegdec: add output pic reorder
 interface
Message-ID: <YaoXeLgK30MKKT+S@gmail.com>
References: <1638509655-14296-1-git-send-email-kyrie.wu@mediatek.com>
 <1638509655-14296-6-git-send-email-kyrie.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638509655-14296-6-git-send-email-kyrie.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kyrie.wu wrote:

> add output reorder func to reorder the output images
> to ensure the output pic is consistent with the input images.
> 
> Signed-off-by: kyrie.wu <kyrie.wu@mediatek.com>
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c | 50 +++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c
> index 9138ecb..fad5bf1c 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c
> @@ -443,6 +443,49 @@ void mtk_jpeg_dec_set_config(void __iomem *base,
>  	mtk_jpeg_dec_set_pause_mcu_idx(base, config->total_mcu);
>  }
>  
> +void mtk_jpegdec_put_buf(struct mtk_jpegdec_comp_dev *jpeg)
> +{
> +	struct mtk_jpeg_src_buf *dst_done_buf, *tmp_dst_done_buf;
> +	struct vb2_v4l2_buffer *dst_buffer;
> +	struct list_head *temp_entry;
> +	struct list_head *pos = NULL;
> +	struct mtk_jpeg_ctx *ctx;
> +	unsigned long flags;
> +
> +	ctx = jpeg->hw_param.curr_ctx;
> +	if (!ctx) {
> +		dev_err(jpeg->dev, "comp_jpeg ctx fail !!!\n");
> +		return;
> +	}
> +
> +	dst_buffer = jpeg->hw_param.dst_buffer;
> +	if (!dst_buffer) {
> +		dev_err(jpeg->dev, "comp_jpeg dst_buffer fail !!!\n");
> +		return;
> +	}
> +
> +	dst_done_buf = container_of(dst_buffer, struct mtk_jpeg_src_buf, b);
> +
> +	spin_lock_irqsave(&ctx->done_queue_lock, flags);
> +	list_add_tail(&dst_done_buf->list, &ctx->dst_done_queue);
> +	while (!list_empty(&ctx->dst_done_queue) &&
> +		(pos != &ctx->dst_done_queue)) {
> +		list_for_each_prev_safe(pos, temp_entry,
> +			(&ctx->dst_done_queue)) {
> +			tmp_dst_done_buf = list_entry(pos,
> +				struct mtk_jpeg_src_buf, list);
> +			if (tmp_dst_done_buf->frame_num ==
> +				ctx->last_done_frame_num) {
> +				list_del(&tmp_dst_done_buf->list);
> +				v4l2_m2m_buf_done(&tmp_dst_done_buf->b,
> +					VB2_BUF_STATE_DONE);
> +				ctx->last_done_frame_num++;
> +			}
> +		}
> +	}
> +	spin_unlock_irqrestore(&ctx->done_queue_lock, flags);
> +}
> +
>  static void mtk_jpegdec_timeout_work(struct work_struct *work)
>  {
>  	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
> @@ -450,10 +493,9 @@ static void mtk_jpegdec_timeout_work(struct work_struct *work)
>  		container_of(work, struct mtk_jpegdec_comp_dev,
>  		job_timeout_work.work);
>  	struct mtk_jpeg_dev *master_jpeg = cjpeg->master_dev;
> -	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> +	struct vb2_v4l2_buffer *src_buf;
>  
>  	src_buf = cjpeg->hw_param.src_buffer;
> -	dst_buf = cjpeg->hw_param.dst_buffer;
>  
>  	mtk_jpeg_dec_reset(cjpeg->reg_base);
>  	clk_disable_unprepare(cjpeg->pm.dec_clk.clk_info->jpegdec_clk);
> @@ -462,7 +504,7 @@ static void mtk_jpegdec_timeout_work(struct work_struct *work)
>  	atomic_inc(&cjpeg->hw_rdy);
>  	wake_up(&master_jpeg->dec_hw_wq);
>  	v4l2_m2m_buf_done(src_buf, buf_state);
> -	v4l2_m2m_buf_done(dst_buf, buf_state);
> +	mtk_jpegdec_put_buf(cjpeg);
>  }
>  
>  int mtk_jpegdec_init_pm(struct mtk_jpegdec_comp_dev *mtkdev)
> @@ -559,7 +601,7 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
>  
>  dec_end:
>  	v4l2_m2m_buf_done(src_buf, buf_state);
> -	v4l2_m2m_buf_done(dst_buf, buf_state);
> +	mtk_jpegdec_put_buf(jpeg);
>  	v4l2_m2m_job_finish(master_jpeg->m2m_dev, ctx->fh.m2m_ctx);
>  	clk_disable_unprepare(jpeg->pm.dec_clk.clk_info->jpegdec_clk);
>  	pm_runtime_put(ctx->jpeg->dev);
> -- 
> 2.6.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
