Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C2A482AC1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 11:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiABKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 05:30:00 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:54388 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiABK37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 05:29:59 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 3y7fnH6e4FGqt3y7gntgp4; Sun, 02 Jan 2022 11:29:58 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 02 Jan 2022 11:29:58 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] floppy: Remove usage of the deprecated "pci-dma-compat.h" API
Date:   Sun,  2 Jan 2022 11:29:54 +0100
Message-Id: <9e24eedeab44cbb840598bb188561a48811de845.1641119338.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [1], Christoph Hellwig has proposed to remove the wrappers in
include/linux/pci-dma-compat.h.

Some reasons why this API should be removed have been given by Julia
Lawall in [2].

A coccinelle script has been used to perform the needed transformation
Only relevant parts are given below.

@@ @@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@ @@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@
expression e1, e2, e3, e4;
@@
-    pci_map_single(e1, e2, e3, e4)
+    dma_map_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_single(e1, e2, e3, e4)
+    dma_unmap_single(&e1->dev, e2, e3, e4)

[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/include/asm/floppy.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/floppy.h b/arch/powerpc/include/asm/floppy.h
index 7af9a68fd949..f8ce178b43b7 100644
--- a/arch/powerpc/include/asm/floppy.h
+++ b/arch/powerpc/include/asm/floppy.h
@@ -134,17 +134,19 @@ static int hard_dma_setup(char *addr, unsigned long size, int mode, int io)
 	int dir;
 
 	doing_vdma = 0;
-	dir = (mode == DMA_MODE_READ) ? PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE;
+	dir = (mode == DMA_MODE_READ) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
 
 	if (bus_addr 
 	    && (addr != prev_addr || size != prev_size || dir != prev_dir)) {
 		/* different from last time -- unmap prev */
-		pci_unmap_single(isa_bridge_pcidev, bus_addr, prev_size, prev_dir);
+		dma_unmap_single(&isa_bridge_pcidev->dev, bus_addr, prev_size,
+				 prev_dir);
 		bus_addr = 0;
 	}
 
 	if (!bus_addr)	/* need to map it */
-		bus_addr = pci_map_single(isa_bridge_pcidev, addr, size, dir);
+		bus_addr = dma_map_single(&isa_bridge_pcidev->dev, addr, size,
+					  dir);
 
 	/* remember this one as prev */
 	prev_addr = addr;
-- 
2.32.0

