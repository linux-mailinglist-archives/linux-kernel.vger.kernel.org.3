Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F9E50E2C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbiDYOPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbiDYOP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:15:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1072B2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:12:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v12so14250079wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7ROoFHp6/1y9xkjil8QACs0v84I+RfrVQSetxvalaE=;
        b=joTij7LHJRlUeIed4osoNFHiS2aC/aqGn0h2FWAV7nK6BEejUYi8KEUqwxE2V3yTFP
         rogG7V1tg0Q1LDyOsrlgnTmIo40sMnK+viT+EWttKRJlxE0wq6y3oI4tGtyvtlka1M4H
         rChobTBG2Nh4A5zKSnT4tseSchDo1mChLGse7shiwEsg2hC2M3BROQLEk3Y86GHRHlU7
         vIRbpbFnjVHnenLgn+ozr+vdJk9tUTxjr36Xzx4uumel+JgHMPaU6whQH64Tcno5MgHB
         YfDgB4qiYLybsyS3//f2vvjgIDj37hmpQsoY4jE3jpJMkDTb/9UbZ1p9fuG5+JN+08M5
         vfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7ROoFHp6/1y9xkjil8QACs0v84I+RfrVQSetxvalaE=;
        b=NEkAkThuwEpS5MsnMQK3P49Q2l5AquCHWBHaIOXGoFIvfk5EGTxLf9LHM0kTDvRGN9
         oRR75R/sgC5C3OtWZkv/Gfd0UJsm4iLeXKayCMnlCFEsIcey+o5wxwo+e9hquwvUnhzL
         tbOId4q6KPVcwkMOHoarfvjNrxawPxddQyosO3idFNjqz7ls4M7qEdiTghnha3Hl7KV2
         JmD2DdEeZWPcYF5kEIT4xBIUtMqAOe5nE49KGWRocVwapWbnSLowG8J4JCB4fph1aKOp
         Wtj1zvujHJ0/1sHSfmzVU+aRU2MHALsbIYIJyGqN2Z362dEeE7p1yiT0mpvoCl/+fUqa
         4j9g==
X-Gm-Message-State: AOAM530ytgaf3uO0vSB/G6cpDFfQBb6KhXD0dl2F8EdokSz9D03NRj3r
        TxfHwquc2Mwpq0jslXKG+wilfQ==
X-Google-Smtp-Source: ABdhPJzLgklRZw0X+TrE9IWqu3mhFAswV3EmvybPYrYGF3Bc2yOgI3GAQjW5Ulno6Bu1ZyxzLuUoqA==
X-Received: by 2002:adf:e0c5:0:b0:206:1ba3:26aa with SMTP id m5-20020adfe0c5000000b002061ba326aamr14302727wri.645.1650895941446;
        Mon, 25 Apr 2022 07:12:21 -0700 (PDT)
Received: from localhost.localdomain ([213.146.143.36])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d568e000000b00207ae498882sm8728954wrv.32.2022.04.25.07.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 07:12:21 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] iommu/sva: Revert mm_pasid_drop and reusing refcount in pasid allocation
Date:   Mon, 25 Apr 2022 22:12:11 +0800
Message-Id: <20220425141211.6699-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
allocation and free it on mm exit")

However the Arm code was written expecting the PASID to be freed on
unbind(), not mm exit.
The mm_pasid_drop in mmput free mm->pasid, which is only index,
but all related resources are still there.

This cause many strange issues:
For example, user driver is ended unexpectedly without calling unbind,
then mmput and mm_pasid_drop will free pasid.
Finally fops_release->unbind is called, error will happen
since mm->pasid = -1.

This also breaks nginx, where master process bind then fork child (daemon)
to manage all worker processes. The master process then exit and free ioasid
but all related resources are still there.
The worker process will alloc the same ioasid just freed, causing hardware
error.

