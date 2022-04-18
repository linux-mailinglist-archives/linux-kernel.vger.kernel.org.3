Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C95504B52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiDRD3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiDRD3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:29:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978D918B11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 20:27:07 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KhXRT2PCdzQjBn;
        Mon, 18 Apr 2022 11:27:01 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 11:27:05 +0800
From:   Yuanzheng Song <songyuanzheng@huawei.com>
To:     <linux@armlinux.org.uk>, <ardb@kernel.org>,
        <rmk+kernel@armlinux.org.uk>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
        <ebiederm@xmission.com>, <wangkefeng.wang@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Yuanzheng Song <songyuanzheng@huawei.com>
Subject: [PATCH] ARM: fix the incorrect value of sp in __die()
Date:   Mon, 18 Apr 2022 03:45:16 +0000
Message-ID: <20220418034516.521046-1-songyuanzheng@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dump_mem() will output useless content that exceed the stack
in __die(), because sp will exceed the top of stack when the
CONFIG_VMAP_STACK=y.

Insufficient stack space to handle exception!
Task stack:     [0xf09dc000..0xf09de000]
IRQ stack:      [0xf0800000..0xf0802000]
Overflow stack: [0xc210e000..0xc210f000]
Internal error: kernel stack overflow: 0 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 81 Comm: sh Not tainted 5.18.0-rc3 #4
Hardware name: ARM-Versatile Express
PC is at mmioset+0x20/0xa8
LR is at recursive_loop+0x34/0x9c
pc : [<c0777080>]    lr : [<c0a90c6c>]    psr: 20000013
sp : f09dbf48  ip : f09dbf4c  fp : 00219644
...
Stack: (0xf09dbf48 to 0xf09de000)
bf40:                   ???????? ???????? ???????? ???????? ???????? ????????
bf60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
bf80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
bfa0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
bfc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
bfe0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
c000: 57ac6e9d 00000000 00000000 00000000 00000000 00000000 00000000 00000000
...

So fix it by adding check for sp and modifying the value of sp
when sp exceed the top of stack.

Insufficient stack space to handle exception!
Task stack:     [0xf09d8000..0xf09da000]
IRQ stack:      [0xf0800000..0xf0802000]
Overflow stack: [0xc210e000..0xc210f000]
Internal error: kernel stack overflow: 0 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 81 Comm: sh Not tainted 5.18.0-rc3-dirty #3
Hardware name: ARM-Versatile Express
PC is at mmioset+0x20/0xa8
LR is at recursive_loop+0x34/0x9c
pc : [<c0777080>]    lr : [<c0a90c6c>]    psr: 20000013
sp : f09d7f48  ip : f09d7f4c  fp : 00219644
...
Stack: (0xf09d8000 to 0xf09da000)
8000: 57ac6e9d 00000000 00000000 00000000 00000000 00000000 00000000 00000000
8020: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
8040: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
8060: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
...

Fixes: a1c510d0adc6 ("ARM: implement support for vmap'ed stacks")
Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
---
 arch/arm/kernel/traps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 9283dc65be31..e93d8f2296be 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -277,6 +277,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	struct task_struct *tsk = current;
 	static int die_counter;
 	int ret;
+	unsigned long sp;
 
 	pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP S_ISA "\n",
 	         str, err, ++die_counter);
@@ -293,8 +294,11 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
 
 	if (!user_mode(regs) || in_interrupt()) {
-		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
-			 ALIGN(regs->ARM_sp - THREAD_SIZE, THREAD_ALIGN)
+		sp = regs->ARM_sp;
+		if (sp < (unsigned long)tsk->stack)
+			sp = (unsigned long)tsk->stack;
+		dump_mem(KERN_EMERG, "Stack: ", sp,
+			 ALIGN(sp - THREAD_SIZE, THREAD_ALIGN)
 			 + THREAD_SIZE);
 		dump_backtrace(regs, tsk, KERN_EMERG);
 		dump_instr(KERN_EMERG, regs);
-- 
2.25.1

