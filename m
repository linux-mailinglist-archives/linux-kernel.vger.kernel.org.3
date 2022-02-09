Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1874AEEF9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiBIKIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiBIKIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:08:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7069E0FF9C7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:07:43 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y17so1770085plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKd8rz2W2pUSkfaR34CkTXWCpF7wlT6fZ+O2u9SSHNA=;
        b=m6B6FzVzBrghgCzIeKI9/sgasAhBfsY90I8yBaKLtzzd3yu55UV4mAEitc5SJn5ZN2
         l9SWOJYnSsSt3vsfTf8NUIekS78zxGRKEUAmYiy088RZhQ1E6zufr4GZSoIbOaM5cL34
         mC8wKd/C95bztRSgwYk2AIOS/j8Ml0xDTE4uo6oTfi6edNI63iPoofrggnHxLyi2s/YY
         sIgvO/3BZTVfkncZl8iF5VMeMdCVJGdDnivqzmQ13aIbafT/vhAc6P2a+7lP8WcO/6Cn
         rASoq+VZ5+ywBcy64hYbSxrNxF4pfr/zzlsi3vXg/CFU9q5cMLd9UoA83ZMC4hut8Nbi
         exQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fKd8rz2W2pUSkfaR34CkTXWCpF7wlT6fZ+O2u9SSHNA=;
        b=dUg2GqQUjJegWKKtO2VadDF5SoHlS8XRAf0J5p0sYpkjHbfZgnd0dBmF5Pa+UyiL12
         y6mC6SR/RxPbxM62xkpn8uyZKYF4otMkCzGK5aTA9enzDswi+AVxFvyr1ZsPvNZLgTgy
         Z0Hbc9fWdN5ZJBOOkBEbUwhZomzj0V1nmf9ldy4T950Huf5HfFIAGKxJcmOWApJ/SD7Q
         x/8sDNyJ4JX5eoyP0M04+FodzGpQXgeOEWIoD0E/KgZ8gHdohzWfYzX2GQUS0qpA5JDv
         UwtQ/5IvAuFCyi6Qfdos9hSglJ9w83yDcMiqvatxhNVme9zCVMqFmA30SBS+44UNiAy4
         pRTA==
X-Gm-Message-State: AOAM532JHT6snF4cwiPdq8yRNdXl7cK8bHup3VkNlgS3cya5QPxikB58
        rwtQJq+m/Eql3uGIL2lis+/u
X-Google-Smtp-Source: ABdhPJz1KHM4SyEbu0dU63ZeC7I6GtfKLK24sp+muKSVHMbE/pqUXLYW9W5RFPPg3VuC4mGPIgeL1g==
X-Received: by 2002:a17:90a:5295:: with SMTP id w21mr2623783pjh.84.1644401219220;
        Wed, 09 Feb 2022 02:06:59 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:06:58 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 19/23] bus: mhi: ep: Add support for handling SYS_ERR condition
Date:   Wed,  9 Feb 2022 15:26:20 +0530
Message-Id: <20220209095624.26389-20-manivannan.sadhasivam@linaro.org>
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

Add support for handling SYS_ERR (System Error) condition in the MHI
endpoint stack. The SYS_ERR flag will be asserted by the endpoint device
when it detects an internal error. The host will then issue reset and
reinitializes MHI to recover from the error state.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/internal.h |  1 +
 drivers/bus/mhi/ep/main.c     | 24 ++++++++++++++++++++++++
 drivers/bus/mhi/ep/sm.c       |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index ee8c5974f0c0..8654af7caf40 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -241,6 +241,7 @@ int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_stat
 int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl);
 
 /* MHI EP memory management functions */
 int mhi_ep_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, size_t size,
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 7d7757784dde..b12c1f4ae8be 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -610,6 +610,30 @@ static void mhi_ep_reset_worker(struct work_struct *work)
 	}
 }
 
+/*
+ * We don't need to do anything special other than setting the MHI SYS_ERR
+ * state. The host issue will reset all contexts and issue MHI RESET so that we
+ * could also recover from error state.
+ */
+void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret;
+
+	/* If MHI EP is not enabled, nothing to do */
+	if (!mhi_cntrl->is_enabled)
+		return;
+
+	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
+	if (ret)
+		return;
+
+	/* Signal host that the device went to SYS_ERR state */
+	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_SYS_ERR);
+	if (ret)
+		dev_err(dev, "Failed sending SYS_ERR state change event: %d\n", ret);
+}
+
 int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
diff --git a/drivers/bus/mhi/ep/sm.c b/drivers/bus/mhi/ep/sm.c
index 68e7f99b9137..9a75ecfe1adf 100644
--- a/drivers/bus/mhi/ep/sm.c
+++ b/drivers/bus/mhi/ep/sm.c
@@ -93,6 +93,7 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl)
 
 	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
 	if (ret) {
+		mhi_ep_handle_syserr(mhi_cntrl);
 		spin_unlock_bh(&mhi_cntrl->state_lock);
 		return ret;
 	}
@@ -128,6 +129,7 @@ int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl)
 	spin_lock_bh(&mhi_cntrl->state_lock);
 	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
 	if (ret) {
+		mhi_ep_handle_syserr(mhi_cntrl);
 		spin_unlock_bh(&mhi_cntrl->state_lock);
 		return ret;
 	}
-- 
2.25.1

