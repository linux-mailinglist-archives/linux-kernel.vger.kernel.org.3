Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2E4EA743
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiC2FmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiC2FmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:42:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED40531935
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648532434; x=1680068434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qef1x61kxuBKogixpH2FkpRMgqvDZAiwuSUR/Lcg4M4=;
  b=KR59Wg0n3rjdyvz738GF03EuycqXnrnUg9LWY7I6ooMGRjZyILqt8Hrp
   XN2cCCu42d96jP1hVKl1s9JOThsTzGJIvUCLua77hDhsJ60mPT1UYpH5q
   NoSq8CFuNbaHfzPtqlZ17CjUzmY8jKTTE7rlhwfbeRnHlv5fplHHWtt0n
   Dx+RqqhdwN+D2fHSRZWWyUczA6n4iyk8nZLuavmKYa6lYOb6qlRgQ9czh
   b1jU83joIr0zqKbHw6JyAuoCv8KxIw6AKVAxXaupfpVLJj42aihxINHIn
   MM94ICy6nKjy2I7XpeVmMNH3QdNWMiEwQwcf61vcPkcfQznhlMhCkZzOm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259137006"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="259137006"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 22:40:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="694603629"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 22:40:31 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH RFC v2 06/11] iommu/vt-d: Add SVA domain support
Date:   Tue, 29 Mar 2022 13:37:55 +0800
Message-Id: <20220329053800.3049561-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 2f9891cb3d00..c14283137fb5 100644
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
index c1b91bce1530..5eae7cf9bee5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4318,6 +4318,16 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
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
index ee5ecde5b318..8f59dd641b2d 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -932,3 +932,40 @@ int intel_svm_page_response(struct device *dev,
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
+	kfree(domain);
+}
+
+const struct iommu_domain_ops intel_svm_domain_ops = {
+	.attach_dev_pasid	= intel_svm_attach_dev_pasid,
+	.detach_dev_pasid	= intel_svm_detach_dev_pasid,
+	.free			= intel_svm_domain_free,
+};
-- 
2.25.1

