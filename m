Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961794C07C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbiBWCZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiBWCZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:25:07 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26F73969D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 18:24:37 -0800 (PST)
X-UUID: 1ce8197dbf7b4187aab88735c511e23c-20220223
X-UUID: 1ce8197dbf7b4187aab88735c511e23c-20220223
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 67793427; Wed, 23 Feb 2022 10:24:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 23 Feb 2022 10:24:30 +0800
Received: from mszsdtcf10.gcn.mediatek.inc (10.16.4.60) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 23 Feb 2022 10:24:29 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     "GitAuthor : Haibo Li" <haibo.li@mediatek.com>,
        <xiaoming.yu@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] ARM:Fix incomplete stacktrace when unwind ftrace_regs_caller
Date:   Wed, 23 Feb 2022 10:24:28 +0800
Message-ID: <20220223022428.58385-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use register_ftrace_function(&ops) to
register a function callback.
if we set FTRACE_OPS_FL_SAVE_REGS in ftrace flags(flags in ops),
then do stack unwind
like dump_stack or WARN in the callback,we get incomplete stacktrace.
The stack unwind ends in ftrace_regs_caller.

Below is the output from test code.
The test code do register_ftrace_function
with FTRACE_OPS_FL_SAVE_REGS set,
and set sysrq_handle_loglevel as filter,then do dump_stack
in callback.It can not continue to
unwind the stack from ftrace_regs_call

echo 7 >/proc/sysrq-trigger
sysrq: Changing Loglevel
CPU: 1 PID: 145 Comm: sh Not tainted
5.17.0-rc4-00002-gb0dc07624ccd-dirty #2
[    9.023226][  T145] Hardware name: Generic DT based system
[    9.023670][  T145]  unwind_backtrace from show_stack+0x28/0x2c
[    9.024070][  T145]  show_stack from dump_stack_lvl+0x48/0x54
[    9.024298][  T145]  dump_stack_lvl from ftrace_regs_call+0x4/0x18
[    9.024650][  T145] sysrq: Loglevel set to 7

Fix it by adding unwind directives in ftrace_regs_caller.

Signed-off-by: Haibo Li <haibo.li@mediatek.com>
---
 arch/arm/kernel/entry-ftrace.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index a74289ebc803..eafa0c9b8992 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -75,15 +75,18 @@
 
 	add 	ip, sp, #12	@ move in IP the value of SP as it was
 				@ before the push {lr} of the mcount mechanism
-
+ UNWIND(.movsp ip)
 	str     lr, [sp, #0]    @ store LR instead of PC
+ UNWIND(.save{pc})  @it is the caller of ftrace_regs_caller
 
 	ldr     lr, [sp, #8]    @ get previous LR
 
 	str	r0, [sp, #8]	@ write r0 as OLD_R0 over previous LR
 
 	stmdb   sp!, {ip, lr}
+ UNWIND(.save{ip,lr})
 	stmdb   sp!, {r0-r11, lr}
+ UNWIND(.save{r0-r11,lr})
 
 	@ stack content at this point:
 	@ 0  4          48   52       56            60   64    68       72
-- 
2.25.1

