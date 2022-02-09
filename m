Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758AB4AEFCB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiBILLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiBILLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:11:50 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA0E0FF0C8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:07:32 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id a39so2545834pfx.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFZgoGnI3cisO4fx/xIRE0ictJOwc0YvUYVkE58qbxo=;
        b=xbLXnF+dqJ0+abr5RsaTixWkMpvl6aBfoCQeWDHwI//8EwOqYnTgtxsP2KCWAZr9ah
         +XRq6yFlp95DoqBbfkgP1iA7qHhXPSmfHYmiyMaSP4oofjZHc9JmtXKq2M+KPI6Gf1Vi
         nCS404jde6vQPYzFM8gmOZAM83FRlreLIr3IRbxEacigRTFTsbtw7uM/S3QXddgayNcW
         ZyZLi3XDNqLBYwdA51t5PPSWOkEq7abbEmPHMDSK5c5rRpjb/xTCOEzSQkVADmOmel/3
         JPPXDrCDgCw1mRAdk5rbQ1CaXR/38XgBDS7DDZKMYkBIBT2GwQG4Fme85zTuQkmOgyPL
         QMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFZgoGnI3cisO4fx/xIRE0ictJOwc0YvUYVkE58qbxo=;
        b=xqlk91wXmmVruKvWmxhX8jrguW8tc3mVBDxrES97ZaHPP5UhA5ydujHXFANXffh2yi
         +XlfCxaSvqOe30rd3MEAd66M0m806Y+I5pDELQmr6lS0WzQ1YJseVzPGaZJGuxn9RyrF
         AZPsWDH7N3oCNuuJHExM7xANCDC2qJVgLwmFtBWluUeoNvMD8f5e5R8hdVdUuSKuLnx5
         r9LzAFlA5yK5i+IcqYfS0F91tI7NwFh7ZE0vDmCY4tyet8NV4aCeJRKlH/hkuBREJu1x
         44dCSn0tAGSx7vDUhsbtcacwfouRoK1zCOJhc9fISjKcLLu4vCxS3lRGKQBwCtZtONSH
         KFKw==
X-Gm-Message-State: AOAM533OBCfsYaCa1Tmd1aYSojHbzWBypwgC28iEwFmOD5u1OvFbiRBH
        aelXvsXYVkXhyHzHM1AGaJoN
X-Google-Smtp-Source: ABdhPJw9bdcof2cDH4gp8Ag0J8r+LQQMS/hK2yE6VFUbHVMN34rb8IydrfaMSo5OmFYYuzeUTxOrpA==
X-Received: by 2002:a63:e643:: with SMTP id p3mr1265637pgj.7.1644401207702;
        Wed, 09 Feb 2022 02:06:47 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:06:47 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 17/23] bus: mhi: ep: Add support for powering down the MHI endpoint stack
Date:   Wed,  9 Feb 2022 15:26:18 +0530
Message-Id: <20220209095624.26389-18-manivannan.sadhasivam@linaro.org>
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
index 86a357129bec..905d91dd67c0 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -21,6 +21,8 @@
 
 static DEFINE_IDA(mhi_ep_cntrl_ida);
 
+static int mhi_ep_destroy_device(struct device *dev, void *data);
+
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
 			     struct mhi_ep_ring_element *el)
 {
@@ -491,6 +493,71 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
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
+		if (!ch_ring->started)
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
+		if (!ch_ring->started)
+			continue;
+
+		mhi_chan = &mhi_cntrl->mhi_chan[i];
+		mutex_lock(&mhi_chan->lock);
+		mhi_ep_ring_reset(mhi_cntrl, ch_ring);
+		mutex_unlock(&mhi_chan->lock);
+	}
+
+	/* Stop and reset the event rings */
+	for (i = 0; i < mhi_cntrl->event_rings; i++) {
+		ev_ring = &mhi_cntrl->mhi_event[i].ring;
+		if (!ev_ring->started)
+			continue;
+
+		mutex_lock(&mhi_cntrl->event_lock);
+		mhi_ep_ring_reset(mhi_cntrl, ev_ring);
+		mutex_unlock(&mhi_cntrl->event_lock);
+	}
+
+	/* Stop and reset the command ring */
+	mhi_ep_ring_reset(mhi_cntrl, &mhi_cntrl->mhi_cmd->ring);
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
@@ -547,6 +614,16 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
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
@@ -827,6 +904,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
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
index 53895f1c68e1..4f86e7986c93 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -260,4 +260,10 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl);
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

