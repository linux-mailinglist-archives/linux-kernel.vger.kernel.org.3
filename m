Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A977B56D4B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiGKGar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiGKGaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:30:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D46BE25
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8015B80D9F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3C5C34115
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657521019;
        bh=83Z3dBr0EAEDGNw5mEkCIQFTIMC5O4T0Hz0XD7hPevE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A+2dy7RQMzsdfJgDJxA4I8QZM7O+a1Tk/ky7YK3SiP39Z6mCEnFMYBDp0EQd/y/mF
         Bt51y3iulX0/ImqOO8PpUPmYSFVtKfG6nlxGVqDPu6yHJ7lNgewz8GKRLPJfXXZ6Yf
         KQWyplx+zs0Pee9YtcDox8MpdRtFY6DMyhlmVL6MCBsRRoCzOP08ckxGsoqoKaowxD
         aWSARL+rLsodpMlYszx50c0VxVT53ruF4pp454n7hjMID7zXYwOZT/mUbJg3v/j9om
         fXS+BkQfdTjgaFjyhPqopz9qZgnJshUtKHMmEtmHBI/6vAGenqZnaRcKTFuWgcT/gZ
         19Ub/Mvur0faQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] habanalabs: fix update of is_in_soft_reset
Date:   Mon, 11 Jul 2022 09:30:00 +0300
Message-Id: <20220711063003.3182795-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711063003.3182795-1-ogabbay@kernel.org>
References: <20220711063003.3182795-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reset_info.is_in_soft_reset should be updated both before in_reset
and inside the spin lock of the reset info structure.

The reasons are:

- When we are inside soft reset, it implies we are in reset. Therefore,
  if someone checks if we are in soft reset, he can deduce we are
  in reset, while the opposite is not correct and might be misleading.

- Both these flags are changed together so they must be changed
  inside the reset info spinlock.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 4391eb22ddb8..5bc291c11e9b 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1346,7 +1346,14 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 			spin_unlock(&hdev->reset_info.lock);
 			return 0;
 		}
+
+		/* This still allows the completion of some KDMA ops
+		 * Update this before in_reset because is_in_soft_reset implies we are in reset
+		 */
+		hdev->reset_info.is_in_soft_reset = !hard_reset;
+
 		hdev->reset_info.in_reset = 1;
+
 		spin_unlock(&hdev->reset_info.lock);
 
 		if (delay_reset)
@@ -1354,9 +1361,6 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 		handle_reset_trigger(hdev, flags);
 
-		/* This still allows the completion of some KDMA ops */
-		hdev->reset_info.is_in_soft_reset = !hard_reset;
-
 		/* This also blocks future CS/VM/JOB completion operations */
 		hdev->disabled = true;
 
@@ -1565,7 +1569,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	}
 
 	spin_lock(&hdev->reset_info.lock);
-	hdev->reset_info.is_in_soft_reset = false;
+	hdev->reset_info.is_in_soft_reset = 0;
 
 	/* Schedule hard reset only if requested and if not already in hard reset.
 	 * We keep 'in_reset' enabled, so no other reset can go in during the hard
@@ -1612,18 +1616,22 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 out_err:
 	hdev->disabled = true;
-	hdev->reset_info.is_in_soft_reset = false;
+
+	spin_lock(&hdev->reset_info.lock);
+	hdev->reset_info.is_in_soft_reset = 0;
 
 	if (hard_reset) {
 		dev_err(hdev->dev, "Failed to reset! Device is NOT usable\n");
 		hdev->reset_info.hard_reset_cnt++;
 	} else if (reset_upon_device_release) {
+		spin_unlock(&hdev->reset_info.lock);
 		dev_err(hdev->dev, "Failed to reset device after user release\n");
 		flags |= HL_DRV_RESET_HARD;
 		flags &= ~HL_DRV_RESET_DEV_RELEASE;
 		hard_reset = true;
 		goto again;
 	} else {
+		spin_unlock(&hdev->reset_info.lock);
 		dev_err(hdev->dev, "Failed to do soft-reset\n");
 		hdev->reset_info.soft_reset_cnt++;
 		flags |= HL_DRV_RESET_HARD;
@@ -1633,6 +1641,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 	hdev->reset_info.in_reset = 0;
 
+	spin_unlock(&hdev->reset_info.lock);
+
 	return rc;
 }
 
-- 
2.25.1

