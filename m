Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39FC56AAB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiGGS2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbiGGS1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17D85A46E;
        Thu,  7 Jul 2022 11:27:45 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCRvdWbUoCJfVCU0ibGORN9bMjD/LC6UFp6uZuHKyD8=;
        b=wYZxBIMh5YKnXO3fSFJ5wOoyU+7iUsPfpwy9/mSNFwwEL4M6qxEuy/FY+a+0DzU6+KcNyL
        FIqBn65l1L9IVb5xoAk59KToXVOqUFHhoYekuJl5FhrLPZe5LYXuWhNuZgqg96tyiTTD77
        hhhhg0S/449WnFd0p/kN+Eu8w4dRevBT8CuGzmnrRPZTmPDLe4Nsn30yEfrZ6mENdoHO83
        30EKvAAJB6zmMu2h2qkWa0+3IyY0lcbfnQJMZJbLhnIBVKHMpPX0yGEzfYqx0huirhNwBz
        4oWLXvqR4fDPH7BMIRIOoLpQuPTUYXMOd9CFLdB4yOBpqkWn65kGHnw0G7tPvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCRvdWbUoCJfVCU0ibGORN9bMjD/LC6UFp6uZuHKyD8=;
        b=tuCyfsHRiQ3sPvbquB/lwQSos0OutypqzDTwWtEJPkDjWyovib7akNwTau7DJairW+Thl5
        uo/Rr6dPESBfvbDA==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Support adding of pages to an initialized enclave
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca254a58eabea053803277449b24b6e4963a3883b=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Ca254a58eabea053803277449b24b6e4963a3883b=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721846326.15455.9523735064075990091.tip-bot2@tip-bot2>
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

Commit-ID:     5a90d2c3f5ef87717e54572af8426aba6fdbdaa6
Gitweb:        https://git.kernel.org/tip/5a90d2c3f5ef87717e54572af8426aba6fdbdaa6
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:52 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:03 -07:00

x86/sgx: Support adding of pages to an initialized enclave

With SGX1 an enclave needs to be created with its maximum memory demands
allocated. Pages cannot be added to an enclave after it is initialized.
SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
pages to an initialized enclave. With SGX2 the enclave still needs to
set aside address space for its maximum memory demands during enclave
creation, but all pages need not be added before enclave initialization.
Pages can be added during enclave runtime.

Add support for dynamically adding pages to an initialized enclave,
architecturally limited to RW permission at creation but allowed to
obtain RWX permissions after trusted enclave runs EMODPE. Add pages
via the page fault handler at the time an enclave address without a
backing enclave page is accessed, potentially directly reclaiming
pages if no free pages are available.

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

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Haitao Huang <haitao.huang@intel.com>
Tested-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
Link: https://lkml.kernel.org/r/a254a58eabea053803277449b24b6e4963a3883b.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 117 ++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index ea81e59..e5b61a5 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -295,6 +295,112 @@ struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 	return __sgx_encl_load_page(encl, entry);
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
+	vm_fault_t vmret = VM_FAULT_SIGBUS;
+	struct sgx_pageinfo pginfo = {0};
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+	struct sgx_va_page *va_page;
+	unsigned long phys_addr;
+	u64 secinfo_flags;
+	int ret;
+
+	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
+		return VM_FAULT_SIGBUS;
+
+	/*
+	 * Ignore internal permission checking for dynamically added pages.
+	 * They matter only for data added during the pre-initialization
+	 * phase. The enclave decides the permissions by the means of
+	 * EACCEPT, EACCEPTCOPY and EMODPE.
+	 */
+	secinfo_flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
+	encl_page = sgx_encl_page_alloc(encl, addr - encl->base, secinfo_flags);
+	if (IS_ERR(encl_page))
+		return VM_FAULT_OOM;
+
+	mutex_lock(&encl->lock);
+
+	epc_page = sgx_alloc_epc_page(encl_page, false);
+	if (IS_ERR(epc_page)) {
+		if (PTR_ERR(epc_page) == -EBUSY)
+			vmret =  VM_FAULT_NOPAGE;
+		goto err_out_unlock;
+	}
+
+	va_page = sgx_encl_grow(encl, false);
+	if (IS_ERR(va_page))
+		goto err_out_epc;
+
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
+		goto err_out_shrink;
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
+	 */
+	vmret = vmf_insert_pfn(vma, addr, PFN_DOWN(phys_addr));
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
+err_out_shrink:
+	sgx_encl_shrink(encl, va_page);
+err_out_epc:
+	sgx_encl_free_epc_page(epc_page);
+err_out_unlock:
+	mutex_unlock(&encl->lock);
+	kfree(encl_page);
+
+	return vmret;
+}
+
 static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 {
 	unsigned long addr = (unsigned long)vmf->address;
@@ -314,6 +420,17 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
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
 
 	entry = sgx_encl_load_page_in_vma(encl, addr, vma->vm_flags);
