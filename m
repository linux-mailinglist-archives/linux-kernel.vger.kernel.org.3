Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0CA466296
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357694AbhLBLmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357516AbhLBLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:41:50 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2C0C061761
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:38:28 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y8so20040381plg.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mb08uectv3gQ/l2JA/mJ57RAUgqx8WhgYqgq7CpOQ08=;
        b=QKVeFCMZqnbKzg72bRUoGwZ98XZQsvcT4nnn4/MwENKvpVrSDovrfYyjjD028MnB5W
         bqmaxcgD9SM/tB8mwpysFNYJZw4yUT26lcZtrC6ctw2St6/72S0t1m7vDxEhBuOIOQJS
         rSHCCJw9YK/YkOTRd53D3EVbvXGkzkZRxusatiBLWqVyZExbOx/UAr//5Tcjp+wUkfiX
         6lEEI4Sb6zpl5AlS0iu74zyqDW4sun38L9roEkU1voVFQuhJ+/OsXTd49rLslQFDhHo1
         8ouZsgwNjgvLjCHHSofRlhXleQnde0oeiEECEIv/9pOOnlGZLx5KwSJTK6gzfSkI8CIb
         4Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mb08uectv3gQ/l2JA/mJ57RAUgqx8WhgYqgq7CpOQ08=;
        b=E4LxViFAJqF8J6vMVXe2w+dj9HUNq41IexWF79pYDRDh7UgURzbFmkkITLsf59hkkS
         arxIEznEkQWSOPqpntmwmU1AEKdVRHFImSIqXz/4oaMYTd3u0tT72t8UtSjhK0COZvSF
         sZMkivME5FWRuhTzjVnStNWAG0pgRvf+WKZx84teEr2ErtAQFk4jElIpQ4mOjQu5RL4c
         e5kxD8karhVou8scSniHUCASr6eBAG66mvL7S/IAvMUGzJSZWNoYA7xbyS8xH0rnj/8z
         KibRXhaBsycZ6kGFkmGkULMEE0pc6m2iRSRV5vJn92XUXXueuxXGhgdWrJ+aeFU5o/AA
         5i9g==
X-Gm-Message-State: AOAM530joHGHULqplfIO/VNgt4KiaMwv8cjKxG3tu3Sg7nNpfZcg+anW
        pmNVnsSZArqvGDoH5uNgl0+X
X-Google-Smtp-Source: ABdhPJy+kdFVSgRQqfpsUckHH+EyjS9mtFb++kXeELtyn3sS74xg2xLFyVmMW/nPqZPRPTEaIV2Iuw==
X-Received: by 2002:a17:90a:cf85:: with SMTP id i5mr5504573pju.101.1638445107631;
        Thu, 02 Dec 2021 03:38:27 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:38:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 18/20] bus: mhi: ep: Add support for queueing SKBs over MHI bus
Date:   Thu,  2 Dec 2021 17:05:50 +0530
Message-Id: <20211202113553.238011-19-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for queueing SKBs over MHI bus in the MHI endpoint stack.
The mhi_ep_queue_skb() API will be used by the client networking drivers
to queue the SKBs to the host over MHI.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 132 ++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |  12 ++++
 2 files changed, 144 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 26d551eb63ce..cc3da846ed36 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -522,6 +522,138 @@ int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element
 	return ret;
 }
 
