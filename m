Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D893566FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiGENwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiGENvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:51:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68D62409E;
        Tue,  5 Jul 2022 06:27:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8170666017ED;
        Tue,  5 Jul 2022 14:27:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657027652;
        bh=vDhEJ8ApSm2fbd/zRQ38k05MovsI47d+ny5h9+TH8ps=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A1wVu48M22VMXZ5wrcOcSBZFhen6vYOFqleTeCKMzxm3eDX+k0xZRLP24SQl1lfZ5
         zrPs/66k3vM2pV3UShJ5vUjcOb+mIfQY+bf1Mqobk9KGmyBM/LvBU+vDeVuZU9kc4Y
         ND2GIWLZyqNgwOovrHvmOZXKsNZTeR8naYrkROy2zAQLVVBelr6pitLTPWYENsrFRg
         t5uPvAo6PupyxqZoRwt6CA+jBbTpvPXkU9YAYt+WxVErhYzrbXbSkjXvoqCd+gfp/U
         BboDegFpIVEV5GuKIkFgMeZV7FvZgx0EC94HfmSFZT5q4nfUc9q1Uf9q3YZlFdesPz
         KM5pwp+asJFMA==
Message-ID: <46eaafc0-478e-8a74-cf8b-dd1f236df035@collabora.com>
Date:   Tue, 5 Jul 2022 15:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V10,5/7] mtk-jpegenc: add jpeg encode worker interface
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        nicolas.dufresne@collabora.com, wenst@chromium.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, kyrie wu <kyrie.wu@mediatek.com>,
        srv_heupstream@mediatek.com
References: <20220627025625.8956-1-irui.wang@mediatek.com>
 <20220627025625.8956-6-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220627025625.8956-6-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/06/22 04:56, Irui Wang ha scritto:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add jpeg encoding worker to ensure that two HWs
> run in parallel in MT8195.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>   .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 208 ++++++++++++++++--
>   .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  30 ++-
>   .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  |  39 +++-
>   3 files changed, 240 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 0c5c85a112ca..544673a527a0 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c

..snip..

> @@ -946,9 +1050,58 @@ static void mtk_jpeg_enc_device_run(void *priv)
>   	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
>   	v4l2_m2m_buf_done(src_buf, buf_state);
>   	v4l2_m2m_buf_done(dst_buf, buf_state);
> +getbuf_fail:
> +	atomic_inc(&jpeg->enchw_rdy);
> +	mtk_jpegenc_put_hw(jpeg, hw_id);
>   	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
>   }
>   
> +static void mtk_jpeg_enc_device_run(void *priv)
> +{

That's not really the best thing to do here... if we're managing multi-core
hardware, this function would be a one-liner and we would never see variable
jpeg->is_jpgenc_multihw changing during runtime.

At this point, we can reduce checks and improve human readability by simply
having two separated functions for single-core vs multi-core...

static void mtk_jpeg_singlecore_enc_dev_run(void *priv) { .... blah .... }

and

static void mtk_jpeg_multicore_enc_dev_run(void *priv)
{
	struct mtk_jpeg_ctx *ctx = priv;

	queue_work(ctx->jpeg->workqueue, &ctx->jpeg_work);
}

Also because we're defining `.m2m_ops` into mt8195_jpegenc_drvdata, so it's
going to be as trivial as defining a new m2m_ops for it:

static const struct v4l2_m2m_ops mtk_jpeg_multicore_enc_m2m_ops = {

	.device_run = mtk_jpeg_multicore_enc_dev_run,

};

Please fix that :-)

