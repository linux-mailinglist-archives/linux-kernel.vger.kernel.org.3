Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2824C6D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiB1MrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbiB1Mqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:46:40 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD077807E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:51 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d15so7698550pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2C1yMFxjGjTvy7CTcaK951xmErKjxy0jIgFxKiOd2x8=;
        b=uCgxUvlhbxXapqigUVqcFyuP9S9KjvbT0yXIw8/FPCsDoaD2hNpa2y3PJzNSNdODAr
         5zDhcTr/ij16AhJmkGPyizu6m6bHhQtfS97/5nHbtJQseebt0KAS6FLY4CCg6gC7/GTf
         iyjobFHGeV21HdU7eOby0Tea6CfGSsJfeWDeDl3oCR1xiOu3s7FSnjpcdUs5NeDiWN/t
         RAa3QRflTim0C2fmA1sq61+lzsoSO7KF93OI2xS4bVUftnprdOuV2W+odrUxJ0VYZsLa
         NUXmK0AdFC7VlAvXxN3XZA/TOwzt3c2y3gvZdz6wgL8Qsw8qq9G+9N2X55tNsbIOD8n7
         kvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2C1yMFxjGjTvy7CTcaK951xmErKjxy0jIgFxKiOd2x8=;
        b=2AIj5ZUM3w9hUO926/N3TQkJV0pgn+q0HBeYvV9hxJQ3vbMuW+LM3l+4dD0ETeviQY
         uPRayAPGnOPjsUu4pQji4fULtnXk7ijZKW0cAyu/XLJ6DYFIQtXRS+/opgZnjySDE7aO
         EfUILildZlkuekxESQ4S1VVJoH8xIecl8GN5uctEjPNlBzqrSwqQLphd8U4HGbzKlBvU
         j7DxDP6l8pEWi7BW0G/VJ2jE6zFHP2NiktwUOZCI2J+z9Wz2ihC3jzebWI3OjtF/64PU
         3VqpMoX/LiTOZRkspOi6w4vD/KqJSGLNNqyiFh62hMaotQCtKe1cMmXfk3J8qIVud/Om
         pi6Q==
X-Gm-Message-State: AOAM532np0E/MrwGdPUKakHI8XBz8pDFLPdqL0hAq3bSrt9cV9Yj3hI1
        vfRZ0naZZ9u3/8aY/hy9LxlP
X-Google-Smtp-Source: ABdhPJyf1eJc3IYDKvt+eJAGN6QzUWzHYipo4VQoUgN4Kv11Lx10mYz/Jhw5zCXCPZ2W0XVnJStrSQ==
X-Received: by 2002:a17:902:6b0a:b0:14d:8ee9:3298 with SMTP id o10-20020a1709026b0a00b0014d8ee93298mr20252851plk.125.1646052351008;
        Mon, 28 Feb 2022 04:45:51 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:45:50 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 21/27] bus: mhi: ep: Add support for handling SYS_ERR condition
Date:   Mon, 28 Feb 2022 18:13:38 +0530
Message-Id: <20220228124344.77359-22-manivannan.sadhasivam@linaro.org>
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
index a2ec4169a4b2..a229d8b70227 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -209,6 +209,7 @@ int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_stat
 int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
 int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
+void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl);
 
 /* MHI EP memory management functions */
 int mhi_ep_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, size_t size,
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 99cbad2a94c9..132fd9f51a1f 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -548,6 +548,26 @@ static void mhi_ep_reset_worker(struct work_struct *work)
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
index ad49276ec044..4d6e8c2d615c 100644
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

