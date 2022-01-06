Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EC9486CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbiAFVwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:52:53 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:61824 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbiAFVwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:52:50 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5aghntW4u2lVY5aghnSlYT; Thu, 06 Jan 2022 22:52:49 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 06 Jan 2022 22:52:49 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 08/16] rapidio/tsi721: Remove usage of the deprecated "pci-dma-compat.h" API
Date:   Thu,  6 Jan 2022 22:52:46 +0100
Message-Id: <bdcc562c16d2551d6eb87baf557813330de45127.1641500561.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [1], Christoph Hellwig has proposed to remove the wrappers in
include/linux/pci-dma-compat.h.

Some reasons why this API should be removed have been given by Julia
Lawall in [2].

A coccinelle script has been used to perform the needed transformation.
It can be found in [3].

[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
[3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/rapidio/devices/tsi721.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 4dd31dd9feea..b3134744fb55 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2836,17 +2836,17 @@ static int tsi721_probe(struct pci_dev *pdev,
 	}
 
 	/* Configure DMA attributes. */
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
-		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
+		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (err) {
 			tsi_err(&pdev->dev, "Unable to set DMA mask");
 			goto err_unmap_bars;
 		}
 
-		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)))
+		if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32)))
 			tsi_info(&pdev->dev, "Unable to set consistent DMA mask");
 	} else {
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
 		if (err)
 			tsi_info(&pdev->dev, "Unable to set consistent DMA mask");
 	}
-- 
2.32.0

