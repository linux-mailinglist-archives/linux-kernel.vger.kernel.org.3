Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD12946565E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245134AbhLAT15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:27:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:46907 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245142AbhLAT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="235267924"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="235267924"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500380449"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:42 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Date:   Wed,  1 Dec 2021 11:23:03 -0800
Message-Id: <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638381245.git.reinette.chatre@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclave creators declare their paging permission intent at the time
the pages are added to the enclave. These paging permissions are
vetted when pages are added to the enclave and stashed off
(in sgx_encl_page->vm_max_prot_bits) for later comparison with
enclave PTEs.

Current permission support assume that enclave page permissions
remain static for the lifetime of the enclave. This is about to change
with the addition of support for SGX2 where the permissions of enclave
pages belonging to an initialized enclave may be changed during the
enclave's lifetime.

Introduce runtime protection bits in preparation for support of
enclave page permission changes. These bits reflect the active
permissions of an enclave page and are not to exceed the maximum
protection bits that passed scrutiny during enclave creation.

Associate runtime protection bits with each enclave page. Initialize
the runtime protection bits to the vetted maximum protection bits
on page creation. Use the runtime protection bits for any access
checks.

struct sgx_encl_page hosting this information is maintained for each
enclave page so the space consumed by the struct is important.
The existing vm_max_prot_bits is already unsigned long while only using
three bits. Transition to a bitfield for the two members containing
protection bits.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c  | 6 +++---
 arch/x86/kernel/cpu/sgx/encl.h  | 3 ++-
 arch/x86/kernel/cpu/sgx/ioctl.c | 6 ++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 60afa8eaf979..6fec68896e1b 100644
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

