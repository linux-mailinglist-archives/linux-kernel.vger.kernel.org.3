Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A1A56AAAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbiGGS22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiGGS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB455A2DF;
        Thu,  7 Jul 2022 11:27:43 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bV04GNrvkuGyt/exN8NcHWFATSNGDW/uBfbikyLiAJg=;
        b=374FcPKrAIU0JF+r4AXJ7XMSF4f/leJErhYAvQt437egsNHGJ+z8El87qhbSK1MnxYBYAN
        CSjbIdb/ykMdfzZiB55k2HUHDvYtimMpcO0rZ6tjp6omsCc5BJj3RncTdIVqM7rB2GuwsI
        fqJCDRB6FrxhxXhwg7KkzF0scatMd7GrvvjxkYzucr0whHs16+2B7Zl+1HqsLT0lZ1qHIM
        akRlmiiljcHL03MwizIivmV33W6B+AECgCsDrdIrQxqOxmKpIFtRPKZElifZkaKaRYLEmQ
        ClHpPOerdRDyNX3xS627FAnJH2nOxiXH5qf+UQVvCN/PAf9ET5ArlavMIwBX5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bV04GNrvkuGyt/exN8NcHWFATSNGDW/uBfbikyLiAJg=;
        b=PVOpqABZ9/lQYWqyZDAU0J2IX8AS4CkfLUQ6RbBBm6bMld0e4USQ2Xz9isi6ZB1E5T20zV
        IFabPOs5aL/dd2Bw==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Support modifying SGX page type
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cbabe39318c5bf16fc65fbfb38896cdee72161575=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cbabe39318c5bf16fc65fbfb38896cdee72161575=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721846142.15455.17370948607282303118.tip-bot2@tip-bot2>
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

Commit-ID:     45d546b8c109d69f6659d58b2ace005b2f07f557
Gitweb:        https://git.kernel.org/tip/45d546b8c109d69f6659d58b2ace005b2f07f557
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:54 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:03 -07:00

x86/sgx: Support modifying SGX page type

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
   using the SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl() introduced here.
2) Approve the page removal by running ENCLU[EACCEPT] from within
   the enclave.
3) Initiate actual page removal using the ioctl() introduced in the
   following patch.

Add ioctl() SGX_IOC_ENCLAVE_MODIFY_TYPES to support changing SGX
enclave page types within an initialized enclave. With
SGX_IOC_ENCLAVE_MODIFY_TYPES the user specifies a page range and the
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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Haitao Huang <haitao.huang@intel.com>
Tested-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
Link: https://lkml.kernel.org/r/babe39318c5bf16fc65fbfb38896cdee72161575.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/include/uapi/asm/sgx.h |  20 +++-
 arch/x86/kernel/cpu/sgx/ioctl.c | 202 +++++++++++++++++++++++++++++++-
 2 files changed, 222 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 82648c0..567f616 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -31,6 +31,8 @@ enum sgx_page_flags {
 	_IO(SGX_MAGIC, 0x04)
 #define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
 	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_permissions)
+#define SGX_IOC_ENCLAVE_MODIFY_TYPES \
+	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_modify_types)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -97,6 +99,24 @@ struct sgx_enclave_restrict_permissions {
 	__u64 count;
 };
 
+/**
+ * struct sgx_enclave_modify_types - parameters for ioctl
+ *                                   %SGX_IOC_ENCLAVE_MODIFY_TYPES
+ * @offset:	starting page offset (page aligned relative to enclave base
+ *		address defined in SECS)
+ * @length:	length of memory (multiple of the page size)
+ * @page_type:	new type for pages in range described by @offset and @length
+ * @result:	(output) SGX result code of ENCLS[EMODT] function
+ * @count:	(output) bytes successfully changed (multiple of page size)
+ */
+struct sgx_enclave_modify_types {
+	__u64 offset;
+	__u64 length;
+	__u64 page_type;
+	__u64 result;
+	__u64 count;
+};
+
 struct sgx_enclave_run;
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 720188d..9ccafbf 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -872,6 +872,205 @@ static long sgx_ioc_enclave_restrict_permissions(struct sgx_encl *encl,
 	return ret;
 }
 
+/**
+ * sgx_enclave_modify_types() - Modify type of SGX enclave pages
+ * @encl:	Enclave to which the pages belong.
+ * @modt:	Checked parameters from user about which pages need modifying
+ *              and their new page type.
+ *
+ * Return:
+ * - 0:		Success
+ * - -errno:	Otherwise
+ */
+static long sgx_enclave_modify_types(struct sgx_encl *encl,
+				     struct sgx_enclave_modify_types *modt)
+{
+	unsigned long max_prot_restore;
+	enum sgx_page_type page_type;
+	struct sgx_encl_page *entry;
+	struct sgx_secinfo secinfo;
+	unsigned long prot;
+	unsigned long addr;
+	unsigned long c;
+	void *epc_virt;
+	int ret;
+
+	page_type = modt->page_type & SGX_PAGE_TYPE_MASK;
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
+out_unlock:
+	mutex_unlock(&encl->lock);
+out:
+	modt->count = c;
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_modify_types() - handler for %SGX_IOC_ENCLAVE_MODIFY_TYPES
+ * @encl:	an enclave pointer
+ * @arg:	userspace pointer to a &struct sgx_enclave_modify_types instance
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
+static long sgx_ioc_enclave_modify_types(struct sgx_encl *encl,
+					 void __user *arg)
+{
+	struct sgx_enclave_modify_types params;
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
+	if (params.page_type & ~SGX_PAGE_TYPE_MASK)
+		return -EINVAL;
+
+	if (params.result || params.count)
+		return -EINVAL;
+
+	ret = sgx_enclave_modify_types(encl, &params);
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
@@ -897,6 +1096,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		ret = sgx_ioc_enclave_restrict_permissions(encl,
 							   (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_MODIFY_TYPES:
+		ret = sgx_ioc_enclave_modify_types(encl, (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
