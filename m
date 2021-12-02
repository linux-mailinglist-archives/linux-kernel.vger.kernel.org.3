Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB1446628D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357585AbhLBLmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357544AbhLBLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:41:25 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB99C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:38:02 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u17so20002903plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNkVGdcpAk1Xtqvfpq5Pdopfhy3WT41I1Sh0APLacSQ=;
        b=IHDK2pbhccoKe9ukL5raKWBzlM/5gZvLQmemIg4OfKxWjYFrg+uft4uJJS9wn0hoUR
         1XHhaUSFgPr9BqtAHXgOHv10jGQwAEYPRWeXClm2DsgSmkuVVLxpxi1FbksAZeK/lCbm
         UZzi1gGjgtgGWbTm7tsQQgDXL27jFGa+VN9UmiiO2AJ8raYxoYsOxU+pVXD09cRonrHv
         B4ehwP/foVcgUFZEzithDCE63+EOHAHYOgnJdP2F9AqinucGeHQx1JgaY1a0GIP629PE
         OULjLSxAeosl9WNwO5PIIjlo6A3vkIFpSvuf2av/g3BFwD1kBOLm8kML6Q3plqw1pk7b
         VEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNkVGdcpAk1Xtqvfpq5Pdopfhy3WT41I1Sh0APLacSQ=;
        b=A64bSVUFWHTU+oogpEIGccyaZllWgOYOm+4+BRngmOQjZjw12/OXQGi56nYp8pikGc
         VKwNp22gbMKPJ03YD4hJTjNpWe6QIeL1Z4j85/K/kARx5w4H6JqmObMmniGqW+wNaaGK
         K/T4LQciX7s1BMqOzwe2SaQI/FL08rEzJfT0MQ37BX8ZRNmA2/KybFfO7t7SigEglqm4
         XjdipwuI9e1FeRyIVJ5dAKBolM1fTKNMDlTHqmICPYa/jnRFa4SctU6f+/sN4kujxNff
         Tw+DguARxTFge1vG+mN5hP/I7SKHo6bnqlo5i1kKRvYjYMNeKD/LK7Nh5CLMjysDKiY5
         jsLg==
X-Gm-Message-State: AOAM530RLcF3JbYId/mcKqOr9VJba/tSZJFf2jMJTVecwbOBbZE0llkT
        AI2VjUk9misRqw32+H2BcVN5
X-Google-Smtp-Source: ABdhPJwqqM09P5wvpx4+rW+a73V/212FE+papI75O2unr0Kj6KRqP8P5vyYOiLj5a2H5JDdsATWx0w==
X-Received: by 2002:a17:902:ab94:b0:143:beb5:b6a7 with SMTP id f20-20020a170902ab9400b00143beb5b6a7mr15150911plr.30.1638445082160;
        Thu, 02 Dec 2021 03:38:02 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:38:01 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/20] bus: mhi: ep: Add support for powering up the MHI endpoint stack
Date:   Thu,  2 Dec 2021 17:05:45 +0530
Message-Id: <20211202113553.238011-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MHI endpoint power_up that includes initializing the MMIO
and rings, caching the host MHI registers, and setting the MHI state to M0.
After registering the MHI EP controller, the stack has to be powered up
for usage.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 228 ++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |  28 +++++
 2 files changed, 256 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 70740358d329..5f62b6fb6dbc 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -16,6 +16,9 @@
 #include <linux/module.h>
 #include "internal.h"
 
