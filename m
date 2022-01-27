Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A716E49EE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 23:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbiA0W0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 17:26:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56460 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiA0W0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:26:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C66DFB823EE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3CBC340E4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:26:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YGmjXyQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643322406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBQhijCPMC0G63JpEOpcwGG5eTAUrAPGSUlgNus7nOU=;
        b=YGmjXyQGiEBkint5Jj0rxX6mYyfGBVWscFQUCvDd4zz0kSTw95roUGa9Dfl5ZfV9aSeF1B
        4bzR8o3sKBTMyl/OTdP6RqOEc8gintsrMKr2wXMDEZPZS8N5+N1SvUnE6qGKQPvgzQbtkA
        9DKgTDKIrLmjHWMyP35mKXtUQPOD1nQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9ac353e5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 27 Jan 2022 22:26:45 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id m6so12973606ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:26:44 -0800 (PST)
X-Gm-Message-State: AOAM532cl+wkv18jnnpEJperQs+xtFCrGZQ7VvJRLM2+yDuNeKGNdg6W
        VMu8ohxNEc7+5TZyDp1c/B35h2Yiy/IvYBu9OLs=
X-Google-Smtp-Source: ABdhPJyw/Emuw4fvZKTLRa1g9eAtm40DzfSYq3KC/XTtHZrAAIaEIf9EfDdYeVkQBcqgqt1KK2gnycuVmTZcQxdLtdk=
X-Received: by 2002:a25:2284:: with SMTP id i126mr7904327ybi.245.1643322403526;
 Thu, 27 Jan 2022 14:26:43 -0800 (PST)
MIME-Version: 1.0
References: <YfMa0QgsjCVdRAvJ@latitude>
In-Reply-To: <YfMa0QgsjCVdRAvJ@latitude>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 27 Jan 2022 23:26:32 +0100
X-Gmail-Original-Message-ID: <CAHmME9pb9A4SN6TTjNvvxKqw1L3gXVOX7KKihfEH4AgKGNGZ2A@mail.gmail.com>
Message-ID: <CAHmME9pb9A4SN6TTjNvvxKqw1L3gXVOX7KKihfEH4AgKGNGZ2A@mail.gmail.com>
Subject: Re: "BUG: Invalid wait context" in invalidate_batched_entropy
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for the report. I'll try to reproduce this and see what's going on.

I'm emailing back right away, though, so that I can CC in Andy
Lutomirski, who I know has been sitting on a stack of patches that fix
up (actually, remove) the locking, so this might be one path to fixing
this.

Thanks,
Jason

