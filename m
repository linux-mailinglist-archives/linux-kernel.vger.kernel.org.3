Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345D9465468
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352086AbhLASAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:00:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38904 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351953AbhLAR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:59:58 -0500
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:1409:4a00:c103:6980:2c3:d021])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 47AFA1F45E4C;
        Wed,  1 Dec 2021 17:56:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638381391; bh=3M72FZKmsDmtGhHYfAyRq03ZhrRM85YubIbRyVIZyBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JTmk6lLi+l+VfaDp27o9HVPWD0pAs/fbJjW4Ol56vuAzimcoTLPfYa6K82n8lqLdZ
         EgBeHzp9yuDej7z0mHLivx2ZFaoImw5QZsbIsmIShpewTtcSCVlUVnfVaJP07mjsqn
         sGlT34VWtONMmvH9/0jPDbN4Gz3WyrjxJgAXKwSNZtLVTCFTILnMjF8JFFaACBmsW0
         Av43U40cJV8Qj02jB7EVQ06oz1PuoZony2es/9KTbs9y9vPhb83CXDVqYoXLdFV2nq
         Oh88FfL5DDC+nxccMumK729+IKKPXzBvQxjpX4mrvsJFzW4bbNbdaNC9u8PqLOlxaS
         M62Rf5irnfVng==
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        laurent.pinchart@ideasonboard.com, hverkuil@xs4all.nl,
        kernel@collabora.com, dafna3@gmail.com,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com, dan.carpenter@oracle.com,
        rdunlap@infradead.org, daniel@0x0f.com
Subject: [PATCH v4 3/6] staging: media: wave5: Add the v4l2 layer
Date:   Wed,  1 Dec 2021 19:56:10 +0200
Message-Id: <20211201175613.13710-4-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
References: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the decoder and encoder implementing the v4l2
API. This patch also adds the Makefile and the VIDEO_WAVE_VPU config

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/Kconfig               |    2 +
 drivers/staging/media/Makefile              |    1 +
 drivers/staging/media/wave5/Kconfig         |   12 +
 drivers/staging/media/wave5/Makefile        |   10 +
 drivers/staging/media/wave5/wave5-vpu-dec.c | 1343 +++++++++++++++++
 drivers/staging/media/wave5/wave5-vpu-enc.c | 1499 +++++++++++++++++++
 drivers/staging/media/wave5/wave5-vpu.c     |  354 +++++
 drivers/staging/media/wave5/wave5-vpu.h     |   73 +
 8 files changed, 3294 insertions(+)
 create mode 100644 drivers/staging/media/wave5/Kconfig
 create mode 100644 drivers/staging/media/wave5/Makefile
 create mode 100644 drivers/staging/media/wave5/wave5-vpu-dec.c
 create mode 100644 drivers/staging/media/wave5/wave5-vpu-enc.c
 create mode 100644 drivers/staging/media/wave5/wave5-vpu.c
 create mode 100644 drivers/staging/media/wave5/wave5-vpu.h

diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfig
index e3aaae920847..25564dc46ca7 100644
--- a/drivers/staging/media/Kconfig
+++ b/drivers/staging/media/Kconfig
@@ -44,4 +44,6 @@ source "drivers/staging/media/ipu3/Kconfig"
 
 source "drivers/staging/media/av7110/Kconfig"
 
+source "drivers/staging/media/wave5/Kconfig"
+
 endif
diff --git a/drivers/staging/media/Makefile b/drivers/staging/media/Makefile
index 5b5afc5b03a0..4cc61f24f5fa 100644
--- a/drivers/staging/media/Makefile
+++ b/drivers/staging/media/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_VIDEO_HANTRO)	+= hantro/
 obj-$(CONFIG_VIDEO_IPU3_IMGU)	+= ipu3/
 obj-$(CONFIG_VIDEO_ZORAN)	+= zoran/
 obj-$(CONFIG_DVB_AV7110)	+= av7110/
