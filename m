Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570FC46ED45
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbhLIQl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241291AbhLIQlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:41:53 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431CBC061D60
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 08:38:18 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g18so5906832pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 08:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XIWAlclISqLqVZ4fRSoN98EYOrbeHDE9G5UV/J5AqJc=;
        b=kwytV/KMewUmDWtOJyCZp716nKMqO3YkHmDZulL8AHr+bTivS/8Zcyqvi5qs4vznzu
         xzVS5eiaUAwhOWIBpub5KjsKoDc92D6rELfnR/bDSM5Yd+GDe55aZF7NVBore31eZXcr
         9RQb8LE4DB1cUn+mWHQDVLYSUg0S0lao18Ogo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XIWAlclISqLqVZ4fRSoN98EYOrbeHDE9G5UV/J5AqJc=;
        b=oSsRnVBYe18O3Zl49v1OE18YfHgRuLOE/oV7Cbgx5NYg3Hlo+b5klLb2tSd/Xda6JM
         9sIMZS0+cS7dWYZPW2VzoeXfJZypw2USbV58PXtrjSdg2pEc3O3FsXVXl/+4NfsPtXA6
         9KmhUrlvrwpBethv8VBIJkxBNrSGxWaritiwyiY0TyE0s1fzMkZQL1C0+oeCBiXMdahu
         yL7VRluV8oXjV7nHfik88cf0GLgf92tegmWdEaGSF25+zsvWETe9E3oBRN0x8rPpdtIB
         E6YtCJu2t03h9I/Vb+ZChxbQTiGtQn0FBh/pwfaC3z6+MH2+1Wn2oFcOOFgcMqXZnKq0
         sRBA==
X-Gm-Message-State: AOAM530QkCeuoBO2mix0sCWz72rJ6009SGo+qeuq7mgcHVU0efl1QiU9
        tIiWUgNj/hh7J2Imtljex1Zt7g==
X-Google-Smtp-Source: ABdhPJwM+U9294o+lCojT+6u6ijmR3fo/V/A//k0Ne81kyfVEY9DQhsu03XodsKNObSLag06y15Wkg==
X-Received: by 2002:a63:90c7:: with SMTP id a190mr35608096pge.526.1639067897780;
        Thu, 09 Dec 2021 08:38:17 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:edb5:3ef8:a855:9380])
        by smtp.gmail.com with ESMTPSA id k14sm229483pff.6.2021.12.09.08.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:38:17 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: v4l2-mem2mem: Apply DST_QUEUE_OFF_BASE on MMAP buffers across ioctls
Date:   Fri, 10 Dec 2021 00:38:03 +0800
Message-Id: <20211209163803.1239386-1-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DST_QUEUE_OFF_BASE is applied to offset/mem_offset on MMAP capture buffers
only for the VIDIOC_QUERYBUF ioctl, while the userspace fields (including
offset/mem_offset) are filled in for VIDIOC_{QUERY,PREPARE,Q,DQ}BUF
ioctls. This leads to differences in the values presented to userspace.
If userspace attempts to mmap the capture buffer directly using values
from DQBUF, it will fail.

Move the code that applies the magic offset into a helper, and call
that helper from all four ioctl entry points.

Fixes: 7f98639def42 ("V4L/DVB: add memory-to-memory device helper framework for videobuf")
Fixes: 908a0d7c588e ("[media] v4l: mem2mem: port to videobuf2")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:

  - Bail out directly without adjusting offsets if the respective
    vb2_*() calls failed

This was tested on RK3399 with

    gst-launch-1.0 videotestsrc num-buffers=2 ! v4l2jpegenc ! fakesink

