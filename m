Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FF04C8256
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiCAEaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiCAE3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:29:52 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 183784DF4E;
        Mon, 28 Feb 2022 20:29:09 -0800 (PST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Bx4M4NoR1iUhoAAA--.595S3;
        Tue, 01 Mar 2022 12:29:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] MIPS: Refactor early_parse_mem() to fix mem= parameter
Date:   Tue,  1 Mar 2022 12:28:58 +0800
Message-Id: <1646108941-27919-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Bx4M4NoR1iUhoAAA--.595S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr15JF17tFyUXF1rCFyrCrg_yoW5JFW5pw
        4fZw1fKr48JFnrZayIyrn3Zry5Gw1vkFW3XFW2kr95Z3WUCr17Cr1IqrW2gFy2qrWxJ3W2
        qF1ktFyjganFy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8XwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4q2_UUUUU=
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
  [    0.000000] Early memory node ranges
  [    0.000000]   node   0: [mem 0x0000000000200000-0x000000000effffff]
  [    0.000000]   node   0: [mem 0x0000000090200000-0x00000000ffffffff]
  [    0.000000]   node   0: [mem 0x0000000120000000-0x00000001613fffff]
  ...
  [    0.000000] Memory: 3005280K/3145728K available (...)

After login, the output of free command is consistent with the
above log.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/kernel/setup.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f979adf..50396ba 100644
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
+	pr_notice("Memory limited to %lluMB\n", (u64)memory_limit >> 20);
 
 	return 0;
 }
@@ -678,6 +666,10 @@ static void __init arch_mem_init(char **cmdline_p)
 	memblock_reserve(__pa_symbol(&__nosave_begin),
 		__pa_symbol(&__nosave_end) - __pa_symbol(&__nosave_begin));
 
+	/* Limit the memory. */
+	memblock_enforce_memory_limit(memory_limit);
+	memblock_allow_resize();
+
 	early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
 }
 
-- 
2.1.0

