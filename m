Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CCD4E1A76
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244834AbiCTGoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiCTGoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:44:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107622102A9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647758565; x=1679294565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bqc+qN2B2/Vja5qf7Vjqf51YeUhWC0UzAro/jfN5yK4=;
  b=X3fdMKhudHmP/wlEPKPsaYjGPszdIjMlj+4O2Ey/9pDiHPzhbmHkmO8l
   a3bBy8WlMZ2nGPy5u8JDuoqdkauYdXmcjpTp8E4RInHSg7iCJj5pVEGh6
   5EIXgehATP5SFUyFfeQLUduszjrFlNqgzvxMmPfb+up6DvXa5rX9KYYtJ
   APcrkwwhBVdi76tThqjkvpswKan4hxGSYIKr8lnD6ufhc7ppRVkCxEdKW
   8l5hMEgbUXN+JnVDIwVi02Xtw5JNjOT3f7ZFeLZiJHB/5IbsHSrR2YryP
   BhOYNpOaq1U4T9egObAfXM8fsviWAkggtwrcbG7kC7SQobOEtfN3iBalE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="254924011"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="254924011"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 23:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="691839880"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:42:41 -0700
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
Subject: [PATCH RFC 02/11] iommu: Add iommu_domain type for SVA
Date:   Sun, 20 Mar 2022 14:40:21 +0800
Message-Id: <20220320064030.2936936-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new iommu domain type IOMMU_DOMAIN_SVA to represent an I/O page
table which is shared from CPU host VA. Add a sva_cookie field in the
iommu_domain structure to save the mm_struct which represent the CPU
memory page table.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 36f43af0af53..3e179b853380 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -64,6 +64,9 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
 
+#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
+#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
+
 /*
  * This are the possible domain-types
  *
@@ -86,6 +89,8 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
+#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
+				 __IOMMU_DOMAIN_HOST_VA)
 
 struct iommu_domain {
 	unsigned type;
@@ -95,6 +100,7 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
+	struct mm_struct *sva_cookie;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
-- 
2.25.1

