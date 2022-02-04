Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4AF4A9D65
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376782AbiBDRHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376768AbiBDRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:07:50 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F96FC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:07:50 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id d10so21308008eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEwW6P81U+oFEDwUNnn1+RRoTuc2+PWBJtU3dqd9WPE=;
        b=HSXGLrTQVR+/k1WeN5VEUxRfuDNaoyLLx6uv7kRXrFYcDqwJJJ0UbvsoQIKmrirbKD
         po6IkWeUbb7rLqVQRifeAHBrOxQn2nKPmngelC7i0qwnwtvaU/bf3yDwo5ggL24x71bc
         44Grr4QQogOgAPeVRSazua4KcTfQTEdGw//7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEwW6P81U+oFEDwUNnn1+RRoTuc2+PWBJtU3dqd9WPE=;
        b=J7Ls/8lJOpbyYRPM0lv2Ssjv8/Jc2+m2sAEWOlBiI1lpBzAudE3SQ/sFXOXdMkMEfN
         vGrZeHeRt0LRGoXUS8a5SCABKpOjryMXfrCbQyT9PiBkcT/B6ppRbmmHtLclYH+u0Qif
         TkTVrNQXSkpbbB/pk/3hiPjHl41neuptd3lp2W4HWz4dFGjerw3j8NjpvtZuRkFAhR7g
         A7962Dca5brGVsRiJGqjhElX4NSqBfX4tJ8avdEDUuiTHIFcW6mx0hugQgLHBMtwD4Ib
         xRlCmgVGBoP35OjzGrU4GzTqgWXeKDUhi7+D51jPQhtkp1+/DLa8udIGM40VTl8Zk2nu
         QvLw==
X-Gm-Message-State: AOAM533+lyN0sZaJquOnnfN3RX51EpSl04ObHBcj9LtYH3OwRRlx2cem
        03e1i+TNbVGD7Bt7b6SPkEtwJA==
X-Google-Smtp-Source: ABdhPJzX86F6TSlTYazKbKQtMXds3zrE/wNa6C4Sj6eMDP1GaQGwDAAl1prn3iqVMCD+fmx1TcbOow==
X-Received: by 2002:a17:906:bc97:: with SMTP id lv23mr3400608ejb.154.1643994468944;
        Fri, 04 Feb 2022 09:07:48 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id gv36sm840753ejc.94.2022.02.04.09.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 09:07:48 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 3/3] media: uvcvideo: Do power management granularly
Date:   Fri,  4 Feb 2022 18:07:45 +0100
Message-Id: <20220204170745.1269482-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220204170745.1269482-1-ribalda@chromium.org>
References: <20220204170745.1269482-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of suspending/resume the USB device at open()/close(), do it
when the device is actually used.

This way we can reduce the power consumption when a service is holding
the video device and leaving it in an idle state.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 179 +++++++++++++++++++++++++------
 1 file changed, 144 insertions(+), 35 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index ae1f221b2a5d..89bfadbe008b 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -25,6 +25,50 @@
 
 #include "uvcvideo.h"
 
+/* ------------------------------------------------------------------------
+ * UVC power management
+ */
+
+static int uvc_pm_get(struct uvc_streaming *stream)
+{
+	int ret = 0;
+
+	/*
+	 * We cannot hold dev->lock when calling autopm_get_interface.
+	 * _uvc_resume() takes the same lock.
+	 */
+	ret = usb_autopm_get_interface(stream->dev->intf);
+	if (ret)
+		return ret;
+
+	mutex_lock(&stream->dev->lock);
+	if (!stream->dev->users)
+		ret = uvc_status_start(stream->dev, GFP_KERNEL);
+	if (!ret)
+		stream->dev->users++;
+	mutex_unlock(&stream->dev->lock);
+
+	if (ret)
+		usb_autopm_put_interface(stream->dev->intf);
+
+	return ret;
+}
+
+static void uvc_pm_put(struct uvc_streaming *stream)
+{
+	mutex_lock(&stream->dev->lock);
+	if (WARN_ON(!stream->dev->users)) {
+		mutex_unlock(&stream->dev->lock);
+		return;
+	}
+	stream->dev->users--;
+	if (!stream->dev->users)
+		uvc_status_stop(stream->dev);
+	mutex_unlock(&stream->dev->lock);
+
+	usb_autopm_put_interface(stream->dev->intf);
+}
+
 /* ------------------------------------------------------------------------
  * UVC ioctls
  */
