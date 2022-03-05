Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2224CE347
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 07:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiCEGWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 01:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiCEGWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 01:22:25 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A58C854BF7;
        Fri,  4 Mar 2022 22:21:35 -0800 (PST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGs1pASNiBh4DAA--.2113S5;
        Sat, 05 Mar 2022 14:21:31 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] MIPS: Refactor early_parse_memmap() to fix memmap= parameter
Date:   Sat,  5 Mar 2022 14:21:28 +0800
Message-Id: <1646461289-31992-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1646461289-31992-1-git-send-email-yangtiezhu@loongson.cn>
References: <1646461289-31992-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9AxGs1pASNiBh4DAA--.2113S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCF17tw4rKFW8Ar18GrWkXrb_yoW5AF13pr
        1furWSkr48tFnrJr1ftrn7u34Yyw1vkF4UGay2krn5Jwn8Jr18Aw1rWFW7KFyfJr1UA3Wj
        qFs8tFy09ws2kw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8AwCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3kuxUUUUU=
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
the kernel command-line parameter memmap= means "Force usage
of a specific region of memory", but when add "memmap=3G@64M"
to the command-line, kernel boot hangs in sparse_init().

In order to support memmap=limit@base, refactor the function
early_parse_memmap() to limit the memory region.

With this patch, when add "memmap=3G@64M" to the command-line,
the kernel boots successfully, we can see the following messages:

  [    0.000000] Memory limited to 64MB-3136MB
  ...
  [    0.000000] Early memory node ranges
  [    0.000000]   node   0: [mem 0x0000000004000000-0x000000000effffff]
  [    0.000000]   node   0: [mem 0x0000000090200000-0x00000000ffffffff]
  [    0.000000]   node   0: [mem 0x0000000120000000-0x00000001653fffff]
  ...
  [    0.000000] Memory: 3070816K/3147776K available (...)

After login, the output of free command is consistent with the
above log.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/kernel/setup.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index de5824bc..6b7229f 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -361,7 +361,6 @@ early_param("mem", early_parse_mem);
 static int __init early_parse_memmap(char *p)
 {
 	char *oldp;
-	u64 start_at, mem_size;
 
 	if (!p)
 		return -EINVAL;
@@ -372,30 +371,38 @@ static int __init early_parse_memmap(char *p)
 	}
 
 	oldp = p;
-	mem_size = memparse(p, &p);
+	memory_limit = memparse(p, &p) & PAGE_MASK;
 	if (p == oldp)
 		return -EINVAL;
 
 	if (*p == '@') {
-		start_at = memparse(p+1, &p);
-		memblock_add(start_at, mem_size);
+		memory_base = memparse(p + 1, &p) & PAGE_MASK;
+	} else if (*p == '$') {
+		memory_base = memparse(p+1, &p) & PAGE_MASK;
+		memblock_reserve(memory_base, memory_limit);
+		pr_notice("Memory reserved to %lluMB-%lluMB\n",
+			  (u64)memory_base >> 20, (u64)(memory_base + memory_limit) >> 20);
+		memory_base = 0;
+		memory_limit = 0;
+		return 0;
 	} else if (*p == '#') {
-		pr_err("\"memmap=nn#ss\" (force ACPI data) invalid on MIPS\n");
+		pr_err("\"memmap=nn#ss\" invalid on MIPS\n");
+		memory_limit = 0;
+		return -EINVAL;
+	} else if (*p == '!') {
+		pr_err("\"memmap=nn!ss\" invalid on MIPS\n");
+		memory_limit = 0;
 		return -EINVAL;
-	} else if (*p == '$') {
-		start_at = memparse(p+1, &p);
-		memblock_add(start_at, mem_size);
-		memblock_reserve(start_at, mem_size);
 	} else {
-		pr_err("\"memmap\" invalid format!\n");
+		pr_err("Unrecognized memmap syntax: %s\n", p);
+		memory_limit = 0;
 		return -EINVAL;
 	}
 
-	if (*p == '\0') {
-		usermem = 1;
-		return 0;
-	} else
-		return -EINVAL;
+	pr_notice("Memory limited to %lluMB-%lluMB\n",
+		  (u64)memory_base >> 20, (u64)(memory_base + memory_limit) >> 20);
+
+	return *p == '\0' ? 0 : -EINVAL;
 }
 early_param("memmap", early_parse_memmap);
 
-- 
2.1.0

