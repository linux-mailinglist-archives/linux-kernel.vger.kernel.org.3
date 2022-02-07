Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEA24AC1C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383081AbiBGOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356741AbiBGOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:20:27 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC604C0401C1;
        Mon,  7 Feb 2022 06:20:25 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o12so27091446lfg.12;
        Mon, 07 Feb 2022 06:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gSi+JnFUcMxH+thg7c07KEbycAW5CMH/rd67OUchC/4=;
        b=CjGMRljSrF0P+xIKS/NwdyKR5Bs5F3Th/X0j+lHl6dE2FNw1PCBRhxlb2tEfHM1DXz
         OhB1w+xdpg5Yt8PrlSRni1rl3MRxyEpRfmXKothRGOLtbmEUvpXZxrqhOSWW3pf3sYaS
         V2Y6XdlGLER2n6HTs3BS/v+hYIYbj+vf9SshFqCgDZX4fAYKGqb9icmjUXdmXGtqiLTg
         JGbTYwzqdXBqoTf+CLJyMxbBLtxjAg8jDOvSEluzK1Hy+Qmy2EFj3XHYm/b9vVcQ8ar7
         NCxWFl+wpTYSaDHzK11M5MtidEuEHPZ+KckI6Y/1YF40bzq8VbvDTWsxpXb1Sm6dk9xz
         woEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gSi+JnFUcMxH+thg7c07KEbycAW5CMH/rd67OUchC/4=;
        b=QcDCOoLnRr/c9z2KYdDq6Q/RRvwtR2F0dEJkHqA2QvK2XKDRxhLqJP5jlCIOJYlzUT
         QXcqNu7huV4TjizKzBCCicxtDWI6kAVO6LrF24yxB5SVBVrxOGHcMmJMbKjH5nl/i3Qj
         hdhG8yhOw9FU6sgo/ViLcJMyr+aLyoC1B2q2KMAhhF4zhWdC1RmntMLJDPNxgez1HjMN
         8hD3++NWIO5RSkxiYjBI8wwzG8W4oFQO4DBfWQI3qJIK+tC9GPk+m37atoU8Tl99u3YT
         VFDCRApwpV69rvi52FAtUfaSMWUGhs46bJHtd/0NCqcf1y8ZrglAK7oEy8eipFWpuCf7
         pRHA==
X-Gm-Message-State: AOAM532arR6glnzW+MWXUD647LWRfOb/qWgq3aUEOXHi5rVLHVdjxQp4
        tJwKH4lvsl68HEQC36QcrL8=
X-Google-Smtp-Source: ABdhPJz51tWBx0HGufKvMLmNtslwwFWl1SdvyCgMvYz1uvyPk93nEuVJUuAS5OHEeCsqIUavbltPFA==
X-Received: by 2002:a05:6512:2821:: with SMTP id cf33mr8499704lfb.37.1644243624149;
        Mon, 07 Feb 2022 06:20:24 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id t13sm1515599lfl.94.2022.02.07.06.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 06:20:23 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] media: staging: tegra-vde: Remove legacy UAPI support
Date:   Mon,  7 Feb 2022 17:19:37 +0300
Message-Id: <20220207141937.13089-5-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207141937.13089-1-digetx@gmail.com>
References: <20220207141937.13089-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy UAPI became unnecessary with the V4L stateless decoder API
support addition to the Tegra decoder driver. Remove legacy UAPI support.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../staging/media/tegra-vde/dmabuf-cache.c    |   2 +-
 drivers/staging/media/tegra-vde/h264.c        |  61 ++--
 drivers/staging/media/tegra-vde/iommu.c       |   2 +-
 drivers/staging/media/tegra-vde/uapi.h        |  73 -----
 drivers/staging/media/tegra-vde/vde.c         | 283 +-----------------
 drivers/staging/media/tegra-vde/vde.h         |  11 -
 6 files changed, 35 insertions(+), 397 deletions(-)
 delete mode 100644 drivers/staging/media/tegra-vde/uapi.h

