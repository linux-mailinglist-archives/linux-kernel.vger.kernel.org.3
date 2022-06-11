Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60951547528
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiFKOCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiFKOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 10:02:48 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B74EA326C5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 07:02:45 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxieR8oKRisV85AA--.63531S2;
        Sat, 11 Jun 2022 22:02:36 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH RFC V3 00/11] irqchip: Add LoongArch-related irqchip drivers
Date:   Sat, 11 Jun 2022 22:02:35 +0800
Message-Id: <1654956155-936-1-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxieR8oKRisV85AA--.63531S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyrWFy5Cr4rWF17CFWUtwb_yoWfur15pF
        43Jr1aqF1UKryYqr15Aw48XFy5JFn3Jw4Dta4xtryxXr95Cr1DKr1UJF95Zr97ArWxWr1U
        ZFyjqw4UGw1UAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
boot protocol LoongArch-specific interrupt controllers (similar to APIC)
are already added in the ACPI Specification 6.5(which may be published in
early June this year and the board is reviewing the draft).

Currently, LoongArch based processors (e.g. Loongson-3A5000) can only
work together with LS7A chipsets. The irq chips in LoongArch computers
include CPUINTC (CPU Core Interrupt Controller), LIOINTC (Legacy I/O
Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller),
HTVECINTC (Hyper-Transport Vector Interrupt Controller), PCH-PIC (Main
Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).

CPUINTC is a per-core controller (in CPU), LIOINTC/EIOINTC/HTVECINTC are
per-package controllers (in CPU), while PCH-PIC/PCH-LPC/PCH-MSI are all
controllers out of CPU (i.e., in chipsets). These controllers (in other
words, irqchips) are linked in a hierarchy, and there are two models of
hierarchy (legacy model and extended model). 

Legacy IRQ model:

In this model, the IPI (Inter-Processor Interrupt) and CPU Local Timer
interrupt go to CPUINTC directly, CPU UARTS interrupts go to LIOINTC,
while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and
gathered by HTVECINTC, and then go to LIOINTC, and then CPUINTC.

 +---------------------------------------------+
 |                                             |
 |    +-----+     +---------+     +-------+    |
 |    | IPI | --> | CPUINTC | <-- | Timer |    |
 |    +-----+     +---------+     +-------+    |
 |                     ^                       |
 |                     |                       |
 |                +---------+     +-------+    |
 |                | LIOINTC | <-- | UARTs |    |
 |                +---------+     +-------+    |
 |                     ^                       |
 |                     |                       |
 |               +-----------+                 |
 |               | HTVECINTC |                 |
 |               +-----------+                 |
 |                ^         ^                  |
 |                |         |                  |
 |          +---------+ +---------+            |
 |          | PCH-PIC | | PCH-MSI |            |
 |          +---------+ +---------+            |
 |            ^     ^           ^              |
 |            |     |           |              |
 |    +---------+ +---------+ +---------+      |
 |    | PCH-LPC | | Devices | | Devices |      |
 |    +---------+ +---------+ +---------+      |
 |         ^                                   |
 |         |                                   |
 |    +---------+                              |
 |    | Devices |                              |
 |    +---------+                              |
 |                                             |
 |                                             |
 +---------------------------------------------+

Extended IRQ model:

In this model, the IPI (Inter-Processor Interrupt) and CPU Local Timer
interrupt go to CPUINTC directly, CPU UARTS interrupts go to LIOINTC,
while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and
gathered by EIOINTC, and then go to to CPUINTC directly.

 +--------------------------------------------------------+
 |                                                        |
 |         +-----+     +---------+     +-------+          |
 |         | IPI | --> | CPUINTC | <-- | Timer |          |
 |         +-----+     +---------+     +-------+          |
 |                      ^       ^                         |
 |                      |       |                         |
 |               +---------+ +---------+     +-------+    |
 |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
 |               +---------+ +---------+     +-------+    |
 |                ^       ^                               |
 |                |       |                               |
 |         +---------+ +---------+                        |
 |         | PCH-PIC | | PCH-MSI |                        |
 |         +---------+ +---------+                        |
 |           ^     ^           ^                          |
 |           |     |           |                          |
 |   +---------+ +---------+ +---------+                  |
 |   | PCH-LPC | | Devices | | Devices |                  |
 |   +---------+ +---------+ +---------+                  |
 |        ^                                               |
 |        |                                               |
 |   +---------+                                          |
 |   | Devices |                                          |
 |   +---------+                                          |
 |                                                        |
 |                                                        |
 +--------------------------------------------------------+

