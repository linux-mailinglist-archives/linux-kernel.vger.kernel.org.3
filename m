Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF7E516A01
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 06:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383200AbiEBEfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 00:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245082AbiEBEf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 00:35:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15F933EBB
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 21:31:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so13232914pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 21:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=REuG9AexGg7IgaxDgoA3z0hRC9whRi90+gRekVavtK0=;
        b=qYdrKsq4vx6OMzLHypiBWrV/zNIs92fUhPgKoluy4rmEnH203IrBZ5Fa674WVndhOO
         OyvjO/qquEY60LWyX8IFzLCEybrvltsbNa4QuQ/Pg0pzG9euNUJO4LCo2E7P942nFzDr
         jYpK4GWMt/Yrb6SuCWvbio/x2n3y6+eCwqWEKvChvESVpKhWiXpsj5RaPseuSrICkhn9
         kxYc/yE2P6PNhIyzbYo/Kyq6wjUV+ZZr/VQzEOM3lkOyeUE3Sa3fY2ecXa4nYyPAoZOa
         fCrideEKQHeXigGJEKyVp6yqoUHb7aqYoFqXfr0Z9Ao7JXHnHJJ9neN0EGBS3T91IBjb
         PD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=REuG9AexGg7IgaxDgoA3z0hRC9whRi90+gRekVavtK0=;
        b=kRud6fq018PFueW47WQuLee2zIo00qnD5RNJTi/DwOUYcAK8qgGp33Vg1U27kwQcEI
         2DbtyhnfQZddAtEsq+71GqLJULdHHyFBa7U6UaQNbEjQtbPYKoJKmKrc/xgHR5yp7I3M
         Y1R9JgM6E32ZJBYC8k16uyAlpFldWdNuCjRmPgAHxI400J56Vx+U4OL5k9Ws/7vQDxIL
         xgjnDPhDjA9MDO2fWWUj/xp6MWB6mWaZ9KJdS2MiPgjG578mvJXy+PI97bUOF80RKe/4
         SiIBkXAPGYbfC6myssSnDeN9q8WKvO2NkMTqXpKuP799FT8j4hcWgGERCcvyZwKaimk/
         bPiA==
X-Gm-Message-State: AOAM532YLlvsMXO303IIN8HrtNm7fQe6Xo7G0QEzbxm+pn4TZheYZ275
        8QewIh8stmWa12b1SPHLLFRjmMASIe3w
X-Google-Smtp-Source: ABdhPJyJDeuSJAGCrkSPLUekdjILRLsonL6mTKS5o69d+6dmpli3ly3cd2fRtjNqiyYjPxS59Hm2QQ==
X-Received: by 2002:a17:90a:e641:b0:1da:43b8:95b7 with SMTP id ep1-20020a17090ae64100b001da43b895b7mr11275846pjb.180.1651465919116;
        Sun, 01 May 2022 21:31:59 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id o6-20020a1709026b0600b0015e8d4eb2d0sm3620260plk.282.2022.05.01.21.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 21:31:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] bus: mhi: ep: Power up/down MHI stack during MHI RESET
Date:   Mon,  2 May 2022 10:01:52 +0530
Message-Id: <20220502043152.16675-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

During graceful shutdown scenario, host will issue MHI RESET to the
endpoint device before initiating shutdown. In that case, it makes sense
to completely power down the MHI stack as sooner or later the access to
MMIO registers will be prohibited. Also, the stack needs to be powered
up in the case of SYS_ERR to recover the device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 40109a79017a..2de7ef20225a 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -977,7 +977,7 @@ static void mhi_ep_reset_worker(struct work_struct *work)
 	enum mhi_state cur_state;
 	int ret;
 
-	mhi_ep_abort_transfer(mhi_cntrl);
+	mhi_ep_power_down(mhi_cntrl);
 
 	spin_lock_bh(&mhi_cntrl->state_lock);
 	/* Reset MMIO to signal host that the MHI_RESET is completed in endpoint */
@@ -990,27 +990,8 @@ static void mhi_ep_reset_worker(struct work_struct *work)
 	 * issue reset during shutdown also and we don't need to do re-init in
 	 * that case.
 	 */
-	if (cur_state == MHI_STATE_SYS_ERR) {
-		mhi_ep_mmio_init(mhi_cntrl);
-
-		/* Set AMSS EE before signaling ready state */
-		mhi_ep_mmio_set_env(mhi_cntrl, MHI_EE_AMSS);
-
-		/* All set, notify the host that we are ready */
-		ret = mhi_ep_set_ready_state(mhi_cntrl);
-		if (ret)
-			return;
-
-		dev_dbg(dev, "READY state notification sent to the host\n");
-
-		ret = mhi_ep_enable(mhi_cntrl);
-		if (ret) {
-			dev_err(dev, "Failed to enable MHI endpoint: %d\n", ret);
-			return;
-		}
-
-		enable_irq(mhi_cntrl->irq);
-	}
+	if (cur_state == MHI_STATE_SYS_ERR)
+		mhi_ep_power_up(mhi_cntrl);
 }
 
 /*
@@ -1089,11 +1070,11 @@ EXPORT_SYMBOL_GPL(mhi_ep_power_up);
 
 void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl)
 {
-	if (mhi_cntrl->enabled)
+	if (mhi_cntrl->enabled) {
 		mhi_ep_abort_transfer(mhi_cntrl);
-
-	kfree(mhi_cntrl->mhi_event);
-	disable_irq(mhi_cntrl->irq);
+		kfree(mhi_cntrl->mhi_event);
+		disable_irq(mhi_cntrl->irq);
+	}
 }
 EXPORT_SYMBOL_GPL(mhi_ep_power_down);
 
-- 
2.25.1