@@ -245,6 +289,9 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
 	 * developers test their webcams with the Linux driver as well as with
 	 * the Windows driver).
 	 */
+	ret = uvc_pm_get(stream);
+	if (ret)
+		goto done;
 	mutex_lock(&stream->mutex);
 	if (stream->dev->quirks & UVC_QUIRK_PROBE_EXTRAFIELDS)
 		probe->dwMaxVideoFrameSize =
@@ -253,6 +300,7 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
 	/* Probe the device. */
 	ret = uvc_probe_video(stream, probe);
 	mutex_unlock(&stream->mutex);
+	uvc_pm_put(stream);
 	if (ret < 0)
 		goto done;
 
@@ -464,7 +512,13 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
 	}
 
 	/* Probe the device with the new settings. */
+	ret = uvc_pm_get(stream);
+	if (ret) {
+		mutex_unlock(&stream->mutex);
+		return ret;
+	}
 	ret = uvc_probe_video(stream, &probe);
+	uvc_pm_put(stream);
 	if (ret < 0) {
 		mutex_unlock(&stream->mutex);
 		return ret;
@@ -555,36 +609,24 @@ static int uvc_v4l2_open(struct file *file)
 {
 	struct uvc_streaming *stream;
 	struct uvc_fh *handle;
-	int ret = 0;
 
 	stream = video_drvdata(file);
 	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
 
-	ret = usb_autopm_get_interface(stream->dev->intf);
-	if (ret < 0)
-		return ret;
-
 	/* Create the device handle. */
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (handle == NULL) {
-		usb_autopm_put_interface(stream->dev->intf);
+	if (!handle)
 		return -ENOMEM;
-	}
 
-	mutex_lock(&stream->dev->lock);
-	if (stream->dev->users == 0) {
-		ret = uvc_status_start(stream->dev, GFP_KERNEL);
-		if (ret < 0) {
-			mutex_unlock(&stream->dev->lock);
-			usb_autopm_put_interface(stream->dev->intf);
-			kfree(handle);
-			return ret;
-		}
+	/*
+	 * If the uvc evdev exists we cannot suspend when the device
+	 * is idle. Otherwise we will miss button actions.
+	 */
+	if (stream->dev->input && uvc_pm_get(stream)) {
+		kfree(handle);
+		return -ENODEV;
 	}
 
-	stream->dev->users++;
-	mutex_unlock(&stream->dev->lock);
-
 	v4l2_fh_init(&handle->vfh, &stream->vdev);
 	v4l2_fh_add(&handle->vfh);
 	handle->chain = stream->chain;
@@ -606,6 +648,12 @@ static int uvc_v4l2_release(struct file *file)
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
 
+	if (handle->is_streaming)
+		uvc_pm_put(stream);
+
+	if (stream->dev->input)
+		uvc_pm_put(stream);
+
 	/* Release the file handle. */
 	uvc_dismiss_privileges(handle);
 	v4l2_fh_del(&handle->vfh);
@@ -613,12 +661,6 @@ static int uvc_v4l2_release(struct file *file)
 	kfree(handle);
 	file->private_data = NULL;
 
-	mutex_lock(&stream->dev->lock);
-	if (--stream->dev->users == 0)
-		uvc_status_stop(stream->dev);
-	mutex_unlock(&stream->dev->lock);
-
-	usb_autopm_put_interface(stream->dev->intf);
 	return 0;
 }
 
@@ -845,9 +887,17 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
 
 	if (handle->is_streaming)
 		goto unlock;
+
+	ret = uvc_pm_get(stream);
+	if (ret)
+		goto unlock;
+
 	ret = uvc_queue_streamon(&stream->queue, type);
 	handle->is_streaming = !ret;
 
+	if (!handle->is_streaming)
+		uvc_pm_put(stream);
+
 unlock:
 	mutex_unlock(&stream->mutex);
 
@@ -871,6 +921,9 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
 	ret = uvc_queue_streamoff(&stream->queue, type);
 	handle->is_streaming = !!ret;
 
+	if (!handle->is_streaming)
+		uvc_pm_put(stream);
+
 unlock:
 	mutex_unlock(&stream->mutex);
 
@@ -922,6 +975,7 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	u8 *buf;
 	int ret;
 
@@ -935,9 +989,16 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
 	if (!buf)
 		return -ENOMEM;
 
+	ret = uvc_pm_get(stream);
+	if (ret) {
+		kfree(buf);
+		return ret;
+	}
+
 	ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, chain->selector->id,
 			     chain->dev->intfnum,  UVC_SU_INPUT_SELECT_CONTROL,
 			     buf, 1);
+	uvc_pm_put(stream);
 	if (!ret)
 		*input = *buf - 1;
 
@@ -950,6 +1011,7 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	u8 *buf;
 	int ret;
 
@@ -971,10 +1033,17 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
 	if (!buf)
 		return -ENOMEM;
 
+	ret = uvc_pm_get(stream);
+	if (ret) {
+		kfree(buf);
+		return ret;
+	}
+
 	*buf = input + 1;
 	ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, chain->selector->id,
 			     chain->dev->intfnum, UVC_SU_INPUT_SELECT_CONTROL,
 			     buf, 1);
