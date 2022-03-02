Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2494C9FB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiCBIqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbiCBIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:45:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5837ABAB87
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:45:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CACB3B81EFE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDCCC340F1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646210705;
        bh=8/7OeTqAjG4On0QqtOdekdPWX3CpyCSVc0y74K8QYkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cv1CtNI5Oi9IiJCcBS/h/2KvXZUivj7pGiSw6nORRDetmR2fy8Vz+OJ2K71/R8b3D
         LMzX541AJoZzBNZ2SqzcvLxIbDZGWMfUZqrGnLQr3fO4c3FSakM874GRz0I6FOcjjx
         FEaFv+zckazUX6EHCZ9MZyv6mfnW91vIjxJYhhasjAKTT+pNuEQd1B6pkyRW3vT80F
         RAswqkNyhdtqge5jkc/0XpmzK3IBhDhK+5YyH+4OvPC5ZyWrX4cCC9Rl/RVA09I9r6
         43JI9Hia3NOJnCN558lkHSFYTv7P1rzSSHKFtAurO8cx7fM7/JD9PYB83aWGQERxlw
         LqvtFt+1xSV/w==
Received: by mail-yb1-f173.google.com with SMTP id u3so1885938ybh.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:45:05 -0800 (PST)
X-Gm-Message-State: AOAM533OZR0dYLUEtLQDRkVKcTytUT+4iPkv3uZoFSGjfoFwPpb0OW/T
        D0t3uEVSNDT1oUvHw/iGsYRl759doM6LdT+ysoQ=
X-Google-Smtp-Source: ABdhPJw2+b/QJSVMs0LXy9wBk70ohlnckh1B4SN3iWZzTaJvnFBhDNxlDTrhKdVI/wrCq5cS6ha13l+RIxYr5lpU2RA=
X-Received: by 2002:a25:6409:0:b0:628:a9bd:6b63 with SMTP id
 y9-20020a256409000000b00628a9bd6b63mr472823ybb.432.1646210704037; Wed, 02 Mar
 2022 00:45:04 -0800 (PST)
MIME-Version: 1.0
References: <Yh5ASXVoWoMj7/Rr@Red> <Yh5AlfprVAZvJDJA@shell.armlinux.org.uk>
 <CAMj1kXGRTM99F_Q29Q4G2Q4L6WSHn2YY+_QZCXQGmw=yWPe1mQ@mail.gmail.com>
 <CAMj1kXEy6n3zZ8Z51kP=tTuOU0xCXLLfC-b6BMpdsjMoM7zGBg@mail.gmail.com> <Yh8tWdiWPgZLyQtx@Red>
In-Reply-To: <Yh8tWdiWPgZLyQtx@Red>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Mar 2022 09:44:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGRtdftpoqmd7HBonBBS67jO=YWzoESPAagGfQBZUDQWg@mail.gmail.com>
Message-ID: <CAMj1kXGRtdftpoqmd7HBonBBS67jO=YWzoESPAagGfQBZUDQWg@mail.gmail.com>
Subject: Re: boot flooded with unwind: Index not found
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_HEX autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 09:40, Corentin Labbe <clabbe.montjoie@gmail.com> wro=
te:
>
> Le Tue, Mar 01, 2022 at 05:52:30PM +0100, Ard Biesheuvel a =C3=A9crit :
> > On Tue, 1 Mar 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Tue, 1 Mar 2022 at 16:52, Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Tue, Mar 01, 2022 at 04:48:25PM +0100, Corentin Labbe wrote:
> > > > > Hello
> > > > >
> > > > > I booted today linux-next (20220301) and my boot is flooded with:
> > > > > [    0.000000] unwind: Index not found c0f0c440
> > > > > [    0.000000] unwind: Index not found 00000000
> > > > > [    0.000000] unwind: Index not found c0f0c440
> > > > > [    0.000000] unwind: Index not found 00000000
> > > > >
> > > > > This happen on a sun8i-a83t-bananapi-m3
> > > >
> > > > Have you enabled vmapped stacks?
> > > >
> > >
> > > This is probably related to
> > >
> > > 538b9265c063 ARM: unwind: track location of LR value in stack frame
> > >
> > > which removes a kernel_text_address() check on frame->pc as it is
> > > essentially redundant, given that we won't find unwind data otherwise=
.
> > > Unfortunately, I failed to realise that the other check carries a
> > > pr_warn(), which may apparently fire spuriously in some cases.
> > >
> > > The 0x0 value can easily be filtered out, but i would be interesting
> > > where the other value originates from. We might be able to solve this
> > > with a simple .nounwind directive in a asm routine somewhere.
> > >
> > > I'll prepare a patch that disregards the 0x0 value - could you check
> > > in the mean time what the address 0xcf0c440 coincides with in your
> > > build?
> >
> > Something like the below should restore the previous behavior, while
> > taking the kernel_text_address() check out of the hot path.
> >
> > --- a/arch/arm/kernel/unwind.c
> > +++ b/arch/arm/kernel/unwind.c
> > @@ -400,7 +400,8 @@ int unwind_frame(struct stackframe *frame)
> >
> >         idx =3D unwind_find_idx(frame->pc);
> >         if (!idx) {
> > -               pr_warn("unwind: Index not found %08lx\n", frame->pc);
> > +               if (frame->pc && kernel_text_address(frame->pc))
> > +                       pr_warn("unwind: Index not found %08lx\n", fram=
e->pc);
> >                 return -URC_FAILURE;
> >         }
>
> Hello
>
> This is a more detailed trace from my follow up after your patch:

So the log below is from a kernel that has the above patch applied?
Could you please share the .config?


> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing ins=
truction cache
> [    0.000000] OF: fdt: Machine model: Banana Pi BPI-M3
> [    0.000000] earlycon: uart0 at MMIO32 0x01c28000 (options '')
> [    0.000000] printk: bootconsole [uart0] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] cma: Reserved 16 MiB at 0xbf000000
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000040000000-0x000000006fffffff]
> [    0.000000]   HighMem  [mem 0x0000000070000000-0x00000000bfffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000bff=
fffff]
> [    0.000000] percpu: Embedded 16 pages/cpu s34740 r8192 d22604 u65536
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522=
752
> [    0.000000] Kernel command line: console=3DttyS0,115200n8 root=3D/dev/=
ram0 earlycon=3Duart,mmio32,0x01c28000 ip=3Ddhcp
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 =
bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 2015596K/2097152K available (9216K kernel code, 15=
42K rwdata, 3468K rodata, 1024K init, 7190K bss, 65172K reserved, 16384K cm=
a-reserved, 1294336K highmem)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8,=
 Nodes=3D1
