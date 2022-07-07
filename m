Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D359A56A1C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiGGMIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiGGMIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:08:13 -0400
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E37759254
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:08:09 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.31.99] (unknown[27.196.144.100])
        by rmsmtp-lg-appmail-12-12001 (RichMail) with SMTP id 2ee162c6cca1a83-5543a;
        Thu, 07 Jul 2022 20:08:03 +0800 (CST)
X-RM-TRANSID: 2ee162c6cca1a83-5543a
Message-ID: <4c420e03-e53d-c1d6-5989-72479e00f159@139.com>
Date:   Thu, 7 Jul 2022 20:08:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V14 00/15] irqchip: Add LoongArch-related irqchip drivers
Content-Language: en-US
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
From:   Hu Zeyuan <huzeyuan139@139.com>
In-Reply-To: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Jianmin,
Could you CC the kernel mailing list of loongarch[1] when you submitting 
patches for LoongArch?

[1]loongarch@lists.linux.dev

Thanks!

在 2022/7/3 16:45, Jianmin Lv 写道:
> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> are already added in the ACPI Specification 6.5(which may be published in
> early June this year and the board is reviewing the draft).
> 
> Currently, LoongArch based processors (e.g. Loongson-3A5000) can only
> work together with LS7A chipsets. The irq chips in LoongArch computers
> include CPUINTC (CPU Core Interrupt Controller), LIOINTC (Legacy I/O
> Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller),
> HTVECINTC (Hyper-Transport Vector Interrupt Controller), PCH-PIC (Main
> Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
> in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
> 
> CPUINTC is a per-core controller (in CPU), LIOINTC/EIOINTC/HTVECINTC are
> per-package controllers (in CPU), while PCH-PIC/PCH-LPC/PCH-MSI are all
> controllers out of CPU (i.e., in chipsets). These controllers (in other
> words, irqchips) are linked in a hierarchy, and there are two models of
> hierarchy (legacy model and extended model).
> 
> Legacy IRQ model:
> 
> In this model, the IPI (Inter-Processor Interrupt) and CPU Local Timer
> interrupt go to CPUINTC directly, CPU UARTS interrupts go to LIOINTC,
> while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and
> gathered by HTVECINTC, and then go to LIOINTC, and then CPUINTC.
> 
>   +---------------------------------------------+
>   |                                             |
>   |    +-----+     +---------+     +-------+    |
>   |    | IPI | --> | CPUINTC | <-- | Timer |    |
>   |    +-----+     +---------+     +-------+    |
>   |                     ^                       |
>   |                     |                       |
>   |                +---------+     +-------+    |
>   |                | LIOINTC | <-- | UARTs |    |
>   |                +---------+     +-------+    |
>   |                     ^                       |
>   |                     |                       |
>   |               +-----------+                 |
>   |               | HTVECINTC |                 |
>   |               +-----------+                 |
>   |                ^         ^                  |
>   |                |         |                  |
>   |          +---------+ +---------+            |
>   |          | PCH-PIC | | PCH-MSI |            |
>   |          +---------+ +---------+            |
>   |            ^     ^           ^              |
>   |            |     |           |              |
>   |    +---------+ +---------+ +---------+      |
>   |    | PCH-LPC | | Devices | | Devices |      |
>   |    +---------+ +---------+ +---------+      |
>   |         ^                                   |
>   |         |                                   |
>   |    +---------+                              |
>   |    | Devices |                              |
>   |    +---------+                              |
>   |                                             |
>   |                                             |
>   +---------------------------------------------+
> 
> Extended IRQ model:
> 
> In this model, the IPI (Inter-Processor Interrupt) and CPU Local Timer
> interrupt go to CPUINTC directly, CPU UARTS interrupts go to LIOINTC,
> while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and
> gathered by EIOINTC, and then go to to CPUINTC directly.
> 
>   +--------------------------------------------------------+
>   |                                                        |
>   |         +-----+     +---------+     +-------+          |
>   |         | IPI | --> | CPUINTC | <-- | Timer |          |
>   |         +-----+     +---------+     +-------+          |
>   |                      ^       ^                         |
>   |                      |       |                         |
>   |               +---------+ +---------+     +-------+    |
>   |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
>   |               +---------+ +---------+     +-------+    |
>   |                ^       ^                               |
>   |                |       |                               |
>   |         +---------+ +---------+                        |
>   |         | PCH-PIC | | PCH-MSI |                        |
>   |         +---------+ +---------+                        |
>   |           ^     ^           ^                          |
>   |           |     |           |                          |
>   |   +---------+ +---------+ +---------+                  |
>   |   | PCH-LPC | | Devices | | Devices |                  |
>   |   +---------+ +---------+ +---------+                  |
>   |        ^                                               |
>   |        |                                               |
>   |   +---------+                                          |
>   |   | Devices |                                          |
>   |   +---------+                                          |
>   |                                                        |
>   |                                                        |
>   +--------------------------------------------------------+
> 
> The hierarchy model is constructed by parsing irq contronler structures
> in MADT. Some controllers((e.g. LIOINTC, HTVECINTC, EIOINTC and PCH-LPC)
> are hardcodingly connected to their parents, so their irqdomins are
> separately routed to their parents in a fixed way. Some controllers
> (e.g. PCH-PIC and PCH-MSI) could be routed to different parents for different
> CPU. The firmware will config EIOINTC for the newer CPU and config HTVECINTC
> for old CPU in MADT. By this way, PCH-PIC and PCH-MSI irqdomain can only be
> routed one parent irqdomin: HTVECINTC or EIOINTC.
> 
> 
> Example of irqchip topology in a system with  two chipsets:
> 
>   +------------------------------------------------------------+
>   |                                                            |
>   |                     +------------------+                   |
>   |                     |      CPUINTC     |                   |
>   |                     +------------------+                   |
>   |                     ^                  ^                   |
>   |                     |                  |                   |
>   |          +----------+                  +----------+        |
>   |          | EIOINTC 0|                  | EIOINTC 1|        |
>   |          +----------+                  +----------+        |
>   |          ^          ^                  ^          ^        |
>   |          |          |                  |          |        |
>   | +----------+   +----------+   +----------+    +----------+ |
>   | | PCH-PIC 0|   | PCH-MSI 0|   | PCH-PIC 1|    | PCH-MSI 1| |
>   | +----------+   +----------+   +----------+    +----------+ |
>   |                                                            |
>   |                                                            |
>   +------------------------------------------------------------+
> 
> For systems with two chipsets, there are tow group(consists of EIOINTC, PCH-PIC and PCH-MSI) irqdomains,
> and each group has same node id. So we defined a structure to mantain the relation of node and it's parent irqdomain.
> 
> struct acpi_vector_group {
>          int node;
> 	int pci_segment;
>          struct irq_domain *parent;
> };
> 
> The initialization and use of acpi_vector_group array are following:
> 
> 1 Entry of struct acpi_vector_group array initialization:
> 
> By parsing MCFG, the node id（from bit44-47 of Base Address）and pci segment are extracted. And from MADT, we have the node id of each EIOINTC.
> 
> entry.node = node id of pci segment
> entry.pci_segment = pci segment (only for msi irqdomain)
> 
> By matching node id of entry and EIOINTC to set parent.
> 
> entry.parent = EIOINTC irqdomain(node id of EIOINTC == node id of pci segment)
> 
> 2 Get parent irqdomain for PCH-PIC:
> 
>>From MADT, we have the node id of each PCH-PIC(from bit44-47 of Base Address).
> if (node of entry i == node of PCH-PIC)
> 	return entrys[i].parent;
> 
> 3 Get parent irqdomain for PCH-MSI of pci segment:
> 
> 	return entrys[i].parent; (i is the index of msi irqdomain)
> 
> 4 How to select a correct irqdomain to map irq for a device?
> For devices using legacy irq behind PCH-PIC, GSI is used to select correct PCH-PIC irqdomain.
> For devices using msi irq behind PCH-MSI, the pci segmen of the device is used to select correct PCH-MSI irqdomain.
> 
> V1 -> V2:
> 1, Remove queued patches;
> 2, Move common logic of DT/ACPI probing to common functions;
> 3, Split .suspend()/.resume() functions to separate patches.
> 
> V2 -> V3:
> 1, Fix a bug for loongson-pch-pic probe;
> 2, Some minor improvements for LPC controller.
> 
> V3 -> V4:
> 1, Rework the CPU interrupt controller driver;
> 2, Some minor improvements for other controllers.
> 
> V4 -> V5:
> 1, Add a description of LoonArch's IRQ model;
> 2, Support multiple EIOINTCs in one system;
> 3, Some minor improvements for other controllers.
> 
> V5 -> V6:
> 1, Attach a fwnode to CPUINTC irq domain;
> 2, Use raw spinlock instead of generic spinlock;
> 3, Improve the method of restoring EIOINTC state;
> 4, Update documentation, comments and commit messages.
> 
> V6 -> V7:
> 1, Fix build warnings reported by kernel test robot.
> 
> V7 -> V8:
> 1, Add arguments sanity checking for irqchip init functions;
> 2, Support Loongson-3C5000 (One NUMA Node includes 4 EIOINTC Node).
> 
> V8 -> V9:
> 1, Rebase on 5.17-rc5;
> 2, Update cover letter;
> 3, Some small improvements.
> 
> V9 -> V10:
> 1, Rebase on 5.17-rc6;
> 2, Fix build warnings reported by kernel test robot.
> 
> V10 -> V11:
> 1, Rebase on 5.18-rc4;
> 2, Fix irq affinity setting for EIOINTC;
> 3, Fix hwirq allocation failure for EIOINTC.
> 
> V11 -> RFC:
> 1, Refactored the way to build irqchip hierarchy topology.
> 
> RFC -> RFC V2:
> 1, Move all IO-interrupt related code to driver/irqchip from arch directory.
> 2. Add description for an example of two chipsets system.
> 
> RFC V2 -> RFC V3:
> 1, Add support for multiple GSI domains
> 2, Use ACPI_GENERIC_GSI for GSI handling
> 3, Drop suspend-resume stuff
> 4, Export fwnode handles instead of irq domain handles
> 
> RFC V3 -> V12:
> 1, Address patch attributions of the patch series
> 
> V12 -> V13
> 1 Based on 5.19-rc2
> 2 Remove arch specified gsi code
> 3 Split some 'common' code into the various drivers where they belong.
> 4 Allow acpi_gsi_to_irq() to have an arch-specific fallback
> 
> V13 -> V14
> 1 Add LoongArch-specified APICs definition
> 2 Use the way in CPUINTC driver to call pch-pic and pch-msi entry
> 3 Fix compiling and regression issue for OF path
> 
> Huacai Chen (8):
>    ACPICA: MADT: Add LoongArch APICs support
>    irqchip: Add Loongson PCH LPC controller support
>    irqchip/loongson-pch-pic: Add ACPI init support
>    irqchip/loongson-pch-msi: Add ACPI init support
>    irqchip/loongson-htvec: Add ACPI init support
>    irqchip/loongson-liointc: Add ACPI init support
>    irqchip: Add Loongson Extended I/O interrupt controller support
>    irqchip: Add LoongArch CPU interrupt controller support
> 
> Jianmin Lv (5):
>    genirq/generic_chip: export irq_unmap_generic_chip
>    LoongArch: Use ACPI_GENERIC_GSI for gsi handling
>    LoongArch: prepare to support multiple pch-pic and pch-msi irqdomain
>    irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC for LoongArch
>    LoongArch: Fix irq number for timer and ipi
> 
> Marc Zyngier (2):
>    APCI: irq: Add support for multiple GSI domains
>    ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback
> 
>   arch/loongarch/Kconfig                      |   1 +
>   arch/loongarch/include/asm/irq.h            |  42 ++-
>   arch/loongarch/kernel/acpi.c                |  65 -----
>   arch/loongarch/kernel/irq.c                 |  45 ++-
>   arch/loongarch/kernel/time.c                |   2 +-
>   arch/mips/include/asm/mach-loongson64/irq.h |   2 +-
>   drivers/acpi/bus.c                          |   3 +
>   drivers/acpi/irq.c                          |  58 ++--
>   drivers/irqchip/Kconfig                     |  28 ++
>   drivers/irqchip/Makefile                    |   3 +
>   drivers/irqchip/irq-gic-v3.c                |  18 +-
>   drivers/irqchip/irq-gic.c                   |  18 +-
>   drivers/irqchip/irq-loongarch-cpu.c         | 169 ++++++++++++
>   drivers/irqchip/irq-loongson-eiointc.c      | 413 ++++++++++++++++++++++++++++
>   drivers/irqchip/irq-loongson-htvec.c        | 145 +++++++---
>   drivers/irqchip/irq-loongson-liointc.c      | 227 ++++++++++-----
>   drivers/irqchip/irq-loongson-pch-lpc.c      | 207 ++++++++++++++
>   drivers/irqchip/irq-loongson-pch-msi.c      | 131 ++++++---
>   drivers/irqchip/irq-loongson-pch-pic.c      | 177 +++++++++---
>   include/acpi/actbl2.h                       | 127 ++++++++-
>   include/linux/acpi.h                        |   4 +-
>   include/linux/cpuhotplug.h                  |   1 +
>   include/linux/irq.h                         |   1 +
>   kernel/irq/generic-chip.c                   |   2 +-
>   24 files changed, 1578 insertions(+), 311 deletions(-)
>   create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
>   create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
>   create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
> 

