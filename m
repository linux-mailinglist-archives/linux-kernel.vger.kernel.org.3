Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8794ACDB2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344094AbiBHBJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbiBHAqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCFBC06109E;
        Mon,  7 Feb 2022 16:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281172; x=1675817172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A0tKjrTiaB3MFmcpXoXALQfp0EgJ5XWEEKw+aPc7+m8=;
  b=JVJ9lrBZz/l4wi9KNOiFbYesjctcKZNLwSrLVVQH4ScY6Q7m74TTPy79
   8af83EEQZQ9QbBVZVDIEnmVdBbb72wzitPGm+nJ0Qw4b0JBkbTygAwfO+
   TSDpIPW8r7+/8tJPLH1HFRBAxxXsJ0SaO4+ly9xPTsCkYHsJXXR5CnuDL
   Dcnr3sDSQVZRIaB48sQ1y4uLTUKs6K59QssSmEl3l0WokQDO7UWhpUay+
   CpU73RS3xG1dsI6czNSY+3eDc6FNkESw6QOc4gXjYx/B+YSqUgC3eiXN2
   /SQDXg+3sz8KEnpcVNUSIRFOap9CL0cI83A38YzvxyXQs/88SETI1Wnbk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407944"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407944"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389483"
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
Subject: [PATCH V2 06/32] x86/sgx: Support VMA permissions more relaxed than enclave permissions
Date:   Mon,  7 Feb 2022 16:45:28 -0800
Message-Id: <0555a4b4a5e8879eb8f879ab3d9908302000f11c.1644274683.git.reinette.chatre@intel.com>
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
Changes since V1:
- Reword commit message (Jarkko).
- Use "relax" instead of "exceed" when referring to permissions (Dave).
- Add snippet to Documentation/x86/sgx.rst that highlights the
  relationship between VMA, EPCM, and PTE permissions on SGX
  systems (Andy).

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
index 48afe96ae0f0..b6105d9e7c46 100644
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
2.25.1

