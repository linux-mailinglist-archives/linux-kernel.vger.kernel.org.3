Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B9B466283
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357421AbhLBLlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357531AbhLBLlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:41:24 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A1DC0613ED
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:37:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so4406011pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UENFBa0oIATirSmaEsUpUKVLwIwkCskxaXXfm167osA=;
        b=EB6dyHpCb/1LAHOK2w2UoXAf0q1ma4ACbErIX18mqix81xmzIJ9Fa/iMz3/p24HwYL
         1IdinTgR9HFle0Pdz0zJtVY49IeNXAWGljzH6CAni3tQMNyMe4E1QGt1TOHbaj4BaOOF
         GpTZi26z7BPxc6VTejP8WecMXik4Ks9f33BkoxD4mxIO2ovfduerXbPQ0Og5plM3I8Px
         LzRx+jr2cUScaPep7aM1aG0opdiNAuPrM5wK41A8H3zsSwJmbRQzX3vCH1kedjVYbtk0
         xZ7XAmPYNVrgMPoHigSLRy6rsyOoSi43CGvNjQjAyK3wbRyoqF3cQRuTMkNgXNRYIMdY
         D76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UENFBa0oIATirSmaEsUpUKVLwIwkCskxaXXfm167osA=;
        b=SAGb753f4mhOZ6RlODhQgHtNtGmcYK1Nnyqwfr0F23HTvs7RUjrM64iIec5u8fXBt0
         +czhRvuu8G4SRZqZ6vIvaOnceZ95bTsyMvbHR/mnOgxRms5maKTp73xX4/fVrsT9IlUC
         CUUR9uyexllMJmGHkSFDRDmq+/QsO7CUM8xsEK7Yeni8Eie8/X97bUG7R/qNdZ8+7cqu
         RmJrNU4yMZueztgoXwTyxq2t78Xm0rrn6QNmcnk5Bwl7gIpH9kiwqGMSrZLAcuIF5yRD
         aoxsoSxSKvnovh/tuBtczJJfRWUVNZSDjG3tBgaQgr8gOeJ8Kp0GrNT8BoRvFw2Ams9B
         3ozQ==
X-Gm-Message-State: AOAM532Q+3Ll36RfK14g2lZBVB5wS9kt4utBCpYlgPCX3fxPXgg9Hq19
        alDSYRBmRgcv+f5gVE0l1jP8
X-Google-Smtp-Source: ABdhPJxSLWSF/CErNnJGBpM68C75FG1aAUryuaA/9zuUFBxPopHst54qAOQZ43AiE9Knpw0pQeJEZg==
X-Received: by 2002:a17:903:30cd:b0:141:c6dd:4d03 with SMTP id s13-20020a17090330cd00b00141c6dd4d03mr14890321plc.16.1638445061865;
        Thu, 02 Dec 2021 03:37:41 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:37:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/20] bus: mhi: ep: Add support for ring management
Date:   Thu,  2 Dec 2021 17:05:41 +0530
Message-Id: <20211202113553.238011-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for managing the MHI ring. The MHI ring is a circular queue
of data structures used to pass the information between host and the
endpoint.

MHI support 3 types of rings:

1. Transfer ring
2. Event ring
3. Command ring

All rings reside inside the host memory and the MHI EP device maps it to
the device memory using blocks like PCIe iATU. The mapping is handled in
the MHI EP controller driver itself.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/Makefile   |   2 +-
 drivers/bus/mhi/ep/internal.h |  23 +++
 drivers/bus/mhi/ep/main.c     |  53 +++++-
 drivers/bus/mhi/ep/ring.c     | 314 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |  11 ++
 5 files changed, 401 insertions(+), 2 deletions(-)
 create mode 100644 drivers/bus/mhi/ep/ring.c

diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
index a1555ae287ad..7ba0e04801eb 100644
--- a/drivers/bus/mhi/ep/Makefile
+++ b/drivers/bus/mhi/ep/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
-mhi_ep-y := main.o mmio.o
+mhi_ep-y := main.o mmio.o ring.o
diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index 39eeb5f384e2..a7a4e6934f7d 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -97,6 +97,18 @@ enum mhi_ep_execenv {
 	MHI_EP_UNRESERVED
 };
 
