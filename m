Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A652A47F6CB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 13:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhLZMnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 07:43:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37174 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhLZMnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 07:43:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEBE7B808CF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 12:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD42C36AEC;
        Sun, 26 Dec 2021 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640522594;
        bh=eW7mkUx3Qr/TVbTslxjth9DjPb8HYEdgAFPSkQzpl0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgW29+gQGy16xiCaccTktMR3p2FbIax34dUlTI3hLSkI29M+TvRfViiGJ82HydfzV
         Wv2sbuYKLGVuUtpL4vSSqIFhhSxb8DSwplj+ZmebzhlUE4StQhMwSe7ubZd1rNB6ho
         0n2TLuMj7nubQ/Xih+6imvXnnpRevabrTU+V+lRwyVxYlF7E8iacFyq6IROlvr7rTA
         JRgAVflJb66eKLQtflGztYldaejfw+DLWeE1kIMRF9e/Gz4IELMGaxeUL7KFuLzGLQ
         ReSGr16xBxbruEXIKKfMMlsBSfIMDHuAMfpa1TUFlFr0dGBnpMnC496PLjDIJDqUkx
         a0K4nI8NL6iIw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 5/5] habanalabs: support hard-reset scheduling during soft-reset
Date:   Sun, 26 Dec 2021 14:43:04 +0200
Message-Id: <20211226124304.237107-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211226124304.237107-1-ogabbay@kernel.org>
References: <20211226124304.237107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As hard-reset can be requested during soft-reset, driver must allow
it or else critical events received during soft-reset will be
ignored.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 31 +++++++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h |  3 ++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 84621ad765bc..733338ab6f1d 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -978,7 +978,7 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
 int hl_device_reset(struct hl_device *hdev, u32 flags)
 {
 	bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false,
-								reset_upon_device_release = false;
+			reset_upon_device_release = false, schedule_hard_reset = false;
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
 	struct hl_ctx *ctx;
 	int i, rc;
@@ -1031,6 +1031,9 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		/* Block future CS/VM/JOB completion operations */
 		spin_lock(&hdev->reset_info.lock);
 		if (hdev->reset_info.in_reset) {
+			/* We only allow scheduling of a hard reset during soft reset */
+			if (hard_reset && hdev->reset_info.is_in_soft_reset)
+				hdev->reset_info.hard_reset_schedule_flags = flags;
 			spin_unlock(&hdev->reset_info.lock);
 			return 0;
 		}
@@ -1193,7 +1196,6 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	 * is required for the initialization itself
 	 */
 	hdev->disabled = false;
-	hdev->reset_info.is_in_soft_reset = false;
 
 	rc = hdev->asic_funcs->hw_init(hdev);
 	if (rc) {
@@ -1243,7 +1245,20 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		}
 	}
 
-	hdev->reset_info.in_reset = 0;
+	spin_lock(&hdev->reset_info.lock);
+	hdev->reset_info.is_in_soft_reset = false;
+
+	/* Schedule hard reset only if requested and if not already in hard reset.
+	 * We keep 'in_reset' enabled, so no other reset can go in during the hard
+	 * reset schedule
+	 */
+	if (!hard_reset && hdev->reset_info.hard_reset_schedule_flags)
+		schedule_hard_reset = true;
+	else
+		hdev->reset_info.in_reset = 0;
+
+	spin_unlock(&hdev->reset_info.lock);
+
 	hdev->reset_info.needs_reset = false;
 
 	dev_notice(hdev->dev, "Successfully finished resetting the device\n");
@@ -1261,6 +1276,16 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		hdev->reset_info.soft_reset_cnt++;
 	}
 
+	if (schedule_hard_reset) {
+		dev_info(hdev->dev, "Performing hard reset scheduled during soft reset\n");
+		flags = hdev->reset_info.hard_reset_schedule_flags;
+		hdev->reset_info.hard_reset_schedule_flags = 0;
+		hdev->disabled = true;
+		hard_reset = true;
+		handle_reset_trigger(hdev, flags);
+		goto again;
+	}
+
 	return 0;
 
 out_err:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 37a3a469b42f..cb710fd478b6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2460,6 +2460,8 @@ struct last_error_session_info {
  * @lock: lock to protect critical reset flows.
  * @soft_reset_cnt: number of soft reset since the driver was loaded.
  * @hard_reset_cnt: number of hard reset since the driver was loaded.
+ * @hard_reset_schedule_flags: hard reset is scheduled to after current soft reset,
+ *                             here we hold the hard reset flags.
  * @in_reset: is device in reset flow.
  * @is_in_soft_reset: Device is currently in soft reset process.
  * @needs_reset: true if reset_on_lockup is false and device should be reset
@@ -2478,6 +2480,7 @@ struct hl_reset_info {
 	spinlock_t	lock;
 	u32		soft_reset_cnt;
 	u32		hard_reset_cnt;
+	u32		hard_reset_schedule_flags;
 	u8		in_reset;
 	u8		is_in_soft_reset;
 	u8		needs_reset;
-- 
2.25.1

