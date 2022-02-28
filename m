Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51404C6D01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiB1MqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiB1MqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:46:07 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B444757F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:08 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h17so5043082plc.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+KBq6RzwgdLLJoe+tsayKrNTKVoiagle0XBxHTtuXw=;
        b=pTIw9yHH8kas/CWWFcZ9t94WLWakoVSGdbFIA2guoZrzNB47lYdUaIIBQvTT8kxFDc
         p1gFCVi/RFtYZKSvE/wUWZ8BYw84o27wv1ILF4Y7XlisxsxZs8PAl02t715b+e7kRujn
         Wk8BHxNWKrDj02t1B3Y36ctTr1vqqNf9AepE9dfgZRVIwmTN7QW33eujKj55eVjJVVX/
         TuPf559S3YxBIrh/6tbsY2YF/6gsr/plS7OQ6sjI2Y8pfRAFg130+8qwPjhZYmiZB2nj
         VpMRE6o5GFyqgUYaunsjTgT3mJefzgJApoaBlEy3qhTgOmIUBun6xM7D60URLd8AkQw1
         3wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+KBq6RzwgdLLJoe+tsayKrNTKVoiagle0XBxHTtuXw=;
        b=StfPjMzsR4leUMICaFRPVThhdI8M0iEQGE1xN17w6UNk5V7WBgq1x4OUil3eM9hvad
         1EllRcs3l9K6FSFrf6vG26F/HWMxz+Y/tk9te6n3AmwSicsP9so5/ozVqoaXgUOzyVWz
         fH0SfOJ3Sgd0DbHwpOawpAhAeSXwiEL7HDuK6lBIc/3wSmaudZSNSQG/C3OW5YD4gp1P
         pD1gZujYwQbZ2LztyNdyuYMb2eGT3ZbnmBjxbM2TsiEHhD3gLgJCAbJ45Qv59HjIYw5a
         6e5x1hyeJjRrjm53aXatZvfMI+2gNEU7YwodMdl0NK+eqNPWCkP8DyJSKFhyeeUunp4R
         hZHQ==
X-Gm-Message-State: AOAM532Y2FQYK9mUZ+OCWMzyeRdFoz4+ifFKF6uvs9CvvT4BkFsh1AFU
        86kQqrePSVfLhCSKXaQFZIsQ
X-Google-Smtp-Source: ABdhPJwTxfg0csI9uswuYIBC/Ef69Q2hlQj120Qf533tug9N5s+j+UYhUpQa8weUTAZxskFel9ypbA==
X-Received: by 2002:a17:902:d888:b0:151:6fe8:6e68 with SMTP id b8-20020a170902d88800b001516fe86e68mr1958933plz.158.1646052308329;
        Mon, 28 Feb 2022 04:45:08 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:45:08 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 13/27] bus: mhi: ep: Add support for managing MMIO registers
Date:   Mon, 28 Feb 2022 18:13:30 +0530
Message-Id: <20220228124344.77359-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/bus/mhi/ep/internal.h |  26 ++++
 drivers/bus/mhi/ep/main.c     |   6 +-
 drivers/bus/mhi/ep/mmio.c     | 272 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |  18 +++
 5 files changed, 322 insertions(+), 2 deletions(-)
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
index 58ec5fdc503f..139e939fcf57 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -151,4 +151,30 @@ struct mhi_ep_chan {
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
index 3afae0bfd83c..d76387c4d5fa 100644
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
 	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
 	if (mhi_cntrl->index < 0) {
diff --git a/drivers/bus/mhi/ep/mmio.c b/drivers/bus/mhi/ep/mmio.c
new file mode 100644
index 000000000000..311c5d94c4d2
--- /dev/null
+++ b/drivers/bus/mhi/ep/mmio.c
@@ -0,0 +1,272 @@
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
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++) {
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
+	bool chdb = 0;
+	u32 i;
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++) {
+		mhi_cntrl->chdb[i].status = mhi_ep_mmio_read(mhi_cntrl, MHI_CHDB_INT_STATUS_n(i));
+		chdb |= !!mhi_cntrl->chdb[i].status;
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
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++)
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
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++)
+		mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_CLEAR_n(i),
+				   MHI_CHDB_INT_CLEAR_n_CLEAR_ALL);
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++)
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
index efcbdc51464f..8e1de062f820 100644
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
 	u32 index;
 };
 
-- 
2.25.1

