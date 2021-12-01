Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFE6465654
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352716AbhLAT12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:27:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:46904 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245113AbhLAT1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="235267925"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="235267925"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500380452"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:42 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/25] x86/sgx: Use more generic name for enclave cpumask function
Date:   Wed,  1 Dec 2021 11:23:04 -0800
Message-Id: <a6667798da726f27e6b63029ab67da1fef5a771e.1638381245.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638381245.git.reinette.chatre@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Knowing which CPUs might have executed an enclave is useful to
ensure that TLBs are cleared when changes are made to enclave pages.

Knowing which CPUs might have executed an enclave is currently only used
within the reclaimer when an enclave page is evicted. In support of this
the function that determines the CPUs is called sgx_encl_ewb_cpumask() -
a name that is specific to the current usage.

Rename sgx_encl_ewb_cpumask() to sgx_encl_cpumask() in preparation for its
usage in more flows. Care should be taken to ensure that any
future usage maintains the current context requirement that ETRACK has
been called first. To highlight this the existing comments regarding
this context is expanded and moved to more prominent location.

With the usage of this function no longer unique to the reclaimer it is
relocated to be the rest of the enclave code in encl.c.

No functional change.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c | 67 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/encl.h |  1 +
 arch/x86/kernel/cpu/sgx/main.c | 31 +---------------
 3 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 6fec68896e1b..c29e10541d12 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -595,6 +595,73 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 	return 0;
 }
 
+/**
+ * sgx_encl_cpumask - Query which CPUs might be accessing the enclave
+ * @encl: the enclave
+ *
+ * Some SGX functions require that no cached linear-to-physical address
+ * mappings are present before they can succeed. For example, ENCLS[EWB]
+ * copies a page from the enclave page cache to regular main memory but
+ * it fails if it cannot ensure that there are no cached
+ * linear-to-physical address mappings referring to the page.
+ *
+ * SGX hardware flushes all cached linear-to-physical mappings on a CPU
+ * when an enclave is exited via ENCLU[EEXIT] or an Asynchronous Enclave
+ * Exit (AEX). Exiting an enclave will thus ensure cached linear-to-physical
+ * address mappings are cleared but coordination with the tracking done within
+ * the SGX hardware is needed to support the SGX functions that depend on this
+ * cache clearing.
+ *
+ * When the ENCLS[ETRACK] function is issued on an enclave the hardware
+ * tracks threads operating inside the enclave at that time. The SGX
+ * hardware tracking require that all the identified threads must have
+ * exited the enclave in order to flush the mappings before a function such
+ * as ENCLS[EWB] will be permitted
+ *
+ * The following flow is used to support SGX functions that require that
+ * no cached linear-to-physical address mappings are present:
+ * 1) Execute ENCLS[ETRACK] to initiate hardware tracking.
+ * 2) Use this function (sgx_encl_cpumask()) to query which CPUs might be
+ *    accessing the enclave.
+ * 3) Send IPI to identified CPUs, kicking them out of the enclave and
+ *    thus flushing all locally cached linear-to-physical address mappings.
+ * 4) Execute SGX function.
+ *
+ * Context: It is required to call this function after ENCLS[ETRACK].
+ *          This will ensure that if any new mm appears (racing with
+ *          sgx_encl_mm_add()) then the new mm will enter into the
+ *          enclave with fresh linear-to-physical address mappings.
+ *
+ *          It is required that all IPIs are completed before a new
+ *          ENCLS[ETRACK] is issued so be sure to protect steps 1 to 3
+ *          of the above flow with the enclave's mutex.
+ *
+ * Return: cpumask of CPUs that might be accessing @encl
+ */
+const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl)
+{
+	cpumask_t *cpumask = &encl->cpumask;
+	struct sgx_encl_mm *encl_mm;
+	int idx;
+
+	cpumask_clear(cpumask);
+
+	idx = srcu_read_lock(&encl->srcu);
+
+	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+		if (!mmget_not_zero(encl_mm->mm))
+			continue;
+
+		cpumask_or(cpumask, cpumask, mm_cpumask(encl_mm->mm));
+
+		mmput_async(encl_mm->mm);
+	}
+
+	srcu_read_unlock(&encl->srcu, idx);
+
+	return cpumask;
+}
+
 static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
 					      pgoff_t index)
 {
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index dc262d843411..becb68503baa 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -106,6 +106,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
+const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl);
 int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 6036328de255..e5be992897f4 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -201,35 +201,6 @@ static void sgx_ipi_cb(void *info)
 {
 }
 
-static const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
-{
-	cpumask_t *cpumask = &encl->cpumask;
-	struct sgx_encl_mm *encl_mm;
-	int idx;
-
-	/*
-	 * Can race with sgx_encl_mm_add(), but ETRACK has already been
-	 * executed, which means that the CPUs running in the new mm will enter
-	 * into the enclave with a fresh epoch.
-	 */
-	cpumask_clear(cpumask);
-
-	idx = srcu_read_lock(&encl->srcu);
-
-	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
-		if (!mmget_not_zero(encl_mm->mm))
-			continue;
-
-		cpumask_or(cpumask, cpumask, mm_cpumask(encl_mm->mm));
-
-		mmput_async(encl_mm->mm);
-	}
-
-	srcu_read_unlock(&encl->srcu, idx);
-
-	return cpumask;
-}
-
 /*
  * Swap page to the regular memory transformed to the blocked state by using
  * EBLOCK, which means that it can no longer be referenced (no new TLB entries).
@@ -276,7 +247,7 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 			 * miss cpus that entered the enclave between
 			 * generating the mask and incrementing epoch.
 			 */
-			on_each_cpu_mask(sgx_encl_ewb_cpumask(encl),
+			on_each_cpu_mask(sgx_encl_cpumask(encl),
 					 sgx_ipi_cb, NULL, 1);
 			ret = __sgx_encl_ewb(epc_page, va_slot, backing);
 		}
-- 
2.25.1

