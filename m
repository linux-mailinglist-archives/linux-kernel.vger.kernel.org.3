Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42DC55AED9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiFZEcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiFZEcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:32:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1777120B4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 21:32:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e28so3227415wra.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 21:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgYFMd2AKATEsQVK+8PzanW7bSMhQStpLS8wApMs/kg=;
        b=VnVmHxRQ/X1+vyk7hb5x1mVI5lvQBvnAX343TjPooAWa2AYnSHrXCA2GazI6XAePxb
         moic/e0X9RQlbbaMIjeU6IUPEwnmaUZ75rim40z2MbV++DOVrSQkGkQESyII7PwnhTv6
         CS971oI5RxwKtZuIxSzMcyugEbB5dnKdzSQNdlquxZzwl8Dtaq7l2razvYH+VXUcXqXf
         FPjn3nHRUkr1uV4MGePLNHKAKDNHeO+Kv/teorTZ/Zqb02KNX56cIJ68GLOO1PFHMdU5
         Td+ePmoG1S4Qj2mFGzf6eSjcAdDmxtY5A8hNYDsVi5epVBG1VYGUEt7tzI8XY8RD/zAj
         4zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgYFMd2AKATEsQVK+8PzanW7bSMhQStpLS8wApMs/kg=;
        b=USWdI31xscHXwf7FH2IPiajImo0ITrxogZZOz5HX2lYoMq9KWpRMg6HD9AzDZCSr/3
         CNUaqwCBVcsRjF0kLYxI9JgUzNwwbnyq7ChqzNkT5IBMU/VB1xa1Cy0nvX3VvsAU3fXZ
         jUvrwHHnjkRgpyvscM9tiHtx6qXznaJfrT3mTuuI1YcCMqLHGyrn7GEP92muAyAusHY1
         t6C5vb0kezmFHz4HZ+259ZdvyTgTEjI4jyYMzUnW2ekaW3nRg1N8zirX5YI9DLfscPTP
         ZNjDCftQvP5Kf/rF3kMgHz+1oCnINfKMneiHjsOJNpkUEH88ebjdpTU3xGbxsvmtfUvP
         P3Rw==
X-Gm-Message-State: AJIora8Vgv0lQClp848oQh34o753/WViMDoRpuV6dH3XN6mU5RJCeLmb
        fxHwrdp+KoAR0rQ7jWMLUBFroXr/iEg4kVSeYQTpaQ==
X-Google-Smtp-Source: AGRyM1sr5KiQ+m9xJ2IZX7O40JlBb/3atVPm677s1tnPo2jqE9OcE2sJEFCNrEpkNDvt4oTITfo+2Ml8u5uv51WXX+c=
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id
 r11-20020a5d6c6b000000b001ea77eadde8mr6438147wrz.690.1656217949141; Sat, 25
 Jun 2022 21:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220521143456.2759-1-jszhang@kernel.org> <20220521143456.2759-2-jszhang@kernel.org>
In-Reply-To: <20220521143456.2759-2-jszhang@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 26 Jun 2022 10:02:17 +0530
Message-ID: <CAAhSdy2yT26QournxS4Zf6L8oMj5Bs6BEjuW56NHapq=cXOEww@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] riscv: move sbi_init() earlier before jump_label_init()
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
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
        kasan-dev@googlegroups.com, Sunil V L <sunilvl@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 8:13 PM Jisheng Zhang <jszhang@kernel.org> wrote:
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

We are seeing a similar crash when booting kernel via EDK2 with RNG enabled.

Shell> fs0:\Image root=/dev/vda2 rootwait console=ttyS0
earlycon=uart8250,mmio,0x10000000 initrd=\initramfs.cp
EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...
[    0.000000] Linux version 5.19.0-rc3 (oe-user@oe-host)
(riscv64-unknown-linux-gnu-gcc (Ventana-2022.05.16) 12.1.0, GNU ld
(Ventana-2022.05.16) 2.37.90.20220201) #1 SMP Thu Jun 23 05:33:13 UTC
2022
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x81200000
[    0.000000] earlycon: uart8250 at MMIO 0x0000000010000000 (options '')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi: RNG=0xff94fd98 MEMRESERVE=0xfe658f18
[    0.000000] efi: seeding entropy pool
[    0.000000] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[    0.000000] Oops [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc3 #1
[    0.000000] epc : 0x0
[    0.000000]  ra : sbi_remote_fence_i+0x1e/0x26
[    0.000000] epc : 0000000000000000 ra : ffffffff800080f8 sp :
ffffffff81203cd0
[    0.000000]  gp : ffffffff812f1d40 tp : ffffffff8120da80 t0 :
0000000000cb8266
[    0.000000]  t1 : 000000006d5e5146 t2 : 0000000058000000 s0 :
ffffffff81203ce0
[    0.000000]  s1 : ffffffff8047586a a0 : 0000000000000000 a1 :
0000000000000000
[    0.000000]  a2 : 0000000000000000 a3 : 0000000000000000 a4 :
0000000000000000
[    0.000000]  a5 : 0000000000000000 a6 : 0000000000000000 a7 :
0000000000000000
[    0.000000]  s2 : ffffffff80dea320 s3 : ffffffff80deabb0 s4 :
ffffffff81353d48
[    0.000000]  s5 : 0000000000000001 s6 : 00000000fffde848 s7 :
0000000000000004
[    0.000000]  s8 : 0000000081021714 s9 : 000000008101e6f0 s10:
00000000fffde780
[    0.000000]  s11: 0000000000000004 t3 : 000000001467a415 t4 :
0000000000000000
[    0.000000]  t5 : 00000000007627e0 t6 : ffffffffbc865574
[    0.000000] status: 0000000200000100 badaddr: 0000000000000000
cause: 000000000000000c
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---

This patch fixes the above crash as well.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

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
