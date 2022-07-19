Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55E0578F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiGSBMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGSBM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:12:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCE833E27
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EC79CE179E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78757C385A2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658193144;
        bh=YKkiE/VLO1FeayfE/5C9Y+mvRT2Ipfor0z06Bp9jPZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z/bS+m61IY2N0YASX2657483WBu3UFJU1E8FkRfuQxJOF7lEl65vsEJDs8wf4Hwff
         qB0ef2wLyLHSwddz9oHfzADmTZEgjLO9qTOs9Ay3GwTQrN/OTG7qlOOoiBhu05qoPy
         FOTiRqMvU21pFI67RlHAhsT3D5ddLijJIshoqD6n7rryQIELMZt3q1Zeskw/lYGR+1
         tCR+/stfwPYzUGf0dHJYAbgsDfHG8ZuvbtFLxmu5vibooV27+V/vTIIvrnDSuJJH7/
         EbXQRmoKAmFd7/sh3riGH3rj7x1yW009H/wHN4AMWI69n5bNkVGlkyBDSFa5h0/sbY
         aT4TIGCmXvTfg==
Received: by mail-ua1-f52.google.com with SMTP id y11so6197347uae.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:12:24 -0700 (PDT)
X-Gm-Message-State: AJIora9imewz05B8bXbbmyQvzLhacIjeTjRd0aL0Ft/6aTUmkrQ+EtIN
        RZctaylR4mAK8DmEDxp6/xGRcy0d/MRiTG7v81E=
X-Google-Smtp-Source: AGRyM1tCVEukUntc49lj36y9OjuhrdnxaL63fysFOyHfJHPzVkgZfzDwslYyJ+JEJqyhZ0oVE/LqN5i7Gif5ZHIo0Lw=
X-Received: by 2002:a9f:3253:0:b0:383:c330:68 with SMTP id y19-20020a9f3253000000b00383c3300068mr7159435uad.104.1658193143299;
 Mon, 18 Jul 2022 18:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
In-Reply-To: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 19 Jul 2022 09:12:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7nBO9_9q0Oca-6i-0s5y1Ao1=8nWcXEzdhh5=Zd5nk8Q@mail.gmail.com>
Message-ID: <CAAhV-H7nBO9_9q0Oca-6i-0s5y1Ao1=8nWcXEzdhh5=Zd5nk8Q@mail.gmail.com>
Subject: Re: [PATCH V16 00/14] irqchip: Add LoongArch-related irqchip drivers
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc and Jianmin,

I will do an integrated test today (together with the arch code and
pci code), and give feedback as soon as possible.

Huacai

