Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB3056AA9D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbiGGS26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbiGGS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729A05C97D;
        Thu,  7 Jul 2022 11:27:48 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IhsDWFv4HXEisZhIiUuH2OLeSt+UlClowROXaoY/va0=;
        b=VwmTQFjN/aXpkTNU+1ZlvEYxHnEo2KIiqKH630s5ZL9+SE8xyz0CQgTPT2YgIhZkQw0/kw
        VrM1ARWwyhX9+xUvRn2QGsgAD4AmRfYWEQjYsg5EeD5soZtbhnXUwWCou8TNMBZmWSCJn1
        bateYtLzdyU3n0mUEi8iHFPEnin0nCmgHddDWvQnYRAqRYT5kjjvXHkkh71jZ/aEiYP2ya
        PzE9N5HJpTWd9eUCWO9MSraQ593cyCcB7iAxa3vQvmALiOt6uR8ZOlbCiuEsAeG0MM+WqJ
        cIDI16CTnpPzkMEvFdIB8StnzW31/CJo3onqXUcSU2Icywuz5J/51ieoYJXpLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218467;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IhsDWFv4HXEisZhIiUuH2OLeSt+UlClowROXaoY/va0=;
        b=j+3EVG/l79CaXzt7hkuD+vJzW0O8Hd30Qwt+pxrm+5vIh2q2cDnTHvKFjAXWVEf+gp3CqW
        MrkH+0BtfZGSt4Dg==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Export sgx_encl_page_alloc()
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C57ae71b4ea17998467670232e12d6617b95c6811=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C57ae71b4ea17998467670232e12d6617b95c6811=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721846599.15455.2087733751699263089.tip-bot2@tip-bot2>
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

Commit-ID:     8123073c4335fcd18ea5e049b85220f122ac1ca3
Gitweb:        https://git.kernel.org/tip/8123073c4335fcd18ea5e049b85220f122ac1ca3
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Tue, 10 May 2022 11:08:49 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:02 -07:00

x86/sgx: Export sgx_encl_page_alloc()

Move sgx_encl_page_alloc() to encl.c and export it so that it can be
used in the implementation for support of adding pages to initialized
enclaves, which requires to allocate new enclave pages.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/57ae71b4ea17998467670232e12d6617b95c6811.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c  | 32 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h  |  3 +++-
 arch/x86/kernel/cpu/sgx/ioctl.c | 32 +--------------------------------
 3 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index c6cac43..5e6a64d 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -887,6 +887,38 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 	return ret;
 }
 
+struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
+					  unsigned long offset,
+					  u64 secinfo_flags)
+{
+	struct sgx_encl_page *encl_page;
+	unsigned long prot;
+
+	encl_page = kzalloc(sizeof(*encl_page), GFP_KERNEL);
+	if (!encl_page)
+		return ERR_PTR(-ENOMEM);
+
+	encl_page->desc = encl->base + offset;
+	encl_page->encl = encl;
+
+	prot = _calc_vm_trans(secinfo_flags, SGX_SECINFO_R, PROT_READ)  |
+	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_W, PROT_WRITE) |
+	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_X, PROT_EXEC);
+
+	/*
+	 * TCS pages must always RW set for CPU access while the SECINFO
+	 * permissions are *always* zero - the CPU ignores the user provided
+	 * values and silently overwrites them with zero permissions.
+	 */
+	if ((secinfo_flags & SGX_SECINFO_PAGE_TYPE_MASK) == SGX_SECINFO_TCS)
+		prot |= PROT_READ | PROT_WRITE;
+
+	/* Calculate maximum of the VM flags for the page. */
+	encl_page->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
+
+	return encl_page;
+}
+
 /**
  * sgx_zap_enclave_ptes() - remove PTEs mapping the address from enclave
  * @encl: the enclave
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index b6b53c0..2cb58ab 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -112,6 +112,9 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 void sgx_encl_put_backing(struct sgx_backing *backing);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
+struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
+					  unsigned long offset,
+					  u64 secinfo_flags);
 void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
 struct sgx_epc_page *sgx_alloc_va_page(void);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 2df27dd..bb8cdb2 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -169,38 +169,6 @@ static long sgx_ioc_enclave_create(struct sgx_encl *encl, void __user *arg)
 	return ret;
 }
 
-static struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
-						 unsigned long offset,
-						 u64 secinfo_flags)
-{
-	struct sgx_encl_page *encl_page;
-	unsigned long prot;
-
-	encl_page = kzalloc(sizeof(*encl_page), GFP_KERNEL);
-	if (!encl_page)
-		return ERR_PTR(-ENOMEM);
-
-	encl_page->desc = encl->base + offset;
-	encl_page->encl = encl;
-
-	prot = _calc_vm_trans(secinfo_flags, SGX_SECINFO_R, PROT_READ)  |
-	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_W, PROT_WRITE) |
-	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_X, PROT_EXEC);
-
-	/*
-	 * TCS pages must always RW set for CPU access while the SECINFO
-	 * permissions are *always* zero - the CPU ignores the user provided
-	 * values and silently overwrites them with zero permissions.
-	 */
-	if ((secinfo_flags & SGX_SECINFO_PAGE_TYPE_MASK) == SGX_SECINFO_TCS)
-		prot |= PROT_READ | PROT_WRITE;
-
-	/* Calculate maximum of the VM flags for the page. */
-	encl_page->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
-
-	return encl_page;
-}
-
 static int sgx_validate_secinfo(struct sgx_secinfo *secinfo)
 {
 	u64 perm = secinfo->flags & SGX_SECINFO_PERMISSION_MASK;
