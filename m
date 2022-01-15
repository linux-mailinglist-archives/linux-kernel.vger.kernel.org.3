Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04CE48F7C0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiAOQMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:12:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42348 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232075AbiAOQMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:12:01 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F12131EC0249;
        Sat, 15 Jan 2022 17:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642263116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=n8YoYfWNJ9tjotqKHxfDfcGGddBqg6mhGj8RsMOvzFU=;
        b=O9pxt06NA/PjC11jpRREBV7R2MST5XzolENgn8JYXPfuQwq+SNgQKtFE+oXqqBmAMVX5eo
        F3s9yEixRACZ32pAXlHGzm4UQSJmGHZLC4Ht+tqfncQA+ctJhNdE59bxfJTUrIKGaiUyUj
        boVdm2Yojz6mKb94CGO6mM6HaRmY6mQ=
Date:   Sat, 15 Jan 2022 17:11:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RIP: 0010:radeon_vm_fini+0x15/0x220 [radeon]
Message-ID: <YeLyToEyBFnQqQGB@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

so this is a *very* old K8 laptop - yap, you read it right, family 0xf.

[   31.353032] powernow_k8: fid 0xa (1800 MHz), vid 0xa
[   31.353569] powernow_k8: fid 0x8 (1600 MHz), vid 0xc
[   31.354081] powernow_k8: fid 0x0 (800 MHz), vid 0x16
[   31.354844] powernow_k8: Found 1 AMD Turion(tm) 64 Mobile Technology MT-34 (1 cpu cores) (version 2.20.00)

This is true story.

Anyway, it blows up, see below.

Kernel is latest Linus tree, top commit is:

a33f5c380c4b ("Merge tag 'xfs-5.17-merge-3' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux")

I can bisect if you don't see it immediately why it blows up.

HTH.

