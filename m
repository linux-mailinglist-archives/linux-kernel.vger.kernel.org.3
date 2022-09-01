Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4565A9EC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiIASRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiIASRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:17:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CDD7A755;
        Thu,  1 Sep 2022 11:17:07 -0700 (PDT)
Date:   Thu, 01 Sep 2022 18:17:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662056225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9GQDEkFf5qaOjyHLJiXUYg9GaIW5Sg6K87UHYjPCYo=;
        b=dU7MnFyPjGmuH8zo3HO4uLOjZpg5QHuPgGQeO+TjYgu/NPvQepxw5SywqtmGHDyIN+SmIT
        G6i2QMV7nCoh4MBgWb4QMQQwD4gsnDdh7LNpHt1yPhbk5/RVvxfNpg6G6QZEruYtIoKsC4
        TpkF5waVFVAH8chrE/WulUjaFdqSsD3weKmVGtyC06MVXMfvWlpJ38tDgb2xjHeiovX473
        k1LWykNKkMUwnVYvUkUGLGvPEB3EwdL9Quv8NIl1YyPydg7BPKZTgYwrVuXxQL5jW5Sbb0
        35Gcc+G5JhZWHcbVLJ+d79ReFzKk5PHyr6zY730X15F9QImGtgtvhQOY/jQyKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662056225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9GQDEkFf5qaOjyHLJiXUYg9GaIW5Sg6K87UHYjPCYo=;
        b=3mF8+8JENQFaB6yxPlV94/J/n7fhTNj5SKVcOnznecH4Fd8Slk6T6bdwuZ9Y7IvdoS2OA/
        mMaCtVHtRs33NzAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Refuse W^X violations
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166205622353.401.14415663682148720649.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     652c5bf380ad018e15006a7f8349800245ddbbad
Gitweb:        https://git.kernel.org/tip/652c5bf380ad018e15006a7f8349800245ddbbad
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 29 Aug 2022 12:18:03 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 01 Sep 2022 11:10:19 -07:00

x86/mm: Refuse W^X violations

x86 has STRICT_*_RWX, but not even a warning when someone violates it.

Add this warning and fully refuse the transition.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net
---
 arch/x86/mm/pat/set_memory.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 6a9043b..1a2d637 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -580,6 +580,33 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
 }
 
 /*
+ * Validate and enforce strict W^X semantics.
+ */
+static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
+				  unsigned long pfn, unsigned long npg)
+{
+	unsigned long end;
+
+	if (!cpu_feature_enabled(X86_FEATURE_NX))
+		return new;
+
+	if (!((pgprot_val(old) ^ pgprot_val(new)) & (_PAGE_RW | _PAGE_NX)))
+		return new;
+
+	if ((pgprot_val(new) & (_PAGE_RW | _PAGE_NX)) != _PAGE_RW)
+		return new;
+
+	end = start + npg * PAGE_SIZE - 1;
+	WARN_ONCE(1, "CPA refuse W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",
+		  (unsigned long long)pgprot_val(old),
+		  (unsigned long long)pgprot_val(new),
+		  start, end, pfn);
+
+	/* refuse the transition into WX */
+	return old;
+}
+
+/*
  * Lookup the page table entry for a virtual address in a specific pgd.
  * Return a pointer to the entry and the level of the mapping.
  */
@@ -885,6 +912,8 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
 				      psize, CPA_DETECT);
 
+	new_prot = verify_rwx(old_prot, new_prot, lpaddr, old_pfn, numpages);
+
 	/*
 	 * If there is a conflict, split the large page.
 	 *
@@ -1525,6 +1554,7 @@ repeat:
 
 	if (level == PG_LEVEL_4K) {
 		pte_t new_pte;
+		pgprot_t old_prot = pte_pgprot(old_pte);
 		pgprot_t new_prot = pte_pgprot(old_pte);
 		unsigned long pfn = pte_pfn(old_pte);
 
@@ -1536,6 +1566,8 @@ repeat:
 		new_prot = static_protections(new_prot, address, pfn, 1, 0,
 					      CPA_PROTECT);
 
+		new_prot = verify_rwx(old_prot, new_prot, address, pfn, 1);
+
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 
 		/*
