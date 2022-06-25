Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7055AA3C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiFYM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiFYM4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:56:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E7618362
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 05:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656161793; x=1687697793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xrUhPovyVpzQVk4gf4IQBAjF6Pmgk0B0rsPwQtugD/8=;
  b=n7QziLnrI2Db6pDDqff/q0A2MhUQI686HY8kZPvAR6p5EJUovItgghCo
   BxHA59Uk3TIn8Id1ShoDTorxqafJVQkbl2UUr+3QetP7+G1/6g8vsBv/5
   IV/oiLBt+rIjfM38ilskUjae5BMB1mUrXe9DhrLhA5sfcHFzLUOjW7P4X
   Zm7yhDajbaotsM2LvyQCl4Ti2rrYeQPWjMVlzNUUl5HuPLRQPxMDeN3o2
   P8Jby5CJgDpCRKI58/YkufTAlnhd6CfebRKMZqAu8Er644vLz89mLbU3f
   7GR8CahlfwYKPHSr1avM8CPWFLL2QU4QZk/vbw5eGUjW7iO9vzp8r/G/n
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="278727945"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="278727945"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 05:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="586890354"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 05:56:30 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 1/6] iommu/vt-d: Remove unused domain_get_iommu()
Date:   Sat, 25 Jun 2022 20:51:59 +0800
Message-Id: <20220625125204.2199437-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not used anywhere. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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
index da6cfea0f0d6..781e060352e6 100644
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

