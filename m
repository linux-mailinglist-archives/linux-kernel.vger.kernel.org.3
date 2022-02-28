Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569EF4C6D03
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiB1Mqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiB1Mqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:46:34 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5120F48322
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so10255983pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ej1D8HLsv04U7QukbTs3p1AIbD/62Sh8puI8DJPJEkY=;
        b=bBgliBFlkBbvTYvj6tpRDcNbYBxod3WqOiO84lLw3sxlEJDjSx0XHUcdtVsXNtwfCG
         v/Zb0fl7Yke5JzEwoOXifiiItvV3zqoi19jrWF5U1qWkpyMbiQGvUjQ+YRtxXrk8HcPk
         dxaz7tIzgP+VvcrrEJz1qDPaacQ6km9Z3fhFpXWeIc1b97c/jONcoW9ZQ8YML9Pv5Wb/
         TbMQuAEM+jckVZFXekK5KdjD6zdzBlrOsFkvh9IVm5zGWpEbyuEvJ9bnipQdz+rR0X/S
         GPcfl6jidi2L+pr+GwGKiRqEW014zpLDGpWQSsc6m8LeRh3x3ndTGbh1stk6i0qHw7Gz
         vxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ej1D8HLsv04U7QukbTs3p1AIbD/62Sh8puI8DJPJEkY=;
        b=xn4jNCBYcwDx65zOBZ3SIOdzJEVNnHQK14hDl6C0YDQ59HCk1p+9/5CVwAnsALSp38
         tPDrQM3AYymRhDER+H+hoNi7f3nD9bI5mkrJtr/xl26Mlho1EMcBg9V9nSwGqCXp9I9t
         Y2nNXhnyadg60ms39OCVnHZnxBuumsXxkJsPZgTmCgHhSCfCZX4V2v/Dxq0KXclF5QPa
         +oTwZmAPPbPlIvc8K3EZ3Urmg/Q4zTad+Nwzv4BIDHrT5b/rfNC7wG7Ogpsb6O1zCYrc
         BUrBhkJJMakRPW5T+5LAF62X7HR7G2gRSO7qGu7oUhGhbLvPZHwIG78cu41L2e1W2fip
         cqMg==
X-Gm-Message-State: AOAM531z4CgBGN+eH7NH5M/AWUmfFbY2IjpQ7/v5X8Tfu+8ZTk0Av3Ar
        Tz/XqYcqDkeVPrxGEC3czGw/SWvCnmyf
X-Google-Smtp-Source: ABdhPJxEz5VBeplv3KEj6tbfJCgClNbmGwIr99meJK1WJULhN7rwgZAjZW54ZpSj/xflwuF7fJ51IQ==
X-Received: by 2002:a17:902:7b8d:b0:14f:f1c2:9ff4 with SMTP id w13-20020a1709027b8d00b0014ff1c29ff4mr20222499pll.54.1646052329701;
        Mon, 28 Feb 2022 04:45:29 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:45:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 17/27] bus: mhi: ep: Add support for processing MHI endpoint interrupts
Date:   Mon, 28 Feb 2022 18:13:34 +0530
Message-Id: <20220228124344.77359-18-manivannan.sadhasivam@linaro.org>
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

Add support for processing MHI endpoint interrupts such as control
interrupt, command interrupt and channel interrupt from the host.

The interrupts will be generated in the endpoint device whenever host
writes to the corresponding doorbell registers. The doorbell logic
is handled inside the hardware internally.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 123 +++++++++++++++++++++++++++++++++++++-
 include/linux/mhi_ep.h    |   4 ++
 2 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 7a29543586d0..ce690b1aeace 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -143,6 +143,112 @@ static void mhi_ep_state_worker(struct work_struct *work)
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
+	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++) {
+		ch_idx = i * MHI_MASK_CH_EV_LEN;
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
@@ -339,7 +445,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	struct mhi_ep_device *mhi_dev;
 	int ret;
 
-	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio)
+	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio || !mhi_cntrl->irq)
 		return -EINVAL;
 
 	ret = mhi_ep_chan_init(mhi_cntrl, config);
@@ -361,6 +467,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	}
 
 	INIT_LIST_HEAD(&mhi_cntrl->st_transition_list);
+	INIT_LIST_HEAD(&mhi_cntrl->ch_db_list);
 	spin_lock_init(&mhi_cntrl->state_lock);
 	spin_lock_init(&mhi_cntrl->list_lock);
 	mutex_init(&mhi_cntrl->event_lock);
@@ -376,12 +483,20 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_destroy_wq;
 	}
 
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
@@ -398,6 +513,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
 err_put_dev:
 	put_device(&mhi_dev->dev);
+err_free_irq:
+	free_irq(mhi_cntrl->irq, mhi_cntrl);
 err_ida_free:
 	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
 err_destroy_wq:
@@ -417,6 +534,8 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 
 	destroy_workqueue(mhi_cntrl->wq);
 
+	free_irq(mhi_cntrl->irq, mhi_cntrl);
+
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_chan);
 
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index dc27a5de7d3c..43aa9b133db4 100644
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
@@ -87,6 +88,7 @@ struct mhi_ep_db_info {
  * @chdb_offset: Channel doorbell offset set by the host
  * @erdb_offset: Event ring doorbell offset set by the host
  * @index: MHI Endpoint controller index
+ * @irq: IRQ used by the endpoint controller
  */
 struct mhi_ep_cntrl {
 	struct device *cntrl_dev;
@@ -111,6 +113,7 @@ struct mhi_ep_cntrl {
 	spinlock_t state_lock;
 
 	struct list_head st_transition_list;
+	struct list_head ch_db_list;
 
 	struct workqueue_struct *wq;
 	struct work_struct state_work;
@@ -137,6 +140,7 @@ struct mhi_ep_cntrl {
 	u32 chdb_offset;
 	u32 erdb_offset;
 	u32 index;
+	int irq;
 };
 
 /**
-- 
2.25.1

