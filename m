Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83B44CCC06
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiCDC5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbiCDC5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:57:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7955117EDA5;
        Thu,  3 Mar 2022 18:56:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B2061A17;
        Fri,  4 Mar 2022 02:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDF1C004E1;
        Fri,  4 Mar 2022 02:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646362576;
        bh=y0CcN02R3T02b5agluklpjI6uCWpnLOSvkKm4FPOpSY=;
        h=From:To:Cc:Subject:Date:From;
        b=X7eBQkP+8LchNO/JFYYZz2XARwJmbfakWuNO4ramysZ7pbQDS7naHvjO/SGV0diQF
         vO260L8DCctc1y/jEoNHuTYyJwRKytaX0Db636rD7MhVAuwam7yW4gwq/PRiZTo10K
         j5E1R420rfqBl8bBitZKsqmt0t5+Rfrvo3elj5P/Y2gCOsY0cBQz/8f8MFbTzdWYEK
         cmXyKz2h4HC+tf02gx5u7maKVPEe7P2BxFnc4WQcG6nAsXb6Q9GOPzLPUv15fEtl6j
         mKzjO4Kn6nKe29T9agb9PLvb8sLQEZybNExfYZ6OZfIodV0esLQphYZKdM4nlsRjpY
         vRTXXMmlMNDPw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v2] x86/sgx: Do not limit EAUG'd pages by pre-initialization policy
Date:   Fri,  4 Mar 2022 04:55:30 +0200
Message-Id: <20220304025530.346238-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Pre-initialization policy is meant for EADD'd pages because they are
part of the enclave identity. It's a good practice to not let touch the
permissions after initialization, and does provide guarantees to e.g.
LSM's about the enclave.

For EAUG'd pages it should be sufficient to let mmap(), mprotect() and
SGX opcodes to control the permissions. Thus effectively disable
pre-initialization policy by setting vm_max_prot_bits to RWX.

Finally, remove vm_run_prot_bits. For EADD'd pages the roof is where
it was during construction, for EAUG'd we don't simply care. This
hard to keep in-sync variable adds only a layer of complexity and
nothing else.

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Nathaniel McCallum <nathaniel@profian.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
Remove vm_run_prot_bits.
---
 arch/x86/kernel/cpu/sgx/encl.c  | 17 +++++------------
 arch/x86/kernel/cpu/sgx/encl.h  |  1 -
 arch/x86/kernel/cpu/sgx/ioctl.c | 33 ++++-----------------------------
 3 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 5fe7189eac9d..c350fb987a11 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -200,15 +200,8 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	encl_page->desc = addr;
 	encl_page->encl = encl;
 
-	/*
-	 * Adding a regular page that is architecturally allowed to only
-	 * be created with RW permissions.
-	 * TBD: Interface with user space policy to support max permissions
-	 * of RWX.
-	 */
-	prot = PROT_READ | PROT_WRITE;
-	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
-	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
+	prot = PROT_READ | PROT_WRITE | PROT_EXEC;
+	encl_page->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
 
 	epc_page = sgx_alloc_epc_page(encl_page, true);
 	if (IS_ERR(epc_page)) {
@@ -338,7 +331,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 	 * exceed the VMA permissions.
 	 */
 	vm_prot_bits = vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
-	page_prot_bits = entry->vm_run_prot_bits & vm_prot_bits;
+	page_prot_bits = entry->vm_max_prot_bits & vm_prot_bits;
 	/*
 	 * Add VM_SHARED so that PTE is made writable right away if VMA
 	 * and EPCM are writable (no COW in SGX).
@@ -391,7 +384,7 @@ static vm_fault_t sgx_vma_pfn_mkwrite(struct vm_fault *vmf)
 		goto out;
 	}
 
-	if (!(entry->vm_run_prot_bits & VM_WRITE))
+	if (!(entry->vm_max_prot_bits & VM_WRITE))
 		ret = VM_FAULT_SIGBUS;
 
 out:
@@ -459,7 +452,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 	mutex_lock(&encl->lock);
 	xas_lock(&xas);
 	xas_for_each(&xas, page, PFN_DOWN(end - 1)) {
-		if (~page->vm_run_prot_bits & vm_prot_bits) {
+		if (~page->vm_max_prot_bits & vm_prot_bits) {
 			ret = -EACCES;
 			break;
 		}
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 1b6ce1da7c92..241e302e7a72 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -28,7 +28,6 @@
 struct sgx_encl_page {
 	unsigned long desc;
 	unsigned long vm_max_prot_bits:8;
-	unsigned long vm_run_prot_bits:8;
 	enum sgx_page_type type:16;
 	struct sgx_epc_page *epc_page;
 	struct sgx_encl *encl;
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index d8c3c07badb3..9ce13a962483 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -198,12 +198,6 @@ static struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
 	/* Calculate maximum of the VM flags for the page. */
 	encl_page->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
 
-	/*
-	 * At time of allocation, the runtime protection bits are the same
-	 * as the maximum protection bits.
-	 */
-	encl_page->vm_run_prot_bits = encl_page->vm_max_prot_bits;
-
 	return encl_page;
 }
 
