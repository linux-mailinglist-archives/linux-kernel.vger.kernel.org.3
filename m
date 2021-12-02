Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9F46627D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357446AbhLBLlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357483AbhLBLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:41:00 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919F6C0613E0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:37:37 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id u80so27651922pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmVcQr8PkVfv5VkFQ4HeP0jQQtjizWL5fbLHamvuirE=;
        b=YfWfnn9BEwD41/FWXEqxruKy5rneBA+0EljL4NfA0K7oMqAfjQpRQB5CKxjsA5K9Qd
         A6RQtm69ZgVHL8rX0fkTo0jYV4HOuT7Gl+B7KSlXXF8PEXBtnbvU+GX9FAueo4iGUMSo
         K/IyIF3tIBJ8Vl8UjyVXODff9OZl27B2dtk9bm8fr09nJygPIpqYcyeyQh1dKsAyUkMd
         WtsJ9pHz6p27BdFN5Gnhj/FTUexdwiQYd7+1ALBf4R4BkMb2muwhY7GhxJ9kqb8tYbMc
         kfkxlUftsx35ndWPBZgiIbM8ybsyrv/sMsPHs8/Y5PsDBkj6vupV+i4QCutjvBTnbF6i
         95bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmVcQr8PkVfv5VkFQ4HeP0jQQtjizWL5fbLHamvuirE=;
        b=k2bVQf7PGegZBwezTQ+yBo/ThpbdFlFy+VTtVfx9Jh5qAFnH+uXYjIuCmwAP7erUOE
         M5OI+2/iTNZpleLUymiICTdaNf0NXwOVrR4szYJ3N9uvEbKO5M8sv6p++sojmTlCpWEP
         sphDoBHTzs1nB0FskbnOfgvZXO9doW79EE/qAYcviJ4jNATzBM85v0t5c3jiRW2lItUQ
         Gyqhss2kOYKVkrKnwYcbYzuKFbfXieD61mSMEbUQBnsMvA+NkEuBqSz7MZTcNNY9yDsJ
         U74byNLYslYOKLKNS1QGKWHVstOG64aXvZ7yKn3u2SVB/ZLMwde73lPIf8dOOT0jMSsw
         j3Bw==
X-Gm-Message-State: AOAM530y8KzNI1Rv4P7PJDv7gMfSa+3Jof6Q18OOqfSi2DR4SEEtOh8t
        x2qtX8lGXJnxVTRbD+xAQe5f
X-Google-Smtp-Source: ABdhPJxWmOaqaIgx6PFn9wgRHOcBz5K+ue0Nt5LkPqimvo55LmVhS9z2IASXcwPqxc1EmTOhtE7tgg==
X-Received: by 2002:a63:b006:: with SMTP id h6mr9090487pgf.192.1638445057001;
        Thu, 02 Dec 2021 03:37:37 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:37:36 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/20] bus: mhi: ep: Add support for managing MMIO registers
Date:   Thu,  2 Dec 2021 17:05:40 +0530
Message-Id: <20211202113553.238011-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for managing the Memory Mapped Input Output (MMIO) registers
of the MHI bus. All MHI operations are carried out using the MMIO registers
by both host and the endpoint device.

The MMIO registers reside inside the endpoint device memory (fixed
location based on the platform) and the address is passed by the MHI EP
controller driver during its registration.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/Makefile   |   2 +-
 drivers/bus/mhi/ep/internal.h |  36 ++++
 drivers/bus/mhi/ep/main.c     |   6 +-
 drivers/bus/mhi/ep/mmio.c     | 303 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |  18 ++
 5 files changed, 363 insertions(+), 2 deletions(-)
 create mode 100644 drivers/bus/mhi/ep/mmio.c

diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
index 64e29252b608..a1555ae287ad 100644
--- a/drivers/bus/mhi/ep/Makefile
+++ b/drivers/bus/mhi/ep/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
-mhi_ep-y := main.o
+mhi_ep-y := main.o mmio.o
diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index 7b164daf4332..39eeb5f384e2 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -91,6 +91,12 @@ struct mhi_generic_ctx {
 	__u64 wp __packed __aligned(4);
 };
 
