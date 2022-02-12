Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B544B373C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiBLSYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:24:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiBLSXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:23:54 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F241660060
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:39 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z17so7244087plb.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DR39PJTsN+CNaJsE354sTId/TsA16GNncXIpBGtTVUk=;
        b=faMhg0PFlLM1YusH1b7hIXOxUUfqurJoJ5tMvwyIN4gtLmqcOwBsoIA63fj85zO2Xe
         J5Yd8jRPD+wiNt8wYLEodvbcvZPJhm3cy57ZLj3gsPKhPJ6p+/HHqDc2LXZWSCzkuoon
         G1jzwOOwgQGtPulEbH8yo/XaCd3G8cCMbY1BfWp/2D5YAi0y4hHj58uQWnYTAhx3aEUl
         o7JFyXbZYJQmecTF4pHivyayCPCWA+Hfr1naI9rHBIRhZLOaRNy2lF/B4GGOZMFm9Kvq
         SvCUmmYO5lZFvPnneasnAb2gBNDkzPuJJXgMvC83YnXLV1g6b73+62NvoUpyhbiPzGOZ
         7FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DR39PJTsN+CNaJsE354sTId/TsA16GNncXIpBGtTVUk=;
        b=pe2gmamMC1AR4y/jXQkK8IF3Tjk4qwdf4dVULo9gzu8NLy0xf3SOp5CEm5Pg3m6Cbk
         JLcrW6ytbplsTioNkZWeLgZ3k0Cs4H7X7OYnEPEYd2M6qspJQZf18Dp7wXvfEIcDJuxr
         y9ALNKNw29c/5qgyZ21R/clrSYb0WIqF+2+Mo21Z8YUcXKX1M/ptQbHD3HgrLUleUuEL
         a0NuhMOWAwUh34kzCpvsmvEH/Kw17Wc5EdyEESpioXNeg67VYuoKdlXPwsO3AAFhMnSm
         kqXumRYiRMSwO2HuHDQv1V7FXh9tpjt/IRpD6vgIG/2gI8CeIZWoDnwh9SF8ufsebINH
         mTyw==
X-Gm-Message-State: AOAM533hfy47Daf4sXteZUbq0NxsyE8O7D5ZOnqqi6r7JKnIyeWBJjBE
        srWtxW8Yl/SwvxuYZd4wmU4G
X-Google-Smtp-Source: ABdhPJxr+CZietQDfAClfTK8cHhPac34/F4IF4g6p0VHydivyrubP6Vzkh/g4lVOAjxyMsIpB3gpWg==
X-Received: by 2002:a17:90a:6881:: with SMTP id a1mr6372208pjd.123.1644690213665;
        Sat, 12 Feb 2022 10:23:33 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:23:33 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 23/25] bus: mhi: ep: Add support for queueing SKBs to the host
Date:   Sat, 12 Feb 2022 23:51:15 +0530
Message-Id: <20220212182117.49438-24-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
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

Add support for queueing SKBs to the host over the transfer ring of the
relevant channel. The mhi_ep_queue_skb() API will be used by the client
networking drivers to queue the SKBs to the host over MHI bus.

The host will add ring elements to the transfer ring periodically for
the device and the device will write SKBs to the ring elements. If a
single SKB doesn't fit in a ring element (TRE), it will be placed in
multiple ring elements and the overflow event will be sent for all ring
elements except the last one. For the last ring element, the EOT event
will be sent indicating the packet boundary.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 102 ++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |  13 +++++
 2 files changed, 115 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index baf383a4857b..e4186b012257 100644
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
+			dev_err(dev, "Channel not available\n");
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
+			goto err_exit;
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
+			dev_err(dev, "Error sending completion event\n");
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

