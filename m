Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B8E4CD168
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbiCDJkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiCDJh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:37:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4716B1AA070;
        Fri,  4 Mar 2022 01:36:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9D23B827BC;
        Fri,  4 Mar 2022 09:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA44C340E9;
        Fri,  4 Mar 2022 09:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386588;
        bh=Owr4D7Nct+1o653wDWG1zRmvQTP1ToeylD32o3q9WB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAH0mSjPpOP8C2zYMLCL3nEvWbsi4edFwFZ33RIrE8W0rJswsuVg54RtpEysYx6hQ
         W4J29m94IeW4Fp/v8Gchb4JuKYw4jYnNlaJOnzPSdUCyKXLeo4HfjW+kss+U7eFfBX
         /b/Y/63hpGiVygbI6HKpe2J6jLdHooPk4XGUdN3WTIOQyVH6fEWgTnfzXGGvE406D7
         iNtaQrpTQmpukx0eb5AgBiRvle2vYnZLeKmp3MoNKUEAwNAdI3WLuajy7D52CxxBuB
         7jXfwpdbJtQnlX0G26dBfT8z8JilGS5T3+bVCTBFA49ahwKagm7M+jIt6SjUAJP7t7
         gD9sK9sB4I2gg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [RFC PATCH v2.1 06/30] x86/sgx: Support VMA permissions more relaxed than enclave permissions
Date:   Fri,  4 Mar 2022 11:35:00 +0200
Message-Id: <20220304093524.397485-6-jarkko@kernel.org>
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

=== Summary ===

An SGX VMA can only be created if its permissions are the same or
weaker than the Enclave Page Cache Map (EPCM) permissions. After VMA
creation this same rule is again enforced by the page fault handler:
faulted enclave pages are required to have equal or more relaxed
EPCM permissions than the VMA permissions.

On SGX1 systems the additional enforcement in the page fault handler
is redundant and on SGX2 systems it incorrectly prevents access.
On SGX1 systems it is unnecessary to repeat the enforcement of the
permission rule. The rule used during original VMA creation will
ensure that any access attempt will use correct permissions.
With SGX2 the EPCM permissions of a page can change after VMA
creation resulting in the VMA permissions potentially being more
relaxed than the EPCM permissions and the page fault handler
incorrectly blocking valid access attempts.

Enable the VMA's pages to remain accessible while ensuring that
the PTEs are installed to match the EPCM permissions but not be
more relaxed than the VMA permissions.

=== Full Changelog ===

An SGX enclave is an area of memory where parts of an application
can reside. First an enclave is created and loaded (from
non-enclave memory) with the code and data of an application,
then user space can map (mmap()) the enclave memory to
be able to enter the enclave at its defined entry points for
execution within it.

The hardware maintains a secure structure, the Enclave Page Cache Map
(EPCM), that tracks the contents of the enclave. Of interest here is
its tracking of the enclave page permissions. When a page is loaded
into the enclave its permissions are specified and recorded in the
EPCM. In parallel the kernel maintains permissions within the
page table entries (PTEs) and the rule is that PTE permissions
are not allowed to be more relaxed than the EPCM permissions.

A new mapping (mmap()) of enclave memory can only succeed if the
mapping has the same or weaker permissions than the permissions that
were vetted during enclave creation. This is enforced by
sgx_encl_may_map() that is called on the mmap() as well as mprotect()
paths. This rule remains.

One feature of SGX2 is to support the modification of EPCM permissions
after enclave initialization. Enclave pages may thus already be part
of a VMA at the time their EPCM permissions are changed resulting
in the VMA's permissions potentially being more relaxed than the EPCM
permissions.

Allow permissions of existing VMAs to be more relaxed than EPCM
permissions in preparation for dynamic EPCM permission changes
made possible in SGX2.  New VMAs that attempt to have more relaxed
permissions than EPCM permissions continue to be unsupported.

Reasons why permissions of existing VMAs are allowed to be more relaxed
than EPCM permissions instead of dynamically changing VMA permissions
when EPCM permissions change are:
1) Changing VMA permissions involve splitting VMAs which is an
   operation that can fail. Additionally changing EPCM permissions of
   a range of pages could also fail on any of the pages involved.
   Handling these error cases causes problems. For example, if an
   EPCM permission change fails and the VMA has already been split
   then it is not possible to undo the VMA split nor possible to
   undo the EPCM permission changes that did succeed before the
   failure.
2) The kernel has little insight into the user space where EPCM
   permissions are controlled from. For example, a RW page may
   be made RO just before it is made RX and splitting the VMAs
   while the VMAs may change soon is unnecessary.

Remove the extra permission check called on a page fault
(vm_operations_struct->fault) or during debugging
(vm_operations_struct->access) when loading the enclave page from swap
that ensures that the VMA permissions are not more relaxed than the
EPCM permissions. Since a VMA could only exist if it passed the
original permission checks during mmap() and a VMA may indeed
have more relaxed permissions than the EPCM permissions this extra
permission check is no longer appropriate.

