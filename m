Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BE44C6D14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiB1Mr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbiB1MrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:47:02 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E917804E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:46:06 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e13so10628056plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IIhQUhN2ZaDMAjZZvol3L7EWmR5Y0sj1KhKNQowC/Jw=;
        b=o6qcAWSguSaU8j/pHUtIBOMLMjbt74TrxHnGx2JCVYfk7+vHSId5QIfaJHCQhIn6LB
         iQzY/Nam/NKb9FQLgn0lfMknrA9vCvN/fyRktweXYoJeC0bhKPEh9H7Urhc2xfQxw7Cn
         LS7HiAlKK4vyWeo5U2iSX3W7q4MwOa1LO23SMUYXI7NWOKkV0ykEB54phsnEJx1Vtyob
         u10LuLHFA2Np1DPSUYEMfd/8JmeKnRw8F8eOdIEpQLm/xoBkjqdufU5I82G9UPq/Slhk
         FRNYufFzaPDvCD0pD5WyD3frbcBYYVU8IR//bErDxK4RdtHgbQpB251HJcVLiuPgylx9
         sJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IIhQUhN2ZaDMAjZZvol3L7EWmR5Y0sj1KhKNQowC/Jw=;
        b=lJopuxdorE+zlewKmzbTs+7ussZ0c1frG64PtwHUQcZh4v8/vpYfpu172LLCPijQ+g
         OaV4/IYD0ZBAk9k10j3F2VE8Jp2YqLkB3MFh9DZVykNoLTn7ZGWHyC9t/xVAAkO59hzh
         f7jP+wOl0iz6NfOMsvgLJ402iTJpC2Fdw81Gc7E9LRjotD22wgzZTyJcnwDXmkA4mn7Y
         AQgKHp8Vn998+jCswNlFT97lUC3BLcanu8Em4IX1XWfWvs30/h1Gn8oipGKFmRpSA1LR
         mXb99yriziZ/xPS0zm+aVL5ZFILLUH67fJlJRbuYxuKXYBvJLxv4oPiulubwmDeSj/HI
         YCPg==
X-Gm-Message-State: AOAM53214HQYoQNvB+WIgsr0iNK+EjcR6HIeb0PzXtFr7JcVpTsKPVU1
        Pcvg1cF7rYnh7DNfONPfsblE
X-Google-Smtp-Source: ABdhPJzArRZdWJkaALITB+q29+YN6aJkdB+QK8z2+neQLJJMFtfpl1OL86kOTkFjwScD2E1Ds7b9pg==
X-Received: by 2002:a17:90a:ac09:b0:1bc:3e9d:158 with SMTP id o9-20020a17090aac0900b001bc3e9d0158mr16328504pjq.235.1646052366361;
        Mon, 28 Feb 2022 04:46:06 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:46:06 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 24/27] bus: mhi: ep: Add support for processing channel rings
Date:   Mon, 28 Feb 2022 18:13:41 +0530
Message-Id: <20220228124344.77359-25-manivannan.sadhasivam@linaro.org>
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

Add support for processing the channel rings from host. For the channel
ring associated with DL channel, the xfer callback will simply invoked.
For the case of UL channel, the ring elements will be read in a buffer
till the write pointer and later passed to the client driver using the
xfer callback.

The client drivers should provide the callbacks for both UL and DL
channels during registration.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 108 ++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |   2 +
 2 files changed, 110 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index e7c0ef9f281b..63e14d55aa06 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -420,6 +420,57 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 	return 0;
 }
 
+int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_element *el)
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
+		result.buf_addr = kzalloc(len, GFP_KERNEL);
+		if (!result.buf_addr)
+			return -ENOMEM;
+
+		do {
+			ret = mhi_ep_read_channel(mhi_cntrl, ring, &result, len);
+			if (ret < 0) {
+				dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
+				kfree(result.buf_addr);
+				return ret;
+			}
+
+			result.dir = mhi_chan->dir;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+			result.bytes_xferd = 0;
+			memset(result.buf_addr, 0, len);
+
+			/* Read until the ring becomes empty */
+		} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
+
+		kfree(result.buf_addr);
+	}
+
+	return 0;
+}
+
 static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	size_t cmd_ctx_host_size, ch_ctx_host_size, ev_ctx_host_size;
