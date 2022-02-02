Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DE54A78D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346942AbiBBTlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:41:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:48444 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbiBBTlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643830878; x=1675366878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H7G+M9z2UW1EGl0N9AVQnxh/5j9NciiuSvnbaYbcXME=;
  b=L5PJKh4ZvwMOvfD1VGIT161kzHYpbqdzR7V1oC7sEP3McM136y/I9otK
   soNcKdht6eEBYXZX0sZaLAiDA8mkX2NNferZw/l/QzsTr88T7NpQ/2XXT
   jBMuwQnUoD6+J1ESjPHm9WQPTYfA6itGImHeP8IPQtrsUiwcgyBHwNXEm
   eamzQFOkFYZk7kYtzevOXL4ZOBVae4QI2kRkBo9VJJLvvkkWQuquJ/cPJ
   exsapFKddeDh0ypDVVd7e8a1aSpMmOjl16B5yvc8znYHH9CWPNuY0o1hV
   lktUuuCjvq1XJdmibAQmgjVvwNfNQVfDRO0SfnMifMPFpkNJmaW+zuDjl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308734863"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="308734863"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 11:41:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="523623678"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 11:41:18 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        jarkko@kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V3] x86/sgx: Add poison handling to reclaimer
Date:   Wed,  2 Feb 2022 11:41:12 -0800
Message-Id: <dcc95eb2aaefb042527ac50d0a50738c7c160dac.1643830353.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SGX reclaimer code lacks page poison handling in its main
free path. This can lead to avoidable machine checks if a
poisoned page is freed and reallocated instead of being
isolated.

A troublesome scenario is:
 1. Machine check (#MC) occurs (asynchronous, !MF_ACTION_REQUIRED)
 2. arch_memory_failure() is eventually called
 3. (SGX) page->poison set to 1
 4. Page is reclaimed
 5. Page added to normal free lists by sgx_reclaim_pages()
    ^ This is the bug (poison pages should be isolated on the
    sgx_poison_page_list instead)
 6. Page is reallocated by some innocent enclave, a second (synchronous)
    in-kernel #MC is induced, probably during EADD instruction.
    ^ This is the fallout from the bug

(6) is unfortunate and can be avoided by replacing the open coded
enclave page freeing code in the reclaimer with sgx_free_epc_page()
to obtain support for poison page handling that includes placing the
poisoned page on the correct list.

Fixes: d6d261bded8a ("x86/sgx: Add new sgx_epc_page flag bit to mark free pages")
Fixes: 992801ae9243 ("x86/sgx: Initial poison handling for dirty and free pages")
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- V2: https://lore.kernel.org/linux-sgx/be5af586f667c7bcb8ef01286ce75675de5d100f.1642630582.git.reinette.chatre@intel.com/
- Add Reviewed-by from Jarkko.
- Remove unused variables.

Changes since V1:
- V1: https://lore.kernel.org/lkml/ef74bd9548df61f77e802e7505affcfb5159c48c.1642545829.git.reinette.chatre@intel.com/
- Complete rewrite of commit message with significant guidance from Dave
  who provided the summary as well as troublesome scenario.

 arch/x86/kernel/cpu/sgx/main.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 4b41efc9e367..8e4bc6453d26 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -344,10 +344,8 @@ static void sgx_reclaim_pages(void)
 {
 	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
 	struct sgx_backing backing[SGX_NR_TO_SCAN];
-	struct sgx_epc_section *section;
 	struct sgx_encl_page *encl_page;
 	struct sgx_epc_page *epc_page;
-	struct sgx_numa_node *node;
 	pgoff_t page_index;
 	int cnt = 0;
 	int ret;
@@ -418,13 +416,7 @@ static void sgx_reclaim_pages(void)
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 
-		section = &sgx_epc_sections[epc_page->section];
-		node = section->node;
-
-		spin_lock(&node->lock);
-		list_add_tail(&epc_page->list, &node->free_page_list);
-		spin_unlock(&node->lock);
-		atomic_long_inc(&sgx_nr_free_pages);
+		sgx_free_epc_page(epc_page);
 	}
 }
 
-- 
2.25.1

