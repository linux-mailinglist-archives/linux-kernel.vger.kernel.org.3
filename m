Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F8F5A3DF8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 16:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiH1OP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 10:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiH1OPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 10:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF3613F9F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 07:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFB9E60F9F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662C5C433D7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661696153;
        bh=8zj1x1xLeLLzipXWrl/kSXEmFtyv39CyRFsnNZ5xakQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i37PBmD/I56kOEG/Hp12wN7WnnZOXbO8r5eqEIrn7KcBqhOQPaFw+o5bW24P2bSMw
         xzmmRV3fWZfZrChFwqRQzk1dB82lROiTgMCGj9CeTVu9CEuyIXr1uztWilIjRkpP49
         yYqgFLBVolBvErS4FqhnxqRw6MCGFzetUNt78Tq8hQirtge5Ple7VD97ZFVyxm/eL9
         fmZ9rrCQFDNNcesatJmjS1Ynwie0CJJYidbeYfM4u3/BS6IPcEi6Vgug0FLeCfV8Pt
         ZyU/mDusiqgRTtZOukKsu+7HUhccTy2mDYQKkuRq2iKa63UljrktZGXttUCvidXcfh
         TDGUDU3zyKexA==
Received: by mail-vs1-f43.google.com with SMTP id w188so6041449vsb.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 07:15:53 -0700 (PDT)
X-Gm-Message-State: ACgBeo2KPtie1M1SXF5sSqXAjuq4R2iUkKMFm3pGpc0FH3vGALNGBtWf
        4PRbgyDfW8gDBqaH7kSAo4kll7QolwLEvj4jsQA=
X-Google-Smtp-Source: AA6agR5/iR+N3klHacCtwT7e/hRVDUkTeliBga/Y2s2tAeAOQcVPLLhXsG0lpJ2OXLZSjKGiewymyPXVv42AKzLve5k=
X-Received: by 2002:a67:d582:0:b0:390:d6dd:5612 with SMTP id
 m2-20020a67d582000000b00390d6dd5612mr847117vsj.78.1661696152320; Sun, 28 Aug
 2022 07:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220827175436.156464-1-xry111@xry111.site> <20220827175436.156464-3-xry111@xry111.site>
In-Reply-To: <20220827175436.156464-3-xry111@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 28 Aug 2022 22:15:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5S+9MZi5_LL11hCFePG9GK08ot_LK+mwZjh+5Hoyxutg@mail.gmail.com>
Message-ID: <CAAhV-H5S+9MZi5_LL11hCFePG9GK08ot_LK+mwZjh+5Hoyxutg@mail.gmail.com>
Subject: Re: [PATCH 2/8] LoongArch: Only use -Wa,-mla-* options for !CONFIG_CC_HAS_EXPLICIT_RELOCS
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
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

Hi, Ruoyao,

On Sun, Aug 28, 2022 at 1:55 AM Xi Ruoyao <xry111@xry111.site> wrote:
>
> If explicit relocation hints is used by the toolchain, -Wa,-mla-*
> options will be useless for C code.  Only use them for
> !CONFIG_CC_HAS_EXPLICIT_RELOCS.
>
> Replace "la" with "la.pcrel" in head.S to keep the semantic consistent
> with new and old toolchains for the low level startup code.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Makefile      | 15 ++++++++++++++-
>  arch/loongarch/kernel/head.S | 10 +++++-----
>  2 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 415e09bdf31a..bd0ea6623245 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -40,10 +40,23 @@ endif
>
>  cflags-y                       += -G0 -pipe -msoft-float
>  LDFLAGS_vmlinux                        += -G0 -static -n -nostdlib
> +
> +ifdef CONFIG_CC_HAS_EXPLICIT_RELOCS
> +# GCC may have -mexplicit-relocs off by default if it was built with an old
> +# assembler.  But with CONFIG_CC_HAS_EXPLICIT_RELOCS we are sure explicit
> +# relocation hints are supported by the assembler, so force it.
> +cflags-y                       += -mexplicit-relocs
> +else
> +# Likewise, disable -mexplicit-relocs if GCC enables by default but the
> +# assembler does not support it.
> +cflags-y                       += $(call cc-option,-mno-explicit-relocs)
> +# With -mno-explicit-relocs, use assembler options to adjust code generation
> +# for symbol address.
>  KBUILD_AFLAGS_KERNEL           += -Wa,-mla-global-with-pcrel
>  KBUILD_CFLAGS_KERNEL           += -Wa,-mla-global-with-pcrel
>  KBUILD_AFLAGS_MODULE           += -Wa,-mla-global-with-abs
> -KBUILD_CFLAGS_MODULE           += -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
> +KBUILD_CFLAGS_MODULE           += -Wa,-mla-global-with-abs,-mla-local-with-abs
> +endif
Move all comments out of #ifdefs may make code more clear.


Huacai
>
>  cflags-y += -ffreestanding
>  cflags-y += $(call cc-option, -mno-check-zero-division)
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 01bac62a6442..eb3f641d5915 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -55,17 +55,17 @@ SYM_CODE_START(kernel_entry)                        # kernel entry point
>         li.w            t0, 0x00                # FPE=0, SXE=0, ASXE=0, BTE=0
>         csrwr           t0, LOONGARCH_CSR_EUEN
>
> -       la              t0, __bss_start         # clear .bss
> +       la.pcrel        t0, __bss_start         # clear .bss
>         st.d            zero, t0, 0
> -       la              t1, __bss_stop - LONGSIZE
> +       la.pcrel        t1, __bss_stop - LONGSIZE
>  1:
>         addi.d          t0, t0, LONGSIZE
>         st.d            zero, t0, 0
>         bne             t0, t1, 1b
>
> -       la              t0, fw_arg0
> +       la.pcrel        t0, fw_arg0
>         st.d            a0, t0, 0               # firmware arguments
> -       la              t0, fw_arg1
> +       la.pcrel        t0, fw_arg1
>         st.d            a1, t0, 0
>
>         /* KSave3 used for percpu base, initialized as 0 */
> @@ -73,7 +73,7 @@ SYM_CODE_START(kernel_entry)                  # kernel entry point
>         /* GPR21 used for percpu base (runtime), initialized as 0 */
>         move            u0, zero
>
> -       la              tp, init_thread_union
> +       la.pcrel        tp, init_thread_union
>         /* Set the SP after an empty pt_regs.  */
>         PTR_LI          sp, (_THREAD_SIZE - 32 - PT_SIZE)
>         PTR_ADD         sp, sp, tp
> --
> 2.37.0
>