> [    0.000000] trace event string verifier disabled
> [    0.000000] Running RCU self tests
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000] rcu:     RCU lockdep checking is enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is=
 10 jiffies.
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on content=
ion.
> [    0.000000] random: get_random_bytes called from start_kernel+0x534/0x=
6cc with crng_init=3D0
> [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_=
cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000003] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps ever=
y 4398046511097ns
> [    0.008654] Switching to timer-based delay loop, resolution 41ns
> [    0.015612] clocksource: timer: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 79635851949 ns
> [    0.026625] Console: colour dummy device 80x30
> [    0.031541] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc=
., Ingo Molnar
> [    0.039985] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.044455] ... MAX_LOCK_DEPTH:          48
> [    0.049009] ... MAX_LOCKDEP_KEYS:        8192
> [    0.053781] ... CLASSHASH_SIZE:          4096
> [    0.058518] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.063349] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.068214] ... CHAINHASH_SIZE:          32768
> [    0.073055]  memory used by lock dependency info: 4061 kB
> [    0.078950]  memory used for stack traces: 2112 kB
> [    0.084155]  per task-struct memory footprint: 1536 bytes
> [    0.090217] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 48.00 BogoMIPS (lpj=3D240000)
> [    0.101518] pid_max: default: 32768 minimum: 301
> [    0.107666] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes=
, linear)
> [    0.115682] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 =
bytes, linear)
> [    0.127870] CPU: Testing write buffer coherency: ok
> [    0.135278] /cpus/cpu@0 missing clock-frequency property
> [    0.141378] /cpus/cpu@1 missing clock-frequency property
> [    0.147357] /cpus/cpu@2 missing clock-frequency property
> [    0.153416] /cpus/cpu@3 missing clock-frequency property
> [    0.159451] /cpus/cpu@100 missing clock-frequency property
> [    0.165776] /cpus/cpu@101 missing clock-frequency property
> [    0.172064] /cpus/cpu@102 missing clock-frequency property
> [    0.178450] /cpus/cpu@103 missing clock-frequency property
> [    0.184459] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.196481] Setting up static identity map for 0x40100000 - 0x40100060
> [    0.206495] ARM CCI driver probed
> [    0.211504] sunxi multi cluster SMP support installed
> [    0.218782] rcu: Hierarchical SRCU implementation.
> [    0.229101] smp: Bringing up secondary CPUs ...
> [    0.239445] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.239515]
> [    0.239521]
> [    0.239529] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    0.239533] WARNING: suspicious RCU usage
> [    0.239539] 5.17.0-rc6-next-20220301-00133-g3d7bbd89fe38-dirty #198 No=
t tainted
> [    0.239547] -----------------------------
> [    0.239550] include/trace/events/lock.h:58 suspicious rcu_dereference_=
check() usage!
> [    0.239559]
> [    0.239559] other info that might help us debug this:
> [    0.239559]
> [    0.239563]
> [    0.239563] rcu_scheduler_active =3D 1, debug_locks =3D 1
> [    0.239570] RCU used illegally from extended quiescent state!
> [    0.239574] 1 lock held by swapper/0/0:
> [    0.239581]  #0: c0f15b4c ((console_sem).lock){-...}-{2:2}, at: down_t=
rylock+0xc/0x2c
> [    0.239652]
> [    0.239652] stack backtrace:
> [    0.239659] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc6-next-=
20220301-00133-g3d7bbd89fe38-dirty #198
> [    0.239671] Hardware name: Allwinner A83t board
> [    0.239680]  unwind_backtrace from show_stack+0x10/0x14
> [    0.239706]  show_stack from init_stack+0x1c54/0x2000
> [    0.343924] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    0.348249] WARNING: suspicious RCU usage
> [    0.352574] 5.17.0-rc6-next-20220301-00133-g3d7bbd89fe38-dirty #198 No=
t tainted
> [    0.360463] -----------------------------
> [    0.364795] include/trace/events/lock.h:13 suspicious rcu_dereference_=
check() usage!
> [    0.373153]
> [    0.373153] other info that might help us debug this:
> [    0.373153]
> [    0.381786]
> [    0.381786] rcu_scheduler_active =3D 1, debug_locks =3D 1
> [    0.388835] RCU used illegally from extended quiescent state!
> [    0.395031] no locks held by swapper/0/0.
> [    0.399357]
> [    0.399357] stack backtrace:
> [    0.404063] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc6-next-=
20220301-00133-g3d7bbd89fe38-dirty #198
> [    0.414764] Hardware name: Allwinner A83t board
> [    0.419654]  unwind_backtrace from show_stack+0x10/0x14
> [    0.425310]  show_stack from init_stack+0x1d5c/0x2000
> [    0.437285] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> [    0.443866] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> [    0.450159] CPU4: thread -1, cpu 0, socket 1, mpidr 80000100
> [    0.456318] CPU5: thread -1, cpu 1, socket 1, mpidr 80000101
> [    0.463067] CPU6: thread -1, cpu 2, socket 1, mpidr 80000102
> [    0.469085] CPU7: thread -1, cpu 3, socket 1, mpidr 80000103
> [    0.470310] smp: Brought up 1 node, 8 CPUs
> [    0.511987] SMP: Total of 8 processors activated (384.00 BogoMIPS).
> [    0.518815] CPU: All CPU(s) started in SVC mode.
> [    0.528747] devtmpfs: initialized
> [    0.575460] VFP support v0.3: implementor 41 architecture 2 part 30 va=
riant 7 rev 5
> [    0.635349] DMA-API: preallocated 65536 debug entries
> [    0.640942] DMA-API: debugging enabled by kernel config
> [    0.646798] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 19112604462750000 ns
> [    0.657668] futex hash table entries: 2048 (order: 5, 131072 bytes, li=
near)
> [    0.667801] pinctrl core: initialized pinctrl subsystem
> [    0.680682] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.707352] DMA: preallocated 256 KiB pool for atomic coherent allocat=
ions
> [    0.721297] thermal_sys: Registered thermal governor 'step_wise'
> [    0.727127] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watc=
hpoint registers.
> [    0.742484] hw-breakpoint: maximum watchpoint size is 8 bytes.
> [    0.845166] platform 1c0c000.lcd-controller: Fixing up cyclic dependen=
cy with 1200000.mixer
> [    0.854770] platform 1c0c000.lcd-controller: Fixing up cyclic dependen=
cy with 1100000.mixer
> [    0.868363] platform 1c0d000.lcd-controller: Fixing up cyclic dependen=
cy with 1200000.mixer
> [    0.877968] platform 1c0d000.lcd-controller: Fixing up cyclic dependen=
cy with 1100000.mixer
> [    0.948337] platform 1ee0000.hdmi: Fixing up cyclic dependency with 1c=
0d000.lcd-controller
> [    0.985080] platform connector: Fixing up cyclic dependency with 1ee00=
00.hdmi
> [    1.055999] SCSI subsystem initialized
> [    1.062543] usbcore: registered new interface driver usbfs
> [    1.069061] usbcore: registered new interface driver hub
> [    1.075249] usbcore: registered new device driver usb
> [    1.082481] mc: Linux media interface: v0.10
> [    1.087480] videodev: Linux video capture interface: v2.00
> [    1.093822] pps_core: LinuxPPS API ver. 1 registered
> [    1.099235] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giometti <giometti@linux.it>
> [    1.109239] PTP clock support registered
> [    1.115805] Advanced Linux Sound Architecture Driver Initialized.
> [    1.128823] clocksource: Switched to clocksource arch_sys_counter
> [    1.840156] NET: Registered PF_INET protocol family
> [    1.846279] IP idents hash table entries: 16384 (order: 5, 131072 byte=
s, linear)
> [    1.857520] tcp_listen_portaddr_hash hash table entries: 512 (order: 2=
, 22528 bytes, linear)
> [    1.866898] TCP established hash table entries: 8192 (order: 3, 32768 =
bytes, linear)
> [    1.876120] TCP bind hash table entries: 8192 (order: 6, 327680 bytes,=
 linear)
