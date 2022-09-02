Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE45AB51E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiIBP2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiIBP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:28:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A8501C6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:01:46 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxReLRGhJjx_4PAA--.3305S2;
        Fri, 02 Sep 2022 23:01:38 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Jinyang He <hejinyang@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Mark kernel stack padding as TOP_OF_KERNEL_STACK_PADDING
Date:   Fri,  2 Sep 2022 23:01:37 +0800
Message-Id: <1662130897-13156-1-git-send-email-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxReLRGhJjx_4PAA--.3305S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF17Wry7tr1xtw18Xw45trb_yoWrtw4kpF
        9rAwn7GF4UGFnYyryUtrn8uFyDJwn7Kw12gayaya4rAFnFvr1rXryxAFyDZFyUta95Kw40
        gFyfKwsIyan8Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
        6r4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5WwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjku4UUUUUU==
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the top reserved bytes of the kernel stack by a macro. It collects
that info so that we can modify or discarded (let it be 0) this padding
if needed. Its name is referenced from x86_64. It seems that x86_64
think the padding as extension on top of the kernel stack in other mode
(normally the top is only pt_regs). Although LoongArch not produce
such an extension at present, collect them because of the uncertainty
of the future. Note that this patch does not modify macro size. It
requires another strict evaluation.

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/loongarch/include/asm/processor.h  | 3 ++-
 arch/loongarch/include/asm/ptrace.h     | 3 ++-
 arch/loongarch/include/asm/stackframe.h | 1 +
 arch/loongarch/kernel/head.S            | 2 +-
 arch/loongarch/kernel/process.c         | 4 ++--
 arch/loongarch/kernel/switch.S          | 2 +-
 6 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
index 1c4b43083..6077fd8e3 100644
--- a/arch/loongarch/include/asm/processor.h
+++ b/arch/loongarch/include/asm/processor.h
@@ -193,8 +193,9 @@ static inline void flush_thread(void)
 
 unsigned long __get_wchan(struct task_struct *p);
 
+#define TOP_OF_KERNEL_STACK_PADDING 32
 #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
-			 THREAD_SIZE - 32 - sizeof(struct pt_regs))
+			 THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING - sizeof(struct pt_regs))
 #define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk))
 #define KSTK_EIP(tsk) (task_pt_regs(tsk)->csr_era)
 #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[3])
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index 17838c6b7..cdceeaa60 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -133,7 +133,8 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs)
 #define current_pt_regs()						\
 ({									\
 	unsigned long sp = (unsigned long)__builtin_frame_address(0);	\
-	(struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 - 32) - 1;	\
+	(struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 -		\
+			   TOP_OF_KERNEL_STACK_PADDING) - 1;		\
 })
 
 /* Helpers for working with the user stack pointer */
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 4ca953062..e9f849b29 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -216,4 +216,5 @@
 	RESTORE_SP_AND_RET \docfi
 	.endm
 
+#define _TOP_OF_KERNEL_STACK_PADDING 32
 #endif /* _ASM_STACKFRAME_H */
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index eb3f641d5..290c53847 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -75,7 +75,7 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 
 	la.pcrel	tp, init_thread_union
 	/* Set the SP after an empty pt_regs.  */
-	PTR_LI		sp, (_THREAD_SIZE - 32 - PT_SIZE)
+	PTR_LI		sp, (_THREAD_SIZE - _TOP_OF_KERNEL_STACK_PADDING - PT_SIZE)
 	PTR_ADD		sp, sp, tp
 	set_saved_sp	sp, t0, t1
 	PTR_ADDI	sp, sp, -4 * SZREG	# init stack pointer
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 660492f06..b51cf7975 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -129,7 +129,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	unsigned long clone_flags = args->flags;
 	struct pt_regs *childregs, *regs = current_pt_regs();
 
-	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
+	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
 
 	/* set up new TSS. */
 	childregs = (struct pt_regs *) childksp - 1;
@@ -236,7 +236,7 @@ bool in_task_stack(unsigned long stack, struct task_struct *task,
 			struct stack_info *info)
 {
 	unsigned long begin = (unsigned long)task_stack_page(task);
-	unsigned long end = begin + THREAD_SIZE - 32;
+	unsigned long end = begin + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
 
 	if (stack < begin || stack >= end)
 		return false;
diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
index 43ebbc399..1797aceae 100644
--- a/arch/loongarch/kernel/switch.S
+++ b/arch/loongarch/kernel/switch.S
@@ -26,7 +26,7 @@ SYM_FUNC_START(__switch_to)
 	move	tp, a2
 	cpu_restore_nonscratch a1
 
-	li.w		t0, _THREAD_SIZE - 32
+	li.w		t0, _THREAD_SIZE - _TOP_OF_KERNEL_STACK_PADDING
 	PTR_ADD		t0, t0, tp
 	set_saved_sp	t0, t1, t2
 
-- 
2.31.1

