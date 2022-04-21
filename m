Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679D55096C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384447AbiDUF1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384391AbiDUF1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:27:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E60DFB8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650518668; x=1682054668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kq4s1NHCuryhOFKECsJ3c8j/56TsU8RAVcNQNz5E+OY=;
  b=fCf5TlbnmNbXKTIFyi59OAg8CPtNxRArexUfUpsiE32h6CQP77h/kXpT
   6C8W3nCXuo3SXgJg6FwTYnFZBSihxW96jGhqnYoO2SWHC7b2uox6lSfA9
   c0ScCKtc2/bPA8QGHE+zfEX9bj54KtokUyx7trauXvsyVJMmaAa6yyjar
   3PYxTZeFTTuKAK8V9vr01+WaH5L53robD0zrPB+WI6jKJ3CSjvdTur0wK
   +S1j1ZWEr6OxgLfcLJClfyXZZ1zdA5ZR+wGKB3Nq+lyIzP6FXmJtEmQPf
   7z6XB/C3BfTuxG9xWp+Hr4TVfsdKP9tdhYSWbqqk3pIlGHtTRlMz8xjZ9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246135673"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="246135673"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 22:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="702944134"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 22:24:25 -0700
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
Subject: [PATCH v4 06/12] iommu/vt-d: Add SVA domain support
Date:   Thu, 21 Apr 2022 13:21:15 +0800
Message-Id: <20220421052121.3464100-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index ffad7f8f2d73..9c2714ba04ff 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4324,6 +4324,16 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
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
index 4c283a250541..251a3a65d77f 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -927,3 +927,40 @@ int intel_svm_page_response(struct device *dev,
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

