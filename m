Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1DB4C6D02
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbiB1Mqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiB1Mqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:46:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE5677ABE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z11so2218072pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vcl92fz3+irxD9KCaDd8YUarALcd3Z7fRorGjh01hG0=;
        b=zgAuBXJFRp+yRZEaovoE+pIg2W1Z/kfpBeR5FtbxhfZVVO7CZ9sce8bsu8VsHlRZsM
         tibWSdo8In69EkbbaS7GK4zm86aE3K0OYjL2fS2Ge9Ek5pe5lX4U5pQmo++S9R6y+OqA
         QOq86PV/Rz3zhBH9FYrh1zuChKmXAxJqzm26n/8Ye2m+fgIjZ7yBReWjBWLFQE8CuPGW
         ///nMTo+2Axboo/sOiUgMH5mEb9gNiOZPusMZMcjSpNK4PDhi8yKFfMDP2t7nPbrZsaJ
         Crm+c9+c2vh5wP8ck+DjJPqMlN/MzqzfvygT6j8Tx6GkErjhjiiTTS5eipdaoF5fKrBC
         Hryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vcl92fz3+irxD9KCaDd8YUarALcd3Z7fRorGjh01hG0=;
        b=PtMk00c/41XZxazLO7cMDfDqIGIT5qmId32vK/Os0dgcwvXvar3t7fTIpInRB1loBw
         +q6CkL/R+OOEimNxsL+72XIrm8p8pKuOtml+0rJTUocGnV18bgIQgmpZawqhPXyEGsI8
         FNsADvMq+u+wuOYfzAvi3ebkHyxrPcLM74+s2lO94wZGE+T14QKEvvMXtBqGrwjb9NEK
         zvLRJo6QMCMSbHkaG5jYWynf17Jr68/WIiFYUTR5m49hw60kcgTyMBuQrrBXz1MFlXN9
         U7G9xm4ddYNDdisiQghJHgbCffTxZhOytZbVfY6oppHI4XqNq6XK9Vd7wihpNPo+HS7e
         IOAQ==
X-Gm-Message-State: AOAM532vVJlIStDYr85K4xisSf4VPeERyNBc+mL4HRDa7RR/t9+qEslo
        NFCnIINj8RaXTQtEKN6VEeYj
X-Google-Smtp-Source: ABdhPJzPm5xtwFQ7yaaEOGCvtLKdMEubwWzR8zddxKevGDreGfG6H4SnD4rvQVEauEKhaHpeg9xdkw==
X-Received: by 2002:a17:90a:dac2:b0:1bd:fecf:6bd1 with SMTP id g2-20020a17090adac200b001bdfecf6bd1mr760205pjx.113.1646052324410;
        Mon, 28 Feb 2022 04:45:24 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:45:24 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 16/27] bus: mhi: ep: Add support for managing MHI state machine
Date:   Mon, 28 Feb 2022 18:13:33 +0530
Message-Id: <20220228124344.77359-17-manivannan.sadhasivam@linaro.org>
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

Add support for managing the MHI state machine by controlling the state
transitions. Only the following MHI state transitions are supported:

1. Ready state
2. M0 state
3. M3 state
4. SYS_ERR state

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/Makefile   |   2 +-
 drivers/bus/mhi/ep/internal.h |  11 +++
 drivers/bus/mhi/ep/main.c     |  54 +++++++++++++-
 drivers/bus/mhi/ep/sm.c       | 136 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |  12 +++
 5 files changed, 213 insertions(+), 2 deletions(-)
 create mode 100644 drivers/bus/mhi/ep/sm.c

diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
index 7ba0e04801eb..aad85f180b70 100644
--- a/drivers/bus/mhi/ep/Makefile
+++ b/drivers/bus/mhi/ep/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
-mhi_ep-y := main.o mmio.o ring.o
+mhi_ep-y := main.o mmio.o ring.o sm.o
diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index 8753ae93eda3..536351218685 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -144,6 +144,11 @@ struct mhi_ep_event {
 	struct mhi_ep_ring ring;
 };
 
+struct mhi_ep_state_transition {
+	struct list_head node;
+	enum mhi_state state;
+};
+
 struct mhi_ep_chan {
 	char *name;
 	struct mhi_ep_device *mhi_dev;
@@ -198,5 +203,11 @@ void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
 /* MHI EP core functions */
 int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state);
 int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_env);
