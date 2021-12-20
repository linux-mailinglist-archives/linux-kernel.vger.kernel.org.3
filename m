Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C2B47A418
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 05:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbhLTE1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 23:27:48 -0500
Received: from mail.loongson.cn ([114.242.206.163]:51822 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237410AbhLTE1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 23:27:45 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxvNw9BsBhq10CAA--.8927S4;
        Mon, 20 Dec 2021 12:27:43 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] MIPS: signal: Return immediately if call fails
Date:   Mon, 20 Dec 2021 12:27:39 +0800
Message-Id: <1639974460-3278-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639974460-3278-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639974460-3278-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxvNw9BsBhq10CAA--.8927S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DZry5Cw4UZrW7Cry3urg_yoW8Cr18pa
        1xKa97KrWUGrnF9FyqyF1rZFyfZ3s3Ar4YkrW0g3WrJ3WrWr45KasayrWFqan5tryUJF18
        KF1qqF4YqFsYkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r45MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjOVy7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debug sigaltstack(), copy_siginfo_to_user() fails first in
setup_rt_frame() if the alternate signal stack is too small, so
it should return immediately if call fails, no need to call the
following functions.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/kernel/signal.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index c1632e8..5bce782 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -754,23 +754,25 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
 			  struct pt_regs *regs, sigset_t *set)
 {
 	struct rt_sigframe __user *frame;
-	int err = 0;
 
 	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(frame, sizeof (*frame)))
 		return -EFAULT;
 
 	/* Create siginfo.  */
-	err |= copy_siginfo_to_user(&frame->rs_info, &ksig->info);
+	if (copy_siginfo_to_user(&frame->rs_info, &ksig->info))
+		return -EFAULT;
 
 	/* Create the ucontext.	 */
-	err |= __put_user(0, &frame->rs_uc.uc_flags);
-	err |= __put_user(NULL, &frame->rs_uc.uc_link);
-	err |= __save_altstack(&frame->rs_uc.uc_stack, regs->regs[29]);
-	err |= setup_sigcontext(regs, &frame->rs_uc.uc_mcontext);
-	err |= __copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set));
-
-	if (err)
+	if (__put_user(0, &frame->rs_uc.uc_flags))
+		return -EFAULT;
+	if (__put_user(NULL, &frame->rs_uc.uc_link))
+		return -EFAULT;
+	if (__save_altstack(&frame->rs_uc.uc_stack, regs->regs[29]))
+		return -EFAULT;
+	if (setup_sigcontext(regs, &frame->rs_uc.uc_mcontext))
+		return -EFAULT;
+	if (__copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set)))
 		return -EFAULT;
 
 	/*
-- 
2.1.0

