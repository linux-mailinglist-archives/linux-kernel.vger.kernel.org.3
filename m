Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E257E466288
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357523AbhLBLlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357539AbhLBLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:41:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7413DC0613FA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:37:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so2956669pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=262H3ZpiOHu7SqfUd+7SxsNZEjus1h/j40yrC+fiqwc=;
        b=mrWbPfBvknNyHFJNrSS2xJPJKeaxvpwNgMDhkkEGQtO/Dqa4ztEGOXSo8J4h+BF7d4
         zbE1qpIWxZa1xnGOxbNndRs0vUptUO8JWrH/qgyTxcpkgEFbuAW+qbKPu1I84SU1AVbC
         YPL5yyAEpII/W2RrHAaCh7xi9SLL1h1HXKaNl9pZ5yABWjCOb9wMpDHAB3KPkfrQpNk9
         I5m2eBNbdBHQQRR7EHV18T64jmH1gCax6oJEMhNjl2cHAHUBLPcf76ev/zh871nRMn3i
         +vc8j6ZTlHnoCe83fpeeMaJQCOD4uob7PHefUB0su9g7/lmAFqAwnJcFHZec+hqELQW5
         NMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=262H3ZpiOHu7SqfUd+7SxsNZEjus1h/j40yrC+fiqwc=;
        b=R85+bkCNs7gz3vaJ0w4S7TTV0PCRawlXckyWlPjgB5ipvaFKJwQTfxFz1KHCFASRkH
         F3eQInfzdlGBYq54t0z7LLkgsGvQr7LrLs5ZvslK2tSwvHHauItPXqSIkPusiD7qMg04
         4urkhXnMaFxJaRmmskPazTmOXs6qER+02aR9+WFWkxR5UgVJe5SCnyHTbTQ5HPvZUn/d
         2tghgBXuzvLoNaLoyvDyAU2jBBW03HNMxFkt02FJx4XGO0miDbZojYi7b92BQElCwsXN
         /46VRebZCkNxk8TQluN7g1JWLqJhrC3QVPlxgjxk0E+CNzv5D/Rg7mUJlCK1BAzAQAVt
         yfkA==
X-Gm-Message-State: AOAM530bY61gQN17yl1MLyah8XJ24SLW6cBjsF+GTNpL4A4BrF2RQs2p
        qxlab7Rc85ZG9bq1QOPBxAIN
X-Google-Smtp-Source: ABdhPJyxaFBkl7Nzc+wALuD9jDJXZOQU9IuR+RtZW2B4Fjga9xIHfs7J/Dgfc/IQK4fBls1rsDvwDQ==
X-Received: by 2002:a17:90a:98f:: with SMTP id 15mr5329610pjo.166.1638445071909;
        Thu, 02 Dec 2021 03:37:51 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:37:51 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/20] bus: mhi: ep: Add support for managing MHI state machine
Date:   Thu,  2 Dec 2021 17:05:43 +0530
Message-Id: <20211202113553.238011-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/bus/mhi/ep/main.c     |  49 +++++++++-
 drivers/bus/mhi/ep/sm.c       | 175 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |   6 ++
 5 files changed, 241 insertions(+), 2 deletions(-)
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
index 3551e673d99a..ec508201c5c0 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -158,6 +158,11 @@ struct mhi_ep_event {
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
@@ -217,5 +222,11 @@ void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
 /* MHI EP core functions */
 int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state);
 int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ep_execenv exec_env);
+bool mhi_ep_check_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state cur_mhi_state,
+			    enum mhi_state mhi_state);
+int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_state);
+int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
+int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
+int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
 
 #endif
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 999784eadb65..f9b80fccfe70 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -179,6 +179,42 @@ static void mhi_ep_ring_worker(struct work_struct *work)
 	spin_unlock_irqrestore(&mhi_cntrl->list_lock, flags);
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
+			 TO_MHI_STATE_STR(itr->state));
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
+			dev_err(dev, "Invalid MHI state transition: %d", itr->state);
+			break;
+		}
+	}
+}
+
 static void mhi_ep_release_device(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
@@ -384,6 +420,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	}
 
 	INIT_WORK(&mhi_cntrl->ring_work, mhi_ep_ring_worker);
