Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF7F4CEAF8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiCFLVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCFLV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:21:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6F66C950
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:20:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D085B80CB9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4C1C340EC;
        Sun,  6 Mar 2022 11:20:31 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V10 00/10] irqchip: Add LoongArch-related irqchip drivers
Date:   Sun,  6 Mar 2022 19:21:45 +0800
Message-Id: <20220306112155.811157-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Q: Why we don't declare irqchips in ACPI DSDT where hierarchy is possible?
A: This is answered in V8 of this series as below:

  - There are several kinds of irq chips(e.g. pchpic、eiointc、cpuintc)
  for LoongArch. SCI interrupt (Fixed hardware is implemented for
  LoongArch in pch such as LS7A1000, and SCI interrupt is used for fixed
  event handling.) is an irq input of pch irq chip which routes
  interrupts to cpu as following irq chips path:

  sci interrupt->|pchpic| ->|eiointc|->|cpuintc|

  sci_interrupt will be transferred from gsi to irq through
  acpi_gsi_to_irq in acpi_enable_subsystem called from acpi_bus_init
  before acpi_scan_init where acpi device namespace is created, so we
  should build pch irq domain and related upstream irq domains before
  acpi_bus_init.

  - PCI bus enumeration is executed from acpi_scan_init, and
  pci_set_msi_domain will be called for setting msi_domain of enumerated
  pci device. In pci_set_msi_domain, msi domain may be got through
  pcibios_device_add, fdt, iort(used for arm64) or inheriting from host
  bridge domain. And in each way, the msi domain needs to be found by
  calling irq_find_matching_fwnode(fwnode, DOMAIN_BUS_PCI_MSI) to match
  one from the registered msi domain before. So we build the msi domain
  as x86 and arm64 before acpi_scan_init. The msi domain is hierarchic
  as following:

  msi interrupt->|msipic| ->|eiointc|->|cpuintc|

  - Yes, a driver can be deferred probed when get -EPROBE_DEFER on
  probing, but both sci interrupt transfer and pci bus enumeration are
  common code (not private driver for LoongArch).

  So, declaring pic devices in DSDT for seems not suitable, we can only
  select the X86-like way which is a bit ugly.

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

V8 -> V9:
1, Rebase on 5.17-rc5;
2, Update cover letter;
3, Some small improvements.

V9 -> V10:
1, Rebase on 5.17-rc6;
2, Fix build warnings reported by kernel test robot.

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
 drivers/irqchip/Kconfig                |  38 +++-
 drivers/irqchip/Makefile               |   3 +
 drivers/irqchip/irq-loongarch-cpu.c    |  92 ++++++++
 drivers/irqchip/irq-loongson-eiointc.c | 372 +++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-loongson-htvec.c   | 146 ++++++++++---
 drivers/irqchip/irq-loongson-liointc.c | 204 +++++++++++-------
 drivers/irqchip/irq-loongson-pch-lpc.c | 225 ++++++++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c | 128 ++++++++----
 drivers/irqchip/irq-loongson-pch-pic.c | 155 +++++++++++---
 include/linux/cpuhotplug.h             |   1 +
 10 files changed, 1177 insertions(+), 187 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
--
2.27.0

