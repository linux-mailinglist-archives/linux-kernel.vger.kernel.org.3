Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8955AC07C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiICSEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiICSEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:04:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2961C6573;
        Sat,  3 Sep 2022 11:04:31 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id j6so3960871qkl.10;
        Sat, 03 Sep 2022 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=svgUOYW+cDH6FRePzSpZfB9jTFKGZLHOswRFjbQ1bCU=;
        b=lmX59Pdr+nr/QnexTD7iNf3t+Av2D09u6pSg1N/sNy4zZ1trAAPLV2Fcrc5feiD7eV
         tZLRltZmriX0BSNhvtbkCJ3pfWt7Ld0YkY6ULnqsotslHg6X0lPmcop10vXLXRGFdOLt
         IIGpcH1PDZjX9ulc6ivYPOYQHrWijVR7TsF2PT1jXqsvakbqUA20Q6Klr87zv8BhsKLB
         zmc6xFZFkLwLvlYB1/V9RoCFsQu0gnVMy76jUmqdYGEsAxMEZYdX5ICmbnFzp1HSxhot
         W29hikOPG1ymeFMxsLsrJF82cBQm0StAYpzWj2R9jFsX4fiPHnPRt1RrCGy+asrU79a+
         yVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=svgUOYW+cDH6FRePzSpZfB9jTFKGZLHOswRFjbQ1bCU=;
        b=a9MG5vmQ1/BGFxLHjsaG2OXDo8m+ubjbCV+bg+uroQyzvY/t3khdKkLasvKegA/gti
         2pKPJkRjSL+KGQ2Sqeqr+/cOoCdYinNkB0WamjWlI9/WM6WbDtxqn4Kuz96QF1hMBFyE
         XL+yHrlu9uvGig9/STV4SBMp/9tEPJmUT/8upMSiSIPvRO+jUHK3Se9BMUD4LMXJTujI
         r7yV99iq9FHWCuoFTmG5DvCfR3srTvM0jaEeoCobgUnDYMPLe24L2errw+VcBEUxdyH4
         jLzPUhR7rghzQgGY5wkwG/FlBhwX3rny8U/FgrfHvrIkAujWQiK/Zr5s524DCx81cDgF
         5t8g==
X-Gm-Message-State: ACgBeo3alZu4Fim3HZb+POVQXyKrgJI9efyBDybt9GmLd1PBhNoDAQxJ
        k2FGfhGGP9M/BDG5mKrJWaRW5Mkt2xuFi/Hy2z9pF4nxkVndYNcSUtU=
X-Google-Smtp-Source: AA6agR7SS+CPGYGTDQa2FvFhVZq3dO1bBGq71pG9VDpMEuekUJHp1+8FJP2thzfhHpFoItqWM1vWhaFYcw2RsRtGS7w=
X-Received: by 2002:a37:6350:0:b0:6bc:65fd:29fc with SMTP id
 x77-20020a376350000000b006bc65fd29fcmr28101665qkb.580.1662228270094; Sat, 03
 Sep 2022 11:04:30 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 3 Sep 2022 23:04:19 +0500
Message-ID: <CABXGCsO+kB2t5QyHY-rUe76npr1m0-5JOtt8g8SiHUo34ur7Ww@mail.gmail.com>
Subject: [BUG] commit a8d302a0b77057568350fe0123e639d02dba0745 cause
 IO_PAGE_FAULT and a lot of errors
