Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA1592D29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbiHOJXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiHOJXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:23:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FE8A3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:23:52 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M5pdR0rHVzXdh2;
        Mon, 15 Aug 2022 17:19:39 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 17:23:49 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 17:23:48 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2] ARM: Remove the special printing format of pc and lr in __show_regs()
Date:   Mon, 15 Aug 2022 17:21:37 +0800
Message-ID: <20220815092137.1819-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_KALLSYMS is set, the parsed symbols of 'pc' and 'lr' are
printed. Otherwise, the raw content of 'pc' and 'lr' are printed in the
lines: "PC is at" and "LR is at". If at this point they are printed in
format [<%08lx>], the subsequent printing of 'pc' and 'lr' does not need
to follow this format again. This allows the register list to be printed
neatly.

For example:
CONFIG_KALLSYMS=y before:
PC is at test+0x58/0x74
LR is at test+0x28/0x74
pc : [<802f3868>]    lr : [<802f3838>]    psr: 60000013
sp : cabc5da8  ip : 00002ff4  fp : 00000001
r10: 81951018  r9 : 00400cc0  r8 : 7ffff000

CONFIG_KALLSYMS=n after:
PC is at [<802f369c>]
LR is at [<802f366c>]
pc : 802f369c  lr : 802f366c  psr: 60000013
sp : cabd9da8  ip : 00002ff4  fp : 00000001
r10: 827e6018  r9 : 00400cc0  r8 : 7ffff000

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
KernelVersion: v6.0-rc1
 arch/arm/kernel/process.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

v1 --> v2:
On the basis of v1, print the instruction pointers in the lines of
"PC is at" and "LR is at" in format [<%08lx>] if CONFIG_KALLSYMS=n,
as is done in dump_backtrace_entry(). To make sure that tools like
scripts/decode_stacktrace.sh can output the symbols of 'pc' and 'lr'.

v1:
Change the format of "pc:" and "lr:" from [<%08lx>] to %08lx.

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 96f3fbd51764292..f9f4e31393a6f56 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -134,9 +134,15 @@ void __show_regs(struct pt_regs *regs)
 
 	show_regs_print_info(KERN_DEFAULT);
 
+#ifdef CONFIG_KALLSYMS
 	printk("PC is at %pS\n", (void *)instruction_pointer(regs));
 	printk("LR is at %pS\n", (void *)regs->ARM_lr);
-	printk("pc : [<%08lx>]    lr : [<%08lx>]    psr: %08lx\n",
+#else
+	printk("PC is at [<%08lx>]\n", instruction_pointer(regs));
+	printk("LR is at [<%08lx>]\n", regs->ARM_lr);
+#endif
+
+	printk("pc : %08lx  lr : %08lx  psr: %08lx\n",
 	       regs->ARM_pc, regs->ARM_lr, regs->ARM_cpsr);
 	printk("sp : %08lx  ip : %08lx  fp : %08lx\n",
 	       regs->ARM_sp, regs->ARM_ip, regs->ARM_fp);
-- 
2.25.1

