Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14590522E66
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243720AbiEKIan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbiEKIaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:30:22 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABD9618B944;
        Wed, 11 May 2022 01:30:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxkNoPdHtiw+cQAA--.6S2;
        Wed, 11 May 2022 16:30:08 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangtiezhu@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 1/3] MIPS: Loongson64: Add Loongson-2K1000 SMP support
Date:   Wed, 11 May 2022 16:30:05 +0800
Message-Id: <20220511083007.17700-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxkNoPdHtiw+cQAA--.6S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JryUGF13Xw13CF1DXry7Jrb_yoW7KrWxp3
        9rC3yUWr4rWFn7Crn3tFy8Zrn5GrW3JFsFva17Kw45uF98Wr1rXayrCF15Gr47Cr4DCa43
        Wr95urWrCFWkAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUsF4iUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SMP part of dt parsing about Loongson-2K1000 to multiplex
loongson3_smp_ops, CONFIG_NUMA is not currently supported,
so of_numa is not used to parse relevant information.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/mips/loongson64/env.c |   3 +
 arch/mips/loongson64/smp.c | 130 +++++++++++++++++++++++++++++++++++--
 2 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/arch/mips/loongson64/env.c b/arch/mips/loongson64/env.c
index c961e2999f15..90552f6b00ca 100644
--- a/arch/mips/loongson64/env.c
+++ b/arch/mips/loongson64/env.c
@@ -52,6 +52,9 @@ void __init prom_dtb_init_env(void)
 		loongson_fdt_blob = __dtb_loongson64_2core_2k1000_begin;
 	else
 		loongson_fdt_blob = (void *)fw_arg2;
+
+	loongson_sysconf.dma_mask_bits = 32;
+	loongson_sysconf.workarounds = WORKAROUND_CPUHOTPLUG;
 }
 
 void __init prom_lefi_init_env(void)
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 660e1de4412a..a7d2ad87bae0 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -13,6 +13,7 @@
 #include <linux/smp.h>
 #include <linux/cpufreq.h>
 #include <linux/kexec.h>
+#include <linux/of_address.h>
 #include <asm/processor.h>
 #include <asm/time.h>
 #include <asm/tlbflush.h>
@@ -476,10 +477,59 @@ static void loongson3_smp_finish(void)
 			smp_processor_id(), read_c0_status());
 }
 