diff --git a/drivers/staging/media/tegra-vde/dmabuf-cache.c b/drivers/staging/media/tegra-vde/dmabuf-cache.c
index a98d03419b8f..69c346148070 100644
--- a/drivers/staging/media/tegra-vde/dmabuf-cache.c
+++ b/drivers/staging/media/tegra-vde/dmabuf-cache.c
@@ -66,9 +66,9 @@ int tegra_vde_dmabuf_cache_map(struct tegra_vde *vde,
 			       struct dma_buf_attachment **ap,
 			       dma_addr_t *addrp)
 {
-	struct device *dev = vde->miscdev.parent;
 	struct dma_buf_attachment *attachment;
 	struct tegra_vde_cache_entry *entry;
+	struct device *dev = vde->dev;
 	struct sg_table *sgt;
 	struct iova *iova;
 	int err;
diff --git a/drivers/staging/media/tegra-vde/h264.c b/drivers/staging/media/tegra-vde/h264.c
index cbf27f0cfdb1..a46c648a26c6 100644
--- a/drivers/staging/media/tegra-vde/h264.c
+++ b/drivers/staging/media/tegra-vde/h264.c
@@ -14,9 +14,36 @@
 #include <media/v4l2-h264.h>
 
 #include "trace.h"
-#include "uapi.h"
 #include "vde.h"
 
+#define FLAG_B_FRAME		0x1
+#define FLAG_REFERENCE		0x2
+
+struct tegra_vde_h264_frame {
+	unsigned int frame_num;
+	unsigned int flags;
+};
+
+struct tegra_vde_h264_decoder_ctx {
+	unsigned int dpb_frames_nb;
+	unsigned int dpb_ref_frames_with_earlier_poc_nb;
+	unsigned int baseline_profile;
+	unsigned int level_idc;
+	unsigned int log2_max_pic_order_cnt_lsb;
+	unsigned int log2_max_frame_num;
+	unsigned int pic_order_cnt_type;
+	unsigned int direct_8x8_inference_flag;
+	unsigned int pic_width_in_mbs;
+	unsigned int pic_height_in_mbs;
+	unsigned int pic_init_qp;
+	unsigned int deblocking_filter_control_present_flag;
+	unsigned int constrained_intra_pred_flag;
+	unsigned int chroma_qp_index_offset;
+	unsigned int pic_order_present_flag;
+	unsigned int num_ref_idx_l0_active_minus1;
+	unsigned int num_ref_idx_l1_active_minus1;
+};
+
 struct h264_reflists {
 	u8 p[V4L2_H264_NUM_DPB_ENTRIES];
 	u8 b0[V4L2_H264_NUM_DPB_ENTRIES];
@@ -438,19 +465,8 @@ static void tegra_vde_decode_frame(struct tegra_vde *vde,
 			 vde->sxe, 0x00);
 }
 
-int tegra_vde_validate_h264_frame(struct device *dev,
-				  struct tegra_vde_h264_frame *frame)
-{
-	if (frame->frame_num > 0x7FFFFF) {
-		dev_err(dev, "Bad frame_num %u\n", frame->frame_num);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-int tegra_vde_validate_h264_ctx(struct device *dev,
-				struct tegra_vde_h264_decoder_ctx *ctx)
+static int tegra_vde_validate_h264_ctx(struct device *dev,
+				       struct tegra_vde_h264_decoder_ctx *ctx)
 {
 	if (ctx->dpb_frames_nb == 0 || ctx->dpb_frames_nb > 17) {
 		dev_err(dev, "Bad DPB size %u\n", ctx->dpb_frames_nb);
@@ -637,23 +653,6 @@ static int tegra_vde_decode_end(struct tegra_vde *vde)
 	return ret;
 }
 
-int tegra_vde_decode_h264(struct tegra_vde *vde,
-			  struct tegra_vde_h264_decoder_ctx *ctx,
-			  struct tegra_video_frame *dpb_frames,
-			  dma_addr_t bitstream_data_addr,
-			  size_t bitstream_data_size)
-{
-	int err;
-
-	err = tegra_vde_decode_begin(vde, ctx, dpb_frames,
-				     bitstream_data_addr,
-				     bitstream_data_size);
-	if (err)
-		return err;
-
-	return tegra_vde_decode_end(vde);
-}
-
 static struct vb2_buffer *get_ref_buf(struct tegra_ctx *ctx,
 				      struct vb2_v4l2_buffer *dst,
 				      unsigned int dpb_idx)
diff --git a/drivers/staging/media/tegra-vde/iommu.c b/drivers/staging/media/tegra-vde/iommu.c
index adf8dc7ee25c..5521ed3e465f 100644
--- a/drivers/staging/media/tegra-vde/iommu.c
+++ b/drivers/staging/media/tegra-vde/iommu.c
@@ -60,7 +60,7 @@ void tegra_vde_iommu_unmap(struct tegra_vde *vde, struct iova *iova)
 
 int tegra_vde_iommu_init(struct tegra_vde *vde)
 {
-	struct device *dev = vde->miscdev.parent;
+	struct device *dev = vde->dev;
 	struct iova *iova;
 	unsigned long order;
 	unsigned long shift;
diff --git a/drivers/staging/media/tegra-vde/uapi.h b/drivers/staging/media/tegra-vde/uapi.h
deleted file mode 100644
index ffb4983e5bb6..000000000000
--- a/drivers/staging/media/tegra-vde/uapi.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/* Copyright (C) 2016-2017 Dmitry Osipenko <digetx@gmail.com> */
-#ifndef _UAPI_TEGRA_VDE_H_
-#define _UAPI_TEGRA_VDE_H_
-
-#include <linux/types.h>
-#include <asm/ioctl.h>
-
-#define FLAG_B_FRAME		0x1
-#define FLAG_REFERENCE		0x2
-
-struct tegra_vde_h264_frame {
-	__s32 y_fd;
-	__s32 cb_fd;
-	__s32 cr_fd;
-	__s32 aux_fd;
-	__u32 y_offset;
-	__u32 cb_offset;
-	__u32 cr_offset;
-	__u32 aux_offset;
-	__u32 frame_num;
-	__u32 flags;
-
-	// Must be zero'ed
-	__u32 reserved[6];
-};
-
-struct tegra_vde_h264_decoder_ctx {
-	__s32 bitstream_data_fd;
-	__u32 bitstream_data_offset;
-
-	__u64 dpb_frames_ptr;
-	__u32 dpb_frames_nb;
-	__u32 dpb_ref_frames_with_earlier_poc_nb;
-
-	// SPS
-	__u32 baseline_profile;
-	__u32 level_idc;
-	__u32 log2_max_pic_order_cnt_lsb;
-	__u32 log2_max_frame_num;
-	__u32 pic_order_cnt_type;
-	__u32 direct_8x8_inference_flag;
-	__u32 pic_width_in_mbs;
-	__u32 pic_height_in_mbs;
-
-	// PPS
-	__u32 pic_init_qp;
-	__u32 deblocking_filter_control_present_flag;
-	__u32 constrained_intra_pred_flag;
-	__u32 chroma_qp_index_offset;
-	__u32 pic_order_present_flag;
-
-	// Slice header
-	__u32 num_ref_idx_l0_active_minus1;
-	__u32 num_ref_idx_l1_active_minus1;
-
-	// Must be zero'ed
-	__u32 reserved[11];
-};
-
-#define VDE_IOCTL_BASE			('v' + 0x20)
-
-#define VDE_IO(nr)			_IO(VDE_IOCTL_BASE, nr)
-#define VDE_IOR(nr, type)		_IOR(VDE_IOCTL_BASE, nr, type)
-#define VDE_IOW(nr, type)		_IOW(VDE_IOCTL_BASE, nr, type)
-#define VDE_IOWR(nr, type)		_IOWR(VDE_IOCTL_BASE, nr, type)
-
-#define TEGRA_VDE_DECODE_H264		0x00
-
-#define TEGRA_VDE_IOCTL_DECODE_H264	\
-	VDE_IOW(TEGRA_VDE_DECODE_H264, struct tegra_vde_h264_decoder_ctx)
-
-#endif // _UAPI_TEGRA_VDE_H_
diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/staging/media/tegra-vde/vde.c
index c147d58c3bfb..f3e863a94c5a 100644
--- a/drivers/staging/media/tegra-vde/vde.c
+++ b/drivers/staging/media/tegra-vde/vde.c
@@ -11,7 +11,6 @@
 #include <linux/genalloc.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
-#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
@@ -22,7 +21,6 @@
 #include <soc/tegra/common.h>
 #include <soc/tegra/pmc.h>
 
-#include "uapi.h"
 #include "vde.h"
 
 #define CREATE_TRACE_POINTS
@@ -58,7 +56,7 @@ int tegra_vde_alloc_bo(struct tegra_vde *vde,
 		       enum dma_data_direction dma_dir,
 		       size_t size)
 {
-	struct device *dev = vde->miscdev.parent;
+	struct device *dev = vde->dev;
 	struct tegra_vde_bo *bo;
 	int err;
 
@@ -129,7 +127,7 @@ int tegra_vde_alloc_bo(struct tegra_vde *vde,
 void tegra_vde_free_bo(struct tegra_vde_bo *bo)
 {
 	struct tegra_vde *vde = bo->vde;
-	struct device *dev = vde->miscdev.parent;
+	struct device *dev = vde->dev;
 
 	if (vde->domain)
 		tegra_vde_iommu_unmap(vde, bo->iova);
@@ -143,266 +141,6 @@ void tegra_vde_free_bo(struct tegra_vde_bo *bo)
 	kfree(bo);
 }
 
-static int tegra_vde_attach_dmabuf(struct tegra_vde *vde,
-				   int fd,
-				   unsigned long offset,
-				   size_t min_size,
-				   size_t align_size,
-				   struct dma_buf_attachment **a,
-				   dma_addr_t *addrp,
-				   size_t *size,
-				   enum dma_data_direction dma_dir)
-{
-	struct device *dev = vde->miscdev.parent;
-	struct dma_buf *dmabuf;
-	int err;
-
-	dmabuf = dma_buf_get(fd);
-	if (IS_ERR(dmabuf)) {
-		dev_err(dev, "Invalid dmabuf FD\n");
-		return PTR_ERR(dmabuf);
-	}
-
-	if (dmabuf->size & (align_size - 1)) {
-		dev_err(dev, "Unaligned dmabuf 0x%zX, should be aligned to 0x%zX\n",
-			dmabuf->size, align_size);
-		return -EINVAL;
-	}
-
-	if ((u64)offset + min_size > dmabuf->size) {
-		dev_err(dev, "Too small dmabuf size %zu @0x%lX, should be at least %zu\n",
-			dmabuf->size, offset, min_size);
-		return -EINVAL;
-	}
-
-	err = tegra_vde_dmabuf_cache_map(vde, dmabuf, dma_dir, a, addrp);
-	if (err)
-		goto err_put;
-
-	*addrp = *addrp + offset;
-
-	if (size)
-		*size = dmabuf->size - offset;
-
-	return 0;
-
-err_put:
-	dma_buf_put(dmabuf);
-
-	return err;
-}
-
-static int tegra_vde_attach_dmabufs_to_frame(struct tegra_vde *vde,
-					     struct tegra_video_frame *frame,
-					     struct tegra_vde_h264_frame *src,
-					     enum dma_data_direction dma_dir,
-					     bool baseline_profile,
-					     size_t lsize, size_t csize)
-{
-	int err;
-
-	err = tegra_vde_attach_dmabuf(vde, src->y_fd,
-				      src->y_offset, lsize, SZ_256,
-				      &frame->y_dmabuf_attachment,
-				      &frame->y_addr,
-				      NULL, dma_dir);
-	if (err)
-		return err;
-
-	err = tegra_vde_attach_dmabuf(vde, src->cb_fd,
-				      src->cb_offset, csize, SZ_256,
-				      &frame->cb_dmabuf_attachment,
-				      &frame->cb_addr,
-				      NULL, dma_dir);
-	if (err)
-		goto err_release_y;
-
-	err = tegra_vde_attach_dmabuf(vde, src->cr_fd,
-				      src->cr_offset, csize, SZ_256,
-				      &frame->cr_dmabuf_attachment,
-				      &frame->cr_addr,
-				      NULL, dma_dir);
-	if (err)
-		goto err_release_cb;
-
-	if (baseline_profile) {
-		frame->aux_addr = 0x64DEAD00;
-		return 0;
-	}
-
-	err = tegra_vde_attach_dmabuf(vde, src->aux_fd,
-				      src->aux_offset, csize, SZ_256,
-				      &frame->aux_dmabuf_attachment,
-				      &frame->aux_addr,
-				      NULL, dma_dir);
-	if (err)
-		goto err_release_cr;
-
-	return 0;
-
-err_release_cr:
-	tegra_vde_dmabuf_cache_unmap(vde, frame->cr_dmabuf_attachment, true);
-err_release_cb:
-	tegra_vde_dmabuf_cache_unmap(vde, frame->cb_dmabuf_attachment, true);
-err_release_y:
-	tegra_vde_dmabuf_cache_unmap(vde, frame->y_dmabuf_attachment, true);
-
-	return err;
-}
-
-static void tegra_vde_release_frame_dmabufs(struct tegra_vde *vde,
-					    struct tegra_video_frame *frame,
-					    enum dma_data_direction dma_dir,
-					    bool baseline_profile,
-					    bool release)
-{
-	if (!baseline_profile)
-		tegra_vde_dmabuf_cache_unmap(vde, frame->aux_dmabuf_attachment,
-					     release);
-
-	tegra_vde_dmabuf_cache_unmap(vde, frame->cr_dmabuf_attachment, release);
-	tegra_vde_dmabuf_cache_unmap(vde, frame->cb_dmabuf_attachment, release);
-	tegra_vde_dmabuf_cache_unmap(vde, frame->y_dmabuf_attachment, release);
-}
-
-static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
-				       unsigned long vaddr)
-{
-	struct dma_buf_attachment *bitstream_data_dmabuf_attachment;
-	struct tegra_vde_h264_frame __user *frames_user;
-	size_t bitstream_data_size, lsize, csize;
-	struct device *dev = vde->miscdev.parent;
-	struct tegra_vde_h264_decoder_ctx ctx;
-	struct tegra_video_frame *dpb_frames;
-	struct tegra_vde_h264_frame *frames;
-	enum dma_data_direction dma_dir;
-	dma_addr_t bitstream_data_addr;
-	unsigned int macroblocks_nb;
-	unsigned int cstride;
-	unsigned int i;
-	int ret;
-
-	if (copy_from_user(&ctx, (void __user *)vaddr, sizeof(ctx)))
-		return -EFAULT;
-
-	ret = tegra_vde_validate_h264_ctx(dev, &ctx);
-	if (ret)
-		return ret;
-
-	ret = tegra_vde_attach_dmabuf(vde, ctx.bitstream_data_fd,
-				      ctx.bitstream_data_offset,
-				      SZ_16K, SZ_16K,
-				      &bitstream_data_dmabuf_attachment,
-				      &bitstream_data_addr,
-				      &bitstream_data_size,
-				      DMA_TO_DEVICE);
-	if (ret)
-		return ret;
-
-	frames = kmalloc_array(ctx.dpb_frames_nb, sizeof(*frames), GFP_KERNEL);
-	if (!frames) {
-		ret = -ENOMEM;
-		goto release_bitstream_dmabuf;
-	}
-
-	dpb_frames = kcalloc(ctx.dpb_frames_nb, sizeof(*dpb_frames),
-			     GFP_KERNEL);
-	if (!dpb_frames) {
-		ret = -ENOMEM;
-		goto free_frames;
-	}
-
-	macroblocks_nb = ctx.pic_width_in_mbs * ctx.pic_height_in_mbs;
-	frames_user = u64_to_user_ptr(ctx.dpb_frames_ptr);
-
-	if (copy_from_user(frames, frames_user,
-			   ctx.dpb_frames_nb * sizeof(*frames))) {
-		ret = -EFAULT;
-		goto free_dpb_frames;
-	}
-
-	cstride = ALIGN(ctx.pic_width_in_mbs * 8, 16);
-	csize = cstride * ctx.pic_height_in_mbs * 8;
-	lsize = macroblocks_nb * 256;
-
-	for (i = 0; i < ctx.dpb_frames_nb; i++) {
-		ret = tegra_vde_validate_h264_frame(dev, &frames[i]);
-		if (ret)
-			goto release_dpb_frames;
-
-		dpb_frames[i].flags = frames[i].flags;
-		dpb_frames[i].frame_num = frames[i].frame_num;
-		dpb_frames[i].luma_atoms_pitch = ctx.pic_width_in_mbs;
-		dpb_frames[i].chroma_atoms_pitch = cstride / VDE_ATOM;
-
-		dma_dir = (i == 0) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
-
-		ret = tegra_vde_attach_dmabufs_to_frame(vde, &dpb_frames[i],
-							&frames[i], dma_dir,
-							ctx.baseline_profile,
-							lsize, csize);
-		if (ret)
-			goto release_dpb_frames;
-	}
-
-	ret = tegra_vde_decode_h264(vde, &ctx, dpb_frames,
-				    bitstream_data_addr, bitstream_data_size);
-
-release_dpb_frames:
-	while (i--) {
-		dma_dir = (i == 0) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
-
-		tegra_vde_release_frame_dmabufs(vde, &dpb_frames[i], dma_dir,
-						ctx.baseline_profile, ret != 0);
-	}
-
-free_dpb_frames:
-	kfree(dpb_frames);
-
-free_frames:
-	kfree(frames);
-
-release_bitstream_dmabuf:
-	tegra_vde_dmabuf_cache_unmap(vde, bitstream_data_dmabuf_attachment,
-				     ret != 0);
-
-	return ret;
-}
-
-static long tegra_vde_unlocked_ioctl(struct file *filp,
-				     unsigned int cmd, unsigned long arg)
-{
-	struct miscdevice *miscdev = filp->private_data;
-	struct tegra_vde *vde = container_of(miscdev, struct tegra_vde,
-					     miscdev);
-
-	switch (cmd) {
-	case TEGRA_VDE_IOCTL_DECODE_H264:
-		return tegra_vde_ioctl_decode_h264(vde, arg);
-	}
-
-	dev_err(miscdev->parent, "Invalid IOCTL command %u\n", cmd);
-
-	return -ENOTTY;
-}
-
-static int tegra_vde_release_file(struct inode *inode, struct file *filp)
-{
-	struct miscdevice *miscdev = filp->private_data;
-	struct tegra_vde *vde = container_of(miscdev, struct tegra_vde,
-					     miscdev);
-
-	tegra_vde_dmabuf_cache_unmap_sync(vde);
-
-	return 0;
-}
-
-static const struct file_operations tegra_vde_fops = {
-	.owner		= THIS_MODULE,
-	.unlocked_ioctl	= tegra_vde_unlocked_ioctl,
-	.release	= tegra_vde_release_file,
-};
-
 static irqreturn_t tegra_vde_isr(int irq, void *data)
 {
 	struct tegra_vde *vde = data;
@@ -590,11 +328,6 @@ static int tegra_vde_probe(struct platform_device *pdev)
 	mutex_init(&vde->lock);
 	init_completion(&vde->decode_completion);
 
-	vde->miscdev.minor = MISC_DYNAMIC_MINOR;
-	vde->miscdev.name = "tegra_vde";
-	vde->miscdev.fops = &tegra_vde_fops;
-	vde->miscdev.parent = dev;
-
 	err = tegra_vde_iommu_init(vde);
 	if (err) {
 		dev_err(dev, "Failed to initialize IOMMU: %d\n", err);
@@ -622,22 +355,14 @@ static int tegra_vde_probe(struct platform_device *pdev)
 		goto err_pm_runtime;
 	}
 
-	err = misc_register(&vde->miscdev);
-	if (err) {
-		dev_err(dev, "Failed to register misc device: %d\n", err);
-		goto err_free_secure_bo;
-	}
-
 	err = tegra_vde_v4l2_init(vde);
 	if (err) {
 		dev_err(dev, "Failed to initialize V4L2: %d\n", err);
-		goto misc_unreg;
+		goto err_free_secure_bo;
 	}
 
 	return 0;
 
-misc_unreg:
-	misc_deregister(&vde->miscdev);
 err_free_secure_bo:
 	tegra_vde_free_bo(vde->secure_bo);
 err_pm_runtime:
@@ -659,8 +384,6 @@ static int tegra_vde_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 
 	tegra_vde_v4l2_deinit(vde);
-	misc_deregister(&vde->miscdev);
-
 	tegra_vde_free_bo(vde->secure_bo);
 
 	/*
diff --git a/drivers/staging/media/tegra-vde/vde.h b/drivers/staging/media/tegra-vde/vde.h
index e0396bb0b986..0fbb1f3d2c88 100644
--- a/drivers/staging/media/tegra-vde/vde.h
+++ b/drivers/staging/media/tegra-vde/vde.h
@@ -12,7 +12,6 @@
 #include <linux/dma-direction.h>
 #include <linux/iova.h>
 #include <linux/list.h>
-#include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -107,7 +106,6 @@ struct tegra_vde {
 	struct mutex lock;
 	struct mutex map_lock;
 	struct list_head map_list;
-	struct miscdevice miscdev;
 	struct reset_control *rst;
 	struct reset_control *rst_mc;
 	struct gen_pool *iram_pool;
@@ -183,15 +181,6 @@ u32 tegra_vde_readl(struct tegra_vde *vde, void __iomem *base, u32 offset);
 void tegra_vde_set_bits(struct tegra_vde *vde, u32 mask, void __iomem *base,
 			u32 offset);
 
-int tegra_vde_validate_h264_frame(struct device *dev,
-				  struct tegra_vde_h264_frame *frame);
-int tegra_vde_validate_h264_ctx(struct device *dev,
-				struct tegra_vde_h264_decoder_ctx *ctx);
-int tegra_vde_decode_h264(struct tegra_vde *vde,
-			  struct tegra_vde_h264_decoder_ctx *ctx,
-			  struct tegra_video_frame *dpb_frames,
-			  dma_addr_t bitstream_data_addr,
-			  size_t bitstream_data_size);
 int tegra_vde_h264_decode_run(struct tegra_ctx *ctx);
 int tegra_vde_h264_decode_wait(struct tegra_ctx *ctx);
 
-- 
2.34.1

