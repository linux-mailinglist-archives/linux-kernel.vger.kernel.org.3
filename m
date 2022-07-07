Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93DD56AACD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiGGS3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiGGS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:28:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1885C9FC;
        Thu,  7 Jul 2022 11:27:56 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWo5XSh1nhHsfCr8b9S54NFU4enBS6/ifvbglH4k5Rs=;
        b=sjj8qZiyHoA3IxNVc4CFQbkGoLoGChCjn1IfIAllXnrF4LyykZrFIkCKm9zddIf7euMf83
        ybfUBxKqRTPXoIEtKf0m00FAbSzwzPhQ6sJ1tTLrS7OFTUMuLWSAHwYd7nIIyQvnFbAa0h
        j5+oaoTtpnTt3sA0fsmIvS6plZ2SpFEt3r1px4DptbShavx2cQo0BEh3Kqxq+8arNbw2aP
        deMNpkelznRftN282wYUktIwZEKyh1wQrxcjQrEBwD4o40F+nld8jjBbHA0k7LAydyFPNi
        fYwYDwsSnOVsBOonh6lQOCHBObncxLvRXxxhWyxlMAvDnQh/YMlBdYhORjzW3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWo5XSh1nhHsfCr8b9S54NFU4enBS6/ifvbglH4k5Rs=;
        b=ShoZ0H7V3u66aN1q8pNn72n9/hRW/7pZyyTFBodrww1EIfjTTAzVUWNb6kogY0IHMW+kej
        OskwZMuBaNe7b2CQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Support loading enclave page without VMA
 permissions check
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd4393513c1f18987c14a490bcf133bfb71a5dc43=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cd4393513c1f18987c14a490bcf133bfb71a5dc43=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721847344.15455.9032781062639676151.tip-bot2@tip-bot2>
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

Commit-ID:     b3fb517dc6020fec85c82171a909da10c6a6f90a
Gitweb:        https://git.kernel.org/tip/b3fb517dc6020fec85c82171a909da10c6a6f90a
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:41 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:01 -07:00

x86/sgx: Support loading enclave page without VMA permissions check

sgx_encl_load_page() is used to find and load an enclave page into
enclave (EPC) memory, potentially loading it from the backing storage.
Both usages of sgx_encl_load_page() are during an access to the
enclave page from a VMA and thus the permissions of the VMA are
considered before the enclave page is loaded.

SGX2 functions operating on enclave pages belonging to an initialized
enclave requiring the page to be in EPC. It is thus required to
support loading enclave pages into the EPC independent from a VMA.

Split the current sgx_encl_load_page() to support the two usages:
A new call, sgx_encl_load_page_in_vma(), behaves exactly like the
current sgx_encl_load_page() that takes VMA permissions into account,
while sgx_encl_load_page() just loads an enclave page into EPC.

VMA, PTE, and EPCM permissions continue to dictate whether
the pages can be accessed from within an enclave.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/d4393513c1f18987c14a490bcf133bfb71a5dc43.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 57 ++++++++++++++++++++++-----------
 arch/x86/kernel/cpu/sgx/encl.h |  2 +-
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 3c24e61..7ad8b47 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -232,25 +232,10 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	return epc_page;
 }
 
-static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
-						unsigned long addr,
-						unsigned long vm_flags)
+static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
+						  struct sgx_encl_page *entry)
 {
-	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
 	struct sgx_epc_page *epc_page;
-	struct sgx_encl_page *entry;
-
-	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
-	if (!entry)
-		return ERR_PTR(-EFAULT);
-
-	/*
-	 * Verify that the faulted page has equal or higher build time
-	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
-	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
-	 */
-	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
-		return ERR_PTR(-EFAULT);
 
 	/* Entry successfully located. */
 	if (entry->epc_page) {
@@ -276,6 +261,40 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 	return entry;
 }
 
+static struct sgx_encl_page *sgx_encl_load_page_in_vma(struct sgx_encl *encl,
+						       unsigned long addr,
+						       unsigned long vm_flags)
+{
+	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
+	struct sgx_encl_page *entry;
+
+	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
+	if (!entry)
+		return ERR_PTR(-EFAULT);
+
+	/*
+	 * Verify that the page has equal or higher build time
+	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
+	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
+	 */
+	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
+		return ERR_PTR(-EFAULT);
+
+	return __sgx_encl_load_page(encl, entry);
+}
+
+struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
+					 unsigned long addr)
+{
+	struct sgx_encl_page *entry;
+
+	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
+	if (!entry)
+		return ERR_PTR(-EFAULT);
+
+	return __sgx_encl_load_page(encl, entry);
+}
+
 static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 {
 	unsigned long addr = (unsigned long)vmf->address;
@@ -297,7 +316,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 
 	mutex_lock(&encl->lock);
 
-	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
+	entry = sgx_encl_load_page_in_vma(encl, addr, vma->vm_flags);
 	if (IS_ERR(entry)) {
 		mutex_unlock(&encl->lock);
 
@@ -445,7 +464,7 @@ static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
 	for ( ; ; ) {
 		mutex_lock(&encl->lock);
 
-		entry = sgx_encl_load_page(encl, addr, vm_flags);
+		entry = sgx_encl_load_page_in_vma(encl, addr, vm_flags);
 		if (PTR_ERR(entry) != -EBUSY)
 			break;
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index d44e737..522a17e 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -116,5 +116,7 @@ unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
 void sgx_encl_free_epc_page(struct sgx_epc_page *page);
+struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
+					 unsigned long addr);
 
 #endif /* _X86_ENCL_H */
