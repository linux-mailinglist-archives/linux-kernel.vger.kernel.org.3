Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C699466293
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357647AbhLBLmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357497AbhLBLlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:41:40 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F097C0613E1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:38:17 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u11so20044468plf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXxNxYYV5RcHGgry8/y8RqGwg5B0/QotcI3nKFMorEY=;
        b=BXPRbj2Qu5dHWVrN6tGOyX9geBDY49fZxhhIDpA9RXI9OOTtqG5b+BBW36OIbpgmZc
         GGMMazAOykh6BNZZK39dZwfRT0EQPeuVu5FWr1oR1OCJGAKR+YwBRwpFtoaOhwMHW6V5
         fRhYdjTCE9cb/tHOZI9+Mx+e7kOrNIwKsNl+m6rpnaTzYghpyGhItJovE6TF9ctZVPCM
         z1TlqaLXS76YXOgOrYXi9nXk96uBXziK22vwppp4Bq1l1UinDo/4XNT8DHY3sGhulZzn
         WBJqUjxx8cbNb+cak6TA8xR003fwnFir7UQ9HZ5YQhWBDJbF5LXbqUjDJKOQqJ0az172
         IBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXxNxYYV5RcHGgry8/y8RqGwg5B0/QotcI3nKFMorEY=;
        b=dKWKTr1nisBF7Gq4nMyTRmnLQoQkwJNxO1kiupTPHinuREdL/fnEhcIKAXvjdHxXfb
         ounWE77rhZwtCuaV4evILMqQJyOf6ZWbC//xezN7/1kPtFkjZCH9Y3olA+iS9dDI4wsi
         SpOV47JydYwXqdi8P++pa0eLiO06GkewOr7vIEQcnOgPNowDUUrNhU7oAt+B27cgmdrl
         nrt/XXdxjuPk4ZNRGG/YdD0/FVl3sAx8riGclG5wj1eNWnXIaT5dBtdxBlollLDoUF1Y
         dC2bWj9lAz2OpJ6/WzCe+h0lpz9Cg+PHFQJy7YyxM0894WOu9u/Uwt3SdSW3KFjYsYMz
         rtTQ==
X-Gm-Message-State: AOAM533gi1QY4mJM9zIQM1H0SFcnmqzHrxUzpVJ4VvWY2QPRIjbdlj2E
        etRFVMaMDAWFNnxzGrX51dWo
X-Google-Smtp-Source: ABdhPJwqoDiWydSWys1ELJ6GFmYWiGCZ1L72iBAely2qK/nzEA+cXaOXsaHsOnLjY0WBHqRk2jMPTw==
X-Received: by 2002:a17:90b:33d0:: with SMTP id lk16mr5506453pjb.20.1638445097166;
        Thu, 02 Dec 2021 03:38:17 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:38:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 16/20] bus: mhi: ep: Add support for handling SYS_ERR condition
Date:   Thu,  2 Dec 2021 17:05:48 +0530
Message-Id: <20211202113553.238011-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index ec508201c5c0..5c6b622482c9 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -228,5 +228,6 @@ int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_stat
 int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl);
 
 #endif
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 0b0fad6bf69a..088eac0808d1 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -148,6 +148,30 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
 	return mhi_ep_send_event(mhi_cntrl, 0, &event);
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
 static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
diff --git a/drivers/bus/mhi/ep/sm.c b/drivers/bus/mhi/ep/sm.c
index 95cec5c627b4..50378b9f7300 100644
--- a/drivers/bus/mhi/ep/sm.c
+++ b/drivers/bus/mhi/ep/sm.c
@@ -98,6 +98,7 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl)
 
 	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
 	if (ret) {
+		mhi_ep_handle_syserr(mhi_cntrl);
 		spin_unlock_bh(&mhi_cntrl->state_lock);
 		return ret;
 	}
@@ -133,6 +134,7 @@ int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl)
 	spin_lock_bh(&mhi_cntrl->state_lock);
 	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
 	if (ret) {
+		mhi_ep_handle_syserr(mhi_cntrl);
 		spin_unlock_bh(&mhi_cntrl->state_lock);
 		return ret;
 	}
-- 
2.25.1

