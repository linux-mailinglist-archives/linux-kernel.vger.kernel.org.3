Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721964C6D10
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiB1MrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbiB1Mqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:46:51 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B5477A99
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:56 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gb21so11022745pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QjlXVyn2SFmUp4Vpbp1tqUjYVeuv+B4+SU1FNvhrxEY=;
        b=U3tFyZYIOctncWfQvyZWlNKuyR19c0QFA+6A9rAGeGY9VWIn1HLSvmz0iHfAHVMZ6f
         Wwv8bmnBuFb8SL0gB5zk68bWuRFPomOEBc4nZ8XLW98dIedQhP/ccnlA27L5QL3qVqn7
         xe1UqKNtkocWPFrPgYAqCbCuqPdSqYA7B2mdsLmIdKmxLGDv6d8q1iV4DGl0+XYdGpaa
         tACE9Wqw0g/seyUaE2dBsKTFN8JXaGH76Dd9ufzRIrgEGyJF3ZBilu4JmSHwE8pad4JD
         T1LmnMOtfipJfozO0PLilDlpa3xcAEliyER/q7w/gcqznQNdwjx25e31F121gSgVktoC
         ANJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QjlXVyn2SFmUp4Vpbp1tqUjYVeuv+B4+SU1FNvhrxEY=;
        b=YbQpURR038/I6viz8yjEi59kDmAQmnVGJ0u/EiyzgKTKQ6p+KpvV9lkpBL6W8wDQW+
         U1h8hDeJ+jgUmV43WhBSiAV/8W+l8iO0OBIxOCuXdFSQ1FBiPWhggdXXLnkQJtWVuOT5
         IXHdb9IHZ2Xb80QOHdXsms/q5tQdfTQEG6sB6BFyuMIEUutrH5z/RGmdZitD53wsxctg
         59VmtVZMEFfF17Qh710D+NO76g5GG4rEwGj/mIEe/DoL+xGDmIhb48YtMqswCW9zsR5W
         Q2+y03gSp5ETFDJB5uehe8j5oAnSNAmnuDo9//4lSStibOLphB7OboQdnFH/bYOGgk21
         +LPQ==
X-Gm-Message-State: AOAM530iCOHIdLkqlprwhm3yg3rT1kw9WMsNby2CEzA1cIvIzISiQawv
        Am8YjfriYBQxGjHB6h+36teB
X-Google-Smtp-Source: ABdhPJwK3k1GMV0Qha6To81soExvk1cabhNK9Gc3J777AMcibozPpplWTCf55xADy4eoSrkN+rr8rg==
X-Received: by 2002:a17:903:32c2:b0:151:3e13:a33b with SMTP id i2-20020a17090332c200b001513e13a33bmr13892024plr.104.1646052356110;
        Mon, 28 Feb 2022 04:45:56 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:45:55 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 22/27] bus: mhi: ep: Add support for processing command rings
Date:   Mon, 28 Feb 2022 18:13:39 +0530
Message-Id: <20220228124344.77359-23-manivannan.sadhasivam@linaro.org>
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

Add support for processing the command rings. Command ring is used by the
host to issue channel specific commands to the ep device. Following
commands are supported:

1. Start channel
2. Stop channel
3. Reset channel

Once the device receives the command doorbell interrupt from host, it
executes the command and generates a command completion event to the
host in the primary event ring.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 190 +++++++++++++++++++++++++++++++++++++-
 include/linux/mhi_ep.h    |   2 +
 2 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 132fd9f51a1f..1d4a9f6db8a3 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -21,6 +21,7 @@
 
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
+static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
 static int mhi_ep_destroy_device(struct device *dev, void *data);
 
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
@@ -148,6 +149,156 @@ void mhi_ep_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t
 	mhi_cntrl->free_addr(mhi_cntrl, phys - offset, virt - offset, size);
 }
 
