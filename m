Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046614AD417
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352271AbiBHIyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiBHIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:54:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C245AC03FEC5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:54:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k18so29362197wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ad/AIeKw/gggP6Br2uoykBbNKFVMSxSNAtQyiBt1RW0=;
        b=5KxMGJIrZxz0UdJJ4KFG3h5rV0PZviBM1D2ZlImvgl2AYSR7uVDIp9FOmugYxXR0jd
         /uG/+J603tKg3P37pGqHHlbr3fFTWLeZiT1w6+erAhedOqoJk8L3BOwALYuFUkgt9rFv
         jQiGMsXhV5QujyODOTCAMmYW8e/ggOnHL5d6jTVn1If8szV5+b8LHzdFdowkrSUMEWah
         jPTmEQXdKOuovazsDjAlCKdIyJVrK45UjaRmuw4mwTheKA34Yrm9QDVifKZ9hcVLF1Go
         vZJYetHiq9fRPxQVsdpQnn9p5KE/Ol1buMRKZZWhAVmq4hbRovF1sdC/5fDZhn2tpOSm
         5hLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ad/AIeKw/gggP6Br2uoykBbNKFVMSxSNAtQyiBt1RW0=;
        b=zvIScZptmZCLpLfdBN5kUdKy6kelj1Gs2T/HXPIyz75LkTMv0NCCWUy4w1dmBHVKl5
         0ykP+T/XMa2CNFJg2hm+Ixyj5Wy6vyDVqaNusLyq6dGYNiCYallLRXMnv9uGfT5cJ6rr
         Q/L3q79dpSQ+Q9O0JVufz2xBBzU5sIsV+M6N8e7tpX7zad08TWuBgcXVq5UFZAOCXNq7
         WFkE7YbcOqLYLRNsVYE4Jcid38+3283LYFzAsaIYyMXeX3SUnEq4Qq2D/vEYXSxqUbiP
         o3bb1gnwLaPZ9pvI3efM0numFsyUGP3ipZM+zkO2Sq5ghD0iqfzb49ebHDhWX/y0fFtF
         ygGA==
X-Gm-Message-State: AOAM530OjegXAcNP4tRkOw1aNZHtTFxkR7S6Z21v8V9CNLpwUs2hysJn
        uq/sXVl0Mdp/Mm1bvkZdYaFHMEs4rkVBEhenWem8+Q==
X-Google-Smtp-Source: ABdhPJzgSop4y+Hsg6mK+sVfvqbbliyC19eTL7sLF/m+UVhe/JN/7WOPjVFLYB6Xxfkqx+mpiM4ybuPoWNgcPTqKJbA=
X-Received: by 2002:adf:bc44:: with SMTP id a4mr2655518wrh.346.1644310456139;
 Tue, 08 Feb 2022 00:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20220126114452.692512-1-apatel@ventanamicro.com>
 <20220126114452.692512-9-apatel@ventanamicro.com> <CAJF2gTQsSn1KBgX2bg2LiSUbCmbGD3oF5KcmK5gq2Dd49BWDBQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQsSn1KBgX2bg2LiSUbCmbGD3oF5KcmK5gq2Dd49BWDBQ@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 8 Feb 2022 14:24:04 +0530
Message-ID: <CAAhSdy3Dkv6ga0ZMp5rMFa8nV9EDHgOMBwuJ4z4-w52T8EaUag@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for
 QEMU virt machine
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 12:16 PM Guo Ren <guoren@kernel.org> wrote:
>
> Another question:
>
> Have you put "idle-states {" in qemu's DTS? or how do you test your patches?

I usually do the following:
1) Dump QEMU virt machine DTB
2) Convert QEMU virt machine DTB into DTS
3) Add "idle-states" in QEMU virt machine DTS
4) Create QEMU virt machine DTB with "idle-states"
5) Use the new QEMU virt machine DTB for testing this series.

Here's one of the DTS files which I used for testing on QEMU virt machine:

/dts-v1/;