+bool mhi_ep_check_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state cur_mhi_state,
+			    enum mhi_state mhi_state);
+int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_state);
+int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
+int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
+int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
 
 #endif
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 903f9bd3e03d..7a29543586d0 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -106,6 +106,43 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
 	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
 }
 
+static void mhi_ep_state_worker(struct work_struct *work)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, state_work);
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ep_state_transition *itr, *tmp;
+	unsigned long flags;
+	LIST_HEAD(head);
+	int ret;
+
+	spin_lock_irqsave(&mhi_cntrl->list_lock, flags);
+	list_splice_tail_init(&mhi_cntrl->st_transition_list, &head);
+	spin_unlock_irqrestore(&mhi_cntrl->list_lock, flags);
+
+	list_for_each_entry_safe(itr, tmp, &head, node) {
+		list_del(&itr->node);
+		dev_dbg(dev, "Handling MHI state transition to %s\n",
+			 mhi_state_str(itr->state));
+
+		switch (itr->state) {
+		case MHI_STATE_M0:
+			ret = mhi_ep_set_m0_state(mhi_cntrl);
+			if (ret)
+				dev_err(dev, "Failed to transition to M0 state\n");
+			break;
+		case MHI_STATE_M3:
+			ret = mhi_ep_set_m3_state(mhi_cntrl);
+			if (ret)
+				dev_err(dev, "Failed to transition to M3 state\n");
+			break;
+		default:
+			dev_err(dev, "Invalid MHI state transition: %d\n", itr->state);
+			break;
+		}
+		kfree(itr);
+	}
+}
+
 static void mhi_ep_release_device(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
@@ -315,6 +352,17 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_free_ch;
 	}
 
+	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
+
+	mhi_cntrl->wq = alloc_workqueue("mhi_ep_wq", 0, 0);
+	if (!mhi_cntrl->wq) {
+		ret = -ENOMEM;
+		goto err_free_cmd;
+	}
+
+	INIT_LIST_HEAD(&mhi_cntrl->st_transition_list);
+	spin_lock_init(&mhi_cntrl->state_lock);
+	spin_lock_init(&mhi_cntrl->list_lock);
 	mutex_init(&mhi_cntrl->event_lock);
 
 	/* Set MHI version and AMSS EE before enumeration */
@@ -325,7 +373,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
 	if (mhi_cntrl->index < 0) {
 		ret = mhi_cntrl->index;
-		goto err_free_cmd;
+		goto err_destroy_wq;
 	}
 
 	/* Allocate the controller device */
@@ -352,6 +400,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	put_device(&mhi_dev->dev);
 err_ida_free:
 	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
+err_destroy_wq:
+	destroy_workqueue(mhi_cntrl->wq);
 err_free_cmd:
 	kfree(mhi_cntrl->mhi_cmd);
 err_free_ch:
@@ -365,6 +415,8 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
 
+	destroy_workqueue(mhi_cntrl->wq);
+
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_chan);
 
