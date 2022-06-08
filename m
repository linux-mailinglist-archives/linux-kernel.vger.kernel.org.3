Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD735436FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244290AbiFHPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbiFHPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:14:58 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C591570
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:10:41 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id k6so12644286qkf.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6PtJz0BrJE/Hg+05Q61y2MGcQT6vQ+yOTNRosqppNs=;
        b=C0Bhmg+IPNSkuViWSHiQkrV9gFQXc2eCIskZK3v8eOop/kIpX8wehKWoojbdxr4dBs
         pydPb9qzFDRvPLIvGbAgtvUA3BGdp5pKzRPTk4lrkiKAo/GgyTKzxkSx3Y9aPSaaG7QF
         LpLV2OVOXQeN4G3KT/xigNQDtVfu5MkIKWAZGkHIAQIRszWdpieTEDMoYKvDMGCEo4W3
         FU7B+bnVoe+nkEmzOiCi7pfjY7QDVjfqhjYDd1by6YU6jhpz1uIzjr66ONV6e3rbxCbc
         ACe0MBfcgJsTQ7lGqZtq9gUT/HIjlwcw0K0h7SM+ZeXb8jNc22/gvK+sTTOl8XOH4tpJ
         +zyQ==
X-Gm-Message-State: AOAM531k7Fwf6eVDMxTp8SAYOVxzHe+SDtZ4XqXhDbQ1asoSjidjlcHI
        84B1XTXf9wUw2ql0paHdrRsGFnUNbX0iFg==
X-Google-Smtp-Source: ABdhPJxuu/wxlgakW03QhduCCofYqEEe9miqE3lZpXydZEmZQwgPvFWEdadyRKSpd0Y5hax55clvSw==
X-Received: by 2002:a05:620a:1009:b0:6a6:bca7:7f4e with SMTP id z9-20020a05620a100900b006a6bca77f4emr11043457qkj.536.1654701039644;
        Wed, 08 Jun 2022 08:10:39 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id g20-20020a05620a40d400b006a5d8d96681sm8708759qko.100.2022.06.08.08.10.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 08:10:39 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id e184so37005063ybf.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:10:38 -0700 (PDT)
X-Received: by 2002:a25:d748:0:b0:65c:6b00:55af with SMTP id
 o69-20020a25d748000000b0065c6b0055afmr34410545ybg.365.1654701038694; Wed, 08
 Jun 2022 08:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de> <878rrs6ft7.fsf@jogness.linutronix.de>
 <Ymfgis0EAw0Oxoa5@alley> <Ymfwk+X0CHq6ex3s@alley> <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com> <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com> <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com> <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com> <87y1zkkrjy.fsf@jogness.linutronix.de>
In-Reply-To: <87y1zkkrjy.fsf@jogness.linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Jun 2022 17:10:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVmoj3Tqz65VmSuVL2no4+bGC=qdB8LWoB=vyASf9vS+g@mail.gmail.com>
Message-ID: <CAMuHMdVmoj3Tqz65VmSuVL2no4+bGC=qdB8LWoB=vyASf9vS+g@mail.gmail.com>
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for per-console locking
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
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

Hi John,

On Mon, May 2, 2022 at 3:19 PM John Ogness <john.ogness@linutronix.de> wrote:
> On 2022-05-02, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > Data written to /dev/kmsg and all kernel logs were always displayed
> > correctly. Also data written directly to /dev/ttyAML0 is displayed
> > properly on the console. The latter doesn't however trigger the input
> > related activity.
> >
> > It looks that the data read from the uart is delivered only if other
> > activity happens on the kernel console. If I type 'reboot' and press
> > enter, nothing happens immediately. If I type 'date >/dev/ttyAML0' via
> > ssh then, I only see the date printed on the console. However if I
> > type 'date >/dev/kmsg', the the date is printed and reboot happens.
>
> I suppose if you login via ssh and check /proc/interrupts, then type
> some things over serial, then check /proc/interrupts again, you will see
> there have been no interrupts for the uart. But interrupts for other
> devices are happening. Is this correct?
>
> > For comparison, here is a 't' sysrq result from the 'working' serial
> > console (next-20220429), which happens usually 1 of 4 boots:
> >
> > https://pastebin.com/mp8zGFbW
>
> This still looks odd to me. We should be seeing a trace originating from
> ret_from_fork+0x10/0x20 and kthread+0x118/0x11c.
>
> I wonder if the early creation of the thread is somehow causing
> problems. Could you try the following patch to see if it makes a
> difference? I would also like to see the sysrq-t output with this patch
> applied:

On one board, I'm seeing a new splat during early boot, pointing to
printk_activate_kthreads:

    Calibrating delay loop (skipped), value calculated using timer
frequency.. 48.00 BogoMIPS (lpj=96000)
    pid_max: default: 32768 minimum: 301
    Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
    Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)

    =============================
    [ BUG: Invalid wait context ]
    5.19.0-rc1-ebisu-00802-g06a0dd60d6e4 #431 Not tainted
    -----------------------------
    swapper/0/1 is trying to lock:
    ffffffc00910bac8 (base_crng.lock){....}-{3:3}, at:
