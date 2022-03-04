Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22AA4CCC54
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 04:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiCDDkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 22:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiCDDku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 22:40:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7140D17B0E2;
        Thu,  3 Mar 2022 19:40:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E81EDB82740;
        Fri,  4 Mar 2022 03:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA83C340E9;
        Fri,  4 Mar 2022 03:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646365200;
        bh=cUyVCfN6pHKsw5cMYLC1/A2lzAsx6jCsMC6j+zAFTs8=;
        h=From:To:Cc:Subject:Date:From;
        b=Ydm49RA2zDS/eLCh+BlLeml8B7r9HZkv+Re/BWJP13/GzUeGqlw0zDasbZ1xP4wqz
         BkHqlQKnKMP5FmCvJ2Az4jnNgKEjpNGIKwflwZ4gbzcmaRyCDZZ8OYpPzO3PSdjvx0
         BmGOtAySquVDEnMKP/TePYEqO9KShhiS+K0XTjcWdEVMLnEB9N9PkhG8PyyzcBFza9
         LQvNpl5RGb2xEkzZ/nIdSKX77Iya8DIY88AOpT7llcPBqdEVizQBSWxuy5x5eVrfx4
         eNvfJPscm7Gd8Xqn4yZVxdamyr/veukcQ/LhIeykAuQuUu8yCfECi7Za8X34NjBe9k
         d+p5OS/A46K2w==
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
Subject: [PATCH v3] x86/sgx: Do not limit EAUG'd pages by pre-initialization policy
Date:   Fri,  4 Mar 2022 05:39:18 +0200
Message-Id: <20220304033918.361495-1-jarkko@kernel.org>
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

Then, remove vm_run_prot_bits. For EADD'd pages the roof is where
it was during construction, for EAUG'd we don't simply care. This
hard to keep in-sync variable adds only a layer of complexity and
nothing else.

Without vm_run_prot_bits existing, SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
does absolutely nothing. Therefore, it can be safely removed.

Link: https://lore.kernel.org/linux-sgx/YiFkDVhBBYj9zo1N@iki.fi/T/#t
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Nathaniel McCallum <nathaniel@profian.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
Remove SGX_IOC_ENCLAVE_RELAX_PERMISSIONS.
v2:
Remove vm_run_prot_bits.
---
 arch/x86/include/uapi/asm/sgx.h |  19 ----
 arch/x86/kernel/cpu/sgx/encl.c  |  17 +---
 arch/x86/kernel/cpu/sgx/encl.h  |   1 -
 arch/x86/kernel/cpu/sgx/ioctl.c | 168 +-------------------------------
 4 files changed, 9 insertions(+), 196 deletions(-)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index db969a2a1874..6cfdd89d3076 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -29,8 +29,6 @@ enum sgx_page_flags {
 	_IOW(SGX_MAGIC, 0x03, struct sgx_enclave_provision)
 #define SGX_IOC_VEPC_REMOVE_ALL \
 	_IO(SGX_MAGIC, 0x04)
-#define SGX_IOC_ENCLAVE_RELAX_PERMISSIONS \
-	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_relax_perm)
 #define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
 	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_restrict_perm)
 #define SGX_IOC_ENCLAVE_MODIFY_TYPE \
@@ -84,23 +82,6 @@ struct sgx_enclave_provision {
 	__u64 fd;
 };
 
