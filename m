Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE694D91EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbiCOBEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbiCOBDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:03:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F13344751;
        Mon, 14 Mar 2022 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647306161; x=1678842161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bG75tiB7pTL3Zxa5XwwH6wgiRtXblx45pRj+5lOZYEo=;
  b=OSUUo+UsP55FjZ87fAkLYkgXebCRzSUigz7f1j9xxTzX08KdvofZUe3q
   4RkkTPc/t5JlUNQyIKDRG6xVbL4O/KIBN/K6Agsh5aCCIb7on2jkAakVN
   bfoakGQnx4MSVZF+UfOd6/b5yh22wZU04jTh/W/LjO+9h8v0ajiLfJL/5
   3qry+JPXyvTN+Q/PSUJ1XLC8ps6N6Ra0oQGha1vUypqs9f2Phm7Exrln1
   J/75HZ/LijzbVmF6soTn9CysoWbU041FtsGhZpNmHUGdBJJO51dFYyspj
   Bu2nF9oGl3XZk2xIKC64fN8/d+y7BRiViciN3pMPGkytXcxrVDSBZgrvq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255912354"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="255912354"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:02:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515669327"
Received: from cathy-vostro-3670.bj.intel.com ([10.238.156.128])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 18:02:39 -0700
From:   Cathy Zhang <cathy.zhang@intel.com>
To:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, ashok.raj@intel.com, cathy.zhang@intel.com
Subject: [RFC PATCH v2 04/10] x86/sgx: Keep record for SGX VA and Guest page type
Date:   Tue, 15 Mar 2022 09:02:54 +0800
Message-Id: <20220315010300.10199-5-cathy.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220315010300.10199-1-cathy.zhang@intel.com>
References: <20220315010300.10199-1-cathy.zhang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regular enclave EPC pages have sgx_encl_page as their owner, but
SGX VA page and KVM guest EPC page are maintained by different
owner structures.

SGX CPUSVN update requires to know the EPC page owner's status
and then decide how to handle the page.

Keep a record of page type for SGX VA and KVM guest page while
the other EPC pages already have their type tracked, so that
CPUSVN update can get EPC page's owner by type and handle it then.

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
---
 arch/x86/kernel/cpu/sgx/sgx.h  | 4 ++++
 arch/x86/kernel/cpu/sgx/encl.c | 2 ++
 arch/x86/kernel/cpu/sgx/virt.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index e627c42a6eec..1dd06899a64c 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -28,6 +28,10 @@
 
 /* Pages on free list */
 #define SGX_EPC_PAGE_IS_FREE		BIT(1)
+/* VA page */
+#define SGX_EPC_PAGE_VA			BIT(2)
+/* Pages allocated for KVM guest */
+#define SGX_EPC_PAGE_GUEST		BIT(3)
 
 struct sgx_epc_page {
 	unsigned int section;
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index e08c59a049d3..a78428aa4465 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -1014,6 +1014,8 @@ struct sgx_epc_page *sgx_alloc_va_page(struct sgx_va_page *va_page)
 		return ERR_PTR(-EFAULT);
 	}
 
+	epc_page->flags |= SGX_EPC_PAGE_VA;
+
 	return epc_page;
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index e953816d7c8b..acdf72769a39 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -50,6 +50,8 @@ static int __sgx_vepc_fault(struct sgx_vepc *vepc,
 	if (IS_ERR(epc_page))
 		return PTR_ERR(epc_page);
 
+	epc_page->flags |= SGX_EPC_PAGE_GUEST;
+
 	ret = xa_err(xa_store(&vepc->page_array, index, epc_page, GFP_KERNEL));
 	if (ret)
 		goto err_free;
-- 
2.17.1

