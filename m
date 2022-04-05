Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E46A4F47AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359156AbiDEVPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443769AbiDEPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22B26D957
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:59:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f3so12185003pfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHnMu0Br8/drDIjtCGRmVDuhOUG28nqK5WGIkqcipfU=;
        b=Cvf9uzJ2ikJ5H3Ciq+6oGFHPJ1RvaQwtUsI0aK1BhhTSog6QPytOyOkJ19UuImlFxE
         jSbgOO2DZFlTuD/4wLdOe55x+C8wilmCep5WDC0VaKI6sty3h6owgdGjxqq9xCXIDGq7
         XGl/snt5nnLgLswXAPdBUGUHPNT8ofl8In4Vi9REdLuXNrl+U1pn4pCTDo0oTVMxloVl
         RBRRGMi6jACJ32OBNtoBcjwAJp6Avpz7CMarSlAbFQM4ChcxiuKd50THZ4I+92q7cdSw
         VfsRjs4UBjp8DBwRCG2/UFSsuhjfjNptbcvxbA4JLlrXI3sgzctpWOgvhI/BRtbNYuEn
         M4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHnMu0Br8/drDIjtCGRmVDuhOUG28nqK5WGIkqcipfU=;
        b=TgTL+09a7RKWfLujirHaU7gVQZVUQoIB22+Tvm3uQrJ00NAVgs0ZNKIBIOVD+GAuwR
         ghpmF4mfjB0DowzOqe358GyJ6BLdKElUXiMWx5t42zzGKJ4pCdUzt8iLj9DN7aJMJyI2
         NcIzeEFXr1IAZ7RqAh3vW74ZcFl3hiUJG0TLZyxWlBfSSRDOMry4WDJVrh3IHYkT1wmE
         R9VwYb/wwYW3HD4o5UjK/Yw2IOCqKIyqrFn52ArIJ6tju3C0nAUeFq6fVlJPw5TyfXB7
         u/JgkJxphae6ajHvvPYGspQ51cgsVT97i4+z9il9bbjc6lHn2o6YWUdlTxf9FYsQqifp
         uFbQ==
X-Gm-Message-State: AOAM5328odrfNYM7heGkeGZsRM00hoWhnoWi89IV5MlyJfSB3zjeFmM2
        IdYafZ+s0VnKX+Rs9I/LFQ7v
X-Google-Smtp-Source: ABdhPJwmwo9nDRtJ1NV5zeQWOTDZ1/khUvuvgWEbrY+WNI7AfucpxARMdIgO5U7J+6UqW2G5hadtCw==
X-Received: by 2002:a63:3f84:0:b0:381:f11:20d7 with SMTP id m126-20020a633f84000000b003810f1120d7mr3040654pga.612.1649167161401;
        Tue, 05 Apr 2022 06:59:21 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:59:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 15/18] bus: mhi: ep: Add support for processing channel rings
Date:   Tue,  5 Apr 2022 19:27:51 +0530
Message-Id: <20220405135754.6622-16-manivannan.sadhasivam@linaro.org>
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
index 1e24eae4b446..e2ed10b4a9d2 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -383,6 +383,57 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 	return 0;
 }
 
+static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_element *el)
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
@@ -565,6 +616,60 @@ static void mhi_ep_cmd_ring_worker(struct work_struct *work)
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
@@ -630,6 +735,8 @@ static void mhi_ep_queue_channel_db(struct mhi_ep_cntrl *mhi_cntrl, unsigned lon
 		spin_lock(&mhi_cntrl->list_lock);
 		list_splice_tail_init(&head, &mhi_cntrl->ch_db_list);
 		spin_unlock(&mhi_cntrl->list_lock);
+
+		queue_work(mhi_cntrl->wq, &mhi_cntrl->ch_ring_work);
 	}
 }
 
@@ -1120,6 +1227,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
 	INIT_WORK(&mhi_cntrl->reset_work, mhi_ep_reset_worker);
 	INIT_WORK(&mhi_cntrl->cmd_ring_work, mhi_ep_cmd_ring_worker);
+	INIT_WORK(&mhi_cntrl->ch_ring_work, mhi_ep_ch_ring_worker);
 
 	mhi_cntrl->wq = alloc_workqueue("mhi_ep_wq", 0, 0);
 	if (!mhi_cntrl->wq) {
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index fc7d197413eb..eecc8f35d630 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -78,6 +78,7 @@ struct mhi_ep_db_info {
  * @state_work: State transition worker
  * @reset_work: Worker for MHI Endpoint reset
  * @cmd_ring_work: Worker for processing command rings
+ * @ch_ring_work: Worker for processing channel rings
  * @raise_irq: CB function for raising IRQ to the host
  * @alloc_map: CB function for allocating memory in endpoint for storing host context and mapping it
  * @unmap_free: CB function to unmap and free the allocated memory in endpoint for storing host context
@@ -126,6 +127,7 @@ struct mhi_ep_cntrl {
 	struct work_struct state_work;
 	struct work_struct reset_work;
 	struct work_struct cmd_ring_work;
+	struct work_struct ch_ring_work;
 
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
 	int (*alloc_map)(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t *phys_ptr,
-- 
2.25.1