To:     tiwai@suse.de,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am bisecting issue that cause errors:
[   57.710235] snd_hda_intel 0000:03:00.1: spurious response
0xeb0cce6a:0x8b612b0d, rp = 1, wp = 1
[   57.710240] ------------[ cut here ]------------
[   57.710241] BUG?
[   57.710257] amd_iommu_report_page_fault: 216 callbacks suppressed
[   57.710260] snd_hda_intel 0000:03:00.1: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x000e address=0x152848808 flags=0x0020]
[   57.710270] snd_hda_intel 0000:03:00.1: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x000e address=0x152848800 flags=0x0000]
[   57.710276] snd_hda_intel 0000:03:00.1: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x000e address=0x152848810 flags=0x0020]
[   57.710282] snd_hda_intel 0000:03:00.1: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x000e address=0x152848810 flags=0x0000]
[   57.710278] WARNING: CPU: 5 PID: 968 at
sound/hda/hdac_controller.c:215
snd_hdac_bus_update_rirb.cold+0x24/0x5b [snd_hda_core]
[   57.710289] Modules linked in: uinput
[   57.710291] snd_hda_intel 0000:03:00.1: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x000e address=0x152848818 flags=0x0020]
[   57.710292]  rfcomm snd_seq_dummy snd_hrtimer nft_objref
nf_conntrack_netbios_ns nf_conntrack_broadcast
[   57.710296] snd_hda_intel 0000:03:00.1: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x000e address=0x152848810 flags=0x0000]
[   57.710297]  nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4
[   57.710302] snd_hda_intel 0000:03:00.1: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x000e address=0x152848820 flags=0x0020]
[   57.710301]  nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack
[   57.710307] snd_hda_intel 0000:03:00.1: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x000e address=0x152848820 flags=0x0000]
[   57.710306]  nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables
nfnetlink qrtr bnep
[   57.710312] snd_hda_intel 0000:03:00.1: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x000e address=0x152848828 flags=0x0020]
[   57.710313]  snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_codec_hdmi intel_rapl_msr snd_sof_amd_renoir snd_sof_amd_acp
[   57.710318] snd_hda_intel 0000:03:00.1: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x000e address=0x152848820 flags=0x0000]
[   57.710318]  intel_rapl_common mt7921e snd_sof_pci mt7921_common
snd_sof sunrpc snd_sof_utils mt76_connac_lib snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi snd_soc_core mt76 snd_hda_codec
snd_compress ac97_bus edac_mce_amd snd_hda_core snd_pcm_dmaengine
btusb snd_pci_acp6x binfmt_misc snd_hwdep kvm_amd btrtl mac80211 btbcm
snd_seq vfat btintel libarc4 snd_seq_device btmtk kvm fat bluetooth
snd_pcm irqbypass snd_pci_acp5x cfg80211 rapl snd_timer
snd_rn_pci_acp3x snd_acp_config joydev snd pcspkr snd_soc_acpi
wmi_bmof asus_nb_wmi soundcore snd_pci_acp3x k10temp i2c_piix4
asus_wireless amd_pmc zram amdgpu drm_ttm_helper ttm iommu_v2 hid_asus
gpu_sched asus_wmi ledtrig_audio drm_buddy drm_display_helper
sparse_keymap crct10dif_pclmul platform_profile ucsi_acpi nvme
crc32_pclmul hid_multitouch crc32c_intel ghash_clmulni_intel serio_raw
typec_ucsi rfkill ccp nvme_core cec r8169 sp5100_tco typec wmi video
i2c_hid_acpi i2c_hid ip6_tables ip_tables fuse
[   57.710389] CPU: 5 PID: 968 Comm: systemd-logind Tainted: G
W    L     6.0.0-rc2-06-a8d302a0b77057568350fe0123e639d02dba0745+ #65
[   57.710392] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G513QY_G513QY/G513QY, BIOS G513QY.318 03/29/2022
[   57.710394] RIP: 0010:snd_hdac_bus_update_rirb.cold+0x24/0x5b [snd_hda_core]
[   57.710403] Code: f0 e9 10 9f ff ff 48 8b 3b 41 89 e9 44 89 e9 44
89 fa 48 c7 c6 e0 53 c4 c1 e8 38 85 2a f0 48 c7 c7 0e 0c c4 c1 e8 df
0d 26 f0 <0f> 0b 0f b7 83 c0 03 00 00 e9 6a bf ff ff 48 8b 3b 44 89 e9
44 89
[   57.710406] RSP: 0000:ffffab4e05f1fe20 EFLAGS: 00010082
[   57.710408] RAX: 0000000000000004 RBX: ffff99c7415b9028 RCX: 0000000000000000
[   57.710410] RDX: 0000000000010002 RSI: ffffffffb28cf864 RDI: 00000000ffffffff
[   57.710412] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffab4e05f1fcd0
[   57.710414] R10: 0000000000000003 R11: ffff99d65d2fffe8 R12: ffff99c7415b9540
[   57.710415] R13: 000000008b612b0d R14: 0000000000000001 R15: 00000000eb0cce6a
[   57.710417] FS:  00007f0fd0b9bbc0(0000) GS:ffff99d617600000(0000)
knlGS:0000000000000000
[   57.710419] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.710421] CR2: 00007f364c00c0f8 CR3: 0000000153686000 CR4: 0000000000750ee0
[   57.710423] PKRU: 55555554
[   57.710425] Call Trace:
[   57.710427]  <TASK>
[   57.710431]  azx_interrupt+0x83/0x110 [snd_hda_codec]
[   57.710443]  __handle_irq_event_percpu+0x93/0x330
[   57.710449]  handle_irq_event+0x34/0x70
[   57.710452]  handle_fasteoi_irq+0x90/0x1e0
[   57.710455]  __common_interrupt+0x71/0x150
[   57.710460]  common_interrupt+0x5c/0xd0
[   57.710465]  asm_common_interrupt+0x22/0x40
[   57.710469] RIP: 0033:0x7f0fd17c56e4
[   57.710471] Code: 00 0f 1f 44 00 00 f3 0f 1e fa f2 ff 25 15 61 2d
00 0f 1f 44 00 00 f3 0f 1e fa f2 ff 25 0d 61 2d 00 0f 1f 44 00 00 f3
0f 1e fa <f2> ff 25 05 61 2d 00 0f 1f 44 00 00 f3 0f 1e fa f2 ff 25 fd
60 2d
[   57.710473] RSP: 002b:00007ffdafa5db78 EFLAGS: 00000202
[   57.710475] RAX: 0000000000000358 RBX: 0000557736741ed0 RCX: 00007f0fd16473eb
[   57.710476] RDX: 0000557736741f0c RSI: 0000557736741ed0 RDI: 0000557736742000
[   57.710477] RBP: 00007ffdafa5dba0 R08: 000055773674f3d0 R09: 0000000557736755
[   57.710479] R10: 0000000000000000 R11: 0000000000000202 R12: 0000557736734d00
[   57.710480] R13: 0000557736734d00 R14: 0000557736734d00 R15: 0000557736733a30
[   57.710485]  </TASK>
[   57.710487] irq event stamp: 268268
[   57.710488] hardirqs last  enabled at (268267):
[<ffffffffb1f273b4>] _raw_write_unlock_irq+0x24/0x50
[   57.710491] hardirqs last disabled at (268268):
[<ffffffffb1f1ddfc>] __schedule+0xe2c/0x16d0
[   57.710495] softirqs last  enabled at (267528):
[<ffffffffb10fe6a9>] __irq_exit_rcu+0xf9/0x170
[   57.710499] softirqs last disabled at (267487):
[<ffffffffb10fe6a9>] __irq_exit_rcu+0xf9/0x170
[   57.710502] ---[ end trace 0000000000000000 ]---
[   57.710514] snd_hdac_bus_update_rirb: 22 callbacks suppressed
[   57.710515] snd_hda_intel 0000:03:00.1: spurious response
0x2b0dec20:0xf61a0b81, last cmd=0x000000
[   57.710523] snd_hda_intel 0000:03:00.1: spurious response
0x84f2e10f:0xdb14c123, last cmd=0x000000
[   57.710525] snd_hda_intel 0000:03:00.1: spurious response
0x1826d07:0x9c2987ff, rp = 5, wp = 9
[   57.710527] ------------[ cut here ]------------

