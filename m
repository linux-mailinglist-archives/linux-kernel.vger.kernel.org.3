Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940D24D00E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiCGORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiCGORB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:17:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4526C71CBF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:16:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE4FF612C3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA35C340E9;
        Mon,  7 Mar 2022 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646662566;
        bh=e56qHnE/crraAFadekrO9GdXE8m+dDcJ1YGP+JayrC4=;
        h=From:To:Cc:Subject:Date:From;
        b=GLHpAPatZyjvshLTeZBOdovrLRsU0vP6W/fVBeJvZigGpzCIcS8sxMCU0ZbleGBpg
         4Ew2NmlQJfO2pA1SX+uOZPAFPbat/bbAhGBKNiC0/uQ0pgPOHr4LJ4sfQY3GF3wW7w
         d9tlhg8sYy7immPFqvZrS2O91zJrydGx1p2earByys2ehO1xghgHBMmlj14mQ7lpX3
         eUujHGZTImI+5Ak7G/PIordXEDAT7OIk+j3JJ4ywb2j13GBQ1X41w0Fn7E3mMjfuvc
         okpQ6t3fiNNNdmFphdhOxRCmyzGIVuAcLd/o+Ft4TpefzLccDZN9NLNrdI2hrfq2zQ
         9AgOWBnPz9cDw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: add irq stack support
Date:   Mon,  7 Mar 2022 22:08:04 +0800
Message-Id: <20220307140804.1400-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, IRQs are still handled on the kernel stack of the current
task on riscv platforms. If the task has a deep call stack at the time
of interrupt, and handling the interrupt also requires a deep stack,
it's possible to see stack overflow.

Before this patch, the stack_max_size of a v5.17-rc1 kernel running on
a lichee RV board gave:
~ # cat /sys/kernel/debug/tracing/stack_max_size
3736

After this patch,
~ # cat /sys/kernel/debug/tracing/stack_max_size
3176

We reduce the max kernel stack usage by 560 bytes!

From another side, after this patch, it's possible to reduce the
THREAD_SIZE to 8KB for RV64 platforms. This is especially useful for
those systems with small memory size, e.g the Allwinner D1S platform
which is RV64 but only has 64MB DDR.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
since v1:
 - add __ro_after_init to the irq_stack[] array.

 arch/riscv/include/asm/thread_info.h |  1 +
 arch/riscv/kernel/asm-offsets.c      |  2 ++
 arch/riscv/kernel/entry.S            | 33 +++++++++++++++++++++++++---
 arch/riscv/kernel/irq.c              | 16 ++++++++++++++
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 60da0dcacf14..67387a8bcb34 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -19,6 +19,7 @@
 #endif
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
+#define IRQ_STACK_SIZE		THREAD_SIZE
 /*
  * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
  * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index df0519a64eaf..9619398a69e1 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -36,6 +36,8 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
+	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
+	OFFSET(TASK_STACK, task_struct, stack);
 
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index ed29e9c8f660..57c9b64e16a5 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -126,12 +126,39 @@ skip_context_tracking:
 	 */
 	bge s4, zero, 1f
 
-	la ra, ret_from_exception
+	/* preserve the sp */
+	move s0, sp
 
-	/* Handle interrupts */
 	move a0, sp /* pt_regs */
+
+	/*
+	 * Compare sp with the base of the task stack.
+	 * If the top ~(THREAD_SIZE - 1) bits match, we are on a task stack,
+	 * and should switch to the irq stack.
+	 */
+	REG_L t0, TASK_STACK(tp)
+	xor t0, t0, s0
+	li t1, ~(THREAD_SIZE - 1)
+	and t0, t0, t1
+	bnez t0, 2f
+
+	la t1, irq_stack
+	REG_L t2, TASK_TI_CPU(tp)
+	slli t2, t2, RISCV_LGPTR
+	add t1, t1, t2
+	REG_L t2, 0(t1)
+	li t1, IRQ_STACK_SIZE
+	/* switch to the irq stack */
+	add sp, t2, t1
+
+2:
+	/* Handle interrupts */
 	la a1, generic_handle_arch_irq
-	jr a1
+	jalr a1
+
+	/* Restore sp */
+	move sp, s0
+	j ret_from_exception
 1:
 	/*
 	 * Exceptions run with interrupts enabled or disabled depending on the
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7207fa08d78f..f20cbfd42e82 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -10,6 +10,8 @@
 #include <linux/seq_file.h>
 #include <asm/smp.h>
 
+void *irq_stack[NR_CPUS] __ro_after_init;
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	show_ipi_stats(p, prec);
@@ -18,7 +20,21 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 void __init init_IRQ(void)
 {
+	int cpu;
+
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
+
+	for_each_possible_cpu(cpu) {
+#ifdef CONFIG_VMAP_STACK
+		void *s = __vmalloc_node(IRQ_STACK_SIZE, THREAD_ALIGN,
+					 THREADINFO_GFP, cpu_to_node(cpu),
+					 __builtin_return_address(0));
+#else
+		void *s = (void *)__get_free_pages(GFP_KERNEL, get_order(IRQ_STACK_SIZE));
+#endif
+
+		irq_stack[cpu] = s;
+	}
 }
-- 
2.34.1

