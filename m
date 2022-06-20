Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB4551AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbiFTNOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344243AbiFTNKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30229186C0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:05:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B482F6153E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A258C341C5;
        Mon, 20 Jun 2022 13:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730293;
        bh=pQCrwYxLiFuvYAKz3WMA+wGM23oV7udwWsD3Zxlu0Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHRB5CUXC2URrm5dqaqcthw++mysb1rmSbo1X5q+jEgpGjiUEWOTMhFQk8WJLMmSi
         qtK2c+GBtDiLB4Fxf8hJgwki8iq5bYJx0oVCc++U1mUA+64woEEqYJtxyl2IilWwmn
         pWFKMzvX9pZ3D8DoM9Wcq2GGJRhgTOtbYAtzLiYW4gO9sWfiuKtgH01RD+3pWPjB2+
         z9ncQ4USiENHPaqraybTujzxGf9ZkLg5ZJP8WkZ8wNM/kYqCKtleWn6iJrKkG3wbMg
         XVUah3MwzljqRBDytzaFXvZXz60bAne5xujbI+iThg/GhCFNz62KSzsL4QG8iYUVb2
         yiQCtTbShtccg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 12/17] habanalabs/gaudi: notify user process on device unavailable
Date:   Mon, 20 Jun 2022 16:04:27 +0300
Message-Id: <20220620130432.1180451-12-ogabbay@kernel.org>
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

When a device error occurs, user process would like to get some
indication on the error by reading some device HW info. If the
device is unavailable, user process can't perform any HW device
reading.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c |  5 ++++-
 include/uapi/misc/habanalabs.h        | 12 +++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1156ec7dacc1..939d2636b9ed 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8063,7 +8063,10 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 
 	if (hdev->asic_prop.fw_security_enabled && !reset_direct) {
 		flags = HL_DRV_RESET_HARD | HL_DRV_RESET_BYPASS_REQ_TO_FW | fw_fatal_err_flag;
-		event_mask |= HL_NOTIFIER_EVENT_DEVICE_RESET;
+
+		/* notify on device unavailable while the reset triggered by fw */
+		event_mask |= (HL_NOTIFIER_EVENT_DEVICE_RESET |
+					HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE);
 	} else if (hdev->hard_reset_on_fw_events) {
 		flags = HL_DRV_RESET_HARD | HL_DRV_RESET_DELAY | fw_fatal_err_flag;
 		event_mask |= HL_NOTIFIER_EVENT_DEVICE_RESET;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 18f86d259421..78aecea4684d 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1432,15 +1432,17 @@ struct hl_debug_args {
 /*
  * Notifier event values - for the notification mechanism and the HL_INFO_GET_EVENTS command
  *
- * HL_NOTIFIER_EVENT_TPC_ASSERT       - Indicates TPC assert event
- * HL_NOTIFIER_EVENT_UNDEFINED_OPCODE - Indicates undefined operation code
- * HL_NOTIFIER_EVENT_DEVICE_RESET     - Indicates device requires a reset
- * HL_NOTIFIER_EVENT_CS_TIMEOUT       - Indicates CS timeout error
+ * HL_NOTIFIER_EVENT_TPC_ASSERT		- Indicates TPC assert event
+ * HL_NOTIFIER_EVENT_UNDEFINED_OPCODE	- Indicates undefined operation code
+ * HL_NOTIFIER_EVENT_DEVICE_RESET	- Indicates device requires a reset
+ * HL_NOTIFIER_EVENT_CS_TIMEOUT		- Indicates CS timeout error
+ * HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE	- Indicates device is unavailable
  */
 #define HL_NOTIFIER_EVENT_TPC_ASSERT		(1ULL << 0)
 #define HL_NOTIFIER_EVENT_UNDEFINED_OPCODE	(1ULL << 1)
 #define HL_NOTIFIER_EVENT_DEVICE_RESET		(1ULL << 2)
-#define HL_NOTIFIER_EVENT_CS_TIMEOUT            (1ULL << 3)
+#define HL_NOTIFIER_EVENT_CS_TIMEOUT		(1ULL << 3)
+#define HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE	(1ULL << 4)
 
 /*
  * Various information operations such as:
-- 
2.25.1