Hardware reports:
[  152.731869] hisi_sec2 0000:76:00.0: qm_acc_do_task_timeout [error status=0x20] found
[  152.739657] hisi_sec2 0000:76:00.0: qm_acc_wb_not_ready_timeout [error status=0x40] found
[  152.747877] hisi_sec2 0000:76:00.0: sec_fsm_hbeat_rint [error status=0x20] found
[  152.755340] hisi_sec2 0000:76:00.0: Controller resetting...
[  152.762044] hisi_sec2 0000:76:00.0: QM mailbox operation timeout!
[  152.768198] hisi_sec2 0000:76:00.0: Failed to dump sqc!
[  152.773490] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
[  152.781426] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
[  152.787468] hisi_sec2 0000:76:00.0: Failed to dump sqc!
[  152.792753] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
[  152.800685] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
[  152.806730] hisi_sec2 0000:76:00.0: Failed to dump sqc!
[  152.812017] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
[  152.819946] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
[  152.825992] hisi_sec2 0000:76:00.0: Failed to dump sqc!

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
This patch partily revert Commit 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
allocation and free it on mm exit") since it can not revert directly now.
And use pasid_valid accordingly 


 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  5 +++-
 drivers/iommu/intel/svm.c                       |  9 ++++++
 drivers/iommu/ioasid.c                          | 39 ++++++++++++++++++++++---
 drivers/iommu/iommu-sva-lib.c                   | 37 ++++++++++++++++-------
 drivers/iommu/iommu-sva-lib.h                   |  1 +
 include/linux/ioasid.h                          | 12 ++++++--
 include/linux/sched/mm.h                        | 16 ----------
 kernel/fork.c                                   |  1 -
 8 files changed, 85 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 22ddd05..a737ba5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -340,12 +340,14 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
 	if (IS_ERR(bond->smmu_mn)) {
 		ret = PTR_ERR(bond->smmu_mn);
-		goto err_free_bond;
+		goto err_free_pasid;
 	}
 
 	list_add(&bond->list, &master->bonds);
 	return &bond->sva;
 
+err_free_pasid:
+	iommu_sva_free_pasid(mm);
 err_free_bond:
 	kfree(bond);
 	return ERR_PTR(ret);
@@ -375,6 +377,7 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
 	if (refcount_dec_and_test(&bond->refs)) {
 		list_del(&bond->list);
 		arm_smmu_mmu_notifier_put(bond->smmu_mn);
+		iommu_sva_free_pasid(bond->mm);
 		kfree(bond);
 	}
 	mutex_unlock(&sva_lock);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 23a3876..241d095 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -322,6 +322,11 @@ static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
 	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
 }
 
+static void intel_svm_free_pasid(struct mm_struct *mm)
+{
+	iommu_sva_free_pasid(mm);
+}
+
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
 					   struct mm_struct *mm,
@@ -465,6 +470,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 				kfree(svm);
 			}
 		}
+		/* Drop a PASID reference and free it if no reference. */
+		intel_svm_free_pasid(mm);
 	}
 out:
 	return ret;
@@ -848,6 +855,8 @@ struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void
 	}
 
 	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
+	if (IS_ERR_OR_NULL(sva))
+		intel_svm_free_pasid(mm);
 	mutex_unlock(&pasid_mutex);
 
 	return sva;
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index a786c034..06fee74 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -2,7 +2,7 @@
 /*
  * I/O Address Space ID allocator. There is one global IOASID space, split into
  * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
- * free IOASIDs with ioasid_alloc() and ioasid_free().
+ * free IOASIDs with ioasid_alloc and ioasid_put.
  */
 #include <linux/ioasid.h>
 #include <linux/module.h>
@@ -15,6 +15,7 @@ struct ioasid_data {
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
+	refcount_t refs;
 };
 
 /*
@@ -314,6 +315,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	data->set = set;
 	data->private = private;
+	refcount_set(&data->refs, 1);
 
 	/*
 	 * Custom allocator needs allocator data to perform platform specific
@@ -346,11 +348,35 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 EXPORT_SYMBOL_GPL(ioasid_alloc);
 
 /**
- * ioasid_free - Free an ioasid
+ * ioasid_get - obtain a reference to the IOASID
+ * @ioasid: the ID to get
+ */
+void ioasid_get(ioasid_t ioasid)
+{
+	struct ioasid_data *ioasid_data;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+	if (ioasid_data)
+		refcount_inc(&ioasid_data->refs);
+	else
+		WARN_ON(1);
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_get);
+
+/**
+ * ioasid_put - Release a reference to an ioasid
  * @ioasid: the ID to remove
+ *
+ * Put a reference to the IOASID, free it when the number of references drops to
+ * zero.
+ *
+ * Return: %true if the IOASID was freed, %false otherwise.
  */
-void ioasid_free(ioasid_t ioasid)
+bool ioasid_put(ioasid_t ioasid)
 {
+	bool free = false;
 	struct ioasid_data *ioasid_data;
 
 	spin_lock(&ioasid_allocator_lock);
@@ -360,6 +386,10 @@ void ioasid_free(ioasid_t ioasid)
 		goto exit_unlock;
 	}
 
