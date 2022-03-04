Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EBD4CD14B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbiCDJin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbiCDJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EB9188866;
        Fri,  4 Mar 2022 01:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 315236187A;
        Fri,  4 Mar 2022 09:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7C4C340E9;
        Fri,  4 Mar 2022 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386600;
        bh=Ly5cUGmjCC569XajckW6RZUrN/Qaux7y19BOgqUNELE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeMb5YVwuscATss8PehQtFFOm6iK6CPgVke8tkyC6p5XTb/LpiVin2vDQX/wX3nCO
         pU0byBriHfnKTKavj9UCXhpBmUAJ27VDSAfTGCnFtAXplEohagO9WuERgI9ZGM+qRd
         t+2EcEojsPKqkXq/4Nq32sHsgWj/c9O/jMMS6peM09a/hyuE/4t/DWSA9RguKZCdAE
         ErSTULP7t2Ifv8KnsJmiidxvvNJUWlSDf0dB+eluWeeCXUOiQomyT9ltztPINS4df+
         9YYb9qoagRnBOGTJC1TnpPYq0S7Mk6wyxPAyfC3/WSc/u8gYcFMLpc8fQ34bek87el
         13QsM9dMIgKOw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [RFC PATCH v2.1 10/30] x86/sgx: Move PTE zap code to new sgx_zap_enclave_ptes()
Date:   Fri,  4 Mar 2022 11:35:04 +0200
Message-Id: <20220304093524.397485-10-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

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
 arch/x86/kernel/cpu/sgx/encl.c | 45 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h |  2 +-
 arch/x86/kernel/cpu/sgx/main.c | 31 ++---------------------
 3 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 54716886e804..6cc732b88c37 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -587,7 +587,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 
 	spin_lock(&encl->mm_lock);
 	list_add_rcu(&encl_mm->list, &encl->mm_list);
-	/* Pairs with smp_rmb() in sgx_reclaimer_block(). */
+	/* Pairs with smp_rmb() in sgx_zap_enclave_ptes(). */
 	smp_wmb();
 	encl->mm_list_version++;
 	spin_unlock(&encl->mm_lock);
@@ -776,6 +776,49 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
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
index 817edefa884a..e760991762e4 100644
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
index 60b166bff7b4..06492dcffcf1 100644
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
2.35.1

