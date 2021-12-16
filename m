Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2871747723F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbhLPMxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbhLPMxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:53:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE29C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:53:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C491B61D79
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 12:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CF9C36AE3;
        Thu, 16 Dec 2021 12:53:40 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V8 00/10] irqchip: Add LoongArch-related irqchip drivers
Date:   Thu, 16 Dec 2021 20:51:57 +0800
Message-Id: <20211216125157.631992-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
boot protocol LoongArch-specific interrupt controllers (similar to APIC)
are already added in the next revision of ACPI Specification (current
revision is 6.4).

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

This patchset adds some irqchip drivers for LoongArch, it is preparing
to add LoongArch support in mainline kernel, we can see a snapshot here:
https://github.com/loongson/linux/tree/loongarch-next

Cross-compile tool chain to build kernel:
https://github.com/loongson/build-tools/releases/latest/download/loongarch64-clfs-20211202-cross-tools.tar.xz

A CLFS-based Linux distro:
https://github.com/loongson/build-tools/releases/latest/download/loongarch64-clfs-system-2021-12-02.tar.bz2

Loongson and LoongArch documentations:
https://github.com/loongson/LoongArch-Documentation

LoongArch-specific interrupt controllers:
https://mantis.uefi.org/mantis/view.php?id=2203

LoongArch use ACPI, but ACPI tables cannot describe the hierarchy of
irqchips, so we initilize the irqchip subsystem in this way (from arch
code):

 cpu_domain = loongarch_cpu_irq_init();
 liointc_domain = liointc_acpi_init(cpu_domain, acpi_liointc);
 eiointc_domain = eiointc_acpi_init(cpu_domain, acpi_eiointc);
 pch_pic_domain = pch_pic_acpi_init(eiointc_domain, acpi_pchpic);
 pch_msi_domain = pch_msi_acpi_init(eiointc_domain, acpi_pchmsi);

Upstream irqchip init function return an irqdomain, and this domain
will be used by downstream irqchips as their parent domains. For more
infomation please refer:
https://lore.kernel.org/linux-arch/20210927064300.624279-11-chenhuacai@loongson.cn/T/#u

Attention: CPUINTC is CSR.ECFG/CSR.ESTAT and its interrupt controller
described in Section 7.4 of "LoongArch Reference Manual, Vol 1"; LIOINTC
is "Legacy I/O Interrupts" described in Section 11.1 of "Loongson 3A5000
Processor Reference Manual"; EIOINTC is "Extended I/O Interrupts" described
in Section 11.2 of "Loongson 3A5000 Processor Reference Manual"; HTVECINTC
is "HyperTransport Interrupts" described in Section 14.3 of "Loongson 3A5000
Processor Reference Manual"; PCH-PIC/PCH-MSI is "Interrupt Controller"
described in Section 5 of "Loongson 7A1000 Bridge User Manual"; PCH-LPC
is "LPC Interrupts" described in Section 24.3 of "Loongson 7A1000 Bridge
User Manual".

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

Huacai Chen:
 irqchip: Adjust Kconfig for Loongson.
 irqchip/loongson-pch-pic: Add ACPI init support.
 irqchip/loongson-pch-pic: Add suspend/resume support.
 irqchip/loongson-pch-msi: Add ACPI init support.
 irqchip/loongson-htvec: Add ACPI init support.
 irqchip/loongson-htvec: Add suspend/resume support.
 irqchip/loongson-liointc: Add ACPI init support. 
 irqchip: Add LoongArch CPU interrupt controller support.
 irqchip: Add Loongson Extended I/O interrupt controller.
 irqchip: Add Loongson PCH LPC controller support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/Kconfig                |  37 +++-
 drivers/irqchip/Makefile               |   3 +
 drivers/irqchip/irq-loongarch-cpu.c    |  89 +++++++++
 drivers/irqchip/irq-loongson-eiointc.c | 331 +++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-loongson-htvec.c   | 142 ++++++++++----
 drivers/irqchip/irq-loongson-liointc.c | 198 ++++++++++++--------
 drivers/irqchip/irq-loongson-pch-lpc.c | 203 ++++++++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c | 119 +++++++-----
 drivers/irqchip/irq-loongson-pch-pic.c | 152 ++++++++++++---
 include/linux/cpuhotplug.h             |   1 +
 10 files changed, 1087 insertions(+), 188 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
--
2.27.0

