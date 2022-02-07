Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377EA4ACD54
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344530AbiBHBDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiBGXD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:03:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6409C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275006; x=1675811006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zzuc+4BUhDw8AYLm9O80nUHIQ9qam3U/ceY5Tn4nhdA=;
  b=Z1NV8vEue4+XvJgpq8m+LgU34fJB88t9X20q2iYroyVUAqscCAbr3cQG
   uPBQm8eQvG/DK6IEOs9oEHGCjq0fWfU/TSqtl5iX4EIp7S7OVnt4klLBQ
   rCVgxgPcPg+ZmSleAwE5n8KxCy6l7tfw4Gi9Ns5t4XENigsP0E0d3a/60
   W5m+IemVXS1Hvpc6xBZHK6P70QuZoZq06nlp/TDTFkV7yRTzO7GdGOXoG
   p69mOMjy7dmpalz3gIv2KjwDg9zQHzsz967C73URqIlJqD2noOKTpyaYt
   HL3+C2O9ZYL26C/9u127wNsjuAEO9N6Pijsai5pGW0xeLsxhYu4p0Evmt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229475001"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="229475001"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540324005"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:01 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
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
Subject: [PATCH v4 01/11] iommu/sva: Rename CONFIG_IOMMU_SVA_LIB to CONFIG_IOMMU_SVA
Date:   Mon,  7 Feb 2022 15:02:44 -0800
Message-Id: <20220207230254.3342514-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207230254.3342514-1-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v4:
- Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).

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
2.35.1

