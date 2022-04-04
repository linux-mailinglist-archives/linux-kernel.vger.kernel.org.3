Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF184F1BC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381249AbiDDVWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379272AbiDDQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60A83206F;
        Mon,  4 Apr 2022 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090996; x=1680626996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmcZSIlJkv/9k53+32pFDDB02AXmc/mojSxyVAU4Ycg=;
  b=QckznjSltzWUfdN+fbzweFp+rod5jfHHsQjZiBGhh5ufm5icc0nKKupz
   ix63v2nmCgs7GO+d1PURJkwKbeiX3mQ/NCd3PRBVXP+6hS31uM8qRe8T1
   n7p9fj0BZmqn2D0NTduIG9ZoJ/VMysPkP+paEVDUbjHVLZ+NKxH4SRH7m
   PwS5v81Jvbr4o7h9QE7e8Rvs1Bj85eNXoWQGLwEVgklU/4KUEw17b+VTi
   UFp/4Zknog6Bc/kl+dKCStM2VzIvfQoD4rS/PVNeMCvlpqTu8ZcPZOHXR
   C9p4JoEW8laUqnpFXADY85MUaAsCTSX/dVA7p+sb3GDcD1arBBbsT0sYH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323734049"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="323734049"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105186"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:50 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 13/30] x86/sgx: Export sgx_encl_page_alloc()
Date:   Mon,  4 Apr 2022 09:49:21 -0700
Message-Id: <794f92c110f79c94b6aa969d9ddc7a73a4c5b67b.1648847675.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648847675.git.reinette.chatre@intel.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

Move sgx_encl_page_alloc() to encl.c and export it so that it can be
used in the implementation for support of adding pages to initialized
enclaves, which requires to allocate new enclave pages.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- New patch
  Originally submitted at:
  https://lore.kernel.org/linux-sgx/20220308112833.262805-3-jarkko@kernel.org/

 arch/x86/kernel/cpu/sgx/encl.c  | 32 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/encl.h  |  3 +++
 arch/x86/kernel/cpu/sgx/ioctl.c | 32 --------------------------------
 3 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index c77a62432862..546423753e4c 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -792,6 +792,38 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
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
index 9d673d9531f0..253ebdd1c5be 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -112,6 +112,9 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
+struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
+					  unsigned long offset,
+					  u64 secinfo_flags);
 void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
 struct sgx_epc_page *sgx_alloc_va_page(void);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 746acddbb774..0460fd224a05 100644
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
-- 
2.25.1