+/* Transfer Ring Element macros */
+#define MHI_EP_TRE_PTR(ptr) (ptr)
+#define MHI_EP_TRE_DWORD0(len) (len & MHI_MAX_MTU)
+#define MHI_EP_TRE_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
+	| (ieot << 9) | (ieob << 8) | chain)
+#define MHI_EP_TRE_GET_PTR(tre) ((tre)->ptr)
+#define MHI_EP_TRE_GET_LEN(tre) ((tre)->dword[0] & 0xffff)
+#define MHI_EP_TRE_GET_CHAIN(tre) FIELD_GET(BIT(0), (tre)->dword[1])
+#define MHI_EP_TRE_GET_IEOB(tre) FIELD_GET(BIT(8), (tre)->dword[1])
+#define MHI_EP_TRE_GET_IEOT(tre) FIELD_GET(BIT(9), (tre)->dword[1])
+#define MHI_EP_TRE_GET_BEI(tre) FIELD_GET(BIT(10), (tre)->dword[1])
+
 enum mhi_ep_ring_state {
 	RING_STATE_UINT = 0,
 	RING_STATE_IDLE,
@@ -161,6 +173,17 @@ struct mhi_ep_chan {
 	bool skip_td;
 };
 
+/* MHI Ring related functions */
+void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id);
+void mhi_ep_ring_stop(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring);
+size_t mhi_ep_ring_addr2offset(struct mhi_ep_ring *ring, u64 ptr);
+int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
+		      union mhi_ep_ring_ctx *ctx);
+int mhi_ep_process_ring(struct mhi_ep_ring *ring);
+int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *element,
+			    int evt_offset);
+void mhi_ep_ring_inc_index(struct mhi_ep_ring *ring);
+
 /* MMIO related functions */
 void mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 *regval);
 void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index fddf75dfb9c7..6d448d42f527 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -18,6 +18,42 @@
 
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
+static void mhi_ep_ring_worker(struct work_struct *work)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = container_of(work,
+				struct mhi_ep_cntrl, ring_work);
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ep_ring *ring;
+	struct list_head *cp, *q;
+	unsigned long flags;
+	int ret = 0;
+
+	/* Process the command ring first */
+	ret = mhi_ep_process_ring(&mhi_cntrl->mhi_cmd->ring);
+	if (ret) {
+		dev_err(dev, "Error processing command ring\n");
+		goto err_unlock;
+	}
+
+	spin_lock_irqsave(&mhi_cntrl->list_lock, flags);
+	/* Process the channel rings now */
+	list_for_each_safe(cp, q, &mhi_cntrl->ch_db_list) {
+		ring = list_entry(cp, struct mhi_ep_ring, list);
+		list_del(cp);
+		ret = mhi_ep_process_ring(ring);
+		if (ret) {
+			dev_err(dev, "Error processing channel ring: %d\n", ring->ch_id);
+			goto err_unlock;
+		}
+
+		/* Re-enable channel interrupt */
+		mhi_ep_mmio_enable_chdb_a7(mhi_cntrl, ring->ch_id);
+	}
+
+err_unlock:
+	spin_unlock_irqrestore(&mhi_cntrl->list_lock, flags);
+}
+
 static void mhi_ep_release_device(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
@@ -222,6 +258,17 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_free_ch;
 	}
 
+	INIT_WORK(&mhi_cntrl->ring_work, mhi_ep_ring_worker);
+
+	mhi_cntrl->ring_wq = alloc_ordered_workqueue("mhi_ep_ring_wq", WQ_HIGHPRI);
+	if (!mhi_cntrl->ring_wq) {
+		ret = -ENOMEM;
+		goto err_free_cmd;
+	}
+
+	INIT_LIST_HEAD(&mhi_cntrl->ch_db_list);
+	spin_lock_init(&mhi_cntrl->list_lock);
+
 	/* Set MHI version and AMSS EE before enumeration */
 	mhi_ep_mmio_write(mhi_cntrl, MHIVER, config->mhi_version);
 	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EP_AMSS_EE);
@@ -230,7 +277,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
 	if (mhi_cntrl->index < 0) {
 		ret = mhi_cntrl->index;
-		goto err_free_cmd;
+		goto err_destroy_ring_wq;
 	}
 
 	/* Allocate the controller device */
