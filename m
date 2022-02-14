Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45294B576D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356717AbiBNQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:52:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356669AbiBNQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:52:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 318196515D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:52:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3B9C1480;
        Mon, 14 Feb 2022 08:52:40 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 048CA3F70D;
        Mon, 14 Feb 2022 08:52:38 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: [PATCH v4 6/7] arm64: entry: centralize preemption decision
Date:   Mon, 14 Feb 2022 16:52:15 +0000
Message-Id: <20220214165216.2231574-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214165216.2231574-1-mark.rutland@arm.com>
References: <20220214165216.2231574-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/entry-common.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index ef7fcefb96bd..2c639b6b676d 100644
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
-- 
2.30.2

