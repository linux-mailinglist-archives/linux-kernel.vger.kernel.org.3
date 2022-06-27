Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7AE55C691
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiF0Gru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiF0Grt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:47:49 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F5559E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:47:46 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-318889e6a2cso75684437b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpPnU8MehDqKJsWHhgDuy79jEz+vPYFTumDLAwjvYYg=;
        b=RUqSR0AqJhPJccEkPVRsXBIORnaIWurSVpDAsnsLojT+BrSq0i7i6VSA1pzQU6nDpC
         V+/vbPBlZcDdIu+glOlIQ++1GKFFKf2lflSnelKokqQPSzOtT2UU/1eTkKF0hovJ50lp
         HYv/S3eXnanC4YfB53eUXnMjTOR8I1GXbb38g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpPnU8MehDqKJsWHhgDuy79jEz+vPYFTumDLAwjvYYg=;
        b=Uqea8+M3nBs6BVtXAwcukCTKe3yDLJFlwXdAs6MWostXlWcTSSfNzK859SE//rgFwF
         6TJmSRukDmatLfdlKN2q1Ys4z9+YAMWRlieSXpOzNQd9Z3qE4wghwB5euOm3tWDsu/Gf
         sAZMf3Yyhzy2zDatiiPuYxa8VDynQqeYvn4gmjcmOWJqok5GED4v1pbI8n8nqnp95cdk
         QBc8WCWDLjMrG6mIjATCl+sUpWfrVdBF25WIoR7k4x22f1H7GjCf8BUa6ded38spE5Qo
         jFIbc0f+Opza9h5J7HrbjE6MU0vebbLzrQ3skN8ZOT8cRfQ/IBhpGb6UAtDr4nQs+Gjt
         eLsA==
X-Gm-Message-State: AJIora9pdt+rI4vOesqWTnzSygaWoHq1C2+XL3JclqYZkIA4cFM+OR5Q
        u4QeM06PmS2ZSK6r6PamdSQRbSvhIG89mFvRKbO3
X-Google-Smtp-Source: AGRyM1t5v9aY9PoJBRWj5wgnpnt/ae8HBGaoYD5GxB91TGwS4Xv3J1jWoSlEf92zESgNMmpi7up5ktRa4dhWz8LGWRA=
X-Received: by 2002:a81:6ad7:0:b0:31b:a0f1:c093 with SMTP id
 f206-20020a816ad7000000b0031ba0f1c093mr6336295ywc.400.1656312465509; Sun, 26
 Jun 2022 23:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220521143456.2759-1-jszhang@kernel.org> <20220521143456.2759-2-jszhang@kernel.org>
 <CAAhSdy2yT26QournxS4Zf6L8oMj5Bs6BEjuW56NHapq=cXOEww@mail.gmail.com>
In-Reply-To: <CAAhSdy2yT26QournxS4Zf6L8oMj5Bs6BEjuW56NHapq=cXOEww@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 26 Jun 2022 23:47:34 -0700
Message-ID: <CAOnJCU+2QXdCkf7g_cnQ+yMoFABc7bfKZ8=5sOJk2uQhS8+Uww@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] riscv: move sbi_init() earlier before jump_label_init()
To:     Anup Patel <anup@brainfault.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Sunil V L <sunilvl@ventanamicro.com>
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

