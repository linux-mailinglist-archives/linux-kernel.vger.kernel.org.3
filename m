Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC74AC2A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442848AbiBGPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442461AbiBGOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:50:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8BEC0401C2;
        Mon,  7 Feb 2022 06:50:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B335A1F444B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644245449;
        bh=13Pa/hRoL9bc6PMdKa7o3kW0gnpTZ/7yRWMBa7/cWug=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E5nDpwdJ3WJeBqgA11hTJgycuzr9IolkDMGGw/W0GyDH6gtijdYhCrmKgT50mz2Bc
         ZZWfgMuby4+E+/iGal0uerm3GAhl96/I61rhtkEAqVPDkJ+MgDbKItyIRozrlwGjy4
         x+JCnRZiXFTma4kNRMrHqjJF5MxIwbFhxRzLHzdgtfKFGamelDdQYY55JKopBN4Gt6
         kZpo/Wv17MvsU5RDVIteshi0UJzElRBd+0D8lNz9ZLPtZQjYR2EgwKYVKM4/mvn682
         dy+SO74CcRhmj++OGIZ/zqUL3OPfTWMfOI/5DoxJzz8yOHzjhnbTH03juHvW0bzPVP
         NUl8f8rHgCHoA==
Message-ID: <d305aefa-7cdf-3221-2883-9381785e335d@collabora.com>
Date:   Mon, 7 Feb 2022 15:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V1, 5/6] media: mtk-jpegdec: add output pic reorder
 interface
Content-Language: en-US
To:     "kyrie.wu" <kyrie.wu@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com,
        irui.wang@mediatek.com
References: <1638509655-14296-1-git-send-email-kyrie.wu@mediatek.com>
 <1638509655-14296-6-git-send-email-kyrie.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1638509655-14296-6-git-send-email-kyrie.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/12/21 06:34, kyrie.wu ha scritto:
> add output reorder func to reorder the output images
> to ensure the output pic is consistent with the input images.
> 
> Signed-off-by: kyrie.wu <kyrie.wu@mediatek.com>
> ---
>   drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c | 50 +++++++++++++++++++++--
>   1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c
> index 9138ecb..fad5bf1c 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c
> @@ -443,6 +443,49 @@ void mtk_jpeg_dec_set_config(void __iomem *base,
>   	mtk_jpeg_dec_set_pause_mcu_idx(base, config->total_mcu);
>   }
>   
> +void mtk_jpegdec_put_buf(struct mtk_jpegdec_comp_dev *jpeg)

This function is used only in this file, hence it should be static.

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

Since this is unlikely to happen (or should be unlikely anyway!!), this print
should then be a dev_dbg()

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
>   static void mtk_jpegdec_timeout_work(struct work_struct *work)
>   {
>   	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
> @@ -450,10 +493,9 @@ static void mtk_jpegdec_timeout_work(struct work_struct *work)
>   		container_of(work, struct mtk_jpegdec_comp_dev,
>   		job_timeout_work.work);
>   	struct mtk_jpeg_dev *master_jpeg = cjpeg->master_dev;
> -	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> +	struct vb2_v4l2_buffer *src_buf;
>   
>   	src_buf = cjpeg->hw_param.src_buffer;
> -	dst_buf = cjpeg->hw_param.dst_buffer;
>   
>   	mtk_jpeg_dec_reset(cjpeg->reg_base);
>   	clk_disable_unprepare(cjpeg->pm.dec_clk.clk_info->jpegdec_clk);
> @@ -462,7 +504,7 @@ static void mtk_jpegdec_timeout_work(struct work_struct *work)
>   	atomic_inc(&cjpeg->hw_rdy);
>   	wake_up(&master_jpeg->dec_hw_wq);
>   	v4l2_m2m_buf_done(src_buf, buf_state);
> -	v4l2_m2m_buf_done(dst_buf, buf_state);
> +	mtk_jpegdec_put_buf(cjpeg);
>   }
>   
>   int mtk_jpegdec_init_pm(struct mtk_jpegdec_comp_dev *mtkdev)
> @@ -559,7 +601,7 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
>   
>   dec_end:
>   	v4l2_m2m_buf_done(src_buf, buf_state);
> -	v4l2_m2m_buf_done(dst_buf, buf_state);
> +	mtk_jpegdec_put_buf(jpeg);
>   	v4l2_m2m_job_finish(master_jpeg->m2m_dev, ctx->fh.m2m_ctx);
>   	clk_disable_unprepare(jpeg->pm.dec_clk.clk_info->jpegdec_clk);
>   	pm_runtime_put(ctx->jpeg->dev);


