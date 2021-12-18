Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B439947985E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 04:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhLRDXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 22:23:20 -0500
Received: from mail.loongson.cn ([114.242.206.163]:50026 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231800AbhLRDXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 22:23:18 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxnN0eVL1hYvUBAA--.8171S4;
        Sat, 18 Dec 2021 11:23:12 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] MIPS: signal: Return immediately if call fails
Date:   Sat, 18 Dec 2021 11:23:08 +0800
Message-Id: <1639797789-3001-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639797789-3001-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639797789-3001-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9BxnN0eVL1hYvUBAA--.8171S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DZry5Cw17uFWDJF4rGrg_yoW8Ww4fpa
        1xGFZ2grWUXr129F90yF1rZFyrZ3s3Aa1YkrW2gF15J3Z5Wrs8Kr92yrySgr4Dtry5J3W8
        t3WjqF4YqFsakFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gr4l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8zVbDUUUU
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
 arch/mips/kernel/signal.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index c1632e8..4cd3969 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -761,15 +761,28 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
 		return -EFAULT;
 
 	/* Create siginfo.  */
-	err |= copy_siginfo_to_user(&frame->rs_info, &ksig->info);
+	err = copy_siginfo_to_user(&frame->rs_info, &ksig->info);
+	if (err)
+		return -EFAULT;
 
 	/* Create the ucontext.	 */
-	err |= __put_user(0, &frame->rs_uc.uc_flags);
-	err |= __put_user(NULL, &frame->rs_uc.uc_link);
-	err |= __save_altstack(&frame->rs_uc.uc_stack, regs->regs[29]);
-	err |= setup_sigcontext(regs, &frame->rs_uc.uc_mcontext);
-	err |= __copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set));
+	err = __put_user(0, &frame->rs_uc.uc_flags);
+	if (err)
+		return -EFAULT;
+
+	err = __put_user(NULL, &frame->rs_uc.uc_link);
+	if (err)
+		return -EFAULT;
+
+	err = __save_altstack(&frame->rs_uc.uc_stack, regs->regs[29]);
+	if (err)
+		return -EFAULT;
+
+	err = setup_sigcontext(regs, &frame->rs_uc.uc_mcontext);
+	if (err)
+		return -EFAULT;
 
+	err = __copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set));
 	if (err)
 		return -EFAULT;
 
-- 
2.1.0

