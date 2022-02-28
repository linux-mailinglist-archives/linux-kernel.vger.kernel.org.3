Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B64C6E14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiB1NYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiB1NYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:24:25 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F55226AED;
        Mon, 28 Feb 2022 05:23:45 -0800 (PST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxeMjazBxiKEAIAA--.10706S3;
        Mon, 28 Feb 2022 21:23:38 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] MIPS: Refactor early_parse_mem() to fix mem= parameter
Date:   Mon, 28 Feb 2022 21:23:34 +0800
Message-Id: <1646054617-16799-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1646054617-16799-1-git-send-email-yangtiezhu@loongson.cn>
References: <1646054617-16799-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxeMjazBxiKEAIAA--.10706S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr15JF17tFyUXF1rCFyrCrg_yoW5JFyfpw
        4fZw1fKr48JF9rZayIyrn3Z345Jw1vkFW3XFW2krn5A3WUCr17Cr1IqrW2gry2qrWxJ3W2
        qF1ktFyjganFk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ry8MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUTqc7UUUUU==
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
index f979adf..6b6d718 100644
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

