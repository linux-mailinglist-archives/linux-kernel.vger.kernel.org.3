Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488524796C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhLQWB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:01:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:26498 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhLQWBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778509; x=1671314509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwIHb5zj6Jp1q7vDF3B1k2nArvxSaD/bhIY0C76LGDw=;
  b=atbhhPMGXwDYBU6qZeuMShaea6WO6Ri2kqlObXlIpLWriAkLqN6QQtHU
   7wPcyIsvVbRhrHpN9AZ9paQUA17Q7MFCvBz1xi8g9xsXaFnBmXv5w+Jaz
   +Yv1fjL417f5ggga1M78nrNZ9JhOnUszQoA+nynHI2uyKOF7RSMGm2vhI
   V0lF0y+PrFMziGODCcp4kumTeesx2f5h8kgTH34rBwjxYC8WhAkEq8uVH
   qYC2HMbpIACJWRdxEMCV5vGXxa2/d/fiM0fGrasQroBjG3cao7pss9e08
   o8DVgFZSElNi5EGzYqZsJ9xcfR95Rl5MyG5Ai+xENptt8YEegUPCMwJfe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381591"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381591"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928094"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:48 -0800
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
Subject: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit
Date:   Fri, 17 Dec 2021 22:01:30 +0000
Message-Id: <20211217220136.2762116-6-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid complexity of updating each thread's PASID status (e.g. sending
IPI to update IA32_PASID MSR) on allocating and freeing PASID, once
allocated and assigned to an mm, the PASID stays with the mm for the
rest of the mm's lifetime. A reference to the PASID is taken on
allocating the PASID. Binding/unbinding the PASID won't change refcount.
The reference is dropped on mm exit and thus the PASID is freed.

Two helpers mm_pasid_get() and mm_pasid_drop() are defined in mm because
the PASID operations handle the pasid member in mm_struct and should be
part of mm operations.

20-bit PASID allows up to 1M processes bound to PASIDs at the same time.
With cgroups and other controls that might limit the number of process
creation, the limited number of PASIDs is not a realistic issue for
lazy PASID free.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Free PASID on mm exit instead of in exit(2) or unbind() (Thomas, AndyL,
  PeterZ)
- Add mm_pasid_init(), mm_pasid_get(), and mm_pasid_drop() functions in mm.
  So the mm's PASID operations are generic for both X86 and ARM
  (Dave Hansen)

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  5 +--
 drivers/iommu/intel/svm.c                     |  9 -----
 drivers/iommu/iommu-sva-lib.c                 | 39 ++++++-------------
 drivers/iommu/iommu-sva-lib.h                 |  1 -
 include/linux/sched/mm.h                      | 16 ++++++++
 kernel/fork.c                                 |  1 +
 6 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index ee66d1f4cb81..c153ffae5462 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -340,14 +340,12 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
 	if (IS_ERR(bond->smmu_mn)) {
 		ret = PTR_ERR(bond->smmu_mn);
-		goto err_free_pasid;
+		goto err_free_bond;
 	}
 
 	list_add(&bond->list, &master->bonds);
 	return &bond->sva;
 
-err_free_pasid:
-	iommu_sva_free_pasid(mm);
 err_free_bond:
 	kfree(bond);
 	return ERR_PTR(ret);
@@ -377,7 +375,6 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
 	if (refcount_dec_and_test(&bond->refs)) {
 		list_del(&bond->list);
 		arm_smmu_mmu_notifier_put(bond->smmu_mn);
-		iommu_sva_free_pasid(bond->mm);
 		kfree(bond);
 	}
 	mutex_unlock(&sva_lock);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5b5d69b04fcc..51ac2096b3da 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -514,11 +514,6 @@ static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
 	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
 }
 
-static void intel_svm_free_pasid(struct mm_struct *mm)
-{
-	iommu_sva_free_pasid(mm);
-}
-
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
 					   struct mm_struct *mm,
@@ -662,8 +657,6 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 				kfree(svm);
 			}
 		}
-		/* Drop a PASID reference and free it if no reference. */
-		intel_svm_free_pasid(mm);
 	}
 out:
 	return ret;
@@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void
 	}
 
 	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
-	if (IS_ERR_OR_NULL(sva))
-		intel_svm_free_pasid(mm);
 	mutex_unlock(&pasid_mutex);
 
 	return sva;
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index bd41405d34e9..ee2294e02716 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -18,8 +18,7 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
  *
  * Try to allocate a PASID for this mm, or take a reference to the existing one
  * provided it fits within the [@min, @max] range. On success the PASID is
- * available in mm->pasid, and must be released with iommu_sva_free_pasid().
- * @min must be greater than 0, because 0 indicates an unused mm->pasid.
+ * available in mm->pasid and will be available for the lifetime of the mm.
  *
  * Returns 0 on success and < 0 on error.
  */
@@ -33,38 +32,24 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 		return -EINVAL;
 
 	mutex_lock(&iommu_sva_lock);
-	if (mm->pasid) {
-		if (mm->pasid >= min && mm->pasid <= max)
-			ioasid_get(mm->pasid);
-		else
+	/* Is a PASID already associated with this mm? */
+	if (pasid_valid(mm->pasid)) {
+		if (mm->pasid < min || mm->pasid >= max)
 			ret = -EOVERFLOW;
-	} else {
-		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
-		if (pasid == INVALID_IOASID)
-			ret = -ENOMEM;
-		else
-			mm->pasid = pasid;
+		goto out;
 	}
+
+	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
+	if (!pasid_valid(pasid))
+		ret = -ENOMEM;
+	else
+		mm_pasid_get(mm, pasid);
+out:
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
 
-/**
- * iommu_sva_free_pasid - Release the mm's PASID
- * @mm: the mm
- *
- * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
- */
-void iommu_sva_free_pasid(struct mm_struct *mm)
-{
-	mutex_lock(&iommu_sva_lock);
-	if (ioasid_put(mm->pasid))
-		mm->pasid = 0;
-	mutex_unlock(&iommu_sva_lock);
-}
-EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
-
 /* ioasid_find getter() requires a void * argument */
 static bool __mmget_not_zero(void *mm)
 {
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 95dc3ebc1928..8909ea1094e3 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -9,7 +9,6 @@
 #include <linux/mm_types.h>
 
 int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
-void iommu_sva_free_pasid(struct mm_struct *mm);
 struct mm_struct *iommu_sva_find(ioasid_t pasid);
 
 /* I/O Page fault */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 394c4359c4e1..21cd094283ad 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -413,8 +413,24 @@ static inline void mm_pasid_init(struct mm_struct *mm)
 {
 	mm->pasid = INVALID_IOASID;
 }
+
+/* Associate a PASID with an mm_struct: */
+static inline void mm_pasid_get(struct mm_struct *mm, u32 pasid)
+{
+	mm->pasid = pasid;
+}
+
+static inline void mm_pasid_drop(struct mm_struct *mm)
+{
+	if (pasid_valid(mm->pasid)) {
+		ioasid_put(mm->pasid);
+		mm->pasid = INVALID_IOASID;
+	}
+}
 #else
 static inline void mm_pasid_init(struct mm_struct *mm) {}
+static inline void mm_pasid_get(struct mm_struct *mm, u32 pasid) {}
+static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif
 
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 4e799c9b13bb..3adad225cc09 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1114,6 +1114,7 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+	mm_pasid_drop(mm);
 	mmdrop(mm);
 }
 
-- 
2.34.1

