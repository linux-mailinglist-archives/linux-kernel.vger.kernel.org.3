Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078E14ADB95
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351788AbiBHOwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiBHOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:52:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2079C061576;
        Tue,  8 Feb 2022 06:52:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C80BB812A8;
        Tue,  8 Feb 2022 14:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39158C340F6;
        Tue,  8 Feb 2022 14:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644331965;
        bh=GXT7yiBPI15AyWn9w7d/ljK4h/t79wwngt2JA9PE0fw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T/Se9cH4WiAjSLc06o9ysGe1pTqhx4946iVFvI/7RvBzZsnKmwJAdr/ylgr+vGtcf
         TQTEMVSiu+Y3voooY0Wq5nieYl3YzCT8Os2TR4nUCRHsJI5W7ZEsyazskzlhHR4bNw
         gt2hV/CViY0AMJ+lXAgzzrjFgJgzElmlyoHt1s7m+hIft5ooyMyrqFRAZZOISM8J8O
         A33Tcmv8FC5Q9ecnMwfKNTSkWtSEGEIPBOjKMdZPM6vSfIblpnxsEJAImWKS1/Psn0
         CS3J/RNvnn/iAfoojyTRGSxuGGaaba53msjFNyrm7c0o/u589rFYMHSo/1Jo+wDmfL
         g0Kr3Lw52G8Ew==
Received: by mail-vk1-f175.google.com with SMTP id v192so9916327vkv.4;
        Tue, 08 Feb 2022 06:52:45 -0800 (PST)
X-Gm-Message-State: AOAM5317MAWoDoDcVwrCq+BX8X81LjVQ8rnQz6RTT1JlYQ4hB0UxSoxT
        FnjDlaRyJ52YggUsKoNZXj9Z+J2wLIpZVKNzDLU=
X-Google-Smtp-Source: ABdhPJzmhDt+vso37Vqb/Up4WrkCrxT3xSDVIziuo+r7z8E+Hq0MRKXuZSCaJpNovG82MH1iETjueZ9d1V/nE2oWZvM=
X-Received: by 2002:a1f:640e:: with SMTP id y14mr1749053vkb.2.1644331964003;
 Tue, 08 Feb 2022 06:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20220126114452.692512-1-apatel@ventanamicro.com>
 <20220126114452.692512-9-apatel@ventanamicro.com> <CAJF2gTQsSn1KBgX2bg2LiSUbCmbGD3oF5KcmK5gq2Dd49BWDBQ@mail.gmail.com>
 <CAAhSdy3Dkv6ga0ZMp5rMFa8nV9EDHgOMBwuJ4z4-w52T8EaUag@mail.gmail.com>
 <CAJF2gTSLmBcgUUE3VGsEq0JCWV74Yy-pkduS66rk=VPVwxk59g@mail.gmail.com> <CAK9=C2WqczG=tH1u9zcLt7Em+fPD1ZZwtDhf1yHJ70-o-HL8OQ@mail.gmail.com>
