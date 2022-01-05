Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011E2485A13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbiAEUgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbiAEUgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:36:38 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC8DC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 12:36:38 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id y4so673631uad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 12:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gb7wMy8ZrLt7CBYzP3rVZ32f9z9T6WftfdAjyIQOBo=;
        b=igYfSkah7NMeAEGpYRe72E98mSwU65Uxq1dOX9EfS5GCNIKO7+McYEFMaHbIMsvT2I
         6p8tUwC1Ox62vSux9bAnRFOJVdea6ot00wyHCoZcRuA2Lt73tbK1jWOrN43F2Daw2a0A
         +ly23bjLw8diKVlPgOWIsVA3201K+GWdbr8aD6f+4A7WJUd+85o7b188jZJ5OblRbNKS
         zJ0ACJQdqxDGzf9hX33DmylfSCm7Y98Fos/SThGpV88JJJ4McStO7DIFG+6wzNpUDQ49
         cJTOXxckhF+0nypYda30g6zfHqAqXyjS1l7mIvW7Hx1KpFGTWvQJpVzV9yur6/OIpXkP
         HfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gb7wMy8ZrLt7CBYzP3rVZ32f9z9T6WftfdAjyIQOBo=;
        b=TFJKRxSC57WVbb7RkOOEDmhHz0EWlEC1sDXtAQPJZ/ekOo3rELgFORw7BZKBIqHSRF
         rHWeiARaSUzS1pfd56fU97+sLnehEKsMW1+GrM1aCwLP4Ji0Y71rkeX7Pu2mZAkfmq3a
         27jha389XoEJo3b2exk7Fv155yAO6f/BUtvDebqlrsPtLL96u2y9PkPmuO6HmwvxXJEz
         pdKu8fZn0h1a7CGEGi4H+UaMeMzGJOuoepEuVYmssZuTFuyltMcWb51RlDFv/v6IRbBx
         YbPPmcU+BfcK7850J1Rmm69GOWw6dmTQrTEX0KO2N/Rtxay0sFzzAxngg2OxzdZitCXy
         AXag==
X-Gm-Message-State: AOAM531ZfJO5gFzzcQF7SxYfwW7sFqkBg7x2Ka4M32v+MRBuj9Cpv/dV
        znE521XHaEhU2smU3zHUHgY=
X-Google-Smtp-Source: ABdhPJxZVI4ORTO8tgh27G9/+Z97ze3uXHBH7Yrmv1eKh2ao1x86MrTYtC+8pgw9B7LwNMRiG2x/Mg==
X-Received: by 2002:a05:6102:548c:: with SMTP id bk12mr17253687vsb.87.1641414997273;
        Wed, 05 Jan 2022 12:36:37 -0800 (PST)
Received: from localhost.localdomain ([181.22.170.52])
        by smtp.gmail.com with ESMTPSA id t130sm7860vkc.32.2022.01.05.12.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:36:36 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, len.baker@gmx.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 1/6] staging: vc04_services: rename structures bm2835_mmal_dev and bm2835_mmal_v4l2_ctrl
Date:   Wed,  5 Jan 2022 17:35:43 -0300
Message-Id: <a893f24fc5ee6c276ea982f141b42ec0a00d7194.1641414449.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641414449.git.gascoar@gmail.com>
References: <cover.1641414449.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kernel, all names related to the chip BCM2835 are always named
bcm2835_*. To avoid confusion, and to make things more consistent,
rename the structures bm2835_mmal_dev and bm2835_mmal_v4l2_ctrl
accordingly.

While at it, one realignment was made to improve readability.

Suggested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../bcm2835-camera/bcm2835-camera.c           | 68 ++++++-------
 .../bcm2835-camera/bcm2835-camera.h           |  8 +-
 .../vc04_services/bcm2835-camera/controls.c   | 99 +++++++++----------
 3 files changed, 87 insertions(+), 88 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 1b184d5c6b82..109021643c3f 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -64,7 +64,7 @@ MODULE_PARM_DESC(max_video_height, "Threshold for video mode");
 static atomic_t camera_instance = ATOMIC_INIT(0);
 
 /* global device data array */
-static struct bm2835_mmal_dev *gdev[MAX_BCM2835_CAMERAS];
+static struct bcm2835_mmal_dev *gdev[MAX_BCM2835_CAMERAS];
 
 #define FPS_MIN 1
 #define FPS_MAX 90
