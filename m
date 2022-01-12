Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7548C089
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351869AbiALI5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:57:46 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:51613 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351894AbiALI5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:57:41 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A6F29C0006;
        Wed, 12 Jan 2022 08:57:34 +0000 (UTC)
Date:   Wed, 12 Jan 2022 09:58:35 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, robh+dt@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 17/23] media: atmel: atmel-isc-base: use mutex to lock
 awb workqueue from streaming
Message-ID: <20220112085835.twjhxjnigl3uhgqj@uno.localdomain>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-18-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213134940.324266-18-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Mon, Dec 13, 2021 at 03:49:34PM +0200, Eugen Hristev wrote:
> The AWB workqueue runs in a kernel thread and needs to be synchronized
> w.r.t. the streaming status.
> It is possible that streaming is stopped while the AWB workq is running.
> In this case it is likely that the check for isc->stop is done at one point
> in time, but the AWB computations are done later, including a call to
> isc_update_profile, which requires streaming to be started.
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
> ---
>  drivers/media/platform/atmel/atmel-isc-base.c | 31 ++++++++++++++++---
>  drivers/media/platform/atmel/atmel-isc.h      |  1 +
>  2 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> index b0c3ed21f372..53cac1aac0fd 100644
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
> @@ -1416,10 +1419,6 @@ static void isc_awb_work(struct work_struct *w)
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
> @@ -1470,7 +1469,24 @@ static void isc_awb_work(struct work_struct *w)
>  	}
>  	regmap_write(regmap, ISC_HIS_CFG + isc->offsets.his,
>  		     hist_id | baysel | ISC_HIS_CFG_RAR);

isc_stop_streaming() calls runtime_put and here you access the hw.

Feels like it's safer to hold the mutex for the whole duration of the
AWB routine ?

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
> @@ -1549,6 +1565,8 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
>
>  		isc_update_awb_ctrls(isc);
>
> +		mutex_lock(&isc->awb_mutex);
> +
>  		if (!isc->stop) {
>  			/*
>  			 * If we are streaming, we can update profile to
> @@ -1563,6 +1581,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
>  			 */
>  			v4l2_ctrl_activate(isc->do_wb_ctrl, false);
>  		}
> +		mutex_unlock(&isc->awb_mutex);
>
>  		/* if we have autowhitebalance on, start histogram procedure */
>  		if (ctrls->awb == ISC_WB_AUTO && !isc->stop &&
> @@ -1754,6 +1773,7 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
>  {
>  	struct isc_device *isc = container_of(notifier->v4l2_dev,
>  					      struct isc_device, v4l2_dev);
> +	mutex_destroy(&isc->awb_mutex);
>  	cancel_work_sync(&isc->awb_work);
>  	video_unregister_device(&isc->video_dev);
>  	v4l2_ctrl_handler_free(&isc->ctrls.handler);
> @@ -1866,6 +1886,8 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>  	isc->current_subdev = container_of(notifier,
>  					   struct isc_subdev_entity, notifier);
>  	mutex_init(&isc->lock);
> +	mutex_init(&isc->awb_mutex);
> +
>  	init_completion(&isc->comp);
>
>  	/* Initialize videobuf2 queue */
> @@ -1941,6 +1963,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>  	video_unregister_device(vdev);
>
>  isc_async_complete_err:
> +	mutex_destroy(&isc->awb_mutex);
>  	mutex_destroy(&isc->lock);
>  	return ret;
>  }
> diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
> index 0b6370d7775f..c2cb805faff3 100644
> --- a/drivers/media/platform/atmel/atmel-isc.h
> +++ b/drivers/media/platform/atmel/atmel-isc.h
> @@ -307,6 +307,7 @@ struct isc_device {
>  	struct work_struct	awb_work;
>
>  	struct mutex		lock; /* serialize access to file operations */
> +	struct mutex		awb_mutex; /* serialize access to streaming status from awb work queue */
>  	spinlock_t		awb_lock; /* serialize access to DMA buffers from awb work queue */
>
>  	struct regmap_field	*pipeline[ISC_PIPE_LINE_NODE_NUM];
> --
> 2.25.1
>
