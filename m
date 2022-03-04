Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8D94CD14A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbiCDJir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiCDJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054731AC2B5;
        Fri,  4 Mar 2022 01:36:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 698CFB827B8;
        Fri,  4 Mar 2022 09:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9183C340E9;
        Fri,  4 Mar 2022 09:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386612;
        bh=YvN2XxHn0WsAeJQ0tEqhXtRRJVqojQejWxtJ2dGHbDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZ6xNu6luV+yGNgfn/RPQNkgFhHbl80hw1OXNg2FJKR6tv7jf0cGIhP4bcb2wtbbi
         +f0zHDTc+tLL6h5T7Px62j4MtU6XviTPTBCTRC4hBCHJR73ygko40Veh9SjvVRHdR3
         VCSaAy5PjKoTLVgk6EzNtmR5yE13nCVTaKfWb8IeIdfW9LwXgD+AOjiKZ+6OQx+sLW
         4bBkzIj1H4d9VpVRxQh1+aAF8LzrIXDGjG8cmGejWg0/PHINAQxHWbD4OKpC8GT87M
         k0JpY1hoyHWfngRA6DQFovAmeUcDMhF5Gmp453+Uo9wpnEM44xvZT9LJv5sse0FqGY
         ZCnb3OaohrsoA==
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
Subject: [RFC PATCH v2.1 14/30] x86/sgx: Support restricting of enclave page permissions
Date:   Fri,  4 Mar 2022 11:35:08 +0200
Message-Id: <20220304093524.397485-14-jarkko@kernel.org>
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

In the initial (SGX1) version of SGX, pages in an enclave need to be
created with permissions that support all usages of the pages, from the
time the enclave is initialized until it is unloaded. For example,
pages used by a JIT compiler or when code needs to otherwise be
relocated need to always have RWX permissions.

SGX2 includes a new function ENCLS[EMODPR] that is run from the kernel
and can be used to restrict the EPCM permissions of regular enclave
pages within an initialized enclave.

Introduce ioctl() SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS to support
restricting EPCM permissions. With this ioctl() the user specifies
a page range and the permissions to be applied to all pages in
the provided range. After checking the new permissions (more detail
below) the page table entries are reset and any new page
table entries will contain the new, restricted, permissions.
ENCLS[EMODPR] is run to restrict the EPCM permissions followed by
the ENCLS[ETRACK] flow that will ensure no cached
linear-to-physical address mappings to the changed pages remain.

It is possible for the permission change request to fail on any
page within the provided range, either with an error encountered
by the kernel or by the SGX hardware while running
ENCLS[EMODPR]. To support partial success the ioctl() returns an
error code based on failures encountered by the kernel as well
as two result output parameters: one for the number of pages
that were successfully changed and one for the SGX return code.

Checking user provided new permissions
======================================

Enclave page permission changes need to be approached with care and
for this reason permission changes are only allowed if the new
permissions are the same or more restrictive that the vetted
permissions. No additional checking is done to ensure that the
permissions are actually being restricted. This is because the
enclave may have relaxed the EPCM permissions from within
the enclave without letting the kernel know. An attempt to relax
permissions using this call will be ignored by the hardware.

For example, together with the support for relaxing of EPCM permissions,
enclave pages added with the vetted permissions in brackets below
are allowed to have permissions as follows:
* (RWX) => RW => R => RX => RWX
* (RW) => R => RW
* (RX) => R => RX

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/include/uapi/asm/sgx.h |  21 +++
 arch/x86/kernel/cpu/sgx/encl.c  |   4 +-
 arch/x86/kernel/cpu/sgx/encl.h  |   3 +
 arch/x86/kernel/cpu/sgx/ioctl.c | 277 ++++++++++++++++++++++++++++++++
 4 files changed, 303 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index f4b81587e90b..107ffb0a0b48 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -29,6 +29,8 @@ enum sgx_page_flags {
 	_IOW(SGX_MAGIC, 0x03, struct sgx_enclave_provision)
 #define SGX_IOC_VEPC_REMOVE_ALL \
 	_IO(SGX_MAGIC, 0x04)
+#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
+	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_perm)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -76,6 +78,25 @@ struct sgx_enclave_provision {
 	__u64 fd;
 };
 
+/**
+ * struct sgx_enclave_restrict_perm - parameters for ioctl
+ *                                    %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
+ * @offset:	starting page offset (page aligned relative to enclave base
+ *		address defined in SECS)
+ * @length:	length of memory (multiple of the page size)
+ * @secinfo:	address for the SECINFO data containing the new permission bits
+ *		for pages in range described by @offset and @length
+ * @result:	(output) SGX result code of ENCLS[EMODPR] function
+ * @count:	(output) bytes successfully changed (multiple of page size)
+ */
+struct sgx_enclave_restrict_perm {
+	__u64 offset;
+	__u64 length;
+	__u64 secinfo;
+	__u64 result;
+	__u64 count;
+};
+
 struct sgx_enclave_run;
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 6cc732b88c37..baf798a793a2 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -90,8 +90,8 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	return epc_page;
 }
 
