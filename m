Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FBD58BB18
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiHGNzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiHGNzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:55:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9DA29F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8434960EE0
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89CAC433D6;
        Sun,  7 Aug 2022 13:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659880497;
        bh=XAa6xTO9WJhBAO+dvlr3NlPbzNmmj0s2OlhemfvVMs8=;
        h=From:To:Cc:Subject:Date:From;
        b=XTQXwJnhEz+M+JGTI/9k6Lg8QB82R1w04hwtjQ3rfqx3Otbwqy6Rfb1W87qoi4/Rm
         JJcgvHriMENU0eBw9W1umFHAi2BnUdeS6lzI0ogV9toaA2Kzvz8hFYJN1twRGqYc57
         XIsbUKNpZlS7EIJfSdTb94FeOhV3Ke1bAf+ZPyaNMBzEfoQo3FiHrga/pJ/ygCD886
         IEYa9ii7zIO3zzX5V8KqtYMjNLXp2KmoinTvN7VFOh06P5UTkLM0kz/egW9IxziwZE
         uwchp+whQdpWLgwXxGV/LIrMFxcWdfpHvNxjmV8Vdg0A+afyQ/Dh0su9OsixQ+4rGs
         GMcodSZ5qGOeQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 1/6] habanalabs/gaudi2: change device f/w security check
Date:   Sun,  7 Aug 2022 16:54:47 +0300
Message-Id: <20220807135452.1219894-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: farah kassabri <fkassabri@habana.ai>

On Gaudi2 the f/w always configures the PCIe iATU and allows access to
scratchpad registers. Therefore, we can know if the f/w is secured
by reading a status bit from the f/w registers.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c |  2 ++
 drivers/misc/habanalabs/gaudi2/gaudi2.c      | 21 ++++++--------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 58c1eff16df6..cbcb9442bdca 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1476,6 +1476,8 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 	 */
 	prop->hard_reset_done_by_fw = !!(cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN);
 
+	prop->fw_security_enabled = !!(cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_SECURITY_EN);
+
 	dev_dbg(hdev->dev, "Firmware preboot boot device status0 %#x\n",
 							cpu_boot_dev_sts0);
 
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 68ab407fa6ba..9ccde0258eca 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2493,7 +2493,6 @@ static int gaudi2_early_init(struct hl_device *hdev)
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct pci_dev *pdev = hdev->pdev;
 	resource_size_t pci_bar_size;
-	u32 fw_boot_status;
 	int rc;
 
 	rc = gaudi2_set_fixed_properties(hdev);
@@ -2521,22 +2520,14 @@ static int gaudi2_early_init(struct hl_device *hdev)
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DRAM_BAR_ID);
 	hdev->dram_pci_bar_start = pci_resource_start(pdev, DRAM_BAR_ID);
 
-	/* If FW security is enabled at this point it means no access to ELBI */
-	if (hdev->asic_prop.fw_security_enabled) {
-		hdev->asic_prop.iatu_done_by_fw = true;
-		goto pci_init;
-	}
-
-	rc = hl_pci_elbi_read(hdev, CFG_BASE + mmCPU_BOOT_DEV_STS0, &fw_boot_status);
-	if (rc)
-		goto free_queue_props;
-
-	/* Check whether FW is configuring iATU */
-	if ((fw_boot_status & CPU_BOOT_DEV_STS0_ENABLED) &&
-			(fw_boot_status & CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN))
+	/*
+	 * Only in pldm driver config iATU
+	 */
+	if (hdev->pldm)
+		hdev->asic_prop.iatu_done_by_fw = false;
+	else
 		hdev->asic_prop.iatu_done_by_fw = true;
 
-pci_init:
 	rc = hl_pci_init(hdev);
 	if (rc)
 		goto free_queue_props;
-- 
2.25.1

