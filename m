Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84014EF8D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349848AbiDARYN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Apr 2022 13:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347073AbiDARYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:24:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D5E207A2D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:22:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1F0A767373; Fri,  1 Apr 2022 19:22:17 +0200 (CEST)
Date:   Fri, 1 Apr 2022 19:22:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Zhi Wang <zhi.a.wang@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v8 3/3] i915/gvt: Use the initial HW state snapshot
 saved in i915
Message-ID: <20220401172216.GA21871@lst.de>
References: <20220401130207.33944-1-zhi.a.wang@intel.com> <20220401130207.33944-4-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20220401130207.33944-4-zhi.a.wang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version still seems unhappy (same hardware as the last report):

[   38.650768] vfio_mdev 6814f392-50ac-4236-ae3d-26d472fd8aae: Adding to iommu group 0
[   38.880317] L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
[   39.736514] kvm [3037]: vcpu0, guest rIP: 0xffffffff81003e6e disabled perfctr wrmsr: 0xc2 data 0xffff
[   43.387606] general protection fault, probably for non-canonical address 0xd2ff1d88269987a: 0000 [#1] PREEMPT SMP PTI
[   43.387612] CPU: 0 PID: 3050 Comm: qemu-system-x86 Tainted: G            E     5.17.0+ #1296
[   43.387615] Hardware name: LENOVO 20KH006JGE/20KH006JGE, BIOS N23ET62W (1.37 ) 02/19/2019
[   43.387616] RIP: 0010:__x86_indirect_thunk_array+0x10/0x20
[   43.387621] Code: 43 54 e9 13 05 c4 ff 53 43 54 e9 db 8c c4 ff 53 43 54 e9 b3 4a d1 ff 53 43 54 e8 07 00 00 00 f3 90 0f ae e8 eb f9 48 89 04 24 <c3> 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 e8 07 00 00 00 f3
[   43.387623] RSP: 0018:ffffc0214461fe10 EFLAGS: 00010286
[   43.387626] RAX: 0d2ff1d88269987a RBX: ffff9d5808ae0000 RCX: 0000000000000004
[   43.387627] RDX: ffffc0214461fe80 RSI: 0000000000145000 RDI: ffffc021422c3000
[   43.387628] RBP: ffffc021422c3000 R08: 0000000000000001 R09: 00000000000a2800
[   43.387630] R10: ffffc0214461fe80 R11: ffffc0214461fe80 R12: 0000000000000004
[   43.387631] R13: 00000000fd145000 R14: 0000000000145000 R15: ffffc021422c3008
[   43.387632] FS:  00007f50c5576700(0000) GS:ffff9d5b92600000(0000) knlGS:0000000000000000
[   43.387633] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.387635] CR2: 0000000000000000 CR3: 0000000103de8005 CR4: 00000000003726f0
[   43.387636] Call Trace:
[   43.387638]  <TASK>
[   43.387640]  ? intel_vgpu_emulate_mmio_read+0xe9/0x390
[   43.387645]  ? intel_vgpu_rw.isra.0+0x1a7/0x1e0
[   43.387648]  ? intel_vgpu_read+0x15c/0x200
[   43.387650]  ? vfs_read+0x9b/0x190
[   43.387655]  ? __x64_sys_pread64+0x8d/0xc0
[   43.387658]  ? do_syscall_64+0x3b/0x90
[   43.387661]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
[   43.387664]  </TASK>
[   43.387665] Modules linked in: cmac(E) ctr(E) ccm(E) rfcomm(E) sd_mod(E) sg(E) uvcvideo(E) videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) videobuf2_common(E) btusb(E) videodev(E) btrtl(E) btbcm(E) btintel(E) mc(E) uas(E) usb_storage(E) scsi_mod(E) scsi_common(E) bnep(E) snd_hda_codec_hdmi(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) bluetooth(E) crc16(E) jitterentropy_rng(E) sha512_generic(E) coretemp(E) drbg(E) crc32_pclmul(E) ansi_cprng(E) ecdh_generic(E) ghash_clmulni_intel(E) ecc(E) wmi_bmof(E) intel_wmi_thunderbolt(E) intel_rapl_msr(E) joydev(E) aesni_intel(E) iwlmvm(E) libaes(E) snd_soc_skl(E) snd_soc_hdac_hda(E) crypto_simd(E) snd_ctl_led(E) snd_hda_ext_core(E) snd_soc_core(E) cryptd(E) snd_soc_acpi_intel_match(E) snd_soc_acpi(E) mac80211(E) snd_hda_codec_realtek(E) snd_soc_sst_ipc(E) snd_hda_codec_generic(E) snd_soc_sst_dsp(E) kvm_intel(E) libarc4(E) intel_cstate(E) snd_hda_intel(E) iwlwifi(E) snd_intel_dspcfg(E) intel_uncore(E) snd_hda_codec(E) pcspkr(E)
[   43.387700]  serio_raw(E) snd_hwdep(E) iTCO_wdt(E) efi_pstore(E) iTCO_vendor_support(E) snd_hda_core(E) tpm_crb(E) watchdog(E) thinkpad_acpi(E) snd_pcm(E) nvram(E) processor_thermal_device_pci_legacy(E) intel_soc_dts_iosf(E) ledtrig_audio(E) cfg80211(E) snd_timer(E) processor_thermal_device(E) platform_profile(E) tpm_tis(E) processor_thermal_rfim(E) processor_thermal_mbox(E) tpm_tis_core(E) snd(E) mei_me(E) ucsi_acpi(E) processor_thermal_rapl(E) tpm(E) typec_ucsi(E) soundcore(E) int3403_thermal(E) intel_rapl_common(E) mei(E) intel_pch_thermal(E) typec(E) rng_core(E) wmi(E) int340x_thermal_zone(E) rfkill(E) ac(E) battery(E) int3400_thermal(E) acpi_thermal_rel(E) evdev(E) acpi_pad(E) parport_pc(E) ppdev(E) lp(E) parport(E) efivarfs(E) ip_tables(E) x_tables(E) autofs4(E) i2c_designware_platform(E) i2c_designware_core(E) e1000e(E) nvme(E) xhci_pci(E) crc32c_intel(E) ptp(E) nvme_core(E) xhci_hcd(E) psmouse(E) t10_pi(E) i2c_i801(E) pps_core(E) i2c_smbus(E) thunderbolt(E) usbcore(E)
[   43.387733]  crc64_rocksoft(E) crc64(E) crc_t10dif(E) crct10dif_generic(E) intel_lpss_pci(E) crct10dif_pclmul(E) crct10dif_common(E) intel_lpss(E) idma64(E) usb_common(E) mfd_core(E)
[   43.387741] ---[ end trace 0000000000000000 ]---
