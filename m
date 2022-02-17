Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3024BA81A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbiBQSXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:23:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbiBQSXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:23:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A538220196;
        Thu, 17 Feb 2022 10:23:02 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:22:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645122181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQfR/4Bh3Na8ZE2qdjeZClIZpmTHDnvnT8L0QQMwGfg=;
        b=AOZz+GNDbSJLpHnoP5mVaNbFNgVNidgsGep+JcXXWBcBzvhi9HQBXYmp1KyWry5z5RUYDx
        tOzuKvGL86bu9b0Y1gT5CnzDattNQI4YTTGvcfhOHQBT682mhlu1TTHpxnMz2KrZJNk1i9
        6lXhXuw1r00nO68SI8szSarklUkpUEPHJUPPYbWbpctLXA17RE0sNRO3q2U5/hv9AuzIp4
        fE6617uahQ3x3a3aAqZGRyaQgSX5TCnNaVaSq8P1Jb3bZhgYqNylMxsU+4GDkyBDyj6QpC
        Egln65X3RF7p+VnS7/Jb3J+36+4yfVt3S8MGKs24mLpSE8JDoG6WazNEOAD+lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645122181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQfR/4Bh3Na8ZE2qdjeZClIZpmTHDnvnT8L0QQMwGfg=;
        b=YraBV9jHzeqPwWyEVejDv2H6MT9QO/tLW8wrNxMXuSQrS/hFQpOAoknZYxmucsa2jPt5Cy
        muHisMgVx1eLlFCg==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sgx: Add poison handling to reclaimer
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cdcc95eb2aaefb042527ac50d0a50738c7c160dac=2E16438?=
 =?utf-8?q?30353=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cdcc95eb2aaefb042527ac50d0a50738c7c160dac=2E164383?=
 =?utf-8?q?0353=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <164512217993.16921.1720244213113719560.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f4b2a4606a14ab0b697a4e21754c9ad19d39f8ca
Gitweb:        https://git.kernel.org/tip/f4b2a4606a14ab0b697a4e21754c9ad19d39f8ca
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Wed, 02 Feb 2022 11:41:12 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Feb 2022 09:12:04 -08:00

x86/sgx: Add poison handling to reclaimer

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/dcc95eb2aaefb042527ac50d0a50738c7c160dac.1643830353.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/main.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 4b41efc..8e4bc64 100644
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
@@ -418,13 +416,7 @@ skip:
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
 
