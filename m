Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C2577FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiGRKdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiGRKdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:33:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5FE1E3C2;
        Mon, 18 Jul 2022 03:33:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A4C4B6601A05;
        Mon, 18 Jul 2022 11:33:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658140416;
        bh=wFbi6UCGoTtmKBC9q/jLYRHp+xvE/2amm1VXtH0cozI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TbOuiDcvpKCaM6ZnCSsqJ+FLLEBIa0fc6RWySI8akBItP60L8kpUXsmislNoFazob
         6EjVk1CKKMsJjbA9O7nxOj3B/R/rh/xDNubTsbctYwbueVVWLhymswKvTez+B/9wQd
         HzA17mwLU5u8bTL0wOStfS7miiVjCPWymS1fOldqf+Hk+TxpWLgNw/S9RLalHXbOmj
         GxvFwOPKr6x1jzQxJ/dMgKMkkqn2vX09uTGWkndtLzGU1v1CGu1r9G5ZxK7htLAPo6
         zTcNQn0zbmzJqK2uN8WP5oRMLf1ZXnaMj/WRfIwXbsdpxtJ415/CeawBRrWdVvgQVd
         rzU4CFmOTcDAw==
Message-ID: <499968a2-fbc6-230d-2ed4-cac2b9a98a17@collabora.com>
Date:   Mon, 18 Jul 2022 12:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [V5,5/8] media: mtk-jpegdec: add jpeg decode worker interface
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        kyrie wu <kyrie.wu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com
References: <20220716093408.29734-1-irui.wang@mediatek.com>
 <20220716093408.29734-6-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220716093408.29734-6-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/07/22 11:34, Irui Wang ha scritto:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add jpeg decoding worker to ensure that three HWs
> run in parallel in MT8195.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> 
> ---
>   .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 172 ++++++++++++++++++
>   .../platform/mediatek/jpeg/mtk_jpeg_core.h    |   6 +
>   .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  |  39 ++--
>   3 files changed, 205 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index a9e8be976bb0..65b963ba0d6f 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1100,8 +1100,177 @@ static void mtk_jpeg_multicore_enc_device_run(void *priv)
>   	queue_work(jpeg->workqueue, &ctx->jpeg_work);
>   }
>   
> +static int mtk_jpegdec_get_hw(struct mtk_jpeg_ctx *ctx)
> +{
> +	struct mtk_jpegdec_comp_dev *comp_jpeg;
> +	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
> +	unsigned long flags;
> +	int hw_id = -1;
> +	int i;
> +
> +	spin_lock_irqsave(&jpeg->hw_lock, flags);
> +	for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++) {
> +		comp_jpeg = jpeg->dec_hw_dev[i];
> +		if (comp_jpeg->hw_state == MTK_JPEG_HW_IDLE) {
> +			hw_id = i;
> +			comp_jpeg->hw_state = MTK_JPEG_HW_BUSY;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
> +
> +	return hw_id;
> +}
> +
> +static int mtk_jpegdec_put_hw(struct mtk_jpeg_dev *jpeg, int hw_id)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&jpeg->hw_lock, flags);
> +	jpeg->dec_hw_dev[hw_id]->hw_state =
> +		MTK_JPEG_HW_IDLE;
> +	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int mtk_jpegdec_set_hw_param(struct mtk_jpeg_ctx *ctx,
> +				    int hw_id,
> +				    struct vb2_v4l2_buffer *src_buf,
> +				    struct vb2_v4l2_buffer *dst_buf)
> +{
> +	struct mtk_jpegdec_comp_dev *jpeg =
> +		ctx->jpeg->dec_hw_dev[hw_id];
> +
> +	jpeg->hw_param.curr_ctx = ctx;
> +	jpeg->hw_param.src_buffer = src_buf;
> +	jpeg->hw_param.dst_buffer = dst_buf;
> +
> +	return 0;
> +}
> +
> +static void mtk_jpegdec_worker(struct work_struct *work)
> +{
> +	struct mtk_jpeg_ctx *ctx = container_of(work, struct mtk_jpeg_ctx,
> +		jpeg_work);
> +	struct mtk_jpegdec_comp_dev *comp_jpeg[MTK_JPEGDEC_HW_MAX];
> +	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
> +	struct mtk_jpeg_src_buf *jpeg_src_buf, *jpeg_dst_buf;
> +	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> +	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
> +	int ret, i, hw_id = 0;
> +	struct mtk_jpeg_bs bs;
> +	struct mtk_jpeg_fb fb;
> +	unsigned long flags;
> +
> +	for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++)
> +		comp_jpeg[i] = jpeg->dec_hw_dev[i];
> +
> +retry_select:

Please ensure that we have a max retries limit to avoid an infinite loop.