+int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_element *el)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_result result = {};
+	struct mhi_ep_chan *mhi_chan;
+	struct mhi_ep_ring *ch_ring;
+	u32 tmp, ch_id;
+	int ret;
+
+	ch_id = MHI_TRE_GET_CMD_CHID(el);
+	mhi_chan = &mhi_cntrl->mhi_chan[ch_id];
+	ch_ring = &mhi_cntrl->mhi_chan[ch_id].ring;
+
+	switch (MHI_TRE_GET_CMD_TYPE(el)) {
+	case MHI_PKT_TYPE_START_CHAN_CMD:
+		dev_dbg(dev, "Received START command for channel (%u)\n", ch_id);
+
+		mutex_lock(&mhi_chan->lock);
+		/* Initialize and configure the corresponding channel ring */
+		if (!ch_ring->started) {
+			ret = mhi_ep_ring_start(mhi_cntrl, ch_ring,
+				(union mhi_ep_ring_ctx *)&mhi_cntrl->ch_ctx_cache[ch_id]);
+			if (ret) {
+				dev_err(dev, "Failed to start ring for channel (%u)\n", ch_id);
+				ret = mhi_ep_send_cmd_comp_event(mhi_cntrl,
+							MHI_EV_CC_UNDEFINED_ERR);
+				if (ret)
+					dev_err(dev, "Error sending completion event: %d\n", ret);
+
+				goto err_unlock;
+			}
+		}
+
+		/* Set channel state to RUNNING */
+		mhi_chan->state = MHI_CH_STATE_RUNNING;
+		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[ch_id].chcfg);
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_RUNNING);
+		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = cpu_to_le32(tmp);
+
+		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
+		if (ret) {
+			dev_err(dev, "Error sending command completion event (%u)\n",
+				MHI_EV_CC_SUCCESS);
+			goto err_unlock;
+		}
+
+		mutex_unlock(&mhi_chan->lock);
+
+		/*
+		 * Create MHI device only during UL channel start. Since the MHI
+		 * channels operate in a pair, we'll associate both UL and DL
+		 * channels to the same device.
+		 *
+		 * We also need to check for mhi_dev != NULL because, the host
+		 * will issue START_CHAN command during resume and we don't
+		 * destroy the device during suspend.
+		 */
+		if (!(ch_id % 2) && !mhi_chan->mhi_dev) {
+			ret = mhi_ep_create_device(mhi_cntrl, ch_id);
+			if (ret) {
+				dev_err(dev, "Error creating device for channel (%u)\n", ch_id);
+				mhi_ep_handle_syserr(mhi_cntrl);
+				return ret;
+			}
+		}
+
+		/* Finally, enable DB for the channel */
+		mhi_ep_mmio_enable_chdb(mhi_cntrl, ch_id);
+
+		break;
+	case MHI_PKT_TYPE_STOP_CHAN_CMD:
+		dev_dbg(dev, "Received STOP command for channel (%u)\n", ch_id);
+		if (!ch_ring->started) {
+			dev_err(dev, "Channel (%u) not opened\n", ch_id);
+			return -ENODEV;
+		}
+
+		mutex_lock(&mhi_chan->lock);
+		/* Disable DB for the channel */
+		mhi_ep_mmio_disable_chdb(mhi_cntrl, ch_id);
+
+		/* Send channel disconnect status to client drivers */
+		result.transaction_status = -ENOTCONN;
+		result.bytes_xferd = 0;
+		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+		/* Set channel state to STOP */
+		mhi_chan->state = MHI_CH_STATE_STOP;
+		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[ch_id].chcfg);
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_STOP);
+		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = cpu_to_le32(tmp);
+
+		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
+		if (ret) {
+			dev_err(dev, "Error sending command completion event (%u)\n",
+				MHI_EV_CC_SUCCESS);
+			goto err_unlock;
+		}
+
+		mutex_unlock(&mhi_chan->lock);
+		break;
+	case MHI_PKT_TYPE_RESET_CHAN_CMD:
+		dev_dbg(dev, "Received STOP command for channel (%u)\n", ch_id);
+		if (!ch_ring->started) {
+			dev_err(dev, "Channel (%u) not opened\n", ch_id);
+			return -ENODEV;
+		}
+
+		mutex_lock(&mhi_chan->lock);
+		/* Stop and reset the transfer ring */
+		mhi_ep_ring_reset(mhi_cntrl, ch_ring);
+
+		/* Send channel disconnect status to client driver */
+		result.transaction_status = -ENOTCONN;
+		result.bytes_xferd = 0;
+		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+		/* Set channel state to DISABLED */
+		mhi_chan->state = MHI_CH_STATE_DISABLED;
+		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[ch_id].chcfg);
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_DISABLED);
+		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = cpu_to_le32(tmp);
+
+		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
+		if (ret) {
+			dev_err(dev, "Error sending command completion event (%u)\n",
+				MHI_EV_CC_SUCCESS);
+			goto err_unlock;
+		}
+
+		mutex_unlock(&mhi_chan->lock);
+		break;
+	default:
+		dev_err(dev, "Invalid command received: %lu for channel (%u)\n",
+			MHI_TRE_GET_CMD_TYPE(el), ch_id);
+		return -EINVAL;
+	}
+
+	return 0;
+
+err_unlock:
+	mutex_unlock(&mhi_chan->lock);
+
+	return ret;
+}
+
 static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	size_t cmd_ctx_host_size, ch_ctx_host_size, ev_ctx_host_size;
