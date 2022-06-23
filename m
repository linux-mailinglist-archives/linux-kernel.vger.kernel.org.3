Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD32558A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiFWUms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiFWUm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:42:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FDD62725
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E1CAB82553
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F25EC341C6;
        Thu, 23 Jun 2022 20:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656016946;
        bh=dGD1jXJ0VCSn7GSAwGqQtjkyrM8lswHVwi3kN9wNSR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpcsYYDs7Za3RQfNaZGZ0zzcmnYPdwLBuZjVsvfSvbUeXCzIJ3T4n+jKNFIZNfNOP
         Lsu9OFoIz/bBp8Cye/fI4oULLLxwceRpMeg5wZql21O0ytNBhQwgqG1XsASmqh31CG
         fSGupJ49qogz2OPsFx7+9RR4CO6+NX18+4HBl7q4I8EQ+GhlaZZG/hf2kB//otiITS
         0vEDzYHIkMs79IKFY8zC6/EUJhCW4FrHvFg87TnkdWR1AG2WXlFu3vGiQBetgwqtjf
         zF3XZ2lJduN4QSMHW+ZmcWEVx+YLd5oGrVbASBoA6EhDdBLlyYGNlmI7rtJVvI5qY3
         aHQqO9TDEVrEA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 8/9] habanalabs: move call to scrub_device_mem after ctx_fini
Date:   Thu, 23 Jun 2022 23:42:11 +0300
Message-Id: <20220623204212.1628709-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623204212.1628709-1-ogabbay@kernel.org>
References: <20220623204212.1628709-1-ogabbay@kernel.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

In future ASICs, it would be possible to have a non-idle
device when context is released. We thus need to postpone the
scrubbing. Postpone it to hpriv release if reset is not executed
or to device late init if reset is executed.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c |  3 ---
 drivers/misc/habanalabs/common/device.c  | 16 ++++++++++++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 60e3e3125fbc..a69c14405f41 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -106,9 +106,6 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		hl_vm_ctx_fini(ctx);
 		hl_asid_free(hdev, ctx->asid);
 		hl_encaps_sig_mgr_fini(hdev, &ctx->sig_mgr);
-
-		/* Scrub both SRAM and DRAM */
-		hdev->asic_funcs->scrub_device_mem(hdev);
 	} else {
 		dev_dbg(hdev->dev, "closing kernel context\n");
 		hdev->asic_funcs->ctx_fini(ctx);
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 0f804ecb6caa..1a4f3eb941a9 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -272,9 +272,15 @@ static void hpriv_release(struct kref *ref)
 	list_del(&hpriv->dev_node);
 	mutex_unlock(&hdev->fpriv_list_lock);
 
-	if ((hdev->reset_if_device_not_idle && !device_is_idle)
-			|| hdev->reset_upon_device_release)
+	if ((hdev->reset_if_device_not_idle && !device_is_idle) ||
+		hdev->reset_upon_device_release) {
 		hl_device_reset(hdev, HL_DRV_RESET_DEV_RELEASE);
+	} else {
+		int rc = hdev->asic_funcs->scrub_device_mem(hdev);
+
+		if (rc)
+			dev_err(hdev->dev, "failed to scrub memory from hpriv release (%d)\n", rc);
+	}
 
 	/* Now we can mark the compute_ctx as not active. Even if a reset is running in a different
 	 * thread, we don't care because the in_reset is marked so if a user will try to open
@@ -1459,6 +1465,12 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		}
 	}
 
+	rc = hdev->asic_funcs->scrub_device_mem(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "scrub mem failed from device reset (%d)\n", rc);
+		return rc;
+	}
+
 	spin_lock(&hdev->reset_info.lock);
 	hdev->reset_info.is_in_soft_reset = false;
 
-- 
2.25.1

