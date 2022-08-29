Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6904C5A455B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiH2InH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiH2InE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:43:04 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2373158B5C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:43:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmsQfAxjg8cLAA--.40214S2;
        Mon, 29 Aug 2022 16:42:56 +0800 (CST)
From:   Mao Bibo <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Add safer signal handler for TLS access
Date:   Mon, 29 Aug 2022 16:42:56 +0800
Message-Id: <20220829084256.3453391-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxvmsQfAxjg8cLAA--.40214S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryxKFW5Xw1fZryfGr4xCrg_yoWrXrWDpF
        9rAw1DJrWUWr1kZryqva4DurykJ3s7Cw429ayaka4fAa1Iq3WrXr1vqFyDZF1Yya1kGFW0
        qasYg3sxta1jqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE-syl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07beJ5wUUUUU=
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoongArch uses general purpose register R2 as thread pointer(TP)
register, signal hanlder also uses TP register to access variables
in TLS area, such as errno and variable in TLS.

If GPR R2 is modified with wrong value, signal handler still uses
the wrong TP register, so signal hanlder is insafe to access TLS
variable.

This patch adds one arch specific syscall set_thread_area, and
restore previoud TP value before signal handler, so that signal
handler is safe to access TLS variable.

Signed-off-by: Mao Bibo <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/unistd.h      |  1 +
 arch/loongarch/include/uapi/asm/unistd.h |  2 ++
 arch/loongarch/kernel/process.c          |  5 ++++-
 arch/loongarch/kernel/signal.c           |  2 ++
 arch/loongarch/kernel/syscall.c          | 10 ++++++++++
 5 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/unistd.h b/arch/loongarch/include/asm/unistd.h
index cfddb0116a8c..1581624f0115 100644
--- a/arch/loongarch/include/asm/unistd.h
+++ b/arch/loongarch/include/asm/unistd.h
@@ -9,3 +9,4 @@
 #include <uapi/asm/unistd.h>
 
 #define NR_syscalls (__NR_syscalls)
+__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
index fcb668984f03..b47f26b5307b 100644
--- a/arch/loongarch/include/uapi/asm/unistd.h
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -3,3 +3,5 @@
 #define __ARCH_WANT_SYS_CLONE3
 
 #include <asm-generic/unistd.h>
+
+#define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 660492f064e7..9f512c91320e 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -88,6 +88,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
 	clear_used_math();
 	regs->csr_era = pc;
 	regs->regs[3] = sp;
+	task_thread_info(current)->tp_value = 0;
 }
 
 void exit_thread(struct task_struct *tsk)
@@ -176,8 +177,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	clear_tsk_thread_flag(p, TIF_LSX_CTX_LIVE);
 	clear_tsk_thread_flag(p, TIF_LASX_CTX_LIVE);
 
-	if (clone_flags & CLONE_SETTLS)
+	if (clone_flags & CLONE_SETTLS) {
 		childregs->regs[2] = tls;
+		task_thread_info(p)->tp_value = tls;
+	}
 
 	return 0;
 }
diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index 7f4889df4a17..2eca555fd4a6 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -487,6 +487,8 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
 	regs->regs[3] = (unsigned long) frame;
 	regs->regs[1] = (unsigned long) sig_return;
 	regs->csr_era = (unsigned long) ksig->ka.sa.sa_handler;
+	if (task_thread_info(current)->tp_value)
+		regs->regs[2] = task_thread_info(current)->tp_value;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index 3fc4211db989..b62560d8fe24 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -29,6 +29,16 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len, unsigned long,
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
 }
 
+SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
+{
+	struct thread_info *ti   = task_thread_info(current);
+	struct pt_regs     *regs = current_pt_regs();
+
+	regs->regs[2] = addr;
+	ti->tp_value  = addr;
+	return 0;
+}
+
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
 #include <asm/unistd.h>
-- 
2.27.0

