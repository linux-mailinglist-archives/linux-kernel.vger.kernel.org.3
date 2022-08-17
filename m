Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D9B59786A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbiHQU6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241823AbiHQU55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:57:57 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0CFAB04A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:57:41 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id d1so10993076qvs.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=NSencxNLAYlXEjBY7G7wHQ85I3w1a9PoMMHRBumwv+M=;
        b=PCsr/WPwx9uPbLFkArNKjD83uUoWe1WgGbndd+/pXvFHPZkeh5HXx3QzWdzLwwCYYy
         IunQALRIHUxvbDRtIZ2wFaRmumntCgHR/3aXVPjcaDVz7jxFwkVzFZwSWBNHL+ZkPNMX
         oXLZbVgW/T5G4Q51MBBuMCqJzRnFmr2Rs8+Kgp9LdMrjoHYGDKlDJuMrSe1wobRh6neZ
         ph9j27eXXY4MLN7mIJ49u6XNkuo95Qjp6gn+MHn7Px6I1VR7K6TDaAHkQz66dGhkcTp1
         drwCvo8IAWN6PdmqL1+WemVzUbpvXzeJVipG7/3NJjQpOhJQr2iQCevqC6sEg6E5cO+g
         84Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=NSencxNLAYlXEjBY7G7wHQ85I3w1a9PoMMHRBumwv+M=;
        b=h6vrsy3bhn4xLNOO4R00kKbMzjQVCoLv8MPqVH7EskyQPv+/jCbaySjVW3ZgpYaqiR
         CJMDvYkvClhtGMwcZD6blH80hKsddoMtSMn2dTlPpSGLN3MEX7Bp5LLN9SU3JWfGLCMH
         AXImztuBOteEg34iO/M/X/aazgwUvQZlJZPMOrCdnPJKS02h5W5X+RBd+nb6YwANOkdn
         komZfxzd+W+lEMmK5bmd1pbdkDgWgJ2lskhylyZMWFf5kx2ty0GzsZi2NmBw4/PDwkG2
         B+Jv9TfesMOcb5uEJNcmDXnsu5AGx7Dr1GNO1m84ubZqQ1Gt5wfgywGJo9n7gmtnn2yx
         MGfA==
X-Gm-Message-State: ACgBeo2ftVLmyrod/+E7Vre1UJHRAZusi2MHMgbjznWLwDyv7ANwidMK
        qxyyCkMngJGDogddqLn2/XlY27/EvdtPFKgt3i8=
X-Google-Smtp-Source: AA6agR7sS4FOMjFp8oYIQ4gL5M5RZqi4Uj9IBODUSuhQLmLR5aaXYv3d6Hkh3AcdDuGz27tZaSaEEwDYPLFMvdAf1AU=
X-Received: by 2002:a05:6214:2462:b0:496:465f:702 with SMTP id
 im2-20020a056214246200b00496465f0702mr6089686qvb.84.1660769860173; Wed, 17
 Aug 2022 13:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsM58-8fxVKAVkwsshg+33B_1_t_WesG160AtVBe1ZvKiw@mail.gmail.com>
 <be6f1ce4-46b1-7a80-230c-b99f203ce8ad@riseup.net> <CABXGCsMFYnE+Wn2EAWuC8DSVj=TVprj6ABZwRK-hXcw-1hnMyw@mail.gmail.com>
 <CABXGCsMpGabZ32j_ObEHa_har2W8M8RWuqnx3d=yJT2NX_ztNg@mail.gmail.com>
 <20220817160751.moqhebkiuiydraka@mail.igalia.com> <CABXGCsOM9An-+EeaGWm0OA1FN2p94=BF210Lhy0tiO6ye9onWQ@mail.gmail.com>
 <dd2ee57a-2ab2-db94-36d9-8faced18fe61@riseup.net>
