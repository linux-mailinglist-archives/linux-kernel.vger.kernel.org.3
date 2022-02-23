Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E816B4C197A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243203AbiBWRIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243274AbiBWRH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:07:56 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D794511A21;
        Wed, 23 Feb 2022 09:07:27 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 4E1191BF206;
        Wed, 23 Feb 2022 17:07:24 +0000 (UTC)
Date:   Wed, 23 Feb 2022 18:07:22 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH v5 06/13] media: atmel: atmel-isc-base: use mutex to lock
 awb workqueue from streaming
Message-ID: <20220223170722.lmi6727vjnhf6zwd@uno.localdomain>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
 <20220217135645.1427466-7-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217135645.1427466-7-eugen.hristev@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Thu, Feb 17, 2022 at 03:56:38PM +0200, Eugen Hristev wrote:
> The AWB workqueue runs in a kernel thread and needs to be synchronized
> w.r.t. the streaming status.
> It is possible that streaming is stopped while the AWB workq is running.
> In this case it is likely that the check for vb2_start_streaming_called is done
> at one point in time, but the AWB computations are done later, including a call
> to isc_update_profile, which requires streaming to be started.
> Thus , isc_update_profile will fail if during this operation sequence the
> streaming was stopped.
> To solve this issue, a mutex is added, that will serialize the awb work and
> streaming stopping, with the mention that either streaming is stopped
> completely including termination of the last frame is done, and after that
> the AWB work can check stream status and stop; either first AWB work is
> completed and after that the streaming can stop correctly.
> The awb spin lock cannot be used since this spinlock is taken in the same
> context and using it in the stop streaming will result in a recursion BUG.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

I trust this doesn't deadlock :)
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j

> ---
>  drivers/media/platform/atmel/atmel-isc-base.c | 29 ++++++++++++++++---
>  drivers/media/platform/atmel/atmel-isc.h      |  2 ++
>  2 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> index 74f575544e09..37c59bb4dc18 100644
> --- a/drivers/media/platform/atmel/atmel-isc-base.c
> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
> @@ -401,6 +401,7 @@ static void isc_stop_streaming(struct vb2_queue *vq)
>  	struct isc_buffer *buf;
>  	int ret;
>
> +	mutex_lock(&isc->awb_mutex);
>  	v4l2_ctrl_activate(isc->do_wb_ctrl, false);
>
>  	isc->stop = true;
> @@ -410,6 +411,8 @@ static void isc_stop_streaming(struct vb2_queue *vq)
>  		v4l2_err(&isc->v4l2_dev,
>  			 "Timeout waiting for end of the capture\n");
>
> +	mutex_unlock(&isc->awb_mutex);
> +
>  	/* Disable DMA interrupt */
>  	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
>
> @@ -1397,10 +1400,6 @@ static void isc_awb_work(struct work_struct *w)
>  	u32 min, max;
>  	int ret;
>
> -	/* streaming is not active anymore */
> -	if (isc->stop)
> -		return;
> -
>  	if (ctrls->hist_stat != HIST_ENABLED)
>  		return;
>
> @@ -1455,7 +1454,24 @@ static void isc_awb_work(struct work_struct *w)
>  	}
>  	regmap_write(regmap, ISC_HIS_CFG + isc->offsets.his,
>  		     hist_id | baysel | ISC_HIS_CFG_RAR);
> +
> +	/*
> +	 * We have to make sure the streaming has not stopped meanwhile.
> +	 * ISC requires a frame to clock the internal profile update.
> +	 * To avoid issues, lock the sequence with a mutex
> +	 */
> +	mutex_lock(&isc->awb_mutex);
> +
> +	/* streaming is not active anymore */
> +	if (isc->stop) {
> +		mutex_unlock(&isc->awb_mutex);
> +		return;
> +	};
> +
>  	isc_update_profile(isc);
> +
> +	mutex_unlock(&isc->awb_mutex);
> +
>  	/* if awb has been disabled, we don't need to start another histogram */
>  	if (ctrls->awb)
>  		regmap_write(regmap, ISC_CTRLEN, ISC_CTRL_HISREQ);
> @@ -1548,6 +1564,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
>  			 */
>  			v4l2_ctrl_activate(isc->do_wb_ctrl, false);
>  		}
> +		mutex_unlock(&isc->awb_mutex);
>
>  		/* if we have autowhitebalance on, start histogram procedure */
>  		if (ctrls->awb == ISC_WB_AUTO &&
> @@ -1740,6 +1757,7 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
>  {
>  	struct isc_device *isc = container_of(notifier->v4l2_dev,
>  					      struct isc_device, v4l2_dev);
> +	mutex_destroy(&isc->awb_mutex);
>  	cancel_work_sync(&isc->awb_work);
>  	video_unregister_device(&isc->video_dev);
>  	v4l2_ctrl_handler_free(&isc->ctrls.handler);
> @@ -1850,6 +1868,8 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>  	isc->current_subdev = container_of(notifier,
>  					   struct isc_subdev_entity, notifier);
>  	mutex_init(&isc->lock);
> +	mutex_init(&isc->awb_mutex);
> +
>  	init_completion(&isc->comp);
>
>  	/* Initialize videobuf2 queue */
> @@ -1929,6 +1949,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>  	video_unregister_device(vdev);
>
>  isc_async_complete_err:
> +	mutex_destroy(&isc->awb_mutex);
>  	mutex_destroy(&isc->lock);
>  	return ret;
>  }
> diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
> index c1ca3916700e..ac8c8679dd53 100644
> --- a/drivers/media/platform/atmel/atmel-isc.h
> +++ b/drivers/media/platform/atmel/atmel-isc.h
> @@ -229,6 +229,7 @@ enum isc_scaler_pads {
>   *
>   * @lock:		lock for serializing userspace file operations
>   *			with ISC operations
> + * @awb_mutex:		serialize access to streaming status from awb work queue
>   * @awb_lock:		lock for serializing awb work queue operations
>   *			with DMA/buffer operations
>   *
> @@ -309,6 +310,7 @@ struct isc_device {
>  	struct work_struct	awb_work;
>
>  	struct mutex		lock;
> +	struct mutex		awb_mutex;
>  	spinlock_t		awb_lock;
>
>  	struct regmap_field	*pipeline[ISC_PIPE_LINE_NODE_NUM];
> --
> 2.25.1
>
