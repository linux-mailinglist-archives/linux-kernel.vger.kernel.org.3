Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38333509ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388898AbiDULlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347487AbiDULle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:41:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D83E2BB37
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650541125; x=1682077125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=osVQwJV/ZujaTApdG5eicPwbXUjaErfT37EPkI8Lc0g=;
  b=bWs+UoAx6K2+ayqtJoBqIGIU+US9H5/45d4wjJ1InKlRZeLO1Mldyh6H
   M7Wz2xKrwqYicaUd0WoFxSQdksQiXsZRtkNvMiBwhxxS/86YqobcLJlHm
   wrmx3KVtXeFEzlL9OPeqimci3r0/neh/0KAd+Rpz2l0tJdRFjN/xqXDCy
   mZRgA36kKim/j0BEXJnFgXqozM68Ne7icG+8PmkFDnoVF8gzU7CwtVp8S
   8R5gVfKRepztWyqyeli4UHveAI61kqN6qYX6Qu9iR3MFemHP3M2gHjBHb
   zvz/kG7PD/5MDcS1wsN8FTf6t4ETVcXLfL+F3YYn38Q1pqmZY6KlKWE1y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264492183"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264492183"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 04:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="703047918"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 04:38:43 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in pasid table entry
Date:   Thu, 21 Apr 2022 19:35:55 +0800
Message-Id: <20220421113558.3504874-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest VT-d specification states that the PGSNP field in the pasid
table entry should be treated as Reserved(0) for implementations not
supporting Snoop Control (SC=0 in the Extended Capability Register).
This adds a check before setting the field.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index f8d215d85695..5cb2daa2b8cb 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -625,8 +625,14 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		}
 	}
 
-	if (flags & PASID_FLAG_PAGE_SNOOP)
-		pasid_set_pgsnp(pte);
+	if (flags & PASID_FLAG_PAGE_SNOOP) {
+		if (ecap_sc_support(iommu->ecap)) {
+			pasid_set_pgsnp(pte);
+		} else {
+			pasid_clear_entry(pte);
+			return -EINVAL;
+		}
+	}
 
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
@@ -710,7 +716,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
-	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
+	if (ecap_sc_support(iommu->ecap) &&
+	    domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
 		pasid_set_pgsnp(pte);
 
 	/*
-- 
2.25.1

