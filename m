Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02885668C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiGEK6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiGEK5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:57:02 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A26167EB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:56:15 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 119A058742592; Tue,  5 Jul 2022 12:56:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 1110260F56A42;
        Tue,  5 Jul 2022 12:56:14 +0200 (CEST)
Date:   Tue, 5 Jul 2022 12:56:14 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     tiwai@suse.de
cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: snd_cs46xx regression, producing Oops
Message-ID: <p2p1s96o-746-74p4-s95-61qo1p7782pn@vanv.qr>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Commit v5.14-rc1-39-g5bff69b3645d introduced a breakage into
snd_cs46xx. When loading the module, an Oops is thrown. The system
works fine afterwards, but the final reboot/poweroff message to ACPI
has no effect after such Oops occurred. (Blacklisting snd_cs46xx
works around the reboot problem.)

bisected to:
commit 5bff69b3645db7b3018ecbc26218d8866aeaf214
Author: Takashi Iwai <tiwai@suse.de>
Date:   Thu Jul 15 09:58:52 2021 +0200

    ALSA: cs46xx: Allocate resources with device-managed APIs
    
    This patch converts the resource management in PCI cs46xx driver with
    devres as a clean up.  Each manual resource management is converted
    with the corresponding devres helper, and the card object release is
    managed now via card->private_free instead of a lowlevel snd_device.


