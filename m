Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952264F4F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457660AbiDFAqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443717AbiDEPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B371C184B71
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q142so9317763pgq.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAPjlvAcw0Oit+TsW2fcUALmxQJOREvAxqgcGccfEpY=;
        b=ZARqHQa20AeiErgDpXA7G3Dv7WakpzrqDkYDLEXF47Hjv4NJBT4kRAxElSxPmlc26a
         Hx8r0/+gJyhgJtisaHPcB+VriQ5RelMCqKft7P0nYff6ZtYG5EVIClSyB6pQ2shA8BKZ
         BYN5MXJGVOrvK+kAXSwLCQK++x+ryc5hp8FyvXzIvBHPNSlr3EKqrFIX74oP9GrD5DD2
         tMmYSSoy/BAqbSoyQU1W6QN+vKeRYCknKCvFavmXn7t4zzaAN7YKN+C0qsZxw6amvHO3
         rdDezCboHqPbvMPuI94ly0WfmR+7EHMoqMREZA/6k0BvIfzLOd8QsGGcAy8kHQGSajUm
         BCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAPjlvAcw0Oit+TsW2fcUALmxQJOREvAxqgcGccfEpY=;
        b=Se/xXSERiGd/pNhrg1oOGkT+d33x5cE4QmTwA2JFRO4SUDQo0G/hoR4h27jBs7pdxB
         0uJAQHD64li8RUQOgusxxtyc+yRmkPcDf6xCIWinQb02cYgrq5V2n/xBKYJqxIHa2ZWV
         l87GxYQl2cexd2x92z2EzN+qowlngCkN1XEwb1hktZ6XtJ51vtgPjE5p43BZOCA+/E0N
         hhUqmpKsDS+i6cl1RIxFSJGQiPL/eYyPdNo2w67h38Y3EzlIoD03jCFPbClv17UN13Eq
         Mv9sMDoUdakqeGPGP8dVctdiagbHK+zEayyKGh/E2tZhT238pqxmAAwZrZvoH9WtBvu1
         7tDA==
X-Gm-Message-State: AOAM5331fvnCNnpuyVVzUfRhcVbyiWV5vzIoHqbVivmBEODmPzXDjX+M
        7SpGWyI6UWPhmlK0AyEUOQH1
X-Google-Smtp-Source: ABdhPJzhId3F849UEfpmlAjdPX1cJ8w4XE2b8TIKy25L5fdRxndveFdBlYlgBA6hwbr2DCqaXxUBvg==
X-Received: by 2002:aa7:91d5:0:b0:4fa:6d3c:55d9 with SMTP id z21-20020aa791d5000000b004fa6d3c55d9mr3800801pfa.41.1649167103147;
        Tue, 05 Apr 2022 06:58:23 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:58:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/18] bus: mhi: ep: Add support for managing MMIO registers
Date:   Tue,  5 Apr 2022 19:27:40 +0530
Message-Id: <20220405135754.6622-5-manivannan.sadhasivam@linaro.org>
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

Add support for managing the Memory Mapped Input Output (MMIO) registers
of the MHI bus. All MHI operations are carried out using the MMIO registers
by both host and the endpoint device.

The MMIO registers reside inside the endpoint device memory (fixed
location based on the platform) and the address is passed by the MHI EP
controller driver during its registration.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/Makefile   |   2 +-
 drivers/bus/mhi/ep/internal.h |  26 ++++
 drivers/bus/mhi/ep/main.c     |   6 +-
 drivers/bus/mhi/ep/mmio.c     | 273 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |  18 +++
 5 files changed, 323 insertions(+), 2 deletions(-)
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
index 0d3923186a5e..475425a30d85 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -153,4 +153,30 @@ struct mhi_ep_chan {
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
+void mhi_ep_mmio_enable_chdb(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
+void mhi_ep_mmio_disable_chdb(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
+void mhi_ep_mmio_enable_chdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl);
+bool mhi_ep_mmio_read_chdb_status_interrupts(struct mhi_ep_cntrl *mhi_cntrl);
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
index 6c64745e8a06..7dcc784f10d1 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -214,7 +214,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	struct mhi_ep_device *mhi_dev;
 	int ret;
 
-	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
+	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio)
 		return -EINVAL;
 
 	ret = mhi_ep_chan_init(mhi_cntrl, config);
@@ -227,6 +227,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_free_ch;
 	}
 
