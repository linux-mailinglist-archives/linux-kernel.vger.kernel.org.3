Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC7554B3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiFNOov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiFNOoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF8A1AF38;
        Tue, 14 Jun 2022 07:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FBD161762;
        Tue, 14 Jun 2022 14:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A10C3411B;
        Tue, 14 Jun 2022 14:44:40 +0000 (UTC)
Message-ID: <fed8b2cf-3098-0690-dc40-796dbe0ff424@xs4all.nl>
Date:   Tue, 14 Jun 2022 16:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v1 2/5] media: rkvdec: Add an ops to check for decode
 errors
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
 <20220610125215.240539-3-nicolas.dufresne@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220610125215.240539-3-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 14:52, Nicolas Dufresne wrote:
> This optional internal ops allow each codec to do their own
> error status checking. The presence of an error is reported
> using the ERROR buffer state. This patch have no functional
> changes.

If a buffer is returned with state ERROR, then that means that it is
seriously corrupt and userspace is expected to drop it. You might still
want to show it for debugging purposes, but the normal action is to drop it.

So this is not a valid approach for a decoder that can still produce a
decent picture, albeit with macroblock artifacts.

A separate control that can be returned as part of the request and contains
some sort of error indication would be more appropriate.

Buffer state ERROR is really meant for e.g. DMA errors and it shouldn't
be mixed with decode errors that still produce a valid picture.

Regards,

	Hans

> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec.c | 10 ++++++----
>  drivers/staging/media/rkvdec/rkvdec.h |  2 ++
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index 7bab7586918c..7e76f8b72885 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -950,6 +950,7 @@ static void rkvdec_v4l2_cleanup(struct rkvdec_dev *rkvdec)
>  static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
>  {
>  	struct rkvdec_dev *rkvdec = priv;
> +	struct rkvdec_ctx *ctx;
>  	enum vb2_buffer_state state;
>  	u32 status;
>  
> @@ -958,12 +959,13 @@ static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
>  		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
>  
>  	writel(0, rkvdec->regs + RKVDEC_REG_INTERRUPT);
> -	if (cancel_delayed_work(&rkvdec->watchdog_work)) {
> -		struct rkvdec_ctx *ctx;
> +	ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
>  
> -		ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
> +	if (ctx->coded_fmt_desc->ops->check_error_info)
> +		state = ctx->coded_fmt_desc->ops->check_error_info(ctx);
> +
> +	if (cancel_delayed_work(&rkvdec->watchdog_work))
>  		rkvdec_job_finish(ctx, state);
> -	}
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
> index 633335ebb9c4..4ae8e6c6b03c 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.h
> +++ b/drivers/staging/media/rkvdec/rkvdec.h
> @@ -73,6 +73,8 @@ struct rkvdec_coded_fmt_ops {
>  		     struct vb2_v4l2_buffer *dst_buf,
>  		     enum vb2_buffer_state result);
>  	int (*try_ctrl)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
> +	/* called from IRQ handler */
> +	int (*check_error_info)(struct rkvdec_ctx *ctx);
>  };
>  
>  struct rkvdec_coded_fmt_desc {

