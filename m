Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91114B3FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiBNC6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:58:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbiBNC6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:58:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB950B31
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644807520; x=1676343520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0JZUGngNJYQNkQxgdzwA+7te07Ku/U9yElxaQVFZPW0=;
  b=VNQ/CNYoi/b8SKAUWyJM+UAIM3vSGndX1BDc0p6jVoX1Te6onr02UsoP
   vq21E7spmkQu0C7ulAzGKpgwtX45aicj6YwvzhUy8/eKsWVvyHZXdRT6A
   y1f/1yQD1/fWF3uhlWGTHRHegewdLZIKAUxksC2/AszmZ2ct9pnvnDIyV
   wDanMOBJ/6HuajU6nhGbGyCd4nK8vYA2e0bV5xDRkH1533hovIEP/n34R
   VQhWi7A2ZCCoaqFCygz7MWK2NTjhpue+d772c/0r4z62LA5qAVvcRxInl
   cMDxbJ9hUwFR81JZJ9ZV3CMHp0xtM8nk0vN3Eq6nzWJIZKkmBnvGzCFf8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313280408"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="313280408"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:58:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="501514913"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:37 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 02/11] iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
Date:   Mon, 14 Feb 2022 10:56:55 +0800
Message-Id: <20220214025704.3184654-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel IOMMU driver has already converted to use default domain
framework in iommu core. There's no need to find a domain for the
device in the domain attaching path. Cleanup that code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel/iommu.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e3b04d5d87b0..b3075933864e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2554,7 +2554,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    struct device *dev,
 						    struct dmar_domain *domain)
 {
-	struct dmar_domain *found = NULL;
 	struct device_domain_info *info;
 	unsigned long flags;
 	int ret;
@@ -2605,26 +2604,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
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

