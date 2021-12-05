Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77F468BF4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhLEPrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhLEPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:46:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F174C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:42:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D2E2B80E1A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB8FC00446;
        Sun,  5 Dec 2021 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638718961;
        bh=mVz86qxJJsxIyngvtQoYQe4V5iY7Ho/CQ0SDWZHDiyw=;
        h=From:To:Cc:Subject:Date:From;
        b=AmspzxLyH/YoBgUMyTUxAly/Qz1gtX1H4IVz3/V/GWr6Gmb1/CZTqk1N+ykcL1id4
         KrAiDl88nJEoGk8lR3Z44u089jeniV9SZjX18PK5BiDVxhCgeBCdwr4NLosx1zY5kp
         n1RvhLt0VPc4olxJK+lYquxnUgxRn8mUwzKETmWLnX3Y80gKKvp+2TEwStPatm1zJy
         dGNs7CYAqEzx7KX6xJYSgm+yhqimXB7nfDpTzMx8ZUrMb+R/rMm1cHL8XWzcArRcDp
         cFXYBXMuu9hsK2u+aN8Oi5hQJpbtKspO/mL4ykHqVfgpC9n0TfDPh3/Btp0V0jgpqx
         1w+YQBF4/xunw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 1/9] habanalabs: pass reset flags to reset thread
Date:   Sun,  5 Dec 2021 17:42:28 +0200
Message-Id: <20211205154236.2198481-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The reset flags used by the reset thread are currently a mix of
hard-coded values and a specific flag which is passed from the context
that initiates the reset.
To make it easier to pass more flags in future from this context to the
reset thread, modify it to pass all the original reset flags to the
thread.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 10 +++-------
 drivers/misc/habanalabs/common/habanalabs.h |  4 ++--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 720eea0b7e9c..db4168f35c18 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -324,16 +324,12 @@ static void device_cdev_sysfs_del(struct hl_device *hdev)
 static void device_hard_reset_pending(struct work_struct *work)
 {
 	struct hl_device_reset_work *device_reset_work =
-		container_of(work, struct hl_device_reset_work,
-				reset_work.work);
+		container_of(work, struct hl_device_reset_work, reset_work.work);
 	struct hl_device *hdev = device_reset_work->hdev;
 	u32 flags;
 	int rc;
 
-	flags = HL_DRV_RESET_HARD | HL_DRV_RESET_FROM_RESET_THR;
-
-	if (device_reset_work->fw_reset)
-		flags |= HL_DRV_RESET_BYPASS_REQ_TO_FW;
+	flags = device_reset_work->flags | HL_DRV_RESET_FROM_RESET_THR;
 
 	rc = hl_device_reset(hdev, flags);
 	if ((rc == -EBUSY) && !hdev->device_fini_pending) {
@@ -1040,7 +1036,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 		hdev->process_kill_trial_cnt = 0;
 
-		hdev->device_reset_work.fw_reset = fw_reset;
+		hdev->device_reset_work.flags = flags;
 
 		/*
 		 * Because the reset function can't run from heartbeat work,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 93d0a85265be..722fc8e69fd6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2214,13 +2214,13 @@ struct hwmon_chip_info;
  * @wq: work queue for device reset procedure.
  * @reset_work: reset work to be done.
  * @hdev: habanalabs device structure.
- * @fw_reset: whether f/w will do the reset without us sending them a message to do it.
+ * @flags: reset flags.
  */
 struct hl_device_reset_work {
 	struct workqueue_struct		*wq;
 	struct delayed_work		reset_work;
 	struct hl_device		*hdev;
-	bool				fw_reset;
+	u32				flags;
 };
 
 /**
-- 
2.25.1

