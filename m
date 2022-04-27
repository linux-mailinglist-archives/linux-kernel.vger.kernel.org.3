Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A895111E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358521AbiD0HGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbiD0HG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:06:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1687252BF;
        Wed, 27 Apr 2022 00:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9135B82489;
        Wed, 27 Apr 2022 07:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372D9C385A9;
        Wed, 27 Apr 2022 07:03:13 +0000 (UTC)
Message-ID: <0979dccf-e9d0-f3bb-ac2c-e2b0ed5fd181@xs4all.nl>
Date:   Wed, 27 Apr 2022 09:03:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 5/5] media: imx-jpeg: Support dynamic resolution change
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1648023273.git.ming.qian@nxp.com>
 <93dd8b6a487a4f228984debb7a255d7ddde8f490.1648023273.git.ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <93dd8b6a487a4f228984debb7a255d7ddde8f490.1648023273.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 10:05, Ming Qian wrote:
> To support dynamic resolution change,
> driver should meet the following conditions:
> 1. the previous pictures are all decoded before source change event.
> 2. prevent decoding new resolution pictures with incorrect capture
>    buffer, until user handle source change event and setup capture.
> 3. report correct fmt and resolution during source change.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 69 ++++++++++++++-----
>  .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  2 +
>  2 files changed, 55 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 30289f2be3dd..0c3a1efbeae7 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -933,13 +933,14 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>  {
>  	struct device *dev = ctx->mxc_jpeg->dev;
>  	struct mxc_jpeg_q_data *q_data_cap;
> -	bool src_chg = false;
>  
>  	if (!jpeg_src_buf->fmt)
> -		return src_chg;
> +		return false;
>  
>  	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
> -	if (q_data_cap->w != jpeg_src_buf->w || q_data_cap->h != jpeg_src_buf->h) {
> +	if (q_data_cap->fmt != jpeg_src_buf->fmt ||
> +	    q_data_cap->w != jpeg_src_buf->w ||
> +	    q_data_cap->h != jpeg_src_buf->h) {
>  		dev_dbg(dev, "Detected jpeg res=(%dx%d)->(%dx%d), pixfmt=%c%c%c%c\n",
>  			q_data_cap->w, q_data_cap->h,
>  			jpeg_src_buf->w, jpeg_src_buf->h,
> @@ -976,9 +977,16 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>  		mxc_jpeg_bytesperline(q_data_cap, jpeg_src_buf->fmt->precision);
>  		mxc_jpeg_sizeimage(q_data_cap);
>  		notify_src_chg(ctx);
> -		src_chg = true;
> +		ctx->source_change = 1;
>  	}
> -	return src_chg;
> +	return ctx->source_change ? true : false;
> +}
> +
> +static int mxc_jpeg_job_ready(void *priv)
> +{
> +	struct mxc_jpeg_ctx *ctx = priv;
> +
> +	return ctx->source_change ? 0 : 1;
>  }
>  
>  static void mxc_jpeg_device_run(void *priv)
> @@ -1028,6 +1036,13 @@ static void mxc_jpeg_device_run(void *priv)
>  
>  		return;
>  	}
> +	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE) {
> +		if (ctx->source_change || mxc_jpeg_source_change(ctx, jpeg_src_buf)) {
> +			spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
> +			v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> +			return;
> +		}
> +	}
>  
>  	mxc_jpeg_enable(reg);
>  	mxc_jpeg_set_l_endian(reg, 1);
> @@ -1074,6 +1089,7 @@ static void mxc_jpeg_set_last_buffer_dequeued(struct mxc_jpeg_ctx *ctx)
>  	q->last_buffer_dequeued = true;
>  	wake_up(&q->done_wq);
>  	ctx->stopped = 0;
> +	ctx->header_parsed = false;
>  }
>  
>  static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
> @@ -1167,6 +1183,8 @@ static int mxc_jpeg_start_streaming(struct vb2_queue *q, unsigned int count)
>  	struct mxc_jpeg_q_data *q_data = mxc_jpeg_get_q_data(ctx, q->type);
>  	int ret;
>  
> +	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE && V4L2_TYPE_IS_CAPTURE(q->type))
> +		ctx->source_change = 0;
>  	dev_dbg(ctx->mxc_jpeg->dev, "Start streaming ctx=%p", ctx);
>  	q_data->sequence = 0;
>  
> @@ -1345,16 +1363,15 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
>  		dev_warn(dev, "Invalid user resolution 0x0");
>  		dev_warn(dev, "Keeping resolution from JPEG: %dx%d",
>  			 header.frame.width, header.frame.height);
> -		q_data_out->w = header.frame.width;
> -		q_data_out->h = header.frame.height;
>  	} else if (header.frame.width != q_data_out->w ||
>  		   header.frame.height != q_data_out->h) {
>  		dev_err(dev,
>  			"Resolution mismatch: %dx%d (JPEG) versus %dx%d(user)",
>  			header.frame.width, header.frame.height,
>  			q_data_out->w, q_data_out->h);
> -		return -EINVAL;
>  	}
> +	q_data_out->w = header.frame.width;
> +	q_data_out->h = header.frame.height;
>  	if (header.frame.width % 8 != 0 || header.frame.height % 8 != 0) {
>  		dev_err(dev, "JPEG width or height not multiple of 8: %dx%d\n",
>  			header.frame.width, header.frame.height);
> @@ -1390,8 +1407,10 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
>  	jpeg_src_buf->fmt = mxc_jpeg_find_format(ctx, fourcc);
>  	jpeg_src_buf->w = header.frame.width;
>  	jpeg_src_buf->h = header.frame.height;
> +	ctx->header_parsed = true;
>  
> -	mxc_jpeg_source_change(ctx, jpeg_src_buf);
> +	if (!v4l2_m2m_num_src_bufs_ready(ctx->fh.m2m_ctx))
> +		mxc_jpeg_source_change(ctx, jpeg_src_buf);
>  
>  	return 0;
>  }
> @@ -1468,6 +1487,7 @@ static void mxc_jpeg_buf_finish(struct vb2_buffer *vb)
>  	if (list_empty(&q->done_list)) {
>  		vbuf->flags |= V4L2_BUF_FLAG_LAST;
>  		ctx->stopped = 0;
> +		ctx->header_parsed = false;
>  	}
>  }
>  
> @@ -1613,26 +1633,42 @@ static int mxc_jpeg_enum_fmt_vid_cap(struct file *file, void *priv,
>  				     struct v4l2_fmtdesc *f)
>  {
>  	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
> +	struct mxc_jpeg_q_data *q_data = mxc_jpeg_get_q_data(ctx, f->type);
>  
> -	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE)
> +	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE) {
>  		return enum_fmt(mxc_formats, MXC_JPEG_NUM_FORMATS, f,
>  			MXC_JPEG_FMT_TYPE_ENC);
> -	else
> +	} else if (!ctx->header_parsed) {
>  		return enum_fmt(mxc_formats, MXC_JPEG_NUM_FORMATS, f,
>  			MXC_JPEG_FMT_TYPE_RAW);
> +	} else {
> +		/* For the decoder CAPTURE queue, only enumerate the raw formats
> +		 * supported for the format currently active on OUTPUT
> +		 * (more precisely what was propagated on capture queue
> +		 * after jpeg parse on the output buffer)
> +		 */
> +		if (f->index)
> +			return -EINVAL;
> +		f->pixelformat = q_data->fmt->fourcc;
> +		strscpy(f->description, q_data->fmt->name, sizeof(f->description));

Don't fill the description field in struct v4l2_fmtdesc. The core will fill
this for you, ensuring consistent format description names.

I've seen this in enum_fmt() and in mxc_jpeg_enum_fmt_vid_cap(), so both
functions should be adapted. This can be done in a new patch since it is
unrelated to the changes of this patch series.

Just something I noticed :-)

