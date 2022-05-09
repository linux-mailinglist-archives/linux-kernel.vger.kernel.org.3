Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BF351F98A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiEIKUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiEIKUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:20:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C608174939;
        Mon,  9 May 2022 03:16:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C0E61063;
        Mon,  9 May 2022 03:16:13 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D4073F66F;
        Mon,  9 May 2022 03:16:12 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org, bhelgaas@google.com,
        robh@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/dma: Explicitly sort PCI DMA windows
Date:   Mon,  9 May 2022 11:16:08 +0100
Message-Id: <35661036a7e4160850895f9b37f35408b6a29f2f.1652091160.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, creating the dma_ranges resource list in pre-sorted fashion
was the simplest and most efficient way to enforce the order required by
iova_reserve_pci_windows(). However since then at least one PCI host
driver is now re-sorting the list for its own probe-time processing,
which doesn't seem entirely unreasonable, so that basic assumption no
longer holds. Make iommu-dma robust and get the sort order it needs by
explicitly sorting, which means we can also save the effort at creation
time and just build the list in whatever natural order the DT had.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Clean up now-unused local variable

 drivers/iommu/dma-iommu.c | 13 ++++++++++++-
 drivers/pci/of.c          |  8 +-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..d05538af4fe9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -20,6 +20,7 @@
 #include <linux/iommu.h>
 #include <linux/iova.h>
 #include <linux/irq.h>
+#include <linux/list_sort.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -414,6 +415,15 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 	return 0;
 }
 
+static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
+		const struct list_head *b)
+{
+	struct resource_entry *res_a = list_entry(a, typeof(*res_a), node);
+	struct resource_entry *res_b = list_entry(b, typeof(*res_b), node);
+
+	return res_a->res->start > res_b->res->start;
+}
+
 static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
@@ -432,6 +442,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 	}
 
 	/* Get reserved DMA windows from host bridge */
+	list_sort(NULL, &bridge->dma_ranges, iommu_dma_ranges_sort);
 	resource_list_for_each_entry(window, &bridge->dma_ranges) {
 		end = window->res->start - window->offset;
 resv_iova:
@@ -440,7 +451,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 			hi = iova_pfn(iovad, end);
 			reserve_iova(iovad, lo, hi);
 		} else if (end < start) {
-			/* dma_ranges list should be sorted */
+			/* DMA ranges should be non-overlapping */
 			dev_err(&dev->dev,
 				"Failed to reserve IOVA [%pa-%pa]\n",
 				&start, &end);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index cb2e8351c2cc..8f0ebaf9ae85 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -369,7 +369,6 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 
 	dev_dbg(dev, "Parsing dma-ranges property...\n");
 	for_each_of_pci_range(&parser, &range) {
-		struct resource_entry *entry;
 		/*
 		 * If we failed translation or got a zero-sized region
 		 * then skip this range
@@ -393,12 +392,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			goto failed;
 		}
 
-		/* Keep the resource list sorted */
-		resource_list_for_each_entry(entry, ib_resources)
-			if (entry->res->start > res->start)
-				break;
-
-		pci_add_resource_offset(&entry->node, res,
+		pci_add_resource_offset(ib_resources, res,
 					res->start - range.pci_addr);
 	}
 
-- 
2.35.3.dirty

