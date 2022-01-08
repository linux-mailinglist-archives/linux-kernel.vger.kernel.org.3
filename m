Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ED04881E9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 07:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiAHGvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 01:51:02 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:57923 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiAHGvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 01:51:01 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 65Z4nkgZpozli65Z4nO3Di; Sat, 08 Jan 2022 07:50:59 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 08 Jan 2022 07:50:59 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     tomas.winkler@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mei: me: Use dma_set_mask_and_coherent() and simplify code
Date:   Sat,  8 Jan 2022 07:50:56 +0100
Message-Id: <67ddcec656194153830684e6ff4513114e8859d6.1641624544.git.christophe.jaillet@wanadoo.fr>
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


While at it, include directly <linux/dma-mapping.h> instead on relying on
indirect inclusion.

[1]: https://lkml.org/lkml/2021/6/7/398

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/mei/pci-me.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 3a45aaf002ac..a05cdb25d0c4 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 
@@ -192,14 +193,7 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto end;
 	}
 
-	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)) ||
-	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64))) {
-
-		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (err)
-			err = dma_set_coherent_mask(&pdev->dev,
-						    DMA_BIT_MASK(32));
-	}
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err) {
 		dev_err(&pdev->dev, "No usable DMA configuration, aborting\n");
 		goto end;
-- 
2.32.0

