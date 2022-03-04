Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000644CD151
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiCDJjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239457AbiCDJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE17198D20;
        Fri,  4 Mar 2022 01:37:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27BCC618EF;
        Fri,  4 Mar 2022 09:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DBBC340E9;
        Fri,  4 Mar 2022 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386632;
        bh=I7FI2ZTIaw0TF4ACFpwpzjWGZayC8TeyxjEwqSEMzZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ml6iu6s7KuPP3FPWGAczwp6xWcEVSlLepx17YudPP7+MV+lH78sQqBinD81g3Hwvx
         iz9zkdQ9Ux0TjmRe7dNMIgYIvIuM5grI+wTlQWW9hGGDyovl9dqSnfeqmNrElPnqT+
         G2i/4TP8wIT6K+VZs8P96yKQeTryNSSN7QgWkcRmaQWo9kLBXl4Fkryy7vdm50mODe
         M+KFpFixaEVWiZXQ3EAqddsU7o9c6qoxVdAtiBByRpRTpaXHbWYZYhclBnGu5DDj1o
         AOzgX3x4v+QwSqF1yH3jcL+8w5xZS6Xos9lYgM6TFk0s6NccseLFAsqwv3/mpUrL0x
         8CZC8YFzZ0n0A==
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
Subject: [RFC PATCH v2.1 21/30] x86/sgx: Support complete page removal
Date:   Fri,  4 Mar 2022 11:35:15 +0200
Message-Id: <20220304093524.397485-21-jarkko@kernel.org>
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

The SGX2 page removal flow was introduced in previous patch and is
as follows:
1) Change the type of the pages to be removed to SGX_PAGE_TYPE_TRIM
   using the ioctl() SGX_IOC_ENCLAVE_MODIFY_TYPE introduced in
   previous patch.
2) Approve the page removal by running ENCLU[EACCEPT] from within
   the enclave.
3) Initiate actual page removal using the ioctl()
   SGX_IOC_ENCLAVE_REMOVE_PAGES introduced here.

Support the final step of the SGX2 page removal flow with ioctl()
SGX_IOC_ENCLAVE_REMOVE_PAGES. With this ioctl() the user specifies
a page range that should be removed. All pages in the provided
range should have the SGX_PAGE_TYPE_TRIM page type and the request
will fail with EPERM (Operation not permitted) if a page that does
not have the correct type is encountered. Page removal can fail
on any page within the provided range. Support partial success by
returning the number of pages that were successfully removed.

Since actual page removal will succeed even if ENCLU[EACCEPT] was not
run from within the enclave the ENCLU[EMODPR] instruction with RWX
permissions is used as a no-op mechanism to ensure ENCLU[EACCEPT] was
successfully run from within the enclave before the enclave page is
removed.

If the user omits running SGX_IOC_ENCLAVE_REMOVE_PAGES the pages will
still be removed when the enclave is unloaded.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/include/uapi/asm/sgx.h |  21 +++++
 arch/x86/kernel/cpu/sgx/ioctl.c | 145 ++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 003599120edf..c4e0326d281d 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -33,6 +33,8 @@ enum sgx_page_flags {
 	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_perm)
 #define SGX_IOC_ENCLAVE_MODIFY_TYPE \
 	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_modt)
+#define SGX_IOC_ENCLAVE_REMOVE_PAGES \
+	_IOWR(SGX_MAGIC, 0x08, struct sgx_enclave_remove_pages)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -117,6 +119,25 @@ struct sgx_enclave_modt {
 	__u64 count;
 };
 
+/**
+ * struct sgx_enclave_remove_pages - %SGX_IOC_ENCLAVE_REMOVE_PAGES parameters
+ * @offset:	starting page offset (page aligned relative to enclave base
+ *		address defined in SECS)
+ * @length:	length of memory (multiple of the page size)
+ * @count:	(output) bytes successfully changed (multiple of page size)
+ *
+ * Regular (PT_REG) or TCS (PT_TCS) can be removed from an initialized
+ * enclave if the system supports SGX2. First, the %SGX_IOC_ENCLAVE_MODIFY_TYPE
+ * ioctl() should be used to change the page type to PT_TRIM. After that
+ * succeeds ENCLU[EACCEPT] should be run from within the enclave and then
+ * %SGX_IOC_ENCLAVE_REMOVE_PAGES can be used to complete the page removal.
+ */
+struct sgx_enclave_remove_pages {
+	__u64 offset;
+	__u64 length;
+	__u64 count;
+};
+
 struct sgx_enclave_run;
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 2c8cca51c7df..99cba5837acc 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -1175,6 +1175,148 @@ static long sgx_ioc_enclave_modt(struct sgx_encl *encl, void __user *arg)
 	return ret;
 }
 
