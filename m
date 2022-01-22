Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B720496DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiAVT7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiAVT6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077D6C061760
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:58:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83C73CE0AB0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C15EC340E5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881491;
        bh=6x3ALbGrGPBwWxr60ShqjcwQkUpIzPhrk/IGXQsDVFA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mcVJJszdefGf8wVKYsFQ8m/WA3zofPDRQI8TjmKrDgDmeTlKb69LmJ/E+MXic6vI9
         tQYfmTx/IgrBAE9S6gpiBA4MNLMzugVOI8kOKY87OEXtWXLK4e9XoyUFsCTeCWrJeg
         xHYZkerGF6Hs0RnxooZ32qoxC6PWHdH+EZu1FtnKmA1zZsj06dk2mNSa1LZ3dknjnG
         mGUJkqhfjXn+WyuwhgJE7pzUbrVEc7hgs+36G41OuDUj3S/KXXOPBp5lGBCWfUKj1i
         +rzSunGbmb1qrnyfQPe2IphugpSCqS+vlJTF6zqV7qjaBgsJNKS4hc4giDA03tFzhS
         tl48MxsCaOlQg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 27/30] habanalabs: fix user interrupt wait when timeout is 0
Date:   Sat, 22 Jan 2022 21:57:28 +0200
Message-Id: <20220122195731.934494-27-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When timeout is 0, we need to return the busy status in case the
target value wasn't reached upon entry to the ioctl.

Also return the correct timestamp.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 0f41c283082c..2b27ff826e3c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2867,8 +2867,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				struct hl_cb_mgr *cb_mgr, u64 timeout_us,
 				u64 cq_counters_handle,	u64 cq_counters_offset,
 				u64 target_value, struct hl_user_interrupt *interrupt,
-				u32 *status,
-				u64 *timestamp)
+				u32 *status, u64 *timestamp)
 {
 	struct hl_user_pending_interrupt *pend;
 	unsigned long timeout, flags;
@@ -2909,10 +2908,13 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		*status = HL_WAIT_CS_STATUS_COMPLETED;
 		/* There was no interrupt, we assume the completion is now. */
 		pend->fence.timestamp = ktime_get();
-	}
+		goto set_timestamp;
 
-	if (!timeout_us || (*status == HL_WAIT_CS_STATUS_COMPLETED))
+	} else if (!timeout_us) {
+		*status = HL_WAIT_CS_STATUS_BUSY;
+		pend->fence.timestamp = ktime_get();
 		goto set_timestamp;
+	}
 
 	/* Add pending user interrupt to relevant list for the interrupt
 	 * handler to monitor
-- 
2.25.1