Regards,

	Hans

> +		return 0;
> +	}
>  }
>  
>  static int mxc_jpeg_enum_fmt_vid_out(struct file *file, void *priv,
>  				     struct v4l2_fmtdesc *f)
>  {
>  	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
> +	u32 type = ctx->mxc_jpeg->mode == MXC_JPEG_DECODE ?  MXC_JPEG_FMT_TYPE_ENC :
> +							     MXC_JPEG_FMT_TYPE_RAW;
> +	int ret;
>  
> +	ret = enum_fmt(mxc_formats, MXC_JPEG_NUM_FORMATS, f, type);
> +	if (ret)
> +		return ret;
>  	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE)
> -		return enum_fmt(mxc_formats, MXC_JPEG_NUM_FORMATS, f,
> -				MXC_JPEG_FMT_TYPE_ENC);
> -	else
> -		return enum_fmt(mxc_formats, MXC_JPEG_NUM_FORMATS, f,
> -				MXC_JPEG_FMT_TYPE_RAW);
> +		f->flags = V4L2_FMT_FLAG_DYN_RESOLUTION;
> +	return 0;
>  }
>  
>  static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fmt,
> @@ -2018,6 +2054,7 @@ static const struct v4l2_file_operations mxc_jpeg_fops = {
>  };
>  
>  static const struct v4l2_m2m_ops mxc_jpeg_m2m_ops = {
> +	.job_ready      = mxc_jpeg_job_ready,
>  	.device_run	= mxc_jpeg_device_run,
>  };
>  
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> index 82b38cc2dfab..9ae56e6e0fbe 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> @@ -94,6 +94,8 @@ struct mxc_jpeg_ctx {
>  	unsigned int			stopping;
>  	unsigned int			stopped;
>  	unsigned int			slot;
> +	unsigned int			source_change;
> +	bool				header_parsed;
>  };
>  
>  struct mxc_jpeg_slot_data {

