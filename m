Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686FA4C6D16
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiB1Mrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiB1MrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:47:16 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EC979C4D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:46:13 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g21so4730792pfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJYdTNp5Gg/lOgcfWY4Qq4TIlRlc1oamUz2dj4AjBfk=;
        b=qIzffofDKqZnIYKZBrvcvld9xY59Jed2+kjKTQSYZjX3jlWFMQq0v0SM2kxtlIpkO0
         JsW4sujrunw6Yy5aMGAlO0iry6llnHZ5NaxTF347FJsMj7VNjh363hhjfZf4k8HmsSBA
         TPQEwjwekuGC05vx1X08/ndD3hLpS5ptHwv41t+6KTXfvsdmZtiVeZ//GlsJwdq6zZ8Q
         LaF9dg2Znwur3CZ5dxgeqC56gwbGVtrW5sJ9DrAEiSPFJQR887u/gYcsF3Ko746TK7+O
         Qs5VvfdWvkhz7S7HC+D0n0NDrctAMj+Zc97kq3ZGyvUTiAtEwDIELaVbBG30NC5DsWbD
         micA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJYdTNp5Gg/lOgcfWY4Qq4TIlRlc1oamUz2dj4AjBfk=;
        b=XLTIIemp+nKZ4R1R2kQ2BRMGY+AJjyXdT+i/Q2t51lUmt1IA/MR+knqtjzJHN/iAKv
         C7AdgDJnitTpAlaEsku5Rz1q03CnfJU6aNf8lTyntWoyzZna/VQV6ke/UI+fuwh6/Ooh
         DOHSnAg9iTyy3ARTL8SaZuADHyeuUq5vpT8AIA+p8f0R0LkE+fC1Ski52lBnAyxwzylQ
         qx+JHiklhKfwe+VG+RkIXPsbmn5iMtY1I18P2EbaJnAB1ISKKL1dwWYrJLMqUq4cIfKi
         UIgwadBJK+dNwZaay20aqDf10zgfhbUZb4cwRoI3NHDsvXLwRz5jv4jeWLwLYE+YIXPp
         dC6w==
X-Gm-Message-State: AOAM531QRhmWI0T5QL3wKhO/oPIqeD/tIlG1mWH8Wpjq1gy2y8Om5SAr
        ZB2Dwzn4p/4udy10YFX9rAS+
X-Google-Smtp-Source: ABdhPJyGvXFHht1Ju98VcuXWZ+wA7qZaQRE+UQ7ts69fGULz/vaYta9lNRr3of+W9cWQdsMXkpBGkg==
X-Received: by 2002:a05:6a00:1991:b0:4e1:a7dd:96e5 with SMTP id d17-20020a056a00199100b004e1a7dd96e5mr21800624pfl.2.1646052371636;
        Mon, 28 Feb 2022 04:46:11 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:46:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 25/27] bus: mhi: ep: Add support for queueing SKBs to the host
Date:   Mon, 28 Feb 2022 18:13:42 +0530
Message-Id: <20220228124344.77359-26-manivannan.sadhasivam@linaro.org>
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
 drivers/bus/mhi/ep/main.c | 82 +++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |  9 +++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 63e14d55aa06..25d34cf26fd7 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -471,6 +471,88 @@ int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_element *el
 	return 0;
 }
 
+/* TODO: Handle partially formed TDs */
+int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_ep_chan *mhi_chan = mhi_dev->dl_chan;
+	struct device *dev = &mhi_chan->mhi_dev->dev;
+	struct mhi_ring_element *el;
+	u32 buf_left, read_offset;
+	struct mhi_ep_ring *ring;
+	enum mhi_ev_ccs code;
+	void *read_addr;
+	u64 write_addr;
+	size_t tr_len;
+	u32 tre_len;
+	int ret;
+
+	buf_left = skb->len;
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
+		if (mhi_ep_queue_is_empty(mhi_dev, DMA_FROM_DEVICE)) {
+			dev_err(dev, "TRE not available!\n");
+			ret = -ENOSPC;
+			goto err_exit;
+		}
+
+		el = &ring->ring_cache[ring->rd_offset];
+		tre_len = MHI_TRE_DATA_GET_LEN(el);
+
+		tr_len = min(buf_left, tre_len);
+		read_offset = skb->len - buf_left;
+		read_addr = skb->data + read_offset;
+		write_addr = MHI_TRE_DATA_GET_PTR(el);
+
+		dev_dbg(dev, "Writing %zd bytes to channel (%u)\n", tr_len, ring->ch_id);
+		ret = mhi_cntrl->write_to_host(mhi_cntrl, read_addr, write_addr, tr_len);
+		if (ret < 0) {
+			dev_err(dev, "Error writing to the channel\n");
+			goto err_exit;
+		}
+
+		buf_left -= tr_len;
+		/*
+		 * For all TREs queued by the host for DL channel, only the EOT flag will be set.
+		 * If the packet doesn't fit into a single TRE, send the OVERFLOW event to
+		 * the host so that the host can adjust the packet boundary to next TREs. Else send
+		 * the EOT event to the host indicating the packet boundary.
+		 */
+		if (buf_left)
+			code = MHI_EV_CC_OVERFLOW;
+		else
+			code = MHI_EV_CC_EOT;
+
+		ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el, tr_len, code);
+		if (ret) {
+			dev_err(dev, "Error sending transfer completion event\n");
+			goto err_exit;
+		}
+
+		mhi_ep_ring_inc_index(ring);
+	} while (buf_left);
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
 	size_t cmd_ctx_host_size, ch_ctx_host_size, ev_ctx_host_size;
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 74170dad09f6..bd3ffde01f04 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -272,4 +272,13 @@ void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl);
  */
 bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir);
 
+/**
+ * mhi_ep_queue_skb - Send SKBs to host over MHI Endpoint
+ * @mhi_dev: Device associated with the DL channel
+ * @skb: SKBs to be queued
+ *
+ * Return: 0 if the SKBs has been sent successfully, a negative error code otherwise.
+ */
+int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb);
+
 #endif
-- 
2.25.1

