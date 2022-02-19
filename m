Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB124BC7A5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbiBSKVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:21:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiBSKVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:21:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C96E03;
        Sat, 19 Feb 2022 02:21:26 -0800 (PST)
Date:   Sat, 19 Feb 2022 10:21:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645266085;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/M4HfuO2kBlgy3I0P8dJHbFXdlGz++mTmlwiqTIeuww=;
        b=PhxszdITTQszv9rznk+8xjXFrfdxyD1UHl6gJPYCseLKdGc5sW2h4/35QWzvDb4fmFhhqi
        ytw3FYuYJkCgvQBt57toeq0SQ5OpK3609Psm4LzRy5jP4/r6Xb4Un0EbcDNy5jYMSOuPfw
        LncSQ43gpnhNXbs2AaVOfTe9RHwKO46nHnE6nGtVUVbU5OD++/dHO2AVVjaBC/8bGU/xaB
        mWNTW+ulo0IhAaYUMEV5L5gPiQXzJo9F1WFIoOFLrVpMxD5MUZiQwgC7Jxl7nzXodKzT8z
        1cqRRvzeiHc3jr5g9l1HgHKJp8w8VP+3ymZ5CazPHIbH/18LrYX+ERjS4LSpSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645266085;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/M4HfuO2kBlgy3I0P8dJHbFXdlGz++mTmlwiqTIeuww=;
        b=eoO3blLhFk2Btg1xHx+n649dQyCzSfV8Y+0MEtBgL5/9vnPalcf2w5iS4EOecq/xYzFs8X
        /4TUkcC2qR9G+WDQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64: entry: Centralize preemption decision
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214165216.2231574-7-mark.rutland@arm.com>
References: <20220214165216.2231574-7-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164526608445.16921.6244195610918340088.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8e12ab7c0e9f73ebfbcd6d37ece738f1825d58c8
Gitweb:        https://git.kernel.org/tip/8e12ab7c0e9f73ebfbcd6d37ece738f1825d58c8
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 14 Feb 2022 16:52:15 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 19 Feb 2022 11:11:08 +01:00

arm64: entry: Centralize preemption decision

For historical reasons, the decision of whether or not to preempt is
spread across arm64_preempt_schedule_irq() and __el1_irq(), and it would
be clearer if this were all in one place.

Also, arm64_preempt_schedule_irq() calls lockdep_assert_irqs_disabled(),
but this is redundant, as we have a subsequent identical assertion in
__exit_to_kernel_mode(), and preempt_schedule_irq() will
BUG_ON(!irqs_disabled()) anyway.

This patch removes the redundant assertion and centralizes the
preemption decision making within arm64_preempt_schedule_irq().

Other than the slight change to assertion behaviour, there should be no
functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20220214165216.2231574-7-mark.rutland@arm.com
---
 arch/arm64/kernel/entry-common.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index ef7fcef..2c639b6 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -222,7 +222,16 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 
 static void __sched arm64_preempt_schedule_irq(void)
 {
-	lockdep_assert_irqs_disabled();
+	if (!IS_ENABLED(CONFIG_PREEMPTION))
+		return;
+
+	/*
+	 * Note: thread_info::preempt_count includes both thread_info::count
+	 * and thread_info::need_resched, and is not equivalent to
+	 * preempt_count().
+	 */
+	if (READ_ONCE(current_thread_info()->preempt_count) != 0)
+		return;
 
 	/*
 	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
@@ -438,14 +447,7 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	irq_exit_rcu();
 
-	/*
-	 * Note: thread_info::preempt_count includes both thread_info::count
-	 * and thread_info::need_resched, and is not equivalent to
-	 * preempt_count().
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPTION) &&
-	    READ_ONCE(current_thread_info()->preempt_count) == 0)
-		arm64_preempt_schedule_irq();
+	arm64_preempt_schedule_irq();
 
 	exit_to_kernel_mode(regs);
 }