and verifying the values using the V4L2 debug messages:

    video2: VIDIOC_QUERYBUF: 00:00:00.000000 index=0, type=vid-cap-mplane, request_fd=0, flags=0x00004000, field=any, sequence=0, memory=mmap
    plane 0: bytesused=0, data_offset=0x00000000, offset/userptr=0x40000000, length=2097152
    timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
    video2: VIDIOC_QUERYBUF: 00:00:00.000000 index=0, type=vid-out-mplane, request_fd=0, flags=0x00004000, field=any, sequence=0, memory=mmap
    plane 0: bytesused=0, data_offset=0x00000000, offset/userptr=0x0, length=153600
    timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000

    video2: VIDIOC_QBUF: 00:00:00.000000 index=0, type=vid-cap-mplane, request_fd=0, flags=0x00004003, field=any, sequence=0, memory=mmap
    plane 0: bytesused=2097152, data_offset=0x00000000, offset/userptr=0x40000000, length=2097152
    timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
    video2: VIDIOC_QBUF: 00:00:00.000000 index=0, type=vid-out-mplane, request_fd=0, flags=0x00004003, field=none, sequence=0, memory=mmap
    plane 0: bytesused=153600, data_offset=0x00000000, offset/userptr=0x0, length=153600
    timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000

    video2: VIDIOC_DQBUF: 00:00:00.000000 index=0, type=vid-cap-mplane, request_fd=0, flags=0x00004001, field=none, sequence=0, memory=mmap
    plane 0: bytesused=6324, data_offset=0x00000000, offset/userptr=0x40000000, length=2097152
    timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
    video2: VIDIOC_DQBUF: 00:00:00.000000 index=0, type=vid-out-mplane, request_fd=0, flags=0x00004001, field=none, sequence=0, memory=mmap
    plane 0: bytesused=153600, data_offset=0x00000000, offset/userptr=0x0, length=153600
    timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000

Gstreamer doesn't do PREPAREBUF calls, so that path was not verified.
However the code changes are exactly the same, so I'm quite confident
about them.

---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 53 ++++++++++++++++++++------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index e2654b422334..3bac9e373502 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -585,19 +585,14 @@ int v4l2_m2m_reqbufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_reqbufs);
 
-int v4l2_m2m_querybuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
-		      struct v4l2_buffer *buf)
+static void v4l2_m2m_adjust_mem_offset(struct vb2_queue *vq,
+				       struct v4l2_buffer *buf)
 {
-	struct vb2_queue *vq;
-	int ret = 0;
-	unsigned int i;
-
-	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
-	ret = vb2_querybuf(vq, buf);
-
 	/* Adjust MMAP memory offsets for the CAPTURE queue */
 	if (buf->memory == V4L2_MEMORY_MMAP && V4L2_TYPE_IS_CAPTURE(vq->type)) {
 		if (V4L2_TYPE_IS_MULTIPLANAR(vq->type)) {
+			unsigned int i;
+
 			for (i = 0; i < buf->length; ++i)
 				buf->m.planes[i].m.mem_offset
 					+= DST_QUEUE_OFF_BASE;
@@ -605,8 +600,23 @@ int v4l2_m2m_querybuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 			buf->m.offset += DST_QUEUE_OFF_BASE;
 		}
 	}
+}
 
-	return ret;
+int v4l2_m2m_querybuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
+		      struct v4l2_buffer *buf)
+{
+	struct vb2_queue *vq;
+	int ret = 0;
+
+	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
+	ret = vb2_querybuf(vq, buf);
+	if (ret)
+		return ret;
+
+	/* Adjust MMAP memory offsets for the CAPTURE queue */
+	v4l2_m2m_adjust_mem_offset(vq, buf);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_querybuf);
 
@@ -763,6 +773,9 @@ int v4l2_m2m_qbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 	if (ret)
 		return ret;
 
+	/* Adjust MMAP memory offsets for the CAPTURE queue */
+	v4l2_m2m_adjust_mem_offset(vq, buf);
+
 	/*
 	 * If the capture queue is streaming, but streaming hasn't started
 	 * on the device, but was asked to stop, mark the previously queued
@@ -784,9 +797,17 @@ int v4l2_m2m_dqbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 		   struct v4l2_buffer *buf)
 {
 	struct vb2_queue *vq;
+	int ret;
 
 	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
-	return vb2_dqbuf(vq, buf, file->f_flags & O_NONBLOCK);
+	ret = vb2_dqbuf(vq, buf, file->f_flags & O_NONBLOCK);
+	if (ret)
+		return ret;
+
+	/* Adjust MMAP memory offsets for the CAPTURE queue */
+	v4l2_m2m_adjust_mem_offset(vq, buf);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_dqbuf);
 
@@ -795,9 +816,17 @@ int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 {
 	struct video_device *vdev = video_devdata(file);
 	struct vb2_queue *vq;
+	int ret;
 
 	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
-	return vb2_prepare_buf(vq, vdev->v4l2_dev->mdev, buf);
+	ret = vb2_prepare_buf(vq, vdev->v4l2_dev->mdev, buf);
+	if (ret)
+		return ret;
+
+	/* Adjust MMAP memory offsets for the CAPTURE queue */
+	v4l2_m2m_adjust_mem_offset(vq, buf);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_prepare_buf);
 
-- 
2.34.1.400.ga245620fadb-goog

