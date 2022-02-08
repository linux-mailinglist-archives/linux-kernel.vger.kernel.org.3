Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBEF4ACDCD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbiBHBJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344159AbiBHAqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:13 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2EEC061355;
        Mon,  7 Feb 2022 16:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281172; x=1675817172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bkkbubhpgksylAdJ5GIuG4s5L7IcqFdVjXHVqGP1L64=;
  b=j4rwqOgDot52Nje7np1wi/8/Je13o0VT+AOo9wETjk/FLDkDbKYH41Bx
   5SjNWMUcKQWiNETCfvyeWqLFRCZ1XLfOdt2DXWMPzhxxOlzuIpLAhNLPJ
   NT3S0O3AFF0VcAeyzDFQW652NadlbSMW16bUF84zZ7hhSiUdqcVJ9C4wa
   5Kj8yB1m2shlgTaX2j5cqyzO83DwXJACL024jGlRMFw/qLKkz8dkKFxcF
   fHL8cHl5I2Kz9AnBudvoiEOk9nA3CmFwf35ZH/gOwMfKXFFMjfDWuFW4F
   ExNWBqGnEm0S1JTU2eYHzD59aernV6v8a3LGhQhcglQtFJ37DkpJj8opU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407946"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407946"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389486"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/32] x86/sgx: Add pfn_mkwrite() handler for present PTEs
Date:   Mon,  7 Feb 2022 16:45:29 -0800
Message-Id: <00f26961350fcbc27f1b6e0ccb24532876705289.1644274683.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644274683.git.reinette.chatre@intel.com>
References: <cover.1644274683.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default a write page fault on a present PTE inherits the
permissions of the VMA.

When using SGX2, enclave page permissions maintained in the
hardware's Enclave Page Cache Map (EPCM) may change after a VMA
accessing the page is created. A VMA's permissions may thus be
more relaxed than the EPCM permissions even though the VMA was
originally created not to have more relaxed permissions. Following
the default behavior during a page fault on a present PTE while
the VMA permissions are more relaxed than the EPCM permissions would
result in the PTE for an enclave page to be writable even
though the page is not writable according to the EPCM permissions.

The kernel should not allow writing to a page if that page is not
writable: the PTE should accurately reflect the EPCM permissions
while not being more relaxed than the VMA permissions.

Do not blindly accept VMA permissions on a page fault due to a
write attempt to a present PTE. Install a pfn_mkwrite() handler
that ensures that the VMA permissions agree with the EPCM
permissions in this regard.

Before and after page fault flow scenarios
==========================================

Consider the following scenario that will be possible when using SGX2:
* An enclave page exists with RW EPCM permissions.
* A RW VMA maps the range spanning the enclave page.
* The enclave page's EPCM permissions are changed to read-only.
* There is no PTE for the enclave page.

Considering that the PTE is not present in the scenario,
user space will observe the following when attempting to write to the
enclave page from within the enclave:
 1) Instruction writing to enclave page is run from within the enclave.
 2) A page fault with second and third bits set (0x6) is encountered
    and handled by the SGX handler sgx_vma_fault() that installs a
    read-only page table entry following previous patch that installs
    a PTE with permissions that VMA and enclave agree on
    (read-only in this case).
 3) Instruction writing to enclave page is re-attempted.
 4) A page fault with first three bits set (0x7) is encountered and
    transparently (from SGX driver and user space perspective) handled
    by the kernel with the PTE made writable because the VMA is
    writable.
 5) Instruction writing to enclave page is re-attempted.
 6) Since the EPCM permissions prevents writing to the page a new page
    fault is encountered, this time with the SGX flag set in the error
    code (0x8007). No action is taken by the kernel for this page fault
    and execution returns to user space.
 7) Typically such a fault will be passed on to an application with a
    signal but if the enclave is entered with the vDSO function provided
    by the kernel then user space does not receive a signal but instead
    the vDSO function returns successfully with exception information
    (vector=14, error code=0x8007, and address) within the exception
    fields within the vDSO function's struct sgx_enclave_run.

As can be observed it is not possible for user space to write to an
enclave page if that page's EPCM permissions do not allow so,
no matter what the VMA or PTE allows.

Even so, the kernel should not allow writing to a page if that page is
not writable. The PTE should accurately reflect the EPCM permissions.

With a pfn_mkwrite() handler that ensures that the VMA permissions
agree with the EPCM permissions user space observes the following
when attempting to write to the enclave page from within the enclave:
 1) Instruction writing to enclave page is run from within the enclave.
 2) A page fault with second and third bits set (0x6) is encountered
    and handled by the SGX handler sgx_vma_fault() that installs a
    read-only page table entry following previous patch that installs
    a PTE with permissions that VMA and enclave agree on
    (read-only in this case).
 3) Instruction writing to enclave page is re-attempted.
 4) A page fault with first three bits set (0x7) is encountered and
    passed to the pfn_mkwrite() handler for consideration. The handler
    determines that the page should not be writable and returns SIGBUS.
 5) Typically such a fault will be passed on to an application with a
    signal but if the enclave is entered with the vDSO function provided
    by the kernel then user space does not receive a signal but instead
    the vDSO function returns successfully with exception information
    (vector=14, error code=0x7, and address) within the exception fields
    within the vDSO function's struct sgx_enclave_run.

The accurate exception information supports the SGX runtime, which is
virtually always implemented inside a shared library, by providing
accurate information in support of its management of the SGX enclave.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Highlight in commit message that the behavior cannot happen in
  existing code but instead is behavior that becomes possible with SGX2
  (Jarkko).
- Reword commit message and remove the Q&A format (Jarkko).

 arch/x86/kernel/cpu/sgx/encl.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index b6105d9e7c46..1ba01c75a579 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -184,6 +184,47 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 	return VM_FAULT_NOPAGE;
 }
 
+/*
+ * A fault occurred while writing to a present enclave PTE. Since PTE is
+ * present this will not be handled by sgx_vma_fault(). VMA may allow
+ * writing to the page while enclave (as based on EPCM permissions) does
+ * not. Do not follow the default of inheriting VMA permissions in this
+ * regard, ensure enclave also allows writing to the page.
+ */
+static vm_fault_t sgx_vma_pfn_mkwrite(struct vm_fault *vmf)
+{
+	unsigned long addr = (unsigned long)vmf->address;
+	struct vm_area_struct *vma = vmf->vma;
+	struct sgx_encl_page *entry;
+	struct sgx_encl *encl;
+	vm_fault_t ret = 0;
+
+	encl = vma->vm_private_data;
+
+	/*
+	 * It's very unlikely but possible that allocating memory for the
+	 * mm_list entry of a forked process failed in sgx_vma_open(). When
+	 * this happens, vm_private_data is set to NULL.
+	 */
+	if (unlikely(!encl))
+		return VM_FAULT_SIGBUS;
+
+	mutex_lock(&encl->lock);
+
+	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
+	if (!entry) {
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+	if (!(entry->vm_max_prot_bits & VM_WRITE))
+		ret = VM_FAULT_SIGBUS;
+
+out:
+	mutex_unlock(&encl->lock);
+	return ret;
+}
+
 static void sgx_vma_open(struct vm_area_struct *vma)
 {
 	struct sgx_encl *encl = vma->vm_private_data;
@@ -381,6 +422,7 @@ const struct vm_operations_struct sgx_vm_ops = {
 	.mprotect = sgx_vma_mprotect,
 	.open = sgx_vma_open,
 	.access = sgx_vma_access,
+	.pfn_mkwrite = sgx_vma_pfn_mkwrite,
 };
 
 /**
-- 
2.25.1

