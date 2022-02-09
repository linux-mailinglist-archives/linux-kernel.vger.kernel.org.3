Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6EB4AF8B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiBIRt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbiBIRtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:49:14 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE6C05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644428957; x=1675964957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UOUACCmc6ZSeIBWc/lGIpGPqTjbY/sikTiknQS2V6T8=;
  b=EAIJ7FCsLtxW9chPLH774Djbn6aXhDhtnQV5o3xqS73CBNi0QIrNjYvt
   wD+x9V62xhFa9Zz0u6WRSgAHBdVPVLV6fCBhSLgTq8mUeCxcrmU8vOU7p
   zfC/VQdWQjO+oGFzfjAyfVZnjqXp2MfiPZY5EItsTJlbS0AD8v4RbwWCh
   5EvcbE2fCjZUbbZmhe0U8/T3FER1+y0FGpNFErdsai1cuKcB9iha2Kc32
   x6fx6hAuQ7hRUIeX1FRLgUNZlES73GmgUeXwOVv1ZI7hg+ChOPeMqi1i3
   uxcVWArNFQe3JAgrMZCFt3H1O7PLc20V73l5eRK+Us28PxVTyjHCeMIV6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249034334"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249034334"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 09:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="633310153"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 09 Feb 2022 09:49:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9BD17107; Wed,  9 Feb 2022 19:49:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iommu/vt-d: Don't cast parameter in for_each_set_bit()
Date:   Wed,  9 Feb 2022 19:49:13 +0200
Message-Id: <20220209174913.4319-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While in this particular case it would not be a (critical) issue,
the pattern itself is bad and error prone in case the location
of the parameter is changed.

Don't cast parameter to unsigned long pointer in for_each_set_bit().
Instead copy to a local variable on stack of a proper type and use.

Fixes: 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..777e81b8f4f5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4973,6 +4973,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
+	unsigned long cache_bits;
 	unsigned long flags;
 	int cache_type;
 	u8 bus, devfn;
@@ -5008,9 +5009,8 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 		size = to_vtd_size(inv_info->granu.addr_info.granule_size,
 				   inv_info->granu.addr_info.nb_granules);
 
-	for_each_set_bit(cache_type,
-			 (unsigned long *)&inv_info->cache,
-			 IOMMU_CACHE_INV_TYPE_NR) {
+	cache_bits = inv_info->cache;
+	for_each_set_bit(cache_type, &cache_bits, IOMMU_CACHE_INV_TYPE_NR) {
 		int granu = 0;
 		u64 pasid = 0;
 		u64 addr = 0;
-- 
2.34.1

