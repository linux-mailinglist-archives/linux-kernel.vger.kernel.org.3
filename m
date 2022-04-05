Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A424F4934
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiDEWF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443739AbiDEPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A22C1A3BB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bx5so11926900pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ccP+sfP/RhErj5M6yeqDbDlXHknxu9wEXiHf6PwTOX4=;
        b=gA4ReVzJe03dAPGW9jNQKKZkFLrJd4fQTS2rTmNEgtRquECJ1PVhR0ktd2su88TXD8
         FEPc1t2rDicwS5K4PV0BYzRHkZHGIq63bxvwRqX4XKle5ut/MNosC2CfFetFo/WjkR9d
         UhxsbyJoB11xJWGZw71oGhriE4xVEO7aGCFAhsjvYqWBZU3qhDjjARLlpcVAoDCYXZtW
         vixPkPANVnNpno+TE92eisFHqhbzkVKDoiuaLGjMTchru+OCMPLGzqN1fCcslyVc9pCk
         vtABbOOybVHsYCQDBSQgYpFr1FQnKDLMoHjz/8/oZqRMx1gzngzYh06eATEeOpg8zkJh
         Ihaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ccP+sfP/RhErj5M6yeqDbDlXHknxu9wEXiHf6PwTOX4=;
        b=pHyqxzVmAS2b8rSp8hGSv/6G+bvFm/3Fbcl81F7MvYKiMW8V8Hl3zOf+QpR6uDpTJW
         h4K2e2qIncSGmkAyEAE6gxkAYTxHTAnPWf1G7n3Bv//8wkUGzuTGB5ofKg3briMYNsm/
         uWL9x4UhCnaet7QtKaGdGp9ue8V0AmREo6n1TdyazNsXcaQIAT2M7jGnqZLoBIPuCbQl
         62sfecE2WrTjGfn+erHHozrnut8XHyrSlizukB5bK/H5WNcTKp7FfPjimMwif/XZ1M/j
         S/KFIb8KGD/ftTn7jOTQ+ztTHnOn/yEKWi1b/jT1cobvANWcwJ3dHC0WZsmX3hQXo02k
         sh/w==
X-Gm-Message-State: AOAM533EimvnNjtMTW4A6D6SWcv36yO7EqI0Cm7aH0b0/K1zmh66kp/Z
        UGKuZcaT1UkJWGdkEsNL/YDj
X-Google-Smtp-Source: ABdhPJx17M6CrvP41RxJBJREkESN1xqKhkCHYc56cP6kh9jJDo+HjN2b77XRB6M+3b62wgHUB7/ksA==
X-Received: by 2002:a17:90a:c504:b0:1bf:6d9f:65a6 with SMTP id k4-20020a17090ac50400b001bf6d9f65a6mr4217009pjt.204.1649167129683;
        Tue, 05 Apr 2022 06:58:49 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:58:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/18] bus: mhi: ep: Add support for powering up the MHI endpoint stack
Date:   Tue,  5 Apr 2022 19:27:45 +0530
Message-Id: <20220405135754.6622-10-manivannan.sadhasivam@linaro.org>
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

Add support for MHI endpoint power_up that includes initializing the MMIO
and rings, caching the host MHI registers, and setting the MHI state to M0.
After registering the MHI EP controller, the stack has to be powered up
for usage.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 205 ++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |  16 +++
 2 files changed, 221 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 4e82006bd83b..20d579733486 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -17,6 +17,9 @@
 #include <linux/module.h>
 #include "internal.h"
 
+#define M0_WAIT_DELAY_MS	100
+#define M0_WAIT_COUNT		100
+
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
@@ -106,6 +109,154 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
 	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
 }
 
