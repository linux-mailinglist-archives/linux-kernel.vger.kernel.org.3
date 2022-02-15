Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BC44B69DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiBOKyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:54:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiBOKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:54:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97EAD76E6;
        Tue, 15 Feb 2022 02:54:32 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644922471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wkiwjypq8zf1cZ8U81Bwa08guYdUw5x3SwReyORkGh8=;
        b=phWV7ITvbdulA2Ub3OXEkShlebhhmWQamWbzDGX9jC0+kPBmbajcAJfDBQPmjUxHy0T2O4
        pxNlDxA8cnNYnmefg4B750KWM0Z7y4oyrU52W1RUgf4cxgsZ/o4VocpdjmswuM4+DeUE0G
        bO3k5bsEQ5vzkqWtBUWDjkNPvQ0qFre8U94GT3zPt1Wo0asjILnm/q3jYZy8oITUsY4qrJ
        0FaQ7UC5DxpkYAeHXAWAPxMEVoyemQQFdh8tj1dueHzJDh3EDnFuSJ2ZhvAE1Urr2tJgGG
        OHvDTznDtBnVdsldrtzMKsnslv3D64LWWaQCGW+4tnuM1dLxTGKZWLrXFgPrFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644922471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wkiwjypq8zf1cZ8U81Bwa08guYdUw5x3SwReyORkGh8=;
        b=HVbLn8qDnNAXrUb66exHGBbhXJzqYZTFOIge0iKMjGC/zBoKDGRHnAtljSrPqMpURRv9R5
        cuNi3sjKsHhVJkBA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] iommu/sva: Assign a PASID to mm on PASID allocation
 and free it on mm exit
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207230254.3342514-6-fenghua.yu@intel.com>
References: <20220207230254.3342514-6-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <164492247040.16921.8852539824628758762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     701fac40384f07197b106136012804c3cae0b3de
Gitweb:        https://git.kernel.org/tip/701fac40384f07197b106136012804c3cae0b3de
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 07 Feb 2022 15:02:48 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Feb 2022 11:31:35 +01:00

iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit

PASIDs are process-wide. It was attempted to use refcounted PASIDs to
free them when the last thread drops the refcount. This turned out to
be complex and error prone. Given the fact that the PASID space is 20
bits, which allows up to 1M processes to have a PASID associated
concurrently, PASID resource exhaustion is not a realistic concern.

Therefore, it was decided to simplify the approach and stick with lazy
on demand PASID allocation, but drop the eager free approach and make an
allocated PASID's lifetime bound to the lifetime of the process.

Get rid of the refcounting mechanisms and replace/rename the interfaces
to reflect this new approach.

  [ bp: Massage commit message. ]

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20220207230254.3342514-6-fenghua.yu@intel.com
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  5 +--
 drivers/iommu/intel/iommu.c                     |  4 +-
 drivers/iommu/intel/svm.c                       |  9 +----
 drivers/iommu/ioasid.c                          | 39 +---------------
 drivers/iommu/iommu-sva-lib.c                   | 39 ++++------------
 drivers/iommu/iommu-sva-lib.h                   |  1 +-
 include/linux/ioasid.h                          | 12 +-----
 include/linux/sched/mm.h                        | 16 +++++++-
 kernel/fork.c                                   |  1 +-
 9 files changed, 38 insertions(+), 88 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a737ba5..22ddd05 100644
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
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3f..ef03b21 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4781,7 +4781,7 @@ attach_failed:
 link_failed:
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
+		ioasid_free(domain->default_pasid);
 
 	return ret;
 }
@@ -4811,7 +4811,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
+		ioasid_free(domain->default_pasid);
 }
 
 static int prepare_domain_attach_device(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5b5d69b..51ac209 100644
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
index 06fee74..a786c03 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -2,7 +2,7 @@
 /*
  * I/O Address Space ID allocator. There is one global IOASID space, split into
  * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
- * free IOASIDs with ioasid_alloc and ioasid_put.
+ * free IOASIDs with ioasid_alloc() and ioasid_free().
  */
 #include <linux/ioasid.h>
 #include <linux/module.h>
@@ -15,7 +15,6 @@ struct ioasid_data {
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
-	refcount_t refs;
 };
 
 /*
@@ -315,7 +314,6 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	data->set = set;
 	data->private = private;
-	refcount_set(&data->refs, 1);
 
 	/*
 	 * Custom allocator needs allocator data to perform platform specific
@@ -348,35 +346,11 @@ exit_free:
 EXPORT_SYMBOL_GPL(ioasid_alloc);
 
 /**
- * ioasid_get - obtain a reference to the IOASID
- * @ioasid: the ID to get
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
-/**
- * ioasid_put - Release a reference to an ioasid
+ * ioasid_free - Free an ioasid
  * @ioasid: the ID to remove
- *
- * Put a reference to the IOASID, free it when the number of references drops to
- * zero.
- *
- * Return: %true if the IOASID was freed, %false otherwise.
  */
-bool ioasid_put(ioasid_t ioasid)
+void ioasid_free(ioasid_t ioasid)
 {
-	bool free = false;
 	struct ioasid_data *ioasid_data;
 
 	spin_lock(&ioasid_allocator_lock);
@@ -386,10 +360,6 @@ bool ioasid_put(ioasid_t ioasid)
 		goto exit_unlock;
 	}
 
-	free = refcount_dec_and_test(&ioasid_data->refs);
-	if (!free)
-		goto exit_unlock;
-
 	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
 	/* Custom allocator needs additional steps to free the xa element */
 	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
@@ -399,9 +369,8 @@ bool ioasid_put(ioasid_t ioasid)
 
 exit_unlock:
 	spin_unlock(&ioasid_allocator_lock);
-	return free;
 }
-EXPORT_SYMBOL_GPL(ioasid_put);
+EXPORT_SYMBOL_GPL(ioasid_free);
 
 /**
  * ioasid_find - Find IOASID data
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index bd41405..1065061 100644
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
index 95dc3eb..8909ea1 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -9,7 +9,6 @@
 #include <linux/mm_types.h>
 
 int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
-void iommu_sva_free_pasid(struct mm_struct *mm);
 struct mm_struct *iommu_sva_find(ioasid_t pasid);
 
 /* I/O Page fault */
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 2237f64..af1c9d6 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -34,8 +34,7 @@ struct ioasid_allocator_ops {
 #if IS_ENABLED(CONFIG_IOASID)
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
-void ioasid_get(ioasid_t ioasid);
-bool ioasid_put(ioasid_t ioasid);
+void ioasid_free(ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
@@ -53,14 +52,7 @@ static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 	return INVALID_IOASID;
 }
 
-static inline void ioasid_get(ioasid_t ioasid)
-{
-}
-
-static inline bool ioasid_put(ioasid_t ioasid)
-{
-	return false;
-}
+static inline void ioasid_free(ioasid_t ioasid) { }
 
 static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 				bool (*getter)(void *))
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index c74d1ed..a80356e 100644
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
+		ioasid_free(mm->pasid);
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
index deacd2c..c03c668 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1115,6 +1115,7 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+	mm_pasid_drop(mm);
 	mmdrop(mm);
 }
 
