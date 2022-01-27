Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B733149DDC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbiA0JUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiA0JUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:20:54 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D15C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:20:53 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b22so2009112qkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQu/7MfSkpkDbURRmfMl4HGuNbYYNwsLfuKYo7AN758=;
        b=Y228d3gIwmmWIxPFvPOHM6QkchBcecMW6/rDkf5jJRtRp1n7kjv/zIO3jGisjE+Twx
         LcRm5sgU41fREGYJUDOIXT4bkbbl1KZu54gBzlDhjcb0/M2kJ4bFqd0RncHTJhVz7CQe
         JH7WvupVrqMTBA7NMEqT1pBplRK/ARuHZrXIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQu/7MfSkpkDbURRmfMl4HGuNbYYNwsLfuKYo7AN758=;
        b=gK1Um43BtjMxrMDsIL7/sn6yW3UKB++TcmqKvQwDW5UVaxz5bm7vgKRhzRyth59LOt
         k6hZo0oPUzt+1fdA8HygwbFP8he/enOyg7sEpp+UoTYomgFrfwx5Wr8uKvchxHzH0ayg
         vGVXw7sHSiBNy0oA+k89orPXnzWMx8vVuji+qewVkU9H2X1FxJ+DqWYM6Hg1vOoLz7mg
         qepC64NpEWiY59QNw64j9LwaDfLAgzhUaaBxXVT1IsQYAIRpRQLQyMKUAVVQgAICeSuj
         Xsga1+UsN04nhTuL6v96k5ia5csgqhxMzShWo1xbC2g3J1YAzEgddUOmfv5PFiZiGDeZ
         LJQw==
X-Gm-Message-State: AOAM533c8SV4O07VsDu32sWuwl5ozSjAMPj/1zitptBaLJcDu+hzEW1P
        dt/foPkNeBIvs2yrbbwtrxoymmsnRpAzbOik
X-Google-Smtp-Source: ABdhPJxM/QLpyGQxDw6GTdef9AymNDhTlibruDbP6BxUum56K2budjeGeifo653eAxEk7E5ligD/Jg==
X-Received: by 2002:ae9:e886:: with SMTP id a128mr1904142qkg.37.1643275252598;
        Thu, 27 Jan 2022 01:20:52 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id m4sm1042339qka.111.2022.01.27.01.20.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 01:20:52 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id h14so6603962ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:20:52 -0800 (PST)
X-Received: by 2002:a25:99c1:: with SMTP id q1mr4522404ybo.620.1643275251516;
 Thu, 27 Jan 2022 01:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20220124190013.221601-1-ribalda@chromium.org> <20220124190013.221601-2-ribalda@chromium.org>
In-Reply-To: <20220124190013.221601-2-ribalda@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 27 Jan 2022 18:20:40 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ArFap+9+zS3Wg8=io9m0xfTZf=V082ZNoYRiOAviajuA@mail.gmail.com>
Message-ID: <CAAFQd5ArFap+9+zS3Wg8=io9m0xfTZf=V082ZNoYRiOAviajuA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] media: uvcvideo: Do power management granularly
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 4:07 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Instead of suspending/resume the USB device at open()/close(), do it
> when the device is actually used.
>
> This way we can reduce the power consumption when a service is holding
> the video device and leaving it in an idle state.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 199 +++++++++++++++++++++++++------
>  drivers/media/usb/uvc/uvcvideo.h |   1 +
>  2 files changed, 166 insertions(+), 34 deletions(-)

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

