Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3E4B3733
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiBLSXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:23:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiBLSXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:23:14 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63810606DF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:22:58 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so2594216pjv.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TXpSxFmkH++353D/y17KqaRLPut9rLTNrGcXF32Trzc=;
        b=aRb0qiKjLol0cgbSQjwI6F5aTfUs0oPPGzfMTA1pVM9h3FVngqTn4OYY+vGBv467zt
         ca2yxr/C6MynXZS6K1SBjDtOuLLAiE+F1UNb8Hh+GupKORAyie1iV344e6AwiLfs2MYP
         qRzmCe+VEAeAzhbHeyUzd4IaHn31KPLUVh+Ul0mSfqIXHHhNcU0/eT076SllrcPi2RGj
         yIJ5JK/2vYbpDVNtdHwttS3dBzB/umWeHrjsDfrdSmTgvhxe3wfO9ZIEH5QjTZbtAGyg
         bPKRwRw590vWUfvScxiwdcELzx+90CF7HiFSUqe96ROuSTYfYzIJk5lgUDAkkPUUGlRz
         ogzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TXpSxFmkH++353D/y17KqaRLPut9rLTNrGcXF32Trzc=;
        b=2oDNHCORyC/kpVfS7O4osFxGglVQR2cn9Pr4qJgHTF6L3e1Fss44IJp0n47NDWPas2
         pJgTAfwCGCfp9V7iQ1J2BVhemh71E4MhzhyEZ4wKSqblSejpWtb7GprK6vye8Q/Z9AO/
         1Flc6BSp/4LEe2KNq+unVPdHB3pWt0W9RPJBO7Fzzfn1RwSoam45xqUYKzi4m5xlPdWY
         2VZ9GJApMmvV+L3Pi8mQ3lNiJOm2ZgoCZkUXrBRVFjqDqz8s5OU1XIE3zhtfawf0NunI
         aWWVj8hQeZcV5P6YPu1teMYmZstRiuBnSDYvsKu/ezm+7Db5ywC21dDHuKEa8SGoOT3U
         v67A==
X-Gm-Message-State: AOAM530BS5c73iEkNSPGN3oCGyinghJf+CAGjn5oY0YtsdDhf8CTi8Ox
        HtbuPaFlxQJ1iJcHi3dLo5Ia
X-Google-Smtp-Source: ABdhPJyhXLccNlgPfvYFLXpxrQrPm1ffN3TfV+KsExAFC7fraqn+4U76adIJtahyNO1VLsC/3tBUmA==
X-Received: by 2002:a17:903:32cb:: with SMTP id i11mr6797100plr.118.1644690177841;
        Sat, 12 Feb 2022 10:22:57 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:22:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 15/25] bus: mhi: ep: Add support for processing MHI endpoint interrupts
Date:   Sat, 12 Feb 2022 23:51:07 +0530
Message-Id: <20220212182117.49438-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
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

Add support for processing MHI endpoint interrupts such as control
interrupt, command interrupt and channel interrupt from the host.

The interrupts will be generated in the endpoint device whenever host
writes to the corresponding doorbell registers. The doorbell logic
is handled inside the hardware internally.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 113 +++++++++++++++++++++++++++++++++++++-
 include/linux/mhi_ep.h    |   2 +
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index ccb3c2795041..072b872e735b 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -185,6 +185,56 @@ static void mhi_ep_ring_worker(struct work_struct *work)
 	}
 }
 
+static void mhi_ep_queue_channel_db(struct mhi_ep_cntrl *mhi_cntrl,
+				    unsigned long ch_int, u32 ch_idx)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ep_ring_item *item;
+	struct mhi_ep_ring *ring;
+	unsigned int i;
+
+	for_each_set_bit(i, &ch_int, 32) {
+		/* Channel index varies for each register: 0, 32, 64, 96 */
+		i += ch_idx;
+		ring = &mhi_cntrl->mhi_chan[i].ring;
+
+		item = kmalloc(sizeof(*item), GFP_ATOMIC);
+		item->ring = ring;
+
+		dev_dbg(dev, "Queuing doorbell interrupt for channel (%d)\n", i);
+		spin_lock(&mhi_cntrl->list_lock);
+		list_add_tail(&item->node, &mhi_cntrl->ch_db_list);
+		spin_unlock(&mhi_cntrl->list_lock);
+
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
@@ -222,6 +272,53 @@ static void mhi_ep_state_worker(struct work_struct *work)
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
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state state;
+	u32 int_value;
+
+	/* Acknowledge the interrupts */
+	int_value = mhi_ep_mmio_read(mhi_cntrl, MHI_CTRL_INT_STATUS_A7);
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
@@ -409,7 +506,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	struct mhi_ep_device *mhi_dev;
 	int ret;
 
-	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio)
+	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio || !mhi_cntrl->irq)
 		return -EINVAL;
 
 	ret = parse_ch_cfg(mhi_cntrl, config);
@@ -454,12 +551,20 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_destroy_state_wq;
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
 
 	dev_set_name(&mhi_dev->dev, "mhi_ep%d", mhi_cntrl->index);
@@ -477,6 +582,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
 err_put_dev:
 	put_device(&mhi_dev->dev);
+err_free_irq:
+	free_irq(mhi_cntrl->irq, mhi_cntrl);
 err_ida_free:
 	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
 err_destroy_state_wq:
@@ -499,6 +606,8 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 	destroy_workqueue(mhi_cntrl->state_wq);
 	destroy_workqueue(mhi_cntrl->ring_wq);
 
+	free_irq(mhi_cntrl->irq, mhi_cntrl);
+
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_chan);
 
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 72ce30cbe87e..a207058a4991 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -90,6 +90,7 @@ struct mhi_ep_db_info {
  * @chdb_offset: Channel doorbell offset set by the host
  * @erdb_offset: Event ring doorbell offset set by the host
  * @index: MHI Endpoint controller index
+ * @irq: IRQ used by the endpoint controller
  */
 struct mhi_ep_cntrl {
 	struct device *cntrl_dev;
@@ -142,6 +143,7 @@ struct mhi_ep_cntrl {
 	u32 chdb_offset;
 	u32 erdb_offset;
 	int index;
+	int irq;
 };
 
 /**
-- 
2.25.1