+static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	size_t cmd_ctx_host_size, ch_ctx_host_size, ev_ctx_host_size;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret;
+
+	/* Update the number of event rings (NER) programmed by the host */
+	mhi_ep_mmio_update_ner(mhi_cntrl);
+
+	dev_dbg(dev, "Number of Event rings: %u, HW Event rings: %u\n",
+		 mhi_cntrl->event_rings, mhi_cntrl->hw_event_rings);
+
+	ch_ctx_host_size = sizeof(struct mhi_chan_ctxt) * mhi_cntrl->max_chan;
+	ev_ctx_host_size = sizeof(struct mhi_event_ctxt) * mhi_cntrl->event_rings;
+	cmd_ctx_host_size = sizeof(struct mhi_cmd_ctxt) * NR_OF_CMD_RINGS;
+
+	/* Get the channel context base pointer from host */
+	mhi_ep_mmio_get_chc_base(mhi_cntrl);
+
+	/* Allocate and map memory for caching host channel context */
+	ret = mhi_cntrl->alloc_map(mhi_cntrl, mhi_cntrl->ch_ctx_host_pa,
+				   &mhi_cntrl->ch_ctx_cache_phys,
+				   (void __iomem **) &mhi_cntrl->ch_ctx_cache,
+				   ch_ctx_host_size);
+	if (ret) {
+		dev_err(dev, "Failed to allocate and map ch_ctx_cache\n");
+		return ret;
+	}
+
+	/* Get the event context base pointer from host */
+	mhi_ep_mmio_get_erc_base(mhi_cntrl);
+
+	/* Allocate and map memory for caching host event context */
+	ret = mhi_cntrl->alloc_map(mhi_cntrl, mhi_cntrl->ev_ctx_host_pa,
+				   &mhi_cntrl->ev_ctx_cache_phys,
+				   (void __iomem **) &mhi_cntrl->ev_ctx_cache,
+				   ev_ctx_host_size);
+	if (ret) {
+		dev_err(dev, "Failed to allocate and map ev_ctx_cache\n");
+		goto err_ch_ctx;
+	}
+
+	/* Get the command context base pointer from host */
+	mhi_ep_mmio_get_crc_base(mhi_cntrl);
+
+	/* Allocate and map memory for caching host command context */
+	ret = mhi_cntrl->alloc_map(mhi_cntrl, mhi_cntrl->cmd_ctx_host_pa,
+				   &mhi_cntrl->cmd_ctx_cache_phys,
+				   (void __iomem **) &mhi_cntrl->cmd_ctx_cache,
+				   cmd_ctx_host_size);
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
+	mhi_cntrl->unmap_free(mhi_cntrl, mhi_cntrl->cmd_ctx_host_pa, mhi_cntrl->cmd_ctx_cache_phys,
+			      (void __iomem *) mhi_cntrl->cmd_ctx_cache, cmd_ctx_host_size);
+
+err_ev_ctx:
+	mhi_cntrl->unmap_free(mhi_cntrl, mhi_cntrl->ev_ctx_host_pa, mhi_cntrl->ev_ctx_cache_phys,
+			      (void __iomem *) mhi_cntrl->ev_ctx_cache, ev_ctx_host_size);
+
+err_ch_ctx:
+	mhi_cntrl->unmap_free(mhi_cntrl, mhi_cntrl->ch_ctx_host_pa, mhi_cntrl->ch_ctx_cache_phys,
+			      (void __iomem *) mhi_cntrl->ch_ctx_cache, ch_ctx_host_size);
+
+	return ret;
+}
+
+static void mhi_ep_free_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	size_t cmd_ctx_host_size, ch_ctx_host_size, ev_ctx_host_size;
+
+	ch_ctx_host_size = sizeof(struct mhi_chan_ctxt) * mhi_cntrl->max_chan;
+	ev_ctx_host_size = sizeof(struct mhi_event_ctxt) * mhi_cntrl->event_rings;
+	cmd_ctx_host_size = sizeof(struct mhi_cmd_ctxt) * NR_OF_CMD_RINGS;
+
+	mhi_cntrl->unmap_free(mhi_cntrl, mhi_cntrl->cmd_ctx_host_pa, mhi_cntrl->cmd_ctx_cache_phys,
+			      (void __iomem *) mhi_cntrl->cmd_ctx_cache, cmd_ctx_host_size);
+
+	mhi_cntrl->unmap_free(mhi_cntrl, mhi_cntrl->ev_ctx_host_pa, mhi_cntrl->ev_ctx_cache_phys,
+			      (void __iomem *) mhi_cntrl->ev_ctx_cache, ev_ctx_host_size);
+
+	mhi_cntrl->unmap_free(mhi_cntrl, mhi_cntrl->ch_ctx_host_pa, mhi_cntrl->ch_ctx_cache_phys,
+			      (void __iomem *) mhi_cntrl->ch_ctx_cache, ch_ctx_host_size);
+}
+
+static void mhi_ep_enable_int(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	/*
+	 * Doorbell interrupts are enabled when the corresponding channel gets started.
+	 * Enabling all interrupts here triggers spurious irqs as some of the interrupts
+	 * associated with hw channels always get triggered.
+	 */
+	mhi_ep_mmio_enable_ctrl_interrupt(mhi_cntrl);
+	mhi_ep_mmio_enable_cmdb_interrupt(mhi_cntrl);
+}
+
+static int mhi_ep_enable(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state state;
+	bool mhi_reset;
+	u32 count = 0;
+	int ret;
+
+	/* Wait for Host to set the M0 state */
+	do {
+		msleep(M0_WAIT_DELAY_MS);
+		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
+		if (mhi_reset) {
+			/* Clear the MHI reset if host is in reset state */
+			mhi_ep_mmio_clear_reset(mhi_cntrl);
+			dev_info(dev, "Detected Host reset while waiting for M0\n");
+		}
+		count++;
+	} while (state != MHI_STATE_M0 && count < M0_WAIT_COUNT);
+
+	if (state != MHI_STATE_M0) {
+		dev_err(dev, "Host failed to enter M0\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = mhi_ep_cache_host_cfg(mhi_cntrl);
+	if (ret) {
+		dev_err(dev, "Failed to cache host config\n");
+		return ret;
+	}
+
+	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EE_AMSS);
+
+	/* Enable all interrupts now */
+	mhi_ep_enable_int(mhi_cntrl);
+
+	return 0;
+}
+
 static void mhi_ep_state_worker(struct work_struct *work)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, state_work);