On Sat, Jun 25, 2022 at 9:33 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Sat, May 21, 2022 at 8:13 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > We call jump_label_init() in setup_arch() is to use static key
> > mechanism earlier, but riscv jump label relies on the sbi functions,
> > If we enable static key before sbi_init(), the code path looks like:
> >   static_branch_enable()
> >     ..
> >       arch_jump_label_transform()
> >         patch_text_nosync()
> >           flush_icache_range()
> >             flush_icache_all()
> >               sbi_remote_fence_i() for CONFIG_RISCV_SBI case
> >                 __sbi_rfence()
> >
> > Since sbi isn't initialized, so NULL deference! Here is a typical
> > panic log:
> >
> > [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> > [    0.000000] Oops [#1]
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-rc7+ #79
> > [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> > [    0.000000] epc : 0x0
> > [    0.000000]  ra : sbi_remote_fence_i+0x1e/0x26
> > [    0.000000] epc : 0000000000000000 ra : ffffffff80005826 sp : ffffffff80c03d50
> > [    0.000000]  gp : ffffffff80ca6178 tp : ffffffff80c0ad80 t0 : 6200000000000000
> > [    0.000000]  t1 : 0000000000000000 t2 : 62203a6b746e6972 s0 : ffffffff80c03d60
> > [    0.000000]  s1 : ffffffff80001af6 a0 : 0000000000000000 a1 : 0000000000000000
> > [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> > [    0.000000]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000080200
> > [    0.000000]  s2 : ffffffff808b3e48 s3 : ffffffff808bf698 s4 : ffffffff80cb2818
> > [    0.000000]  s5 : 0000000000000001 s6 : ffffffff80c9c345 s7 : ffffffff80895aa0
> > [    0.000000]  s8 : 0000000000000001 s9 : 000000000000007f s10: 0000000000000000
> > [    0.000000]  s11: 0000000000000000 t3 : ffffffff80824d08 t4 : 0000000000000022
> > [    0.000000]  t5 : 000000000000003d t6 : 0000000000000000
> > [    0.000000] status: 0000000000000100 badaddr: 0000000000000000 cause: 000000000000000c
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> > [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> >
> > Fix this issue by moving sbi_init() earlier before jump_label_init()
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>
> We are seeing a similar crash when booting kernel via EDK2 with RNG enabled.
>
> Shell> fs0:\Image root=/dev/vda2 rootwait console=ttyS0
> earlycon=uart8250,mmio,0x10000000 initrd=\initramfs.cp
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services...
> [    0.000000] Linux version 5.19.0-rc3 (oe-user@oe-host)
> (riscv64-unknown-linux-gnu-gcc (Ventana-2022.05.16) 12.1.0, GNU ld
> (Ventana-2022.05.16) 2.37.90.20220201) #1 SMP Thu Jun 23 05:33:13 UTC
> 2022
> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x81200000
> [    0.000000] earlycon: uart8250 at MMIO 0x0000000010000000 (options '')
> [    0.000000] printk: bootconsole [uart8250] enabled
> [    0.000000] efi: EFI v2.70 by EDK II
> [    0.000000] efi: RNG=0xff94fd98 MEMRESERVE=0xfe658f18
> [    0.000000] efi: seeding entropy pool
> [    0.000000] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [    0.000000] Oops [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc3 #1
> [    0.000000] epc : 0x0
> [    0.000000]  ra : sbi_remote_fence_i+0x1e/0x26
> [    0.000000] epc : 0000000000000000 ra : ffffffff800080f8 sp :
> ffffffff81203cd0
> [    0.000000]  gp : ffffffff812f1d40 tp : ffffffff8120da80 t0 :
> 0000000000cb8266
> [    0.000000]  t1 : 000000006d5e5146 t2 : 0000000058000000 s0 :
> ffffffff81203ce0
> [    0.000000]  s1 : ffffffff8047586a a0 : 0000000000000000 a1 :
> 0000000000000000
> [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000000 a4 :
> 0000000000000000
> [    0.000000]  a5 : 0000000000000000 a6 : 0000000000000000 a7 :
> 0000000000000000
> [    0.000000]  s2 : ffffffff80dea320 s3 : ffffffff80deabb0 s4 :
> ffffffff81353d48
> [    0.000000]  s5 : 0000000000000001 s6 : 00000000fffde848 s7 :
> 0000000000000004
> [    0.000000]  s8 : 0000000081021714 s9 : 000000008101e6f0 s10:
> 00000000fffde780
> [    0.000000]  s11: 0000000000000004 t3 : 000000001467a415 t4 :
> 0000000000000000
> [    0.000000]  t5 : 00000000007627e0 t6 : ffffffffbc865574
> [    0.000000] status: 0000000200000100 badaddr: 0000000000000000
> cause: 000000000000000c
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
> the idle task! ]---
>
> This patch fixes the above crash as well.
>

Thanks for the confirmation.

> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Thanks,
> Anup
>
> > ---
> >  arch/riscv/kernel/setup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 834eb652a7b9..d150cedeb7e0 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -268,6 +268,7 @@ void __init setup_arch(char **cmdline_p)
> >         *cmdline_p = boot_command_line;
> >
> >         early_ioremap_setup();
> > +       sbi_init();
> >         jump_label_init();
> >         parse_early_param();
> >
> > @@ -284,7 +285,6 @@ void __init setup_arch(char **cmdline_p)
> >         misc_mem_init();
> >
> >         init_resources();
> > -       sbi_init();
> >
> >  #ifdef CONFIG_KASAN
> >         kasan_init();
> > --
> > 2.34.1
> >
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