The hierarchy model is constructed by parsing irq contronler structures
in MADT. Some controllers((e.g. LIOINTC, HTVECINTC, EIOINTC and PCH-LPC)
are hardcodingly connected to their parents, so their irqdomins are
separately routed to their parents in a fixed way. Some controllers
(e.g. PCH-PIC and PCH-MSI) could be routed to different parents for different
CPU. The firmware will config EIOINTC for the newer CPU and config HTVECINTC
for old CPU in MADT. By this way, PCH-PIC and PCH-MSI irqdomain can only be
routed one parent irqdomin: HTVECINTC or EIOINTC.


Example of irqchip topology in a system with  two chipsets:

 +------------------------------------------------------------+
 |                                                            |
 |                     +------------------+                   |
 |                     |      CPUINTC     |                   |
 |                     +------------------+                   |
 |                     ^                  ^                   |
 |                     |                  |                   |
 |          +----------+                  +----------+        |
 |          | EIOINTC 0|                  | EIOINTC 1|        |
 |          +----------+                  +----------+        |
 |          ^          ^                  ^          ^        |
 |          |          |                  |          |        |
 | +----------+   +----------+   +----------+    +----------+ |
 | | PCH-PIC 0|   | PCH-MSI 0|   | PCH-PIC 1|    | PCH-MSI 1| |
 | +----------+   +----------+   +----------+    +----------+ |
 |                                                            |
 |                                                            |
 +------------------------------------------------------------+

For systems with two chipsets, there are tow group(consists of EIOINTC, PCH-PIC and PCH-MSI) irqdomains, 
and each group has same node id. So we defined a structure to mantain the relation of node and it's parent irqdomain.

struct acpi_vector_group {
        int node;
        struct irq_domain *parent;
};

The initialization and use of acpi_vector_group array are following:

1 Entry of struct acpi_vector_group array initialization:

By parsing MCFG, the node id（from bit44-47 of Base Address）of each pci segment is extracted. And from MADT, we have the node id of each EIOINTC.

entrys[pci segment].node = node id of pci segment
entrys[pci segment].parent = EIOINTC irqdomain(node id of EIOINTC == node id of pci segment)

2 Get parent irqdomain for PCH-PIC:

From MADT, we have the node id of each PCH-PIC(from bit44-47 of Base Address).
if (node of entry i == node of PCH-PIC)
	return entrys[i].parent;

entrys[pci segment].node = node id of pci segment
entrys[pci segment].parent = EIOINTC irqdomain(node id of EIOINTC == node id of pci segment)

3 Get parent irqdomain for PCH-MSI of pci segment:

	return entrys[pci segment].parent;

4 How to select a correct irqdomain to map irq for a device?
For devices using legacy irq behind PCH-PIC, GSI is used to select correct PCH-PIC irqdomain.
For devices using msi irq behind PCH-MSI, the pci segmen of the device is used to select correct PCH-MSI irqdomain.

V1 -> V2:
1, Remove queued patches;
2, Move common logic of DT/ACPI probing to common functions;
3, Split .suspend()/.resume() functions to separate patches.

V2 -> V3:
1, Fix a bug for loongson-pch-pic probe;
2, Some minor improvements for LPC controller.

V3 -> V4:
1, Rework the CPU interrupt controller driver;
2, Some minor improvements for other controllers.

V4 -> V5:
1, Add a description of LoonArch's IRQ model;
2, Support multiple EIOINTCs in one system;
3, Some minor improvements for other controllers.

V5 -> V6:
1, Attach a fwnode to CPUINTC irq domain;
2, Use raw spinlock instead of generic spinlock;
3, Improve the method of restoring EIOINTC state;
4, Update documentation, comments and commit messages.

V6 -> V7:
1, Fix build warnings reported by kernel test robot.

V7 -> V8:
1, Add arguments sanity checking for irqchip init functions;
2, Support Loongson-3C5000 (One NUMA Node includes 4 EIOINTC Node).

V8 -> V9:
1, Rebase on 5.17-rc5;
2, Update cover letter;
3, Some small improvements.

V9 -> V10:
1, Rebase on 5.17-rc6;
2, Fix build warnings reported by kernel test robot.

V10 -> V11:
1, Rebase on 5.18-rc4;
2, Fix irq affinity setting for EIOINTC;
3, Fix hwirq allocation failure for EIOINTC.

V11 -> RFC:
1, Refactored the way to build irqchip hierarchy topology.

RFC -> RFC V2:
1, Move all IO-interrupt related code to driver/irqchip from arch directory.
2. Add description for an example of two chipsets system.

RFC V2 -> RFC V3:
1, Add support for multiple GSI domains
2, Use ACPI_GENERIC_GSI for GSI handling
3, Drop suspend-resume stuff
4, Export fwnode handles instead of irq domain handles

Huacai Chen (1):
  irqchip: Adjust Kconfig for Loongson

Jianmin Lv (10):
  APCI: irq: Add support for multiple GSI domains
  genirq/generic_chip: export irq_unmap_generic_chip
  irqchip: Add LoongArch CPU interrupt controller support
  irqchip: create library file for LoongArch irqchip driver
  irqchip/loongson-pch-pic: Add ACPI init support
  irqchip/loongson-pch-msi: Add ACPI init support
  irqchip/loongson-htvec: Add ACPI init support
  irqchip/loongson-liointc: Add ACPI init support
  irqchip: Add Loongson Extended I/O interrupt controller support
  irqchip: Add Loongson PCH LPC controller support

 drivers/acpi/bus.c                         |   3 +
 drivers/acpi/irq.c                         |  40 ++--
 drivers/irqchip/Kconfig                    |  38 +++-
 drivers/irqchip/Makefile                   |   3 +
 drivers/irqchip/irq-gic-v3.c               |  18 +-
 drivers/irqchip/irq-gic.c                  |  18 +-
 drivers/irqchip/irq-loongarch-cpu.c        | 134 +++++++++++
 drivers/irqchip/irq-loongarch-pic-common.c | 122 ++++++++++
 drivers/irqchip/irq-loongarch-pic-common.h |  39 ++++
 drivers/irqchip/irq-loongson-eiointc.c     | 347 +++++++++++++++++++++++++++++
 drivers/irqchip/irq-loongson-htvec.c       | 119 +++++++---
 drivers/irqchip/irq-loongson-liointc.c     | 232 ++++++++++++-------
 drivers/irqchip/irq-loongson-pch-lpc.c     | 202 +++++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c     | 138 ++++++++----
 drivers/irqchip/irq-loongson-pch-pic.c     | 167 +++++++++++---
 include/linux/acpi.h                       |   3 +-
 include/linux/cpuhotplug.h                 |   1 +
 include/linux/irq.h                        |   1 +
 kernel/irq/generic-chip.c                  |   2 +-
 19 files changed, 1409 insertions(+), 218 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongarch-pic-common.c
 create mode 100644 drivers/irqchip/irq-loongarch-pic-common.h
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c

-- 
1.8.3.1