> +	struct mtk_jpeg_ctx *ctx = priv;
> +	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
> +	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> +	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!jpeg->is_jpgenc_multihw) {
> +		src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
> +		dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> +
> +		ret = pm_runtime_resume_and_get(jpeg->dev);
> +		if (ret < 0)
> +			goto enc_end;
> +
> +		schedule_delayed_work(&jpeg->job_timeout_work,
> +				      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
> +
> +		spin_lock_irqsave(&jpeg->hw_lock, flags);
> +
> +		/*
> +		 * Resetting the hardware every frame is to ensure that all the
> +		 * registers are cleared. This is a hardware requirement.
> +		 */
> +		mtk_jpeg_enc_reset(jpeg->reg_base);
> +
> +		mtk_jpeg_set_enc_src(ctx, jpeg->reg_base, &src_buf->vb2_buf);
> +		mtk_jpeg_set_enc_dst(ctx, jpeg->reg_base, &dst_buf->vb2_buf);
> +		mtk_jpeg_set_enc_params(ctx, jpeg->reg_base);
> +		mtk_jpeg_enc_start(jpeg->reg_base);
> +		spin_unlock_irqrestore(&jpeg->hw_lock, flags);
> +		return;
> +
> +enc_end:
> +		v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> +		v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> +		v4l2_m2m_buf_done(src_buf, buf_state);
> +		v4l2_m2m_buf_done(dst_buf, buf_state);
> +		v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> +	} else {
> +		queue_work(jpeg->workqueue, &ctx->jpeg_work);
> +	}
> +}
> +
>   static void mtk_jpeg_dec_device_run(void *priv)
>   {
>   	struct mtk_jpeg_ctx *ctx = priv;
> @@ -1211,6 +1364,9 @@ static int mtk_jpeg_open(struct file *file)
>   		goto free;
>   	}
>   
> +	if (jpeg->is_jpgenc_multihw)
> +		INIT_WORK(&ctx->jpeg_work, mtk_jpegenc_worker);
> +
>   	v4l2_fh_init(&ctx->fh, vfd);
>   	file->private_data = &ctx->fh;
>   	v4l2_fh_add(&ctx->fh);
> @@ -1355,6 +1511,18 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>   			dev_err(&pdev->dev, "Failed to init clk\n");
>   			goto err_clk_init;
>   		}
> +	} else {
> +		if (of_property_read_bool(pdev->dev.of_node,
> +					  "mediatek,jpegenc-multi-core")) {

This check is redundant (and will be wrong in the jpegdec series): you're entering
this branch only `if (jpeg->is_jpgenc_multihw)`, and this is initialized a little
earlier when reading the very same devicetree property.

So, for this series, remove the redundant check; for the jpegdec series, don't
recheck with of_property_read_bool, but check for `if (jpeg->is_jpgenc_multihw)`
and then theck for `if (jpeg->is_jpgdec_multihw)`.

> +			init_waitqueue_head(&jpeg->enc_hw_wq);
> +			jpeg->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
> +								  WQ_MEM_RECLAIM
> +								  | WQ_FREEZABLE);
> +			if (!jpeg->workqueue) {
> +				ret = -EINVAL;
> +				goto err_alloc_workqueue;
> +			}
> +		}
>   	}
>   
>   	ret = v4l2_device_register(&pdev->dev, &jpeg->v4l2_dev);
> @@ -1423,6 +1591,8 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>   
>   err_clk_init:
>   
> +err_alloc_workqueue:
> +

You aren't doing anything at all here, so this label is not required. Remove it.

