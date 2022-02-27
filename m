Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18A4C5ABA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiB0Lvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiB0Lvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:51:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A7038DBF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 03:50:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FA1660E83
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 11:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E4DC340E9;
        Sun, 27 Feb 2022 11:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645962658;
        bh=1HJAIqgYBkb1uG2L18Qyd/mg7/n9jJfHv7Eg6fYejFU=;
        h=From:To:Cc:Subject:Date:From;
        b=bhGybBKSM7lzpqCD/79sVSJMZphP/475xWMRhfG+2+e0yXwsh7zywTNMASvNcwRzd
         LAZMrfrsyFJuflXNeHV5Zye4w7iEL0QpWRZObecMz0KTIdOmcLGDgdxwfrtCfPk17s
         y8NSshIbR+4Otj/xtZAXLb8M7ggpcgp5P7E4dIBvBcUU7PucsgaSPXa9QngoHtsZq9
         xm7aM4XM5FBpql4BLnPdv0eGJ+S7fJEayGRJL32Cz72S8+HTfKdugB/Nejror0Ymtb
         nr59YoAv47mIwZON5O9ojdb4eJc07QBboswHp3+fSepTExEg3htsxuBWwrgYv6OucA
         pQpyLxwIpTg8Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH v2] habanalabs: add an option to delay a device reset
Date:   Sun, 27 Feb 2022 13:50:53 +0200
Message-Id: <20220227115053.1067361-1-ogabbay@kernel.org>
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
Changes in v2:
 - fix bug of using logical &&. Replace to bit-wise &

 drivers/misc/habanalabs/common/device.c     | 8 +++++++-
 drivers/misc/habanalabs/common/habanalabs.h | 4 ++++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index d52381d1fbd2..dc9341a64541 100644
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
+	delay_reset = !!(flags & HL_DRV_RESET_DELAY);
 
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

