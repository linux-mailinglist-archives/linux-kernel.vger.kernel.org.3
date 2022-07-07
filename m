Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2144556AAB4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbiGGS2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbiGGS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C525C970;
        Thu,  7 Jul 2022 11:27:47 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218466;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMAtwtsQOdAc/7LFaxrYI7QMgUN2qq4ImKJaCNxHzqU=;
        b=PaN0hHpRvH/h60PDaoo7DdCF5mPvb5c3k7qWhkEhlnVf0CcDUjJ2GNXnQgvUv+R0yPL8Dl
        yjlQatyuUlFlW4Hu/1Lsck2lUJIRe2Tl1oXG0vQukSs5TGM8ZSLkbE+YsxGjAnOuN/5ow4
        VZRGX2tIGvnYXxZq0rBMdgIyrXfh7CpTp5nFXIJhKl3YQE25+Y3zPodUWniGkRwJOPJKJu
        CaGZC+MRACpce5zGQg5QSLJImvNJY+FoT62SKMmzTaqs6vuUPAS/MqTViwY2iSKGMOGOxO
        b/fh4yEjbQy1j4yWXacj6/Q5vip3McJ1PPFG9TgflywMTxSBlJftklQnTwl0hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218466;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMAtwtsQOdAc/7LFaxrYI7QMgUN2qq4ImKJaCNxHzqU=;
        b=mhM7MRHE4LwIADVFSBClUwWbjupIFoxEB5c8vRg722o3V+nYZ746jb8/1+XB4nKLWJeDQI
        58+vTcgVoHyOy1Ag==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Support VA page allocation without reclaiming
Cc:     Haitao Huang <haitao.huang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C42c5934c229982ee67982bb97c6ab34bde758620=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C42c5934c229982ee67982bb97c6ab34bde758620=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721846507.15455.12610890636000750990.tip-bot2@tip-bot2>
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

Commit-ID:     a76e7f1f18884a94998ca82862c0a4e6d0fd2933
Gitweb:        https://git.kernel.org/tip/a76e7f1f18884a94998ca82862c0a4e6d0fd2933
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:50 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:02 -07:00

x86/sgx: Support VA page allocation without reclaiming

struct sgx_encl should be protected with the mutex
sgx_encl->lock. One exception is sgx_encl->page_cnt that
is incremented (in sgx_encl_grow()) when an enclave page
is added to the enclave. The reason the mutex is not held
is to allow the reclaimer to be called directly if there are
no EPC pages (in support of a new VA page) available at the time.

Incrementing sgx_encl->page_cnt without sgc_encl->lock held
is currently (before SGX2) safe from concurrent updates because
all paths in which sgx_encl_grow() is called occur before
enclave initialization and are protected with an atomic
operation on SGX_ENCL_IOCTL.

SGX2 includes support for dynamically adding pages after
enclave initialization where the protection of SGX_ENCL_IOCTL
is not available.

Make direct reclaim of EPC pages optional when new VA pages
are added to the enclave. Essentially the existing "reclaim"
flag used when regular EPC pages are added to an enclave
becomes available to the caller when used to allocate VA pages
instead of always being "true".

When adding pages without invoking the reclaimer it is possible
to do so with sgx_encl->lock held, gaining its protection against
concurrent updates to sgx_encl->page_cnt after enclave
initialization.

No functional change.

Reported-by: Haitao Huang <haitao.huang@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/42c5934c229982ee67982bb97c6ab34bde758620.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c  | 6 ++++--
 arch/x86/kernel/cpu/sgx/encl.h  | 4 ++--
 arch/x86/kernel/cpu/sgx/ioctl.c | 8 ++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 5e6a64d..ea81e59 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -964,6 +964,8 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
 
 /**
  * sgx_alloc_va_page() - Allocate a Version Array (VA) page
+ * @reclaim: Reclaim EPC pages directly if none available. Enclave
+ *           mutex should not be held if this is set.
  *
  * Allocate a free EPC page and convert it to a Version Array (VA) page.
  *
@@ -971,12 +973,12 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
  *   a VA page,
  *   -errno otherwise
  */
-struct sgx_epc_page *sgx_alloc_va_page(void)
+struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
 {
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(NULL, true);
+	epc_page = sgx_alloc_epc_page(NULL, reclaim);
 	if (IS_ERR(epc_page))
 		return ERR_CAST(epc_page);
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 2cb58ab..3d0e0ba 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -116,14 +116,14 @@ struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
 					  unsigned long offset,
 					  u64 secinfo_flags);
 void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
-struct sgx_epc_page *sgx_alloc_va_page(void);
+struct sgx_epc_page *sgx_alloc_va_page(bool reclaim);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
 void sgx_encl_free_epc_page(struct sgx_epc_page *page);
 struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 					 unsigned long addr);
-struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim);
 void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
 
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index bb8cdb2..5d41aa2 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -17,7 +17,7 @@
 #include "encl.h"
 #include "encls.h"
 
-struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim)
 {
 	struct sgx_va_page *va_page = NULL;
 	void *err;
@@ -30,7 +30,7 @@ struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 		if (!va_page)
 			return ERR_PTR(-ENOMEM);
 
-		va_page->epc_page = sgx_alloc_va_page();
+		va_page->epc_page = sgx_alloc_va_page(reclaim);
 		if (IS_ERR(va_page->epc_page)) {
 			err = ERR_CAST(va_page->epc_page);
 			kfree(va_page);
@@ -64,7 +64,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	struct file *backing;
 	long ret;
 
-	va_page = sgx_encl_grow(encl);
+	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
 	else if (va_page)
@@ -275,7 +275,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 		return PTR_ERR(epc_page);
 	}
 
-	va_page = sgx_encl_grow(encl);
+	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page)) {
 		ret = PTR_ERR(va_page);
 		goto err_out_free;
