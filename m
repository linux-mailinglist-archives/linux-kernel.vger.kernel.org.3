Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E18452B8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiERLWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiERLWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085615E4B8;
        Wed, 18 May 2022 04:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8AE260B84;
        Wed, 18 May 2022 11:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166F6C385A5;
        Wed, 18 May 2022 11:22:30 +0000 (UTC)
Message-ID: <f83e6b7e-8cb7-67b4-3e20-82bd9ff9a6a0@xs4all.nl>
Date:   Wed, 18 May 2022 13:22:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4] media: imx-jpeg: Encoder support to set jpeg quality
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220422015320.14600-1-ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220422015320.14600-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On 4/22/22 03:53, Ming Qian wrote:
> Implement V4L2_CID_JPEG_COMPRESSION_QUALITY
> to set jpeg quality
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
> v4
> - put the changelog in wrong place in v3
> v3
> - put this v3 information below the --- line
> v2
> - free ctrl handler if error is set and return error
> 
>  .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 11 +++-
>  .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  1 +
>  .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 57 +++++++++++++++++++
>  .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  2 +
>  4 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> index 29c604b1b179..c482228262a3 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
> @@ -100,9 +100,6 @@ void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg)
>  
>  	/* all markers and segments */
>  	writel(0x3ff, reg + CAST_CFG_MODE);
> -
> -	/* quality factor */
> -	writel(0x4b, reg + CAST_QUALITY);
>  }
>  
>  void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg)
> @@ -114,6 +111,14 @@ void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg)
>  	writel(0x140, reg + CAST_MODE);
>  }
>  
> +void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg, u8 quality)
> +{
> +	dev_dbg(dev, "CAST Encoder Quality %d...\n", quality);
> +
> +	/* quality factor */
> +	writel(quality, reg + CAST_QUALITY);
> +}
> +
>  void mxc_jpeg_dec_mode_go(struct device *dev, void __iomem *reg)
>  {
>  	dev_dbg(dev, "CAST Decoder GO...\n");
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> index ae70d3a0dc24..356e40140987 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> @@ -119,6 +119,7 @@ int mxc_jpeg_enable(void __iomem *reg);
>  void wait_frmdone(struct device *dev, void __iomem *reg);
>  void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg);
>  void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg);
> +void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg, u8 quality);
>  void mxc_jpeg_dec_mode_go(struct device *dev, void __iomem *reg);
>  int mxc_jpeg_get_slot(void __iomem *reg);
>  u32 mxc_jpeg_get_offset(void __iomem *reg, int slot);
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 0c3a1efbeae7..1bd245ba00e2 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -624,6 +624,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
>  	    ctx->enc_state == MXC_JPEG_ENC_CONF) {
>  		ctx->enc_state = MXC_JPEG_ENCODING;
>  		dev_dbg(dev, "Encoder config finished. Start encoding...\n");
> +		mxc_jpeg_enc_set_quality(dev, reg, ctx->jpeg_quality);
>  		mxc_jpeg_enc_mode_go(dev, reg);
>  		goto job_unlock;
>  	}
> @@ -1563,6 +1564,51 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
>  	}
>  }
>  
> +static int mxc_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct mxc_jpeg_ctx *ctx =
> +		container_of(ctrl->handler, struct mxc_jpeg_ctx, ctrl_handler);
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_JPEG_COMPRESSION_QUALITY:
> +		ctx->jpeg_quality = ctrl->val;
> +		break;
> +	default:
> +		dev_err(ctx->mxc_jpeg->dev, "Invalid control, id = %d, val = %d\n",
> +			ctrl->id, ctrl->val);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_ctrl_ops mxc_jpeg_ctrl_ops = {
> +	.s_ctrl = mxc_jpeg_s_ctrl,
> +};
> +
> +static void mxc_jpeg_encode_ctrls(struct mxc_jpeg_ctx *ctx)
> +{
> +	v4l2_ctrl_new_std(&ctx->ctrl_handler, &mxc_jpeg_ctrl_ops,
> +			  V4L2_CID_JPEG_COMPRESSION_QUALITY, 1, 100, 1, 75);
> +}
> +
> +static int mxc_jpeg_ctrls_setup(struct mxc_jpeg_ctx *ctx)
> +{
> +	v4l2_ctrl_handler_init(&ctx->ctrl_handler, 2);
> +
> +	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE)
> +		mxc_jpeg_encode_ctrls(ctx);
> +
> +	if (ctx->ctrl_handler.error) {
> +		int err = ctx->ctrl_handler.error;
> +
> +		v4l2_ctrl_handler_free(&ctx->ctrl_handler);
> +		return err;
> +	}
> +
> +	return v4l2_ctrl_handler_setup(&ctx->ctrl_handler);

If v4l2_ctrl_handler_setup() fails, then v4l2_ctrl_handler_free() is never called.
The mxc_jpeg_open() function assumes that mxc_jpeg_ctrls_setup() either returns
0 or an error, and that on error it has freed any allocated memory.

So this needs to be fixed.

Regards,

	Hans

> +}
> +
>  static int mxc_jpeg_open(struct file *file)
>  {
>  	struct mxc_jpeg_dev *mxc_jpeg = video_drvdata(file);
> @@ -1594,6 +1640,12 @@ static int mxc_jpeg_open(struct file *file)
>  		goto error;
>  	}
>  
> +	ret = mxc_jpeg_ctrls_setup(ctx);
> +	if (ret) {
> +		dev_err(ctx->mxc_jpeg->dev, "failed to setup mxc jpeg controls\n");
> +		goto err_ctrls_setup;
> +	}
> +	ctx->fh.ctrl_handler = &ctx->ctrl_handler;
>  	mxc_jpeg_set_default_params(ctx);
>  	ctx->slot = MXC_MAX_SLOTS; /* slot not allocated yet */
>  
> @@ -1605,6 +1657,8 @@ static int mxc_jpeg_open(struct file *file)
>  
>  	return 0;
>  
> +err_ctrls_setup:
> +	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
>  error:
>  	v4l2_fh_del(&ctx->fh);
>  	v4l2_fh_exit(&ctx->fh);
> @@ -1962,6 +2016,8 @@ static int mxc_jpeg_subscribe_event(struct v4l2_fh *fh,
>  		return v4l2_event_subscribe(fh, sub, 0, NULL);
>  	case V4L2_EVENT_SOURCE_CHANGE:
>  		return v4l2_src_change_event_subscribe(fh, sub);
> +	case V4L2_EVENT_CTRL:
> +		return v4l2_ctrl_subscribe_event(fh, sub);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -2035,6 +2091,7 @@ static int mxc_jpeg_release(struct file *file)
>  	else
>  		dev_dbg(dev, "Release JPEG encoder instance on slot %d.",
>  			ctx->slot);
> +	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
>  	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
>  	v4l2_fh_del(&ctx->fh);
>  	v4l2_fh_exit(&ctx->fh);
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> index 9ae56e6e0fbe..9c9da32b2125 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> @@ -96,6 +96,8 @@ struct mxc_jpeg_ctx {
>  	unsigned int			slot;
>  	unsigned int			source_change;
>  	bool				header_parsed;
> +	struct v4l2_ctrl_handler	ctrl_handler;
> +	u8				jpeg_quality;
>  };
>  
>  struct mxc_jpeg_slot_data {
