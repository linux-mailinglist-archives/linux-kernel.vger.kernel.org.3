Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702A646E27D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhLIGdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbhLIGdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:33:17 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559EBC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 22:29:44 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id p13so4540841pfw.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDQeLFsJWWQ29fDPIRsuMsj8pMxqvIriv1EEMWZcKag=;
        b=Gyjp7Xf3cj1lZ8F/xfViYEIuRYf3fMl/Mw1adhD4mSO3XNhNa2pa98S/1og1a3P1gF
         JhMAHRepEmOmBg195q1VKTLU6xtKvEMZfF4C63CoLFJRkoVidivE0fDbauL2wUC3PlVf
         vbj0px713lX0sbbz9B2aQQn+rDYWkoBvZJjgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDQeLFsJWWQ29fDPIRsuMsj8pMxqvIriv1EEMWZcKag=;
        b=wHFBNSAxTziRuk0GAnFu6wa20b6OYCSpq7MXbgJpWENUldeTGakkmGmAMJw8WwMdSj
         9vyLvK4n5z8LSRVxt7i2xjAuojrMp9hTzE/d5F0DHZoS8KGOM1qnas7S6w+lIdEIwtNL
         JZEu9osRawOAtbFlyfk+E6jyeZzeMoJcNWFS8sPNa0rtPdX87d1Cz+oU2YWOjILAwPMS
         3WjgJ1zOPlMRpyOJRuxWSUrg8szYQmQqNGxRP7Bn0Lowg57/ZBpDubbBpRSqEMiZRmkI
         lAy2ED7EYEXARJe51c4DEQ6/iayr2ptW0vjnh+n4S8gj7NV7G/q0miX2xexZAucxHusy
         YlcQ==
X-Gm-Message-State: AOAM533Vfvp24/aVm4Ky2eFJBn+NCrQmi+YE1WgXUwsiJUDH/a5F6HwC
        2JlyzUOBgCXH5MtmR4ejPhfI4g==
X-Google-Smtp-Source: ABdhPJz0oqWHYeM9S4aGwcZ+QzMWku/0b3Ibttb0E/0Hqw7EylOUJ2GHHJ2w27Ua5SGg5emAapqOiA==
X-Received: by 2002:a63:f015:: with SMTP id k21mr28881226pgh.154.1639031383867;
        Wed, 08 Dec 2021 22:29:43 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:edb5:3ef8:a855:9380])
        by smtp.gmail.com with ESMTPSA id h20sm4158955pgh.13.2021.12.08.22.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 22:29:43 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: v4l2-mem2mem: Apply DST_QUEUE_OFF_BASE on MMAP buffers across ioctls
Date:   Thu,  9 Dec 2021 14:29:26 +0800
Message-Id: <20211209062926.991516-2-wenst@chromium.org>
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
 drivers/media/v4l2-core/v4l2-mem2mem.c | 46 ++++++++++++++++++++------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index e2654b422334..b47f25297c43 100644
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
@@ -605,6 +600,19 @@ int v4l2_m2m_querybuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 			buf->m.offset += DST_QUEUE_OFF_BASE;
 		}
 	}
+}
+
+int v4l2_m2m_querybuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
+		      struct v4l2_buffer *buf)
+{
+	struct vb2_queue *vq;
+	int ret = 0;
+
+	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
+	ret = vb2_querybuf(vq, buf);
+
+	/* Adjust MMAP memory offsets for the CAPTURE queue */
+	v4l2_m2m_adjust_mem_offset(vq, buf);
 
 	return ret;
 }
@@ -760,6 +768,10 @@ int v4l2_m2m_qbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 	}
 
 	ret = vb2_qbuf(vq, vdev->v4l2_dev->mdev, buf);
+
+	/* Adjust MMAP memory offsets for the CAPTURE queue */
+	v4l2_m2m_adjust_mem_offset(vq, buf);
+
 	if (ret)
 		return ret;
 
@@ -784,9 +796,15 @@ int v4l2_m2m_dqbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 		   struct v4l2_buffer *buf)
 {
 	struct vb2_queue *vq;
+	int ret;
 
 	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
-	return vb2_dqbuf(vq, buf, file->f_flags & O_NONBLOCK);
+	ret = vb2_dqbuf(vq, buf, file->f_flags & O_NONBLOCK);
+
+	/* Adjust MMAP memory offsets for the CAPTURE queue */
+	v4l2_m2m_adjust_mem_offset(vq, buf);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_dqbuf);
 
@@ -795,9 +813,15 @@ int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 {
 	struct video_device *vdev = video_devdata(file);
 	struct vb2_queue *vq;
+	int ret;
 
 	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
-	return vb2_prepare_buf(vq, vdev->v4l2_dev->mdev, buf);
+	ret = vb2_prepare_buf(vq, vdev->v4l2_dev->mdev, buf);
+
+	/* Adjust MMAP memory offsets for the CAPTURE queue */
+	v4l2_m2m_adjust_mem_offset(vq, buf);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_prepare_buf);
 
-- 
2.34.1.400.ga245620fadb-goog

