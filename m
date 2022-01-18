Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6B2493128
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350197AbiARXFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:05:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:38063 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbiARXFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642547111; x=1674083111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1w4bZ0hPrYjlH7HlLA4QZibwGcCLLenIDeZW6JHzjiU=;
  b=kdguhiubRjJfdeOSNZZ1YvOqP2jH0iAlejmV3z3jd+kYajUx+soqA1/o
   gyZlUKXVjU2yRBFf2LZaX8rXk3s0U640xlY8foQCLlTib29PJpgiyB8pn
   uwtQHkJubx36kysU9TLeuLLFCW/KZcDWbMzFLCaJzELiJLSRoojE7j1Ao
   TseFobwnIAyz2Paq9Q00o9FdPNdkf+V10D9dF7c+S1EZ2MhNMRgO3CxAJ
   NMhZFkTjM5j9p1tKg4wUXdQ8ktxhEnvIAn51gt3JxW27c0nkWDHVOWiRB
   NCdKxRMrX0RWYNejr2yc76PIuq9u6wXjQIcB0sURgV2WwKjKSNcp5fR6B
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="244891021"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="244891021"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 15:05:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="492825297"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 15:05:10 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        jarkko@kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/sgx: Add poison handling to reclaimer
Date:   Tue, 18 Jan 2022 15:05:03 -0800
Message-Id: <ef74bd9548df61f77e802e7505affcfb5159c48c.1642545829.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The machine check recovery handling in SGX added the changes
listed below to the freeing of pages in sgx_free_epc_page().
The SGX reclaimer contains an open coded version of
sgx_free_epc_page() and thus did not obtain the changes in
support of poison handling.

The changes made to EPC page freeing in support of poison handling
are:
1) A new SGX_EPC_PAGE_IS_FREE flag is set when the EPC page is
   freed. Introduced in commit d6d261bded8a ("x86/sgx: Add new
   sgx_epc_page flag bit to mark free pages").
2) A new "poison" field in struct sgx_epc_page is used to
   determine whether a newly freed EPC page should be placed
   on the list of poisoned or list of free pages. Introduced
   in commit 992801ae9243 ("x86/sgx: Initial poison handling
   for dirty and free pages").
3) The owner field in struct sgx_epc_page is cleared when the EPC
   page is freed.  Introduced in commit 992801ae9243 ("x86/sgx:
   Initial poison handling for dirty and free pages").

Replace the open coded enclave page freeing code in the reclaimer
with sgx_free_epc_page() to obtain support for poison page handling.

Fixes: d6d261bded8a ("x86/sgx: Add new sgx_epc_page flag bit to mark free pages")
Fixes: 992801ae9243 ("x86/sgx: Initial poison handling for dirty and free pages")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
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

