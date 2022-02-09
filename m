Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696404AEEF5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiBIKHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiBIKH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:07:28 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532D0C0DE7D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:06:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i6so1483644pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJ/IrBqAhY6ooqnqMfBHnDdwWCQ6xV2O1RBt+ef1ci0=;
        b=N+crAb7GboCVn8EoGJaKTdj12EZgoFOr5E0uUeCDocJxOOxCQmm7+kkhuo6QbPFNTL
         I2urBGBssOcez6I7Yli/shScZIrJ9m+n///Rz73MkLCl3i8wQ0n4bvALmLz/ThV0gO5D
         nNn+NGpTmK15sRbO8gG44uzAbqIdzu18PnWBhxZS3vfX3wuUsD/p6JvrwtejNn/pmliI
         SIEpghjyqYs5I/dnWhHk+4uUmbecvJno/tIlbjDoRVyncDx0xGjsFGfHfX62RQZj+SRE
         2bE++imMPoAbDZJMXmRuAPl/bzvSCmyxei8F8uNreAVXC8bssvvjUN6HfBVHIzuD3Cv5
         jz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJ/IrBqAhY6ooqnqMfBHnDdwWCQ6xV2O1RBt+ef1ci0=;
        b=RBCv9IXTHsgTeaD/BQM1hMusnpkYZT4YA0qVkPuigZswpyNO7EKncMCPDyKTtRDine
         LQHwNk20KFdugoJlv23GKHu46fidyNpJJ7HANXsEyjpI6OG16XyRTZ4caZUc2no5ACtC
         gsnMFSlqhJgGGkM52uHTdT2vS3TRkJ4e1LQKbRMalZbb+4qiFxuM2J6nubQNlAYLr1eC
         yjdFWwSAE+6v5qW3RZPNYnCa3nV2gYrHDynFz4yGOoNiOxbdZrwPEAxpiQR74j6jzJbo
         ehW0VdbBp9zT/7AogW84MIlcO4YHHDcl+bi8Q3tuywqocjj29wuS/9ehCusR1SYbNFl3
         R0pg==
X-Gm-Message-State: AOAM5329RN5t/J6D97Xu0k83mp1eJ82HfQyki3FNl+Bst3Z/VxnKI1I5
        GDaX09HQpWRabzpVmdBibUh6
X-Google-Smtp-Source: ABdhPJxO+V2Gyf0BR+/DJVYn+brrTUU8vKQd24+k0zoNtb3VBYNk9Qgfh3AJCWJfXgBL7LQPDl/ItA==
X-Received: by 2002:a63:8a4c:: with SMTP id y73mr1276800pgd.303.1644401178831;
        Wed, 09 Feb 2022 02:06:18 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:06:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 12/23] bus: mhi: ep: Add support for ring management
