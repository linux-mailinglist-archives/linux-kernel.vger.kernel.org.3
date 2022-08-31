Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5945A5A781C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiHaHuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiHaHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:49:07 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B120C22A5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:48:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx9OFeEg9jNZINAA--.59415S2;
        Wed, 31 Aug 2022 15:48:46 +0800 (CST)
From:   Mao Bibo <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: Add safer signal handler for TLS access
Date:   Wed, 31 Aug 2022 15:48:46 +0800
Message-Id: <20220831074846.3565542-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx9OFeEg9jNZINAA--.59415S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1ruw18Ww4ftr4UuryrtFb_yoWxWF4rpF
        9xAw1kArZ0kw1kAr9Fva4Dury8Gwn7Gw47uFZIka45Aa12qa1rXryv9a4DZF4Yyw4ku3W0
        qFZ0grnxta1qqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK6svPMxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
        AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7eOJUUUUU
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

It passes to run with the following test case.
=======8<======
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <signal.h>
 #include <pthread.h>
 #include <asm/ucontext.h>
 #include <asm/sigcontext.h>

 #define ILL_INSN ".word 0x000001f0"
static inline long test_sigill(unsigned long fid)
{
        register long ret __asm__("$r4");
        register unsigned long fun __asm__("$r4") = fid;

        __asm__ __volatile__("move $r2, $r0 \r\n");
        __asm__ __volatile__(
                        ILL_INSN
                        : "=r" (ret)
                        : "r" (fun)
                        : "memory"
                        );

        return ret;
}

static void set_sigill_handler(void (*fn) (int, siginfo_t *, void *))
{
        struct sigaction sa;
        memset(&sa, 0, sizeof(struct sigaction));

        sa.sa_sigaction = fn;
        sa.sa_flags = SA_SIGINFO;
        sigemptyset(&sa.sa_mask);
        if (sigaction(SIGILL, &sa, 0) != 0) {
                perror("sigaction");
        }
}

void catch_sig(int sig, siginfo_t *si, void *vuc)
{
        struct ucontext *uc = vuc;
        register unsigned long tls  __asm__("$r2");

        uc->uc_mcontext.sc_pc +=4;
        uc->uc_mcontext.sc_regs[2] = tls;
        printf("catched signal %d\n", sig);
}

void *print_message_function( void *ptr )
{
        char *message;
        message = (char *) ptr;
        printf("%s \n", message);
        test_sigill(1);
}

void pthread_test(void)
{
        pthread_t thread1, thread2;
        char *message1 = "Thread 1";
        char *message2 = "Thread 2";
        int  iret1, iret2;

        iret1 = pthread_create( &thread1, NULL, print_message_function,
				(void*) message1);
        iret2 = pthread_create( &thread2, NULL, print_message_function,
				(void*) message2);
        pthread_join( thread1, NULL);
        pthread_join( thread2, NULL);
        printf("Thread 1 returns: %d\n",iret1);
        printf("Thread 2 returns: %d\n",iret2);
        exit(0);
}

void exec_test(void) {
        test_sigill(1);
}

void main() {
        register unsigned long tls  __asm__("$r2");
        int val;

        val = syscall(244, tls);
        set_sigill_handler(&catch_sig);
        pthread_test();
        //exec_test();
        return;
}
=======8<======

Signed-off-by: Mao Bibo <maobibo@loongson.cn>
---
v1->v2:
 - Clear TP value in clone function if CLONE_SETTLS is not set 
---
 arch/loongarch/include/asm/unistd.h      |  1 +
 arch/loongarch/include/uapi/asm/unistd.h |  2 ++
 arch/loongarch/kernel/process.c          | 10 +++++++++-
 arch/loongarch/kernel/signal.c           |  5 +++++
 arch/loongarch/kernel/syscall.c          | 10 ++++++++++
 5 files changed, 27 insertions(+), 1 deletion(-)

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
index 660492f064e7..f513b3d845b4 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -88,6 +88,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
 	clear_used_math();
 	regs->csr_era = pc;
 	regs->regs[3] = sp;
+	task_thread_info(current)->tp_value = 0;
 }
 
 void exit_thread(struct task_struct *tsk)
@@ -176,8 +177,15 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	clear_tsk_thread_flag(p, TIF_LSX_CTX_LIVE);
 	clear_tsk_thread_flag(p, TIF_LASX_CTX_LIVE);
 
-	if (clone_flags & CLONE_SETTLS)
+	/*
+	 * record tls val for cloned threads
+	 * clear it for forked process
+	 */
+	if (clone_flags & CLONE_SETTLS) {
 		childregs->regs[2] = tls;
+		task_thread_info(p)->tp_value = tls;
+	} else
+		task_thread_info(p)->tp_value = 0;
 
 	return 0;
 }
diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index 7f4889df4a17..9e0c9755e548 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -480,6 +480,9 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
 	 *
 	 * c0_era point to the signal handler, $r3 (sp) points to
 	 * the struct rt_sigframe.
+	 *
+	 * Use recorded TP to signal handler if exists since $r2 may be
+	 * corrupted already.
 	 */
 	regs->regs[4] = ksig->sig;
 	regs->regs[5] = (unsigned long) &frame->rs_info;
@@ -487,6 +490,8 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
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