+static void skip_to_next_td(struct mhi_ep_chan *mhi_chan, struct mhi_ep_ring *ring)
+{
+	struct mhi_ep_ring_element *el;
+	u32 td_boundary_reached = 0;
+
+	mhi_chan->skip_td = 1;
+	el = &ring->ring_cache[ring->rd_offset];
+	while (ring->rd_offset != ring->wr_offset) {
+		if (td_boundary_reached) {
+			mhi_chan->skip_td = 0;
+			break;
+		}
+
+		if (!MHI_EP_TRE_GET_CHAIN(el))
+			td_boundary_reached = 1;
+
+		mhi_ep_ring_inc_index(ring);
+		el = &ring->ring_cache[ring->rd_offset];
+	}
+}
+
+int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir,
+		     struct sk_buff *skb, size_t len, enum mhi_flags mflags)
+{
+	struct mhi_ep_chan *mhi_chan = (dir == DMA_FROM_DEVICE) ? mhi_dev->dl_chan :
+							       mhi_dev->ul_chan;
+	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
+	enum mhi_ev_ccs code = MHI_EV_CC_INVALID;
+	struct mhi_ep_ring_element *el;
+	u64 write_to_loc, skip_tre = 0;
+	struct mhi_ep_ring *ring;
+	size_t bytes_to_write;
+	void __iomem *tre_buf;
+	phys_addr_t tre_phys;
+	void *read_from_loc;
+	u32 buf_remaining;
+	u32 tre_len;
+	int ret = 0;
+
+	if (dir == DMA_TO_DEVICE)
+		return -EINVAL;
+
+	buf_remaining = len;
+	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
+
+	mutex_lock(&mhi_chan->lock);
+	if (mhi_chan->skip_td)
+		skip_to_next_td(mhi_chan, ring);
+
+	do {
+		/* Don't process the transfer ring if the channel is not in RUNNING state */
+		if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
+			dev_err(&mhi_chan->mhi_dev->dev, "Channel not available");
+			ret = -ENODEV;
+			goto err_exit;
+		}
+
+		if (mhi_ep_queue_is_empty(mhi_dev, dir)) {
+			dev_err(&mhi_chan->mhi_dev->dev, "TRE not available!\n");
+			ret = -EINVAL;
+			goto err_exit;
+		}
+
+		el = &ring->ring_cache[ring->rd_offset];
+		tre_len = MHI_EP_TRE_GET_LEN(el);
+		if (skb->len > tre_len) {
+			dev_err(&mhi_chan->mhi_dev->dev, "Buffer size (%d) is too large!\n",
+				skb->len);
+			ret = -ENOMEM;
+			goto err_exit;
+		}
+
+		bytes_to_write = min(buf_remaining, tre_len);
+		read_from_loc = skb->data;
+		write_to_loc = MHI_EP_TRE_GET_PTR(el);
+
+		tre_buf = mhi_cntrl->alloc_addr(mhi_cntrl, &tre_phys, bytes_to_write);
+		if (!tre_buf) {
+			dev_err(&mhi_chan->mhi_dev->dev, "Failed to allocate TRE buffer\n");
+			ret = -ENOMEM;
+			goto err_exit;
+		}
+
+		ret = mhi_cntrl->map_addr(mhi_cntrl, tre_phys, write_to_loc, bytes_to_write);
+		if (ret) {
+			dev_err(&mhi_chan->mhi_dev->dev, "Failed to map TRE buffer\n");
+			goto err_tre_free;
+		}
+
+		dev_dbg(&mhi_chan->mhi_dev->dev, "Writing %d bytes", bytes_to_write);
+		memcpy_toio(tre_buf, read_from_loc, bytes_to_write);
+
+		mhi_cntrl->unmap_addr(mhi_cntrl, tre_phys);
+		mhi_cntrl->free_addr(mhi_cntrl, tre_phys, tre_buf, bytes_to_write);
+
+		buf_remaining -= bytes_to_write;
+		if (buf_remaining) {
+			if (!MHI_EP_TRE_GET_CHAIN(el))
+				code = MHI_EV_CC_OVERFLOW;
+			else if (MHI_EP_TRE_GET_IEOB(el))
+				code = MHI_EV_CC_EOB;
+		} else {
+			if (MHI_EP_TRE_GET_CHAIN(el))
+				skip_tre = 1;
+			code = MHI_EV_CC_EOT;
+		}
+
+		ret = mhi_ep_send_completion_event(mhi_cntrl, ring, bytes_to_write, code);
+		if (ret) {
+			dev_err(&mhi_chan->mhi_dev->dev, "Error sending completion event");
+			goto err_exit;
+		}
+
+		mhi_ep_ring_inc_index(ring);
+	} while (!skip_tre && buf_remaining);
+
+	if (skip_tre)
+		skip_to_next_td(mhi_chan, ring);
+
+	mutex_unlock(&mhi_chan->lock);
+
+	return 0;
+
+err_tre_free:
+	mhi_cntrl->free_addr(mhi_cntrl, tre_phys, tre_buf, bytes_to_write);
+err_exit:
+	mutex_unlock(&mhi_chan->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_ep_queue_skb);
+
 static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 260a181d3fab..a7715f8066ed 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -274,4 +274,16 @@ void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl);
  */
 bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir);
 
+/**
+ * mhi_ep_queue_skb - Send SKBs to host over MHI Endpoint
+ * @mhi_dev: Device associated with the channels
+ * @dir: DMA direction for the channel
+ * @skb: Buffer for holding SKBs
+ * @len: Buffer length
+ * @mflags: MHI Endpoint transfer flags used for the transfer
+ *
+ * Return: 0 if the SKBs has been sent successfully, a negative error code otherwise.
+ */
+int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir,
+		     struct sk_buff *skb, size_t len, enum mhi_flags mflags);
 #endif
-- 
2.25.1

