Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C325E4CD445
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbiCDMae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiCDMac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:30:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD2A12B75A;
        Fri,  4 Mar 2022 04:29:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 177FEB827B6;
        Fri,  4 Mar 2022 12:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA85C340E9;
        Fri,  4 Mar 2022 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646396980;
        bh=qqaaLUGJk9QbqrbR/Xa7zdtAeGOXMTQYUpqaJRPNkPM=;
        h=From:To:Cc:Subject:Date:From;
        b=RHWCkD94Lq366/su5MpiWzjZUW+v/rwm1kU2OesfZ2epQmPbqFEp4yinxflFT4SaC
         frKFPu5HTAgr7TTt0ySE914gHwnPYXp6VTZ7WnOo2riJoW0oBsFW0x061UQBAjR1vR
         M80cA5wOx3RMcMWc0S0S0kExAJWZAnSPfB+HEGxWo5Ne5Wl967y0bkDzJ/i61+c8dk
         wxC4PpO49h3EVYQKLMU+vL8QNUkoDVA8DZG4tm44K0nRKL1r2EPFTgD7iDJ5XxZIRX
         tWBEF2cqeEKdqhJSu+9umt7wLHvG7N3ZNaQvzExG0BZJHuboDp5oMmJ4AmtJYSxQgO
         55gcsEyMZ1vKQ==
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
Subject: [PATCH RFC] x86: Add SGX_IOC_ENCLAVE_AUGMENT_PAGES
Date:   Fri,  4 Mar 2022 14:28:52 +0200
Message-Id: <20220304122852.563475-1-jarkko@kernel.org>
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

With SGX1 an enclave needs to be created with its maximum memory demands
allocated. Pages cannot be added to an enclave after it is initialized.
SGX2 introduces a new function, ENCLS[EAUG], that can be used to add pages
to an initialized enclave. With SGX2 the enclave still needs to set aside
address space for its maximum memory demands during enclave creation, but
all pages need not be added before enclave initialization. Pages can be
added during enclave runtime.

Add support for dynamically adding pages to an initialized enclave with
SGX_IOC_ENCLAVE_AUGMENT_PAGES, which performs EAUG's to a given range of
pages. Do not enforce any particular permissions from kernel, like is done
for the pages added during the pre-initialization phase, as enclave
controls the final permissions and content for these pages by issuing
either ENCLU[EACCEPT] (empty RW) or ENCLU[EACCEPTCOPY] (arbitrary data and
permissions).

Explicit EAUG ioctl is a better choice than an implicit EAUG from a page
fault handler because it allows to have O(1) number of kernel-enclave round
trips for EAUG-EACCEPT{COPY} process, instead of O(n), as it is in the case
when a page fault handler EAUG single page at a time.

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Nathaniel McCallum <nathaniel@profian.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
Is contained in sgx2-v2.1 branch of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-sgx.git
---
 arch/x86/include/uapi/asm/sgx.h |  14 +++
 arch/x86/kernel/cpu/sgx/ioctl.c | 159 ++++++++++++++++++++++++++++++++
 2 files changed, 173 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index c4e0326d281d..2b3a606e78fe 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -35,6 +35,8 @@ enum sgx_page_flags {
 	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_modt)
 #define SGX_IOC_ENCLAVE_REMOVE_PAGES \
 	_IOWR(SGX_MAGIC, 0x08, struct sgx_enclave_remove_pages)
+#define SGX_IOC_ENCLAVE_AUGMENT_PAGES \
+	_IOWR(SGX_MAGIC, 0x09, struct sgx_enclave_augment_pages)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -138,6 +140,18 @@ struct sgx_enclave_remove_pages {
 	__u64 count;
 };
 
+/**
+ * struct sgx_enclave_augment_pages - parameter structure for the %SGX_IOC_ENCLAVE_ADD_PAGE ioctl
+ * @offset:	starting page offset
+ * @length:	length of the data (multiple of the page size)
+ * @count:	number of bytes added (multiple of the page size)
+ */
+struct sgx_enclave_augment_pages {
+	__u64 offset;
+	__u64 length;
+	__u64 count;
+};
+
 struct sgx_enclave_run;
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 3ad4320ff6ae..1cb410d97ac7 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -1320,6 +1320,162 @@ static long sgx_ioc_enclave_remove_pages(struct sgx_encl *encl,
 	return ret;
 }
 