+#define INVALID_HWID	ULONG_MAX
+static void parse_dt_cpus_init(void)
+{
+	struct device_node *dn, *np;
+	int i, hwids[NR_CPUS];
+	u64 hwid;
+
+	for_each_of_cpu_node(dn) {
+		hwid = of_get_cpu_hwid(dn, 0);
+		if (hwid >= INVALID_HWID)
+			continue;
+
+		for (i = 0; i < loongson_sysconf.nr_cpus; i++) {
+			if (hwids[i] == hwid) {
+				pr_err("%pOF: duplicate cpu reg properties in the DT\n", dn);
+				continue;
+			}
+		}
+
+		if (loongson_sysconf.nr_cpus >= NR_CPUS)
+			break;
+
+		hwids[loongson_sysconf.nr_cpus] = hwid;
+		loongson_sysconf.nr_cpus++;
+
+		np = of_find_compatible_node(NULL, NULL, "loongson, mmio-ipi");
+		if (!np) {
+			pr_info("Failed to get ipi node\n");
+			return;
+		}
+
+		smp_group[0] = (unsigned long long)of_iomap(np, 0);
+		if (!smp_group[0]) {
+			pr_info("Failed to map ipi register base address\n");
+			return;
+		}
+	}
+
+	of_node_put(np);
+	loongson_sysconf.reserved_cpus_mask = 0;
+	loongson_sysconf.boot_cpu_id = 0;
+	loongson_sysconf.nr_nodes = 1;
+	loongson_sysconf.cores_per_node = loongson_sysconf.nr_cpus;
+	loongson_sysconf.cores_per_package = loongson_sysconf.nr_cpus;
+}
+
 static void __init loongson3_smp_setup(void)
 {
 	int i = 0, num = 0; /* i: physical id, num: logical id */
 
+	if (loongson_sysconf.fw_interface == LOONGSON_DTB)
+		parse_dt_cpus_init();
+
 	init_cpu_possible(cpu_none_mask);
 
 	/* For unified kernel, NR_CPUS is the maximum possible value,
@@ -781,6 +831,68 @@ static void loongson3_type3_play_dead(int *state_addr)
 		: "a1");
 }
 
+static void loongson3_type4_play_dead(int *state_addr)
+{
+	register int val;
+	register long cpuid, core, node, count;
+	register void *addr, *base, *initfunc;
+
+	__asm__ __volatile__(
+		"   .set push                     \n"
+		"   .set noreorder                \n"
+		"   li %[addr], 0x80000000        \n" /* KSEG0 */
+		"1: cache 0, 0(%[addr])           \n" /* flush L1 ICache */
+		"   cache 0, 1(%[addr])           \n"
+		"   cache 0, 2(%[addr])           \n"
+		"   cache 0, 3(%[addr])           \n"
+		"   cache 1, 0(%[addr])           \n" /* flush L1 DCache */
+		"   cache 1, 1(%[addr])           \n"
+		"   cache 1, 2(%[addr])           \n"
+		"   cache 1, 3(%[addr])           \n"
+		"   addiu %[sets], %[sets], -1    \n"
+		"   bnez  %[sets], 1b             \n"
+		"   addiu %[addr], %[addr], 0x40  \n"
+		"   li    %[val], 0x7             \n" /* *state_addr = CPU_DEAD; */
+		"   sw    %[val], (%[state_addr]) \n"
+		"   sync                          \n"
+		"   cache 21, (%[state_addr])     \n" /* flush entry of *state_addr */
+		"   .set pop                      \n"
+		: [addr] "=&r" (addr), [val] "=&r" (val)
+		: [state_addr] "r" (state_addr),
+		  [sets] "r" (cpu_data[smp_processor_id()].dcache.sets));
+
+	__asm__ __volatile__(
+		"   .set push                         \n"
+		"   .set noreorder                    \n"
+		"   .set mips64                       \n"
+		"   mfc0  %[cpuid], $15, 1            \n"
+		"   andi  %[cpuid], 0x3ff             \n"
+		"   dli   %[base], 0x900000001fe11000 \n"
+		"   andi  %[core], %[cpuid], 0x3      \n"
+		"   sll   %[core], 8                  \n" /* get core id */
+		"   or    %[base], %[base], %[core]   \n"
+		"   andi  %[node], %[cpuid], 0xc      \n"
+		"   dsll  %[node], 42                 \n" /* get node id */
+		"   or    %[base], %[base], %[node]   \n"
+		"1: li    %[count], 0x100             \n" /* wait for init loop */
+		"2: bnez  %[count], 2b                \n" /* limit mailbox access */
+		"   addiu %[count], -1                \n"
+		"   ld    %[initfunc], 0x20(%[base])  \n" /* get PC via mailbox */
+		"   beqz  %[initfunc], 1b             \n"
+		"   nop                               \n"
+		"   ld    $sp, 0x28(%[base])          \n" /* get SP via mailbox */
+		"   ld    $gp, 0x30(%[base])          \n" /* get GP via mailbox */
+		"   ld    $a1, 0x38(%[base])          \n"
+		"   jr    %[initfunc]                 \n" /* jump to initial PC */
+		"   nop                               \n"
+		"   .set pop                          \n"
+		: [core] "=&r" (core), [node] "=&r" (node),
+		  [base] "=&r" (base), [cpuid] "=&r" (cpuid),
+		  [count] "=&r" (count), [initfunc] "=&r" (initfunc)
+		: /* No Input */
+		: "a1");
+}
+
 void play_dead(void)
 {
 	int prid_imp, prid_rev, *state_addr;
@@ -816,6 +928,13 @@ void play_dead(void)
 		play_dead_at_ckseg1 =
 			(void *)CKSEG1ADDR((unsigned long)loongson3_type3_play_dead);
 		break;
+	case PRID_REV_LOONGSON2K_R1_0:
+	case PRID_REV_LOONGSON2K_R1_1:
+	case PRID_REV_LOONGSON2K_R1_2:
+	case PRID_REV_LOONGSON2K_R1_3:
+		play_dead_at_ckseg1 =
+			(void *)CKSEG1ADDR((unsigned long)loongson3_type4_play_dead);
+		break;
 	}
 
 out:
@@ -854,10 +973,13 @@ static int loongson3_enable_clock(unsigned int cpu)
 
 static int register_loongson3_notifier(void)
 {
-	return cpuhp_setup_state_nocalls(CPUHP_MIPS_SOC_PREPARE,
-					 "mips/loongson:prepare",
-					 loongson3_enable_clock,
-					 loongson3_disable_clock);
+	if (loongson_sysconf.fw_interface != LOONGSON_DTB)
+		return cpuhp_setup_state_nocalls(CPUHP_MIPS_SOC_PREPARE,
+						 "mips/loongson:prepare",
+						 loongson3_enable_clock,
+						 loongson3_disable_clock);
+	else
+		return 0;
 }
 early_initcall(register_loongson3_notifier);
 
-- 
2.20.1

