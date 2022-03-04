Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8174CD16A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiCDJkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbiCDJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269F1986F0;
        Fri,  4 Mar 2022 01:37:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47E5461919;
        Fri,  4 Mar 2022 09:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BD2C340E9;
        Fri,  4 Mar 2022 09:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386629;
        bh=9fi/2jUf+PXia13XYfleroCJFtMUOM8/GTAonJi9M0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLE111mhsBbmHzbKPc9RAK5G3PJBcBy3U/RuGu5nCcIaSYtDORBrO8Dgde9LDQikH
         kUlP5CB3Y2We/ZDW+LgJ2CJwtBJBkkad/t0kLb7bBIldue7y2cSKxj9dPLhsou9oyE
         R1yHuytCbxozqJFaaDqqMrJkHy8WlQOZ9ttlEAHbX2ufqskjpSKzndxwLGO7vtl4+3
         LaCnCywV/Rf99CizwzJce3EbS3MOE429dbIgXY17Kr1nXE8FejEjdXuHysXa+6nqpC
         jUEAGTT7RCAs2DzvdjAOEzMv+zdgMNsFQ7nvxZu+ttcZGg1lUOzniiBoR70mcG1YQD
         vU5HxIR1Z30gQ==
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
Subject: [RFC PATCH v2.1 20/30] x86/sgx: Support modifying SGX page type
Date:   Fri,  4 Mar 2022 11:35:14 +0200
Message-Id: <20220304093524.397485-20-jarkko@kernel.org>
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

Every enclave contains one or more Thread Control Structures (TCS). The
TCS contains meta-data used by the hardware to save and restore thread
specific information when entering/exiting the enclave. With SGX1 an
enclave needs to be created with enough TCSs to support the largest
number of threads expecting to use the enclave and enough enclave pages
to meet all its anticipated memory demands. In SGX1 all pages remain in
the enclave until the enclave is unloaded.

SGX2 introduces a new function, ENCLS[EMODT], that is used to change
the type of an enclave page from a regular (SGX_PAGE_TYPE_REG) enclave
page to a TCS (SGX_PAGE_TYPE_TCS) page or change the type from a
regular (SGX_PAGE_TYPE_REG) or TCS (SGX_PAGE_TYPE_TCS)
page to a trimmed (SGX_PAGE_TYPE_TRIM) page (setting it up for later
removal).

With the existing support of dynamically adding regular enclave pages
to an initialized enclave and changing the page type to TCS it is
possible to dynamically increase the number of threads supported by an
enclave.

Changing the enclave page type to SGX_PAGE_TYPE_TRIM is the first step
of dynamically removing pages from an initialized enclave. The complete
page removal flow is:
1) Change the type of the pages to be removed to SGX_PAGE_TYPE_TRIM
   using the SGX_IOC_ENCLAVE_MODIFY_TYPE ioctl() introduced here.
2) Approve the page removal by running ENCLU[EACCEPT] from within
   the enclave.
3) Initiate actual page removal using the ioctl() introduced in the
   following patch.

Add ioctl() SGX_IOC_ENCLAVE_MODIFY_TYPE to support changing SGX
enclave page types within an initialized enclave. With
SGX_IOC_ENCLAVE_MODIFY_TYPE the user specifies a page range and the
enclave page type to be applied to all pages in the provided range.
The ioctl() itself can return an error code based on failures
encountered by the kernel. It is also possible for SGX specific
failures to be encountered.  Add a result output parameter to
communicate the SGX return code. It is possible for the enclave page
type change request to fail on any page within the provided range.
Support partial success by returning the number of pages that were
successfully changed.

After the page type is changed the page continues to be accessible
from the kernel perspective with page table entries and internal
state. The page may be moved to swap. Any access until ENCLU[EACCEPT]
will encounter a page fault with SGX flag set in error code.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/include/uapi/asm/sgx.h |  20 +++
 arch/x86/kernel/cpu/sgx/ioctl.c | 212 ++++++++++++++++++++++++++++++++
 2 files changed, 232 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 107ffb0a0b48..003599120edf 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -31,6 +31,8 @@ enum sgx_page_flags {
 	_IO(SGX_MAGIC, 0x04)
 #define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
 	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_perm)
