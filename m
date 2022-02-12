Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B416F4B3738
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiBLSXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:23:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiBLSXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:23:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23198606D7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so14992881pja.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2XD6GLOy1WeMbVJM+mE9l+D4GurGc+LL2vthiVaNWmY=;
        b=ZQ8ws5jacEDY80ooN3Y1PtbbBoqTJx2pmlj5MsuJAXCvaiM79s35ZAmULMIe0fx4Rm
         pf3bgdmHLGxiscLlFkNTIi7l9U1dqxHMJtPohpxrgIpVdTpOgRu8d4BlclDpGEVfTgjG
         yjcZZ+wZy4hWcmqm7EBh3G0OWitkP038EK+sFkrcbiN8cSZsvFSRDh+Y3+tWTUWypZpO
         m4LEie7uvPtV601HIIOdGisINSq1GqL9Im5R6pNpBBlkFshu5MfPoeKsj28ubiA73S5Z
         0rb/b6Qw2Cz/VSPiYZG7nqa7RSs5CgzaFbkfeTmZlDTmy4Xo/+WxO6j+DYKFlBcScnNp
         chaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2XD6GLOy1WeMbVJM+mE9l+D4GurGc+LL2vthiVaNWmY=;
        b=Qd4ABj5oJ5X++q5PFXvabAshsxQ5wOSWt3ronUGWh38IhZ6SYYwthDWteHQMCq94Ei
         FEWi10Po7XGCNoIbbQ7b0B4t9cvmwFL9R2cJmB6hUB92/6aXtqESiHNsJEtacAL9brfV
         NU3GduzLYHYDAVLap62E944gSjW8SY50I2DNHyLyLpMl+k57rSUsZL4ys6EQjqziN8IQ
         hzwVB0+6mk3uYehLplCtStM6S0A2u8msofAnd/3Vxg+bXxVfwNLS6P8sv7wlqI8uJXRS
         J/QviPpB2xNQ3L+eXdQQjRepjPQj7nHxGPVokMq+4Y+UiV6xuG8yD0ZrAm/A5NBcfL+Y
         3osA==
X-Gm-Message-State: AOAM533bxb7gvzmXgiCsS33evlWskt9raiMpAxX5uLw9BWZ2Ug3Iav1R
        T8bAegVTdPzuZDpYi3k9t62E
X-Google-Smtp-Source: ABdhPJyWqwE3MwA3UG5zv2W75d93RjLa8xtdZ1MDEYli+5Z+jvcztVTBVQCs5WEid0A193wDhVC6rw==
X-Received: by 2002:a17:90b:3810:: with SMTP id mq16mr6452775pjb.26.1644690205278;
        Sat, 12 Feb 2022 10:23:25 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:23:24 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 21/25] bus: mhi: ep: Add support for reading from the host
Date:   Sat, 12 Feb 2022 23:51:13 +0530
Message-Id: <20220212182117.49438-22-manivannan.sadhasivam@linaro.org>
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

Data transfer between host and the ep device happens over the transfer
ring associated with each bi-directional channel pair. Host defines the
transfer ring by allocating memory for it. The read and write pointer
addresses of the transfer ring are stored in the channel context.

Once host places the elements in the transfer ring, it increments the
write pointer and rings the channel doorbell. Device will receive the
doorbell interrupt and will process the transfer ring elements.

This commit adds support for reading the transfer ring elements from
the transfer ring till write pointer, incrementing the read pointer and
finally sending the completion event to the host through corresponding
event ring.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 103 ++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |   9 ++++
 2 files changed, 112 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 4c2ee517832c..b937c6cda9ba 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -336,6 +336,109 @@ int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element
 	return ret;
 }
 
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

