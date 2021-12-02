Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3667B46628C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357561AbhLBLmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357529AbhLBLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:41:25 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA5AC0613FD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:37:57 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h24so20354025pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9Zk0Mx91LkY3ff2uRdFKhlAWYb3Qu2I8it/OG3Zh78=;
        b=Q/78+blmQN0kykBYegZYj4RMoHPyz12H2xkImfaVEXW8VTXxzIf31Bem91lATJpl1U
         N7nlkHjEnSTWW5PBn24c1vQLV/V1dNg6ZMDBZwhZqZG0OcmPXa9PUwXYC6WiTiGnBIoq
         gXQYj7CY3ZEsgGP4l7t3RTaB8R58dbPuTGU2180FCVqzS0YluY5xf+jj0Rzgpu9ORmiA
         4tr625w1odOqfwVQEVNuwUCLgiRsdc/+cuLl1cpbS212F7OD0Bez4NU8/fkQ6lhSgu95
         ctzYBLHoAO2Ju8tXh1Op2DHeEpP7mnPeJTQc13cb3PNy7eIpcQ65AFl01vMYIMKpkDlT
         ryEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9Zk0Mx91LkY3ff2uRdFKhlAWYb3Qu2I8it/OG3Zh78=;
        b=cxkDDXYGtMPtw2sz1nwyoCabb1sLZ08eO7Un0GrVXemAyKTIi0oE10QKQ4dkNDkOpm
         +vNmx9ZE1pRI3cfeSRkowIaF5hZqfA0SXDQa1FpMyioVnWxkpXT6vCiXkJdvMBXSlijy
         KaET91jZwUB6JKmtObnnl4yBJA4h1J+RXYSQge1cmGnKYDT5epqukQesX+6ITmog+A0H
         eJSLNfOY0eNHyphrwHh6hVBaO3USgd+uouZh2+Y9H34sg968U7jPhDVgImylck3hQW2t
         FUNkgtnov/Iy7OacgNCajV8UrX26Dz7IzGXkcW1sbtn2J1u3saBu3OxV/PtgCYIqrKo8
         EvYg==
X-Gm-Message-State: AOAM531mj67T8NfRELXonG5jnpWNKOSj4+gc4xORGUppGlCXLHzH0Fgf
        HeeG7uSKoa4qn4R5uCez+udJMCtUJ9tm
X-Google-Smtp-Source: ABdhPJx1a7042SZo6wN5sWbJjlB8FVkEKUAWdmgxxZ+Jz8PpswrtSgCvYEFxDZQTm7tUnZmXro2gGQ==
X-Received: by 2002:a17:90b:128d:: with SMTP id fw13mr5371859pjb.50.1638445077190;
        Thu, 02 Dec 2021 03:37:57 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:37:56 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/20] bus: mhi: ep: Add support for processing MHI endpoint interrupts
Date:   Thu,  2 Dec 2021 17:05:44 +0530
Message-Id: <20211202113553.238011-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for processing MHI endpoint interrupts such as control
interrupt, command interrupt and channel interrupt from the host.

The interrupts will be generated in the endpoint device whenever host
writes to the corresponding doorbell registers. The doorbell logic
is handled inside the hardware internally.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 114 +++++++++++++++++++++++++++++++++++++-
 include/linux/mhi_ep.h    |   2 +
 2 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index f9b80fccfe70..70740358d329 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -179,6 +179,56 @@ static void mhi_ep_ring_worker(struct work_struct *work)
 	spin_unlock_irqrestore(&mhi_cntrl->list_lock, flags);
 }
 
+static void mhi_ep_queue_channel_db(struct mhi_ep_cntrl *mhi_cntrl,
+				    unsigned long ch_int, u32 ch_idx)
+{
+	struct mhi_ep_ring *ring;
+	unsigned int i;
+
+	for_each_set_bit(i, &ch_int, 32) {
+		/* Channel index varies for each register: 0, 32, 64, 96 */
+		i += ch_idx;
+		ring = &mhi_cntrl->mhi_chan[i].ring;
+
+		spin_lock(&mhi_cntrl->list_lock);
+		list_add(&ring->list, &mhi_cntrl->ch_db_list);
+		spin_unlock(&mhi_cntrl->list_lock);
+		/*
+		 * Disable the channel interrupt here and enable it once
+		 * the current interrupt got serviced
+		 */
+		mhi_ep_mmio_disable_chdb_a7(mhi_cntrl, i);
+		queue_work(mhi_cntrl->ring_wq, &mhi_cntrl->ring_work);
+	}
+}
+
+/*
+ * Channel interrupt statuses are contained in 4 registers each of 32bit length.
+ * For checking all interrupts, we need to loop through each registers and then
+ * check for bits set.
+ */
+static void mhi_ep_check_channel_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 ch_int, ch_idx;
+	int i;
+
+	mhi_ep_mmio_read_chdb_status_interrupts(mhi_cntrl);
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++) {
+		ch_idx = i * MHI_MASK_CH_EV_LEN;
+
+		/* Only process channel interrupt if the mask is enabled */
+		ch_int = (mhi_cntrl->chdb[i].status & mhi_cntrl->chdb[i].mask);
+		if (ch_int) {
+			dev_dbg(dev, "Processing channel doorbell interrupt\n");
+			mhi_ep_queue_channel_db(mhi_cntrl, ch_int, ch_idx);
+			mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_CLEAR_A7_n(i),
+							mhi_cntrl->chdb[i].status);
+		}
+	}
+}
+
 static void mhi_ep_state_worker(struct work_struct *work)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, state_work);
