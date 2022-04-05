Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC53F4F4E17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587672AbiDFAKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443760AbiDEPkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E3496B3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:59:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so2602854pjn.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ny+phYwNiJnvXwk2X19s7jEmqFEJxYeMxhclYgpS61Y=;
        b=X9D62q+dqROeyzyL44KzLP+BCYSx7UAbu0SA27pEi7tpX1mpP6ccfVar6CW/EPfF7b
         tgLsFGPX21UCDEjbkYRp1iI+zzzpk42KTTLxwYrwK7g7OcB3y3Fp84BpDKp2OmHiO8UM
         Ss1WYdUkX8HMUS7L2dvIQyqj1YmmEcIZJJpnaz6+VBjM1vllfdNcy+jU5KN8oDZQXN1B
         3c1uV2e5RN6PfDaxWX/gD4Yt1V0QkOQK6sZYIi2L4OMwQqLhuJKNF3gv1KABi+CPneda
         rmE1mQyppXHwH/7cFZ/ZHP4TAbGUkXbrmIZcdIqznp4sbBuwwKpthWDKgG3Rqp3PuNw3
         oOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ny+phYwNiJnvXwk2X19s7jEmqFEJxYeMxhclYgpS61Y=;
        b=AY5ah44o2n35aJqza1EAmgAzNOfhjyL3TT2H0MudTaOpRBZv5gn0B3qpwIVtIm7lq+
         n3IcuFl2iznDh0GqUoRU4NaFUxP6NY7yWCy4bbNoCH4bzBurym/VZhLCLjPeZgwRRVPB
         yWEI7zxKeyrLs5T0Axfm8MtZS1w9SdI/48gBK88d1c29v22ydk2RTV1rgFio+uw8dwHA
         cT5/KX7kxsAYQEF6N4s7TByNlQo98YYmHI+kKRRgiwRbdojW9A/NiBRdxpfTFOa1Mcfu
         iCc+85nylQFzGdJRfSV1lk1JPW2i/fvkb837eQwMe94SYbarfdN0LlAE7GdHnufafuXX
         HQHQ==
X-Gm-Message-State: AOAM5318fHuNx5Uye5VIoRX9f+Ms0MOOySkv5LBLuFD1o+XQT58vzawd
        n/JmJhgOnv9r80U4irZG+JjM
X-Google-Smtp-Source: ABdhPJz7can+mMiblhffpSiE6moyXGZCiLIUTTR9o3lxFg3iZ12j40Jmt062mJVc8U5RXU/scsqpFg==
X-Received: by 2002:a17:902:d888:b0:151:6fe8:6e68 with SMTP id b8-20020a170902d88800b001516fe86e68mr3637795plz.158.1649167151976;
        Tue, 05 Apr 2022 06:59:11 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:59:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/18] bus: mhi: ep: Add support for processing command rings
Date:   Tue,  5 Apr 2022 19:27:49 +0530
Message-Id: <20220405135754.6622-14-manivannan.sadhasivam@linaro.org>
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
index 706473ea4918..32ac567e0f67 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -22,6 +22,7 @@
 
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
+static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
 static int mhi_ep_destroy_device(struct device *dev, void *data);
 
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
@@ -111,6 +112,156 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
 	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
 }
 
+static int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_element *el)
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
@@ -259,6 +410,40 @@ static int mhi_ep_enable(struct mhi_ep_cntrl *mhi_cntrl)
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
@@ -402,8 +587,10 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
 	}
 
 	/* Check for command doorbell interrupt */
-	if (FIELD_GET(MHI_CTRL_INT_STATUS_CRDB_MSK, int_value))
+	if (FIELD_GET(MHI_CTRL_INT_STATUS_CRDB_MSK, int_value)) {
 		dev_dbg(dev, "Processing command doorbell interrupt\n");
+		queue_work(mhi_cntrl->wq, &mhi_cntrl->cmd_ring_work);
+	}
 
 	/* Check for channel interrupts */
 	mhi_ep_check_channel_interrupt(mhi_cntrl);
@@ -811,6 +998,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
 	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
 	INIT_WORK(&mhi_cntrl->reset_work, mhi_ep_reset_worker);
+	INIT_WORK(&mhi_cntrl->cmd_ring_work, mhi_ep_cmd_ring_worker);
 
 	mhi_cntrl->wq = alloc_workqueue("mhi_ep_wq", 0, 0);
 	if (!mhi_cntrl->wq) {
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 2f31a54c205f..8c6406d9c51f 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -77,6 +77,7 @@ struct mhi_ep_db_info {
  * @wq: Dedicated workqueue for handling rings and state changes
  * @state_work: State transition worker
  * @reset_work: Worker for MHI Endpoint reset
+ * @cmd_ring_work: Worker for processing command rings
  * @raise_irq: CB function for raising IRQ to the host
  * @alloc_map: CB function for allocating memory in endpoint for storing host context and mapping it
  * @unmap_free: CB function to unmap and free the allocated memory in endpoint for storing host context
@@ -124,6 +125,7 @@ struct mhi_ep_cntrl {
 	struct workqueue_struct *wq;
 	struct work_struct state_work;
 	struct work_struct reset_work;
+	struct work_struct cmd_ring_work;
 
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
 	int (*alloc_map)(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t *phys_ptr,
-- 
2.25.1

