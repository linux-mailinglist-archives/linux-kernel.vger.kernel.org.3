Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C362570EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiGLAP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiGLAPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:15:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334AF32BAC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584869; x=1689120869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=94MIxLZGh7cLOMunSeLNvcXgG4W8P5quRK88jbR6hII=;
  b=M87iP3qVwGgymewFelUhHkm2v0mZ/qvzSfMN5Vy6HES9yD/JtW2HMDVE
   Ku0wHF6WyBq7kJirybAMj6IOzN2/4xU8BpXDSlUCHialpo+v8zwJSvAHX
   c7cNmR1CCUOUzOCpcCqKLewXCnfz3g9MkpxPb0+IqpfgtEZrulEK6jJ82
   bgwhBtqBK7LiNa0UBX99H9xkg9mFjQSH2pKB+pTMukiw7GhmoHQqZw1Zd
   u38zP3TGwiNacPqyzMoEJvXvnmLq3ONcy1JJn7rDK6kdDhUtrKd7bfQTE
   7cbuvFQoFeGMZ/V9xZuTp1wVHNN1Ofwy7ufTES/dX5QUeUwQ67UDsr1oK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="283555235"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="283555235"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:14:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445861"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:14:10 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 20/25] iommu/vt-d: Remove unused domain_get_iommu()
Date:   Tue, 12 Jul 2022 08:09:03 +0800
Message-Id: <20220712000908.3431936-21-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not used anywhere. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220702015610.2849494-2-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index df64d3d9c49a..56e0d8cd2102 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -725,7 +725,6 @@ extern int dmar_ir_support(void);
 
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
-struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 769e850b9767..55a055a8ed4b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -445,24 +445,6 @@ int iommu_calculate_agaw(struct intel_iommu *iommu)
 	return __iommu_calculate_agaw(iommu, DEFAULT_DOMAIN_ADDRESS_WIDTH);
 }
 
-/* This functionin only returns single iommu in a domain */
-struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
-{
-	int iommu_id;
-
-	/* si_domain and vm domain should not get here. */
-	if (WARN_ON(!iommu_is_dma_domain(&domain->domain)))
-		return NULL;
-
-	for_each_domain_iommu(iommu_id, domain)
-		break;
-
-	if (iommu_id < 0 || iommu_id >= g_num_of_iommus)
-		return NULL;
-
-	return g_iommus[iommu_id];
-}
-
 static inline bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
 {
 	return sm_supported(iommu) ?
-- 
2.25.1

