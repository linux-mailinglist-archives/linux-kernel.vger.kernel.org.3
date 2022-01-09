Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DD9488BDF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 19:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiAIS5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 13:57:23 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:55501 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiAIS5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 13:57:20 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 6dNWnw2VWsoWh6dNWnw5jl; Sun, 09 Jan 2022 19:57:19 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 09 Jan 2022 19:57:19 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH] scsi: efct: Remove useless DMA-32 fallback configuration
Date:   Sun,  9 Jan 2022 19:57:04 +0100
Message-Id: <958bcb2a6e86344c14f38369e8e7079615a2b0e3.1641754613.git.christophe.jaillet@wanadoo.fr>
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

While at it, return the error code returned by dma_set_mask_and_coherent()
instead of -1.

[1]: https://lkml.org/lkml/2021/6/7/398

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch was not part of the 1st serie I've sent. So there is no
Reviewed-by tag.
---
 drivers/scsi/elx/efct/efct_driver.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/elx/efct/efct_driver.c b/drivers/scsi/elx/efct/efct_driver.c
index ae62fc3c9ee3..b08fc8839808 100644
--- a/drivers/scsi/elx/efct/efct_driver.c
+++ b/drivers/scsi/elx/efct/efct_driver.c
@@ -541,13 +541,10 @@ efct_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, efct);
 
-	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) != 0) {
-		dev_warn(&pdev->dev, "trying DMA_BIT_MASK(32)\n");
-		if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
-			dev_err(&pdev->dev, "setting DMA_BIT_MASK failed\n");
-			rc = -1;
-			goto dma_mask_out;
-		}
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (rc) {
+		dev_err(&pdev->dev, "setting DMA_BIT_MASK failed\n");
+		goto dma_mask_out;
 	}
 
 	num_interrupts = efct_device_interrupts_required(efct);
-- 
2.32.0

