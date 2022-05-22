Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA65301C8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbiEVICI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 04:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbiEVICD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 04:02:03 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E622C109
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:01:59 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p139so20495670ybc.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTR4F6Zdd5GmGSK+3VogNeE1cHs24uCXuHYRDacHFH0=;
        b=MBJcy6x7M7Ay+fMd3UCpbOdofujh5V0wLWk1jvv1/hY7Oa7ImjQ8OgaAtQePnZ/aLq
         U/EAPeSLh3jD4fmffjn2cDZZXRrNIaLJk3YuZbQpPT/o9BzjUzvSc6MVy3ZSz/ZjOl1E
         pG2ZoltJ4iKhV+27FTcEy3PdUAAnSoPfHIWXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTR4F6Zdd5GmGSK+3VogNeE1cHs24uCXuHYRDacHFH0=;
        b=WumvOtXS20lejGx+ob/7i3zH0MaJms2R0+8FDqfJupcmm1lQnn4jMqbIqysgPL2WEN
         ajczJivqoQGWWyAMcomFYK8SQuXoyMh+unWsIq1bjHPlQl8udcLAi2XFe3VlkjBFJc/0
         nQbe7i127MhD13NYRk2LMw+lGRmXv5nHp9sq97+AJWL+0IDyuijHgQH0E30cf9uHl9LG
         tDyRt+G9F/R/eGmOh6JldxSgMy/wdyG7B0fRRcjQSNj1DoTcbrgk9TrnVeN0jUsVitKp
         xW0jhUnj0xHDbiUBA4sw58hI7Ds4mTK7GwvxMTL3yvkaE7xKAwLCP/3309KK87TNTtuh
         45Nw==
X-Gm-Message-State: AOAM532VpniMWe/BwCW/+E2hfcWy7/3KQOXnLr45PvUSU2x56toFo/Qz
        ohQ+9uFFOBTEpp0dRWQI4DText5Y13IdgKtNqg/iISlKyQ==
X-Google-Smtp-Source: ABdhPJytDIb72jnNAMvfjSVmqzrgWgR7LpO0kXNlntJZ5fXhvFnznaUNWXyONquMGqObNerCg+NKW/O3se66hI+ZDgQ=
X-Received: by 2002:a25:941:0:b0:64d:da87:62ff with SMTP id
 u1-20020a250941000000b0064dda8762ffmr16707944ybm.459.1653206518170; Sun, 22
 May 2022 01:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220521143456.2759-1-jszhang@kernel.org> <20220521143456.2759-2-jszhang@kernel.org>
In-Reply-To: <20220521143456.2759-2-jszhang@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 22 May 2022 01:01:47 -0700
Message-ID: <CAOnJCU+peNAHCWGvNhHV30h0t9oM5f3f_5=AtbHae=S8SrDAVA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] riscv: move sbi_init() earlier before jump_label_init()
To:     Jisheng Zhang <jszhang@kernel.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 7:44 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> We call jump_label_init() in setup_arch() is to use static key
> mechanism earlier, but riscv jump label relies on the sbi functions,
> If we enable static key before sbi_init(), the code path looks like:
>   static_branch_enable()
>     ..
>       arch_jump_label_transform()
>         patch_text_nosync()
>           flush_icache_range()
>             flush_icache_all()
>               sbi_remote_fence_i() for CONFIG_RISCV_SBI case
>                 __sbi_rfence()
>

@Alexandre Ghiti : Is this the root cause of the panic you were seeing ?

IIRC, you mentioned in your last email that you don't see the issue
anymore. May be you avoided the issue because alternatives usage
was moved but root case remains as it is ?

> Since sbi isn't initialized, so NULL deference! Here is a typical
> panic log:
>
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    0.000000] Oops [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-rc7+ #79
> [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> [    0.000000] epc : 0x0
> [    0.000000]  ra : sbi_remote_fence_i+0x1e/0x26
> [    0.000000] epc : 0000000000000000 ra : ffffffff80005826 sp : ffffffff80c03d50
> [    0.000000]  gp : ffffffff80ca6178 tp : ffffffff80c0ad80 t0 : 6200000000000000
> [    0.000000]  t1 : 0000000000000000 t2 : 62203a6b746e6972 s0 : ffffffff80c03d60
> [    0.000000]  s1 : ffffffff80001af6 a0 : 0000000000000000 a1 : 0000000000000000
> [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> [    0.000000]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000080200
> [    0.000000]  s2 : ffffffff808b3e48 s3 : ffffffff808bf698 s4 : ffffffff80cb2818
> [    0.000000]  s5 : 0000000000000001 s6 : ffffffff80c9c345 s7 : ffffffff80895aa0
> [    0.000000]  s8 : 0000000000000001 s9 : 000000000000007f s10: 0000000000000000
> [    0.000000]  s11: 0000000000000000 t3 : ffffffff80824d08 t4 : 0000000000000022
> [    0.000000]  t5 : 000000000000003d t6 : 0000000000000000
> [    0.000000] status: 0000000000000100 badaddr: 0000000000000000 cause: 000000000000000c
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>
> Fix this issue by moving sbi_init() earlier before jump_label_init()
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 834eb652a7b9..d150cedeb7e0 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -268,6 +268,7 @@ void __init setup_arch(char **cmdline_p)
>         *cmdline_p = boot_command_line;
>
>         early_ioremap_setup();
> +       sbi_init();
>         jump_label_init();
>         parse_early_param();
>
> @@ -284,7 +285,6 @@ void __init setup_arch(char **cmdline_p)
>         misc_mem_init();
>
>         init_resources();
> -       sbi_init();
>
>  #ifdef CONFIG_KASAN
>         kasan_init();
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
