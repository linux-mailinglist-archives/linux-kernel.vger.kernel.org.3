Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BC1479862
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 04:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhLRDXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 22:23:41 -0500
Received: from mail.loongson.cn ([114.242.206.163]:50096 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231843AbhLRDXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 22:23:40 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxnN0eVL1hYvUBAA--.8171S3;
        Sat, 18 Dec 2021 11:23:11 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] MIPS: signal: Protect against sigaltstack wraparound
Date:   Sat, 18 Dec 2021 11:23:07 +0800
Message-Id: <1639797789-3001-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639797789-3001-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639797789-3001-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9BxnN0eVL1hYvUBAA--.8171S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4kWFy7CF4fXw4fCr1ftFb_yoW5Cw45pr
        4q9F4fGr47Xw129FnrCw18WrZ5t397Aw17GF1ak3y09ay7Xr4rtrykt3W5CF1fAFZ5Ga4Y
        gFWDWFn7Jr4UA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gr4l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUaQ6LUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a process uses alternative signal stack by using sigaltstack(),
then that stack overflows and stack wraparound occurs.

Simple Explanation:
The accurate sp order is A,B,C,D,...
But now the sp points to A,B,C and A,B,C again.

This problem can reproduce by the following code:

  $ cat test_sigaltstack.c
  #include <stdio.h>
  #include <signal.h>
  #include <stdlib.h>
  #include <string.h>

  volatile int counter = 0;

  void print_sp()
  {
      unsigned long sp;

      __asm__ __volatile__("move %0, $sp" : "=r" (sp));
      printf("sp = 0x%08lx\n", sp);
  }

  void segv_handler()
  {
      int *c = NULL;

      print_sp();
      counter++;
      printf("%d\n", counter);

      if (counter == 23)
          abort();

      *c = 1;	// SEGV
  }

  int main()
  {
      int *c = NULL;
      char *s = malloc(SIGSTKSZ);
      stack_t stack;
      struct sigaction action;

      memset(s, 0, SIGSTKSZ);
      stack.ss_sp = s;
      stack.ss_flags = 0;
      stack.ss_size = SIGSTKSZ;
      if (sigaltstack(&stack, NULL)) {
          printf("Failed to use sigaltstack!\n");
          return -1;
      }

      memset(&action, 0, sizeof(action));
      action.sa_handler = segv_handler;
      action.sa_flags = SA_ONSTACK | SA_NODEFER;
      sigemptyset(&action.sa_mask);
      sigaction(SIGSEGV, &action, NULL);

      *c = 0;	//SEGV

      if (!s)
          free(s);

      return 0;
  }
  $ gcc test_sigaltstack.c -o test_sigaltstack
  $ ./test_sigaltstack
  sp = 0x120015c80
  1
  sp = 0x120015900
  2
  sp = 0x120015580
  3
  sp = 0x120015200
  4
  sp = 0x120014e80
  5
  sp = 0x120014b00
  6
  sp = 0x120014780
  7
  sp = 0x120014400
  8
  sp = 0x120014080
  9
  sp = 0x120013d00
  10
  sp = 0x120015c80
  11               # wraparound occurs! the 11nd output is same as 1st.
  sp = 0x120015900
  12
  sp = 0x120015580
  13
  sp = 0x120015200
  14
  sp = 0x120014e80
  15
  sp = 0x120014b00
  16
  sp = 0x120014780
  17
  sp = 0x120014400
  18
  sp = 0x120014080
  19
  sp = 0x120013d00
  20
  sp = 0x120015c80
  21                # wraparound occurs! the 21nd output is same as 1st.
  sp = 0x120015900
  22
  sp = 0x120015580
  23
  Aborted

With this patch:

  $ ./test_sigaltstack
  sp = 0x120015c80
  1
  sp = 0x120015900
  2
  sp = 0x120015580
  3
  sp = 0x120015200
  4
  sp = 0x120014e80
  5
  sp = 0x120014b00
  6
  sp = 0x120014780
  7
  sp = 0x120014400
  8
  sp = 0x120014080
  9
  Segmentation fault

If we are on the alternate signal stack and would overflow it, don't.
Return an always-bogus address instead so we will die with SIGSEGV.

This patch is similar with commit 83bd01024b1f ("x86: protect against
sigaltstack wraparound").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/kernel/signal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index c9b2a75..c1632e8 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -563,6 +563,13 @@ void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 	sp = regs->regs[29];
 
 	/*
+	 * If we are on the alternate signal stack and would overflow it, don't.
+	 * Return an always-bogus address instead so we will die with SIGSEGV.
+	 */
+	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - frame_size)))
+		return (void __user __force *)(-1UL);
+
+	/*
 	 * FPU emulator may have it's own trampoline active just
 	 * above the user stack, 16-bytes before the next lowest
 	 * 16 byte boundary.  Try to avoid trashing it.
-- 
2.1.0

