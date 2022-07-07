Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FD356AA9A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiGGS32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiGGS2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:28:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279845C9EA;
        Thu,  7 Jul 2022 11:27:53 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqNDhWbEeno72qVMm6FQyO9C/jysSOx4xZPeop9a6hw=;
        b=YSzSAGp1goMJa62BcPpM6mXcu01+VC6M5UJNdLrsfTJ9y8V4J9SeFC3YrL8mhXdIRUe9BN
        elmPDtx5FcnpIJXPx7rrDEV7jKC2GgSZ5vy+deTW7XIg2yWHMK8D0ZrwPQcvIscIKlRViS
        sR2n/tDRjXw7o/lzyjB+wBKlrFzJYVcJrQWj2GqnZ1xm6t3KCPaa2IDfubL0N70F10y43e
        pNlMzGUQNdiZoxRU/HNnVH1lEUDqH6DlNuiEYpyNZPbHufd2ARHuuN2yRhMcWzAiGY5RRT
        7bEol+p+FKVvRKBDUiCHccKoxd5yIP4QHPkPL1ng74wshnhJkA2/Nu6iyo4+zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqNDhWbEeno72qVMm6FQyO9C/jysSOx4xZPeop9a6hw=;
        b=PPTA/Xr8ICnF731AJnbAtlo2EEve5voUC+1+wAYs8abcF9DJPDPxTFRGj0bW5jlq2CNgrv
        PZfxhc/j/DZzH6Cg==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Move PTE zap code to new sgx_zap_enclave_ptes()
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb010cdf01d7ce55dd0f00e883b7ccbd9db57160a=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cb010cdf01d7ce55dd0f00e883b7ccbd9db57160a=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721847059.15455.5665183777074687958.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     f89c2f9bf5a64f619de06ded4349dff5a35da860
Gitweb:        https://git.kernel.org/tip/f89c2f9bf5a64f619de06ded4349dff5a35da860
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:44 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:02 -07:00

x86/sgx: Move PTE zap code to new sgx_zap_enclave_ptes()

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/b010cdf01d7ce55dd0f00e883b7ccbd9db57160a.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 45 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h |  2 +-
 arch/x86/kernel/cpu/sgx/main.c | 31 +----------------------
 3 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 7539cef..c6cac43 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -706,7 +706,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 
 	spin_lock(&encl->mm_lock);
 	list_add_rcu(&encl_mm->list, &encl->mm_list);
-	/* Pairs with smp_rmb() in sgx_reclaimer_block(). */
+	/* Pairs with smp_rmb() in sgx_zap_enclave_ptes(). */
 	smp_wmb();
 	encl->mm_list_version++;
 	spin_unlock(&encl->mm_lock);
@@ -888,6 +888,49 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 }
 
 /**
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
+/**
  * sgx_alloc_va_page() - Allocate a Version Array (VA) page
  *
  * Allocate a free EPC page and convert it to a Version Array (VA) page.
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index ef8cf10..f72a674 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -111,7 +111,7 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 void sgx_encl_put_backing(struct sgx_backing *backing);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
-
+void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
 struct sgx_epc_page *sgx_alloc_va_page(void);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 7b53a69..9df2221 100644
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
 
