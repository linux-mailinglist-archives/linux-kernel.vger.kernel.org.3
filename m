Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABDF4ACDAD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbiBHBJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344162AbiBHAqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:13 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A26C0612A4;
        Mon,  7 Feb 2022 16:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281172; x=1675817172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Stk+3fvhrUfHLDS05QiXyxq3INLSvoy9CWL37/WB/Mk=;
  b=WlMurCTWPepPg9RaXwc7eQG62jqy/GE8a0NP7yCId50IP34mnBBWhQPO
   tISGbEnfvt2MrKF5q1FFN+IXoF1LByxaEUyDglRdYrQJCXHpH5b1f1ZEP
   JNOIM7xUSsKAmuCeuV/s8HC3j0Ealoth8XGUtlTFBHW5hItaBfCBn1RyX
   C/GV9fWoO7wYILv4XOSJH7t0jiJZ+A3I0L1yn/iI1t2YB+DgBCNzqagqm
   ib5nPfBGqKGLZPcZXu4+bvBX8PGadN0Cz/uCa5NZCa/GHI1Q1r8a2k5DH
   /TPGClXkLb6ixSZoS2l8x52wLg1XqYoptm+qeCTUiGvGO3HJEiTjQbI3b
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407948"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407948"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389489"
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
Subject: [PATCH V2 08/32] x86/sgx: x86/sgx: Add sgx_encl_page->vm_run_prot_bits for dynamic permission changes
Date:   Mon,  7 Feb 2022 16:45:30 -0800
Message-Id: <5136c1984544a18aadf17df040dfd8c846a22f18.1644274683.git.reinette.chatre@intel.com>
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

Enclave creators declare their enclave page permissions (EPCM
permissions) at the time the pages are added to the enclave. These
page permissions are the vetted permissible accesses of the enclave
pages and stashed off (in struct sgx_encl_page->vm_max_prot_bits)
for later comparison with enclave PTEs and VMAs.

Current permission support assume that EPCM permissions remain static
for the lifetime of the enclave. This is about to change with the
addition of support for SGX2 where the EPCM permissions of enclave
pages belonging to an initialized enclave may change during the
enclave's lifetime.

Support for changing of EPCM permissions should continue to respect
the vetted maximum protection bits maintained in
sgx_encl_page->vm_max_prot_bits. Towards this end, add
sgx_encl_page->vm_run_prot_bits in preparation for support of
enclave page permission changes. sgx_encl_page->vm_run_prot_bits
reflect the active EPCM permissions of an enclave page and are not to
exceed sgx_encl_page->vm_max_prot_bits.

Two permission fields are used: sgx_encl_page->vm_run_prot_bits
reflects the current EPCM permissions and is used to manage the page
table entries while sgx_encl_page->vm_max_prot_bits contains the vetted
maximum protection bits and is used to guide which EPCM permissions
are allowed in the upcoming SGX2 permission changing support (it guides
what values sgx_encl_page->vm_run_prot_bits may have).

Consider this example how sgx_encl_page->vm_max_prot_bits and
sgx_encl_page->vm_run_prot_bits are used:

(1) Add an enclave page with secinfo of RW to an uninitialized enclave:
    sgx_encl_page->vm_max_prot_bits = RW
    sgx_encl_page->vm_run_prot_bits = RW

    At this point RW VMAs would be allowed to access this page and PTEs
    would allow write access as guided by
    sgx_encl_page->vm_run_prot_bits.

(2) User space invokes SGX2 to change the EPCM permissions to read-only.
    This is allowed because sgx_encl_page->vm_max_prot_bits = RW:
    sgx_encl_page->vm_max_prot_bits = RW
    sgx_encl_page->vm_run_prot_bits = R

    At this point only new read-only VMAs would be allowed to access
    this page and PTEs would not allow write access as guided
    by sgx_encl_page->vm_run_prot_bits.

(3) User space invokes SGX2 to change the EPCM permissions to RX.
    This will not be supported by the kernel because
    sgx_encl_page->vm_max_prot_bits = RW:
    sgx_encl_page->vm_max_prot_bits = RW
    sgx_encl_page->vm_run_prot_bits = R

