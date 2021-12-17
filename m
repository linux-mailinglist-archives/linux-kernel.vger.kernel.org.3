Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DAF4796C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhLQWBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:01:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:26492 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhLQWBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778508; x=1671314508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vrJ/zKRVUU6ZR06GrFfxZCmYCCjEMizfBdO6/ux2RvU=;
  b=JOsmFRhquO0/lkAVTgVBlCwKFAfp2cLo5PR+wlM5c3ku2pnFQ5RmIIeo
   zbiClsJYg4jCLevU9ZYKgtdMkyLikacHb8kP6vZaaWCO2jriXV9usIyXF
   mRRNWBlBK0hktsSFsA1/2zGLSp9UePpyuGGthWSyaA93Pse40KT/UFg3i
   BQb/zJ1GyGRdLs5m+2j5SEvfvZ8W3/vCYY8jHCCO97vbVxaEhqhtFcmDo
   Q13yKUFj6g3VDoJlf6bEs3lyLhE5ac5hSegucN1a6+OUBAdVfNTBxVPat
   lf4dCgLOMOuUjQqKxUavkIxaewceK6khdGfs/+7qM3g1WDeB0VS1vWQEa
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381584"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381584"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928073"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:46 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 01/11] iommu/sva: Rename CONFIG_IOMMU_SVA_LIB to CONFIG_IOMMU_SVA
Date:   Fri, 17 Dec 2021 22:01:26 +0000
Message-Id: <20211217220136.2762116-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This CONFIG option originally only referred to the Shared
Virtual Address (SVA) library. But it is now also used for
non-library portions of code.

Drop the "_LIB" suffix so that there is just one configuration
options for all code relating to SVA.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Add this patch for more meaningful name CONFIG_IOMMU_SVA

 drivers/iommu/Kconfig         | 6 +++---
 drivers/iommu/Makefile        | 2 +-
 drivers/iommu/intel/Kconfig   | 2 +-
 drivers/iommu/iommu-sva-lib.h | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 3eb68fa1b8cc..c79a0df090c0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -144,8 +144,8 @@ config IOMMU_DMA
 	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
 
-# Shared Virtual Addressing library
-config IOMMU_SVA_LIB
+# Shared Virtual Addressing
+config IOMMU_SVA
 	bool
 	select IOASID
 
@@ -379,7 +379,7 @@ config ARM_SMMU_V3
 config ARM_SMMU_V3_SVA
 	bool "Shared Virtual Addressing support for the ARM SMMUv3"
 	depends on ARM_SMMU_V3
-	select IOMMU_SVA_LIB
+	select IOMMU_SVA
 	select MMU_NOTIFIER
 	help
 	  Support for sharing process address spaces with devices using the
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index bc7f730edbb0..44475a9b3eea 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -27,6 +27,6 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
-obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o io-pgfault.o
+obj-$(CONFIG_IOMMU_SVA) += iommu-sva-lib.o io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 247d0f2d5fdf..39a06d245f12 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -52,7 +52,7 @@ config INTEL_IOMMU_SVM
 	select PCI_PRI
 	select MMU_NOTIFIER
 	select IOASID
-	select IOMMU_SVA_LIB
+	select IOMMU_SVA
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 031155010ca8..95dc3ebc1928 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -17,7 +17,7 @@ struct device;
 struct iommu_fault;
 struct iopf_queue;
 
-#ifdef CONFIG_IOMMU_SVA_LIB
+#ifdef CONFIG_IOMMU_SVA
 int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
 
 int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev);
@@ -28,7 +28,7 @@ struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
 
-#else /* CONFIG_IOMMU_SVA_LIB */
+#else /* CONFIG_IOMMU_SVA */
 static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
 {
 	return -ENODEV;
@@ -64,5 +64,5 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
 {
 	return -ENODEV;
 }
-#endif /* CONFIG_IOMMU_SVA_LIB */
+#endif /* CONFIG_IOMMU_SVA */
 #endif /* _IOMMU_SVA_LIB_H */
-- 
2.34.1