+/**
+ * sgx_encl_remove_pages() - Remove trimmed pages from SGX enclave
+ * @encl:	Enclave to which the pages belong
+ * @params:	Checked parameters from user on which pages need to be removed
+ *
+ * Return:
+ * - 0:		Success.
+ * - -errno:	Otherwise.
+ */
+static long sgx_encl_remove_pages(struct sgx_encl *encl,
+				  struct sgx_enclave_remove_pages *params)
+{
+	struct sgx_encl_page *entry;
+	struct sgx_secinfo secinfo;
+	unsigned long addr;
+	unsigned long c;
+	void *epc_virt;
+	int ret;
+
+	memset(&secinfo, 0, sizeof(secinfo));
+	secinfo.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
+
+	for (c = 0 ; c < params->length; c += PAGE_SIZE) {
+		addr = encl->base + params->offset + c;
+
+		mutex_lock(&encl->lock);
+
+		entry = sgx_encl_load_page(encl, addr);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry) == -EBUSY ? -EAGAIN : -EFAULT;
+			goto out_unlock;
+		}
+
+		if (entry->type != SGX_PAGE_TYPE_TRIM) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+
+		/*
+		 * ENCLS[EMODPR] is a no-op instruction used to inform if
+		 * ENCLU[EACCEPT] was run from within the enclave. If
+		 * ENCLS[EMODPR] is run with RWX on a trimmed page that is
+		 * not yet accepted then it will return
+		 * %SGX_PAGE_NOT_MODIFIABLE, after the trimmed page is
+		 * accepted the instruction will encounter a page fault.
+		 */
+		epc_virt = sgx_get_epc_virt_addr(entry->epc_page);
+		ret = __emodpr(&secinfo, epc_virt);
+		if (!encls_faulted(ret) || ENCLS_TRAPNR(ret) != X86_TRAP_PF) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+
+		if (sgx_unmark_page_reclaimable(entry->epc_page)) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
+
+		/*
+		 * Do not keep encl->lock because of dependency on
+		 * mmap_lock acquired in sgx_zap_enclave_ptes().
+		 */
+		mutex_unlock(&encl->lock);
+
+		sgx_zap_enclave_ptes(encl, addr);
+
+		mutex_lock(&encl->lock);
+
+		sgx_encl_free_epc_page(entry->epc_page);
+		encl->secs_child_cnt--;
+		entry->epc_page = NULL;
+		xa_erase(&encl->page_array, PFN_DOWN(entry->desc));
+		sgx_encl_shrink(encl, NULL);
+		kfree(entry);
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
+	params->count = c;
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_remove_pages() - handler for %SGX_IOC_ENCLAVE_REMOVE_PAGES
+ * @encl:	an enclave pointer
+ * @arg:	userspace pointer to &struct sgx_enclave_remove_pages instance
+ *
+ * Final step of the flow removing pages from an initialized enclave. The
+ * complete flow is:
+ *
+ * 1) User changes the type of the pages to be removed to %SGX_PAGE_TYPE_TRIM
+ *    using the %SGX_IOC_ENCLAVE_MODIFY_TYPE ioctl().
+ * 2) User approves the page removal by running ENCLU[EACCEPT] from within
+ *    the enclave.
+ * 3) User initiates actual page removal using the
+ *    %SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl() that is handled here.
+ *
+ * First remove any page table entries pointing to the page and then proceed
+ * with the actual removal of the enclave page and data in support of it.
+ *
+ * VA pages are not affected by this removal. It is thus possible that the
+ * enclave may end up with more VA pages than needed to support all its
+ * pages.
+ *
+ * Return:
+ * - 0:		Success
+ * - -errno:	Otherwise
+ */
+static long sgx_ioc_enclave_remove_pages(struct sgx_encl *encl,
+					 void __user *arg)
+{
+	struct sgx_enclave_remove_pages params;
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
+	if (params.count)
+		return -EINVAL;
+
+	ret = sgx_encl_remove_pages(encl, &params);
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
@@ -1202,6 +1344,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_MODIFY_TYPE:
 		ret = sgx_ioc_enclave_modt(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_REMOVE_PAGES:
+		ret = sgx_ioc_enclave_remove_pages(encl, (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.35.1