/ {
    #address-cells = <0x02>;
    #size-cells = <0x02>;
    compatible = "riscv-virtio";
    model = "riscv-virtio,qemu";

    chosen {
        linux,initrd-end = <0x8855d200>;
        linux,initrd-start = <0x88200000>;
        bootargs = "root=/dev/ram rw console=ttyS0 earlycon";
        stdout-path = "/soc/uart@10000000";
    };

    memory@80000000 {
        device_type = "memory";
        reg = <0x00 0x80000000 0x00 0x10000000>;
    };

    cpus {
        #address-cells = <0x01>;
        #size-cells = <0x00>;
        timebase-frequency = <0x989680>;

        cpu@0 {
            phandle = <0x07>;
            device_type = "cpu";
            reg = <0x00>;
            status = "okay";
            compatible = "riscv";
            riscv,isa = "rv64imafdcsu";
            mmu-type = "riscv,sv48";
            cpu-idle-states = <&CPU_NONRET_DEF>;

            interrupt-controller {
                #interrupt-cells = <0x01>;
                interrupt-controller;
                compatible = "riscv,cpu-intc";
                phandle = <0x08>;
            };
        };

        cpu@1 {
            phandle = <0x05>;
            device_type = "cpu";
            reg = <0x01>;
            status = "okay";
            compatible = "riscv";
            riscv,isa = "rv64imafdcsu";
            mmu-type = "riscv,sv48";
            cpu-idle-states = <&CPU_RET_DEF>;

            interrupt-controller {
                #interrupt-cells = <0x01>;
                interrupt-controller;
                compatible = "riscv,cpu-intc";
                phandle = <0x06>;
            };
        };

        cpu@2 {
            phandle = <0x03>;
            device_type = "cpu";
            reg = <0x02>;
            status = "okay";
            compatible = "riscv";
            riscv,isa = "rv64imafdcsu";
            mmu-type = "riscv,sv48";
            cpu-idle-states = <&CPU_NONRET_DEF>;

            interrupt-controller {
                #interrupt-cells = <0x01>;
                interrupt-controller;
                compatible = "riscv,cpu-intc";
                phandle = <0x04>;
            };
        };

        cpu@3 {
            phandle = <0x01>;
            device_type = "cpu";
            reg = <0x03>;
            status = "okay";
            compatible = "riscv";
            riscv,isa = "rv64imafdcsu";
            mmu-type = "riscv,sv48";
            cpu-idle-states = <&CPU_RET_DEF>;

            interrupt-controller {
                #interrupt-cells = <0x01>;
                interrupt-controller;
                compatible = "riscv,cpu-intc";
                phandle = <0x02>;
            };
        };

        cpu-map {

            cluster0 {

                core0 {
                    cpu = <0x07>;
                };

                core1 {
                    cpu = <0x05>;
                };

                core2 {
                    cpu = <0x03>;
                };

                core3 {
                    cpu = <0x01>;
                };
            };
        };

        idle-states {
            CPU_RET_DEF: cpu-retentive-default {
                compatible = "riscv,idle-state";
                riscv,sbi-suspend-param = <0x00000000>;
                entry-latency-us = <10>;
                exit-latency-us = <10>;
                min-residency-us = <100>;
            };

            CPU_NONRET_DEF: cpu-nonretentive-default {
                compatible = "riscv,idle-state";
                riscv,sbi-suspend-param = <0x80000000>;
                entry-latency-us = <100>;
                exit-latency-us = <100>;
                min-residency-us = <1000>;
            };
        };
    };

    soc {
        #address-cells = <0x02>;
        #size-cells = <0x02>;
        compatible = "simple-bus";
        ranges;

        flash@20000000 {
            bank-width = <0x04>;
            reg = <0x00 0x20000000 0x00 0x2000000 0x00 0x22000000 0x00
0x2000000>;
            compatible = "cfi-flash";
        };

        rtc@101000 {
            interrupts = <0x0b>;
            interrupt-parent = <0x09>;
            reg = <0x00 0x101000 0x00 0x1000>;
            compatible = "google,goldfish-rtc";
        };

        uart@10000000 {
            interrupts = <0x0a>;
            interrupt-parent = <0x09>;
            clock-frequency = <0x384000>;
            reg = <0x00 0x10000000 0x00 0x100>;
            compatible = "ns16550a";
        };

        poweroff {
            value = <0x5555>;
            offset = <0x00>;
            regmap = <0x0a>;
            compatible = "syscon-poweroff";
        };

        reboot {
            value = <0x7777>;
            offset = <0x00>;
            regmap = <0x0a>;
            compatible = "syscon-reboot";
        };

        test@100000 {
            phandle = <0x0a>;
            reg = <0x00 0x100000 0x00 0x1000>;
            compatible = "sifive,test1\0sifive,test0\0syscon";
        };

        pci@30000000 {
            interrupt-map-mask = <0x1800 0x00 0x00 0x07>;
            interrupt-map = <0x00 0x00 0x00 0x01 0x09 0x20 0x00 0x00
0x00 0x02 0x09 0x21 0x00 0x00 0x00 0x03 0x09 0x22 0x00 0x00 0x00 0x04
0x09 0x23 0x800 0x00 0x00 0x01 0x09 0x21 0x800 0x00 0x00 0x02 0x09
0x22 0x800 0x00 0x00 0x03 0x09 0x23 0x800 0x00 0x00 0x04 0x09 0x20
0x1000 0x00 0x00 0x01 0x09 0x22 0x1000 0x00 0x00 0x02 0x09 0x23 0x1000
0x00 0x00 0x03 0x09 0x20 0x1000 0x00 0x00 0x04 0x09 0x21 0x1800 0x00
0x00 0x01 0x09 0x23 0x1800 0x00 0x00 0x02 0x09 0x20 0x1800 0x00 0x00
0x03 0x09 0x21 0x1800 0x00 0x00 0x04 0x09 0x22>;
            ranges = <0x1000000 0x00 0x00 0x00 0x3000000 0x00 0x10000
0x2000000 0x00 0x40000000 0x00 0x40000000 0x00 0x40000000>;
            reg = <0x00 0x30000000 0x00 0x10000000>;
            dma-coherent;
            bus-range = <0x00 0xff>;
            linux,pci-domain = <0x00>;
            device_type = "pci";
            compatible = "pci-host-ecam-generic";
            #size-cells = <0x02>;
            #interrupt-cells = <0x01>;
            #address-cells = <0x03>;
        };

        virtio_mmio@10008000 {
            interrupts = <0x08>;
            interrupt-parent = <0x09>;
            reg = <0x00 0x10008000 0x00 0x1000>;
            compatible = "virtio,mmio";
        };

        virtio_mmio@10007000 {
            interrupts = <0x07>;
            interrupt-parent = <0x09>;
            reg = <0x00 0x10007000 0x00 0x1000>;
            compatible = "virtio,mmio";
        };

        virtio_mmio@10006000 {
            interrupts = <0x06>;
            interrupt-parent = <0x09>;
            reg = <0x00 0x10006000 0x00 0x1000>;
            compatible = "virtio,mmio";
        };

        virtio_mmio@10005000 {
            interrupts = <0x05>;
            interrupt-parent = <0x09>;
            reg = <0x00 0x10005000 0x00 0x1000>;
            compatible = "virtio,mmio";
        };

        virtio_mmio@10004000 {
            interrupts = <0x04>;
            interrupt-parent = <0x09>;
            reg = <0x00 0x10004000 0x00 0x1000>;
            compatible = "virtio,mmio";
        };

        virtio_mmio@10003000 {
            interrupts = <0x03>;
            interrupt-parent = <0x09>;
            reg = <0x00 0x10003000 0x00 0x1000>;
            compatible = "virtio,mmio";
        };

        virtio_mmio@10002000 {
            interrupts = <0x02>;
            interrupt-parent = <0x09>;
            reg = <0x00 0x10002000 0x00 0x1000>;
            compatible = "virtio,mmio";
        };

        virtio_mmio@10001000 {
            interrupts = <0x01>;
            interrupt-parent = <0x09>;
            reg = <0x00 0x10001000 0x00 0x1000>;
            compatible = "virtio,mmio";
        };

        plic@c000000 {
            phandle = <0x09>;
            riscv,ndev = <0x35>;
            reg = <0x00 0xc000000 0x00 0x210000>;
            interrupts-extended = <0x08 0x0b 0x08 0x09 0x06 0x0b 0x06
0x09 0x04 0x0b 0x04 0x09 0x02 0x0b 0x02 0x09>;
            interrupt-controller;
            compatible = "riscv,plic0";
            #interrupt-cells = <0x01>;
            #address-cells = <0x00>;
        };

        clint@2000000 {
            interrupts-extended = <0x08 0x03 0x08 0x07 0x06 0x03 0x06
0x07 0x04 0x03 0x04 0x07 0x02 0x03 0x02 0x07>;
            reg = <0x00 0x2000000 0x00 0x10000>;
            compatible = "riscv,clint0";
        };
    };
};

Regards,
Anup
