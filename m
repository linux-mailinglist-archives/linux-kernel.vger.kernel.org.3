Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8AB4B374E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiBLSXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:23:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBLSXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:23:31 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9ED60061
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:15 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x4so7260230plb.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nOeAtH9KqQy90Wc3/INZFeCi473Iwk1s2/Fhz+I9C3k=;
        b=QVyTtzeYWyHPclKxH4SZFHtF3XCzqOxoFhFxXy2EYmqZBAs4qu7xculGq8C+XBIAQ6
         mnNoxhoezaVExurBfqUDBoG3+QukjV1xsSgsJlIjJlO4sV87QeTciq+pweb+NPWSneBR
         C44eWQfK50ltPyKIiD3qTuO3qum1GxmwW1cyNx2oPma5DknsnycP2tuaKg0k5GAqKJth
         cGarVlOqQcCCVWh1BuSIgqN4LpBclde/55vIUNGLj4jA9IZafiqXmx+yLG7dL9UbQ1ov
         AgAP9+h1euN1dD2TQP2QT2et4qNLNxru/nSDrpDxYGV0ko9UG+GcGfi9BiKBR3fFxRIc
         JqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nOeAtH9KqQy90Wc3/INZFeCi473Iwk1s2/Fhz+I9C3k=;
        b=BP2cRttcZKP4Xz36WxcAu0J3V1U4lB/7cLzYqwcY5dc/E4Jz0rJ/U1ah1dkpI7Wb0c
         2wIW+JkbHC9tmut0Rvzywg4a9FFSFa1e9aXRyL6v6Z0DTjwC8VqfpJx7qDTlgGq1wwJ5
         HnlcCUZgjbkdIxH/PNWUeJL3yIP8hbjpq3R/IBJdowLujbyNFmK1Pntmfpy2C/tkMtP9
         T694BpdBr5KbTC79IWGqWEMaktRbVK8OoYqXZw7tuVWN4ECRT6RIo9aVz0Xmd0mPgPc0
         17UZf3Pt3E9IshAT25MFdlY4cCbxBxhPMW8I48YmwHpSEJ2je9Fhky/aE2HrJGgR8YvW
         Hc5A==
X-Gm-Message-State: AOAM533+u4Hs+lrN42xVdsXnwSaRPc1ybMqQ3I37T4UYnVc4WBszOXAL
        qfnyJtNangjYcggU/5b4AMQ6
X-Google-Smtp-Source: ABdhPJx6sakHNoUbIv6WLbXVv5/bnUcjzl4CHpRshFMWafwsldLiP14yjSqXEdQQorWGmy1gsOxkKA==
X-Received: by 2002:a17:90b:4c0d:: with SMTP id na13mr6274373pjb.96.1644690195423;
        Sat, 12 Feb 2022 10:23:15 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:23:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 19/25] bus: mhi: ep: Add support for handling SYS_ERR condition
Date:   Sat, 12 Feb 2022 23:51:11 +0530
Message-Id: <20220212182117.49438-20-manivannan.sadhasivam@linaro.org>
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
index ddedd0fb19aa..6378ac5c7e37 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -611,6 +611,30 @@ static void mhi_ep_reset_worker(struct work_struct *work)
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

