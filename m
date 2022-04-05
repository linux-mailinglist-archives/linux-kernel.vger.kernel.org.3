Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10C24F4F14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836889AbiDFAkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443779AbiDEPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E286FA19
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:59:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p8so12164900pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFXomhHOlRXcuYSu2VTavCR7TmWd+0G4V458iu5OlvM=;
        b=OVBa/4kqlzEmoELnAN/0mTt7ddoTItJ9fZOzsluUCzvlxHMR5LlEa27+4wKNj5HY6l
         +dyO0RsQWJ6qLatkdPD/jGzsPIMYdGh5eFBWWTIrqy0h1UUjAKJB3GK64uXY9mINapJk
         0WSq0I3m+H1SMzflZQTJAE0Noyhbt0DrGXZACefS+TlygUS6Y46xm/rCU2Jy5t1NGxtt
         69mho63QClXfvK59CKWQ98iQUiGavxUhtFyoshI6ZrvXjvM4zblZo804r3V54YV533gE
         +MaxlSgY/vQa/BJGlrV03g4yekDtbsAiXn6KfpaJWjrdIrHAkmYPh1reIhgiPb7vuAsm
         QcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFXomhHOlRXcuYSu2VTavCR7TmWd+0G4V458iu5OlvM=;
        b=L7FhKadSCYLm2anALYZdHK6qlFIgM4pkvCRZxqc3A9p7VKWEeYdDaD3By49m4AsBck
         Jp+Ft1SI1NaIjzcJHXhdIKliL7nxZ0zlssmJxUgdRNziWArBn6sesbWh2AqJ7I2BRHLS
         bONCt/r80+jVceyqNFRuHW0sHy8YbPVBg+munEiV8JikL4uajIU8yRvkufZ8l9vf+o92
         1B8p+cJonWB2VNJ5reDjft6rrZPSJo5Y+VNUBhhGtQUZVQ48s2Zv+mgEARiw8apwKnnC
         XCbUPssiNcrhWkS+0EblDWe+nXUrnjwYtCD1sGknvET1EXwWcWHfb8vG7vHc0f4AK1JE
         AhEA==
X-Gm-Message-State: AOAM530VIOQzzen2+C8rtmeOletGLII2HYXoGtQbuWfnZW01puosbBa0
        xD/iJTCbFzDUXJWXtJuUiArd
X-Google-Smtp-Source: ABdhPJzjAFMtlNNMcn978sSk84yQ8/SjT7VR0/m3/NHEsGVrvtmAG9H/ATIZenHZztmnx3vaqBC0FQ==
X-Received: by 2002:a05:6a00:27a2:b0:4fa:e893:bb68 with SMTP id bd34-20020a056a0027a200b004fae893bb68mr3688149pfb.82.1649167171771;
        Tue, 05 Apr 2022 06:59:31 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:59:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 17/18] bus: mhi: ep: Add support for suspending and resuming channels
Date:   Tue,  5 Apr 2022 19:27:53 +0530
Message-Id: <20220405135754.6622-18-manivannan.sadhasivam@linaro.org>
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
index d201d755560c..a2125fa5fe2f 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -212,5 +212,7 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
 void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_resume_channels(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_suspend_channels(struct mhi_ep_cntrl *mhi_cntrl);
 
 #endif
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 660d1e9791d3..bae5f40ec15e 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1097,6 +1097,64 @@ void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl)
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
index e3865b85399d..3655c19e23c7 100644
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

