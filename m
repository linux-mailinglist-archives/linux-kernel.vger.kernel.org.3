Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A855036A0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 14:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiDPMgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 08:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiDPMgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 08:36:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BACFE429
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650112413; x=1681648413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tCjF1I4YjEgxSy7zR9vWw2QROF8JK1qkQd4b3h+ujew=;
  b=Gnfuz0w0/RFifaqu8RBqzCjaxKrQ5nj+8f/vg+ttI+1vVmaUg/wEsuSM
   SFcsY7MTbHZVN1IFn6sGJxRKC3yLwQCYdgcURz0ztpavqcTUycOSm4Be+
   w88tloGp3usGZSjejW5J2JhIPWHDSfZeyGTpvehkly56lHCIeTr5qwuXO
   3mcjzNsp5OTr5WcTAUIcuYcy30oRN9MfD3NxNgMwnT/a7vH/Ys5i4TBg2
   MZhWtkiv/KSS6M4v+fbTUUlR/+JNJcVAKyv/NIP+hHGB7o7JrmMj4a2K3
   s7K/8r8QW9TaM3Ur8d4urexX8jGH9Zls02d8hlx6viVzUmgM3Mg4flmJD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243221101"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="243221101"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 05:33:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="701332465"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:33:31 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/3] iommu/vt-d: Set PGSNP bit in pasid table entry for sva binding
Date:   Sat, 16 Apr 2022 20:30:47 +0800
Message-Id: <20220416123049.879969-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416123049.879969-1-baolu.lu@linux.intel.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field make the requests snoop processor caches irrespective of other
attributes in the request or other fields in paging structure entries
used to translate the request. The latest VT-d specification states that
this field is treated as Reserved(0) for implementations not supporting
Snoop Control (SC=0 in the Extended Capability Register). Hence add a
check in the code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 2 +-
 drivers/iommu/intel/svm.c   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index f8d215d85695..9ca3c67a2058 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -625,7 +625,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		}
 	}
 
-	if (flags & PASID_FLAG_PAGE_SNOOP)
+	if ((flags & PASID_FLAG_PAGE_SNOOP) && ecap_sc_support(iommu->ecap))
 		pasid_set_pgsnp(pte);
 
 	pasid_set_domain_id(pte, did);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 23a38763c1d1..d88af37c20ef 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -394,6 +394,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
 			PASID_FLAG_SUPERVISOR_MODE : 0;
 	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
+	sflags |= PASID_FLAG_PAGE_SNOOP;
 	spin_lock_irqsave(&iommu->lock, iflags);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
-- 
2.25.1