In-Reply-To: <dd2ee57a-2ab2-db94-36d9-8faced18fe61@riseup.net>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 18 Aug 2022 01:57:29 +0500
Message-ID: <CABXGCsMc_D_iJ-r-_s8q13Vq6dgfQg1tnp-0aojfv5Q8izTrfw@mail.gmail.com>
Subject: Re: [BUG][5.20] refcount_t: underflow; use-after-free
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Melissa Wen <mwen@igalia.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:43 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Hi Mikhail,
>
> Looks like 45ecaea738830b9d521c93520c8f201359dcbd95 ("drm/sched: Partial
> revert of 'drm/sched: Keep s_fence->parent pointer'") introduced the
> error. Try reverting it and check if the use-after-free still happens.

Thanks, but unfortunately, this did not lead to the expected result.
Again happens use-after-free in an incomprehensible context.
From the new: added warning "suspicious RCU usage" but it looks like
it is completely not related to the use-after-free issue.

[ 215.434115] ------------[ cut here ]------------
[ 215.434184] refcount_t: underflow; use-after-free.
[ 215.434204] WARNING: CPU: 7 PID: 1258 at lib/refcount.c:28
refcount_warn_saturate+0xba/0x110
[ 215.434214] Modules linked in: uinput rfcomm snd_seq_dummy
snd_hrtimer nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink
qrtr bnep sunrpc binfmt_misc snd_seq_midi snd_seq_midi_event
intel_rapl_msr intel_rapl_common snd_hda_codec_realtek vfat
snd_hda_codec_generic snd_hda_codec_hdmi mt76x2u fat mt76x2_common
snd_hda_intel mt76x02_usb snd_intel_dspcfg snd_intel_sdw_acpi mt76_usb
iwlmvm edac_mce_amd snd_usb_audio snd_hda_codec mt76x02_lib
snd_hda_core snd_usbmidi_lib snd_hwdep snd_rawmidi uvcvideo mt76
kvm_amd snd_seq videobuf2_vmalloc videobuf2_memops snd_seq_device
mac80211 videobuf2_v4l2 videobuf2_common kvm btusb iwlwifi snd_pcm
btrtl videodev libarc4 eeepc_wmi btbcm asus_wmi iwlmei btintel
ledtrig_audio xpad irqbypass sparse_keymap btmtk platform_profile
joydev
[ 215.434436] hid_logitech_hidpp rapl ff_memless mc snd_timer
bluetooth cfg80211 video pcspkr wmi_bmof snd soundcore k10temp
i2c_piix4 rfkill mei asus_ec_sensors acpi_cpufreq zram amdgpu
drm_ttm_helper ttm iommu_v2 ucsi_ccg gpu_sched crct10dif_pclmul
crc32_pclmul typec_ucsi drm_buddy crc32c_intel ghash_clmulni_intel ccp
igb sp5100_tco typec drm_display_helper nvme dca nvme_core cec wmi
ip6_tables ip_tables fuse
[ 215.434528] Unloaded tainted modules: amd64_edac():1 amd64_edac():1
amd64_edac():1 amd64_edac():1 amd64_edac():1 amd64_edac():1
amd64_edac():1 amd64_edac():1 amd64_edac():1 amd64_edac():1
amd64_edac():1 pcc_cpufreq():1 amd64_edac():1 pcc_cpufreq():1
pcc_cpufreq():1 amd64_edac():1 amd64_edac():1 pcc_cpufreq():1
pcc_cpufreq():1 amd64_edac():1 amd64_edac():1 pcc_cpufreq():1
amd64_edac():1 pcc_cpufreq():1 amd64_edac():1 pcc_cpufreq():1
amd64_edac():1 pcc_cpufreq():1 amd64_edac():1 pcc_cpufreq():1
amd64_edac():1 pcc_cpufreq():1 amd64_edac():1 pcc_cpufreq():1
amd64_edac():1 pcc_cpufreq():1 amd64_edac():1 pcc_cpufreq():1
amd64_edac():1 pcc_cpufreq():1 pcc_cpufreq():1 amd64_edac():1
amd64_edac():1 pcc_cpufreq():1 pcc_cpufreq():1 amd64_edac():1
pcc_cpufreq():1 amd64_edac():1 pcc_cpufreq():1 pcc_cpufreq():1
amd64_edac():1 pcc_cpufreq():1 pcc_cpufreq():1 amd64_edac():1
pcc_cpufreq():1 amd64_edac():1 pcc_cpufreq():1 pcc_cpufreq():1
pcc_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 fjes():1
[ 215.434672] pcc_cpufreq():1 fjes():1 pcc_cpufreq():1 fjes():1
pcc_cpufreq():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1
[ 215.434702] CPU: 7 PID: 1258 Comm: kworker/7:3 Tainted: G W L
------- --- 6.0.0-0.rc1.20220817git3cc40a443a04.14.fc38.x86_64 #1
[ 215.434709] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 4403 04/27/2022
[ 215.434715] Workqueue: events drm_sched_entity_kill_jobs_work [gpu_sched]
[ 215.434728] RIP: 0010:refcount_warn_saturate+0xba/0x110
[ 215.434734] Code: 01 01 e8 59 59 6f 00 0f 0b e9 22 46 a5 00 80 3d be
7d be 01 00 75 85 48 c7 c7 c0 99 8e 92 c6 05 ae 7d be 01 01 e8 36 59
6f 00 <0f> 0b e9 ff 45 a5 00 80 3d 99 7d be 01 00 0f 85 5e ff ff ff 48
c7
[ 215.434740] RSP: 0018:ffff9ccb0237fe60 EFLAGS: 00010286
[ 215.434747] RAX: 0000000000000026 RBX: ffff8d531f6f2828 RCX: 000000000000=
0000
[ 215.434753] RDX: 0000000000000001 RSI: ffffffff928d07a4 RDI: 00000000ffff=
ffff
[ 215.434757] RBP: ffff8d61e47f5600 R08: 0000000000000000 R09: ffff9ccb0237=
fd10
[ 215.434762] R10: 0000000000000003 R11: ffff8d622e2fffe8 R12: ffff8d61e47f=
c800
[ 215.434767] R13: ffff8d5313e95500 R14: ffff8d61e47fc805 R15: ffff8d531f6f=
2830
[ 215.434772] FS: 0000000000000000(0000) GS:ffff8d61e4600000(0000)
knlGS:0000000000000000
[ 215.434777] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 215.434782] CR2: 00007f0c8b815048 CR3: 00000001ab0e8000 CR4: 000000000035=
0ee0
[ 215.434788] Call Trace:
[ 215.434792] <TASK>
[ 215.434797] process_one_work+0x2a0/0x600
[ 215.434819] worker_thread+0x4f/0x3a0
[ 215.434830] ? process_one_work+0x600/0x600
[ 215.434836] kthread+0xf5/0x120
[ 215.434842] ? kthread_complete_and_exit+0x20/0x20
[ 215.434854] ret_from_fork+0x22/0x30
[ 215.434881] </TASK>
[ 215.434885] irq event stamp: 134873
[ 215.434890] hardirqs last enabled at (134881): [<ffffffff9118ce7e>]
__up_console_sem+0x5e/0x70
[ 215.434897] hardirqs last disabled at (134888): [<ffffffff9118ce63>]
__up_console_sem+0x43/0x70
[ 215.434903] softirqs last enabled at (131264): [<ffffffff910ff769>]
__irq_exit_rcu+0xf9/0x170
[ 215.434910] softirqs last disabled at (131257): [<ffffffff910ff769>]
__irq_exit_rcu+0xf9/0x170
[ 215.434917] ---[ end trace 0000000000000000 ]---

Full kerner log: https://pastebin.com/qED477Pz

--=20
Best Regards,
Mike Gavrilov.