> [    1.885881] TCP: Hash tables configured (established 8192 bind 8192)
> [    1.894083] UDP hash table entries: 512 (order: 3, 49152 bytes, linear=
)
> [    1.901714] UDP-Lite hash table entries: 512 (order: 3, 49152 bytes, l=
inear)
> [    1.910798] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    1.922517] RPC: Registered named UNIX socket transport module.
> [    1.929185] RPC: Registered udp transport module.
> [    1.934335] RPC: Registered tcp transport module.
> [    1.939594] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    1.950532] Trying to unpack rootfs image as initramfs...
> [    1.955690] Initialise system trusted keyrings
> [    1.963169] workingset: timestamp_bits=3D30 max_order=3D19 bucket_orde=
r=3D0
> [    2.019818] NFS: Registering the id_resolver key type
> [    2.025553] Key type id_resolver registered
> [    2.030337] Key type id_legacy registered
> [    2.129933] NET: Registered PF_ALG protocol family
> [    2.135490] Key type asymmetric registered
> [    2.140166] Asymmetric key parser 'x509' registered
> [    2.147479] bounce: pool size: 64 pages
> [    2.152643] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 247)
> [    2.161050] io scheduler mq-deadline registered
> [    2.166023] io scheduler kyber registered
> [    2.818294] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
> [    2.911286] brd: module loaded
> [    2.990798] loop: module loaded
> [    3.011369] CAN device driver interface
> [    3.022864] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    3.030150] ehci-platform: EHCI generic platform driver
> [    3.037461] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    3.044379] ohci-platform: OHCI generic platform driver
> [    3.063534] i2c_dev: i2c /dev entries driver
> [    3.080741] sun8i-rotate 1020000.rotate: Device registered as /dev/vid=
eo0
> [    3.102983] sunxi-wdt 1c20ca0.watchdog: Watchdog enabled (timeout=3D16=
 sec, nowayout=3D0)
> [    3.115379] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialise=
d: dm-devel@redhat.com
> [    3.140183] sun8i-ss 1c15000.crypto: will run requests pump with realt=
ime priority
> [    3.150005] sun8i-ss 1c15000.crypto: will run requests pump with realt=
ime priority
> [    3.159248] sun8i-ss 1c15000.crypto: DEBUG: Register cbc(aes)
> [    3.165597] sun8i-ss 1c15000.crypto: DEBUG: Register ecb(aes)
> [    3.172073] sun8i-ss 1c15000.crypto: DEBUG: Register cbc(des3_ede)
> [    3.178940] sun8i-ss 1c15000.crypto: DEBUG: Register ecb(des3_ede)
> [    3.185718] sun8i-ss 1c15000.crypto: Register md5
> [    3.190968] sun8i-ss 1c15000.crypto: Register sha1
> [    3.196237] sun8i-ss 1c15000.crypto: Register sha224
> [    3.201892] sun8i-ss 1c15000.crypto: Register sha256
> [    3.207372] sun8i-ss 1c15000.crypto: Register hmac(sha1)
> [    3.213967] sun8i-ss 1c15000.crypto: Security System Die ID 7
> [    3.226428] usbcore: registered new interface driver usbhid
> [    3.232650] usbhid: USB HID core driver
> [    3.265675] Initializing XFRM netlink socket
> [    3.270845] NET: Registered PF_PACKET protocol family
> [    3.276493] can: controller area network core
> [    3.281937] NET: Registered PF_CAN protocol family
> [    3.287198] can: raw protocol
> [    3.290825] can: broadcast manager protocol
> [    3.295480] can: netlink gateway - max_hops=3D1
> [    3.301621] Key type dns_resolver registered
> [    3.306640] Registering SWP/SWPB emulation handler
> [    3.323559] Loading compiled-in X.509 certificates
> [    3.338045] alg: extra crypto tests enabled.  This is intended for dev=
eloper use only.
> [    6.454305] Freeing initrd memory: 24268K
> [    6.577353] sun8i-ss 1c15000.crypto: Fallback for hmac-sha1-sun8i-ss i=
s hmac(sha1-generic)
> [    6.935170] sun8i-ss 1c15000.crypto: Fallback for sha256-sun8i-ss is s=
ha256-generic
> [    7.205127] sun8i-ss 1c15000.crypto: Fallback for sha224-sun8i-ss is s=
ha224-generic
> [    7.451810] sun8i-ss 1c15000.crypto: Fallback for sha1-sun8i-ss is sha=
1-generic
> [    7.704434] sun8i-ss 1c15000.crypto: Fallback for md5-sun8i-ss is md5-=
generic
> [    7.811076] random: fast init done
> [    7.897484] alg_test_stdrng test sun8i-ss-prng
> [    7.995818] sun8i-ss 1c15000.crypto: Fallback for ecb-des3-sun8i-ss is=
 ecb(des3_ede-generic)
> [    8.751380] sun8i-ss 1c15000.crypto: Fallback for cbc-des3-sun8i-ss is=
 cbc(des3_ede-generic)
