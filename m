Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EFB56D51B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiGKHDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGKHDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:03:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7338F192A8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:03:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b2so3689585plx.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvcpBMBhsK4WThjIJ06GBib55a72jQWIvp45WwzhM0M=;
        b=nVo8rx6VOOC28p9T/aKSRT17oSfJld+SgNKLaQjWe4lXHAxea0/9ZefGQSJAMHQrp/
         dSHJkpNxq3Bb2zD532BR6aNt22z7Lt0+oSYhud365U9Qz68ryiRKugzYUwJjAxdnX7AT
         Y7u/qvoq/y5cNHc56lg8GUiS/93nph1JCKeBA5SBnbMmj2c9eUxamuf/qdtsHfPpxXvA
         u0Vhkb5LcjuYiKfEF5QIYG1ikfV6pLK0QHlCHwVvmS9DeU19pzTflNUj7T6XykIKuKcD
         SuEA0g98a0qX+9h2G+0bWfU4naTGFPNyp9tmY/uz7qn3YJ6cE3vgvNPrSOOVru0AnhZK
         eZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvcpBMBhsK4WThjIJ06GBib55a72jQWIvp45WwzhM0M=;
        b=BcM50IBlNLENYUB+yaBKNNkCRWepaue4/JzyLWznVOghcGKmdmEFw2KDvVoPUxh6x7
         W8xN4akfALMUWpnL+Hoq23ByR4pnzaG157fzl9xQqd/Ocoa8OEQM0yxYDQXj0jcGrq92
         zfyP+o7nd8LDqzSM9ccXt/3rOxrR6dDrvbKpMpryoEq9ZAJMzfYg/d7bi2FSehZHkhXU
         9yhjhAXkiYMOpsaw/Bw/42TNAEfUl3HXQQp0qeFLmi+yNRgyzVERZywrWAW+8g5YZDoH
         s4fZYhOBXLkoVcg0TcMEAAH9NQUa11fnUWh0wRnyKLVBioeqagRn7as6XolRpH6Gbggm
         6Uyg==
X-Gm-Message-State: AJIora8R3siWix2EPvIYGGTRanfblCL54H21bupaUgBCtK4mrZ4sPLrz
        Y0f59OFVcjIxLDUsFQ13Nz2wpMJCpog=
X-Google-Smtp-Source: AGRyM1tkRMMSGieV9B+4jTa6gBCbgS/VOYk6R3OP4PWsI/ErIO73Qcxhm9Awn7/7FYSemvdlQPOzYw==
X-Received: by 2002:a17:903:22cf:b0:16c:4145:75c5 with SMTP id y15-20020a17090322cf00b0016c414575c5mr5717431plg.127.1657522985449;
        Mon, 11 Jul 2022 00:03:05 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id ge16-20020a17090b0e1000b001efa4a1bb3esm3967305pjb.35.2022.07.11.00.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 00:03:04 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Linux MM <linux-mm@kvack.org>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2] x86/mm/tlb: ignore f->new_tlb_gen when zero
Date:   Sun, 10 Jul 2022 16:28:37 -0700
Message-Id: <20220710232837.3618-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
possible") introduced an optimization of skipping the flush if the TLB
generation that is flushed (as provided in flush_tlb_info) was already
flushed.

However, arch_tlbbatch_flush() does not provide any generation in
flush_tlb_info. As a result, try_to_unmap_one() would not perform any
TLB flushes.

Fix it by checking whether f->new_tlb_gen is nonzero. Zero value is
anyhow is an invalid generation value. To avoid future confusions,
introduce TLB_GENERATION_INVALID constant and use it properly. Add some
assertions to check no partial flushes are done with
TLB_GENERATION_INVALID or when f->mm is NULL, since this does not make
any sense.

In addition, add the missing unlikely().

Fixes: aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when possible")
Reported-by: Hugh Dickins <hughd@google.com>
Tested-by: Hugh Dickins <hughd@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>

---

v1 -> v2:
* Introduce TLB_GENERATION_INVALID to clarify intent.
* Leave the early return and do not "goto out".
* Add some assertions to check and document in code the relationship
  between TLB_GENERATION_INVALID and TLB_FLUSH_ALL.
---
 arch/x86/include/asm/tlbflush.h |  1 +
 arch/x86/mm/tlb.c               | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 4af5579c7ef7..cda3118f3b27 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -16,6 +16,7 @@
 void __flush_tlb_all(void);
 
 #define TLB_FLUSH_ALL	-1UL
+#define TLB_GENERATION_INVALID	0
 
 void cr4_update_irqsoff(unsigned long set, unsigned long clear);
 unsigned long cr4_read_shadow(void);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d9314cc8b81f..0f346c51dd99 100644
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
+		VM_BUG_ON(f->new_tlb_gen == TLB_GENERATION_INVALID);
+
+		/* Partial flush must have valid mm */
+		VM_BUG_ON(f->mm == NULL);
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
-- 
2.25.1

