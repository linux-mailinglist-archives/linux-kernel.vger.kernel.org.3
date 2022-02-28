Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DC44C6CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiB1Mqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbiB1Mqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:46:34 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD54E4B439
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so11221749pjw.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOKWOiXPdIu4E+xI1dskhzwHubmEMAPM1rfQtzt3OWk=;
        b=kaYZgUDCVuCj/avIuDWBO2IozU6r/iapJjT8ZrZLe6Jal7igSHxFOCMqt2PBkrXXqu
         g3+97G7iiQ+36dBNbKB4FU6aX76gHQswYS9ASI6+ex9lNu5uFtWdasRcNT/x56l1Myjp
         38jvmo8rwtzH1Jx0kg2tV0E85kj7DQoGF6LGQH4yCoSzcEQLHBow0zg6mw5qsVPN7PBz
         4HkxdHABFNURx0ryd6coeZ/swOadzd8TDpFh+5at2qvbB0DqktlXXWSvHCNXFSaTYOaM
         +03uC4CfJ132IOYuwzkAcmHAmXKw+Th5SMIkuzw7a++b3X6h38U9KIEDoenZrwUreqlM
         SLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOKWOiXPdIu4E+xI1dskhzwHubmEMAPM1rfQtzt3OWk=;
        b=f6rf50Ok1jhhciWz1J4kiYImHVugUUVTITpALiQwYehlR9++GsH42ijTaqw5R7Tss5
         6EVtF4dMPGbKAWZqyOLeN6gVhbvnk0LEVP9JbjdtHSxelBFAVPF/YgrPp4p6RmY4Kl9Z
         BNssRNaM9uc0TwzMD1XqMs9bIRN0r/vR+x379t95fKXG4vhDW3hjcDsUw1/ik8pPTnkV
         lt9QaJmwJbofHBOzQ+oRfN5Jd1OJJsb4eLRIRNKAUaIN6yBNKqcxJNkDzQT0jSz7foKn
         r0At01r2ulJTQEACBdzJD19KjFbzSDjh4AHgkzBVPU/O9qsmvu68t076jrtYc95CA6Vo
         KUdg==
X-Gm-Message-State: AOAM530QY5atDA089NoaoHAA20RNsjf5SDdUnvoXJmPNSmJHbgEB4/QH
        6p87dOABrhKW6IrxfxyVvC1v
X-Google-Smtp-Source: ABdhPJzR39ku1h3++ACWDSHI+9yf++jektrBKyCYSG06RXV6bUpvl2yrdEPjVgpXQc+vi0eAGf+Xbw==
X-Received: by 2002:a17:902:76c7:b0:14f:cbb1:71da with SMTP id j7-20020a17090276c700b0014fcbb171damr20276336plt.39.1646052335040;
        Mon, 28 Feb 2022 04:45:35 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:45:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 18/27] bus: mhi: ep: Add support for powering up the MHI endpoint stack
Date:   Mon, 28 Feb 2022 18:13:35 +0530
Message-Id: <20220228124344.77359-19-manivannan.sadhasivam@linaro.org>
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

Add support for MHI endpoint power_up that includes initializing the MMIO
and rings, caching the host MHI registers, and setting the MHI state to M0.
After registering the MHI EP controller, the stack has to be powered up
for usage.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/internal.h |   6 +
 drivers/bus/mhi/ep/main.c     | 237 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        |  16 +++
 3 files changed, 259 insertions(+)

diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index 536351218685..a2ec4169a4b2 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -210,4 +210,10 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
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
index ce690b1aeace..47807102baad 100644
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
@@ -106,6 +109,186 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
 	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
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
+	ret = mhi_ep_alloc_map(mhi_cntrl, mhi_cntrl->ch_ctx_host_pa, ch_ctx_host_size,
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
+	ret = mhi_ep_alloc_map(mhi_cntrl, mhi_cntrl->ev_ctx_host_pa, ev_ctx_host_size,
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
+	ret = mhi_ep_alloc_map(mhi_cntrl, mhi_cntrl->cmd_ctx_host_pa, cmd_ctx_host_size,
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
+			mhi_cntrl->cmd_ctx_cache, cmd_ctx_host_size);
+
+err_ev_ctx:
+	mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->ev_ctx_host_pa, mhi_cntrl->ev_ctx_cache_phys,
+			mhi_cntrl->ev_ctx_cache, ev_ctx_host_size);
+
+err_ch_ctx:
+	mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->ch_ctx_host_pa, mhi_cntrl->ch_ctx_cache_phys,
+			mhi_cntrl->ch_ctx_cache, ch_ctx_host_size);
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
+	mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->cmd_ctx_host_pa, mhi_cntrl->cmd_ctx_cache_phys,
+			mhi_cntrl->cmd_ctx_cache, cmd_ctx_host_size);
+	mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->ev_ctx_host_pa, mhi_cntrl->ev_ctx_cache_phys,
+			mhi_cntrl->ev_ctx_cache, ev_ctx_host_size);
+	mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->ch_ctx_host_pa, mhi_cntrl->ch_ctx_cache_phys,
+			mhi_cntrl->ch_ctx_cache, ch_ctx_host_size);
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
@@ -249,6 +432,60 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
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
index 43aa9b133db4..1b7dec859a5e 100644
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
@@ -89,6 +92,7 @@ struct mhi_ep_db_info {
  * @erdb_offset: Event ring doorbell offset set by the host
  * @index: MHI Endpoint controller index
  * @irq: IRQ used by the endpoint controller
+ * @enabled: Check if the endpoint controller is enabled or not
  */
 struct mhi_ep_cntrl {
 	struct device *cntrl_dev;
@@ -106,6 +110,9 @@ struct mhi_ep_cntrl {
 	u64 ch_ctx_host_pa;
 	u64 ev_ctx_host_pa;
 	u64 cmd_ctx_host_pa;
+	phys_addr_t ch_ctx_cache_phys;
+	phys_addr_t ev_ctx_cache_phys;
+	phys_addr_t cmd_ctx_cache_phys;
 
 	struct mhi_ep_db_info chdb[4];
 	struct mutex event_lock;
@@ -141,6 +148,7 @@ struct mhi_ep_cntrl {
 	u32 erdb_offset;
 	u32 index;
 	int irq;
+	bool enabled;
 };
 
 /**
@@ -235,4 +243,12 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
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

