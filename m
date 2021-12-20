Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8247A41A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 05:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbhLTE1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 23:27:50 -0500
Received: from mail.loongson.cn ([114.242.206.163]:51840 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237421AbhLTE1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 23:27:48 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxvNw9BsBhq10CAA--.8927S5;
        Mon, 20 Dec 2021 12:27:43 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] MIPS: signal: Remove unnecessary DEBUG_SIG related code
Date:   Mon, 20 Dec 2021 12:27:40 +0800
Message-Id: <1639974460-3278-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639974460-3278-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639974460-3278-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxvNw9BsBhq10CAA--.8927S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1kZry5urW3CFyxZrW7CFg_yoW5tw4xpF
        4jka4kGrZrXw1DuFyDX3s5KryfAr98Cw129F4qka4rZa4fXF1rJF9aq3Wqvr1YvrykWF1f
        KFWYva12yws5AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r45MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUnmRUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEBUG_SIG is not defined on MIPS, so DEBUGP() is an empty function.
Additionally, it is unacceptable to printk messages in the normal
path of signal handling, the system can not work well if DEBUG_SIG
is defined, so just remove the related code.

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
index 5bce782..ca95211 100644
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
@@ -792,10 +789,6 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
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

