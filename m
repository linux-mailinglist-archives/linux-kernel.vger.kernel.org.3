Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CBD4D9397
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344876AbiCOFMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344842AbiCOFMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:12:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9188A49250
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647321067; x=1678857067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ol0nXzisKyEPOLK+60+mhBiQ8qX4SQP0mQu06nsUuvU=;
  b=R7klZzYOg5Hmtx0aGtul9HX0RNXHOYSHxpQ25zf/RbQ5xKO5JPTLcrdB
   3qWWJWbJKv4950gn/8SC9nSNtC8CppQkMZwOaFg3zYB1anlT6DoDG1EjK
   2RRk8lKrBF9UDmwhpkemIKFvGtwVxWLANUL7f81e2MDK1JPeNpTUjNIZZ
   6qWx8FiDAxrstu/c3BljOY34/kJhzZtKNJhmJ3SUQ1fIw06y5YsnJrVws
   go+0I7ayxK+4eXVajnsuxJvNSjeNOaRK63KLZDeqcORDQ4bUUQCtoyZgp
   T95C71dNDBip9Cs38RYDS96gSiQnXwpfCc4LeYXEkPYPHqjaJzkRWFZdG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236159100"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="236159100"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 22:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="580383571"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 22:03:58 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Date:   Mon, 14 Mar 2022 22:07:06 -0700
Message-Id: <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

An IOMMU domain represents an address space which can be attached by
devices that perform DMA within a domain. However, for platforms with
PASID capability the domain attachment needs be handled at device+PASID
level. There can be multiple PASIDs within a device and multiple devices
attached to a given domain.
This patch introduces a new IOMMU op which support device, PASID, and
IOMMU domain attachment. The immediate use case is for PASID capable
devices to perform DMA under DMA APIs.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/linux/iommu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 369f05c2a4e2..fde5b933dbe3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
  * @aux_get_pasid: get the pasid given an aux-domain
  * @sva_bind: Bind process address space to device
  * @sva_unbind: Unbind process address space from device
+ * @attach_dev_pasid: attach an iommu domain to a pasid of device
+ * @detach_dev_pasid: detach an iommu domain from a pasid of device
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
  * @cache_invalidate: invalidate translation caches
@@ -296,6 +298,10 @@ struct iommu_ops {
 	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
 				      void *drvdata);
 	void (*sva_unbind)(struct iommu_sva *handle);
+	int (*attach_dev_pasid)(struct iommu_domain *domain,
+				struct device *dev, ioasid_t id);
+	void (*detach_dev_pasid)(struct iommu_domain *domain,
+				 struct device *dev, ioasid_t id);
 	u32 (*sva_get_pasid)(struct iommu_sva *handle);
 
 	int (*page_response)(struct device *dev,
-- 
2.25.1

