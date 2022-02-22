Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C07C4BF40B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiBVItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBVItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:49:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44D4A2F32;
        Tue, 22 Feb 2022 00:48:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF6D61459;
        Tue, 22 Feb 2022 08:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CE9C340E8;
        Tue, 22 Feb 2022 08:48:37 +0000 (UTC)
Message-ID: <de212d97-538f-f25c-5211-8606901cef00@xs4all.nl>
Date:   Tue, 22 Feb 2022 09:48:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3] media: imx-jpeg: Set V4L2_BUF_FLAG_LAST at eos
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220222084116.5619-1-ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220222084116.5619-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What changed in v3?

The v2 is already part of a PR, so if the changes are just of the cleanup
type, then I prefer to have a diff on top of the v2. Otherwise I need to
respin the PR.

Regards,

	Hans

On 2/22/22 09:41, Ming Qian wrote:
> The V4L2_EVENT_EOS event is a deprecated behavior,
> the V4L2_BUF_FLAG_LAST buffer flag should be used instead.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
> ---
>  drivers/media/platform/imx-jpeg/mxc-jpeg.c | 41 ++++++++++++++++++++--
>  drivers/media/platform/imx-jpeg/mxc-jpeg.h |  1 +
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
> index ec5a326affd6..1de0400750aa 100644
> --- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
> @@ -997,6 +997,20 @@ static void mxc_jpeg_device_run(void *priv)
>  	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
>  }
>  
> +static void mxc_jpeg_set_last_buffer_dequeued(struct mxc_jpeg_ctx *ctx)
> +{
> +	struct vb2_queue *q;
> +
> +	ctx->stopped = 1;
> +	q = v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx);
> +	if (!list_empty(&q->done_list))
> +		return;
> +
> +	q->last_buffer_dequeued = true;
> +	wake_up(&q->done_wq);
> +	ctx->stopped = 0;
> +}
> +
>  static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
>  				struct v4l2_decoder_cmd *cmd)
>  {
> @@ -1014,6 +1028,7 @@ static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
>  		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
>  			/* No more src bufs, notify app EOS */
>  			notify_eos(ctx);
> +			mxc_jpeg_set_last_buffer_dequeued(ctx);
>  		} else {
>  			/* will send EOS later*/
>  			ctx->stopping = 1;
> @@ -1040,6 +1055,7 @@ static int mxc_jpeg_encoder_cmd(struct file *file, void *priv,
>  		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
>  			/* No more src bufs, notify app EOS */
>  			notify_eos(ctx);
> +			mxc_jpeg_set_last_buffer_dequeued(ctx);
>  		} else {
>  			/* will send EOS later*/
>  			ctx->stopping = 1;
> @@ -1116,6 +1132,10 @@ static void mxc_jpeg_stop_streaming(struct vb2_queue *q)
>  		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
>  	}
>  	pm_runtime_put_sync(&ctx->mxc_jpeg->pdev->dev);
> +	if (V4L2_TYPE_IS_OUTPUT(q->type)) {
> +		ctx->stopping = 0;
> +		ctx->stopped = 0;
> +	}
>  }
>  
>  static int mxc_jpeg_valid_comp_id(struct device *dev,
> @@ -1407,12 +1427,29 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
>  	return 0;
>  }
>  
> +static void mxc_jpeg_buf_finish(struct vb2_buffer *vb)
> +{
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> +	struct vb2_queue *q = vb->vb2_queue;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(vb->type))
> +		return;
> +	if (!ctx->stopped)
> +		return;
> +	if (list_empty(&q->done_list)) {
> +		vbuf->flags |= V4L2_BUF_FLAG_LAST;
> +		ctx->stopped = 0;
> +	}
> +}
> +
>  static const struct vb2_ops mxc_jpeg_qops = {
>  	.queue_setup		= mxc_jpeg_queue_setup,
>  	.wait_prepare		= vb2_ops_wait_prepare,
>  	.wait_finish		= vb2_ops_wait_finish,
>  	.buf_out_validate	= mxc_jpeg_buf_out_validate,
>  	.buf_prepare		= mxc_jpeg_buf_prepare,
> +	.buf_finish             = mxc_jpeg_buf_finish,
>  	.start_streaming	= mxc_jpeg_start_streaming,
>  	.stop_streaming		= mxc_jpeg_stop_streaming,
>  	.buf_queue		= mxc_jpeg_buf_queue,
> @@ -1848,14 +1885,14 @@ static int mxc_jpeg_dqbuf(struct file *file, void *priv,
>  	int ret;
>  
>  	dev_dbg(dev, "DQBUF type=%d, index=%d", buf->type, buf->index);
> -	if (ctx->stopping == 1	&& num_src_ready == 0) {
> +	if (ctx->stopping == 1 && num_src_ready == 0) {
>  		/* No more src bufs, notify app EOS */
>  		notify_eos(ctx);
>  		ctx->stopping = 0;
> +		mxc_jpeg_set_last_buffer_dequeued(ctx);
>  	}
>  
>  	ret = v4l2_m2m_dqbuf(file, fh->m2m_ctx, buf);
> -
>  	return ret;
>  }
>  
> diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/imx-jpeg/mxc-jpeg.h
> index 9fb2a5aaa941..f53f004ba851 100644
> --- a/drivers/media/platform/imx-jpeg/mxc-jpeg.h
> +++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.h
> @@ -91,6 +91,7 @@ struct mxc_jpeg_ctx {
>  	struct v4l2_fh			fh;
>  	enum mxc_jpeg_enc_state		enc_state;
>  	unsigned int			stopping;
> +	unsigned int			stopped;
>  	unsigned int			slot;
>  };
>  
