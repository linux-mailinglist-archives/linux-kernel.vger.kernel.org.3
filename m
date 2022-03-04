Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EE34CD16B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbiCDJk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbiCDJiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE41A7D80;
        Fri,  4 Mar 2022 01:37:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE1EA6187A;
        Fri,  4 Mar 2022 09:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78E4C340E9;
        Fri,  4 Mar 2022 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386621;
        bh=qmR8VL89D7QLIxPis9eXbKu0Sm2nQvl/e0ei1F0JvzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fut6ELTKDQmvi4L5tYhsnbNKGMFaiY5DlGMCd0xN9C5ZxTrE5taRp082lO9qaDlOT
         TxiObUQXT+F3pX4V/0IE8MM693Vh1ICWVFkh+Qk0EwpBGwkN2aQ1PPNz/PWcF0y9zL
         7AA/FdfpCtmRtzslZgE6Sc2R1WwfsWXCWFLF9dfL3CSP1mGvMfsXK1PWcFLR+ClyDE
         r0vqYCwcLreqmR/sDUNIe2SdxpjrlWK126zRyH3e13hfuEt3a3HF51lW1qbHcp1fyf
         vdkQzNqRFqK8mAeBDzDNjy/3s2Y241JOkYhIf3XDCD1qYZ9C2wcJL0cVyk+b4eORLn
         stt+AqR9qKD7g==
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
Subject: [RFC PATCH v2.1 17/30] x86/sgx: Support adding of pages to an initialized enclave
Date:   Fri,  4 Mar 2022 11:35:11 +0200
Message-Id: <20220304093524.397485-17-jarkko@kernel.org>
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

With SGX1 an enclave needs to be created with its maximum memory demands
allocated. Pages cannot be added to an enclave after it is initialized.
SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
pages to an initialized enclave. With SGX2 the enclave still needs to
set aside address space for its maximum memory demands during enclave
creation, but all pages need not be added before enclave initialization.
Pages can be added during enclave runtime.

Add support for dynamically adding pages to an initialized enclave,
architecturally limited to RW permission. Add pages via the page fault
handler at the time an enclave address without a backing enclave page
is accessed, potentially directly reclaiming pages if no free pages
are available.

The enclave is still required to run ENCLU[EACCEPT] on the page before
it can be used. A useful flow is for the enclave to run ENCLU[EACCEPT]
on an uninitialized address. This will trigger the page fault handler
that will add the enclave page and return execution to the enclave to
repeat the ENCLU[EACCEPT] instruction, this time successful.

If the enclave accesses an uninitialized address in another way, for
example by expanding the enclave stack to a page that has not yet been
added, then the page fault handler would add the page on the first
write but upon returning to the enclave the instruction that triggered
the page fault would be repeated and since ENCLU[EACCEPT] was not run
yet it would trigger a second page fault, this time with the SGX flag
set in the page fault error code. This can only be recovered by entering
the enclave again and directly running the ENCLU[EACCEPT] instruction on
the now initialized address.

Accessing an uninitialized address from outside the enclave also
triggers this flow but the page will remain inaccessible (access will
result in #PF) until accepted from within the enclave via
ENCLU[EACCEPT].

The page is added with the architecturally constrained RW permissions
as runtime as well as maximum allowed permissions. It is understood that
there are some use cases, for example code relocation, that requires RWX
maximum permissions. Supporting these use cases require guidance from
user space policy before such maximum permissions can be allowed.
Integration with user policy is deferred.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c  | 132 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/encl.h  |   2 +
 arch/x86/kernel/cpu/sgx/ioctl.c |   4 +-
 3 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index baf798a793a2..9602b6db831b 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -124,6 +124,127 @@ struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 	return entry;
 }
 
