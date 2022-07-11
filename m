Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B4056D4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiGKGam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGKGaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63A8BCA8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D87E611E0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2EBC3411C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657521020;
        bh=l2bGUdXWv5OCccOqmvxvTEkgHR6GbIt7bogASXuKEyo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bQB6NnXg/lSA6ZssQ1Yf+Xd00SSlIS7NcUQ6qXdYN2fHT5heUYd/paSlwZCW7GxH/
         8EACWatGcohgOF8oUwhWG+D08UY3GyAcUJYeTSThRR5f/HoQGrUKxymf8aqdtseSvi
         L7sWKmLEROC3uWIzAKUzpa6003yYjXE4GaZcMFDUiCafP97bO9oiLFv0/xQxvR4QoB
         +HQR/+AS7Gz9VOnguU+9bC427iq89z79XY9YQ/a0x98IV28kqxmAGCML4okBVUydXn
         txVUaz9Zicf7pYmw4++JExmuxK4wKt7qKI0A273f+xxTW87o6OFc5Rc0/rCfnHpHNw
         K2oYcFsUQ5O1Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] habanalabs: add status of reset after device release
Date:   Mon, 11 Jul 2022 09:30:01 +0300
Message-Id: <20220711063003.3182795-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711063003.3182795-1-ogabbay@kernel.org>
References: <20220711063003.3182795-1-ogabbay@kernel.org>
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

The user might want to know the device is in reset after device
release, which is not an erroneous event as a regular reset.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c         | 17 +++++++++++------
 drivers/misc/habanalabs/common/habanalabs_drv.c |  6 +++++-
 include/uapi/misc/habanalabs.h                  |  5 ++++-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 5bc291c11e9b..19c049046383 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -271,16 +271,20 @@ enum hl_device_status hl_device_status(struct hl_device *hdev)
 {
 	enum hl_device_status status;
 
-	if (hdev->reset_info.in_reset)
-		status = HL_DEVICE_STATUS_IN_RESET;
-	else if (hdev->reset_info.needs_reset)
+	if (hdev->reset_info.in_reset) {
+		if (hdev->reset_info.is_in_soft_reset)
+			status = HL_DEVICE_STATUS_IN_RESET_AFTER_DEVICE_RELEASE;
+		else
+			status = HL_DEVICE_STATUS_IN_RESET;
+	} else if (hdev->reset_info.needs_reset) {
 		status = HL_DEVICE_STATUS_NEEDS_RESET;
-	else if (hdev->disabled)
+	} else if (hdev->disabled) {
 		status = HL_DEVICE_STATUS_MALFUNCTION;
-	else if (!hdev->init_done)
+	} else if (!hdev->init_done) {
 		status = HL_DEVICE_STATUS_IN_DEVICE_CREATION;
-	else
+	} else {
 		status = HL_DEVICE_STATUS_OPERATIONAL;
+	}
 
 	return status;
 }
@@ -296,6 +300,7 @@ bool hl_device_operational(struct hl_device *hdev,
 
 	switch (current_status) {
 	case HL_DEVICE_STATUS_IN_RESET:
+	case HL_DEVICE_STATUS_IN_RESET_AFTER_DEVICE_RELEASE:
 	case HL_DEVICE_STATUS_MALFUNCTION:
 	case HL_DEVICE_STATUS_NEEDS_RESET:
 		return false;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index d900bae86168..f733ead605e7 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -165,7 +165,8 @@ int hl_device_open(struct inode *inode, struct file *filp)
 			"Can't open %s because it is %s\n",
 			dev_name(hdev->dev), hdev->status[status]);
 
-		if (status == HL_DEVICE_STATUS_IN_RESET)
+		if (status == HL_DEVICE_STATUS_IN_RESET ||
+					status == HL_DEVICE_STATUS_IN_RESET_AFTER_DEVICE_RELEASE)
 			rc = -EAGAIN;
 		else
 			rc = -EPERM;
@@ -395,6 +396,9 @@ static int create_hdev(struct hl_device **dev, struct pci_dev *pdev)
 	strncpy(hdev->status[HL_DEVICE_STATUS_NEEDS_RESET], "needs reset", HL_STR_MAX);
 	strncpy(hdev->status[HL_DEVICE_STATUS_IN_DEVICE_CREATION],
 					"in device creation", HL_STR_MAX);
+	strncpy(hdev->status[HL_DEVICE_STATUS_IN_RESET_AFTER_DEVICE_RELEASE],
+					"in reset after device release", HL_STR_MAX);
+
 
 	/* First, we must find out which ASIC are we handling. This is needed
 	 * to configure the behavior of the driver (kernel parameters)
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 8c6ab71e7831..5d06d5c74dd1 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -684,6 +684,8 @@ enum hl_goya_dma_direction {
  * @HL_DEVICE_STATUS_NEEDS_RESET: Device needs reset because auto reset was disabled.
  * @HL_DEVICE_STATUS_IN_DEVICE_CREATION: Device is operational but its creation is still in
  *                                       progress.
+ * @HL_DEVICE_STATUS_IN_RESET_AFTER_DEVICE_RELEASE: Device is currently during reset that was
+ *                                                  triggered because the user released the device
  * @HL_DEVICE_STATUS_LAST: Last status.
  */
 enum hl_device_status {
@@ -692,7 +694,8 @@ enum hl_device_status {
 	HL_DEVICE_STATUS_MALFUNCTION,
 	HL_DEVICE_STATUS_NEEDS_RESET,
 	HL_DEVICE_STATUS_IN_DEVICE_CREATION,
-	HL_DEVICE_STATUS_LAST = HL_DEVICE_STATUS_IN_DEVICE_CREATION
+	HL_DEVICE_STATUS_IN_RESET_AFTER_DEVICE_RELEASE,
+	HL_DEVICE_STATUS_LAST = HL_DEVICE_STATUS_IN_RESET_AFTER_DEVICE_RELEASE
 };
 
 enum hl_server_type {
-- 
2.25.1