@@ -764,12 +758,6 @@ static long sgx_enclave_relax_perm(struct sgx_encl *encl,
 			goto out_unlock;
 		}
 
-		/*
-		 * Change runtime protection before zapping PTEs to ensure
-		 * any new #PF uses new permissions.
-		 */
-		entry->vm_run_prot_bits = vm_prot;
-
 		mutex_unlock(&encl->lock);
 		/*
 		 * Do not keep encl->lock because of dependency on
@@ -946,9 +934,9 @@ static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
 				      struct sgx_enclave_restrict_perm *modp,
 				      u64 secinfo_perm)
 {
-	unsigned long vm_prot, run_prot_restore;
 	struct sgx_encl_page *entry;
 	struct sgx_secinfo secinfo;
+	unsigned long vm_prot;
 	unsigned long addr;
 	unsigned long c;
 	void *epc_virt;
@@ -1002,14 +990,6 @@ static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
 			goto out_unlock;
 		}
 
-		/*
-		 * Change runtime protection before zapping PTEs to ensure
-		 * any new #PF uses new permissions. EPCM permissions (if
-		 * needed) not changed yet.
-		 */
-		run_prot_restore = entry->vm_run_prot_bits;
-		entry->vm_run_prot_bits = vm_prot;
-
 		mutex_unlock(&encl->lock);
 		/*
 		 * Do not keep encl->lock because of dependency on
@@ -1033,12 +1013,12 @@ static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
 			pr_err_once("EMODPR encountered exception %d\n",
 				    ENCLS_TRAPNR(ret));
 			ret = -EFAULT;
-			goto out_prot_restore;
+			goto out_reclaim;
 		}
 		if (encls_failed(ret)) {
 			modp->result = ret;
 			ret = -EFAULT;
-			goto out_prot_restore;
+			goto out_reclaim;
 		}
 
 		ret = sgx_enclave_etrack(encl);
@@ -1054,8 +1034,6 @@ static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
 	ret = 0;
 	goto out;
 
-out_prot_restore:
-	entry->vm_run_prot_bits = run_prot_restore;
 out_reclaim:
 	sgx_mark_page_reclaimable(entry->epc_page);
 out_unlock:
@@ -1136,7 +1114,7 @@ static long sgx_enclave_modt(struct sgx_encl *encl,
 			     struct sgx_enclave_modt *modt,
 			     enum sgx_page_type page_type)
 {
-	unsigned long max_prot_restore, run_prot_restore;
+	unsigned long max_prot_restore;
 	struct sgx_encl_page *entry;
 	struct sgx_secinfo secinfo;
 	unsigned long prot;
@@ -1182,7 +1160,6 @@ static long sgx_enclave_modt(struct sgx_encl *encl,
 		}
 
 		max_prot_restore = entry->vm_max_prot_bits;
-		run_prot_restore = entry->vm_run_prot_bits;
 
 		/*
 		 * Once a regular page becomes a TCS page it cannot be
@@ -1200,7 +1177,6 @@ static long sgx_enclave_modt(struct sgx_encl *encl,
 			}
 			prot = PROT_READ | PROT_WRITE;
 			entry->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
-			entry->vm_run_prot_bits = entry->vm_max_prot_bits;
 
 			/*
 			 * Prevent page from being reclaimed while mutex
@@ -1262,7 +1238,6 @@ static long sgx_enclave_modt(struct sgx_encl *encl,
 
 out_entry_changed:
 	entry->vm_max_prot_bits = max_prot_restore;
-	entry->vm_run_prot_bits = run_prot_restore;
 out_unlock:
 	mutex_unlock(&encl->lock);
 out:
-- 
2.35.1

