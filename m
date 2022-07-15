Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D6C57599F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 04:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbiGOCiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 22:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGOCiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 22:38:05 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D705481E6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 19:38:03 -0700 (PDT)
Received: from lingfengzhe-ms7c94.loongson.cn (unknown [10.90.50.23])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf+ME09BiLbsfAA--.64763S2;
        Fri, 15 Jul 2022 10:37:56 +0800 (CST)
From:   Qi Hu <huqi@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Xu Li <lixu@loongson.cn>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>, Qi Hu <huqi@loongson.cn>
Subject: [PATCH v2] LoongArch: Fix missing fcsr in ptrace's fpr_set
Date:   Fri, 15 Jul 2022 10:37:53 +0800
Message-Id: <20220715023753.436226-1-huqi@loongson.cn>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxf+ME09BiLbsfAA--.64763S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryrtF1UJw4rWF1rXw1xuFg_yoW8XFWrpr
        ZxAas3Wr4rGFWSvr4Dt3yv9ryDX3s2gFyS9393J3WfAwnrXrs8XryjyFZ2vFW2y348Wayx
        XF9Y9r4YyFsFqaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svP
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQAICV3QvP1zwwACs+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In file ptrace.c, function fpr_set does not copy fcsr data from ubuf
to kbuf. That's the reason why fcsr cannot be modified by ptrace.

This patch fixs this problem and allows users using ptrace to modify
the fcsr.

Co-developed-by: Xu Li <lixu@loongson.cn>
Signed-off-by: Qi Hu <huqi@loongson.cn>
---
V1 -> V2: Change Signed-off-by to Co-developed-by in the commit message.
---
 arch/loongarch/kernel/ptrace.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index e6ab87948e1d..dc2b82ea894c 100644
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -193,7 +193,7 @@ static int fpr_set(struct task_struct *target,
 		   const void *kbuf, const void __user *ubuf)
 {
 	const int fcc_start = NUM_FPU_REGS * sizeof(elf_fpreg_t);
-	const int fcc_end = fcc_start + sizeof(u64);
+	const int fcsr_start = fcc_start + sizeof(u64);
 	int err;
 
 	BUG_ON(count % sizeof(elf_fpreg_t));
@@ -209,10 +209,12 @@ static int fpr_set(struct task_struct *target,
 	if (err)
 		return err;
 
-	if (count > 0)
-		err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.fpu.fcc,
-					  fcc_start, fcc_end);
+	err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.fpu.fcc, fcc_start,
+				  fcc_start + sizeof(u64));
+	err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.fpu.fcsr, fcsr_start,
+				  fcsr_start + sizeof(u32));
 
 	return err;
 }
-- 
2.37.0

