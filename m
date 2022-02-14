Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ED44B4DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350273AbiBNLPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:15:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350369AbiBNLPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:15:09 -0500
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61934EFF91
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:44:22 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id e11so11018428ils.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8UlwMVVLWhmPlE/PNpTYvysOndyoiHtzqJZyRftJj4M=;
        b=AVM+oRgDoJvmVS47nh8NK0cfXTK4BGEzKeYJPO2OtIcgzHLMVwIApM4le/RFKmNTou
         i9AonBvIoui/OY1JxTZH4C6T0iEc4GPsqlP6mcBCrUysMXpc21EfiG+fGnY9fwdKU95L
         576NpKGc0f+Yijj3Ep33RJPQeI1vexmdkJFgTt8jD5t/mDZ/MdMCjSF2euWzUzGxfpVE
         lGu2JNJcLKtl8oMgB9O9d755MxrjgjIz7IahNUwu8qh80dipa5Bl5ljPvhqm0o/qiwj8
         lcKh6+YyytgqfLV4+L+h3S6a6+rT2IVGeJdgFeN+97mDCKKeWv6bkIX+oTNR+F79GupU
         gsWw==
X-Gm-Message-State: AOAM530j+tqmHYQFC10X59lP0dadPL6GtgUtbyTPrkhFjYT+ZpfYsVhX
        6yRUo2FWhtx5tChs0A4IcTTqjZT5oaxy1jHn5rDprkE=
X-Google-Smtp-Source: ABdhPJxXnRbdKYAk/eQEjSASB4PhnFbCrNay6Iay1SGwgHXpGogu4ezLDXvE+rYrzbw3+Midtc7CBkSj6bDX8P8UwbY=
X-Received: by 2002:a05:6e02:2199:: with SMTP id j25mr7941276ila.296.1644835461287;
 Mon, 14 Feb 2022 02:44:21 -0800 (PST)
MIME-Version: 1.0
References: <CAJtcoLbNJrTjjHpFxgXwe+aJaw4=Und37yuym89RKSBCwSyCSQ@mail.gmail.com>
In-Reply-To: <CAJtcoLbNJrTjjHpFxgXwe+aJaw4=Und37yuym89RKSBCwSyCSQ@mail.gmail.com>
From:   Martin Knoblauch <knobi@knobisoft.de>
Date:   Mon, 14 Feb 2022 11:44:10 +0100
Message-ID: <CAJtcoLbmF1vT6HQ3ZhQJW6cYpp6c=GEakeegQOwUXrO8dSHoOQ@mail.gmail.com>
Subject: Re: Possible regression on suspend (mem/s2idle) between 5.15 and 5.16
To:     linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
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

Hi,

 sorry for top posting, but this is likely important enough. The
problem seems to be gone with 5.17-rc4. So I guess there is some
potential for putting a fix into 5.16.x. If that rings a bell, I am
happy to test that. Unfortunately I do not have the time for
bisection.

Adding the Nouveau list

Cheers
Martin

