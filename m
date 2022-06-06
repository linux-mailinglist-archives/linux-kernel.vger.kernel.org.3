Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7FF53ED6D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiFFSBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiFFSBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:01:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945A732EE7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:01:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b135so13281702pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPBJs4v6yE5fyDh1qHWy5uLB8kDJdqQyxmymwKvUdt0=;
        b=jNk7ZCkSuJzITY/sKx6O+as8Gy7wuG3vteylYs/dBQ5i0LafIKQDpQvPw9wIz+sWdz
         /ocZkfDOqZLPx4Brt+3oRiS99DbWuKQJMDAbQTb633eEQQt+G+XdUjpsVXmEstyN87N8
         d7GSFxqNM+UhA+tp5eYpUPY0irbirA0ABKcqyoYb+klKjDCzHFNN2iWosZ9EXPpmxwRk
         HxrnXpHPOHy4NkNrs2bkL7PJ7aNcbcpIjyNvMu2LlxcS+YjpzELMtRsKRkyksQX6om/7
         rBX2Hh9Q71JC7uYA/vDAXejQ7pMrki8PfWasWliYUBj8jnLs9H6MwPRTEoYv1+kVzKtb
         Iu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPBJs4v6yE5fyDh1qHWy5uLB8kDJdqQyxmymwKvUdt0=;
        b=GQaMVtZ3vTdTrL/3OuK0cMy++TQUkFNxbRhogh16ZLk0dKv0RaKjbP40KSCHMTSAmf
         JTlbUfaUI9CF3vEwPwOQFCrGg2oso4U8yeV9fNg3MEDzVrIpwE6Kb29RRRpgAAnZy9ts
         /Xv75WQxubTmc/GGdNDgGnhUP4SgldpkXa+KZDWSPQ+e5AUAAc6ArkDN2+Lzh7AnsJoL
         a0r8T/XpmMaj17lc+GXB/sKZzq4z4MrgMg+yaHAbvBGewyHrBNx9rIsmOxOFi8DFxxwY
         Z0kCjoEElQcp6FKvI02ifAYlF+nSzK55Xm0bEJ/y3ujJe0kcMudGibE5mJH5NLbD7tal
         NweQ==
X-Gm-Message-State: AOAM532QVK6CeD06dI0OfeaUk/+2hBhX5FLpQseiFKCnjo4zvcNBtOq9
        loiUDW8FNvlX6lAew9rlL04=
X-Google-Smtp-Source: ABdhPJxU6JdtgxZQ+E0Ja4sc5RzGGjaYutAxLgIScpxRIciTT8jgU/r/ba01+qv22HFIIjMRTJ92hQ==
X-Received: by 2002:a63:8048:0:b0:3fc:8c4e:29ae with SMTP id j69-20020a638048000000b003fc8c4e29aemr21940445pgd.295.1654538478779;
        Mon, 06 Jun 2022 11:01:18 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id x19-20020aa79413000000b0051be7a8c008sm6640531pfo.30.2022.06.06.11.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 11:01:18 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH v2] x86/mm/tlb: avoid reading mm_tlb_gen when possible
Date:   Mon,  6 Jun 2022 11:01:23 -0700
Message-Id: <20220606180123.2485171-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

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

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>

--

Note: The benchmarked kernels include Dave's revert of commit
6035152d8eeb ("x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
tlb_is_not_lazy()
---
 arch/x86/mm/tlb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d400b6d9d246..d9314cc8b81f 100644
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
-- 
2.25.1

