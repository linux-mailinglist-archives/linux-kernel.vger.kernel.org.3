Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA74057A40E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiGSQRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiGSQRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:17:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8D349B6B;
        Tue, 19 Jul 2022 09:17:04 -0700 (PDT)
Date:   Tue, 19 Jul 2022 16:17:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658247422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rnOinfjefyG7040ci+QjKu8n+QSf1S9hG2ztD7d8UA=;
        b=aAhQSfDwq5/iaVqf0x0NEqRYIUwYk61StVOoJdfA2c6VOlXgujhmtcshelSkeU3C1AjORv
        WNMxGxynuHUP2GcCA/t24leelqQVk5RpIpv+UodMdACQQQGaIWxa+sOQ482K823xXnfwD7
        9sM1+1D1tdV6FLur8qOA7WfAtT6nHz9tAufD+h1748MTOlib5OlcS5/2jVXXw6yY2+pI9T
        Os3rlXKv5pyLX2aTn0znmh7qCySmeA+hIDlUOkTaspH3nrLLivL6t0jwBwGqAno1Gl/A2E
        mp5FVPPuFvw0jD1Fgjx61/+C4KFVRPI/0hE6MqvuWLNy2xZF2m4GJP1n5iGAKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658247422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rnOinfjefyG7040ci+QjKu8n+QSf1S9hG2ztD7d8UA=;
        b=oiw3HHu+MYSh4C/4nHtvZNZ1Pd+QPpkpuXOE6js9n1gCl2Z0wSX4qyE5w7VyR0cF6qJKSB
        I0y4/wWRMGDmlLCw==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/tlb: Ignore f->new_tlb_gen when zero
Cc:     Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220710232837.3618-1-namit@vmware.com>
References: <20220710232837.3618-1-namit@vmware.com>
MIME-Version: 1.0
Message-ID: <165824742138.15455.11110929785444044294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     8f1d56f64f8d6b80dea2d1978d10071132a695c5
Gitweb:        https://git.kernel.org/tip/8f1d56f64f8d6b80dea2d1978d10071132a695c5
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Sun, 10 Jul 2022 16:28:37 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 19 Jul 2022 09:04:52 -07:00

x86/mm/tlb: Ignore f->new_tlb_gen when zero

Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
possible") introduced an optimization to skip superfluous TLB
flushes based on the generation provided in flush_tlb_info.

However, arch_tlbbatch_flush() does not provide any generation in
flush_tlb_info and populates the flush_tlb_info generation with
0.  This 0 is causes the flush_tlb_info to be interpreted as a
superfluous, old flush.  As a result, try_to_unmap_one() would
not perform any TLB flushes.

Fix it by checking whether f->new_tlb_gen is nonzero. Zero value
is anyhow is an invalid generation value. To avoid future
confusion, introduce TLB_GENERATION_INVALID constant and use it
properly. Add warnings to ensure no partial flushes are done with
TLB_GENERATION_INVALID or when f->mm is NULL, since this does not
make any sense.

In addition, add the missing unlikely().

[ dhansen: change VM_BUG_ON() -> VM_WARN_ON(), clarify changelog ]

Fixes: aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when possible")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Hugh Dickins <hughd@google.com>
Link: https://lkml.kernel.org/r/20220710232837.3618-1-namit@vmware.com
---
 arch/x86/include/asm/tlbflush.h |  1 +
 arch/x86/mm/tlb.c               | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 98fa0a1..21bf105 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -16,6 +16,7 @@
 void __flush_tlb_all(void);
 
 #define TLB_FLUSH_ALL	-1UL
+#define TLB_GENERATION_INVALID	0
 
 void cr4_update_irqsoff(unsigned long set, unsigned long clear);
 unsigned long cr4_read_shadow(void);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d9314cc..c1e31e9 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -771,7 +771,8 @@ static void flush_tlb_func(void *info)
 		return;
 	}
 
-	if (f->new_tlb_gen <= local_tlb_gen) {
+	if (unlikely(f->new_tlb_gen != TLB_GENERATION_INVALID &&
+		     f->new_tlb_gen <= local_tlb_gen)) {
 		/*
 		 * The TLB is already up to date in respect to f->new_tlb_gen.
 		 * While the core might be still behind mm_tlb_gen, checking
@@ -843,6 +844,12 @@ static void flush_tlb_func(void *info)
 		/* Partial flush */
 		unsigned long addr = f->start;
 
+		/* Partial flush cannot have invalid generations */
+		VM_WARN_ON(f->new_tlb_gen == TLB_GENERATION_INVALID);
+
+		/* Partial flush must have valid mm */
+		VM_WARN_ON(f->mm == NULL);
+
 		nr_invalidate = (f->end - f->start) >> f->stride_shift;
 
 		while (addr < f->end) {
@@ -1045,7 +1052,8 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		struct flush_tlb_info *info;
 
 		preempt_disable();
-		info = get_flush_tlb_info(NULL, start, end, 0, false, 0);
+		info = get_flush_tlb_info(NULL, start, end, 0, false,
+					  TLB_GENERATION_INVALID);
 
 		on_each_cpu(do_kernel_range_flush, info, 1);
 
@@ -1214,7 +1222,8 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 
 	int cpu = get_cpu();
 
-	info = get_flush_tlb_info(NULL, 0, TLB_FLUSH_ALL, 0, false, 0);
+	info = get_flush_tlb_info(NULL, 0, TLB_FLUSH_ALL, 0, false,
+				  TLB_GENERATION_INVALID);
 	/*
 	 * flush_tlb_multi() is not optimized for the common case in which only
 	 * a local TLB flush is needed. Optimize this use-case by calling
