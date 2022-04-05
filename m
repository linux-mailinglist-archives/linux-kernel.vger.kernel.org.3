Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C430B4F4C79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446881AbiDEXWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443723AbiDEPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EC618501D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m16so263361plx.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DwqVDSvJSfwZ0Ggknwzk5Wv74L0EXv0rJyFzegKHjo=;
        b=ca9JoHCMjMrC4rMH/Xq4vuiynj/Kmo1KadytiPfKQfvgXuwSeL3aQbg7eRt6sf9JWP
         sLyqrHcS+/JdnViHaFhNY/N83DY6gvnitF3QuTzhs9oXn6nNe1/di4fALnHAdqMoPRtK
         ovNcM1SN2CfCCYrZ3PTanIvcchJco6mc/YPjJEt8LgbackiUfvZ+ZXZ/IrWrpz9y5zkO
         rSsrbaWFoJOAcjfBFEP8tzzRkjrQ7tLj02Ouuzr2LMwTBSspGPXwDmIRilFuHW9lONXA
         Syq3fDeqgHv+FNktD1XivZiEb1C3ZTKbwDMoxIdQAHVUtJJbB1dK/eLg5R/QTD+yQtpx
         fEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DwqVDSvJSfwZ0Ggknwzk5Wv74L0EXv0rJyFzegKHjo=;
        b=ovtjTDo4d+Jpf1hh/4dksOQYwuV0XcStIbaBlwA7aQkMo3mlx583W7JRad3/8cg8zd
         0DyWUHQcwYbURcmkCBT0UJnPOUaeOAaCm/UmStTHJ4dReDTEb/c90joU43MoUoL/LelO
         mqtHzqQEbPsduUn5kMdXC0u8k9pi/UBQUyuiSI01awrWai5mrrZEVTmraEE2V8CTOUpb
         1Q4Z2hA7FPmOTyFQV0FQCNOH8aZtvnVNXcaK+CvELUxSuF+QznIpY5WowM18W6D5WN3l
         pZE9/3ybbMy09+1MgpHnD9D0Z07cusk/7mPZqi4WKzuoGtUlOFmNbeuwWyYS9x042G+i
         8z6w==
X-Gm-Message-State: AOAM5330aB68zKVWc1IndyZBjd02Q5Fedh3ThgdiYEhRMS7Ci47LkIzg
        q1XWYF9/XcD7xzpixhNVFE0CWmHvZTGF
X-Google-Smtp-Source: ABdhPJxknuQ+oQddPVamGJA1F0s1vpORFHDm8eHGbP0m+FWlNDjKb1nl2ZuNJEGmcxlEckD2u2THFg==
X-Received: by 2002:a17:902:f64e:b0:14d:20db:8478 with SMTP id m14-20020a170902f64e00b0014d20db8478mr3768320plg.158.1649167108806;
        Tue, 05 Apr 2022 06:58:28 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:58:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/18] bus: mhi: ep: Add support for ring management
Date:   Tue,  5 Apr 2022 19:27:41 +0530
Message-Id: <20220405135754.6622-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405135754.6622-1-manivannan.sadhasivam@linaro.org>
References: <20220405135754.6622-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/Makefile   |   2 +-
 drivers/bus/mhi/ep/internal.h |  18 +++
 drivers/bus/mhi/ep/ring.c     | 207 ++++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+), 1 deletion(-)
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
index 475425a30d85..d16b87061ac6 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -116,6 +116,11 @@ union mhi_ep_ring_ctx {
 	struct mhi_generic_ctx generic;
 };
 
+struct mhi_ep_ring_item {
+	struct list_head node;
+	struct mhi_ep_ring *ring;
+};
+
 struct mhi_ep_ring {
 	struct mhi_ep_cntrl *mhi_cntrl;
 	union mhi_ep_ring_ctx *ring_ctx;
@@ -128,6 +133,9 @@ struct mhi_ep_ring {
 	u32 db_offset_h;
 	u32 db_offset_l;
 	u32 ch_id;
+	u32 er_index;
+	u32 irq_vector;
+	bool started;
 };
 
 struct mhi_ep_cmd {
@@ -153,6 +161,16 @@ struct mhi_ep_chan {
 	bool skip_td;
 };
 
+/* MHI Ring related functions */
+void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id);
+void mhi_ep_ring_reset(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring);
+int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
+		      union mhi_ep_ring_ctx *ctx);
+size_t mhi_ep_ring_addr2offset(struct mhi_ep_ring *ring, u64 ptr);
+int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *element);
+void mhi_ep_ring_inc_index(struct mhi_ep_ring *ring);
+int mhi_ep_update_wr_offset(struct mhi_ep_ring *ring);
+
 /* MMIO related functions */
 u32 mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset);
 void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