@@ -291,6 +442,40 @@ static int mhi_ep_enable(struct mhi_ep_cntrl *mhi_cntrl)
 	return 0;
 }
 
+static void mhi_ep_cmd_ring_worker(struct work_struct *work)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, cmd_ring_work);
+	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_cmd->ring;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ring_element *el;
+	int ret;
+
+	/* Update the write offset for the ring */
+	ret = mhi_ep_update_wr_offset(ring);
+	if (ret) {
+		dev_err(dev, "Error updating write offset for ring\n");
+		return;
+	}
+
+	/* Sanity check to make sure there are elements in the ring */
+	if (ring->rd_offset == ring->wr_offset)
+		return;
+
+	/*
+	 * Process command ring element till write offset. In case of an error, just try to
+	 * process next element.
+	 */
+	while (ring->rd_offset != ring->wr_offset) {
+		el = &ring->ring_cache[ring->rd_offset];
+
+		ret = mhi_ep_process_cmd_ring(ring, el);
+		if (ret)
+			dev_err(dev, "Error processing cmd ring element: %zu\n", ring->rd_offset);
+
+		mhi_ep_ring_inc_index(ring);
+	}
+}
+
 static void mhi_ep_state_worker(struct work_struct *work)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, state_work);
@@ -434,8 +619,10 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
 	}
 
 	/* Check for command doorbell interrupt */
-	if (FIELD_GET(MHI_CTRL_INT_STATUS_CRDB_MSK, int_value))
+	if (FIELD_GET(MHI_CTRL_INT_STATUS_CRDB_MSK, int_value)) {
 		dev_dbg(dev, "Processing command doorbell interrupt\n");
+		queue_work(mhi_cntrl->wq, &mhi_cntrl->cmd_ring_work);
+	}
 
 	/* Check for channel interrupts */
 	mhi_ep_check_channel_interrupt(mhi_cntrl);
@@ -843,6 +1030,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
 	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
 	INIT_WORK(&mhi_cntrl->reset_work, mhi_ep_reset_worker);
+	INIT_WORK(&mhi_cntrl->cmd_ring_work, mhi_ep_cmd_ring_worker);
 
 	mhi_cntrl->wq = alloc_workqueue("mhi_ep_wq", 0, 0);
 	if (!mhi_cntrl->wq) {
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index e77a7b025430..681c638833ff 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -77,6 +77,7 @@ struct mhi_ep_db_info {
  * @wq: Dedicated workqueue for handling rings and state changes
  * @state_work: State transition worker
  * @reset_work: Worker for MHI Endpoint reset
+ * @cmd_ring_work: Worker for processing command rings
  * @raise_irq: CB function for raising IRQ to the host
  * @alloc_addr: CB function for allocating memory in endpoint for storing host context
  * @map_addr: CB function for mapping host context to endpoint
@@ -126,6 +127,7 @@ struct mhi_ep_cntrl {
 	struct workqueue_struct *wq;
 	struct work_struct state_work;
 	struct work_struct reset_work;
+	struct work_struct cmd_ring_work;
 
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
 	void __iomem *(*alloc_addr)(struct mhi_ep_cntrl *mhi_cntrl, phys_addr_t *phys_addr,
-- 
2.25.1

