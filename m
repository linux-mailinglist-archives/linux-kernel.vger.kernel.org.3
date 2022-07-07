Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E242569AA7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiGGGpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiGGGp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:45:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EFF2B638
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6A19B81F4F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DED8C341CB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657176325;
        bh=Zx0os8GxJvcPYdreDFRWb7KMIvQ2KbMgMIacPeI+trY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jiF5vAL7aPamFNMX3qPej3opnILKFKpAfR4RdPixBzPspn1NP74dBk6aGm4lCvcyc
         uyQ0kJYziibPsQo81qh7z2fvzyCImnrpEOF/WpHpfFmDWYsK0s9E/k7V7UdUyJgNI2
         dDi2tfCQf/QfWAzwR5MgbfavMXw3+XnRYhrXiIlby1xAsUGaCwq++ZwigXiHhgwufD
         rLgZ8NHIVNY0m9E/1zJDML5rAMSZb0kulNe6geZ/fjI6Z1+tB7uvMmTRD5RWeLRAl0
         l194x4jd6mNJL8SCfO+8ONDVgd5UMX76KQVKeShjmtR9EY6hkyd84RIJMk/qhP6CSE
         umxTJB+AGRhYg==
Received: by mail-vs1-f48.google.com with SMTP id a184so8215094vsa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 23:45:25 -0700 (PDT)
X-Gm-Message-State: AJIora9ANZfJ2+HP+w09E29Zlow7RdXeZqC4iEE9KW1fTuH+vvF3TN8V
        zZ7LgVrau7yyz9mnHfV8l1ERja1BwSTXRWeHxuM=
X-Google-Smtp-Source: AGRyM1sqjxJmJfvb+KLhWZ/KjfX6VOXLNDZMdjjnFE3m+NF4ud3XzRygjOBS0PjwP/OsqOSfcYVdvYOVTbKn81n3NS0=
X-Received: by 2002:a67:f588:0:b0:354:35de:4329 with SMTP id
 i8-20020a67f588000000b0035435de4329mr25446544vso.84.1657176324174; Wed, 06
 Jul 2022 23:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220706112937.1218573-1-huqi@loongson.cn>
In-Reply-To: <20220706112937.1218573-1-huqi@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 7 Jul 2022 14:45:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6MHjzdwyZqk6a3sKByRofG1Th6QEk0Be5NBhiAsVNcTg@mail.gmail.com>
Message-ID: <CAAhV-H6MHjzdwyZqk6a3sKByRofG1Th6QEk0Be5NBhiAsVNcTg@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: Remove vcsr in loongarch_fpu
To:     huqi <huqi@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I have rewritten the commit message. If no problem, this patch will be
queued for loongarch-fixes.
--
The `vcsr` only exists in the old hardware design, it isn't used in any
shipped hardware from Loongson-3A5000 on. FPU and LSX/LASX both use the
`fcsr` as their control and status registers now. For example, the RM
control bit in fcsr0 is shared by FPU, LSX and LASX.

Particularly, fcsr16 to fcsr31 are reserved for LSX/LASX now, access to
these registers has no visible effect if LSX/LASX is enabled, and will
cause SXD/ASXD exceptions if LSX/LASX is not enabled.

So, mentions of vcsr are obsolete in the first place, let's remove them.
--
Huacai

On Wed, Jul 6, 2022 at 7:29 PM huqi <huqi@loongson.cn> wrote:
>
> From: Qi Hu <huqi@loongson.cn>
>
> The `vcsr` is not used anymore. Remove this member from `loongarch_fpu`.
>
> From 3A5000(LoongArch), `vcsr` is removed in hardware. FP and LSX/LASX
> both use `fcsr` as their csr.
>
> Particularly, fcsr from $r16 to $r31 are reserved for LSX/LASX, an
> using the registers in this area will cause SXD/ASXD if LSX/LASX is
> not enabled.
>
> Signed-off-by: Qi Hu <huqi@loongson.cn>
> ---
> V3:
> - Modify commit message to conform to the format.
> V2:
> - Add more details in the commit message.
> ---
>  arch/loongarch/include/asm/fpregdef.h  |  1 -
>  arch/loongarch/include/asm/processor.h |  2 --
>  arch/loongarch/kernel/asm-offsets.c    |  1 -
>  arch/loongarch/kernel/fpu.S            | 10 ----------
>  4 files changed, 14 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/fpregdef.h b/arch/loongarch/include/asm/fpregdef.h
> index adb16e4b43b0..b6be527831dd 100644
> --- a/arch/loongarch/include/asm/fpregdef.h
> +++ b/arch/loongarch/include/asm/fpregdef.h
> @@ -48,6 +48,5 @@
>  #define fcsr1  $r1
>  #define fcsr2  $r2
>  #define fcsr3  $r3
> -#define vcsr16 $r16
>
>  #endif /* _ASM_FPREGDEF_H */
> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
> index 1d63c934b289..57ec45aa078e 100644
> --- a/arch/loongarch/include/asm/processor.h
> +++ b/arch/loongarch/include/asm/processor.h
> @@ -80,7 +80,6 @@ BUILD_FPR_ACCESS(64)
>
>  struct loongarch_fpu {
>         unsigned int    fcsr;
> -       unsigned int    vcsr;
>         uint64_t        fcc;    /* 8x8 */
>         union fpureg    fpr[NUM_FPU_REGS];
>  };
> @@ -161,7 +160,6 @@ struct thread_struct {
>          */                                                     \
>         .fpu                    = {                             \
>                 .fcsr           = 0,                            \
> -               .vcsr           = 0,                            \
>                 .fcc            = 0,                            \
>                 .fpr            = {{{0,},},},                   \
>         },                                                      \
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
> index bfb65eb2844f..20cd9e16a95a 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -166,7 +166,6 @@ void output_thread_fpu_defines(void)
>
>         OFFSET(THREAD_FCSR, loongarch_fpu, fcsr);
>         OFFSET(THREAD_FCC,  loongarch_fpu, fcc);
> -       OFFSET(THREAD_VCSR, loongarch_fpu, vcsr);
>         BLANK();
>  }
>
> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
> index 75c6ce0682a2..a631a7137667 100644
> --- a/arch/loongarch/kernel/fpu.S
> +++ b/arch/loongarch/kernel/fpu.S
> @@ -146,16 +146,6 @@
>         movgr2fcsr      fcsr0, \tmp0
>         .endm
>
> -       .macro sc_save_vcsr base, tmp0
> -       movfcsr2gr      \tmp0, vcsr16
> -       EX      st.w \tmp0, \base, 0
> -       .endm
> -
> -       .macro sc_restore_vcsr base, tmp0
> -       EX      ld.w \tmp0, \base, 0
> -       movgr2fcsr      vcsr16, \tmp0
> -       .endm
> -
>  /*
>   * Save a thread's fp context.
>   */
> --
> 2.36.1
>
>