>   err_req_irq:
>   
>   	return ret;
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> index 55719bd1b0fb..2fc20c6e06f4 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> @@ -75,6 +75,11 @@ struct mtk_jpeg_variant {
>   	u32 cap_q_default_fourcc;
>   };
>   
> +enum mtk_jpeg_hw_state {
> +	MTK_JPEG_HW_IDLE = 0,
> +	MTK_JPEG_HW_BUSY = 1,
> +};
> +
>   struct mtk_jpeg_hw_param {
>   	struct vb2_v4l2_buffer *src_buffer;
>   	struct vb2_v4l2_buffer *dst_buffer;
> @@ -97,12 +102,17 @@ struct mtk_jpegenc_clk {
>   
>   /**
>    * struct mtk_jpegenc_comp_dev - JPEG COREX abstraction
> - * @dev:		        JPEG device
> - * @plat_dev:		    platform device data
> - * @reg_base:		    JPEG registers mapping
> - * @master_dev:		    mtk_jpeg_dev device
> - * @pm:	                mtk_jpegenc_pm
> - * @jpegenc_irq:	    jpeg encode irq num
> + * @dev:		JPEG device
> + * @plat_dev:		platform device data
> + * @reg_base:		JPEG registers mapping
> + * @master_dev:		mtk_jpeg_dev device
> + * @venc_clk:	        mtk_jpegenc_clk
> + * @jpegenc_irq:	jpeg encode irq num
> + * @job_timeout_work:	handle jpeg encode work
> + * @hw_param:		record hw param
> + * @hw_rdy:		record hw ready
> + * @hw_state:		record hw state
> + * @hw_lock:		spinlock protecting the hw device resource
>    */
>   struct mtk_jpegenc_comp_dev {
>   	struct device *dev;
> @@ -114,6 +124,9 @@ struct mtk_jpegenc_comp_dev {
>   	int hw_id;
>   	struct delayed_work job_timeout_work;
>   	struct mtk_jpeg_hw_param hw_param;
> +	enum mtk_jpeg_hw_state hw_state;
> +	//spinlock protecting the hw device resource
> +	spinlock_t hw_lock;
>   };
>   
>   /**
> @@ -146,6 +159,8 @@ struct mtk_jpeg_dev {
>   	void __iomem *reg_encbase[MTK_JPEGENC_HW_MAX];
>   	struct mtk_jpegenc_comp_dev *enc_hw_dev[MTK_JPEGENC_HW_MAX];
>   	bool is_jpgenc_multihw;
> +	wait_queue_head_t enc_hw_wq;
> +	atomic_t enchw_rdy;
>   };
>   
>   /**
> @@ -204,6 +219,9 @@ struct mtk_jpeg_ctx {
>   	u8 enc_quality;
>   	u8 restart_interval;
>   	struct v4l2_ctrl_handler ctrl_hdl;
> +
> +	struct work_struct jpeg_work;
> +	u32 total_frame_num;
>   };
>   
>   #endif /* _MTK_JPEG_CORE_H */
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> index bea62013ce7d..8e1840137c34 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> @@ -192,6 +192,7 @@ static void mtk_jpegenc_timeout_work(struct work_struct *work)
>   		container_of(dly_work,
>   			     struct mtk_jpegenc_comp_dev,
>   			     job_timeout_work);
> +	struct mtk_jpeg_dev *master_jpeg = cjpeg->master_dev;
>   	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
>   	struct vb2_v4l2_buffer *src_buf, *dst_buf;
>   
> @@ -202,6 +203,9 @@ static void mtk_jpegenc_timeout_work(struct work_struct *work)
>   	mtk_jpeg_enc_reset(cjpeg->reg_base);
>   	clk_disable_unprepare(cjpeg->venc_clk.clks->clk);
>   	pm_runtime_put(cjpeg->dev);
> +	cjpeg->hw_state = MTK_JPEG_HW_IDLE;
> +	atomic_inc(&master_jpeg->enchw_rdy);
> +	wake_up(&master_jpeg->enc_hw_wq);
>   	v4l2_m2m_buf_done(src_buf, buf_state);
>   }
>   
> @@ -218,30 +222,37 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
>   
>   	cancel_delayed_work(&jpeg->job_timeout_work);
>   
> +	ctx = jpeg->hw_param.curr_ctx;
> +	src_buf = jpeg->hw_param.src_buffer;
> +	dst_buf = jpeg->hw_param.dst_buffer;
> +	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
> +
>   	irq_status = readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
>   		JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
>   	if (irq_status)
>   		writel(0, jpeg->reg_base + JPEG_ENC_INT_STS);
> -	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE))
> -		return IRQ_NONE;
> -
> -	ctx = v4l2_m2m_get_curr_priv(master_jpeg->m2m_dev);
> -	if (!ctx) {
> -		v4l2_err(&master_jpeg->v4l2_dev, "Context is NULL\n");
> -		return IRQ_HANDLED;
> +	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE)) {
> +		dev_err(jpeg->dev, " Not JPEG_ENC_INT_STATUS_DONE\n");

Please be more descriptive in error messages. Also, should this really be
a dev_err?!?

> +		goto irq_handled;
>   	}
>   
> -	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> -	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> -	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
> -
>   	result_size = mtk_jpeg_enc_get_file_size(jpeg->reg_base);
>   	vb2_set_plane_payload(&dst_buf->vb2_buf, 0, result_size);
> +
> +irq_handled:
>   	buf_state = VB2_BUF_STATE_DONE;
>   	v4l2_m2m_buf_done(src_buf, buf_state);
>   	v4l2_m2m_buf_done(dst_buf, buf_state);
> -	v4l2_m2m_job_finish(master_jpeg->m2m_dev, ctx->fh.m2m_ctx);
>   	pm_runtime_put(ctx->jpeg->dev);
> +	clk_disable_unprepare(jpeg->venc_clk.clks->clk);
> +	if (!list_empty(&ctx->fh.m2m_ctx->out_q_ctx.rdy_queue) ||
> +	    !list_empty(&ctx->fh.m2m_ctx->cap_q_ctx.rdy_queue)) {
> +		queue_work(master_jpeg->workqueue, &ctx->jpeg_work);
> +	}
> +
> +	jpeg->hw_state = MTK_JPEG_HW_IDLE;
> +	wake_up(&master_jpeg->enc_hw_wq);
> +	atomic_inc(&master_jpeg->enchw_rdy);
>   
>   	return IRQ_HANDLED;
>   }
> @@ -294,6 +305,10 @@ static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
>   	dev->plat_dev = pdev;
>   	dev->dev = &pdev->dev;
>   
> +	atomic_set(&master_dev->enchw_rdy, MTK_JPEGENC_HW_MAX);
> +	spin_lock_init(&dev->hw_lock);
> +	dev->hw_state = MTK_JPEG_HW_IDLE;
> +
>   	INIT_DELAYED_WORK(&dev->job_timeout_work,
>   			  mtk_jpegenc_timeout_work);
>   


