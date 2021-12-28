Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606D2480DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 00:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbhL1XpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 18:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbhL1XpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 18:45:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68105C061574;
        Tue, 28 Dec 2021 15:45:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE3D9B808CF;
        Tue, 28 Dec 2021 23:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED149C36AE9;
        Tue, 28 Dec 2021 23:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640735110;
        bh=7u7GV1qH6g+5RnFKcsD4IgyME2WTGsGMyR16yxq1efw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TtqWnAYq+n2jlsdzL8GoUzKndGkmc40PorhcmXredy6bIlhzfYkt6BO1BMtAXtVz+
         EXu6H+Wyqw2+JOesXHd4KBxWWipwT5wuDBOxJPH9um+vdWPLsA+pyp2JpnbMnOflop
         FnTamg2EtKaIhVxk33b3DkHG5wPF7jtI2HqSCU6Qvu3qgSYRsemtCwQNpriTGgTOYa
         nvIzshTEWzyI6ek2LC9gGxU2yqf2CYyFyYIm2bYcCC8e4ppiCrjh+wYhneMLWAoQXA
         gYE/DsiyU5HvLNirZpUNjkcw8LWJ6cUhLaHQqqBeuC7/kB12qDJpuQOwzqJDNrud61
         onimBdoPb316Q==
Date:   Wed, 29 Dec 2021 01:45:08 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH v13 2/2] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
Message-ID: <YcuhhI2+k0XVuTb1@iki.fi>
References: <20211116162116.93081-1-jarkko@kernel.org>
 <20211116162116.93081-2-jarkko@kernel.org>
 <YbzhBrimHGGpddDM@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbzhBrimHGGpddDM@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:12:06PM -0700, Nathan Chancellor wrote:
> Hi Jarkko,
> 
> On Tue, Nov 16, 2021 at 06:21:16PM +0200, Jarkko Sakkinen wrote:
> > The amount of SGX memory on the system is determined by the BIOS and it
> > varies wildly between systems.  It can be from dozens of MB's on desktops
> > or VM's, up to many GB's on servers.  Just like for regular memory, it is
> > sometimes useful to know the amount of usable SGX memory in the system.
> > 
> > Introduce CONFIG_HAVE_ARCH_NODE_DEV_GROUP opt-in flag to expose an arch
> > specific attribute group, and add an attribute for the amount of SGX
> > memory in bytes to each NUMA node:
> > 
> > /sys/devices/system/node/nodeX/x86/sgx_total_bytes
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Apologies if this has already been reported or fixed, I haven't seen
> anything from a full search of lore.kernel.org.
> 
> With this patch in -next as commit 50468e431335 ("x86/sgx: Add an
> attribute for the amount of SGX memory in a NUMA node"), this sysfs node
> causes an OOPS for me on at least one of my test systems (Intel based):
> 
> # cat /sys/devices/system/node/node0/x86/sgx_total_bytes
> fish: Job 1, 'cat /sys/devices/system/node/no…' terminated by signal SIGKILL (Forced quit)
> 
> # dmesg
> [   56.956995] BUG: kernel NULL pointer dereference, address: 0000000000000020
> [   56.957003] #PF: supervisor read access in kernel mode
> [   56.957006] #PF: error_code(0x0000) - not-present page
> [   56.957009] PGD 0 P4D 0
> [   56.957013] Oops: 0000 [#2] PREEMPT SMP PTI
> [   56.957017] CPU: 1 PID: 866 Comm: cat Tainted: G      D           5.16.0-rc5-next-20211217-debug #1 15ae5b0f28a4b9b6343440ee595affa8e1b5cf57
> [   56.957022] Hardware name: ASUSTeK COMPUTER INC. Q302LA/Q302LA, BIOS Q302LA.203 05/15/2014
> [   56.957024] RIP: 0010:sgx_total_bytes_show+0x28/0x40
> [   56.957032] Code: 66 90 0f 1f 44 00 00 49 89 f8 48 89 d7 48 c7 c6 5f b1 52 a4 41 8b 80 98 02 00 00 48 8d 04 40 48 c1 e0 04 48 03 05 38 b1 3c 02 <48> 8b 50 20 e8 ff ee 3b 00 48 98 31 d2 89 d6 89 d7 41 89 d0 c3 0f
> [   56.957035] RSP: 0018:ffffb79c81447d60 EFLAGS: 00010246
> [   56.957039] RAX: 0000000000000000 RBX: ffffffffa4c30ec0 RCX: 0000000000000000
> [   56.957041] RDX: ffff95d502b95000 RSI: ffffffffa452b15f RDI: ffff95d502b95000
> [   56.957044] RBP: ffffffffa41567c0 R08: ffff95d5002a0400 R09: 0000000000000000
> [   56.957046] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb79c81447e28
> [   56.957048] R13: ffffb79c81447e00 R14: ffff95d5041247a8 R15: 0000000000000001
> [   56.957051] FS:  00007f4ab25af600(0000) GS:ffff95d616e80000(0000) knlGS:0000000000000000
> [   56.957054] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   56.957056] CR2: 0000000000000020 CR3: 00000001029e8005 CR4: 00000000001706e0
> [   56.957060] Call Trace:
> [   56.957062]  <TASK>
> [   56.957064]  dev_attr_show+0x19/0x40
> [   56.957072]  sysfs_kf_seq_show+0xa1/0x120
> [   56.957080]  seq_read_iter+0x12e/0x4c0
> [   56.957085]  new_sync_read+0x159/0x1f0
> [   56.957093]  vfs_read+0xff/0x1a0
> [   56.957099]  ksys_read+0x67/0xf0
> [   56.957105]  do_syscall_64+0x5c/0x90
> [   56.957110]  ? syscall_exit_to_user_mode+0x23/0x50
> [   56.957116]  ? exc_page_fault+0x72/0x180
> [   56.957121]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   56.957128] RIP: 0033:0x7f4ab24d1862
> [   56.957131] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 5a 29 0a 00 e8 55 e4 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
> [   56.957134] RSP: 002b:00007ffff14dac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   56.957137] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f4ab24d1862
> [   56.957140] RDX: 0000000000020000 RSI: 00007f4ab20d8000 RDI: 0000000000000003
> [   56.957142] RBP: 00007f4ab20d8000 R08: 00007f4ab20d7010 R09: 0000000000000000
> [   56.957144] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000020000
> [   56.957146] R13: 0000000000000003 R14: 0000000000000000 R15: 00007ffff14daf18
> [   56.957150]  </TASK>
> [   56.957152] Modules linked in: 8021q garp mrp stp llc snd_hda_codec_hdmi ccm
> algif_aead cbc x86_pkg_temp_thermal des_generic intel_powerclamp libdes
> coretemp ecb kvm_intel algif_skcipher kvm ax88796b irqbypass cmac
> crct10dif_pclmul i915 crc32_pclmul md4 ghash_clmulni_intel algif_hash
> snd_hda_codec_realtek af_alg snd_hda_codec_generic ledtrig_audio uvcvideo
> asus_nb_wmi aesni_intel snd_hda_intel intel_spi_platform i2c_algo_bit iwlmvm
> videobuf2_vmalloc asus_wmi snd_intel_dspcfg ttm snd_intel_sdw_acpi crypto_simd
> joydev ak8975 intel_spi iTCO_wdt btusb mousedev spi_nor sparse_keymap
> intel_pmc_bxt at24 cryptd videobuf2_memops iTCO_vendor_support mac80211
> hid_multitouch mtd platform_profile btrtl intel_rapl_msr mei_hdcp snd_hda_codec
> btbcm rapl libarc4 videobuf2_v4l2 drm_kms_helper intel_cstate
> processor_thermal_device_pci_legacy asix intel_uncore syscopyarea selftests
> btintel snd_hda_core videobuf2_common pcspkr iwlwifi snd_hwdep
> processor_thermal_device vfat btmtk i2c_i801 sysfillrect usbnet
> [   56.957229]  snd_pcm processor_thermal_rfim psmouse fat sysimgblt i2c_smbus
> bluetooth videodev processor_thermal_mbox snd_timer processor_thermal_rapl
> fb_sys_fops mii cfg80211 mei_me usbhid snd ecdh_generic mdio_devres mc
> inv_mpu6050_i2c intel_rapl_common cec crc16 int340x_thermal_zone libphy lpc_ich
> rfkill intel_gtt mei soundcore intel_soc_dts_iosf inv_mpu6050 acpi_als wmi
> dell_smo8800 industrialio_triggered_buffer int3400_thermal video i2c_mux
> kfifo_buf soc_button_array industrialio acpi_thermal_rel asus_wireless mac_hid
> drm pkcs8_key_parser fuse bpf_preload ip_tables x_tables xfs libcrc32c
> crc32c_generic serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci
> xhci_pci_renesas serio
> [   56.957286] CR2: 0000000000000020
> [   56.957289] ---[ end trace 0000000000000000 ]---
> [   56.957291] RIP: 0010:sgx_total_bytes_show+0x28/0x40
> [   56.957296] Code: 66 90 0f 1f 44 00 00 49 89 f8 48 89 d7 48 c7 c6 5f b1 52 a4 41 8b 80 98 02 00 00 48 8d 04 40 48 c1 e0 04 48 03 05 38 b1 3c 02 <48> 8b 50 20 e8 ff ee 3b 00 48 98 31 d2 89 d6 89 d7 41 89 d0 c3 0f
> [   56.957299] RSP: 0018:ffffb79c8118fd58 EFLAGS: 00010246
> [   56.957301] RAX: 0000000000000000 RBX: ffffffffa4c30ec0 RCX: 0000000000000000
> [   56.957304] RDX: ffff95d50403d000 RSI: ffffffffa452b15f RDI: ffff95d50403d000
> [   56.957306] RBP: ffffffffa41567c0 R08: ffff95d5002a0400 R09: 0000000000000000
> [   56.957308] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb79c8118fe20
> [   56.957310] R13: ffffb79c8118fdf8 R14: ffff95d503fd0550 R15: 0000000000000001
> [   56.957312] FS:  00007f4ab25af600(0000) GS:ffff95d616e80000(0000) knlGS:0000000000000000
> [   56.957315] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   56.957317] CR2: 0000000000000020 CR3: 00000001029e8005 CR4: 00000000001706e0
> 
> If I can provide any further information or testing, let me know!

Dave, when is the fix going to be applied [*]?

> 
> Cheers,
> Nathan

[*] https://lore.kernel.org/linux-sgx/YcGTePmWDMOQU1pn@iki.fi/T/#m831a01bdde347f9e0af2c973986fae0499718201

BR,
Jarkko