crng_make_state+0x148/0x1e4
    other info that might help us debug this:
    context-{5:5}
    2 locks held by swapper/0/1:
     #0: ffffffc008f8ae00 (console_lock){+.+.}-{0:0}, at:
printk_activate_kthreads+0x10/0x54
     #1: ffffffc009da4a28 (&meta->lock){....}-{2:2}, at:
__kfence_alloc+0x378/0x5c4
    stack backtrace:
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.19.0-rc1-ebisu-00802-g06a0dd60d6e4 #431
    Hardware name: Renesas Ebisu-4D board based on r8a77990 (DT)
    Call trace:
     dump_backtrace.part.0+0x98/0xc0
     show_stack+0x14/0x28
     dump_stack_lvl+0xac/0xec
     dump_stack+0x14/0x2c
     __lock_acquire+0x388/0x10a0
     lock_acquire+0x190/0x2c0
     _raw_spin_lock_irqsave+0x6c/0x94
     crng_make_state+0x148/0x1e4
     _get_random_bytes.part.0+0x4c/0xe8
     get_random_u32+0x4c/0x140
     __kfence_alloc+0x460/0x5c4
     kmem_cache_alloc_trace+0x194/0x1dc
     __kthread_create_on_node+0x5c/0x1a8
     kthread_create_on_node+0x58/0x7c
     printk_start_kthread.part.0+0x34/0xa8
     printk_activate_kthreads+0x4c/0x54
     do_one_initcall+0xec/0x278
     kernel_init_freeable+0x11c/0x214
     kernel_init+0x24/0x124
     ret_from_fork+0x10/0x20
    rcu: Hierarchical SRCU implementation.
    printk: console [tty0] printing thread started
    EFI services will not be available.
    smp: Bringing up secondary CPUs ...
    Detected VIPT I-cache on CPU1
    CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
    smp: Brought up 1 node, 2 CPUs
    SMP: Total of 2 processors activated.

> ---------------- BEGIN PATCH ---------------
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2311a0ad584a..c4362d25de22 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3837,7 +3837,7 @@ static int __init printk_activate_kthreads(void)
>
>         return 0;
>  }
> -early_initcall(printk_activate_kthreads);
> +late_initcall(printk_activate_kthreads);
>
>  #if defined CONFIG_PRINTK
>  /* If @con is specified, only wait for that console. Otherwise wait for all. */
> ---------------- END PATCH ---------------

Doesn't seem to make much of a difference, only a slightly different
backtrace, compared to the above:

     Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
     Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
    +rcu: Hierarchical SRCU implementation.

     =============================
     [ BUG: Invalid wait context ]
    -5.19.0-rc1-ebisu-00802-g06a0dd60d6e4 #431 Not tainted
    +5.19.0-rc1-ebisu-00802-g06a0dd60d6e4-dirty #433 Not tainted
     -----------------------------
     swapper/0/1 is trying to lock:
     ffffffc00910bac8 (base_crng.lock){....}-{3:3}, at:
crng_make_state+0x148/0x1e4
     other info that might help us debug this:
     context-{5:5}
    -2 locks held by swapper/0/1:
    - #0: ffffffc008f8ae00 (console_lock){+.+.}-{0:0}, at:
printk_activate_kthreads+0x10/0x54
    - #1: ffffffc009da4a28 (&meta->lock){....}-{2:2}, at:
__kfence_alloc+0x378/0x5c4
    +1 lock held by swapper/0/1:
    + #0: ffffffc009da4a28 (&meta->lock){....}-{2:2}, at:
__kfence_alloc+0x378/0x5c4
     stack backtrace:
    -CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.19.0-rc1-ebisu-00802-g06a0dd60d6e4 #431
    +CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.19.0-rc1-ebisu-00802-g06a0dd60d6e4-dirty #433
     Hardware name: Renesas Ebisu-4D board based on r8a77990 (DT)
     Call trace:
      dump_backtrace.part.0+0x98/0xc0
    @@ -33,20 +32,14 @@ Call trace:
      kmem_cache_alloc_trace+0x194/0x1dc
      __kthread_create_on_node+0x5c/0x1a8
      kthread_create_on_node+0x58/0x7c
    - printk_start_kthread.part.0+0x34/0xa8
    - printk_activate_kthreads+0x4c/0x54
    + rcu_spawn_gp_kthread+0x54/0x208
      do_one_initcall+0xec/0x278
      kernel_init_freeable+0x11c/0x214
      kernel_init+0x24/0x124
      ret_from_fork+0x10/0x20
    -rcu: Hierarchical SRCU implementation.
    -printk: console [tty0] printing thread started
     EFI services will not be available.
     smp: Bringing up secondary CPUs ...
     Detected VIPT I-cache on CPU1
     ...
    +printk: console [tty0] printing thread started

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
