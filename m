Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0444C54C204
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351228AbiFOGiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352380AbiFOGiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:38:05 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA32B41615
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:38:02 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr99HfqliljRDAA--.20432S4;
        Wed, 15 Jun 2022 14:38:01 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        Rui Wang <wangrui@loongson.cn>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] LoongArch: No need to call RESTORE_ALL_AND_RET for all syscalls
Date:   Wed, 15 Jun 2022 14:37:59 +0800
Message-Id: <1655275079-17651-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1655275079-17651-1-git-send-email-yangtiezhu@loongson.cn>
References: <1655275079-17651-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxr99HfqliljRDAA--.20432S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4fur1DXw1ruryrXrWUurg_yoW8KFW8p3
        WqvFnakF4jgF97Cry3XryxurWay3Z7GF4UuFsFk395uw1kX345Xryvya4Dtr12kw48KrW8
        Xa48GwsIgFyjqwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF1l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKKZAUUUUU
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

(1) If syscall number is __NR_clone and __NR_clone3,
    call RESTORE_STATIC_SOME_SP_AND_RET.
(2) If syscall number is __NR_rt_sigreturn and __NR_rt_sigsuspend,
    call RESTORE_TEMP_SOME_SP_AND_RET.
(3) The other syscalls call RESTORE_SOME_SP_AND_RET.

With this patch, it can reduce many load instructions.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/stackframe.h | 17 +++++++++++++++++
 arch/loongarch/kernel/entry.S           | 24 +++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

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
index 53ce2cb..58fe507 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -79,7 +79,29 @@ SYM_FUNC_START(handle_syscall)
 	move	a0, sp
 	bl	do_syscall
 
-	RESTORE_ALL_AND_RET
+	/*
+	 * Syscall number held in a7 which is stored in PT_R11.
+	 * If syscall number is __NR_clone and __NR_clone3,
+	 * call RESTORE_STATIC_SOME_SP_AND_RET.
+	 * If syscall number is __NR_rt_sigreturn and __NR_rt_sigsuspend,
+	 * call RESTORE_TEMP_SOME_SP_AND_RET.
+	 * The other syscalls call RESTORE_SOME_SP_AND_RET.
+	 */
+	cfi_ld	t3, PT_R11
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

