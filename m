Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D3D4AB560
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbiBGG6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357613AbiBGGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:44:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27545C043185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644216251; x=1675752251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OKL1r6Isxh5NwGJDUX9vHjv6BhHF7fJWfzI6cLdyIuo=;
  b=EC6qW772MgTnnPlVoXLbpJIERfhMdQfQRjnfH06CmdHPorWNffIuUPL7
   qqV1PxSgqH42lbAXyQ7S61NtloynrudiBlp3tQO0EUSqPQDOQn5W4LXNd
   YaxSQH8BM5mU2CX2eAwzMP36h9yxdidJFNLOcYFoRX5SKuHu0ZJdlpyJH
   oXrahmAtjVWdAGqaNP2TsPgpCA6v1f7FhpqTqAgDeDprNo/kq1YMlyACB
   baIsvoaT816wq6cXKldNdqu7y4PDStNW/EmQtPbNM8sHEjmklMG7OD1In
   VsZxfcgvgDu7EJYMIPrGxDvwpwcD0/GVDweFijaDk0c09h2zIL66ZugQe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273171153"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="273171153"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:43:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="525020221"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:06 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 03/10] iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
Date:   Mon,  7 Feb 2022 14:41:35 +0800
Message-Id: <20220207064142.1092846-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel IOMMU driver has already converted to use default domain
framework in iommu core. There's no need to find a domain for the
device in the domain attaching path. Cleanup that code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 438da5da301d..583ec0fa4ac1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2521,7 +2521,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    struct device *dev,
 						    struct dmar_domain *domain)
 {
-	struct dmar_domain *found = NULL;
 	struct device_domain_info *info;
 	unsigned long flags;
 	int ret;
@@ -2572,26 +2571,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	}
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	if (dev)
-		found = find_domain(dev);
-
-	if (!found) {
-		struct device_domain_info *info2;
-		info2 = dmar_search_domain_by_dev_info(info->segment, info->bus,
-						       info->devfn);
-		if (info2) {
-			found      = info2->domain;
-			info2->dev = dev;
-		}
-	}
-
-	if (found) {
-		spin_unlock_irqrestore(&device_domain_lock, flags);
-		free_devinfo_mem(info);
-		/* Caller must free the original domain */
-		return found;
-	}
-
 	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
 	spin_unlock(&iommu->lock);
-- 
2.25.1