[   37.904144] [drm] radeon kernel modesetting enabled.
[   37.904823] radeon 0000:01:05.0: vgaarb: deactivate vga console
[   37.907351] Console: switching to colour dummy device 80x25
[   37.909076] [drm] initializing kernel modesetting (RS480 0x1002:0x5955 0x10CF:0x1302 0x00).
[   37.909767] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than pnp 00:01 [mem 0x000d1800-0x000d1fff]
[   37.911775] caller pci_map_rom+0x78/0x1d0 mapping multiple BARs
[   37.912498] [drm] Generation 2 PCI interface, using max accessible memory
[   37.913450] radeon 0000:01:05.0: VRAM: 64M 0x000000003C000000 - 0x000000003FFFFFFF (64M used)
[   37.914199] radeon 0000:01:05.0: GTT: 512M 0x0000000040000000 - 0x000000005FFFFFFF
[   37.914856] [drm] Detected VRAM RAM=64M, BAR=128M
[   37.915758] [drm] RAM width 128bits DDR
[   37.916181] [drm] radeon: 64M of VRAM memory ready
[   37.917328] [drm] radeon: 512M of GTT memory ready.
[   37.917832] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   37.923315] [drm] radeon: power management initialized
[   37.923827] [drm] radeon: 2 quad pipes, 1 z pipes initialized.
[   37.924372] [drm] PCIE GART of 512M enabled (table at 0x0000000008400000).
[   37.925900] radeon 0000:01:05.0: WB enabled
[   37.926436] radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x0000000040000000
[   37.929710] radeon 0000:01:05.0: radeon: MSI limited to 32-bit
[   37.930282] [drm] radeon: irq initialized.
[   37.930826] [drm] Loading R300 Microcode
[   38.093492] [drm] radeon: ring at 0x0000000040001000
[   38.094022] [drm] ring test succeeded in 4 usecs
[   38.094561] [drm] ib test succeeded in 0 usecs
[   38.096275] [drm] Panel ID String: 1024x768
[   38.096762] [drm] Panel Size 1024x768
[   38.097741] [drm] Radeon Display Connectors
[   38.098107] [drm] Connector 0:
[   38.098500] [drm]   VGA-1
[   38.098779] [drm]   DDC: 0x68 0x68 0x68 0x68 0x68 0x68 0x68 0x68
[   38.099321] [drm]   Encoders:
[   38.099708] [drm]     CRT1: INTERNAL_DAC2
[   38.100075] [drm] Connector 1:
[   38.100440] [drm]   LVDS-1
[   38.100761] [drm]   Encoders:
[   38.101126] [drm]     LCD1: INTERNAL_LVDS
[   38.101491] [drm] Connector 2:
[   38.101883] [drm]   SVIDEO-1
[   38.102248] [drm]   Encoders:
[   38.102613] [drm]     TV1: INTERNAL_DAC2
[   38.103023] BUG: kernel NULL pointer dereference, address: 0000000000000023
[   38.103564] #PF: supervisor read access in kernel mode
[   38.104018] #PF: error_code(0x0000) - not-present page
[   38.104472] PGD 0 P4D 0 
[   38.104728] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   38.104728] CPU: 0 PID: 349 Comm: systemd-udevd Not tainted 5.16.0+ #1
[   38.104728] Hardware name: FUJITSU SIEMENS LIFEBOOK S2110/FJNB19A, BIOS Version 1.11  05/19/2006
[   38.104728] RIP: 0010:radeon_vm_fini+0x15/0x220 [radeon]
[   38.104728] Code: e1 d7 c3 ff b8 f4 ff ff ff eb b6 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 41 55 49 89 fd 41 54 49 89 f4 55 53 <48> 8b 46 20 48 85 c0 0f 85 ae fd 01 00 4d 8d 74 24 20 4c 89 f7 e8
[   38.104728] RSP: 0018:ffffc900004b3a98 EFLAGS: 00010202
[   38.104728] RAX: 0000000000000001 RBX: ffff8880081a4000 RCX: 0000000000000000
[   38.104728] RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffff888008168000
[   38.104728] RBP: ffff88800432b200 R08: 0000000000000000 R09: ffff88800432b200
[   38.104728] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000003
[   38.104728] R13: ffff888008168000 R14: ffff8880081a4000 R15: 0000000000000003
[   38.104728] FS:  00007fe2cfab18c0(0000) GS:ffff888039000000(0000) knlGS:0000000000000000
[   38.104728] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.104728] CR2: 0000000000000023 CR3: 000000000820e000 CR4: 00000000000006f0
[   38.104728] Call Trace:
[   38.104728]  <TASK>
[   38.104728]  radeon_driver_open_kms+0x6b/0x1b0 [radeon]
[   38.104728]  drm_file_alloc+0x19c/0x260 [drm]
[   38.104728]  drm_client_init+0xdc/0x190 [drm]
[   38.104728]  drm_fb_helper_init+0x3a/0x60 [drm_kms_helper]
[   38.104728]  radeon_fbdev_init+0x8e/0x130 [radeon]
[   38.104728]  radeon_modeset_init.cold+0x206/0x521 [radeon]
[   38.104728]  radeon_driver_load_kms+0xe5/0x1f0 [radeon]
[   38.104728]  drm_dev_register+0xfc/0x1e0 [drm]
[   38.104728]  radeon_pci_probe+0xc6/0x100 [radeon]
[   38.104728]  pci_device_probe+0xbb/0x170
[   38.104728]  really_probe+0xca/0x3c0
[   38.104728]  __driver_probe_device+0xfe/0x180
[   38.104728]  driver_probe_device+0x2c/0xb0
[   38.104728]  __driver_attach+0xc5/0x1d0
[   38.104728]  ? __device_attach_driver+0xf0/0xf0
[   38.104728]  ? __device_attach_driver+0xf0/0xf0
[   38.104728]  bus_for_each_dev+0x7a/0xc0
[   38.104728]  ? klist_add_tail+0x4f/0x90
[   38.104728]  bus_add_driver+0x16b/0x210
[   38.104728]  driver_register+0x8b/0xe0
[   38.104728]  ? 0xffffffffa0758000
[   38.104728]  do_one_initcall+0x44/0x200
[   38.104728]  ? kmem_cache_alloc_trace+0xb3/0x1f0
[   38.104728]  do_init_module+0x5c/0x260
[   38.104728]  __do_sys_finit_module+0xca/0x140
[   38.104728]  do_syscall_64+0x3b/0x80
[   38.104728]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   38.104728] RIP: 0033:0x7fe2cff62679
[   38.104728] Code: 48 8d 3d 9a a1 0c 00 0f 05 eb a5 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64 89 01 48
[   38.104728] RSP: 002b:00007ffd2a00b738 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   38.104728] RAX: ffffffffffffffda RBX: 0000562792263fb0 RCX: 00007fe2cff62679
[   38.104728] RDX: 0000000000000000 RSI: 00005627922c0a00 RDI: 0000000000000016
[   38.104728] RBP: 0000000000020000 R08: 0000000000000000 R09: 0000562791f34e62
[   38.104728] R10: 0000000000000016 R11: 0000000000000246 R12: 00005627922c0a00
[   38.104728] R13: 0000000000000000 R14: 00005627922c5fa0 R15: 0000562792263fb0
[   38.104728]  </TASK>
[   38.104728] Modules linked in: radeon(+) mac80211 ath drm_ttm_helper ttm cfg80211 snd_atiixp drm_kms_helper snd_ac97_codec drm ac97_bus snd_pcm powernow_k8 snd_timer rfkill pcmcia drm_panel_orientation_quirks snd libarc4 yenta_socket edac_mce_amd i2c_algo_bit pcmcia_rsrc evdev joydev fb_sys_fops soundcore syscopyarea pcspkr pcmcia_core sysfillrect input_leds sysimgblt k8temp video battery ac button b44 mii sdhci_pci iosf_mbi firewire_ohci psmouse ssb cqhci ohci_pci firewire_core sdhci led_class crc_itu_t libphy ehci_pci ohci_hcd ehci_hcd mmc_core i2c_piix4 usbcore usb_common
[   38.104728] CR2: 0000000000000023
[   38.137547] ---[ end trace 91f9e835d12cf639 ]---
[   38.138012] RIP: 0010:radeon_vm_fini+0x15/0x220 [radeon]
[   38.138690] Code: e1 d7 c3 ff b8 f4 ff ff ff eb b6 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 41 55 49 89 fd 41 54 49 89 f4 55 53 <48> 8b 46 20 48 85 c0 0f 85 ae fd 01 00 4d 8d 74 24 20 4c 89 f7 e8
[   38.140044] RSP: 0018:ffffc900004b3a98 EFLAGS: 00010202
[   38.140501] RAX: 0000000000000001 RBX: ffff8880081a4000 RCX: 0000000000000000
[   38.141181] RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffff888008168000
[   38.141808] RBP: ffff88800432b200 R08: 0000000000000000 R09: ffff88800432b200
[   38.142462] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000003
[   38.143089] R13: ffff888008168000 R14: ffff8880081a4000 R15: 0000000000000003
[   38.143739] FS:  00007fe2cfab18c0(0000) GS:ffff888039000000(0000) knlGS:0000000000000000
[   38.144369] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.144959] CR2: 00005627922c1218 CR3: 000000000820e000 CR4: 00000000000006f0
[   38.190852] ath5k 0000:08:0a.0: registered as 'phy0'
[   38.872632] ath: EEPROM regdomain: 0x67
[   38.873033] ath: EEPROM indicates we should expect a direct regpair map
[   38.873576] ath: Country alpha2 being used: 00
[   38.874056] ath: Regpair used: 0x67
[   38.874464] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   38.876582] ath5k: phy0: Atheros AR5414 chip found (MAC: 0xa5, PHY: 0x61)
[   42.868873] b44 ssb0:0 eth0: Link is up at 100 Mbps, full duplex
[   42.869437] b44 ssb0:0 eth0: Flow control is off for TX and off for RX
[   42.870108] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   43.788129] Adding 1951740k swap on /dev/sda1.  Priority:-2 extents:1 across:1951740k 
[   43.879669] EXT4-fs (sda2): re-mounted. Quota mode: disabled.
[   44.683438] loop: module loaded
[   47.618816] fuse: init (API version 7.36)
[   47.839777] input: ACPI Virtual Keyboard Device as /devices/virtual/input/input14
[   55.500008] NET: Registered PF_AX25 protocol family

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
