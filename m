Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691DE4684A0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 13:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354819AbhLDME1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 07:04:27 -0500
Received: from mail.loongson.cn ([114.242.206.163]:60010 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234627AbhLDMEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 07:04:25 -0500
Received: from openarena.loongson.cn (unknown [10.20.41.56])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axash0WKthy+ECAA--.5894S2;
        Sat, 04 Dec 2021 20:00:52 +0800 (CST)
From:   suijingfeng <suijingfeng@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips/loongson64: using __fast_iob implement __wbflush() instead of sync
Date:   Sat,  4 Dec 2021 20:00:51 +0800
Message-Id: <20211204120051.376260-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Axash0WKthy+ECAA--.5894S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4kur1fKrW8XryUCF48Zwb_yoWrur17p3
        9Iyws8Wr4kZr1xGr93CryUAr4rZa95JFWxZF42vFyUZ3sFqr92vFyftryrJr4DXry8Xayr
        u3y5WrWDuFy7Aw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK6svPMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOoGdUUUUU=
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 1) loongson's cpu(ls3a3000, ls3a4000, ls3a5000) have uncache store buffers
    which is for uncache accleration.

    Uncached Accelerated is the name under which the R10000 introduced
    a cache mode that uses the CPU's write buffer to combine writes
    but that otherwise is uncached.

    wbflush is mean to empty data gathered in the uncache store buffers
    within the CPU.

 2) The SYNC instruction in R10000

    A SYNC instruction is not prevented from graduating if the uncached
    buffer contains any uncached accelerated stores[1].

 3) wbflush() implementation of IDT CPU.

    IDT CPUs enforce strict write priority (all pending writes retired
    to memory before main memory is read). Thus, implementing wbflush()
    is as simple as implementing an uncached load.

    for loongson's cpu, __wbflush should also be implemented with
    __fast_iob not sync.

[1] https://www.ele.uva.es/~jesman/BigSeti/ftp/Microprocesadores/MIPS/t5.ver.2.0.book.pdf

Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
---
 arch/mips/loongson64/Makefile  |  1 +
 arch/mips/loongson64/setup.c   | 17 -----------------
 arch/mips/loongson64/smp.c     |  6 +++---
 arch/mips/loongson64/wbflush.c | 28 ++++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 20 deletions(-)
 create mode 100644 arch/mips/loongson64/wbflush.c

diff --git a/arch/mips/loongson64/Makefile b/arch/mips/loongson64/Makefile
index e806280bbb85..ad00d92c2871 100644
--- a/arch/mips/loongson64/Makefile
+++ b/arch/mips/loongson64/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_SUSPEND) += pm.o
 obj-$(CONFIG_PCI_QUIRKS) += vbios_quirk.o
 obj-$(CONFIG_CPU_LOONGSON3_CPUCFG_EMULATION) += cpucfg-emul.o
 obj-$(CONFIG_SYSFS) += boardinfo.o
+obj-$(CONFIG_CPU_HAS_WB) += wbflush.o
diff --git a/arch/mips/loongson64/setup.c b/arch/mips/loongson64/setup.c
index 6fe3ffffcaa6..cb10d14da433 100644
--- a/arch/mips/loongson64/setup.c
+++ b/arch/mips/loongson64/setup.c
@@ -3,10 +3,7 @@
  * Copyright (C) 2007 Lemote Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  */
-#include <linux/export.h>
 #include <linux/init.h>
-
-#include <asm/wbflush.h>
 #include <asm/bootinfo.h>
 #include <linux/libfdt.h>
 #include <linux/of_fdt.h>
@@ -17,20 +14,6 @@
 
 void *loongson_fdt_blob;
 
-static void wbflush_loongson(void)
-{
-	asm(".set\tpush\n\t"
-	    ".set\tnoreorder\n\t"
-	    ".set mips3\n\t"
-	    "sync\n\t"
-	    "nop\n\t"
-	    ".set\tpop\n\t"
-	    ".set mips0\n\t");
-}
-
-void (*__wbflush)(void) = wbflush_loongson;
-EXPORT_SYMBOL(__wbflush);
-
 void __init plat_mem_setup(void)
 {
 	if (loongson_fdt_blob)
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 660e1de4412a..0d9f249c95f9 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -42,13 +42,13 @@ static uint32_t core0_c0count[NR_CPUS];
 #define loongson3_ipi_write32(action, addr)	\
 	do {					\
 		writel(action, addr);		\
-		__wbflush();			\
+		wbflush();			\
 	} while (0)
 /* write a 64bit value to ipi register */
 #define loongson3_ipi_write64(action, addr)	\
 	do {					\
 		writeq(action, addr);		\
-		__wbflush();			\
+		wbflush();			\
 	} while (0)
 
 static u32 (*ipi_read_clear)(int cpu);
@@ -418,7 +418,7 @@ static irqreturn_t loongson3_ipi_interrupt(int irq, void *dev_id)
 		c0count = c0count ? c0count : 1;
 		for (i = 1; i < nr_cpu_ids; i++)
 			core0_c0count[i] = c0count;
-		__wbflush(); /* Let others see the result ASAP */
+		wbflush(); /* Let others see the result ASAP */
 	}
 
 	return IRQ_HANDLED;
diff --git a/arch/mips/loongson64/wbflush.c b/arch/mips/loongson64/wbflush.c
new file mode 100644
index 000000000000..49f0e4c53196
--- /dev/null
+++ b/arch/mips/loongson64/wbflush.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2021 suijingfeng@loongson.cn
+ */
+#include <linux/export.h>
+#include <linux/init.h>
+#include <asm/wbflush.h>
+#include <asm/barrier.h>
+
+#ifdef CONFIG_CPU_HAS_WB
+
+/*
+ * I/O ASIC systems use a standard writeback buffer that gets flushed
+ * upon an uncached read.
+ */
+static void wbflush_mips(void)
+{
+	__fast_iob();
+}
+
+void (*__wbflush)(void) = wbflush_mips;
+EXPORT_SYMBOL(__wbflush);
+
+#endif
-- 
2.25.1

