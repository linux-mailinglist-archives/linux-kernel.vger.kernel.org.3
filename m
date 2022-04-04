Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D84F1BB9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381055AbiDDVWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379257AbiDDQvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242912E9D6;
        Mon,  4 Apr 2022 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090993; x=1680626993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KLeqkiiFihlMEI/XwbDkiA6gel561aXhUFgrx5JHtUE=;
  b=PuWId8kmCJJfJtCd1MApPK1De+/1BowuJpGwQl1U+IrV8LLh53Ag4wqs
   pvRPgw+Fom8DvY3dZmeS7rILNUMpD3icmTf/mK3G7JqTNOSzMImZq5B9O
   Sj8hgHsKcUlDdSgIrAnvwI2h8sjNL84dcD7vibGKuvpKYqbtKenF+CVFy
   +7jqJpauBOpfEiUaIh6UX1AZqOsG6H4LxtfRvdPIs2S7zKyug0OVKvVZS
   DNCb46A3QjGM/RntED00a0N2DS7s3l6LNfJ3eomKS8HNePaFaV15dHHyG
   zSFCIWvzZfa9n8e4fMzqWarQp6qdoKdQpnr1o7J20nLRgeUQHrZWVc8nF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323734042"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="323734042"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105171"
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
Subject: [PATCH V3 08/30] x86/sgx: Move PTE zap code to new sgx_zap_enclave_ptes()
Date:   Mon,  4 Apr 2022 09:49:16 -0700
Message-Id: <2454321f9d7ac6b0fd4925201f8d8d88471b41c0.1648847675.git.reinette.chatre@intel.com>
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

The SGX reclaimer removes page table entries pointing to pages that are
moved to swap.

SGX2 enables changes to pages belonging to an initialized enclave, thus
enclave pages may have their permission or type changed while the page
is being accessed by an enclave. Supporting SGX2 requires page table
entries to be removed so that any cached mappings to changed pages
are removed. For example, with the ability to change enclave page types
a regular enclave page may be changed to a Thread Control Structure
(TCS) page that may not be accessed by an enclave.

Factor out the code removing page table entries to a separate function
sgx_zap_enclave_ptes(), fixing accuracy of comments in the process,
and make it available to the upcoming SGX2 code.

Place sgx_zap_enclave_ptes() with the rest of the enclave code in
encl.c interacting with the page table since this code is no longer
unique to the reclaimer.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V2

Changes since V1:
- Elaborate why SGX2 needs this ability (Jarkko).
- More specific subject.
- Fix kernel-doc to have brackets in function name.

 arch/x86/kernel/cpu/sgx/encl.c | 45 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h |  2 +-
 arch/x86/kernel/cpu/sgx/main.c | 31 ++---------------------
 3 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 8de9bebc4d81..c77a62432862 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -605,7 +605,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 
 	spin_lock(&encl->mm_lock);
 	list_add_rcu(&encl_mm->list, &encl->mm_list);
-	/* Pairs with smp_rmb() in sgx_reclaimer_block(). */
+	/* Pairs with smp_rmb() in sgx_zap_enclave_ptes(). */
 	smp_wmb();
 	encl->mm_list_version++;
 	spin_unlock(&encl->mm_lock);
@@ -792,6 +792,49 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 	return ret;
 }
 
+/**
+ * sgx_zap_enclave_ptes() - remove PTEs mapping the address from enclave
+ * @encl: the enclave
+ * @addr: page aligned pointer to single page for which PTEs will be removed
+ *
+ * Multiple VMAs may have an enclave page mapped. Remove the PTE mapping
+ * @addr from each VMA. Ensure that page fault handler is ready to handle
+ * new mappings of @addr before calling this function.
+ */
+void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
+{
+	unsigned long mm_list_version;
+	struct sgx_encl_mm *encl_mm;
+	struct vm_area_struct *vma;
+	int idx, ret;
+
+	do {
+		mm_list_version = encl->mm_list_version;
+
+		/* Pairs with smp_wmb() in sgx_encl_mm_add(). */
+		smp_rmb();
+
+		idx = srcu_read_lock(&encl->srcu);
+
+		list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+			if (!mmget_not_zero(encl_mm->mm))
+				continue;
+
+			mmap_read_lock(encl_mm->mm);
+
+			ret = sgx_encl_find(encl_mm->mm, addr, &vma);
+			if (!ret && encl == vma->vm_private_data)
+				zap_vma_ptes(vma, addr, PAGE_SIZE);
+
+			mmap_read_unlock(encl_mm->mm);
+
+			mmput_async(encl_mm->mm);
+		}
+
+		srcu_read_unlock(&encl->srcu, idx);
+	} while (unlikely(encl->mm_list_version != mm_list_version));
+}
+
 /**
  * sgx_alloc_va_page() - Allocate a Version Array (VA) page
  *
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index e59c2cbf71e2..1b15d22f6757 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -111,7 +111,7 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
-
+void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
 struct sgx_epc_page *sgx_alloc_va_page(void);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index fa33922879bf..ce9e87d5f8ec 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -137,36 +137,9 @@ static void sgx_reclaimer_block(struct sgx_epc_page *epc_page)
 	struct sgx_encl_page *page = epc_page->owner;
 	unsigned long addr = page->desc & PAGE_MASK;
 	struct sgx_encl *encl = page->encl;
-	unsigned long mm_list_version;
-	struct sgx_encl_mm *encl_mm;
-	struct vm_area_struct *vma;
-	int idx, ret;
-
-	do {
-		mm_list_version = encl->mm_list_version;
-
-		/* Pairs with smp_rmb() in sgx_encl_mm_add(). */
-		smp_rmb();
-
-		idx = srcu_read_lock(&encl->srcu);
-
-		list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
-			if (!mmget_not_zero(encl_mm->mm))
-				continue;
-
-			mmap_read_lock(encl_mm->mm);
-
-			ret = sgx_encl_find(encl_mm->mm, addr, &vma);
-			if (!ret && encl == vma->vm_private_data)
-				zap_vma_ptes(vma, addr, PAGE_SIZE);
-
-			mmap_read_unlock(encl_mm->mm);
-
-			mmput_async(encl_mm->mm);
-		}
+	int ret;
 
-		srcu_read_unlock(&encl->srcu, idx);
-	} while (unlikely(encl->mm_list_version != mm_list_version));
+	sgx_zap_enclave_ptes(encl, addr);
 
 	mutex_lock(&encl->lock);
 
-- 
2.25.1

