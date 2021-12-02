Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD0C466290
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357625AbhLBLmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357441AbhLBLla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:41:30 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FACC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:38:07 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 8so27627492pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nV8vHxyZkpSnq48aLAVk9vWe3JSWpiq16Z/xCyUhjNk=;
        b=Y8YiN5H2VJrW66Jul8DtVt+vPTBGorE5JkAQNt5Pfqh0p1zZffWZMqz+ZgOzkQjQW8
         PU81FmoyDguGJJV6l9fxt6rgDCCNtvMiB0mks1nN6CKlsbnMR13HRODeaDfEbL751WG9
         4Jy4J7F79S37q4xR/TlNyNmLqIMqwvUWLUSf4H8GT9b6KosBheKjhkn3pNgsv0eDe9KL
         F8YqtX3ZgZ/w88OAUVGb4jdHdNrTDYqFBf1oIo2A1n+Sprutp6oEMZfb29AKUqsFft7B
         V8b+4oTAUyzZ4HbkDORrCQhhyb9qMlAWo5TADfv/jgSoETMC2E7kps/ng445CndAeuDt
         jZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nV8vHxyZkpSnq48aLAVk9vWe3JSWpiq16Z/xCyUhjNk=;
        b=dqlTBPEJnCO8FaCuv7AZg0VzrLtuZTJU13pP0D9eQXq3dyQ7PnXoNQdYCyKSkbepRr
         1FNVSMDo18Ea0hTQPEUvqNb1g0xTNun7wYyi/sf/x6dtgXCztJKuUla01pp+g4jTI0iM
         h7d/V0HXnhgjUHSnEPnkEz0ko1wdxnczOw2HQ/YXifN6a+vWvG5bDK4L2TReAjuqAVz5
         wTpgEOZmYrJPEs56ESv2RSwl5kUsuwDXZ1AwpREW2AAYsZ5q51UvVMZbtfxLQjxCQve4
         0ZmG5L8ls2+2Yvum4nUH3Wqmz+LBB4gYoBlYRv/O7ZjurjcwS8B6zzYyAZtlu81q/12t
         aP6w==
X-Gm-Message-State: AOAM532OHnZlBnzXTCMWgzYWD63UjBu7vzlQn2QYYo8BQyPij07942tC
        SfFhpHjwAPBh2zhUkyGDPiE+
X-Google-Smtp-Source: ABdhPJwpqrSSnOrT7D2SRy1GCdYfVGlS+Hb9qNXef7DD3HfUnGZOuYU/lpSmNu3ustqALzJtRuQmaQ==
X-Received: by 2002:a63:66c7:: with SMTP id a190mr9181345pgc.463.1638445087251;
        Thu, 02 Dec 2021 03:38:07 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:38:06 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 14/20] bus: mhi: ep: Add support for powering down the MHI endpoint stack
Date:   Thu,  2 Dec 2021 17:05:46 +0530
Message-Id: <20211202113553.238011-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MHI endpoint power_down that includes stopping all
available channels, destroying the channels, resetting the event and
transfer rings and freeing the host cache.

The stack will be powered down whenever the physical bus link goes down.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 81 +++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |  6 +++
 2 files changed, 87 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 5f62b6fb6dbc..89d1bb780747 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -21,6 +21,8 @@
 
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
+static int mhi_ep_destroy_device(struct device *dev, void *data);
+
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 event_ring,
 			     struct mhi_ep_ring_element *el)
 {
@@ -485,6 +487,71 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void mhi_ep_abort_transfer(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct mhi_ep_ring *ch_ring, *ev_ring;
+	struct mhi_result result = {};
+	struct mhi_ep_chan *mhi_chan;
+	int i;
+
+	/* Stop all the channels */
+	for (i = 0; i < mhi_cntrl->max_chan; i++) {
+		ch_ring = &mhi_cntrl->mhi_chan[i].ring;
+		if (ch_ring->state == RING_STATE_UINT)
+			continue;
+
+		mhi_chan = &mhi_cntrl->mhi_chan[i];
+		mutex_lock(&mhi_chan->lock);
+		/* Send channel disconnect status to client drivers */
+		if (mhi_chan->xfer_cb) {
+			result.transaction_status = -ENOTCONN;
+			result.bytes_xferd = 0;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+		}
+
+		/* Set channel state to DISABLED */
+		mhi_chan->state = MHI_CH_STATE_DISABLED;
+		mutex_unlock(&mhi_chan->lock);
+	}
+
+	flush_workqueue(mhi_cntrl->ring_wq);
+	flush_workqueue(mhi_cntrl->state_wq);
+
+	/* Destroy devices associated with all channels */
+	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_ep_destroy_device);
+
+	/* Stop and reset the transfer rings */
+	for (i = 0; i < mhi_cntrl->max_chan; i++) {
+		ch_ring = &mhi_cntrl->mhi_chan[i].ring;
+		if (ch_ring->state == RING_STATE_UINT)
+			continue;
+
+		mhi_chan = &mhi_cntrl->mhi_chan[i];
+		mutex_lock(&mhi_chan->lock);
+		mhi_ep_ring_stop(mhi_cntrl, ch_ring);
+		mutex_unlock(&mhi_chan->lock);
+	}
+
+	/* Stop and reset the event rings */
+	for (i = 0; i < mhi_cntrl->event_rings; i++) {
+		ev_ring = &mhi_cntrl->mhi_event[i].ring;
+		if (ev_ring->state == RING_STATE_UINT)
+			continue;
+
+		mutex_lock(&mhi_cntrl->event_lock);
+		mhi_ep_ring_stop(mhi_cntrl, ev_ring);
+		mutex_unlock(&mhi_cntrl->event_lock);
+	}
+
+	/* Stop and reset the command ring */
+	mhi_ep_ring_stop(mhi_cntrl, &mhi_cntrl->mhi_cmd->ring);
+
+	mhi_ep_free_host_cfg(mhi_cntrl);
+	mhi_ep_mmio_mask_interrupts(mhi_cntrl);
+
+	mhi_cntrl->is_enabled = false;
+}
+
 int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
@@ -541,6 +608,16 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
 }
 EXPORT_SYMBOL_GPL(mhi_ep_power_up);
 
+void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	if (mhi_cntrl->is_enabled)
+		mhi_ep_abort_transfer(mhi_cntrl);
+
+	kfree(mhi_cntrl->mhi_event);
+	disable_irq(mhi_cntrl->irq);
+}
+EXPORT_SYMBOL_GPL(mhi_ep_power_down);
+
 static void mhi_ep_release_device(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
@@ -825,6 +902,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 }
 EXPORT_SYMBOL_GPL(mhi_ep_register_controller);
 
+/*
+ * It is expected that the controller drivers will power down the MHI EP stack
+ * using "mhi_ep_power_down()" before calling this function to unregister themselves.
+ */
 void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 105e8067409a..57fa445661f6 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -257,4 +257,10 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl);
  */
 int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl);
 
+/**
+ * mhi_ep_power_down - Power down the MHI endpoint stack
+ * @mhi_cntrl: MHI controller
+ */
+void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl);
+
 #endif
-- 
2.25.1

