Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084B448B15C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349655AbiAKPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:53:44 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.168]:61518 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343654AbiAKPxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:53:42 -0500
X-KPN-MessageId: 8da454f4-72f6-11ec-8862-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 8da454f4-72f6-11ec-8862-005056aba152;
        Tue, 11 Jan 2022 16:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=mVdBKq941lH1RljJoRLz7YFt47OS4LC0wZ46bPhLPMk=;
        b=eKkbIzjCqCaimnaLOuVv4LpzfkHj9RkgJ81dFaJdlqidlQjGhpQDkoi5RlGlCVvNyDeyXzd4SU7Ym
         2B+N1Wi5G6FfmfLMyxCewQHfBCwG8Ga8qW9M9DcFdHsSmp4Ows7ES1iM6zz+Q3Yfhlrp/DNb3qPlfY
         6v2XSUI9i+shrN/df6SV8uxMTTcQ6Xa3qmq579sGaiESOv6g/oj6O7z/JRbraiYQQSHeosigtre5Q3
         /q6bIkHIqiCxhpI9NGI+Ay0YzJG2VKG4g/w7i9hJiIZf7ZVLe67pseyXS59Us0EEwFigtLFhh+P0LB
         ctObuVZL7kU7RkcDYAedMW6G407oBPA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jrUMIdbS0XQXMQaX8JQf1yXvyTD33F5lIxq+6/J8hcn9MMTBxWdIV9i06ciH35N
 bWycFAjZaaYUtbe25ObAnqw==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id a5358a2c-72f6-11ec-81f5-005056ab7447;
        Tue, 11 Jan 2022 16:53:40 +0100 (CET)
Message-ID: <c6adb59e-4554-dc08-3772-148eb22c29ba@xs4all.nl>
Date:   Tue, 11 Jan 2022 16:53:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v3 07/23] media: atmel: atmel-isc-base: use streaming
 status when queueing buffers
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        linux-media@vger.kernel.org, robh+dt@kernel.org, jacopo@jmondi.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        nicolas.ferre@microchip.com
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-8-eugen.hristev@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20211213134940.324266-8-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2021 14:49, Eugen Hristev wrote:
> During experiments with libcamera, it looks like vb2_is_streaming returns
> true before our start streaming is called.
> Order of operations is streamon -> queue -> start_streaming
> ISC would have started the DMA immediately when a buffer is being added
> to the vbqueue if the queue is streaming.
> It is more safe to start the DMA after the start streaming of the driver is
> called.
> Thus, even if vb2queue is streaming, add the buffer to the dma queue of the
> driver instead of actually starting the DMA process, if the start streaming
> has not been called yet.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/media/platform/atmel/atmel-isc-base.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> index 26a6090f056c..e6c9071c04f0 100644
> --- a/drivers/media/platform/atmel/atmel-isc-base.c
> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
> @@ -441,12 +441,14 @@ static void isc_buffer_queue(struct vb2_buffer *vb)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&isc->dma_queue_lock, flags);
> -	if (!isc->cur_frm && list_empty(&isc->dma_queue) &&
> -		vb2_is_streaming(vb->vb2_queue)) {
> +
> +	if (!isc->cur_frm && list_empty(&isc->dma_queue) && !isc->stop) {
>  		isc->cur_frm = buf;
>  		isc_start_dma(isc);
> -	} else
> +	} else {
>  		list_add_tail(&buf->list, &isc->dma_queue);
> +	}
> +
>  	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
>  }

Both the old and new code doesn't make a lot of sense.

buf_queue is only called by vb2 if start_streaming has already been called or is
about to be called.

Typically all that the buf_queue op does is to call list_add_tail(&buf->list, &isc->dma_queue);
inside the spinlock.

>  
> @@ -1014,7 +1016,7 @@ static int isc_s_fmt_vid_cap(struct file *file, void *priv,
>  {
>  	struct isc_device *isc = video_drvdata(file);
>  
> -	if (vb2_is_streaming(&isc->vb2_vidq))
> +	if (!isc->stop)

This is weird as well. Normally this calls vb2_is_busy to check if the
queue is busy (that really means that buffers are already allocated, so
changing the format isn't allowed anymore).

>  		return -EBUSY;
>  
>  	return isc_set_fmt(isc, f);
> @@ -1536,7 +1538,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
>  
>  		isc_update_awb_ctrls(isc);
>  
> -		if (vb2_is_streaming(&isc->vb2_vidq)) {
> +		if (!isc->stop) {

Ditto.

>  			/*
>  			 * If we are streaming, we can update profile to
>  			 * have the new settings in place.
> @@ -1552,8 +1554,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
>  		}
>  
>  		/* if we have autowhitebalance on, start histogram procedure */
> -		if (ctrls->awb == ISC_WB_AUTO &&
> -		    vb2_is_streaming(&isc->vb2_vidq) &&
> +		if (ctrls->awb == ISC_WB_AUTO && !isc->stop &&
>  		    ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
>  			isc_set_histogram(isc, true);
>  
> @@ -1829,6 +1830,8 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>  	struct vb2_queue *q = &isc->vb2_vidq;
>  	int ret = 0;
>  
> +	isc->stop = true;
> +

I'm really not sure that you need the stop bool at all.

>  	INIT_WORK(&isc->awb_work, isc_awb_work);
>  
>  	ret = v4l2_device_register_subdev_nodes(&isc->v4l2_dev);

Regards,

	Hans
