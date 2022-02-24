Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B04C2C29
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiBXMwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiBXMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:52:47 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 900AA20D527
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:52:15 -0800 (PST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxSMl8fxdizHIGAA--.7452S2;
        Thu, 24 Feb 2022 20:52:13 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Refactor early_parse_mem() to fix mem= parameter
Date:   Thu, 24 Feb 2022 20:52:12 +0800
Message-Id: <1645707132-10121-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxSMl8fxdizHIGAA--.7452S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr15JF17tFyUXF1rCFyrCrg_yoW8uFW3pw
        1Sv34fKr4DtF9rZaySyrn3W345Aw1vkFy2qay2krn5J3Wjkr1UGr1IgFW5Zry2qryxJ3W0
        qF1ktFy0g39Fy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Xr1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUUJ733UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/admin-guide/kernel-parameters.txt,
the kernel command-line parameter mem= means "Force usage of
a specific amount of memory", but when add "mem=3G" to the
command-line, kernel boot hangs in sparse_init().

This commit is similar with the implementation of the other
archs such as arm64, powerpc and riscv, refactor the function
early_parse_mem() and then use memblock_enforce_memory_limit()
to limit the memory size.

With this patch, when add "mem=3G" to the command-line, the
kernel boots successfully, we can see the following messages:

  [    0.000000] Memory limited to 3072MB
  ...
  [    0.000000] Memory: 2991952K/3145728K available (...)

After login, the output of free command is consistent with the
above log.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/kernel/setup.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f979adf..2917412 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -339,27 +339,15 @@ static void __init bootmem_init(void)
 #endif	/* CONFIG_SGI_IP27 */
 
 static int usermem __initdata;
+static phys_addr_t memory_limit;
 
 static int __init early_parse_mem(char *p)
 {
-	phys_addr_t start, size;
-
-	/*
-	 * If a user specifies memory size, we
-	 * blow away any automatically generated
-	 * size.
-	 */
-	if (usermem == 0) {
-		usermem = 1;
-		memblock_remove(memblock_start_of_DRAM(),
-			memblock_end_of_DRAM() - memblock_start_of_DRAM());
-	}
-	start = 0;
-	size = memparse(p, &p);
-	if (*p == '@')
-		start = memparse(p + 1, &p);
+	if (!p)
+		return 1;
 
-	memblock_add(start, size);
+	memory_limit = memparse(p, &p) & PAGE_MASK;
+	pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
 
 	return 0;
 }
@@ -633,6 +621,9 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	parse_early_param();
 
+	/* Limit the memory size via mem= command-line parameter */
+	memblock_enforce_memory_limit(memory_limit);
+
 	if (usermem)
 		pr_info("User-defined physical RAM map overwrite\n");
 
-- 
2.1.0

