Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2859D4AEFC9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiBILLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiBILLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:11:39 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2040E084525
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:07:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y17so1769471plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/Hodc4ALp4I6GQ2Tgd6uBHqRiJNCMJ0aMQ8bgemegg=;
        b=e8Mh5XNs4hLoOij3avK/Kjl7B/4229JCVXyksiYl/FUnPX3wLrYV873hA8wvoDvZvv
         gkhSjrOXI5pvEJWE0v3Fe6Ryr1APLFpF9xM1fn45ZEyWUR4iVqvMoExS9XX/Xy2CCoV1
         JippzNEN2b7dtx+idChCUdR3zScr0Smezo0pNlwbI/C5du5wTANmtx3m8aRR6uHtDQTU
         wQ6lQbUa9OwZgdGnOy78xZbYaKuNwaEXC0iVbz9XZT/poBJciTMuq14hZutH0+Z5h5N4
         DCZURYNa8RkgvAGfu3NSe0Cdxag85GAT9RHwXgDo4lsjGZaB5MG7xUwCHjmjE5uG3cHK
         eIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/Hodc4ALp4I6GQ2Tgd6uBHqRiJNCMJ0aMQ8bgemegg=;
        b=KzwhOntwD3CQWji8sX3uSHpl3Lrc/AMsGjWLqIzEVeb1afkBSsYr1UGrbDpqJ81dcQ
         9aD1SW8VVhLHRrCfX8cgUfxwXbUC+3IskxcJf1E+JUkNC3GamYH/LNSWUC9UYHBCjEOc
         GeGtgnq3Kfi7HpZCgrBSSqh6I1tTLSo1P5KRE6+goqUZzoePZCMXpyJg7OvII28tK86n
         uSWegy3yN5MKLkHXmsz9xB7MjA7+8f4XckHChLzUeftuSlbSPk/DNOpl04cqqPxLYMrE
         VP02ZxlkO2WIb9pc+/k92wGDqC/jiVaIGDcC8Se4vnqU7Z5UNK6Y99KvzFS/Ea4JYGoq
         wMIg==
X-Gm-Message-State: AOAM531/uVxryQYpaQBxVkMIfnyftxts2ExUHP/RW2ybtiwrCSa7/8zR
        9Xd/t/km+O5VkaaTBWy0sC+a
X-Google-Smtp-Source: ABdhPJwB1WGl/0V+N5h4mWP6hD3H1gvCQ8HuakiVc2ZGBpuKLqo7w+l82r6q6x5q5URgNvviBovzGg==
X-Received: by 2002:a17:90b:4b83:: with SMTP id lr3mr2554057pjb.135.1644401201878;
        Wed, 09 Feb 2022 02:06:41 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:06:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 16/23] bus: mhi: ep: Add support for powering up the MHI endpoint stack
Date:   Wed,  9 Feb 2022 15:26:17 +0530
Message-Id: <20220209095624.26389-17-manivannan.sadhasivam@linaro.org>
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

Add support for MHI endpoint power_up that includes initializing the MMIO
and rings, caching the host MHI registers, and setting the MHI state to M0.
After registering the MHI EP controller, the stack has to be powered up
for usage.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/internal.h |   6 +
 drivers/bus/mhi/ep/main.c     | 229 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |  22 ++++
 3 files changed, 257 insertions(+)

diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index e4e8f06c2898..ee8c5974f0c0 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -242,4 +242,10 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
 
+/* MHI EP memory management functions */
+int mhi_ep_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, size_t size,
+		     phys_addr_t *phys_ptr, void __iomem **virt);
+void mhi_ep_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t phys,
+		       void __iomem *virt, size_t size);
+
 #endif
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index fed18e34a1d1..86a357129bec 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -16,6 +16,9 @@
 #include <linux/module.h>
 #include "internal.h"
 
+#define MHI_SUSPEND_MIN			100
+#define MHI_SUSPEND_TIMEOUT		600
+
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
@@ -143,6 +146,176 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
 	return mhi_ep_send_event(mhi_cntrl, 0, &event);
 }
 
