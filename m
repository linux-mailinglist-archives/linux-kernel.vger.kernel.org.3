Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4B4CD143
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbiCDJid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbiCDJh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:37:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F361AA4A3;
        Fri,  4 Mar 2022 01:36:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D1AE61983;
        Fri,  4 Mar 2022 09:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29CCC340E9;
        Fri,  4 Mar 2022 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386591;
        bh=kKcR9AvfZlN19CESCMgiF89yZBxT/ZOKGdAISIaDRy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FL3tOIUmfhfHK63Ab5MP7aTRkotd0px38yI7drnuBRi7UH6dLWheNUIg14jXgupDx
         TASHw0sH95vnY/fytDdwVM/WaX1UF8F8cjVzbjaRO1W1jrmHafzb4k9FcOcFaQ8JlD
         /pAubU4WBi8dIJq3NrA1Qja79vX2tzL1Y6iOEQmkmiPAUxrc5tqVL/oKrFfh6mZxkL
         46JzhiNHI0N3/v/nHqsldedvy/s4mKFbJeHEvYcZrrtCZvP3iXg2ieKX+AkvziJYdK
         zYwJJjIzBP5uNlmx0pnC3aj4+omAcM3/8hpjcqxmvt8Xb+jRBLTwApx9AjW0HDWaCt
         HUt7N6+YhIkbA==
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
Subject: [RFC PATCH v2.1 07/30] x86/sgx: Add pfn_mkwrite() handler for present PTEs
Date:   Fri,  4 Mar 2022 11:35:01 +0200
Message-Id: <20220304093524.397485-7-jarkko@kernel.org>
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
 arch/x86/kernel/cpu/sgx/encl.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 20e97d3abdce..6d25f7ed1294 100644
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
2.35.1

