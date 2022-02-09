Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73C44AEFD1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiBILMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBILMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:12:16 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945A4E1004CD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:07:55 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y8so661467pfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=um/QPlMPSYIu/2X13qGoGMxXxkltBh/JUMS9OfQ8QpU=;
        b=FzmfuUxgZ4ojIytm2iWKsPkymGsBvaCASWzPD/KEnQIuzcLhn8Go3epGUfUWdoQHvs
         u5PwPn9lLI4Gj19cgA70QMqMqAFPEMkPe3e+Efbs49ZWZTedopEECunkIqxgU3VNVhfo
         hYJGwnsOJu8GWajZoT3A5q+/xAXJ3rEXIvmmAJWGaKh5hqG5PqEqEzws/pnybSBhF6Co
         PQBKc5pIbGORd1Bd731i73FTvZ9ICOk6EcpxrNYqnPysxxi1r+MQLze5n+v8mf5DATzC
         CzWGZSvM42i6NhbQtO51pf21tnpT/O4s2Qje/ha2HeusB6pR9mGXgWbthgbEP5svsuh9
         i8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=um/QPlMPSYIu/2X13qGoGMxXxkltBh/JUMS9OfQ8QpU=;
        b=vS4M5NfvWzAMPj9xTfYXoy9ofHXrnyuEHC9thPcVT/wohNJ3MD6NMpuuqxp+9auts0
         TLrc9QNtjLmVV/xL75pmxwRnX86H1NKU/xoavS41gbAqyXX8XMIjuXizXlkLBTX+wJmq
         SVX6nAAzTJXx7AXkNTgNAeM+kprQjvd0iSOt95MgI/PAwzTlRw8MR6eqLfdNZlaqw4QA
         2zMiLZUQsQQYhQ8+lydUTLlkUJ/ZOszrVOJVbgaun688kCgBuQb6RtuXp/T31khWiQJG
         cp6qEGCkrG37MwCaW+wsv5SPrIw687S2CI9cNTkVvC6RyMieQBlJvm0wEOPvZeztOTPj
         XoPA==
X-Gm-Message-State: AOAM531Z47o5TW19r89o5SnRGgW3MBa+9MQ+VPByxHmAVEeitpfs9gsw
        j2lO1Vk/jgTksUZVJ/KGdOOI
X-Google-Smtp-Source: ABdhPJzfd7y5ykqxl6y1YnACYi74CXYhdtIDa+47PM+EM/M5byzQBT3UuhfsMaaV00JNIPmD3kS4gQ==
X-Received: by 2002:a65:4c4b:: with SMTP id l11mr1286054pgr.310.1644401230849;
        Wed, 09 Feb 2022 02:07:10 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:07:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 21/23] bus: mhi: ep: Add support for queueing SKBs over MHI bus
Date:   Wed,  9 Feb 2022 15:26:22 +0530
Message-Id: <20220209095624.26389-22-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
References: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
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

Add support for queueing SKBs over MHI bus in the MHI endpoint stack.
The mhi_ep_queue_skb() API will be used by the client networking drivers
to queue the SKBs to the host over MHI.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 102 ++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |  13 +++++
 2 files changed, 115 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index c46d09cc67f4..8a8e90887060 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -488,6 +488,108 @@ int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element
 	return 0;
 }
 
+int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir,
+		     struct sk_buff *skb, size_t len, enum mhi_flags mflags)
+{
+	struct mhi_ep_chan *mhi_chan = (dir == DMA_FROM_DEVICE) ? mhi_dev->dl_chan :
+								mhi_dev->ul_chan;
+	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct device *dev = &mhi_chan->mhi_dev->dev;
+	struct mhi_ep_ring_element *el;
+	struct mhi_ep_ring *ring;
+	size_t bytes_to_write;
+	enum mhi_ev_ccs code;
+	void *read_from_loc;
+	u32 buf_remaining;
+	u64 write_to_loc;
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
+
+	do {
+		/* Don't process the transfer ring if the channel is not in RUNNING state */
+		if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
+			dev_err(dev, "Channel not available");
+			ret = -ENODEV;
+			goto err_exit;
+		}
+
+		if (mhi_ep_queue_is_empty(mhi_dev, dir)) {
+			dev_err(dev, "TRE not available!\n");
+			ret = -EINVAL;
+			goto err_exit;
+		}
+
+		el = &ring->ring_cache[ring->rd_offset];
+		tre_len = MHI_EP_TRE_GET_LEN(el);
+		if (skb->len > tre_len) {
+			dev_err(dev, "Buffer size (%d) is too large for TRE (%d)!\n",
+				skb->len, tre_len);
+			ret = -ENOMEM;
+			goto err_exit;
+		}
+
+		bytes_to_write = min(buf_remaining, tre_len);
+		read_from_loc = skb->data;
+		write_to_loc = MHI_EP_TRE_GET_PTR(el);
+
+		ret = mhi_cntrl->write_to_host(mhi_cntrl, read_from_loc, write_to_loc,
+					       bytes_to_write);
+		if (ret < 0)
+			return ret;
+
+		buf_remaining -= bytes_to_write;
+		/*
+		 * For all TREs queued by the host for DL channel, only the EOT flag will be set.
+		 * If the packet doesn't fit into a single TRE, send the OVERFLOW event to
+		 * the host so that the host can adjust the packet boundary to next TREs. Else send
+		 * the EOT event to the host indicating the packet boundary.
+		 */
+		if (buf_remaining)
+			code = MHI_EV_CC_OVERFLOW;
+		else
+			code = MHI_EV_CC_EOT;
+
+		ret = mhi_ep_send_completion_event(mhi_cntrl, ring, bytes_to_write, code);
+		if (ret) {
+			dev_err(dev, "Error sending completion event");
+			goto err_exit;
+		}
+
+		mhi_ep_ring_inc_index(ring);
+	} while (buf_remaining);
+
+	/*
+	 * During high network traffic, sometimes the DL doorbell interrupt from the host is missed
+	 * by the endpoint. So manually check for the write pointer update here so that we don't run
+	 * out of buffer due to missing interrupts.
+	 */
+	if (ring->rd_offset + 1 == ring->wr_offset) {
+		ret = mhi_ep_update_wr_offset(ring);
+		if (ret) {
+			dev_err(dev, "Error updating write pointer\n");
+			goto err_exit;
+		}
+	}
+
+	mutex_unlock(&mhi_chan->lock);
+
+	return 0;
+
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
index aaf4b6942037..75cfbf0c6fb0 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -277,4 +277,17 @@ void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl);
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
+
 #endif
-- 
2.25.1