> +	hw_id = mtk_jpegdec_get_hw(ctx);
> +	if (hw_id < 0) {
> +		ret = wait_event_interruptible_timeout(jpeg->dec_hw_wq,
> +						       atomic_read(&jpeg->dechw_rdy) > 0,
> +						       MTK_JPEG_HW_TIMEOUT_MSEC);
> +		if (ret != 0) {
> +			dev_err(jpeg->dev, "%s : %d, all HW are busy\n",
> +				__func__, __LINE__);
> +			v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> +			return;
> +		}
> + > +		goto retry_select;
> +	}
> +
> +	atomic_dec(&jpeg->dechw_rdy);
> +	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
> +	if (!src_buf)
> +		goto getbuf_fail;
> +
> +	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> +	if (!dst_buf)
> +		goto getbuf_fail;
> +
> +	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> +	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> +
> +	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
> +	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(&src_buf->vb2_buf);
> +	jpeg_dst_buf = mtk_jpeg_vb2_to_srcbuf(&dst_buf->vb2_buf);
> +
> +	if (mtk_jpeg_check_resolution_change(ctx,
> +					     &jpeg_src_buf->dec_param)) {
> +		mtk_jpeg_queue_src_chg_event(ctx);
> +		ctx->state = MTK_JPEG_SOURCE_CHANGE;
> +		goto dec_end;
> +	}
> +
> +	jpeg_src_buf->curr_ctx = ctx;
> +	jpeg_src_buf->frame_num = ctx->total_frame_num;
> +	jpeg_dst_buf->curr_ctx = ctx;
> +	jpeg_dst_buf->frame_num = ctx->total_frame_num;
> +	ctx->total_frame_num++;
> +
> +	mtk_jpegdec_set_hw_param(ctx, hw_id, src_buf, dst_buf);
> +	ret = pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
> +	if (ret < 0) {
> +		dev_err(jpeg->dev, "%s : %d, pm_runtime_get_sync fail !!!\n",
> +			__func__, __LINE__);
> +		goto dec_end;
> +	}
> +
> +	ret = clk_prepare_enable(comp_jpeg[hw_id]->jdec_clk.clks->clk);
> +	if (ret) {
> +		dev_err(jpeg->dev, "%s : %d, jpegdec clk_prepare_enable fail\n",
> +			__func__, __LINE__);
> +		goto clk_end;
> +	}
> +
> +	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
> +			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
> +
> +	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
> +	if (mtk_jpeg_set_dec_dst(ctx,
> +				 &jpeg_src_buf->dec_param,
> +				 &dst_buf->vb2_buf, &fb)) {
> +		dev_err(jpeg->dev, "%s : %d, mtk_jpeg_set_dec_dst fail\n",
> +			__func__, __LINE__);
> +		goto setdst_end;
> +	}
> +
> +	spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
> +	mtk_jpeg_dec_reset(comp_jpeg[hw_id]->reg_base);
> +	mtk_jpeg_dec_set_config(jpeg->reg_base,
> +				&jpeg_src_buf->dec_param,
> +				&bs,
> +				&fb);
> +	mtk_jpeg_dec_start(comp_jpeg[hw_id]->reg_base);
> +	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> +	spin_unlock_irqrestore(&comp_jpeg[hw_id]->hw_lock, flags);
> +
> +	return;
> +
> +setdst_end:
> +	clk_disable_unprepare(comp_jpeg[hw_id]->jdec_clk.clks->clk);
> +clk_end:
> +	pm_runtime_put(comp_jpeg[hw_id]->dev);
> +dec_end:
> +	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> +	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> +	v4l2_m2m_buf_done(src_buf, buf_state);
> +	v4l2_m2m_buf_done(dst_buf, buf_state);
> +getbuf_fail:
> +	atomic_inc(&jpeg->dechw_rdy);
> +	mtk_jpegdec_put_hw(jpeg, hw_id);
> +	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> +}
> +
>   static void mtk_jpeg_multicore_dec_device_run(void *priv)
>   {
> +	struct mtk_jpeg_ctx *ctx = priv;
> +	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
> +
> +	queue_work(jpeg->workqueue, &ctx->jpeg_work);


In the previous commit, I asked why this function was empty: I see you're
filling it in right now, so please add the MT8195 compatibles after this
commit, or later.

>   }
>   
>   static void mtk_jpeg_dec_device_run(void *priv)
> @@ -1377,6 +1546,9 @@ static int mtk_jpeg_open(struct file *file)
>   	if (jpeg->is_jpgenc_multihw)
>   		INIT_WORK(&ctx->jpeg_work, mtk_jpegenc_worker);
>   
> +	if (jpeg->is_jpgdec_multihw)
> +		INIT_WORK(&ctx->jpeg_work, mtk_jpegdec_worker);
> +
>   	INIT_LIST_HEAD(&ctx->dst_done_queue);
>   	spin_lock_init(&ctx->done_queue_lock);
>   	v4l2_fh_init(&ctx->fh, vfd);
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> index ddfe2b4c48b3..ef9a3e1fdf60 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> @@ -171,6 +171,9 @@ struct mtk_jpegdec_comp_dev {
>   	int jpegdec_irq;
>   	struct delayed_work job_timeout_work;
>   	struct mtk_jpeg_hw_param hw_param;
> +	enum mtk_jpeg_hw_state hw_state;
> +	//spinlock protecting the hw device resource

C-style comments please.

> +	spinlock_t hw_lock;
>   };
>   
>   /**

Regards,
Angelo