diff --git a/drivers/bus/mhi/ep/sm.c b/drivers/bus/mhi/ep/sm.c
new file mode 100644
index 000000000000..ad49276ec044
--- /dev/null
+++ b/drivers/bus/mhi/ep/sm.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/errno.h>
+#include <linux/mhi_ep.h>
+#include "internal.h"
+
+bool __must_check mhi_ep_check_mhi_state(struct mhi_ep_cntrl *mhi_cntrl,
+					 enum mhi_state cur_mhi_state,
+					 enum mhi_state mhi_state)
+{
+	if (mhi_state == MHI_STATE_SYS_ERR)
+		return true;    /* Allowed in any state */
+
+	if (mhi_state == MHI_STATE_READY)
+		return cur_mhi_state == MHI_STATE_RESET;
+
+	if (mhi_state == MHI_STATE_M0)
+		return (cur_mhi_state == MHI_STATE_M3 || cur_mhi_state == MHI_STATE_READY);
+
+	if (mhi_state == MHI_STATE_M3)
+		return cur_mhi_state == MHI_STATE_M0;
+
+	return false;
+}
+
+int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_state)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	if (!mhi_ep_check_mhi_state(mhi_cntrl, mhi_cntrl->mhi_state, mhi_state)) {
+		dev_err(dev, "MHI state change to %s from %s is not allowed!\n",
+			mhi_state_str(mhi_state),
+			mhi_state_str(mhi_cntrl->mhi_state));
+		return -EACCES;
+	}
+
+	/* TODO */
+	if (mhi_state == MHI_STATE_M1 || mhi_state == MHI_STATE_M2) {
+		dev_err(dev, "MHI state (%s) not supported\n", mhi_state_str(mhi_state));
+		return -EOPNOTSUPP;
+	}
+
+	mhi_ep_mmio_masked_write(mhi_cntrl, EP_MHISTATUS, MHISTATUS_MHISTATE_MASK, mhi_state);
+	mhi_cntrl->mhi_state = mhi_state;
+
+	if (mhi_state == MHI_STATE_READY)
+		mhi_ep_mmio_masked_write(mhi_cntrl, EP_MHISTATUS, MHISTATUS_READY_MASK, 1);
+
+	if (mhi_state == MHI_STATE_SYS_ERR)
+		mhi_ep_mmio_masked_write(mhi_cntrl, EP_MHISTATUS, MHISTATUS_SYSERR_MASK, 1);
+
+	return 0;
+}
+
+int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state old_state;
+	int ret;
+
+	spin_lock_bh(&mhi_cntrl->state_lock);
+	old_state = mhi_cntrl->mhi_state;
+
+	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
+	spin_unlock_bh(&mhi_cntrl->state_lock);
+
+	if (ret)
+		return ret;
+
+	/* Signal host that the device moved to M0 */
+	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_M0);
+	if (ret) {
+		dev_err(dev, "Failed sending M0 state change event\n");
+		return ret;
+	}
+
+	if (old_state == MHI_STATE_READY) {
+		/* Send AMSS EE event to host */
+		ret = mhi_ep_send_ee_event(mhi_cntrl, MHI_EE_AMSS);
+		if (ret) {
+			dev_err(dev, "Failed sending AMSS EE event\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret;
+
+	spin_lock_bh(&mhi_cntrl->state_lock);
+	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
+	spin_unlock_bh(&mhi_cntrl->state_lock);
+
+	if (ret)
+		return ret;
+
+	/* Signal host that the device moved to M3 */
+	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_M3);
+	if (ret) {
+		dev_err(dev, "Failed sending M3 state change event\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state mhi_state;
+	int ret, is_ready;
+
+	spin_lock_bh(&mhi_cntrl->state_lock);
+	/* Ensure that the MHISTATUS is set to RESET by host */
+	mhi_state = mhi_ep_mmio_masked_read(mhi_cntrl, EP_MHISTATUS, MHISTATUS_MHISTATE_MASK);
+	is_ready = mhi_ep_mmio_masked_read(mhi_cntrl, EP_MHISTATUS, MHISTATUS_READY_MASK);
+
+	if (mhi_state != MHI_STATE_RESET || is_ready) {
+		dev_err(dev, "READY state transition failed. MHI host not in RESET state\n");
+		spin_unlock_bh(&mhi_cntrl->state_lock);
+		return -EIO;
+	}
+
+	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_READY);
+	spin_unlock_bh(&mhi_cntrl->state_lock);
+
+	return ret;
+}
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 44a4669382ad..dc27a5de7d3c 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -67,6 +67,11 @@ struct mhi_ep_db_info {
  * @cmd_ctx_host_pa: Physical address of host command context data structure
  * @chdb: Array of channel doorbell interrupt info
  * @event_lock: Lock for protecting event rings
+ * @list_lock: Lock for protecting state transition and channel doorbell lists
+ * @state_lock: Lock for protecting state transitions
+ * @st_transition_list: List of state transitions
+ * @wq: Dedicated workqueue for handling rings and state changes
+ * @state_work: State transition worker
  * @raise_irq: CB function for raising IRQ to the host
  * @alloc_addr: CB function for allocating memory in endpoint for storing host context
  * @map_addr: CB function for mapping host context to endpoint
@@ -102,6 +107,13 @@ struct mhi_ep_cntrl {
 
 	struct mhi_ep_db_info chdb[4];
 	struct mutex event_lock;
+	spinlock_t list_lock;
+	spinlock_t state_lock;
+
+	struct list_head st_transition_list;
+
+	struct workqueue_struct *wq;
+	struct work_struct state_work;
 
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
 	void __iomem *(*alloc_addr)(struct mhi_ep_cntrl *mhi_cntrl, phys_addr_t *phys_addr,
-- 
2.25.1

