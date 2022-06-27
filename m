Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE5155C1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiF0LmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbiF0Li7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:38:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BEBCB8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A1C160C9B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D5AC341C8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656329705;
        bh=lH+Rr3xY1iZWcq9hqNDqYG1yNxkxuwibTOC6oRon1rY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QPOH6tmVkPvXIwTxI4myytNrGnRJ6MRk7AvDT+MEapqDwdnnV20OdY7p0/CdYTsqo
         8X8qzmTYNWJlqKe2YpB1e2f72TrC/IaAUF4Bjhb7pbZyMjzxbkkIAR68P6b4w7hOeT
         3SKsMDwZa53AhduADsCHrdFB3UkgydMhSQSsSF56u7uFoa/lH6KoSItggvqd/TU0HV
         c/qcZpADFM5H3nl+f/kAuYdOZmMTOCYNiIQqWRwi7rr7dhJ1euNf8DE94FWrIW2299
         34EGlFiV5mCotVlYpeMTX4ot8Z86hJvxtswGDreuzulZdr+kdp0654bKoyz94ST03+
         GYonVHKnd8ahw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] habanalabs: use %pa to print pci bar size
Date:   Mon, 27 Jun 2022 14:34:59 +0300
Message-Id: <20220627113459.590125-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627113459.590125-1-ogabbay@kernel.org>
References: <20220627113459.590125-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI bar size is resource_size_t so we should use %pa to make it work
correctly on all architectures.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 25 +++++++++++--------------
 drivers/misc/habanalabs/goya/goya.c   | 25 +++++++++++--------------
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 05d9817985d9..8fa0b86ccb6b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -801,6 +801,7 @@ static int gaudi_early_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct pci_dev *pdev = hdev->pdev;
+	resource_size_t pci_bar_size;
 	u32 fw_boot_status;
 	int rc;
 
@@ -811,24 +812,20 @@ static int gaudi_early_init(struct hl_device *hdev)
 	}
 
 	/* Check BAR sizes */
-	if (pci_resource_len(pdev, SRAM_BAR_ID) != SRAM_BAR_SIZE) {
-		dev_err(hdev->dev,
-			"Not " HL_NAME "? BAR %d size %llu, expecting %llu\n",
-			SRAM_BAR_ID,
-			(unsigned long long) pci_resource_len(pdev,
-							SRAM_BAR_ID),
-			SRAM_BAR_SIZE);
+	pci_bar_size = pci_resource_len(pdev, SRAM_BAR_ID);
+
+	if (pci_bar_size != SRAM_BAR_SIZE) {
+		dev_err(hdev->dev, "Not " HL_NAME "? BAR %d size %pa, expecting %llu\n",
+			SRAM_BAR_ID, &pci_bar_size, SRAM_BAR_SIZE);
 		rc = -ENODEV;
 		goto free_queue_props;
 	}
 
-	if (pci_resource_len(pdev, CFG_BAR_ID) != CFG_BAR_SIZE) {
-		dev_err(hdev->dev,
-			"Not " HL_NAME "? BAR %d size %llu, expecting %llu\n",
-			CFG_BAR_ID,
-			(unsigned long long) pci_resource_len(pdev,
-								CFG_BAR_ID),
-			CFG_BAR_SIZE);
+	pci_bar_size = pci_resource_len(pdev, CFG_BAR_ID);
+
+	if (pci_bar_size != CFG_BAR_SIZE) {
+		dev_err(hdev->dev, "Not " HL_NAME "? BAR %d size %pa, expecting %llu\n",
+			CFG_BAR_ID, &pci_bar_size, CFG_BAR_SIZE);
 		rc = -ENODEV;
 		goto free_queue_props;
 	}
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 9bde01de4fcf..3255d2044c6c 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -608,6 +608,7 @@ static int goya_early_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct pci_dev *pdev = hdev->pdev;
+	resource_size_t pci_bar_size;
 	u32 fw_boot_status, val;
 	int rc;
 
@@ -618,24 +619,20 @@ static int goya_early_init(struct hl_device *hdev)
 	}
 
 	/* Check BAR sizes */
-	if (pci_resource_len(pdev, SRAM_CFG_BAR_ID) != CFG_BAR_SIZE) {
-		dev_err(hdev->dev,
-			"Not " HL_NAME "? BAR %d size %llu, expecting %llu\n",
-			SRAM_CFG_BAR_ID,
-			(unsigned long long) pci_resource_len(pdev,
-							SRAM_CFG_BAR_ID),
-			CFG_BAR_SIZE);
+	pci_bar_size = pci_resource_len(pdev, SRAM_CFG_BAR_ID);
+
+	if (pci_bar_size != CFG_BAR_SIZE) {
+		dev_err(hdev->dev, "Not " HL_NAME "? BAR %d size %pa, expecting %llu\n",
+			SRAM_CFG_BAR_ID, &pci_bar_size, CFG_BAR_SIZE);
 		rc = -ENODEV;
 		goto free_queue_props;
 	}
 
-	if (pci_resource_len(pdev, MSIX_BAR_ID) != MSIX_BAR_SIZE) {
-		dev_err(hdev->dev,
-			"Not " HL_NAME "? BAR %d size %llu, expecting %llu\n",
-			MSIX_BAR_ID,
-			(unsigned long long) pci_resource_len(pdev,
-								MSIX_BAR_ID),
-			MSIX_BAR_SIZE);
+	pci_bar_size = pci_resource_len(pdev, MSIX_BAR_ID);
+
+	if (pci_bar_size != MSIX_BAR_SIZE) {
+		dev_err(hdev->dev, "Not " HL_NAME "? BAR %d size %pa, expecting %llu\n",
+			MSIX_BAR_ID, &pci_bar_size, MSIX_BAR_SIZE);
 		rc = -ENODEV;
 		goto free_queue_props;
 	}
-- 
2.25.1

