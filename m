Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7148F613
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 10:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiAOJPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 04:15:48 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:57755 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiAOJPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 04:15:47 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id 8fA0nihUyhTNk8fA0n3ptR; Sat, 15 Jan 2022 10:15:45 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 15 Jan 2022 10:15:45 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: bfa: Remove useless DMA-32 fallback configuration
Date:   Sat, 15 Jan 2022 10:15:41 +0100
Message-Id: <5663cef9b54004fa56cca7ce65f51eadfc3ecddb.1642238127.git.christophe.jaillet@wanadoo.fr>
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
 drivers/scsi/bfa/bfad.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index 440ef32be048..e5aa982ffedc 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -732,9 +732,6 @@ bfad_pci_init(struct pci_dev *pdev, struct bfad_s *bfad)
 	pci_set_master(pdev);
 
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (rc)
-		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-
 	if (rc) {
 		rc = -ENODEV;
 		printk(KERN_ERR "dma_set_mask_and_coherent fail %p\n", pdev);
@@ -1559,9 +1556,6 @@ bfad_pci_slot_reset(struct pci_dev *pdev)
 	pci_set_master(pdev);
 
 	rc = dma_set_mask_and_coherent(&bfad->pcidev->dev, DMA_BIT_MASK(64));
-	if (rc)
-		rc = dma_set_mask_and_coherent(&bfad->pcidev->dev,
-					       DMA_BIT_MASK(32));
 	if (rc)
 		goto out_disable_device;
 
-- 
2.32.0

