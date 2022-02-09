Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9138D4AEFC4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiBILLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiBILLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:11:09 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65186E0F9D98
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:07:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c8-20020a17090a674800b001b91184b732so2161706pjm.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NMpGHqPnhqxkjvc6r5GMD0fMkW8tMw6KlHDYVxHdn2U=;
        b=B4Yn7jKIUDm2OAwEXij+OFbTThaic5w1aOf0f7h0UwkEZc9zYg6z2XJWSV7NhP0Zs+
         lmn/RcR4P03HLduFsCmTlMpwHAIAgEtkAH3ygfBt9g5GLidAsdmqG/obdcG3yYwiUWkK
         sVG7waeG+4JwqS00mdceah2qVPKKGnRVQxTjT28TA9MHHsaVDPmPIrGgtbydPpy0zMRU
         9AKWPrj3UZmq9zntMKKlf7cETGnRqIpMJ+v8VtIoi6mNeOop44fwqTmCUdbBqzRNgJvt
         fZPcABIo+GWZHAmQKn4ETeAx9+9xqsdAW1K4U2PMMqiVpl9CTtxkR18MH91ttx4LjkYY
         uwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMpGHqPnhqxkjvc6r5GMD0fMkW8tMw6KlHDYVxHdn2U=;
        b=OqnUogQ4SMsVdpcMH2L1ImpAUWogxc7wo/g64jFrZsT098mVrX725oj2YKmss0Qlnr
         1V06OvYUVxXiXyaryQ5tYS6GNk+P+Xo6pE73hDiiZgjANMKZcViM6Hsn/dzwhWjhPtLt
         f+fInHqBTfV9O+LplhfhhA2s58m2jaRmKFXh0HLbNYov7Q/Xk51NFIFhi9hLigrLY/q+
         CLk/ncq+AzIJs2UNqjqr9rB1wb8z8SZJm0pLX3P0fmAtfhR9/y9S/JjW5V5iViG6eWpr
         gmp6IYw4lqk/vwdgSpQl0nPdgfF+G/hwhZZsrZ5rxLK25PNSrKDR7Q/twnNt3Meg1cs8
         GPqw==
X-Gm-Message-State: AOAM531bnVlMH2EQqz95gKLGID4UQqnDN+9dpGgeuCsJ+hy+ujbvcAFr
        fhGtX2o+uW88Bn1P4PVSjTAi
X-Google-Smtp-Source: ABdhPJyiRn/KWXntusKXNKDqIw1RfKpPyWx6lPq76lVZE/DyKLMem7wdNT6oQPG2LPIqJVDv9hdieA==
X-Received: by 2002:a17:902:a708:: with SMTP id w8mr1366936plq.101.1644401190344;
        Wed, 09 Feb 2022 02:06:30 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:06:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 14/23] bus: mhi: ep: Add support for managing MHI state machine
Date:   Wed,  9 Feb 2022 15:26:15 +0530
Message-Id: <20220209095624.26389-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
References: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
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
 drivers/bus/mhi/ep/main.c     |  51 ++++++++++-
 drivers/bus/mhi/ep/sm.c       | 168 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |   6 ++
 5 files changed, 236 insertions(+), 2 deletions(-)
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
index fd63f79c6aec..e4e8f06c2898 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -173,6 +173,11 @@ struct mhi_ep_event {
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
@@ -230,5 +235,11 @@ void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
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
index 1bf46d33f3c3..ed2427f954d7 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -184,6 +184,43 @@ static void mhi_ep_ring_worker(struct work_struct *work)
 	}
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
+			dev_err(dev, "Invalid MHI state transition: %d", itr->state);
+			break;
+		}
+		kfree(itr);
+	}
+}
+
 static void mhi_ep_release_device(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
@@ -385,6 +422,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	}
 
 	INIT_WORK(&mhi_cntrl->ring_work, mhi_ep_ring_worker);
+	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
 
 	mhi_cntrl->ring_wq = alloc_workqueue("mhi_ep_ring_wq", 0, 0);
 	if (!mhi_cntrl->ring_wq) {
@@ -392,8 +430,16 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_free_cmd;
 	}
 