With the permission check removed, ensure that PTEs do
not blindly inherit the VMA permissions but instead the permissions
that the VMA and EPCM agree on. PTEs for writable pages (from VMA
and enclave perspective) are installed with the writable bit set,
reducing the need for this additional flow to the permission mismatch
cases handled next.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/x86/sgx.rst      | 10 +++++++++
 arch/x86/kernel/cpu/sgx/encl.c | 38 ++++++++++++++++++----------------
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index 89ff924b1480..5659932728a5 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -99,6 +99,16 @@ The relationships between the different permission masks are:
 * PTEs are installed to match the EPCM permissions, but not be more
   relaxed than the VMA permissions.
 
+On systems supporting SGX2 EPCM permissions may change while the
+enclave page belongs to a VMA without impacting the VMA permissions.
+This means that a running VMA may appear to allow access to an enclave
+page that is not allowed by its EPCM permissions. For example, when an
+enclave page with RW EPCM permissions is mapped by a RW VMA but is
+subsequently changed to have read-only EPCM permissions. The kernel
+continues to maintain correct access to the enclave page through the
+PTE that will ensure that only access allowed by both the VMA
+and EPCM permissions are permitted.
+
 Application interface
 =====================
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 001808e3901c..20e97d3abdce 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -91,10 +91,8 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
 }
 
 static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
-						unsigned long addr,
-						unsigned long vm_flags)
+						unsigned long addr)
 {
-	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
 	struct sgx_epc_page *epc_page;
 	struct sgx_encl_page *entry;
 
@@ -102,14 +100,6 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 	if (!entry)
 		return ERR_PTR(-EFAULT);
 
-	/*
-	 * Verify that the faulted page has equal or higher build time
-	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
-	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
-	 */
-	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
-		return ERR_PTR(-EFAULT);
-
 	/* Entry successfully located. */
 	if (entry->epc_page) {
 		if (entry->desc & SGX_ENCL_PAGE_BEING_RECLAIMED)
@@ -138,7 +128,9 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 {
 	unsigned long addr = (unsigned long)vmf->address;
 	struct vm_area_struct *vma = vmf->vma;
+	unsigned long page_prot_bits;
 	struct sgx_encl_page *entry;
+	unsigned long vm_prot_bits;
 	unsigned long phys_addr;
 	struct sgx_encl *encl;
 	vm_fault_t ret;
@@ -155,7 +147,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 
 	mutex_lock(&encl->lock);
 
-	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
+	entry = sgx_encl_load_page(encl, addr);
 	if (IS_ERR(entry)) {
 		mutex_unlock(&encl->lock);
 
@@ -167,7 +159,19 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 
 	phys_addr = sgx_get_epc_phys_addr(entry->epc_page);
 
-	ret = vmf_insert_pfn(vma, addr, PFN_DOWN(phys_addr));
+	/*
+	 * Insert PTE to match the EPCM page permissions ensured to not
+	 * exceed the VMA permissions.
+	 */
+	vm_prot_bits = vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
+	page_prot_bits = entry->vm_max_prot_bits & vm_prot_bits;
+	/*
+	 * Add VM_SHARED so that PTE is made writable right away if VMA
+	 * and EPCM are writable (no COW in SGX).
+	 */
+	page_prot_bits |= (vma->vm_flags & VM_SHARED);
+	ret = vmf_insert_pfn_prot(vma, addr, PFN_DOWN(phys_addr),
+				  vm_get_page_prot(page_prot_bits));
 	if (ret != VM_FAULT_NOPAGE) {
 		mutex_unlock(&encl->lock);
 
@@ -295,15 +299,14 @@ static int sgx_encl_debug_write(struct sgx_encl *encl, struct sgx_encl_page *pag
  * Load an enclave page to EPC if required, and take encl->lock.
  */
 static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
-						   unsigned long addr,
-						   unsigned long vm_flags)
+						   unsigned long addr)
 {
 	struct sgx_encl_page *entry;
 
 	for ( ; ; ) {
 		mutex_lock(&encl->lock);
 
-		entry = sgx_encl_load_page(encl, addr, vm_flags);
+		entry = sgx_encl_load_page(encl, addr);
 		if (PTR_ERR(entry) != -EBUSY)
 			break;
 
@@ -339,8 +342,7 @@ static int sgx_vma_access(struct vm_area_struct *vma, unsigned long addr,
 		return -EFAULT;
 
 	for (i = 0; i < len; i += cnt) {
-		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK,
-					      vma->vm_flags);
+		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK);
 		if (IS_ERR(entry)) {
 			ret = PTR_ERR(entry);
 			break;
-- 
2.35.1