On Thu, Jan 27, 2022 at 11:21 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> Hi,
>
> when booting my ARM board with lockdep and CONFIG_PROVE_LOCKING, I get th=
e following message:
>
> [    2.500000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    2.500000] [ BUG: Invalid wait context ]
> [    2.500000] 5.17.0-rc1 #563 Not tainted
> [    2.500000] -----------------------------
> [    2.500000] swapper/1 is trying to lock:
> [    2.500000] c0b0e9cc (batched_entropy_u32.lock){....}-{3:3}, at: inval=
idate_batched_entropy+0x18/0x4c
> [    2.500000] other info that might help us debug this:
> [    2.500000] context-{2:2}
> [    2.500000] 3 locks held by swapper/1:
> [    2.500000]  #0: c0ae86ac (event_mutex){+.+.}-{4:4}, at: event_trace_i=
nit+0x4c/0xd8
> [    2.500000]  #1: c0ae81b8 (trace_event_sem){+.+.}-{4:4}, at: event_tra=
ce_init+0x68/0xd8
> [    2.500000]  #2: c19b05cc (&sb->s_type->i_mutex_key#2){+.+.}-{4:4}, at=
: start_creating+0x40/0xc4
> [    2.500000] stack backtrace:
> [    2.500000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.17.0-rc1 #563
> [    2.500000] Hardware name: WPCM450 chip
> [    2.500000] [<c00100a8>] (unwind_backtrace) from [<c000db2c>] (show_st=
ack+0x10/0x14)
> [    2.500000] [<c000db2c>] (show_stack) from [<c0054eec>] (__lock_acquir=
e+0x3f0/0x189c)
> [    2.500000] [<c0054eec>] (__lock_acquire) from [<c0054478>] (lock_acqu=
ire+0x2b8/0x354)
> [    2.500000] [<c0054478>] (lock_acquire) from [<c0568028>] (_raw_spin_l=
ock_irqsave+0x60/0x74)
> [    2.500000] [<c0568028>] (_raw_spin_lock_irqsave) from [<c030b6f4>] (i=
nvalidate_batched_entropy+0x18/0x4c)
> [    2.500000] [<c030b6f4>] (invalidate_batched_entropy) from [<c030e7fc>=
] (crng_fast_load+0xf0/0x110)
> [    2.500000] [<c030e7fc>] (crng_fast_load) from [<c030e954>] (add_inter=
rupt_randomness+0x138/0x200)
> [    2.500000] [<c030e954>] (add_interrupt_randomness) from [<c0061b34>] =
(handle_irq_event_percpu+0x18/0x38)
> [    2.500000] [<c0061b34>] (handle_irq_event_percpu) from [<c0061b8c>] (=
handle_irq_event+0x38/0x5c)
> [    2.500000] [<c0061b8c>] (handle_irq_event) from [<c0065b28>] (handle_=
fasteoi_irq+0x9c/0x114)
> [    2.500000] [<c0065b28>] (handle_fasteoi_irq) from [<c0061178>] (handl=
e_irq_desc+0x24/0x34)
> [    2.500000] [<c0061178>] (handle_irq_desc) from [<c056214c>] (generic_=
handle_arch_irq+0x28/0x3c)
> [    2.500000] [<c056214c>] (generic_handle_arch_irq) from [<c0008eb4>] (=
__irq_svc+0x54/0x80)
> [    2.500000] Exception stack(0xc1485d48 to 0xc1485d90)
> [    2.500000] 5d40:                   9780e804 00000001 c09413d4 200000d=
3 60000053 c016af54
> [    2.500000] 5d60: 00000000 c0afa5b8 c14194e0 c19a1d48 c0789ce0 0000000=
0 c1490480 c1485d98
> [    2.500000] 5d80: c0168970 c0168984 20000053 ffffffff
> [    2.500000] [<c0008eb4>] (__irq_svc) from [<c0168984>] (read_seqbegin.=
constprop.0+0x6c/0x90)
> [    2.500000] [<c0168984>] (read_seqbegin.constprop.0) from [<c016af54>]=
 (d_lookup+0x14/0x40)
> [    2.500000] [<c016af54>] (d_lookup) from [<c015cecc>] (lookup_dcache+0=
x18/0x50)
> [    2.500000] [<c015cecc>] (lookup_dcache) from [<c015d868>] (lookup_one=
_len+0x90/0xe0)
> [    2.500000] [<c015d868>] (lookup_one_len) from [<c01e33e4>] (start_cre=
ating+0x68/0xc4)
> [    2.500000] [<c01e33e4>] (start_creating) from [<c01e398c>] (tracefs_c=
reate_file+0x30/0x11c)
> [    2.500000] [<c01e398c>] (tracefs_create_file) from [<c00c42f8>] (trac=
e_create_file+0x14/0x38)
> [    2.500000] [<c00c42f8>] (trace_create_file) from [<c00cc854>] (event_=
create_dir+0x310/0x420)
> [    2.500000] [<c00cc854>] (event_create_dir) from [<c00cc9d8>] (__trace=
_early_add_event_dirs+0x28/0x50)
> [    2.500000] [<c00cc9d8>] (__trace_early_add_event_dirs) from [<c07c8d6=
4>] (event_trace_init+0x70/0xd8)
> [    2.500000] [<c07c8d64>] (event_trace_init) from [<c07c8560>] (tracer_=
init_tracefs+0x14/0x284)
> [    2.500000] [<c07c8560>] (tracer_init_tracefs) from [<c000a330>] (do_o=
ne_initcall+0xdc/0x288)
> [    2.500000] [<c000a330>] (do_one_initcall) from [<c07bd1e8>] (kernel_i=
nit_freeable+0x1c4/0x20c)
> [    2.500000] [<c07bd1e8>] (kernel_init_freeable) from [<c05629c0>] (ker=
nel_init+0x10/0x110)
> [    2.500000] [<c05629c0>] (kernel_init) from [<c00084f8>] (ret_from_for=
k+0x14/0x3c)
> [    2.500000] Exception stack(0xc1485fb0 to 0xc1485ff8)
> [    2.500000] 5fa0:                                     00000000 0000000=
0 00000000 00000000
> [    2.500000] 5fc0: 00000000 00000000 00000000 00000000 00000000 0000000=
0 00000000 00000000
> [    2.500000] 5fe0: 00000000 00000000 00000000 00000000 00000013 0000000=
0
>
>
>
> I wasn't able to bisect it, but I can see it as far back as v5.13
> (I can't easily test earlier kernels). The lock in question was
> introduced with v5.2-rc1:
>
>
> commit b7d5dc21072cda7124d13eae2aefb7343ef94197
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Sat Apr 20 00:09:51 2019 -0400
>
>     random: add a spinlock_t to struct batched_entropy
>
>     The per-CPU variable batched_entropy_uXX is protected by get_cpu_var(=
).
>     This is just a preempt_disable() which ensures that the variable is o=
nly
>     from the local CPU. It does not protect against users on the same CPU
>     from another context. It is possible that a preemptible context reads
>     slot 0 and then an interrupt occurs and the same value is read again.
>
> [...]
>     Add a spinlock_t to the batched_entropy data structure and acquire th=
e
>     lock while accessing it. Acquire the lock with disabled interrupts
>     because this function may be used from interrupt context.
>
>     Remove the batched_entropy_reset_lock lock. Now that we have a lock f=
or
>     the data scructure, we can access it from a remote CPU.
>
>     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
>
> I'm not very familiar with the finer details of locking rules and
> lockdep, so any ideas (or patches) to fix this will be appreciated.
>
>
> Best regards,
> Jonathan Neusch=C3=A4fer
> --
>
>
> In case it's relevant, here is my config:
>
> CONFIG_SYSVIPC=3Dy
> CONFIG_NO_HZ=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> CONFIG_PREEMPT=3Dy
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> CONFIG_LOG_BUF_SHIFT=3D19
> CONFIG_CGROUPS=3Dy
> CONFIG_NAMESPACES=3Dy
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D"rootfs.cpio"
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> CONFIG_EXPERT=3Dy
> CONFIG_PROFILING=3Dy
> # CONFIG_ARCH_MULTI_V7 is not set
> CONFIG_ARCH_NPCM=3Dy
> CONFIG_ARCH_WPCM450=3Dy
> CONFIG_CPU_DCACHE_WRITETHROUGH=3Dy
> CONFIG_AEABI=3Dy
> CONFIG_HIGHMEM=3Dy
> CONFIG_UACCESS_WITH_MEMCPY=3Dy
> CONFIG_ARM_APPENDED_DTB=3Dy
> CONFIG_CMDLINE=3D"earlyprintk debug console=3DttyS0,115200 panic=3D-1"
> CONFIG_CMDLINE_EXTEND=3Dy
> CONFIG_KEXEC=3Dy
> # CONFIG_ATAGS_PROC is not set
> CONFIG_CPU_FREQ=3Dy
> CONFIG_CPU_FREQ_STAT=3Dy
> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
> CONFIG_CPU_IDLE=3Dy
> CONFIG_KPROBES=3Dy
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> CONFIG_ZSWAP=3Dy
> CONFIG_ZSWAP_DEFAULT_ON=3Dy
> CONFIG_Z3FOLD=3Dy
> CONFIG_NET=3Dy
> CONFIG_PACKET=3Dy
> CONFIG_UNIX=3Dy
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_PNP=3Dy
> CONFIG_IP_PNP_DHCP=3Dy
> CONFIG_IP_PNP_BOOTP=3Dy
> CONFIG_NET_DSA=3Dy
> CONFIG_NET_DSA_TAG_DSA=3Dy
> CONFIG_NET_DSA_TAG_EDSA=3Dy
> CONFIG_NET_DSA_TAG_TRAILER=3Dy
> CONFIG_NET_NCSI=3Dy
> CONFIG_NCSI_OEM_CMD_GET_MAC=3Dy
> CONFIG_NET_PKTGEN=3Dm
> # CONFIG_WIRELESS is not set
> CONFIG_DEVTMPFS=3Dy
> CONFIG_DEVTMPFS_MOUNT=3Dy
> CONFIG_DEVTMPFS_SAFE=3Dy
> CONFIG_MTD=3Dy
> CONFIG_MTD_CMDLINE_PARTS=3Dy
> CONFIG_MTD_BLOCK=3Dy
> CONFIG_MTD_CFI=3Dy
> CONFIG_MTD_JEDECPROBE=3Dy
> CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
> CONFIG_MTD_CFI_GEOMETRY=3Dy
> # CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
> CONFIG_MTD_CFI_INTELEXT=3Dy
> CONFIG_MTD_CFI_STAA=3Dy
> CONFIG_MTD_PHYSMAP=3Dy
> CONFIG_MTD_SPI_NOR=3Dy
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_SRAM=3Dy
> CONFIG_EEPROM_AT24=3Dy
> CONFIG_SCSI=3Dy
> # CONFIG_SCSI_PROC_FS is not set
> # CONFIG_SCSI_LOWLEVEL is not set
> CONFIG_NETDEVICES=3Dy
> # CONFIG_NET_VENDOR_ALACRITECH is not set
> # CONFIG_NET_VENDOR_AMAZON is not set
> # CONFIG_NET_VENDOR_AQUANTIA is not set
> # CONFIG_NET_VENDOR_ARC is not set
> # CONFIG_NET_VENDOR_BROADCOM is not set
> # CONFIG_NET_VENDOR_CADENCE is not set
> # CONFIG_NET_VENDOR_CAVIUM is not set
> # CONFIG_NET_VENDOR_CIRRUS is not set
> # CONFIG_NET_VENDOR_CORTINA is not set
> # CONFIG_NET_VENDOR_EZCHIP is not set
> # CONFIG_NET_VENDOR_FARADAY is not set
> # CONFIG_NET_VENDOR_GOOGLE is not set
> # CONFIG_NET_VENDOR_HISILICON is not set
> # CONFIG_NET_VENDOR_HUAWEI is not set
> # CONFIG_NET_VENDOR_INTEL is not set
> # CONFIG_NET_VENDOR_MICROSOFT is not set
> # CONFIG_NET_VENDOR_LITEX is not set
> # CONFIG_NET_VENDOR_MARVELL is not set
> # CONFIG_NET_VENDOR_MELLANOX is not set
> # CONFIG_NET_VENDOR_MICREL is not set
> # CONFIG_NET_VENDOR_MICROCHIP is not set
> # CONFIG_NET_VENDOR_MICROSEMI is not set
> # CONFIG_NET_VENDOR_NATSEMI is not set
> # CONFIG_NET_VENDOR_NETRONOME is not set
> # CONFIG_NET_VENDOR_NI is not set
> # CONFIG_NET_VENDOR_PENSANDO is not set
> # CONFIG_NET_VENDOR_QUALCOMM is not set
> # CONFIG_NET_VENDOR_RENESAS is not set
> # CONFIG_NET_VENDOR_ROCKER is not set
> # CONFIG_NET_VENDOR_SAMSUNG is not set
> # CONFIG_NET_VENDOR_SEEQ is not set
> # CONFIG_NET_VENDOR_SOLARFLARE is not set
> # CONFIG_NET_VENDOR_SMSC is not set
> # CONFIG_NET_VENDOR_SOCIONEXT is not set
> # CONFIG_NET_VENDOR_STMICRO is not set
> # CONFIG_NET_VENDOR_SYNOPSYS is not set
> # CONFIG_NET_VENDOR_VIA is not set
> # CONFIG_NET_VENDOR_WIZNET is not set
> # CONFIG_NET_VENDOR_XILINX is not set
> CONFIG_DAVICOM_PHY=3Dy
> CONFIG_MARVELL_PHY=3Dy
> CONFIG_MICREL_PHY=3Dy
> CONFIG_REALTEK_PHY=3Dy
> # CONFIG_WLAN is not set
> CONFIG_INPUT_EVDEV=3Dy
> CONFIG_KEYBOARD_QT1070=3Dm
> CONFIG_KEYBOARD_GPIO=3Dy
> # CONFIG_INPUT_MOUSE is not set
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_LEGACY_PTY_COUNT=3D16
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D6
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D6
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> CONFIG_SERIAL_8250_ASPEED_VUART=3Dm
> CONFIG_SERIAL_OF_PLATFORM=3Dy
> CONFIG_HW_RANDOM=3Dy
> CONFIG_I2C=3Dy
> # CONFIG_I2C_COMPAT is not set
> CONFIG_I2C_CHARDEV=3Dy
> CONFIG_I2C_MUX=3Dy
> CONFIG_SPI=3Dy
> CONFIG_SPI_BITBANG=3Dy
> CONFIG_PINCTRL_SINGLE=3Dy
> CONFIG_GPIOLIB=3Dy
> CONFIG_DEBUG_GPIO=3Dy
> CONFIG_GPIO_SYSFS=3Dy
> CONFIG_GPIO_PCF857X=3Dy
> CONFIG_POWER_RESET=3Dy
> CONFIG_POWER_RESET_GPIO=3Dy
> CONFIG_POWER_SUPPLY=3Dy
> CONFIG_THERMAL=3Dy
> CONFIG_WATCHDOG=3Dy
> CONFIG_NPCM7XX_WATCHDOG=3Dy
> CONFIG_MFD_ATMEL_HLCDC=3Dy
> CONFIG_MFD_SYSCON=3Dy
> CONFIG_REGULATOR=3Dy
> CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
> # CONFIG_DRM_DEBUG_MODESET_LOCK is not set
> CONFIG_FB=3Dy
> CONFIG_FB_MODE_HELPERS=3Dy
> CONFIG_HID_A4TECH=3Dy
> CONFIG_HID_APPLE=3Dy
> CONFIG_HID_BELKIN=3Dy
> CONFIG_HID_CHERRY=3Dy
> CONFIG_HID_CYPRESS=3Dy
> CONFIG_HID_DRAGONRISE=3Dy
> CONFIG_HID_EZKEY=3Dy
> CONFIG_HID_GYRATION=3Dy
> CONFIG_HID_ITE=3Dy
> CONFIG_HID_TWINHAN=3Dy
> CONFIG_HID_KENSINGTON=3Dy
> CONFIG_HID_REDRAGON=3Dy
> CONFIG_HID_MICROSOFT=3Dy
> CONFIG_HID_MONTEREY=3Dy
> CONFIG_HID_PANTHERLORD=3Dy
> CONFIG_HID_PETALYNX=3Dy
> CONFIG_HID_SUNPLUS=3Dy
> CONFIG_HID_GREENASIA=3Dy
> CONFIG_HID_SMARTJOYPLUS=3Dy
> CONFIG_HID_TOPSEED=3Dy
> CONFIG_HID_ZEROPLUS=3Dy
> CONFIG_USB_CHIPIDEA=3Dy
> CONFIG_USB_CHIPIDEA_UDC=3Dy
> CONFIG_NOP_USB_XCEIV=3Dy
> CONFIG_USB_GADGET=3Dy
> CONFIG_U_SERIAL_CONSOLE=3Dy
> CONFIG_USB_CONFIGFS=3Dy
> CONFIG_USB_CONFIGFS_SERIAL=3Dy
> CONFIG_USB_CONFIGFS_RNDIS=3Dy
> CONFIG_USB_CONFIGFS_MASS_STORAGE=3Dy
> CONFIG_USB_CONFIGFS_F_HID=3Dy
> CONFIG_MMC=3Dy
> CONFIG_SDIO_UART=3Dy
> CONFIG_MMC_SDHCI=3Dm
> CONFIG_MMC_SDHCI_PLTFM=3Dm
> CONFIG_MMC_SDHCI_OF_ASPEED=3Dm
> CONFIG_NEW_LEDS=3Dy
> CONFIG_LEDS_CLASS=3Dy
> CONFIG_LEDS_GPIO=3Dy
> CONFIG_LEDS_TRIGGERS=3Dy
> CONFIG_LEDS_TRIGGER_TIMER=3Dy
> CONFIG_LEDS_TRIGGER_ONESHOT=3Dy
> CONFIG_LEDS_TRIGGER_MTD=3Dy
> CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
> CONFIG_LEDS_TRIGGER_CPU=3Dy
> CONFIG_LEDS_TRIGGER_ACTIVITY=3Dy
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
> CONFIG_LEDS_TRIGGER_PANIC=3Dy
> CONFIG_LEDS_TRIGGER_TTY=3Dy
> CONFIG_RTC_CLASS=3Dy
> CONFIG_RTC_DRV_RS5C372=3Dy
> CONFIG_RTC_DRV_PCF8563=3Dy
> CONFIG_RTC_DRV_S35390A=3Dy
> CONFIG_RTC_DRV_RV3029C2=3Dm
> CONFIG_DMADEVICES=3Dy
> CONFIG_SYNC_FILE=3Dy
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_VIRTIO_MENU is not set
> # CONFIG_VHOST_MENU is not set
> CONFIG_STAGING=3Dy
> # CONFIG_SURFACE_PLATFORMS is not set
> # CONFIG_IOMMU_SUPPORT is not set
> CONFIG_MEMORY=3Dy
> CONFIG_PWM=3Dy
> CONFIG_PWM_ATMEL_HLCDC_PWM=3Dm
> CONFIG_GENERIC_PHY=3Dy
> CONFIG_ISO9660_FS=3Dm
> CONFIG_JOLIET=3Dy
> CONFIG_UDF_FS=3Dm
> CONFIG_MSDOS_FS=3Dy
> CONFIG_VFAT_FS=3Dy
> CONFIG_TMPFS=3Dy
> # CONFIG_MISC_FILESYSTEMS is not set
> # CONFIG_NETWORK_FILESYSTEMS is not set
> CONFIG_NLS_CODEPAGE_437=3Dy
> CONFIG_NLS_CODEPAGE_850=3Dy
> CONFIG_NLS_ISO8859_1=3Dy
> CONFIG_NLS_ISO8859_2=3Dy
> CONFIG_NLS_UTF8=3Dy
> CONFIG_KEYS=3Dy
> CONFIG_LSM=3D"lockdown,yama,loadpin,safesetid,integrity,bpf"
> CONFIG_CRYPTO_RSA=3Dy
> CONFIG_CRYPTO_CCM=3Dy
> CONFIG_CRYPTO_GCM=3Dy
> CONFIG_CRYPTO_CMAC=3Dy
> CONFIG_CRYPTO_SHA256=3Dy
> CONFIG_CRYPTO_AES=3Dy
> CONFIG_CRYPTO_DEFLATE=3Dy
> CONFIG_CRYPTO_ZSTD=3Dy
> CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
> CONFIG_X509_CERTIFICATE_PARSER=3Dy
> CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
> CONFIG_CRC_CCITT=3Dy
> CONFIG_CRC16=3Dy
> CONFIG_LIBCRC32C=3Dy
> CONFIG_DMA_API_DEBUG=3Dy
> CONFIG_PRINTK_TIME=3Dy
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_DEBUG_INFO_COMPRESSED=3Dy
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_DEBUG_FS=3Dy
> # CONFIG_SCHED_DEBUG is not set
> # CONFIG_DEBUG_PREEMPT is not set
> CONFIG_PROVE_LOCKING=3Dy
> CONFIG_PROVE_RAW_LOCK_NESTING=3Dy
> CONFIG_DEBUG_LOCKDEP=3Dy
> CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> # CONFIG_FTRACE is not set
> CONFIG_BACKTRACE_VERBOSE=3Dy
> CONFIG_DEBUG_USER=3Dy
> CONFIG_DEBUG_LL=3Dy
> CONFIG_DEBUG_LL_UART_8250=3Dy
> CONFIG_DEBUG_UART_PHYS=3D0xb8000000
> CONFIG_DEBUG_UART_VIRT=3D0x0ff000000
> CONFIG_DEBUG_UART_8250_WORD=3Dy
> CONFIG_EARLY_PRINTK=3Dy
