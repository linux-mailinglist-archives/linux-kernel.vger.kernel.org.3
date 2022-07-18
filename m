Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02116578E86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiGRX6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiGRX6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:58:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BE823BC3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658188693; x=1689724693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jY4YCblaNCyb/LRbAS6ElI6rZb3UlpHUJJKbMY1wf3g=;
  b=Gdy5mHn0Krm10lT42MPAtOyeRSwOOKHSMQF3Z+hd/TGVhsKDT9DmMTaL
   sfshQBYj3US90lcdjuGzz0Zr+pbccu8Ay9VY6GstddZLZu//5dxxNOk1X
   FKf65y6+CbGIoew3cS+zNnwNpE76aKot9yKQV3+Kc7gv4ZMImoWfliNws
   tGNgusfNMgddmz/HMihLibz1ytYi0+O0wKBlihZqgs/OEFGIr1zzxcGZ2
   OLZsvKyPA+97rIf+cyso6s6t/hka+wEScXSIPf8la8wibHC3QaKP37PIu
   DrmlQi+qVRP0clFeo+WH5TLCFfMb3/+FiXAoR8CJlglTNCAmSYn02D+fJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="350312144"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="350312144"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 16:58:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="624940776"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2022 16:58:11 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix possible recursive locking in intel_iommu_init()
Date:   Tue, 19 Jul 2022 07:53:25 +0800
Message-Id: <20220718235325.3952426-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global rwsem dmar_global_lock was introduced by commit 3a5670e8ac932
("iommu/vt-d: Introduce a rwsem to protect global data structures"). It
is used to protect DMAR related global data from DMAR and PCI devices
hotplug operations.

The dmar_global_lock used in the intel_iommu_init() might cause recursive
locking issue, where intel_iommu_get_resv_regions() is taking the
dmar_global_lock from within a section where intel_iommu_init() already
holds it via probe_acpi_namespace_devices().

Using dmar_global_lock in intel_iommu_init() is unnecessary since it is
unlikely that any IO board must be hot added during the early boot stage.
This fixes the possible recursive locking issue by moving down DMAR and
PCI devices hotplug support after the IOMMU is initialized and removing
the dmar_global_lock uses in intel_iommu_init().

Fixes: d5692d4af08cd ("iommu/vt-d: Fix suspicious RCU usage in probe_acpi_namespace_devices()")
Reported-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/linux-iommu/894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/dmar.h        |  4 +++-
 drivers/iommu/intel/dmar.c  |  7 +++++++
 drivers/iommu/intel/iommu.c | 27 ++-------------------------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index d81a51978d01..8917a32173c4 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -65,6 +65,7 @@ struct dmar_pci_notify_info {
 
 extern struct rw_semaphore dmar_global_lock;
 extern struct list_head dmar_drhd_units;
+extern int intel_iommu_enabled;
 
 #define for_each_drhd_unit(drhd)					\
 	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
@@ -88,7 +89,8 @@ extern struct list_head dmar_drhd_units;
 static inline bool dmar_rcu_check(void)
 {
 	return rwsem_is_locked(&dmar_global_lock) ||
-	       system_state == SYSTEM_BOOTING;
+	       system_state == SYSTEM_BOOTING ||
+	       (IS_ENABLED(CONFIG_INTEL_IOMMU) && !intel_iommu_enabled);
 }
 
 #define	dmar_rcu_dereference(p)	rcu_dereference_check((p), dmar_rcu_check())
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 6327b34f5aa7..63f32dfece82 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2349,6 +2349,13 @@ static int dmar_device_hotplug(acpi_handle handle, bool insert)
 	if (!dmar_in_use())
 		return 0;
 
+	/*
+	 * It's unlikely that any I/O board is hot added before the IOMMU
+	 * subsystem is initialized.
+	 */
+	if (IS_ENABLED(CONFIG_INTEL_IOMMU) && !intel_iommu_enabled)
+		return -EOPNOTSUPP;
+
 	if (dmar_detect_dsm(handle, DMAR_DSM_FUNC_DRHD)) {
 		tmp = handle;
 	} else {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7cca030a508e..59064cf92e7b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3013,13 +3013,7 @@ static int __init init_dmars(void)
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
-			/*
-			 * Call dmar_alloc_hwirq() with dmar_global_lock held,
-			 * could cause possible lock race condition.
-			 */
-			up_write(&dmar_global_lock);
 			ret = intel_svm_enable_prq(iommu);
-			down_write(&dmar_global_lock);
 			if (ret)
 				goto free_iommu;
 		}
@@ -3932,7 +3926,6 @@ int __init intel_iommu_init(void)
 	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
 		    platform_optin_force_iommu();
 
-	down_write(&dmar_global_lock);
 	if (dmar_table_init()) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMAR table\n");
@@ -3945,16 +3938,6 @@ int __init intel_iommu_init(void)
 		goto out_free_dmar;
 	}
 
-	up_write(&dmar_global_lock);
-
-	/*
-	 * The bus notifier takes the dmar_global_lock, so lockdep will
-	 * complain later when we register it under the lock.
-	 */
-	dmar_register_bus_notifier();
-
-	down_write(&dmar_global_lock);
-
 	if (!no_iommu)
 		intel_iommu_debugfs_init();
 
@@ -3999,11 +3982,9 @@ int __init intel_iommu_init(void)
 		pr_err("Initialization failed\n");
 		goto out_free_dmar;
 	}
-	up_write(&dmar_global_lock);
 
 	init_iommu_pm_ops();
 
-	down_read(&dmar_global_lock);
 	for_each_active_iommu(iommu, drhd) {
 		/*
 		 * The flush queue implementation does not perform
@@ -4021,13 +4002,11 @@ int __init intel_iommu_init(void)
 				       "%s", iommu->name);
 		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
 	}
-	up_read(&dmar_global_lock);
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
 	if (si_domain && !hw_pass_through)
 		register_memory_notifier(&intel_iommu_memory_nb);
 
-	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
 		pr_warn("ACPI name space devices didn't probe correctly\n");
 
@@ -4038,17 +4017,15 @@ int __init intel_iommu_init(void)
 
 		iommu_disable_protect_mem_regions(iommu);
 	}
-	up_read(&dmar_global_lock);
-
-	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 	intel_iommu_enabled = 1;
+	dmar_register_bus_notifier();
+	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 	return 0;
 
 out_free_dmar:
 	intel_iommu_free_dmars();
-	up_write(&dmar_global_lock);
 	return ret;
 }
 
-- 
2.25.1

