Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01F04EA740
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiC2Fm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiC2Fmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:42:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E211B24A764
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648532453; x=1680068453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JfGjVHRgrpt8QUxiPQxKQ7422++u6wuqZXu+sum80fQ=;
  b=oHkE9Zw/3DRO8W3iyKM5sO09trgqpJr4KADCKsaDpW/B2QhWfJ5k/jiQ
   yTp2LkPOS6aPv64iEztr/0a4A7e9E7O6VplgauvyLdyDpLhOdkNcQr7wV
   uBUE5JjyrWOsNBlJv5pW9GP405LOoMdoJrsf0G6AWuQb+5tYZKl96/P+k
   1MkZUSabkcNnrNr/JSsdbL9Ypab3uXQi8ziRSqv/9pYFGrfvmNOKG8lM+
   OWoaP2AufS9KCSCeaiBDwl1ugLik4rEr0qmzWjEBZbHOpaeAjrL9o7KW/
   bVGalORwajcu7d66mS578TjejYf3eGbxSmxPXY+7NrozcQpqRMT2uJbCy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259137066"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="259137066"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 22:40:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="694603691"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 22:40:49 -0700
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
Subject: [PATCH RFC v2 11/11] iommu: Rename iommu-sva-lib.{c,h}
Date:   Tue, 29 Mar 2022 13:38:00 +0800
Message-Id: <20220329053800.3049561-12-baolu.lu@linux.intel.com>
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

Rename iommu-sva-lib.c[h] to iommu-sva.c[h] as it contains all code
for SVA implementation in iommu core.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/{iommu-sva-lib.h => iommu-sva.h}  | 0
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 2 +-
 drivers/iommu/intel/iommu.c                     | 2 +-
 drivers/iommu/intel/svm.c                       | 2 +-
 drivers/iommu/io-pgfault.c                      | 2 +-
 drivers/iommu/{iommu-sva-lib.c => iommu-sva.c}  | 2 +-
 drivers/iommu/iommu.c                           | 2 +-
 drivers/iommu/Makefile                          | 2 +-
 9 files changed, 8 insertions(+), 8 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (100%)
 rename drivers/iommu/{iommu-sva-lib.c => iommu-sva.c} (99%)

diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva.h
similarity index 100%
rename from drivers/iommu/iommu-sva-lib.h
rename to drivers/iommu/iommu-sva.h
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 5591321f9e11..a13543aa9df4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -9,7 +9,7 @@
 #include <linux/slab.h>
 
 #include "arm-smmu-v3.h"
-#include "../../iommu-sva-lib.h"
+#include "../../iommu-sva.h"
 #include "../../io-pgtable-arm.h"
 
 struct arm_smmu_mmu_notifier {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 543d3ef1c102..ca2bd17eec41 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -31,7 +31,7 @@
 #include <linux/amba/bus.h>
 
 #include "arm-smmu-v3.h"
-#include "../../iommu-sva-lib.h"
+#include "../../iommu-sva.h"
 
 static bool disable_bypass = true;
 module_param(disable_bypass, bool, 0444);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1d6a62512bca..57a3d54c414b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -27,7 +27,7 @@
 #include <linux/tboot.h>
 
 #include "../irq_remapping.h"
-#include "../iommu-sva-lib.h"
+#include "../iommu-sva.h"
 #include "pasid.h"
 #include "cap_audit.h"
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c76b99b46626..b6b83ca705d5 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -25,7 +25,7 @@
 
 #include "pasid.h"
 #include "perf.h"
-#include "../iommu-sva-lib.h"
+#include "../iommu-sva.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, u32 pasid);
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 159e4f107fe3..5468993c8c6c 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
-#include "iommu-sva-lib.h"
+#include "iommu-sva.h"
 
 /**
  * struct iopf_queue - IO Page Fault queue
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva.c
similarity index 99%
rename from drivers/iommu/iommu-sva-lib.c
rename to drivers/iommu/iommu-sva.c
index a53574f9559a..dbe4b9958e48 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva.c
@@ -7,7 +7,7 @@
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
 
-#include "iommu-sva-lib.h"
+#include "iommu-sva.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
 static DECLARE_IOASID_SET(iommu_sva_pasid);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6b51ead9d63b..f4a5d6351421 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -27,7 +27,7 @@
 #include <linux/cc_platform.h>
 #include <trace/events/iommu.h>
 
-#include "iommu-sva-lib.h"
+#include "iommu-sva.h"
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 44475a9b3eea..c1763476162b 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -27,6 +27,6 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
-obj-$(CONFIG_IOMMU_SVA) += iommu-sva-lib.o io-pgfault.o
+obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
-- 
2.25.1

