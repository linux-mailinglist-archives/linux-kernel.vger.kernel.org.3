Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7F516944
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 03:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356524AbiEBBzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 21:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356807AbiEBBzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 21:55:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560311EEEE
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 18:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651456330; x=1682992330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mzTtaAStsMU4y588iYABmQJ+1EZsf0v9Q75YY8ToPeM=;
  b=DVm11VPmJpX7HG7DsKgY2FqnljjUmE0BA2OFcdeGRN0lvCIDP2TyLgce
   oA90Ge5Hff4fyS1m9zlrwP0483AwmARPDayaXPju53U1FgwhjeSQCUsXk
   cTq1k3T4B0yL2rh34xNPq7hcSGF1c7N3PpiDb4QVyzkViz0ppjVYWZZSQ
   sPMMy9jKrxUmu2fmr/+G8DB1k6zl7KonNvuF+i6deyxio9FbMu2lg8BhB
   oCUncPONQUPXDeteoLiz1cZw8vJnprWBf/9mlMGvJTJznk4O0fkzcRW+O
   XfBJFPgIrDQqgim+pwT0rjcCRzl3jXXqux5CWP5pgfGM0ksa8QIYY3kik
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="249062067"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="249062067"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 18:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="707406492"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 01 May 2022 18:52:05 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 06/12] iommu/vt-d: Add SVA domain support
Date:   Mon,  2 May 2022 09:48:36 +0800
Message-Id: <20220502014842.991097-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502014842.991097-1-baolu.lu@linux.intel.com>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SVA domain allocation and provide an SVA-specific
iommu_domain_ops.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  1 +
 drivers/iommu/intel/iommu.c | 10 ++++++++++
 drivers/iommu/intel/svm.c   | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 72e5d7900e71..3b4ca16f53e2 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
+extern const struct iommu_domain_ops intel_svm_domain_ops;
 
 struct intel_svm_dev {
 	struct list_head list;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 170eb777d57b..5d1d3e325afa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4330,6 +4330,16 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		return domain;
 	case IOMMU_DOMAIN_IDENTITY:
 		return &si_domain->domain;
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	case IOMMU_DOMAIN_SVA:
+		dmar_domain = alloc_domain(type);
+		if (!dmar_domain)
+			return NULL;
+		domain = &dmar_domain->domain;
+		domain->ops = &intel_svm_domain_ops;
+
+		return domain;
+#endif /* CONFIG_INTEL_IOMMU_SVM */
 	default:
 		return NULL;
 	}
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 574ddddaa33a..ec684d883014 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -931,3 +931,40 @@ int intel_svm_page_response(struct device *dev,
 	mutex_unlock(&pasid_mutex);
 	return ret;
 }
+
+static int intel_svm_attach_dev_pasid(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct mm_struct *mm = iommu_sva_domain_mm(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct iommu_sva *sva;
+	int ret = 0;
+
+	mutex_lock(&pasid_mutex);
+	sva = intel_svm_bind_mm(iommu, dev, mm);
+	if (IS_ERR(sva))
+		ret = PTR_ERR(sva);
+	mutex_unlock(&pasid_mutex);
+
+	return ret;
+}
+
+static void intel_svm_detach_dev_pasid(struct iommu_domain *domain,
+				       struct device *dev, ioasid_t pasid)
+{
+	mutex_lock(&pasid_mutex);
+	intel_svm_unbind_mm(dev, pasid);
+	mutex_unlock(&pasid_mutex);
+}
+
+static void intel_svm_domain_free(struct iommu_domain *domain)
+{
+	kfree(to_dmar_domain(domain));
+}
+
+const struct iommu_domain_ops intel_svm_domain_ops = {
+	.attach_dev_pasid	= intel_svm_attach_dev_pasid,
+	.detach_dev_pasid	= intel_svm_detach_dev_pasid,
+	.free			= intel_svm_domain_free,
+};
-- 
2.25.1