+/*
+ * Performa EAUG operation for an enclave.
+ */
+static int sgx_encl_augment_page(struct sgx_encl *encl, unsigned long offset)
+{
+	struct sgx_pageinfo pginfo = {0};
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+	struct sgx_va_page *va_page;
+	u64 secinfo_flags;
+	int ret;
+
+	/*
+	 * Ignore internal permission checking for dynamically added pages.
+	 * They matter only for data added during the pre-initialization phase.
+	 * The enclave decides the permissions by the means of EACCEPT,
+	 * EACCEPTCOPY and EMODPE.
+	 */
+	secinfo_flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
+	encl_page = sgx_encl_page_alloc(encl, offset, secinfo_flags);
+	if (IS_ERR(encl_page))
+		return PTR_ERR(encl_page);
+
+	epc_page = sgx_alloc_epc_page(encl_page, true);
+	if (IS_ERR(epc_page)) {
+		ret = PTR_ERR(epc_page);
+		goto err_alloc_epc_page;
+	}
+
+	va_page = sgx_encl_grow(encl);
+	if (IS_ERR(va_page)) {
+		ret = PTR_ERR(va_page);
+		goto err_grow;
+	}
+
+	mutex_lock(&encl->lock);
+
+	/*
+	 * Adding to encl->va_pages must be done under encl->lock.  Ditto for
+	 * deleting (via sgx_encl_shrink()) in the error path.
+	 */
+	if (va_page)
+		list_add(&va_page->list, &encl->va_pages);
+
+	/*
+	 * Insert prior to EADD in case of OOM.  EADD modifies MRENCLAVE, i.e.
+	 * can't be gracefully unwound, while failure on EADD/EXTEND is limited
+	 * to userspace errors (or kernel/hardware bugs).
+	 */
+	ret = xa_insert(&encl->page_array, PFN_DOWN(encl_page->desc),
+			encl_page, GFP_KERNEL);
+
+	/*
+	 * If ret == -EBUSY then page was created in another flow while
+	 * running without encl->lock
+	 */
+	if (ret)
+		goto err_xa_insert;
+
+	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
+	pginfo.addr = encl_page->desc & PAGE_MASK;
+	pginfo.metadata = 0;
+
+	ret = __eaug(&pginfo, sgx_get_epc_virt_addr(epc_page));
+	if (ret)
+		goto err_eaug;
+
+	encl_page->encl = encl;
+	encl_page->epc_page = epc_page;
+	encl_page->type = SGX_PAGE_TYPE_REG;
+	encl->secs_child_cnt++;
+
+	sgx_mark_page_reclaimable(encl_page->epc_page);
+
+	mutex_unlock(&encl->lock);
+
+	return 0;
+
+err_eaug:
+	xa_erase(&encl->page_array, PFN_DOWN(encl_page->desc));
+
+err_xa_insert:
+	sgx_encl_shrink(encl, va_page);
+	mutex_unlock(&encl->lock);
+
+err_grow:
+	sgx_encl_free_epc_page(epc_page);
+
+err_alloc_epc_page:
+	kfree(encl_page);
+
+	return VM_FAULT_SIGBUS;
+}
+
+/**
+ * sgx_ioc_enclave_augment_pages() - The handler for %SGX_IOC_ENCLAVE_AUGMENT_PAGES
+ * @encl:       an enclave pointer
+ * @arg:	a user pointer to a struct sgx_enclave_augment_pages instance
+ *
+ * Request to augment pages to an initialized enclave. The pages must be
+ * acknowledged by the enclave by issuing either ENCLU[EACCEPT] (for a
+ * trivial empty data page) or ENCLU[EACCEPTCOPY] (for a page with arbitrary
+ * permissions and user provided data).
+ *
+ * mmap() protection bits for augmented pages can be arbitrary, i.e. their
+ * permissions are only capped by the VMA, not by EPCM permissions. This is
+ * a constraint because enclave can internally control the final EPCM versions,
+ * for which the kernel has no say.
+ *
+ * Return:
+ * - 0:		Success.
+ * - -EACCES:	The source page is located in a noexec partition.
+ * - -ENOMEM:	Out of EPC pages.
+ * - -EINTR:	The call was interrupted before data was processed.
+ * - -EIO:	EAUG failed.
+ * - -errno:	POSIX error.
+ */
+static long sgx_ioc_enclave_augment_pages(struct sgx_encl *encl, void __user *user_arg)
+{
+	struct sgx_enclave_augment_pages arg;
+	unsigned long c;
+	int ret;
+
+	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
+		return -EINVAL;
+
+	if (copy_from_user(&arg, user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	if (sgx_validate_offset_length(encl, arg.offset, arg.length))
+		return -EINVAL;
+
+	for (c = 0 ; c < arg.length; c += PAGE_SIZE) {
+		if (signal_pending(current)) {
+			if (!c)
+				ret = -ERESTARTSYS;
+
+			break;
+		}
+
+		if (need_resched())
+			cond_resched();
+
+		ret = sgx_encl_augment_page(encl, arg.offset + c);
+		if (ret)
+			break;
+	}
+
+	arg.count = c;
+
+	if (copy_to_user(user_arg, &arg, sizeof(arg)))
+		return -EFAULT;
+
+	return ret;
+}
+
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
 	struct sgx_encl *encl = filep->private_data;
@@ -1350,6 +1506,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_REMOVE_PAGES:
 		ret = sgx_ioc_enclave_remove_pages(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_AUGMENT_PAGES:
+		ret = sgx_ioc_enclave_augment_pages(encl, (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.35.1