and bisect said this commit causes it:
a8d302a0b77057568350fe0123e639d02dba0745 is the first bad commit
commit a8d302a0b77057568350fe0123e639d02dba0745
Author: Takashi Iwai <tiwai@suse.de>
Date:   Sun Aug 21 17:59:11 2022 +0200

    ALSA: memalloc: Revive x86-specific WC page allocations again

    We dropped the x86-specific hack for WC-page allocations with a hope
    that the standard dma_alloc_wc() works nowadays.  Alas, it doesn't,
    and we need to take back some workaround again, but in a different
    form, as the previous one was broken for some platforms.

    This patch re-introduces the x86-specific WC-page allocations, but it
    uses rather the manual page allocations instead of
    dma_alloc_coherent().  The use of dma_alloc_coherent() was also a
    potential problem in the recent addition of the fallback allocation
    for noncontig pages, and this patch eliminates both at once.

    Fixes: 9882d63bea14 ("ALSA: memalloc: Drop x86-specific hack for
WC allocations")
    Cc: <stable@vger.kernel.org>
    BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216363
    Link: https://lore.kernel.org/r/20220821155911.10715-1-tiwai@suse.de
    Signed-off-by: Takashi Iwai <tiwai@suse.de>

 sound/core/memalloc.c | 87 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 16 deletions(-)

Full kernel log is here: https://pastebin.com/RMtNAYPe

-- 
Best Regards,
Mike Gavrilov.