@@ -215,6 +265,54 @@ static void mhi_ep_state_worker(struct work_struct *work)
 	}
 }
 
+static void mhi_ep_process_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl,
+					 enum mhi_state state)
+{
+	struct mhi_ep_state_transition *item = kmalloc(sizeof(*item), GFP_ATOMIC);
+
+	item->state = state;
+	spin_lock(&mhi_cntrl->list_lock);
+	list_add_tail(&item->node, &mhi_cntrl->st_transition_list);
+	spin_unlock(&mhi_cntrl->list_lock);
+
+	queue_work(mhi_cntrl->state_wq, &mhi_cntrl->state_work);
+}
+
+/*
+ * Interrupt handler that services interrupts raised by the host writing to
+ * MHICTRL and Command ring doorbell (CRDB) registers for state change and
+ * channel interrupts.
+ */
+static irqreturn_t mhi_ep_irq(int irq, void *data)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = data;
+
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state state;
+	u32 int_value = 0;
+
+	/* Acknowledge the interrupts */
+	mhi_ep_mmio_read(mhi_cntrl, MHI_CTRL_INT_STATUS_A7, &int_value);
+	mhi_ep_mmio_write(mhi_cntrl, MHI_CTRL_INT_CLEAR_A7, int_value);
+
+	/* Check for ctrl interrupt */
+	if (FIELD_GET(MHI_CTRL_INT_STATUS_A7_MSK, int_value)) {
+		dev_dbg(dev, "Processing ctrl interrupt\n");
+		mhi_ep_process_ctrl_interrupt(mhi_cntrl, state);
+	}
+
+	/* Check for command doorbell interrupt */
+	if (FIELD_GET(MHI_CTRL_INT_STATUS_CRDB_MSK, int_value)) {
+		dev_dbg(dev, "Processing command doorbell interrupt\n");
+		queue_work(mhi_cntrl->ring_wq, &mhi_cntrl->ring_work);
+	}
+
+	/* Check for channel interrupts */
+	mhi_ep_check_channel_interrupt(mhi_cntrl);
+
+	return IRQ_HANDLED;
+}
+
 static void mhi_ep_release_device(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
@@ -406,7 +504,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	struct mhi_ep_device *mhi_dev;
 	int ret;
 
-	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio)
+	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio || !mhi_cntrl->irq)
 		return -EINVAL;
 
 	ret = parse_ch_cfg(mhi_cntrl, config);
@@ -450,12 +548,20 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_destroy_state_wq;
 	}
 
+	irq_set_status_flags(mhi_cntrl->irq, IRQ_NOAUTOEN);
+	ret = request_irq(mhi_cntrl->irq, mhi_ep_irq, IRQF_TRIGGER_HIGH,
+			  "doorbell_irq", mhi_cntrl);
+	if (ret) {
+		dev_err(mhi_cntrl->cntrl_dev, "Failed to request Doorbell IRQ: %d\n", ret);
+		goto err_ida_free;
+	}
+
 	/* Allocate the controller device */
 	mhi_dev = mhi_ep_alloc_device(mhi_cntrl);
 	if (IS_ERR(mhi_dev)) {
 		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate controller device\n");
 		ret = PTR_ERR(mhi_dev);
-		goto err_ida_free;
+		goto err_free_irq;
 	}
 
 	mhi_dev->dev_type = MHI_DEVICE_CONTROLLER;
@@ -474,6 +580,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
 err_release_dev:
 	put_device(&mhi_dev->dev);
+err_free_irq:
+	free_irq(mhi_cntrl->irq, mhi_cntrl);
 err_ida_free:
 	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
 err_destroy_state_wq:
@@ -496,6 +604,8 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 	destroy_workqueue(mhi_cntrl->state_wq);
 	destroy_workqueue(mhi_cntrl->ring_wq);
 
+	free_irq(mhi_cntrl->irq, mhi_cntrl);
+
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_chan);
 
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index ea7435d0e609..7a665cd55579 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -84,6 +84,7 @@ struct mhi_ep_db_info {
  * @chdb_offset: Channel doorbell offset set by the host
  * @erdb_offset: Event ring doorbell offset set by the host
  * @index: MHI Endpoint controller index
+ * @irq: IRQ used by the endpoint controller
  */
 struct mhi_ep_cntrl {
 	struct device *cntrl_dev;
@@ -129,6 +130,7 @@ struct mhi_ep_cntrl {
 	u32 chdb_offset;
 	u32 erdb_offset;
 	int index;
+	int irq;
 };
 
 /**
-- 
2.25.1

