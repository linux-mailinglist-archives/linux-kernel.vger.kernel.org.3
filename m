Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F69482891
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 22:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiAAV24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 16:28:56 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:64230 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiAAV2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 16:28:55 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 3lvonPgP41yYB3lvpn11kX; Sat, 01 Jan 2022 22:28:54 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 01 Jan 2022 22:28:54 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     tskd08@gmail.com, mchehab@kernel.org, andy.shevchenko@gmail.com,
        kirill.shilimanov@huawei.com, novikov@ispras.ru
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] media: pt3: Use dma_set_mask_and_coherent() and simplify code
Date:   Sat,  1 Jan 2022 22:28:51 +0100
Message-Id: <34f3a2b58d5f9078709b7d592536af0be49ea1d9.1641072450.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dma_set_mask_and_coherent() instead of unrolling it with some
dma_set_mask()+dma_set_coherent_mask().

Moreover, as stated in [1], dma_set_mask() with a 64-bit mask will never
fail if dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lkml.org/lkml/2021/6/7/398

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/pci/pt3/pt3.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/media/pci/pt3/pt3.c b/drivers/media/pci/pt3/pt3.c
index 0d51bdf01f43..11f26cac0abc 100644
--- a/drivers/media/pci/pt3/pt3.c
+++ b/drivers/media/pci/pt3/pt3.c
@@ -707,18 +707,10 @@ static int pt3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret < 0)
 		return ret;
 
-	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
-	if (ret == 0)
-		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
-	else {
-		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (ret == 0)
-			dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-		else {
-			dev_err(&pdev->dev, "Failed to set DMA mask\n");
-			return ret;
-		}
-		dev_info(&pdev->dev, "Use 32bit DMA\n");
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set DMA mask\n");
+		return ret;
 	}
 
 	pt3 = devm_kzalloc(&pdev->dev, sizeof(*pt3), GFP_KERNEL);
-- 
2.32.0