@@ -249,6 +400,60 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
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
+	mhi_cntrl->mhi_state = MHI_STATE_RESET;
+
+	/* Set AMSS EE before signaling ready state */
+	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EE_AMSS);
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
+	mhi_cntrl->enabled = true;
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
index 137bd3ee2e43..3b065f82fbeb 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -65,6 +65,9 @@ struct mhi_ep_db_info {
  * @ch_ctx_host_pa: Physical address of host channel context data structure
  * @ev_ctx_host_pa: Physical address of host event context data structure
  * @cmd_ctx_host_pa: Physical address of host command context data structure
+ * @ch_ctx_cache_phys: Physical address of the host channel context cache
+ * @ev_ctx_cache_phys: Physical address of the host event context cache
+ * @cmd_ctx_cache_phys: Physical address of the host command context cache
  * @chdb: Array of channel doorbell interrupt info
  * @event_lock: Lock for protecting event rings
  * @list_lock: Lock for protecting state transition and channel doorbell lists
@@ -87,6 +90,7 @@ struct mhi_ep_db_info {
  * @erdb_offset: Event ring doorbell offset set by the host
  * @index: MHI Endpoint controller index
  * @irq: IRQ used by the endpoint controller
+ * @enabled: Check if the endpoint controller is enabled or not
  */
 struct mhi_ep_cntrl {
 	struct device *cntrl_dev;
@@ -104,6 +108,9 @@ struct mhi_ep_cntrl {
 	u64 ch_ctx_host_pa;
 	u64 ev_ctx_host_pa;
 	u64 cmd_ctx_host_pa;
+	phys_addr_t ch_ctx_cache_phys;
+	phys_addr_t ev_ctx_cache_phys;
+	phys_addr_t cmd_ctx_cache_phys;
 
 	struct mhi_ep_db_info chdb[4];
 	struct mutex event_lock;
@@ -134,6 +141,7 @@ struct mhi_ep_cntrl {
 	u32 erdb_offset;
 	u32 index;
 	int irq;
+	bool enabled;
 };
 
 /**
@@ -228,4 +236,12 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
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