@@ -259,6 +306,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	put_device(&mhi_dev->dev);
 err_ida_free:
 	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
+err_destroy_ring_wq:
+	destroy_workqueue(mhi_cntrl->ring_wq);
 err_free_cmd:
 	kfree(mhi_cntrl->mhi_cmd);
 err_free_ch:
@@ -272,6 +321,8 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
 
+	destroy_workqueue(mhi_cntrl->ring_wq);
+
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_chan);
 
diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
new file mode 100644
index 000000000000..763b8506d309
--- /dev/null
+++ b/drivers/bus/mhi/ep/ring.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/mhi_ep.h>
+#include "internal.h"
+
+size_t mhi_ep_ring_addr2offset(struct mhi_ep_ring *ring, u64 ptr)
+{
+	u64 rbase;
+
+	rbase = ring->ring_ctx->generic.rbase;
+
+	return (ptr - rbase) / sizeof(struct mhi_ep_ring_element);
+}
+
+static u32 mhi_ep_ring_num_elems(struct mhi_ep_ring *ring)
+{
+	return ring->ring_ctx->generic.rlen / sizeof(struct mhi_ep_ring_element);
+}
+
+void mhi_ep_ring_inc_index(struct mhi_ep_ring *ring)
+{
+	ring->rd_offset++;
+	if (ring->rd_offset == ring->ring_size)
+		ring->rd_offset = 0;
+}
+
+static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	size_t start, copy_size;
+	struct mhi_ep_ring_element *ring_shadow;
+	phys_addr_t ring_shadow_phys;
+	size_t size = ring->ring_size * sizeof(struct mhi_ep_ring_element);
+	int ret;
+
+	/* No need to cache event rings */
+	if (ring->type == RING_TYPE_ER)
+		return 0;
+
+	/* No need to cache the ring if write pointer is unmodified */
+	if (ring->wr_offset == end)
+		return 0;
+
+	start = ring->wr_offset;
+
+	/* Allocate memory for host ring */
+	ring_shadow = mhi_cntrl->alloc_addr(mhi_cntrl, &ring_shadow_phys,
+					   size);
+	if (!ring_shadow) {
+		dev_err(dev, "Failed to allocate memory for ring_shadow\n");
+		return -ENOMEM;
+	}
+
+	/* Map host ring */
+	ret = mhi_cntrl->map_addr(mhi_cntrl, ring_shadow_phys,
+				  ring->ring_ctx->generic.rbase, size);
+	if (ret) {
+		dev_err(dev, "Failed to map ring_shadow\n\n");
+		goto err_ring_free;
+	}
+
+	dev_dbg(dev, "Caching ring: start %d end %d size %d", start, end, copy_size);
+
+	if (start < end) {
+		copy_size = (end - start) * sizeof(struct mhi_ep_ring_element);
+		memcpy_fromio(&ring->ring_cache[start], &ring_shadow[start], copy_size);
+	} else {
+		copy_size = (ring->ring_size - start) * sizeof(struct mhi_ep_ring_element);
+		memcpy_fromio(&ring->ring_cache[start], &ring_shadow[start], copy_size);
+		if (end)
+			memcpy_fromio(&ring->ring_cache[0], &ring_shadow[0],
+					end * sizeof(struct mhi_ep_ring_element));
+	}
+
+	/* Now unmap and free host ring */
+	mhi_cntrl->unmap_addr(mhi_cntrl, ring_shadow_phys);
+	mhi_cntrl->free_addr(mhi_cntrl, ring_shadow_phys, ring_shadow, size);
+
+	return 0;
+
+err_ring_free:
+	mhi_cntrl->free_addr(mhi_cntrl, ring_shadow_phys, &ring_shadow, size);
+
+	return ret;
+}
+
+static int mhi_ep_cache_ring(struct mhi_ep_ring *ring, u64 wr_ptr)
+{
+	size_t wr_offset;
+	int ret;
+
+	wr_offset = mhi_ep_ring_addr2offset(ring, wr_ptr);
+
+	/* Cache the host ring till write offset */
+	ret = __mhi_ep_cache_ring(ring, wr_offset);
+	if (ret)
+		return ret;
+
+	ring->wr_offset = wr_offset;
+
+	return 0;
+}
+
+static int mhi_ep_update_wr_offset(struct mhi_ep_ring *ring)
+{
+	u64 wr_ptr;
+
+	switch (ring->type) {
+	case RING_TYPE_CMD:
+		mhi_ep_mmio_get_cmd_db(ring, &wr_ptr);
+		break;
+	case RING_TYPE_ER:
+		mhi_ep_mmio_get_er_db(ring, &wr_ptr);
+		break;
+	case RING_TYPE_CH:
+		mhi_ep_mmio_get_ch_db(ring, &wr_ptr);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return mhi_ep_cache_ring(ring, wr_ptr);
+}
+
+static int mhi_ep_process_ring_element(struct mhi_ep_ring *ring, size_t offset)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ep_ring_element *el;
+	int ret = -ENODEV;
+
+	/* Get the element and invoke the respective callback */
+	el = &ring->ring_cache[offset];
+
+	if (ring->ring_cb)
+		ret = ring->ring_cb(ring, el);
+	else
+		dev_err(dev, "No callback registered for ring\n");
+
+	return ret;
+}
+
+int mhi_ep_process_ring(struct mhi_ep_ring *ring)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret = 0;
+
+	/* Event rings should not be processed */
+	if (ring->type == RING_TYPE_ER)
+		return -EINVAL;
+
+	dev_dbg(dev, "Processing ring of type: %d\n", ring->type);
+
+	/* Update the write offset for the ring */
+	ret = mhi_ep_update_wr_offset(ring);
+	if (ret) {
+		dev_err(dev, "Error updating write offset for ring\n");
+		return ret;
+	}
+
+	/* Sanity check to make sure there are elements in the ring */
+	if (ring->rd_offset == ring->wr_offset)
+		return 0;
+
+	/* Process channel ring first */
+	if (ring->type == RING_TYPE_CH) {
+		ret = mhi_ep_process_ring_element(ring, ring->rd_offset);
+		if (ret)
+			dev_err(dev, "Error processing ch ring element: %d\n", ring->rd_offset);
+
+		return ret;
+	}
+
+	/* Process command ring now */
+	while (ring->rd_offset != ring->wr_offset) {
+		ret = mhi_ep_process_ring_element(ring, ring->rd_offset);
+		if (ret) {
+			dev_err(dev, "Error processing cmd ring element: %d\n", ring->rd_offset);
+			return ret;
+		}
+
+		mhi_ep_ring_inc_index(ring);
+	}
+
+	return 0;
+}
+
+/* TODO: Support for adding multiple ring elements to the ring */
+int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el, int size)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ep_ring_element *ring_shadow;
+	size_t ring_size = ring->ring_size * sizeof(struct mhi_ep_ring_element);
+	phys_addr_t ring_shadow_phys;
+	size_t old_offset = 0;
+	u32 num_free_elem;
+	int ret;
+
+	ret = mhi_ep_update_wr_offset(ring);
+	if (ret) {
+		dev_err(dev, "Error updating write pointer\n");
+		return ret;
+	}
+
+	if (ring->rd_offset < ring->wr_offset)
+		num_free_elem = (ring->wr_offset - ring->rd_offset) - 1;
+	else
+		num_free_elem = ((ring->ring_size - ring->rd_offset) + ring->wr_offset) - 1;
+
+	/* Check if there is space in ring for adding at least an element */
+	if (num_free_elem < 1) {
+		dev_err(dev, "No space left in the ring\n");
+		return -ENOSPC;
+	}
+
+	old_offset = ring->rd_offset;
+	mhi_ep_ring_inc_index(ring);
+
+	dev_dbg(dev, "Adding an element to ring at offset (%d)\n", ring->rd_offset);
+
+	/* Update rp in ring context */
+	ring->ring_ctx->generic.rp = (ring->rd_offset * sizeof(struct mhi_ep_ring_element)) +
+				      ring->ring_ctx->generic.rbase;
+
+	/* Allocate memory for host ring */
+	ring_shadow = mhi_cntrl->alloc_addr(mhi_cntrl, &ring_shadow_phys, ring_size);
+	if (!ring_shadow) {
+		dev_err(dev, "failed to allocate ring_shadow\n");
+		return -ENOMEM;
+	}
+
+	/* Map host ring */
+	ret = mhi_cntrl->map_addr(mhi_cntrl, ring_shadow_phys,
+				  ring->ring_ctx->generic.rbase, ring_size);
+	if (ret) {
+		dev_err(dev, "failed to map ring_shadow\n\n");
+		goto err_ring_free;
+	}
+
+	/* Copy the element to ring */
+	memcpy_toio(&ring_shadow[old_offset], el, sizeof(struct mhi_ep_ring_element));
+
+	/* Now unmap and free host ring */
+	mhi_cntrl->unmap_addr(mhi_cntrl, ring_shadow_phys);
+	mhi_cntrl->free_addr(mhi_cntrl, ring_shadow_phys, ring_shadow, ring_size);
+
+	return 0;
+
+err_ring_free:
+	mhi_cntrl->free_addr(mhi_cntrl, ring_shadow_phys, ring_shadow, ring_size);
+
+	return ret;
+}
+
+void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id)
+{
+	ring->state = RING_STATE_UINT;
+	ring->type = type;
+	if (ring->type == RING_TYPE_CMD) {
+		ring->db_offset_h = CRDB_HIGHER;
+		ring->db_offset_l = CRDB_LOWER;
+	} else if (ring->type == RING_TYPE_CH) {
+		ring->db_offset_h = CHDB_HIGHER_n(id);
+		ring->db_offset_l = CHDB_LOWER_n(id);
+		ring->ch_id = id;
+	} else if (ring->type == RING_TYPE_ER) {
+		ring->db_offset_h = ERDB_HIGHER_n(id);
+		ring->db_offset_l = ERDB_LOWER_n(id);
+	}
+}
+
+int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
+			union mhi_ep_ring_ctx *ctx)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret;
+
+	ring->mhi_cntrl = mhi_cntrl;
+	ring->ring_ctx = ctx;
+	ring->ring_size = mhi_ep_ring_num_elems(ring);
+
+	/* During ring init, both rp and wp are equal */
+	ring->rd_offset = mhi_ep_ring_addr2offset(ring, ring->ring_ctx->generic.rp);
+	ring->wr_offset = mhi_ep_ring_addr2offset(ring, ring->ring_ctx->generic.rp);
+	ring->state = RING_STATE_IDLE;
+
+	/* Allocate ring cache memory for holding the copy of host ring */
+	ring->ring_cache = kcalloc(ring->ring_size, sizeof(struct mhi_ep_ring_element),
+				   GFP_KERNEL);
+	if (!ring->ring_cache)
+		return -ENOMEM;
+
+	ret = mhi_ep_cache_ring(ring, ring->ring_ctx->generic.wp);
+	if (ret) {
+		dev_err(dev, "Failed to cache ring\n");
+		kfree(ring->ring_cache);
+		return ret;
+	}
+
+	return 0;
+}
+
+void mhi_ep_ring_stop(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring)
+{
+	ring->state = RING_STATE_UINT;
+	kfree(ring->ring_cache);
+}
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 902c8febd856..729f4b802b74 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -62,6 +62,11 @@ struct mhi_ep_db_info {
  * @ch_ctx_host_pa: Physical address of host channel context data structure
  * @ev_ctx_host_pa: Physical address of host event context data structure
  * @cmd_ctx_host_pa: Physical address of host command context data structure
+ * @ring_wq: Dedicated workqueue for processing MHI rings
+ * @ring_work: Ring worker
+ * @ch_db_list: List of queued channel doorbells
+ * @st_transition_list: List of state transitions
+ * @list_lock: Lock for protecting state transition and channel doorbell lists
  * @chdb: Array of channel doorbell interrupt info
  * @raise_irq: CB function for raising IRQ to the host
  * @alloc_addr: CB function for allocating memory in endpoint for storing host context
@@ -90,6 +95,12 @@ struct mhi_ep_cntrl {
 	u64 ev_ctx_host_pa;
 	u64 cmd_ctx_host_pa;
 
+	struct workqueue_struct	*ring_wq;
+	struct work_struct ring_work;
+
+	struct list_head ch_db_list;
+	struct list_head st_transition_list;
+	spinlock_t list_lock;
 	struct mhi_ep_db_info chdb[4];
 
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl);
-- 
2.25.1

