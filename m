Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0EA48FE8F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 19:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiAPS4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 13:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiAPS4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 13:56:41 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1555C061574;
        Sun, 16 Jan 2022 10:56:40 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o12so32801292lfu.12;
        Sun, 16 Jan 2022 10:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PIdAnBY4fbixuPBMwnIS6fyqG8Ugotl/tbo+/X7Aryc=;
        b=anDIgKXr5OCl9tpKwElTwcQuukvwoZSeS7c1qDVPlb0ouFKnW9ZOq/49W//qrWfF9F
         b9XVBRezrAt4XM+OYMhk+DK3VZZp3+q0kvnWC0/CGlVp0pRFvBFxnRbs1q4WbmaJZbTh
         pfDhv7Bo3NTVC4V8e3ViuSbthmL4j3whneT/4GXDFvoKvKZ4nTNxXFsqp7tBtfDvKjC7
         iK9BsL58Hh8Q4TfyZ66Hf/YZl/TII702OYcGhgyx/kLNu/NhtSIJUtvKHa/Hurkhpgr1
         AYhAtI+iTTjsupgnrCyo5Fw8xyCJi+zrG8haWT6ZQBZ9QWgyHWqDyz8ieyGGAZ9JatT4
         5VEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIdAnBY4fbixuPBMwnIS6fyqG8Ugotl/tbo+/X7Aryc=;
        b=lcN8XR0VazHPVegyi9uQv7CurFs0g00ePI9mKJYYzbosRc2ywrkgpCURNufsaCuHSt
         8mX5bbBRAK8XT+hlXS2bvaX9yuGNyeio2o+FqSLpAJeXy6CmMSnXu2lzNOoD6R6LzykT
         oK/pyJ2bId26FEFM9qeQ5ALQuDWWR7zdjo9kZd7CYlNjoA2M3v1XOgeEh0CR21vfz5XF
         H+1ETjDKIuMEsDXrQ1S/DRNi9GBTD+vgrzTtR9e8d1LuUHjiAMnqr1Rl9t8qpg4kMrYF
         q1HI8KhsePHKyyve/gddUty4tScnWPgv7d8U3WOtdOOLUfzvSMw0D2Q48NLOQbO3fkob
         Z2Gg==
X-Gm-Message-State: AOAM5328dDwlj4BvHauqTX4CBYVRKJIYKeNSNDFQ9CrYaKUF6bpr4dD1
        3Ltx/NrvzBKwx1sEX0NdOyQ=
X-Google-Smtp-Source: ABdhPJxgMPzI7nB9mf0syXpiYV3WtcYkbnefz2oMiE0uNH3due/2FPvqqILA32jSS4ODGv2cEOcc2Q==
X-Received: by 2002:ac2:5615:: with SMTP id v21mr13854983lfd.152.1642359398793;
        Sun, 16 Jan 2022 10:56:38 -0800 (PST)
Received: from localhost.localdomain (46-138-227-157.dynamic.spd-mgts.ru. [46.138.227.157])
        by smtp.gmail.com with ESMTPSA id j2sm1179597lfe.18.2022.01.16.10.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 10:56:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] media: staging: tegra-vde: Factor out H.264 code
Date:   Sun, 16 Jan 2022 21:55:54 +0300
Message-Id: <20220116185556.10657-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220116185556.10657-1-digetx@gmail.com>
References: <20220116185556.10657-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out H.264 hardware programming code into separate source file in a
preparation to support V4L API by the Tegra video decoder driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/staging/media/tegra-vde/Makefile |   2 +-
 drivers/staging/media/tegra-vde/h264.c   | 647 +++++++++++++++++++++++
 drivers/staging/media/tegra-vde/vde.c    | 626 +---------------------
 drivers/staging/media/tegra-vde/vde.h    |  42 ++
 4 files changed, 706 insertions(+), 611 deletions(-)
 create mode 100644 drivers/staging/media/tegra-vde/h264.c

diff --git a/drivers/staging/media/tegra-vde/Makefile b/drivers/staging/media/tegra-vde/Makefile
index 2827f7601de8..43525b08b3b0 100644
--- a/drivers/staging/media/tegra-vde/Makefile
+++ b/drivers/staging/media/tegra-vde/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-tegra-vde-y := vde.o iommu.o dmabuf-cache.o
+tegra-vde-y := vde.o iommu.o dmabuf-cache.o h264.o
 obj-$(CONFIG_TEGRA_VDE)	+= tegra-vde.o
