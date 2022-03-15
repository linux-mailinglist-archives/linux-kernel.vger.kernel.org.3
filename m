Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822524D91EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243515AbiCOBEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbiCOBDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:03:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258444743;
        Mon, 14 Mar 2022 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647306164; x=1678842164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TRsu0k6qJfQAJscm5EyiR33+jFQ2ZrQG7ziBnk9opcE=;
  b=F7KzZrNZ3RjJbp8L2+PGsahzy23B88GLlq+Rv2RhgYUy0JSkmRk8AWgq
   tUitKM21pIowbEcxxIXuRaCvhrfwFQ1E2H0U1HDoP7JXjE1vxpjSdIh0N
   Y9fkUZFbzP88ai/Q1Cs0GFuThtFAyRyEK2Xxi/qLNTWLLir2vmsrsANdk
   Ij7FHtWzWzhmQzYkWIsMrxxG5fOfibCmnPKtXRWzTDJvgu1f36DewdHal
   YAMt5QFajAXKMgP3zUU2sxLTgzL9wMAFH3XFMffzlb/b0kGs8v11iiPps
   8KQZ0GYM88PVLti3eEQHuOPkxIdi9cZ5pGz10AqJrxRxReXidWpCGjlXN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255912362"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="255912362"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:02:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515669336"
Received: from cathy-vostro-3670.bj.intel.com ([10.238.156.128])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 18:02:40 -0700
From:   Cathy Zhang <cathy.zhang@intel.com>
To:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, ashok.raj@intel.com, cathy.zhang@intel.com
Subject: [RFC PATCH v2 05/10] x86/sgx: Save the size of each EPC section
Date:   Tue, 15 Mar 2022 09:02:55 +0800
Message-Id: <20220315010300.10199-6-cathy.zhang@intel.com>
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

For SGX CPUSVN update process will check all EPC pages in each
section to ensure they will be marked as unused, it requires to
know the size of each EPC section to end the loop.

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
---
 arch/x86/kernel/cpu/sgx/sgx.h  | 1 +
 arch/x86/kernel/cpu/sgx/main.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 1dd06899a64c..8fa0f9c64a13 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -63,6 +63,7 @@ struct sgx_epc_section {
 	void *virt_addr;
 	struct sgx_epc_page *pages;
 	struct sgx_numa_node *node;
+	u64 size;
 };
 
 extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 99c86b77ca8f..c9331f6ba034 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -636,6 +636,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	}
 
 	section->phys_addr = phys_addr;
+	section->size = size;
 	xa_store_range(&sgx_epc_address_space, section->phys_addr,
 		       phys_addr + size - 1, section, GFP_KERNEL);
 
-- 
2.17.1

