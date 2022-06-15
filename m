Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7FA54BF56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244589AbiFOBj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbiFOBjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:39:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 055A633A25
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:39:09 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP046OKliBLNCAA--.5517S4;
        Wed, 15 Jun 2022 09:39:08 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] LoongArch: No need to call RESTORE_ALL_AND_RET for all syscalls
Date:   Wed, 15 Jun 2022 09:39:05 +0800
Message-Id: <1655257145-24140-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1655257145-24140-1-git-send-email-yangtiezhu@loongson.cn>
References: <1655257145-24140-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxP046OKliBLNCAA--.5517S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1rXw4UCF47tr1xur4kJFb_yoW8WFW7p3
        ZrZFn7tr40gr93A34ayryxurZFyanrGa129FsFkryruw1kXr98ZFyvva4DtF12yw48KrW0
        ga4rGwnIgFyUXwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
        JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_KwCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU7nYwUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In handle_syscall, it is unnecessary to call RESTORE_ALL_AND_RET for all
syscalls, clone and clone3 should call RESTORE_STATIC_SOME_AND_RET, and
the other syscalls should call RESTORE_SOME_AND_RET.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/stackframe.h | 10 ++++++++++
 arch/loongarch/kernel/entry.S           | 12 +++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 4ca9530..9869b39 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -216,4 +216,14 @@
 	RESTORE_SP_AND_RET \docfi
 	.endm
 
+	.macro	RESTORE_STATIC_SOME_AND_RET docfi=0
+	RESTORE_STATIC \docfi
+	RESTORE_SOME \docfi
+	RESTORE_SP_AND_RET \docfi
+	.endm
+
+	.macro	RESTORE_SOME_AND_RET docfi=0
+	RESTORE_SOME \docfi
+	RESTORE_SP_AND_RET \docfi
+	.endm
 #endif /* _ASM_STACKFRAME_H */
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index 551b6ec..8176094 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -78,7 +78,17 @@ SYM_FUNC_START(handle_syscall)
 	move	a0, sp
 	bl	do_syscall
 
-	RESTORE_ALL_AND_RET
+	/*
+	 * Syscall number held in a7.
+	 * If syscall number is __NR_clone and __NR_clone3, call RESTORE_STATIC_SOME_AND_RET.
+	 */
+	li.w	t3, __NR_clone
+	beq	a7, t3, 3f
+	li.w	t3, __NR_clone3
+	beq	a7, t3, 3f
+	RESTORE_SOME_AND_RET
+3:
+	RESTORE_STATIC_SOME_AND_RET
 SYM_FUNC_END(handle_syscall)
 
 SYM_CODE_START(ret_from_fork)
-- 
2.1.0

