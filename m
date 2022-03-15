Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6D4D91E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbiCOBEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344096AbiCOBDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:03:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160B84550D;
        Mon, 14 Mar 2022 18:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647306159; x=1678842159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=eo8eRy18WOMEfF6XezKel2X6wCXcvho3sORMilAr+Pw=;
  b=LlQYTQA5XiwKvmHTVxUydm3jys6WY598wD13zFSge2CZwSqanq+2mzaQ
   ai664m+FJ08qUte5ebHRnpZdhWaMS53EkN9qIool/ggZg7baznkt05fcU
   /Po+8+obj53MnE4N9JuCo9Lmz86EPxKs0OH3x+XZUpuXBmAmAvwBQAo+c
   pY0x4m4f6Czh55eqBpUyhbjPyFI/1Umv6Fu9dUpkVXUZysTsIpo7J3LYY
   SeEUInGPhLMdPUmkwIMOCL0ZOGagO7Bw5VdzAobrXGwPdj/X05d+4D0qt
   TRiUkD6VxNTVUhaUEiYIRf4G6D4pqoHg/kgjlmytyTDkbaf92UFBNqBd9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255912352"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="255912352"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515669316"
Received: from cathy-vostro-3670.bj.intel.com ([10.238.156.128])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 18:02:37 -0700
From:   Cathy Zhang <cathy.zhang@intel.com>
To:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, ashok.raj@intel.com, cathy.zhang@intel.com
Subject: [RFC PATCH v2 03/10] x86/sgx: Save enclave pointer for VA page
Date:   Tue, 15 Mar 2022 09:02:53 +0800
Message-Id: <20220315010300.10199-4-cathy.zhang@intel.com>
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

Tearing down all enclaves is required by SGX SVN update, which
involves running the ENCLS[EREMOVE] instruction on every EPC
page. This (tearing down all enclaves) should be coordinated
with any enclaves that may be in the process of existing and thus
already be running ENCLS[EREMOVE] as part of enclave release.

In support of this coordination, it is required to know which enclave
owns each in-use EPC page. It is already possible to locate the
owning enclave of SECS and regular pages but not for VA pages.

Save the enclave pointer for each VA page to support locating its
owning enclave.

Note: to track 2T EPC memory, this scheme of tracking will use
additional 8M memory.

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.h  | 1 +
 arch/x86/kernel/cpu/sgx/ioctl.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 1807a7f55065..e6f14c45ad49 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -77,6 +77,7 @@ struct sgx_va_page {
 	struct sgx_epc_page *epc_page;
 	DECLARE_BITMAP(slots, SGX_VA_SLOT_COUNT);
 	struct list_head list;
+	struct sgx_encl *encl;
 };
 
 struct sgx_backing {
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 9eb429aeb319..0f7b3e24fb94 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -30,6 +30,7 @@ struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 		if (!va_page)
 			return ERR_PTR(-ENOMEM);
 
+		va_page->encl = encl;
 		va_page->epc_page = sgx_alloc_va_page(va_page);
 		if (IS_ERR(va_page->epc_page)) {
 			err = ERR_CAST(va_page->epc_page);
-- 
2.17.1

