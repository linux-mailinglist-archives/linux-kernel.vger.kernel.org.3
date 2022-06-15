Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49AA54C627
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbiFOKaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347673AbiFOK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:29:39 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 068674162A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:29:37 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9+NtKliy5VDAA--.20939S5;
        Wed, 15 Jun 2022 18:29:36 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        Rui Wang <wangrui@loongson.cn>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 3/3] LoongArch: No need to call RESTORE_ALL_AND_RET for all syscalls
Date:   Wed, 15 Jun 2022 18:29:33 +0800
Message-Id: <1655288973-6066-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1655288973-6066-1-git-send-email-yangtiezhu@loongson.cn>
References: <1655288973-6066-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxr9+NtKliy5VDAA--.20939S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4UAF4UCr4kZFyfZw13Arb_yoW8KFWxpw
        nFvFnYkF4jgF97Ary3XrWxurWay3Z7GF4UuFsFkrZ5uw1vqr98Xryvya4Dtr12yw48trW8
        Wa4rGwsIgFyqq3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8twCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDDGOUUUUU=
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

(1) clone and clone3 call RESTORE_STATIC_SOME_SP_AND_RET.
(2) rt_sigreturn and rt_sigsuspend call RESTORE_TEMP_SOME_SP_AND_RET.
(3) The other syscalls call RESTORE_SOME_SP_AND_RET.

With this patch, it can reduce many load instructions.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/stackframe.h | 17 +++++++++++++++++
 arch/loongarch/kernel/entry.S           | 25 ++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 4ca9530..52649a5f 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -216,4 +216,21 @@
 	RESTORE_SP_AND_RET \docfi
 	.endm
 
+	.macro	RESTORE_SOME_SP_AND_RET docfi=0
+	RESTORE_SOME \docfi
+	RESTORE_SP_AND_RET \docfi
+	.endm
+
+	.macro	RESTORE_STATIC_SOME_SP_AND_RET docfi=0
+	RESTORE_STATIC \docfi
+	RESTORE_SOME \docfi
+	RESTORE_SP_AND_RET \docfi
+	.endm
+
+	.macro	RESTORE_TEMP_SOME_SP_AND_RET docfi=0
+	RESTORE_TEMP \docfi
+	RESTORE_SOME \docfi
+	RESTORE_SP_AND_RET \docfi
+	.endm
+
 #endif /* _ASM_STACKFRAME_H */
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index a0f7fcc..e27e38b 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -72,10 +72,33 @@ SYM_FUNC_START(handle_syscall)
 	li.d	tp, ~_THREAD_MASK
 	and	tp, tp, sp
 
+	/* Syscall number held in a7, we can store it in TI_SYSCALL. */
+        LONG_S  a7, tp, TI_SYSCALL
+
 	move	a0, sp
 	bl	do_syscall
 
-	RESTORE_ALL_AND_RET
+	/*
+	 * Syscall number held in a7 which is stored in TI_SYSCALL.
+	 * clone and clone3 call RESTORE_STATIC_SOME_SP_AND_RET.
+	 * rt_sigreturn and rt_sigsuspend call RESTORE_TEMP_SOME_SP_AND_RET.
+	 * The other syscalls call RESTORE_SOME_SP_AND_RET.
+	 */
+	LONG_L	t3, tp, TI_SYSCALL
+	li.w	t4, __NR_clone
+	beq	t3, t4, 3f
+	li.w	t4, __NR_clone3
+	beq	t3, t4, 3f
+	li.w	t4, __NR_rt_sigreturn
+	beq	t3, t4, 4f
+	li.w	t4, __NR_rt_sigsuspend
+	beq	t3, t4, 4f
+
+	RESTORE_SOME_SP_AND_RET
+3:
+	RESTORE_STATIC_SOME_SP_AND_RET
+4:
+	RESTORE_TEMP_SOME_SP_AND_RET
 SYM_FUNC_END(handle_syscall)
 
 SYM_CODE_START(ret_from_fork)
-- 
2.1.0

