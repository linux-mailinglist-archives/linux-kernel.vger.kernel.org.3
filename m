Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD9B4F4F29
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390270AbiDFAmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443755AbiDEPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D7836E02
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:59:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n8so3993709plh.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlDX9fQV9YwI2F2bsF/EhT89ZCpPX/Uxw6NOPcG/zWs=;
        b=vpfHXe2NKDpDlZOUubw/epseFWJYmzTK8I77LrHDUtVgVvNxWJLYVFm4Nw6VlN9whs
         Kxln9wEZ2CRA8FsH9PU5mi95PNoHoP4GWEapJH4Xc4U/PGwzruUl1h93BQlSvnQcdyPe
         y0YtQEVbBngqi2TDqoSexbidaWxDM8Tp8ht1yMXLHWsIdRZdcPv1QdnlYuo9c8FCPE89
         Nn/SFJmJKbIQuh5k/DtqmvQKF/kJWgO7D2kdmy6w7w0ZBqO7VrPBkMBEttF6JVVKhmG7
         QLUOVZxVU0YbWzDp6ydW7J8xT6qUkJeLpVIponOsgiyiBbqFyvaEEcoibQcBj1xbqbJ/
         fj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlDX9fQV9YwI2F2bsF/EhT89ZCpPX/Uxw6NOPcG/zWs=;
        b=3JKdqAgsR62ytSWw7Fiadhqeqt16D+cYyz9QV+C/lGxMNDuin0t3Ma6WiCHbJRUmnD
         ZOE9ooMc9PpPTqFQMK0Ff69QybICtM8y9vuRaPl/YQX+E0dmytH64omdQRa3Hx2+bxO9
         Yh3/Nykxv1fXxCiS2ubMu1JRx5tKIR12Ly/B0VhzuWnywMoZXv4LNdaFs5vFL9P2tEu6
         ZcFKnVT5L3vZgHQlhX2Hj4u03UjMplTgMF1tUwTuZGq81tgZDST/BqxrxgtgUFdKgC4f
         1FMT/5I8D/zQNKGZEwni/eKbdUR1ZOZs3DFHgxIwZGw+SlaPy4yiBtllgTF/1QBfu8s2
         9CIw==
X-Gm-Message-State: AOAM5330CUiJF26pw7ss0z6cMVoPGmIsIrj+LtJ7OXVf7KOlwAolfCPE
        h/+k4TiZYA6KFD/MwTfH54wC+57xEVEu
X-Google-Smtp-Source: ABdhPJx9jXnVCoeYIBfz9Q4nYaydHk89UYiMnWdYdSATjinvEhEEvVQ+jncDXj6i4vUE9kjQAl0gmA==
X-Received: by 2002:a17:903:40c7:b0:156:8b56:5fa1 with SMTP id t7-20020a17090340c700b001568b565fa1mr3657852pld.108.1649167146927;
        Tue, 05 Apr 2022 06:59:06 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.98])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm16785402pfi.149.2022.04.05.06.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:59:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/18] bus: mhi: ep: Add support for handling SYS_ERR condition
Date:   Tue,  5 Apr 2022 19:27:48 +0530
Message-Id: <20220405135754.6622-13-manivannan.sadhasivam@linaro.org>
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

Add support for handling SYS_ERR (System Error) condition in the MHI
endpoint stack. The SYS_ERR flag will be asserted by the endpoint device
when it detects an internal error. The host will then issue reset and
reinitializes MHI to recover from the error state.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/internal.h |  1 +
 drivers/bus/mhi/ep/main.c     | 20 ++++++++++++++++++++
 drivers/bus/mhi/ep/sm.c       | 11 +++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index 4f2e26841702..d201d755560c 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -211,5 +211,6 @@ int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_stat
 int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl);
 
 #endif
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index d36708d43eb6..706473ea4918 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -516,6 +516,26 @@ static void mhi_ep_reset_worker(struct work_struct *work)
 	}
 }
 
+/*
+ * We don't need to do anything special other than setting the MHI SYS_ERR
+ * state. The host will reset all contexts and issue MHI RESET so that we
+ * could also recover from error state.
+ */
+void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret;
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
index ffc02f5d0a0d..e3865b85399d 100644
--- a/drivers/bus/mhi/ep/sm.c
+++ b/drivers/bus/mhi/ep/sm.c
@@ -68,8 +68,10 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl)
 	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
 	spin_unlock_bh(&mhi_cntrl->state_lock);
 
-	if (ret)
+	if (ret) {
+		mhi_ep_handle_syserr(mhi_cntrl);
 		return ret;
+	}
 
 	/* Signal host that the device moved to M0 */
 	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_M0);
@@ -99,8 +101,10 @@ int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl)
 	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
 	spin_unlock_bh(&mhi_cntrl->state_lock);
 
-	if (ret)
+	if (ret) {
+		mhi_ep_handle_syserr(mhi_cntrl);
 		return ret;
+	}
 
 	/* Signal host that the device moved to M3 */
 	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_M3);
@@ -132,5 +136,8 @@ int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl)
 	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_READY);
 	spin_unlock_bh(&mhi_cntrl->state_lock);
 
+	if (ret)
+		mhi_ep_handle_syserr(mhi_cntrl);
+
 	return ret;
 }
-- 
2.25.1

