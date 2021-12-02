Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62C3466295
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357680AbhLBLm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357444AbhLBLlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:41:44 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8C8C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:38:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x5so27676656pfr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+aUkbjzi1MK2hvOsEY4CY7pNRFfLRq84Zvw7+YMNiA=;
        b=BDMl+sDXE/gug1hhp4vN1iDLiKSlczozIBQUQckN9Ozsc7VjZ/vmHaSJ2E/DnOq9D0
         BbNRwiunRKoAx0R+FJxf5W9OmP9zRfgE/l4IWhOPKIo+ORfmQx6IHdtRYpc3wwMiRN/T
         PAaUIHpY+iVMKoASuom0CMseq9AFpAhcZSdaE8+jnR2XxNRCij+MzJfMMzCLZ6uhICC3
         lnVMl4Z1OVQ9uq3drAvhvelsY9BqGiK6c0C5f/EMdLUDvNlmu0xOL6yRIBZQYo+kUa3w
         tK/7D1BIL/9UzdFL7kXJmBuOFudGf6CzWvlhY5oK1xJsRi5C+j1e/TWGg0r5UJ52rlK1
         dpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+aUkbjzi1MK2hvOsEY4CY7pNRFfLRq84Zvw7+YMNiA=;
        b=nV6Tr6z774k0NkmpAHvvgFejiV/A0/TilvI+OSA3YOMZtKlGZiWTO99F33xtm3avTu
         Xp9oy9oHj1l8Mz77YpkKlsL4Q8LSBwkvY4fvOKazcg4XdXbe1oCIoIp7LcgNDEMc/kPz
         RjsaX26WHBoKf4Hg8nWVbO8LunS8tSqNohi485jhPwgZMCLfI+12LQnFQSRtHb9acwdf
         YymJ1Ns4lhw2NSvzr6DQSfqrKpSy3tUARfEOx62f5PLiPUfIoMofwLwgYGiJBzP6YUTD
         zUiYSgwznVbYfxYgpu74pXuzKlurS7gMRDdI5k3IYsum+Cz311KHLSnhXA97mWu8NFrQ
         KzMg==
X-Gm-Message-State: AOAM532OETDs1V56T/L4j9bMjG1uJHxuOcpsxQfpSl3Rfo7jFTziBvll
        DLttUP8YJ3VNkoiuIBnrYZFg
X-Google-Smtp-Source: ABdhPJzjvG3oA9qcjp93hKg2dvLQMAn/A7afYi6Cd9geFgTCwgxJWT8toiuj1bYH3lQzslBCiRKfqA==
X-Received: by 2002:aa7:96ba:0:b0:49f:c35f:83f8 with SMTP id g26-20020aa796ba000000b0049fc35f83f8mr12226795pfk.47.1638445102232;
        Thu, 02 Dec 2021 03:38:22 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:38:21 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 17/20] bus: mhi: ep: Add support for processing command and TRE rings
Date:   Thu,  2 Dec 2021 17:05:49 +0530
Message-Id: <20211202113553.238011-18-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/bus/mhi/ep/internal.h |   2 +
 drivers/bus/mhi/ep/main.c     | 350 ++++++++++++++++++++++++++++++++++
 drivers/bus/mhi/ep/ring.c     |   2 +
 include/linux/mhi_ep.h        |   9 +
 4 files changed, 363 insertions(+)

diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index 5c6b622482c9..70626ef3799d 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -188,6 +188,8 @@ int mhi_ep_process_ring(struct mhi_ep_ring *ring);
 int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *element,
 			    int evt_offset);
 void mhi_ep_ring_inc_index(struct mhi_ep_ring *ring);
+int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
+int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
 
 /* MMIO related functions */
 void mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 *regval);
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 088eac0808d1..26d551eb63ce 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -21,6 +21,7 @@
 
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
+static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
 static int mhi_ep_destroy_device(struct device *dev, void *data);
 
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 event_ring,
@@ -172,6 +173,355 @@ void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl)
 		dev_err(dev, "Failed sending SYS_ERR state change event: %d\n", ret);
 }
 