In-Reply-To: <CAK9=C2WqczG=tH1u9zcLt7Em+fPD1ZZwtDhf1yHJ70-o-HL8OQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 8 Feb 2022 22:52:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSeH6w2Cfr5QEJTJ4ho_B4q3Eo2Xi+R_2yt+7CZCa+WBg@mail.gmail.com>
Message-ID: <CAJF2gTSeH6w2Cfr5QEJTJ4ho_B4q3Eo2Xi+R_2yt+7CZCa+WBg@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for
 QEMU virt machine
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 9:25 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> On Tue, Feb 8, 2022 at 3:47 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Tue, Feb 8, 2022 at 4:54 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Tue, Feb 8, 2022 at 12:16 PM Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > Another question:
> > > >
> > > > Have you put "idle-states {" in qemu's DTS? or how do you test your patches?
> > >
> > > I usually do the following:
> > > 1) Dump QEMU virt machine DTB
> > > 2) Convert QEMU virt machine DTB into DTS
> > > 3) Add "idle-states" in QEMU virt machine DTS
> > > 4) Create QEMU virt machine DTB with "idle-states"
> > > 5) Use the new QEMU virt machine DTB for testing this series.
> > >
> > > Here's one of the DTS files which I used for testing on QEMU virt machine:
> > >
> > > /dts-v1/;
> > >
> > > / {
> > >     #address-cells = <0x02>;
> > >     #size-cells = <0x02>;
> > >     compatible = "riscv-virtio";
> > >     model = "riscv-virtio,qemu";
> > >
> > >     chosen {
> > >         linux,initrd-end = <0x8855d200>;
> > >         linux,initrd-start = <0x88200000>;
> > >         bootargs = "root=/dev/ram rw console=ttyS0 earlycon";
> > >         stdout-path = "/soc/uart@10000000";
> > >     };
> > >
> > >     memory@80000000 {
> > >         device_type = "memory";
> > >         reg = <0x00 0x80000000 0x00 0x10000000>;
> > >     };
> > >
> > >     cpus {
> > >         #address-cells = <0x01>;
> > >         #size-cells = <0x00>;
> > >         timebase-frequency = <0x989680>;
> > >
> > >         cpu@0 {
> > >             phandle = <0x07>;
> > >             device_type = "cpu";
> > >             reg = <0x00>;
> > >             status = "okay";
> > >             compatible = "riscv";
> > >             riscv,isa = "rv64imafdcsu";
> > >             mmu-type = "riscv,sv48";
> > >             cpu-idle-states = <&CPU_NONRET_DEF>;
> > >
> > >             interrupt-controller {
> > >                 #interrupt-cells = <0x01>;
> > >                 interrupt-controller;
> > >                 compatible = "riscv,cpu-intc";
> > >                 phandle = <0x08>;
> > >             };
> > >         };
> > >
> > >         cpu@1 {
> > >             phandle = <0x05>;
> > >             device_type = "cpu";
> > >             reg = <0x01>;
> > >             status = "okay";
> > >             compatible = "riscv";
> > >             riscv,isa = "rv64imafdcsu";
> > >             mmu-type = "riscv,sv48";
> > >             cpu-idle-states = <&CPU_RET_DEF>;
> > >
> > >             interrupt-controller {
> > >                 #interrupt-cells = <0x01>;
> > >                 interrupt-controller;
> > >                 compatible = "riscv,cpu-intc";
> > >                 phandle = <0x06>;
> > >             };
> > >         };
> > >
> > >         cpu@2 {
> > >             phandle = <0x03>;
> > >             device_type = "cpu";
> > >             reg = <0x02>;
> > >             status = "okay";
> > >             compatible = "riscv";
> > >             riscv,isa = "rv64imafdcsu";
> > >             mmu-type = "riscv,sv48";
> > >             cpu-idle-states = <&CPU_NONRET_DEF>;
> > >
> > >             interrupt-controller {
> > >                 #interrupt-cells = <0x01>;
> > >                 interrupt-controller;
> > >                 compatible = "riscv,cpu-intc";
> > >                 phandle = <0x04>;
> > >             };
> > >         };
> > >
> > >         cpu@3 {
> > >             phandle = <0x01>;
> > >             device_type = "cpu";
> > >             reg = <0x03>;
> > >             status = "okay";
> > >             compatible = "riscv";
> > >             riscv,isa = "rv64imafdcsu";
> > >             mmu-type = "riscv,sv48";
> > >             cpu-idle-states = <&CPU_RET_DEF>;
> > >
> > >             interrupt-controller {
> > >                 #interrupt-cells = <0x01>;
> > >                 interrupt-controller;
> > >                 compatible = "riscv,cpu-intc";
> > >                 phandle = <0x02>;
> > >             };
> > >         };
> > >
> > >         cpu-map {
> > >
> > >             cluster0 {
> > >
> > >                 core0 {
> > >                     cpu = <0x07>;
> > >                 };
> > >
> > >                 core1 {
> > >                     cpu = <0x05>;
> > >                 };
> > >
> > >                 core2 {
> > >                     cpu = <0x03>;
> > >                 };
> > >
> > >                 core3 {
> > >                     cpu = <0x01>;
> > >                 };
> > >             };
> > >         };
> > >
> > >         idle-states {
> > >             CPU_RET_DEF: cpu-retentive-default {
> > >                 compatible = "riscv,idle-state";
> > >                 riscv,sbi-suspend-param = <0x00000000>;
> > >                 entry-latency-us = <10>;
> > >                 exit-latency-us = <10>;
> > >                 min-residency-us = <100>;
> > >             };
> > >
> > >             CPU_NONRET_DEF: cpu-nonretentive-default {
> > >                 compatible = "riscv,idle-state";
> > >                 riscv,sbi-suspend-param = <0x80000000>;
> > >                 entry-latency-us = <100>;
> > >                 exit-latency-us = <100>;
> > >                 min-residency-us = <1000>;
> > >             };
> > >         };
> > >     };
> > >
> > >     soc {
> > >         #address-cells = <0x02>;
> > >         #size-cells = <0x02>;
> > >         compatible = "simple-bus";
> > >         ranges;
> > >
> > >         flash@20000000 {
> > >             bank-width = <0x04>;
> > >             reg = <0x00 0x20000000 0x00 0x2000000 0x00 0x22000000 0x00
> > > 0x2000000>;
> > >             compatible = "cfi-flash";
> > >         };
> > >
> > >         rtc@101000 {
> > >             interrupts = <0x0b>;
> > >             interrupt-parent = <0x09>;
> > >             reg = <0x00 0x101000 0x00 0x1000>;
> > >             compatible = "google,goldfish-rtc";
> > >         };
> > >
> > >         uart@10000000 {
> > >             interrupts = <0x0a>;
> > >             interrupt-parent = <0x09>;
> > >             clock-frequency = <0x384000>;
> > >             reg = <0x00 0x10000000 0x00 0x100>;
> > >             compatible = "ns16550a";
> > >         };
> > >
> > >         poweroff {
> > >             value = <0x5555>;
> > >             offset = <0x00>;
> > >             regmap = <0x0a>;
> > >             compatible = "syscon-poweroff";
> > >         };
> > >
> > >         reboot {
> > >             value = <0x7777>;
> > >             offset = <0x00>;
> > >             regmap = <0x0a>;
> > >             compatible = "syscon-reboot";
> > >         };
> > >
> > >         test@100000 {
> > >             phandle = <0x0a>;
> > >             reg = <0x00 0x100000 0x00 0x1000>;
> > >             compatible = "sifive,test1\0sifive,test0\0syscon";
> > >         };
> > >
> > >         pci@30000000 {
> > >             interrupt-map-mask = <0x1800 0x00 0x00 0x07>;
> > >             interrupt-map = <0x00 0x00 0x00 0x01 0x09 0x20 0x00 0x00
> > > 0x00 0x02 0x09 0x21 0x00 0x00 0x00 0x03 0x09 0x22 0x00 0x00 0x00 0x04
> > > 0x09 0x23 0x800 0x00 0x00 0x01 0x09 0x21 0x800 0x00 0x00 0x02 0x09
> > > 0x22 0x800 0x00 0x00 0x03 0x09 0x23 0x800 0x00 0x00 0x04 0x09 0x20
> > > 0x1000 0x00 0x00 0x01 0x09 0x22 0x1000 0x00 0x00 0x02 0x09 0x23 0x1000
> > > 0x00 0x00 0x03 0x09 0x20 0x1000 0x00 0x00 0x04 0x09 0x21 0x1800 0x00
> > > 0x00 0x01 0x09 0x23 0x1800 0x00 0x00 0x02 0x09 0x20 0x1800 0x00 0x00
> > > 0x03 0x09 0x21 0x1800 0x00 0x00 0x04 0x09 0x22>;
> > >             ranges = <0x1000000 0x00 0x00 0x00 0x3000000 0x00 0x10000
> > > 0x2000000 0x00 0x40000000 0x00 0x40000000 0x00 0x40000000>;
> > >             reg = <0x00 0x30000000 0x00 0x10000000>;
> > >             dma-coherent;
> > >             bus-range = <0x00 0xff>;
> > >             linux,pci-domain = <0x00>;
> > >             device_type = "pci";
> > >             compatible = "pci-host-ecam-generic";
> > >             #size-cells = <0x02>;
> > >             #interrupt-cells = <0x01>;
> > >             #address-cells = <0x03>;
> > >         };
> > >
> > >         virtio_mmio@10008000 {
> > >             interrupts = <0x08>;
> > >             interrupt-parent = <0x09>;
> > >             reg = <0x00 0x10008000 0x00 0x1000>;
> > >             compatible = "virtio,mmio";
> > >         };
> > >
> > >         virtio_mmio@10007000 {
> > >             interrupts = <0x07>;
> > >             interrupt-parent = <0x09>;
> > >             reg = <0x00 0x10007000 0x00 0x1000>;
> > >             compatible = "virtio,mmio";
> > >         };
> > >
> > >         virtio_mmio@10006000 {
> > >             interrupts = <0x06>;
> > >             interrupt-parent = <0x09>;
> > >             reg = <0x00 0x10006000 0x00 0x1000>;
> > >             compatible = "virtio,mmio";
> > >         };
> > >
> > >         virtio_mmio@10005000 {
> > >             interrupts = <0x05>;
> > >             interrupt-parent = <0x09>;
> > >             reg = <0x00 0x10005000 0x00 0x1000>;
> > >             compatible = "virtio,mmio";
> > >         };
> > >
> > >         virtio_mmio@10004000 {
> > >             interrupts = <0x04>;
> > >             interrupt-parent = <0x09>;
> > >             reg = <0x00 0x10004000 0x00 0x1000>;
> > >             compatible = "virtio,mmio";
> > >         };
> > >
> > >         virtio_mmio@10003000 {
> > >             interrupts = <0x03>;
> > >             interrupt-parent = <0x09>;
> > >             reg = <0x00 0x10003000 0x00 0x1000>;
> > >             compatible = "virtio,mmio";
> > >         };
> > >
> > >         virtio_mmio@10002000 {
> > >             interrupts = <0x02>;
> > >             interrupt-parent = <0x09>;
> > >             reg = <0x00 0x10002000 0x00 0x1000>;
> > >             compatible = "virtio,mmio";
> > >         };
> > >
> > >         virtio_mmio@10001000 {
> > >             interrupts = <0x01>;
> > >             interrupt-parent = <0x09>;
> > >             reg = <0x00 0x10001000 0x00 0x1000>;
> > >             compatible = "virtio,mmio";
> > >         };
> > >
> > >         plic@c000000 {
> > >             phandle = <0x09>;
> > >             riscv,ndev = <0x35>;
> > >             reg = <0x00 0xc000000 0x00 0x210000>;
> > >             interrupts-extended = <0x08 0x0b 0x08 0x09 0x06 0x0b 0x06
> > > 0x09 0x04 0x0b 0x04 0x09 0x02 0x0b 0x02 0x09>;
> > >             interrupt-controller;
> > >             compatible = "riscv,plic0";
> > >             #interrupt-cells = <0x01>;
> > >             #address-cells = <0x00>;
> > >         };
> > >
> > >         clint@2000000 {
> > >             interrupts-extended = <0x08 0x03 0x08 0x07 0x06 0x03 0x06
> > > 0x07 0x04 0x03 0x04 0x07 0x02 0x03 0x02 0x07>;
> > >             reg = <0x00 0x2000000 0x00 0x10000>;
> > >             compatible = "riscv,clint0";
> > >         };
> > >     };
> > > };
> >
> > Thx Anup, but it still couldn't work for testing suspend.
> >
> > # echo mem > /sys/power/state
> > sh: write error: Function not implemented
> >
> > Why there is no ARCH_SUSPEND_POSSIBLE in the patch series?
>
> You are referring to system-level suspend to RAM support whereas
> this series adds CPU idle power management support.
Right.

>
> Adding system-level suspend to RAM will be a separate series
> and it will re-use the non-retentive suspend infrastructure added
> by this series.
Do you have the plan for the feature of SUSPEND? I think you've done
the core part by this series.

In the end, thx for the work :)

>
> Regards,
> Anup
>
> >
> > ref arm64's:
> > commit 166936bace056dfc11452d794209f39a5e9b0fb4
> > Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Date:   Thu Nov 7 18:37:14 2013 +0000
> >
> >     arm64: kernel: add PM build infrastructure
> >
> >     This patch adds the required makefile and kconfig entries to enable PM
> >     for arm64 systems.
> >
> >     The kernel relies on the cpu_{suspend}/{resume} infrastructure to
> >     properly save the context for a CPU and put it to sleep, hence this
> >     patch adds the config option required to enable cpu_{suspend}/{resume}
> >     API.
> >
> >     In order to rely on the CPU PM implementation for saving and restoring
> >     of CPU subsystems like GIC and PMU, the arch Kconfig must be also
> >     augmented to select the CONFIG_CPU_PM option when SUSPEND or CPU_IDLE
> >     kernel implementations are selected.
> >
> > >
> > > Regards,
> > > Anup
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
