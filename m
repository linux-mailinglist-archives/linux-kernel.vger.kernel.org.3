Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CB849B784
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349811AbiAYPWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:22:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:31994 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1581991AbiAYPTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643123952; x=1674659952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s4ZvmzsF0fERLoGFRxsy+2A2MHLZif0dxtVpyXm9a+8=;
  b=XO42G8jzk2+r3WlNMwKqqGZGNxk2EWA3idkjrGMAiSaZuH7OJhXWLdEc
   E5Q5zPankoA4pyin5J400QYUKGYVr5H5s6fzuh2RP/TllMxUmMhu57Zxe
   pMsAreKYxQbkMT4CEU17Bjc438X5McpB4Ts95Xa507hyp/CB6Dplj9VFr
   0QB7SXcv6GkxA24tTGlu4xic6w6AVLhO6ol1jJOpkV+Jd109vhxquhaoY
   9AbY9x4N/G2MJQ+w8c0W/Eww2fV58MJxtQcFDpqR8mzjyJ+8Yl62CrpuU
   yCGRdMOElrxjz2JXJQXrXyk3absTIIEnHVjcl14UEz3Rar7BPPF45Q1uZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226301229"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="226301229"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 07:18:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="520414512"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 07:18:27 -0800
Date:   Tue, 25 Jan 2022 07:18:18 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YfAUutQhqS6ejUFU@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com>
 <87ee4w6g1n.ffs@tglx>
 <87bl006fdb.ffs@tglx>
 <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com>
 <878rv46eg3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rv46eg3.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Mon, Jan 24, 2022 at 09:55:56PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 24 2022 at 12:52, Fenghua Yu wrote:
> > On Mon, Jan 24, 2022 at 09:36:00PM +0100, Thomas Gleixner wrote:
> >> On Mon, Jan 24 2022 at 21:21, Thomas Gleixner wrote:
> > Ah. This patch should remove ioasid_get(). So I will change this patch
> > as follows:
> >
> > 1. Remove ioasid_get() because it's not used any more when IOASID's
> >    refcount is set to 1 once the IOASID is allocated and is freed on mm exit.
> > 2. Change mm_pasid_get() to mm_pasid_set().
> 
> Yes. Just resend this one. No need to post the full queue again.

Here is the updated patch #5. Thank you very much for your review!

From 895f2c15385dc93acf39700014458fe275d996a2 Mon Sep 17 00:00:00 2001
From: Fenghua Yu <fenghua.yu@intel.com>
Date: Thu, 18 Nov 2021 14:06:40 -0800
Subject: [PATCH v2.1 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit

To avoid complexity of updating each thread's PASID status (e.g. sending
IPI to update IA32_PASID MSR) on allocating and freeing PASID, once
allocated and assigned to an mm, the PASID stays with the mm for the
rest of the mm's lifetime. A reference to the PASID is taken on
allocating the PASID. Binding/unbinding the PASID won't change refcount.
The reference is dropped on mm exit and thus the PASID is freed.

Two helpers mm_pasid_set() and mm_pasid_drop() are defined in mm because
the PASID operations handle the pasid member in mm_struct and should be
part of mm operations. Unused ioasid_get() and iommu_sva_free_pasid()
are deleted.

20-bit PASID allows up to 1M processes bound to PASIDs at the same time.
With cgroups and other controls that might limit the number of process
creation, the limited number of PASIDs is not a realistic issue for
lazy PASID free.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2.1:
- Rename mm_pasid_get() to mm_pasid_set() (Thomas).
- Remove ioasid_get() because it's not used any more when IOASID's
  refcount is set to 1 once the IOASID is allocated and is freed
  on mm exit (Thomas).

v2:
- Free PASID on mm exit instead of in exit(2) or unbind() (Thomas, AndyL,
  PeterZ)
- Add mm_pasid_init(), mm_pasid_get(), and mm_pasid_drop() functions in mm.
  So the mm's PASID operations are generic for both X86 and ARM
  (Dave Hansen)

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  5 +--
 drivers/iommu/intel/svm.c                     |  9 -----
 drivers/iommu/ioasid.c                        | 17 --------
 drivers/iommu/iommu-sva-lib.c                 | 39 ++++++-------------
 drivers/iommu/iommu-sva-lib.h                 |  1 -
 include/linux/ioasid.h                        |  5 ---
 include/linux/sched/mm.h                      | 16 ++++++++
 kernel/fork.c                                 |  1 +
 8 files changed, 30 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a737ba5f727e..22ddd05bbdcd 100644
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
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 50ee27bbd04e..cb8e74adb685 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -347,23 +347,6 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 }
 EXPORT_SYMBOL_GPL(ioasid_alloc);
 
-/**
- * ioasid_get - obtain a reference to the IOASID
- */
-void ioasid_get(ioasid_t ioasid)
-{
-	struct ioasid_data *ioasid_data;
-
-	spin_lock(&ioasid_allocator_lock);
-	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (ioasid_data)
-		refcount_inc(&ioasid_data->refs);
-	else
-		WARN_ON(1);
-	spin_unlock(&ioasid_allocator_lock);
-}
-EXPORT_SYMBOL_GPL(ioasid_get);
-
 /**
  * ioasid_put - Release a reference to an ioasid
  * @ioasid: the ID to remove
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index bd41405d34e9..106506143896 100644
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
+		mm_pasid_set(mm, pasid);
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
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 2237f64dbaae..46a41f61ad3e 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -34,7 +34,6 @@ struct ioasid_allocator_ops {
 #if IS_ENABLED(CONFIG_IOASID)
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
-void ioasid_get(ioasid_t ioasid);
 bool ioasid_put(ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
@@ -53,10 +52,6 @@ static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 	return INVALID_IOASID;
 }
 
-static inline void ioasid_get(ioasid_t ioasid)
-{
-}
-
 static inline bool ioasid_put(ioasid_t ioasid)
 {
 	return false;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index c74d1edbac2f..1893ecfa93d6 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -439,8 +439,24 @@ static inline void mm_pasid_init(struct mm_struct *mm)
 {
 	mm->pasid = INVALID_IOASID;
 }
+
+/* Associate a PASID with an mm_struct: */
+static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
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
+static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
+static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif
 
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index deacd2c17a7f..c03c6682464c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1115,6 +1115,7 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+	mm_pasid_drop(mm);
 	mmdrop(mm);
 }
 
-- 
2.34.1

