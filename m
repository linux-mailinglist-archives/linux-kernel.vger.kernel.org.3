Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22A45AABF7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiIBKBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbiIBKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:01:14 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CDD64A130
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 03:00:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx9OEm1BFjjL4PAA--.1120S2;
        Fri, 02 Sep 2022 18:00:06 +0800 (CST)
From:   Mao Bibo <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH v3] LoongArch: Add safer signal handler for TLS access
Date:   Fri,  2 Sep 2022 17:59:58 +0800
Message-Id: <20220902095958.3875126-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx9OEm1BFjjL4PAA--.1120S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1ruw18Ww4ftr4UuryrtFb_yoWxCw15pF
        98Cr1qyrZ0kw1kAr9Fva4DuryrJwn7Gw429FZIka43Aa12qa1rXryv9a4DZF1Yyw4ku3W0
        qFZ0qrn3ta1qqaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
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

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v2->v3:
 - Use current_thread_info rather than task_thread_info(current)
v1->v2:
 - Clear TP value in clone function if CLONE_SETTLS is not set
---
 arch/loongarch/include/asm/unistd.h      |  1 +
 arch/loongarch/include/uapi/asm/unistd.h |  2 ++
 arch/loongarch/kernel/process.c          | 10 +++++++++-
 arch/loongarch/kernel/signal.c           |  5 +++++
 arch/loongarch/kernel/syscall.c          |  9 +++++++++
 5 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/unistd.h b/arch/loongarch/include/asm/unistd.h
index cfddb0116a8c..1581624f0115 100644
--- a/arch/loongarch/include/asm/unistd.h
+++ b/arch/loongarch/include/asm/unistd.h
@@ -9,3 +9,4 @@
 #include <uapi/asm/unistd.h>
 
 #define NR_syscalls (__NR_syscalls)
+__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
index b344b1f91715..ceb8c4cec505 100644
--- a/arch/loongarch/include/uapi/asm/unistd.h
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -4,3 +4,5 @@
 #define __ARCH_WANT_SYS_CLONE3
 
 #include <asm-generic/unistd.h>
+
+#define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 660492f064e7..488bbe2e8c99 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -88,6 +88,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
 	clear_used_math();
 	regs->csr_era = pc;
 	regs->regs[3] = sp;
+	current_thread_info()->tp_value = 0;
 }
 
 void exit_thread(struct task_struct *tsk)
@@ -152,6 +153,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		childregs->csr_crmd = p->thread.csr_crmd;
 		childregs->csr_prmd = p->thread.csr_prmd;
 		childregs->csr_ecfg = p->thread.csr_ecfg;
+		task_thread_info(p)->tp_value = 0;
 		return 0;
 	}
 
@@ -176,8 +178,14 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
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
+	}
 
 	return 0;
 }
diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index 7f4889df4a17..2d88630e2a05 100644
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
+	if (current_thread_info()->tp_value)
+		regs->regs[2] = current_thread_info()->tp_value;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index 3fc4211db989..330d2aeadc02 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -29,6 +29,15 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len, unsigned long,
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
 }
 
+SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
+{
+	struct pt_regs     *regs = current_pt_regs();
+
+	regs->regs[2] = addr;
+	current_thread_info()->tp_value  = addr;
+	return 0;
+}
+
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
 #include <asm/unistd.h>
-- 
2.31.1