@@ -210,7 +210,7 @@ static int queue_setup(struct vb2_queue *vq,
 		       unsigned int *nbuffers, unsigned int *nplanes,
 		       unsigned int sizes[], struct device *alloc_ctxs[])
 {
-	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vq);
+	struct bcm2835_mmal_dev *dev = vb2_get_drv_priv(vq);
 	unsigned long size;
 
 	/* refuse queue setup if port is not configured */
@@ -265,7 +265,7 @@ static int queue_setup(struct vb2_queue *vq,
 
 static int buffer_init(struct vb2_buffer *vb)
 {
-	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
+	struct bcm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2 = to_vb2_v4l2_buffer(vb);
 	struct vb2_mmal_buffer *buf =
 				container_of(vb2, struct vb2_mmal_buffer, vb);
@@ -280,7 +280,7 @@ static int buffer_init(struct vb2_buffer *vb)
 
 static int buffer_prepare(struct vb2_buffer *vb)
 {
-	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
+	struct bcm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
 	unsigned long size;
 
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev, "%s: dev:%p, vb %p\n",
@@ -302,7 +302,7 @@ static int buffer_prepare(struct vb2_buffer *vb)
 
 static void buffer_cleanup(struct vb2_buffer *vb)
 {
-	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
+	struct bcm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2 = to_vb2_v4l2_buffer(vb);
 	struct vb2_mmal_buffer *buf =
 				container_of(vb2, struct vb2_mmal_buffer, vb);
@@ -313,7 +313,7 @@ static void buffer_cleanup(struct vb2_buffer *vb)
 	mmal_vchi_buffer_cleanup(&buf->mmal);
 }
 
-static inline bool is_capturing(struct bm2835_mmal_dev *dev)
+static inline bool is_capturing(struct bcm2835_mmal_dev *dev)
 {
 	return dev->capture.camera_port ==
 	    &dev->component[COMP_CAMERA]->output[CAM_PORT_CAPTURE];
@@ -324,7 +324,7 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 		      int status,
 		      struct mmal_buffer *mmal_buf)
 {
-	struct bm2835_mmal_dev *dev = port->cb_ctx;
+	struct bcm2835_mmal_dev *dev = port->cb_ctx;
 	struct vb2_mmal_buffer *buf =
 			container_of(mmal_buf, struct vb2_mmal_buffer, mmal);
 
@@ -416,7 +416,7 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 	}
 }
 
-static int enable_camera(struct bm2835_mmal_dev *dev)
+static int enable_camera(struct bcm2835_mmal_dev *dev)
 {
 	int ret;
 
@@ -447,7 +447,7 @@ static int enable_camera(struct bm2835_mmal_dev *dev)
 	return 0;
 }
 
-static int disable_camera(struct bm2835_mmal_dev *dev)
+static int disable_camera(struct bcm2835_mmal_dev *dev)
 {
 	int ret;
 
@@ -482,7 +482,7 @@ static int disable_camera(struct bm2835_mmal_dev *dev)
 
 static void buffer_queue(struct vb2_buffer *vb)
 {
-	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
+	struct bcm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2 = to_vb2_v4l2_buffer(vb);
 	struct vb2_mmal_buffer *buf =
 				container_of(vb2, struct vb2_mmal_buffer, vb);
@@ -501,7 +501,7 @@ static void buffer_queue(struct vb2_buffer *vb)
 
 static int start_streaming(struct vb2_queue *vq, unsigned int count)
 {
-	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vq);
+	struct bcm2835_mmal_dev *dev = vb2_get_drv_priv(vq);
 	int ret;
 	u32 parameter_size;
 
@@ -596,7 +596,7 @@ static void stop_streaming(struct vb2_queue *vq)
 {
 	int ret;
 	unsigned long timeout;
-	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vq);
+	struct bcm2835_mmal_dev *dev = vb2_get_drv_priv(vq);
 	struct vchiq_mmal_port *port = dev->capture.port;
 
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev, "%s: dev:%p\n",
@@ -671,7 +671,7 @@ static const struct vb2_ops bm2835_mmal_video_qops = {
  * ------------------------------------------------------------------
  */
 
-static int set_overlay_params(struct bm2835_mmal_dev *dev,
+static int set_overlay_params(struct bcm2835_mmal_dev *dev,
 			      struct vchiq_mmal_port *port)
 {
 	struct mmal_parameter_displayregion prev_config = {
@@ -713,7 +713,7 @@ static int vidioc_enum_fmt_vid_overlay(struct file *file, void *priv,
 static int vidioc_g_fmt_vid_overlay(struct file *file, void *priv,
 				    struct v4l2_format *f)
 {
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 
 	f->fmt.win = dev->overlay;
 
@@ -723,7 +723,7 @@ static int vidioc_g_fmt_vid_overlay(struct file *file, void *priv,
 static int vidioc_try_fmt_vid_overlay(struct file *file, void *priv,
 				      struct v4l2_format *f)
 {
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 
 	f->fmt.win.field = V4L2_FIELD_NONE;
 	f->fmt.win.chromakey = 0;
@@ -754,7 +754,7 @@ static int vidioc_try_fmt_vid_overlay(struct file *file, void *priv,
 static int vidioc_s_fmt_vid_overlay(struct file *file, void *priv,
 				    struct v4l2_format *f)
 {
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 
 	vidioc_try_fmt_vid_overlay(file, priv, f);
 
@@ -770,7 +770,7 @@ static int vidioc_s_fmt_vid_overlay(struct file *file, void *priv,
 static int vidioc_overlay(struct file *file, void *f, unsigned int on)
 {
 	int ret;
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 	struct vchiq_mmal_port *src;
 	struct vchiq_mmal_port *dst;
 
@@ -829,7 +829,7 @@ static int vidioc_g_fbuf(struct file *file, void *fh,
 	/* The video overlay must stay within the framebuffer and can't be
 	 * positioned independently.
 	 */
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 	struct vchiq_mmal_port *preview_port =
 		&dev->component[COMP_CAMERA]->output[CAM_PORT_PREVIEW];
 
@@ -878,7 +878,7 @@ static int vidioc_s_input(struct file *file, void *priv, unsigned int i)
 static int vidioc_querycap(struct file *file, void *priv,
 			   struct v4l2_capability *cap)
 {
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 	u32 major;
 	u32 minor;
 
@@ -911,7 +911,7 @@ static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
 static int vidioc_g_fmt_vid_cap(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 
 	f->fmt.pix.width = dev->capture.width;
 	f->fmt.pix.height = dev->capture.height;
@@ -936,7 +936,7 @@ static int vidioc_g_fmt_vid_cap(struct file *file, void *priv,
 static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 	struct mmal_fmt *mfmt;
 
 	mfmt = get_format(f);
@@ -1010,7 +1010,7 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 }
 
 
-static int mmal_setup_video_component(struct bm2835_mmal_dev *dev,
+static int mmal_setup_video_component(struct bcm2835_mmal_dev *dev,
 				      struct v4l2_format *f)
 {
 	bool overlay_enabled = !!dev->component[COMP_PREVIEW]->enabled;
@@ -1056,7 +1056,7 @@ static int mmal_setup_video_component(struct bm2835_mmal_dev *dev,
 	return ret;
 }
 
-static int mmal_setup_encode_component(struct bm2835_mmal_dev *dev,
+static int mmal_setup_encode_component(struct bcm2835_mmal_dev *dev,
 				       struct v4l2_format *f,
 				       struct vchiq_mmal_port *port,
 				       struct vchiq_mmal_port *camera_port,
@@ -1144,7 +1144,7 @@ static int mmal_setup_encode_component(struct bm2835_mmal_dev *dev,
 	return 0;
 }
 
-static int mmal_setup_components(struct bm2835_mmal_dev *dev,
+static int mmal_setup_components(struct bcm2835_mmal_dev *dev,
 				 struct v4l2_format *f)
 {
 	int ret;
@@ -1290,7 +1290,7 @@ static int vidioc_s_fmt_vid_cap(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
 	int ret;
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 	struct mmal_fmt *mfmt;
 
 	/* try the format to set valid parameters */
@@ -1333,7 +1333,7 @@ static int vidioc_s_fmt_vid_cap(struct file *file, void *priv,
 static int vidioc_enum_framesizes(struct file *file, void *fh,
 				  struct v4l2_frmsizeenum *fsize)
 {
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 	static const struct v4l2_frmsize_stepwise sizes = {
 		MIN_WIDTH, 0, 2,
 		MIN_HEIGHT, 0, 2
@@ -1358,7 +1358,7 @@ static int vidioc_enum_framesizes(struct file *file, void *fh,
 static int vidioc_enum_frameintervals(struct file *file, void *priv,
 				      struct v4l2_frmivalenum *fival)
 {
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 	int i;
 
 	if (fival->index)
@@ -1388,7 +1388,7 @@ static int vidioc_enum_frameintervals(struct file *file, void *priv,
 static int vidioc_g_parm(struct file *file, void *priv,
 			 struct v4l2_streamparm *parm)
 {
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 
 	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
@@ -1402,7 +1402,7 @@ static int vidioc_g_parm(struct file *file, void *priv,
 static int vidioc_s_parm(struct file *file, void *priv,
 			 struct v4l2_streamparm *parm)
 {
-	struct bm2835_mmal_dev *dev = video_drvdata(file);
+	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 	struct v4l2_fract tpf;
 
 	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
@@ -1530,7 +1530,7 @@ static int get_num_cameras(struct vchiq_mmal_instance *instance,
 
 static int set_camera_parameters(struct vchiq_mmal_instance *instance,
 				 struct vchiq_mmal_component *camera,
-				 struct bm2835_mmal_dev *dev)
+				 struct bcm2835_mmal_dev *dev)
 {
 	struct mmal_parameter_camera_config cam_config = {
 		.max_stills_w = dev->max_width,
@@ -1555,7 +1555,7 @@ static int set_camera_parameters(struct vchiq_mmal_instance *instance,
 #define MAX_SUPPORTED_ENCODINGS 20
 
 /* MMAL instance and component init */
-static int mmal_init(struct bm2835_mmal_dev *dev)
+static int mmal_init(struct bcm2835_mmal_dev *dev)
 {
 	int ret;
 	struct mmal_es_format_local *format;
@@ -1769,7 +1769,7 @@ static int mmal_init(struct bm2835_mmal_dev *dev)
 	return ret;
 }
 
-static int bm2835_mmal_init_device(struct bm2835_mmal_dev *dev,
+static int bm2835_mmal_init_device(struct bcm2835_mmal_dev *dev,
 				   struct video_device *vfd)
 {
 	int ret;
@@ -1798,7 +1798,7 @@ static int bm2835_mmal_init_device(struct bm2835_mmal_dev *dev,
 	return 0;
 }
 
-static void bcm2835_cleanup_instance(struct bm2835_mmal_dev *dev)
+static void bcm2835_cleanup_instance(struct bcm2835_mmal_dev *dev)
 {
 	if (!dev)
 		return;
@@ -1849,7 +1849,7 @@ static struct v4l2_format default_v4l2_format = {
 static int bcm2835_mmal_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct bm2835_mmal_dev *dev;
+	struct bcm2835_mmal_dev *dev;
 	struct vb2_queue *q;
 	int camera;
 	unsigned int num_cameras;
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
index 75524adff0f5..338b7c142ae3 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
@@ -32,7 +32,7 @@ enum {
 
 extern int bcm2835_v4l2_debug;
 
-struct bm2835_mmal_dev {
+struct bcm2835_mmal_dev {
 	/* v4l2 devices */
 	struct v4l2_device v4l2_dev;
 	struct video_device vdev;
@@ -111,11 +111,11 @@ struct bm2835_mmal_dev {
 };
 
 int bm2835_mmal_init_controls(
-			struct bm2835_mmal_dev *dev,
+			struct bcm2835_mmal_dev *dev,
 			struct v4l2_ctrl_handler *hdl);
 
-int bm2835_mmal_set_all_camera_controls(struct bm2835_mmal_dev *dev);
-int set_framerate_params(struct bm2835_mmal_dev *dev);
+int bm2835_mmal_set_all_camera_controls(struct bcm2835_mmal_dev *dev);
+int set_framerate_params(struct bcm2835_mmal_dev *dev);
 
 /* Debug helpers */
 
diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index 3696dfb5a020..03967a7d99a0 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -65,7 +65,7 @@ enum bm2835_mmal_ctrl_type {
 	MMAL_CONTROL_TYPE_CLUSTER, /* special cluster entry */
 };
 
-struct bm2835_mmal_v4l2_ctrl {
+struct bcm2835_mmal_v4l2_ctrl {
 	u32 id; /* v4l2 control identifier */
 	enum bm2835_mmal_ctrl_type type;
 	/* control minimum value or
@@ -77,8 +77,8 @@ struct bm2835_mmal_v4l2_ctrl {
 	u64 step; /* step size of the control */
 	const s64 *imenu; /* integer menu array */
 	u32 mmal_id; /* mmal parameter id */
-	int (*setter)(struct bm2835_mmal_dev *dev, struct v4l2_ctrl *ctrl,
-		      const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl);
+	int (*setter)(struct bcm2835_mmal_dev *dev, struct v4l2_ctrl *ctrl,
+		      const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl);
 };
 
 struct v4l2_to_mmal_effects_setting {
@@ -150,9 +150,9 @@ static const struct v4l2_mmal_scene_config scene_configs[] = {
 
 /* control handlers*/
 
-static int ctrl_set_rational(struct bm2835_mmal_dev *dev,
+static int ctrl_set_rational(struct bcm2835_mmal_dev *dev,
 			     struct v4l2_ctrl *ctrl,
-			     const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			     const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	struct mmal_parameter_rational rational_value;
 	struct vchiq_mmal_port *control;
@@ -168,9 +168,9 @@ static int ctrl_set_rational(struct bm2835_mmal_dev *dev,
 					     sizeof(rational_value));
 }
 
-static int ctrl_set_value(struct bm2835_mmal_dev *dev,
+static int ctrl_set_value(struct bcm2835_mmal_dev *dev,
 			  struct v4l2_ctrl *ctrl,
-			  const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			  const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	u32 u32_value;
 	struct vchiq_mmal_port *control;
@@ -184,9 +184,9 @@ static int ctrl_set_value(struct bm2835_mmal_dev *dev,
 					     &u32_value, sizeof(u32_value));
 }
 
-static int ctrl_set_iso(struct bm2835_mmal_dev *dev,
+static int ctrl_set_iso(struct bcm2835_mmal_dev *dev,
 			struct v4l2_ctrl *ctrl,
-			const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	u32 u32_value;
 	struct vchiq_mmal_port *control;
@@ -212,9 +212,9 @@ static int ctrl_set_iso(struct bm2835_mmal_dev *dev,
 					     &u32_value, sizeof(u32_value));
 }
 
-static int ctrl_set_value_ev(struct bm2835_mmal_dev *dev,
+static int ctrl_set_value_ev(struct bcm2835_mmal_dev *dev,
 			     struct v4l2_ctrl *ctrl,
-			     const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			     const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	s32 s32_value;
 	struct vchiq_mmal_port *control;
@@ -228,9 +228,9 @@ static int ctrl_set_value_ev(struct bm2835_mmal_dev *dev,
 					     &s32_value, sizeof(s32_value));
 }
 
-static int ctrl_set_rotate(struct bm2835_mmal_dev *dev,
+static int ctrl_set_rotate(struct bcm2835_mmal_dev *dev,
 			   struct v4l2_ctrl *ctrl,
-			   const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			   const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	int ret;
 	u32 u32_value;
@@ -257,9 +257,9 @@ static int ctrl_set_rotate(struct bm2835_mmal_dev *dev,
 					    &u32_value, sizeof(u32_value));
 }
 
-static int ctrl_set_flip(struct bm2835_mmal_dev *dev,
+static int ctrl_set_flip(struct bcm2835_mmal_dev *dev,
 			 struct v4l2_ctrl *ctrl,
-			 const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			 const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	int ret;
 	u32 u32_value;
@@ -298,9 +298,9 @@ static int ctrl_set_flip(struct bm2835_mmal_dev *dev,
 					    &u32_value, sizeof(u32_value));
 }
 
-static int ctrl_set_exposure(struct bm2835_mmal_dev *dev,
+static int ctrl_set_exposure(struct bcm2835_mmal_dev *dev,
 			     struct v4l2_ctrl *ctrl,
-			     const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			     const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	enum mmal_parameter_exposuremode exp_mode = dev->exposure_mode_user;
 	u32 shutter_speed = 0;
@@ -354,9 +354,9 @@ static int ctrl_set_exposure(struct bm2835_mmal_dev *dev,
 	return ret;
 }
 
-static int ctrl_set_metering_mode(struct bm2835_mmal_dev *dev,
+static int ctrl_set_metering_mode(struct bcm2835_mmal_dev *dev,
 				  struct v4l2_ctrl *ctrl,
-				  const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+				  const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	switch (ctrl->val) {
 	case V4L2_EXPOSURE_METERING_AVERAGE:
@@ -390,9 +390,9 @@ static int ctrl_set_metering_mode(struct bm2835_mmal_dev *dev,
 	}
 }
 
-static int ctrl_set_flicker_avoidance(struct bm2835_mmal_dev *dev,
+static int ctrl_set_flicker_avoidance(struct bcm2835_mmal_dev *dev,
 				      struct v4l2_ctrl *ctrl,
-				      const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+				      const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	u32 u32_value;
 	struct vchiq_mmal_port *control;
@@ -419,9 +419,9 @@ static int ctrl_set_flicker_avoidance(struct bm2835_mmal_dev *dev,
 					     &u32_value, sizeof(u32_value));
 }
 
-static int ctrl_set_awb_mode(struct bm2835_mmal_dev *dev,
+static int ctrl_set_awb_mode(struct bcm2835_mmal_dev *dev,
 			     struct v4l2_ctrl *ctrl,
-			     const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			     const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	u32 u32_value;
 	struct vchiq_mmal_port *control;
@@ -475,9 +475,9 @@ static int ctrl_set_awb_mode(struct bm2835_mmal_dev *dev,
 					     &u32_value, sizeof(u32_value));
 }
 
-static int ctrl_set_awb_gains(struct bm2835_mmal_dev *dev,
+static int ctrl_set_awb_gains(struct bcm2835_mmal_dev *dev,
 			      struct v4l2_ctrl *ctrl,
-			      const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			      const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	struct vchiq_mmal_port *control;
 	struct mmal_parameter_awbgains gains;
@@ -498,9 +498,9 @@ static int ctrl_set_awb_gains(struct bm2835_mmal_dev *dev,
 					     &gains, sizeof(gains));
 }
 
-static int ctrl_set_image_effect(struct bm2835_mmal_dev *dev,
+static int ctrl_set_image_effect(struct bcm2835_mmal_dev *dev,
 				 struct v4l2_ctrl *ctrl,
-				 const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+				 const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	int ret = -EINVAL;
 	int i, j;
@@ -555,9 +555,9 @@ static int ctrl_set_image_effect(struct bm2835_mmal_dev *dev,
 	return (ret == 0 ? 0 : -EINVAL);
 }
 
-static int ctrl_set_colfx(struct bm2835_mmal_dev *dev,
+static int ctrl_set_colfx(struct bcm2835_mmal_dev *dev,
 			  struct v4l2_ctrl *ctrl,
-			  const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			  const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	int ret;
 	struct vchiq_mmal_port *control;
@@ -579,9 +579,9 @@ static int ctrl_set_colfx(struct bm2835_mmal_dev *dev,
 	return (ret == 0 ? 0 : -EINVAL);
 }
 
-static int ctrl_set_bitrate(struct bm2835_mmal_dev *dev,
+static int ctrl_set_bitrate(struct bcm2835_mmal_dev *dev,
 			    struct v4l2_ctrl *ctrl,
-			    const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			    const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	int ret;
 	struct vchiq_mmal_port *encoder_out;
@@ -607,9 +607,9 @@ static int ctrl_set_bitrate(struct bm2835_mmal_dev *dev,
 	return 0;
 }
 
-static int ctrl_set_bitrate_mode(struct bm2835_mmal_dev *dev,
+static int ctrl_set_bitrate_mode(struct bcm2835_mmal_dev *dev,
 				 struct v4l2_ctrl *ctrl,
-				 const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+				 const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	u32 bitrate_mode;
 	struct vchiq_mmal_port *encoder_out;
@@ -634,9 +634,9 @@ static int ctrl_set_bitrate_mode(struct bm2835_mmal_dev *dev,
 	return 0;
 }
 
-static int ctrl_set_image_encode_output(struct bm2835_mmal_dev *dev,
+static int ctrl_set_image_encode_output(struct bcm2835_mmal_dev *dev,
 					struct v4l2_ctrl *ctrl,
-					const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+					const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	u32 u32_value;
 	struct vchiq_mmal_port *jpeg_out;
@@ -650,9 +650,9 @@ static int ctrl_set_image_encode_output(struct bm2835_mmal_dev *dev,
 					     &u32_value, sizeof(u32_value));
 }
 
-static int ctrl_set_video_encode_param_output(struct bm2835_mmal_dev *dev,
+static int ctrl_set_video_encode_param_output(struct bcm2835_mmal_dev *dev,
 					      struct v4l2_ctrl *ctrl,
-					      const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+					      const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	u32 u32_value;
 	struct vchiq_mmal_port *vid_enc_ctl;
@@ -666,9 +666,9 @@ static int ctrl_set_video_encode_param_output(struct bm2835_mmal_dev *dev,
 					     &u32_value, sizeof(u32_value));
 }
 
-static int ctrl_set_video_encode_profile_level(struct bm2835_mmal_dev *dev,
+static int ctrl_set_video_encode_profile_level(struct bcm2835_mmal_dev *dev,
 					       struct v4l2_ctrl *ctrl,
-					       const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+					       const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	struct mmal_parameter_video_profile param;
 	int ret = 0;
@@ -777,9 +777,9 @@ static int ctrl_set_video_encode_profile_level(struct bm2835_mmal_dev *dev,
 	return ret;
 }
 
-static int ctrl_set_scene_mode(struct bm2835_mmal_dev *dev,
+static int ctrl_set_scene_mode(struct bcm2835_mmal_dev *dev,
 			       struct v4l2_ctrl *ctrl,
-			       const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
+			       const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
 	int ret = 0;
 	int shutter_speed;
@@ -886,10 +886,9 @@ static int ctrl_set_scene_mode(struct bm2835_mmal_dev *dev,
 
 static int bm2835_mmal_s_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct bm2835_mmal_dev *dev =
-		container_of(ctrl->handler, struct bm2835_mmal_dev,
-			     ctrl_handler);
-	const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl = ctrl->priv;
+	struct bcm2835_mmal_dev *dev = container_of(ctrl->handler, struct bcm2835_mmal_dev,
+						    ctrl_handler);
+	const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl = ctrl->priv;
 	int ret;
 
 	if (!mmal_ctrl || mmal_ctrl->id != ctrl->id || !mmal_ctrl->setter) {
@@ -908,7 +907,7 @@ static const struct v4l2_ctrl_ops bm2835_mmal_ctrl_ops = {
 	.s_ctrl = bm2835_mmal_s_ctrl,
 };
 
-static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
+static const struct bcm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 	{
 		.id = V4L2_CID_SATURATION,
 		.type = MMAL_CONTROL_TYPE_STD,
@@ -1247,7 +1246,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 	},
 };
 
-int bm2835_mmal_set_all_camera_controls(struct bm2835_mmal_dev *dev)
+int bm2835_mmal_set_all_camera_controls(struct bcm2835_mmal_dev *dev)
 {
 	int c;
 	int ret = 0;
@@ -1267,7 +1266,7 @@ int bm2835_mmal_set_all_camera_controls(struct bm2835_mmal_dev *dev)
 	return ret;
 }
 
-int set_framerate_params(struct bm2835_mmal_dev *dev)
+int set_framerate_params(struct bcm2835_mmal_dev *dev)
 {
 	struct mmal_parameter_fps_range fps_range;
 	int ret;
@@ -1312,11 +1311,11 @@ int set_framerate_params(struct bm2835_mmal_dev *dev)
 	return ret;
 }
 
-int bm2835_mmal_init_controls(struct bm2835_mmal_dev *dev,
+int bm2835_mmal_init_controls(struct bcm2835_mmal_dev *dev,
 			      struct v4l2_ctrl_handler *hdl)
 {
 	int c;
-	const struct bm2835_mmal_v4l2_ctrl *ctrl;
+	const struct bcm2835_mmal_v4l2_ctrl *ctrl;
 
 	v4l2_ctrl_handler_init(hdl, V4L2_CTRL_COUNT);
 
-- 
2.34.1

