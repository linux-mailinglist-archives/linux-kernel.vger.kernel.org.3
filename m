Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848B54B3752
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiBLSWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:22:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiBLSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:22:45 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3765A5FF36
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:22:37 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u12so7230439plf.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nX8pUBwKky2LdiFf9TxlzbYf+tv5DdGbcpHlM/nAQUg=;
        b=it0CBKz3c7dJqQf2nVMGHjZH5xYvHc4sqnB+4rLvJLH5/u/ltaTjqV2XFDXLAyuh7S
         SWd7C8909p8YcgnYpTU+HpPJLMEbIJabinW5b3Z7MbOuj4k6rFRSe4QaO0FYUyKC1Rx2
         QEnTeikKU1uDWlKS8phuZK4Bf722w5mUp7BJpAGbx5PPFH66EesmpPHxGWyjnoVnNTb3
         RnJcyR4dRyspsjsglTXSuxje190DUfBL3ZfHEed5LNQhpritTIP9I7bcavvgNNb4TTp0
         vEL6ujNIN05+hP8rkJJTzaamWnV0YqGIP5CN3iV8SB8lnP2VmKPHm2NnV7aaNjUct+t1
         QX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nX8pUBwKky2LdiFf9TxlzbYf+tv5DdGbcpHlM/nAQUg=;
        b=2iDq5uCaH4J1mMbTbSt8JSH6SmbxMq8Z/zDf/6flmnFbJuEifvQIfYhn/sjhl5votn
         Ps8n0Krf2eAWB52FysqqcmNIk+s5yc5iG3Jvc7449QuGLWdMwcZUhdYjO/6llp1x6oVb
         PYlq+eCR+dLMfyGbpBsTecCmbmCXkvCNGIx2ec4xvGoCWs70IQLEFqeXRNm4fmIe6f1e
         jil59xs0gkcKxjXO37n1YAXwLX02B5m94fgBzvOkb16h2VBL/qc0BUK84HZqFXNoqw4A
         AoQOXPnVM3EGqY/1V/U1Zj6DlDMM7VHYm1/5kcYsQap6mqbdgMoil1YRId0Z6X68eXQf
         doaQ==
X-Gm-Message-State: AOAM5323cTYmWLOnyVX8Bx1BA9gx9S/LAE38IjSD7rkzxp1D4pbAukkJ
        WAHFdqf6UUkY4ycvrWrNDCIt
X-Google-Smtp-Source: ABdhPJyR0fVwxQfwWTuBT4QJjgZVgtj9CxeGwWUq5Tw1ivSsdSY1Fo/pOyo8iQrD4pi/3VEHFbx+MA==
X-Received: by 2002:a17:902:c3d5:: with SMTP id j21mr6886426plj.59.1644690157332;
        Sat, 12 Feb 2022 10:22:37 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:22:36 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 11/25] bus: mhi: ep: Add support for managing MMIO registers
Date:   Sat, 12 Feb 2022 23:51:03 +0530
Message-Id: <20220212182117.49438-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
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

Add support for managing the Memory Mapped Input Output (MMIO) registers
of the MHI bus. All MHI operations are carried out using the MMIO registers
by both host and the endpoint device.

The MMIO registers reside inside the endpoint device memory (fixed
location based on the platform) and the address is passed by the MHI EP
controller driver during its registration.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/Makefile   |   2 +-
 drivers/bus/mhi/ep/internal.h |  37 +++++
 drivers/bus/mhi/ep/main.c     |   6 +-
 drivers/bus/mhi/ep/mmio.c     | 274 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |  18 +++
 5 files changed, 335 insertions(+), 2 deletions(-)
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
index e313a2546664..2c756a90774c 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -101,6 +101,17 @@ struct mhi_generic_ctx {
 	__u64 wp __packed __aligned(4);
 };
 
+/**
+ * enum mhi_ep_execenv - MHI Endpoint Execution Environment
+ * @MHI_EP_SBL_EE: Secondary Bootloader
+ * @MHI_EP_AMSS_EE: Advanced Mode Subscriber Software
+ */
+enum mhi_ep_execenv {
+	MHI_EP_SBL_EE = 1,
+	MHI_EP_AMSS_EE = 2,
+	MHI_EP_UNRESERVED
+};
+
 enum mhi_ep_ring_type {
 	RING_TYPE_CMD = 0,
 	RING_TYPE_ER,
@@ -157,4 +168,30 @@ struct mhi_ep_chan {
 	bool skip_td;
 };
 
+/* MMIO related functions */
+u32 mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset);
+void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
+void mhi_ep_mmio_masked_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 mask, u32 val);
+u32 mhi_ep_mmio_masked_read(struct mhi_ep_cntrl *dev, u32 offset, u32 mask);
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
+u64 mhi_ep_mmio_get_db(struct mhi_ep_ring *ring);
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
index fcaacf9ddbd1..950b5bcabe18 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -205,7 +205,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	struct mhi_ep_device *mhi_dev;
 	int ret;
 
-	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
+	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio)
 		return -EINVAL;
 
 	ret = parse_ch_cfg(mhi_cntrl, config);