> [    9.580606] sun8i-ss 1c15000.crypto: Fallback for ecb-aes-sun8i-ss is =
ecb(aes-generic)
> [    9.943526] sun8i-ss 1c15000.crypto: Fallback for cbc-aes-sun8i-ss is =
cbc(aes-generic)
> [   10.307336] alg_test_stdrng test drbg_nopr_hmac_sha512
> [   10.553558] alg_test_stdrng test drbg_nopr_hmac_sha256
> [   10.749710] alg_test_stdrng test drbg_nopr_hmac_sha384
> [   10.994919] alg_test_stdrng test drbg_nopr_hmac_sha1
> [   11.027045] alg_test_stdrng test drbg_nopr_sha256
> [   11.079874] alg_test_stdrng test drbg_nopr_sha512
> [   11.131980] alg_test_stdrng test drbg_nopr_sha384
> [   11.182511] alg_test_stdrng test drbg_nopr_sha1
> [   11.213096] alg_test_stdrng test drbg_nopr_ctr_aes256
> [   11.391601] alg_test_stdrng test drbg_nopr_ctr_aes192
> [   11.436864] alg_test_stdrng test drbg_nopr_ctr_aes128
> [   11.470634] alg_test_stdrng test drbg_pr_hmac_sha512
> [   11.548614] alg_test_stdrng test drbg_pr_hmac_sha256
> [   11.627097] alg_test_stdrng test drbg_pr_hmac_sha384
> [   11.704620] alg_test_stdrng test drbg_pr_hmac_sha1
> [   11.750945] alg_test_stdrng test drbg_pr_sha256
> [   11.829385] alg_test_stdrng test drbg_pr_sha512
> [   11.906740] alg_test_stdrng test drbg_pr_sha384
> [   11.984845] alg_test_stdrng test drbg_pr_sha1
> [   12.030321] alg_test_stdrng test drbg_pr_ctr_aes256
> [   12.107965] alg_test_stdrng test drbg_pr_ctr_aes192
> [   12.172472] alg_test_stdrng test drbg_pr_ctr_aes128
> [   12.218850] alg_test_stdrng test ansi_cprng
> [   15.230417] sun8i-a83t-pinctrl 1c20800.pinctrl: initialized sunXi PIO =
driver
> [   15.253549] sun8i-a83t-r-pinctrl 1f02c00.pinctrl: initialized sunXi PI=
O driver
> [   15.265102] sun8i-a83t-pinctrl 1c20800.pinctrl: supply vcc-pb not foun=
d, using dummy regulator
> [   15.292713] printk: console [ttyS0] disabled
> [   15.318528] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq =3D 54, base_=
baud =3D 1500000) is a U6_16550A
> [   15.329196] printk: console [ttyS0] enabled
> [   15.329196] printk: console [ttyS0] enabled
> [   15.337981] printk: bootconsole [uart0] disabled
> [   15.337981] printk: bootconsole [uart0] disabled
> [   15.353739] sun8i-a83t-pinctrl 1c20800.pinctrl: supply vcc-pg not foun=
d, using dummy regulator
> [   15.397215] 1c28400.serial: ttyS1 at MMIO 0x1c28400 (irq =3D 55, base_=
baud =3D 1500000) is a U6_16550A
> [   15.420171] sun8i-a83t-r-pinctrl 1f02c00.pinctrl: supply vcc-pl not fo=
und, using dummy regulator
> [   15.432016] Registered IR keymap rc-empty
> [   15.436862] rc rc0: sunxi-ir as /devices/platform/soc/1f02000.ir/rc/rc=
0
> [   15.444488] input: sunxi-ir as /devices/platform/soc/1f02000.ir/rc/rc0=
/input0
> [   15.456659] sunxi-ir 1f02000.ir: initialized sunXi IR driver
> [   15.496947] sun8i-a83t-pinctrl 1c20800.pinctrl: supply vcc-pd not foun=
d, using dummy regulator
> [   15.511818] sunxi-rsb 1f03400.rsb: RSB running at 3000000 Hz
> [   15.521011] axp20x-rsb sunxi-rsb-3a3: AXP20x variant AXP813 found
> [   15.553157] input: axp20x-pek as /devices/platform/soc/1f03400.rsb/sun=
xi-rsb-3a3/axp221-pek/input/input1
> [   15.591742] vcc-dram: Bringing 1180000uV into 1200000-1200000uV
> [   15.632089] vcc-wifi: Bringing 2900000uV into 3300000-3300000uV
> [   15.719380] axp20x-adc axp813-adc: DMA mask not set
> [   15.731930] axp20x-battery-power-supply axp20x-battery-power-supply: D=
MA mask not set
> [   15.748351] axp20x-ac-power-supply axp20x-ac-power-supply: DMA mask no=
t set
> [   15.772317] axp20x-usb-power-supply axp20x-usb-power-supply: DMA mask =
not set
> [   15.789744] axp20x-rsb sunxi-rsb-3a3: AXP20X driver loaded
> [   15.813791] sun8i-a83t-pinctrl 1c20800.pinctrl: supply vcc-ph not foun=
d, using dummy regulator
> [   15.838994] dwmac-sun8i 1c30000.ethernet: IRQ eth_wake_irq not found
> [   15.845480] dwmac-sun8i 1c30000.ethernet: IRQ eth_lpi not found
> [   15.855879] dwmac-sun8i 1c30000.ethernet: PTP uses main clock
> [   15.862064] dwmac-sun8i 1c30000.ethernet: Current syscon value is not =
the default 1ce6 (expect 0)
> [   15.874428] dwmac-sun8i 1c30000.ethernet: No HW DMA feature register s=
upported
> [   15.881864] dwmac-sun8i 1c30000.ethernet: RX Checksum Offload Engine s=
upported
> [   15.889252] dwmac-sun8i 1c30000.ethernet: COE Type 2
> [   15.894287] dwmac-sun8i 1c30000.ethernet: TX Checksum insertion suppor=
ted
> [   15.901212] dwmac-sun8i 1c30000.ethernet: Normal descriptors
> [   15.906939] dwmac-sun8i 1c30000.ethernet: Chain mode enabled
> [   15.975999] ehci-platform 1c1a000.usb: EHCI Host Controller
> [   15.982427] ehci-platform 1c1a000.usb: new USB bus registered, assigne=
d bus number 1
> [   15.997426] ehci-platform 1c1a000.usb: irq 48, io mem 0x01c1a000
> [   16.028860] ehci-platform 1c1a000.usb: USB 2.0 started, EHCI 1.00
> [   16.044389] hub 1-0:1.0: USB hub found
> [   16.048913] hub 1-0:1.0: 1 port detected
> [   16.063451] usb_phy_generic usb_phy_generic.0.auto: supply vcc not fou=
nd, using dummy regulator
> [   16.080515] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
> [   16.086669] musb-hdrc musb-hdrc.1.auto: new USB bus registered, assign=
ed bus number 2
> [   16.106365] hub 2-0:1.0: USB hub found
> [   16.111270] hub 2-0:1.0: 1 port detected
> [   16.193991] sun8i-a83t-pinctrl 1c20800.pinctrl: supply vcc-pf not foun=
d, using dummy regulator
> [   16.196692] sun8i-a83t-pinctrl 1c20800.pinctrl: supply vcc-pc not foun=
d, using dummy regulator
> [   16.270439] sunxi-mmc 1c0f000.mmc: Got CD GPIO
> [   16.304500] sunxi-mmc 1c0f000.mmc: initialized, max. request size: 163=
84 KB
> [   16.313850] sunxi-mmc 1c11000.mmc: initialized, max. request size: 163=
84 KB, uses new timings mode
> [   16.330874] dwmac-sun8i 1c30000.ethernet eth0: PHY [stmmac-0:01] drive=
r [RTL8211E Gigabit Ethernet] (irq=3DPOLL)
> [   16.359236] usb 1-1: new high-speed USB device number 2 using ehci-pla=
tform
> [   16.375986] dwmac-sun8i 1c30000.ethernet eth0: Register MEM_TYPE_PAGE_=
POOL RxQ-0
> [   16.378191] mmc1: host does not support reading read-only switch, assu=
ming write-enable
> [   16.383272] mmc2: new DDR MMC card at address 0001
> [   16.390143] mmcblk2: mmc2:0001 8WPD3R 7.28 GiB
> [   16.395281] mmc1: new high speed SDHC card at address 59b4
> [   16.413063] mmcblk1: mmc1:59b4 SMI   7.50 GiB
> [   16.425756] mmcblk2boot0: mmc2:0001 8WPD3R 4.00 MiB
> [   16.437832]  mmcblk1: p1
> [   16.447435] mmcblk2boot1: mmc2:0001 8WPD3R 4.00 MiB
> [   16.462264] dwmac-sun8i 1c30000.ethernet eth0: No Safety Features supp=
ort found
> [   16.469871] dwmac-sun8i 1c30000.ethernet eth0: No MAC Management Count=
ers available
> [   16.477704] dwmac-sun8i 1c30000.ethernet eth0: PTP not supported by HW
> [   16.496769] dwmac-sun8i 1c30000.ethernet eth0: configuring for phy/rgm=
ii-id link mode
> [   16.585365] hub 1-1:1.0: USB hub found
> [   16.591452] hub 1-1:1.0: 4 ports detected
> [   17.019079] usb 1-1.1: new high-speed USB device number 3 using ehci-p=
latform
> [   19.662500] dwmac-sun8i 1c30000.ethernet eth0: Link is Up - 100Mbps/Ha=
lf - flow control off
> [   19.699027] Sending DHCP requests ..., OK
> [   25.684277] IP-Config: Got DHCP answer from 192.168.1.100, my address =
is 192.168.1.206
> [   25.692650] IP-Config: Complete:
> [   25.696020]      device=3Deth0, hwaddr=3D02:01:2a:37:9f:4d, ipaddr=3D1=
92.168.1.206, mask=3D255.255.255.0, gw=3D192.168.1.1
> [   25.706583]      host=3D192.168.1.206, domain=3D, nis-domain=3D(none)
> [   25.712760]      bootserver=3D192.168.1.100, rootserver=3D192.168.1.10=
0, rootpath=3D
> [   25.712868]      nameserver0=3D192.168.1.100
> [   25.730678] ALSA device list:
> [   25.734085]   No soundcards found.
> [   25.773872] Freeing unused kernel image (initmem) memory: 1024K
> [   25.850909] Run /init as init process
> Starting syslogd: OK
> Starting klogd: OK
> Running sysctl: OK
> Populating /dev using udev: [   27.010526] udevd[229]: starting version 3=
.2.10
> [   27.020221] random: udevd: uninitialized urandom read (16 bytes read)
> [   27.028018] random: udevd: uninitialized urandom read (16 bytes read)
> [   27.034847] random: udevd: uninitialized urandom read (16 bytes read)
> [   27.092031] udevd[230]: starting eudev-3.2.10
> [   28.155904] urandom_read: 1 callbacks suppressed
> [   28.155986] random: udevd: uninitialized urandom read (16 bytes read)
> [   28.265267] random: udevd: uninitialized urandom read (16 bytes read)
> [   28.319448] 8<--- cut here ---
> [   28.322595] Unable to handle kernel paging request at virtual address =
60000013
> [   28.329845] [60000013] *pgd=3D00000000
> [   28.333496] Internal error: Oops: 5 [#1] SMP ARM
> [   28.338161] Modules linked in:
> [   28.341249] CPU: 7 PID: 252 Comm: udevd Not tainted 5.17.0-rc6-next-20=
220301-00133-g3d7bbd89fe38-dirty #198
> [   28.351003] Hardware name: Allwinner A83t board
> [   28.355550] PC is at unwind_frame+0x4c0/0x6a0
> [   28.359959] LR is at __start_unwind_idx+0x10/0x32ce8
> [   28.364961] pc : [<c010f28c>]    lr : [<c0d636d8>]    psr: 60000193
> [   28.371233] sp : f14118b0  ip : c0d636d8  fp : 00000000
> [   28.376471] r10: 00000001  r9 : c14f7818  r8 : 60000013
> [   28.381706] r7 : f141195c  r6 : 60002000  r5 : 00000002  r4 : 60000013
> [   28.388243] r3 : 00000000  r2 : c0d96414  r1 : 0000000f  r0 : f14118c8
> [   28.394784] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segm=
ent none
> [   28.402027] Control: 10c5387d  Table: 4576c06a  DAC: 00000051
> [   28.407794] Register r0 information: 2-page vmalloc region starting at=
 0xf1410000 allocated at kernel_clone+0x54/0x410
> [   28.418558] Register r1 information: non-paged memory
> [   28.423670] Register r2 information: non-slab/vmalloc memory
> [   28.429365] Register r3 information: NULL pointer
> [   28.434087] Register r4 information: non-paged memory
> [   28.439163] Register r5 information: non-paged memory
> [   28.444237] Register r6 information: non-paged memory
> [   28.449305] Register r7 information: 2-page vmalloc region starting at=
 0xf1410000 allocated at kernel_clone+0x54/0x410
> [   28.460049] Register r8 information: non-paged memory
> [   28.465189] Register r9 information: non-slab/vmalloc memory
> [   28.470916] Register r10 information: non-paged memory
> [   28.476142] Register r11 information: NULL pointer
> [   28.481031] Register r12 information: non-slab/vmalloc memory
> [   28.486864] Process udevd (pid: 252, stack limit =3D 0x(ptrval))
> [   28.492795] Stack: (0xf14118b0 to 0xf1412000)
> [   28.497191] 18a0:                                     00000000 c5654ec=
0 ffffe000 c0c64d48
> [   28.505383] 18c0: 00000041 c0f0959c c5655638 c169015c c14d7cd8 a29ed94=
4 c018c928 60000013
> [   28.513571] 18e0: ffffffff f1411c9c 2e174000 c5654ec0 00000000 6000001=
3 c14e2b38 60000013
> [   28.521757] 1900: c0100af4 00000000 c5655658 a29ed944 c5654ec0 c5654ec=
0 c0e5d5b8 c0e5d5b8
> [   28.529944] 1920: f1411938 a29ed944 00000080 c5654ec0 deadbeef c0f0959=
c c12bbfa0 c1084680
> [   28.538131] 1940: c14f7818 c12bab18 f1411984 c010aea8 f141198c 0000000=
0 00000000 60000013
> [   28.546320] 1960: f1411c68 c0100af4 c0100af4 f1411c64 f1411c48 a29ed94=
4 c5655638 c5654ec0
> [   28.554508] 1980: c12bbfb0 c01c2664 00000001 00000008 0007fada c12bbfb=
0 00000004 a29ed944
> [   28.562696] 19a0: c5655638 c0185b4c c14e4cd0 a29ed944 00000041 0000052=
2 c14e4cd0 c5655698
> [   28.570884] 19c0: c14e449c a29ed944 c0f0e640 c5655638 c14f7818 c0f0959=
c c169015c c0c65e00
> [   28.579071] 19e0: c14f7818 c5655658 c14e2b38 c018b168 00000000 0000001=
8 f1411adc a29ed944
> [   28.587263] 1a00: 60000093 c0f0e630 c0f0e630 c1084680 c5654ec0 c0f0959=
c 00000001 c169015c
> [   28.595454] 1a20: 00000000 c0f09598 c0e5d5b8 00000001 c0f0959c c01845d=
4 7d56fa57 660cde72
> [   28.603644] 1a40: c0c68134 c0c6daa4 c01844b0 00000001 00000000 0000000=
0 c01c2664 c5654ec0
> [   28.611840] 1a60: c0e5d5b8 00000001 00000041 c14f7808 c5655638 f1411b0=
4 014d87c4 00000000
> [   28.620028] 1a80: f1411aec f1411aec c0f0959c c0c65e00 c0c68134 0000000=
0 c5655638 a29ed944
> [   28.628215] 1aa0: c5654ec0 c5654ec0 c0e5d5b8 c0e5d5b8 f1411ac8 2e17400=
0 00000080 00000000
> [   28.636403] 1ac0: 60000193 c018c90c 00000001 00000080 00000000 c010f15=
4 00000000 00000000
> [   28.644586] 1ae0: f1411af0 00000000 f1411aec f1411aec f1411ad0 a29ed94=
4 c14e3434 c5654ec0
> [   28.652771] 1b00: c12bbfb0 c01c2664 c5654ec0 00000000 0007fada a29ed94=
4 00000004 c0f0e630
> [   28.660955] 1b20: c010f154 60000193 f1411c1c f1411c30 c5654ec0 0000000=
0 00000000 c0973b98
> [   28.669141] 1b40: 00000001 00000000 c010f154 00000009 f1411c1c c0f0e63=
0 c0f0e630 c010f154
> [   28.677328] 1b60: c108468c c5654ec0 ffffe000 c0c64d48 f1411b90 0000001=
8 c1084680 c0e5d5b8
> [   28.685514] 1b80: c0f09598 00000005 00000001 00000001 00000000 f1411c4=
4 f1411c10 c0217308
> [   28.693697] 1ba0: c0217308 f1411c44 00000000 f1411c30 00000000 0000000=
0 c14e3434 00000000
> [   28.701878] 1bc0: c14f7808 00010000 00000354 2e174000 c5654ec0 a29ed94=
4 c14e2b38 f1411c1c
> [   28.710060] 1be0: f1411c14 c010be28 f1411c9c 2e174000 c5654ec0 0000000=
0 f1411c44 c010ad40
> [   28.718243] 1c00: 00000000 c5654ec0 00000001 c010bea4 00000001 0000000=
0 00000000 f1411c44
> [   28.726434] 1c20: f1411c30 00000000 00000000 f1411c2c f1411c10 a29ed94=
4 c5654ec0 c0100af4
> [   28.734621] 1c40: 60000013 c0217308 c018c928 60000013 ffffffff f1411c9=
c 2e174000 c5654ec0
> [   28.742806] 1c60: 00000000 c0100af4 00000001 0000000f 2e174000 0000000=
0 c5654ec0 c0e5d5b8
> [   28.750991] 1c80: c0e5d5b8 f1411cb8 2e174000 00000000 00000000 6000001=
3 ffffffff f1411cb8
> [   28.759178] 1ca0: c0185d38 c018c928 60000013 ffffffff 00000051 c018c90=
c 00000001 00000000
> [   28.767357] 1cc0: 00000000 c03683e4 00000000 00000000 f1411ce8 0000000=
0 00000000 00000000
> [   28.775538] 1ce0: 60000013 c018c90c 00000001 00000000 00000000 c04cab6=
8 00000000 00000000
> [   28.783724] 1d00: c5655638 a29ed944 c5654ec0 c27ad478 c1804200 c27ad47=
8 c57183c0 c03683b8
> [   28.791907] 1d20: c57183c8 00000142 00000000 c0366a44 00000001 0000000=
0 c03683e4 c018c564
> [   28.800095] 1d40: c57183c0 c03683e4 c57183c0 c57183c0 00000000 c38a02b=
0 c5282ba8 c57183c0
> [   28.808278] 1d60: c38a02b0 00000000 c57183c0 c03683b8 c57183c8 0000014=
2 00000000 c02be950
> [   28.816467] 1d80: 00020000 c0f11eac 00000000 c57183c0 f1411e70 f1411f3=
0 00000142 c02d5528
> [   28.824651] 1da0: 00005a04 c0f0959c c5655638 c169015c c14bec14 0000000=
0 00000000 fffffffe
> [   28.832832] 1dc0: 000017ff 00001000 c0c84818 00000000 c5654ec0 0000004=
1 00000000 c0c8481c
> [   28.841018] 1de0: 00005a04 00000000 00001000 00000000 00000000 0000000=
0 00203000 00000000
> [   28.849202] 1e00: 0000001c 00000000 0000000c a29ed944 c5654ec0 c5654ec=
0 c0e5d5b8 c0e5d5b8
> [   28.857385] 1e20: f1411e38 2e174000 00000000 a29ed944 c5654ec0 c5654ec=
0 c0e5d5b8 c0e5d5b8
> [   28.865572] 1e40: f1411e58 a29ed944 00000000 c5654ec0 c561a000 f1411f3=
0 00000001 c5654ec0
> [   28.873757] 1e60: c5654ec0 00000142 0005c03c c02d62a0 c3dfe490 c5282b4=
0 340e8a69 00000004
> [   28.881947] 1e80: c561a04e c5655638 c18990d0 c1c020c0 c38a02b0 0000010=
1 00000002 00000000
> [   28.890130] 1ea0: 000000f4 0000002e 00000000 00000000 00000000 f1411eb=
8 00000000 a29ed944
> [   28.898316] 1ec0: c544a6c0 c544a640 c544a678 00000000 c544a6c0 c544a64=
0 c544a678 c0973d1c
> [   28.906500] 1ee0: 00000008 c02e8a18 c561a000 00000000 00000002 ffffff9=
c 00000000 f14141ed
> [   28.914689] 1f00: c561a000 a29ed944 ffffff9c f1411f60 c561a000 0000000=
8 ffffff9c c02c0788
> [   28.922874] 1f20: 0000001c 00000000 c1802c00 c561a000 00020000 c02c000=
0 00000004 00000100
> [   28.931059] 1f40: 00000001 a29ed944 c5654ec0 ffffff9c bec6f330 0000014=
2 c0100244 c02c0c04
> [   28.939245] 1f60: 000a0000 00000000 00000000 00000000 00000000 0000000=
0 000a0000 00000000
> [   28.947433] 1f80: 00000000 00000000 00000000 00000000 00000000 a29ed94=
4 00000000 b6f4ab60
> [   28.955619] 1fa0: bec6f730 c0100060 00000000 b6f4ab60 ffffff9c bec6f33=
0 000a0000 00000000
> [   28.963803] 1fc0: 00000000 b6f4ab60 bec6f730 00000142 0005880c bec6f33=
0 000573f4 0005c03c
> [   28.971985] 1fe0: 000571b4 bec6f288 b6c22138 b6c22158 60000010 ffffff9=
c 00000000 00000000
> [   28.980163]  unwind_frame from __save_stack_trace+0x70/0x94
> [   28.985767]  __save_stack_trace from stack_trace_save+0x38/0x58
> [   28.991703]  stack_trace_save from save_trace+0x50/0x410
> [   28.997028]  save_trace from __lock_acquire+0x23c0/0x31b0
> [   29.002431]  __lock_acquire from lock_acquire+0x10c/0x3a8
> [   29.007837]  lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
> [   29.013768]  _raw_spin_lock_irqsave from unwind_frame+0x388/0x6a0
> [   29.019868]  unwind_frame from walk_stackframe+0x30/0x3c
> [   29.025188]  walk_stackframe from return_address+0x58/0x15c
> [   29.030765]  return_address from trace_hardirqs_off+0x64/0x160
> [   29.036607]  trace_hardirqs_off from __irq_svc+0x54/0xac
> [   29.041942] 8<--- cut here ---
> [   29.044998] Unable to handle kernel paging request at virtual address =
60000013
> [   29.052214] [60000013] *pgd=3D00000000
> [   29.055810] Internal error: Oops: 5 [#2] SMP ARM
> [   29.060432] Modules linked in:
> [   29.063496] CPU: 7 PID: 252 Comm: udevd Not tainted 5.17.0-rc6-next-20=
220301-00133-g3d7bbd89fe38-dirty #198
> [   29.073233] Hardware name: Allwinner A83t board
> [   29.077761] PC is at unwind_frame+0x4c0/0x6a0
> [   29.082126] LR is at __start_unwind_idx+0x10/0x32ce8
> [   29.087102] pc : [<c010f28c>]    lr : [<c0d636d8>]    psr: 60000193
> [   29.093365] sp : f1411670  ip : c0d636d8  fp : 00000000
> [   29.098587] r10: 00000001  r9 : c5654ec0  r8 : 60000013
> [   29.103809] r7 : f1411714  r6 : 60002000  r5 : 00000002  r4 : 60000013
> [   29.110332] r3 : 00000000  r2 : c0d96414  r1 : 0000000f  r0 : f1411688
> [   29.116855] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segm=
ent none
> [   29.124074] Control: 10c5387d  Table: 4576c06a  DAC: 00000051
> [   29.129814] Register r0 information: 2-page vmalloc region starting at=
 0xf1410000 allocated at kernel_clone+0x54/0x410
> [   29.140518] Register r1 information: non-paged memory
> [   29.145574] Register r2 information: non-slab/vmalloc memory
> [   29.151235] Register r3 information: NULL pointer
> [   29.155940] Register r4 information: non-paged memory
> [   29.160993] Register r5 information: non-paged memory
> [   29.166044] Register r6 information: non-paged memory
> [   29.171098] Register r7 information: 2-page vmalloc region starting at=
 0xf1410000 allocated at kernel_clone+0x54/0x410
> [   29.181792] Register r8 information: non-paged memory
> [   29.186845] Register r9 information: slab task_struct start c5654ec0 p=
ointer offset 0
> [   29.194695] Register r10 information: non-paged memory
> [   29.199834] Register r11 information: NULL pointer
> [   29.204627] Register r12 information: non-slab/vmalloc memory
> [   29.210373] Process udevd (pid: 252, stack limit =3D 0x(ptrval))
> [   29.216204] Stack: (0xf1411670 to 0xf1412000)
> [   29.220561] 1660:                                     c5654ec0 c5654ec=
0 ffffe000 c0c64d48
> [   29.228734] 1680: 0000002c ffffffff c5654ec0 0000002c ffffffff c019356=
0 c0f08f78 c0196314
> [   29.236908] 16a0: f1411704 f1411c9c 2e174000 c5654ec0 00000000 6000001=
3 f1412000 60000013
> [   29.245080] 16c0: c0100af4 00000000 c0101278 c0c64de0 c5654ec0 0000000=
5 f141174c c0196558
> [   29.253252] 16e0: f1411704 a29ed944 c5654ec0 c0100af4 c0c643e4 c010006=
0 c0101278 c0c64de0
> [   29.261416] 1700: c5654ec0 00000005 f141174c c010f52c 30203030 6000001=
3 f1411c68 c0100af4
> [   29.269589] 1720: c0100af4 f1411c64 f1411c48 a29ed944 c108241c f141186=
0 c0f0e3b4 c5654ec0
> [   29.277762] 1740: 60000193 0000000b c0c642f4 c010b3a4 f1410000 0000000=
b 00000000 ffffffff
> [   29.285935] 1760: c5654ec0 00000000 ffffffff c0193560 c0f08f78 c019631=
4 f14117dc c5654ec0
> [   29.294107] 1780: 60000013 00000300 c0c65d54 c5486940 c5654ec0 c5654ec=
0 00000005 c5486940
> [   29.302279] 17a0: c0c65d54 c5486940 c5654ec0 00000001 00000000 c019655=
8 f14117dc a29ed944
> [   29.310452] 17c0: c5654ec0 60000013 00000005 c5486940 c0c65d54 c548694=
0 c5654ec0 00000001
> [   29.318623] 17e0: 00000000 c0113630 c5654ec0 c0113aa0 f1411860 0000000=
0 00000000 00000000
> [   29.326797] 1800: 00000000 00000000 00000000 00000000 00000000 0000000=
5 60000013 f1411860
> [   29.334970] 1820: c0f0ee48 60000013 c5654ec0 00000001 00000000 c0113c6=
4 00000000 c02172b8
> [   29.343143] 1840: c010f28c 60000193 ffffffff c010f28c 60000193 fffffff=
f f1411894 c0100a70
> [   29.351316] 1860: f14118c8 0000000f c0d96414 00000000 60000013 0000000=
2 60002000 f141195c
> [   29.359488] 1880: 60000013 c14f7818 00000001 00000000 c0d636d8 f14118b=
0 c0d636d8 c010f28c
> [   29.367660] 18a0: 60000193 ffffffff 00000051 c010ee2c 00000000 c5654ec=
0 ffffe000 c0c64d48
> [   29.375834] 18c0: 00000041 c0f0959c c5655638 c169015c c14d7cd8 a29ed94=
4 c018c928 60000013
> [   29.384006] 18e0: ffffffff f1411c9c 2e174000 c5654ec0 00000000 6000001=
3 c14e2b38 60000013
> [   29.392180] 1900: c0100af4 00000000 c5655658 a29ed944 c5654ec0 c5654ec=
0 c0e5d5b8 c0e5d5b8
> [   29.400352] 1920: f1411938 a29ed944 00000080 c5654ec0 deadbeef c0f0959=
c c12bbfa0 c1084680
> [   29.408525] 1940: c14f7818 c12bab18 f1411984 c010aea8 f141198c 0000000=
0 00000000 60000013
> [   29.416699] 1960: f1411c68 c0100af4 c0100af4 f1411c64 f1411c48 a29ed94=
4 c5655638 c5654ec0
> [   29.424871] 1980: c12bbfb0 c01c2664 00000001 00000008 0007fada c12bbfb=
0 00000004 a29ed944
> [   29.433043] 19a0: c5655638 c0185b4c c14e4cd0 a29ed944 00000041 0000052=
2 c14e4cd0 c5655698
> [   29.441215] 19c0: c14e449c a29ed944 c0f0e640 c5655638 c14f7818 c0f0959=
c c169015c c0c65e00
> [   29.449388] 19e0: c14f7818 c5655658 c14e2b38 c018b168 00000000 0000001=
8 f1411adc a29ed944
> [   29.457560] 1a00: 60000093 c0f0e630 c0f0e630 c1084680 c5654ec0 c0f0959=
c 00000001 c169015c
> [   29.465733] 1a20: 00000000 c0f09598 c0e5d5b8 00000001 c0f0959c c01845d=
4 7d56fa57 660cde72
> [   29.473905] 1a40: c0c68134 c0c6daa4 c01844b0 00000001 00000000 0000000=
0 c01c2664 c5654ec0
> [   29.482077] 1a60: c0e5d5b8 00000001 00000041 c14f7808 c5655638 f1411b0=
4 014d87c4 00000000
> [   29.490250] 1a80: f1411aec f1411aec c0f0959c c0c65e00 c0c68134 0000000=
0 c5655638 a29ed944
> [   29.498422] 1aa0: c5654ec0 c5654ec0 c0e5d5b8 c0e5d5b8 f1411ac8 2e17400=
0 00000080 00000000
> [   29.506594] 1ac0: 60000193 c018c90c 00000001 00000080 00000000 c010f15=
4 00000000 00000000
> [   29.514767] 1ae0: f1411af0 00000000 f1411aec f1411aec f1411ad0 a29ed94=
4 c14e3434 c5654ec0
> [   29.522940] 1b00: c12bbfb0 c01c2664 c5654ec0 00000000 0007fada a29ed94=
4 00000004 c0f0e630
> [   29.531112] 1b20: c010f154 60000193 f1411c1c f1411c30 c5654ec0 0000000=
0 00000000 c0973b98
> [   29.539285] 1b40: 00000001 00000000 c010f154 00000009 f1411c1c c0f0e63=
0 c0f0e630 c010f154
> [   29.547457] 1b60: c108468c c5654ec0 ffffe000 c0c64d48 f1411b90 0000001=
8 c1084680 c0e5d5b8
> [   29.555630] 1b80: c0f09598 00000005 00000001 00000001 00000000 f1411c4=
4 f1411c10 c0217308
> [   29.563802] 1ba0: c0217308 f1411c44 00000000 f1411c30 00000000 0000000=
0 c14e3434 00000000
> [   29.571975] 1bc0: c14f7808 00010000 00000354 2e174000 c5654ec0 a29ed94=
4 c14e2b38 f1411c1c
> [   29.580148] 1be0: f1411c14 c010be28 f1411c9c 2e174000 c5654ec0 0000000=
0 f1411c44 c010ad40
> [   29.588320] 1c00: 00000000 c5654ec0 00000001 c010bea4 00000001 0000000=
0 00000000 f1411c44
> [   29.596492] 1c20: f1411c30 00000000 00000000 f1411c2c f1411c10 a29ed94=
4 c5654ec0 c0100af4
> [   29.604664] 1c40: 60000013 c0217308 c018c928 60000013 ffffffff f1411c9=
c 2e174000 c5654ec0
> [   29.612837] 1c60: 00000000 c0100af4 00000001 0000000f 2e174000 0000000=
0 c5654ec0 c0e5d5b8
> [   29.621009] 1c80: c0e5d5b8 f1411cb8 2e174000 00000000 00000000 6000001=
3 ffffffff f1411cb8
> [   29.629181] 1ca0: c0185d38 c018c928 60000013 ffffffff 00000051 c018c90=
c 00000001 00000000
> [   29.637354] 1cc0: 00000000 c03683e4 00000000 00000000 f1411ce8 0000000=
0 00000000 00000000
> [   29.645518] 1ce0: 60000013 c018c90c 00000001 00000000 00000000 c04cab6=
8 00000000 00000000
> [   29.653690] 1d00: c5655638 a29ed944 c5654ec0 c27ad478 c1804200 c27ad47=
8 c57183c0 c03683b8
> [   29.661863] 1d20: c57183c8 00000142 00000000 c0366a44 00000001 0000000=
0 c03683e4 c018c564
> [   29.670036] 1d40: c57183c0 c03683e4 c57183c0 c57183c0 00000000 c38a02b=
0 c5282ba8 c57183c0
> [   29.678207] 1d60: c38a02b0 00000000 c57183c0 c03683b8 c57183c8 0000014=
2 00000000 c02be950
> [   29.686381] 1d80: 00020000 c0f11eac 00000000 c57183c0 f1411e70 f1411f3=
0 00000142 c02d5528
> [   29.694553] 1da0: 00005a04 c0f0959c c5655638 c169015c c14bec14 0000000=
0 00000000 fffffffe
> [   29.702725] 1dc0: 000017ff 00001000 c0c84818 00000000 c5654ec0 0000004=
1 00000000 c0c8481c
> [   29.710898] 1de0: 00005a04 00000000 00001000 00000000 00000000 0000000=
0 00203000 00000000
> [   29.719070] 1e00: 0000001c 00000000 0000000c a29ed944 c5654ec0 c5654ec=
0 c0e5d5b8 c0e5d5b8
> [   29.727242] 1e20: f1411e38 2e174000 00000000 a29ed944 c5654ec0 c5654ec=
0 c0e5d5b8 c0e5d5b8
> [   29.735414] 1e40: f1411e58 a29ed944 00000000 c5654ec0 c561a000 f1411f3=
0 00000001 c5654ec0
> [   29.743586] 1e60: c5654ec0 00000142 0005c03c c02d62a0 c3dfe490 c5282b4=
0 340e8a69 00000004
> [   29.751759] 1e80: c561a04e c5655638 c18990d0 c1c020c0 c38a02b0 0000010=
1 00000002 00000000
> [   29.759931] 1ea0: 000000f4 0000002e 00000000 00000000 00000000 f1411eb=
8 00000000 a29ed944
> [   29.768104] 1ec0: c544a6c0 c544a640 c544a678 00000000 c544a6c0 c544a64=
0 c544a678 c0973d1c
> [   29.776276] 1ee0: 00000008 c02e8a18 c561a000 00000000 00000002 ffffff9=
c 00000000 f14141ed
> [   29.784448] 1f00: c561a000 a29ed944 ffffff9c f1411f60 c561a000 0000000=
8 ffffff9c c02c0788
> [   29.792621] 1f20: 0000001c 00000000 c1802c00 c561a000 00020000 c02c000=
0 00000004 00000100
> [   29.800794] 1f40: 00000001 a29ed944 c5654ec0 ffffff9c bec6f330 0000014=
2 c0100244 c02c0c04
> [   29.808966] 1f60: 000a0000 00000000 00000000 00000000 00000000 0000000=
0 000a0000 00000000
> [   29.817138] 1f80: 00000000 00000000 00000000 00000000 00000000 a29ed94=
4 00000000 b6f4ab60
> [   29.825310] 1fa0: bec6f730 c0100060 00000000 b6f4ab60 ffffff9c bec6f33=
0 000a0000 00000000
> [   29.833483] 1fc0: 00000000 b6f4ab60 bec6f730 00000142 0005880c bec6f33=
0 000573f4 0005c03c
> [   29.841654] 1fe0: 000571b4 bec6f288 b6c22138 b6c22158 60000010 ffffff9=
c 00000000 00000000
> [   29.849824]  unwind_frame from unwind_backtrace+0xc0/0x130
> [   29.855319]  unwind_backtrace from die+0x270/0x4b8
> [   29.860116]  die from die_kernel_fault+0x64/0x74
> [   29.864747]  die_kernel_fault from do_bad_area+0x0/0xc8
> [   29.869990] Code: e3110001 0afffff9 e35b0000 1a000031 (e594c000)
> [   29.876086] ---[ end trace 0000000000000000 ]---
> [   29.880707] note: udevd[252] exited with preempt_count 1#
> [   29.896289] udevd[230]: worker [252] terminated by signal 11 (Segmenta=
tion fault)
> [   29.904008] udevd[230]: worker [252] failed while handling '/devices/p=
latform/soc/1c11000.mmc/mmc_host/mmc2/mmc2:0001/block/mmcblk2'
> [   54.338560] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [   54.344576] rcu:     1-...!: (1 GPs behind) idle=3Dbd1/1/0x40000000 so=
ftirq=3D348/350 fqs=3D0
> [   54.352430] rcu:     4-...!: (0 ticks this GP) idle=3D135/1/0x40000000=
 softirq=3D123/123 fqs=3D0
> [   54.360544]  (detected by 7, t=3D2604 jiffies, g=3D121, q=3D8900)
> [   54.366138] Sending NMI from CPU 7 to CPUs 1:
> [   64.371235] Sending NMI from CPU 7 to CPUs 4:
> [   74.376326] rcu: rcu_sched kthread timer wakeup didn't happen for 4604=
 jiffies! g121 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
> [   74.387375] rcu:     Possible timer handling issue on cpu=3D4 timer-so=
ftirq=3D29
> [   74.394168] rcu: rcu_sched kthread starved for 4607 jiffies! g121 f0x0=
 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D4
> [   74.404263] rcu:     Unless rcu_sched kthread gets sufficient CPU time=
, OOM is now expected behavior.
> [   74.413221] rcu: RCU grace-period kthread stack dump:
> [   74.418277] task:rcu_sched       state:I stack:    0 pid:   11 ppid:  =
   2 flags:0x00000000
> [   74.426660]  __schedule from schedule+0x54/0xc8
> [   74.431230]  schedule from schedule_timeout+0xb0/0x200
> [   74.436397]  schedule_timeout from rcu_gp_fqs_loop+0x16c/0x7d4
> [   74.442261]  rcu_gp_fqs_loop from rcu_gp_kthread+0x1ac/0x328
> [   74.447942]  rcu_gp_kthread from kthread+0xf0/0x110
> [   74.452849]  kthread from ret_from_fork+0x14/0x2c
> [   74.457580] rcu: Stack dump where RCU GP kthread last ran:
> [   74.463068] Sending NMI from CPU 7 to CPUs 4:
