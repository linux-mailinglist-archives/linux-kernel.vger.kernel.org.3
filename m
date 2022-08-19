Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520315996CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347502AbiHSIKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347495AbiHSIKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:10:31 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E27E58AE;
        Fri, 19 Aug 2022 01:10:30 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id o184so4012255oif.13;
        Fri, 19 Aug 2022 01:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MAnXagYjiuWeDTJ+i5sfMrFcvpfp6NbedVvWmTP//ek=;
        b=lCM/2BfDI9fMx9bZOIBXuGWgIhcks+/S/ZSRrLcGGPb1ftzGdgKdj5Cm1zXfEKLhZd
         CzHgZtfb7cjhVo7Qf39sRwKtFcdtjLtRSmu4/k803LdQKRHGk0NqqqNqP8KKym7mmcEV
         8XLz4J3uYeWoeeRxcYalYAq3NW4a8dr/WHJoL/Ks5ekqEbAygXJvbOihrsAVow1b9IyC
         Vg64VWIRmCEGxzSLRSiPEK5yX1CLjBymaNU3tRg1dnnKrUDkTCYJUCSUnTguFSiODInU
         7RpY2+Rvby5Jiayb+cYAEu8VX9GsXTIqB4SY8gl5ScOdnonm+LpZbd+nLITCullfOybx
         Z2uw==
X-Gm-Message-State: ACgBeo0pPqBkZGpiYH8WtbYPoDWwzy/RUl71pXKoiFVULnByIvU5aJ6y
        tcBCfHM3e1uevvQ75Q7pbhMomWVrbEnutw==
X-Google-Smtp-Source: AA6agR7A9WyMPeyvQMiwkFaveWR0vJd18jmBG3YEgXbPciriUywaUyjK7ZCf+tLFcrUAdAbIT1OJUA==
X-Received: by 2002:a05:6808:220c:b0:343:7801:11b3 with SMTP id bd12-20020a056808220c00b00343780111b3mr4998967oib.64.1660896629845;
        Fri, 19 Aug 2022 01:10:29 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id o12-20020a056870910c00b0010bf07976c9sm1101687oae.41.2022.08.19.01.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:10:29 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id m21-20020a9d6ad5000000b00638df677850so2633244otq.5;
        Fri, 19 Aug 2022 01:10:29 -0700 (PDT)
X-Received: by 2002:a0d:eb45:0:b0:333:f813:6c79 with SMTP id
 u66-20020a0deb45000000b00333f8136c79mr6390139ywe.384.1660896295663; Fri, 19
 Aug 2022 01:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220815151451.23293-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Aug 2022 10:04:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXHSMcrVOH+vcrdRRF+i2TkMcFisGxHMBPUEa8nTMFpzw@mail.gmail.com>
Message-ID: <CAMuHMdXHSMcrVOH+vcrdRRF+i2TkMcFisGxHMBPUEa8nTMFpzw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhalar,

On Mon, Aug 15, 2022 at 5:17 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
> Single).
>
> Below is the list of IP blocks added in the initial SoC DTSI which can be
> used to boot via initramfs on RZ/Five SMARC EVK:
> - AX45MP CPU
> - CPG
> - PINCTRL
> - PLIC
> - SCIF0
> - SYSC
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the RZ/Five SoC

My first thought was:

    This should be arch/riscv/boot/dts/renesas/r9a07g043f01.dtsi,
     including the common r9a07g043.dtsi, shared by
     arch/arm64/boot/dts/renesas/r9a07g043u11.dtsi.

Then I realized this is harder than it sounds, due:

> +       soc: soc {
> +               compatible = "simple-bus";
> +               interrupt-parent = <&plic>;

vs. "interrupt-parent = <&plic>;" for r9a07g043u11, but mostly
due to

> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               scif0: serial@1004b800 {
> +                       compatible = "renesas,scif-r9a07g043",
> +                                    "renesas,scif-r9a07g044";
> +                       reg = <0 0x1004b800 0 0x400>;
> +                       interrupts = <412 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <414 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <415 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <413 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <416 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <416 IRQ_TYPE_LEVEL_HIGH>;

vs. "interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH> ..." on
r9a07g043u11.
Interestingly, the actual hardware interrupt numbers are the same,
but the GIC DT bindings abstracts the offset of 32 by using a second
cell and GIC_SPI.  Unfortunately this cannot be handled by some CPP
magic, as dtc does not support arithmetic operations yet.

I expect this or similar issues to pop up everywhere, when more
RISCV-V SoCs will appear that share the non-CPU parts with ARM SoCs.

Ignoring this issue, which we probably can solve only later:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
