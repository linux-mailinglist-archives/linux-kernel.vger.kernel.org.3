Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315F74ED5B0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiCaIfv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Mar 2022 04:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiCaIfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:35:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB223EB86
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:33:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A49268AA6; Thu, 31 Mar 2022 10:33:55 +0200 (CEST)
Date:   Thu, 31 Mar 2022 10:33:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        Zhi Wang <zhi.a.wang@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v7 1/3] i915/gvt: Separate the MMIO tracking table from
 GVT-g
Message-ID: <20220331083355.GA21928@lst.de>
References: <20220325175251.167164-1-zhi.a.wang@intel.com> <20220328065008.GA29798@lst.de> <4af59d97-b583-4022-3ec3-360e7df43689@intel.com> <20220331074225.GA21004@lst.de> <d6345ebf-ccb1-9cb7-c154-a5e011c62cbe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <d6345ebf-ccb1-9cb7-c154-a5e011c62cbe@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 08:04:04AM +0000, Wang, Zhi A wrote:
> Hi Chris:
> 
> Thanks for the testing. Can you attach the dmesg? I tested mostly on my skylake desktop with some 3D workload.

Sure, I should have done that from the beginning:

[   25.354587] vfio_mdev 6814f392-50ac-4236-ae3d-26d472fd8aae: Adding to iommu group 0
[   25.583015] L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
[   26.429492] kvm [2555]: vcpu0, guest rIP: 0xffffffff81003e6e disabled perfctr wrmsr: 0xc2 data 0xffff
[   30.206202] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   30.206206] #PF: supervisor instruction fetch in kernel mode
[   30.206208] #PF: error_code(0x0010) - not-present page
[   30.206209] PGD 0 P4D 0 
[   30.206211] Oops: 0010 [#1] PREEMPT SMP PTI
[   30.206214] CPU: 6 PID: 2565 Comm: qemu-system-x86 Tainted: G            E     5.17.0+ #1292
[   30.206216] Hardware name: LENOVO 20KH006JGE/20KH006JGE, BIOS N23ET62W (1.37 ) 02/19/2019
[   30.206217] RIP: 0010:0x0
[   30.206223] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[   30.206224] RSP: 0018:ffffa775c3fb3e18 EFLAGS: 00010286
[   30.206226] RAX: 0000000000000000 RBX: ffff90a808bc0000 RCX: 0000000000000004
[   30.206227] RDX: ffffa775c3fb3e80 RSI: 0000000000042300 RDI: ffffa775c40ad000
[   30.206228] RBP: ffffa775c40ad000 R08: 0000000000000001 R09: 0000000000021180
[   30.206230] R10: ffffa775c3fb3e80 R11: ffffa775c3fb3e80 R12: 0000000000000004
[   30.206231] R13: 00000000fd042300 R14: 0000000000042300 R15: ffffa775c40ad008
[   30.206232] FS:  00007fdd9cbfc700(0000) GS:ffff90ab92780000(0000) knlGS:0000000000000000
[   30.206233] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.206235] CR2: ffffffffffffffd6 CR3: 00000001c117c002 CR4: 00000000003726e0
[   30.206236] Call Trace:
[   30.206238]  <TASK>
[   30.206239]  intel_vgpu_emulate_mmio_read+0xe9/0x390
[   30.206247]  intel_vgpu_rw.isra.0+0x1a7/0x1e0
[   30.206249]  intel_vgpu_read+0x15c/0x200
[   30.206252]  vfs_read+0x9b/0x190
[   30.206257]  __x64_sys_pread64+0x8d/0xc0
[   30.206259]  do_syscall_64+0x3b/0x90
[   30.206263]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   30.206266] RIP: 0033:0x7fddb17e41a7
[   30.206268] Code: 08 89 3c 24 48 89 4c 24 18 e8 f5 7b f9 ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 25 7c f9 ff 48 8b
[   30.206270] RSP: 002b:00007fdd9cbfb2f0 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
[   30.206272] RAX: ffffffffffffffda RBX: 000055ee30d20ed8 RCX: 00007fddb17e41a7
[   30.206273] RDX: 0000000000000004 RSI: 00007fdd9cbfb338 RDI: 000000000000001b
[   30.206274] RBP: 0000000000000004 R08: 0000000000000000 R09: 00000000ffffffff
[   30.206275] R10: 0000000000042300 R11: 0000000000000293 R12: 0000000000042300
[   30.206276] R13: 000055ee30d20df0 R14: 0000000000000004 R15: 0000000000042300
[   30.206278]  </TASK>
[   30.206279] Modules linked in: cmac(E) ctr(E) ccm(E) rfcomm(E) sd_mod(E) sg(E) uvcvideo(E) videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E) videobuf2_common(E) videodev(E) mc(E) btusb(E) btrtl(E) btbcm(E) btintel(E) uas(E) usb_storage(E) scsi_mod(E) scsi_common(E) bnep(E) snd_hda_codec_hdmi(E) wmi_bmof(E) intel_wmi_thunderbolt(E) joydev(E) bluetooth(E) intel_rapl_msr(E) crc16(E) x86_pkg_temp_thermal(E) jitterentropy_rng(E) intel_powerclamp(E) sha512_generic(E) drbg(E) coretemp(E) ansi_cprng(E) crc32_pclmul(E) ecdh_generic(E) ghash_clmulni_intel(E) ecc(E) aesni_intel(E) libaes(E) crypto_simd(E) iwlmvm(E) snd_soc_skl(E) cryptd(E) snd_soc_hdac_hda(E) mac80211(E) snd_ctl_led(E) snd_hda_ext_core(E) snd_hda_codec_realtek(E) libarc4(E) snd_soc_core(E) snd_hda_codec_generic(E) snd_soc_acpi_intel_match(E) kvm_intel(E) snd_soc_acpi(E) snd_soc_sst_ipc(E) iwlwifi(E) snd_soc_sst_dsp(E) intel_cstate(E) intel_uncore(E) snd_hda_intel(E) serio_raw(E) snd_intel_dspcfg(E) pcspkr(E)
[   30.206314]  snd_hda_codec(E) efi_pstore(E) snd_hwdep(E) tpm_crb(E) processor_thermal_device_pci_legacy(E) snd_hda_core(E) intel_soc_dts_iosf(E) iTCO_wdt(E) iTCO_vendor_support(E) cfg80211(E) processor_thermal_device(E) snd_pcm(E) tpm_tis(E) processor_thermal_rfim(E) thinkpad_acpi(E) watchdog(E) processor_thermal_mbox(E) tpm_tis_core(E) ucsi_acpi(E) nvram(E) mei_me(E) snd_timer(E) processor_thermal_rapl(E) ledtrig_audio(E) intel_pch_thermal(E) tpm(E) intel_rapl_common(E) mei(E) platform_profile(E) typec_ucsi(E) typec(E) rng_core(E) wmi(E) snd(E) battery(E) ac(E) soundcore(E) int3403_thermal(E) rfkill(E) int340x_thermal_zone(E) int3400_thermal(E) evdev(E) acpi_pad(E) acpi_thermal_rel(E) parport_pc(E) ppdev(E) lp(E) parport(E) efivarfs(E) ip_tables(E) x_tables(E) autofs4(E) i2c_designware_platform(E) i2c_designware_core(E) nvme(E) nvme_core(E) t10_pi(E) xhci_pci(E) e1000e(E) crc32c_intel(E) crc64_rocksoft(E) psmouse(E) xhci_hcd(E) ptp(E) i2c_i801(E) crc64(E) pps_core(E) thunderbolt(E)
[   30.206347]  i2c_smbus(E) crc_t10dif(E) usbcore(E) crct10dif_generic(E) intel_lpss_pci(E) crct10dif_pclmul(E) intel_lpss(E) crct10dif_common(E) idma64(E) mfd_core(E) usb_common(E)
[   30.206355] CR2: 0000000000000000
[   30.206356] ---[ end trace 0000000000000000 ]---
[   30.348825] RIP: 0010:0x0
[   30.348839] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[   30.348840] RSP: 0018:ffffa775c3fb3e18 EFLAGS: 00010286
[   30.348842] RAX: 0000000000000000 RBX: ffff90a808bc0000 RCX: 0000000000000004
[   30.348844] RDX: ffffa775c3fb3e80 RSI: 0000000000042300 RDI: ffffa775c40ad000
[   30.348845] RBP: ffffa775c40ad000 R08: 0000000000000001 R09: 0000000000021180
[   30.348846] R10: ffffa775c3fb3e80 R11: ffffa775c3fb3e80 R12: 0000000000000004
[   30.348847] R13: 00000000fd042300 R14: 0000000000042300 R15: ffffa775c40ad008
[   30.348849] FS:  00007fdd9cbfc700(0000) GS:ffff90ab92780000(0000) knlGS:0000000000000000
[   30.348850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.348851] CR2: ffffffffffffffd6 CR3: 00000001c117c002 CR4: 00000000003726e0
