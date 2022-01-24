Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADD649835B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbiAXPO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:14:59 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:55004 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240588AbiAXPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:14:58 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6756B1529;
        Mon, 24 Jan 2022 16:14:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643037296;
        bh=QzguhOsWKcDPKL1U0eTNS+68gbDPzvjUYAkS0EkT4B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpxLcYbITqD4M12snwkGuj4bQ/1T7shRCNqweDuuL3YG9uj5aCR0cprBzEtmFeZzp
         LkrOvCcbH9Q9XENCws0aAQI5hOdfBvHmdyrTkVh56K9NLExWC+k6lnkEuf+rHG65+X
         8sW/l1Id6lOGyRpaLVirK8uMKVzRtZCxFmDxotn0=
Date:   Mon, 24 Jan 2022 17:14:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Do power management granularly
Message-ID: <Ye7CXovFQMm9q4F6@pendragon.ideasonboard.com>
References: <20220124144539.180822-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124144539.180822-1-ribalda@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Mon, Jan 24, 2022 at 03:45:39PM +0100, Ricardo Ribalda wrote:
> Instead of suspending/resume the USB device at open()/close(), do it
> when the device is actually used.
> 
> This way we can reduce the power consumption when a service is holding
> the video device and leaving it in an idle state.

Won't this prevent receiving button events ?

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 191 +++++++++++++++++++++++++------
>  drivers/media/usb/uvc/uvcvideo.h |   1 +
>  2 files changed, 156 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 711556d13d03..4fcfc9a24e7f 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -25,6 +25,55 @@
>  
>  #include "uvcvideo.h"
>  
> +/* ------------------------------------------------------------------------
> + * UVC power management
> + */
> +
> +static int uvc_pm_get(struct uvc_streaming *stream)
> +{
> +	int ret = 0;
> +
> +	if (!video_is_registered(&stream->vdev))
> +		return -ENODEV;
> +
> +	/*
> +	 * We cannot hold dev->lock when calling autopm_get_interface.
> +	 */
> +	ret = usb_autopm_get_interface(stream->dev->intf);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&stream->dev->lock);
> +	if (!stream->dev->users)
> +		ret = uvc_status_start(stream->dev, GFP_KERNEL);
> +	if (!ret)
> +		stream->dev->users++;
> +	mutex_unlock(&stream->dev->lock);
> +
> +	if (ret)
> +		usb_autopm_put_interface(stream->dev->intf);
> +
> +	return ret;
> +}
> +
> +static void uvc_pm_put(struct uvc_streaming *stream)
> +{
> +	if (!video_is_registered(&stream->vdev))
> +		return;
> +
> +	mutex_lock(&stream->dev->lock);
> +	if (WARN_ON(!stream->dev->users)) {
> +		mutex_unlock(&stream->dev->lock);
> +		return;
> +	}
> +	stream->dev->users--;
> +	if (!stream->dev->users)
> +		uvc_status_stop(stream->dev);
> +	mutex_unlock(&stream->dev->lock);
> +
> +	usb_autopm_put_interface(stream->dev->intf);
> +}
> +
>  /* ------------------------------------------------------------------------
>   * UVC ioctls
>   */
> @@ -251,8 +300,14 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
>  			stream->ctrl.dwMaxVideoFrameSize;
>  
>  	/* Probe the device. */
> +	ret = uvc_pm_get(stream);
> +	if (ret) {
> +		mutex_unlock(&stream->mutex);
> +		goto done;
> +	}
>  	ret = uvc_probe_video(stream, probe);
>  	mutex_unlock(&stream->mutex);
> +	uvc_pm_put(stream);
>  	if (ret < 0)
>  		goto done;
>  
> @@ -464,7 +519,13 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
>  	}
>  
>  	/* Probe the device with the new settings. */
> +	ret = uvc_pm_get(stream);
> +	if (ret) {
> +		mutex_unlock(&stream->mutex);
> +		return ret;
> +	}
>  	ret = uvc_probe_video(stream, &probe);
> +	uvc_pm_put(stream);
>  	if (ret < 0) {
>  		mutex_unlock(&stream->mutex);
>  		return ret;
> @@ -555,35 +616,14 @@ static int uvc_v4l2_open(struct file *file)
>  {
>  	struct uvc_streaming *stream;
>  	struct uvc_fh *handle;
> -	int ret = 0;
>  
>  	stream = video_drvdata(file);
>  	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
>  
> -	ret = usb_autopm_get_interface(stream->dev->intf);
> -	if (ret < 0)
> -		return ret;
> -
>  	/* Create the device handle. */
>  	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> -	if (handle == NULL) {
> -		usb_autopm_put_interface(stream->dev->intf);
> +	if (!handle)
>  		return -ENOMEM;
> -	}
> -
> -	mutex_lock(&stream->dev->lock);
> -	if (stream->dev->users == 0) {
> -		ret = uvc_status_start(stream->dev, GFP_KERNEL);
> -		if (ret < 0) {
> -			mutex_unlock(&stream->dev->lock);
> -			usb_autopm_put_interface(stream->dev->intf);
> -			kfree(handle);
> -			return ret;
> -		}
> -	}
> -
> -	stream->dev->users++;
> -	mutex_unlock(&stream->dev->lock);
>  
>  	v4l2_fh_init(&handle->vfh, &stream->vdev);
>  	v4l2_fh_add(&handle->vfh);
> @@ -606,6 +646,9 @@ static int uvc_v4l2_release(struct file *file)
>  	if (uvc_has_privileges(handle))
>  		uvc_queue_release(&stream->queue);
>  
> +	if (handle->is_streaming)
> +		uvc_pm_put(stream);
> +
>  	/* Release the file handle. */
>  	uvc_dismiss_privileges(handle);
>  	v4l2_fh_del(&handle->vfh);
> @@ -613,12 +656,6 @@ static int uvc_v4l2_release(struct file *file)
>  	kfree(handle);
>  	file->private_data = NULL;
>  
> -	mutex_lock(&stream->dev->lock);
> -	if (--stream->dev->users == 0)
> -		uvc_status_stop(stream->dev);
> -	mutex_unlock(&stream->dev->lock);
> -
> -	usb_autopm_put_interface(stream->dev->intf);
>  	return 0;
>  }
>  
> @@ -842,7 +879,21 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
>  		return -EBUSY;
>  
>  	mutex_lock(&stream->mutex);
> +	if (!handle->is_streaming) {
> +		ret = uvc_pm_get(stream);
> +		if (ret)
> +			goto unlock;
> +	}
> +
>  	ret = uvc_queue_streamon(&stream->queue, type);
> +
> +	if (ret && !handle->is_streaming)
> +		uvc_pm_put(stream);
> +
> +	if (!ret)
> +		handle->is_streaming = true;
> +
> +unlock:
>  	mutex_unlock(&stream->mutex);
>  
>  	return ret;
> @@ -859,6 +910,10 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
>  
>  	mutex_lock(&stream->mutex);
>  	uvc_queue_streamoff(&stream->queue, type);
> +	if (handle->is_streaming) {
> +		handle->is_streaming = false;
> +		uvc_pm_put(stream);
> +	}
>  	mutex_unlock(&stream->mutex);
>  
>  	return 0;
> @@ -909,6 +964,7 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
>  	u8 *buf;
>  	int ret;
>  
> @@ -922,9 +978,16 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
>  	if (!buf)
>  		return -ENOMEM;
>  
> +	ret = uvc_pm_get(stream);
> +	if (ret) {
> +		kfree(buf);
> +		return ret;
> +	}
> +
>  	ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, chain->selector->id,
>  			     chain->dev->intfnum,  UVC_SU_INPUT_SELECT_CONTROL,
>  			     buf, 1);
> +	uvc_pm_put(stream);
>  	if (!ret)
>  		*input = *buf - 1;
>  
> @@ -937,6 +1000,7 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
>  	u8 *buf;
>  	int ret;
>  
> @@ -958,10 +1022,17 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
>  	if (!buf)
>  		return -ENOMEM;
>  
> +	ret = uvc_pm_get(stream);
> +	if (ret) {
> +		kfree(buf);
> +		return ret;
> +	}
> +
>  	*buf = input + 1;
>  	ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, chain->selector->id,
>  			     chain->dev->intfnum, UVC_SU_INPUT_SELECT_CONTROL,
>  			     buf, 1);
> +	uvc_pm_put(stream);
>  	kfree(buf);
>  
>  	return ret;
> @@ -972,8 +1043,15 @@ static int uvc_ioctl_queryctrl(struct file *file, void *fh,
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
> +	int ret;
>  
> -	return uvc_query_v4l2_ctrl(chain, qc);
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
> +	ret = uvc_query_v4l2_ctrl(chain, qc);
> +	uvc_pm_put(stream);
> +	return ret;
>  }
>  
>  static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
> @@ -981,10 +1059,15 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
>  	struct v4l2_queryctrl qc = { qec->id };
>  	int ret;
>  
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
>  	ret = uvc_query_v4l2_ctrl(chain, &qc);
> +	uvc_pm_put(stream);
>  	if (ret)
>  		return ret;
>  
> @@ -1030,6 +1113,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
>  	struct v4l2_ext_control *ctrl = ctrls->controls;
>  	unsigned int i;
>  	int ret;
> @@ -1054,22 +1138,30 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
>  		return 0;
>  	}
>  
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
>  	ret = uvc_ctrl_begin(chain);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		uvc_pm_put(stream);
>  		return ret;
> +	}
>  
>  	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
>  		ret = uvc_ctrl_get(chain, ctrl);
>  		if (ret < 0) {
>  			uvc_ctrl_rollback(handle);
>  			ctrls->error_idx = i;
> +			uvc_pm_put(stream);
>  			return ret;
>  		}
>  	}
>  
>  	ctrls->error_idx = 0;
>  
> -	return uvc_ctrl_rollback(handle);
> +	ret = uvc_ctrl_rollback(handle);
> +	uvc_pm_put(stream);
> +	return ret;
>  }
>  
>  static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> @@ -1078,6 +1170,7 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>  {
>  	struct v4l2_ext_control *ctrl = ctrls->controls;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
>  	unsigned int i;
>  	int ret;
>  
> @@ -1085,9 +1178,15 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
> +
>  	ret = uvc_ctrl_begin(chain);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		uvc_pm_put(stream);
>  		return ret;
> +	}
>  
>  	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
>  		ret = uvc_ctrl_set(handle, ctrl);
> @@ -1095,6 +1194,7 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>  			uvc_ctrl_rollback(handle);
>  			ctrls->error_idx = ioctl == VIDIOC_S_EXT_CTRLS ?
>  						    ctrls->count : i;
> +			uvc_pm_put(stream);
>  			return ret;
>  		}
>  	}
> @@ -1102,9 +1202,12 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>  	ctrls->error_idx = 0;
>  
>  	if (ioctl == VIDIOC_S_EXT_CTRLS)
> -		return uvc_ctrl_commit(handle, ctrls);
> +		ret = uvc_ctrl_commit(handle, ctrls);
>  	else
> -		return uvc_ctrl_rollback(handle);
> +		ret = uvc_ctrl_rollback(handle);
> +
> +	uvc_pm_put(stream);
> +	return ret;
>  }
>  
>  static int uvc_ioctl_s_ext_ctrls(struct file *file, void *fh,
> @@ -1119,8 +1222,16 @@ static int uvc_ioctl_try_ext_ctrls(struct file *file, void *fh,
>  				   struct v4l2_ext_controls *ctrls)
>  {
>  	struct uvc_fh *handle = fh;
> +	struct uvc_streaming *stream = handle->stream;
> +	int ret;
> +
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
> +	ret = uvc_ioctl_s_try_ext_ctrls(handle, ctrls, VIDIOC_TRY_EXT_CTRLS);
> +	uvc_pm_put(stream);
>  
> -	return uvc_ioctl_s_try_ext_ctrls(handle, ctrls, VIDIOC_TRY_EXT_CTRLS);
> +	return ret;
>  }
>  
>  static int uvc_ioctl_querymenu(struct file *file, void *fh,
> @@ -1128,8 +1239,16 @@ static int uvc_ioctl_querymenu(struct file *file, void *fh,
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
> +	int ret;
>  
> -	return uvc_query_v4l2_menu(chain, qm);
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
> +	ret = uvc_query_v4l2_menu(chain, qm);
> +	uvc_pm_put(stream);
> +
> +	return ret;
>  }
>  
>  static int uvc_ioctl_g_selection(struct file *file, void *fh,
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 143230b3275b..5958b2a54dab 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -720,6 +720,7 @@ enum uvc_handle_state {
>  
>  struct uvc_fh {
>  	struct v4l2_fh vfh;
> +	bool is_streaming;
>  	struct uvc_video_chain *chain;
>  	struct uvc_streaming *stream;
>  	enum uvc_handle_state state;

-- 
Regards,

Laurent Pinchart