+	/* Set MHI version and AMSS EE before enumeration */
+	mhi_ep_mmio_write(mhi_cntrl, EP_MHIVER, config->mhi_version);
+	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EE_AMSS);
+
 	/* Set controller index */
 	ret = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
 	if (ret < 0)
diff --git a/drivers/bus/mhi/ep/mmio.c b/drivers/bus/mhi/ep/mmio.c
new file mode 100644
index 000000000000..b5bfd22f2c8e
--- /dev/null
+++ b/drivers/bus/mhi/ep/mmio.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Linaro Ltd.
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
+	regval |= (val << __ffs(mask)) & mask;
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
+	regval = mhi_ep_mmio_read(mhi_cntrl, EP_MHICTRL);
+	*state = FIELD_GET(MHICTRL_MHISTATE_MASK, regval);
+	*mhi_reset = !!FIELD_GET(MHICTRL_RESET_MASK, regval);
+}
+
+static void mhi_ep_mmio_set_chdb(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id, bool enable)
+{
+	u32 chid_mask, chid_shift, chdb_idx, val;
+
+	chid_shift = ch_id % 32;
+	chid_mask = BIT(chid_shift);
+	chdb_idx = ch_id / 32;
+
+	val = enable ? 1 : 0;
+
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CHDB_INT_MASK_n(chdb_idx), chid_mask, val);
+
+	/* Update the local copy of the channel mask */
+	mhi_cntrl->chdb[chdb_idx].mask &= ~chid_mask;
+	mhi_cntrl->chdb[chdb_idx].mask |= val << chid_shift;
+}
+
+void mhi_ep_mmio_enable_chdb(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id)
+{
+	mhi_ep_mmio_set_chdb(mhi_cntrl, ch_id, true);
+}
+
+void mhi_ep_mmio_disable_chdb(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id)
+{
+	mhi_ep_mmio_set_chdb(mhi_cntrl, ch_id, false);
+}
+
+static void mhi_ep_mmio_set_chdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl, bool enable)
+{
+	u32 val, i;
+
+	val = enable ? MHI_CHDB_INT_MASK_n_EN_ALL : 0;
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_DB; i++) {
+		mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_MASK_n(i), val);
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
+bool mhi_ep_mmio_read_chdb_status_interrupts(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	bool chdb = false;
+	u32 i;
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_DB; i++) {
+		mhi_cntrl->chdb[i].status = mhi_ep_mmio_read(mhi_cntrl, MHI_CHDB_INT_STATUS_n(i));
+		if (mhi_cntrl->chdb[i].status)
+			chdb = true;
+	}
+
+	/* Return whether a channel doorbell interrupt occurred or not */
+	return chdb;
+}
+
+static void mhi_ep_mmio_set_erdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl, bool enable)
+{
+	u32 val, i;
+
+	val = enable ? MHI_ERDB_INT_MASK_n_EN_ALL : 0;
+
+	for (i = 0; i < MHI_MASK_ROWS_EV_DB; i++)
+		mhi_ep_mmio_write(mhi_cntrl, MHI_ERDB_INT_MASK_n(i), val);
+}
+
+static void mhi_ep_mmio_mask_erdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_set_erdb_interrupts(mhi_cntrl, false);
+}
+
+void mhi_ep_mmio_enable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CTRL_INT_MASK,
+				  MHI_CTRL_MHICTRL_MASK, 1);
+}
+
+void mhi_ep_mmio_disable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CTRL_INT_MASK,
+				  MHI_CTRL_MHICTRL_MASK, 0);
+}
+
+void mhi_ep_mmio_enable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CTRL_INT_MASK,
+				  MHI_CTRL_CRDB_MASK, 1);
+}
+
+void mhi_ep_mmio_disable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CTRL_INT_MASK,
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
+	u32 i;
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_DB; i++)
+		mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_CLEAR_n(i),
+				   MHI_CHDB_INT_CLEAR_n_CLEAR_ALL);
+
+	for (i = 0; i < MHI_MASK_ROWS_EV_DB; i++)
+		mhi_ep_mmio_write(mhi_cntrl, MHI_ERDB_INT_CLEAR_n(i),
+				   MHI_ERDB_INT_CLEAR_n_CLEAR_ALL);
+
+	mhi_ep_mmio_write(mhi_cntrl, MHI_CTRL_INT_CLEAR,
+			   MHI_CTRL_INT_MMIO_WR_CLEAR |
+			   MHI_CTRL_INT_CRDB_CLEAR |
+			   MHI_CTRL_INT_CRDB_MHICTRL_CLEAR);
+}
+
+void mhi_ep_mmio_get_chc_base(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 regval;
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, EP_CCABAP_HIGHER);
+	mhi_cntrl->ch_ctx_host_pa = regval;
+	mhi_cntrl->ch_ctx_host_pa <<= 32;
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, EP_CCABAP_LOWER);
+	mhi_cntrl->ch_ctx_host_pa |= regval;
+}
+
+void mhi_ep_mmio_get_erc_base(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 regval;
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, EP_ECABAP_HIGHER);
+	mhi_cntrl->ev_ctx_host_pa = regval;
+	mhi_cntrl->ev_ctx_host_pa <<= 32;
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, EP_ECABAP_LOWER);
+	mhi_cntrl->ev_ctx_host_pa |= regval;
+}
+
+void mhi_ep_mmio_get_crc_base(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 regval;
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, EP_CRCBAP_HIGHER);
+	mhi_cntrl->cmd_ctx_host_pa = regval;
+	mhi_cntrl->cmd_ctx_host_pa <<= 32;
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, EP_CRCBAP_LOWER);
+	mhi_cntrl->cmd_ctx_host_pa |= regval;
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
+	mhi_ep_mmio_write(mhi_cntrl, EP_BHI_EXECENV, value);
+}
+
+void mhi_ep_mmio_clear_reset(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_masked_write(mhi_cntrl, EP_MHICTRL, MHICTRL_RESET_MASK, 0);
+}
+
+void mhi_ep_mmio_reset(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_write(mhi_cntrl, EP_MHICTRL, 0);
+	mhi_ep_mmio_write(mhi_cntrl, EP_MHISTATUS, 0);
+	mhi_ep_mmio_clear_interrupts(mhi_cntrl);
+}
+
+void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 regval;
+
+	mhi_cntrl->chdb_offset = mhi_ep_mmio_read(mhi_cntrl, EP_CHDBOFF);
+	mhi_cntrl->erdb_offset = mhi_ep_mmio_read(mhi_cntrl, EP_ERDBOFF);
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, EP_MHICFG);
+	mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
+	mhi_cntrl->hw_event_rings = FIELD_GET(MHICFG_NHWER_MASK, regval);
+
+	mhi_ep_mmio_reset(mhi_cntrl);
+}
+
+void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	u32 regval;
+
+	regval = mhi_ep_mmio_read(mhi_cntrl, EP_MHICFG);
+	mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
+	mhi_cntrl->hw_event_rings = FIELD_GET(MHICFG_NHWER_MASK, regval);
+}
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index e2b94f9eb846..5db048e258e4 100644
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
  * @alloc_map: CB function for allocating memory in endpoint for storing host context and mapping it
  * @unmap_free: CB function to unmap and free the allocated memory in endpoint for storing host context
@@ -67,6 +71,10 @@ struct mhi_ep_db_info {
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
@@ -79,6 +87,12 @@ struct mhi_ep_cntrl {
 	struct mhi_ep_cmd *mhi_cmd;
 	struct mhi_ep_sm *sm;
 
+	u64 ch_ctx_host_pa;
+	u64 ev_ctx_host_pa;
+	u64 cmd_ctx_host_pa;
+
+	struct mhi_ep_db_info chdb[4];
+
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
 	int (*alloc_map)(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t *phys_ptr,
 			 void __iomem **virt, size_t size);
@@ -91,6 +105,10 @@ struct mhi_ep_cntrl {
 
 	u32 max_chan;
 	u32 mru;
+	u32 event_rings;
+	u32 hw_event_rings;
+	u32 chdb_offset;
+	u32 erdb_offset;
 	u32 index;
 };
 
-- 
2.25.1

