Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24A48F5E0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 09:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiAOIGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 03:06:39 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:56432 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiAOIGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 03:06:37 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id 8e55niL4YhTNk8e55n3jsu; Sat, 15 Jan 2022 09:06:36 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 15 Jan 2022 09:06:36 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: host: xhci-plat: Remove useless DMA-32 fallback configuration
Date:   Sat, 15 Jan 2022 09:06:31 +0100
Message-Id: <178f859197bebb385609a7c9458fb972ed312e5d.1642233968.git.christophe.jaillet@wanadoo.fr>
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
The "if (ret)" is also useless because
dma_coerce_mask_and_coherent(..., 64) + dma_set_mask_and_coherent(..., 64)
can't fail according to [1].
However, I've left it as-is because it is a common pattern.
It could be replaced by a comment explaining why, but looks like an
overkill to me.
---
 drivers/usb/host/xhci-plat.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1edcc9b13ce..93b321682b35 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -226,20 +226,13 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (!sysdev)
 		sysdev = &pdev->dev;
 
-	/* Try to set 64-bit DMA first */
 	if (WARN_ON(!sysdev->dma_mask))
 		/* Platform did not initialize dma_mask */
-		ret = dma_coerce_mask_and_coherent(sysdev,
-						   DMA_BIT_MASK(64));
+		ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
 	else
 		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
-
-	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
-	if (ret) {
-		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(32));
-		if (ret)
-			return ret;
-	}
+	if (ret)
+		return ret;
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.32.0

