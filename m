Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB2544486
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbiFIHMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiFIHMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:12:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CE724249C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654758725; x=1686294725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/iNWtyXhoUjFCJMWGA58jiCCwl0OUy7BEC+3COjS34M=;
  b=AZqjWJTz/Rn6O8m0axiw7tjSnBL1pgzD2mSwT/i7VZ8lmxmSykjqcl89
   l8pASQT7bixcxUNe6hAKbp5VUns4P0qFejVnRRRGJgFdQw/VjeCyFvh1I
   cxLWP2XBS8fv0I65CYMT902WsxvSoGyfVlUW5lsK4226xl5V5BzILmUlK
   wjRiBAUFL2+AQGqTNG+HLy0YvmE+Ux2CheKuo6BGmZKIQzOxl0xSYfozK
   HeyBJvBvYnmWKxWJjzAP0NMpkCr1sjIYsCFyBwntOuARVC+3nMmx3cbPk
   7+OIDdTNoWwWIzovJR5U3LmTN+FuAzNBib6pBMOALYNV8QKpYr82Bn4dH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="277995417"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="277995417"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 00:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="580445921"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2022 00:12:01 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCHES 2/2] iommu: Replace put_pages_list() with iommu_free_pgtbl_pages()
Date:   Thu,  9 Jun 2022 15:08:11 +0800
Message-Id: <20220609070811.902868-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609070811.902868-1-baolu.lu@linux.intel.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Therefore, RCU protected page free will take effect if necessary.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd/io_pgtable.c | 5 ++---
 drivers/iommu/dma-iommu.c      | 6 ++++--
 drivers/iommu/intel/iommu.c    | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 6608d1717574..a62d5dafd7f2 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -423,7 +423,7 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
 	}
 
 	/* Everything flushed out, free pages now */
-	put_pages_list(&freelist);
+	iommu_free_pgtbl_pages(&dom->domain, &freelist);
 
 	return ret;
 }
@@ -503,8 +503,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 
 	/* Make changes visible to IOMMUs */
 	amd_iommu_domain_update(dom);
-
-	put_pages_list(&freelist);
+	iommu_free_pgtbl_pages(&dom->domain, &freelist);
 }
 
 static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f90251572a5d..a948358c3e51 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -132,7 +132,8 @@ static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
 		if (fq->entries[idx].counter >= counter)
 			break;
 
-		put_pages_list(&fq->entries[idx].freelist);
+		iommu_free_pgtbl_pages(cookie->fq_domain,
+				       &fq->entries[idx].freelist);
 		free_iova_fast(&cookie->iovad,
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
@@ -228,7 +229,8 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 		struct iova_fq *fq = per_cpu_ptr(cookie->fq, cpu);
 
 		fq_ring_for_each(idx, fq)
-			put_pages_list(&fq->entries[idx].freelist);
+			iommu_free_pgtbl_pages(cookie->fq_domain,
+					       &fq->entries[idx].freelist);
 	}
 
 	free_percpu(cookie->fq);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 19024dc52735..f429671e837f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1891,7 +1891,7 @@ static void domain_exit(struct dmar_domain *domain)
 		LIST_HEAD(freelist);
 
 		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
-		put_pages_list(&freelist);
+		iommu_free_pgtbl_pages(&domain->domain, &freelist);
 	}
 
 	kfree(domain);
@@ -4510,7 +4510,7 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 				      start_pfn, nrpages,
 				      list_empty(&gather->freelist), 0);
 
-	put_pages_list(&gather->freelist);
+	iommu_free_pgtbl_pages(domain, &gather->freelist);
 }
 
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
2.25.1

