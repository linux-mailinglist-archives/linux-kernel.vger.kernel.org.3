Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D257552F71
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348491AbiFUKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345821AbiFUKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:07:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 552841028
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 03:07:58 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT957mLFifqhRAA--.24852S4;
        Tue, 21 Jun 2022 18:07:56 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        Rui Wang <wangrui@loongson.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] LoongArch: No need to call RESTORE_ALL_AND_RET for all syscalls
Date:   Tue, 21 Jun 2022 18:07:54 +0800
Message-Id: <1655806074-17454-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1655806074-17454-1-git-send-email-yangtiezhu@loongson.cn>
References: <1655806074-17454-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxT957mLFifqhRAA--.24852S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyrCryDtFW8Aw1kJrWkWFg_yoW5CF17pF
        ZFkFnYkr4vgrn7Ary3KFyv9rZxAws7GF43WF40krWruw1kXrn8Xr4vya4qqFnrtw4FgrW0
        qFWrXwnYgas8XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
        CY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vjfUbhFIUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In handle_syscall, it is unnecessary to call RESTORE_ALL_AND_RET
for all syscalls.

(1) rt_sigreturn call RESTORE_ALL_AND_RET.
(2) The other syscalls call RESTORE_STATIC_SOME_SP_AND_RET.

This patch only adds the minimal changes as simple as possible
to reduce the code complexity, at the same time, it can reduce
many load instructions.

Here are the test environments:

  Hardware: Loongson-LS3A5000-7A1000-1w-A2101
  Firmware: UDK2018-LoongArch-A2101-pre-beta8 [1]
  System: loongarch64-clfs-system-5.0 [2]

The system passed functional testing used with the following
test case without and with this patch:

  git clone https://github.com/hevz/sigaction-test.git
  cd sigaction-test
  make check

Additionally, use UnixBench syscall to test the performance:

  git clone https://github.com/kdlucas/byte-unixbench.git
  cd byte-unixbench/UnixBench/
  make
  pgms/syscall 600

In order to avoid the performance impact, add init=/bin/bash
to the boot cmdline.

Here is the test result, the bigger the better, it shows about
1.2% gain tested with close, getpid and exec [3]:

  duration  without_this_patch  with_this_patch
  600 s     626558267 lps       634244079 lps

[1] https://github.com/loongson/Firmware/tree/main/5000Series/PC/A2101
[2] https://github.com/sunhaiyong1978/CLFS-for-LoongArch/releases/tag/5.0
[3] https://github.com/kdlucas/byte-unixbench/blob/master/UnixBench/src/syscall.c

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/stackframe.h |  5 +++++
 arch/loongarch/kernel/entry.S           | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 4ca9530..551ab8f 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -216,4 +216,9 @@
 	RESTORE_SP_AND_RET \docfi
 	.endm
 
+	.macro	RESTORE_STATIC_SOME_SP_AND_RET docfi=0
+	RESTORE_STATIC \docfi
+	RESTORE_SOME \docfi
+	RESTORE_SP_AND_RET \docfi
+	.endm
 #endif /* _ASM_STACKFRAME_H */
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index d5b3dbc..c764c99 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -14,6 +14,7 @@
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
 #include <asm/thread_info.h>
+#include <asm/unistd.h>
 
 	.text
 	.cfi_sections	.debug_frame
@@ -62,9 +63,23 @@ SYM_FUNC_START(handle_syscall)
 	li.d	tp, ~_THREAD_MASK
 	and	tp, tp, sp
 
+	/* Syscall number held in a7, we can store it in TI_SYSCALL. */
+        LONG_S  a7, tp, TI_SYSCALL
+
 	move	a0, sp
 	bl	do_syscall
 
+	/*
+	 * Syscall number held in a7 which is stored in TI_SYSCALL.
+	 * rt_sigreturn call RESTORE_ALL_AND_RET.
+	 * The other syscalls call RESTORE_STATIC_SOME_SP_AND_RET.
+	 */
+	LONG_L	t3, tp, TI_SYSCALL
+	li.w	t4, __NR_rt_sigreturn
+	beq	t3, t4, 1f
+
+	RESTORE_STATIC_SOME_SP_AND_RET
+1:
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_syscall)
 
-- 
2.1.0

