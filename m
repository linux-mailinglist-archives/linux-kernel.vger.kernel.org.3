Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495A14AEFCD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiBILLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiBILLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:11:52 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D2AE0FF0CC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:07:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id om7so1681712pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4o9xCQUHVRvja/FToQCLxxhmJS9+mNwbw+kIoBrp6zw=;
        b=gx7iHvWuC+9XU8vKL8OuEBuOE52BrYE3H3qd+1iRgs6ImoYrxga9CePaAeuyaB67Jn
         eiK2bp8QDmc1T1RiNWCs1owh1bU3kFQfAe1L+mCLHSFDE3sE5OMdRfoUwer/xjyYkFxH
         C6u5UOxvFtqNmCxhwgWbir5MZdpWgSRqplMzXGVxdGgvsNUgiKUjYyyT9g+0iAgNWeAt
         ZVZ09Nsf68wYitS5rt4Ol7gu7EsTlmAqesy4bt5vSP56Lg8ddDoAJlS4XmahbLeO8Qhe
         rbHCePSPgmv7XswKmu9BwBP3j95GzafhKjd4OGv3QnsYcWAM1HrEkn4pv9ID0tbUPt40
         c26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4o9xCQUHVRvja/FToQCLxxhmJS9+mNwbw+kIoBrp6zw=;
        b=ziO02ysQAvvrgc1wCaCbfRBX+6PIDG9hDz3bNc6MapV2VbEttFSLy+0qqsBByInhFv
         6tVlbDD8eRWC3HjWpgO/f0j2FX2L1gDOOvGEAClJezXSjJDS995lycrdTx8UybX4neJa
         9D1SKu2WUs/TSPGyRSdJEcQVanzzZ4Frf8PmPkQGf9EiHYmgwvqGcrGjmCI4bOFV1+i1
         qF+Rhe1ZwuEpU9ugrEn9UlRi4+I92bHJywTad8Qkg9p0fMjcKOtz6FTB++NqhDQCpUMv
         zd+XBV8IN5SPgjWgkLXRLy0Vjw1dAeGtUfkQZ3s6Wv+IIBdS6DVgOO8+6r/WSAxsOAUe
         50WA==
X-Gm-Message-State: AOAM532QQpEfd6gNl7t/zImI7uLs0OlqnGAO4nOXLNiC/OcmTognZnZv
        dZG9pQC2iAn4lPgOqlH7lUYF
X-Google-Smtp-Source: ABdhPJx536QW/Ho9u8GXzCDchikyLTE3xYhc8KXip2Z5k20UZiYQYVrp1c6TOdkP3PBH+s6nZo7wyA==
X-Received: by 2002:a17:90a:2ac4:: with SMTP id i4mr2539391pjg.204.1644401213435;
        Wed, 09 Feb 2022 02:06:53 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:06:53 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 18/23] bus: mhi: ep: Add support for handling MHI_RESET
Date:   Wed,  9 Feb 2022 15:26:19 +0530
Message-Id: <20220209095624.26389-19-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
References: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
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

Add support for handling MHI_RESET in MHI endpoint stack. MHI_RESET will
be issued by the host during shutdown and during error scenario so that
it can recover the endpoint device without restarting the whole device.

MHI_RESET handling involves resetting the internal MHI registers, data
structures, state machines, resetting all channels/rings and setting
MHICTRL.RESET bit to 0. Additionally the device will also move to READY
state if the reset was due to SYS_ERR.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 53 +++++++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h    |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 905d91dd67c0..7d7757784dde 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -470,6 +470,7 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	enum mhi_state state;
 	u32 int_value;
+	bool mhi_reset;
 
 	/* Acknowledge the interrupts */
 	int_value = mhi_ep_mmio_read(mhi_cntrl, MHI_CTRL_INT_STATUS_A7);
@@ -478,6 +479,14 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
 	/* Check for ctrl interrupt */
 	if (FIELD_GET(MHI_CTRL_INT_STATUS_A7_MSK, int_value)) {
 		dev_dbg(dev, "Processing ctrl interrupt\n");
+		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
+		if (mhi_reset) {
+			dev_info(dev, "Host triggered MHI reset!\n");
+			disable_irq_nosync(mhi_cntrl->irq);
+			schedule_work(&mhi_cntrl->reset_work);
+			return IRQ_HANDLED;
+		}
+
 		mhi_ep_process_ctrl_interrupt(mhi_cntrl, state);
 	}
 
@@ -558,6 +567,49 @@ static void mhi_ep_abort_transfer(struct mhi_ep_cntrl *mhi_cntrl)
 	mhi_cntrl->is_enabled = false;
 }
 
+static void mhi_ep_reset_worker(struct work_struct *work)
+{
+	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, reset_work);
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state cur_state;
+	int ret;
+
+	mhi_ep_abort_transfer(mhi_cntrl);
+
+	spin_lock_bh(&mhi_cntrl->state_lock);
+	/* Reset MMIO to signal host that the MHI_RESET is completed in endpoint */
+	mhi_ep_mmio_reset(mhi_cntrl);
+	cur_state = mhi_cntrl->mhi_state;
+	spin_unlock_bh(&mhi_cntrl->state_lock);
+
+	/*
+	 * Only proceed further if the reset is due to SYS_ERR. The host will
+	 * issue reset during shutdown also and we don't need to do re-init in
+	 * that case.
+	 */
+	if (cur_state == MHI_STATE_SYS_ERR) {
+		mhi_ep_mmio_init(mhi_cntrl);
+
+		/* Set AMSS EE before signaling ready state */
+		mhi_ep_mmio_set_env(mhi_cntrl, MHI_EP_AMSS_EE);
+
+		/* All set, notify the host that we are ready */
+		ret = mhi_ep_set_ready_state(mhi_cntrl);
+		if (ret)
+			return;
+
+		dev_dbg(dev, "READY state notification sent to the host\n");
+
+		ret = mhi_ep_enable(mhi_cntrl);
+		if (ret) {
+			dev_err(dev, "Failed to enable MHI endpoint: %d\n", ret);
+			return;
+		}
+
+		enable_irq(mhi_cntrl->irq);
+	}
+}
+
 int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
@@ -826,6 +878,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
 	INIT_WORK(&mhi_cntrl->ring_work, mhi_ep_ring_worker);
 	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
+	INIT_WORK(&mhi_cntrl->reset_work, mhi_ep_reset_worker);
 
 	mhi_cntrl->ring_wq = alloc_workqueue("mhi_ep_ring_wq", 0, 0);
 	if (!mhi_cntrl->ring_wq) {
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 4f86e7986c93..276d29fef465 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -75,6 +75,7 @@ struct mhi_ep_db_info {
  * @ring_wq: Dedicated workqueue for processing MHI rings
  * @state_work: State transition worker
  * @ring_work: Ring worker
+ * @reset_work: Worker for MHI Endpoint reset
  * @ch_db_list: List of queued channel doorbells
  * @st_transition_list: List of state transitions
  * @list_lock: Lock for protecting state transition and channel doorbell lists
@@ -126,6 +127,7 @@ struct mhi_ep_cntrl {
 	struct workqueue_struct	*ring_wq;
 	struct work_struct state_work;
 	struct work_struct ring_work;
+	struct work_struct reset_work;
 
 	struct list_head ch_db_list;
 	struct list_head st_transition_list;
-- 
2.25.1