new file mode 100644
index 000000000000..115518ec76a4
--- /dev/null
+++ b/drivers/bus/mhi/ep/ring.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/mhi_ep.h>
+#include "internal.h"
+
+size_t mhi_ep_ring_addr2offset(struct mhi_ep_ring *ring, u64 ptr)
+{
+	return (ptr - ring->rbase) / sizeof(struct mhi_ring_element);
+}
+
+static u32 mhi_ep_ring_num_elems(struct mhi_ep_ring *ring)
+{
+	__le64 rlen;
+
+	memcpy_fromio(&rlen, (void __iomem *) &ring->ring_ctx->generic.rlen, sizeof(u64));
+
+	return le64_to_cpu(rlen) / sizeof(struct mhi_ring_element);
+}
+
+void mhi_ep_ring_inc_index(struct mhi_ep_ring *ring)
+{
+	ring->rd_offset = (ring->rd_offset + 1) % ring->ring_size;
+}
+
+static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	size_t start, copy_size;
+	int ret;
+
+	/* Don't proceed in the case of event ring. This happens during mhi_ep_ring_start(). */
+	if (ring->type == RING_TYPE_ER)
+		return 0;
+
+	/* No need to cache the ring if write pointer is unmodified */
+	if (ring->wr_offset == end)
+		return 0;
+
+	start = ring->wr_offset;
+	if (start < end) {
+		copy_size = (end - start) * sizeof(struct mhi_ring_element);
+		ret = mhi_cntrl->read_from_host(mhi_cntrl, ring->rbase +
+						(start * sizeof(struct mhi_ring_element)),
+						&ring->ring_cache[start], copy_size);
+		if (ret < 0)
+			return ret;
+	} else {
+		copy_size = (ring->ring_size - start) * sizeof(struct mhi_ring_element);
+		ret = mhi_cntrl->read_from_host(mhi_cntrl, ring->rbase +
+						(start * sizeof(struct mhi_ring_element)),
+						&ring->ring_cache[start], copy_size);
+		if (ret < 0)
+			return ret;
+
+		if (end) {
+			ret = mhi_cntrl->read_from_host(mhi_cntrl, ring->rbase,
+							&ring->ring_cache[0],
+							end * sizeof(struct mhi_ring_element));
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
+/* TODO: Support for adding multiple ring elements to the ring */
+int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *el)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	size_t old_offset = 0;
+	u32 num_free_elem;
+	__le64 rp;
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
+	rp = cpu_to_le64(ring->rd_offset * sizeof(*el) + ring->rbase);
+	memcpy_toio((void __iomem *) &ring->ring_ctx->generic.rp, &rp, sizeof(u64));
+
+	ret = mhi_cntrl->write_to_host(mhi_cntrl, el, ring->rbase + (old_offset * sizeof(*el)),
+				       sizeof(*el));
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
+		ring->db_offset_h = EP_CRDB_HIGHER;
+		ring->db_offset_l = EP_CRDB_LOWER;
+	} else if (ring->type == RING_TYPE_CH) {
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
+	__le64 val;
+	int ret;
+
+	ring->mhi_cntrl = mhi_cntrl;
+	ring->ring_ctx = ctx;
+	ring->ring_size = mhi_ep_ring_num_elems(ring);
+	memcpy_fromio(&val, (void __iomem *) &ring->ring_ctx->generic.rbase, sizeof(u64));
+	ring->rbase = le64_to_cpu(val);
+
+	if (ring->type == RING_TYPE_CH)
+		ring->er_index = le32_to_cpu(ring->ring_ctx->ch.erindex);
+
+	if (ring->type == RING_TYPE_ER)
+		ring->irq_vector = le32_to_cpu(ring->ring_ctx->ev.msivec);
+
+	/* During ring init, both rp and wp are equal */
+	memcpy_fromio(&val, (void __iomem *) &ring->ring_ctx->generic.rp, sizeof(u64));
+	ring->rd_offset = mhi_ep_ring_addr2offset(ring, le64_to_cpu(val));
+	ring->wr_offset = mhi_ep_ring_addr2offset(ring, le64_to_cpu(val));
+
+	/* Allocate ring cache memory for holding the copy of host ring */
+	ring->ring_cache = kcalloc(ring->ring_size, sizeof(struct mhi_ring_element), GFP_KERNEL);
+	if (!ring->ring_cache)
+		return -ENOMEM;
+
+	memcpy_fromio(&val, (void __iomem *) &ring->ring_ctx->generic.wp, sizeof(u64));
+	ret = mhi_ep_cache_ring(ring, le64_to_cpu(val));
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
+	ring->ring_cache = NULL;
+}
-- 
2.25.1

