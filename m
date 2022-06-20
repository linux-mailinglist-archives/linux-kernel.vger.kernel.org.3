Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73311551CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbiFTNSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344470AbiFTNNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:13:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012B51EEFD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 29621CE1389
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884D2C341C5;
        Mon, 20 Jun 2022 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730284;
        bh=LIh5P9rurCKr+WxNDqQn/Fla3DTQIh1w7F2VfHAcU28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N93JXV3ImzapM0sI5AV3d7QUg64PHpBXdnAWKnvz7LBnVJbRCbVDi31wMjX/wvnAY
         Ag/JBPg66aEPuUrR9387uDO5HKPappI8zgPvZ1sStFv8UAWxPW2tNEFa7LngTw6M+x
         1Vu01PQhV2CVsxE2dHBpqkJZZprBajNZUQp0olMcNc+sD5VaVSiOMtj8dcxFHL/dHA
         yiSnO1p9Y41/RWJVBph+febOG0o0QonXNIhJXInZLwxVvA44LP8Z33YPdgLO7eruRf
         nd7EMCczFBPGEbTBti+3AWiqaWSDaexjpnszj70stNtbDagqJwCbUg4lZ8tuNyJQAV
         kIpY15nqbABXA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 05/17] habanalabs: send an event notification when CS timeout occurs
Date:   Mon, 20 Jun 2022 16:04:20 +0300
Message-Id: <20220620130432.1180451-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
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

From: Tal Cohen <talcohen@habana.ai>

The Driver needs to inform the User process whenever one of its
CS is timed out. The Driver shall recognize the CS timeout and shall
send an eventfd notification, towards user space, whenever a timeout
is expired on a CS.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 26 ++++++++++++-------
 include/uapi/misc/habanalabs.h                |  2 ++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 47b49cbf67ab..cbb7c29966ff 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -797,10 +797,11 @@ static void cs_do_release(struct kref *ref)
 static void cs_timedout(struct work_struct *work)
 {
 	struct hl_device *hdev;
+	u64 event_mask;
 	int rc;
 	struct hl_cs *cs = container_of(work, struct hl_cs,
 						 work_tdr.work);
-	bool skip_reset_on_timeout = cs->skip_reset_on_timeout;
+	bool skip_reset_on_timeout = cs->skip_reset_on_timeout, device_reset = false;
 
 	rc = cs_get_unless_zero(cs);
 	if (!rc)
@@ -811,9 +812,15 @@ static void cs_timedout(struct work_struct *work)
 		return;
 	}
 
-	/* Mark the CS is timed out so we won't try to cancel its TDR */
-	if (likely(!skip_reset_on_timeout))
+	if (likely(!skip_reset_on_timeout)) {
+		if (hdev->reset_on_lockup)
+			device_reset = true;
+		else
+			hdev->reset_info.needs_reset = true;
+
+		/* Mark the CS is timed out so we won't try to cancel its TDR */
 		cs->timedout = true;
+	}
 
 	hdev = cs->ctx->hdev;
 
@@ -822,6 +829,11 @@ static void cs_timedout(struct work_struct *work)
 	if (rc) {
 		hdev->last_error.cs_timeout.timestamp = ktime_get();
 		hdev->last_error.cs_timeout.seq = cs->sequence;
+
+		event_mask = device_reset ? (HL_NOTIFIER_EVENT_CS_TIMEOUT |
+				HL_NOTIFIER_EVENT_DEVICE_RESET) : HL_NOTIFIER_EVENT_CS_TIMEOUT;
+
+		hl_notifier_event_send_all(hdev, event_mask);
 	}
 
 	switch (cs->type) {
@@ -856,12 +868,8 @@ static void cs_timedout(struct work_struct *work)
 
 	cs_put(cs);
 
-	if (likely(!skip_reset_on_timeout)) {
-		if (hdev->reset_on_lockup)
-			hl_device_reset(hdev, HL_DRV_RESET_TDR);
-		else
-			hdev->reset_info.needs_reset = true;
-	}
+	if (device_reset)
+		hl_device_reset(hdev, HL_DRV_RESET_TDR);
 }
 
 static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 5f9a6097f5f3..18f86d259421 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1435,10 +1435,12 @@ struct hl_debug_args {
  * HL_NOTIFIER_EVENT_TPC_ASSERT       - Indicates TPC assert event
  * HL_NOTIFIER_EVENT_UNDEFINED_OPCODE - Indicates undefined operation code
  * HL_NOTIFIER_EVENT_DEVICE_RESET     - Indicates device requires a reset
+ * HL_NOTIFIER_EVENT_CS_TIMEOUT       - Indicates CS timeout error
  */
 #define HL_NOTIFIER_EVENT_TPC_ASSERT		(1ULL << 0)
 #define HL_NOTIFIER_EVENT_UNDEFINED_OPCODE	(1ULL << 1)
 #define HL_NOTIFIER_EVENT_DEVICE_RESET		(1ULL << 2)
+#define HL_NOTIFIER_EVENT_CS_TIMEOUT            (1ULL << 3)
 
 /*
  * Various information operations such as:
-- 
2.25.1