+int mhi_ep_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, size_t size,
+		     phys_addr_t *phys_ptr, void __iomem **virt)
+{
+	size_t offset = pci_addr % 0x1000;
+	void __iomem *buf;
+	phys_addr_t phys;
+	int ret;
+
+	size += offset;
+
+	buf = mhi_cntrl->alloc_addr(mhi_cntrl, &phys, size);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = mhi_cntrl->map_addr(mhi_cntrl, phys, pci_addr - offset, size);
+	if (ret) {
+		mhi_cntrl->free_addr(mhi_cntrl, phys, buf, size);
+		return ret;
+	}
+
+	*phys_ptr = phys + offset;
+	*virt = buf + offset;
+
+	return 0;
+}
+
+void mhi_ep_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t phys,
+			void __iomem *virt, size_t size)
+{
+	size_t offset = pci_addr % 0x1000;
+
+	size += offset;
+
+	mhi_cntrl->unmap_addr(mhi_cntrl, phys - offset);
+	mhi_cntrl->free_addr(mhi_cntrl, phys - offset, virt - offset, size);
+}
+
+static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret;
+
+	/* Update the number of event rings (NER) programmed by the host */
+	mhi_ep_mmio_update_ner(mhi_cntrl);
+
+	dev_dbg(dev, "Number of Event rings: %d, HW Event rings: %d\n",
+		 mhi_cntrl->event_rings, mhi_cntrl->hw_event_rings);
+
+	mhi_cntrl->ch_ctx_host_size = sizeof(struct mhi_chan_ctxt) *
+					mhi_cntrl->max_chan;
+	mhi_cntrl->ev_ctx_host_size = sizeof(struct mhi_event_ctxt) *
+					mhi_cntrl->event_rings;
+	mhi_cntrl->cmd_ctx_host_size = sizeof(struct mhi_cmd_ctxt);
+
+	/* Get the channel context base pointer from host */
+	mhi_ep_mmio_get_chc_base(mhi_cntrl);
+
+	/* Allocate and map memory for caching host channel context */
+	ret = mhi_ep_alloc_map(mhi_cntrl, mhi_cntrl->ch_ctx_host_pa, mhi_cntrl->ch_ctx_host_size,
+				&mhi_cntrl->ch_ctx_cache_phys,
+				(void __iomem **)&mhi_cntrl->ch_ctx_cache);
+	if (ret) {
+		dev_err(dev, "Failed to allocate and map ch_ctx_cache\n");
+		return ret;
+	}
+
+	/* Get the event context base pointer from host */
+	mhi_ep_mmio_get_erc_base(mhi_cntrl);
+
+	/* Allocate and map memory for caching host event context */
+	ret = mhi_ep_alloc_map(mhi_cntrl, mhi_cntrl->ev_ctx_host_pa, mhi_cntrl->ev_ctx_host_size,
+				&mhi_cntrl->ev_ctx_cache_phys,
+				(void __iomem **)&mhi_cntrl->ev_ctx_cache);
+	if (ret) {
+		dev_err(dev, "Failed to allocate and map ev_ctx_cache\n");
+		goto err_ch_ctx;
+	}
+
+	/* Get the command context base pointer from host */
+	mhi_ep_mmio_get_crc_base(mhi_cntrl);
+
+	/* Allocate and map memory for caching host command context */
+	ret = mhi_ep_alloc_map(mhi_cntrl, mhi_cntrl->cmd_ctx_host_pa, mhi_cntrl->cmd_ctx_host_size,
+				&mhi_cntrl->cmd_ctx_cache_phys,
+				(void __iomem **)&mhi_cntrl->cmd_ctx_cache);
+	if (ret) {
+		dev_err(dev, "Failed to allocate and map cmd_ctx_cache\n");
+		goto err_ev_ctx;
+	}
+
+	/* Initialize command ring */
+	ret = mhi_ep_ring_start(mhi_cntrl, &mhi_cntrl->mhi_cmd->ring,
+				(union mhi_ep_ring_ctx *)mhi_cntrl->cmd_ctx_cache);
+	if (ret) {
+		dev_err(dev, "Failed to start the command ring\n");
+		goto err_cmd_ctx;
+	}
+
+	return ret;
+
+err_cmd_ctx:
+	mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->cmd_ctx_host_pa, mhi_cntrl->cmd_ctx_cache_phys,
+			mhi_cntrl->cmd_ctx_cache, mhi_cntrl->cmd_ctx_host_size);
+
+err_ev_ctx:
+	mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->ev_ctx_host_pa, mhi_cntrl->ev_ctx_cache_phys,
+			mhi_cntrl->ev_ctx_cache, mhi_cntrl->ev_ctx_host_size);
+
+err_ch_ctx:
+	mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->ch_ctx_host_pa, mhi_cntrl->ch_ctx_cache_phys,
+			mhi_cntrl->ch_ctx_cache, mhi_cntrl->ch_ctx_host_size);
+
+	return ret;
+}
+
+static void mhi_ep_free_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->cmd_ctx_host_pa, mhi_cntrl->cmd_ctx_cache_phys,
+			mhi_cntrl->cmd_ctx_cache, mhi_cntrl->cmd_ctx_host_size);
+	mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->ev_ctx_host_pa, mhi_cntrl->ev_ctx_cache_phys,
+			mhi_cntrl->ev_ctx_cache, mhi_cntrl->ev_ctx_host_size);
+	mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->ch_ctx_host_pa, mhi_cntrl->ch_ctx_cache_phys,
+			mhi_cntrl->ch_ctx_cache, mhi_cntrl->ch_ctx_host_size);
+}
+
+static void mhi_ep_enable_int(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_enable_ctrl_interrupt(mhi_cntrl);
+	mhi_ep_mmio_enable_cmdb_interrupt(mhi_cntrl);
+}
+
+static int mhi_ep_enable(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state state;
+	u32 max_cnt = 0;
+	bool mhi_reset;
+	int ret;
+
+	/* Wait for Host to set the M0 state */
+	do {
+		msleep(MHI_SUSPEND_MIN);
+		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
+		if (mhi_reset) {
+			/* Clear the MHI reset if host is in reset state */
+			mhi_ep_mmio_clear_reset(mhi_cntrl);
+			dev_dbg(dev, "Host initiated reset while waiting for M0\n");
+		}
+		max_cnt++;
+	} while (state != MHI_STATE_M0 && max_cnt < MHI_SUSPEND_TIMEOUT);
+
+	if (state == MHI_STATE_M0) {
+		ret = mhi_ep_cache_host_cfg(mhi_cntrl);
+		if (ret) {
+			dev_err(dev, "Failed to cache host config\n");
+			return ret;
+		}
+
+		mhi_ep_mmio_set_env(mhi_cntrl, MHI_EP_AMSS_EE);
+	} else {
+		dev_err(dev, "Host failed to enter M0\n");
+		return -ETIMEDOUT;
+	}
+
+	/* Enable all interrupts now */
+	mhi_ep_enable_int(mhi_cntrl);
+
+	return 0;
+}
+
 static void mhi_ep_ring_worker(struct work_struct *work)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = container_of(work,
@@ -318,6 +491,62 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret, i;
+
+	/*
+	 * Mask all interrupts until the state machine is ready. Interrupts will
+	 * be enabled later with mhi_ep_enable().
+	 */
+	mhi_ep_mmio_mask_interrupts(mhi_cntrl);
+	mhi_ep_mmio_init(mhi_cntrl);
+
+	mhi_cntrl->mhi_event = kzalloc(mhi_cntrl->event_rings * (sizeof(*mhi_cntrl->mhi_event)),
+					GFP_KERNEL);
+	if (!mhi_cntrl->mhi_event)
+		return -ENOMEM;
+
+	/* Initialize command, channel and event rings */
+	mhi_ep_ring_init(&mhi_cntrl->mhi_cmd->ring, RING_TYPE_CMD, 0);
+	for (i = 0; i < mhi_cntrl->max_chan; i++)
+		mhi_ep_ring_init(&mhi_cntrl->mhi_chan[i].ring, RING_TYPE_CH, i);
+	for (i = 0; i < mhi_cntrl->event_rings; i++)
+		mhi_ep_ring_init(&mhi_cntrl->mhi_event[i].ring, RING_TYPE_ER, i);
+
+	spin_lock_bh(&mhi_cntrl->state_lock);
+	mhi_cntrl->mhi_state = MHI_STATE_RESET;
+	spin_unlock_bh(&mhi_cntrl->state_lock);
+
+	/* Set AMSS EE before signaling ready state */
+	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EP_AMSS_EE);
+
+	/* All set, notify the host that we are ready */
+	ret = mhi_ep_set_ready_state(mhi_cntrl);
+	if (ret)
+		goto err_free_event;
+
+	dev_dbg(dev, "READY state notification sent to the host\n");
+
+	ret = mhi_ep_enable(mhi_cntrl);
+	if (ret) {
+		dev_err(dev, "Failed to enable MHI endpoint\n");
+		goto err_free_event;
+	}
+
+	enable_irq(mhi_cntrl->irq);
+	mhi_cntrl->is_enabled = true;
+
+	return 0;
+
+err_free_event:
+	kfree(mhi_cntrl->mhi_event);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_ep_power_up);
+
 static void mhi_ep_release_device(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index a207058a4991..53895f1c68e1 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -65,6 +65,12 @@ struct mhi_ep_db_info {
  * @ch_ctx_host_pa: Physical address of host channel context data structure
  * @ev_ctx_host_pa: Physical address of host event context data structure
  * @cmd_ctx_host_pa: Physical address of host command context data structure
+ * @ch_ctx_cache_phys: Physical address of the host channel context cache
+ * @ev_ctx_cache_phys: Physical address of the host event context cache
+ * @cmd_ctx_cache_phys: Physical address of the host command context cache
+ * @ch_ctx_host_size: Size of the host channel context data structure
+ * @ev_ctx_host_size: Size of the host event context data structure
+ * @cmd_ctx_host_size: Size of the host command context data structure
  * @state_wq: Dedicated workqueue for handling MHI state transitions
  * @ring_wq: Dedicated workqueue for processing MHI rings
  * @state_work: State transition worker
@@ -91,6 +97,7 @@ struct mhi_ep_db_info {
  * @erdb_offset: Event ring doorbell offset set by the host
  * @index: MHI Endpoint controller index
  * @irq: IRQ used by the endpoint controller
+ * @is_enabled: Check if the endpoint controller is enabled or not
  */
 struct mhi_ep_cntrl {
 	struct device *cntrl_dev;
@@ -108,6 +115,12 @@ struct mhi_ep_cntrl {
 	u64 ch_ctx_host_pa;
 	u64 ev_ctx_host_pa;
 	u64 cmd_ctx_host_pa;
+	phys_addr_t ch_ctx_cache_phys;
+	phys_addr_t ev_ctx_cache_phys;
+	phys_addr_t cmd_ctx_cache_phys;
+	size_t ch_ctx_host_size;
+	size_t ev_ctx_host_size;
+	size_t cmd_ctx_host_size;
 
 	struct workqueue_struct *state_wq;
 	struct workqueue_struct	*ring_wq;
@@ -144,6 +157,7 @@ struct mhi_ep_cntrl {
 	u32 erdb_offset;
 	int index;
 	int irq;
+	bool is_enabled;
 };
 
 /**
@@ -238,4 +252,12 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
  */
 void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl);
 
+/**
+ * mhi_ep_power_up - Power up the MHI endpoint stack
+ * @mhi_cntrl: MHI Endpoint controller
+ *
+ * Return: 0 if power up succeeds, a negative error code otherwise.
+ */
+int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl);
+
 #endif
-- 
2.25.1

