Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D77D56AACA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiGGS2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiGGS16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990DB5C94B;
        Thu,  7 Jul 2022 11:27:46 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218465;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y42WLvrDTa3V+6E32q2qT4GNXU0F85IRJ8GofwcRIOM=;
        b=E8F/gMJwTji486s3NXCEh99AXOBx+HX/hKC1wArhAx18CBgDqXtpVR82JnhGKHn6XVf/Hi
        6sMz5gwshB/XHsmtaoRXLVS0nLbM+bUZOR1rYAx2s5QwjZDM8qWDpimr3v88gTm3gq6QgY
        Mlbcp8F3bErY10Uq8pephxYaabzi4p3jHr6ywiDtNz/6SAygRmuA9Ep8JRjaUOmGz4H0EE
        4Ru/PLKvoXSUXvaEjm+0yQt4nGYp3bg2sz6rp3CjsYk5IWx039W+j8L7C6losfpk77wRbC
        UzzPwgkeEXMhG40RHpt4jQhKWcEKfsCTAkhO9jkYF9YVLsEmZ/jRRP7K9vcbag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218465;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y42WLvrDTa3V+6E32q2qT4GNXU0F85IRJ8GofwcRIOM=;
        b=QwOV70Phv+/YbyusZZ71Z+yFZFtf6kozPIX4DsuygLlinyCuLndhNKkPbxCtOnPtZ23sAl
        Km1aw3sD2siwC8Ag==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Support restricting of enclave page permissions
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C082cee986f3c1a2f4fdbf49501d7a8c5a98446f8=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C082cee986f3c1a2f4fdbf49501d7a8c5a98446f8=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721846417.15455.4074908162801839460.tip-bot2@tip-bot2>
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

Commit-ID:     ff08530a5232aab3b610db44cdc5045d26421911
Gitweb:        https://git.kernel.org/tip/ff08530a5232aab3b610db44cdc5045d26421911
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:51 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:03 -07:00

x86/sgx: Support restricting of enclave page permissions

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
a page range and the EPCM permissions to be applied to all pages in
the provided range. ENCLS[EMODPR] is run to restrict the EPCM
permissions followed by the ENCLS[ETRACK] flow that will ensure
no cached linear-to-physical address mappings to the changed
pages remain.

It is possible for the permission change request to fail on any
page within the provided range, either with an error encountered
by the kernel or by the SGX hardware while running
ENCLS[EMODPR]. To support partial success the ioctl() returns an
error code based on failures encountered by the kernel as well
as two result output parameters: one for the number of pages
that were successfully changed and one for the SGX return code.

The page table entry permissions are not impacted by the EPCM
permission changes. VMAs and PTEs will continue to allow the
maximum vetted permissions determined at the time the pages
are added to the enclave. The SGX error code in a page fault
will indicate if it was an EPCM permission check that prevented
an access attempt.

No checking is done to ensure that the permissions are actually
being restricted. This is because the enclave may have relaxed
the EPCM permissions from within the enclave without the kernel
knowing. An attempt to relax permissions using this call will
be ignored by the hardware.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Haitao Huang <haitao.huang@intel.com>
Tested-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
Link: https://lkml.kernel.org/r/082cee986f3c1a2f4fdbf49501d7a8c5a98446f8.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/include/uapi/asm/sgx.h |  21 +++-
 arch/x86/kernel/cpu/sgx/ioctl.c | 216 +++++++++++++++++++++++++++++++-
 2 files changed, 237 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index f4b8158..82648c0 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -29,6 +29,8 @@ enum sgx_page_flags {
 	_IOW(SGX_MAGIC, 0x03, struct sgx_enclave_provision)
 #define SGX_IOC_VEPC_REMOVE_ALL \
 	_IO(SGX_MAGIC, 0x04)
+#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
+	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_permissions)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -76,6 +78,25 @@ struct sgx_enclave_provision {
 	__u64 fd;
 };
 