-/**
- * struct sgx_enclave_relax_perm - parameters for ioctl
- *                                 %SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
- * @offset:	starting page offset (page aligned relative to enclave base
- *		address defined in SECS)
- * @length:	length of memory (multiple of the page size)
- * @secinfo:	address for the SECINFO data containing the new permission bits
- *		for pages in range described by @offset and @length
- * @count:	(output) bytes successfully changed (multiple of page size)
- */
-struct sgx_enclave_relax_perm {
-	__u64 offset;
-	__u64 length;
-	__u64 secinfo;
-	__u64 count;
-};
-
 /**
  * struct sgx_enclave_restrict_perm - parameters for ioctl
  *                                    %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
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
index d8c3c07badb3..3ad4320ff6ae 100644
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
 
@@ -710,85 +704,6 @@ static unsigned long vm_prot_from_secinfo(u64 secinfo_perm)
 	return vm_prot;
 }
 
-/**
- * sgx_enclave_relax_perm() - Update OS after permissions relaxed by enclave
- * @encl:	Enclave to which the pages belong.
- * @modp:	Checked parameters from user on which pages need modifying.
- * @secinfo_perm: New validated permission bits.
- *
- * Return:
- * - 0:		Success.
- * - -errno:	Otherwise.
- */
-static long sgx_enclave_relax_perm(struct sgx_encl *encl,
-				   struct sgx_enclave_relax_perm *modp,
-				   u64 secinfo_perm)
-{
-	struct sgx_encl_page *entry;
-	unsigned long vm_prot;
-	unsigned long addr;
-	unsigned long c;
-	int ret;
-
-	vm_prot = vm_prot_from_secinfo(secinfo_perm);
-
-	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
-		addr = encl->base + modp->offset + c;
-
-		mutex_lock(&encl->lock);
-
-		entry = xa_load(&encl->page_array, PFN_DOWN(addr));
-		if (!entry) {
-			ret = -EFAULT;
-			goto out_unlock;
-		}
-
-		/*
-		 * Changing EPCM permissions is only supported on regular
-		 * SGX pages.
-		 */
-		if (entry->type != SGX_PAGE_TYPE_REG) {
-			ret = -EINVAL;
-			goto out_unlock;
-		}
-
-		/*
-		 * Do not accept permissions that are more relaxed
-		 * than vetted permissions.
-		 * If this check fails then EPCM permissions may be more
-		 * relaxed that what would be allowed by the kernel via
-		 * PTEs.
-		 */
-		if ((entry->vm_max_prot_bits & vm_prot) != vm_prot) {
-			ret = -EPERM;
-			goto out_unlock;
-		}
-
-		/*
-		 * Change runtime protection before zapping PTEs to ensure
-		 * any new #PF uses new permissions.
-		 */
-		entry->vm_run_prot_bits = vm_prot;
-
-		mutex_unlock(&encl->lock);
-		/*
-		 * Do not keep encl->lock because of dependency on
-		 * mmap_lock acquired in sgx_zap_enclave_ptes().
-		 */
-		sgx_zap_enclave_ptes(encl, addr);
-	}
-
-	ret = 0;
-	goto out;
-
-out_unlock:
-	mutex_unlock(&encl->lock);
-out:
-	modp->count = c;
-
-	return ret;
-}
-
 /*
  * Ensure enclave is ready for SGX2 functions. Readiness is checked
  * by ensuring the hardware supports SGX2 and the enclave is initialized
@@ -835,65 +750,6 @@ static int sgx_perm_from_user_secinfo(void __user *_secinfo, u64 *secinfo_perm)
 	return 0;
 }
 
-/**
- * sgx_ioc_enclave_relax_perm() - handler for
- *                                %SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
- * @encl:	an enclave pointer
- * @arg:	userspace pointer to a &struct sgx_enclave_relax_perm instance
- *
- * SGX2 distinguishes between relaxing and restricting the enclave page
- * permissions maintained by the hardware (EPCM permissions) of pages
- * belonging to an initialized enclave (after %SGX_IOC_ENCLAVE_INIT).
- *
- * EPCM permissions can be relaxed anytime directly from within the enclave
- * with no visibility from the kernel. This is accomplished with
- * ENCLU[EMODPE] run from within the enclave. Accessing pages with
- * the new, relaxed permissions requires the kernel to update the PTE
- * to handle the subsequent #PF correctly.
- *
- * Enclave page permissions are not allowed to exceed the
- * maximum vetted permissions maintained in
- * &struct sgx_encl_page->vm_max_prot_bits. If the enclave
- * exceeds these permissions by running ENCLU[EMODPE] from within the enclave
- * the kernel will prevent access to the pages via PTE and
- * VMA permissions.
- *
- * Return:
- * - 0:		Success
- * - -errno:	Otherwise
- */
-static long sgx_ioc_enclave_relax_perm(struct sgx_encl *encl, void __user *arg)
-{
-	struct sgx_enclave_relax_perm params;
-	u64 secinfo_perm;
-	long ret;
-
-	ret = sgx_ioc_sgx2_ready(encl);
-	if (ret)
-		return ret;
-
-	if (copy_from_user(&params, arg, sizeof(params)))
-		return -EFAULT;
-
-	if (sgx_validate_offset_length(encl, params.offset, params.length))
-		return -EINVAL;
-
-	ret = sgx_perm_from_user_secinfo((void __user *)params.secinfo,
-					 &secinfo_perm);
-	if (ret)
-		return ret;
-
-	if (params.count)
-		return -EINVAL;
-
-	ret = sgx_enclave_relax_perm(encl, &params, secinfo_perm);
-
-	if (copy_to_user(arg, &params, sizeof(params)))
-		return -EFAULT;
-
-	return ret;
-}
-
 /*
  * Some SGX functions require that no cached linear-to-physical address
  * mappings are present before they can succeed. Collaborate with
@@ -946,9 +802,9 @@ static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
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
@@ -1002,14 +858,6 @@ static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
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
@@ -1033,12 +881,12 @@ static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
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
@@ -1054,8 +902,6 @@ static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
 	ret = 0;
 	goto out;
 
-out_prot_restore:
-	entry->vm_run_prot_bits = run_prot_restore;
 out_reclaim:
 	sgx_mark_page_reclaimable(entry->epc_page);
 out_unlock:
@@ -1136,7 +982,7 @@ static long sgx_enclave_modt(struct sgx_encl *encl,
 			     struct sgx_enclave_modt *modt,
 			     enum sgx_page_type page_type)
 {
-	unsigned long max_prot_restore, run_prot_restore;
+	unsigned long max_prot_restore;
 	struct sgx_encl_page *entry;
 	struct sgx_secinfo secinfo;
 	unsigned long prot;
@@ -1182,7 +1028,6 @@ static long sgx_enclave_modt(struct sgx_encl *encl,
 		}
 
 		max_prot_restore = entry->vm_max_prot_bits;
-		run_prot_restore = entry->vm_run_prot_bits;
 
 		/*
 		 * Once a regular page becomes a TCS page it cannot be
@@ -1200,7 +1045,6 @@ static long sgx_enclave_modt(struct sgx_encl *encl,
 			}
 			prot = PROT_READ | PROT_WRITE;
 			entry->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
-			entry->vm_run_prot_bits = entry->vm_max_prot_bits;
 
 			/*
 			 * Prevent page from being reclaimed while mutex
@@ -1262,7 +1106,6 @@ static long sgx_enclave_modt(struct sgx_encl *encl,
 
 out_entry_changed:
 	entry->vm_max_prot_bits = max_prot_restore;
-	entry->vm_run_prot_bits = run_prot_restore;
 out_unlock:
 	mutex_unlock(&encl->lock);
 out:
@@ -1498,9 +1341,6 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_PROVISION:
 		ret = sgx_ioc_enclave_provision(encl, (void __user *)arg);
 		break;
-	case SGX_IOC_ENCLAVE_RELAX_PERMISSIONS:
-		ret = sgx_ioc_enclave_relax_perm(encl, (void __user *)arg);
-		break;
 	case SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS:
 		ret = sgx_ioc_enclave_restrict_perm(encl, (void __user *)arg);
 		break;
-- 
2.35.1