+enum mhi_ep_execenv {
+	MHI_EP_SBL_EE = 1,
+	MHI_EP_AMSS_EE = 2,
+	MHI_EP_UNRESERVED
+};
+
 enum mhi_ep_ring_state {
 	RING_STATE_UINT = 0,
 	RING_STATE_IDLE,
@@ -155,4 +161,34 @@ struct mhi_ep_chan {
 	bool skip_td;
 };
 
+/* MMIO related functions */
+void mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 *regval);
+void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
+void mhi_ep_mmio_masked_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset,
+			      u32 mask, u32 shift, u32 val);
+int mhi_ep_mmio_masked_read(struct mhi_ep_cntrl *dev, u32 offset,
+			    u32 mask, u32 shift, u32 *regval);
+void mhi_ep_mmio_enable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_disable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_enable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_disable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_enable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id);
+void mhi_ep_mmio_disable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id);
+void mhi_ep_mmio_enable_chdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_read_chdb_status_interrupts(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_mask_interrupts(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_get_chc_base(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_get_erc_base(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_get_crc_base(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_get_ch_db(struct mhi_ep_ring *ring, u64 *wr_offset);
+void mhi_ep_mmio_get_er_db(struct mhi_ep_ring *ring, u64 *wr_offset);
+void mhi_ep_mmio_get_cmd_db(struct mhi_ep_ring *ring, u64 *wr_offset);
+void mhi_ep_mmio_set_env(struct mhi_ep_cntrl *mhi_cntrl, u32 value);
+void mhi_ep_mmio_clear_reset(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_reset(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *state,
+			       bool *mhi_reset);
+void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
+
 #endif
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index f0b5f49db95a..fddf75dfb9c7 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -209,7 +209,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	struct mhi_ep_device *mhi_dev;
 	int ret;
 
-	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
+	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio)
 		return -EINVAL;
 
 	ret = parse_ch_cfg(mhi_cntrl, config);
@@ -222,6 +222,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_free_ch;
 	}
 
+	/* Set MHI version and AMSS EE before enumeration */
+	mhi_ep_mmio_write(mhi_cntrl, MHIVER, config->mhi_version);
+	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EP_AMSS_EE);
+
 	/* Set controller index */
 	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
 	if (mhi_cntrl->index < 0) {
diff --git a/drivers/bus/mhi/ep/mmio.c b/drivers/bus/mhi/ep/mmio.c
new file mode 100644
index 000000000000..157ef1240f6f
--- /dev/null
+++ b/drivers/bus/mhi/ep/mmio.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/mhi_ep.h>
+
+#include "internal.h"
+
+void mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 *regval)
+{
+	*regval = readl(mhi_cntrl->mmio + offset);
+}
+
+void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val)
+{
+	writel(val, mhi_cntrl->mmio + offset);
+}
+
+void mhi_ep_mmio_masked_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 mask,
+			       u32 shift, u32 val)
+{
+	u32 regval;
+
+	mhi_ep_mmio_read(mhi_cntrl, offset, &regval);
+	regval &= ~mask;
+	regval |= ((val << shift) & mask);
+	mhi_ep_mmio_write(mhi_cntrl, offset, regval);
+}
+
+int mhi_ep_mmio_masked_read(struct mhi_ep_cntrl *dev, u32 offset,
+			     u32 mask, u32 shift, u32 *regval)
+{
+	mhi_ep_mmio_read(dev, offset, regval);
+	*regval &= mask;
+	*regval >>= shift;
+
+	return 0;
+}
+
+void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *state,
+				bool *mhi_reset)
+{
+	u32 regval;
+
+	mhi_ep_mmio_read(mhi_cntrl, MHICTRL, &regval);
+	*state = FIELD_GET(MHICTRL_MHISTATE_MASK, regval);
+	*mhi_reset = !!FIELD_GET(MHICTRL_RESET_MASK, regval);
+}
+
+static void mhi_ep_mmio_mask_set_chdb_int_a7(struct mhi_ep_cntrl *mhi_cntrl,
+						u32 chdb_id, bool enable)
+{
+	u32 chid_mask, chid_idx, chid_shft, val = 0;
+
+	chid_shft = chdb_id % 32;
+	chid_mask = BIT(chid_shft);
+	chid_idx = chdb_id / 32;
+
+	if (chid_idx >= MHI_MASK_ROWS_CH_EV_DB)
+		return;
+
+	if (enable)
+		val = 1;
+
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(chid_idx),
+				  chid_mask, chid_shft, val);
+	mhi_ep_mmio_read(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(chid_idx),
+			  &mhi_cntrl->chdb[chid_idx].mask);
+}
+
+void mhi_ep_mmio_enable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id)
+{
+	mhi_ep_mmio_mask_set_chdb_int_a7(mhi_cntrl, chdb_id, true);
+}
+
+void mhi_ep_mmio_disable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id)
+{
+	mhi_ep_mmio_mask_set_chdb_int_a7(mhi_cntrl, chdb_id, false);
+}
+
+static void mhi_ep_mmio_set_chdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl, bool enable)
+{
+	u32 val = 0, i = 0;
+
+	if (enable)
+		val = MHI_CHDB_INT_MASK_A7_n_EN_ALL;
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++) {
+		mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(i), val);
+		mhi_cntrl->chdb[i].mask = val;
+	}
+}
+
+void mhi_ep_mmio_enable_chdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_set_chdb_interrupts(mhi_cntrl, true);
+}
+
+static void mhi_ep_mmio_mask_chdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_set_chdb_interrupts(mhi_cntrl, false);
+}
+
+void mhi_ep_mmio_read_chdb_status_interrupts(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 i;
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++)
+		mhi_ep_mmio_read(mhi_cntrl, MHI_CHDB_INT_STATUS_A7_n(i),
+				  &mhi_cntrl->chdb[i].status);
+}
+
+static void mhi_ep_mmio_set_erdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl, bool enable)
+{
+	u32 val = 0, i;
+
+	if (enable)
+		val = MHI_ERDB_INT_MASK_A7_n_EN_ALL;
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++)
+		mhi_ep_mmio_write(mhi_cntrl, MHI_ERDB_INT_MASK_A7_n(i), val);
+}
+
+static void mhi_ep_mmio_mask_erdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_set_erdb_interrupts(mhi_cntrl, false);
+}
+
+void mhi_ep_mmio_enable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CTRL_INT_MASK_A7,
+				  MHI_CTRL_MHICTRL_MASK,
+				  MHI_CTRL_MHICTRL_SHFT, 1);
+}
+
+void mhi_ep_mmio_disable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CTRL_INT_MASK_A7,
+				  MHI_CTRL_MHICTRL_MASK,
+				  MHI_CTRL_MHICTRL_SHFT, 0);
+}
+
+void mhi_ep_mmio_enable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CTRL_INT_MASK_A7,
+				  MHI_CTRL_CRDB_MASK,
+				  MHI_CTRL_CRDB_SHFT, 1);
+}
+
+void mhi_ep_mmio_disable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CTRL_INT_MASK_A7,
+				  MHI_CTRL_CRDB_MASK,
+				  MHI_CTRL_CRDB_SHFT, 0);
+}
+
+void mhi_ep_mmio_mask_interrupts(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_disable_ctrl_interrupt(mhi_cntrl);
+	mhi_ep_mmio_disable_cmdb_interrupt(mhi_cntrl);
+	mhi_ep_mmio_mask_chdb_interrupts(mhi_cntrl);
+	mhi_ep_mmio_mask_erdb_interrupts(mhi_cntrl);
+}
+
+static void mhi_ep_mmio_clear_interrupts(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 i = 0;
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++)
+		mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_CLEAR_A7_n(i),
+				   MHI_CHDB_INT_CLEAR_A7_n_CLEAR_ALL);
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++)
+		mhi_ep_mmio_write(mhi_cntrl, MHI_ERDB_INT_CLEAR_A7_n(i),
+				   MHI_ERDB_INT_CLEAR_A7_n_CLEAR_ALL);
+
+	mhi_ep_mmio_write(mhi_cntrl, MHI_CTRL_INT_CLEAR_A7,
+			   MHI_CTRL_INT_MMIO_WR_CLEAR |
+			   MHI_CTRL_INT_CRDB_CLEAR |
+			   MHI_CTRL_INT_CRDB_MHICTRL_CLEAR);
+}
+
+void mhi_ep_mmio_get_chc_base(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 ccabap_value = 0;
+
+	mhi_ep_mmio_read(mhi_cntrl, CCABAP_HIGHER, &ccabap_value);
+	mhi_cntrl->ch_ctx_host_pa = ccabap_value;
+	mhi_cntrl->ch_ctx_host_pa <<= 32;
+
+	mhi_ep_mmio_read(mhi_cntrl, CCABAP_LOWER, &ccabap_value);
+	mhi_cntrl->ch_ctx_host_pa |= ccabap_value;
+}
+
+void mhi_ep_mmio_get_erc_base(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 ecabap_value = 0;
+
+	mhi_ep_mmio_read(mhi_cntrl, ECABAP_HIGHER, &ecabap_value);
+	mhi_cntrl->ev_ctx_host_pa = ecabap_value;
+	mhi_cntrl->ev_ctx_host_pa <<= 32;
+
+	mhi_ep_mmio_read(mhi_cntrl, ECABAP_LOWER, &ecabap_value);
+	mhi_cntrl->ev_ctx_host_pa |= ecabap_value;
+}
+
+void mhi_ep_mmio_get_crc_base(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 crcbap_value = 0;
+
+	mhi_ep_mmio_read(mhi_cntrl, CRCBAP_HIGHER, &crcbap_value);
+	mhi_cntrl->cmd_ctx_host_pa = crcbap_value;
+	mhi_cntrl->cmd_ctx_host_pa <<= 32;
+
+	mhi_ep_mmio_read(mhi_cntrl, CRCBAP_LOWER, &crcbap_value);
+	mhi_cntrl->cmd_ctx_host_pa |= crcbap_value;
+}
+
+void mhi_ep_mmio_get_ch_db(struct mhi_ep_ring *ring, u64 *wr_ptr)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	u32 value = 0;
+
+	mhi_ep_mmio_read(mhi_cntrl, ring->db_offset_h, &value);
+	*wr_ptr = value;
+	*wr_ptr <<= 32;
+
+	mhi_ep_mmio_read(mhi_cntrl, ring->db_offset_l, &value);
+
+	*wr_ptr |= value;
+}
+
+void mhi_ep_mmio_get_er_db(struct mhi_ep_ring *ring, u64 *wr_ptr)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	u32 value = 0;
+
+	mhi_ep_mmio_read(mhi_cntrl, ring->db_offset_h, &value);
+	*wr_ptr = value;
+	*wr_ptr <<= 32;
+
+	mhi_ep_mmio_read(mhi_cntrl, ring->db_offset_l, &value);
+
+	*wr_ptr |= value;
+}
+
+void mhi_ep_mmio_get_cmd_db(struct mhi_ep_ring *ring, u64 *wr_ptr)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	u32 value = 0;
+
+	mhi_ep_mmio_read(mhi_cntrl, ring->db_offset_h, &value);
+	*wr_ptr = value;
+	*wr_ptr <<= 32;
+
+	mhi_ep_mmio_read(mhi_cntrl, ring->db_offset_l, &value);
+	*wr_ptr |= value;
+}
+
+void mhi_ep_mmio_set_env(struct mhi_ep_cntrl *mhi_cntrl, u32 value)
+{
+	mhi_ep_mmio_write(mhi_cntrl, BHI_EXECENV, value);
+}
+
+void mhi_ep_mmio_clear_reset(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHICTRL, MHICTRL_RESET_MASK,
+				  MHICTRL_RESET_SHIFT, 0);
+}
+
+void mhi_ep_mmio_reset(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_write(mhi_cntrl, MHICTRL, 0);
+	mhi_ep_mmio_write(mhi_cntrl, MHISTATUS, 0);
+	mhi_ep_mmio_clear_interrupts(mhi_cntrl);
+}
+
+void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	int mhi_cfg = 0;
+
+	mhi_ep_mmio_read(mhi_cntrl, CHDBOFF, &mhi_cntrl->chdb_offset);
+	mhi_ep_mmio_read(mhi_cntrl, ERDBOFF, &mhi_cntrl->erdb_offset);
+
+	mhi_ep_mmio_read(mhi_cntrl, MHICFG, &mhi_cfg);
+	mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, mhi_cfg);
+	mhi_cntrl->hw_event_rings = FIELD_GET(MHICFG_NHWER_MASK, mhi_cfg);
+
+	mhi_ep_mmio_reset(mhi_cntrl);
+}
+
+void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	int mhi_cfg = 0;
+
+	mhi_ep_mmio_read(mhi_cntrl, MHICFG, &mhi_cfg);
+	mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, mhi_cfg);
+	mhi_cntrl->hw_event_rings = FIELD_GET(MHICFG_NHWER_MASK, mhi_cfg);
+}
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index bc72c197db4d..902c8febd856 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -59,6 +59,10 @@ struct mhi_ep_db_info {
  * @mhi_event: Points to the event ring configurations table
  * @mhi_cmd: Points to the command ring configurations table
  * @sm: MHI Endpoint state machine
+ * @ch_ctx_host_pa: Physical address of host channel context data structure
+ * @ev_ctx_host_pa: Physical address of host event context data structure
+ * @cmd_ctx_host_pa: Physical address of host command context data structure
+ * @chdb: Array of channel doorbell interrupt info
  * @raise_irq: CB function for raising IRQ to the host
  * @alloc_addr: CB function for allocating memory in endpoint for storing host context
  * @map_addr: CB function for mapping host context to endpoint
@@ -66,6 +70,10 @@ struct mhi_ep_db_info {
  * @unmap_addr: CB function to unmap the host context in endpoint
  * @mhi_state: MHI Endpoint state
  * @max_chan: Maximum channels supported by the endpoint controller
+ * @event_rings: Number of event rings supported by the endpoint controller
+ * @hw_event_rings: Number of hardware event rings supported by the endpoint controller
+ * @chdb_offset: Channel doorbell offset set by the host
+ * @erdb_offset: Event ring doorbell offset set by the host
  * @index: MHI Endpoint controller index
  */
 struct mhi_ep_cntrl {
@@ -78,6 +86,12 @@ struct mhi_ep_cntrl {
 	struct mhi_ep_cmd *mhi_cmd;
 	struct mhi_ep_sm *sm;
 
+	u64 ch_ctx_host_pa;
+	u64 ev_ctx_host_pa;
+	u64 cmd_ctx_host_pa;
+
+	struct mhi_ep_db_info chdb[4];
+
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl);
 	void __iomem *(*alloc_addr)(struct mhi_ep_cntrl *mhi_cntrl,
 				  phys_addr_t *phys_addr, size_t size);
@@ -91,6 +105,10 @@ struct mhi_ep_cntrl {
 	enum mhi_state mhi_state;
 
 	u32 max_chan;
+	u32 event_rings;
+	u32 hw_event_rings;
+	u32 chdb_offset;
+	u32 erdb_offset;
 	int index;
 };
 
-- 
2.25.1

