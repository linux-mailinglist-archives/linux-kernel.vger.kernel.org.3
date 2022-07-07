Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5535656AAA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiGGS2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbiGGS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08CF5C941;
        Thu,  7 Jul 2022 11:27:42 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3dcXxCifgY1BFLWO1CIjq8B835rYyaPw+Wv5g7/fl0=;
        b=nVvES+L5Nvdvprwy279/NF4fzX4ESIwPLmnbBoz6eXkADJ8hn4jN6kAYIQh+mCij5UNIB1
        ct8o6iURpgXfBRJTwT7w97szjYlh653KbMBm85ukgNSGvp2T1jylCOAE73a1OX493jJwTw
        V6Oq1KkatZu7KjW3h0T9QPp3KeN0r41H3VKjKl6RAP03xqnphZIfCyJo/U3Ahs9zEqhB+h
        MSZeWITITmic9q53jCj6fFTl57Btz1LETN20bWuOFm+jFkWNJL0udJFggdk9yzV6y6d8lR
        vWtvaUAWjezmWYRVTTvyvHCLPoY239aOjnmWiAheLuDgS2XEkAM+YMeFSdsjjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3dcXxCifgY1BFLWO1CIjq8B835rYyaPw+Wv5g7/fl0=;
        b=aF2cirCOM9H0+2+1cdPWG+RxJUxoZdb6PQfalInmm4XPV1ssQ+JeS0fZqa28OpwsQ5gcBE
        Dr1+CC41kZrnqhDQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Support complete page removal
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb75ee93e96774e38bb44a24b8e9bbfb67b08b51b=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cb75ee93e96774e38bb44a24b8e9bbfb67b08b51b=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721846050.15455.14920111922219967763.tip-bot2@tip-bot2>
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

Commit-ID:     9849bb27152c18e8531424c0a8ef5f51ece40aea
Gitweb:        https://git.kernel.org/tip/9849bb27152c18e8531424c0a8ef5f51ece40aea
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:55 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:03 -07:00

x86/sgx: Support complete page removal

The SGX2 page removal flow was introduced in previous patch and is
as follows:
1) Change the type of the pages to be removed to SGX_PAGE_TYPE_TRIM
   using the ioctl() SGX_IOC_ENCLAVE_MODIFY_TYPES introduced in
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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Haitao Huang <haitao.huang@intel.com>
Tested-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/b75ee93e96774e38bb44a24b8e9bbfb67b08b51b.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/include/uapi/asm/sgx.h |  21 ++++-
 arch/x86/kernel/cpu/sgx/ioctl.c | 145 +++++++++++++++++++++++++++++++-
 2 files changed, 166 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 567f616..2dd35bb 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -33,6 +33,8 @@ enum sgx_page_flags {
 	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_permissions)
 #define SGX_IOC_ENCLAVE_MODIFY_TYPES \
 	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_modify_types)
+#define SGX_IOC_ENCLAVE_REMOVE_PAGES \
+	_IOWR(SGX_MAGIC, 0x07, struct sgx_enclave_remove_pages)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -117,6 +119,25 @@ struct sgx_enclave_modify_types {
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
+ * enclave if the system supports SGX2. First, the %SGX_IOC_ENCLAVE_MODIFY_TYPES
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
index 9ccafbf..1a2595f 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -1071,6 +1071,148 @@ static long sgx_ioc_enclave_modify_types(struct sgx_encl *encl,
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
+ *    using the %SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl().
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
@@ -1099,6 +1241,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_MODIFY_TYPES:
 		ret = sgx_ioc_enclave_modify_types(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_REMOVE_PAGES:
+		ret = sgx_ioc_enclave_remove_pages(encl, (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
