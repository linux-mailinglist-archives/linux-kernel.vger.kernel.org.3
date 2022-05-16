Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AA527E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiEPHeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241130AbiEPHeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:34:05 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB76A2315E;
        Mon, 16 May 2022 00:34:03 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L1rZ26MsZz1JCDp;
        Mon, 16 May 2022 15:32:42 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 15:34:01 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <tglx@linutronix.de>,
        <mark.rutland@arm.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: [PATCH -next, v2] powerpc: add support for syscall stack randomization
Date:   Mon, 16 May 2022 15:32:25 +0800
Message-ID: <20220516073225.112875-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for adding a random offset to the stack while handling
syscalls. This patch uses mftb() instead of get_random_int() for better
performance.

In order to avoid unconditional stack canaries on syscall entry (due to
the use of alloca()), also disable stack protector to avoid triggering
needless checks and slowing down the entry path. As there is no general
way to control stack protector coverage with a function attribute, this
must be disabled at the compilation unit level.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

---
Changes in v2:
  -move choose choose_random_kstack_offset() to the end of system_call_exception
  -allow full 6 (10) bits of entropy
  -disable stack-protector for interrupt.c
---
 arch/powerpc/Kconfig            |  1 +
 arch/powerpc/kernel/Makefile    |  7 +++++++
 arch/powerpc/kernel/interrupt.c | 19 ++++++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 98309eeae09c..2f0019a0054e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -192,6 +192,7 @@ config PPC
 	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KFENCE			if PPC_BOOK3S_32 || PPC_8xx || 40x
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 4ddd161aef32..5c5e85b8229b 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -40,6 +40,13 @@ CFLAGS_cputable.o += -DDISABLE_BRANCH_PROFILING
 CFLAGS_btext.o += -DDISABLE_BRANCH_PROFILING
 endif
 
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
+# Remove stack protector to avoid triggering unneeded stack canary
+# checks due to randomize_kstack_offset.
+CFLAGS_REMOVE_interrupt.o = -fstack-protector -fstack-protector-strong
+CFLAGS_interrupt.o += -fno-stack-protector
+#endif
+
 obj-y				:= cputable.o syscalls.o \
 				   irq.o align.o signal_$(BITS).o pmc.o vdso.o \
 				   process.o systbl.o idle.o \
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 784ea3289c84..d7cdcb6fc336 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -4,6 +4,7 @@
 #include <linux/err.h>
 #include <linux/compat.h>
 #include <linux/sched/debug.h> /* for show_regs */
+#include <linux/randomize_kstack.h>
 
 #include <asm/kup.h>
 #include <asm/cputime.h>
@@ -78,10 +79,12 @@ notrace long system_call_exception(long r3, long r4, long r5,
 				   long r6, long r7, long r8,
 				   unsigned long r0, struct pt_regs *regs)
 {
+	long ret;
 	syscall_fn f;
 
 	kuap_lock();
 
+	add_random_kstack_offset();
 	regs->orig_gpr3 = r3;
 
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
@@ -229,7 +232,21 @@ notrace long system_call_exception(long r3, long r4, long r5,
 		f = (void *)sys_call_table[r0];
 	}
 
-	return f(r3, r4, r5, r6, r7, r8);
+	ret = f(r3, r4, r5, r6, r7, r8);
+	/*
+	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
+	 * so the maximum stack offset is 1k bytes(10 bits).
+	 *
+	 * The actual entropy will be further reduced by the compiler when
+	 * applying stack alignment constraints: the powerpc architecture
+	 * may have two kinds of stack alignment(16-bytes and 8-bytes).
+	 *
+	 * So the resulting 6 or 7 bits of entropy is seen in SP[9:4] or SP[9:3].
+	 *
+	 */
+	choose_random_kstack_offset(mftb());
+
+	return ret;
 }
 
 static notrace void booke_load_dbcr0(void)
-- 
2.17.1

