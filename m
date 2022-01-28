Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F13C49EF98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbiA1A1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:27:37 -0500
Received: from ale.deltatee.com ([204.191.154.188]:47184 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344611AbiA1A0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=bX2MPLdONywt9Jg2kBZ4+U7MTlH6jUj7zAM9CGcnTno=; b=niKQOBObQMpHq2+bvomGg6XFgp
        e1uacA/QTmWjbufbUaQHCaMQmWbnjcZWnSLHUq9QeghzBCGHaPx51JjPpjwQi2gEklYFI7GgCyw7D
        CNTSkJaGcq3FrfD8eWZC0hG8DPiRZcD756F/qbelT7Bc7Em5rX/s1g1pxSLMW+CG3ACNgvR2otysh
        F77hKp129+rLZEG054Gymw8ud2/4rdBTZ+Df4k6e3BoqJJsvNquMm7fZqXD1kgwn3dlcYGF44MSu2
        CftfO2vzYEunYEwZP5js2Dgy6yn2OaLmG3u/saGDENWjr2+DYN6dHFVEwVmIUmAzYzaPXBBo8q/A0
        wXF9HkkA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nDF5v-005OcZ-0x; Thu, 27 Jan 2022 17:26:28 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nDF5n-0001cX-6K; Thu, 27 Jan 2022 17:26:19 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 27 Jan 2022 17:25:58 -0700
Message-Id: <20220128002614.6136-9-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128002614.6136-1-logang@deltatee.com>
References: <20220128002614.6136-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.6
Subject: [PATCH v5 08/24] dma-direct: support PCI P2PDMA pages in dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
PCI P2PDMA pages directly without a hack in the callers. This allows
for heterogeneous SGLs that contain both P2PDMA and regular pages.

A P2PDMA page may have three possible outcomes when being mapped:
  1) If the data path between the two devices doesn't go through the
     root port, then it should be mapped with a PCI bus address
  2) If the data path goes through the host bridge, it should be mapped
     normally, as though it were a CPU physical address
  3) It is not possible for the two devices to communicate and thus
     the mapping operation should fail (and it will return -EREMOTEIO).

SGL segments that contain PCI bus addresses are marked with
sg_dma_mark_pci_p2pdma() and are ignored when unmapped.

P2PDMA mappings are also failed if swiotlb needs to be used on the
mapping.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 kernel/dma/direct.c | 43 +++++++++++++++++++++++++++++++++++++------
 kernel/dma/direct.h |  7 ++++++-
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 50f48e9e4598..975df5f3aaf9 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -461,29 +461,60 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu_all();
 }
 
+/*
+ * Unmaps segments, except for ones marked as pci_p2pdma which do not
+ * require any further action as they contain a bus address.
+ */
 void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sg(sgl, sg, nents, i)
-		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
-			     attrs);
+	for_each_sg(sgl,  sg, nents, i) {
+		if (sg_is_dma_bus_address(sg))
+			sg_dma_unmark_bus_address(sg);
+		else
+			dma_direct_unmap_page(dev, sg->dma_address,
+					      sg_dma_len(sg), dir, attrs);
+	}
 }
 #endif
 
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	int i;
+	struct pci_p2pdma_map_state p2pdma_state = {};
+	enum pci_p2pdma_map_type map;
 	struct scatterlist *sg;
+	int i, ret;
 
 	for_each_sg(sgl, sg, nents, i) {
+		if (is_pci_p2pdma_page(sg_page(sg))) {
+			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
+			switch (map) {
+			case PCI_P2PDMA_MAP_BUS_ADDR:
+				continue;
+			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+				/*
+				 * Any P2P mapping that traverses the PCI
+				 * host bridge must be mapped with CPU physical
+				 * address and not PCI bus addresses. This is
+				 * done with dma_direct_map_page() below.
+				 */
+				break;
+			default:
+				ret = -EREMOTEIO;
+				goto out_unmap;
+			}
+		}
+
 		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
 				sg->offset, sg->length, dir, attrs);
-		if (sg->dma_address == DMA_MAPPING_ERROR)
+		if (sg->dma_address == DMA_MAPPING_ERROR) {
+			ret = -EIO;
 			goto out_unmap;
+		}
 		sg_dma_len(sg) = sg->length;
 	}
 
@@ -491,7 +522,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 
 out_unmap:
 	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
-	return -EIO;
+	return ret;
 }
 
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 4632b0f4f72e..a33152d79069 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -87,10 +87,15 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (is_swiotlb_force_bounce(dev))
+	if (is_swiotlb_force_bounce(dev)) {
+		if (is_pci_p2pdma_page(page))
+			return DMA_MAPPING_ERROR;
 		return swiotlb_map(dev, phys, size, dir, attrs);
+	}
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
+		if (is_pci_p2pdma_page(page))
+			return DMA_MAPPING_ERROR;
 		if (swiotlb_force != SWIOTLB_NO_FORCE)
 			return swiotlb_map(dev, phys, size, dir, attrs);
 
-- 
2.30.2

