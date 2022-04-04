Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F97E4F1E46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356171AbiDDWFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379258AbiDDQvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C382DAA1;
        Mon,  4 Apr 2022 09:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090992; x=1680626992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9a9K+tWtE8LPpkDvBp2rFINxF37F6Ff4NooRYQeIg8k=;
  b=OcMLC/5tlKOUSacRVHGF1a2IV7GJT2jwrSkuPHBhrFLsiBHgdF7nDdSt
   S/7M52bc1kbkYLkf1nqUsnp71dkPH6Q92s9+M383LOlHv6ah2ofNXNgMd
   R2EuD7/K1UhoqW7zGtgYRWgRKS/PzQ1RrT2Nu+XThtqXXb3IAlPtw6w8C
   kVrw6SlBc8sHJjwl8aemyppp8PKs7OJUyQxJrS+1s40Mb1xJZg6ZwcVwo
   NNvp8YfExRAodJK3thQOMSOtE0CDljb3AdhdG9OwbeFfrEk9AYf+eafsZ
   KN1RaptqfraRnpJDjE9faU4EjFbjrscRsyou8ebAqaOCdveNg1yUbRsgf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323734041"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="323734041"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105165"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:50 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 06/30] x86/sgx: Export sgx_encl_ewb_cpumask()
Date:   Mon,  4 Apr 2022 09:49:14 -0700
Message-Id: <ad3a21d0e332ac2cc465ef8c5de318962e2db6bc.1648847675.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648847675.git.reinette.chatre@intel.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using sgx_encl_ewb_cpumask() to learn which CPUs might have executed
an enclave is useful to ensure that TLBs are cleared when changes are
made to enclave pages.

sgx_encl_ewb_cpumask() is used within the reclaimer when an enclave
page is evicted. The upcoming SGX2 support enables changes to be
made to enclave pages and will require TLBs to not refer to the
changed pages and thus will be needing sgx_encl_ewb_cpumask().

Relocate sgx_encl_ewb_cpumask() to be with the rest of the enclave
code in encl.c now that it is no longer unique to the reclaimer.

Take care to ensure that any future usage maintains the
current context requirement that ETRACK has been called first.
Expand the existing comments to highlight this while moving them
to a more prominent location before the function.

No functional change.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V2

Changes since V1:
- New patch split from original "x86/sgx: Use more generic name for
  enclave cpumask function" (Jarkko).
- Change subject line (Jarkko).
- Fixup kernel-doc to use brackets in function name.

 arch/x86/kernel/cpu/sgx/encl.c | 67 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/encl.h |  1 +
 arch/x86/kernel/cpu/sgx/main.c | 29 ---------------
 3 files changed, 68 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 05ae1168391c..c6525eba74e8 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -613,6 +613,73 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 	return 0;
 }
 
+/**
+ * sgx_encl_ewb_cpumask() - Query which CPUs might be accessing the enclave
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
+ * 2) Use this function (sgx_encl_ewb_cpumask()) to query which CPUs might be
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
+const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
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
index 6b34efba1602..d2acb4debde5 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -105,6 +105,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
+const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl);
 int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 8e4bc6453d26..2de85f459492 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -203,35 +203,6 @@ static void sgx_ipi_cb(void *info)
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
-- 
2.25.1