+#define MHI_SUSPEND_MIN			100
+#define MHI_SUSPEND_TIMEOUT		600
+
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 event_ring,
@@ -143,6 +146,175 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
 	return mhi_ep_send_event(mhi_cntrl, 0, &event);
 }
 
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
+	/* Allocate memory for caching host channel context */
+	mhi_cntrl->ch_ctx_cache = mhi_cntrl->alloc_addr(mhi_cntrl, &mhi_cntrl->ch_ctx_cache_phys,
+							mhi_cntrl->ch_ctx_host_size);
+	if (!mhi_cntrl->ch_ctx_cache) {
+		dev_err(dev, "Failed to allocate ch_ctx_cache memory\n");
+		return -ENOMEM;
+	}
+
+	/* Map the host channel context */
+	ret = mhi_cntrl->map_addr(mhi_cntrl, mhi_cntrl->ch_ctx_cache_phys,
+				  mhi_cntrl->ch_ctx_host_pa, mhi_cntrl->ch_ctx_host_size);
+	if (ret) {
+		dev_err(dev, "Failed to map ch_ctx_cache\n");
+		goto err_ch_ctx;
+	}
+
+	/* Get the event context base pointer from host */
+	mhi_ep_mmio_get_erc_base(mhi_cntrl);
+
+	/* Allocate memory for caching host event context */
+	mhi_cntrl->ev_ctx_cache = mhi_cntrl->alloc_addr(mhi_cntrl, &mhi_cntrl->ev_ctx_cache_phys,
+							mhi_cntrl->ev_ctx_host_size);
+	if (!mhi_cntrl->ev_ctx_cache) {
+		dev_err(dev, "Failed to allocate ev_ctx_cache memory\n");
+		ret = -ENOMEM;
+		goto err_ch_ctx_map;
+	}
+
+	/* Map the host event context */
+	ret = mhi_cntrl->map_addr(mhi_cntrl, mhi_cntrl->ev_ctx_cache_phys,
+				  mhi_cntrl->ev_ctx_host_pa, mhi_cntrl->ev_ctx_host_size);
+	if (ret) {
+		dev_err(dev, "Failed to map ev_ctx_cache\n");
+		goto err_ev_ctx;
+	}
+
+	/* Get the command context base pointer from host */
+	mhi_ep_mmio_get_crc_base(mhi_cntrl);
+
+	/* Allocate memory for caching host command context */
+	mhi_cntrl->cmd_ctx_cache = mhi_cntrl->alloc_addr(mhi_cntrl, &mhi_cntrl->cmd_ctx_cache_phys,
+							 mhi_cntrl->cmd_ctx_host_size);
+	if (!mhi_cntrl->cmd_ctx_cache) {
+		dev_err(dev, "Failed to allocate cmd_ctx_cache memory\n");
+		ret = -ENOMEM;
+		goto err_ev_ctx_map;
+	}
+
+	/* Map the host command context */
+	ret = mhi_cntrl->map_addr(mhi_cntrl, mhi_cntrl->cmd_ctx_cache_phys,
+				  mhi_cntrl->cmd_ctx_host_pa, mhi_cntrl->cmd_ctx_host_size);
+	if (ret) {
+		dev_err(dev, "Failed to map cmd_ctx_cache\n");
+		goto err_cmd_ctx;
+	}
+
+	/* Initialize command ring */
+	ret = mhi_ep_ring_start(mhi_cntrl, &mhi_cntrl->mhi_cmd->ring,
+				(union mhi_ep_ring_ctx *)mhi_cntrl->cmd_ctx_cache);
+	if (ret) {
+		dev_err(dev, "Failed to start the command ring\n");
+		goto err_cmd_ctx_map;
+	}
+
+	return ret;
+
+err_cmd_ctx_map:
+	mhi_cntrl->unmap_addr(mhi_cntrl, mhi_cntrl->cmd_ctx_cache_phys);
+
+err_cmd_ctx:
+	mhi_cntrl->free_addr(mhi_cntrl, mhi_cntrl->cmd_ctx_cache_phys,
+			     mhi_cntrl->cmd_ctx_cache, mhi_cntrl->cmd_ctx_host_size);
+
+err_ev_ctx_map:
+	mhi_cntrl->unmap_addr(mhi_cntrl, mhi_cntrl->ev_ctx_cache_phys);
+
+err_ev_ctx:
+	mhi_cntrl->free_addr(mhi_cntrl, mhi_cntrl->ev_ctx_cache_phys,
+			     mhi_cntrl->ev_ctx_cache, mhi_cntrl->ev_ctx_host_size);
+
+err_ch_ctx_map:
+	mhi_cntrl->unmap_addr(mhi_cntrl, mhi_cntrl->ch_ctx_cache_phys);
+
+err_ch_ctx:
+	mhi_cntrl->free_addr(mhi_cntrl, mhi_cntrl->ch_ctx_cache_phys,
+			     mhi_cntrl->ch_ctx_cache, mhi_cntrl->ch_ctx_host_size);
+
+	return ret;
+}
+
+static void mhi_ep_free_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_cntrl->unmap_addr(mhi_cntrl, mhi_cntrl->cmd_ctx_cache_phys);
+	mhi_cntrl->free_addr(mhi_cntrl, mhi_cntrl->cmd_ctx_cache_phys,
+			     mhi_cntrl->cmd_ctx_cache, mhi_cntrl->cmd_ctx_host_size);
+	mhi_cntrl->unmap_addr(mhi_cntrl, mhi_cntrl->ev_ctx_cache_phys);
+	mhi_cntrl->free_addr(mhi_cntrl, mhi_cntrl->ev_ctx_cache_phys,
+			     mhi_cntrl->ev_ctx_cache, mhi_cntrl->ev_ctx_host_size);
+	mhi_cntrl->unmap_addr(mhi_cntrl, mhi_cntrl->ch_ctx_cache_phys);
+	mhi_cntrl->free_addr(mhi_cntrl, mhi_cntrl->ch_ctx_cache_phys,
+			     mhi_cntrl->ch_ctx_cache, mhi_cntrl->ch_ctx_host_size);
+}
+
+static void mhi_ep_enable_int(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	mhi_ep_mmio_enable_chdb_interrupts(mhi_cntrl);
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
@@ -313,6 +485,62 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
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
+				       GFP_KERNEL);
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
+		dev_err(dev, "Failed to enable MHI endpoint: %d\n", ret);
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
index 7a665cd55579..105e8067409a 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -59,9 +59,18 @@ struct mhi_ep_db_info {
  * @mhi_event: Points to the event ring configurations table
  * @mhi_cmd: Points to the command ring configurations table
  * @sm: MHI Endpoint state machine
+ * @ch_ctx_cache: Cache of host channel context data structure
+ * @ev_ctx_cache: Cache of host event context data structure
+ * @cmd_ctx_cache: Cache of host command context data structure
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
@@ -85,6 +94,7 @@ struct mhi_ep_db_info {
  * @erdb_offset: Event ring doorbell offset set by the host
  * @index: MHI Endpoint controller index
  * @irq: IRQ used by the endpoint controller
+ * @is_enabled: Check if the endpoint controller is enabled or not
  */
 struct mhi_ep_cntrl {
 	struct device *cntrl_dev;
@@ -96,9 +106,18 @@ struct mhi_ep_cntrl {
 	struct mhi_ep_cmd *mhi_cmd;
 	struct mhi_ep_sm *sm;
 
+	struct mhi_chan_ctxt *ch_ctx_cache;
+	struct mhi_event_ctxt *ev_ctx_cache;
+	struct mhi_cmd_ctxt *cmd_ctx_cache;
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
@@ -131,6 +150,7 @@ struct mhi_ep_cntrl {
 	u32 erdb_offset;
 	int index;
 	int irq;
+	bool is_enabled;
 };
 
 /**
@@ -229,4 +249,12 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
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

