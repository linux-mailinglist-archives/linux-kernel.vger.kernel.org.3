Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A54942F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiASWYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:24:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:56951 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbiASWYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642631051; x=1674167051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0pJyoyJAvBdSpCycsxUaxiIERBuyoVK8GZ/qVyHt7Hc=;
  b=TK5ygU+dWRNVxhHWm6/pC86MugZ81+D9wBJ1YqvC/IvjuTrviaEeT1xV
   7yxj5DzZ1qCMRcmILetNG3eUOQVs/LGUX92bshcAhgu0bu35SoOJja1kw
   tMuFcBMKb0/6IOBg7Uxq42VshtLUB1padEGT2uoAxre8umNvFAtU55yhk
   X80DZCHB5N1lmiNzsSrGAMZcS+jDd+x0ddTI/wyepmUUFEqJ7hCwHWFiG
   f34H0YcoAOU6detGzkA+8icuIgXENazLB3vxMzd/IoQpKEnh/TLoGSruA
   yQEsUPCHNlArrH3gu2eQfcYETeQqg6VZPVp4JMmBzJp0ExAFTaRdhcc+g
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="331561464"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="331561464"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 14:24:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="561218570"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 14:24:04 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        jarkko@kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2] x86/sgx: Add poison handling to reclaimer
Date:   Wed, 19 Jan 2022 14:23:50 -0800
Message-Id: <be5af586f667c7bcb8ef01286ce75675de5d100f.1642630582.git.reinette.chatre@intel.com>
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
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- V1: https://lore.kernel.org/lkml/ef74bd9548df61f77e802e7505affcfb5159c48c.1642545829.git.reinette.chatre@intel.com/
- Complete rewrite of commit message with significant guidance from Dave
  who provided the summary as well as troublesome scenario.

 arch/x86/kernel/cpu/sgx/main.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 4b41efc9e367..997a5d0bc488 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -418,13 +418,7 @@ static void sgx_reclaim_pages(void)
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

