Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83534F1D86
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382688AbiDDVbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379270AbiDDQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E2C31356;
        Mon,  4 Apr 2022 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090996; x=1680626996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d1SJNvP8v9eXa3w1Wjuwy/XMdEhGgiSStSIhrE7ENyk=;
  b=nWK80rC3YaB2cbs2qdiEq1ticoyqGqaSL+3BXL70cHhRyMOCXgAjW5h1
   QbDutUUgLCWwvebYoF2zuvtLfOSd/FLrvMzaSZNoNl3B8/NI6mXiR+W/g
   AY4Yj5b3uxOkdHh31HE0z1GIvDCHUgLRdRhsVP7z4R170hpWphUZbKlVu
   aNJZEhhYB1hjJkJE2EhLgvxSbR/aMGt09k/wbqcK1h4N0dfSXdyRnSYRm
   tDjCCofAle2RSz7CrW7RILq/eU1lj+SuZi5eMHi8tgpnORpbY17z0bv5o
   eLdi3zk93eDHOcoACiNZ2fZp0kFnKWb1oFWUtuoM+wa6RMLK0GVDSZG6N
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323734050"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="323734050"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105192"
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
Subject: [PATCH V3 15/30] x86/sgx: Support adding of pages to an initialized enclave
Date:   Mon,  4 Apr 2022 09:49:23 -0700
Message-Id: <50b9da1f491eb31d9b038afa0d75871965f474eb.1648847675.git.reinette.chatre@intel.com>
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

With SGX1 an enclave needs to be created with its maximum memory demands
allocated. Pages cannot be added to an enclave after it is initialized.
SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
pages to an initialized enclave. With SGX2 the enclave still needs to
set aside address space for its maximum memory demands during enclave
creation, but all pages need not be added before enclave initialization.
Pages can be added during enclave runtime.

Add support for dynamically adding pages to an initialized enclave,
architecturally limited to RW permission at creation but allowed to
obtain RWX permissions after enclave runs EMODPE. Add pages via the
page fault handler at the time an enclave address without a backing
enclave page is accessed, potentially directly reclaiming pages if
no free pages are available.

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
---
Changes since V2:
- Remove runtime tracking of EPCM permissions
  (sgx_encl_page->vm_run_prot_bits) (Jarkko).
- Move export of sgx_encl_{grow,shrink}() to separate patch. (Jarkko)
- Use sgx_encl_page_alloc(). (Jarkko)
- Set max allowed permissions to be RWX (Jarkko). Update changelog
  to indicate the change and use comment in code as
  created by Jarkko in:
https://lore.kernel.org/linux-sgx/20220306053211.135762-4-jarkko@kernel.org
- Do not set protection bits but let it be inherited by VMA (Jarkko)

Changes since V1:
- Fix subject line "to initialized" -> "to an initialized" (Jarkko).
- Move text about hardware's PENDING state to the patch that introduces
  the ENCLS[EAUG] wrapper (Jarkko).
- Ensure kernel-doc uses brackets when referring to function.

 arch/x86/kernel/cpu/sgx/encl.c | 124 +++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 546423753e4c..fa4f947f8496 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -194,6 +194,119 @@ struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
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
+	struct sgx_pageinfo pginfo = {0};
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+	struct sgx_va_page *va_page;
+	unsigned long phys_addr;
+	u64 secinfo_flags;
+	vm_fault_t vmret;
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
@@ -213,6 +326,17 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
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
-- 
2.25.1

