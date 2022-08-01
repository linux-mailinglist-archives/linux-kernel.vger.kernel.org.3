Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5650F586AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiHAMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiHAMiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:38:24 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10BD29F045
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:17:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxAM9WxOdiKTUAAA--.1249S6;
        Mon, 01 Aug 2022 20:17:30 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 4/4] LoongArch: Add USER_STACKTRACE support
Date:   Mon,  1 Aug 2022 20:17:26 +0800
Message-Id: <20220801121726.9681-5-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220801121726.9681-1-zhangqing@loongson.cn>
References: <20220801121726.9681-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxAM9WxOdiKTUAAA--.1249S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCryUZw1rCF1DtrW5KFWxWFg_yoW5ZFy5pF
        nFy3ZxtrWUWw4Skr9xZry8Xr98Jw4kG3y2gFZxta45Zr17Xry8Xr4IyFyvqFyUJ393Ja4S
        ga43Kr1qqF4DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5JwCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUseOJUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get the best output you can compile your userspace programs with
frame pointers (at least glibc + the app you are tracing export "CC
=gcc -fno-omit-frame-pointer".

...
     echo 'p:malloc /usr/lib64/libc.so.6:0x0a4704 size=%r4:u64'
                                                > uprobe_events
     echo 'p:free /usr/lib64/libc.so.6:0x0a4d50 ptr=%r4:x64'
                                               >> uprobe_events
     echo 'comm == "demo"' > ./events/uprobes/malloc/filter
     echo 'comm == "demo"' > ./events/uprobes/free/filter
     echo 1 > ./options/userstacktrace
     echo 1 > ./options/sym-userobj
 ...

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig                  |  1 +
 arch/loongarch/include/asm/stacktrace.h |  5 +++
 arch/loongarch/kernel/stacktrace.c      | 42 +++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 85d0fa3147cd..05906384d564 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -107,6 +107,7 @@ config LOONGARCH
 	select SWIOTLB
 	select TRACE_IRQFLAGS_SUPPORT
 	select USE_PERCPU_NUMA_NODE_ID
+	select USER_STACKTRACE_SUPPORT
 	select ZONE_DMA32
 	select MMU_GATHER_MERGE_VMAS if MMU
 
diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/include/asm/stacktrace.h
index 49cb89213aeb..77fdb8ad662d 100644
--- a/arch/loongarch/include/asm/stacktrace.h
+++ b/arch/loongarch/include/asm/stacktrace.h
@@ -21,6 +21,11 @@ struct stack_info {
 	unsigned long begin, end, next_sp;
 };
 
+struct stack_frame {
+	unsigned long	fp;
+	unsigned long	ra;
+};
+
 bool in_task_stack(unsigned long stack, struct task_struct *task,
 			struct stack_info *info);
 bool in_irq_stack(unsigned long stack, struct stack_info *info);
diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/stacktrace.c
index f4f4b8ad3917..344224c7cb0e 100644
--- a/arch/loongarch/kernel/stacktrace.c
+++ b/arch/loongarch/kernel/stacktrace.c
@@ -6,6 +6,7 @@
  */
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
+#include <linux/uaccess.h>
 
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
@@ -35,3 +36,44 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 			break;
 	}
 }
+
+static int
+copy_stack_frame(unsigned long fp, struct stack_frame *frame)
+{
+	int ret;
+	unsigned long err;
+	unsigned long __user *user_frame_tail;
+
+	user_frame_tail = (unsigned long *)(fp - sizeof(struct stack_frame));
+	if (!access_ok(user_frame_tail, sizeof(*frame)))
+		return 0;
+
+	ret = 1;
+	pagefault_disable();
+	err = (__copy_from_user_inatomic(frame, user_frame_tail, sizeof(*frame)));
+	if (err || (unsigned long)user_frame_tail >= frame->fp)
+		ret = 0;
+	pagefault_enable();
+
+	return ret;
+}
+
+void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
+			  const struct pt_regs *regs)
+{
+	unsigned long fp = regs->regs[22];
+
+	while (fp && !((unsigned long)fp & 0xf)) {
+		struct stack_frame frame;
+
+		frame.fp = 0;
+		frame.ra = 0;
+		if (!copy_stack_frame(fp, &frame))
+			break;
+		if (!frame.ra)
+			break;
+		if (!consume_entry(cookie, frame.ra))
+			break;
+		fp = frame.fp;
+	}
+}
-- 
2.20.1

