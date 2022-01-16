Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D479448FE91
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 19:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiAPS4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 13:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbiAPS4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 13:56:42 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BCBC06173E;
        Sun, 16 Jan 2022 10:56:41 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id br17so49512309lfb.6;
        Sun, 16 Jan 2022 10:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sk4KqytwCGJ665FwaYHnbIUx323Z3OeOkRJ0y/KS1bY=;
        b=KecGt1+I2T/9UeRJw1WF31E/FQgrrlR9ZzZ5sdKoqlnex/oU6flZV325BLszctCqZ7
         9+uyrHqXuGWsC5wSU2CdmVoGnZM6iHKRISHnHujH0ZAyr60F3XjZnSxJDsy2qwyUbcbq
         Ucyafwv2njXvmeIUvWd4xiqYaq72dCXpJfScCzh4e6b4a2llqDhvvVCaUCpwXvY4OgyE
         curONo4svT86VSJIS0r2oJgqKC+2LvE6gmX/xk5fN8bH6Meo9QDZJISTySSbkfRnDlKh
         7RsWOVFYBTCiFfp+1eUhuTvmTW2J/7qVU9pJRancvksz36LwmOcARIFCoasWIzOStIe8
         QqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sk4KqytwCGJ665FwaYHnbIUx323Z3OeOkRJ0y/KS1bY=;
        b=0RGZdxwfj+f65TmXidYEzswcoJ4JsZnJRtgBQrExUfRHwC3phoZUAcVG9YwT6s0bJG
         geE/5Yo4xgU2jqzEnWD4W7Qt4WtCVLaRQe1SLXxqIzrYNF4PHwoEN2XgUPcn0SbJ359S
         5QiSJh6/SGthZ3snbofvoQmgyslA3AMKklEElv64R/BoUF8qvvHAY4zCNi0puAlYNVXH
         rz8PiYLuqNvVkx8ifDP7wX1li6LNQ3NMe9CS+degdT95M+apSKcIuld/BzgO2rUm9E1t
         ri3URgUkhp/lqKOzkfi1IwoU6x7P93lVAZolMUZxIVRqa07wlbeN/4yP+CYJIJ33Krdu
         oekQ==
X-Gm-Message-State: AOAM531Nozgfy5xZAQnINXZEriicubD2qPYaEbmXRFSYKODl558ksZez
        mmmYNojNz82qBc2QIUv/ZZQ=
X-Google-Smtp-Source: ABdhPJyj/+KKfPpfxFn10z6Z4CrDlYyy0kyK7B4mETEuayPx9Q5lPUofojrrepzhMhddRLrG9zXEWw==
X-Received: by 2002:a2e:b90d:: with SMTP id b13mr889124ljb.385.1642359399573;
        Sun, 16 Jan 2022 10:56:39 -0800 (PST)
Received: from localhost.localdomain (46-138-227-157.dynamic.spd-mgts.ru. [46.138.227.157])
        by smtp.gmail.com with ESMTPSA id j2sm1179597lfe.18.2022.01.16.10.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 10:56:39 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] media: staging: tegra-vde: Support V4L stateless video decoder API
Date:   Sun, 16 Jan 2022 21:55:55 +0300
Message-Id: <20220116185556.10657-3-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220116185556.10657-1-digetx@gmail.com>
References: <20220116185556.10657-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose Tegra video decoder as a generic V4L M2M stateless video decoder.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/staging/media/tegra-vde/Kconfig  |    7 +
 drivers/staging/media/tegra-vde/Makefile |    2 +-
 drivers/staging/media/tegra-vde/h264.c   |  297 ++++++-
 drivers/staging/media/tegra-vde/v4l2.c   | 1018 ++++++++++++++++++++++
 drivers/staging/media/tegra-vde/vde.c    |   74 +-
 drivers/staging/media/tegra-vde/vde.h    |   85 ++
 6 files changed, 1475 insertions(+), 8 deletions(-)
 create mode 100644 drivers/staging/media/tegra-vde/v4l2.c

diff --git a/drivers/staging/media/tegra-vde/Kconfig b/drivers/staging/media/tegra-vde/Kconfig
index 0dc78afd09e0..07dbc1f44ca8 100644
--- a/drivers/staging/media/tegra-vde/Kconfig
+++ b/drivers/staging/media/tegra-vde/Kconfig
@@ -2,9 +2,16 @@
 config TEGRA_VDE
 	tristate "NVIDIA Tegra Video Decoder Engine driver"
 	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on VIDEO_DEV && VIDEO_V4L2
 	select DMA_SHARED_BUFFER
 	select IOMMU_IOVA
+	select MEDIA_CONTROLLER
+	select MEDIA_CONTROLLER_REQUEST_API
 	select SRAM
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_DMA_SG
+	select V4L2_H264
+	select V4L2_MEM2MEM_DEV
 	help
 	    Say Y here to enable support for the NVIDIA Tegra video decoder
 	    driver.
diff --git a/drivers/staging/media/tegra-vde/Makefile b/drivers/staging/media/tegra-vde/Makefile
index 43525b08b3b0..1758aa201baa 100644
--- a/drivers/staging/media/tegra-vde/Makefile
+++ b/drivers/staging/media/tegra-vde/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-tegra-vde-y := vde.o iommu.o dmabuf-cache.o h264.o
+tegra-vde-y := vde.o iommu.o dmabuf-cache.o h264.o v4l2.o
 obj-$(CONFIG_TEGRA_VDE)	+= tegra-vde.o
diff --git a/drivers/staging/media/tegra-vde/h264.c b/drivers/staging/media/tegra-vde/h264.c
index 03faa705bf71..b3bb3e865ff3 100644
--- a/drivers/staging/media/tegra-vde/h264.c
+++ b/drivers/staging/media/tegra-vde/h264.c
@@ -11,10 +11,18 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
+#include <media/v4l2-h264.h>
+
 #include "trace.h"
 #include "uapi.h"
 #include "vde.h"
 