+	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
 
 	mhi_cntrl->ring_wq = alloc_ordered_workqueue("mhi_ep_ring_wq", WQ_HIGHPRI);
 	if (!mhi_cntrl->ring_wq) {
@@ -391,7 +428,14 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_free_cmd;
 	}
 
+	mhi_cntrl->state_wq = alloc_ordered_workqueue("mhi_ep_state_wq", WQ_HIGHPRI);
+	if (!mhi_cntrl->state_wq) {
+		ret = -ENOMEM;
+		goto err_destroy_ring_wq;
+	}
+
 	INIT_LIST_HEAD(&mhi_cntrl->ch_db_list);
+	INIT_LIST_HEAD(&mhi_cntrl->st_transition_list);
 	spin_lock_init(&mhi_cntrl->list_lock);
 	mutex_init(&mhi_cntrl->event_lock);
 
@@ -403,7 +447,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
 	if (mhi_cntrl->index < 0) {
 		ret = mhi_cntrl->index;
-		goto err_destroy_ring_wq;
+		goto err_destroy_state_wq;
 	}
 
 	/* Allocate the controller device */
@@ -432,6 +476,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	put_device(&mhi_dev->dev);
 err_ida_free:
 	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
+err_destroy_state_wq:
+	destroy_workqueue(mhi_cntrl->state_wq);
 err_destroy_ring_wq:
 	destroy_workqueue(mhi_cntrl->ring_wq);
 err_free_cmd:
@@ -447,6 +493,7 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
 
+	destroy_workqueue(mhi_cntrl->state_wq);
 	destroy_workqueue(mhi_cntrl->ring_wq);
 
 	kfree(mhi_cntrl->mhi_cmd);
