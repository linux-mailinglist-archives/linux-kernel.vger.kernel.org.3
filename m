Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F055354C628
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347060AbiFOKab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347743AbiFOK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:29:39 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C93454B1D0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:29:37 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9+NtKliy5VDAA--.20939S4;
        Wed, 15 Jun 2022 18:29:36 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        Rui Wang <wangrui@loongson.cn>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/3] LoongArch: Only clone and clone3 need to call SAVE_STATIC
Date:   Wed, 15 Jun 2022 18:29:32 +0800
Message-Id: <1655288973-6066-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1655288973-6066-1-git-send-email-yangtiezhu@loongson.cn>
References: <1655288973-6066-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxr9+NtKliy5VDAA--.20939S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1ktw17tr1kWr4UGryrCrg_yoWkJwc_A3
        ZrG3yUW3yrAa9aqF9rXr4rX3ZFkw48KF1vkrs2grWYka45t39rtwsa9w1UAF4DKrn3Wrs5
        ZrWUXFyvkr1akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
        0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4DMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUItCDUUUUU==
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

With this patch, it can reduce many store instructions.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/entry.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index d5b3dbc..a0f7fcc 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -14,6 +14,7 @@
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
 #include <asm/thread_info.h>
+#include <asm/unistd.h>
 
 	.text
 	.cfi_sections	.debug_frame
@@ -56,8 +57,17 @@ SYM_FUNC_START(handle_syscall)
 	cfi_st	u0, PT_R21
 	cfi_st	fp, PT_R22
 
+	/* Syscall number held in a7, only clone and clone3 need to call SAVE_STATIC. */
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

