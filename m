Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E370A496DD2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiAVT7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbiAVT6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D5C06176A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:58:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2328460E04
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A371AC340E4;
        Sat, 22 Jan 2022 19:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881494;
        bh=cyzVm38DQy6kiGrsedFR7m0VmkBXxeobu+7fnTLiScs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgY5YQlEK+poOJDtj9Ftc6N6Sf4fpgw3qBKpnnnDVsVjNIvJfk7hbNXcr69uPWQlN
         Hw7PQqoq7CdKC2fmiXX+uDaRRCUEMRD8Hd9jE0DHG+XqEPc9N84JtKtw2Cx7FtOvYr
         O0lEy2lLBVKrUmIrJBWuZCfTnaHTBBos8xHSki/SWxNE5+xUTAfcJ/ASnQ8TbFTPf5
         2f0D6z7uOdECqoDr7SCEQwc5qczLcqQjHoeTWbmH14tyrMbDlOisbF4LPt3XSNe/hj
         tztY/zXjmRF2qwHVeBMeA1an9Ap0gq8uMi4xDRrXpMMD8dlF9/Zs0RzByLHNZl8W5j
         lgE/LdNAQeJkg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 29/30] habanalabs: prevent false heartbeat failure during soft-reset
Date:   Sat, 22 Jan 2022 21:57:30 +0200
Message-Id: <20220122195731.934494-29-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The heartbeat thread is active during soft-reset, and it tries to send
messages to CPU-CP core.
Within the soft-reset, in the time window in which the device is marked
as disabled, any CPU-CP command is "silently" skipped and a success
value it returned.
However, in addition to the return value, the heartbeat function also
checks the F/W result, but because no command is sent in this time
window, the result variable won't hold the expected value and we will
have a false heartbeat failure.

To avoid it, modify the "silent" skip to be done only in hard-reset.
The CPU-CP should be able to handle messages during soft-reset.

In addition to the heartbeat problem, this should also solve other
issues in other flows that send messages during soft-reset and use the
F/W result as it w/o being aware to the reset.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 39de9d86ee6c..11957d36c6a9 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -214,7 +214,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 	dma_addr_t pkt_dma_addr;
 	struct hl_bd *sent_bd;
 	u32 tmp, expected_ack_val, pi;
-	int rc = 0;
+	int rc;
 
 	pkt = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev, len,
 								&pkt_dma_addr);
@@ -228,8 +228,11 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 
 	mutex_lock(&hdev->send_cpu_message_lock);
 
-	if (hdev->disabled)
+	/* CPU-CP messages can be sent during soft-reset */
+	if (hdev->disabled && !hdev->reset_info.is_in_soft_reset) {
+		rc = 0;
 		goto out;
+	}
 
 	if (hdev->device_cpu_disabled) {
 		rc = -EIO;
-- 
2.25.1

