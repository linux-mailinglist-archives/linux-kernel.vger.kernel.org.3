Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7231C58882E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiHCHqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiHCHqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:46:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BE51A07A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:46:31 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LyP3w6pZPzjXNK;
        Wed,  3 Aug 2022 15:43:24 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 3 Aug 2022 15:46:27 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 3 Aug 2022 15:46:26 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] ARM: Dump the stack traces based on the parameter 'regs' of show_regs()
Date:   Wed, 3 Aug 2022 15:44:58 +0800
Message-ID: <20220803074458.1599-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function show_regs() is usually called in interrupt handler or exception
handler, it prints the registers specified by the parameter 'regs', then
dump the stack traces. Although not explicitly documented, dump the stack
traces based on'regs' seems to make the most sense. Although dump_stack()
can finally dump the desired content, because 'regs' are saved by the
entry of current interrupt or exception. In the following example we can
see: 1) The backtrace of interrupt or exception handler is not expected,
it causes confusion. 2) Something is printed repeatedly. The line with
the kernel version "CPU: 0 PID: 70 Comm: test0 Not tainted 5.19.0+ #8",
the registers saved in "Exception stack" which 'regs' actually point to.

For example:
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:    0-....: (499 ticks this GP) idle=379/1/0x40000002 softirq=91/91 fqs=249
        (t=500 jiffies g=-911 q=13 ncpus=4)
CPU: 0 PID: 70 Comm: test0 Not tainted 5.19.0+ #8
Hardware name: ARM-Versatile Express
PC is at ktime_get+0x4c/0xe8
LR is at ktime_get+0x4c/0xe8
pc : 8019a474  lr : 8019a474  psr: 60000013
sp : cabd1f28  ip : 00000001  fp : 00000005
r10: 527bf1b8  r9 : 431bde82  r8 : d7b634db
r7 : 0000156e  r6 : 61f234f8  r5 : 00000001  r4 : 80ca86c0
r3 : ffffffff  r2 : fe5bce0b  r1 : 00000000  r0 : 01a431f4
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6121406a  DAC: 00000051
CPU: 0 PID: 70 Comm: test0 Not tainted 5.19.0+ #8  <-----------start----------
Hardware name: ARM-Versatile Express                                          |
 unwind_backtrace from show_stack+0x10/0x14                                   |
 show_stack from dump_stack_lvl+0x40/0x4c                                     |
 dump_stack_lvl from rcu_dump_cpu_stacks+0x10c/0x134                          |
 rcu_dump_cpu_stacks from rcu_sched_clock_irq+0x780/0xaf4                     |
 rcu_sched_clock_irq from update_process_times+0x54/0x74                      |
 update_process_times from tick_periodic+0x3c/0xd4                            |
 tick_periodic from tick_handle_periodic+0x20/0x80                       worthless
 tick_handle_periodic from twd_handler+0x30/0x40                             or
 twd_handler from handle_percpu_devid_irq+0x8c/0x1c8                    duplicated
 handle_percpu_devid_irq from generic_handle_domain_irq+0x24/0x34             |
 generic_handle_domain_irq from gic_handle_irq+0x74/0x88                      |
 gic_handle_irq from generic_handle_arch_irq+0x34/0x44                        |
 generic_handle_arch_irq from call_with_stack+0x18/0x20                       |
 call_with_stack from __irq_svc+0x98/0xb0                                     |
Exception stack(0xcabd1ed8 to 0xcabd1f20)                                     |
1ec0:                                                       01a431f4 00000000 |
1ee0: fe5bce0b ffffffff 80ca86c0 00000001 61f234f8 0000156e d7b634db 431bde82 |
1f00: 527bf1b8 00000005 00000001 cabd1f28 8019a474 8019a474 60000013 ffffffff |
 __irq_svc from ktime_get+0x4c/0xe8                 <---------end--------------
 ktime_get from test_task+0x44/0x110
 test_task from kthread+0xd8/0xf4
 kthread from ret_from_fork+0x14/0x2c
Exception stack(0xcabd1fb0 to 0xcabd1ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000

After replacing dump_stack() with dump_backtrace():
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:    0-....: (500 ticks this GP) idle=8f7/1/0x40000002 softirq=129/129 fqs=241
        (t=500 jiffies g=-915 q=13 ncpus=4)
CPU: 0 PID: 69 Comm: test0 Not tainted 5.19.0+ #9
Hardware name: ARM-Versatile Express
PC is at ktime_get+0x4c/0xe8
LR is at ktime_get+0x4c/0xe8
pc : 8019a494  lr : 8019a494  psr: 60000013
sp : cabddf28  ip : 00000001  fp : 00000002
r10: 0779cb48  r9 : 431bde82  r8 : d7b634db
r7 : 00000a66  r6 : e835ab70  r5 : 00000001  r4 : 80ca86c0
r3 : ffffffff  r2 : ff337d39  r1 : 00000000  r0 : 00cc82c6
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 611d006a  DAC: 00000051
 ktime_get from test_task+0x44/0x110
 test_task from kthread+0xd8/0xf4
 kthread from ret_from_fork+0x14/0x2c
Exception stack(0xcabddfb0 to 0xcabddff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
KernelVersion: v5.19
 arch/arm/include/asm/stacktrace.h | 2 ++
 arch/arm/kernel/process.c         | 2 +-
 arch/arm/kernel/traps.c           | 8 ++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 3e78f921b8b2dc4..dd19a46f781a372 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -41,5 +41,7 @@ extern void walk_stackframe(struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
 extern void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		     unsigned long top);
+extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+			   const char *loglvl);
 
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 3fb30d734c3568a..ae9ddf6c24156ef 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -201,7 +201,7 @@ void __show_regs(struct pt_regs *regs)
 void show_regs(struct pt_regs * regs)
 {
 	__show_regs(regs);
-	dump_stack();
+	dump_backtrace(regs, NULL, KERN_DEFAULT);
 }
 
 ATOMIC_NOTIFIER_HEAD(thread_notify_head);
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 9283dc65be31b7d..00006d268906088 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -205,14 +205,14 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_ARM_UNWIND
-static inline void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
-				  const char *loglvl)
+void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+		    const char *loglvl)
 {
 	unwind_backtrace(regs, tsk, loglvl);
 }
 #else
-static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
-			   const char *loglvl)
+void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+		    const char *loglvl)
 {
 	unsigned int fp, mode;
 	int ok = 1;
-- 
2.25.1

