Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0795277C4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 15:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbiEONOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbiEONOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 09:14:15 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1488613F41
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 06:14:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VDAcGqu_1652620449;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VDAcGqu_1652620449)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 15 May 2022 21:14:09 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, wangkefeng.wang@huawei.com,
        vitaly.wool@konsulko.com, rmk+kernel@armlinux.org.uk,
        ebiederm@xmission.com, tongtiangen@huawei.co
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, mick@ics.forth.gr,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] RISC-V: Add fast call path of crash_kexec()
Date:   Sun, 15 May 2022 21:14:07 +0800
Message-Id: <20220515131407.946832-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, almost all archs (x86, arm64, mips...) support fast call
of crash_kexec() when "regs && kexec_should_crash()" is true. But
RISC-V not, it can only enter crash system via panic(). However panic()
doesn't pass the regs of the real accident scene to crash_kexec(),
it caused we can't get accurate backtrace via gdb,
	$ riscv64-linux-gnu-gdb vmlinux vmcore
	Reading symbols from vmlinux...
	[New LWP 95]
	#0  console_unlock () at kernel/printk/printk.c:2557
	2557                    if (do_cond_resched)
	(gdb) bt
	#0  console_unlock () at kernel/printk/printk.c:2557
	#1  0x0000000000000000 in ?? ()

With the patch we can get the accurate backtrace,
	$ riscv64-linux-gnu-gdb vmlinux vmcore
	Reading symbols from vmlinux...
	[New LWP 95]
	#0  0xffffffe00063a4e0 in test_thread (data=<optimized out>) at drivers/virtio/virtio_mmio.c:806
	806             *(int *)p = 0xdead;
	(gdb)
	(gdb) bt
	#0  0xffffffe00063a4e0 in test_thread (data=<optimized out>) at drivers/virtio/virtio_mmio.c:806
	#1  0x0000000000000000 in ?? ()

Test code to produce NULL address dereference,
	+extern int panic_on_oops;
	+static struct task_struct *k;
	+static int test_thread(void *data) {
	+
	+       void *p = NULL;
	+
	+       while (!panic_on_oops)
	+               msleep(2000);
	+
	+       *(int *)p = 0xdead;
	+
	+       return 0;
	+}
	+
	 static int __init virtio_mmio_init(void)
	 {
	+       k = kthread_run(test_thread, NULL, "test_thread");
	+       if (IS_ERR(k))
	+               pr_err("Couldn't create test kthread\n");
	+
	        return platform_driver_register(&virtio_mmio_driver);
	 }

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 arch/riscv/kernel/traps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index fe92e119e6a3..e666ebfa2a64 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/kexec.h>
 
 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
@@ -44,6 +45,9 @@ void die(struct pt_regs *regs, const char *str)
 
 	ret = notify_die(DIE_OOPS, str, regs, 0, regs->cause, SIGSEGV);
 
+	if (regs && kexec_should_crash(current))
+		crash_kexec(regs);
+
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irq(&die_lock);
-- 
2.17.1

