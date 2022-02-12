Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646824B3736
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiBLSXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:23:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiBLSX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:23:29 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2D46004B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:11 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i6so20055185pfc.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ng+FJmRFoQc89QlNXGEu6Nz+DsWMowqD6JzTm0cBnHI=;
        b=VPJI5RfGfxcBSf0QCISXQcbfstewq+3Xs+C4gL6WufagubJPmyHN1LYFaXIqL+YlHz
         uIAzpSjT5zk7jpumLD3QfrKQhj3xn5kGYFV5jNqIDx/rtokTPd8Ha7wvaJKeUwAM8bum
         HP2OhF0laEajy6uQVBDTxSssHFmyF1ZI1JEXWoszjyLyJD0nJWiKT8Hw8ObO/FNuJ1Qq
         R4bTaty9M3qIo/tQ9N0Z4g5Ei9uEFtTn4eyArgXPkIHKAz+fIn6CXjS3+JoQplEsxgbA
         Bbo5M/ycAM8KLD+TR7m17FbqyfP53rA/ojJd8EcCnmU9nsnO3RnU5NoqBskCILFHmIXL
         T+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ng+FJmRFoQc89QlNXGEu6Nz+DsWMowqD6JzTm0cBnHI=;
        b=CFALyQ7CoJYFIFO5GCKc4yhAFyspG/VvGFjtMk/Rssg5DQ/pKwrkuiRgfusEy3PcZ2
         XwApoB0rZTUHIx2zsMOhblOflnlbAfv09ksBKWwu/HzW7QJmfmUalfn8647yPjuDrg5S
         kv0G7zUIdSG7CKzSIBZ4xJfYVfURRPS2AK35TrmL03R3bX9gBYK+fn/HdMKfEYAIHzdp
         e9U88SKrOInC9DGkLc6TpGOFE2sUtrdFYYKrtEO/AfqJzxuXZy2iO6KK8mV4Nk6H/p/A
         XYhHQT98krcel0YUJTmAZkfwHMCRZVxhPn+kKL0jI1B+LmTO2/IUaFzk1y7obifd/gFg
         Hlcw==
X-Gm-Message-State: AOAM5325pOa8rUcoNR3vfJlEE9jwiKYieI3C+2aEMmCcijkoF8hcx+Ud
        qL/FruSQQFAaTOI3g+zAkmmL
X-Google-Smtp-Source: ABdhPJxzQw7S9tasrOjpKXFp+CMbejZJTVo1V7X6T1PPGnxNyTmSRhp1q/FXC/uKEFOs432QgWAE4A==
X-Received: by 2002:a65:458f:: with SMTP id o15mr4100193pgq.92.1644690191159;
        Sat, 12 Feb 2022 10:23:11 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:23:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 18/25] bus: mhi: ep: Add support for handling MHI_RESET
Date:   Sat, 12 Feb 2022 23:51:10 +0530
Message-Id: <20220212182117.49438-19-manivannan.sadhasivam@linaro.org>
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
index 14cb08de4263..ddedd0fb19aa 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -471,6 +471,7 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	enum mhi_state state;
 	u32 int_value;
+	bool mhi_reset;
 
 	/* Acknowledge the interrupts */
 	int_value = mhi_ep_mmio_read(mhi_cntrl, MHI_CTRL_INT_STATUS_A7);
@@ -479,6 +480,14 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
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
 
@@ -559,6 +568,49 @@ static void mhi_ep_abort_transfer(struct mhi_ep_cntrl *mhi_cntrl)
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
@@ -827,6 +879,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
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

