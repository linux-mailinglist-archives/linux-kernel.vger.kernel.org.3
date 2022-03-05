Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852054CE348
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 07:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiCEGWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 01:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiCEGWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 01:22:25 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 137DD532EA;
        Fri,  4 Mar 2022 22:21:34 -0800 (PST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGs1pASNiBh4DAA--.2113S4;
        Sat, 05 Mar 2022 14:21:30 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] MIPS: Refactor early_parse_mem() to fix mem= parameter
Date:   Sat,  5 Mar 2022 14:21:27 +0800
Message-Id: <1646461289-31992-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1646461289-31992-1-git-send-email-yangtiezhu@loongson.cn>
References: <1646461289-31992-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9AxGs1pASNiBh4DAA--.2113S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtryUuF47Ww4DJF1DAr1kZrb_yoW7Kr45pr
        4xXr1Ygr48JFn7Aw1xJrnrJr9xJ34vkF15JF1ayrn7Z3WUJr1UJ34ktr4jga43JrWUJF12
        qF4ktryUKw4DCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8AwCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRM8BUUUUUU=
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
command-line, kernel boot hangs in sparse_init(), the same
issue appears when add "mem=3G@64M".

Here are the logs with "mem=3G@64M memblock=debug" added to
the kernel command line before the hang:

  [    0.000000] Linux version 5.17.0-rc3+ (loongson@linux)
  [    0.000000] CpuClock = 1800000000
  [    0.000000] The bridge chip is LS7A
  [    0.000000] CP0_Config3: CP0 16.3 (0xdc8030a0)
  [    0.000000] CP0_PageGrain: CP0 5.1 (0x28000000)
  [    0.000000] NUMA: Discovered 4 cpus on 1 nodes
  [    0.000000] Node0: mem_type:1, mem_start:0x200000, mem_size:0xee MB
  [    0.000000]        start_pfn:0x80, end_pfn:0x3c00, num_physpages:0x3b80
  [    0.000000] Node0: mem_type:2, mem_start:0x90200000, mem_size:0x6fe MB
  [    0.000000]        start_pfn:0x24080, end_pfn:0x40000, num_physpages:0x1fb00
  [    0.000000] Node0: mem_type:2, mem_start:0x120000000, mem_size:0x1600 MB
  [    0.000000]        start_pfn:0x48000, end_pfn:0xa0000, num_physpages:0x77b00
  [    0.000000] Node0's addrspace_offset is 0x0
  [    0.000000] Node0: start_pfn=0x80, end_pfn=0xa0000
  [    0.000000] NUMA: set cpumask cpu 0 on node 0
  [    0.000000] NUMA: set cpumask cpu 1 on node 0
  [    0.000000] NUMA: set cpumask cpu 2 on node 0
  [    0.000000] NUMA: set cpumask cpu 3 on node 0
  [    0.000000] printk: bootconsole [early0] enabled
  [    0.000000] CPU0 revision is: 0014c001 (ICT Loongson-3)
  [    0.000000] FPU revision is: 00f70501
  [    0.000000] MSA revision is: 00060140
  [    0.000000] OF: fdt: No chosen node found, continuing without
  [    0.000000] MIPS: machine is loongson,loongson64g-4core-ls7a
  [    0.000000] User-defined physical RAM map overwrite
  [    0.000000] Kernel sections are not in the memory maps
  [    0.000000] memblock_add: [0x0000000000200000-0x000000000231185f] setup_arch+0x140/0x794
  [    0.000000] memblock_reserve: [0x0000000001260520-0x0000000001262560] setup_arch+0x148/0x794
  [    0.000000] Initrd not found or empty - disabling initrd
  [    0.000000] memblock_alloc_try_nid: 8257 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 early_init_dt_alloc_memory_arch+0x30/0x60
  [    0.000000] memblock_reserve: [0x0000000004000000-0x0000000004002040] memblock_alloc_range_nid+0xf0/0x178
  [    0.000000] memblock_alloc_try_nid: 37972 bytes align=0x8 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 early_init_dt_alloc_memory_arch+0x30/0x60
  [    0.000000] memblock_reserve: [0x0000000004002048-0x000000000400b49b] memblock_alloc_range_nid+0xf0/0x178

As Mike Rapoport said, the kernel lives in 0x200000 and using
mem=3G@64M removes the memory with the kernel and also makes
the kernel think there is memory between 0x400000 and 0xf000000
while there seem to be a hole up to 0x90200000. This definitely
can be reason for the hangs.

This commit is similar with the implementation of the other
archs such as arm64, powerpc and riscv, refactor the function
early_parse_mem() and then use memblock_mem_range_remove_map()
to support mem=limit and mem=limit@base (if @base is omitted,
it is equivalent to mem=limit).

With this patch, when add "mem=3G" to the command-line, the kernel boots
successfully, we can see the following messages:

  [    0.000000] Memory limited to 0MB-3072MB
  ...
  [    0.000000] Early memory node ranges
  [    0.000000]   node   0: [mem 0x0000000000200000-0x000000000effffff]
  [    0.000000]   node   0: [mem 0x0000000090200000-0x00000000ffffffff]
  [    0.000000]   node   0: [mem 0x0000000120000000-0x00000001613fffff]
  ...
  [    0.000000] Memory: 3005280K/3145728K available (...)

When add "mem=3G@64M" to the command-line, the kernel boots successfully,
we can see the following messages:

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
 arch/mips/kernel/setup.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f979adf..de5824bc 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -339,27 +339,20 @@ static void __init bootmem_init(void)
 #endif	/* CONFIG_SGI_IP27 */
 
 static int usermem __initdata;
+static phys_addr_t memory_limit;
+static phys_addr_t memory_base;
 
 static int __init early_parse_mem(char *p)
 {
-	phys_addr_t start, size;
+	if (!p)
+		return 1;
 
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
+	memory_limit = memparse(p, &p) & PAGE_MASK;
 	if (*p == '@')
-		start = memparse(p + 1, &p);
+		memory_base = memparse(p + 1, &p) & PAGE_MASK;
 
-	memblock_add(start, size);
+	pr_notice("Memory limited to %lluMB-%lluMB\n",
+		  (u64)memory_base >> 20, (u64)(memory_base + memory_limit) >> 20);
 
 	return 0;
 }
@@ -678,6 +671,10 @@ static void __init arch_mem_init(char **cmdline_p)
 	memblock_reserve(__pa_symbol(&__nosave_begin),
 		__pa_symbol(&__nosave_end) - __pa_symbol(&__nosave_begin));
 
+	/* Limit the memory. */
+	memblock_mem_range_remove_map(memory_base, memory_limit);
+	memblock_allow_resize();
+
 	early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
 }
 
-- 
2.1.0