diff --git a/drivers/staging/media/tegra-vde/h264.c b/drivers/staging/media/tegra-vde/h264.c
new file mode 100644
index 000000000000..03faa705bf71
--- /dev/null
+++ b/drivers/staging/media/tegra-vde/h264.c
@@ -0,0 +1,647 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NVIDIA Tegra Video decoder driver
+ *
+ * Copyright (C) 2016-2022 Dmitry Osipenko <digetx@gmail.com>
+ *
+ */
+
+#include <linux/iopoll.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+#include "trace.h"
+#include "uapi.h"
+#include "vde.h"
+
+static int tegra_vde_wait_mbe(struct tegra_vde *vde)
+{
+	u32 tmp;
+
+	return readl_relaxed_poll_timeout(vde->mbe + 0x8C, tmp,
+					  tmp >= 0x10, 1, 100);
+}
+
+static int tegra_vde_setup_mbe_frame_idx(struct tegra_vde *vde,
+					 unsigned int refs_nb,
+					 bool setup_refs)
+{
+	u32 value, frame_idx_enb_mask = 0;
+	unsigned int frame_idx;
+	unsigned int idx;
+	int err;
+
+	tegra_vde_writel(vde, 0xD0000000 | (0 << 23), vde->mbe, 0x80);
+	tegra_vde_writel(vde, 0xD0200000 | (0 << 23), vde->mbe, 0x80);
+
+	err = tegra_vde_wait_mbe(vde);
+	if (err)
+		return err;
+
+	if (!setup_refs)
+		return 0;
+
+	for (idx = 0, frame_idx = 1; idx < refs_nb; idx++, frame_idx++) {
+		tegra_vde_writel(vde, 0xD0000000 | (frame_idx << 23),
+				 vde->mbe, 0x80);
+		tegra_vde_writel(vde, 0xD0200000 | (frame_idx << 23),
+				 vde->mbe, 0x80);
+
+		frame_idx_enb_mask |= frame_idx << (6 * (idx % 4));
+
+		if (idx % 4 == 3 || idx == refs_nb - 1) {
+			value = 0xC0000000;
+			value |= (idx >> 2) << 24;
+			value |= frame_idx_enb_mask;
+
+			tegra_vde_writel(vde, value, vde->mbe, 0x80);
+
+			err = tegra_vde_wait_mbe(vde);
+			if (err)
+				return err;
+
+			frame_idx_enb_mask = 0;
+		}
+	}
+
+	return 0;
+}
+
+static void tegra_vde_mbe_set_0xa_reg(struct tegra_vde *vde, int reg, u32 val)
+{
+	tegra_vde_writel(vde, 0xA0000000 | (reg << 24) | (val & 0xFFFF),
+			 vde->mbe, 0x80);
+	tegra_vde_writel(vde, 0xA0000000 | ((reg + 1) << 24) | (val >> 16),
+			 vde->mbe, 0x80);
+}
+
+static int tegra_vde_wait_bsev(struct tegra_vde *vde, bool wait_dma)
+{
+	struct device *dev = vde->dev;
+	u32 value;
+	int err;
+
+	err = readl_relaxed_poll_timeout(vde->bsev + INTR_STATUS, value,
+					 !(value & BIT(2)), 1, 100);
+	if (err) {
+		dev_err(dev, "BSEV unknown bit timeout\n");
+		return err;
+	}
+
+	err = readl_relaxed_poll_timeout(vde->bsev + INTR_STATUS, value,
+					 (value & BSE_ICMDQUE_EMPTY), 1, 100);
+	if (err) {
+		dev_err(dev, "BSEV ICMDQUE flush timeout\n");
+		return err;
+	}
+
+	if (!wait_dma)
+		return 0;
+
+	err = readl_relaxed_poll_timeout(vde->bsev + INTR_STATUS, value,
+					 !(value & BSE_DMA_BUSY), 1, 100);
+	if (err) {
+		dev_err(dev, "BSEV DMA timeout\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int tegra_vde_push_to_bsev_icmdqueue(struct tegra_vde *vde,
+					    u32 value, bool wait_dma)
+{
+	tegra_vde_writel(vde, value, vde->bsev, ICMDQUE_WR);
+
+	return tegra_vde_wait_bsev(vde, wait_dma);
+}
+
+static void tegra_vde_setup_frameid(struct tegra_vde *vde,
+				    struct tegra_video_frame *frame,
+				    unsigned int frameid,
+				    u32 mbs_width, u32 mbs_height)
+{
+	u32 y_addr  = frame ? frame->y_addr  : 0x6CDEAD00;
+	u32 cb_addr = frame ? frame->cb_addr : 0x6CDEAD00;
+	u32 cr_addr = frame ? frame->cr_addr : 0x6CDEAD00;
+	u32 value1 = frame ? ((mbs_width << 16) | mbs_height) : 0;
+	u32 value2 = frame ? ((((mbs_width + 1) >> 1) << 6) | 1) : 0;
+
+	tegra_vde_writel(vde, y_addr  >> 8, vde->frameid, 0x000 + frameid * 4);
+	tegra_vde_writel(vde, cb_addr >> 8, vde->frameid, 0x100 + frameid * 4);
+	tegra_vde_writel(vde, cr_addr >> 8, vde->frameid, 0x180 + frameid * 4);
+	tegra_vde_writel(vde, value1,       vde->frameid, 0x080 + frameid * 4);
+	tegra_vde_writel(vde, value2,       vde->frameid, 0x280 + frameid * 4);
+}
+
+static void tegra_setup_frameidx(struct tegra_vde *vde,
+				 struct tegra_video_frame *frames,
+				 unsigned int frames_nb,
+				 u32 mbs_width, u32 mbs_height)
+{
+	unsigned int idx;
+
+	for (idx = 0; idx < frames_nb; idx++)
+		tegra_vde_setup_frameid(vde, &frames[idx], idx,
+					mbs_width, mbs_height);
+
+	for (; idx < 17; idx++)
+		tegra_vde_setup_frameid(vde, NULL, idx, 0, 0);
+}
+
+static void tegra_vde_setup_iram_entry(struct tegra_vde *vde,
+				       unsigned int table,
+				       unsigned int row,
+				       u32 value1, u32 value2)
+{
+	u32 *iram_tables = vde->iram;
+
+	trace_vde_setup_iram_entry(table, row, value1, value2);
+
+	iram_tables[0x20 * table + row * 2 + 0] = value1;
+	iram_tables[0x20 * table + row * 2 + 1] = value2;
+}
+
+static void tegra_vde_setup_iram_tables(struct tegra_vde *vde,
+					struct tegra_video_frame *dpb_frames,
+					unsigned int ref_frames_nb,
+					unsigned int with_earlier_poc_nb)
+{
+	struct tegra_video_frame *frame;
+	int with_later_poc_nb;
+	u32 value, aux_addr;
+	unsigned int i, k;
+
+	trace_vde_ref_l0(dpb_frames[0].frame_num);
+
+	for (i = 0; i < 16; i++) {
+		if (i < ref_frames_nb) {
+			frame = &dpb_frames[i + 1];
+
+			aux_addr = frame->aux_addr;
+
+			value  = (i + 1) << 26;
+			value |= !(frame->flags & FLAG_B_FRAME) << 25;
+			value |= 1 << 24;
+			value |= frame->frame_num;
+		} else {
+			aux_addr = 0x6ADEAD00;
+			value = 0x3f;
+		}
+
+		tegra_vde_setup_iram_entry(vde, 0, i, value, aux_addr);
+		tegra_vde_setup_iram_entry(vde, 1, i, value, aux_addr);
+		tegra_vde_setup_iram_entry(vde, 2, i, value, aux_addr);
+		tegra_vde_setup_iram_entry(vde, 3, i, value, aux_addr);
+	}
+
+	if (!(dpb_frames[0].flags & FLAG_B_FRAME))
+		return;
+
+	if (with_earlier_poc_nb >= ref_frames_nb)
+		return;
+
+	with_later_poc_nb = ref_frames_nb - with_earlier_poc_nb;
+
+	trace_vde_ref_l1(with_later_poc_nb, with_earlier_poc_nb);
+
+	for (i = 0, k = with_earlier_poc_nb; i < with_later_poc_nb; i++, k++) {
+		frame = &dpb_frames[k + 1];
+
+		aux_addr = frame->aux_addr;
+
+		value  = (k + 1) << 26;
+		value |= !(frame->flags & FLAG_B_FRAME) << 25;
+		value |= 1 << 24;
+		value |= frame->frame_num;
+
+		tegra_vde_setup_iram_entry(vde, 2, i, value, aux_addr);
+	}
+
+	for (k = 0; i < ref_frames_nb; i++, k++) {
+		frame = &dpb_frames[k + 1];
+
+		aux_addr = frame->aux_addr;
+
+		value  = (k + 1) << 26;
+		value |= !(frame->flags & FLAG_B_FRAME) << 25;
+		value |= 1 << 24;
+		value |= frame->frame_num;
+
+		tegra_vde_setup_iram_entry(vde, 2, i, value, aux_addr);
+	}
+}
+
+static int tegra_vde_setup_hw_context(struct tegra_vde *vde,
+				      struct tegra_vde_h264_decoder_ctx *ctx,
+				      struct tegra_video_frame *dpb_frames,
+				      dma_addr_t bitstream_data_addr,
+				      size_t bitstream_data_size,
+				      unsigned int macroblocks_nb)
+{
+	struct device *dev = vde->dev;
+	u32 value;
+	int err;
+
+	tegra_vde_set_bits(vde, 0x000A, vde->sxe, 0xF0);
+	tegra_vde_set_bits(vde, 0x000B, vde->bsev, CMDQUE_CONTROL);
+	tegra_vde_set_bits(vde, 0x8002, vde->mbe, 0x50);
+	tegra_vde_set_bits(vde, 0x000A, vde->mbe, 0xA0);
+	tegra_vde_set_bits(vde, 0x000A, vde->ppe, 0x14);
+	tegra_vde_set_bits(vde, 0x000A, vde->ppe, 0x28);
+	tegra_vde_set_bits(vde, 0x0A00, vde->mce, 0x08);
+	tegra_vde_set_bits(vde, 0x000A, vde->tfe, 0x00);
+	tegra_vde_set_bits(vde, 0x0005, vde->vdma, 0x04);
+
+	tegra_vde_writel(vde, 0x00000000, vde->vdma, 0x1C);
+	tegra_vde_writel(vde, 0x00000000, vde->vdma, 0x00);
+	tegra_vde_writel(vde, 0x00000007, vde->vdma, 0x04);
+	tegra_vde_writel(vde, 0x00000007, vde->frameid, 0x200);
+	tegra_vde_writel(vde, 0x00000005, vde->tfe, 0x04);
+	tegra_vde_writel(vde, 0x00000000, vde->mbe, 0x84);
+	tegra_vde_writel(vde, 0x00000010, vde->sxe, 0x08);
+	tegra_vde_writel(vde, 0x00000150, vde->sxe, 0x54);
+	tegra_vde_writel(vde, 0x0000054C, vde->sxe, 0x58);
+	tegra_vde_writel(vde, 0x00000E34, vde->sxe, 0x5C);
+	tegra_vde_writel(vde, 0x063C063C, vde->mce, 0x10);
+	tegra_vde_writel(vde, 0x0003FC00, vde->bsev, INTR_STATUS);
+	tegra_vde_writel(vde, 0x0000150D, vde->bsev, BSE_CONFIG);
+	tegra_vde_writel(vde, 0x00000100, vde->bsev, BSE_INT_ENB);
+	tegra_vde_writel(vde, 0x00000000, vde->bsev, 0x98);
+	tegra_vde_writel(vde, 0x00000060, vde->bsev, 0x9C);
+
+	memset(vde->iram + 128, 0, macroblocks_nb / 2);
+
+	tegra_setup_frameidx(vde, dpb_frames, ctx->dpb_frames_nb,
+			     ctx->pic_width_in_mbs, ctx->pic_height_in_mbs);
+
+	tegra_vde_setup_iram_tables(vde, dpb_frames,
+				    ctx->dpb_frames_nb - 1,
+				    ctx->dpb_ref_frames_with_earlier_poc_nb);
+
+	/*
+	 * The IRAM mapping is write-combine, ensure that CPU buffers have
+	 * been flushed at this point.
+	 */
+	wmb();
+
+	tegra_vde_writel(vde, 0x00000000, vde->bsev, 0x8C);
+	tegra_vde_writel(vde, bitstream_data_addr + bitstream_data_size,
+			 vde->bsev, 0x54);
+
+	vde->bitstream_data_addr = bitstream_data_addr;
+
+	value = ctx->pic_width_in_mbs << 11 | ctx->pic_height_in_mbs << 3;
+
+	tegra_vde_writel(vde, value, vde->bsev, 0x88);
+
+	err = tegra_vde_wait_bsev(vde, false);
+	if (err)
+		return err;
+
+	err = tegra_vde_push_to_bsev_icmdqueue(vde, 0x800003FC, false);
+	if (err)
+		return err;
+
+	value = 0x01500000;
+	value |= ((vde->iram_lists_addr + 512) >> 2) & 0xFFFF;
+
+	err = tegra_vde_push_to_bsev_icmdqueue(vde, value, true);
+	if (err)
+		return err;
+
+	err = tegra_vde_push_to_bsev_icmdqueue(vde, 0x840F054C, false);
+	if (err)
+		return err;
+
+	err = tegra_vde_push_to_bsev_icmdqueue(vde, 0x80000080, false);
+	if (err)
+		return err;
+
+	value = 0x0E340000 | ((vde->iram_lists_addr >> 2) & 0xFFFF);
+
+	err = tegra_vde_push_to_bsev_icmdqueue(vde, value, true);
+	if (err)
+		return err;
+
+	value = 0x00800005;
+	value |= ctx->pic_width_in_mbs << 11;
+	value |= ctx->pic_height_in_mbs << 3;
+
+	tegra_vde_writel(vde, value, vde->sxe, 0x10);
+
+	value = !ctx->baseline_profile << 17;
+	value |= ctx->level_idc << 13;
+	value |= ctx->log2_max_pic_order_cnt_lsb << 7;
+	value |= ctx->pic_order_cnt_type << 5;
+	value |= ctx->log2_max_frame_num;
+
+	tegra_vde_writel(vde, value, vde->sxe, 0x40);
+
+	value = ctx->pic_init_qp << 25;
+	value |= !!(ctx->deblocking_filter_control_present_flag) << 2;
+	value |= !!ctx->pic_order_present_flag;
+
+	tegra_vde_writel(vde, value, vde->sxe, 0x44);
+
+	value = ctx->chroma_qp_index_offset;
+	value |= ctx->num_ref_idx_l0_active_minus1 << 5;
+	value |= ctx->num_ref_idx_l1_active_minus1 << 10;
+	value |= !!ctx->constrained_intra_pred_flag << 15;
+
+	tegra_vde_writel(vde, value, vde->sxe, 0x48);
+
+	value = 0x0C000000;
+	value |= !!(dpb_frames[0].flags & FLAG_B_FRAME) << 24;
+
+	tegra_vde_writel(vde, value, vde->sxe, 0x4C);
+
+	value = 0x03800000;
+	value |= bitstream_data_size & GENMASK(19, 15);
+
+	tegra_vde_writel(vde, value, vde->sxe, 0x68);
+
+	tegra_vde_writel(vde, bitstream_data_addr, vde->sxe, 0x6C);
+
+	if (vde->soc->supports_ref_pic_marking)
+		tegra_vde_writel(vde, vde->secure_bo->dma_addr, vde->sxe, 0x7c);
+
+	value = 0x10000005;
+	value |= ctx->pic_width_in_mbs << 11;
+	value |= ctx->pic_height_in_mbs << 3;
+
+	tegra_vde_writel(vde, value, vde->mbe, 0x80);
+
+	value = 0x26800000;
+	value |= ctx->level_idc << 4;
+	value |= !ctx->baseline_profile << 1;
+	value |= !!ctx->direct_8x8_inference_flag;
+
+	tegra_vde_writel(vde, value, vde->mbe, 0x80);
+
+	tegra_vde_writel(vde, 0xF4000001, vde->mbe, 0x80);
+	tegra_vde_writel(vde, 0x20000000, vde->mbe, 0x80);
+	tegra_vde_writel(vde, 0xF4000101, vde->mbe, 0x80);
+
+	value = 0x20000000;
+	value |= ctx->chroma_qp_index_offset << 8;
+
+	tegra_vde_writel(vde, value, vde->mbe, 0x80);
+
+	err = tegra_vde_setup_mbe_frame_idx(vde,
+					    ctx->dpb_frames_nb - 1,
+					    ctx->pic_order_cnt_type == 0);
+	if (err) {
+		dev_err(dev, "MBE frames setup failed %d\n", err);
+		return err;
+	}
+
+	tegra_vde_mbe_set_0xa_reg(vde, 0, 0x000009FC);
+	tegra_vde_mbe_set_0xa_reg(vde, 2, 0x61DEAD00);
+	tegra_vde_mbe_set_0xa_reg(vde, 4, 0x62DEAD00);
+	tegra_vde_mbe_set_0xa_reg(vde, 6, 0x63DEAD00);
+	tegra_vde_mbe_set_0xa_reg(vde, 8, dpb_frames[0].aux_addr);
+
+	value = 0xFC000000;
+	value |= !!(dpb_frames[0].flags & FLAG_B_FRAME) << 2;
+
+	if (!ctx->baseline_profile)
+		value |= !!(dpb_frames[0].flags & FLAG_REFERENCE) << 1;
+
+	tegra_vde_writel(vde, value, vde->mbe, 0x80);
+
+	err = tegra_vde_wait_mbe(vde);
+	if (err) {
+		dev_err(dev, "MBE programming failed %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void tegra_vde_decode_frame(struct tegra_vde *vde,
+				   unsigned int macroblocks_nb)
+{
+	reinit_completion(&vde->decode_completion);
+
+	tegra_vde_writel(vde, 0x00000001, vde->bsev, 0x8C);
+	tegra_vde_writel(vde, 0x20000000 | (macroblocks_nb - 1),
+			 vde->sxe, 0x00);
+}
+
+int tegra_vde_validate_h264_frame(struct device *dev,
+				  struct tegra_vde_h264_frame *frame)
+{
+	if (frame->frame_num > 0x7FFFFF) {
+		dev_err(dev, "Bad frame_num %u\n", frame->frame_num);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int tegra_vde_validate_h264_ctx(struct device *dev,
+				struct tegra_vde_h264_decoder_ctx *ctx)
+{
+	if (ctx->dpb_frames_nb == 0 || ctx->dpb_frames_nb > 17) {
+		dev_err(dev, "Bad DPB size %u\n", ctx->dpb_frames_nb);
+		return -EINVAL;
+	}
+
+	if (ctx->level_idc > 15) {
+		dev_err(dev, "Bad level value %u\n", ctx->level_idc);
+		return -EINVAL;
+	}
+
+	if (ctx->pic_init_qp > 52) {
+		dev_err(dev, "Bad pic_init_qp value %u\n", ctx->pic_init_qp);
+		return -EINVAL;
+	}
+
+	if (ctx->log2_max_pic_order_cnt_lsb > 16) {
+		dev_err(dev, "Bad log2_max_pic_order_cnt_lsb value %u\n",
+			ctx->log2_max_pic_order_cnt_lsb);
+		return -EINVAL;
+	}
+
+	if (ctx->log2_max_frame_num > 16) {
+		dev_err(dev, "Bad log2_max_frame_num value %u\n",
+			ctx->log2_max_frame_num);
+		return -EINVAL;
+	}
+
+	if (ctx->chroma_qp_index_offset > 31) {
+		dev_err(dev, "Bad chroma_qp_index_offset value %u\n",
+			ctx->chroma_qp_index_offset);
+		return -EINVAL;
+	}
+
+	if (ctx->pic_order_cnt_type > 2) {
+		dev_err(dev, "Bad pic_order_cnt_type value %u\n",
+			ctx->pic_order_cnt_type);
+		return -EINVAL;
+	}
+
+	if (ctx->num_ref_idx_l0_active_minus1 > 15) {
+		dev_err(dev, "Bad num_ref_idx_l0_active_minus1 value %u\n",
+			ctx->num_ref_idx_l0_active_minus1);
+		return -EINVAL;
+	}
+
+	if (ctx->num_ref_idx_l1_active_minus1 > 15) {
+		dev_err(dev, "Bad num_ref_idx_l1_active_minus1 value %u\n",
+			ctx->num_ref_idx_l1_active_minus1);
+		return -EINVAL;
+	}
+
+	if (!ctx->pic_width_in_mbs || ctx->pic_width_in_mbs > 127) {
+		dev_err(dev, "Bad pic_width_in_mbs value %u\n",
+			ctx->pic_width_in_mbs);
+		return -EINVAL;
+	}
+
+	if (!ctx->pic_height_in_mbs || ctx->pic_height_in_mbs > 127) {
+		dev_err(dev, "Bad pic_height_in_mbs value %u\n",
+			ctx->pic_height_in_mbs);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tegra_vde_decode_begin(struct tegra_vde *vde,
+				  struct tegra_vde_h264_decoder_ctx *ctx,
+				  struct tegra_video_frame *dpb_frames,
+				  dma_addr_t bitstream_data_addr,
+				  size_t bitstream_data_size)
+{
+	struct device *dev = vde->dev;
+	unsigned int macroblocks_nb;
+	int err;
+
+	err = mutex_lock_interruptible(&vde->lock);
+	if (err)
+		return err;
+
+	err = pm_runtime_resume_and_get(dev);
+	if (err < 0)
+		goto unlock;
+
+	/*
+	 * We rely on the VDE registers reset value, otherwise VDE
+	 * causes bus lockup.
+	 */
+	err = reset_control_assert(vde->rst_mc);
+	if (err) {
+		dev_err(dev, "DEC start: Failed to assert MC reset: %d\n",
+			err);
+		goto put_runtime_pm;
+	}
+
+	err = reset_control_reset(vde->rst);
+	if (err) {
+		dev_err(dev, "DEC start: Failed to reset HW: %d\n", err);
+		goto put_runtime_pm;
+	}
+
+	err = reset_control_deassert(vde->rst_mc);
+	if (err) {
+		dev_err(dev, "DEC start: Failed to deassert MC reset: %d\n",
+			err);
+		goto put_runtime_pm;
+	}
+
+	macroblocks_nb = ctx->pic_width_in_mbs * ctx->pic_height_in_mbs;
+
+	err = tegra_vde_setup_hw_context(vde, ctx, dpb_frames,
+					 bitstream_data_addr,
+					 bitstream_data_size,
+					 macroblocks_nb);
+	if (err)
+		goto put_runtime_pm;
+
+	tegra_vde_decode_frame(vde, macroblocks_nb);
+
+	return 0;
+
+put_runtime_pm:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+unlock:
+	mutex_unlock(&vde->lock);
+
+	return err;
+}
+
+static void tegra_vde_decode_abort(struct tegra_vde *vde)
+{
+	struct device *dev = vde->dev;
+	int err;
+
+	/*
+	 * At first reset memory client to avoid resetting VDE HW in the
+	 * middle of DMA which could result into memory corruption or hang
+	 * the whole system.
+	 */
+	err = reset_control_assert(vde->rst_mc);
+	if (err)
+		dev_err(dev, "DEC end: Failed to assert MC reset: %d\n", err);
+
+	err = reset_control_assert(vde->rst);
+	if (err)
+		dev_err(dev, "DEC end: Failed to assert HW reset: %d\n", err);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	mutex_unlock(&vde->lock);
+}
+
+static int tegra_vde_decode_end(struct tegra_vde *vde)
+{
+	unsigned int read_bytes, macroblocks_nb;
+	struct device *dev = vde->dev;
+	dma_addr_t bsev_ptr;
+	long timeout;
+	int ret;
+
+	timeout = wait_for_completion_interruptible_timeout(
+			&vde->decode_completion, msecs_to_jiffies(1000));
+	if (timeout == 0) {
+		bsev_ptr = tegra_vde_readl(vde, vde->bsev, 0x10);
+		macroblocks_nb = tegra_vde_readl(vde, vde->sxe, 0xC8) & 0x1FFF;
+		read_bytes = bsev_ptr ? bsev_ptr - vde->bitstream_data_addr : 0;
+
+		dev_err(dev, "Decoding failed: read 0x%X bytes, %u macroblocks parsed\n",
+			read_bytes, macroblocks_nb);
+
+		ret = -EIO;
+	} else if (timeout < 0) {
+		ret = timeout;
+	} else {
+		ret = 0;
+	}
+
+	tegra_vde_decode_abort(vde);
+
+	return ret;
+}
+
+int tegra_vde_decode_h264(struct tegra_vde *vde,
+			  struct tegra_vde_h264_decoder_ctx *ctx,
+			  struct tegra_video_frame *dpb_frames,
+			  dma_addr_t bitstream_data_addr,
+			  size_t bitstream_data_size)
+{
+	int err;
+
+	err = tegra_vde_decode_begin(vde, ctx, dpb_frames,
+				     bitstream_data_addr,
+				     bitstream_data_size);
+	if (err)
+		return err;
+
+	return tegra_vde_decode_end(vde);
+}
diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/staging/media/tegra-vde/vde.c
index a8f1a024c343..36f5595c0fd8 100644
--- a/drivers/staging/media/tegra-vde/vde.c
+++ b/drivers/staging/media/tegra-vde/vde.c
@@ -10,7 +10,6 @@
 #include <linux/dma-buf.h>
 #include <linux/genalloc.h>
 #include <linux/interrupt.h>
-#include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -29,38 +28,15 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-#define ICMDQUE_WR		0x00
-#define CMDQUE_CONTROL		0x08
-#define INTR_STATUS		0x18
-#define BSE_INT_ENB		0x40
-#define BSE_CONFIG		0x44
-
-#define BSE_ICMDQUE_EMPTY	BIT(3)
-#define BSE_DMA_BUSY		BIT(23)
-
-struct video_frame {
-	struct dma_buf_attachment *y_dmabuf_attachment;
-	struct dma_buf_attachment *cb_dmabuf_attachment;
-	struct dma_buf_attachment *cr_dmabuf_attachment;
-	struct dma_buf_attachment *aux_dmabuf_attachment;
-	dma_addr_t y_addr;
-	dma_addr_t cb_addr;
-	dma_addr_t cr_addr;
-	dma_addr_t aux_addr;
-	u32 frame_num;
-	u32 flags;
-};
-
-static void tegra_vde_writel(struct tegra_vde *vde,
-			     u32 value, void __iomem *base, u32 offset)
+void tegra_vde_writel(struct tegra_vde *vde, u32 value,
+		      void __iomem *base, u32 offset)
 {
 	trace_vde_writel(vde, base, offset, value);
 
 	writel_relaxed(value, base + offset);
 }
 
-static u32 tegra_vde_readl(struct tegra_vde *vde,
-			   void __iomem *base, u32 offset)
+u32 tegra_vde_readl(struct tegra_vde *vde, void __iomem *base, u32 offset)
 {
 	u32 value = readl_relaxed(base + offset);
 
@@ -69,22 +45,14 @@ static u32 tegra_vde_readl(struct tegra_vde *vde,
 	return value;
 }
 
-static void tegra_vde_set_bits(struct tegra_vde *vde,
-			       u32 mask, void __iomem *base, u32 offset)
+void tegra_vde_set_bits(struct tegra_vde *vde, u32 mask,
+			void __iomem *base, u32 offset)
 {
 	u32 value = tegra_vde_readl(vde, base, offset);
 
 	tegra_vde_writel(vde, value | mask, base, offset);
 }
 
-static int tegra_vde_wait_mbe(struct tegra_vde *vde)
-{
-	u32 tmp;
-
-	return readl_relaxed_poll_timeout(vde->mbe + 0x8C, tmp,
-					  (tmp >= 0x10), 1, 100);
-}
-
 static int tegra_vde_alloc_bo(struct tegra_vde *vde,
 			      struct tegra_vde_bo **ret_bo,
 			      enum dma_data_direction dma_dir,
@@ -175,412 +143,6 @@ static void tegra_vde_free_bo(struct tegra_vde_bo *bo)
 	kfree(bo);
 }
 
-static int tegra_vde_setup_mbe_frame_idx(struct tegra_vde *vde,
-					 unsigned int refs_nb,
-					 bool setup_refs)
-{
-	u32 frame_idx_enb_mask = 0;
-	u32 value;
-	unsigned int frame_idx;
-	unsigned int idx;
-	int err;
-
-	tegra_vde_writel(vde, 0xD0000000 | (0 << 23), vde->mbe, 0x80);
-	tegra_vde_writel(vde, 0xD0200000 | (0 << 23), vde->mbe, 0x80);
-
-	err = tegra_vde_wait_mbe(vde);
-	if (err)
-		return err;
-
-	if (!setup_refs)
-		return 0;
-
-	for (idx = 0, frame_idx = 1; idx < refs_nb; idx++, frame_idx++) {
-		tegra_vde_writel(vde, 0xD0000000 | (frame_idx << 23),
-				 vde->mbe, 0x80);
-		tegra_vde_writel(vde, 0xD0200000 | (frame_idx << 23),
-				 vde->mbe, 0x80);
-
-		frame_idx_enb_mask |= frame_idx << (6 * (idx % 4));
-
-		if (idx % 4 == 3 || idx == refs_nb - 1) {
-			value = 0xC0000000;
-			value |= (idx >> 2) << 24;
-			value |= frame_idx_enb_mask;
-
-			tegra_vde_writel(vde, value, vde->mbe, 0x80);
-
-			err = tegra_vde_wait_mbe(vde);
-			if (err)
-				return err;
-
-			frame_idx_enb_mask = 0;
-		}
-	}
-
-	return 0;
-}
-
-static void tegra_vde_mbe_set_0xa_reg(struct tegra_vde *vde, int reg, u32 val)
-{
-	tegra_vde_writel(vde, 0xA0000000 | (reg << 24) | (val & 0xFFFF),
-			 vde->mbe, 0x80);
-	tegra_vde_writel(vde, 0xA0000000 | ((reg + 1) << 24) | (val >> 16),
-			 vde->mbe, 0x80);
-}
-
-static int tegra_vde_wait_bsev(struct tegra_vde *vde, bool wait_dma)
-{
-	struct device *dev = vde->miscdev.parent;
-	u32 value;
-	int err;
-
-	err = readl_relaxed_poll_timeout(vde->bsev + INTR_STATUS, value,
-					 !(value & BIT(2)), 1, 100);
-	if (err) {
-		dev_err(dev, "BSEV unknown bit timeout\n");
-		return err;
-	}
-
-	err = readl_relaxed_poll_timeout(vde->bsev + INTR_STATUS, value,
-					 (value & BSE_ICMDQUE_EMPTY), 1, 100);
-	if (err) {
-		dev_err(dev, "BSEV ICMDQUE flush timeout\n");
-		return err;
-	}
-
-	if (!wait_dma)
-		return 0;
-
-	err = readl_relaxed_poll_timeout(vde->bsev + INTR_STATUS, value,
-					 !(value & BSE_DMA_BUSY), 1, 100);
-	if (err) {
-		dev_err(dev, "BSEV DMA timeout\n");
-		return err;
-	}
-
-	return 0;
-}
-
-static int tegra_vde_push_to_bsev_icmdqueue(struct tegra_vde *vde,
-					    u32 value, bool wait_dma)
-{
-	tegra_vde_writel(vde, value, vde->bsev, ICMDQUE_WR);
-
-	return tegra_vde_wait_bsev(vde, wait_dma);
-}
-
-static void tegra_vde_setup_frameid(struct tegra_vde *vde,
-				    struct video_frame *frame,
-				    unsigned int frameid,
-				    u32 mbs_width, u32 mbs_height)
-{
-	u32 y_addr  = frame ? frame->y_addr  : 0x6CDEAD00;
-	u32 cb_addr = frame ? frame->cb_addr : 0x6CDEAD00;
-	u32 cr_addr = frame ? frame->cr_addr : 0x6CDEAD00;
-	u32 value1 = frame ? ((mbs_width << 16) | mbs_height) : 0;
-	u32 value2 = frame ? ((((mbs_width + 1) >> 1) << 6) | 1) : 0;
-
-	tegra_vde_writel(vde, y_addr  >> 8, vde->frameid, 0x000 + frameid * 4);
-	tegra_vde_writel(vde, cb_addr >> 8, vde->frameid, 0x100 + frameid * 4);
-	tegra_vde_writel(vde, cr_addr >> 8, vde->frameid, 0x180 + frameid * 4);
-	tegra_vde_writel(vde, value1,       vde->frameid, 0x080 + frameid * 4);
-	tegra_vde_writel(vde, value2,       vde->frameid, 0x280 + frameid * 4);
-}
-
-static void tegra_setup_frameidx(struct tegra_vde *vde,
-				 struct video_frame *frames,
-				 unsigned int frames_nb,
-				 u32 mbs_width, u32 mbs_height)
-{
-	unsigned int idx;
-
-	for (idx = 0; idx < frames_nb; idx++)
-		tegra_vde_setup_frameid(vde, &frames[idx], idx,
-					mbs_width, mbs_height);
-
-	for (; idx < 17; idx++)
-		tegra_vde_setup_frameid(vde, NULL, idx, 0, 0);
-}
-
-static void tegra_vde_setup_iram_entry(struct tegra_vde *vde,
-				       unsigned int table,
-				       unsigned int row,
-				       u32 value1, u32 value2)
-{
-	u32 *iram_tables = vde->iram;
-
-	trace_vde_setup_iram_entry(table, row, value1, value2);
-
-	iram_tables[0x20 * table + row * 2] = value1;
-	iram_tables[0x20 * table + row * 2 + 1] = value2;
-}
-
-static void tegra_vde_setup_iram_tables(struct tegra_vde *vde,
-					struct video_frame *dpb_frames,
-					unsigned int ref_frames_nb,
-					unsigned int with_earlier_poc_nb)
-{
-	struct video_frame *frame;
-	u32 value, aux_addr;
-	int with_later_poc_nb;
-	unsigned int i, k;
-
-	trace_vde_ref_l0(dpb_frames[0].frame_num);
-
-	for (i = 0; i < 16; i++) {
-		if (i < ref_frames_nb) {
-			frame = &dpb_frames[i + 1];
-
-			aux_addr = frame->aux_addr;
-
-			value  = (i + 1) << 26;
-			value |= !(frame->flags & FLAG_B_FRAME) << 25;
-			value |= 1 << 24;
-			value |= frame->frame_num;
-		} else {
-			aux_addr = 0x6ADEAD00;
-			value = 0x3f;
-		}
-
-		tegra_vde_setup_iram_entry(vde, 0, i, value, aux_addr);
-		tegra_vde_setup_iram_entry(vde, 1, i, value, aux_addr);
-		tegra_vde_setup_iram_entry(vde, 2, i, value, aux_addr);
-		tegra_vde_setup_iram_entry(vde, 3, i, value, aux_addr);
-	}
-
-	if (!(dpb_frames[0].flags & FLAG_B_FRAME))
-		return;
-
-	if (with_earlier_poc_nb >= ref_frames_nb)
-		return;
-
-	with_later_poc_nb = ref_frames_nb - with_earlier_poc_nb;
-
-	trace_vde_ref_l1(with_later_poc_nb, with_earlier_poc_nb);
-
-	for (i = 0, k = with_earlier_poc_nb; i < with_later_poc_nb; i++, k++) {
-		frame = &dpb_frames[k + 1];
-
-		aux_addr = frame->aux_addr;
-
-		value  = (k + 1) << 26;
-		value |= !(frame->flags & FLAG_B_FRAME) << 25;
-		value |= 1 << 24;
-		value |= frame->frame_num;
-
-		tegra_vde_setup_iram_entry(vde, 2, i, value, aux_addr);
-	}
-
-	for (k = 0; i < ref_frames_nb; i++, k++) {
-		frame = &dpb_frames[k + 1];
-
-		aux_addr = frame->aux_addr;
-
-		value  = (k + 1) << 26;
-		value |= !(frame->flags & FLAG_B_FRAME) << 25;
-		value |= 1 << 24;
-		value |= frame->frame_num;
-
-		tegra_vde_setup_iram_entry(vde, 2, i, value, aux_addr);
-	}
-}
-
-static int tegra_vde_setup_hw_context(struct tegra_vde *vde,
-				      struct tegra_vde_h264_decoder_ctx *ctx,
-				      struct video_frame *dpb_frames,
-				      dma_addr_t bitstream_data_addr,
-				      size_t bitstream_data_size,
-				      unsigned int macroblocks_nb)
-{
-	struct device *dev = vde->miscdev.parent;
-	u32 value;
-	int err;
-
-	tegra_vde_set_bits(vde, 0x000A, vde->sxe, 0xF0);
-	tegra_vde_set_bits(vde, 0x000B, vde->bsev, CMDQUE_CONTROL);
-	tegra_vde_set_bits(vde, 0x8002, vde->mbe, 0x50);
-	tegra_vde_set_bits(vde, 0x000A, vde->mbe, 0xA0);
-	tegra_vde_set_bits(vde, 0x000A, vde->ppe, 0x14);
-	tegra_vde_set_bits(vde, 0x000A, vde->ppe, 0x28);
-	tegra_vde_set_bits(vde, 0x0A00, vde->mce, 0x08);
-	tegra_vde_set_bits(vde, 0x000A, vde->tfe, 0x00);
-	tegra_vde_set_bits(vde, 0x0005, vde->vdma, 0x04);
-
-	tegra_vde_writel(vde, 0x00000000, vde->vdma, 0x1C);
-	tegra_vde_writel(vde, 0x00000000, vde->vdma, 0x00);
-	tegra_vde_writel(vde, 0x00000007, vde->vdma, 0x04);
-	tegra_vde_writel(vde, 0x00000007, vde->frameid, 0x200);
-	tegra_vde_writel(vde, 0x00000005, vde->tfe, 0x04);
-	tegra_vde_writel(vde, 0x00000000, vde->mbe, 0x84);
-	tegra_vde_writel(vde, 0x00000010, vde->sxe, 0x08);
-	tegra_vde_writel(vde, 0x00000150, vde->sxe, 0x54);
-	tegra_vde_writel(vde, 0x0000054C, vde->sxe, 0x58);
-	tegra_vde_writel(vde, 0x00000E34, vde->sxe, 0x5C);
-	tegra_vde_writel(vde, 0x063C063C, vde->mce, 0x10);
-	tegra_vde_writel(vde, 0x0003FC00, vde->bsev, INTR_STATUS);
-	tegra_vde_writel(vde, 0x0000150D, vde->bsev, BSE_CONFIG);
-	tegra_vde_writel(vde, 0x00000100, vde->bsev, BSE_INT_ENB);
-	tegra_vde_writel(vde, 0x00000000, vde->bsev, 0x98);
-	tegra_vde_writel(vde, 0x00000060, vde->bsev, 0x9C);
-
-	memset(vde->iram + 128, 0, macroblocks_nb / 2);
-
-	tegra_setup_frameidx(vde, dpb_frames, ctx->dpb_frames_nb,
-			     ctx->pic_width_in_mbs, ctx->pic_height_in_mbs);
-
-	tegra_vde_setup_iram_tables(vde, dpb_frames,
-				    ctx->dpb_frames_nb - 1,
-				    ctx->dpb_ref_frames_with_earlier_poc_nb);
-
-	/*
-	 * The IRAM mapping is write-combine, ensure that CPU buffers have
-	 * been flushed at this point.
-	 */
-	wmb();
-
-	tegra_vde_writel(vde, 0x00000000, vde->bsev, 0x8C);
-	tegra_vde_writel(vde, bitstream_data_addr + bitstream_data_size,
-			 vde->bsev, 0x54);
-
-	value = ctx->pic_width_in_mbs << 11 | ctx->pic_height_in_mbs << 3;
-
-	tegra_vde_writel(vde, value, vde->bsev, 0x88);
-
-	err = tegra_vde_wait_bsev(vde, false);
-	if (err)
-		return err;
-
-	err = tegra_vde_push_to_bsev_icmdqueue(vde, 0x800003FC, false);
-	if (err)
-		return err;
-
-	value = 0x01500000;
-	value |= ((vde->iram_lists_addr + 512) >> 2) & 0xFFFF;
-
-	err = tegra_vde_push_to_bsev_icmdqueue(vde, value, true);
-	if (err)
-		return err;
-
-	err = tegra_vde_push_to_bsev_icmdqueue(vde, 0x840F054C, false);
-	if (err)
-		return err;
-
-	err = tegra_vde_push_to_bsev_icmdqueue(vde, 0x80000080, false);
-	if (err)
-		return err;
-
-	value = 0x0E340000 | ((vde->iram_lists_addr >> 2) & 0xFFFF);
-
-	err = tegra_vde_push_to_bsev_icmdqueue(vde, value, true);
-	if (err)
-		return err;
-
-	value = 0x00800005;
-	value |= ctx->pic_width_in_mbs << 11;
-	value |= ctx->pic_height_in_mbs << 3;
-
-	tegra_vde_writel(vde, value, vde->sxe, 0x10);
-
-	value = !ctx->baseline_profile << 17;
-	value |= ctx->level_idc << 13;
-	value |= ctx->log2_max_pic_order_cnt_lsb << 7;
-	value |= ctx->pic_order_cnt_type << 5;
-	value |= ctx->log2_max_frame_num;
-
-	tegra_vde_writel(vde, value, vde->sxe, 0x40);
-
-	value = ctx->pic_init_qp << 25;
-	value |= !!(ctx->deblocking_filter_control_present_flag) << 2;
-	value |= !!ctx->pic_order_present_flag;
-
-	tegra_vde_writel(vde, value, vde->sxe, 0x44);
-
-	value = ctx->chroma_qp_index_offset;
-	value |= ctx->num_ref_idx_l0_active_minus1 << 5;
-	value |= ctx->num_ref_idx_l1_active_minus1 << 10;
-	value |= !!ctx->constrained_intra_pred_flag << 15;
-
-	tegra_vde_writel(vde, value, vde->sxe, 0x48);
-
-	value = 0x0C000000;
-	value |= !!(dpb_frames[0].flags & FLAG_B_FRAME) << 24;
-
-	tegra_vde_writel(vde, value, vde->sxe, 0x4C);
-
-	value = 0x03800000;
-	value |= bitstream_data_size & GENMASK(19, 15);
-
-	tegra_vde_writel(vde, value, vde->sxe, 0x68);
-
-	tegra_vde_writel(vde, bitstream_data_addr, vde->sxe, 0x6C);
-
-	if (vde->soc->supports_ref_pic_marking)
-		tegra_vde_writel(vde, vde->secure_bo->dma_addr, vde->sxe, 0x7c);
-
-	value = 0x10000005;
-	value |= ctx->pic_width_in_mbs << 11;
-	value |= ctx->pic_height_in_mbs << 3;
-
-	tegra_vde_writel(vde, value, vde->mbe, 0x80);
-
-	value = 0x26800000;
-	value |= ctx->level_idc << 4;
-	value |= !ctx->baseline_profile << 1;
-	value |= !!ctx->direct_8x8_inference_flag;
-
-	tegra_vde_writel(vde, value, vde->mbe, 0x80);
-
-	tegra_vde_writel(vde, 0xF4000001, vde->mbe, 0x80);
-	tegra_vde_writel(vde, 0x20000000, vde->mbe, 0x80);
-	tegra_vde_writel(vde, 0xF4000101, vde->mbe, 0x80);
-
-	value = 0x20000000;
-	value |= ctx->chroma_qp_index_offset << 8;
-
-	tegra_vde_writel(vde, value, vde->mbe, 0x80);
-
-	err = tegra_vde_setup_mbe_frame_idx(vde,
-					    ctx->dpb_frames_nb - 1,
-					    ctx->pic_order_cnt_type == 0);
-	if (err) {
-		dev_err(dev, "MBE frames setup failed %d\n", err);
-		return err;
-	}
-
-	tegra_vde_mbe_set_0xa_reg(vde, 0, 0x000009FC);
-	tegra_vde_mbe_set_0xa_reg(vde, 2, 0x61DEAD00);
-	tegra_vde_mbe_set_0xa_reg(vde, 4, 0x62DEAD00);
-	tegra_vde_mbe_set_0xa_reg(vde, 6, 0x63DEAD00);
-	tegra_vde_mbe_set_0xa_reg(vde, 8, dpb_frames[0].aux_addr);
-
-	value = 0xFC000000;
-	value |= !!(dpb_frames[0].flags & FLAG_B_FRAME) << 2;
-
-	if (!ctx->baseline_profile)
-		value |= !!(dpb_frames[0].flags & FLAG_REFERENCE) << 1;
-
-	tegra_vde_writel(vde, value, vde->mbe, 0x80);
-
-	err = tegra_vde_wait_mbe(vde);
-	if (err) {
-		dev_err(dev, "MBE programming failed %d\n", err);
-		return err;
-	}
-
-	return 0;
-}
-
-static void tegra_vde_decode_frame(struct tegra_vde *vde,
-				   unsigned int macroblocks_nb)
-{
-	reinit_completion(&vde->decode_completion);
-
-	tegra_vde_writel(vde, 0x00000001, vde->bsev, 0x8C);
-	tegra_vde_writel(vde, 0x20000000 | (macroblocks_nb - 1),
-			 vde->sxe, 0x00);
-}
-
 static int tegra_vde_attach_dmabuf(struct tegra_vde *vde,
 				   int fd,
 				   unsigned long offset,
@@ -631,7 +193,7 @@ static int tegra_vde_attach_dmabuf(struct tegra_vde *vde,
 }
 
 static int tegra_vde_attach_dmabufs_to_frame(struct tegra_vde *vde,
-					     struct video_frame *frame,
+					     struct tegra_video_frame *frame,
 					     struct tegra_vde_h264_frame *src,
 					     enum dma_data_direction dma_dir,
 					     bool baseline_profile,
@@ -689,7 +251,7 @@ static int tegra_vde_attach_dmabufs_to_frame(struct tegra_vde *vde,
 }
 
 static void tegra_vde_release_frame_dmabufs(struct tegra_vde *vde,
-					    struct video_frame *frame,
+					    struct tegra_video_frame *frame,
 					    enum dma_data_direction dma_dir,
 					    bool baseline_profile,
 					    bool release)
@@ -703,106 +265,22 @@ static void tegra_vde_release_frame_dmabufs(struct tegra_vde *vde,
 	tegra_vde_dmabuf_cache_unmap(vde, frame->y_dmabuf_attachment, release);
 }
 
-static int tegra_vde_validate_frame(struct device *dev,
-				    struct tegra_vde_h264_frame *frame)
-{
-	if (frame->frame_num > 0x7FFFFF) {
-		dev_err(dev, "Bad frame_num %u\n", frame->frame_num);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int tegra_vde_validate_h264_ctx(struct device *dev,
-				       struct tegra_vde_h264_decoder_ctx *ctx)
-{
-	if (ctx->dpb_frames_nb == 0 || ctx->dpb_frames_nb > 17) {
-		dev_err(dev, "Bad DPB size %u\n", ctx->dpb_frames_nb);
-		return -EINVAL;
-	}
-
-	if (ctx->level_idc > 15) {
-		dev_err(dev, "Bad level value %u\n", ctx->level_idc);
-		return -EINVAL;
-	}
-
-	if (ctx->pic_init_qp > 52) {
-		dev_err(dev, "Bad pic_init_qp value %u\n", ctx->pic_init_qp);
-		return -EINVAL;
-	}
-
-	if (ctx->log2_max_pic_order_cnt_lsb > 16) {
-		dev_err(dev, "Bad log2_max_pic_order_cnt_lsb value %u\n",
-			ctx->log2_max_pic_order_cnt_lsb);
-		return -EINVAL;
-	}
-
-	if (ctx->log2_max_frame_num > 16) {
-		dev_err(dev, "Bad log2_max_frame_num value %u\n",
-			ctx->log2_max_frame_num);
-		return -EINVAL;
-	}
-
-	if (ctx->chroma_qp_index_offset > 31) {
-		dev_err(dev, "Bad chroma_qp_index_offset value %u\n",
-			ctx->chroma_qp_index_offset);
-		return -EINVAL;
-	}
-
-	if (ctx->pic_order_cnt_type > 2) {
-		dev_err(dev, "Bad pic_order_cnt_type value %u\n",
-			ctx->pic_order_cnt_type);
-		return -EINVAL;
-	}
-
-	if (ctx->num_ref_idx_l0_active_minus1 > 15) {
-		dev_err(dev, "Bad num_ref_idx_l0_active_minus1 value %u\n",
-			ctx->num_ref_idx_l0_active_minus1);
-		return -EINVAL;
-	}
-
-	if (ctx->num_ref_idx_l1_active_minus1 > 15) {
-		dev_err(dev, "Bad num_ref_idx_l1_active_minus1 value %u\n",
-			ctx->num_ref_idx_l1_active_minus1);
-		return -EINVAL;
-	}
-
-	if (!ctx->pic_width_in_mbs || ctx->pic_width_in_mbs > 127) {
-		dev_err(dev, "Bad pic_width_in_mbs value %u\n",
-			ctx->pic_width_in_mbs);
-		return -EINVAL;
-	}
-
-	if (!ctx->pic_height_in_mbs || ctx->pic_height_in_mbs > 127) {
-		dev_err(dev, "Bad pic_height_in_mbs value %u\n",
-			ctx->pic_height_in_mbs);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 				       unsigned long vaddr)
 {
+	struct dma_buf_attachment *bitstream_data_dmabuf_attachment;
+	struct tegra_vde_h264_frame __user *frames_user;
+	size_t bitstream_data_size, lsize, csize;
 	struct device *dev = vde->miscdev.parent;
 	struct tegra_vde_h264_decoder_ctx ctx;
+	struct tegra_video_frame *dpb_frames;
 	struct tegra_vde_h264_frame *frames;
-	struct tegra_vde_h264_frame __user *frames_user;
-	struct video_frame *dpb_frames;
-	struct dma_buf_attachment *bitstream_data_dmabuf_attachment;
 	enum dma_data_direction dma_dir;
 	dma_addr_t bitstream_data_addr;
-	dma_addr_t bsev_ptr;
-	size_t lsize, csize;
-	size_t bitstream_data_size;
 	unsigned int macroblocks_nb;
-	unsigned int read_bytes;
 	unsigned int cstride;
 	unsigned int i;
-	long timeout;
-	int ret, err;
+	int ret;
 
 	if (copy_from_user(&ctx, (void __user *)vaddr, sizeof(ctx)))
 		return -EFAULT;
@@ -848,7 +326,7 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 	lsize = macroblocks_nb * 256;
 
 	for (i = 0; i < ctx.dpb_frames_nb; i++) {
-		ret = tegra_vde_validate_frame(dev, &frames[i]);
+		ret = tegra_vde_validate_h264_frame(dev, &frames[i]);
 		if (ret)
 			goto release_dpb_frames;
 
@@ -865,81 +343,8 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 			goto release_dpb_frames;
 	}
 
-	ret = mutex_lock_interruptible(&vde->lock);
-	if (ret)
-		goto release_dpb_frames;
-
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
-		goto unlock;
-
-	/*
-	 * We rely on the VDE registers reset value, otherwise VDE
-	 * causes bus lockup.
-	 */
-	ret = reset_control_assert(vde->rst_mc);
-	if (ret) {
-		dev_err(dev, "DEC start: Failed to assert MC reset: %d\n",
-			ret);
-		goto put_runtime_pm;
-	}
-
-	ret = reset_control_reset(vde->rst);
-	if (ret) {
-		dev_err(dev, "DEC start: Failed to reset HW: %d\n", ret);
-		goto put_runtime_pm;
-	}
-
-	ret = reset_control_deassert(vde->rst_mc);
-	if (ret) {
-		dev_err(dev, "DEC start: Failed to deassert MC reset: %d\n",
-			ret);
-		goto put_runtime_pm;
-	}
-
-	ret = tegra_vde_setup_hw_context(vde, &ctx, dpb_frames,
-					 bitstream_data_addr,
-					 bitstream_data_size,
-					 macroblocks_nb);
-	if (ret)
-		goto put_runtime_pm;
-
-	tegra_vde_decode_frame(vde, macroblocks_nb);
-
-	timeout = wait_for_completion_interruptible_timeout(
-			&vde->decode_completion, msecs_to_jiffies(1000));
-	if (timeout == 0) {
-		bsev_ptr = tegra_vde_readl(vde, vde->bsev, 0x10);
-		macroblocks_nb = tegra_vde_readl(vde, vde->sxe, 0xC8) & 0x1FFF;
-		read_bytes = bsev_ptr ? bsev_ptr - bitstream_data_addr : 0;
-
-		dev_err(dev, "Decoding failed: read 0x%X bytes, %u macroblocks parsed\n",
-			read_bytes, macroblocks_nb);
-
-		ret = -EIO;
-	} else if (timeout < 0) {
-		ret = timeout;
-	}
-
-	/*
-	 * At first reset memory client to avoid resetting VDE HW in the
-	 * middle of DMA which could result into memory corruption or hang
-	 * the whole system.
-	 */
-	err = reset_control_assert(vde->rst_mc);
-	if (err)
-		dev_err(dev, "DEC end: Failed to assert MC reset: %d\n", err);
-
-	err = reset_control_assert(vde->rst);
-	if (err)
-		dev_err(dev, "DEC end: Failed to assert HW reset: %d\n", err);
-
-put_runtime_pm:
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
-
-unlock:
-	mutex_unlock(&vde->lock);
+	ret = tegra_vde_decode_h264(vde, &ctx, dpb_frames,
+				    bitstream_data_addr, bitstream_data_size);
 
 release_dpb_frames:
 	while (i--) {
@@ -1088,6 +493,7 @@ static int tegra_vde_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, vde);
 
 	vde->soc = of_device_get_match_data(&pdev->dev);
+	vde->dev = dev;
 
 	vde->sxe = devm_platform_ioremap_resource_byname(pdev, "sxe");
 	if (IS_ERR(vde->sxe))
diff --git a/drivers/staging/media/tegra-vde/vde.h b/drivers/staging/media/tegra-vde/vde.h
index bbd42b8d9991..8ba6a71e3e40 100644
--- a/drivers/staging/media/tegra-vde/vde.h
+++ b/drivers/staging/media/tegra-vde/vde.h
@@ -16,6 +16,15 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 
+#define ICMDQUE_WR		0x00
+#define CMDQUE_CONTROL		0x08
+#define INTR_STATUS		0x18
+#define BSE_INT_ENB		0x40
+#define BSE_CONFIG		0x44
+
+#define BSE_ICMDQUE_EMPTY	BIT(3)
+#define BSE_DMA_BUSY		BIT(23)
+
 struct clk;
 struct dma_buf;
 struct gen_pool;
@@ -23,6 +32,21 @@ struct iommu_group;
 struct iommu_domain;
 struct reset_control;
 struct dma_buf_attachment;
+struct tegra_vde_h264_frame;
+struct tegra_vde_h264_decoder_ctx;
+
+struct tegra_video_frame {
+	struct dma_buf_attachment *y_dmabuf_attachment;
+	struct dma_buf_attachment *cb_dmabuf_attachment;
+	struct dma_buf_attachment *cr_dmabuf_attachment;
+	struct dma_buf_attachment *aux_dmabuf_attachment;
+	dma_addr_t y_addr;
+	dma_addr_t cb_addr;
+	dma_addr_t cr_addr;
+	dma_addr_t aux_addr;
+	u32 frame_num;
+	u32 flags;
+};
 
 struct tegra_vde_soc {
 	bool supports_ref_pic_marking;
@@ -50,6 +74,7 @@ struct tegra_vde {
 	void __iomem *ppb;
 	void __iomem *vdma;
 	void __iomem *frameid;
+	struct device *dev;
 	struct mutex lock;
 	struct mutex map_lock;
 	struct list_head map_list;
@@ -66,10 +91,27 @@ struct tegra_vde {
 	struct iova *iova_resv_last_page;
 	const struct tegra_vde_soc *soc;
 	struct tegra_vde_bo *secure_bo;
+	dma_addr_t bitstream_data_addr;
 	dma_addr_t iram_lists_addr;
 	u32 *iram;
 };
 
+void tegra_vde_writel(struct tegra_vde *vde, u32 value, void __iomem *base,
+		      u32 offset);
+u32 tegra_vde_readl(struct tegra_vde *vde, void __iomem *base, u32 offset);
+void tegra_vde_set_bits(struct tegra_vde *vde, u32 mask, void __iomem *base,
+			u32 offset);
+
+int tegra_vde_validate_h264_frame(struct device *dev,
+				  struct tegra_vde_h264_frame *frame);
+int tegra_vde_validate_h264_ctx(struct device *dev,
+				struct tegra_vde_h264_decoder_ctx *ctx);
+int tegra_vde_decode_h264(struct tegra_vde *vde,
+			  struct tegra_vde_h264_decoder_ctx *ctx,
+			  struct tegra_video_frame *dpb_frames,
+			  dma_addr_t bitstream_data_addr,
+			  size_t bitstream_data_size);
+
 int tegra_vde_iommu_init(struct tegra_vde *vde);
 void tegra_vde_iommu_deinit(struct tegra_vde *vde);
 int tegra_vde_iommu_map(struct tegra_vde *vde,
-- 
2.33.1