>
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 711556d13d03..48217e47646f 100644
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
> +       int ret = 0;
> +
> +       if (!video_is_registered(&stream->vdev))
> +               return -ENODEV;
> +
> +       /*
> +        * We cannot hold dev->lock when calling autopm_get_interface.
> +        */
> +       ret = usb_autopm_get_interface(stream->dev->intf);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&stream->dev->lock);
> +       if (!stream->dev->users)
> +               ret = uvc_status_start(stream->dev, GFP_KERNEL);
> +       if (!ret)
> +               stream->dev->users++;
> +       mutex_unlock(&stream->dev->lock);
> +
> +       if (ret)
> +               usb_autopm_put_interface(stream->dev->intf);
> +
> +       return ret;
> +}
> +
> +static void uvc_pm_put(struct uvc_streaming *stream)
> +{
> +       if (!video_is_registered(&stream->vdev))
> +               return;
> +
> +       mutex_lock(&stream->dev->lock);
> +       if (WARN_ON(!stream->dev->users)) {
> +               mutex_unlock(&stream->dev->lock);
> +               return;
> +       }
> +       stream->dev->users--;
> +       if (!stream->dev->users)
> +               uvc_status_stop(stream->dev);
> +       mutex_unlock(&stream->dev->lock);
> +
> +       usb_autopm_put_interface(stream->dev->intf);
> +}
> +
>  /* ------------------------------------------------------------------------
>   * UVC ioctls
>   */
> @@ -251,8 +300,14 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
>                         stream->ctrl.dwMaxVideoFrameSize;
>
>         /* Probe the device. */
> +       ret = uvc_pm_get(stream);
> +       if (ret) {
> +               mutex_unlock(&stream->mutex);
> +               goto done;
> +       }
>         ret = uvc_probe_video(stream, probe);
>         mutex_unlock(&stream->mutex);
> +       uvc_pm_put(stream);
>         if (ret < 0)
>                 goto done;
>
> @@ -464,7 +519,13 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
>         }
>
>         /* Probe the device with the new settings. */
> +       ret = uvc_pm_get(stream);
> +       if (ret) {
> +               mutex_unlock(&stream->mutex);
> +               return ret;
> +       }
>         ret = uvc_probe_video(stream, &probe);
> +       uvc_pm_put(stream);
>         if (ret < 0) {
>                 mutex_unlock(&stream->mutex);
>                 return ret;
> @@ -555,36 +616,24 @@ static int uvc_v4l2_open(struct file *file)
>  {
>         struct uvc_streaming *stream;
>         struct uvc_fh *handle;
> -       int ret = 0;
>
>         stream = video_drvdata(file);
>         uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
>
> -       ret = usb_autopm_get_interface(stream->dev->intf);
> -       if (ret < 0)
> -               return ret;
> -
>         /* Create the device handle. */
>         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> -       if (handle == NULL) {
> -               usb_autopm_put_interface(stream->dev->intf);
> +       if (!handle)
>                 return -ENOMEM;
> -       }
>
> -       mutex_lock(&stream->dev->lock);
> -       if (stream->dev->users == 0) {
> -               ret = uvc_status_start(stream->dev, GFP_KERNEL);
> -               if (ret < 0) {
> -                       mutex_unlock(&stream->dev->lock);
> -                       usb_autopm_put_interface(stream->dev->intf);
> -                       kfree(handle);
> -                       return ret;
> -               }
> +       /*
> +        * If the uvc evdev exists we cannot suspend when the device
> +        * is idle. Otherwise we will miss button actions.
> +        */
> +       if (stream->dev->input && uvc_pm_get(stream)) {
> +               kfree(handle);
> +               return -ENODEV;
>         }
>
> -       stream->dev->users++;
> -       mutex_unlock(&stream->dev->lock);
> -
>         v4l2_fh_init(&handle->vfh, &stream->vdev);
>         v4l2_fh_add(&handle->vfh);
>         handle->chain = stream->chain;
> @@ -606,6 +655,12 @@ static int uvc_v4l2_release(struct file *file)
>         if (uvc_has_privileges(handle))
>                 uvc_queue_release(&stream->queue);
>
> +       if (handle->is_streaming)
> +               uvc_pm_put(stream);
> +
> +       if (stream->dev->input)
> +               uvc_pm_put(stream);
> +
>         /* Release the file handle. */
>         uvc_dismiss_privileges(handle);
>         v4l2_fh_del(&handle->vfh);
> @@ -613,12 +668,6 @@ static int uvc_v4l2_release(struct file *file)
>         kfree(handle);
>         file->private_data = NULL;
>
> -       mutex_lock(&stream->dev->lock);
> -       if (--stream->dev->users == 0)
> -               uvc_status_stop(stream->dev);
> -       mutex_unlock(&stream->dev->lock);
> -
> -       usb_autopm_put_interface(stream->dev->intf);
>         return 0;
>  }
>
> @@ -842,7 +891,21 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
>                 return -EBUSY;
>
>         mutex_lock(&stream->mutex);
> +       if (!handle->is_streaming) {
> +               ret = uvc_pm_get(stream);
> +               if (ret)
> +                       goto unlock;
> +       }
> +
>         ret = uvc_queue_streamon(&stream->queue, type);
> +
> +       if (ret && !handle->is_streaming)
> +               uvc_pm_put(stream);
> +
> +       if (!ret)
> +               handle->is_streaming = true;
> +
> +unlock:
>         mutex_unlock(&stream->mutex);
>
>         return ret;
> @@ -859,6 +922,10 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
>
>         mutex_lock(&stream->mutex);
>         uvc_queue_streamoff(&stream->queue, type);
> +       if (handle->is_streaming) {
> +               handle->is_streaming = false;
> +               uvc_pm_put(stream);
> +       }
>         mutex_unlock(&stream->mutex);
>
>         return 0;
> @@ -909,6 +976,7 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
>  {
>         struct uvc_fh *handle = fh;
>         struct uvc_video_chain *chain = handle->chain;
> +       struct uvc_streaming *stream = handle->stream;
>         u8 *buf;
>         int ret;
>
> @@ -922,9 +990,16 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
>         if (!buf)
>                 return -ENOMEM;
>
> +       ret = uvc_pm_get(stream);
> +       if (ret) {
> +               kfree(buf);
> +               return ret;
> +       }
> +
>         ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, chain->selector->id,
>                              chain->dev->intfnum,  UVC_SU_INPUT_SELECT_CONTROL,
>                              buf, 1);
> +       uvc_pm_put(stream);
>         if (!ret)
>                 *input = *buf - 1;
>
> @@ -937,6 +1012,7 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
>  {
>         struct uvc_fh *handle = fh;
>         struct uvc_video_chain *chain = handle->chain;
> +       struct uvc_streaming *stream = handle->stream;
>         u8 *buf;
>         int ret;
>
> @@ -958,10 +1034,17 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
>         if (!buf)
>                 return -ENOMEM;
>
> +       ret = uvc_pm_get(stream);
> +       if (ret) {
> +               kfree(buf);
> +               return ret;
> +       }
> +
>         *buf = input + 1;
>         ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, chain->selector->id,
>                              chain->dev->intfnum, UVC_SU_INPUT_SELECT_CONTROL,
>                              buf, 1);
> +       uvc_pm_put(stream);
>         kfree(buf);
>
>         return ret;
> @@ -972,8 +1055,15 @@ static int uvc_ioctl_queryctrl(struct file *file, void *fh,
>  {
>         struct uvc_fh *handle = fh;
>         struct uvc_video_chain *chain = handle->chain;
> +       struct uvc_streaming *stream = handle->stream;
> +       int ret;
>
> -       return uvc_query_v4l2_ctrl(chain, qc);
> +       ret = uvc_pm_get(stream);
> +       if (ret)
> +               return ret;
> +       ret = uvc_query_v4l2_ctrl(chain, qc);
> +       uvc_pm_put(stream);
> +       return ret;
>  }
>
>  static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
> @@ -981,10 +1071,15 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
>  {
>         struct uvc_fh *handle = fh;
>         struct uvc_video_chain *chain = handle->chain;
> +       struct uvc_streaming *stream = handle->stream;
>         struct v4l2_queryctrl qc = { qec->id };
>         int ret;
>
> +       ret = uvc_pm_get(stream);
> +       if (ret)
> +               return ret;
>         ret = uvc_query_v4l2_ctrl(chain, &qc);
> +       uvc_pm_put(stream);
>         if (ret)
>                 return ret;
>
> @@ -1030,6 +1125,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
>  {
>         struct uvc_fh *handle = fh;
>         struct uvc_video_chain *chain = handle->chain;
> +       struct uvc_streaming *stream = handle->stream;
>         struct v4l2_ext_control *ctrl = ctrls->controls;
>         unsigned int i;
>         int ret;
> @@ -1054,22 +1150,30 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
>                 return 0;
>         }
>
> +       ret = uvc_pm_get(stream);
> +       if (ret)
> +               return ret;
>         ret = uvc_ctrl_begin(chain);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               uvc_pm_put(stream);
>                 return ret;
> +       }
>
>         for (i = 0; i < ctrls->count; ++ctrl, ++i) {
>                 ret = uvc_ctrl_get(chain, ctrl);
>                 if (ret < 0) {
>                         uvc_ctrl_rollback(handle);
>                         ctrls->error_idx = i;
> +                       uvc_pm_put(stream);
>                         return ret;
>                 }
>         }
>
>         ctrls->error_idx = 0;
>
> -       return uvc_ctrl_rollback(handle);
> +       ret = uvc_ctrl_rollback(handle);
> +       uvc_pm_put(stream);
> +       return ret;
>  }
>
>  static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> @@ -1078,6 +1182,7 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>  {
>         struct v4l2_ext_control *ctrl = ctrls->controls;
>         struct uvc_video_chain *chain = handle->chain;
> +       struct uvc_streaming *stream = handle->stream;
>         unsigned int i;
>         int ret;
>
> @@ -1085,9 +1190,15 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>         if (ret < 0)
>                 return ret;
>
> +       ret = uvc_pm_get(stream);
> +       if (ret)
> +               return ret;
> +
>         ret = uvc_ctrl_begin(chain);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               uvc_pm_put(stream);
>                 return ret;
> +       }
>
>         for (i = 0; i < ctrls->count; ++ctrl, ++i) {
>                 ret = uvc_ctrl_set(handle, ctrl);
> @@ -1095,6 +1206,7 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>                         uvc_ctrl_rollback(handle);
>                         ctrls->error_idx = ioctl == VIDIOC_S_EXT_CTRLS ?
>                                                     ctrls->count : i;
> +                       uvc_pm_put(stream);
>                         return ret;
>                 }
>         }
> @@ -1102,9 +1214,12 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>         ctrls->error_idx = 0;
>
>         if (ioctl == VIDIOC_S_EXT_CTRLS)
> -               return uvc_ctrl_commit(handle, ctrls);
> +               ret = uvc_ctrl_commit(handle, ctrls);
>         else
> -               return uvc_ctrl_rollback(handle);
> +               ret = uvc_ctrl_rollback(handle);
> +
> +       uvc_pm_put(stream);
> +       return ret;
>  }
>
>  static int uvc_ioctl_s_ext_ctrls(struct file *file, void *fh,
> @@ -1119,8 +1234,16 @@ static int uvc_ioctl_try_ext_ctrls(struct file *file, void *fh,
>                                    struct v4l2_ext_controls *ctrls)
>  {
>         struct uvc_fh *handle = fh;
> +       struct uvc_streaming *stream = handle->stream;
> +       int ret;
> +
> +       ret = uvc_pm_get(stream);
> +       if (ret)
> +               return ret;
> +       ret = uvc_ioctl_s_try_ext_ctrls(handle, ctrls, VIDIOC_TRY_EXT_CTRLS);
> +       uvc_pm_put(stream);
>
> -       return uvc_ioctl_s_try_ext_ctrls(handle, ctrls, VIDIOC_TRY_EXT_CTRLS);
> +       return ret;
>  }
>
>  static int uvc_ioctl_querymenu(struct file *file, void *fh,
> @@ -1128,8 +1251,16 @@ static int uvc_ioctl_querymenu(struct file *file, void *fh,
>  {
>         struct uvc_fh *handle = fh;
>         struct uvc_video_chain *chain = handle->chain;
> +       struct uvc_streaming *stream = handle->stream;
> +       int ret;
>
> -       return uvc_query_v4l2_menu(chain, qm);
> +       ret = uvc_pm_get(stream);
> +       if (ret)
> +               return ret;
> +       ret = uvc_query_v4l2_menu(chain, qm);
> +       uvc_pm_put(stream);
> +
> +       return ret;
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
>         struct v4l2_fh vfh;
> +       bool is_streaming;
>         struct uvc_video_chain *chain;
>         struct uvc_streaming *stream;
>         enum uvc_handle_state state;
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>