@@ -218,6 +218,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
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
index 000000000000..58e887beb050
--- /dev/null
+++ b/drivers/bus/mhi/ep/mmio.c
@@ -0,0 +1,274 @@
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
+u32 mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset)
+{
+	return readl(mhi_cntrl->mmio + offset);
+}
+
+void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val)
+{
+	writel(val, mhi_cntrl->mmio + offset);
+}
+
+void mhi_ep_mmio_masked_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 mask, u32 val)
+{
+	u32 regval;
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, offset);
+	regval &= ~mask;
+	regval |= ((val << __ffs(mask)) & mask);
+	mhi_ep_mmio_write(mhi_cntrl, offset, regval);
+}
+
+u32 mhi_ep_mmio_masked_read(struct mhi_ep_cntrl *dev, u32 offset, u32 mask)
+{
+	u32 regval;
+
+	regval = mhi_ep_mmio_read(dev, offset);
+	regval &= mask;
+	regval >>= __ffs(mask);
+
+	return regval;
+}
+
+void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *state,
+				bool *mhi_reset)
+{
+	u32 regval;
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, MHICTRL);
+	*state = FIELD_GET(MHICTRL_MHISTATE_MASK, regval);
+	*mhi_reset = !!FIELD_GET(MHICTRL_RESET_MASK, regval);
+}
+
+static void mhi_ep_mmio_mask_set_chdb_int_a7(struct mhi_ep_cntrl *mhi_cntrl,
+						u32 chdb_id, bool enable)
+{
+	u32 chid_mask, chid_idx, chid_shift, val = 0;
+
+	chid_shift = chdb_id % 32;
+	chid_mask = BIT(chid_shift);
+	chid_idx = chdb_id / 32;
+
+	WARN_ON(chid_idx >= MHI_MASK_ROWS_CH_EV_DB);
+
+	if (enable)
+		val = 1;
+
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(chid_idx),
+				  chid_mask, val);
+
+	/* Update the local copy of the channel mask */
+	mhi_cntrl->chdb[chid_idx].mask &= ~chid_mask;
+	mhi_cntrl->chdb[chid_idx].mask |= val << chid_shift;
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
+	u32 val = 0, i;
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
+		mhi_cntrl->chdb[i].status = mhi_ep_mmio_read(mhi_cntrl,
+							     MHI_CHDB_INT_STATUS_A7_n(i));
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
+				  MHI_CTRL_MHICTRL_MASK, 1);
+}
+
+void mhi_ep_mmio_disable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CTRL_INT_MASK_A7,
+				  MHI_CTRL_MHICTRL_MASK, 0);
+}
+
+void mhi_ep_mmio_enable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CTRL_INT_MASK_A7,
+				  MHI_CTRL_CRDB_MASK, 1);
+}
+
+void mhi_ep_mmio_disable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CTRL_INT_MASK_A7,
+				  MHI_CTRL_CRDB_MASK, 0);
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
+	u32 ccabap_value;
+
+	ccabap_value = mhi_ep_mmio_read(mhi_cntrl, CCABAP_HIGHER);
+	mhi_cntrl->ch_ctx_host_pa = ccabap_value;
+	mhi_cntrl->ch_ctx_host_pa <<= 32;
+
+	ccabap_value = mhi_ep_mmio_read(mhi_cntrl, CCABAP_LOWER);
+	mhi_cntrl->ch_ctx_host_pa |= ccabap_value;
+}
+
+void mhi_ep_mmio_get_erc_base(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 ecabap_value;
+
+	ecabap_value = mhi_ep_mmio_read(mhi_cntrl, ECABAP_HIGHER);
+	mhi_cntrl->ev_ctx_host_pa = ecabap_value;
+	mhi_cntrl->ev_ctx_host_pa <<= 32;
+
+	ecabap_value = mhi_ep_mmio_read(mhi_cntrl, ECABAP_LOWER);
+	mhi_cntrl->ev_ctx_host_pa |= ecabap_value;
+}
+
+void mhi_ep_mmio_get_crc_base(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 crcbap_value;
+
+	crcbap_value = mhi_ep_mmio_read(mhi_cntrl, CRCBAP_HIGHER);
+	mhi_cntrl->cmd_ctx_host_pa = crcbap_value;
+	mhi_cntrl->cmd_ctx_host_pa <<= 32;
+
+	crcbap_value = mhi_ep_mmio_read(mhi_cntrl, CRCBAP_LOWER);
+	mhi_cntrl->cmd_ctx_host_pa |= crcbap_value;
+}
+
+u64 mhi_ep_mmio_get_db(struct mhi_ep_ring *ring)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	u64 db_offset;
+	u32 regval;
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, ring->db_offset_h);
+	db_offset = regval;
+	db_offset <<= 32;
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, ring->db_offset_l);
+	db_offset |= regval;
+
+	return db_offset;
+}
+
+void mhi_ep_mmio_set_env(struct mhi_ep_cntrl *mhi_cntrl, u32 value)
+{
+	mhi_ep_mmio_write(mhi_cntrl, BHI_EXECENV, value);
+}
+
+void mhi_ep_mmio_clear_reset(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHICTRL, MHICTRL_RESET_MASK, 0);
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
+	int mhi_cfg;
+
+	mhi_cntrl->chdb_offset = mhi_ep_mmio_read(mhi_cntrl, CHDBOFF);
+	mhi_cntrl->erdb_offset = mhi_ep_mmio_read(mhi_cntrl, ERDBOFF);
+
+	mhi_cfg = mhi_ep_mmio_read(mhi_cntrl, MHICFG);
+	mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, mhi_cfg);
+	mhi_cntrl->hw_event_rings = FIELD_GET(MHICFG_NHWER_MASK, mhi_cfg);
+
+	mhi_ep_mmio_reset(mhi_cntrl);
+}
+
+void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	int mhi_cfg;
+
+	mhi_cfg = mhi_ep_mmio_read(mhi_cntrl, MHICFG);
+	mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, mhi_cfg);
+	mhi_cntrl->hw_event_rings = FIELD_GET(MHICFG_NHWER_MASK, mhi_cfg);
+}
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index da865f9d3646..3d2ab7a5ccd7 100644
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
@@ -69,6 +73,10 @@ struct mhi_ep_db_info {
  * @mhi_state: MHI Endpoint state
  * @max_chan: Maximum channels supported by the endpoint controller
  * @mru: MRU (Maximum Receive Unit) value of the endpoint controller
+ * @event_rings: Number of event rings supported by the endpoint controller
+ * @hw_event_rings: Number of hardware event rings supported by the endpoint controller
+ * @chdb_offset: Channel doorbell offset set by the host
+ * @erdb_offset: Event ring doorbell offset set by the host
  * @index: MHI Endpoint controller index
  */
 struct mhi_ep_cntrl {
@@ -81,6 +89,12 @@ struct mhi_ep_cntrl {
 	struct mhi_ep_cmd *mhi_cmd;
 	struct mhi_ep_sm *sm;
 
+	u64 ch_ctx_host_pa;
+	u64 ev_ctx_host_pa;
+	u64 cmd_ctx_host_pa;
+
+	struct mhi_ep_db_info chdb[4];
+
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
 	void __iomem *(*alloc_addr)(struct mhi_ep_cntrl *mhi_cntrl, phys_addr_t *phys_addr,
 		       size_t size);
@@ -98,6 +112,10 @@ struct mhi_ep_cntrl {
 
 	u32 max_chan;
 	u32 mru;
+	u32 event_rings;
+	u32 hw_event_rings;
+	u32 chdb_offset;
+	u32 erdb_offset;
 	int index;
 };
 
-- 
2.25.1

