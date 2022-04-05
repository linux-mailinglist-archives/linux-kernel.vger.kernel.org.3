Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE0C4F3F3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357439AbiDEUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443736AbiDEPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86997101D7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j20-20020a17090ae61400b001ca9553d073so2718154pjy.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPnLdxVwWqpS/Y43SlQYTqZKeEDygkSAdozHlJ6hMrY=;
        b=ZgS6la0kq3ydpDai5iK3HNh9vDJJ9u9/nEgU+OUeST2SjC3Ty94WhsIOvb/PWRXHpH
         pNBryBDpxMsq2shcjpat96gbydz2APlKuFcdA5C80LfFKLCthnYLtaW9WAGqV0Qy+13G
         5VJGxx1blQftKhpXSaIH3tj+RZmzR0f8DquJJGlAcx4BWAUUpOYPLTU8nYV/zQML/1DG
         BPozEhVjUE3XY1sulwEkCI7SomyQP5X1H4qGmBbb3niKkPlDaza0RoV+HivfEUSdAbRn
         jdBQrA4Puo3HC0sWfla1OsRJX8jDsYULXAhyn+KrHrlDZxk62a54uxPsTr+XFaAQSa+3
         wx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPnLdxVwWqpS/Y43SlQYTqZKeEDygkSAdozHlJ6hMrY=;
        b=tJJX5aTGZZ1PbADKx+9kBMjvzQnsMgvVTkjYhg/CXWrpsVW6H+ByuRN9Op5ikURIEp
         vLHCz/byVCEDPMO0r9pFUFXE/AycD8AmaPNVH1o72JQTZgy/obC7f1Kmw1HPz1r4/vA+
         6nwyctjuK4IC2xoH9GA5ozKlPgN+prbO4TUgtzKuHtrvsuEeg6juKwc4JdEwbHGSDqD5
         eToRbATY7MmZtKUBBkkNntkNgpkB30DkgHoGInK39zPu0ev8LizYOZUjhTuH1+ee8r95
         rkEoiN7jY5I7ZzB5QHcD+4Q00GXY9STzmq0cDhN+JxOoVQObdQGL1Cp/YIimtlTMGSZN
         yM+A==
X-Gm-Message-State: AOAM531bFBbpgHUYhbFAkGiqD5ktCly7PNDKH2skj8o+tnEYln0TqDWd
        LtmmpPNCTDB4w/ISIOk6rtWB
X-Google-Smtp-Source: ABdhPJx14TxvP/wVvUCdEPeqQpIEydnQtStLCTq4xa7VuMPl4IM7vLmPEdRsfEciB6so9sB0G8pR0w==
X-Received: by 2002:a17:90b:3881:b0:1c7:c02b:bcf8 with SMTP id mu1-20020a17090b388100b001c7c02bbcf8mr4317123pjb.131.1649167124899;
        Tue, 05 Apr 2022 06:58:44 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:58:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/18] bus: mhi: ep: Add support for processing MHI endpoint interrupts
Date:   Tue,  5 Apr 2022 19:27:44 +0530
Message-Id: <20220405135754.6622-9-manivannan.sadhasivam@linaro.org>
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

Add support for processing MHI endpoint interrupts such as control
interrupt, command interrupt and channel interrupt from the host.

The interrupts will be generated in the endpoint device whenever host
writes to the corresponding doorbell registers. The doorbell logic
is handled inside the hardware internally.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 124 +++++++++++++++++++++++++++++++++++++-
 include/linux/mhi_ep.h    |   4 ++
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index c912daf6dc65..4e82006bd83b 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -11,6 +11,7 @@
 #include <linux/dma-direction.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/mhi_ep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -142,6 +143,112 @@ static void mhi_ep_state_worker(struct work_struct *work)
 	}
 }
 
