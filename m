Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39D54BF57
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbiFOBjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241605AbiFOBjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:39:14 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59CCE36B66
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:39:09 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP046OKliBLNCAA--.5517S3;
        Wed, 15 Jun 2022 09:39:07 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] LoongArch: Only clone and clone3 need to call SAVE_STATIC
Date:   Wed, 15 Jun 2022 09:39:04 +0800
Message-Id: <1655257145-24140-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1655257145-24140-1-git-send-email-yangtiezhu@loongson.cn>
References: <1655257145-24140-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxP046OKliBLNCAA--.5517S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1ktw17tr1kWr4UGryrCrg_yoWDtwb_A3
        ZrGa1UWrWrAa92vF9Fqw4fXasFyw48KFnYy3Z7WrWYka45try7twsIqw1UZFs8Krs5XrsY
        vrWjgFyvkr1YkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbhxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWkMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUboKZtUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In handle_syscall, it is unnecessary to call SAVE_STATIC for all syscalls,
only clone and clone3 need to do this operation, so it is better to check
the syscall number before call SAVE_STATIC.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/entry.S | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index d5b3dbc..551b6ec 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -14,6 +14,7 @@
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
 #include <asm/thread_info.h>
+#include <asm/unistd.h>
 
 	.text
 	.cfi_sections	.debug_frame
@@ -56,8 +57,20 @@ SYM_FUNC_START(handle_syscall)
 	cfi_st	u0, PT_R21
 	cfi_st	fp, PT_R22
 
+	/*
+	 * Syscall number held in a7.
+	 * If syscall number is __NR_clone and __NR_clone3, call SAVE_STATIC.
+	 */
+	li.w	t3, __NR_clone
+	beq	a7, t3, 1f
+	li.w	t3, __NR_clone3
+	beq	a7, t3, 1f
+	b	2f
+
+1:
 	SAVE_STATIC
 
+2:
 	move	u0, t0
 	li.d	tp, ~_THREAD_MASK
 	and	tp, tp, sp
-- 
2.1.0

