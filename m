Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0909A575CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiGOHsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGOHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:48:14 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AC677A6B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:48:13 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id c20so3210797qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbVpr0R59qtPw7baWfpBEgK5+t95ngcNjWBuGYLeZHA=;
        b=h82sFSY7nRFpsFdG3qNI1H42MXw5pvnOvB38hLiHFEDHaLfuzUJXmz8S5lpjusayYS
         YD+GUBy07LcOzqEcQArsxmM2onFO9KwsV9ycmV+0v6YRpCxO6YR8l5TmZFkl5evZq+KX
         LWn+lELhoL2YChRB9XdET+4tUZygBw84i3mylzHkyxI+/t+Ue1AYV+MFWabeNZtndnwE
         O/hCFzcBRANJzdV1Vqfkb9q0HgGibt5NG2RcdK2jXHzJF2h0MKWD5BrTP+7MaOkxuik4
         mwJ1fbdgx0SxipZ2r93lT7d6yh/rLqeSi8oo8n7IMS/iTAIk4i/VzqN1nlllXft40mZJ
         VYCg==
X-Gm-Message-State: AJIora8peWf4LwTlZt0lhM26JkHiPFp+Bg/5Pb8DwC3qgvZJmRc7sh96
        9Wsy72axBCOZdLYk59oJpQ+uqRQqw9XT3Q==
X-Google-Smtp-Source: AGRyM1uKN4CPq9Rd5a/55fiRFoRIFaz8wpTLfEVZp3TU1D0XzSSBBfp/it/seBRdwfVSPFbIRler5g==
X-Received: by 2002:a05:622a:1301:b0:31e:b67a:e3e9 with SMTP id v1-20020a05622a130100b0031eb67ae3e9mr11237368qtk.335.1657871292320;
        Fri, 15 Jul 2022 00:48:12 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id v6-20020ae9e306000000b006b58fce19dasm3347176qkf.20.2022.07.15.00.48.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 00:48:11 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y195so7288671yby.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:48:11 -0700 (PDT)
X-Received: by 2002:a25:2b48:0:b0:668:3b7d:326c with SMTP id
 r69-20020a252b48000000b006683b7d326cmr12451089ybr.380.1657871291234; Fri, 15
 Jul 2022 00:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220521193356.26562-1-palmer@rivosinc.com>
In-Reply-To: <20220521193356.26562-1-palmer@rivosinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Jul 2022 09:47:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJ7bhPka0acgw2wAZmsgDP2+tbqS7fO2A=_BOmv+8+HA@mail.gmail.com>
Message-ID: <CAMuHMdVJ7bhPka0acgw2wAZmsgDP2+tbqS7fO2A=_BOmv+8+HA@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Add CONFIG_{NON,}PORTABLE
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Jens Axboe <axboe@kernel.dk>, Guo Ren <guoren@kernel.org>,
        mchitale@ventanamicro.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Sat, May 21, 2022 at 10:49 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The RISC-V port has collected a handful of options that are
> fundamentally non-portable.  To prevent users from shooting themselves
> in the foot, hide them all behind a config entry that explicitly calls
> out that non-portable binaries may be produced.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks for your patch, which is now commit 44c1e84a38a03175 ("RISC-V:
Add CONFIG_{NON,}PORTABLE") in riscv/for-next

> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -222,6 +222,21 @@ source "arch/riscv/Kconfig.erratas"
>
>  menu "Platform type"
>
> +config NONPORTABLE
> +       bool "Allow configurations that result in non-portable kernels"
> +       help
> +         RISC-V kernel binaries are compatible between all known systems
> +         whenever possible, but there are some use cases that can only be
> +         satisfied by configurations that result in kernel binaries that are
> +         not portable between systems.
> +
> +         Selecting N does not guarantee kernels will be portable to all known
> +         systems.  Selecting any of the options guarded by NONPORTABLE will
> +         result in kernel binaries that are unlikely to be portable between
> +         systems.
> +
> +         If unsure, say N.

Doing it this way means allmodconfig will enable NONPORTABLE, which
may not be what we want?

> +
>  choice
>         prompt "Base ISA"
>         default ARCH_RV64I

> @@ -554,7 +571,7 @@ config PHYS_RAM_BASE
>
>  config XIP_KERNEL
>         bool "Kernel Execute-In-Place from ROM"
> -       depends on MMU && SPARSEMEM
> +       depends on MMU && SPARSEMEM && NONPORTABLE

Nice! Would we get something like this on arm32 past rmk?

>         # This prevents XIP from being enabled by all{yes,mod}config, which
>         # fail to build since XIP doesn't support large kernels.
>         depends on !COMPILE_TEST
> @@ -594,9 +611,16 @@ endmenu
>
>  config BUILTIN_DTB
>         bool
> -       depends on OF
> +       depends on OF && NONPORTABLE
>         default y if XIP_KERNEL
>
> +config PORTABLE
> +       bool
> +       default !NONPORTABLE
> +       select EFI
> +       select OF
> +       select MMU
> +
>  menu "Power management options"
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
