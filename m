Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE78D4D92D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiCODKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbiCODKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:10:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C473F12771
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:09:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso717509wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YlAUUoV15oIq0bfUkEEQvam2TX7UDNlQRyUb6o8Uzlc=;
        b=3D0/VuzRE5jVE1gU0WP/Oy/EhATOtCMCyTpruJzRr8ydYVT0gTX/boRnslD4WQy256
         pY16gkSplQ4WewRozBZ6bp3Rsh97puqjVxsahRK/RJKAWgQdH2Jper+1W6hIqF0sB4MV
         pYPh/XG4b9G6cwrtClJq0co3NTwj/1JolR5lihHLRvKUXUp74PAmn5SgCQ9YDFJFR31z
         WRsxDRbkQk3nn6V6nC1+rk/13pI48GkNP4cGiNOAV5i9FhsQXTL0Xix+GUQgBtLA8nnH
         tuux+3XqjRSlbwacu9iNpov5T3uRPFHY2j1uyz5AHHLunssgnHKYEYzhIu3E4OCDxHxc
         GkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlAUUoV15oIq0bfUkEEQvam2TX7UDNlQRyUb6o8Uzlc=;
        b=Jsri+rsgEMBHPAVdu+RbS1StyqIRRoenyXfnvJYqEiwieCdExEFwXFOom8QS4/rUO9
         JMz7AJW6J06qZeGL2dOfHVDgd0Hkz4gE4FEQ2LOhh6OGvHcSpqfTGtPVTss04zirEFar
         QFwHEeIPxkizSDfEoD/6LDpIqtvtt2crU5uzuNdpQHwglCpg1YJmN8NPwiBRYOn9lusA
         eoG9oblNzng7AI5fSYiDvsOa0/c+Zr8MIDI/LayTGZE/G2fR0iQn7UOVRx1KdOc657cv
         +hQhUVEPy3HNso2F0JTeiPtlOTV7dLVJmOkV9Uei693BwzfImJZmAVQ3317dcokzRwdp
         Sxhg==
X-Gm-Message-State: AOAM5339tsW6Ux/tVOHDwJSpHjpDxV7GjX8EhSk5XSTcg1U9vP7YO48J
        bnZhhDw5mWupPX1hAvlPT7Gw6urvV6KeLIsH55DeBQ==
X-Google-Smtp-Source: ABdhPJyCnZeApAQIeIu9ckLEshUmzpf0Q/365p7fKRUenQLTUKelNGht6AV1uZDc+vfVxlqgydvi7TWz1k4R/1KWIPg=
X-Received: by 2002:a05:600c:2c49:b0:384:7202:358e with SMTP id
 r9-20020a05600c2c4900b003847202358emr1556102wmg.108.1647313739201; Mon, 14
 Mar 2022 20:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220314203845.832648-1-atishp@rivosinc.com> <20220314203845.832648-3-atishp@rivosinc.com>
In-Reply-To: <20220314203845.832648-3-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 15 Mar 2022 08:38:46 +0530
Message-ID: <CAAhSdy1Fw3Ykfkkxb-0S=Nmd=fGcQuK8yCRRGF2pTnMDRgCroQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] RISC-V: Minimal parser for "riscv, isa" strings
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 2:09 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> From: Tsukasa OI <research_trasio@irq.a4lg.com>
>
> Current hart ISA ("riscv,isa") parser don't correctly parse:
>
> 1. Multi-letter extensions
> 2. Version numbers
>
> All ISA extensions ratified recently has multi-letter extensions
> (except 'H'). The current "riscv,isa" parser that is easily confused
> by multi-letter extensions and "p" in version numbers can be a huge
> problem for adding new extensions through the device tree.
>
> Leaving it would create incompatible hacks and would make "riscv,isa"
> value unreliable.
>
> This commit implements minimal parser for "riscv,isa" strings.  With this,
> we can safely ignore multi-letter extensions and version numbers.
>
> [Improved commit text and fixed a bug around 's' in base extension]
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> [Fixed workaround for QEMU]
> Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

I think I have reviewed most of the patches in this series.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/cpufeature.c | 72 ++++++++++++++++++++++++++++------
>  1 file changed, 61 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index dd3d57eb4eea..72c5f6ef56b5 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/bitmap.h>
> +#include <linux/ctype.h>
>  #include <linux/of.h>
>  #include <asm/processor.h>
>  #include <asm/hwcap.h>
> @@ -66,7 +67,7 @@ void __init riscv_fill_hwcap(void)
>         struct device_node *node;
>         const char *isa;
>         char print_str[NUM_ALPHA_EXTS + 1];
> -       size_t i, j, isa_len;
> +       int i, j;
>         static unsigned long isa2hwcap[256] = {0};
>
>         isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
> @@ -92,23 +93,72 @@ void __init riscv_fill_hwcap(void)
>                         continue;
>                 }
>
> -               i = 0;
> -               isa_len = strlen(isa);
>  #if IS_ENABLED(CONFIG_32BIT)
>                 if (!strncmp(isa, "rv32", 4))
> -                       i += 4;
> +                       isa += 4;
>  #elif IS_ENABLED(CONFIG_64BIT)
>                 if (!strncmp(isa, "rv64", 4))
> -                       i += 4;
> +                       isa += 4;
>  #endif
> -               for (; i < isa_len; ++i) {
> -                       this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
> +               for (; *isa; ++isa) {
> +                       const char *ext = isa++;
> +                       const char *ext_end = isa;
> +                       bool ext_long = false, ext_err = false;
> +
> +                       switch (*ext) {
> +                       case 's':
> +                               /**
> +                                * Workaround for invalid single-letter 's' & 'u'(QEMU).
> +                                * No need to set the bit in riscv_isa as 's' & 'u' are
> +                                * not valid ISA extensions. It works until multi-letter
> +                                * extension starting with "Su" appears.
> +                                */
> +                               if (ext[-1] != '_' && ext[1] == 'u') {
> +                                       ++isa;
> +                                       ext_err = true;
> +                                       break;
> +                               }
> +                               fallthrough;
> +                       case 'x':
> +                       case 'z':
> +                               ext_long = true;
> +                               /* Multi-letter extension must be delimited */
> +                               for (; *isa && *isa != '_'; ++isa)
> +                                       if (!islower(*isa) && !isdigit(*isa))
> +                                               ext_err = true;
> +                               break;
> +                       default:
> +                               if (unlikely(!islower(*ext))) {
> +                                       ext_err = true;
> +                                       break;
> +                               }
> +                               /* Find next extension */
> +                               if (!isdigit(*isa))
> +                                       break;
> +                               /* Skip the minor version */
> +                               while (isdigit(*++isa))
> +                                       ;
> +                               if (*isa != 'p')
> +                                       break;
> +                               if (!isdigit(*++isa)) {
> +                                       --isa;
> +                                       break;
> +                               }
> +                               /* Skip the major version */
> +                               while (isdigit(*++isa))
> +                                       ;
> +                               break;
> +                       }
> +                       if (*isa != '_')
> +                               --isa;
>                         /*
> -                        * TODO: X, Y and Z extension parsing for Host ISA
> -                        * bitmap will be added in-future.
> +                        * TODO: Full version-aware handling including
> +                        * multi-letter extensions will be added in-future.
>                          */
> -                       if ('a' <= isa[i] && isa[i] < 'x')
> -                               this_isa |= (1UL << (isa[i] - 'a'));
> +                       if (ext_err || ext_long)
> +                               continue;
> +                       this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> +                       this_isa |= (1UL << (*ext - 'a'));
>                 }
>
>                 /*
> --
> 2.30.2
>
