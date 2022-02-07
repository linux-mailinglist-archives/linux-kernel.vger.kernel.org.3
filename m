Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7F4AB911
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiBGKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352721AbiBGKpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:45:51 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FFAC043181;
        Mon,  7 Feb 2022 02:45:49 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 0B2B840013;
        Mon,  7 Feb 2022 10:45:45 +0000 (UTC)
Date:   Mon, 7 Feb 2022 11:46:52 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     robh+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jacopo+renesas@jmondi.org,
        hverkuil-cisco@xs4all.nl, nicolas.ferre@microchip.com,
        sakari.ailus@iki.fi, laurent.pinchart@ideasonboard.com,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v4 01/11] media: atmel: atmel-isc: replace 'stop'
 variable with vb2 calls
Message-ID: <20220207104652.zovthrwpdi5cnvdm@uno.localdomain>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
 <20220121131416.603972-2-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220121131416.603972-2-eugen.hristev@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

On Fri, Jan 21, 2022 at 03:14:06PM +0200, Eugen Hristev wrote:
> The stop variable is redundant as the state of the streaming can be obtained
> by calling vb2_start_streaming_called(&isc->vb2_vidq) or by calling
> vb2_is_busy(&isc->vb2_vidq).
> Thus, remove the stop variable completely.
>
> Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

I trust yours and Hans' judgment here.
The patch looks sane
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
> ---
> Changes in v4:
> - new patch
>
>  drivers/media/platform/atmel/atmel-isc-base.c | 12 +++++-------
>  drivers/media/platform/atmel/atmel-isc.h      |  2 --
>  2 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> index db15770d5b88..9c62d0ae7887 100644
> --- a/drivers/media/platform/atmel/atmel-isc-base.c
> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
> @@ -362,7 +362,6 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
>  	spin_lock_irqsave(&isc->dma_queue_lock, flags);
>
>  	isc->sequence = 0;
> -	isc->stop = false;
>  	reinit_completion(&isc->comp);
>
>  	isc->cur_frm = list_first_entry(&isc->dma_queue,
> @@ -403,8 +402,6 @@ static void isc_stop_streaming(struct vb2_queue *vq)
>
>  	v4l2_ctrl_activate(isc->do_wb_ctrl, false);
>
> -	isc->stop = true;
> -
>  	/* Wait until the end of the current frame */
>  	if (isc->cur_frm && !wait_for_completion_timeout(&isc->comp, 5 * HZ))
>  		v4l2_err(&isc->v4l2_dev,
> @@ -1029,7 +1026,7 @@ static int isc_s_fmt_vid_cap(struct file *file, void *priv,
>  {
>  	struct isc_device *isc = video_drvdata(file);
>
> -	if (vb2_is_streaming(&isc->vb2_vidq))
> +	if (vb2_is_busy(&isc->vb2_vidq))
>  		return -EBUSY;
>
>  	return isc_set_fmt(isc, f);
> @@ -1236,7 +1233,8 @@ irqreturn_t isc_interrupt(int irq, void *dev_id)
>  			isc->cur_frm = NULL;
>  		}
>
> -		if (!list_empty(&isc->dma_queue) && !isc->stop) {
> +		if (!list_empty(&isc->dma_queue) &&
> +		    vb2_start_streaming_called(&isc->vb2_vidq)) {
>  			isc->cur_frm = list_first_entry(&isc->dma_queue,
>  						     struct isc_buffer, list);
>  			list_del(&isc->cur_frm->list);
> @@ -1244,7 +1242,7 @@ irqreturn_t isc_interrupt(int irq, void *dev_id)
>  			isc_start_dma(isc);
>  		}
>
> -		if (isc->stop)
> +		if (!vb2_start_streaming_called(&isc->vb2_vidq))
>  			complete(&isc->comp);
>
>  		ret = IRQ_HANDLED;
> @@ -1398,7 +1396,7 @@ static void isc_awb_work(struct work_struct *w)
>  	int ret;
>
>  	/* streaming is not active anymore */
> -	if (isc->stop)
> +	if (!vb2_start_streaming_called(&isc->vb2_vidq))
>  		return;
>
>  	if (ctrls->hist_stat != HIST_ENABLED)
> diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
> index 07fa6dbf8460..5fbf52a9080b 100644
> --- a/drivers/media/platform/atmel/atmel-isc.h
> +++ b/drivers/media/platform/atmel/atmel-isc.h
> @@ -201,7 +201,6 @@ struct isc_reg_offsets {
>   * @dma_queue:		the queue for dma buffers
>   * @cur_frm:		current isc frame/buffer
>   * @sequence:		current frame number
> - * @stop:		true if isc is not streaming, false if streaming
>   * @comp:		completion reference that signals frame completion
>   *
>   * @fmt:		current v42l format
> @@ -276,7 +275,6 @@ struct isc_device {
>  	struct list_head	dma_queue;
>  	struct isc_buffer	*cur_frm;
>  	unsigned int		sequence;
> -	bool			stop;
>  	struct completion	comp;
>
>  	struct v4l2_format	fmt;
> --
> 2.25.1
>