+struct h264_reflists {
+	u8 p[V4L2_H264_NUM_DPB_ENTRIES];
+	u8 b0[V4L2_H264_NUM_DPB_ENTRIES];
+	u8 b1[V4L2_H264_NUM_DPB_ENTRIES];
+};
+
 static int tegra_vde_wait_mbe(struct tegra_vde *vde)
 {
 	u32 tmp;
@@ -125,8 +133,8 @@ static void tegra_vde_setup_frameid(struct tegra_vde *vde,
 	u32 y_addr  = frame ? frame->y_addr  : 0x6CDEAD00;
 	u32 cb_addr = frame ? frame->cb_addr : 0x6CDEAD00;
 	u32 cr_addr = frame ? frame->cr_addr : 0x6CDEAD00;
-	u32 value1 = frame ? ((mbs_width << 16) | mbs_height) : 0;
-	u32 value2 = frame ? ((((mbs_width + 1) >> 1) << 6) | 1) : 0;
+	u32 value1 = frame ? ((frame->luma_atoms_pitch << 16) | mbs_height) : 0;
+	u32 value2 = frame ? ((frame->chroma_atoms_pitch << 6) | 1) : 0;
 
 	tegra_vde_writel(vde, y_addr  >> 8, vde->frameid, 0x000 + frameid * 4);
 	tegra_vde_writel(vde, cb_addr >> 8, vde->frameid, 0x100 + frameid * 4);
@@ -645,3 +653,288 @@ int tegra_vde_decode_h264(struct tegra_vde *vde,
 
 	return tegra_vde_decode_end(vde);
 }
+
+static struct vb2_buffer *get_ref_buf(struct tegra_ctx *ctx,
+				      struct vb2_v4l2_buffer *dst,
+				      unsigned int dpb_idx)
+{
+	const struct v4l2_h264_dpb_entry *dpb = ctx->h264.decode_params->dpb;
+	struct vb2_queue *cap_q = &ctx->fh.m2m_ctx->cap_q_ctx.q;
+	int buf_idx = -1;
+
+	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
+		buf_idx = vb2_find_timestamp(cap_q,
+					     dpb[dpb_idx].reference_ts, 0);
+
+	/*
+	 * If a DPB entry is unused or invalid, address of current destination
+	 * buffer is returned.
+	 */
+	if (buf_idx < 0)
+		return &dst->vb2_buf;
+
+	return vb2_get_buffer(cap_q, buf_idx);
+}
+
+static int tegra_vde_validate_vb_size(struct tegra_ctx *ctx,
+				      struct vb2_buffer *vb,
+				      unsigned int plane_id,
+				      size_t min_size)
+{
+	u64 offset = vb->planes[plane_id].data_offset;
+	struct device *dev = ctx->vde->dev;
+
+	if (offset + min_size > vb2_plane_size(vb, plane_id)) {
+		dev_err(dev, "Too small plane[%u] size %lu @0x%llX, should be at least %zu\n",
+			plane_id, vb2_plane_size(vb, plane_id), offset, min_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tegra_vde_h264_setup_frame(struct tegra_ctx *ctx,
+				      struct tegra_vde_h264_decoder_ctx *h264,
+				      struct v4l2_h264_reflist_builder *b,
+				      struct vb2_buffer *vb,
+				      unsigned int ref_id,
+				      unsigned int id)
+{
+	struct v4l2_pix_format_mplane *pixfmt = &ctx->decoded_fmt.fmt.pix_mp;
+	struct tegra_m2m_buffer *tb = vb_to_tegra_buf(vb);
+	struct tegra_ctx_h264 *h = &ctx->h264;
+	struct tegra_vde *vde = ctx->vde;
+	struct device *dev = vde->dev;
+	unsigned int cstride, lstride;
+	unsigned int flags = 0;
+	size_t lsize, csize;
+	int err, frame_num;
+
+	lsize = h264->pic_width_in_mbs * 16 * h264->pic_height_in_mbs * 16;
+	csize = h264->pic_width_in_mbs *  8 * h264->pic_height_in_mbs *  8;
+	lstride = pixfmt->plane_fmt[0].bytesperline;
+	cstride = pixfmt->plane_fmt[1].bytesperline;
+
+	err = tegra_vde_validate_vb_size(ctx, vb, 0, lsize);
+	if (err)
+		return err;
+
+	err = tegra_vde_validate_vb_size(ctx, vb, 1, csize);
+	if (err)
+		return err;
+
+	err = tegra_vde_validate_vb_size(ctx, vb, 2, csize);
+	if (err)
+		return err;
+
+	if (!tb->aux || tb->aux->size < csize) {
+		dev_err(dev, "Too small aux size %zd, should be at least %zu\n",
+			tb->aux ? tb->aux->size : -1, csize);
+		return -EINVAL;
+	}
+
+	if (id == 0) {
+		frame_num = h->decode_params->frame_num;
+
+		if (h->decode_params->nal_ref_idc)
+			flags |= FLAG_REFERENCE;
+	} else {
+		frame_num = b->refs[ref_id].frame_num & 0x7fffff;
+	}
+
+	if (to_vb2_v4l2_buffer(vb)->flags & V4L2_BUF_FLAG_BFRAME)
+		flags |= FLAG_B_FRAME;
+
+	vde->frames[id].flags = flags;
+	vde->frames[id].y_addr = tb->dma_addr[0];
+	vde->frames[id].cb_addr = tb->dma_addr[1];
+	vde->frames[id].cr_addr = tb->dma_addr[2];
+	vde->frames[id].aux_addr = tb->aux->dma_addr;
+	vde->frames[id].frame_num = frame_num;
+	vde->frames[id].luma_atoms_pitch = lstride / VDE_ATOM;
+	vde->frames[id].chroma_atoms_pitch = cstride / VDE_ATOM;
+
+	return 0;
+}
+
+static int tegra_vde_h264_setup_frames(struct tegra_ctx *ctx,
+				       struct tegra_vde_h264_decoder_ctx *h264)
+{
+	struct vb2_v4l2_buffer *src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	struct vb2_v4l2_buffer *dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+	const struct v4l2_h264_dpb_entry *dpb = ctx->h264.decode_params->dpb;
+	struct tegra_ctx_h264 *h = &ctx->h264;
+	struct v4l2_h264_reflist_builder b;
+	struct h264_reflists reflists;
+	struct vb2_buffer *ref;
+	unsigned int i;
+	u8 *dpb_id;
+	int err;
+
+	/*
+	 * Tegra hardware requires information about frame's type, assuming
+	 * that frame consists of the same type slices. Userspace must tag
+	 * frame's type appropriately.
+	 *
+	 * Decoding of a non-uniform frames isn't supported by hardware and
+	 * require software preprocessing that we don't implement. Decoding
+	 * is expected to fail in this case. Such video streams are rare in
+	 * practice, so not a big deal.
+	 *
+	 * If userspace doesn't tell us frame's type, then we will try decode
+	 * as-is.
+	 */
+	v4l2_m2m_buf_copy_metadata(src, dst, true);
+
+	err = tegra_vde_h264_setup_frame(ctx, h264, NULL, &dst->vb2_buf, 0,
+					 h264->dpb_frames_nb++);
+	if (err)
+		return err;
+
+	if (dst->flags & V4L2_BUF_FLAG_KEYFRAME)
+		return 0;
+
+	v4l2_h264_init_reflist_builder(&b, h->decode_params, h->sps, dpb);
+
+	if (dst->flags & V4L2_BUF_FLAG_BFRAME) {
+		v4l2_h264_build_b_ref_lists(&b, reflists.b0, reflists.b1);
+		dpb_id = reflists.b0;
+	} else {
+		v4l2_h264_build_p_ref_list(&b, reflists.p);
+		dpb_id = reflists.p;
+	}
+
+	for (i = 0; i < b.num_valid; i++) {
+		ref = get_ref_buf(ctx, dst, dpb_id[i]);
+
+		err = tegra_vde_h264_setup_frame(ctx, h264, &b, ref, dpb_id[i],
+						 h264->dpb_frames_nb++);
+		if (err)
+			return err;
+
+		if (b.refs[dpb_id[i]].pic_order_count < b.cur_pic_order_count)
+			h264->dpb_ref_frames_with_earlier_poc_nb++;
+	}
+
+	return 0;
+}
+
+static unsigned int to_tegra_vde_h264_level_idc(unsigned int level_idc)
+{
+	switch (level_idc) {
+	case 11:
+		return 2;
+	case 12:
+		return 3;
+	case 13:
+		return 4;
+	case 20:
+		return 5;
+	case 21:
+		return 6;
+	case 22:
+		return 7;
+	case 30:
+		return 8;
+	case 31:
+		return 9;
+	case 32:
+		return 10;
+	case 40:
+		return 11;
+	case 41:
+		return 12;
+	case 42:
+		return 13;
+	case 50:
+		return 14;
+	default:
+		break;
+	}
+
+	return 15;
+}
+
+static int tegra_vde_h264_setup_context(struct tegra_ctx *ctx,
+					struct tegra_vde_h264_decoder_ctx *h264)
+{
+	struct tegra_ctx_h264 *h = &ctx->h264;
+	struct tegra_vde *vde = ctx->vde;
+	struct device *dev = vde->dev;
+	int err;
+
+	memset(h264, 0, sizeof(*h264));
+	memset(vde->frames, 0, sizeof(vde->frames));
+
+	tegra_vde_prepare_control_data(ctx, V4L2_CID_STATELESS_H264_DECODE_PARAMS);
+	tegra_vde_prepare_control_data(ctx, V4L2_CID_STATELESS_H264_SPS);
+	tegra_vde_prepare_control_data(ctx, V4L2_CID_STATELESS_H264_PPS);
+
+	/* CABAC unsupported by hardware, requires software preprocessing */
+	if (h->pps->flags & V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE)
+		return -EOPNOTSUPP;
+
+	if (h->sps->profile_idc == 66)
+		h264->baseline_profile = 1;
+
+	if (h->sps->flags & V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE)
+		h264->direct_8x8_inference_flag = 1;
+
+	if (h->pps->flags & V4L2_H264_PPS_FLAG_CONSTRAINED_INTRA_PRED)
+		h264->constrained_intra_pred_flag = 1;
+
+	if (h->pps->flags & V4L2_H264_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT)
+		h264->deblocking_filter_control_present_flag = 1;
+
+	if (h->pps->flags & V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN_FRAME_PRESENT)
+		h264->pic_order_present_flag = 1;
+
+	h264->level_idc				= to_tegra_vde_h264_level_idc(h->sps->level_idc);
+	h264->log2_max_pic_order_cnt_lsb	= h->sps->log2_max_pic_order_cnt_lsb_minus4 + 4;
+	h264->log2_max_frame_num		= h->sps->log2_max_frame_num_minus4 + 4;
+	h264->pic_order_cnt_type		= h->sps->pic_order_cnt_type;
+	h264->pic_width_in_mbs			= h->sps->pic_width_in_mbs_minus1 + 1;
+	h264->pic_height_in_mbs			= h->sps->pic_height_in_map_units_minus1 + 1;
+
+	h264->num_ref_idx_l0_active_minus1	= h->pps->num_ref_idx_l0_default_active_minus1;
+	h264->num_ref_idx_l1_active_minus1	= h->pps->num_ref_idx_l1_default_active_minus1;
+	h264->chroma_qp_index_offset		= h->pps->chroma_qp_index_offset & 0x1f;
+	h264->pic_init_qp			= h->pps->pic_init_qp_minus26 + 26;
+
+	err = tegra_vde_h264_setup_frames(ctx, h264);
+	if (err)
+		return err;
+
+	err = tegra_vde_validate_h264_ctx(dev, h264);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int tegra_vde_h264_decode_run(struct tegra_ctx *ctx)
+{
+	struct vb2_v4l2_buffer *src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	struct tegra_m2m_buffer *bitstream = vb_to_tegra_buf(&src->vb2_buf);
+	size_t bitstream_size = vb2_get_plane_payload(&src->vb2_buf, 0);
+	struct tegra_vde_h264_decoder_ctx h264;
+	struct tegra_vde *vde = ctx->vde;
+	int err;
+
+	err = tegra_vde_h264_setup_context(ctx, &h264);
+	if (err)
+		return err;
+
+	err = tegra_vde_decode_begin(vde, &h264, vde->frames,
+				     bitstream->dma_addr[0],
+				     bitstream_size);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int tegra_vde_h264_decode_wait(struct tegra_ctx *ctx)
+{
+	return tegra_vde_decode_end(ctx->vde);
+}
diff --git a/drivers/staging/media/tegra-vde/v4l2.c b/drivers/staging/media/tegra-vde/v4l2.c
new file mode 100644
index 000000000000..bd8c207d5b54
--- /dev/null
+++ b/drivers/staging/media/tegra-vde/v4l2.c
@@ -0,0 +1,1018 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NVIDIA Tegra Video decoder driver
+ *
+ * Copyright (C) 2019-2022 Dmitry Osipenko <digetx@gmail.com>
+ *
+ * Based on Cedrus driver by Bootlin.
+ * Copyright (C) 2016 Florent Revest <florent.revest@free-electrons.com>
+ * Copyright (C) 2018 Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ *
+ * Based on Rockchip driver by Collabora.
+ * Copyright (C) 2019 Boris Brezillon <boris.brezillon@collabora.com>
+ */
+
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include "vde.h"
+
+static const struct v4l2_ctrl_config ctrl_cfgs[] = {
+	{	.id = V4L2_CID_STATELESS_H264_DECODE_PARAMS,	},
+	{	.id = V4L2_CID_STATELESS_H264_SPS,		},
+	{	.id = V4L2_CID_STATELESS_H264_PPS,		},
+	{
+		.id = V4L2_CID_STATELESS_H264_DECODE_MODE,
+		.min = V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
+		.max = V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
+		.def = V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
+	},
+	{
+		.id = V4L2_CID_STATELESS_H264_START_CODE,
+		.min = V4L2_STATELESS_H264_START_CODE_ANNEX_B,
+		.max = V4L2_STATELESS_H264_START_CODE_ANNEX_B,
+		.def = V4L2_STATELESS_H264_START_CODE_ANNEX_B,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_H264_PROFILE,
+		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
+		.max = V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
+		.def = V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_H264_LEVEL,
+		.min = V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
+		.max = V4L2_MPEG_VIDEO_H264_LEVEL_5_1,
+	},
+};
+
+static inline struct tegra_ctx *fh_to_tegra_ctx(struct v4l2_fh *fh)
+{
+	return container_of(fh, struct tegra_ctx, fh);
+}
+
+static void tegra_set_control_data(struct tegra_ctx *ctx, void *data, u32 id)
+{
+	switch (id) {
+	case V4L2_CID_STATELESS_H264_DECODE_PARAMS:
+		ctx->h264.decode_params = data;
+		break;
+	case V4L2_CID_STATELESS_H264_SPS:
+		ctx->h264.sps = data;
+		break;
+	case V4L2_CID_STATELESS_H264_PPS:
+		ctx->h264.pps = data;
+		break;
+	}
+}
+
+void tegra_vde_prepare_control_data(struct tegra_ctx *ctx, u32 id)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ctrl_cfgs); i++) {
+		if (ctx->ctrls[i]->id == id) {
+			tegra_set_control_data(ctx, ctx->ctrls[i]->p_cur.p, id);
+			return;
+		}
+	}
+
+	tegra_set_control_data(ctx, NULL, id);
+}
+
+static int tegra_queue_setup(struct vb2_queue *vq,
+			     unsigned int *nbufs,
+			     unsigned int *num_planes,
+			     unsigned int sizes[],
+			     struct device *alloc_devs[])
+{
+	struct tegra_ctx *ctx = vb2_get_drv_priv(vq);
+	struct v4l2_format *f;
+	unsigned int i;
+
+	if (V4L2_TYPE_IS_OUTPUT(vq->type))
+		f = &ctx->coded_fmt;
+	else
+		f = &ctx->decoded_fmt;
+
+	if (*num_planes) {
+		if (*num_planes != f->fmt.pix_mp.num_planes)
+			return -EINVAL;
+
+		for (i = 0; i < f->fmt.pix_mp.num_planes; i++) {
+			if (sizes[i] < f->fmt.pix_mp.plane_fmt[i].sizeimage)
+				return -EINVAL;
+		}
+	} else {
+		*num_planes = f->fmt.pix_mp.num_planes;
+
+		for (i = 0; i < f->fmt.pix_mp.num_planes; i++)
+			sizes[i] = f->fmt.pix_mp.plane_fmt[i].sizeimage;
+	}
+
+	return 0;
+}
+
+static int tegra_buf_out_validate(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+	vbuf->field = V4L2_FIELD_NONE;
+	return 0;
+}
+
+static void __tegra_buf_cleanup(struct vb2_buffer *vb, unsigned int i)
+{
+	struct vb2_queue *vq = vb->vb2_queue;
+	struct tegra_ctx *ctx = vb2_get_drv_priv(vq);
+	struct tegra_m2m_buffer *tb = vb_to_tegra_buf(vb);
+
+	while (i--) {
+		if (tb->a[i]) {
+			tegra_vde_dmabuf_cache_unmap(ctx->vde, tb->a[i], true);
+			tb->a[i] = NULL;
+		}
+
+		if (tb->iova[i]) {
+			tegra_vde_iommu_unmap(ctx->vde, tb->iova[i]);
+			tb->iova[i] = NULL;
+		}
+	}
+
+	if (tb->aux) {
+		tegra_vde_free_bo(tb->aux);
+		tb->aux = NULL;
+	}
+}
+
+static int tegra_buf_init(struct vb2_buffer *vb)
+{
+	struct vb2_queue *vq = vb->vb2_queue;
+	struct tegra_ctx *ctx = vb2_get_drv_priv(vq);
+	struct tegra_m2m_buffer *tb = vb_to_tegra_buf(vb);
+	struct tegra_vde *vde = ctx->vde;
+	enum dma_data_direction dma_dir;
+	struct sg_table *sgt;
+	unsigned int i;
+	int err;
+
+	if (V4L2_TYPE_IS_CAPTURE(vq->type) && vb->num_planes > 1) {
+		/*
+		 * Tegra decoder writes auxiliary data for I/P frames.
+		 * This data is needed for decoding of B frames.
+		 */
+		err = tegra_vde_alloc_bo(vde, &tb->aux, DMA_FROM_DEVICE,
+					 vb2_plane_size(vb, 1));
+		if (err)
+			return err;
+	}
+
+	if (V4L2_TYPE_IS_OUTPUT(vq->type))
+		dma_dir = DMA_TO_DEVICE;
+	else
+		dma_dir = DMA_FROM_DEVICE;
+
+	for (i = 0; i < vb->num_planes; i++) {
+		if (vq->memory == VB2_MEMORY_DMABUF) {
+			get_dma_buf(vb->planes[i].dbuf);
+
+			err = tegra_vde_dmabuf_cache_map(vde, vb->planes[i].dbuf,
+							 dma_dir, &tb->a[i],
+							 &tb->dma_base[i]);
+			if (err) {
+				dma_buf_put(vb->planes[i].dbuf);
+				goto cleanup;
+			}
+
+			continue;
+		}
+
+		if (vde->domain) {
+			sgt = vb2_dma_sg_plane_desc(vb, i);
+
+			err = tegra_vde_iommu_map(vde, sgt, &tb->iova[i],
+						  vb2_plane_size(vb, i));
+			if (err)
+				goto cleanup;
+
+			tb->dma_base[i] = iova_dma_addr(&vde->iova, tb->iova[i]);
+		} else {
+			tb->dma_base[i] = vb2_dma_contig_plane_dma_addr(vb, i);
+		}
+	}
+
+	return 0;
+
+cleanup:
+	__tegra_buf_cleanup(vb, i);
+
+	return err;
+}
+
+static void tegra_buf_cleanup(struct vb2_buffer *vb)
+{
+	__tegra_buf_cleanup(vb, vb->num_planes);
+}
+
+static int tegra_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vb2_queue *vq = vb->vb2_queue;
+	struct tegra_ctx *ctx = vb2_get_drv_priv(vq);
+	struct tegra_m2m_buffer *tb = vb_to_tegra_buf(vb);
+	size_t hw_align, hw_size, hw_payload, size, offset;
+	struct v4l2_pix_format_mplane *pixfmt;
+	unsigned int i;
+	void *vb_data;
+
+	if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
+		hw_align = BSEV_ALIGN;
+		pixfmt = &ctx->coded_fmt.fmt.pix_mp;
+	} else {
+		hw_align = FRAMEID_ALIGN;
+		pixfmt = &ctx->decoded_fmt.fmt.pix_mp;
+	}
+
+	for (i = 0; i < vb->num_planes; i++) {
+		offset = vb->planes[i].data_offset;
+
+		if (offset & (hw_align - 1))
+			return -EINVAL;
+
+		if (V4L2_TYPE_IS_CAPTURE(vq->type)) {
+			size = pixfmt->plane_fmt[i].sizeimage;
+			hw_payload = ALIGN(size, VDE_ATOM);
+		} else {
+			size = vb2_get_plane_payload(vb, i) - offset;
+			hw_payload = ALIGN(size + VDE_ATOM, SXE_BUFFER);
+		}
+
+		hw_size = offset + hw_payload;
+
+		if (vb2_plane_size(vb, i) < hw_size)
+			return -EINVAL;
+
+		vb2_set_plane_payload(vb, i, hw_payload);
+
+		if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
+			vb_data = vb2_plane_vaddr(vb, i);
+
+			/*
+			 * Hardware requires zero-padding of coded data.
+			 * Otherwise it will fail to parse the trailing
+			 * data and abort the decoding.
+			 */
+			if (vb_data)
+				memset(vb_data + offset + size, 0,
+				       hw_size - offset - size);
+		}
+
+		tb->dma_addr[i] = tb->dma_base[i] + offset;
+	}
+
+	switch (pixfmt->pixelformat) {
+	case V4L2_PIX_FMT_YVU420M:
+		swap(tb->dma_addr[1], tb->dma_addr[2]);
+		break;
+	}
+
+	return 0;
+}
+
+static void tegra_buf_queue(struct vb2_buffer *vb)
+{
+	struct tegra_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
+}
+
+static void tegra_buf_request_complete(struct vb2_buffer *vb)
+{
+	struct tegra_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+
+	v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->hdl);
+}
+
+static int tegra_start_streaming(struct vb2_queue *vq, unsigned int count)
+{
+	return 0;
+}
+
+static void tegra_stop_streaming(struct vb2_queue *vq)
+{
+	struct tegra_ctx *ctx = vb2_get_drv_priv(vq);
+
+	while (true) {
+		struct vb2_v4l2_buffer *vbuf;
+
+		if (V4L2_TYPE_IS_OUTPUT(vq->type))
+			vbuf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+		else
+			vbuf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+
+		if (!vbuf)
+			break;
+
+		v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req, &ctx->hdl);
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+	}
+}
+
+static const struct vb2_ops tegra_qops = {
+	.queue_setup = tegra_queue_setup,
+	.buf_init = tegra_buf_init,
+	.buf_cleanup = tegra_buf_cleanup,
+	.buf_prepare = tegra_buf_prepare,
+	.buf_queue = tegra_buf_queue,
+	.buf_out_validate = tegra_buf_out_validate,
+	.buf_request_complete = tegra_buf_request_complete,
+	.start_streaming = tegra_start_streaming,
+	.stop_streaming = tegra_stop_streaming,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+};
+
+static int tegra_queue_init(void *priv,
+			    struct vb2_queue *src_vq,
+			    struct vb2_queue *dst_vq)
+{
+	struct tegra_ctx *ctx = priv;
+	struct tegra_vde *vde = ctx->vde;
+	const struct vb2_mem_ops *mem_ops;
+	unsigned long dma_attrs;
+	int err;
+
+	/*
+	 * TODO: Switch to use of vb2_dma_contig_memops uniformly once we
+	 * will add IOMMU_DOMAIN support for video decoder to tegra-smmu
+	 * driver. For now we need to stick with SG ops in order to be able
+	 * to get SGT table easily. This is suboptimal since SG mappings are
+	 * wasting CPU cache and we don't need that caching.
+	 */
+	if (vde->domain)
+		mem_ops = &vb2_dma_sg_memops;
+	else
+		mem_ops = &vb2_dma_contig_memops;
+
+	dma_attrs = DMA_ATTR_WRITE_COMBINE;
+
+	src_vq->buf_struct_size = sizeof(struct tegra_m2m_buffer);
+	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	src_vq->io_modes = VB2_DMABUF | VB2_MMAP;
+	src_vq->supports_requests = true;
+	src_vq->requires_requests = true;
+	src_vq->lock = &vde->v4l2_lock;
+	src_vq->dma_attrs = dma_attrs;
+	src_vq->mem_ops = mem_ops;
+	src_vq->ops = &tegra_qops;
+	src_vq->drv_priv = ctx;
+	src_vq->dev = vde->dev;
+
+	err = vb2_queue_init(src_vq);
+	if (err) {
+		v4l2_err(&vde->v4l2_dev,
+			 "failed to initialize src queue: %d\n", err);
+		return err;
+	}
+
+	/*
+	 * We may need to zero the end of bitstream in kernel if userspace
+	 * doesn't do that, hence kmap is needed for the coded data. It's not
+	 * needed for framebuffers.
+	 */
+	dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
+
+	dst_vq->buf_struct_size = sizeof(struct tegra_m2m_buffer);
+	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	dst_vq->io_modes = VB2_DMABUF | VB2_MMAP;
+	dst_vq->lock = &vde->v4l2_lock;
+	dst_vq->dma_attrs = dma_attrs;
+	dst_vq->mem_ops = mem_ops;
+	dst_vq->ops = &tegra_qops;
+	dst_vq->drv_priv = ctx;
+	dst_vq->dev = vde->dev;
+
+	err = vb2_queue_init(dst_vq);
+	if (err) {
+		v4l2_err(&vde->v4l2_dev,
+			 "failed to initialize dst queue: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void tegra_reset_fmt(struct tegra_ctx *ctx, struct v4l2_format *f,
+			    u32 fourcc)
+{
+	memset(f, 0, sizeof(*f));
+	f->fmt.pix_mp.pixelformat = fourcc;
+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
+	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709;
+	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
+}
+
+static void tegra_reset_coded_fmt(struct tegra_ctx *ctx)
+{
+	const struct tegra_vde_soc *soc = ctx->vde->soc;
+	struct v4l2_format *f = &ctx->coded_fmt;
+
+	ctx->coded_fmt_desc = &soc->coded_fmts[0];
+	tegra_reset_fmt(ctx, f, ctx->coded_fmt_desc->fourcc);
+
+	f->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	f->fmt.pix_mp.width = ctx->coded_fmt_desc->frmsize.min_width;
+	f->fmt.pix_mp.height = ctx->coded_fmt_desc->frmsize.min_height;
+}
+
+static void tegra_fill_pixfmt_mp(struct v4l2_pix_format_mplane *pixfmt,
+				 u32 pixelformat, u32 width, u32 height)
+{
+	const struct v4l2_format_info *info = v4l2_format_info(pixelformat);
+	struct v4l2_plane_pix_format *plane;
+	unsigned int i;
+
+	switch (pixelformat) {
+	case V4L2_PIX_FMT_YUV420M:
+	case V4L2_PIX_FMT_YVU420M:
+		pixfmt->width = width;
+		pixfmt->height = height;
+		pixfmt->pixelformat = pixelformat;
+		pixfmt->num_planes = info->mem_planes;
+
+		for (i = 0; i < pixfmt->num_planes; i++) {
+			unsigned int hdiv = (i == 0) ? 1 : 2;
+			unsigned int vdiv = (i == 0) ? 1 : 2;
+
+			/*
+			 * VDE is connected to Graphics Memory using 128bit port,
+			 * all memory accesses are made using 16B atoms.
+			 *
+			 * V4L requires Cb/Cr strides to be exactly half of the
+			 * Y stride, hence we're aligning Y to 16B x 2.
+			 */
+			plane = &pixfmt->plane_fmt[i];
+			plane->bytesperline = ALIGN(width, VDE_ATOM * 2) / hdiv;
+			plane->sizeimage = plane->bytesperline * height / vdiv;
+		}
+
+		break;
+	}
+}
+
+static void tegra_reset_decoded_fmt(struct tegra_ctx *ctx)
+{
+	struct v4l2_format *f = &ctx->decoded_fmt;
+
+	tegra_reset_fmt(ctx, f, ctx->coded_fmt_desc->decoded_fmts[0]);
+	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	tegra_fill_pixfmt_mp(&f->fmt.pix_mp,
+			     ctx->coded_fmt_desc->decoded_fmts[0],
+			     ctx->coded_fmt.fmt.pix_mp.width,
+			     ctx->coded_fmt.fmt.pix_mp.height);
+}
+
+static void tegra_job_finish(struct tegra_ctx *ctx,
+			     enum vb2_buffer_state result)
+{
+	v4l2_m2m_buf_done_and_job_finish(ctx->vde->m2m, ctx->fh.m2m_ctx,
+					 result);
+}
+
+static void tegra_decode_complete(struct work_struct *work)
+{
+	struct tegra_ctx *ctx = container_of(work, struct tegra_ctx, work);
+	int err;
+
+	err = ctx->coded_fmt_desc->decode_wait(ctx);
+	if (err)
+		tegra_job_finish(ctx, VB2_BUF_STATE_ERROR);
+	else
+		tegra_job_finish(ctx, VB2_BUF_STATE_DONE);
+}
+
+static int tegra_querycap(struct file *file, void *priv,
+			  struct v4l2_capability *cap)
+{
+	strscpy(cap->bus_info, "platform:tegra-vde", sizeof(cap->bus_info));
+	strscpy(cap->driver, "tegra-vde", sizeof(cap->driver));
+	strscpy(cap->card, "tegra-vde", sizeof(cap->card));
+
+	return 0;
+}
+
+static int tegra_enum_decoded_fmt(struct file *file, void *priv,
+				  struct v4l2_fmtdesc *f)
+{
+	struct tegra_ctx *ctx = fh_to_tegra_ctx(priv);
+
+	if (WARN_ON(!ctx->coded_fmt_desc))
+		return -EINVAL;
+
+	if (f->index >= ctx->coded_fmt_desc->num_decoded_fmts)
+		return -EINVAL;
+
+	f->pixelformat = ctx->coded_fmt_desc->decoded_fmts[f->index];
+
+	return 0;
+}
+
+static int tegra_g_decoded_fmt(struct file *file, void *priv,
+			       struct v4l2_format *f)
+{
+	struct tegra_ctx *ctx = fh_to_tegra_ctx(priv);
+
+	*f = ctx->decoded_fmt;
+	return 0;
+}
+
+static int tegra_try_decoded_fmt(struct file *file, void *priv,
+				 struct v4l2_format *f)
+{
+	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
+	struct tegra_ctx *ctx = fh_to_tegra_ctx(priv);
+	const struct tegra_coded_fmt_desc *coded_desc;
+	unsigned int i;
+
+	/*
+	 * The codec context should point to a coded format desc, if the format
+	 * on the coded end has not been set yet, it should point to the
+	 * default value.
+	 */
+	coded_desc = ctx->coded_fmt_desc;
+	if (WARN_ON(!coded_desc))
+		return -EINVAL;
+
+	if (!coded_desc->num_decoded_fmts)
+		return -EINVAL;
+
+	for (i = 0; i < coded_desc->num_decoded_fmts; i++) {
+		if (coded_desc->decoded_fmts[i] == pix_mp->pixelformat)
+			break;
+	}
+
+	if (i == coded_desc->num_decoded_fmts)
+		pix_mp->pixelformat = coded_desc->decoded_fmts[0];
+
+	/* always apply the frmsize constraint of the coded end */
+	v4l2_apply_frmsize_constraints(&pix_mp->width,
+				       &pix_mp->height,
+				       &coded_desc->frmsize);
+
+	tegra_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
+			     pix_mp->width, pix_mp->height);
+	pix_mp->field = V4L2_FIELD_NONE;
+
+	return 0;
+}
+
+static int tegra_s_decoded_fmt(struct file *file, void *priv,
+			       struct v4l2_format *f)
+{
+	struct tegra_ctx *ctx = fh_to_tegra_ctx(priv);
+	struct vb2_queue *vq;
+	int err;
+
+	/* change not allowed if queue is busy */
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+			     V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+	if (vb2_is_busy(vq))
+		return -EBUSY;
+
+	err = tegra_try_decoded_fmt(file, priv, f);
+	if (err)
+		return err;
+
+	ctx->decoded_fmt = *f;
+
+	return 0;
+}
+
+static int tegra_enum_coded_fmt(struct file *file, void *priv,
+				struct v4l2_fmtdesc *f)
+{
+	struct tegra_ctx *ctx = fh_to_tegra_ctx(priv);
+	const struct tegra_vde_soc *soc = ctx->vde->soc;
+
+	if (f->index >= soc->num_coded_fmts)
+		return -EINVAL;
+
+	f->pixelformat = soc->coded_fmts[f->index].fourcc;
+
+	return 0;
+}
+
+static int tegra_g_coded_fmt(struct file *file, void *priv,
+			     struct v4l2_format *f)
+{
+	struct tegra_ctx *ctx = fh_to_tegra_ctx(priv);
+
+	*f = ctx->coded_fmt;
+	return 0;
+}
+
+static const struct tegra_coded_fmt_desc *
+tegra_find_coded_fmt_desc(struct tegra_ctx *ctx, u32 fourcc)
+{
+	const struct tegra_vde_soc *soc = ctx->vde->soc;
+	unsigned int i;
+
+	for (i = 0; i < soc->num_coded_fmts; i++) {
+		if (soc->coded_fmts[i].fourcc == fourcc)
+			return &soc->coded_fmts[i];
+	}
+
+	return NULL;
+}
+
+static int tegra_try_coded_fmt(struct file *file, void *priv,
+			       struct v4l2_format *f)
+{
+	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
+	struct tegra_ctx *ctx = fh_to_tegra_ctx(priv);
+	const struct tegra_vde_soc *soc = ctx->vde->soc;
+	int size = pix_mp->plane_fmt[0].sizeimage;
+	const struct tegra_coded_fmt_desc *desc;
+
+	desc = tegra_find_coded_fmt_desc(ctx, pix_mp->pixelformat);
+	if (!desc) {
+		pix_mp->pixelformat = soc->coded_fmts[0].fourcc;
+		desc = &soc->coded_fmts[0];
+	}
+
+	v4l2_apply_frmsize_constraints(&pix_mp->width,
+				       &pix_mp->height,
+				       &desc->frmsize);
+
+	pix_mp->plane_fmt[0].sizeimage = max(ALIGN(size, SXE_BUFFER), SZ_2M);
+	pix_mp->field = V4L2_FIELD_NONE;
+	pix_mp->num_planes = 1;
+
+	return 0;
+}
+
+static int tegra_s_coded_fmt(struct file *file, void *priv,
+			     struct v4l2_format *f)
+{
+	struct tegra_ctx *ctx = fh_to_tegra_ctx(priv);
+	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
+	const struct tegra_coded_fmt_desc *desc;
+	struct vb2_queue *peer_vq, *vq;
+	struct v4l2_format *cap_fmt;
+	int err;
+
+	/*
+	 * In order to support dynamic resolution change, the decoder admits
+	 * a resolution change, as long as the pixelformat remains. Can't be
+	 * done if streaming.
+	 */
+	vq = v4l2_m2m_get_vq(m2m_ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
+	if (vb2_is_streaming(vq) ||
+	    (vb2_is_busy(vq) &&
+	     f->fmt.pix_mp.pixelformat != ctx->coded_fmt.fmt.pix_mp.pixelformat))
+		return -EBUSY;
+
+	/*
+	 * Since format change on the OUTPUT queue will reset the CAPTURE
+	 * queue, we can't allow doing so when the CAPTURE queue has buffers
+	 * allocated.
+	 */
+	peer_vq = v4l2_m2m_get_vq(m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+	if (vb2_is_busy(peer_vq))
+		return -EBUSY;
+
+	err = tegra_try_coded_fmt(file, priv, f);
+	if (err)
+		return err;
+
+	desc = tegra_find_coded_fmt_desc(ctx, f->fmt.pix_mp.pixelformat);
+	if (!desc)
+		return -EINVAL;
+
+	ctx->coded_fmt_desc = desc;
+	ctx->coded_fmt = *f;
+
+	/*
+	 * Current decoded format might have become invalid with newly
+	 * selected codec, so reset it to default just to be safe and
+	 * keep internal driver state sane. User is mandated to set
+	 * the decoded format again after we return, so we don't need
+	 * anything smarter.
+	 *
+	 * Note that this will propagates any size changes to the decoded format.
+	 */
+	tegra_reset_decoded_fmt(ctx);
+
+	/* propagate colorspace information to capture */
+	cap_fmt = &ctx->decoded_fmt;
+	cap_fmt->fmt.pix_mp.xfer_func = f->fmt.pix_mp.xfer_func;
+	cap_fmt->fmt.pix_mp.ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
+	cap_fmt->fmt.pix_mp.colorspace = f->fmt.pix_mp.colorspace;
+	cap_fmt->fmt.pix_mp.quantization = f->fmt.pix_mp.quantization;
+
+	return 0;
+}
+
+static int tegra_enum_framesizes(struct file *file, void *priv,
+				 struct v4l2_frmsizeenum *fsize)
+{
+	struct tegra_ctx *ctx = fh_to_tegra_ctx(priv);
+	const struct tegra_coded_fmt_desc *fmt;
+
+	if (fsize->index)
+		return -EINVAL;
+
+	fmt = tegra_find_coded_fmt_desc(ctx, fsize->pixel_format);
+	if (!fmt)
+		return -EINVAL;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
+	fsize->stepwise = fmt->frmsize;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops tegra_v4l2_ioctl_ops = {
+	.vidioc_querycap = tegra_querycap,
+	.vidioc_enum_framesizes = tegra_enum_framesizes,
+
+	.vidioc_try_fmt_vid_out_mplane = tegra_try_coded_fmt,
+	.vidioc_g_fmt_vid_out_mplane = tegra_g_coded_fmt,
+	.vidioc_s_fmt_vid_out_mplane = tegra_s_coded_fmt,
+	.vidioc_enum_fmt_vid_out = tegra_enum_coded_fmt,
+
+	.vidioc_try_fmt_vid_cap_mplane = tegra_try_decoded_fmt,
+	.vidioc_g_fmt_vid_cap_mplane = tegra_g_decoded_fmt,
+	.vidioc_s_fmt_vid_cap_mplane = tegra_s_decoded_fmt,
+	.vidioc_enum_fmt_vid_cap = tegra_enum_decoded_fmt,
+
+	.vidioc_reqbufs = v4l2_m2m_ioctl_reqbufs,
+	.vidioc_querybuf = v4l2_m2m_ioctl_querybuf,
+	.vidioc_qbuf = v4l2_m2m_ioctl_qbuf,
+	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
+	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
+	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
+	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
+
+	.vidioc_streamon = v4l2_m2m_ioctl_streamon,
+	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
+
+	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+static int tegra_init_ctrls(struct tegra_ctx *ctx)
+{
+	unsigned int i;
+	int err;
+
+	err = v4l2_ctrl_handler_init(&ctx->hdl, ARRAY_SIZE(ctrl_cfgs));
+	if (err)
+		return err;
+
+	for (i = 0; i < ARRAY_SIZE(ctrl_cfgs); i++) {
+		ctx->ctrls[i] = v4l2_ctrl_new_custom(&ctx->hdl, &ctrl_cfgs[i],
+						     NULL);
+		if (ctx->hdl.error) {
+			err = ctx->hdl.error;
+			goto free_ctrls;
+		}
+	}
+
+	err = v4l2_ctrl_handler_setup(&ctx->hdl);
+	if (err)
+		goto free_ctrls;
+
+	ctx->fh.ctrl_handler = &ctx->hdl;
+
+	return 0;
+
+free_ctrls:
+	v4l2_ctrl_handler_free(&ctx->hdl);
+
+	return err;
+}
+
+static int tegra_init_m2m(struct tegra_ctx *ctx)
+{
+	ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(ctx->vde->m2m,
+					    ctx, tegra_queue_init);
+	if (IS_ERR(ctx->fh.m2m_ctx))
+		return PTR_ERR(ctx->fh.m2m_ctx);
+
+	return 0;
+}
+
+static int tegra_open(struct file *file)
+{
+	struct tegra_vde *vde = video_drvdata(file);
+	struct tegra_ctx *ctx;
+	int err;
+
+	ctx = kzalloc(offsetof(struct tegra_ctx, ctrls[ARRAY_SIZE(ctrl_cfgs)]),
+		      GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->vde = vde;
+	v4l2_fh_init(&ctx->fh, video_devdata(file));
+	INIT_WORK(&ctx->work, tegra_decode_complete);
+
+	err = tegra_init_ctrls(ctx);
+	if (err) {
+		v4l2_err(&vde->v4l2_dev, "failed to add controls: %d\n", err);
+		goto free_ctx;
+	}
+
+	err = tegra_init_m2m(ctx);
+	if (err) {
+		v4l2_err(&vde->v4l2_dev, "failed to initialize m2m: %d\n", err);
+		goto free_ctrls;
+	}
+
+	file->private_data = &ctx->fh;
+	v4l2_fh_add(&ctx->fh);
+
+	tegra_reset_coded_fmt(ctx);
+	tegra_try_coded_fmt(file, file->private_data, &ctx->coded_fmt);
+
+	tegra_reset_decoded_fmt(ctx);
+	tegra_try_decoded_fmt(file, file->private_data, &ctx->decoded_fmt);
+
+	return 0;
+
+free_ctrls:
+	v4l2_ctrl_handler_free(&ctx->hdl);
+free_ctx:
+	kfree(ctx);
+
+	return err;
+}
+
+static int tegra_release(struct file *file)
+{
+	struct v4l2_fh *fh = file->private_data;
+	struct tegra_ctx *ctx = fh_to_tegra_ctx(fh);
+	struct tegra_vde *vde = ctx->vde;
+
+	v4l2_fh_del(fh);
+	v4l2_m2m_ctx_release(fh->m2m_ctx);
+	v4l2_ctrl_handler_free(&ctx->hdl);
+	v4l2_fh_exit(fh);
+	kfree(ctx);
+
+	tegra_vde_dmabuf_cache_unmap_sync(vde);
+
+	return 0;
+}
+
+static const struct v4l2_file_operations tegra_v4l2_fops = {
+	.owner = THIS_MODULE,
+	.open = tegra_open,
+	.poll = v4l2_m2m_fop_poll,
+	.mmap = v4l2_m2m_fop_mmap,
+	.release = tegra_release,
+	.unlocked_ioctl = video_ioctl2,
+};
+
+static void tegra_device_run(void *priv)
+{
+	struct tegra_ctx *ctx = priv;
+	struct vb2_v4l2_buffer *src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	struct media_request *src_req = src->vb2_buf.req_obj.req;
+	int err;
+
+	v4l2_ctrl_request_setup(src_req, &ctx->hdl);
+
+	err = ctx->coded_fmt_desc->decode_run(ctx);
+
+	v4l2_ctrl_request_complete(src_req, &ctx->hdl);
+
+	if (err)
+		tegra_job_finish(ctx, VB2_BUF_STATE_ERROR);
+	else
+		queue_work(ctx->vde->wq, &ctx->work);
+}
+
+static const struct v4l2_m2m_ops tegra_v4l2_m2m_ops = {
+	.device_run = tegra_device_run,
+};
+
+static int tegra_request_validate(struct media_request *req)
+{
+	unsigned int count;
+
+	count = vb2_request_buffer_cnt(req);
+	if (!count)
+		return -ENOENT;
+	else if (count > 1)
+		return -EINVAL;
+
+	return vb2_request_validate(req);
+}
+
+static const struct media_device_ops tegra_media_device_ops = {
+	.req_validate = tegra_request_validate,
+	.req_queue = v4l2_m2m_request_queue,
+};
+
+int tegra_vde_v4l2_init(struct tegra_vde *vde)
+{
+	struct device *dev = vde->dev;
+	int err;
+
+	mutex_init(&vde->v4l2_lock);
+	media_device_init(&vde->mdev);
+	video_set_drvdata(&vde->vdev, vde);
+
+	vde->vdev.lock = &vde->v4l2_lock,
+	vde->vdev.fops = &tegra_v4l2_fops,
+	vde->vdev.vfl_dir = VFL_DIR_M2M,
+	vde->vdev.release = video_device_release_empty,
+	vde->vdev.v4l2_dev = &vde->v4l2_dev;
+	vde->vdev.ioctl_ops = &tegra_v4l2_ioctl_ops,
+	vde->vdev.device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING,
+
+	vde->v4l2_dev.mdev = &vde->mdev;
+	vde->mdev.ops = &tegra_media_device_ops;
+	vde->mdev.dev = dev;
+
+	strscpy(vde->mdev.model, "tegra-vde", sizeof(vde->mdev.model));
+	strscpy(vde->vdev.name,  "tegra-vde", sizeof(vde->vdev.name));
+	strscpy(vde->mdev.bus_info, "platform:tegra-vde",
+		sizeof(vde->mdev.bus_info));
+
+	vde->wq = create_workqueue("tegra-vde");
+	if (!vde->wq)
+		return -ENOMEM;
+
+	err = media_device_register(&vde->mdev);
+	if (err) {
+		dev_err(dev, "failed to register media device: %d\n", err);
+		goto clean_up_media_device;
+	}
+
+	err = v4l2_device_register(dev, &vde->v4l2_dev);
+	if (err) {
+		dev_err(dev, "failed to register v4l2 device: %d\n", err);
+		goto unreg_media_device;
+	}
+
+	err = video_register_device(&vde->vdev, VFL_TYPE_VIDEO, -1);
+	if (err) {
+		dev_err(dev, "failed to register video device: %d\n", err);
+		goto unreg_v4l2;
+	}
+
+	vde->m2m = v4l2_m2m_init(&tegra_v4l2_m2m_ops);
+	err = PTR_ERR_OR_ZERO(vde->m2m);
+	if (err) {
+		dev_err(dev, "failed to initialize m2m device: %d\n", err);
+		goto unreg_video_device;
+	}
+
+	err = v4l2_m2m_register_media_controller(vde->m2m, &vde->vdev,
+						 MEDIA_ENT_F_PROC_VIDEO_DECODER);
+	if (err) {
+		dev_err(dev, "failed to register media controller: %d\n", err);
+		goto release_m2m;
+	}
+
+	v4l2_info(&vde->v4l2_dev, "v4l2 device registered as /dev/video%d\n",
+		  vde->vdev.num);
+
+	return 0;
+
+release_m2m:
+	v4l2_m2m_release(vde->m2m);
+unreg_video_device:
+	video_unregister_device(&vde->vdev);
+unreg_v4l2:
+	v4l2_device_unregister(&vde->v4l2_dev);
+unreg_media_device:
+	media_device_unregister(&vde->mdev);
+clean_up_media_device:
+	media_device_cleanup(&vde->mdev);
+
+	destroy_workqueue(vde->wq);
+
+	return err;
+}
+
+void tegra_vde_v4l2_deinit(struct tegra_vde *vde)
+{
+	v4l2_m2m_unregister_media_controller(vde->m2m);
+	v4l2_m2m_release(vde->m2m);
+
+	video_unregister_device(&vde->vdev);
+	v4l2_device_unregister(&vde->v4l2_dev);
+
+	media_device_unregister(&vde->mdev);
+	media_device_cleanup(&vde->mdev);
+
+	destroy_workqueue(vde->wq);
+}
diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/staging/media/tegra-vde/vde.c
index 36f5595c0fd8..c147d58c3bfb 100644
--- a/drivers/staging/media/tegra-vde/vde.c
+++ b/drivers/staging/media/tegra-vde/vde.c
@@ -53,10 +53,10 @@ void tegra_vde_set_bits(struct tegra_vde *vde, u32 mask,
 	tegra_vde_writel(vde, value | mask, base, offset);
 }
 
-static int tegra_vde_alloc_bo(struct tegra_vde *vde,
-			      struct tegra_vde_bo **ret_bo,
-			      enum dma_data_direction dma_dir,
-			      size_t size)
+int tegra_vde_alloc_bo(struct tegra_vde *vde,
+		       struct tegra_vde_bo **ret_bo,
+		       enum dma_data_direction dma_dir,
+		       size_t size)
 {
 	struct device *dev = vde->miscdev.parent;
 	struct tegra_vde_bo *bo;
@@ -126,7 +126,7 @@ static int tegra_vde_alloc_bo(struct tegra_vde *vde,
 	return err;
 }
 
-static void tegra_vde_free_bo(struct tegra_vde_bo *bo)
+void tegra_vde_free_bo(struct tegra_vde_bo *bo)
 {
 	struct tegra_vde *vde = bo->vde;
 	struct device *dev = vde->miscdev.parent;
@@ -332,6 +332,8 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 
 		dpb_frames[i].flags = frames[i].flags;
 		dpb_frames[i].frame_num = frames[i].frame_num;
+		dpb_frames[i].luma_atoms_pitch = ctx.pic_width_in_mbs;
+		dpb_frames[i].chroma_atoms_pitch = cstride / VDE_ATOM;
 
 		dma_dir = (i == 0) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
 
@@ -626,8 +628,16 @@ static int tegra_vde_probe(struct platform_device *pdev)
 		goto err_free_secure_bo;
 	}
 
+	err = tegra_vde_v4l2_init(vde);
+	if (err) {
+		dev_err(dev, "Failed to initialize V4L2: %d\n", err);
+		goto misc_unreg;
+	}
+
 	return 0;
 
+misc_unreg:
+	misc_deregister(&vde->miscdev);
 err_free_secure_bo:
 	tegra_vde_free_bo(vde->secure_bo);
 err_pm_runtime:
@@ -648,6 +658,7 @@ static int tegra_vde_remove(struct platform_device *pdev)
 	struct tegra_vde *vde = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 
+	tegra_vde_v4l2_deinit(vde);
 	misc_deregister(&vde->miscdev);
 
 	tegra_vde_free_bo(vde->secure_bo);
@@ -722,20 +733,73 @@ static const struct dev_pm_ops tegra_vde_pm_ops = {
 				tegra_vde_pm_resume)
 };
 
+static const u32 tegra124_decoded_fmts[] = {
+	/* TBD: T124 supports only a non-standard Tegra tiled format */
+};
+
+static const struct tegra_coded_fmt_desc tegra124_coded_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_H264_SLICE,
+		.frmsize = {
+			.min_width = 16,
+			.max_width = 1920,
+			.step_width = 16,
+			.min_height = 16,
+			.max_height = 2032,
+			.step_height = 16,
+		},
+		.num_decoded_fmts = ARRAY_SIZE(tegra124_decoded_fmts),
+		.decoded_fmts = tegra124_decoded_fmts,
+		.decode_run = tegra_vde_h264_decode_run,
+		.decode_wait = tegra_vde_h264_decode_wait,
+	},
+};
+
+static const u32 tegra20_decoded_fmts[] = {
+	V4L2_PIX_FMT_YUV420M,
+	V4L2_PIX_FMT_YVU420M,
+};
+
+static const struct tegra_coded_fmt_desc tegra20_coded_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_H264_SLICE,
+		.frmsize = {
+			.min_width = 16,
+			.max_width = 1920,
+			.step_width = 16,
+			.min_height = 16,
+			.max_height = 2032,
+			.step_height = 16,
+		},
+		.num_decoded_fmts = ARRAY_SIZE(tegra20_decoded_fmts),
+		.decoded_fmts = tegra20_decoded_fmts,
+		.decode_run = tegra_vde_h264_decode_run,
+		.decode_wait = tegra_vde_h264_decode_wait,
+	},
+};
+
 static const struct tegra_vde_soc tegra124_vde_soc = {
 	.supports_ref_pic_marking = true,
+	.coded_fmts = tegra124_coded_fmts,
+	.num_coded_fmts = ARRAY_SIZE(tegra124_coded_fmts),
 };
 
 static const struct tegra_vde_soc tegra114_vde_soc = {
 	.supports_ref_pic_marking = true,
+	.coded_fmts = tegra20_coded_fmts,
+	.num_coded_fmts = ARRAY_SIZE(tegra20_coded_fmts),
 };
 
 static const struct tegra_vde_soc tegra30_vde_soc = {
 	.supports_ref_pic_marking = false,
+	.coded_fmts = tegra20_coded_fmts,
+	.num_coded_fmts = ARRAY_SIZE(tegra20_coded_fmts),
 };
 
 static const struct tegra_vde_soc tegra20_vde_soc = {
 	.supports_ref_pic_marking = false,
+	.coded_fmts = tegra20_coded_fmts,
+	.num_coded_fmts = ARRAY_SIZE(tegra20_coded_fmts),
 };
 
 static const struct of_device_id tegra_vde_of_match[] = {
diff --git a/drivers/staging/media/tegra-vde/vde.h b/drivers/staging/media/tegra-vde/vde.h
index 8ba6a71e3e40..4c646f47b7c8 100644
--- a/drivers/staging/media/tegra-vde/vde.h
+++ b/drivers/staging/media/tegra-vde/vde.h
@@ -15,6 +15,16 @@
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <media/media-device.h>
+#include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-dma-sg.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mem2mem.h>
 
 #define ICMDQUE_WR		0x00
 #define CMDQUE_CONTROL		0x08
@@ -25,9 +35,15 @@
 #define BSE_ICMDQUE_EMPTY	BIT(3)
 #define BSE_DMA_BUSY		BIT(23)
 
+#define BSEV_ALIGN		SZ_1
+#define FRAMEID_ALIGN		SZ_256
+#define SXE_BUFFER		SZ_32K
+#define VDE_ATOM		SZ_16
+
 struct clk;
 struct dma_buf;
 struct gen_pool;
+struct tegra_ctx;
 struct iommu_group;
 struct iommu_domain;
 struct reset_control;
@@ -46,10 +62,23 @@ struct tegra_video_frame {
 	dma_addr_t aux_addr;
 	u32 frame_num;
 	u32 flags;
+	u32 luma_atoms_pitch;
+	u32 chroma_atoms_pitch;
+};
+
+struct tegra_coded_fmt_desc {
+	u32 fourcc;
+	struct v4l2_frmsize_stepwise frmsize;
+	unsigned int num_decoded_fmts;
+	const u32 *decoded_fmts;
+	int (*decode_run)(struct tegra_ctx *ctx);
+	int (*decode_wait)(struct tegra_ctx *ctx);
 };
 
 struct tegra_vde_soc {
 	bool supports_ref_pic_marking;
+	const struct tegra_coded_fmt_desc *coded_fmts;
+	u32 num_coded_fmts;
 };
 
 struct tegra_vde_bo {
@@ -94,8 +123,59 @@ struct tegra_vde {
 	dma_addr_t bitstream_data_addr;
 	dma_addr_t iram_lists_addr;
 	u32 *iram;
+	struct v4l2_device v4l2_dev;
+	struct v4l2_m2m_dev *m2m;
+	struct media_device mdev;
+	struct video_device vdev;
+	struct mutex v4l2_lock;
+	struct workqueue_struct *wq;
+	struct tegra_video_frame frames[V4L2_H264_NUM_DPB_ENTRIES + 1];
+};
+
+int tegra_vde_alloc_bo(struct tegra_vde *vde,
+		       struct tegra_vde_bo **ret_bo,
+		       enum dma_data_direction dma_dir,
+		       size_t size);
+void tegra_vde_free_bo(struct tegra_vde_bo *bo);
+
+struct tegra_ctx_h264 {
+	const struct v4l2_ctrl_h264_decode_params *decode_params;
+	const struct v4l2_ctrl_h264_sps *sps;
+	const struct v4l2_ctrl_h264_pps *pps;
+};
+
+struct tegra_ctx {
+	struct tegra_vde *vde;
+	struct tegra_ctx_h264 h264;
+	struct work_struct work;
+	struct v4l2_fh fh;
+	struct v4l2_ctrl_handler hdl;
+	struct v4l2_format coded_fmt;
+	struct v4l2_format decoded_fmt;
+	const struct tegra_coded_fmt_desc *coded_fmt_desc;
+	struct v4l2_ctrl *ctrls[];
+};
+
+struct tegra_m2m_buffer {
+	struct v4l2_m2m_buffer m2m;
+	struct dma_buf_attachment *a[VB2_MAX_PLANES];
+	dma_addr_t dma_base[VB2_MAX_PLANES];
+	dma_addr_t dma_addr[VB2_MAX_PLANES];
+	struct iova *iova[VB2_MAX_PLANES];
+	struct tegra_vde_bo *aux;
 };
 
+static inline struct tegra_m2m_buffer *
+vb_to_tegra_buf(struct vb2_buffer *vb)
+{
+	struct v4l2_m2m_buffer *m2m = container_of(vb, struct v4l2_m2m_buffer,
+						   vb.vb2_buf);
+
+	return container_of(m2m, struct tegra_m2m_buffer, m2m);
+}
+
+void tegra_vde_prepare_control_data(struct tegra_ctx *ctx, u32 id);
+
 void tegra_vde_writel(struct tegra_vde *vde, u32 value, void __iomem *base,
 		      u32 offset);
 u32 tegra_vde_readl(struct tegra_vde *vde, void __iomem *base, u32 offset);
@@ -111,6 +191,8 @@ int tegra_vde_decode_h264(struct tegra_vde *vde,
 			  struct tegra_video_frame *dpb_frames,
 			  dma_addr_t bitstream_data_addr,
 			  size_t bitstream_data_size);
+int tegra_vde_h264_decode_run(struct tegra_ctx *ctx);
+int tegra_vde_h264_decode_wait(struct tegra_ctx *ctx);
 
 int tegra_vde_iommu_init(struct tegra_vde *vde);
 void tegra_vde_iommu_deinit(struct tegra_vde *vde);
@@ -164,4 +246,7 @@ tegra_vde_reg_base_name(struct tegra_vde *vde, void __iomem *base)
 	return "???";
 }
 
+int tegra_vde_v4l2_init(struct tegra_vde *vde);
+void tegra_vde_v4l2_deinit(struct tegra_vde *vde);
+
 #endif /* TEGRA_VDE_H */
-- 
2.33.1

