Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33B59B2C3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiHUI2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiHUI2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:28:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB01712AB2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EE7FB80064
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CF8C433D6;
        Sun, 21 Aug 2022 08:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661070508;
        bh=QPpJgZ36LPlIYnOj2O1JNITZU3NBr4yLvEC68Xpisno=;
        h=From:To:Cc:Subject:Date:From;
        b=PlCE5HQ8J4T0r+lOJ93CAGlvo3WRq9UPVU8wujLJ7i75HLf5fqF2y/GYybVdL9T2d
         OU8o4YV8e3Slnh8Ejhh0xDDWkFEVNltfP9tkqGGfiKuA1o2LAFh/0x3Lr6I5Px4V6t
         mwQd/K01XUEXRwXac9bXsN1fUOod1aoJ5rD1tTc8u2CTMmi4JtVRg7Jw4GdSpfyjLH
         ZzteydYampDQVN/t5bze2IpYtJINWs7/qdnXqJQhv2uYzKlve6WP5+VbCVwWOCN7ST
         WNZ1r0lnGqKKGHsF1zD/GrngCOgfVJzCfptGrpSfJsJtnXi+EZG3AvFM3Xsho2mQxc
         NbUQdGGdR7LCw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 1/5] habanalabs: add cdev index data member
Date:   Sun, 21 Aug 2022 11:28:19 +0300
Message-Id: <20220821082823.62846-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Omer Shpigelman <oshpigelman@habana.ai>

Instead of recalculating the cdev index, store it in a dedicated data
member. This data member is intended to be passed to other drivers using
the auxiliary bus infra and hence this new data member is necessary in
case that the calculation is changed in the future.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 10 ++++++----
 drivers/misc/habanalabs/common/habanalabs.h |  4 +++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index ab2497b6d164..b662d40f18e8 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1730,7 +1730,9 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	char *name;
 	bool add_cdev_sysfs_on_err = false;
 
-	name = kasprintf(GFP_KERNEL, "hl%d", hdev->id / 2);
+	hdev->cdev_idx = hdev->id / 2;
+
+	name = kasprintf(GFP_KERNEL, "hl%d", hdev->cdev_idx);
 	if (!name) {
 		rc = -ENOMEM;
 		goto out_disabled;
@@ -1745,7 +1747,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (rc)
 		goto out_disabled;
 
-	name = kasprintf(GFP_KERNEL, "hl_controlD%d", hdev->id / 2);
+	name = kasprintf(GFP_KERNEL, "hl_controlD%d", hdev->cdev_idx);
 	if (!name) {
 		rc = -ENOMEM;
 		goto free_dev;
@@ -2023,10 +2025,10 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (hdev->pdev)
 		dev_err(&hdev->pdev->dev,
 			"Failed to initialize hl%d. Device is NOT usable !\n",
-			hdev->id / 2);
+			hdev->cdev_idx);
 	else
 		pr_err("Failed to initialize hl%d. Device is NOT usable !\n",
-			hdev->id / 2);
+			hdev->cdev_idx);
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 237a887b3a43..a3c516c31b54 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3129,7 +3129,8 @@ struct hl_reset_info {
  * @edma_binning: contains mask of edma engines that is received from the f/w which
  *                   indicates which edma engines are binned-out
  * @id: device minor.
- * @id_control: minor of the control device
+ * @id_control: minor of the control device.
+ * @cdev_idx: char device index. Used for setting its name.
  * @cpu_pci_msb_addr: 50-bit extension bits for the device CPU's 40-bit
  *                    addresses.
  * @is_in_dram_scrub: true if dram scrub operation is on going.
@@ -3289,6 +3290,7 @@ struct hl_device {
 	u32				edma_binning;
 	u16				id;
 	u16				id_control;
+	u16				cdev_idx;
 	u16				cpu_pci_msb_addr;
 	u8				is_in_dram_scrub;
 	u8				disabled;
-- 
2.25.1