(3) User space invokes SGX2 to change the EPCM permissions to RW.
    This will be allowed because sgx_encl_page->vm_max_prot_bits = RW:
    sgx_encl_page->vm_max_prot_bits = RW
    sgx_encl_page->vm_run_prot_bits = RW

    At this point RW VMAs would again be allowed to access this page
    and PTEs would allow write access as guided by
    sgx_encl_page->vm_run_prot_bits.

struct sgx_encl_page hosting this information is maintained for each
enclave page so the space consumed by the struct is important.
The existing sgx_encl_page->vm_max_prot_bits is already unsigned long
while only using three bits. Transition to a bitfield for the two
members containing protection bits.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Add snippet to Documentation/x86/sgx.rst that details the difference
  between vm_max_prot_bits and vm_run_prot_bits (Andy and Jarkko).
- Change subject line (Jarkko).
- Refer to actual variables instead of using English rephrasing -
  sgx_encl_page->vm_run_prot_bits instead of "runtime
  protection bits" (Jarkko).
- Add information in commit message on why two fields are needed
  (Jarkko).

 Documentation/x86/sgx.rst       | 10 ++++++++++
 arch/x86/kernel/cpu/sgx/encl.c  |  6 +++---
 arch/x86/kernel/cpu/sgx/encl.h  |  3 ++-
 arch/x86/kernel/cpu/sgx/ioctl.c |  6 ++++++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index 5659932728a5..9df620b59f83 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -99,6 +99,16 @@ The relationships between the different permission masks are:
 * PTEs are installed to match the EPCM permissions, but not be more
   relaxed than the VMA permissions.
 
+During runtime the EPCM permissions of enclave pages belonging to an
+initialized enclave can change on systems supporting SGX2. In support
+of these runtime changes the kernel maintains (for each enclave page)
+the most permissive EPCM permission mask allowed by policy as
+the ``vm_max_prot_bits`` of that page. EPCM permissions are not allowed
+to be relaxed beyond ``vm_max_prot_bits``.  The kernel also maintains
+the currently active EPCM permissions of an enclave page as its
+``vm_run_prot_bits`` to ensure PTEs and new VMAs respect the active
+EPCM permission values.
+
 On systems supporting SGX2 EPCM permissions may change while the
 enclave page belongs to a VMA without impacting the VMA permissions.
 This means that a running VMA may appear to allow access to an enclave
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 1ba01c75a579..a980d8458949 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -164,7 +164,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 	 * exceed the VMA permissions.
 	 */
 	vm_prot_bits = vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
-	page_prot_bits = entry->vm_max_prot_bits & vm_prot_bits;
+	page_prot_bits = entry->vm_run_prot_bits & vm_prot_bits;
 	/*
 	 * Add VM_SHARED so that PTE is made writable right away if VMA
 	 * and EPCM are writable (no COW in SGX).
@@ -217,7 +217,7 @@ static vm_fault_t sgx_vma_pfn_mkwrite(struct vm_fault *vmf)
 		goto out;
 	}
 
-	if (!(entry->vm_max_prot_bits & VM_WRITE))
+	if (!(entry->vm_run_prot_bits & VM_WRITE))
 		ret = VM_FAULT_SIGBUS;
 
 out:
@@ -280,7 +280,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 	mutex_lock(&encl->lock);
 	xas_lock(&xas);
 	xas_for_each(&xas, page, PFN_DOWN(end - 1)) {
-		if (~page->vm_max_prot_bits & vm_prot_bits) {
+		if (~page->vm_run_prot_bits & vm_prot_bits) {
 			ret = -EACCES;
 			break;
 		}
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index fec43ca65065..dc262d843411 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -27,7 +27,8 @@
 
 struct sgx_encl_page {
 	unsigned long desc;
-	unsigned long vm_max_prot_bits;
+	unsigned long vm_max_prot_bits:8;
+	unsigned long vm_run_prot_bits:8;
 	struct sgx_epc_page *epc_page;
 	struct sgx_encl *encl;
 	struct sgx_va_page *va_page;
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 83df20e3e633..7e0819a89532 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -197,6 +197,12 @@ static struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
 	/* Calculate maximum of the VM flags for the page. */
 	encl_page->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
 
+	/*
+	 * At time of allocation, the runtime protection bits are the same
+	 * as the maximum protection bits.
+	 */
+	encl_page->vm_run_prot_bits = encl_page->vm_max_prot_bits;
+
 	return encl_page;
 }
 
-- 
2.25.1

