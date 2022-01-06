Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8788486CB7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiAFVvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:51:09 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:63152 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244453AbiAFVvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:51:07 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5af4ntVVA2lVY5af4nSlQz; Thu, 06 Jan 2022 22:51:06 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 06 Jan 2022 22:51:06 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 05/16] agp/intel: Remove usage of the deprecated "pci-dma-compat.h" API
Date:   Thu,  6 Jan 2022 22:51:05 +0100
Message-Id: <f865712ee4edbbf3cdd831795b7546a768d923a3.1641500561.git.christophe.jaillet@wanadoo.fr>
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
 drivers/char/agp/intel-gtt.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index c53cc9868cd8..79a1b65527c2 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -111,8 +111,8 @@ static int intel_gtt_map_memory(struct page **pages,
 	for_each_sg(st->sgl, sg, num_entries, i)
 		sg_set_page(sg, pages[i], PAGE_SIZE, 0);
 
-	if (!pci_map_sg(intel_private.pcidev,
-			st->sgl, st->nents, PCI_DMA_BIDIRECTIONAL))
+	if (!dma_map_sg(&intel_private.pcidev->dev, st->sgl, st->nents,
+			DMA_BIDIRECTIONAL))
 		goto err;
 
 	return 0;
@@ -127,8 +127,8 @@ static void intel_gtt_unmap_memory(struct scatterlist *sg_list, int num_sg)
 	struct sg_table st;
 	DBG("try unmapping %lu pages\n", (unsigned long)mem->page_count);
 
-	pci_unmap_sg(intel_private.pcidev, sg_list,
-		     num_sg, PCI_DMA_BIDIRECTIONAL);
+	dma_unmap_sg(&intel_private.pcidev->dev, sg_list, num_sg,
+		     DMA_BIDIRECTIONAL);
 
 	st.sgl = sg_list;
 	st.orig_nents = st.nents = num_sg;
@@ -303,9 +303,9 @@ static int intel_gtt_setup_scratch_page(void)
 	set_pages_uc(page, 1);
 
 	if (intel_private.needs_dmar) {
-		dma_addr = pci_map_page(intel_private.pcidev, page, 0,
-				    PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
-		if (pci_dma_mapping_error(intel_private.pcidev, dma_addr)) {
+		dma_addr = dma_map_page(&intel_private.pcidev->dev, page, 0,
+					PAGE_SIZE, DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(&intel_private.pcidev->dev, dma_addr)) {
 			__free_page(page);
 			return -EINVAL;
 		}
@@ -552,9 +552,9 @@ static void intel_gtt_teardown_scratch_page(void)
 {
 	set_pages_wb(intel_private.scratch_page, 1);
 	if (intel_private.needs_dmar)
-		pci_unmap_page(intel_private.pcidev,
-			       intel_private.scratch_page_dma,
-			       PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
+		dma_unmap_page(&intel_private.pcidev->dev,
+			       intel_private.scratch_page_dma, PAGE_SIZE,
+			       DMA_BIDIRECTIONAL);
 	__free_page(intel_private.scratch_page);
 }
 
@@ -1412,13 +1412,13 @@ int intel_gmch_probe(struct pci_dev *bridge_pdev, struct pci_dev *gpu_pdev,
 
 	if (bridge) {
 		mask = intel_private.driver->dma_mask_size;
-		if (pci_set_dma_mask(intel_private.pcidev, DMA_BIT_MASK(mask)))
+		if (dma_set_mask(&intel_private.pcidev->dev, DMA_BIT_MASK(mask)))
 			dev_err(&intel_private.pcidev->dev,
 				"set gfx device dma mask %d-bit failed!\n",
 				mask);
 		else
-			pci_set_consistent_dma_mask(intel_private.pcidev,
-						    DMA_BIT_MASK(mask));
+			dma_set_coherent_mask(&intel_private.pcidev->dev,
+					      DMA_BIT_MASK(mask));
 	}
 
 	if (intel_gtt_init() != 0) {
-- 
2.32.0