+/**
+ * sgx_encl_eaug_page() - Dynamically add page to initialized enclave
+ * @vma:	VMA obtained from fault info from where page is accessed
+ * @encl:	enclave accessing the page
+ * @addr:	address that triggered the page fault
+ *
+ * When an initialized enclave accesses a page with no backing EPC page
+ * on a SGX2 system then the EPC can be added dynamically via the SGX2
+ * ENCLS[EAUG] instruction.
+ *
+ * Returns: Appropriate vm_fault_t: VM_FAULT_NOPAGE when PTE was installed
+ * successfully, VM_FAULT_SIGBUS or VM_FAULT_OOM as error otherwise.
+ */
+static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
+				     struct sgx_encl *encl, unsigned long addr)
+{
+	struct sgx_pageinfo pginfo = {0};
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+	struct sgx_va_page *va_page;
+	unsigned long phys_addr;
+	unsigned long prot;
+	vm_fault_t vmret;
+	int ret;
+
+	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
+		return VM_FAULT_SIGBUS;
+
+	encl_page = kzalloc(sizeof(*encl_page), GFP_KERNEL);
+	if (!encl_page)
+		return VM_FAULT_OOM;
+
+	encl_page->desc = addr;
+	encl_page->encl = encl;
+
+	/*
+	 * Adding a regular page that is architecturally allowed to only
+	 * be created with RW permissions.
+	 * TBD: Interface with user space policy to support max permissions
+	 * of RWX.
+	 */
+	prot = PROT_READ | PROT_WRITE | PROT_EXEC;
+	encl_page->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
+
+	epc_page = sgx_alloc_epc_page(encl_page, true);
+	if (IS_ERR(epc_page)) {
+		kfree(encl_page);
+		return VM_FAULT_SIGBUS;
+	}
+
+	va_page = sgx_encl_grow(encl);
+	if (IS_ERR(va_page)) {
+		ret = PTR_ERR(va_page);
+		goto err_out_free;
+	}
+
+	mutex_lock(&encl->lock);
+
+	/*
+	 * Copy comment from sgx_encl_add_page() to maintain guidance in
+	 * this similar flow:
+	 * Adding to encl->va_pages must be done under encl->lock.  Ditto for
+	 * deleting (via sgx_encl_shrink()) in the error path.
+	 */
+	if (va_page)
+		list_add(&va_page->list, &encl->va_pages);
+
+	ret = xa_insert(&encl->page_array, PFN_DOWN(encl_page->desc),
+			encl_page, GFP_KERNEL);
+	/*
+	 * If ret == -EBUSY then page was created in another flow while
+	 * running without encl->lock
+	 */
+	if (ret)
+		goto err_out_unlock;
+
+	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
+	pginfo.addr = encl_page->desc & PAGE_MASK;
+	pginfo.metadata = 0;
+
+	ret = __eaug(&pginfo, sgx_get_epc_virt_addr(epc_page));
+	if (ret)
+		goto err_out;
+
+	encl_page->encl = encl;
+	encl_page->epc_page = epc_page;
+	encl_page->type = SGX_PAGE_TYPE_REG;
+	encl->secs_child_cnt++;
+
+	sgx_mark_page_reclaimable(encl_page->epc_page);
+
+	phys_addr = sgx_get_epc_phys_addr(epc_page);
+	/*
+	 * Do not undo everything when creating PTE entry fails - next #PF
+	 * would find page ready for a PTE.
+	 * PAGE_SHARED because protection is forced to be RW above and COW
+	 * is not supported.
+	 */
+	vmret = vmf_insert_pfn_prot(vma, addr, PFN_DOWN(phys_addr),
+				    PAGE_SHARED);
+	if (vmret != VM_FAULT_NOPAGE) {
+		mutex_unlock(&encl->lock);
+		return VM_FAULT_SIGBUS;
+	}
+	mutex_unlock(&encl->lock);
+	return VM_FAULT_NOPAGE;
+
+err_out:
+	xa_erase(&encl->page_array, PFN_DOWN(encl_page->desc));
+
+err_out_unlock:
+	sgx_encl_shrink(encl, va_page);
+	mutex_unlock(&encl->lock);
+
+err_out_free:
+	sgx_encl_free_epc_page(epc_page);
+	kfree(encl_page);
+
+	return VM_FAULT_SIGBUS;
+}
+
 static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 {
 	unsigned long addr = (unsigned long)vmf->address;
@@ -145,6 +266,17 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 	if (unlikely(!encl))
 		return VM_FAULT_SIGBUS;
 
+	/*
+	 * The page_array keeps track of all enclave pages, whether they
+	 * are swapped out or not. If there is no entry for this page and
+	 * the system supports SGX2 then it is possible to dynamically add
+	 * a new enclave page. This is only possible for an initialized
+	 * enclave that will be checked for right away.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SGX2) &&
+	    (!xa_load(&encl->page_array, PFN_DOWN(addr))))
+		return sgx_encl_eaug_page(vma, encl, addr);
+
 	mutex_lock(&encl->lock);
 
 	entry = sgx_encl_load_page(encl, addr);
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 965cfc7b2b93..049b3bb08e63 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -122,4 +122,6 @@ void sgx_encl_free_epc_page(struct sgx_epc_page *page);
 struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 					 unsigned long addr);
 
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
+void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index a848f6c38781..166ec7d79634 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -17,7 +17,7 @@
 #include "encl.h"
 #include "encls.h"
 
-static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 {
 	struct sgx_va_page *va_page = NULL;
 	void *err;
@@ -43,7 +43,7 @@ static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 	return va_page;
 }
 
-static void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
+void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
 {
 	encl->page_cnt--;
 
-- 
2.35.1

