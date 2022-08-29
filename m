Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49055A45FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiH2JXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiH2JXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:23:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6D95A8AB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F185560F9E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81115C433D6;
        Mon, 29 Aug 2022 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661764985;
        bh=3IJumO9VnNtaTpGxXYYQba7A8+do7X/gIE6+XfMnLiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLR3usUKj19KPV6pAq55LQjhMdgaL2YxoeHPWJq5IjCX3VbTeFqekNoiw39laK1li
         wz3zrIyrmgHrzswBIJZhBxe17hDSJFU/Qnstecea2fFz+FPpML3bp9Cj5nypZDQsUa
         NyvEoYWQKmcCnEzLpqZ1Yq+WN18F++YqgjrmFMerDmDhSolzc9EEufk6Q5H+OHKeRL
         4xdmg09Y5NX/5QqJQgef5v+FLseS/tLkGQS9D7R+TCHtWDVZGwJKq6z7qAWizgUdyD
         R9DAS0PChMc31Qj1whLZwKLRtSjaYigOYOgwWsZosWZw5WNUiQsf/bPnKq4mvw6JWt
         GRyto/YNp9UtA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 5/7] habanalabs: allow control device open during reset
Date:   Mon, 29 Aug 2022 12:22:52 +0300
Message-Id: <20220829092254.930753-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829092254.930753-1-ogabbay@kernel.org>
References: <20220829092254.930753-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Monitoring apps would like to query device state at any time so we
should allow it also during reset because it doesn't involve
accessing the h/w.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       | 22 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  2 ++
 .../misc/habanalabs/common/habanalabs_drv.c   |  4 ++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 230b7eeef962..ea6238e614f1 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -352,6 +352,28 @@ bool hl_device_operational(struct hl_device *hdev,
 	}
 }
 
+bool hl_ctrl_device_operational(struct hl_device *hdev,
+		enum hl_device_status *status)
+{
+	enum hl_device_status current_status;
+
+	current_status = hl_device_status(hdev);
+	if (status)
+		*status = current_status;
+
+	switch (current_status) {
+	case HL_DEVICE_STATUS_MALFUNCTION:
+		return false;
+	case HL_DEVICE_STATUS_IN_RESET:
+	case HL_DEVICE_STATUS_IN_RESET_AFTER_DEVICE_RELEASE:
+	case HL_DEVICE_STATUS_NEEDS_RESET:
+	case HL_DEVICE_STATUS_OPERATIONAL:
+	case HL_DEVICE_STATUS_IN_DEVICE_CREATION:
+	default:
+		return true;
+	}
+}
+
 static void hpriv_release(struct kref *ref)
 {
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 33c6476b60a9..cf9cbbd09063 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3486,6 +3486,8 @@ int hl_device_open(struct inode *inode, struct file *filp);
 int hl_device_open_ctrl(struct inode *inode, struct file *filp);
 bool hl_device_operational(struct hl_device *hdev,
 		enum hl_device_status *status);
+bool hl_ctrl_device_operational(struct hl_device *hdev,
+		enum hl_device_status *status);
 enum hl_device_status hl_device_status(struct hl_device *hdev);
 int hl_device_set_debug_mode(struct hl_device *hdev, struct hl_ctx *ctx, bool enable);
 int hl_hw_queues_create(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index e12148428731..7bf0dc245d39 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -268,9 +268,9 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 
 	mutex_lock(&hdev->fpriv_ctrl_list_lock);
 
-	if (!hl_device_operational(hdev, NULL)) {
+	if (!hl_ctrl_device_operational(hdev, NULL)) {
 		dev_err_ratelimited(hdev->dev_ctrl,
-			"Can't open %s because it is disabled or in reset\n",
+			"Can't open %s because it is disabled\n",
 			dev_name(hdev->dev_ctrl));
 		rc = -EPERM;
 		goto out_err;
-- 
2.25.1

