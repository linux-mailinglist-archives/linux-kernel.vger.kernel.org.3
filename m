Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C77A4C5A48
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 10:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiB0JpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 04:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiB0JpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:45:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2876048337
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 01:44:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADD3CB80B30
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CD5C340E9;
        Sun, 27 Feb 2022 09:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645955075;
        bh=731TwFGrPC+/K47am47K7HtWat2IngcxyfC/vUPVg2E=;
        h=From:To:Cc:Subject:Date:From;
        b=NDuKvBqXfmHOBtOJYjKP1hyGb2IJ/f5jWkvG4/uIVURULKYLBcmOtbXYhbfnK5+3H
         LqlsEO6vnuQIkao+xN9FtK1Q/rQzhJvXy6RgmA1pes38v9e0PuNtR9qq6jgc5s03me
         ABnmh3o3xROsO2XCYEzGi+MUHuUjYIqb4E6cQ6IY817kKe1hGnNAba4ru9GKxZkYJL
         9bRnZazfjR5s/mgjCynqr0aLpKdMhAjWzLxjuS24+0KLC3QGGkEM9VgCy1ZpTsUGUv
         Li8ZZFUc6wcyXa7Ji3BAEyzpPRwA+143DFRIk1Efg1H4Z2/b2TMUX9m3UeWSF7+XqG
         ETYxfgJ7wdu4g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: add an option to delay a device reset
Date:   Sun, 27 Feb 2022 11:44:30 +0200
Message-Id: <20220227094430.1059796-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Several H/W events can be sent adjacently, even due to a single error.
If a hard-reset is triggered as part of handling one of these events,
the following events won't be handled.
The debug info from these missed events is important, sometimes even
more important than the one that was handled.

To allow handling these close events, add an option to delay a device
reset and use it when resetting due to H/W events.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 8 +++++++-
 drivers/misc/habanalabs/common/habanalabs.h | 4 ++++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index d52381d1fbd2..651326cd22fb 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -13,6 +13,8 @@
 #include <linux/pci.h>
 #include <linux/hwmon.h>
 
+#define HL_RESET_DELAY_USEC		10000	/* 10ms */
+
 enum hl_device_status hl_device_status(struct hl_device *hdev)
 {
 	enum hl_device_status status;
@@ -980,7 +982,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 {
 	bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false,
 			reset_upon_device_release = false, schedule_hard_reset = false,
-			skip_wq_flush = false;
+			skip_wq_flush, delay_reset;
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
 	struct hl_ctx *ctx;
 	int i, rc;
@@ -994,6 +996,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	from_hard_reset_thread = !!(flags & HL_DRV_RESET_FROM_RESET_THR);
 	fw_reset = !!(flags & HL_DRV_RESET_BYPASS_REQ_TO_FW);
 	skip_wq_flush = !!(flags & HL_DRV_RESET_DEV_RELEASE);
+	delay_reset = !!(flags && HL_DRV_RESET_DELAY);
 
 	if (!hard_reset && !hdev->asic_prop.supports_soft_reset) {
 		hard_instead_soft = true;
@@ -1043,6 +1046,9 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		hdev->reset_info.in_reset = 1;
 		spin_unlock(&hdev->reset_info.lock);
 
+		if (delay_reset)
+			usleep_range(HL_RESET_DELAY_USEC, HL_RESET_DELAY_USEC << 1);
+
 		handle_reset_trigger(hdev, flags);
 
 		/* This still allows the completion of some KDMA ops */
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index cef4717d0916..1edaf6ab67bd 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -142,6 +142,9 @@ enum hl_mmu_page_table_location {
  *
  * - HL_DRV_RESET_FW_FATAL_ERR
  *       Set if reset is due to a fatal error from FW
+ *
+ * - HL_DRV_RESET_DELAY
+ *       Set if a delay should be added before the reset
  */
 
 #define HL_DRV_RESET_HARD		(1 << 0)
@@ -151,6 +154,7 @@ enum hl_mmu_page_table_location {
 #define HL_DRV_RESET_DEV_RELEASE	(1 << 4)
 #define HL_DRV_RESET_BYPASS_REQ_TO_FW	(1 << 5)
 #define HL_DRV_RESET_FW_FATAL_ERR	(1 << 6)
+#define HL_DRV_RESET_DELAY		(1 << 7)
 
 #define HL_MAX_SOBS_PER_MONITOR	8
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 0eed0efae040..21c2b678ff72 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8199,7 +8199,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 					| HL_DRV_RESET_BYPASS_REQ_TO_FW
 					| fw_fatal_err_flag);
 	else if (hdev->hard_reset_on_fw_events)
-		hl_device_reset(hdev, HL_DRV_RESET_HARD | fw_fatal_err_flag);
+		hl_device_reset(hdev, HL_DRV_RESET_HARD | HL_DRV_RESET_DELAY | fw_fatal_err_flag);
 	else
 		hl_fw_unmask_irq(hdev, event_type);
 }
-- 
2.25.1