+obj-$(CONFIG_VIDEO_WAVE_VPU)	+= wave5/
diff --git a/drivers/staging/media/wave5/Kconfig b/drivers/staging/media/wave5/Kconfig
new file mode 100644
index 000000000000..9f4ccc77fcbf
--- /dev/null
+++ b/drivers/staging/media/wave5/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+config VIDEO_WAVE_VPU
+	tristate "Chips&Media Wave Codec Driver"
+	depends on VIDEO_DEV && VIDEO_V4L2
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	select V4L2_MEM2MEM_DEV
+	help
+	  Chips&Media stateful encoder and decoder driver.
+	  The driver supports HEVC and H264 formats.
+	  To compile this driver as modules, choose M here: the
+	  modules will be called wave5.
diff --git a/drivers/staging/media/wave5/Makefile b/drivers/staging/media/wave5/Makefile
new file mode 100644
index 000000000000..56f3a5289103
--- /dev/null
+++ b/drivers/staging/media/wave5/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_VIDEO_WAVE_VPU) += wave5.o
+wave5-objs +=  	wave5-hw.o \
+		wave5-vpuapi.o \
+		wave5-vdi.o \
+		wave5-vpu-dec.o \
+		wave5-vpu.o \
+		wave5-vpu-enc.o
+
diff --git a/drivers/staging/media/wave5/wave5-vpu-dec.c b/drivers/staging/media/wave5/wave5-vpu-dec.c
new file mode 100644
index 000000000000..9e833e060b1b
--- /dev/null
+++ b/drivers/staging/media/wave5/wave5-vpu-dec.c
@@ -0,0 +1,1343 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Wave5 series multi-standard codec IP - decoder interface
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#include "wave5-vpu.h"
+
+#define VPU_DEC_DEV_NAME "C&M VPU decoder"
+#define VPU_DEC_DRV_NAME "vpu-dec"
+#define V4L2_CID_VPU_THUMBNAIL_MODE (V4L2_CID_USER_BASE + 0x1001)
+
+static const struct vpu_format wave5_vpu_dec_fmt_list[2][6] = {
+	[VPU_FMT_TYPE_CODEC] = {
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_HEVC,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_H264,
+			.max_width = 8192,
+			.min_width = 32,
+			.max_height = 8192,
+			.min_height = 32,
+		},
+	},
+	[VPU_FMT_TYPE_RAW] = {
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420M,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12M,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21M,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+	}
+};
+
+static enum wave_std wave5_to_vpu_codstd(unsigned int v4l2_pix_fmt)
+{
+	switch (v4l2_pix_fmt) {
+	case V4L2_PIX_FMT_H264:
+		return W_AVC_DEC;
+	case V4L2_PIX_FMT_HEVC:
+		return W_HEVC_DEC;
+	default:
+		return STD_UNKNOWN;
+	}
+}
+
+static const struct vpu_format *wave5_get_vpu_fmt(unsigned int v4l2_pix_fmt, enum vpu_fmt_type type)
+{
+	unsigned int index;
+
+	for (index = 0; index < ARRAY_SIZE(wave5_vpu_dec_fmt_list[type]); index++) {
+		if (wave5_vpu_dec_fmt_list[type][index].v4l2_pix_fmt == v4l2_pix_fmt)
+			return &wave5_vpu_dec_fmt_list[type][index];
+	}
+
+	return NULL;
+}
+
+static const struct vpu_format *wave5_find_vpu_fmt_by_idx(unsigned int idx, enum vpu_fmt_type type)
+{
+	if (idx >= ARRAY_SIZE(wave5_vpu_dec_fmt_list[type]))
+		return NULL;
+
+	if (!wave5_vpu_dec_fmt_list[type][idx].v4l2_pix_fmt)
+		return NULL;
+
+	return &wave5_vpu_dec_fmt_list[type][idx];
+}
+
+static void wave5_handle_bitstream_buffer(struct vpu_instance *inst)
+{
+	struct v4l2_m2m_buffer *v4l2_m2m_buf = NULL;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&inst->bitstream_lock, flags);
+
+	v4l2_m2m_for_each_src_buf(inst->v4l2_fh.m2m_ctx, v4l2_m2m_buf) {
+		struct vb2_v4l2_buffer *vbuf = &v4l2_m2m_buf->vb;
+		struct vpu_buffer *vpu_buf = wave5_to_vpu_buf(vbuf);
+		u32 src_size = vb2_get_plane_payload(&vbuf->vb2_buf, 0);
+		void *src_buf = vb2_plane_vaddr(&vbuf->vb2_buf, 0);
+		dma_addr_t bs_rd_ptr = 0;
+		dma_addr_t bs_wr_ptr = 0;
+		u32 bs_remain_size = 0;
+		size_t offset;
+
+		if (vpu_buf->consumed) {
+			dev_dbg(inst->dev->dev, "already consumed buffer\n");
+			continue;
+		}
+
+		wave5_vpu_dec_get_bitstream_buffer(inst, &bs_rd_ptr, &bs_wr_ptr, &bs_remain_size);
+
+		if (bs_remain_size < src_size) {
+			dev_dbg(inst->dev->dev, "fill next time : remained size < source size.\n");
+			continue;
+		}
+
+		offset = bs_wr_ptr - inst->bitstream_vbuf.daddr;
+		if (bs_wr_ptr + src_size > inst->bitstream_vbuf.daddr + inst->bitstream_vbuf.size) {
+			int size;
+
+			size = inst->bitstream_vbuf.daddr + inst->bitstream_vbuf.size - bs_wr_ptr;
+			wave5_vdi_write_memory(inst->dev, &inst->bitstream_vbuf, offset, src_buf,
+					       size, VDI_128BIT_LITTLE_ENDIAN);
+			wave5_vdi_write_memory(inst->dev, &inst->bitstream_vbuf, 0,
+					       src_buf + size, src_size - size,
+					       VDI_128BIT_LITTLE_ENDIAN);
+		} else {
+			wave5_vdi_write_memory(inst->dev, &inst->bitstream_vbuf, offset, src_buf,
+					       src_size, VDI_128BIT_LITTLE_ENDIAN);
+		}
+
+		ret = wave5_vpu_dec_update_bitstream_buffer(inst, src_size);
+		if (ret) {
+			dev_dbg(inst->dev->dev, "vpu_dec_update_bitstream_buffer fail: %d\n", ret);
+			continue;
+		}
+
+		vpu_buf->consumed = true;
+
+		if (inst->state == VPU_INST_STATE_WAIT_BUF)
+			inst->state = VPU_INST_STATE_PIC_RUN;
+	}
+
+	spin_unlock_irqrestore(&inst->bitstream_lock, flags);
+}
+
+static void wave5_handle_src_buffer(struct vpu_instance *inst)
+{
+	struct vb2_v4l2_buffer *src_buf;
+
+	unsigned long flags;
+
+	spin_lock_irqsave(&inst->bitstream_lock, flags);
+
+	src_buf = v4l2_m2m_next_src_buf(inst->v4l2_fh.m2m_ctx);
+	if (src_buf) {
+		struct vpu_buffer *vpu_buf = wave5_to_vpu_buf(src_buf);
+
+		if (vpu_buf->consumed) {
+			u32 remain_num = 0;
+
+			dev_dbg(inst->dev->dev, "already consumed buffer\n");
+			remain_num = v4l2_m2m_num_src_bufs_ready(inst->v4l2_fh.m2m_ctx);
+			dev_dbg(inst->dev->dev, "remain buffer : %d\n", remain_num);
+			if (remain_num > 1) {
+				src_buf = v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx);
+				inst->timestamp = src_buf->vb2_buf.timestamp;
+				v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
+			}
+		}
+	}
+	spin_unlock_irqrestore(&inst->bitstream_lock, flags);
+}
+
+static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned int width,
+				 unsigned int height)
+{
+	switch (pix_mp->pixelformat) {
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[0].sizeimage = width * height * 3 / 2;
+		memset(&pix_mp->plane_fmt[0].reserved, 0, sizeof(pix_mp->plane_fmt[0].reserved));
+		break;
+	case V4L2_PIX_FMT_YUV420M:
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[0].sizeimage = width * height;
+		memset(&pix_mp->plane_fmt[0].reserved, 0, sizeof(pix_mp->plane_fmt[0].reserved));
+		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
+		pix_mp->plane_fmt[1].sizeimage = width * height / 4;
+		memset(&pix_mp->plane_fmt[1].reserved, 0, sizeof(pix_mp->plane_fmt[1].reserved));
+		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
+		pix_mp->plane_fmt[2].sizeimage = width * height / 4;
+		memset(&pix_mp->plane_fmt[2].reserved, 0, sizeof(pix_mp->plane_fmt[2].reserved));
+		break;
+	case V4L2_PIX_FMT_NV12M:
+	case V4L2_PIX_FMT_NV21M:
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[0].sizeimage = width * height;
+		memset(&pix_mp->plane_fmt[0].reserved, 0, sizeof(pix_mp->plane_fmt[0].reserved));
+		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[1].sizeimage = width * height / 2;
+		memset(&pix_mp->plane_fmt[1].reserved, 0, sizeof(pix_mp->plane_fmt[1].reserved));
+		break;
+	default:
+		pix_mp->width = width;
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = 0;
+		pix_mp->plane_fmt[0].sizeimage = width * height / 2;
+		memset(&pix_mp->plane_fmt[0].reserved, 0, sizeof(pix_mp->plane_fmt[0].reserved));
+		break;
+	}
+}
+
+static void wave5_vpu_dec_start_decode(struct vpu_instance *inst)
+{
+	struct dec_param pic_param;
+	struct queue_status_info q_status;
+	u32 remain_cmd_q, max_cmd_q = 0;
+	int ret;
+
+	memset(&pic_param, 0, sizeof(struct dec_param));
+
+	wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
+	dev_dbg(inst->dev->dev, "min_src_buf_cnt :%d default : %d | qcount : %d | report_q : %d\n",
+		inst->min_src_frame_buf_count, COMMAND_QUEUE_DEPTH, q_status.instance_queue_count,
+		q_status.report_queue_count);
+
+	max_cmd_q = (inst->min_src_frame_buf_count < COMMAND_QUEUE_DEPTH) ?
+		inst->min_src_frame_buf_count : COMMAND_QUEUE_DEPTH;
+	remain_cmd_q = max_cmd_q - q_status.instance_queue_count;
+
+	while (remain_cmd_q) {
+		u32 fail_res = 0;
+
+		ret = wave5_vpu_dec_start_one_frame(inst, &pic_param, &fail_res);
+		if (ret) {
+			if (fail_res != WAVE5_SYSERR_QUEUEING_FAIL) {
+				struct vb2_v4l2_buffer *src_buf =
+					v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx);
+
+				inst->state = VPU_INST_STATE_STOP;
+				v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
+				break;
+			}
+		}
+		remain_cmd_q--;
+	}
+}
+
+static void wave5_vpu_dec_stop_decode(struct vpu_instance *inst)
+{
+	u32 i;
+	unsigned long flags;
+
+	inst->state = VPU_INST_STATE_STOP;
+
+	spin_lock_irqsave(&inst->bitstream_lock, flags);
+	wave5_vpu_dec_update_bitstream_buffer(inst, 0);
+	spin_unlock_irqrestore(&inst->bitstream_lock, flags);
+
+	for (i = 0; i < inst->min_dst_frame_buf_count; i++)
+		wave5_vpu_dec_clr_disp_flag(inst, i);
+}
+
+static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
+{
+	struct dec_output_info dec_output_info;
+	int ret;
+	int irq_status;
+
+	if (kfifo_out(&inst->dev->irq_status, &irq_status, sizeof(int)))
+		wave5_vpu_clear_interrupt_ex(inst, irq_status);
+
+	if (irq_status & BIT(INT_WAVE5_BSBUF_EMPTY)) {
+		dev_dbg(inst->dev->dev, "bitstream EMPTY!!!!\n");
+		inst->state = VPU_INST_STATE_WAIT_BUF;
+		wave5_handle_src_buffer(inst);
+		wave5_handle_bitstream_buffer(inst);
+	}
+
+	if (!(irq_status & BIT(INT_WAVE5_DEC_PIC)))
+		return;
+	ret = wave5_vpu_dec_get_output_info(inst, &dec_output_info);
+	if (ret) {
+		v4l2_m2m_job_finish(inst->dev->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
+		return;
+	}
+	if (inst->state == VPU_INST_STATE_STOP) {
+		struct queue_status_info q_status;
+
+		if (dec_output_info.index_frame_display >= 0)
+			wave5_vpu_dec_clr_disp_flag(inst, dec_output_info.index_frame_display);
+
+		wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
+
+		if (!(q_status.report_queue_count + q_status.instance_queue_count))
+			v4l2_m2m_job_finish(inst->dev->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
+	} else if (dec_output_info.index_frame_decoded == DECODED_IDX_FLAG_NO_FB &&
+			dec_output_info.index_frame_display == DISPLAY_IDX_FLAG_NO_FB) {
+		dev_dbg(inst->dev->dev, "no more frame buffer\n");
+		inst->state = VPU_INST_STATE_WAIT_BUF;
+	} else {
+		wave5_handle_src_buffer(inst);
+
+		if (dec_output_info.index_frame_display >= 0) {
+			struct vb2_v4l2_buffer *dst_buf =
+				v4l2_m2m_dst_buf_remove_by_idx(inst->v4l2_fh.m2m_ctx,
+							       dec_output_info.index_frame_display);
+			int stride = dec_output_info.disp_frame.stride;
+			int height = dec_output_info.disp_pic_height;
+
+			if (inst->dst_fmt.num_planes == 1) {
+				vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
+						      (stride * height * 3 / 2));
+			} else if (inst->dst_fmt.num_planes == 2) {
+				vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
+						      (stride * height));
+				vb2_set_plane_payload(&dst_buf->vb2_buf, 1,
+						      ((stride / 2) * height));
+			} else if (inst->dst_fmt.num_planes == 3) {
+				vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
+						      (stride * height));
+				vb2_set_plane_payload(&dst_buf->vb2_buf, 1,
+						      ((stride / 2) * (height / 2)));
+				vb2_set_plane_payload(&dst_buf->vb2_buf, 2,
+						      ((stride / 2) * (height / 2)));
+			}
+
+			dst_buf->vb2_buf.timestamp = inst->timestamp;
+			dst_buf->field = V4L2_FIELD_NONE;
+			v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
+		} else if (dec_output_info.index_frame_display == DISPLAY_IDX_FLAG_SEQ_END) {
+			static const struct v4l2_event vpu_event_eos = {
+				.type = V4L2_EVENT_EOS
+			};
+
+			dev_dbg(inst->dev->dev, "stream end\n");
+			inst->state = VPU_INST_STATE_STOP;
+			v4l2_event_queue_fh(&inst->v4l2_fh, &vpu_event_eos);
+		}
+
+		if (!kfifo_len(&inst->dev->irq_status))
+			v4l2_m2m_job_finish(inst->dev->v4l2_m2m_dev,
+					    inst->v4l2_fh.m2m_ctx);
+	}
+}
+
+static int wave5_vpu_dec_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, VPU_DEC_DRV_NAME, sizeof(cap->driver));
+	strscpy(cap->card, VPU_DEC_DRV_NAME, sizeof(cap->card));
+	strscpy(cap->bus_info, "platform:" VPU_DEC_DRV_NAME, sizeof(cap->bus_info));
+
+	return 0;
+}
+
+static int wave5_vpu_dec_enum_framesizes(struct file *f, void *fh, struct v4l2_frmsizeenum *fsize)
+{
+	const struct vpu_format *vpu_fmt;
+
+	if (fsize->index)
+		return -EINVAL;
+
+	vpu_fmt = wave5_get_vpu_fmt(fsize->pixel_format, VPU_FMT_TYPE_CODEC);
+	if (!vpu_fmt) {
+		vpu_fmt = wave5_get_vpu_fmt(fsize->pixel_format, VPU_FMT_TYPE_RAW);
+		if (!vpu_fmt)
+			return -EINVAL;
+	}
+
+	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
+	fsize->stepwise.min_width = vpu_fmt->min_width;
+	fsize->stepwise.max_width = vpu_fmt->max_width;
+	fsize->stepwise.step_width = 1;
+	fsize->stepwise.min_height = vpu_fmt->min_height;
+	fsize->stepwise.max_height = vpu_fmt->max_height;
+	fsize->stepwise.step_height = 1;
+
+	return 0;
+}
+
+static int wave5_vpu_dec_enum_fmt_cap(struct file *file, void *fh, struct v4l2_fmtdesc *f)
+{
+	const struct vpu_format *vpu_fmt;
+
+	vpu_fmt = wave5_find_vpu_fmt_by_idx(f->index, VPU_FMT_TYPE_RAW);
+	if (!vpu_fmt)
+		return -EINVAL;
+
+	f->pixelformat = vpu_fmt->v4l2_pix_fmt;
+	f->flags = 0;
+
+	return 0;
+}
+
+static int wave5_vpu_dec_try_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	const struct vpu_format *vpu_fmt;
+
+	dev_dbg(inst->dev->dev, "4cc %d width %d height %d nm planes %d colorspace %d field : %d\n",
+		f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.colorspace, f->fmt.pix_mp.field);
+
+	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		return -EINVAL;
+
+	vpu_fmt = wave5_get_vpu_fmt(f->fmt.pix_mp.pixelformat, VPU_FMT_TYPE_RAW);
+	if (!vpu_fmt) {
+		f->fmt.pix_mp.pixelformat = inst->dst_fmt.pixelformat;
+		f->fmt.pix_mp.num_planes = inst->dst_fmt.num_planes;
+		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->dst_fmt.width, inst->dst_fmt.height);
+	} else {
+		int width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
+		int height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
+		const struct v4l2_format_info *info = v4l2_format_info(vpu_fmt->v4l2_pix_fmt);
+
+		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
+		f->fmt.pix_mp.num_planes = info->mem_planes;
+		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
+	}
+
+	f->fmt.pix_mp.flags = 0;
+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	f->fmt.pix_mp.colorspace = inst->colorspace;
+	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
+	f->fmt.pix_mp.hsv_enc = inst->hsv_enc;
+	f->fmt.pix_mp.quantization = inst->quantization;
+	f->fmt.pix_mp.xfer_func = inst->xfer_func;
+	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
+
+	return 0;
+}
+
+static int wave5_vpu_dec_s_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	int i, ret;
+
+	dev_dbg(inst->dev->dev, "4cc %d width %d height %d num_planes %d colorspace %d field %d\n",
+		f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.colorspace, f->fmt.pix_mp.field);
+
+	ret = wave5_vpu_dec_try_fmt_cap(file, fh, f);
+	if (ret)
+		return ret;
+
+	inst->dst_fmt.width = f->fmt.pix_mp.width;
+	inst->dst_fmt.height = f->fmt.pix_mp.height;
+	inst->dst_fmt.pixelformat = f->fmt.pix_mp.pixelformat;
+	inst->dst_fmt.field = f->fmt.pix_mp.field;
+	inst->dst_fmt.flags = f->fmt.pix_mp.flags;
+	inst->dst_fmt.num_planes = f->fmt.pix_mp.num_planes;
+	for (i = 0; i < inst->dst_fmt.num_planes; i++) {
+		inst->dst_fmt.plane_fmt[i].bytesperline = f->fmt.pix_mp.plane_fmt[i].bytesperline;
+		inst->dst_fmt.plane_fmt[i].sizeimage = f->fmt.pix_mp.plane_fmt[i].sizeimage;
+	}
+
+	return 0;
+}
+
+static int wave5_vpu_dec_g_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	int i;
+
+	f->fmt.pix_mp.width = inst->dst_fmt.width;
+	f->fmt.pix_mp.height = inst->dst_fmt.height;
+	f->fmt.pix_mp.pixelformat = inst->dst_fmt.pixelformat;
+	f->fmt.pix_mp.field = inst->dst_fmt.field;
+	f->fmt.pix_mp.flags = inst->dst_fmt.flags;
+	f->fmt.pix_mp.num_planes = inst->dst_fmt.num_planes;
+	for (i = 0; i < f->fmt.pix_mp.num_planes; i++) {
+		f->fmt.pix_mp.plane_fmt[i].bytesperline = inst->dst_fmt.plane_fmt[i].bytesperline;
+		f->fmt.pix_mp.plane_fmt[i].sizeimage = inst->dst_fmt.plane_fmt[i].sizeimage;
+	}
+
+	f->fmt.pix_mp.colorspace = inst->colorspace;
+	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
+	f->fmt.pix_mp.hsv_enc = inst->hsv_enc;
+	f->fmt.pix_mp.quantization = inst->quantization;
+	f->fmt.pix_mp.xfer_func = inst->xfer_func;
+
+	return 0;
+}
+
+static int wave5_vpu_dec_enum_fmt_out(struct file *file, void *fh, struct v4l2_fmtdesc *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	const struct vpu_format *vpu_fmt;
+
+	dev_dbg(inst->dev->dev, "index : %d\n", f->index);
+
+	vpu_fmt = wave5_find_vpu_fmt_by_idx(f->index, VPU_FMT_TYPE_CODEC);
+	if (!vpu_fmt)
+		return -EINVAL;
+
+	f->pixelformat = vpu_fmt->v4l2_pix_fmt;
+	f->flags = 0;
+
+	return 0;
+}
+
+static int wave5_vpu_dec_try_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	const struct vpu_format *vpu_fmt;
+
+	dev_dbg(inst->dev->dev, "4cc %d width %d height %d num_planes %d colorspace %d field %d\n",
+		f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.colorspace, f->fmt.pix_mp.field);
+
+	if (f->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+
+	vpu_fmt = wave5_get_vpu_fmt(f->fmt.pix_mp.pixelformat, VPU_FMT_TYPE_CODEC);
+	if (!vpu_fmt) {
+		f->fmt.pix_mp.pixelformat = inst->src_fmt.pixelformat;
+		f->fmt.pix_mp.num_planes = inst->src_fmt.num_planes;
+		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->src_fmt.width, inst->src_fmt.height);
+	} else {
+		int width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
+		int height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
+
+		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
+		f->fmt.pix_mp.num_planes = 1;
+		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
+	}
+
+	f->fmt.pix_mp.flags = 0;
+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
+
+	return 0;
+}
+
+static int wave5_vpu_dec_s_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	int i, ret;
+
+	dev_dbg(inst->dev->dev, "pixelformat %d width %d height %d num_planes %d field : %d\n",
+		f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
+
+	ret = wave5_vpu_dec_try_fmt_out(file, fh, f);
+	if (ret)
+		return ret;
+
+	inst->src_fmt.width = f->fmt.pix_mp.width;
+	inst->src_fmt.height = f->fmt.pix_mp.height;
+	inst->src_fmt.pixelformat = f->fmt.pix_mp.pixelformat;
+	inst->src_fmt.field = f->fmt.pix_mp.field;
+	inst->src_fmt.flags = f->fmt.pix_mp.flags;
+	inst->src_fmt.num_planes = f->fmt.pix_mp.num_planes;
+	for (i = 0; i < inst->src_fmt.num_planes; i++) {
+		inst->src_fmt.plane_fmt[i].bytesperline = f->fmt.pix_mp.plane_fmt[i].bytesperline;
+		inst->src_fmt.plane_fmt[i].sizeimage = f->fmt.pix_mp.plane_fmt[i].sizeimage;
+	}
+
+	inst->colorspace = f->fmt.pix_mp.colorspace;
+	inst->ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
+	inst->hsv_enc = f->fmt.pix_mp.hsv_enc;
+	inst->quantization = f->fmt.pix_mp.quantization;
+	inst->xfer_func = f->fmt.pix_mp.xfer_func;
+
+	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_mp.height);
+
+	return 0;
+}
+
+static int wave5_vpu_dec_g_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	int i;
+
+	f->fmt.pix_mp.width = inst->src_fmt.width;
+	f->fmt.pix_mp.height = inst->src_fmt.height;
+	f->fmt.pix_mp.pixelformat = inst->src_fmt.pixelformat;
+	f->fmt.pix_mp.field = inst->src_fmt.field;
+	f->fmt.pix_mp.flags = inst->src_fmt.flags;
+	f->fmt.pix_mp.num_planes = inst->src_fmt.num_planes;
+	for (i = 0; i < f->fmt.pix_mp.num_planes; i++) {
+		f->fmt.pix_mp.plane_fmt[i].bytesperline = inst->src_fmt.plane_fmt[i].bytesperline;
+		f->fmt.pix_mp.plane_fmt[i].sizeimage = inst->src_fmt.plane_fmt[i].sizeimage;
+	}
+
+	f->fmt.pix_mp.colorspace = inst->colorspace;
+	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
+	f->fmt.pix_mp.hsv_enc = inst->hsv_enc;
+	f->fmt.pix_mp.quantization = inst->quantization;
+	f->fmt.pix_mp.xfer_func = inst->xfer_func;
+
+	return 0;
+}
+
+static int wave5_vpu_dec_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+
+	dev_dbg(inst->dev->dev, "type : %d | target : %d\n", s->type, s->target);
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+	switch (s->target) {
+	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+	case V4L2_SEL_TGT_COMPOSE_PADDED:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = inst->dst_fmt.width;
+		s->r.height = inst->dst_fmt.height;
+		break;
+	case V4L2_SEL_TGT_COMPOSE:
+	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = inst->src_fmt.width;
+		s->r.height = inst->src_fmt.height;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int wave5_vpu_dec_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+
+	dev_dbg(inst->dev->dev, "type : %d | target : %d\n", s->type, s->target);
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	if (s->target != V4L2_SEL_TGT_COMPOSE)
+		return -EINVAL;
+
+	dev_dbg(inst->dev->dev, "V4L2_SEL_TGT_COMPOSE w: %d h: %d\n", s->r.width, s->r.height);
+	inst->dst_fmt.width = s->r.width;
+	inst->dst_fmt.height = s->r.height;
+
+	return 0;
+}
+
+static int wave5_vpu_dec_try_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *dc)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+
+	dev_dbg(inst->dev->dev, "decoder command : %d\n", dc->cmd);
+
+	if (dc->cmd != V4L2_DEC_CMD_STOP && dc->cmd != V4L2_DEC_CMD_START)
+		return -EINVAL;
+
+	dc->flags = 0;
+
+	if (dc->cmd == V4L2_DEC_CMD_STOP) {
+		dc->stop.pts = 0;
+	} else if (dc->cmd == V4L2_DEC_CMD_START) {
+		dc->start.speed = 0;
+		dc->start.format = V4L2_DEC_START_FMT_NONE;
+	}
+
+	return 0;
+}
+
+static int wave5_vpu_dec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *dc)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	int ret;
+
+	dev_dbg(inst->dev->dev, "decoder command : %d\n", dc->cmd);
+
+	ret = wave5_vpu_dec_try_decoder_cmd(file, fh, dc);
+	if (ret < 0)
+		return ret;
+
+	if (!wave5_vpu_both_queues_are_streaming(inst))
+		return 0;
+
+	switch (dc->cmd) {
+	case V4L2_DEC_CMD_STOP:
+		wave5_vpu_dec_stop_decode(inst);
+		break;
+	case V4L2_DEC_CMD_START:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int wave5_vpu_dec_subscribe_event(struct v4l2_fh *fh,
+					 const struct v4l2_event_subscription *sub)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+
+	dev_dbg(inst->dev->dev, "type : %d id : %d | flags : %d\n", sub->type, sub->id, sub->flags);
+
+	switch (sub->type) {
+	case V4L2_EVENT_EOS:
+		return v4l2_event_subscribe(fh, sub, 0, NULL);
+	case V4L2_EVENT_SOURCE_CHANGE:
+		return v4l2_src_change_event_subscribe(fh, sub);
+	case V4L2_EVENT_CTRL:
+		return v4l2_ctrl_subscribe_event(fh, sub);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct v4l2_ioctl_ops wave5_vpu_dec_ioctl_ops = {
+	.vidioc_querycap = wave5_vpu_dec_querycap,
+	.vidioc_enum_framesizes = wave5_vpu_dec_enum_framesizes,
+
+	.vidioc_enum_fmt_vid_cap	= wave5_vpu_dec_enum_fmt_cap,
+	.vidioc_s_fmt_vid_cap_mplane = wave5_vpu_dec_s_fmt_cap,
+	.vidioc_g_fmt_vid_cap_mplane = wave5_vpu_dec_g_fmt_cap,
+	.vidioc_try_fmt_vid_cap_mplane = wave5_vpu_dec_try_fmt_cap,
+
+	.vidioc_enum_fmt_vid_out	= wave5_vpu_dec_enum_fmt_out,
+	.vidioc_s_fmt_vid_out_mplane = wave5_vpu_dec_s_fmt_out,
+	.vidioc_g_fmt_vid_out_mplane = wave5_vpu_dec_g_fmt_out,
+	.vidioc_try_fmt_vid_out_mplane = wave5_vpu_dec_try_fmt_out,
+
+	.vidioc_g_selection = wave5_vpu_dec_g_selection,
+	.vidioc_s_selection = wave5_vpu_dec_s_selection,
+
+	.vidioc_reqbufs = v4l2_m2m_ioctl_reqbufs,
+	.vidioc_querybuf = v4l2_m2m_ioctl_querybuf,
+	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
+	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
+	.vidioc_qbuf = v4l2_m2m_ioctl_qbuf,
+	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
+	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
+	.vidioc_streamon = v4l2_m2m_ioctl_streamon,
+	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
+
+	.vidioc_try_decoder_cmd = wave5_vpu_dec_try_decoder_cmd,
+	.vidioc_decoder_cmd = wave5_vpu_dec_decoder_cmd,
+
+	.vidioc_subscribe_event = wave5_vpu_dec_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+static int wave5_vpu_dec_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vpu_instance *inst = wave5_ctrl_to_vpu_inst(ctrl);
+
+	dev_dbg(inst->dev->dev, "name : %s\n", ctrl->name);
+
+	switch (ctrl->id) {
+	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
+		if (inst->state != VPU_INST_STATE_NONE && inst->state != VPU_INST_STATE_OPEN)
+			ctrl->val = inst->min_dst_frame_buf_count;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(inst->dev->dev, "value : %d\n", ctrl->val);
+
+	return 0;
+}
+
+static int wave5_vpu_dec_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vpu_instance *inst = wave5_ctrl_to_vpu_inst(ctrl);
+
+	dev_dbg(inst->dev->dev, "name : %s | value : %d\n", ctrl->name, ctrl->val);
+
+	switch (ctrl->id) {
+	case V4L2_CID_VPU_THUMBNAIL_MODE:
+		inst->thumbnail_mode = ctrl->val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops wave5_vpu_dec_ctrl_ops = {
+	.g_volatile_ctrl = wave5_vpu_dec_g_volatile_ctrl,
+	.s_ctrl = wave5_vpu_dec_s_ctrl,
+};
+
+static const struct v4l2_ctrl_config wave5_vpu_thumbnail_mode = {
+	.ops = &wave5_vpu_dec_ctrl_ops,
+	.id = V4L2_CID_VPU_THUMBNAIL_MODE,
+	.name = "thumbnail mode",
+	.type = V4L2_CTRL_TYPE_BOOLEAN,
+	.def = 0,
+	.min = 0,
+	.max = 1,
+	.step = 1,
+	.flags = V4L2_CTRL_FLAG_WRITE_ONLY,
+};
+
+static void wave5_set_default_dec_openparam(struct dec_open_param *open_param)
+{
+	open_param->bitstream_mode = BS_MODE_INTERRUPT;
+	open_param->stream_endian = VPU_STREAM_ENDIAN;
+	open_param->frame_endian = VPU_FRAME_ENDIAN;
+	open_param->cbcr_interleave = false;
+	open_param->nv21 = false;
+}
+
+static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
+				     unsigned int *num_planes, unsigned int sizes[],
+			 struct device *alloc_devs[])
+{
+	struct vpu_instance *inst = vb2_get_drv_priv(q);
+	struct v4l2_pix_format_mplane inst_format =
+		(q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : inst->dst_fmt;
+	unsigned int i;
+	int ret;
+
+	dev_dbg(inst->dev->dev, "num_buffers : %d | num_planes : %d | type : %d\n", *num_buffers,
+		*num_planes, q->type);
+
+	if (*num_planes) {
+		if (inst_format.num_planes != *num_planes)
+			return -EINVAL;
+
+		for (i = 0; i < *num_planes; i++) {
+			if (sizes[i] < inst_format.plane_fmt[i].sizeimage)
+				return -EINVAL;
+		}
+	} else {
+		*num_planes = inst_format.num_planes;
+
+		if (*num_planes == 1) {
+			sizes[0] = inst_format.width * inst_format.height * 3 / 2;
+			if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+				sizes[0] = inst_format.plane_fmt[0].sizeimage;
+			dev_dbg(inst->dev->dev, "size[0] : %d\n", sizes[0]);
+		} else if (*num_planes == 2) {
+			sizes[0] = inst_format.width * inst_format.height;
+			sizes[1] = inst_format.width * inst_format.height / 2;
+			dev_dbg(inst->dev->dev, "size[0] :%d | size[1] : %d\n", sizes[0], sizes[1]);
+		} else if (*num_planes == 3) {
+			sizes[0] = inst_format.width * inst_format.height;
+			sizes[1] = inst_format.width * inst_format.height / 4;
+			sizes[2] = inst_format.width * inst_format.height / 4;
+			dev_dbg(inst->dev->dev, "size[0] : %d | size[1] : %d | size[2] : %d\n",
+				sizes[0], sizes[1], sizes[2]);
+		}
+	}
+
+	if (inst->state == VPU_INST_STATE_NONE && q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		struct dec_open_param open_param;
+
+		memset(&open_param, 0, sizeof(struct dec_open_param));
+		wave5_set_default_dec_openparam(&open_param);
+
+		inst->bitstream_vbuf.size = ALIGN(inst->src_fmt.plane_fmt[0].sizeimage, 1024) * 4;
+		ret = wave5_vdi_allocate_dma_memory(inst->dev, &inst->bitstream_vbuf);
+		if (ret) {
+			dev_dbg(inst->dev->dev, "alloc bitstream of size %zu failed\n",
+				inst->bitstream_vbuf.size);
+			return ret;
+		}
+
+		inst->std = wave5_to_vpu_codstd(inst->src_fmt.pixelformat);
+		if (inst->std == STD_UNKNOWN) {
+			dev_warn(inst->dev->dev, "unsupported pixelformat: %.4s\n",
+				 (char *)&inst->src_fmt.pixelformat);
+			return -EINVAL;
+		}
+		open_param.bitstream_buffer = inst->bitstream_vbuf.daddr;
+		open_param.bitstream_buffer_size = inst->bitstream_vbuf.size;
+
+		ret = wave5_vpu_dec_open(inst, &open_param);
+		if (ret) {
+			dev_dbg(inst->dev->dev, "wave5_vpu_dec_open failed: %d\n", ret);
+			return ret;
+		}
+
+		inst->state = VPU_INST_STATE_OPEN;
+
+		if (inst->thumbnail_mode)
+			wave5_vpu_dec_give_command(inst, ENABLE_DEC_THUMBNAIL_MODE, NULL);
+
+		inst->min_src_frame_buf_count = *num_buffers;
+
+	} else if (inst->state != VPU_INST_STATE_NONE &&
+	    inst->state != VPU_INST_STATE_OPEN &&
+	    q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
+		u32 non_linear_num = inst->min_dst_frame_buf_count;
+		u32 fb_stride, fb_height;
+		u32 luma_size, chroma_size;
+
+		*num_buffers = inst->min_dst_frame_buf_count;
+
+		if (inst->state != VPU_INST_STATE_INIT_SEQ)
+			return 0;
+
+		for (i = 0; i < non_linear_num; i++) {
+			struct frame_buffer *frame = &inst->frame_buf[i];
+			struct vpu_buf *vframe = &inst->frame_vbuf[i];
+
+			fb_stride = inst->dst_fmt.width;
+			fb_height = ALIGN(inst->dst_fmt.height, 32);
+			luma_size = fb_stride * fb_height;
+			chroma_size = ALIGN(fb_stride / 2, 16) * fb_height;
+
+			vframe->size = luma_size + chroma_size;
+			ret = wave5_vdi_allocate_dma_memory(inst->dev, vframe);
+			if (ret) {
+				dev_dbg(inst->dev->dev, "alloc FBC buff of size %zu failed\n",
+					vframe->size);
+				return ret;
+			}
+
+			frame->buf_y = vframe->daddr;
+			frame->buf_cb = vframe->daddr + luma_size;
+			frame->buf_cr = (dma_addr_t)-1;
+			frame->size = vframe->size;
+			frame->width = inst->src_fmt.width;
+			frame->stride = fb_stride;
+			frame->map_type = COMPRESSED_FRAME_MAP;
+			frame->update_fb_info = true;
+		}
+	}
+
+	return 0;
+}
+
+static void wave5_vpu_dec_start_streaming_inst_open(struct vb2_queue *q, unsigned int count)
+{
+	struct dec_initial_info initial_info;
+	struct vpu_instance *inst = vb2_get_drv_priv(q);
+	int ret;
+
+	ret = wave5_vpu_dec_issue_seq_init(inst);
+	if (ret)
+		dev_dbg(inst->dev->dev, "failed wave5_vpu_dec_issue_seq_init %d\n", ret);
+
+	if (wave5_vpu_wait_interrupt(inst, VPU_DEC_TIMEOUT) < 0)
+		dev_dbg(inst->dev->dev, "failed to call vpu_wait_interrupt()\n");
+
+	ret = wave5_vpu_dec_complete_seq_init(inst, &initial_info);
+	if (ret) {
+		dev_dbg(inst->dev->dev, "vpu_dec_complete_seq_init: %d, reason : %d\n",
+			ret, initial_info.seq_init_err_reason);
+	} else {
+		static const struct v4l2_event vpu_event_src_ch = {
+			.type = V4L2_EVENT_SOURCE_CHANGE,
+			.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION,
+		};
+
+		dev_dbg(inst->dev->dev, "width %d height %d profile %d | minbuffer : %u\n",
+			initial_info.pic_width, initial_info.pic_height,
+			initial_info.profile, initial_info.min_frame_buffer_count);
+
+		inst->state = VPU_INST_STATE_INIT_SEQ;
+		inst->min_dst_frame_buf_count = initial_info.min_frame_buffer_count + 1;
+
+		if (initial_info.pic_width != inst->src_fmt.width ||
+		    initial_info.pic_height != inst->src_fmt.height) {
+			wave5_update_pix_fmt(&inst->src_fmt, initial_info.pic_width,
+					     initial_info.pic_height);
+			wave5_update_pix_fmt(&inst->dst_fmt, initial_info.pic_width,
+					     initial_info.pic_height);
+		}
+		v4l2_event_queue_fh(&inst->v4l2_fh, &vpu_event_src_ch);
+	}
+}
+
+static void wave5_vpu_dec_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct vpu_instance *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vpu_buffer *vpu_buf = wave5_to_vpu_buf(vbuf);
+
+	dev_dbg(inst->dev->dev, "type %4d index %4d size[0] %4ld size[1] : %4ld | size[2] : %4ld\n",
+		vb->type, vb->index, vb2_plane_size(&vbuf->vb2_buf, 0),
+		vb2_plane_size(&vbuf->vb2_buf, 1), vb2_plane_size(&vbuf->vb2_buf, 2));
+
+	v4l2_m2m_buf_queue(inst->v4l2_fh.m2m_ctx, vbuf);
+
+	if (vb->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		vpu_buf->consumed = false;
+		wave5_handle_bitstream_buffer(inst);
+		vbuf->sequence = inst->queued_src_buf_num++;
+	}
+
+	if (vb->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		return;
+
+	if (inst->state == VPU_INST_STATE_INIT_SEQ) {
+		dma_addr_t buf_addr_y = 0, buf_addr_cb = 0, buf_addr_cr = 0;
+		u32 buf_size = 0;
+		u32 non_linear_num = inst->min_dst_frame_buf_count;
+		u32 fb_stride = inst->dst_fmt.width;
+		u32 luma_size = fb_stride * inst->dst_fmt.height;
+		u32 chroma_size = (fb_stride / 2) * (inst->dst_fmt.height / 2);
+
+		if (inst->dst_fmt.num_planes == 1) {
+			buf_size = vb2_plane_size(&vbuf->vb2_buf, 0);
+			buf_addr_y = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
+			buf_addr_cb = buf_addr_y + luma_size;
+			buf_addr_cr = buf_addr_cb + chroma_size;
+		} else if (inst->dst_fmt.num_planes == 2) {
+			buf_size = vb2_plane_size(&vbuf->vb2_buf, 0) +
+				vb2_plane_size(&vbuf->vb2_buf, 1);
+			buf_addr_y = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
+			buf_addr_cb = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 1);
+			buf_addr_cr = buf_addr_cb + chroma_size;
+		} else if (inst->dst_fmt.num_planes == 3) {
+			buf_size = vb2_plane_size(&vbuf->vb2_buf, 0) +
+				vb2_plane_size(&vbuf->vb2_buf, 1) +
+				vb2_plane_size(&vbuf->vb2_buf, 2);
+			buf_addr_y = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
+			buf_addr_cb = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 1);
+			buf_addr_cr = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 2);
+		}
+		inst->frame_buf[vb->index + non_linear_num].buf_y = buf_addr_y;
+		inst->frame_buf[vb->index + non_linear_num].buf_cb = buf_addr_cb;
+		inst->frame_buf[vb->index + non_linear_num].buf_cr = buf_addr_cr;
+		inst->frame_buf[vb->index + non_linear_num].size = buf_size;
+		inst->frame_buf[vb->index + non_linear_num].width = inst->src_fmt.width;
+		inst->frame_buf[vb->index + non_linear_num].stride = fb_stride;
+		inst->frame_buf[vb->index + non_linear_num].map_type = LINEAR_FRAME_MAP;
+		inst->frame_buf[vb->index + non_linear_num].update_fb_info = true;
+	}
+
+	if (inst->state == VPU_INST_STATE_PIC_RUN ||
+	    inst->state == VPU_INST_STATE_STOP ||
+	    inst->state == VPU_INST_STATE_WAIT_BUF) {
+		wave5_vpu_dec_clr_disp_flag(inst, vb->index);
+		if (inst->state == VPU_INST_STATE_WAIT_BUF)
+			inst->state = VPU_INST_STATE_PIC_RUN;
+	}
+	vbuf->sequence = inst->queued_dst_buf_num++;
+}
+
+static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count)
+{
+	struct vpu_instance *inst = vb2_get_drv_priv(q);
+	int ret;
+
+	dev_dbg(inst->dev->dev, "type : %d\n", q->type);
+
+	if (inst->state == VPU_INST_STATE_OPEN)
+		wave5_vpu_dec_start_streaming_inst_open(q, count);
+
+	if (inst->state == VPU_INST_STATE_INIT_SEQ &&
+	    q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
+		u32 non_linear_num = inst->min_dst_frame_buf_count;
+		u32 linear_num = inst->min_dst_frame_buf_count;
+		u32 stride = inst->dst_fmt.width;
+
+		dev_dbg(inst->dev->dev, "stride %d dst height %d\n", stride, inst->dst_fmt.height);
+		ret = wave5_vpu_dec_register_frame_buffer_ex(inst, non_linear_num, linear_num,
+							     stride, inst->dst_fmt.height,
+							    COMPRESSED_FRAME_MAP);
+		if (ret)
+			dev_dbg(inst->dev->dev, "fail vpu_dec_register_frame_buffer_ex %d", ret);
+
+		inst->state = VPU_INST_STATE_PIC_RUN;
+	}
+
+	return 0;
+}
+
+static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
+{
+	struct vpu_instance *inst = vb2_get_drv_priv(q);
+	struct vb2_v4l2_buffer *buf;
+
+	dev_dbg(inst->dev->dev, "type : %d\n", q->type);
+
+	if (wave5_vpu_both_queues_are_streaming(inst))
+		inst->state = VPU_INST_STATE_STOP;
+
+	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		while ((buf = v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx))) {
+			dev_dbg(inst->dev->dev, "buf type : %4d | index : %4d\n", buf->vb2_buf.type,
+				buf->vb2_buf.index);
+			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
+		}
+	} else {
+		while ((buf = v4l2_m2m_dst_buf_remove(inst->v4l2_fh.m2m_ctx))) {
+			u32 plane;
+
+			dev_dbg(inst->dev->dev, "buf type : %4d | index : %4d\n", buf->vb2_buf.type,
+				buf->vb2_buf.index);
+
+			for (plane = 0; plane < inst->dst_fmt.num_planes; plane++)
+				vb2_set_plane_payload(&buf->vb2_buf, plane, 0);
+
+			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
+		}
+	}
+}
+
+static const struct vb2_ops wave5_vpu_dec_vb2_ops = {
+	.queue_setup = wave5_vpu_dec_queue_setup,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+	.buf_queue = wave5_vpu_dec_buf_queue,
+	.start_streaming = wave5_vpu_dec_start_streaming,
+	.stop_streaming = wave5_vpu_dec_stop_streaming,
+};
+
+static void wave5_set_default_format(struct v4l2_pix_format_mplane *src_fmt,
+				     struct v4l2_pix_format_mplane *dst_fmt)
+{
+	unsigned int dst_pix_fmt = wave5_vpu_dec_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix_fmt;
+	const struct v4l2_format_info *dst_fmt_info = v4l2_format_info(dst_pix_fmt);
+
+	src_fmt->pixelformat = wave5_vpu_dec_fmt_list[VPU_FMT_TYPE_CODEC][0].v4l2_pix_fmt;
+	src_fmt->field = V4L2_FIELD_NONE;
+	src_fmt->flags = 0;
+	src_fmt->num_planes = 1;
+	wave5_update_pix_fmt(src_fmt, 720, 480);
+
+	dst_fmt->pixelformat = dst_pix_fmt;
+	dst_fmt->field = V4L2_FIELD_NONE;
+	dst_fmt->flags = 0;
+	dst_fmt->num_planes = dst_fmt_info->mem_planes;
+	wave5_update_pix_fmt(dst_fmt, 736, 480);
+}
+
+static int wave5_vpu_dec_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
+{
+	struct vpu_instance *inst = priv;
+	int ret;
+
+	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	src_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
+	src_vq->mem_ops = &vb2_dma_contig_memops;
+	src_vq->ops = &wave5_vpu_dec_vb2_ops;
+	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	src_vq->buf_struct_size = sizeof(struct vpu_buffer);
+	src_vq->allow_zero_bytesused = 1;
+	src_vq->min_buffers_needed = 0;
+	src_vq->drv_priv = inst;
+	src_vq->lock = &inst->dev->dev_lock;
+	src_vq->dev = inst->dev->v4l2_dev.dev;
+	ret = vb2_queue_init(src_vq);
+	if (ret)
+		return ret;
+
+	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	dst_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
+	dst_vq->mem_ops = &vb2_dma_contig_memops;
+	dst_vq->ops = &wave5_vpu_dec_vb2_ops;
+	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	dst_vq->buf_struct_size = sizeof(struct vpu_buffer);
+	dst_vq->allow_zero_bytesused = 1;
+	dst_vq->min_buffers_needed = 0;
+	dst_vq->drv_priv = inst;
+	dst_vq->lock = &inst->dev->dev_lock;
+	dst_vq->dev = inst->dev->v4l2_dev.dev;
+	ret = vb2_queue_init(dst_vq);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct vpu_instance_ops wave5_vpu_dec_inst_ops = {
+	.start_process = wave5_vpu_dec_start_decode,
+	.stop_process = wave5_vpu_dec_stop_decode,
+	.finish_process = wave5_vpu_dec_finish_decode,
+};
+
+static int wave5_vpu_open_dec(struct file *filp)
+{
+	struct video_device *vdev = video_devdata(filp);
+	struct vpu_device *dev = video_drvdata(filp);
+	struct vpu_instance *inst = NULL;
+	struct v4l2_ctrl *ctrl;
+	int ret;
+
+	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+
+	inst->dev = dev;
+	inst->type = VPU_INST_TYPE_DEC;
+	inst->ops = &wave5_vpu_dec_inst_ops;
+
+	spin_lock_init(&inst->bitstream_lock);
+
+	v4l2_fh_init(&inst->v4l2_fh, vdev);
+	filp->private_data = &inst->v4l2_fh;
+	v4l2_fh_add(&inst->v4l2_fh);
+
+	inst->v4l2_fh.m2m_ctx =
+		v4l2_m2m_ctx_init(dev->v4l2_m2m_dev, inst, wave5_vpu_dec_queue_init);
+	if (IS_ERR(inst->v4l2_fh.m2m_ctx)) {
+		ret = PTR_ERR(inst->v4l2_fh.m2m_ctx);
+		goto free_inst;
+	}
+
+	v4l2_ctrl_handler_init(&inst->v4l2_ctrl_hdl, 10);
+	v4l2_ctrl_new_custom(&inst->v4l2_ctrl_hdl, &wave5_vpu_thumbnail_mode, NULL);
+	ctrl = v4l2_ctrl_new_std(&inst->v4l2_ctrl_hdl, &wave5_vpu_dec_ctrl_ops,
+				 V4L2_CID_MIN_BUFFERS_FOR_CAPTURE, 1, 32, 1, 1);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+
+	if (inst->v4l2_ctrl_hdl.error) {
+		return -ENODEV;
+		goto free_inst;
+	}
+
+	inst->v4l2_fh.ctrl_handler = &inst->v4l2_ctrl_hdl;
+	v4l2_ctrl_handler_setup(&inst->v4l2_ctrl_hdl);
+
+	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
+	inst->colorspace = V4L2_COLORSPACE_REC709;
+	inst->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	inst->hsv_enc = 0;
+	inst->quantization = V4L2_QUANTIZATION_DEFAULT;
+	inst->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+
+	return 0;
+
+free_inst:
+	kfree(inst);
+	return ret;
+}
+
+static int wave5_vpu_dec_release(struct file *filp)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(filp->private_data);
+	u32 fail_res;
+	int retry_count = 10;
+	int i, ret;
+
+	v4l2_m2m_ctx_release(inst->v4l2_fh.m2m_ctx);
+	if (inst->state != VPU_INST_STATE_NONE) {
+		do {
+			fail_res = 0;
+			ret = wave5_vpu_dec_close(inst, &fail_res);
+			if (ret && ret != -EIO)
+				break;
+			if (fail_res != WAVE5_SYSERR_VPU_STILL_RUNNING)
+				break;
+			if (!wave5_vpu_wait_interrupt(inst, VPU_DEC_TIMEOUT))
+				break;
+		} while (--retry_count);
+
+		if (fail_res == WAVE5_SYSERR_VPU_STILL_RUNNING)
+			dev_warn(inst->dev->dev, "close fail res %u\n", fail_res);
+		if (ret && ret != -EIO)
+			dev_warn(inst->dev->dev, "close fail ret=%d\n", ret);
+	}
+
+	for (i = 0; i < inst->min_dst_frame_buf_count; i++)
+		wave5_vdi_free_dma_memory(inst->dev, &inst->frame_vbuf[i]);
+
+	wave5_vdi_free_dma_memory(inst->dev, &inst->bitstream_vbuf);
+	v4l2_ctrl_handler_free(&inst->v4l2_ctrl_hdl);
+	v4l2_fh_del(&inst->v4l2_fh);
+	v4l2_fh_exit(&inst->v4l2_fh);
+	kfree(inst);
+
+	return 0;
+}
+
+static const struct v4l2_file_operations wave5_vpu_dec_fops = {
+	.owner = THIS_MODULE,
+	.open = wave5_vpu_open_dec,
+	.release = wave5_vpu_dec_release,
+	.unlocked_ioctl = video_ioctl2,
+	.poll = v4l2_m2m_fop_poll,
+	.mmap = v4l2_m2m_fop_mmap,
+};
+
+int wave5_vpu_dec_register_device(struct vpu_device *dev)
+{
+	struct video_device *vdev_dec;
+	int ret;
+
+	vdev_dec = devm_kzalloc(dev->v4l2_dev.dev, sizeof(*vdev_dec), GFP_KERNEL);
+	if (!vdev_dec)
+		return -ENOMEM;
+
+	dev->video_dev_dec = vdev_dec;
+
+	strscpy(vdev_dec->name, VPU_DEC_DEV_NAME, sizeof(vdev_dec->name));
+	vdev_dec->fops = &wave5_vpu_dec_fops;
+	vdev_dec->ioctl_ops = &wave5_vpu_dec_ioctl_ops;
+	vdev_dec->release = video_device_release_empty;
+	vdev_dec->v4l2_dev = &dev->v4l2_dev;
+	vdev_dec->vfl_dir = VFL_DIR_M2M;
+	vdev_dec->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
+	vdev_dec->lock = &dev->dev_lock;
+
+	ret = video_register_device(vdev_dec, VFL_TYPE_VIDEO, -1);
+	if (ret)
+		return ret;
+
+	video_set_drvdata(vdev_dec, dev);
+
+	return 0;
+}
+
+void wave5_vpu_dec_unregister_device(struct vpu_device *dev)
+{
+	video_unregister_device(dev->video_dev_dec);
+}
+
diff --git a/drivers/staging/media/wave5/wave5-vpu-enc.c b/drivers/staging/media/wave5/wave5-vpu-enc.c
new file mode 100644
index 000000000000..4a9d21715296
--- /dev/null
+++ b/drivers/staging/media/wave5/wave5-vpu-enc.c
@@ -0,0 +1,1499 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Wave5 series multi-standard codec IP - encoder interface
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#include "wave5-vpu.h"
+
+#define VPU_ENC_DEV_NAME "C&M VPU encoder"
+#define VPU_ENC_DRV_NAME "vpu-enc"
+
+static const struct vpu_format wave5_vpu_enc_fmt_list[2][6] = {
+	[VPU_FMT_TYPE_CODEC] = {
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_HEVC,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_H264,
+			.max_width = 8192,
+			.min_width = 32,
+			.max_height = 8192,
+			.min_height = 32,
+		},
+	},
+	[VPU_FMT_TYPE_RAW] = {
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420M,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12M,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+		{
+			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21M,
+			.max_width = 8192,
+			.min_width = 8,
+			.max_height = 8192,
+			.min_height = 8,
+		},
+	}
+};
+
+static enum wave_std wave5_to_vpu_wavestd(unsigned int v4l2_pix_fmt)
+{
+	switch (v4l2_pix_fmt) {
+	case V4L2_PIX_FMT_H264:
+		return W_AVC_ENC;
+	case V4L2_PIX_FMT_HEVC:
+		return W_HEVC_ENC;
+	default:
+		return STD_UNKNOWN;
+	}
+}
+
+static const struct vpu_format *wave5_find_vpu_format(unsigned int v4l2_pix_fmt,
+						      enum vpu_fmt_type type)
+{
+	unsigned int index;
+
+	for (index = 0; index < ARRAY_SIZE(wave5_vpu_enc_fmt_list[type]); index++) {
+		if (wave5_vpu_enc_fmt_list[type][index].v4l2_pix_fmt == v4l2_pix_fmt)
+			return &wave5_vpu_enc_fmt_list[type][index];
+	}
+
+	return NULL;
+}
+
+static const struct vpu_format *wave5_find_vpu_fmt_by_idx(unsigned int idx, enum vpu_fmt_type type)
+{
+	if (idx >= ARRAY_SIZE(wave5_vpu_enc_fmt_list[type]))
+		return NULL;
+
+	if (!wave5_vpu_enc_fmt_list[type][idx].v4l2_pix_fmt)
+		return NULL;
+
+	return &wave5_vpu_enc_fmt_list[type][idx];
+}
+
+static struct vb2_v4l2_buffer *wave5_get_valid_src_buf(struct vpu_instance *inst)
+{
+	struct vb2_v4l2_buffer *vb2_v4l2_buf;
+	struct v4l2_m2m_buffer *v4l2_m2m_buf;
+	struct vpu_buffer *vpu_buf = NULL;
+
+	v4l2_m2m_for_each_src_buf(inst->v4l2_fh.m2m_ctx, v4l2_m2m_buf) {
+		vb2_v4l2_buf = &v4l2_m2m_buf->vb;
+		vpu_buf = wave5_to_vpu_buf(vb2_v4l2_buf);
+
+		if (!vpu_buf->consumed) {
+			dev_dbg(inst->dev->dev, "no consumed src idx : %d\n",
+				vb2_v4l2_buf->vb2_buf.index);
+			return vb2_v4l2_buf;
+		}
+	}
+
+	return NULL;
+}
+
+static struct vb2_v4l2_buffer *wave5_get_valid_dst_buf(struct vpu_instance *inst)
+{
+	struct vb2_v4l2_buffer *vb2_v4l2_buf;
+	struct v4l2_m2m_buffer *v4l2_m2m_buf;
+	struct vpu_buffer *vpu_buf;
+
+	v4l2_m2m_for_each_dst_buf(inst->v4l2_fh.m2m_ctx, v4l2_m2m_buf) {
+		vb2_v4l2_buf = &v4l2_m2m_buf->vb;
+		vpu_buf = wave5_to_vpu_buf(vb2_v4l2_buf);
+
+		if (!vpu_buf->consumed) {
+			dev_dbg(inst->dev->dev, "no consumed dst idx : %d\n",
+				vb2_v4l2_buf->vb2_buf.index);
+			return vb2_v4l2_buf;
+		}
+	}
+
+	return NULL;
+}
+
+static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned int width,
+				 unsigned int height)
+{
+	switch (pix_mp->pixelformat) {
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height * 3 / 2;
+		memset(&pix_mp->plane_fmt[0].reserved, 0, sizeof(pix_mp->plane_fmt[0].reserved));
+		break;
+	case V4L2_PIX_FMT_YUV420M:
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
+		memset(&pix_mp->plane_fmt[0].reserved, 0, sizeof(pix_mp->plane_fmt[0].reserved));
+		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
+		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 4;
+		memset(&pix_mp->plane_fmt[1].reserved, 0, sizeof(pix_mp->plane_fmt[1].reserved));
+		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
+		pix_mp->plane_fmt[2].sizeimage = round_up(width, 32) * height / 4;
+		memset(&pix_mp->plane_fmt[2].reserved, 0, sizeof(pix_mp->plane_fmt[2].reserved));
+		break;
+	case V4L2_PIX_FMT_NV12M:
+	case V4L2_PIX_FMT_NV21M:
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
+		memset(&pix_mp->plane_fmt[0].reserved, 0, sizeof(pix_mp->plane_fmt[0].reserved));
+		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
+		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 2;
+		memset(&pix_mp->plane_fmt[1].reserved, 0, sizeof(pix_mp->plane_fmt[1].reserved));
+		break;
+	default:
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = height;
+		pix_mp->plane_fmt[0].bytesperline = 0;
+		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
+		memset(&pix_mp->plane_fmt[0].reserved, 0, sizeof(pix_mp->plane_fmt[0].reserved));
+		break;
+	}
+}
+
+static void wave5_vpu_enc_start_encode(struct vpu_instance *inst)
+{
+	int ret;
+	struct queue_status_info q_status;
+	u32 remain_cmd_q, max_cmd_q = 0;
+
+	wave5_vpu_enc_give_command(inst, ENC_GET_QUEUE_STATUS, &q_status);
+	dev_dbg(inst->dev->dev, "min_src_buf_cnt %d | default : %d | qcount : %d | report_q : %d\n",
+		inst->min_src_frame_buf_count, COMMAND_QUEUE_DEPTH, q_status.instance_queue_count,
+		q_status.report_queue_count);
+
+	max_cmd_q = (inst->min_src_frame_buf_count < COMMAND_QUEUE_DEPTH) ?
+		inst->min_src_frame_buf_count : COMMAND_QUEUE_DEPTH;
+	remain_cmd_q = max_cmd_q - q_status.instance_queue_count;
+
+	while (remain_cmd_q) {
+		struct vb2_v4l2_buffer *src_buf;
+		struct vb2_v4l2_buffer *dst_buf;
+		struct vpu_buffer *src_vbuf;
+		struct vpu_buffer *dst_vbuf;
+		struct frame_buffer frame_buf;
+		struct enc_param pic_param;
+		u32 luma_size = (inst->dst_fmt.width * inst->dst_fmt.height);
+		u32 chroma_size = ((inst->dst_fmt.width / 2) * (inst->dst_fmt.height / 2));
+		u32 fail_res;
+
+		memset(&pic_param, 0, sizeof(struct enc_param));
+
+		src_buf = wave5_get_valid_src_buf(inst);
+		dst_buf = wave5_get_valid_dst_buf(inst);
+
+		if (!src_buf || !dst_buf) {
+			dev_dbg(inst->dev->dev, "no valid src/dst buf\n");
+			break;
+		}
+
+		src_vbuf = wave5_to_vpu_buf(src_buf);
+		dst_vbuf = wave5_to_vpu_buf(dst_buf);
+
+		if (inst->src_fmt.num_planes == 1) {
+			frame_buf.buf_y = vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
+			frame_buf.buf_cb = frame_buf.buf_y + luma_size;
+			frame_buf.buf_cr = frame_buf.buf_cb + chroma_size;
+		} else if (inst->src_fmt.num_planes == 2) {
+			frame_buf.buf_y = vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
+			frame_buf.buf_cb = vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 1);
+			frame_buf.buf_cr = frame_buf.buf_cb + chroma_size;
+		} else if (inst->src_fmt.num_planes == 3) {
+			frame_buf.buf_y = vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
+			frame_buf.buf_cb = vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 1);
+			frame_buf.buf_cr = vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 2);
+		}
+		frame_buf.stride = inst->dst_fmt.width;
+		frame_buf.cbcr_interleave = 0;
+
+		dev_dbg(inst->dev->dev, "encoding src sequence : %d | dst sequence : %d\n",
+			src_buf->sequence, dst_buf->sequence);
+
+		pic_param.src_idx = src_buf->vb2_buf.index;
+		pic_param.source_frame = &frame_buf;
+		pic_param.pic_stream_buffer_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf,
+										 0);
+		pic_param.pic_stream_buffer_size = vb2_plane_size(&dst_buf->vb2_buf, 0);
+		pic_param.code_option.implicit_header_encode = 1;
+
+		ret = wave5_vpu_enc_start_one_frame(inst, &pic_param, &fail_res);
+		if (ret) {
+			if (fail_res != WAVE5_SYSERR_QUEUEING_FAIL) {
+				src_buf = v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx);
+				dst_buf = v4l2_m2m_dst_buf_remove(inst->v4l2_fh.m2m_ctx);
+				dev_dbg(inst->dev->dev, "fail wave5_vpu_enc_start_one_frame() %d\n",
+					ret);
+				inst->state = VPU_INST_STATE_STOP;
+				v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
+				v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
+			}
+		} else {
+			dev_dbg(inst->dev->dev, "success  wave5_vpu_enc_start_one_frame()\n");
+			src_vbuf->consumed = TRUE;
+			dst_vbuf->consumed = TRUE;
+		}
+
+		remain_cmd_q--;
+	}
+}
+
+static void wave5_vpu_enc_stop_encode(struct vpu_instance *inst)
+{
+	struct queue_status_info q_status;
+
+	inst->state = VPU_INST_STATE_STOP;
+
+	wave5_vpu_enc_give_command(inst, ENC_GET_QUEUE_STATUS, &q_status);
+
+	if (q_status.report_queue_count + q_status.instance_queue_count == 0)
+		v4l2_m2m_job_finish(inst->dev->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
+}
+
+static void wave5_vpu_enc_finish_encode(struct vpu_instance *inst)
+{
+	int ret;
+	struct enc_output_info enc_output_info;
+	int irq_status;
+
+	if (kfifo_out(&inst->dev->irq_status, &irq_status, sizeof(int)))
+		wave5_vpu_clear_interrupt_ex(inst, irq_status);
+
+	ret = wave5_vpu_enc_get_output_info(inst, &enc_output_info);
+	if (ret) {
+		dev_dbg(inst->dev->dev, "vpu_enc_get_output_info fail %d  reason: %d | info : %d\n",
+			ret, enc_output_info.error_reason, enc_output_info.warn_info);
+	} else {
+		struct vb2_v4l2_buffer *dst_buf = NULL;
+		struct v4l2_m2m_buffer *v4l2_m2m_buf = NULL;
+
+		v4l2_m2m_buf = NULL;
+		v4l2_m2m_for_each_dst_buf(inst->v4l2_fh.m2m_ctx, v4l2_m2m_buf) {
+			dst_buf = &v4l2_m2m_buf->vb;
+			if (enc_output_info.bitstream_buffer ==
+					vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0))
+				break;
+		}
+
+		if (enc_output_info.enc_src_idx >= 0) {
+			struct vb2_v4l2_buffer *src_buf =
+				v4l2_m2m_src_buf_remove_by_idx(inst->v4l2_fh.m2m_ctx,
+							       enc_output_info.enc_src_idx);
+
+			inst->timestamp = src_buf->vb2_buf.timestamp;
+			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
+		}
+
+		if (enc_output_info.recon_frame_index == RECON_IDX_FLAG_ENC_END) {
+			static const struct v4l2_event vpu_event_eos = {
+				.type = V4L2_EVENT_EOS
+			};
+
+			dst_buf->flags |= V4L2_BUF_FLAG_LAST;
+			vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
+
+			inst->state = VPU_INST_STATE_STOP;
+			v4l2_event_queue_fh(&inst->v4l2_fh, &vpu_event_eos);
+		} else {
+			vb2_set_plane_payload(&dst_buf->vb2_buf, 0, enc_output_info.bitstream_size);
+
+			dst_buf->vb2_buf.timestamp = inst->timestamp;
+			dst_buf->field = V4L2_FIELD_NONE;
+			if (enc_output_info.pic_type == PIC_TYPE_I) {
+				if (enc_output_info.enc_vcl_nut == 19 ||
+				    enc_output_info.enc_vcl_nut == 20)
+					dst_buf->flags |= V4L2_BUF_FLAG_KEYFRAME;
+				else
+					dst_buf->flags |= V4L2_BUF_FLAG_PFRAME;
+			} else if (enc_output_info.pic_type == PIC_TYPE_P) {
+				dst_buf->flags |= V4L2_BUF_FLAG_PFRAME;
+			} else if (enc_output_info.pic_type == PIC_TYPE_B) {
+				dst_buf->flags |= V4L2_BUF_FLAG_BFRAME;
+			}
+		}
+
+		v4l2_m2m_dst_buf_remove_by_buf(inst->v4l2_fh.m2m_ctx, dst_buf);
+		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
+	}
+
+	if (inst->state == VPU_INST_STATE_STOP) {
+		struct queue_status_info q_status;
+
+		wave5_vpu_enc_give_command(inst, ENC_GET_QUEUE_STATUS, &q_status);
+		dev_dbg(inst->dev->dev, "default : %d | qcount : %d | report_q : %d\n",
+			COMMAND_QUEUE_DEPTH, q_status.instance_queue_count,
+				q_status.report_queue_count);
+
+		if (q_status.report_queue_count + q_status.instance_queue_count == 0)
+			v4l2_m2m_job_finish(inst->dev->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
+	} else {
+		v4l2_m2m_job_finish(inst->dev->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
+	}
+}
+
+static int wave5_vpu_enc_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, VPU_ENC_DRV_NAME, sizeof(cap->driver));
+	strscpy(cap->card, VPU_ENC_DRV_NAME, sizeof(cap->card));
+	strscpy(cap->bus_info, "platform:" VPU_ENC_DRV_NAME, sizeof(cap->bus_info));
+
+	return 0;
+}
+
+static int wave5_vpu_enc_enum_framesizes(struct file *f, void *fh, struct v4l2_frmsizeenum *fsize)
+{
+	const struct vpu_format *vpu_fmt;
+
+	if (fsize->index)
+		return -EINVAL;
+
+	vpu_fmt = wave5_find_vpu_format(fsize->pixel_format, VPU_FMT_TYPE_CODEC);
+	if (!vpu_fmt) {
+		vpu_fmt = wave5_find_vpu_format(fsize->pixel_format, VPU_FMT_TYPE_RAW);
+		if (!vpu_fmt)
+			return -EINVAL;
+	}
+
+	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
+	fsize->stepwise.min_width = vpu_fmt->min_width;
+	fsize->stepwise.max_width = vpu_fmt->max_width;
+	fsize->stepwise.step_width = 1;
+	fsize->stepwise.min_height = vpu_fmt->min_height;
+	fsize->stepwise.max_height = vpu_fmt->max_height;
+	fsize->stepwise.step_height = 1;
+
+	return 0;
+}
+
+static int wave5_vpu_enc_enum_fmt_cap(struct file *file, void *fh, struct v4l2_fmtdesc *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	const struct vpu_format *vpu_fmt;
+
+	dev_dbg(inst->dev->dev, "index : %d\n", f->index);
+
+	vpu_fmt = wave5_find_vpu_fmt_by_idx(f->index, VPU_FMT_TYPE_CODEC);
+	if (!vpu_fmt)
+		return -EINVAL;
+
+	f->pixelformat = vpu_fmt->v4l2_pix_fmt;
+	f->flags = 0;
+
+	return 0;
+}
+
+static int wave5_vpu_enc_try_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	const struct vpu_format *vpu_fmt;
+
+	dev_dbg(inst->dev->dev, "fourcc: %d width %d height %d num_planes %d field : %d\n",
+		f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
+
+	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		return -EINVAL;
+
+	vpu_fmt = wave5_find_vpu_format(f->fmt.pix_mp.pixelformat, VPU_FMT_TYPE_CODEC);
+	if (!vpu_fmt) {
+		f->fmt.pix_mp.pixelformat = inst->dst_fmt.pixelformat;
+		f->fmt.pix_mp.num_planes = inst->dst_fmt.num_planes;
+		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->dst_fmt.width, inst->dst_fmt.height);
+	} else {
+		int width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
+		int height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
+
+		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
+		f->fmt.pix_mp.num_planes = 1;
+		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
+	}
+
+	f->fmt.pix_mp.flags = 0;
+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	f->fmt.pix_mp.colorspace = inst->colorspace;
+	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
+	f->fmt.pix_mp.hsv_enc = inst->hsv_enc;
+	f->fmt.pix_mp.quantization = inst->quantization;
+	f->fmt.pix_mp.xfer_func = inst->xfer_func;
+	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
+
+	return 0;
+}
+
+static int wave5_vpu_enc_s_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	int i, ret;
+
+	dev_dbg(inst->dev->dev, "4cc %d width %d height %d num_planes %d field %d\n",
+		f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
+
+	ret = wave5_vpu_enc_try_fmt_cap(file, fh, f);
+	if (ret)
+		return ret;
+
+	inst->dst_fmt.width = f->fmt.pix_mp.width;
+	inst->dst_fmt.height = f->fmt.pix_mp.height;
+	inst->dst_fmt.pixelformat = f->fmt.pix_mp.pixelformat;
+	inst->dst_fmt.field = f->fmt.pix_mp.field;
+	inst->dst_fmt.flags = f->fmt.pix_mp.flags;
+	inst->dst_fmt.num_planes = f->fmt.pix_mp.num_planes;
+	for (i = 0; i < inst->dst_fmt.num_planes; i++) {
+		inst->dst_fmt.plane_fmt[i].bytesperline = f->fmt.pix_mp.plane_fmt[i].bytesperline;
+		inst->dst_fmt.plane_fmt[i].sizeimage = f->fmt.pix_mp.plane_fmt[i].sizeimage;
+	}
+
+	return 0;
+}
+
+static int wave5_vpu_enc_g_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	int i;
+
+	f->fmt.pix_mp.width = inst->dst_fmt.width;
+	f->fmt.pix_mp.height = inst->dst_fmt.height;
+	f->fmt.pix_mp.pixelformat = inst->dst_fmt.pixelformat;
+	f->fmt.pix_mp.field = inst->dst_fmt.field;
+	f->fmt.pix_mp.flags = inst->dst_fmt.flags;
+	f->fmt.pix_mp.num_planes = inst->dst_fmt.num_planes;
+	for (i = 0; i < f->fmt.pix_mp.num_planes; i++) {
+		f->fmt.pix_mp.plane_fmt[i].bytesperline = inst->dst_fmt.plane_fmt[i].bytesperline;
+		f->fmt.pix_mp.plane_fmt[i].sizeimage = inst->dst_fmt.plane_fmt[i].sizeimage;
+	}
+
+	f->fmt.pix_mp.colorspace = inst->colorspace;
+	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
+	f->fmt.pix_mp.hsv_enc = inst->hsv_enc;
+	f->fmt.pix_mp.quantization = inst->quantization;
+	f->fmt.pix_mp.xfer_func = inst->xfer_func;
+
+	return 0;
+}
+
+static int wave5_vpu_enc_enum_fmt_out(struct file *file, void *fh, struct v4l2_fmtdesc *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	const struct vpu_format *vpu_fmt;
+
+	dev_dbg(inst->dev->dev, "index : %d\n", f->index);
+
+	vpu_fmt = wave5_find_vpu_fmt_by_idx(f->index, VPU_FMT_TYPE_RAW);
+	if (!vpu_fmt)
+		return -EINVAL;
+
+	f->pixelformat = vpu_fmt->v4l2_pix_fmt;
+	f->flags = 0;
+
+	return 0;
+}
+
+static int wave5_vpu_enc_try_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	const struct vpu_format *vpu_fmt;
+
+	dev_dbg(inst->dev->dev, "4cc %d width %d height %d num_planes %d field %d\n",
+		f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
+
+	if (f->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+
+	vpu_fmt = wave5_find_vpu_format(f->fmt.pix_mp.pixelformat, VPU_FMT_TYPE_RAW);
+	if (!vpu_fmt) {
+		f->fmt.pix_mp.pixelformat = inst->src_fmt.pixelformat;
+		f->fmt.pix_mp.num_planes = inst->src_fmt.num_planes;
+		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->src_fmt.width, inst->src_fmt.height);
+	} else {
+		int width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
+		int height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
+		const struct v4l2_format_info *info = v4l2_format_info(vpu_fmt->v4l2_pix_fmt);
+
+		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
+		f->fmt.pix_mp.num_planes = info->mem_planes;
+		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
+	}
+
+	f->fmt.pix_mp.flags = 0;
+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
+
+	return 0;
+}
+
+static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	int i, ret;
+
+	dev_dbg(inst->dev->dev, "4cc %d width %d height %d num_planes %d field : %d\n",
+		f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
+		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
+
+	ret = wave5_vpu_enc_try_fmt_out(file, fh, f);
+	if (ret)
+		return ret;
+
+	inst->src_fmt.width = f->fmt.pix_mp.width;
+	inst->src_fmt.height = f->fmt.pix_mp.height;
+	inst->src_fmt.pixelformat = f->fmt.pix_mp.pixelformat;
+	inst->src_fmt.field = f->fmt.pix_mp.field;
+	inst->src_fmt.flags = f->fmt.pix_mp.flags;
+	inst->src_fmt.num_planes = f->fmt.pix_mp.num_planes;
+	for (i = 0; i < inst->src_fmt.num_planes; i++) {
+		inst->src_fmt.plane_fmt[i].bytesperline = f->fmt.pix_mp.plane_fmt[i].bytesperline;
+		inst->src_fmt.plane_fmt[i].sizeimage = f->fmt.pix_mp.plane_fmt[i].sizeimage;
+	}
+
+	inst->colorspace = f->fmt.pix_mp.colorspace;
+	inst->ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
+	inst->hsv_enc = f->fmt.pix_mp.hsv_enc;
+	inst->quantization = f->fmt.pix_mp.quantization;
+	inst->xfer_func = f->fmt.pix_mp.xfer_func;
+
+	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_mp.height);
+
+	return 0;
+}
+
+static int wave5_vpu_enc_g_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	int i;
+
+	dev_dbg(inst->dev->dev, "\n");
+
+	f->fmt.pix_mp.width = inst->src_fmt.width;
+	f->fmt.pix_mp.height = inst->src_fmt.height;
+	f->fmt.pix_mp.pixelformat = inst->src_fmt.pixelformat;
+	f->fmt.pix_mp.field = inst->src_fmt.field;
+	f->fmt.pix_mp.flags = inst->src_fmt.flags;
+	f->fmt.pix_mp.num_planes = inst->src_fmt.num_planes;
+	for (i = 0; i < f->fmt.pix_mp.num_planes; i++) {
+		f->fmt.pix_mp.plane_fmt[i].bytesperline = inst->src_fmt.plane_fmt[i].bytesperline;
+		f->fmt.pix_mp.plane_fmt[i].sizeimage = inst->src_fmt.plane_fmt[i].sizeimage;
+	}
+
+	f->fmt.pix_mp.colorspace = inst->colorspace;
+	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
+	f->fmt.pix_mp.hsv_enc = inst->hsv_enc;
+	f->fmt.pix_mp.quantization = inst->quantization;
+	f->fmt.pix_mp.xfer_func = inst->xfer_func;
+
+	return 0;
+}
+
+static int wave5_vpu_enc_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+
+	dev_dbg(inst->dev->dev, "type : %d | target : %d\n", s->type, s->target);
+
+	if (s->type == V4L2_BUF_TYPE_VIDEO_OUTPUT) {
+		switch (s->target) {
+		case V4L2_SEL_TGT_CROP_DEFAULT:
+		case V4L2_SEL_TGT_CROP_BOUNDS:
+			s->r.left = 0;
+			s->r.top = 0;
+			s->r.width = inst->src_fmt.width;
+			s->r.height = inst->src_fmt.height;
+			break;
+		case V4L2_SEL_TGT_CROP:
+			s->r.left = 0;
+			s->r.top = 0;
+			s->r.width = inst->dst_fmt.width;
+			s->r.height = inst->dst_fmt.height;
+			dev_dbg(inst->dev->dev, "V4L2_SEL_TGT_CROP width : %d | height : %d\n",
+				s->r.width, s->r.height);
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int wave5_vpu_enc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+
+	dev_dbg(inst->dev->dev, "type : %d | target : %d\n", s->type, s->target);
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
+		return -EINVAL;
+
+	if (s->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	dev_dbg(inst->dev->dev, "V4L2_SEL_TGT_CROP width : %d | height : %d\n",
+		s->r.width, s->r.height);
+	inst->dst_fmt.width = s->r.width;
+	inst->dst_fmt.height = s->r.height;
+
+	return 0;
+}
+
+static int wave5_vpu_enc_try_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *ec)
+{
+	if (ec->cmd != V4L2_ENC_CMD_STOP && ec->cmd != V4L2_ENC_CMD_START)
+		return -EINVAL;
+
+	ec->flags = 0;
+	return 0;
+}
+
+static int wave5_vpu_enc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *ec)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	int ret;
+
+	ret = wave5_vpu_enc_try_encoder_cmd(file, fh, ec);
+	if (ret < 0)
+		return ret;
+
+	if (!wave5_vpu_both_queues_are_streaming(inst))
+		return 0;
+
+	switch (ec->cmd) {
+	case V4L2_ENC_CMD_STOP:
+		wave5_vpu_enc_stop_encode(inst);
+		break;
+	case V4L2_ENC_CMD_START:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int wave5_vpu_enc_subscribe_event(struct v4l2_fh *fh,
+					 const struct v4l2_event_subscription *sub)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+
+	dev_dbg(inst->dev->dev, "type %d | id : %d | flags : %d\n", sub->type, sub->id, sub->flags);
+
+	switch (sub->type) {
+	case V4L2_EVENT_EOS:
+		return v4l2_event_subscribe(fh, sub, 0, NULL);
+	case V4L2_EVENT_CTRL:
+		return v4l2_ctrl_subscribe_event(fh, sub);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int wave5_vpu_enc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+
+	dev_dbg(inst->dev->dev, "type : %d\n", a->type);
+
+	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+
+	a->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	a->parm.output.timeperframe.numerator = 1;
+	a->parm.output.timeperframe.denominator = inst->frame_rate;
+
+	dev_dbg(inst->dev->dev, "numerator : %d | denominator : %d\n",
+		a->parm.output.timeperframe.numerator,
+			a->parm.output.timeperframe.denominator);
+
+	return 0;
+}
+
+static int wave5_vpu_enc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+
+	dev_dbg(inst->dev->dev, "type : %d\n", a->type);
+
+	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+
+	a->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	if (a->parm.output.timeperframe.denominator && a->parm.output.timeperframe.numerator) {
+		inst->frame_rate = a->parm.output.timeperframe.denominator /
+				   a->parm.output.timeperframe.numerator;
+	} else {
+		a->parm.output.timeperframe.numerator = 1;
+		a->parm.output.timeperframe.denominator = inst->frame_rate;
+	}
+
+	dev_dbg(inst->dev->dev, "numerator : %d | denominator : %d\n",
+		a->parm.output.timeperframe.numerator,
+		a->parm.output.timeperframe.denominator);
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops wave5_vpu_enc_ioctl_ops = {
+	.vidioc_querycap = wave5_vpu_enc_querycap,
+	.vidioc_enum_framesizes = wave5_vpu_enc_enum_framesizes,
+
+	.vidioc_enum_fmt_vid_cap	= wave5_vpu_enc_enum_fmt_cap,
+	.vidioc_s_fmt_vid_cap_mplane = wave5_vpu_enc_s_fmt_cap,
+	.vidioc_g_fmt_vid_cap_mplane = wave5_vpu_enc_g_fmt_cap,
+	.vidioc_try_fmt_vid_cap_mplane = wave5_vpu_enc_try_fmt_cap,
+
+	.vidioc_enum_fmt_vid_out	= wave5_vpu_enc_enum_fmt_out,
+	.vidioc_s_fmt_vid_out_mplane = wave5_vpu_enc_s_fmt_out,
+	.vidioc_g_fmt_vid_out_mplane = wave5_vpu_enc_g_fmt_out,
+	.vidioc_try_fmt_vid_out_mplane = wave5_vpu_enc_try_fmt_out,
+
+	.vidioc_g_selection = wave5_vpu_enc_g_selection,
+	.vidioc_s_selection = wave5_vpu_enc_s_selection,
+
+	.vidioc_g_parm = wave5_vpu_enc_g_parm,
+	.vidioc_s_parm = wave5_vpu_enc_s_parm,
+
+	.vidioc_reqbufs = v4l2_m2m_ioctl_reqbufs,
+	.vidioc_querybuf = v4l2_m2m_ioctl_querybuf,
+	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
+	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
+	.vidioc_qbuf = v4l2_m2m_ioctl_qbuf,
+	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
+	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
+	.vidioc_streamon = v4l2_m2m_ioctl_streamon,
+	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
+
+	.vidioc_try_encoder_cmd = wave5_vpu_enc_try_encoder_cmd,
+	.vidioc_encoder_cmd = wave5_vpu_enc_encoder_cmd,
+
+	.vidioc_subscribe_event = wave5_vpu_enc_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+static int wave5_vpu_enc_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vpu_instance *inst = wave5_ctrl_to_vpu_inst(ctrl);
+
+	dev_dbg(inst->dev->dev, "name : %s\n", ctrl->name);
+
+	switch (ctrl->id) {
+	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
+		if (inst->state != VPU_INST_STATE_NONE && inst->state != VPU_INST_STATE_OPEN)
+			ctrl->val = inst->min_src_frame_buf_count;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(inst->dev->dev, "value : %d\n", ctrl->val);
+
+	return 0;
+}
+
+static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vpu_instance *inst = wave5_ctrl_to_vpu_inst(ctrl);
+
+	dev_dbg(inst->dev->dev, "name : %s | value : %d\n", ctrl->name, ctrl->val);
+
+	switch (ctrl->id) {
+	case V4L2_CID_HFLIP:
+		inst->mirror_direction |= (ctrl->val << 1);
+		break;
+	case V4L2_CID_VFLIP:
+		inst->mirror_direction |= ctrl->val;
+		break;
+	case V4L2_CID_ROTATE:
+		inst->rot_angle = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VBV_SIZE:
+		inst->vbv_buf_size = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_HEVC_PROFILE:
+		switch (ctrl->val) {
+		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN:
+			inst->profile = HEVC_PROFILE_MAIN;
+			inst->bit_depth = 8;
+			break;
+		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE:
+			inst->profile = HEVC_PROFILE_STILLPICTURE;
+			inst->bit_depth = 8;
+			break;
+		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10:
+			inst->profile = HEVC_PROFILE_MAIN10;
+			inst->bit_depth = 10;
+			break;
+		default:
+			inst->profile = 0;
+			inst->bit_depth = 0;
+			break;
+		}
+		break;
+	case V4L2_CID_MPEG_VIDEO_HEVC_LEVEL:
+		switch (ctrl->val) {
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_1:
+			inst->level = 10 * 3;
+			break;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_2:
+			inst->level = 20 * 3;
+			break;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1:
+			inst->level = 21 * 3;
+			break;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_3:
+			inst->level = 30 * 3;
+			break;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1:
+			inst->level = 31 * 3;
+			break;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_4:
+			inst->level = 40 * 3;
+			break;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1:
+			inst->level = 41 * 3;
+			break;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5:
+			inst->level = 50 * 3;
+			break;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1:
+			inst->level = 51 * 3;
+			break;
+		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2:
+			inst->level = 52 * 3;
+			break;
+		default:
+			inst->level = 0;
+			break;
+		}
+		break;
+	case V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP:
+		inst->min_qp_i = ctrl->val;
+		inst->min_qp_p = ctrl->val;
+		inst->min_qp_b = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP:
+		inst->max_qp_i = ctrl->val;
+		inst->max_qp_p = ctrl->val;
+		inst->max_qp_b = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
+		switch (ctrl->val) {
+		case V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE:
+		case V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE:
+			inst->profile = H264_PROFILE_BP;
+			inst->bit_depth = 8;
+			break;
+		case V4L2_MPEG_VIDEO_H264_PROFILE_MAIN:
+			inst->profile = H264_PROFILE_MP;
+			inst->bit_depth = 8;
+			break;
+		case V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED:
+			inst->profile = H264_PROFILE_EXTENDED;
+			inst->bit_depth = 8;
+			break;
+		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH:
+			inst->profile = H264_PROFILE_HP;
+			inst->bit_depth = 8;
+			break;
+		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10:
+			inst->profile = H264_PROFILE_HIGH10;
+			inst->bit_depth = 10;
+			break;
+		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422:
+			inst->profile = H264_PROFILE_HIGH422;
+			inst->bit_depth = 10;
+			break;
+		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE:
+			inst->profile = H264_PROFILE_HIGH444;
+			inst->bit_depth = 10;
+			break;
+		default:
+			inst->profile = 0;
+			inst->bit_depth = 0;
+			break;
+		}
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
+		switch (ctrl->val) {
+		case V4L2_MPEG_VIDEO_H264_LEVEL_1_0:
+			inst->level = 10;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_1B:
+			inst->level = 9;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_1_1:
+			inst->level = 11;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_1_2:
+			inst->level = 12;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_1_3:
+			inst->level = 13;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_2_0:
+			inst->level = 20;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_2_1:
+			inst->level = 21;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_2_2:
+			inst->level = 22;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_3_0:
+			inst->level = 30;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_3_1:
+			inst->level = 31;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_3_2:
+			inst->level = 32;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_4_0:
+			inst->level = 40;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_4_1:
+			inst->level = 41;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_4_2:
+			inst->level = 42;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_5_0:
+			inst->level = 50;
+			break;
+		case V4L2_MPEG_VIDEO_H264_LEVEL_5_1:
+			inst->level = 51;
+			break;
+		default:
+			inst->level = 0;
+			break;
+		}
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_MIN_QP:
+		inst->min_qp_i = ctrl->val;
+		inst->min_qp_p = ctrl->val;
+		inst->min_qp_b = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_MAX_QP:
+		inst->max_qp_i = ctrl->val;
+		inst->max_qp_p = ctrl->val;
+		inst->max_qp_b = ctrl->val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops wave5_vpu_enc_ctrl_ops = {
+	.g_volatile_ctrl = wave5_vpu_enc_g_volatile_ctrl,
+	.s_ctrl = wave5_vpu_enc_s_ctrl,
+};
+
+static void wave5_set_default_enc_openparam(struct enc_open_param *open_param)
+{
+	unsigned int i;
+
+	open_param->stream_endian = VPU_STREAM_ENDIAN;
+	open_param->source_endian = VPU_SOURCE_ENDIAN;
+	open_param->line_buf_int_en = TRUE;
+
+	open_param->wave_param.gop_preset_idx = PRESET_IDX_IPP_SINGLE;
+	open_param->wave_param.decoding_refresh_type = 1;
+	open_param->wave_param.intra_qp = 30;
+	open_param->wave_param.tmvp_enable = 1;
+	open_param->wave_param.max_num_merge = 2;
+	open_param->wave_param.lf_cross_slice_boundary_enable = 1;
+	open_param->wave_param.skip_intra_trans = 1;
+	open_param->wave_param.sao_enable = 1;
+	open_param->wave_param.transform8x8_enable = 1;
+	open_param->wave_param.intra_nx_n_enable = 1;
+	for (i = 0; i < MAX_GOP_NUM; i++)
+		open_param->wave_param.fixed_bit_ratio[i] = 1;
+	open_param->wave_param.cu_level_rc_enable = 1;
+	open_param->wave_param.hvs_qp_enable = 1;
+	open_param->wave_param.hvs_qp_scale = 2;
+	open_param->wave_param.hvs_max_delta_qp = 10;
+	open_param->wave_param.gop_param.custom_gop_size = 1;
+	open_param->wave_param.initial_rc_qp = -1;
+	open_param->wave_param.nr_intra_weight_y = 7;
+	open_param->wave_param.nr_intra_weight_cb = 7;
+	open_param->wave_param.nr_intra_weight_cr = 7;
+	open_param->wave_param.nr_inter_weight_y = 4;
+	open_param->wave_param.nr_inter_weight_cb = 4;
+	open_param->wave_param.nr_inter_weight_cr = 4;
+	open_param->wave_param.strong_intra_smooth_enable = 1;
+	open_param->wave_param.bg_thr_diff = 8;
+	open_param->wave_param.bg_thr_mean_diff = 1;
+	open_param->wave_param.bg_lambda_qp = 32;
+	open_param->wave_param.bg_delta_qp = 3;
+	open_param->wave_param.rdo_skip = 1;
+	open_param->wave_param.intra_mb_refresh_arg = 1;
+	open_param->wave_param.entropy_coding_mode = 1;
+	open_param->wave_param.rc_weight_param = 16;
+	open_param->wave_param.rc_weight_buf = 128;
+	open_param->wave_param.lambda_scaling_enable = 1;
+}
+
+static int wave5_vpu_enc_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
+				     unsigned int *num_planes, unsigned int sizes[],
+			       struct device *alloc_devs[])
+{
+	struct vpu_instance *inst = vb2_get_drv_priv(q);
+	struct v4l2_pix_format_mplane inst_format =
+		(q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : inst->dst_fmt;
+	unsigned int i;
+	int ret;
+
+	dev_dbg(inst->dev->dev, "num_buffers : %d | num_planes : %d | type : %d\n", *num_buffers,
+		*num_planes, q->type);
+
+	if (*num_planes) {
+		if (inst_format.num_planes != *num_planes)
+			return -EINVAL;
+
+		for (i = 0; i < *num_planes; i++) {
+			if (sizes[i] < inst_format.plane_fmt[i].sizeimage)
+				return -EINVAL;
+		}
+	} else {
+		*num_planes = inst_format.num_planes;
+		for (i = 0; i < *num_planes; i++) {
+			sizes[i] = inst_format.plane_fmt[i].sizeimage;
+			dev_dbg(inst->dev->dev, "size[%d] : %d\n", i, sizes[i]);
+		}
+	}
+
+	dev_dbg(inst->dev->dev, "size : %d\n", sizes[0]);
+
+	if (inst->state == VPU_INST_STATE_NONE && q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		u32 non_linear_num = 0;
+		unsigned int fb_stride = 0;
+		u32 fb_height = 0;
+		struct enc_open_param open_param;
+		struct enc_initial_info initial_info;
+
+		memset(&open_param, 0, sizeof(struct enc_open_param));
+		wave5_set_default_enc_openparam(&open_param);
+
+		inst->std = wave5_to_vpu_wavestd(inst->dst_fmt.pixelformat);
+		if (inst->std == STD_UNKNOWN) {
+			dev_warn(inst->dev->dev, "unsupported pixelformat: %.4s\n",
+				 (char *)&inst->dst_fmt.pixelformat);
+			return -EINVAL;
+		}
+		open_param.pic_width = inst->dst_fmt.width;
+		open_param.pic_height = inst->dst_fmt.height;
+		open_param.frame_rate_info = inst->frame_rate;
+		open_param.vbv_buffer_size = inst->vbv_buf_size;
+		open_param.wave_param.profile = inst->profile;
+		open_param.wave_param.level = inst->level;
+		open_param.wave_param.internal_bit_depth = inst->bit_depth;
+		open_param.wave_param.min_qp_i = inst->min_qp_i;
+		open_param.wave_param.max_qp_i = inst->max_qp_i;
+		open_param.wave_param.min_qp_p = inst->min_qp_p;
+		open_param.wave_param.max_qp_p = inst->max_qp_p;
+		open_param.wave_param.min_qp_b = inst->min_qp_b;
+		open_param.wave_param.max_qp_b = inst->max_qp_b;
+
+		ret = wave5_vpu_enc_open(inst, &open_param);
+		if (ret) {
+			dev_dbg(inst->dev->dev, "failed wave5_vpu_enc_open : %d\n", ret);
+			return ret;
+		}
+
+		inst->state = VPU_INST_STATE_OPEN;
+
+		if (inst->mirror_direction) {
+			wave5_vpu_enc_give_command(inst, ENABLE_MIRRORING, NULL);
+			wave5_vpu_enc_give_command(inst, SET_MIRROR_DIRECTION,
+						   &inst->mirror_direction);
+		}
+		if (inst->rot_angle) {
+			wave5_vpu_enc_give_command(inst, ENABLE_ROTATION, NULL);
+			wave5_vpu_enc_give_command(inst, SET_ROTATION_ANGLE, &inst->rot_angle);
+		}
+
+		ret = wave5_vpu_enc_issue_seq_init(inst);
+		if (ret) {
+			dev_dbg(inst->dev->dev, "failed wave5_vpu_enc_issue_seq_init() : %d\n",
+				ret);
+			return ret;
+		}
+
+		if (wave5_vpu_wait_interrupt(inst, VPU_ENC_TIMEOUT) < 0) {
+			dev_dbg(inst->dev->dev, "failed to call wave5_vpu_wait_interrupt()\n");
+			return -EINVAL;
+		}
+
+		ret = wave5_vpu_enc_complete_seq_init(inst, &initial_info);
+		if (ret)
+			return ret;
+
+		dev_dbg(inst->dev->dev, "min_frame_buffer : %d | min_source_buffer : %d\n",
+			initial_info.min_frame_buffer_count, initial_info.min_src_frame_count);
+		inst->state = VPU_INST_STATE_INIT_SEQ;
+		inst->min_src_frame_buf_count = initial_info.min_src_frame_count +
+						COMMAND_QUEUE_DEPTH;
+		inst->min_dst_frame_buf_count = initial_info.min_frame_buffer_count;
+		*num_buffers = inst->min_src_frame_buf_count;
+		dev_dbg(inst->dev->dev, "source buffer num : %d", *num_buffers);
+
+		non_linear_num = inst->min_dst_frame_buf_count;
+
+		fb_stride = inst->dst_fmt.width;
+		fb_height = inst->dst_fmt.height;
+
+		for (i = 0; i < non_linear_num; i++) {
+			u32 luma_size = fb_stride * fb_height;
+			u32 chroma_size = ALIGN(fb_stride / 2, 16) * fb_height;
+
+			inst->frame_vbuf[i].size = luma_size + chroma_size;
+			if (wave5_vdi_allocate_dma_memory(inst->dev, &inst->frame_vbuf[i]) < 0)
+				dev_dbg(inst->dev->dev, "failed to allocate FBC buffer : %zu\n",
+					inst->frame_vbuf[i].size);
+
+			inst->frame_buf[i].buf_y = inst->frame_vbuf[i].daddr;
+			inst->frame_buf[i].buf_cb = (dma_addr_t)-1;
+			inst->frame_buf[i].buf_cr = (dma_addr_t)-1;
+			inst->frame_buf[i].update_fb_info = true;
+			inst->frame_buf[i].size = inst->frame_vbuf[i].size;
+		}
+
+		ret = wave5_vpu_enc_register_frame_buffer(inst, non_linear_num, fb_stride,
+							  fb_height, COMPRESSED_FRAME_MAP);
+		if (ret) {
+			dev_dbg(inst->dev->dev, "failed wave5_vpu_enc_register_frame_buffer %d\n",
+				ret);
+			return -EINVAL;
+		}
+
+		inst->state = VPU_INST_STATE_PIC_RUN;
+	}
+
+	if (inst->state != VPU_INST_STATE_NONE && inst->state != VPU_INST_STATE_OPEN &&
+	    q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		*num_buffers = inst->min_src_frame_buf_count;
+		dev_dbg(inst->dev->dev, "source buffer num : %d", *num_buffers);
+	}
+
+	return 0;
+}
+
+static void wave5_vpu_enc_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct vpu_instance *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vpu_buffer *vpu_buf = wave5_to_vpu_buf(vbuf);
+
+	dev_dbg(inst->dev->dev, "type %4d index %4d size[0] %4ld size[1] : %4ld | size[2] : %4ld\n",
+		vb->type, vb->index, vb2_plane_size(&vbuf->vb2_buf, 0),
+		vb2_plane_size(&vbuf->vb2_buf, 1), vb2_plane_size(&vbuf->vb2_buf, 2));
+
+	if (vb->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		vbuf->sequence = inst->queued_src_buf_num++;
+	else
+		vbuf->sequence = inst->queued_dst_buf_num++;
+
+	vpu_buf->consumed = FALSE;
+	v4l2_m2m_buf_queue(inst->v4l2_fh.m2m_ctx, vbuf);
+}
+
+static void wave5_vpu_enc_stop_streaming(struct vb2_queue *q)
+{
+	struct vpu_instance *inst = vb2_get_drv_priv(q);
+	struct vb2_v4l2_buffer *buf;
+
+	dev_dbg(inst->dev->dev, "type : %d\n", q->type);
+
+	if (wave5_vpu_both_queues_are_streaming(inst))
+		inst->state = VPU_INST_STATE_STOP;
+
+	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		while ((buf = v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx))) {
+			dev_dbg(inst->dev->dev, "buf type : %4d | index : %4d\n",
+				buf->vb2_buf.type, buf->vb2_buf.index);
+			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
+		}
+	} else {
+		while ((buf = v4l2_m2m_dst_buf_remove(inst->v4l2_fh.m2m_ctx))) {
+			dev_dbg(inst->dev->dev, "buf type : %4d | index : %4d\n",
+				buf->vb2_buf.type, buf->vb2_buf.index);
+			vb2_set_plane_payload(&buf->vb2_buf, 0, 0);
+			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
+		}
+	}
+}
+
+static const struct vb2_ops wave5_vpu_enc_vb2_ops = {
+	.queue_setup = wave5_vpu_enc_queue_setup,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+	.buf_queue = wave5_vpu_enc_buf_queue,
+	.stop_streaming = wave5_vpu_enc_stop_streaming,
+};
+
+static void wave5_set_default_format(struct v4l2_pix_format_mplane *src_fmt,
+				     struct v4l2_pix_format_mplane *dst_fmt)
+{
+	unsigned int src_pix_fmt = wave5_vpu_enc_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix_fmt;
+	const struct v4l2_format_info *src_fmt_info = v4l2_format_info(src_pix_fmt);
+
+	src_fmt->pixelformat = src_pix_fmt;
+	src_fmt->field = V4L2_FIELD_NONE;
+	src_fmt->flags = 0;
+	src_fmt->num_planes = src_fmt_info->mem_planes;
+	wave5_update_pix_fmt(src_fmt, 416, 240);
+
+	dst_fmt->pixelformat = wave5_vpu_enc_fmt_list[VPU_FMT_TYPE_CODEC][0].v4l2_pix_fmt;
+	dst_fmt->field = V4L2_FIELD_NONE;
+	dst_fmt->flags = 0;
+	dst_fmt->num_planes = 1;
+	wave5_update_pix_fmt(dst_fmt, 416, 240);
+}
+
+static int wave5_vpu_enc_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
+{
+	struct vpu_instance *inst = priv;
+	int ret;
+
+	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	src_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
+	src_vq->mem_ops = &vb2_dma_contig_memops;
+	src_vq->ops = &wave5_vpu_enc_vb2_ops;
+	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	src_vq->buf_struct_size = sizeof(struct vpu_buffer);
+	src_vq->allow_zero_bytesused = 1;
+	src_vq->min_buffers_needed = 0;
+	src_vq->drv_priv = inst;
+	src_vq->lock = &inst->dev->dev_lock;
+	src_vq->dev = inst->dev->v4l2_dev.dev;
+	ret = vb2_queue_init(src_vq);
+	if (ret)
+		return ret;
+
+	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	dst_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
+	dst_vq->mem_ops = &vb2_dma_contig_memops;
+	dst_vq->ops = &wave5_vpu_enc_vb2_ops;
+	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	dst_vq->buf_struct_size = sizeof(struct vpu_buffer);
+	dst_vq->allow_zero_bytesused = 1;
+	dst_vq->min_buffers_needed = 0;
+	dst_vq->drv_priv = inst;
+	dst_vq->lock = &inst->dev->dev_lock;
+	dst_vq->dev = inst->dev->v4l2_dev.dev;
+	ret = vb2_queue_init(dst_vq);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct vpu_instance_ops wave5_vpu_enc_inst_ops = {
+	.start_process = wave5_vpu_enc_start_encode,
+	.stop_process = wave5_vpu_enc_stop_encode,
+	.finish_process = wave5_vpu_enc_finish_encode,
+};
+
+static int wave5_vpu_open_enc(struct file *filp)
+{
+	struct video_device *vdev = video_devdata(filp);
+	struct vpu_device *dev = video_drvdata(filp);
+	struct vpu_instance *inst = NULL;
+	struct v4l2_ctrl_handler *v4l2_ctrl_hdl;
+	struct v4l2_ctrl *ctrl;
+
+	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+	v4l2_ctrl_hdl = &inst->v4l2_ctrl_hdl;
+
+	inst->dev = dev;
+	inst->type = VPU_INST_TYPE_ENC;
+	inst->ops = &wave5_vpu_enc_inst_ops;
+
+	v4l2_fh_init(&inst->v4l2_fh, vdev);
+	filp->private_data = &inst->v4l2_fh;
+	v4l2_fh_add(&inst->v4l2_fh);
+
+	inst->v4l2_fh.m2m_ctx =
+		v4l2_m2m_ctx_init(dev->v4l2_m2m_dev, inst, wave5_vpu_enc_queue_init);
+	if (IS_ERR(inst->v4l2_fh.m2m_ctx))
+		return -ENODEV;
+
+	v4l2_ctrl_handler_init(v4l2_ctrl_hdl, 30);
+	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_HEVC_PROFILE,
+			       V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10, 0,
+			       V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN);
+	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_HEVC_LEVEL, V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1, 0,
+			       V4L2_MPEG_VIDEO_HEVC_LEVEL_1);
+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP,
+			  0, 63, 1, 8);
+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP,
+			  0, 63, 1, 51);
+	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_H264_PROFILE,
+			       V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE, 0,
+			       V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE);
+	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_H264_LEVEL, V4L2_MPEG_VIDEO_H264_LEVEL_5_1, 0,
+			       V4L2_MPEG_VIDEO_H264_LEVEL_1_0);
+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_MPEG_VIDEO_H264_MIN_QP,
+			  0, 63, 1, 8);
+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_MPEG_VIDEO_H264_MAX_QP,
+			  0, 63, 1, 51);
+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_ROTATE, 0, 270, 90, 0);
+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops, V4L2_CID_MPEG_VIDEO_VBV_SIZE, 10,
+			  3000, 1, 3000);
+	ctrl = v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
+				 V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 1);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+
+	if (inst->v4l2_ctrl_hdl.error)
+		return inst->v4l2_ctrl_hdl.error;
+
+	inst->v4l2_fh.ctrl_handler = v4l2_ctrl_hdl;
+	v4l2_ctrl_handler_setup(v4l2_ctrl_hdl);
+
+	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
+	inst->colorspace = V4L2_COLORSPACE_REC709;
+	inst->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	inst->hsv_enc = 0;
+	inst->quantization = V4L2_QUANTIZATION_DEFAULT;
+	inst->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+	inst->frame_rate = 30;
+
+	return 0;
+}
+
+static int wave5_vpu_enc_release(struct file *filp)
+{
+	struct vpu_instance *inst = wave5_to_vpu_inst(filp->private_data);
+	int retry_count = 10;
+	u32 fail_res;
+	int i, ret;
+
+	v4l2_m2m_ctx_release(inst->v4l2_fh.m2m_ctx);
+	if (inst->state != VPU_INST_STATE_NONE) {
+		do {
+			fail_res = 0;
+			ret = wave5_vpu_enc_close(inst, &fail_res);
+			if (ret && ret != -EIO)
+				break;
+			if (fail_res != WAVE5_SYSERR_VPU_STILL_RUNNING)
+				break;
+			if (!wave5_vpu_wait_interrupt(inst, VPU_ENC_TIMEOUT))
+				break;
+		} while (--retry_count);
+
+		if (fail_res == WAVE5_SYSERR_VPU_STILL_RUNNING)
+			dev_warn(inst->dev->dev, "failed wave5_vpu_enc_close()\n");
+		if (ret && ret != -EIO)
+			dev_warn(inst->dev->dev, "close fail ret=%d\n", ret);
+	}
+
+	for (i = 0; i < inst->min_dst_frame_buf_count; i++)
+		wave5_vdi_free_dma_memory(inst->dev, &inst->frame_vbuf[i]);
+
+	v4l2_ctrl_handler_free(&inst->v4l2_ctrl_hdl);
+	v4l2_fh_del(&inst->v4l2_fh);
+	v4l2_fh_exit(&inst->v4l2_fh);
+	kfree(inst);
+
+	return 0;
+}
+
+static const struct v4l2_file_operations wave5_vpu_enc_fops = {
+	.owner = THIS_MODULE,
+	.open = wave5_vpu_open_enc,
+	.release = wave5_vpu_enc_release,
+	.unlocked_ioctl = video_ioctl2,
+	.poll = v4l2_m2m_fop_poll,
+	.mmap = v4l2_m2m_fop_mmap,
+};
+
+int wave5_vpu_enc_register_device(struct vpu_device *dev)
+{
+	struct video_device *vdev_enc;
+	int ret;
+
+	vdev_enc = devm_kzalloc(dev->v4l2_dev.dev, sizeof(*vdev_enc), GFP_KERNEL);
+	if (!vdev_enc)
+		return -ENOMEM;
+
+	dev->video_dev_enc = vdev_enc;
+
+	strscpy(vdev_enc->name, VPU_ENC_DEV_NAME, sizeof(vdev_enc->name));
+	vdev_enc->fops = &wave5_vpu_enc_fops;
+	vdev_enc->ioctl_ops = &wave5_vpu_enc_ioctl_ops;
+	vdev_enc->release = video_device_release_empty;
+	vdev_enc->v4l2_dev = &dev->v4l2_dev;
+	vdev_enc->vfl_dir = VFL_DIR_M2M;
+	vdev_enc->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
+	vdev_enc->lock = &dev->dev_lock;
+
+	ret = video_register_device(vdev_enc, VFL_TYPE_VIDEO, -1);
+	if (ret)
+		return ret;
+
+	video_set_drvdata(vdev_enc, dev);
+
+	return 0;
+}
+
+void wave5_vpu_enc_unregister_device(struct vpu_device *dev)
+{
+	video_unregister_device(dev->video_dev_enc);
+}
+
diff --git a/drivers/staging/media/wave5/wave5-vpu.c b/drivers/staging/media/wave5/wave5-vpu.c
new file mode 100644
index 000000000000..f0f60508fa7d
--- /dev/null
+++ b/drivers/staging/media/wave5/wave5-vpu.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Wave5 series multi-standard codec IP - platform driver
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include "wave5-vpu.h"
+#include "wave5-regdefine.h"
+#include "wave5-vpuconfig.h"
+#include "wave5.h"
+
+#define VPU_PLATFORM_DEVICE_NAME "vdec"
+#define VPU_CLK_NAME "vcodec"
+
+#define WAVE5_IS_ENC BIT(0)
+#define WAVE5_IS_DEC BIT(1)
+
+struct wave5_match_data {
+	int flags;
+	const char *fw_name;
+};
+
+int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout)
+{
+	int ret;
+
+	ret = wait_for_completion_timeout(&inst->dev->irq_done,
+					  msecs_to_jiffies(timeout));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	reinit_completion(&inst->dev->irq_done);
+
+	return 0;
+}
+
+static irqreturn_t wave5_vpu_irq(int irq, void *dev_id)
+{
+	struct vpu_device *dev = dev_id;
+	unsigned int irq_status;
+
+	if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS)) {
+		irq_status = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
+		wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_status);
+		wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
+
+		kfifo_in(&dev->irq_status, &irq_status, sizeof(int));
+
+		return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
+{
+	struct vpu_device *dev = dev_id;
+	struct vpu_instance *inst;
+	unsigned int irq_status, val;
+	int ret;
+
+	while (kfifo_len(&dev->irq_status)) {
+		inst = v4l2_m2m_get_curr_priv(dev->v4l2_m2m_dev);
+		if (inst) {
+			inst->ops->finish_process(inst);
+		} else {
+			ret = kfifo_out(&dev->irq_status, &irq_status, sizeof(int));
+			if (!ret)
+				break;
+			dev_dbg(dev->dev, "irq_status: 0x%x\n", irq_status);
+			val = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON_USR);
+			val &= ~irq_status;
+			wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_USR, val);
+			complete(&dev->irq_done);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void wave5_vpu_device_run(void *priv)
+{
+	struct vpu_instance *inst = priv;
+
+	dev_dbg(inst->dev->dev, "inst type=%d state=%d\n",
+		inst->type, inst->state);
+
+	inst->ops->start_process(inst);
+}
+
+static int wave5_vpu_job_ready(void *priv)
+{
+	struct vpu_instance *inst = priv;
+
+	dev_dbg(inst->dev->dev, "inst type=%d state=%d\n",
+		inst->type, inst->state);
+
+	if (inst->state == VPU_INST_STATE_STOP)
+		return 0;
+
+	return 1;
+}
+
+static void wave5_vpu_job_abort(void *priv)
+{
+	struct vpu_instance *inst = priv;
+
+	dev_dbg(inst->dev->dev, "inst type=%d state=%d\n",
+		inst->type, inst->state);
+
+	inst->ops->stop_process(inst);
+}
+
+static const struct v4l2_m2m_ops wave5_vpu_m2m_ops = {
+	.device_run = wave5_vpu_device_run,
+	.job_ready = wave5_vpu_job_ready,
+	.job_abort = wave5_vpu_job_abort,
+};
+
+static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name)
+{
+	const struct firmware *fw;
+	int ret;
+	u32 version;
+	u32 revision;
+	u32 product_id;
+
+	ret = request_firmware(&fw, fw_name, dev);
+	if (ret) {
+		dev_err(dev, "request_firmware fail\n");
+		return ret;
+	}
+
+	ret = wave5_vpu_init_with_bitcode(dev, (u8 *)fw->data, fw->size);
+	if (ret) {
+		dev_err(dev, "vpu_init_with_bitcode fail\n");
+		goto release_fw;
+	}
+	release_firmware(fw);
+
+	ret = wave5_vpu_get_version_info(dev, &version, &revision, &product_id);
+	if (ret) {
+		dev_err(dev, "vpu_get_version_info fail\n");
+		goto release_fw;
+	}
+
+	dev_err(dev, "enum product_id : %08x\n", product_id);
+	dev_err(dev, "fw_version : %08x(r%d)\n", version, revision);
+
+	return 0;
+
+release_fw:
+	release_firmware(fw);
+	return ret;
+}
+
+static int wave5_vpu_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct vpu_device *dev;
+	const struct wave5_match_data *match_data;
+	struct resource *res;
+
+	match_data = device_get_match_data(&pdev->dev);
+	if (!match_data) {
+		dev_err(&pdev->dev, "missing data\n");
+		return -EINVAL;
+	}
+
+	/* physical addresses limited to 32 bits */
+	dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->vdb_register = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dev->vdb_register))
+		return PTR_ERR(dev->vdb_register);
+	ida_init(&dev->inst_ida);
+
+	mutex_init(&dev->dev_lock);
+	mutex_init(&dev->hw_lock);
+	init_completion(&dev->irq_done);
+	dev_set_drvdata(&pdev->dev, dev);
+	dev->dev = &pdev->dev;
+
+	ret = devm_clk_bulk_get_all(&pdev->dev, &dev->clks);
+
+	/* continue without clock, assume externally managed */
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "unable to get clocks: %d\n", ret);
+		ret = 0;
+	}
+	dev->num_clks = ret;
+
+	ret = clk_bulk_prepare_enable(dev->num_clks, dev->clks);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	dev->product_code = wave5_vdi_read_register(dev, VPU_PRODUCT_CODE_REGISTER);
+	ret = wave5_vdi_init(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to init vdi: %d\n", ret);
+		goto err_clk_dis;
+	}
+	dev->product = wave_vpu_get_product_id(dev);
+
+	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "v4l2_device_register fail: %d\n", ret);
+		goto err_vdi_release;
+	}
+
+	dev->v4l2_m2m_dev = v4l2_m2m_init(&wave5_vpu_m2m_ops);
+	if (IS_ERR(dev->v4l2_m2m_dev)) {
+		ret = PTR_ERR(dev->v4l2_m2m_dev);
+		dev_err(&pdev->dev, "v4l2_m2m_init fail: %d\n", ret);
+		goto err_v4l2_unregister;
+	}
+
+	if (match_data->flags & WAVE5_IS_DEC) {
+		ret = wave5_vpu_dec_register_device(dev);
+		if (ret) {
+			dev_err(&pdev->dev, "wave5_vpu_dec_register_device fail: %d\n", ret);
+			goto err_m2m_release;
+		}
+	}
+	if (match_data->flags & WAVE5_IS_ENC) {
+		ret = wave5_vpu_enc_register_device(dev);
+		if (ret) {
+			dev_err(&pdev->dev, "wave5_vpu_enc_register_device fail: %d\n", ret);
+			goto err_dec_unreg;
+		}
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get irq resource\n");
+		ret = -ENXIO;
+		goto err_enc_unreg;
+	}
+	dev->irq = res->start;
+
+	if (kfifo_alloc(&dev->irq_status, 16 * sizeof(int), GFP_KERNEL)) {
+		dev_err(&pdev->dev, "failed to allocate fifo\n");
+		goto err_enc_unreg;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, dev->irq, wave5_vpu_irq,
+					wave5_vpu_irq_thread, 0, "vpu_irq", dev);
+	if (ret) {
+		dev_err(&pdev->dev, "fail to register interrupt handler: %d\n", ret);
+		goto err_kfifo_free;
+	}
+
+	ret = wave5_vpu_load_firmware(&pdev->dev, match_data->fw_name);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to wave5_vpu_load_firmware: %d\n", ret);
+		goto err_kfifo_free;
+	}
+
+	return 0;
+
+err_kfifo_free:
+	kfifo_free(&dev->irq_status);
+err_enc_unreg:
+	if (match_data->flags & WAVE5_IS_ENC)
+		wave5_vpu_enc_unregister_device(dev);
+err_dec_unreg:
+	if (match_data->flags & WAVE5_IS_DEC)
+		wave5_vpu_dec_unregister_device(dev);
+err_m2m_release:
+	v4l2_m2m_release(dev->v4l2_m2m_dev);
+err_v4l2_unregister:
+	v4l2_device_unregister(&dev->v4l2_dev);
+err_vdi_release:
+	wave5_vdi_release(&pdev->dev);
+err_clk_dis:
+	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
+
+	return ret;
+}
+
+static int wave5_vpu_remove(struct platform_device *pdev)
+{
+	struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
+
+	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
+	wave5_vpu_enc_unregister_device(dev);
+	wave5_vpu_dec_unregister_device(dev);
+	v4l2_m2m_release(dev->v4l2_m2m_dev);
+	v4l2_device_unregister(&dev->v4l2_dev);
+	kfifo_free(&dev->irq_status);
+	wave5_vdi_release(&pdev->dev);
+
+	return 0;
+}
+
+static const struct wave5_match_data wave511_data = {
+	.flags = WAVE5_IS_DEC,
+	.fw_name = "wave511_dec_fw.bin",
+};
+
+static const struct wave5_match_data wave521_data = {
+	.flags = WAVE5_IS_ENC,
+	.fw_name = "wave521_enc_fw.bin",
+};
+
+static const struct wave5_match_data wave521c_data = {
+	.flags = WAVE5_IS_ENC | WAVE5_IS_DEC,
+	.fw_name = "wave521c_codec_fw.bin",
+};
+
+static const struct wave5_match_data default_match_data = {
+	.flags = WAVE5_IS_ENC | WAVE5_IS_DEC,
+	.fw_name = "chagall.bin",
+};
+
+static const struct of_device_id wave5_dt_ids[] = {
+	{ .compatible = "cnm,cm511-vpu", .data = &wave511_data },
+	{ .compatible = "cnm,cm517-vpu", .data = &default_match_data },
+	{ .compatible = "cnm,cm521-vpu", .data = &wave521_data },
+	{ .compatible = "cnm,cm521c-vpu", .data = &wave521c_data },
+	{ .compatible = "cnm,cm521c-dual-vpu", .data = &wave521c_data },
+	{ .compatible = "cnm,cm521e1-vpu", .data = &default_match_data },
+	{ .compatible = "cnm,cm537-vpu", .data = &default_match_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, wave5_dt_ids);
+
+static struct platform_driver wave5_vpu_driver = {
+	.driver = {
+		.name = VPU_PLATFORM_DEVICE_NAME,
+		.of_match_table = of_match_ptr(wave5_dt_ids),
+		},
+	.probe = wave5_vpu_probe,
+	.remove = wave5_vpu_remove,
+	//.suspend = vpu_suspend,
+	//.resume = vpu_resume,
+};
+
+module_platform_driver(wave5_vpu_driver);
+MODULE_DESCRIPTION("chips&media VPU V4L2 driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/staging/media/wave5/wave5-vpu.h b/drivers/staging/media/wave5/wave5-vpu.h
new file mode 100644
index 000000000000..1e0dd2e8c722
--- /dev/null
+++ b/drivers/staging/media/wave5/wave5-vpu.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - basic types
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+#ifndef __VPU_DRV_H__
+#define __VPU_DRV_H__
+
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-fh.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-vmalloc.h>
+#include "wave5-vpuconfig.h"
+#include "wave5-vpuapi.h"
+
+#define VPU_BUF_SYNC_TO_DEVICE 0
+#define VPU_BUF_SYNC_FROM_DEVICE 1
+
+struct vpu_buffer {
+	struct v4l2_m2m_buffer v4l2_m2m_buf;
+	bool                   consumed;
+};
+
+enum vpu_fmt_type {
+	VPU_FMT_TYPE_CODEC = 0,
+	VPU_FMT_TYPE_RAW   = 1
+};
+
+struct vpu_format {
+	unsigned int v4l2_pix_fmt;
+	unsigned int max_width;
+	unsigned int min_width;
+	unsigned int max_height;
+	unsigned int min_height;
+};
+
+static inline struct vpu_instance *wave5_to_vpu_inst(struct v4l2_fh *vfh)
+{
+	return container_of(vfh, struct vpu_instance, v4l2_fh);
+}
+
+static inline struct vpu_instance *wave5_ctrl_to_vpu_inst(struct v4l2_ctrl *vctrl)
+{
+	return container_of(vctrl->handler, struct vpu_instance, v4l2_ctrl_hdl);
+}
+
+static inline struct vpu_buffer *wave5_to_vpu_buf(struct vb2_v4l2_buffer *vbuf)
+{
+	return container_of(vbuf, struct vpu_buffer, v4l2_m2m_buf.vb);
+}
+
+int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout);
+
+int  wave5_vpu_dec_register_device(struct vpu_device *dev);
+void wave5_vpu_dec_unregister_device(struct vpu_device *dev);
+int  wave5_vpu_enc_register_device(struct vpu_device *dev);
+void wave5_vpu_enc_unregister_device(struct vpu_device *dev);
+static inline bool wave5_vpu_both_queues_are_streaming(struct vpu_instance *inst)
+{
+	struct vb2_queue *vq_cap =
+		v4l2_m2m_get_vq(inst->v4l2_fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+	struct vb2_queue *vq_out =
+		v4l2_m2m_get_vq(inst->v4l2_fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
+
+	return vb2_is_streaming(vq_cap) && vb2_is_streaming(vq_out);
+}
+
+#endif
+
-- 
2.17.1

