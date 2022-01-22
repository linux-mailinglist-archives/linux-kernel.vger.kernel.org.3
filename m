Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388D3496DD3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiAVT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiAVT6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6B7C061768
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:58:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9BFDACE0AAD
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6793BC340E2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881493;
        bh=Qva+HIbiRH8n5YbTbSiMootSgT51S/uHMzMuw+y+s9k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kaooSMsNaUv17uBDJoZaZ91OOhU383/qVde8Y9ysODL9/TDtSnMzvaqOgZ4idTykb
         zHyi+dhd+THJwwz8ed/xTAcb1EK7t6SiV/ZLI5lmRISHf2KLKWoVrFLpJeU+1K0jtV
         63XG4XCmfPx3iXeziRE0EVdvHkg0UyVD7enN8v63F0KpjrFavhJpGXJ0r7q7kFuX6c
         ues3QT3qjI5y5A2jyNrCqU6N53Rfw9CwLNY1ZzEbUOlV4Kwx5C+EvksWJnxB4rl888
         MTqOxzcNELKSDY4/sYAooh2taXT2RaZQ8bd7JcBr0w8q2bbR5C+fNdiG6Ns7Ooj1H8
         yC1AC8HbaSfVA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 28/30] habanalabs: fix race between wait and irq
Date:   Sat, 22 Jan 2022 21:57:29 +0200
Message-Id: <20220122195731.934494-28-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race in the user interrupts code, where between checking
the target value and adding the new pend to the list, there is a chance
the interrupt happened.

In that case, no one will complete the node, and we will get a timeout
on it.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 2b27ff826e3c..3d9020825df5 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2901,16 +2901,21 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	pend->cq_kernel_addr = (u64 *) cb->kernel_address + cq_counters_offset;
 	pend->cq_target_value = target_value;
 
+	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
+
 	/* We check for completion value as interrupt could have been received
 	 * before we added the node to the wait list
 	 */
 	if (*pend->cq_kernel_addr >= target_value) {
+		spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
+
 		*status = HL_WAIT_CS_STATUS_COMPLETED;
 		/* There was no interrupt, we assume the completion is now. */
 		pend->fence.timestamp = ktime_get();
 		goto set_timestamp;
 
 	} else if (!timeout_us) {
+		spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 		*status = HL_WAIT_CS_STATUS_BUSY;
 		pend->fence.timestamp = ktime_get();
 		goto set_timestamp;
@@ -2919,7 +2924,6 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	/* Add pending user interrupt to relevant list for the interrupt
 	 * handler to monitor
 	 */
-	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
 	list_add_tail(&pend->wait_list_node, &interrupt->wait_list_head);
 	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 
-- 
2.25.1