+static void mhi_ep_queue_channel_db(struct mhi_ep_cntrl *mhi_cntrl, unsigned long ch_int,
+				    u32 ch_idx)
+{
+	struct mhi_ep_ring_item *item;
+	struct mhi_ep_ring *ring;
+	bool work = !!ch_int;
+	LIST_HEAD(head);
+	u32 i;
+
+	/* First add the ring items to a local list */
+	for_each_set_bit(i, &ch_int, 32) {
+		/* Channel index varies for each register: 0, 32, 64, 96 */
+		u32 ch_id = ch_idx + i;
+
+		ring = &mhi_cntrl->mhi_chan[ch_id].ring;
+		item = kzalloc(sizeof(*item), GFP_ATOMIC);
+		if (!item)
+			return;
+
+		item->ring = ring;
+		list_add_tail(&item->node, &head);
+	}
+
+	/* Now, splice the local list into ch_db_list and queue the work item */
+	if (work) {
+		spin_lock(&mhi_cntrl->list_lock);
+		list_splice_tail_init(&head, &mhi_cntrl->ch_db_list);
+		spin_unlock(&mhi_cntrl->list_lock);
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
+	u32 ch_int, ch_idx, i;
+
+	/* Bail out if there is no channel doorbell interrupt */
+	if (!mhi_ep_mmio_read_chdb_status_interrupts(mhi_cntrl))
+		return;
+
+	for (i = 0; i < MHI_MASK_ROWS_CH_DB; i++) {
+		ch_idx = i * MHI_MASK_CH_LEN;
+
+		/* Only process channel interrupt if the mask is enabled */
+		ch_int = mhi_cntrl->chdb[i].status & mhi_cntrl->chdb[i].mask;
+		if (ch_int) {
+			mhi_ep_queue_channel_db(mhi_cntrl, ch_int, ch_idx);
+			mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_CLEAR_n(i),
+							mhi_cntrl->chdb[i].status);
+		}
+	}
+}
+
+static void mhi_ep_process_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl,
+					 enum mhi_state state)
+{
+	struct mhi_ep_state_transition *item;
+
+	item = kzalloc(sizeof(*item), GFP_ATOMIC);
+	if (!item)
+		return;
+
+	item->state = state;
+	spin_lock(&mhi_cntrl->list_lock);
+	list_add_tail(&item->node, &mhi_cntrl->st_transition_list);
+	spin_unlock(&mhi_cntrl->list_lock);
+
+	queue_work(mhi_cntrl->wq, &mhi_cntrl->state_work);
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
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state state;
+	u32 int_value;
+
+	/* Acknowledge the ctrl interrupt */
+	int_value = mhi_ep_mmio_read(mhi_cntrl, MHI_CTRL_INT_STATUS);
+	mhi_ep_mmio_write(mhi_cntrl, MHI_CTRL_INT_CLEAR, int_value);
+
+	/* Check for ctrl interrupt */
+	if (FIELD_GET(MHI_CTRL_INT_STATUS_MSK, int_value)) {
+		dev_dbg(dev, "Processing ctrl interrupt\n");
+		mhi_ep_process_ctrl_interrupt(mhi_cntrl, state);
+	}
+
+	/* Check for command doorbell interrupt */
+	if (FIELD_GET(MHI_CTRL_INT_STATUS_CRDB_MSK, int_value))
+		dev_dbg(dev, "Processing command doorbell interrupt\n");
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
@@ -338,7 +445,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	struct mhi_ep_device *mhi_dev;
 	int ret;
 
-	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio)
+	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio || !mhi_cntrl->irq)
 		return -EINVAL;
 
 	ret = mhi_ep_chan_init(mhi_cntrl, config);
@@ -360,6 +467,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	}
 
 	INIT_LIST_HEAD(&mhi_cntrl->st_transition_list);
+	INIT_LIST_HEAD(&mhi_cntrl->ch_db_list);
 	spin_lock_init(&mhi_cntrl->state_lock);
 	spin_lock_init(&mhi_cntrl->list_lock);
 	mutex_init(&mhi_cntrl->event_lock);
@@ -375,12 +483,20 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
 	mhi_cntrl->index = ret;
 
+	irq_set_status_flags(mhi_cntrl->irq, IRQ_NOAUTOEN);
+	ret = request_irq(mhi_cntrl->irq, mhi_ep_irq, IRQF_TRIGGER_HIGH,
+			  "doorbell_irq", mhi_cntrl);
+	if (ret) {
+		dev_err(mhi_cntrl->cntrl_dev, "Failed to request Doorbell IRQ\n");
+		goto err_ida_free;
+	}
+
 	/* Allocate the controller device */
 	mhi_dev = mhi_ep_alloc_device(mhi_cntrl, MHI_DEVICE_CONTROLLER);
 	if (IS_ERR(mhi_dev)) {
 		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate controller device\n");
 		ret = PTR_ERR(mhi_dev);
-		goto err_ida_free;
+		goto err_free_irq;
 	}
 
 	dev_set_name(&mhi_dev->dev, "mhi_ep%u", mhi_cntrl->index);
@@ -397,6 +513,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
 err_put_dev:
 	put_device(&mhi_dev->dev);
+err_free_irq:
+	free_irq(mhi_cntrl->irq, mhi_cntrl);
 err_ida_free:
 	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
 err_destroy_wq:
@@ -416,6 +534,8 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 
 	destroy_workqueue(mhi_cntrl->wq);
 
+	free_irq(mhi_cntrl->irq, mhi_cntrl);
+
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_chan);
 
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 2880d2aa88b8..137bd3ee2e43 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -70,6 +70,7 @@ struct mhi_ep_db_info {
  * @list_lock: Lock for protecting state transition and channel doorbell lists
  * @state_lock: Lock for protecting state transitions
  * @st_transition_list: List of state transitions
+ * @ch_db_list: List of queued channel doorbells
  * @wq: Dedicated workqueue for handling rings and state changes
  * @state_work: State transition worker
  * @raise_irq: CB function for raising IRQ to the host
@@ -85,6 +86,7 @@ struct mhi_ep_db_info {
  * @chdb_offset: Channel doorbell offset set by the host
  * @erdb_offset: Event ring doorbell offset set by the host
  * @index: MHI Endpoint controller index
+ * @irq: IRQ used by the endpoint controller
  */
 struct mhi_ep_cntrl {
 	struct device *cntrl_dev;
@@ -109,6 +111,7 @@ struct mhi_ep_cntrl {
 	spinlock_t state_lock;
 
 	struct list_head st_transition_list;
+	struct list_head ch_db_list;
 
 	struct workqueue_struct *wq;
 	struct work_struct state_work;
@@ -130,6 +133,7 @@ struct mhi_ep_cntrl {
 	u32 chdb_offset;
 	u32 erdb_offset;
 	u32 index;
+	int irq;
 };
 
 /**
-- 
2.25.1