+/**
+ * struct sgx_enclave_restrict_permissions - parameters for ioctl
+ *                                        %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
+ * @offset:	starting page offset (page aligned relative to enclave base
+ *		address defined in SECS)
+ * @length:	length of memory (multiple of the page size)
+ * @permissions:new permission bits for pages in range described by @offset
+ *              and @length
+ * @result:	(output) SGX result code of ENCLS[EMODPR] function
+ * @count:	(output) bytes successfully changed (multiple of page size)
+ */
+struct sgx_enclave_restrict_permissions {
+	__u64 offset;
+	__u64 length;
+	__u64 permissions;
+	__u64 result;
+	__u64 count;
+};
+
 struct sgx_enclave_run;
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 5d41aa2..720188d 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -660,6 +660,218 @@ static long sgx_ioc_enclave_provision(struct sgx_encl *encl, void __user *arg)
 	return sgx_set_attribute(&encl->attributes_mask, params.fd);
 }
 
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
+ * Some SGX functions require that no cached linear-to-physical address
+ * mappings are present before they can succeed. Collaborate with
+ * hardware via ENCLS[ETRACK] to ensure that all cached
+ * linear-to-physical address mappings belonging to all threads of
+ * the enclave are cleared. See sgx_encl_cpumask() for details.
+ *
+ * Must be called with enclave's mutex held from the time the
+ * SGX function requiring that no cached linear-to-physical mappings
+ * are present is executed until this ETRACK flow is complete.
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
+ * sgx_enclave_restrict_permissions() - Restrict EPCM permissions
+ * @encl:	Enclave to which the pages belong.
+ * @modp:	Checked parameters from user on which pages need modifying and
+ *              their new permissions.
+ *
+ * Return:
+ * - 0:		Success.
+ * - -errno:	Otherwise.
+ */
+static long
+sgx_enclave_restrict_permissions(struct sgx_encl *encl,
+				 struct sgx_enclave_restrict_permissions *modp)
+{
+	struct sgx_encl_page *entry;
+	struct sgx_secinfo secinfo;
+	unsigned long addr;
+	unsigned long c;
+	void *epc_virt;
+	int ret;
+
+	memset(&secinfo, 0, sizeof(secinfo));
+	secinfo.flags = modp->permissions & SGX_SECINFO_PERMISSION_MASK;
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
+		 * Apart from ensuring that read-access remains, do not verify
+		 * the permission bits requested. Kernel has no control over
+		 * how EPCM permissions can be relaxed from within the enclave.
+		 * ENCLS[EMODPR] can only remove existing EPCM permissions,
+		 * attempting to set new permissions will be ignored by the
+		 * hardware.
+		 */
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
+			goto out_unlock;
+		}
+		if (encls_failed(ret)) {
+			modp->result = ret;
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+
+		ret = sgx_enclave_etrack(encl);
+		if (ret) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+
+		mutex_unlock(&encl->lock);
+	}
+
+	ret = 0;
+	goto out;
+
+out_unlock:
+	mutex_unlock(&encl->lock);
+out:
+	modp->count = c;
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_restrict_permissions() - handler for
+ *                                        %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
+ * @encl:	an enclave pointer
+ * @arg:	userspace pointer to a &struct sgx_enclave_restrict_permissions
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
+ * Return:
+ * - 0:		Success
+ * - -errno:	Otherwise
+ */
+static long sgx_ioc_enclave_restrict_permissions(struct sgx_encl *encl,
+						 void __user *arg)
+{
+	struct sgx_enclave_restrict_permissions params;
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
+	if (params.permissions & ~SGX_SECINFO_PERMISSION_MASK)
+		return -EINVAL;
+
+	/*
+	 * Fail early if invalid permissions requested to prevent ENCLS[EMODPR]
+	 * from faulting later when the CPU does the same check.
+	 */
+	if ((params.permissions & SGX_SECINFO_W) &&
+	    !(params.permissions & SGX_SECINFO_R))
+		return -EINVAL;
+
+	if (params.result || params.count)
+		return -EINVAL;
+
+	ret = sgx_enclave_restrict_permissions(encl, &params);
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
@@ -681,6 +893,10 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_PROVISION:
 		ret = sgx_ioc_enclave_provision(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS:
+		ret = sgx_ioc_enclave_restrict_permissions(encl,
+							   (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
