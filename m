Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625ED4AEEFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiBIKJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiBIKJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:09:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9586E0FF9ED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:07:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso3081053pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2T5IRzoOZVYDY0zgBjv898DXplyaPio2veegSPIUaPo=;
        b=dJRbTQ43vxbVMnJlQH1u8dNDA/kXbVs67ucQfEjS/xXJdVSfdiiNbHqAoK+VNC1kKk
         BbToe+7afZNKcWZ2Sk/agN/6qlIMXHhOLSZ/ZZ+S0RRHcx/+U6D3sygfF8eW4W86agbz
         gT+KDizHCGK5q6ixLWffEk47Ydzg1KlypzHnqMqlyvLFOu8qtuAMzstX4vAC1VQT3OkG
         Tbut62KVaq+kaD96adVIyXm5nzFD03e3twvvU7Pjp5z+FuBjCExEJpFoXkSCBvE9L7s5
         8EsR45oAmuHwuN0sKAII6PSkIlBL+ZEWQ56/7CT1pGFf+cmEgazO2+kG0xkZvHvSNcce
         ZMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2T5IRzoOZVYDY0zgBjv898DXplyaPio2veegSPIUaPo=;
        b=FfMiowBrOD7idcGAR52OQmigu2yHc4nwZ5SPUYs5DHxz5I9QIC3fHVqEIQ9hkPGxd6
         1xeYKxcbeBco6xmJI7P4FniTYXxpomHMjwLBCRCHtLgZ8ZVNoR76NPm/S6s9gXU30gJW
         +VPk9KbqpsAR9R2iVVWNe4hgy4FwZH1KerYwglKxeIA7UzipaEhSZChJ09WZ5TAmJ5Dd
         P7PcMeTOg2ldA2EHHeYonlIa8aorCKTZUSVOHQrsLdSw3RoOgdcsW1VHxD+RV7Qssmfy
         Xng/xC+tIud/GcZ4DnX9uEecdZ+ss0/w8Rw1XHap+yKLCAPwHUaNOroqua1aVU7s/ihM
         q/bQ==
X-Gm-Message-State: AOAM532l5copQ6Wi7KTfjFEhgQ2DpZbQnScyszoue+wSGVzzFmaJQsU0
        hdvgM8HNMxJuOPCMaFhyXWDT
X-Google-Smtp-Source: ABdhPJxIDz8puE8UtnqU5D3MQnL/efNmxYgS5MBKHjJudBzkiRyEeyyxcv14sUo26Fn3V4kX0y5/xg==
X-Received: by 2002:a17:902:d2ca:: with SMTP id n10mr1368181plc.88.1644401225202;
        Wed, 09 Feb 2022 02:07:05 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:07:04 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 20/23] bus: mhi: ep: Add support for processing command and TRE rings
Date:   Wed,  9 Feb 2022 15:26:21 +0530
Message-Id: <20220209095624.26389-21-manivannan.sadhasivam@linaro.org>
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

Since we now have all necessary infrastructure, let's add support for
processing the command and TRE rings in the MHI endpoint stack. As a part
of the TRE ring processing, the channel read functionality is also added
that allows the MHI endpoint device to read data from the host over any
available MHI channel.

During the TRE ring processing, client driver will also be notified about
the data availability.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 303 ++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |   9 ++
 2 files changed, 312 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index b12c1f4ae8be..c46d09cc67f4 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -21,6 +21,7 @@
 
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
+static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
 static int mhi_ep_destroy_device(struct device *dev, void *data);
 
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
@@ -185,6 +186,308 @@ void mhi_ep_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t
 	mhi_cntrl->free_addr(mhi_cntrl, phys - offset, virt - offset, size);
 }
 
