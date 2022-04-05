Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FF64F4ED5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454908AbiDFAcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443768AbiDEPkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:16 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615D84ECFD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:59:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s8so12136561pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A/z6JzkGKNlx4UzAyiHVaubCMaFwFj5epaAwhZLy9Fo=;
        b=HHblhrcUOiYtag1nKWlpkSs+K9EYzup8SUgBN7cJscZGKXkUwmSKL2ki9Ejzm+0VOI
         +n5y/SJGNZQQfLBnUI+thrmZ8KJxkMZXApu4o9IkYeCc3tcRvOFE9Rctn74ph1u4HsZw
         Ek/4pXEdgfvhah3XYJyyrvH5e5mMUqmOM19vvshoIHXxg7QrwdtaGmILWTNzAW7a2+H9
         L43q37pqlIJqKVVYzloaX0rsx4UzI0aWhchJmIxEly+RpguRUrYils0aY+iCZHLWOgmi
         rMsROmPlwWRCq+BbQ8n/7o2A909XIfxZ22puWXw093xEXthJpox/K/l+LQ/pm1RqeFDL
         DjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A/z6JzkGKNlx4UzAyiHVaubCMaFwFj5epaAwhZLy9Fo=;
        b=sAyww9b0J8m/OXj+TVl6o4uvHj5/l10nqizn9yHwpWf14NEaXEa65pZDWbIInXDstK
         bw6YsKwY7k0QnVhmE4bivaf/1ksULP1O3E8Gy2ynryAx11W80PHdm5ip99LY2eiffZ/x
         aoJpv586fSgG3+a39qHhAw+FD8MHOL27C3agJ3/RjZvz0ddq6yFNDbxQvG3OIo6CipE+
         F7pgkjNkPoSn+l9G+d7/pQ7HUHbgChl8RR7wwAfHYE82RIv+xMf3ToDHmFB0ssdskvLB
         KVSs8yOzSht38jwif94H5HqRGm8VyidKZ98Vht7WQWQDRpXFJIbb2t7z1vFAKZnDHJgr
         8d+A==
X-Gm-Message-State: AOAM531EnGYYVIzPd4tSrLtKILVpOCYNJywm4i8X0MKhaAFACCvSlVXP
        cmoXamFDu0Qi3gSzhkwmhW+Z
X-Google-Smtp-Source: ABdhPJy2wJqlZ51F3kxb//kZFsVXBLFoNOBQ5De0t479OO2lkDBS5114hRqWJKomsTf8uPv6QvUfHQ==
X-Received: by 2002:a63:2a04:0:b0:398:5225:8982 with SMTP id q4-20020a632a04000000b0039852258982mr3003670pgq.394.1649167156809;
        Tue, 05 Apr 2022 06:59:16 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:59:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 14/18] bus: mhi: ep: Add support for reading from the host
Date:   Tue,  5 Apr 2022 19:27:50 +0530
Message-Id: <20220405135754.6622-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405135754.6622-1-manivannan.sadhasivam@linaro.org>
References: <20220405135754.6622-1-manivannan.sadhasivam@linaro.org>
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

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 121 ++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |   9 +++
 2 files changed, 130 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 32ac567e0f67..1e24eae4b446 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -262,6 +262,127 @@ static int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_ele
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
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	size_t tr_len, read_offset, write_offset;
+	struct mhi_ring_element *el;
+	bool tr_done = false;
+	void *write_addr;
+	u64 read_addr;
+	u32 buf_left;
+	int ret;
+
+	buf_left = len;
+
+	do {
+		/* Don't process the transfer ring if the channel is not in RUNNING state */
+		if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
+			dev_err(dev, "Channel not available\n");
+			return -ENODEV;
+		}
+
+		el = &ring->ring_cache[ring->rd_offset];
+
+		/* Check if there is data pending to be read from previous read operation */
+		if (mhi_chan->tre_bytes_left) {
+			dev_dbg(dev, "TRE bytes remaining: %u\n", mhi_chan->tre_bytes_left);
+			tr_len = min(buf_left, mhi_chan->tre_bytes_left);
+		} else {
+			mhi_chan->tre_loc = MHI_TRE_DATA_GET_PTR(el);
+			mhi_chan->tre_size = MHI_TRE_DATA_GET_LEN(el);
+			mhi_chan->tre_bytes_left = mhi_chan->tre_size;
+
+			tr_len = min(buf_left, mhi_chan->tre_size);
+		}
+
+		read_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
+		write_offset = len - buf_left;
+		read_addr = mhi_chan->tre_loc + read_offset;
+		write_addr = result->buf_addr + write_offset;
+
+		dev_dbg(dev, "Reading %zd bytes from channel (%u)\n", tr_len, ring->ch_id);
+		ret = mhi_cntrl->read_from_host(mhi_cntrl, read_addr, write_addr, tr_len);
+		if (ret < 0) {
+			dev_err(&mhi_chan->mhi_dev->dev, "Error reading from channel\n");
+			return ret;
+		}
+
+		buf_left -= tr_len;
+		mhi_chan->tre_bytes_left -= tr_len;
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
+			if (MHI_TRE_DATA_GET_CHAIN(el)) {
+				/*
+				 * IEOB (Interrupt on End of Block) flag will be set by the host if
+				 * it expects the completion event for all TREs of a TD.
+				 */
+				if (MHI_TRE_DATA_GET_IEOB(el)) {
+					ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el,
+								     MHI_TRE_DATA_GET_LEN(el),
+								     MHI_EV_CC_EOB);
+					if (ret < 0) {
+						dev_err(&mhi_chan->mhi_dev->dev,
+							"Error sending transfer compl. event\n");
+						return ret;
+					}
+				}
+			} else {
+				/*
+				 * IEOT (Interrupt on End of Transfer) flag will be set by the host
+				 * for the last TRE of the TD and expects the completion event for
+				 * the same.
+				 */
+				if (MHI_TRE_DATA_GET_IEOT(el)) {
+					ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el,
+								     MHI_TRE_DATA_GET_LEN(el),
+								     MHI_EV_CC_EOT);
+					if (ret < 0) {
+						dev_err(&mhi_chan->mhi_dev->dev,
+							"Error sending transfer compl. event\n");
+						return ret;
+					}
+				}
+
+				tr_done = true;
+			}
+
+			mhi_ep_ring_inc_index(ring);
+		}
+
+		result->bytes_xferd += tr_len;
+	} while (buf_left && !tr_done);
+
+	return 0;
+}
+
 static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	size_t cmd_ctx_host_size, ch_ctx_host_size, ev_ctx_host_size;
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 8c6406d9c51f..fc7d197413eb 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -254,4 +254,13 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl);
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