@@ -597,6 +648,60 @@ static void mhi_ep_cmd_ring_worker(struct work_struct *work)
 	}
 }
 
+static void mhi_ep_ch_ring_worker(struct work_struct *work)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, ch_ring_work);
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ep_ring_item *itr, *tmp;
+	struct mhi_ring_element *el;
+	struct mhi_ep_ring *ring;
+	struct mhi_ep_chan *chan;
+	unsigned long flags;
+	LIST_HEAD(head);
+	int ret;
+
+	spin_lock_irqsave(&mhi_cntrl->list_lock, flags);
+	list_splice_tail_init(&mhi_cntrl->ch_db_list, &head);
+	spin_unlock_irqrestore(&mhi_cntrl->list_lock, flags);
+
+	/* Process each queued channel ring. In case of an error, just process next element. */
+	list_for_each_entry_safe(itr, tmp, &head, node) {
+		list_del(&itr->node);
+		ring = itr->ring;
+
+		/* Update the write offset for the ring */
+		ret = mhi_ep_update_wr_offset(ring);
+		if (ret) {
+			dev_err(dev, "Error updating write offset for ring\n");
+			kfree(itr);
+			continue;
+		}
+
+		/* Sanity check to make sure there are elements in the ring */
+		if (ring->rd_offset == ring->wr_offset) {
+			kfree(itr);
+			continue;
+		}
+
+		el = &ring->ring_cache[ring->rd_offset];
+		chan = &mhi_cntrl->mhi_chan[ring->ch_id];
+
+		mutex_lock(&chan->lock);
+		dev_dbg(dev, "Processing the ring for channel (%u)\n", ring->ch_id);
+		ret = mhi_ep_process_ch_ring(ring, el);
+		if (ret) {
+			dev_err(dev, "Error processing ring for channel (%u): %d\n",
+				ring->ch_id, ret);
+			mutex_unlock(&chan->lock);
+			kfree(itr);
+			continue;
+		}
+
+		mutex_unlock(&chan->lock);
+		kfree(itr);
+	}
+}
+
 static void mhi_ep_state_worker(struct work_struct *work)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, state_work);
@@ -662,6 +767,8 @@ static void mhi_ep_queue_channel_db(struct mhi_ep_cntrl *mhi_cntrl, unsigned lon
 		spin_lock(&mhi_cntrl->list_lock);
 		list_splice_tail_init(&head, &mhi_cntrl->ch_db_list);
 		spin_unlock(&mhi_cntrl->list_lock);
+
+		queue_work(mhi_cntrl->wq, &mhi_cntrl->ch_ring_work);
 	}
 }
 
@@ -1152,6 +1259,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
 	INIT_WORK(&mhi_cntrl->reset_work, mhi_ep_reset_worker);
 	INIT_WORK(&mhi_cntrl->cmd_ring_work, mhi_ep_cmd_ring_worker);
+	INIT_WORK(&mhi_cntrl->ch_ring_work, mhi_ep_ch_ring_worker);
 
 	mhi_cntrl->wq = alloc_workqueue("mhi_ep_wq", 0, 0);
 	if (!mhi_cntrl->wq) {
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 45d12a55b435..74170dad09f6 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -78,6 +78,7 @@ struct mhi_ep_db_info {
  * @state_work: State transition worker
  * @reset_work: Worker for MHI Endpoint reset
  * @cmd_ring_work: Worker for processing command rings
+ * @ch_ring_work: Worker for processing channel rings
  * @raise_irq: CB function for raising IRQ to the host
  * @alloc_addr: CB function for allocating memory in endpoint for storing host context
  * @map_addr: CB function for mapping host context to endpoint
@@ -128,6 +129,7 @@ struct mhi_ep_cntrl {
 	struct work_struct state_work;
 	struct work_struct reset_work;
 	struct work_struct cmd_ring_work;
+	struct work_struct ch_ring_work;
 
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
 	void __iomem *(*alloc_addr)(struct mhi_ep_cntrl *mhi_cntrl, phys_addr_t *phys_addr,
-- 
2.25.1

