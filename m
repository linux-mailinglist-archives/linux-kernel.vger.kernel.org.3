Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2BE4E48EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiCVWIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiCVWI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:08:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66E26EC47
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:07:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so3379344pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TS8XvKx0EZ+UdGgKfRTSvykFRznwfr9/dGZbbHvXVw0=;
        b=mtuu0RzF3lauiZrZqawvwWZz8A8VnM1vUePZI7Tr8GzaNaKAP/Sk6EbDNyfkLULSnY
         nP+DljGfVz28nycvwHIbzK4AK7O/RLZLWno2KutjbN7vx4mqS2C/nzbykr4Ti44Zfjwj
         G0eMtuuMyQB1Ug6MN5vLpgKB5AkFkdDCvXZsQZkB8vU4ZkklY1sXsIA4eMyUquB++kTx
         jMmJS7jcyuRig8XwbXdhArBRd0mRSY0bkdTJ3WL6ghpSvBXo3NDlTpwDSO2x9jjcgkJr
         ggtonMmS1eJIdOZIVeuogAeHXutY+APocQvCYOS6/weyQzKKWrKhIkju/IPweaGu3Wbk
         n9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TS8XvKx0EZ+UdGgKfRTSvykFRznwfr9/dGZbbHvXVw0=;
        b=nA2tHy6Dc2GAZLUMLm677jNUb7dEcs4pJhWc3nmEEpdSC2hlO18JlFa/+MPNE3jPeY
         UePIUTdrTgTd9n492KtHsyPe7vAKts4mY2pGUGbfhYyu3Qva0+bZ6CnG9wMeJyGjzBJV
         h4/knrUj3cKeeCIJg5QGpTL0Ax81I7JOzCJ/h6J/1NPTaSPQl7sB33fyTiyxQ2zkEECc
         EzMtrgV2B+s823oWVEtAdrgSkIdawNbn7o0vxE5o6oHFFucjfFx3pPGYzJ2H2izRFA8U
         gVaGPbJFK2i+RW+nQwGifiQ13A6jkXif5qrujvS6jkK8w17uVs+UHZAFagZpJ2/sRcJ1
         KpTQ==
X-Gm-Message-State: AOAM530kE/uVWObbCP5C8HPQ8cKBAlhlPbRrZdE0zz+GUbcmcech94Rl
        9uCUV04614PZwfpSLJ9t2ig=
X-Google-Smtp-Source: ABdhPJxlP5xvqbQppkypvIpFVSVm8mBF87tCW9ygzymuyrOyBndCa3uk289bGEe7lus9Vodj/sMlvA==
X-Received: by 2002:a17:902:c286:b0:154:25ae:d6c7 with SMTP id i6-20020a170902c28600b0015425aed6c7mr20289308pld.44.1647986820161;
        Tue, 22 Mar 2022 15:07:00 -0700 (PDT)
Received: from sc2-hs2-b1628.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id my18-20020a17090b4c9200b001c75aeac7fdsm3456400pjb.27.2022.03.22.15.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 15:06:59 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH] x86/mm/tlb: avoid reading mm_tlb_gen when possible
Date:   Tue, 22 Mar 2022 22:07:57 +0000
Message-Id: <20220322220757.8607-1-namit@vmware.com>
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

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
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
index 300b11e45792..6d7c69526051 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -733,10 +733,10 @@ static void flush_tlb_func(void *info)
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
@@ -770,6 +770,22 @@ static void flush_tlb_func(void *info)
 		return;
 	}
 
+	if (f->new_tlb_gen <= local_tlb_gen) {
+		/*
+		 * We are already up to date in respect to f->new_tlb_gen.
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

