Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619D947985D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 04:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhLRDXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 22:23:19 -0500
Received: from mail.loongson.cn ([114.242.206.163]:50020 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229580AbhLRDXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 22:23:18 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxnN0eVL1hYvUBAA--.8171S5;
        Sat, 18 Dec 2021 11:23:12 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MIPS: signal: Remove unnecessary DEBUG_SIG related code
Date:   Sat, 18 Dec 2021 11:23:09 +0800
Message-Id: <1639797789-3001-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639797789-3001-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639797789-3001-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9BxnN0eVL1hYvUBAA--.8171S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy8Gw1rXFyrZr4DArW7CFg_yoW5tw4kpF
        4jka4kGrZFqw1DuFyDX3sYgryfAr98Cw129F4qka4rZa4SqF1rJF9aq3Wqvr1YvrykWF1f
        KFWYva12yws5AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gr4l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUUUDGDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since DEBUG_SIG is not defined on MIPS, so DEBUGP() is an empty function.
Additionally, it is unacceptable to printk message in the normal path of
signal handling, the system can not work well if DEBUG_SIG is defined, so
just remove the related code.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/kernel/signal-common.h | 8 --------
 arch/mips/kernel/signal.c        | 7 -------
 arch/mips/kernel/signal_n32.c    | 4 ----
 arch/mips/kernel/signal_o32.c    | 8 --------
 4 files changed, 27 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index f50d484..f70135f 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -11,14 +11,6 @@
 #ifndef __SIGNAL_COMMON_H
 #define __SIGNAL_COMMON_H
 
-/* #define DEBUG_SIG */
-
-#ifdef DEBUG_SIG
-#  define DEBUGP(fmt, args...) printk("%s: " fmt, __func__, ##args)
-#else
-#  define DEBUGP(fmt, args...)
-#endif
-
 /*
  * Determine which stack to use..
  */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 4cd3969..feb0cba 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -743,9 +743,6 @@ static int setup_frame(void *sig_return, struct ksignal *ksig,
 	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
 
-	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
-	       current->comm, current->pid,
-	       frame, regs->cp0_epc, regs->regs[31]);
 	return 0;
 }
 #endif
@@ -803,10 +800,6 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
 	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
 
-	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
-	       current->comm, current->pid,
-	       frame, regs->cp0_epc, regs->regs[31]);
-
 	return 0;
 }
 
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 7bd00fa..d0e3f74 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -130,10 +130,6 @@ static int setup_rt_frame_n32(void *sig_return, struct ksignal *ksig,
 	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
 
-	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
-	       current->comm, current->pid,
-	       frame, regs->cp0_epc, regs->regs[31]);
-
 	return 0;
 }
 
diff --git a/arch/mips/kernel/signal_o32.c b/arch/mips/kernel/signal_o32.c
index 299a7a2..3691f74 100644
--- a/arch/mips/kernel/signal_o32.c
+++ b/arch/mips/kernel/signal_o32.c
@@ -144,10 +144,6 @@ static int setup_frame_32(void *sig_return, struct ksignal *ksig,
 	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
 
-	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
-	       current->comm, current->pid,
-	       frame, regs->cp0_epc, regs->regs[31]);
-
 	return 0;
 }
 
@@ -230,10 +226,6 @@ static int setup_rt_frame_32(void *sig_return, struct ksignal *ksig,
 	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
 
-	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
-	       current->comm, current->pid,
-	       frame, regs->cp0_epc, regs->regs[31]);
-
 	return 0;
 }
 
-- 
2.1.0