trace log from modern kernel:
[    0.000000] Linux version 5.18.9 (jengelh@f3) (gcc (SUSE Linux) 12.1.0, GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.38.20220525-6) #3 PREEMPT_DYNAMIC Tue Jul 5 10:43:37 CEST 2022
...
[   32.475313] snd_intel8x0 0000:00:02.7: intel8x0_measure_ac97_clock: measured 59821 usecs (2877 samples)
[   32.475410] snd_intel8x0 0000:00:02.7: clocking to 48000
[   33.683930] snd_cs46xx 0000:00:0d.0: Direct firmware load for cs46xx/cwc4630 failed with error -2
[   33.684035] snd_cs46xx 0000:00:0d.0: firmware load error [cwc4630]
[   33.684092] snd_cs46xx: probe of 0000:00:0d.0 failed with error -2
[   33.684772] BUG: unable to handle page fault for address: f7cd846c
[   33.684833] #PF: supervisor write access in kernel mode
[   33.684886] #PF: error_code(0x0002) - not-present page
[   33.684936] *pde = 010e9067 *pte = 00000000 
[   33.684992] Oops: 0002 [#1] PREEMPT
[   33.685045] CPU: 0 PID: 413 Comm: systemd-udevd Tainted: G            E     5.18.9 #3 aa51fdb6e59156e58028f32c0abfef9c9b603d9b
[   33.685119] Hardware name: ECS L7S7A2/L7S7A2, BIOS 07.00T 04/02/01
[   33.685172] EIP: snd_cs46xx_codec_write+0x3b/0xe0 [snd_cs46xx]
[   33.685265] Code: ec 18 83 7d 08 01 89 45 f0 0f 8f b0 00 00 00 89 f0 0f b7 f9 8b 8e 58 01 00 00 ba 01 00 00 00 e8 cb 83 af da 8b 46 28 8b 4d f0 <89> 88 6c 04 00 00 8b 46 28 89 b8 70 04 00 00 8b 46 28 05 60 04 00
[   33.685356] EAX: f7cd8000 EBX: c232c548 ECX: 00000002 EDX: 00000001
[   33.685410] ESI: c232c548 EDI: 00009f9f EBP: c1fd5b08 ESP: c1fd5ae4
[   33.685463] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00210297
[   33.685528] CR0: 80050033 CR2: f7cd846c CR3: 0335d000 CR4: 00000690
[   33.685581] Call Trace:
[   33.685637]  ? snd_cs46xx_codec_write+0xe0/0xe0 [snd_cs46xx 58d1cdc18910e2717003e6be0e13f1fe4cf1ef4e]
[   33.685721]  snd_cs46xx_ac97_write+0x2a/0x50 [snd_cs46xx 58d1cdc18910e2717003e6be0e13f1fe4cf1ef4e]
[   33.685804]  snd_ac97_write+0x51/0x80 [snd_ac97_codec 9efa9e43a5e3a59d5b4ae0b33ee748e5f4f27a3a]
[   33.685908]  snd_ac97_powerdown+0xc9/0x120 [snd_ac97_codec 9efa9e43a5e3a59d5b4ae0b33ee748e5f4f27a3a]
[   33.685990]  snd_ac97_dev_free+0x13/0x30 [snd_ac97_codec 9efa9e43a5e3a59d5b4ae0b33ee748e5f4f27a3a]
[   33.686072]  __snd_device_free+0x3d/0x80 [snd 6a4ed59569dfc8ba5a4beabb0b5a692067dfc833]
[   33.686178]  snd_device_free_all+0x43/0x80 [snd 6a4ed59569dfc8ba5a4beabb0b5a692067dfc833]
[   33.686260]  release_card_device+0x23/0x90 [snd 6a4ed59569dfc8ba5a4beabb0b5a692067dfc833]
[   33.686340]  device_release+0x37/0xa0
[   33.686399]  kobject_put+0xb1/0x230
[   33.686454]  ? snd_card_disconnect+0x134/0x230 [snd 6a4ed59569dfc8ba5a4beabb0b5a692067dfc833]
[   33.686536]  put_device+0x11/0x20
[   33.686587]  __snd_card_release+0x69/0x80 [snd 6a4ed59569dfc8ba5a4beabb0b5a692067dfc833]
[   33.686668]  release_nodes+0x3d/0xb0
[   33.686726]  devres_release_all+0x77/0xd0
[   33.686780]  device_unbind_cleanup+0x10/0x60
[   33.686833]  really_probe+0x1ee/0x370
[   33.686885]  ? pm_runtime_barrier+0x44/0x90
[   33.686945]  __driver_probe_device+0x111/0x200
[   33.686998]  ? kernfs_create_dir_ns+0x79/0xc0
[   33.687053]  driver_probe_device+0x27/0xa0
[   33.687106]  __driver_attach+0xb7/0x1b0
[   33.687158]  ? __device_attach_driver+0x100/0x100
[   33.687211]  bus_for_each_dev+0x5a/0x90
[   33.687263]  driver_attach+0x1e/0x30
[   33.687314]  ? __device_attach_driver+0x100/0x100
[   33.687366]  bus_add_driver+0x14f/0x200
[   33.687419]  driver_register+0x7c/0xd0
[   33.687469]  ? sysfs_add_bin_file_mode_ns+0x67/0xd0
[   33.687524]  ? 0xf7f10000
[   33.687574]  __pci_register_driver+0x3c/0x40
[   33.687628]  cs46xx_driver_init+0x1c/0x1000 [snd_cs46xx 58d1cdc18910e2717003e6be0e13f1fe4cf1ef4e]
[   33.687710]  do_one_initcall+0x3f/0x1a0
[   33.687764]  ? kmem_cache_alloc_trace+0x13f/0x2f0
[   33.687822]  ? do_init_module+0x24/0x240
[   33.687882]  do_init_module+0x46/0x240
[   33.687935]  ? __vfree+0x20/0x50
[   33.687992]  load_module+0x2393/0x2540
[   33.691234]  ? try_module_get+0xb0/0xb0
[   33.691293]  __ia32_sys_finit_module+0xb4/0x130
[   33.691351]  __do_fast_syscall_32+0x67/0xb0
[   33.691411]  ? syscall_exit_to_user_mode+0x1a/0x40
[   33.691466]  ? __do_fast_syscall_32+0x71/0xb0
[   33.691519]  ? irqentry_exit_to_user_mode+0x8/0x20
[   33.691571]  do_fast_syscall_32+0x31/0x70
[   33.691624]  do_SYSENTER_32+0x15/0x20
[   33.691676]  entry_SYSENTER_32+0x98/0xf0
[   33.691732] EIP: 0xb7f27549
[   33.691782] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[   33.691873] EAX: ffffffda EBX: 00000012 ECX: b7bbe036 EDX: 00000000
[   33.691926] ESI: b7bc5dd8 EDI: 01add640 EBP: ffffff08 ESP: bfee05ac
[   33.691979] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200246
[   33.692046] Modules linked in: drm_ttm_helper(E) snd_cs46xx(E+) ttm(E) snd_rawmidi(E) mxm_wmi(E) snd_intel8x0(E) wmi(E) pcspkr(E) snd_ac97_codec(E) video(E) ac97_bus(E) 8139too(E) snd_pcm(E) drm_dp_helper(E) 8139cp(E) sis900(E) snd_timer(E) parport_pc(E) mii(E) tiny_power_button(E) snd(E) soundcore(E) i2c_sis96x(E) button(E) parport(E) ext4(E) mbcache(E) jbd2(E) fuse(E) configfs(E) ip_tables(E) x_tables(E) xfs(E) libcrc32c(E) hid_generic(E) usbhid(E) sr_mod(E) cdrom(E) ata_generic(E) ohci_pci(E) serio_raw(E) sata_sil(E) ohci_hcd(E) ehci_pci(E) ehci_hcd(E) pata_sis(E) usbcore(E) libata(E) floppy(E) sg(E)
[   33.692314] CR2: 00000000f7cd846c
[   33.692365] ---[ end trace 0000000000000000 ]---
[   33.692414] EIP: snd_cs46xx_codec_write+0x3b/0xe0 [snd_cs46xx]
[   33.692483] Code: ec 18 83 7d 08 01 89 45 f0 0f 8f b0 00 00 00 89 f0 0f b7 f9 8b 8e 58 01 00 00 ba 01 00 00 00 e8 cb 83 af da 8b 46 28 8b 4d f0 <89> 88 6c 04 00 00 8b 46 28 89 b8 70 04 00 00 8b 46 28 05 60 04 00
[   33.692572] EAX: f7cd8000 EBX: c232c548 ECX: 00000002 EDX: 00000001
[   33.692626] ESI: c232c548 EDI: 00009f9f EBP: c1fd5b08 ESP: c1fd5ae4
[   33.692679] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00210297
[   33.692742] CR0: 80050033 CR2: f7cd846c CR3: 0335d000 CR4: 00000690

On a 5.14, it's just the three lines
  snd_cs46xx 0000:00:0d.0: Direct firmware load for cs46xx/cwc4630 failed with error -2
  snd_cs46xx 0000:00:0d.0: firmware load error [cwc4630]
  snd_cs46xx: probe of 0000:00:0d.0 failed with error -2
and life goes on.