+int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ep_ring *ch_ring, *event_ring;
+	union mhi_ep_ring_ctx *event_ctx;
+	struct mhi_result result = {};
+	struct mhi_ep_chan *mhi_chan;
+	u32 event_ring_idx, tmp;
+	u32 ch_id;
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
+		if (ch_ring->state == RING_STATE_UINT) {
+			ret = mhi_ep_ring_start(mhi_cntrl, ch_ring,
+				(union mhi_ep_ring_ctx *)&mhi_cntrl->ch_ctx_cache[ch_id]);
+			if (ret) {
+				dev_err(dev, "Failed to start ring for channel (%d)\n", ch_id);
+				ret = mhi_ep_send_cmd_comp_event(mhi_cntrl,
+							MHI_EV_CC_UNDEFINED_ERR);
+				if (ret)
+					dev_err(dev, "Error sending completion event: %d\n",
+						MHI_EV_CC_UNDEFINED_ERR);
+
+				goto err_unlock;
+			}
+		}
+
+		/* Enable DB for the channel */
+		mhi_ep_mmio_enable_chdb_a7(mhi_cntrl, ch_id);
+
+		mutex_lock(&mhi_cntrl->event_lock);
+		event_ring_idx = mhi_cntrl->ch_ctx_cache[ch_id].erindex;
+		event_ring = &mhi_cntrl->mhi_event[event_ring_idx].ring;
+		event_ctx = (union mhi_ep_ring_ctx *)&mhi_cntrl->ev_ctx_cache[event_ring_idx];
+		if (event_ring->state == RING_STATE_UINT) {
+			ret = mhi_ep_ring_start(mhi_cntrl, event_ring, event_ctx);
+			if (ret) {
+				dev_err(dev, "Error starting event ring: %d\n",
+					mhi_cntrl->ch_ctx_cache[ch_id].erindex);
+				mutex_unlock(&mhi_cntrl->event_lock);
+				goto err_unlock;
+			}
+		}
+
+		mutex_unlock(&mhi_cntrl->event_lock);
+
+		/* Set channel state to RUNNING */
+		mhi_chan->state = MHI_CH_STATE_RUNNING;
+		tmp = mhi_cntrl->ch_ctx_cache[ch_id].chcfg;
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= (MHI_CH_STATE_RUNNING << CHAN_CTX_CHSTATE_SHIFT);
+		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = tmp;
+
+		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
+		if (ret) {
+			dev_err(dev, "Error sending command completion event: %d\n",
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
+		if (ch_ring->state == RING_STATE_UINT) {
+			dev_err(dev, "Channel (%d) not opened\n", ch_id);
+			return -ENODEV;
+		}
+
+		mutex_lock(&mhi_chan->lock);
+		/* Disable DB for the channel */
+		mhi_ep_mmio_disable_chdb_a7(mhi_cntrl, ch_id);
+
+		/* Set the local value of the transfer ring read pointer to the channel context */
+		ch_ring->rd_offset = mhi_ep_ring_addr2offset(ch_ring,
+					ch_ring->ring_ctx->generic.rp);
+
+		/* Send channel disconnect status to client drivers */
+		result.transaction_status = -ENOTCONN;
+		result.bytes_xferd = 0;
+		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+		/* Set channel state to STOP */
+		mhi_chan->state = MHI_CH_STATE_STOP;
+		tmp = mhi_cntrl->ch_ctx_cache[ch_id].chcfg;
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= (MHI_CH_STATE_STOP << CHAN_CTX_CHSTATE_SHIFT);
+		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = tmp;
+
+		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
+		if (ret) {
+			dev_err(dev, "Error sending command completion event: %d\n",
+				MHI_EV_CC_SUCCESS);
+			goto err_unlock;
+		}
+
+		mutex_unlock(&mhi_chan->lock);
+		break;
+	case MHI_PKT_TYPE_RESET_CHAN_CMD:
+		dev_dbg(dev, "Received STOP command for channel (%d)\n", ch_id);
+		if (ch_ring->state == RING_STATE_UINT) {
+			dev_err(dev, "Channel (%d) not opened\n", ch_id);
+			return -ENODEV;
+		}
+
+		mutex_lock(&mhi_chan->lock);
+		/* Stop and reset the transfer ring */
+		mhi_ep_ring_stop(mhi_cntrl, ch_ring);
+
+		/* Send channel disconnect status to client driver */
+		result.transaction_status = -ENOTCONN;
+		result.bytes_xferd = 0;
+		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+		/* Set channel state to DISABLED */
+		mhi_chan->state = MHI_CH_STATE_DISABLED;
+		tmp = mhi_cntrl->ch_ctx_cache[ch_id].chcfg;
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
+		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = tmp;
+
+		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
+		if (ret) {
+			dev_err(dev, "Error sending command completion event: %d\n",
+				MHI_EV_CC_SUCCESS);
+			goto err_unlock;
+		}
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
+static int mhi_ep_check_tre_bytes_left(struct mhi_ep_cntrl *mhi_cntrl,
+				       struct mhi_ep_ring *ring,
+				       struct mhi_ep_ring_element *el)
+{
+	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
+	bool td_done = 0;
+
+	/* A full TRE worth of data was consumed. Check if we are at a TD boundary */
+	if (mhi_chan->tre_bytes_left == 0) {
+		if (MHI_EP_TRE_GET_CHAIN(el)) {
+			if (MHI_EP_TRE_GET_IEOB(el))
+				mhi_ep_send_completion_event(mhi_cntrl,
+				ring, MHI_EP_TRE_GET_LEN(el), MHI_EV_CC_EOB);
+		} else {
+			if (MHI_EP_TRE_GET_IEOT(el))
+				mhi_ep_send_completion_event(mhi_cntrl,
+				ring, MHI_EP_TRE_GET_LEN(el), MHI_EV_CC_EOT);
+			td_done = 1;
+		}
+
+		mhi_ep_ring_inc_index(ring);
+		mhi_chan->tre_bytes_left = 0;
+		mhi_chan->tre_loc = 0;
+	}
+
+	return td_done;
+}
+
+bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir)
+{
+	struct mhi_ep_chan *mhi_chan = (dir == DMA_FROM_DEVICE) ? mhi_dev->dl_chan :
+							       mhi_dev->ul_chan;
+	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
+
+	return !!(ring->rd_offset == ring->wr_offset);
+}
+EXPORT_SYMBOL_GPL(mhi_ep_queue_is_empty);
+
+static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
+			       struct mhi_ep_ring *ring,
+			       struct mhi_result *result,
+			       u32 len)
+{
+	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	size_t bytes_to_read, addr_offset;
+	struct mhi_ep_ring_element *el;
+	ssize_t bytes_read = 0;
+	u32 buf_remaining;
+	void __iomem *tre_buf;
+	phys_addr_t tre_phys;
+	void *write_to_loc;
+	u64 read_from_loc;
+	bool td_done = 0;
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
+		if (mhi_chan->tre_loc) {
+			bytes_to_read = min(buf_remaining,
+						mhi_chan->tre_bytes_left);
+			dev_dbg(dev, "TRE bytes remaining: %d", mhi_chan->tre_bytes_left);
+		} else {
+			if (mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE))
+				/* Nothing to do */
+				return 0;
+
+			mhi_chan->tre_loc = MHI_EP_TRE_GET_PTR(el);
+			mhi_chan->tre_size = MHI_EP_TRE_GET_LEN(el);
+			mhi_chan->tre_bytes_left = mhi_chan->tre_size;
+
+			bytes_to_read = min(buf_remaining, mhi_chan->tre_size);
+		}
+
+		bytes_read += bytes_to_read;
+		addr_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
+		read_from_loc = mhi_chan->tre_loc + addr_offset;
+		write_to_loc = result->buf_addr + (len - buf_remaining);
+		mhi_chan->tre_bytes_left -= bytes_to_read;
+
+		tre_buf = mhi_cntrl->alloc_addr(mhi_cntrl, &tre_phys, bytes_to_read);
+		if (!tre_buf) {
+			dev_err(dev, "Failed to allocate TRE buffer\n");
+			return -ENOMEM;
+		}
+
+		ret = mhi_cntrl->map_addr(mhi_cntrl, tre_phys, read_from_loc, bytes_to_read);
+		if (ret) {
+			dev_err(dev, "Failed to map TRE buffer\n");
+			goto err_tre_free;
+		}
+
+		dev_dbg(&mhi_chan->mhi_dev->dev, "Reading %d bytes", bytes_to_read);
+		memcpy_fromio(write_to_loc, tre_buf, bytes_to_read);
+
+		mhi_cntrl->unmap_addr(mhi_cntrl, tre_phys);
+		mhi_cntrl->free_addr(mhi_cntrl, tre_phys, tre_buf, bytes_to_read);
+
+		buf_remaining -= bytes_to_read;
+		td_done = mhi_ep_check_tre_bytes_left(mhi_cntrl, ring, el);
+	} while (buf_remaining && !td_done);
+
+	result->bytes_xferd = bytes_read;
+
+	return bytes_read;
+
+err_tre_free:
+	mhi_cntrl->free_addr(mhi_cntrl, tre_phys, tre_buf, bytes_to_read);
+
+	return ret;
+}
+
+int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+	struct mhi_result result = {};
+	u32 len = MHI_EP_DEFAULT_MTU;
+	struct mhi_ep_chan *mhi_chan;
+	int ret = 0;
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
+	dev_dbg(&mhi_chan->mhi_dev->dev, "Processing TRE ring\n");
+
+	mutex_lock(&mhi_chan->lock);
+	if (ring->ch_id % 2) {
+		/* DL channel */
+		result.dir = mhi_chan->dir;
+		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+	} else {
+		/* UL channel */
+		while (1) {
+			result.buf_addr = kzalloc(len, GFP_KERNEL);
+			if (!result.buf_addr) {
+				ret = -ENOMEM;
+				goto err_unlock;
+			}
+
+			ret = mhi_ep_read_channel(mhi_cntrl, ring, &result, len);
+			if (ret < 0) {
+				dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel");
+				kfree(result.buf_addr);
+				break;
+			} else if (ret == 0) {
+				/* No more data to read */
+				kfree(result.buf_addr);
+				break;
+			}
+
+			result.dir = mhi_chan->dir;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+			kfree(result.buf_addr);
+		}
+	}
+
+err_unlock:
+	mutex_unlock(&mhi_chan->lock);
+
+	return ret;
+}
+
 static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
index 763b8506d309..11adfb659f16 100644
--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -264,9 +264,11 @@ void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32
 	ring->state = RING_STATE_UINT;
 	ring->type = type;
 	if (ring->type == RING_TYPE_CMD) {
+		ring->ring_cb = mhi_ep_process_cmd_ring;
 		ring->db_offset_h = CRDB_HIGHER;
 		ring->db_offset_l = CRDB_LOWER;
 	} else if (ring->type == RING_TYPE_CH) {
+		ring->ring_cb = mhi_ep_process_tre_ring;
 		ring->db_offset_h = CHDB_HIGHER_n(id);
 		ring->db_offset_l = CHDB_LOWER_n(id);
 		ring->ch_id = id;
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 6482b0c91865..260a181d3fab 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -265,4 +265,13 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl);
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