+	free = refcount_dec_and_test(&ioasid_data->refs);
+	if (!free)
+		goto exit_unlock;
+
 	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
 	/* Custom allocator needs additional steps to free the xa element */
 	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
@@ -369,8 +399,9 @@ void ioasid_free(ioasid_t ioasid)
 
 exit_unlock:
 	spin_unlock(&ioasid_allocator_lock);
+	return free;
 }
-EXPORT_SYMBOL_GPL(ioasid_free);
+EXPORT_SYMBOL_GPL(ioasid_put);
 
 /**
  * ioasid_find - Find IOASID data
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 1065061..175cfd8 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -18,7 +18,8 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
  *
  * Try to allocate a PASID for this mm, or take a reference to the existing one
  * provided it fits within the [@min, @max] range. On success the PASID is
- * available in mm->pasid and will be available for the lifetime of the mm.
+ * available in mm->pasid, and must be released with iommu_sva_free_pasid().
+ * @min must be greater than 0, because 0 indicates an unused mm->pasid.
  *
  * Returns 0 on success and < 0 on error.
  */
@@ -32,24 +33,38 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 		return -EINVAL;
 
 	mutex_lock(&iommu_sva_lock);
-	/* Is a PASID already associated with this mm? */
 	if (pasid_valid(mm->pasid)) {
-		if (mm->pasid < min || mm->pasid >= max)
+		if (mm->pasid >= min && mm->pasid <= max)
+			ioasid_get(mm->pasid);
+		else
 			ret = -EOVERFLOW;
-		goto out;
+	} else {
+		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
+		if (!pasid_valid(pasid))
+			ret = -ENOMEM;
+		else
+			mm->pasid = pasid;
 	}
-
-	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
-	if (!pasid_valid(pasid))
-		ret = -ENOMEM;
-	else
-		mm_pasid_set(mm, pasid);
-out:
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
 
+/**
+ * iommu_sva_free_pasid - Release the mm's PASID
+ * @mm: the mm
+ *
+ * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
+ */
+void iommu_sva_free_pasid(struct mm_struct *mm)
+{
+	mutex_lock(&iommu_sva_lock);
+	if (ioasid_put(mm->pasid))
+		mm->pasid = 0;
+	mutex_unlock(&iommu_sva_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
+
 /* ioasid_find getter() requires a void * argument */
 static bool __mmget_not_zero(void *mm)
 {
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 8909ea1..95dc3eb 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -9,6 +9,7 @@
 #include <linux/mm_types.h>
 
 int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
+void iommu_sva_free_pasid(struct mm_struct *mm);
 struct mm_struct *iommu_sva_find(ioasid_t pasid);
 
 /* I/O Page fault */
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index af1c9d6..2237f64 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -34,7 +34,8 @@ struct ioasid_allocator_ops {
 #if IS_ENABLED(CONFIG_IOASID)
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
-void ioasid_free(ioasid_t ioasid);
+void ioasid_get(ioasid_t ioasid);
+bool ioasid_put(ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
@@ -52,7 +53,14 @@ static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 	return INVALID_IOASID;
 }
 
-static inline void ioasid_free(ioasid_t ioasid) { }
+static inline void ioasid_get(ioasid_t ioasid)
+{
+}
+
+static inline bool ioasid_put(ioasid_t ioasid)
+{
+	return false;
+}
 
 static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 				bool (*getter)(void *))
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 1ad1f4b..5990844 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -447,24 +447,8 @@ static inline void mm_pasid_init(struct mm_struct *mm)
 {
 	mm->pasid = INVALID_IOASID;
 }
-
-/* Associate a PASID with an mm_struct: */
-static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
-{
-	mm->pasid = pasid;
-}
-
-static inline void mm_pasid_drop(struct mm_struct *mm)
-{
-	if (pasid_valid(mm->pasid)) {
-		ioasid_free(mm->pasid);
-		mm->pasid = INVALID_IOASID;
-	}
-}
 #else
 static inline void mm_pasid_init(struct mm_struct *mm) {}
-static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
-static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif
 
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897..f9f9f53f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1190,7 +1190,6 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
-	mm_pasid_drop(mm);
 	mmdrop(mm);
 }
 
-- 
2.7.4

