Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261B84881FE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 08:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiAHHIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 02:08:47 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:54603 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiAHHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 02:08:47 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 65qGnknaaozli65qGnO5GR; Sat, 08 Jan 2022 08:08:45 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 08 Jan 2022 08:08:45 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] virtio: Simplify DMA setting
Date:   Sat,  8 Jan 2022 08:08:43 +0100
Message-Id: <fc97319a44d41d8b7eb127e1facdef4139ed77ac.1641625657.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.


While at it, include directly <linux/dma-mapping.h> instead on relying on
indirect inclusion.

[1]: https://lkml.org/lkml/2021/6/7/398

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/virtio/virtio_mmio.c           | 4 +---
 drivers/virtio/virtio_pci_legacy_dev.c | 7 +++----
 drivers/virtio/virtio_pci_modern_dev.c | 6 ++----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..aa1efa854de1 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -617,9 +617,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	}
 	if (rc)
-		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-	if (rc)
-		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
+		dev_warn(&pdev->dev, "Failed to enable DMA.  Trying to continue, but this might not work.\n");
 
 	platform_set_drvdata(pdev, vm_dev);
 
diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/virtio_pci_legacy_dev.c
index 677d1f68bc9b..52b1c4dd43fe 100644
--- a/drivers/virtio/virtio_pci_legacy_dev.c
+++ b/drivers/virtio/virtio_pci_legacy_dev.c
@@ -2,6 +2,7 @@
 
 #include "linux/virtio_pci.h"
 #include <linux/virtio_pci_legacy.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 
@@ -26,9 +27,7 @@ int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
 		return -ENODEV;
 
 	rc = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(64));
-	if (rc) {
-		rc = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32));
-	} else {
+	if (!rc) {
 		/*
 		 * The virtio ring base address is expressed as a 32-bit PFN,
 		 * with a page size of 1 << VIRTIO_PCI_QUEUE_ADDR_SHIFT.
@@ -38,7 +37,7 @@ int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
 	}
 
 	if (rc)
-		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
+		dev_warn(&pci_dev->dev, "Failed to enable DMA.  Trying to continue, but this might not work.\n");
 
 	rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
 	if (rc)
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index e8b3ff2b9fbc..830dc269d68f 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <linux/virtio_pci_modern.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 
@@ -256,10 +257,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 
 	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
 	if (err)
-		err = dma_set_mask_and_coherent(&pci_dev->dev,
-						DMA_BIT_MASK(32));
-	if (err)
-		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
+		dev_warn(&pci_dev->dev, "Failed to enable DMA.  Trying to continue, but this might not work.\n");
 
 	/* Device capability is only mandatory for devices that have
 	 * device-specific configuration.
-- 
2.32.0