On Mon, Jul 18, 2022 at 10:14 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
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
> Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller), PCH-P=
IC
> (Main Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Contr=
oller
> in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
>
> CPUINTC is a per-core controller (in CPU), LIOINTC/EIOINTC are
> per-package controllers (in CPU), while PCH-PIC/PCH-LPC/PCH-MSI are all
> controllers out of CPU (i.e., in chipsets). These controllers (in other
> words, irqchips) are linked in a hierarchy way.
>
> The IPI (Inter-Processor Interrupt) and CPU Local Timer
> interrupt go to CPUINTC directly, CPU UARTS interrupts go to LIOINTC,
> while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and
> gathered by EIOINTC, and then go to to CPUINTC directly.
>
>  +--------------------------------------------------------+
>  |                                                        |
>  |         +-----+     +---------+     +-------+          |
>  |         | IPI | --> | CPUINTC | <-- | Timer |          |
>  |         +-----+     +---------+     +-------+          |
>  |                      ^       ^                         |
>  |                      |       |                         |
>  |               +---------+ +---------+     +-------+    |
>  |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
>  |               +---------+ +---------+     +-------+    |
>  |                ^       ^                               |
>  |                |       |                               |
>  |         +---------+ +---------+                        |
>  |         | PCH-PIC | | PCH-MSI |                        |
>  |         +---------+ +---------+                        |
>  |           ^     ^           ^                          |
>  |           |     |           |                          |
>  |   +---------+ +---------+ +---------+                  |
>  |   | PCH-LPC | | Devices | | Devices |                  |
>  |   +---------+ +---------+ +---------+                  |
>  |        ^                                               |
>  |        |                                               |
>  |   +---------+                                          |
>  |   | Devices |                                          |
>  |   +---------+                                          |
>  |                                                        |
>  |                                                        |
>  +--------------------------------------------------------+
>
> The hierarchy model is constructed by parsing irq contronler structures
> in MADT.
>
> Example of irqchip topology in a system with  two chipsets:
>
>  +------------------------------------------------------------+
>  |                                                            |
>  |                     +------------------+                   |
>  |                     |      CPUINTC     |                   |
>  |                     +------------------+                   |
>  |                     ^                  ^                   |
>  |                     |                  |                   |
>  |          +----------+                  +----------+        |
>  |          | EIOINTC 0|                  | EIOINTC 1|        |
>  |          +----------+                  +----------+        |
>  |          ^          ^                  ^          ^        |
>  |          |          |                  |          |        |
>  | +----------+   +----------+   +----------+    +----------+ |
>  | | PCH-PIC 0|   | PCH-MSI 0|   | PCH-PIC 1|    | PCH-MSI 1| |
>  | +----------+   +----------+   +----------+    +----------+ |
>  |                                                            |
>  |                                                            |
>  +------------------------------------------------------------+
>
> For systems with two chipsets, there are tow group(consists of EIOINTC, P=
CH-PIC and PCH-MSI) irqdomains,
> and each group has same node id. So we defined a structure to mantain the=
 relation of node and it's parent irqdomain.
>
> struct acpi_vector_group {
>         int node;
>         int pci_segment;
>         struct irq_domain *parent;
> };
>
> The initialization and use of acpi_vector_group array are following:
>
> 1 Entry of struct acpi_vector_group array initialization:
>
> By parsing MCFG, the node id=EF=BC=88from bit44-47 of Base Address=EF=BC=
=89and pci segment are extracted. And from MADT, we have the node id of eac=
h EIOINTC.
>
> entry.node =3D node id of pci segment
> entry.pci_segment =3D pci segment (only for msi irqdomain)
>
> By matching node id of entry and EIOINTC to set parent.
>
> entry.parent =3D EIOINTC irqdomain(node id of EIOINTC =3D=3D node id of p=
ci segment)
>
> 2 Get parent irqdomain for PCH-PIC:
>
> From MADT, we have the node id of each PCH-PIC(from bit44-47 of Base Addr=
ess).
> if (node of entry i =3D=3D node of PCH-PIC)
>         return entrys[i].parent;
>
> 3 Get parent irqdomain for PCH-MSI of pci segment:
>
>         return entrys[i].parent; (i is the index of msi irqdomain)
>
> 4 How to select a correct irqdomain to map irq for a device?
> For devices using legacy irq behind PCH-PIC, GSI is used to select correc=
t PCH-PIC irqdomain.
> For devices using msi irq behind PCH-MSI, the pci segmen of the device is=
 used to select correct PCH-MSI irqdomain.
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
> 1, Move all IO-interrupt related code to driver/irqchip from arch directo=
ry.
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
> V14 -> V15
> 1 Expose fwnode_handle of CPUINTC domain instead of using get_xxx_irq() f=
or CPUINTC driver
> 2 Fix EIOINTC driver: delete parent_data referencing and fix set_affinity=
 bug
> 3 Use acpi_disabled for DT and ACPI runtime code path
> 4 Fix return type of arch-specific acpi_gsi_to_irq fallback
> 5 Fix compile bug tested by kernel test robot
>
> V15 -> V16
>
> 1 Merge entry function to make code simpler for cpuintc driver
> 2 Provisionally add ACPICA data structures
> 3 Drop "Legacy" model support
> 4 Fix compiling error
>
> Huacai Chen (7):
>   irqchip: Add Loongson PCH LPC controller support
>   irqchip: remove COMPILE_TEST for pch-pic and pch-msi
>   irqchip/loongson-pch-pic: Add ACPI init support
>   irqchip/loongson-pch-msi: Add ACPI init support
>   irqchip/loongson-liointc: Add ACPI init support
>   irqchip: Add Loongson Extended I/O interrupt controller support
>   irqchip: Add LoongArch CPU interrupt controller support
>
> Jianmin Lv (4):
>   genirq/generic_chip: export irq_unmap_generic_chip
>   LoongArch: Use ACPI_GENERIC_GSI for gsi handling
>   LoongArch: prepare to support multiple pch-pic and pch-msi irqdomain
>   irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC for LoongArch
>
> Marc Zyngier (3):
>   LoongArch: Provisionally add ACPICA data structures
>   APCI: irq: Add support for multiple GSI domains
>   ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback
>
>  arch/loongarch/Kconfig                      |   1 +
>  arch/loongarch/include/asm/acpi.h           | 142 ++++++++++
>  arch/loongarch/include/asm/irq.h            |  51 ++--
>  arch/loongarch/kernel/acpi.c                |  65 -----
>  arch/loongarch/kernel/irq.c                 |  57 +++-
>  arch/loongarch/kernel/time.c                |  14 +-
>  arch/mips/include/asm/mach-loongson64/irq.h |   2 +-
>  drivers/acpi/bus.c                          |   3 +
>  drivers/acpi/irq.c                          |  58 ++--
>  drivers/irqchip/Kconfig                     |  32 ++-
>  drivers/irqchip/Makefile                    |   3 +
>  drivers/irqchip/irq-gic-v3.c                |  18 +-
>  drivers/irqchip/irq-gic.c                   |  18 +-
>  drivers/irqchip/irq-loongarch-cpu.c         | 150 +++++++++++
>  drivers/irqchip/irq-loongson-eiointc.c      | 395 ++++++++++++++++++++++=
++++++
>  drivers/irqchip/irq-loongson-liointc.c      | 207 +++++++++------
>  drivers/irqchip/irq-loongson-pch-lpc.c      | 208 +++++++++++++++
>  drivers/irqchip/irq-loongson-pch-msi.c      | 131 ++++++---
>  drivers/irqchip/irq-loongson-pch-pic.c      | 178 ++++++++++---
>  include/linux/acpi.h                        |   4 +-
>  include/linux/cpuhotplug.h                  |   1 +
>  include/linux/irq.h                         |   1 +
>  kernel/irq/generic-chip.c                   |   2 +-
>  23 files changed, 1463 insertions(+), 278 deletions(-)
>  create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
>  create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
>  create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
>
> --
> 1.8.3.1
>
>