+	mhi_cntrl->state_wq = alloc_workqueue("mhi_ep_state_wq", 0, 0);
+	if (!mhi_cntrl->state_wq) {
+		ret = -ENOMEM;
+		goto err_destroy_ring_wq;
+	}
+
 	INIT_LIST_HEAD(&mhi_cntrl->ch_db_list);
+	INIT_LIST_HEAD(&mhi_cntrl->st_transition_list);
 	spin_lock_init(&mhi_cntrl->list_lock);
+	spin_lock_init(&mhi_cntrl->state_lock);
 	mutex_init(&mhi_cntrl->event_lock);
 
 	/* Set MHI version and AMSS EE before enumeration */
@@ -404,7 +450,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
 	if (mhi_cntrl->index < 0) {
 		ret = mhi_cntrl->index;
-		goto err_destroy_ring_wq;
+		goto err_destroy_state_wq;
 	}
 
 	/* Allocate the controller device */
@@ -432,6 +478,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	put_device(&mhi_dev->dev);
 err_ida_free:
 	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
+err_destroy_state_wq:
+	destroy_workqueue(mhi_cntrl->state_wq);
 err_destroy_ring_wq:
 	destroy_workqueue(mhi_cntrl->ring_wq);
 err_free_cmd:
@@ -447,6 +495,7 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
 
+	destroy_workqueue(mhi_cntrl->state_wq);
 	destroy_workqueue(mhi_cntrl->ring_wq);
 
 	kfree(mhi_cntrl->mhi_cmd);
diff --git a/drivers/bus/mhi/ep/sm.c b/drivers/bus/mhi/ep/sm.c
new file mode 100644
index 000000000000..68e7f99b9137
--- /dev/null
+++ b/drivers/bus/mhi/ep/sm.c
@@ -0,0 +1,168 @@
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
+			mhi_state_str(mhi_state),
+			mhi_state_str(mhi_cntrl->mhi_state));
+		return -EACCES;
+	}
+
+	switch (mhi_state) {
+	case MHI_STATE_READY:
+		mhi_ep_mmio_masked_write(mhi_cntrl, MHISTATUS,
+				MHISTATUS_READY_MASK, 1);
+
+		mhi_ep_mmio_masked_write(mhi_cntrl, MHISTATUS,
+				MHISTATUS_MHISTATE_MASK, mhi_state);
+		break;
+	case MHI_STATE_SYS_ERR:
+		mhi_ep_mmio_masked_write(mhi_cntrl, MHISTATUS,
+				MHISTATUS_SYSERR_MASK, 1);
+
+		mhi_ep_mmio_masked_write(mhi_cntrl, MHISTATUS,
+				MHISTATUS_MHISTATE_MASK, mhi_state);
+		break;
+	case MHI_STATE_M1:
+	case MHI_STATE_M2:
+		dev_err(dev, "MHI state (%s) not supported\n", mhi_state_str(mhi_state));
+		return -EOPNOTSUPP;
+	case MHI_STATE_M0:
+	case MHI_STATE_M3:
+		mhi_ep_mmio_masked_write(mhi_cntrl, MHISTATUS,
+					  MHISTATUS_MHISTATE_MASK, mhi_state);
+		break;
+	default:
+		dev_err(dev, "Invalid MHI state (%d)\n", mhi_state);
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
+		dev_err(dev, "Failed sending M0 state change event\n");
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
+	mhi_state = mhi_ep_mmio_masked_read(mhi_cntrl, MHISTATUS, MHISTATUS_MHISTATE_MASK);
+	is_ready = mhi_ep_mmio_masked_read(mhi_cntrl, MHISTATUS, MHISTATUS_READY_MASK);
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
index 062133a68118..72ce30cbe87e 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -65,11 +65,14 @@ struct mhi_ep_db_info {
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
@@ -105,12 +108,15 @@ struct mhi_ep_cntrl {
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