On Fri, Feb 11, 2022 at 4:26 PM Martin Knoblauch <knobi@knobisoft.de> wrote:
>
> Hi,
>
>  sorry for the likely insufficient report. I am running Tumbleweed on
> a Dell Notebook with a TU117GLM gfx, using the Nouveau driver. Kernel
> is homegrown. Ever since going from 5.15.12 to 5.16.x (x now 9),
> suspend stopped working reliably. After a maximum of three
> suspend/resume cycles the box would reboot spontaneously.
>
> I have found the following in dmesg output:
>
> # cat > bad-suspend.txt
> [   87.120765] PM: suspend entry (s2idle)
> [   87.124895] Filesystems sync: 0.004 seconds
> [   87.155826] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [   87.157424] OOM killer disabled.
> [   87.157424] Freezing remaining freezable tasks ... (elapsed 0.001
> seconds) done.
> [   87.158520] printk: Suspending console(s) (use no_console_suspend to debug)
> [   87.159501] e1000e: EEE TX LPI TIMER: 00000011
> [   87.164889] sd 4:0:0:0: [sda] Synchronizing SCSI cache
> [   87.164980] sd 4:0:0:0: [sda] Stopping disk
> ==> [   87.169576] nouveau 0000:01:00.0: acr: unload binary failed
> [   87.622136] ACPI: EC: interrupt blocked
> [   99.986273] ACPI: EC: interrupt unblocked
> [  102.826726] sd 4:0:0:0: [sda] Starting disk
> [  102.836370] nouveau 0000:01:00.0: fifo: fault 00 [VIRT_READ] at
> 0000000000000000 engine 0e [sec2] client 16 [HUB/SEC] reason 00 [PDE]
> on channel -1 [00ffe5d000 unknown]
> [  102.836389] nouveau 0000:01:00.0: fifo: runlist 3: scheduled for recovery
> [  102.836395] nouveau 0000:01:00.0: fifo: engine 3: scheduled for recovery
> [  102.936294] ------------[ cut here ]------------
> [  102.936295] nouveau 0000:01:00.0: timeout
> [  102.936312] WARNING: CPU: 3 PID: 3734 at
> drivers/gpu/drm/nouveau/nvkm/falcon/v1.c:247
> nvkm_falcon_v1_wait_for_halt+0xb7/0xc0 [nouveau]
> [  102.936351] Modules linked in: uvcvideo videobuf2_vmalloc
> snd_usb_audio videobuf2_memops videobuf2_v4l2 snd_usbmidi_lib
> videobuf2_common snd_rawmidi cmac algif_hash algif_skcipher af_alg
> bnep af_packet btusb btrtl btbcm btintel bluetooth ecdh_generic ecc
> vboxnetadp(O) vboxnetflt(O) vboxdrv(O) iwlmvm mac80211 libarc4
> iTCO_wdt iTCO_vendor_support x86_pkg_temp_thermal intel_powerclamp
> coretemp dell_smm_hwmon kvm_intel iwlwifi snd_ctl_led
> snd_hda_codec_realtek kvm snd_hda_codec_generic ledtrig_audio
> snd_hda_codec_hdmi irqbypass sha256_ssse3 sha256_generic libsha256
> pcspkr wmi_bmof snd_hda_intel cfg80211 snd_intel_dspcfg e1000e
> i2c_i801 snd_hda_codec i2c_smbus rfkill snd_hwdep snd_hda_core snd_pcm
> snd_timer mei_me snd mei soundcore thermal battery ac nls_iso8859_1
> nls_cp437 vfat fat squashfs loop fuse configfs crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel aesni_intel nouveau crypto_simd i915
> cryptd drm_ttm_helper mxm_wmi i2c_algo_bit ttm serio_raw
> drm_kms_helper nvme xhci_pci nvme_core
> [  102.936378]  drm xhci_hcd wmi video button btrfs blake2b_generic
> libcrc32c crc32c_intel xor raid6_pq zstd_compress sg dm_multipath
> dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [  102.936385] CPU: 3 PID: 3734 Comm: kworker/u24:53 Tainted: G
>    O      5.16.9-1-default #1
> [  102.936386] Hardware name: Dell Inc. Precision 7540/0JWGT7, BIOS
> 1.7.0 01/07/2020
> [  102.936387] Workqueue: events_unbound async_run_entry_fn
> [  102.936391] RIP: 0010:nvkm_falcon_v1_wait_for_halt+0xb7/0xc0 [nouveau]
> [  102.936422] Code: 8b 40 10 48 8b 78 10 4c 8b 67 50 4d 85 e4 75 03
> 4c 8b 27 e8 cb 90 dd e0 4c 89 e2 48 c7 c7 32 35 a7 a0 48 89 c6 e8 e0
> 8a 12 e1 <0f> 0b eb a7 e8 40 ee 17 e1 0f 1f 44 00 00 41 54 be 80 96 98
> 00 55
> [  102.936422] RSP: 0018:ffffc90002aebb70 EFLAGS: 00010246
> [  102.936424] RAX: 0000000000000000 RBX: ffffffffffffff92 RCX: 0000000000000000
> [  102.936425] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  102.936425] RBP: ffff88810bbdfc98 R08: 0000000000000000 R09: 0000000000000000
> [  102.936426] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888101d83bc0
> [  102.936426] R13: 0000000000000000 R14: 0000000000000000 R15: ffff888102f13400
> [  102.936427] FS:  0000000000000000(0000) GS:ffff88887c2c0000(0000)
> knlGS:0000000000000000
> [  102.936428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  102.936429] CR2: 0000562dd42c70a2 CR3: 000000000560a001 CR4: 00000000003706e0
> [  102.936430] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  102.936430] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  102.936431] Call Trace:
> [  102.936432]  <TASK>
> [  102.936434]  gm200_acr_hsfw_boot+0xc6/0x170 [nouveau]
> [  102.936466]  nvkm_acr_hsf_boot+0x82/0x100 [nouveau]
> [  102.936496]  tu102_acr_init+0x15/0x30 [nouveau]
> [  102.936526]  nvkm_acr_load+0x3e/0x110 [nouveau]
> [  102.936555]  ? nvkm_notify_get+0x5c/0x70 [nouveau]
> [  102.936583]  ? ktime_get+0x39/0xa0
> [  102.936586]  nvkm_subdev_init+0x97/0xe0 [nouveau]
> [  102.936614]  ? ktime_get+0x39/0xa0
> [  102.936616]  nvkm_device_init+0x127/0x1d0 [nouveau]
> [  102.936664]  nvkm_udevice_init+0x45/0x70 [nouveau]
> [  102.936709]  nvkm_object_init+0x3b/0x130 [nouveau]
> [  102.936738]  nvkm_object_init+0x73/0x130 [nouveau]
> [  102.936766]  nvkm_object_init+0x73/0x130 [nouveau]
> [  102.936795]  nouveau_do_resume+0x2b/0xc0 [nouveau]
> [  102.936842]  nouveau_pmops_resume+0x67/0x90 [nouveau]
> [  102.936888]  ? pci_legacy_resume+0x80/0x80
> [  102.936891]  dpm_run_callback+0x49/0x150
> [  102.936893]  device_resume+0x105/0x280
> [  102.936895]  ? pm_dev_err+0x34/0x34
> [  102.936897]  async_resume+0x19/0x30
> [  102.936899]  async_run_entry_fn+0x2b/0x110
> [  102.936901]  process_one_work+0x1e5/0x3b0
> [  102.936903]  worker_thread+0x4d/0x3e0
> [  102.936904]  ? rescuer_thread+0x3a0/0x3a0
> [  102.936905]  kthread+0x146/0x170
> [  102.936906]  ? set_kthread_struct+0x50/0x50
> [  102.936907]  ret_from_fork+0x1f/0x30
> [  102.936910]  </TASK>
> [  102.936910] ---[ end trace e592260dfc1c79fb ]---
> [  102.936912] nouveau 0000:01:00.0: acr: AHESASC binary failed
> [  102.936913] nouveau 0000:01:00.0: acr: init failed, -110
> [  102.937027] nouveau 0000:01:00.0: init failed with -110
> [  102.937028] nouveau: Xorg.bin[1996]:00000000:00000080: init failed with -110
> [  102.937029] nouveau: DRM-master:00000000:00000000: init failed with -110
> [  102.937029] nouveau: DRM-master:00000000:00000000: init failed with -110
> [  102.937030] nouveau 0000:01:00.0: DRM: Client resume failed with error: -110
> [  102.937032] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -110
> [  102.937040] nouveau 0000:01:00.0: PM: failed to resume async: error -110
> [  103.134577] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  103.137666] ata5.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
> [  103.137670] ata5.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
> LOCK) filtered out
> [  103.137672] ata5.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
> CONFIGURATION OVERLAY) filtered out
> [  103.137838] ata5.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected
> by device (Stat=0x51 Err=0x04)
> [  103.138290] ata5.00: supports DRM functions and may not be fully accessible
> [  103.139265] ata5.00: disabling queued TRIM support
> [  103.143959] ata5.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
> [  103.143963] ata5.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
> LOCK) filtered out
> [  103.143964] ata5.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
> CONFIGURATION OVERLAY) filtered out
> [  103.144103] ata5.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected
> by device (Stat=0x51 Err=0x04)
> [  103.144532] ata5.00: supports DRM functions and may not be fully accessible
> [  103.145328] ata5.00: disabling queued TRIM support
> [  103.148888] ata5.00: configured for UDMA/133
> [  103.159132] ahci 0000:00:17.0: port does not support device sleep
> [  103.159591] ata5.00: Enabling discard_zeroes_data
> [  103.674691] OOM killer enabled.
> [  103.674692] Restarting tasks ... done.
> [  103.719371] PM: suspend exit
> [  103.992941] [drm:lspcon_init [i915]] *ERROR* Failed to probe lspcon
> [  103.993000] [drm:intel_dp_detect_dpcd [i915]] *ERROR* LSPCON init
> failed on port D
> [  106.221326] e1000e 0000:00:1f.6 em1: NIC Link is Up 1000 Mbps Full
> Duplex, Flow Control: Rx/Tx
>
> The unusual thing is the "nouveau 0000:01:00.0: acr: unload binary
> failed" message. This does not happen with 5.15.x kernels. Has anybody
> else seen this with 5.16?
>
> Happy weekend
> Martin
> --
> ------------------------------------------------------
> Martin Knoblauch
> email: k n o b i AT knobisoft DOT de
> www: http://www.knobisoft.de
