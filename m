Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0592348F606
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 09:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiAOIxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 03:53:11 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:50461 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiAOIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 03:53:10 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id 8eo7nia4uhTNk8eo7n3nrl; Sat, 15 Jan 2022 09:53:08 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 15 Jan 2022 09:53:08 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: 3w-sas: Remove useless DMA-32 fallback configuration
Date:   Sat, 15 Jan 2022 09:53:03 +0100
Message-Id: <dbbe8671ca760972d80f8d35f3170b4609bee368.1642236763.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in [1], dma_set_mask() with a 64-bit mask never fails if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/3w-sas.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index b9482da79512..3ebe66151dcb 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1567,8 +1567,6 @@ static int twl_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 	pci_try_set_mwi(pdev);
 
 	retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (retval)
-		retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (retval) {
 		TW_PRINTK(host, TW_DRIVER, 0x18, "Failed to set dma mask");
 		retval = -ENODEV;
@@ -1786,8 +1784,6 @@ static int __maybe_unused twl_resume(struct device *dev)
 	pci_try_set_mwi(pdev);
 
 	retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (retval)
-		retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (retval) {
 		TW_PRINTK(host, TW_DRIVER, 0x25, "Failed to set dma mask during resume");
 		retval = -ENODEV;
-- 
2.32.0

