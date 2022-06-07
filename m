Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AB65403E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbiFGQir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343997AbiFGQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:38:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7768F7E1F4;
        Tue,  7 Jun 2022 09:38:44 -0700 (PDT)
Date:   Tue, 07 Jun 2022 16:38:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654619922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jngsz6dYDWW2zX55YZPRWzvjcIWvdvuKFA7feqYO/0c=;
        b=GjltvIMB6VY/6I7I+8+lBegNmCrxvZXdNYFlxUsbQzDIag/6f+bUggWreW3T/FMVbNUgeG
        qMYs3vSV2L1GYvCo3prJwaAeuAsEYziG+AGLOjK+caAFs6U47yvqbtl1LLmKYUnE27h5pW
        mL2ejSaaFWgVrTs1mORCG9vyeteA9uxKkArftJ3BoOK3v1PDchx/KAjIdzwMTcumxolg38
        iq8jg0BorP/+H2y63gjctwX1mwhN/DBLbIt+AckkgyvrKeh91HkI5/cd2v6WpUy9URuDq1
        5nJD6qOdRPndl+lPXh8t6HnuGj7Yt3McPLyvuvYw/NLYIagkauaINQg201DIHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654619922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jngsz6dYDWW2zX55YZPRWzvjcIWvdvuKFA7feqYO/0c=;
        b=UmcgmJDiZQRRmbrYbrK6npKIRs3D31dwmnZTC7LfVFs3N3jpnGqux9wBv/P4gaK7veZUvj
        hnlRlXGISFYNW/Cw==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/tlb: Avoid reading mm_tlb_gen when possible
Cc:     Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220606180123.2485171-1-namit@vmware.com>
References: <20220606180123.2485171-1-namit@vmware.com>
MIME-Version: 1.0
Message-ID: <165461992091.4207.8723057747625123650.tip-bot2@tip-bot2>
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

Commit-ID:     aa44284960d550eb4d8614afdffebc68a432a9b4
Gitweb:        https://git.kernel.org/tip/aa44284960d550eb4d8614afdffebc68a432a9b4
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Mon, 06 Jun 2022 11:01:23 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 07 Jun 2022 08:48:03 -07:00

x86/mm/tlb: Avoid reading mm_tlb_gen when possible

On extreme TLB shootdown storms, the mm's tlb_gen cacheline is highly
contended and reading it should (arguably) be avoided as much as
possible.

Currently, flush_tlb_func() reads the mm's tlb_gen unconditionally,
even when it is not necessary (e.g., the mm was already switched).
This is wasteful.

Moreover, one of the existing optimizations is to read mm's tlb_gen to
see if there are additional in-flight TLB invalidations and flush the
entire TLB in such a case. However, if the request's tlb_gen was already
flushed, the benefit of checking the mm's tlb_gen is likely to be offset
by the overhead of the check itself.

Running will-it-scale with tlb_flush1_threads show a considerable
benefit on 56-core Skylake (up to +24%):

threads		Baseline (v5.17+)	+Patch
1		159960			160202
5		310808			308378 (-0.7%)
10		479110			490728
15		526771			562528
20		534495			587316
25		547462			628296
30		579616			666313
35		594134			701814
40		612288			732967
45		617517			749727
50		637476			735497
55		614363			778913 (+24%)

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20220606180123.2485171-1-namit@vmware.com
---
 arch/x86/mm/tlb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d400b6d..d9314cc 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -734,10 +734,10 @@ static void flush_tlb_func(void *info)
 	const struct flush_tlb_info *f = info;
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	u64 mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
 	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
 	bool local = smp_processor_id() == f->initiating_cpu;
 	unsigned long nr_invalidate = 0;
+	u64 mm_tlb_gen;
 
 	/* This code cannot presently handle being reentered. */
 	VM_WARN_ON(!irqs_disabled());
@@ -771,6 +771,22 @@ static void flush_tlb_func(void *info)
 		return;
 	}
 
+	if (f->new_tlb_gen <= local_tlb_gen) {
+		/*
+		 * The TLB is already up to date in respect to f->new_tlb_gen.
+		 * While the core might be still behind mm_tlb_gen, checking
+		 * mm_tlb_gen unnecessarily would have negative caching effects
+		 * so avoid it.
+		 */
+		return;
+	}
+
+	/*
+	 * Defer mm_tlb_gen reading as long as possible to avoid cache
+	 * contention.
+	 */
+	mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
+
 	if (unlikely(local_tlb_gen == mm_tlb_gen)) {
 		/*
 		 * There's nothing to do: we're already up to date.  This can