Date:   Wed,  9 Feb 2022 15:26:13 +0530
Message-Id: <20220209095624.26389-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
References: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/bus/mhi/ep/internal.h |  33 +++++
 drivers/bus/mhi/ep/main.c     |  58 +++++++-
 drivers/bus/mhi/ep/ring.c     | 267 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |  11 ++
 5 files changed, 369 insertions(+), 2 deletions(-)
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
index 2c756a90774c..48d6e9667d55 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -112,6 +112,18 @@ enum mhi_ep_execenv {
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
 enum mhi_ep_ring_type {
 	RING_TYPE_CMD = 0,
 	RING_TYPE_ER,
@@ -131,6 +143,11 @@ union mhi_ep_ring_ctx {
 	struct mhi_generic_ctx generic;
 };
 
+struct mhi_ep_ring_item {
+	struct list_head node;
+	struct mhi_ep_ring *ring;
+};
+
 struct mhi_ep_ring {
 	struct mhi_ep_cntrl *mhi_cntrl;
 	int (*ring_cb)(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
@@ -143,6 +160,9 @@ struct mhi_ep_ring {
 	u32 db_offset_h;
 	u32 db_offset_l;
 	u32 ch_id;
+	u32 er_index;
+	u32 irq_vector;
+	bool started;
 };
 
 struct mhi_ep_cmd {
@@ -168,6 +188,19 @@ struct mhi_ep_chan {
 	bool skip_td;
 };
 
+/* MHI Ring related functions */
+void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id);
+void mhi_ep_ring_reset(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring);
+int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
+		      union mhi_ep_ring_ctx *ctx);
+size_t mhi_ep_ring_addr2offset(struct mhi_ep_ring *ring, u64 ptr);
+int mhi_ep_process_ring(struct mhi_ep_ring *ring);
+int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *element);
+void mhi_ep_ring_inc_index(struct mhi_ep_ring *ring);
+int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
+int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
+int mhi_ep_update_wr_offset(struct mhi_ep_ring *ring);
+
 /* MMIO related functions */
 u32 mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset);
 void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 5a66d85d05b8..f907f76aa1f2 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -18,6 +18,47 @@
 
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
+static void mhi_ep_ring_worker(struct work_struct *work)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = container_of(work,
+				struct mhi_ep_cntrl, ring_work);
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ep_ring_item *itr, *tmp;
+	struct mhi_ep_ring *ring;
+	struct mhi_ep_chan *chan;
+	unsigned long flags;
+	LIST_HEAD(head);
+	int ret;
+
+	/* Process the command ring first */
+	ret = mhi_ep_process_ring(&mhi_cntrl->mhi_cmd->ring);
+	if (ret) {
+		dev_err(dev, "Error processing command ring\n");
+		return;
+	}
+
+	spin_lock_irqsave(&mhi_cntrl->list_lock, flags);
+	list_splice_tail_init(&mhi_cntrl->ch_db_list, &head);
+	spin_unlock_irqrestore(&mhi_cntrl->list_lock, flags);
+
+	/* Process the channel rings now */
+	list_for_each_entry_safe(itr, tmp, &head, node) {
+		list_del(&itr->node);
+		ring = itr->ring;
+		chan = &mhi_cntrl->mhi_chan[ring->ch_id];
+		mutex_lock(&chan->lock);
+		dev_dbg(dev, "Processing the ring for channel (%d)\n", ring->ch_id);
+		ret = mhi_ep_process_ring(ring);
+		if (ret) {
+			dev_err(dev, "Error processing ring for channel (%d)\n", ring->ch_id);
+			mutex_unlock(&chan->lock);
+			return;
+		}
+		mutex_unlock(&chan->lock);
+		kfree(itr);
+	}
+}
+
 static void mhi_ep_release_device(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
@@ -218,6 +259,17 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_free_ch;
 	}
 
+	INIT_WORK(&mhi_cntrl->ring_work, mhi_ep_ring_worker);
+
+	mhi_cntrl->ring_wq = alloc_workqueue("mhi_ep_ring_wq", 0, 0);
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
@@ -226,7 +278,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
 	if (mhi_cntrl->index < 0) {
 		ret = mhi_cntrl->index;
-		goto err_free_cmd;
+		goto err_destroy_ring_wq;
 	}
 
 	/* Allocate the controller device */
@@ -254,6 +306,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	put_device(&mhi_dev->dev);
 err_ida_free:
 	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
+err_destroy_ring_wq:
+	destroy_workqueue(mhi_cntrl->ring_wq);
 err_free_cmd:
 	kfree(mhi_cntrl->mhi_cmd);
 err_free_ch:
@@ -267,6 +321,8 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
 
+	destroy_workqueue(mhi_cntrl->ring_wq);
+
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_chan);
 
diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
new file mode 100644
index 000000000000..3eb02c9be5eb
--- /dev/null
+++ b/drivers/bus/mhi/ep/ring.c
@@ -0,0 +1,267 @@
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
+	rbase = le64_to_cpu(ring->ring_ctx->generic.rbase);
+
+	return (ptr - rbase) / sizeof(struct mhi_ep_ring_element);
+}
+
+static u32 mhi_ep_ring_num_elems(struct mhi_ep_ring *ring)
+{
+	return le64_to_cpu(ring->ring_ctx->generic.rlen) / sizeof(struct mhi_ep_ring_element);
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
+	if (start < end) {
+		copy_size = (end - start) * sizeof(struct mhi_ep_ring_element);
+		ret = mhi_cntrl->read_from_host(mhi_cntrl,
+						(le64_to_cpu(ring->ring_ctx->generic.rbase) +
+						(start * sizeof(struct mhi_ep_ring_element))),
+						&ring->ring_cache[start], copy_size);
+		if (ret < 0)
+			return ret;
+	} else {
+		copy_size = (ring->ring_size - start) * sizeof(struct mhi_ep_ring_element);
+		ret = mhi_cntrl->read_from_host(mhi_cntrl,
+						(le64_to_cpu(ring->ring_ctx->generic.rbase) +
+						(start * sizeof(struct mhi_ep_ring_element))),
+						&ring->ring_cache[start], copy_size);
+		if (ret < 0)
+			return ret;
+
+		if (end) {
+			ret = mhi_cntrl->read_from_host(mhi_cntrl,
+							le64_to_cpu(ring->ring_ctx->generic.rbase),
+							&ring->ring_cache[0],
+							end * sizeof(struct mhi_ep_ring_element));
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	dev_dbg(dev, "Cached ring: start %zu end %zu size %zu\n", start, end, copy_size);
+
+	return 0;
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
+int mhi_ep_update_wr_offset(struct mhi_ep_ring *ring)
+{
+	u64 wr_ptr;
+
+	wr_ptr = mhi_ep_mmio_get_db(ring);
+
+	return mhi_ep_cache_ring(ring, wr_ptr);
+}
+
+static int mhi_ep_process_ring_element(struct mhi_ep_ring *ring, size_t offset)
+{
+	struct mhi_ep_ring_element *el;
+
+	/* Get the element and invoke the respective callback */
+	el = &ring->ring_cache[offset];
+
+	return ring->ring_cb(ring, el);
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
+			dev_err(dev, "Error processing ch ring element: %zu\n", ring->rd_offset);
+
+		return ret;
+	}
+
+	/* Process command ring now */
+	while (ring->rd_offset != ring->wr_offset) {
+		ret = mhi_ep_process_ring_element(ring, ring->rd_offset);
+		if (ret) {
+			dev_err(dev, "Error processing cmd ring element: %zu\n", ring->rd_offset);
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
+int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	__le64 rbase = ring->ring_ctx->generic.rbase;
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
+	if (!num_free_elem) {
+		dev_err(dev, "No space left in the ring\n");
+		return -ENOSPC;
+	}
+
+	old_offset = ring->rd_offset;
+	mhi_ep_ring_inc_index(ring);
+
+	dev_dbg(dev, "Adding an element to ring at offset (%zu)\n", ring->rd_offset);
+
+	/* Update rp in ring context */
+	ring->ring_ctx->generic.rp = cpu_to_le64((ring->rd_offset * sizeof(*el))) + rbase;
+
+	/* Ensure that the ring pointer gets updated before writing the element to ring */
+	smp_wmb();
+
+	ret = mhi_cntrl->write_to_host(mhi_cntrl, el, (le64_to_cpu(rbase) +
+				       (old_offset * sizeof(*el))), sizeof(*el));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id)
+{
+	ring->type = type;
+	if (ring->type == RING_TYPE_CMD) {
+		ring->ring_cb = mhi_ep_process_cmd_ring;
+		ring->db_offset_h = CRDB_HIGHER;
+		ring->db_offset_l = CRDB_LOWER;
+	} else if (ring->type == RING_TYPE_CH) {
+		ring->ring_cb = mhi_ep_process_tre_ring;
+		ring->db_offset_h = CHDB_HIGHER_n(id);
+		ring->db_offset_l = CHDB_LOWER_n(id);
+		ring->ch_id = id;
+	} else {
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
+	if (ring->type == RING_TYPE_CH)
+		ring->er_index = le32_to_cpu(ring->ring_ctx->ch.erindex);
+
+	if (ring->type == RING_TYPE_ER)
+		ring->irq_vector = le32_to_cpu(ring->ring_ctx->ev.msivec);
+
+	/* During ring init, both rp and wp are equal */
+	ring->rd_offset = mhi_ep_ring_addr2offset(ring, le64_to_cpu(ring->ring_ctx->generic.rp));
+	ring->wr_offset = mhi_ep_ring_addr2offset(ring, le64_to_cpu(ring->ring_ctx->generic.rp));
+
+	/* Allocate ring cache memory for holding the copy of host ring */
+	ring->ring_cache = kcalloc(ring->ring_size, sizeof(struct mhi_ep_ring_element),
+				   GFP_KERNEL);
+	if (!ring->ring_cache)
+		return -ENOMEM;
+
+	ret = mhi_ep_cache_ring(ring, le64_to_cpu(ring->ring_ctx->generic.wp));
+	if (ret) {
+		dev_err(dev, "Failed to cache ring\n");
+		kfree(ring->ring_cache);
+		return ret;
+	}
+
+	ring->started = true;
+
+	return 0;
+}
+
+void mhi_ep_ring_reset(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring)
+{
+	ring->started = false;
+	kfree(ring->ring_cache);
+}
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 3d2ab7a5ccd7..33828a6c4e63 100644
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
@@ -93,6 +98,12 @@ struct mhi_ep_cntrl {
 	u64 ev_ctx_host_pa;
 	u64 cmd_ctx_host_pa;
 
+	struct workqueue_struct	*ring_wq;
+	struct work_struct ring_work;
+
+	struct list_head ch_db_list;
+	struct list_head st_transition_list;
+	spinlock_t list_lock;
 	struct mhi_ep_db_info chdb[4];
 
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
-- 
2.25.1