+	uvc_pm_put(stream);
 	kfree(buf);
 
 	return ret;
@@ -985,8 +1054,15 @@ static int uvc_ioctl_queryctrl(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
+	int ret;
 
-	return uvc_query_v4l2_ctrl(chain, qc);
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
+	ret = uvc_query_v4l2_ctrl(chain, qc);
+	uvc_pm_put(stream);
+	return ret;
 }
 
 static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
@@ -994,10 +1070,15 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	struct v4l2_queryctrl qc = { qec->id };
 	int ret;
 
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
 	ret = uvc_query_v4l2_ctrl(chain, &qc);
+	uvc_pm_put(stream);
 	if (ret)
 		return ret;
 
@@ -1043,6 +1124,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	struct v4l2_ext_control *ctrl = ctrls->controls;
 	unsigned int i;
 	int ret;
@@ -1067,22 +1149,30 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 		return 0;
 	}
 
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
 	ret = uvc_ctrl_begin(chain);
-	if (ret < 0)
+	if (ret < 0) {
+		uvc_pm_put(stream);
 		return ret;
+	}
 
 	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
 		ret = uvc_ctrl_get(chain, ctrl);
 		if (ret < 0) {
 			uvc_ctrl_rollback(handle);
 			ctrls->error_idx = i;
-			return ret;
+			goto done;
 		}
 	}
 
 	ctrls->error_idx = 0;
 
-	return uvc_ctrl_rollback(handle);
+	ret = uvc_ctrl_rollback(handle);
+done:
+	uvc_pm_put(stream);
+	return ret;
 }
 
 static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
@@ -1091,6 +1181,7 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 {
 	struct v4l2_ext_control *ctrl = ctrls->controls;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	unsigned int i;
 	int ret;
 
@@ -1098,9 +1189,15 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 	if (ret < 0)
 		return ret;
 
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
+
 	ret = uvc_ctrl_begin(chain);
-	if (ret < 0)
+	if (ret < 0) {
+		uvc_pm_put(stream);
 		return ret;
+	}
 
 	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
 		ret = uvc_ctrl_set(handle, ctrl);
@@ -1108,16 +1205,20 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 			uvc_ctrl_rollback(handle);
 			ctrls->error_idx = ioctl == VIDIOC_S_EXT_CTRLS ?
 						    ctrls->count : i;
-			return ret;
+			goto done;
 		}
 	}
 
 	ctrls->error_idx = 0;
 
 	if (ioctl == VIDIOC_S_EXT_CTRLS)
-		return uvc_ctrl_commit(handle, ctrls);
+		ret = uvc_ctrl_commit(handle, ctrls);
 	else
-		return uvc_ctrl_rollback(handle);
+		ret = uvc_ctrl_rollback(handle);
+
+done:
+	uvc_pm_put(stream);
+	return ret;
 }
 
 static int uvc_ioctl_s_ext_ctrls(struct file *file, void *fh,
@@ -1141,8 +1242,16 @@ static int uvc_ioctl_querymenu(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
+	int ret;
+
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
+	ret = uvc_query_v4l2_menu(chain, qm);
+	uvc_pm_put(stream);
 
-	return uvc_query_v4l2_menu(chain, qm);
+	return ret;
 }
 
 static int uvc_ioctl_g_selection(struct file *file, void *fh,
-- 
2.35.0.263.gb82422642f-goog

