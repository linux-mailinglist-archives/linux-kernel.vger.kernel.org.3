Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3972509ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388910AbiDULlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244998AbiDULlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:41:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022DF2C106
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650541126; x=1682077126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t+FgniAGQmeXacymlT2gSb61V603jB6flixJAZie7ew=;
  b=I2PlLDcve7ja5qOIfWmTnr8HJVRXqHB9UXHfsHLv73qJQGLD0EJWKuI9
   oV3b/FO5Bk5LTYgndQ/rWqlpIp5Li/x0T6CE/EbegFo3Na8R5/aaOZEmZ
   h/nUXpG326qer4q//bBAT+JkDgcG9wXblzite1zt2PbC5UlRrVn7o/zon
   sVac8y4Xa/xXMylTsioDGl3Cl+fCwaIqwiZHH1tc/T8U+7t7FUiPjRDMv
   Z3Ck1aNtcdMhog3/U9H1Nqm7oVfj60+/ql+zCyZloLdRWJajMIEbwRDWB
   at7Hi6LsEgs+EhPUnKOHVaiNJuMxV2b1dXusnO7vOsm2rSag1oOX/fmdp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264492186"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264492186"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 04:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="703047926"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 04:38:45 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/4] iommu/vt-d: Set PGSNP bit in pasid table entry for SVA binding
Date:   Thu, 21 Apr 2022 19:35:56 +0800
Message-Id: <20220421113558.3504874-3-baolu.lu@linux.intel.com>
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

This field make the requests snoop processor caches irrespective of
other attributes in the request or other fields in paging structure
entries used to translate the request.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 23a38763c1d1..c720d1be992d 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -391,9 +391,12 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	}
 
 	/* Setup the pasid table: */
-	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
-			PASID_FLAG_SUPERVISOR_MODE : 0;
-	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
+	sflags = PASID_FLAG_PAGE_SNOOP;
+	if (flags & SVM_FLAG_SUPERVISOR_MODE)
+		sflags |= PASID_FLAG_SUPERVISOR_MODE;
+	if (cpu_feature_enabled(X86_FEATURE_LA57))
+		sflags |= PASID_FLAG_FL5LP;
+
 	spin_lock_irqsave(&iommu->lock, iflags);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
-- 
2.25.1