+int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el)
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
+		dev_dbg(dev, "Received START command for channel (%d)\n", ch_id);
+
+		mutex_lock(&mhi_chan->lock);
+		/* Initialize and configure the corresponding channel ring */
+		if (!ch_ring->started) {
+			ret = mhi_ep_ring_start(mhi_cntrl, ch_ring,
+				(union mhi_ep_ring_ctx *)&mhi_cntrl->ch_ctx_cache[ch_id]);
+			if (ret) {
+				dev_err(dev, "Failed to start ring for channel (%d)\n", ch_id);
+				ret = mhi_ep_send_cmd_comp_event(mhi_cntrl,
+							MHI_EV_CC_UNDEFINED_ERR);
+				if (ret)
+					dev_err(dev, "Error sending completion event (%d)\n",
+						MHI_EV_CC_UNDEFINED_ERR);
+
+				goto err_unlock;
+			}
+		}
+
+		/* Enable DB for the channel */
+		mhi_ep_mmio_enable_chdb_a7(mhi_cntrl, ch_id);
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
+			dev_err(dev, "Error sending command completion event (%d)\n",
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
+				dev_err(dev, "Error creating device for channel (%d)\n", ch_id);
+				return ret;
+			}
+		}
+
+		break;
+	case MHI_PKT_TYPE_STOP_CHAN_CMD:
+		dev_dbg(dev, "Received STOP command for channel (%d)\n", ch_id);
+		if (!ch_ring->started) {
+			dev_err(dev, "Channel (%d) not opened\n", ch_id);
+			return -ENODEV;
+		}
+
+		mutex_lock(&mhi_chan->lock);
+		/* Disable DB for the channel */
+		mhi_ep_mmio_disable_chdb_a7(mhi_cntrl, ch_id);
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
+			dev_err(dev, "Error sending command completion event (%d)\n",
+				MHI_EV_CC_SUCCESS);
+			goto err_unlock;
+		}
+
+		mutex_unlock(&mhi_chan->lock);
+		break;
+	case MHI_PKT_TYPE_RESET_CHAN_CMD:
+		dev_dbg(dev, "Received STOP command for channel (%d)\n", ch_id);
+		if (!ch_ring->started) {
+			dev_err(dev, "Channel (%d) not opened\n", ch_id);
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
+			dev_err(dev, "Error sending command completion event (%d)\n",
+				MHI_EV_CC_SUCCESS);
+			goto err_unlock;
+		}
+
+		mutex_unlock(&mhi_chan->lock);
+		break;
+	default:
+		dev_err(dev, "Invalid command received: %d for channel (%d)",
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
+bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir)
+{
+	struct mhi_ep_chan *mhi_chan = (dir == DMA_FROM_DEVICE) ? mhi_dev->dl_chan :
+								mhi_dev->ul_chan;
+	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
+
+	return !!(ring->rd_offset == ring->wr_offset);
+}
+EXPORT_SYMBOL_GPL(mhi_ep_queue_is_empty);
+
+static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
+				struct mhi_ep_ring *ring,
+				struct mhi_result *result,
+				u32 len)
+{
+	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
+	size_t bytes_to_read, read_offset, write_offset;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ep_ring_element *el;
+	bool td_done = false;
+	void *write_to_loc;
+	u64 read_from_loc;
+	u32 buf_remaining;
+	int ret;
+
+	buf_remaining = len;
+
+	do {
+		/* Don't process the transfer ring if the channel is not in RUNNING state */
+		if (mhi_chan->state != MHI_CH_STATE_RUNNING)
+			return -ENODEV;
+
+		el = &ring->ring_cache[ring->rd_offset];
+
+		/* Check if there is data pending to be read from previous read operation */
+		if (mhi_chan->tre_bytes_left) {
+			dev_dbg(dev, "TRE bytes remaining: %d\n", mhi_chan->tre_bytes_left);
+			bytes_to_read = min(buf_remaining, mhi_chan->tre_bytes_left);
+		} else {
+			mhi_chan->tre_loc = MHI_EP_TRE_GET_PTR(el);
+			mhi_chan->tre_size = MHI_EP_TRE_GET_LEN(el);
+			mhi_chan->tre_bytes_left = mhi_chan->tre_size;
+
+			bytes_to_read = min(buf_remaining, mhi_chan->tre_size);
+		}
+
+		read_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
+		write_offset = len - buf_remaining;
+		read_from_loc = mhi_chan->tre_loc + read_offset;
+		write_to_loc = result->buf_addr + write_offset;
+
+		dev_dbg(dev, "Reading %zd bytes from channel (%d)\n", bytes_to_read, ring->ch_id);
+		ret = mhi_cntrl->read_from_host(mhi_cntrl, read_from_loc, write_to_loc,
+						bytes_to_read);
+		if (ret < 0)
+			return ret;
+
+		buf_remaining -= bytes_to_read;
+		mhi_chan->tre_bytes_left -= bytes_to_read;
+
+		/*
+		 * Once the TRE (Transfer Ring Element) of a TD (Transfer Descriptor) has been
+		 * read completely:
+		 *
+		 * 1. Send completion event to the host based on the flags set in TRE.
+		 * 2. Increment the local read offset of the transfer ring.
+		 */
+		if (!mhi_chan->tre_bytes_left) {
+			/*
+			 * The host will split the data packet into multiple TREs if it can't fit
+			 * the packet in a single TRE. In that case, CHAIN flag will be set by the
+			 * host for all TREs except the last one.
+			 */
+			if (MHI_EP_TRE_GET_CHAIN(el)) {
+				/*
+				 * IEOB (Interrupt on End of Block) flag will be set by the host if
+				 * it expects the completion event for all TREs of a TD.
+				 */
+				if (MHI_EP_TRE_GET_IEOB(el))
+					mhi_ep_send_completion_event(mhi_cntrl,
+					ring, MHI_EP_TRE_GET_LEN(el), MHI_EV_CC_EOB);
+			} else {
+				/*
+				 * IEOT (Interrupt on End of Transfer) flag will be set by the host
+				 * for the last TRE of the TD and expects the completion event for
+				 * the same.
+				 */
+				if (MHI_EP_TRE_GET_IEOT(el))
+					mhi_ep_send_completion_event(mhi_cntrl,
+					ring, MHI_EP_TRE_GET_LEN(el), MHI_EV_CC_EOT);
+				td_done = true;
+			}
+
+			mhi_ep_ring_inc_index(ring);
+		}
+
+		result->bytes_xferd += bytes_to_read;
+	} while (buf_remaining && !td_done);
+
+	return 0;
+}
+
+int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct mhi_result result = {};
+	u32 len = MHI_EP_DEFAULT_MTU;
+	struct mhi_ep_chan *mhi_chan;
+	int ret;
+
+	mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
+
+	/*
+	 * Bail out if transfer callback is not registered for the channel.
+	 * This is most likely due to the client driver not loaded at this point.
+	 */
+	if (!mhi_chan->xfer_cb) {
+		dev_err(&mhi_chan->mhi_dev->dev, "Client driver not available\n");
+		return -ENODEV;
+	}
+
+	if (ring->ch_id % 2) {
+		/* DL channel */
+		result.dir = mhi_chan->dir;
+		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+	} else {
+		/* UL channel */
+		do {
+			result.buf_addr = kzalloc(len, GFP_KERNEL);
+			if (!result.buf_addr)
+				return -ENOMEM;
+
+			ret = mhi_ep_read_channel(mhi_cntrl, ring, &result, len);
+			if (ret < 0) {
+				dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel: %d", ret);
+				kfree(result.buf_addr);
+				return ret;
+			}
+
+			result.dir = mhi_chan->dir;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+			kfree(result.buf_addr);
+			result.bytes_xferd = 0;
+
+			/* Read until the ring becomes empty */
+		} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
+	}
+
+	return 0;
+}
+
 static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 276d29fef465..aaf4b6942037 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -268,4 +268,13 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl);
  */
 void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl);
 
+/**
+ * mhi_ep_queue_is_empty - Determine whether the transfer queue is empty
+ * @mhi_dev: Device associated with the channels
+ * @dir: DMA direction for the channel
+ *
+ * Return: true if the queue is empty, false otherwise.
+ */
+bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir);
+
 #endif
-- 
2.25.1