diff --git a/drivers/bus/mhi/ep/sm.c b/drivers/bus/mhi/ep/sm.c
new file mode 100644
index 000000000000..95cec5c627b4
--- /dev/null
+++ b/drivers/bus/mhi/ep/sm.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/mhi_ep.h>
+#include "internal.h"
+
+bool __must_check mhi_ep_check_mhi_state(struct mhi_ep_cntrl *mhi_cntrl,
+					 enum mhi_state cur_mhi_state,
+					 enum mhi_state mhi_state)
+{
+	bool valid = false;
+
+	switch (mhi_state) {
+	case MHI_STATE_READY:
+		valid = (cur_mhi_state == MHI_STATE_RESET);
+		break;
+	case MHI_STATE_M0:
+		valid = (cur_mhi_state == MHI_STATE_READY ||
+			  cur_mhi_state == MHI_STATE_M3);
+		break;
+	case MHI_STATE_M3:
+		valid = (cur_mhi_state == MHI_STATE_M0);
+		break;
+	case MHI_STATE_SYS_ERR:
+		/* Transition to SYS_ERR state is allowed all the time */
+		valid = true;
+		break;
+	default:
+		break;
+	}
+
+	return valid;
+}
+
+int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_state)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	if (!mhi_ep_check_mhi_state(mhi_cntrl, mhi_cntrl->mhi_state, mhi_state)) {
+		dev_err(dev, "MHI state change to %s from %s is not allowed!\n",
+			TO_MHI_STATE_STR(mhi_state),
+			TO_MHI_STATE_STR(mhi_cntrl->mhi_state));
+		return -EACCES;
+	}
+
+	switch (mhi_state) {
+	case MHI_STATE_READY:
+		mhi_ep_mmio_masked_write(mhi_cntrl, MHISTATUS,
+				MHISTATUS_READY_MASK,
+				MHISTATUS_READY_SHIFT, 1);
+
+		mhi_ep_mmio_masked_write(mhi_cntrl, MHISTATUS,
+				MHISTATUS_MHISTATE_MASK,
+				MHISTATUS_MHISTATE_SHIFT, mhi_state);
+		break;
+	case MHI_STATE_SYS_ERR:
+		mhi_ep_mmio_masked_write(mhi_cntrl, MHISTATUS,
+				MHISTATUS_SYSERR_MASK,
+				MHISTATUS_SYSERR_SHIFT, 1);
+
+		mhi_ep_mmio_masked_write(mhi_cntrl, MHISTATUS,
+				MHISTATUS_MHISTATE_MASK,
+				MHISTATUS_MHISTATE_SHIFT, mhi_state);
+		break;
+	case MHI_STATE_M1:
+	case MHI_STATE_M2:
+		dev_err(dev, "MHI state (%s) not supported\n", TO_MHI_STATE_STR(mhi_state));
+		return -EOPNOTSUPP;
+	case MHI_STATE_M0:
+	case MHI_STATE_M3:
+		mhi_ep_mmio_masked_write(mhi_cntrl, MHISTATUS,
+					  MHISTATUS_MHISTATE_MASK,
+					  MHISTATUS_MHISTATE_SHIFT, mhi_state);
+		break;
+	default:
+		dev_err(dev, "Invalid MHI state (%d)", mhi_state);
+		return -EINVAL;
+	}
+
+	mhi_cntrl->mhi_state = mhi_state;
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
+	if (ret) {
+		spin_unlock_bh(&mhi_cntrl->state_lock);
+		return ret;
+	}
+
+	spin_unlock_bh(&mhi_cntrl->state_lock);
+	/* Signal host that the device moved to M0 */
+	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_M0);
+	if (ret) {
+		dev_err(dev, "Failed sending M0 state change event: %d\n", ret);
+		return ret;
+	}
+
+	if (old_state == MHI_STATE_READY) {
+		/* Allow the host to process state change event */
+		mdelay(1);
+
+		/* Send AMSS EE event to host */
+		ret = mhi_ep_send_ee_event(mhi_cntrl, MHI_EP_AMSS_EE);
+		if (ret) {
+			dev_err(dev, "Failed sending AMSS EE event: %d\n", ret);
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
+	if (ret) {
+		spin_unlock_bh(&mhi_cntrl->state_lock);
+		return ret;
+	}
+
+	spin_unlock_bh(&mhi_cntrl->state_lock);
+
+	/* Signal host that the device moved to M3 */
+	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_M3);
+	if (ret) {
+		dev_err(dev, "Failed sending M3 state change event: %d\n", ret);
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
+	mhi_ep_mmio_masked_read(mhi_cntrl, MHISTATUS, MHISTATUS_MHISTATE_MASK,
+				 MHISTATUS_MHISTATE_SHIFT, &mhi_state);
+	mhi_ep_mmio_masked_read(mhi_cntrl, MHISTATUS, MHISTATUS_READY_MASK,
+				 MHISTATUS_READY_SHIFT, &is_ready);
+
+	if (mhi_state != MHI_STATE_RESET || is_ready) {
+		dev_err(dev, "READY state transition failed. MHI host not in RESET state\n");
+		spin_unlock_bh(&mhi_cntrl->state_lock);
+		return -EFAULT;
+	}
+
+	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_READY);
+	spin_unlock_bh(&mhi_cntrl->state_lock);
+
+	return ret;
+}
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 323cd3319b13..ea7435d0e609 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -62,11 +62,14 @@ struct mhi_ep_db_info {
  * @ch_ctx_host_pa: Physical address of host channel context data structure
  * @ev_ctx_host_pa: Physical address of host event context data structure
  * @cmd_ctx_host_pa: Physical address of host command context data structure
+ * @state_wq: Dedicated workqueue for handling MHI state transitions
  * @ring_wq: Dedicated workqueue for processing MHI rings
+ * @state_work: State transition worker
  * @ring_work: Ring worker
  * @ch_db_list: List of queued channel doorbells
  * @st_transition_list: List of state transitions
  * @list_lock: Lock for protecting state transition and channel doorbell lists
+ * @state_lock: Lock for protecting state transitions
  * @event_lock: Lock for protecting event rings
  * @chdb: Array of channel doorbell interrupt info
  * @raise_irq: CB function for raising IRQ to the host
@@ -96,12 +99,15 @@ struct mhi_ep_cntrl {
 	u64 ev_ctx_host_pa;
 	u64 cmd_ctx_host_pa;
 
+	struct workqueue_struct *state_wq;
 	struct workqueue_struct	*ring_wq;
+	struct work_struct state_work;
 	struct work_struct ring_work;
 
 	struct list_head ch_db_list;
 	struct list_head st_transition_list;
 	spinlock_t list_lock;
+	spinlock_t state_lock;
 	struct mutex event_lock;
 	struct mhi_ep_db_info chdb[4];
 
-- 
2.25.1