+#define SGX_IOC_ENCLAVE_MODIFY_TYPE \
+	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_modt)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -97,6 +99,24 @@ struct sgx_enclave_restrict_perm {
 	__u64 count;
 };
 
+/**
+ * struct sgx_enclave_modt - parameters for %SGX_IOC_ENCLAVE_MODIFY_TYPE
+ * @offset:	starting page offset (page aligned relative to enclave base
+ *		address defined in SECS)
+ * @length:	length of memory (multiple of the page size)
+ * @secinfo:	address for the SECINFO data containing the new type
+ *		for pages in range described by @offset and @length
+ * @result:	(output) SGX result code of ENCLS[EMODT] function
+ * @count:	(output) bytes successfully changed (multiple of page size)
+ */
+struct sgx_enclave_modt {
+	__u64 offset;
+	__u64 length;
+	__u64 secinfo;
+	__u64 result;
+	__u64 count;
+};
+
 struct sgx_enclave_run;
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 166ec7d79634..2c8cca51c7df 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -966,6 +966,215 @@ static long sgx_ioc_enclave_restrict_perm(struct sgx_encl *encl,
 	return ret;
 }
 
+/**
+ * sgx_enclave_modt() - Modify type of SGX enclave pages
+ * @encl:	Enclave to which the pages belong.
+ * @modt:	Checked parameters from user about which pages need modifying.
+ * @page_type:	New page type.
+ *
+ * Return:
+ * - 0:		Success
+ * - -errno:	Otherwise
+ */
+static long sgx_enclave_modt(struct sgx_encl *encl,
+			     struct sgx_enclave_modt *modt,
+			     enum sgx_page_type page_type)
+{
+	unsigned long max_prot_restore, run_prot_restore;
+	struct sgx_encl_page *entry;
+	struct sgx_secinfo secinfo;
+	unsigned long prot;
+	unsigned long addr;
+	unsigned long c;
+	void *epc_virt;
+	int ret;
+
+	/*
+	 * The only new page types allowed by hardware are PT_TCS and PT_TRIM.
+	 */
+	if (page_type != SGX_PAGE_TYPE_TCS && page_type != SGX_PAGE_TYPE_TRIM)
+		return -EINVAL;
+
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = page_type << 8;
+
+	for (c = 0 ; c < modt->length; c += PAGE_SIZE) {
+		addr = encl->base + modt->offset + c;
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
+		 * Borrow the logic from the Intel SDM. Regular pages
+		 * (SGX_PAGE_TYPE_REG) can change type to SGX_PAGE_TYPE_TCS
+		 * or SGX_PAGE_TYPE_TRIM but TCS pages can only be trimmed.
+		 * CET pages not supported yet.
+		 */
+		if (!(entry->type == SGX_PAGE_TYPE_REG ||
+		      (entry->type == SGX_PAGE_TYPE_TCS &&
+		       page_type == SGX_PAGE_TYPE_TRIM))) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		max_prot_restore = entry->vm_max_prot_bits;
+		run_prot_restore = entry->vm_run_prot_bits;
+
+		/*
+		 * Once a regular page becomes a TCS page it cannot be
+		 * changed back. So the maximum allowed protection reflects
+		 * the TCS page that is always RW from kernel perspective but
+		 * will be inaccessible from within enclave. Before doing
+		 * so, do make sure that the new page type continues to
+		 * respect the originally vetted page permissions.
+		 */
+		if (entry->type == SGX_PAGE_TYPE_REG &&
+		    page_type == SGX_PAGE_TYPE_TCS) {
+			if (~entry->vm_max_prot_bits & (VM_READ | VM_WRITE)) {
+				ret = -EPERM;
+				goto out_unlock;
+			}
+			prot = PROT_READ | PROT_WRITE;
+			entry->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
+			entry->vm_run_prot_bits = entry->vm_max_prot_bits;
+
+			/*
+			 * Prevent page from being reclaimed while mutex
+			 * is released.
+			 */
+			if (sgx_unmark_page_reclaimable(entry->epc_page)) {
+				ret = -EAGAIN;
+				goto out_entry_changed;
+			}
+
+			/*
+			 * Do not keep encl->lock because of dependency on
+			 * mmap_lock acquired in sgx_zap_enclave_ptes().
+			 */
+			mutex_unlock(&encl->lock);
+
+			sgx_zap_enclave_ptes(encl, addr);
+
+			mutex_lock(&encl->lock);
+
+			sgx_mark_page_reclaimable(entry->epc_page);
+		}
+
+		/* Change EPC type */
+		epc_virt = sgx_get_epc_virt_addr(entry->epc_page);
+		ret = __emodt(&secinfo, epc_virt);
+		if (encls_faulted(ret)) {
+			/*
+			 * All possible faults should be avoidable:
+			 * parameters have been checked, will only change
+			 * valid page types, and no concurrent
+			 * SGX1/SGX2 ENCLS instructions since these are
+			 * protected with mutex.
+			 */
+			pr_err_once("EMODT encountered exception %d\n",
+				    ENCLS_TRAPNR(ret));
+			ret = -EFAULT;
+			goto out_entry_changed;
+		}
+		if (encls_failed(ret)) {
+			modt->result = ret;
+			ret = -EFAULT;
+			goto out_entry_changed;
+		}
+
+		ret = sgx_enclave_etrack(encl);
+		if (ret) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+
+		entry->type = page_type;
+
+		mutex_unlock(&encl->lock);
+	}
+
+	ret = 0;
+	goto out;
+
+out_entry_changed:
+	entry->vm_max_prot_bits = max_prot_restore;
+	entry->vm_run_prot_bits = run_prot_restore;
+out_unlock:
+	mutex_unlock(&encl->lock);
+out:
+	modt->count = c;
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_modt() - handler for %SGX_IOC_ENCLAVE_MODIFY_TYPE
+ * @encl:	an enclave pointer
+ * @arg:	userspace pointer to a &struct sgx_enclave_modt instance
+ *
+ * Ability to change the enclave page type supports the following use cases:
+ *
+ * * It is possible to add TCS pages to an enclave by changing the type of
+ *   regular pages (%SGX_PAGE_TYPE_REG) to TCS (%SGX_PAGE_TYPE_TCS) pages.
+ *   With this support the number of threads supported by an initialized
+ *   enclave can be increased dynamically.
+ *
+ * * Regular or TCS pages can dynamically be removed from an initialized
+ *   enclave by changing the page type to %SGX_PAGE_TYPE_TRIM. Changing the
+ *   page type to %SGX_PAGE_TYPE_TRIM marks the page for removal with actual
+ *   removal done by handler of %SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl() called
+ *   after ENCLU[EACCEPT] is run on %SGX_PAGE_TYPE_TRIM page from within the
+ *   enclave.
+ *
+ * Return:
+ * - 0:		Success
+ * - -errno:	Otherwise
+ */
+static long sgx_ioc_enclave_modt(struct sgx_encl *encl, void __user *arg)
+{
+	struct sgx_enclave_modt params;
+	enum sgx_page_type page_type;
+	struct sgx_secinfo secinfo;
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
+	if (copy_from_user(&secinfo, (void __user *)params.secinfo,
+			   sizeof(secinfo)))
+		return -EFAULT;
+
+	if (secinfo.flags & ~SGX_SECINFO_PAGE_TYPE_MASK)
+		return -EINVAL;
+
+	if (memchr_inv(secinfo.reserved, 0, sizeof(secinfo.reserved)))
+		return -EINVAL;
+
+	if (params.result || params.count)
+		return -EINVAL;
+
+	page_type = (secinfo.flags & SGX_SECINFO_PAGE_TYPE_MASK) >> 8;
+	ret = sgx_enclave_modt(encl, &params, page_type);
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
@@ -990,6 +1199,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS:
 		ret = sgx_ioc_enclave_restrict_perm(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_MODIFY_TYPE:
+		ret = sgx_ioc_enclave_modt(encl, (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.35.1

