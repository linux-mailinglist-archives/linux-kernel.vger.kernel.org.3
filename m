Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736514C6D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiB1Mrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiB1MrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:47:17 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCF479C52
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:46:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z15so11050566pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfwzfNqq6vq0SsTnjLEp+6L4UBQXfn7xq4uvXb2A4qw=;
        b=bA1BWSLFNpCciGnGldmGs1g305ey7gWYd43oNQc5VxwUczAgrbRw2sleyGyaQ+yTks
         KIoWCdmI4qVwT2R/y+CkuyNPTHKpcHZxECpjxvZh8d6+KuF2Nh4tEiHZVcmH+kf8VXpn
         wdDr+0npYRU+vCHEevPo6oY1GTStiukGcKmfZfC4F9ay6enSEPHLTHpZ0Ap6OxDBtkXX
         u2q1+qlM5qRf1SyzfLkTqEaKaGWxqq47wcYzBNSTshELUZQzOFs8bpZXDhS/fybJxCDU
         sFnHzByYu3ZTkLQUYCFBHbQvA8kqGS8PheXsfV1lVHZ7E9XR2/Tdc7kE6HCOwnW9+2/b
         5vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfwzfNqq6vq0SsTnjLEp+6L4UBQXfn7xq4uvXb2A4qw=;
        b=CPYyGQPSoKPWZyOhR9KIWejELbuNSc9vz6sptD9FIrLHCrYf3rr9sG66hmi/BmLyyE
         I+CVuBsj2kVjduf3lCmojJ/dyjpDPcr01Sa5857iU05OXkoqn6BLt0aCvT5WonCFaxMf
         OiiAqeMQPSl9P2obhnv1rZoo2h73QpV9yeagS6ZHLgMi3amBllJNtSwciTf7tn0ZtVMo
         z0PXP054Hn+xx7NITbrxkdGOXxbXJm1Iw2zSdxaLanpIC6V78fgCVx/IOyhwVU3zxune
         SlmRoDBu76H427nWeCQ7Kx7RCxeJDSQL7IZ0M6f9K0Mv8gCoKNu8gWo8dzxFz7yR5RFe
         JKpw==
X-Gm-Message-State: AOAM531tTTiPCWxSv9oVNAI5n/FX3WRElNYJ6o9nIuuKa0SliPVDMRfw
        C/4dYkPbUFaQxoKjayODpF4x
X-Google-Smtp-Source: ABdhPJyoDhxnyLLhiXj3FVUBCTzye9LuIHWe8nXli2d39+oXfn3otagNBKy+7n1ttyR5IGl84g15pQ==
X-Received: by 2002:a05:6a00:8d5:b0:4e1:77c9:def8 with SMTP id s21-20020a056a0008d500b004e177c9def8mr21504500pfu.55.1646052376709;
        Mon, 28 Feb 2022 04:46:16 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:46:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 26/27] bus: mhi: ep: Add support for suspending and resuming channels
Date:   Mon, 28 Feb 2022 18:13:43 +0530
Message-Id: <20220228124344.77359-27-manivannan.sadhasivam@linaro.org>
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

Add support for suspending and resuming the channels in MHI endpoint stack.
The channels will be moved to the suspended state during M3 state
transition and will be resumed during M0 transition.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/internal.h |  2 ++
 drivers/bus/mhi/ep/main.c     | 58 +++++++++++++++++++++++++++++++++++
 drivers/bus/mhi/ep/sm.c       |  5 +++
 3 files changed, 65 insertions(+)

diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index a229d8b70227..14fbf4e41ebf 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -210,6 +210,8 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
 void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_resume_channels(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_suspend_channels(struct mhi_ep_cntrl *mhi_cntrl);
 
 /* MHI EP memory management functions */
 int mhi_ep_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, size_t size,
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 25d34cf26fd7..3efdbf924076 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1129,6 +1129,64 @@ void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl)
 }
 EXPORT_SYMBOL_GPL(mhi_ep_power_down);
 
+void mhi_ep_suspend_channels(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct mhi_ep_chan *mhi_chan;
+	u32 tmp;
+	int i;
+
+	for (i = 0; i < mhi_cntrl->max_chan; i++) {
+		mhi_chan = &mhi_cntrl->mhi_chan[i];
+
+		if (!mhi_chan->mhi_dev)
+			continue;
+
+		mutex_lock(&mhi_chan->lock);
+		/* Skip if the channel is not currently running */
+		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[i].chcfg);
+		if (FIELD_GET(CHAN_CTX_CHSTATE_MASK, tmp) != MHI_CH_STATE_RUNNING) {
+			mutex_unlock(&mhi_chan->lock);
+			continue;
+		}
+
+		dev_dbg(&mhi_chan->mhi_dev->dev, "Suspending channel\n");
+		/* Set channel state to SUSPENDED */
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_SUSPENDED);
+		mhi_cntrl->ch_ctx_cache[i].chcfg = cpu_to_le32(tmp);
+		mutex_unlock(&mhi_chan->lock);
+	}
+}
+
+void mhi_ep_resume_channels(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct mhi_ep_chan *mhi_chan;
+	u32 tmp;
+	int i;
+
+	for (i = 0; i < mhi_cntrl->max_chan; i++) {
+		mhi_chan = &mhi_cntrl->mhi_chan[i];
+
+		if (!mhi_chan->mhi_dev)
+			continue;
+
+		mutex_lock(&mhi_chan->lock);
+		/* Skip if the channel is not currently suspended */
+		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[i].chcfg);
+		if (FIELD_GET(CHAN_CTX_CHSTATE_MASK, tmp) != MHI_CH_STATE_SUSPENDED) {
+			mutex_unlock(&mhi_chan->lock);
+			continue;
+		}
+
+		dev_dbg(&mhi_chan->mhi_dev->dev, "Resuming channel\n");
+		/* Set channel state to RUNNING */
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_RUNNING);
+		mhi_cntrl->ch_ctx_cache[i].chcfg = cpu_to_le32(tmp);
+		mutex_unlock(&mhi_chan->lock);
+	}
+}
+
 static void mhi_ep_release_device(struct device *dev)
 {
 	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
diff --git a/drivers/bus/mhi/ep/sm.c b/drivers/bus/mhi/ep/sm.c
index 4d6e8c2d615c..22b578bd851b 100644
--- a/drivers/bus/mhi/ep/sm.c
+++ b/drivers/bus/mhi/ep/sm.c
@@ -62,8 +62,11 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl)
 	enum mhi_state old_state;
 	int ret;
 
+	/* If MHI is in M3, resume suspended channels */
 	spin_lock_bh(&mhi_cntrl->state_lock);
 	old_state = mhi_cntrl->mhi_state;
+	if (old_state == MHI_STATE_M3)
+		mhi_ep_resume_channels(mhi_cntrl);
 
 	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
 	spin_unlock_bh(&mhi_cntrl->state_lock);
@@ -106,6 +109,8 @@ int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl)
 		return ret;
 	}
 
+	mhi_ep_suspend_channels(mhi_cntrl);
+
 	/* Signal host that the device moved to M3 */
 	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_M3);
 	if (ret) {
-- 
2.25.1