-static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
-						unsigned long addr)
+struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
+					 unsigned long addr)
 {
 	struct sgx_epc_page *epc_page;
 	struct sgx_encl_page *entry;
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 94ccea8fbbf2..965cfc7b2b93 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -119,4 +119,7 @@ void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
 void sgx_encl_free_epc_page(struct sgx_epc_page *page);
 
+struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
+					 unsigned long addr);
+
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 0c211af8e948..a848f6c38781 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -692,6 +692,280 @@ static long sgx_ioc_enclave_provision(struct sgx_encl *encl, void __user *arg)
 	return sgx_set_attribute(&encl->attributes_mask, params.fd);
 }
 
+static unsigned long vm_prot_from_secinfo(u64 secinfo_perm)
+{
+	unsigned long vm_prot;
+
+	vm_prot = _calc_vm_trans(secinfo_perm, SGX_SECINFO_R, PROT_READ)  |
+		  _calc_vm_trans(secinfo_perm, SGX_SECINFO_W, PROT_WRITE) |
+		  _calc_vm_trans(secinfo_perm, SGX_SECINFO_X, PROT_EXEC);
+	vm_prot = calc_vm_prot_bits(vm_prot, 0);
+
+	return vm_prot;
+}
+
+/*
+ * Ensure enclave is ready for SGX2 functions. Readiness is checked
+ * by ensuring the hardware supports SGX2 and the enclave is initialized
+ * and thus able to handle requests to modify pages within it.
+ */
+static int sgx_ioc_sgx2_ready(struct sgx_encl *encl)
+{
+	if (!(cpu_feature_enabled(X86_FEATURE_SGX2)))
+		return -ENODEV;
+
+	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Return valid permission fields from a secinfo structure provided by
+ * user space. The secinfo structure is required to only have bits in
+ * the permission fields set.
+ */
+static int sgx_perm_from_user_secinfo(void __user *_secinfo, u64 *secinfo_perm)
+{
+	struct sgx_secinfo secinfo;
+	u64 perm;
+
+	if (copy_from_user(&secinfo, (void __user *)_secinfo,
+			   sizeof(secinfo)))
+		return -EFAULT;
+
+	if (secinfo.flags & ~SGX_SECINFO_PERMISSION_MASK)
+		return -EINVAL;
+
+	if (memchr_inv(secinfo.reserved, 0, sizeof(secinfo.reserved)))
+		return -EINVAL;
+
+	perm = secinfo.flags & SGX_SECINFO_PERMISSION_MASK;
+
+	if ((perm & SGX_SECINFO_W) && !(perm & SGX_SECINFO_R))
+		return -EINVAL;
+
+	*secinfo_perm = perm;
+
+	return 0;
+}
+
+/*
+ * Some SGX functions require that no cached linear-to-physical address
+ * mappings are present before they can succeed. Collaborate with
+ * hardware via ENCLS[ETRACK] to ensure that all cached
+ * linear-to-physical address mappings belonging to all threads of
+ * the enclave are cleared. See sgx_encl_cpumask() for details.
+ */
+static int sgx_enclave_etrack(struct sgx_encl *encl)
+{
+	void *epc_virt;
+	int ret;
+
+	epc_virt = sgx_get_epc_virt_addr(encl->secs.epc_page);
+	ret = __etrack(epc_virt);
+	if (ret) {
+		/*
+		 * ETRACK only fails when there is an OS issue. For
+		 * example, two consecutive ETRACK was sent without
+		 * completed IPI between.
+		 */
+		pr_err_once("ETRACK returned %d (0x%x)", ret, ret);
+		/*
+		 * Send IPIs to kick CPUs out of the enclave and
+		 * try ETRACK again.
+		 */
+		on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb, NULL, 1);
+		ret = __etrack(epc_virt);
+		if (ret) {
+			pr_err_once("ETRACK repeat returned %d (0x%x)",
+				    ret, ret);
+			return -EFAULT;
+		}
+	}
+	on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb, NULL, 1);
+
+	return 0;
+}
+
+/**
+ * sgx_enclave_restrict_perm() - Restrict EPCM permissions and align OS view
+ * @encl:	Enclave to which the pages belong.
+ * @modp:	Checked parameters from user on which pages need modifying.
+ * @secinfo_perm: New (validated) permission bits.
+ *
+ * Return:
+ * - 0:		Success.
+ * - -errno:	Otherwise.
+ */
+static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
+				      struct sgx_enclave_restrict_perm *modp,
+				      u64 secinfo_perm)
+{
+	struct sgx_encl_page *entry;
+	struct sgx_secinfo secinfo;
+	unsigned long vm_prot;
+	unsigned long addr;
+	unsigned long c;
+	void *epc_virt;
+	int ret;
+
+	memset(&secinfo, 0, sizeof(secinfo));
+	secinfo.flags = secinfo_perm;
+
+	vm_prot = vm_prot_from_secinfo(secinfo_perm);
+
+	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
+		addr = encl->base + modp->offset + c;
+
+		mutex_lock(&encl->lock);
+
+		entry = sgx_encl_load_page(encl, addr);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry) == -EBUSY ? -EAGAIN : -EFAULT;
+			goto out_unlock;
+		}
+
+		/*
+		 * Changing EPCM permissions is only supported on regular
+		 * SGX pages. Attempting this change on other pages will
+		 * result in #PF.
+		 */
+		if (entry->type != SGX_PAGE_TYPE_REG) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		/*
+		 * Do not verify if current runtime protection bits are what
+		 * is being requested. The enclave may have relaxed EPCM
+		 * permissions calls without letting the kernel know and
+		 * thus permission restriction may still be needed even if
+		 * from the kernel's perspective the permissions are unchanged.
+		 */
+
+		/* New permissions should never exceed vetted permissions. */
+		if ((entry->vm_max_prot_bits & vm_prot) != vm_prot) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+
+		/* Make sure page stays around while releasing mutex. */
+		if (sgx_unmark_page_reclaimable(entry->epc_page)) {
+			ret = -EAGAIN;
+			goto out_unlock;
+		}
+
+		mutex_unlock(&encl->lock);
+		/*
+		 * Do not keep encl->lock because of dependency on
+		 * mmap_lock acquired in sgx_zap_enclave_ptes().
+		 */
+		sgx_zap_enclave_ptes(encl, addr);
+
+		mutex_lock(&encl->lock);
+
+		/* Change EPCM permissions. */
+		epc_virt = sgx_get_epc_virt_addr(entry->epc_page);
+		ret = __emodpr(&secinfo, epc_virt);
+		if (encls_faulted(ret)) {
+			/*
+			 * All possible faults should be avoidable:
+			 * parameters have been checked, will only change
+			 * permissions of a regular page, and no concurrent
+			 * SGX1/SGX2 ENCLS instructions since these
+			 * are protected with mutex.
+			 */
+			pr_err_once("EMODPR encountered exception %d\n",
+				    ENCLS_TRAPNR(ret));
+			ret = -EFAULT;
+			goto out_reclaim;
+		}
+		if (encls_failed(ret)) {
+			modp->result = ret;
+			ret = -EFAULT;
+			goto out_reclaim;
+		}
+
+		ret = sgx_enclave_etrack(encl);
+		if (ret) {
+			ret = -EFAULT;
+			goto out_reclaim;
+		}
+
+		sgx_mark_page_reclaimable(entry->epc_page);
+		mutex_unlock(&encl->lock);
+	}
+
+	ret = 0;
+	goto out;
+
+out_reclaim:
+	sgx_mark_page_reclaimable(entry->epc_page);
+out_unlock:
+	mutex_unlock(&encl->lock);
+out:
+	modp->count = c;
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_restrict_perm() - handler for
+ *                                   %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
+ * @encl:	an enclave pointer
+ * @arg:	userspace pointer to a &struct sgx_enclave_restrict_perm
+ *		instance
+ *
+ * SGX2 distinguishes between relaxing and restricting the enclave page
+ * permissions maintained by the hardware (EPCM permissions) of pages
+ * belonging to an initialized enclave (after SGX_IOC_ENCLAVE_INIT).
+ *
+ * EPCM permissions cannot be restricted from within the enclave, the enclave
+ * requires the kernel to run the privileged level 0 instructions ENCLS[EMODPR]
+ * and ENCLS[ETRACK]. An attempt to relax EPCM permissions with this call
+ * will be ignored by the hardware.
+ *
+ * Enclave page permissions are not allowed to exceed the maximum vetted
+ * permissions maintained in &struct sgx_encl_page->vm_max_prot_bits.
+ *
+ * Return:
+ * - 0:		Success
+ * - -errno:	Otherwise
+ */
+static long sgx_ioc_enclave_restrict_perm(struct sgx_encl *encl,
+					  void __user *arg)
+{
+	struct sgx_enclave_restrict_perm params;
+	u64 secinfo_perm;
+	long ret;
+
+	ret = sgx_ioc_sgx2_ready(encl);
+	if (ret)
+		return ret;
+
+	if (copy_from_user(&params, arg, sizeof(params)))
+		return -EFAULT;
+
+	if (sgx_validate_offset_length(encl, params.offset, params.length))
+		return -EINVAL;
+
+	ret = sgx_perm_from_user_secinfo((void __user *)params.secinfo,
+					 &secinfo_perm);
+	if (ret)
+		return ret;
+
+	if (params.result || params.count)
+		return -EINVAL;
+
+	ret = sgx_enclave_restrict_perm(encl, &params, secinfo_perm);
+
+	if (copy_to_user(arg, &params, sizeof(params)))
+		return -EFAULT;
+
+	return ret;
+}
+
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
 	struct sgx_encl *encl = filep->private_data;
@@ -713,6 +987,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_PROVISION:
 		ret = sgx_ioc_enclave_provision(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS:
+		ret = sgx_ioc_enclave_restrict_perm(encl, (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.35.1

