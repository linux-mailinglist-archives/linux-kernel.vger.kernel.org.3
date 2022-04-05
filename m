Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EBB4F48D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbiDEVvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443731AbiDEPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A826549
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gt4so6098495pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+h2x0AOOQQNC+oWU2BlJ3OVdaRw6wDtMukMcvpq2P8=;
        b=QjX+37BYB3ZgYz4MmN5uKl2hDbOpWmGh8pnZX31CrUUblSfMFETND2JOTvDYcXERjD
         /Bn1FrLJQqVjebW8lmGBTlnfcbce4vSSoscx+e9YBj3w73xSlEw8CiTu85mn3I3ssIUh
         3gzBXhcjTvDUEaEuB7RfWPGz/mDB8O2RUBl+fIJen8kpIs3BimmR1H/QuuLMGNT9ro9s
         jXrl78jQ9RjCFAMFYAPzgKLoh9tmowFlEV5k2T0Is6JGO3OF26HhiZUqDTXkUToHxw8o
         4g2xEl99YViaQXno5fgJLl3UggUScgvYh7AOg0kxZ3rjl7kDPW+uqMQn54hQMtvCMCFh
         VS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+h2x0AOOQQNC+oWU2BlJ3OVdaRw6wDtMukMcvpq2P8=;
        b=TOdptLguzxossNmMcvrhjJLwiP+qzFaYkFL10p0tLcmW0ZclVsd7jc6WKEwKPkkSi2
         sGoQaY3uzsVD0s7r1GeVhAoqJRwfmU+4WXs0wlzzHO4WILc3QBMvyTJqAwbvIWaVEF5f
         yTBYyqFtCSk0K4K/k9YAQRqSGgv1r7KoFZLiXN5SlZ1WlLR+SKhUxH4GPYwzBMWm0RuY
         me6SXpYGpcyN3nuf7+YsAncK4fTpzSlaBrdqyt2k851Xq5VgOR3t/qJmtaiQRbbj2jJk
         nTjxNftEGXU74RlbRF3JeKog3HH//S7Al0+W5RRULNC2zFC4aMmVHbMo6Kz8WNGWbWdC
         hDBg==
X-Gm-Message-State: AOAM531y7T9S0iyF9x/dN8tIbOz0C8eT4nfkcz60Txs1fIsQKZURTaTB
        73yKccIJfCJTKvFwjzbUmuco
X-Google-Smtp-Source: ABdhPJzVUykZbHCwZMRUAlLCyyWENP5Q/OmcSCAmI+OTYd2+TsmaPB9dRYXWLyysqanOfNxRxxOT/g==
X-Received: by 2002:a17:902:ecd1:b0:154:5393:aaa4 with SMTP id a17-20020a170902ecd100b001545393aaa4mr3471081plh.131.1649167119693;
        Tue, 05 Apr 2022 06:58:39 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:58:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/18] bus: mhi: ep: Add support for managing MHI state machine
Date:   Tue,  5 Apr 2022 19:27:43 +0530
Message-Id: <20220405135754.6622-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405135754.6622-1-manivannan.sadhasivam@linaro.org>
References: <20220405135754.6622-1-manivannan.sadhasivam@linaro.org>
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

Add support for managing the MHI state machine by controlling the state
transitions. Only the following MHI state transitions are supported:

1. Ready state
2. M0 state
3. M3 state
4. SYS_ERR state

Reviewed-by: Alex Elder <elder@linaro.org>
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
index e096d9cb2cb1..4f2e26841702 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -146,6 +146,11 @@ struct mhi_ep_event {
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
@@ -200,5 +205,11 @@ void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
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
index eca1f58ba5fb..c912daf6dc65 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -105,6 +105,43 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
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
@@ -314,6 +351,17 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
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
@@ -323,7 +371,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	/* Set controller index */
 	ret = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
 	if (ret < 0)
-		goto err_free_cmd;
+		goto err_destroy_wq;
 
 	mhi_cntrl->index = ret;
 
@@ -351,6 +399,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	put_device(&mhi_dev->dev);
 err_ida_free:
 	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
+err_destroy_wq:
+	destroy_workqueue(mhi_cntrl->wq);
 err_free_cmd:
 	kfree(mhi_cntrl->mhi_cmd);
 err_free_ch:
@@ -364,6 +414,8 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
 
+	destroy_workqueue(mhi_cntrl->wq);
+
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_chan);
 
diff --git a/drivers/bus/mhi/ep/sm.c b/drivers/bus/mhi/ep/sm.c
new file mode 100644
index 000000000000..ffc02f5d0a0d
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
+		return cur_mhi_state == MHI_STATE_M3 || cur_mhi_state == MHI_STATE_READY;
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
+	/* TODO: Add support for M1 and M2 states */
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
index 46236ffb528a..2880d2aa88b8 100644
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
  * @alloc_map: CB function for allocating memory in endpoint for storing host context and mapping it
  * @unmap_free: CB function to unmap and free the allocated memory in endpoint for storing host context
@@ -100,6 +105,13 @@ struct mhi_ep_cntrl {
 
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
 	int (*alloc_map)(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t *phys_ptr,
-- 
2.25.1

