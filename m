Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2455629CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 05:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiGADpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 23:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiGADpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 23:45:45 -0400
X-Greylist: delayed 509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 20:45:44 PDT
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com [115.236.118.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C36F1F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 20:45:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:36a:1490:a600:e4a7:e096:77dd:23b4])
        by mail-m11874.qiye.163.com (Hmail) with ESMTPA id E674D3C02C1;
        Fri,  1 Jul 2022 11:37:12 +0800 (CST)
From:   Yupeng Li <liyupeng@zbhlos.com>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org
Cc:     caizp2008@163.com, linux-kernel@vger.kernel.org,
        Yupeng Li <liyupeng@zbhlos.com>
Subject: [PATCH 1/1] timers/nohz: fix build with CONFIG_NO_HZ_FULL warnning.
Date:   Fri,  1 Jul 2022 11:36:47 +0800
Message-Id: <20220701033647.911334-1-liyupeng@zbhlos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSk9DVkhMSx1LHx0ZQ0NNTFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSE0aQUpPQktBGk1LS0EeTxpMQR5LQk1BTEwfH0FJSBlPWVdZFhoPEhUdFF
        lBWU9LSFVKSktITk9VS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MVE6KQw6Sj06Qyo8TT0YAzIM
        GRwaCg1VSlVKTU5NTU9NTUhIT01JVTMWGhIXVRcSAg4LHhUcOwEZExcUCFUYFBZFWVdZEgtZQVlJ
        T0seQUhNGkFKT0JLQRpNS0tBHk8aTEEeS0JNQUxMHx9BSUgZT1lXWQgBWUFIS0pMNwY+
X-HM-Tid: 0a81b7d586682eb0kusne674d3c02c1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_NO_HZ_FULL was enabled,build kernel with Section mismatch
warnnings.Fixed this by removing the __init annotation according to
the prompt of compilation information ,some build messages as followed:
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.symvers
WARNING: modpost: vmlinux.o(___ksymtab_gpl+tick_nohz_full_setup+0x0): Section mismatch in reference from the variable __ksymtab_tick_nohz_full_setup to the function .init.text:tick_nohz_full_setup()
The symbol tick_nohz_full_setup is exported and annotated __init
Fix this by removing the __init annotation of tick_nohz_full_setup or drop the export.

  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
  LD      .tmp_vmlinux.kallsyms1

Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
Reviewed-by: Caicai <caizp2008@163.com>
---
 include/linux/tick.h     | 2 +-
 kernel/time/tick-sched.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index bfd571f18cfd..63fe21c6a55c 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -272,7 +272,7 @@ static inline void tick_dep_clear_signal(struct signal_struct *signal,
 
 extern void tick_nohz_full_kick_cpu(int cpu);
 extern void __tick_nohz_task_switch(void);
-extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
+extern void tick_nohz_full_setup(cpumask_var_t cpumask);
 #else
 static inline bool tick_nohz_full_enabled(void) { return false; }
 static inline bool tick_nohz_full_cpu(int cpu) { return false; }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 58a11f859ac7..f8641c66f0d8 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -520,7 +520,7 @@ void __tick_nohz_task_switch(void)
 }
 
 /* Get the boot-time nohz CPU list from the kernel parameters. */
-void __init tick_nohz_full_setup(cpumask_var_t cpumask)
+void tick_nohz_full_setup(cpumask_var_t cpumask)
 {
 	alloc_bootmem_cpumask_var(&tick_nohz_full_mask);
 	cpumask_copy(tick_nohz_full_mask, cpumask);
-- 
2.34.1

