Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6D510A46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354929AbiDZUW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354926AbiDZUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:22:24 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7BF1A73FF;
        Tue, 26 Apr 2022 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1651004345;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:To:Cc:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=T+gA++UZtTjFuYAmY/nN3XzDzCsaiQIP4G9Onhil2co=;
    b=O6x3WMrOhbY4ilIYUoaC2TGZ4w0iLn9K9BKNK/QD6YwOhLyfL+SdX+PC4BlFI+QWdb
    WF2D7eJnDcZ6fk26KluuRXCGLrBw9D4chQXmMtng2OJJrLrrn/+EfKyrQVd0/TYPj+qW
    EU0cFvu3s1rwb4EjENk0jDGH+Edyqn05pbwCG4QiSxxTnYPA0NCuofeAK0ait1L1w2/N
    UtULAifGC6ycoGBhhxvZZx4lK8j/wCIkGuSS8d5IrBBERXVbo05Hz1+tLEQ/Qdr9pfJj
    9GO8u0SRbtMQpG/YZg/755/Vq1D0MAdDPPx6O7+zHfN/KLZR3KQzJjQVvkBUXkwaLUuk
    MgTA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw4vkcA=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy3QKJ4zum
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 26 Apr 2022 22:19:04 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Date:   Tue, 26 Apr 2022 22:19:04 +0200
Subject: kernel panic with v5.18-rc1 on OpenPandora (only)
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Message-Id: <FA654A0D-29B7-4B6B-B613-73598A92ADA8@goldelico.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,
I ran across a new issue on the OpenPandora (omap3530) first appearing =
with v5.18-rc1.
It seems as if there is something happening within the omap3 L3 irq =
handler which
is used (only?) for the wl1251. And this triggers the timeout BUG_ON() =
in
omap3_l3_app_irq().

I have not seen this issue on the GTA04.

It goes away if I remove the wlan interrupt from =
omap3-pandora-common.dtsi.
Interestingly, removing the wl1251.ko does NOT stop it. So it is not the =
driver.

git bisect reported:

a1c510d0adc604bb143c86052bc5be48cbcfa17c is the first bad commit
commit a1c510d0adc604bb143c86052bc5be48cbcfa17c
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Thu Sep 23 09:15:53 2021 +0200

    ARM: implement support for vmap'ed stacks
   =20
Any ideas?

BR and thanks,
Nikolaus

...
[   27.357666] omap_hsmmc 480ad000.mmc: found wl1251
[   27.465332] OF: graph: no port node found in =
/ocp@68000000/isp@480bc000/ports
[   27.535552] wl1251: using dedicated interrupt line
[   27.597839] usb0: HOST MAC 32:70:05:18:ff:78
[   27.751281] ------------[ cut here ]------------
[   27.756164] kernel BUG at drivers/bus/omap_l3_smx.c:177!
[   27.761749] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[   27.767913] Modules linked in: omap3_isp(+) v4l2_fwnode v4l2_async =
wl1251_sdio(+) videobuf2_dma_contig videobuf2_memops wl1251 usb_f_ecm =
videobuf2_v4l2 videobuf2_common bq27xxx_battery_hdq omap_sham videodev =
mac80211 mc omap_aes_driver libarc4 crypto_engine omap_crypto g_ether =
usb_f_rndis u_ether omap_hdq libcomposite configfs panel_tpo_td043mtea1 =
omap2430(+) phy_twl4030_usb musb_hdrc twl4030_pwrbutton twl4030_charger =
twl4030_madc snd_soc_twl4030 industrialio twl4030_keypad ehci_omap =
bq27xxx_battery_i2c bq27xxx_battery pandora_nub omapdrm cfg80211 =
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm =
drm_panel_orientation_quirks cec ip_tables x_tables ipv6 autofs4
[   27.831207] CPU: 0 PID: 1812 Comm: systemd-udevd Not tainted =
5.16.0-rc1-letux+ #9435
[   27.839355] Hardware name: Generic OMAP3 (Flattened Device Tree)
[   27.845672] PC is at omap3_l3_app_irq+0x3c/0x120
[   27.850555] LR is at __handle_irq_event_percpu+0xb0/0x1f8
[   27.856262] pc : [<c053f5a4>]    lr : [<c017d36c>]    psr: 20070193
[   27.862854] sp : e0001eb0  ip : 0dcf2f92  fp : c0d04014
[   27.868377] r10: e0001f00  r9 : c1032200  r8 : 00000000
[   27.873870] r7 : e0001f84  r6 : 0000001a  r5 : 00000000  r4 : =
f8000000
[   27.880767] r3 : 00000000  r2 : 00080000  r1 : 00080000  r0 : =
00080000
[   27.887634] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  =
Segment none
[   27.895263] Control: 10c5387d  Table: 829a8019  DAC: 00000051
[   27.901306] Register r0 information: non-paged memory
[   27.906646] Register r1 information: non-paged memory
[   27.911987] Register r2 information: non-paged memory
[   27.917297] Register r3 information: NULL pointer
[   27.922271] Register r4 information: 0-page vmalloc region starting =
at 0xf8000000 allocated at iotable_init+0x0/0xf4
[   27.933380] Register r5 information: NULL pointer
[   27.938354] Register r6 information: non-paged memory
[   27.943695] Register r7 information: 2-page vmalloc region starting =
at 0xe0000000 allocated at start_kernel+0x5c0/0x918
[   27.955047] Register r8 information: NULL pointer
[   27.959991] Register r9 information: slab kmalloc-256 start c1032200 =
pointer offset 0 size 256
[   27.969085] Register r10 information: 2-page vmalloc region starting =
at 0xe0000000 allocated at start_kernel+0x5c0/0x918
[   27.980529] Register r11 information: non-slab/vmalloc memory
[   27.986572] Register r12 information: non-paged memory
[   27.991973] Process systemd-udevd (pid: 1812, stack limit =3D =
0x9cb9744d)
[   27.998931] Stack: (0xe0001eb0 to 0xe0002000)
[   28.003509] 1ea0:                                     0000001a =
c111a880 00000000 c111a800
[   28.012115] 1ec0: c1032200 0000001a e0001f84 c017d36c c1032200 =
e0001f00 00000000 c0d03fc8
[   28.020721] 1ee0: c1032200 c1032218 e0001f84 c0c79374 c29a15c0 =
c0deb720 e0001f50 c017d4d8
[   28.029296] 1f00: 00000000 ea298583 c1032200 c103226c c1032218 =
c017d55c c1032200 c103226c
[   28.037902] 1f20: c1032218 c0181c64 c0c7f684 e0001f50 00000000 =
c017ccbc c0c7f684 c0901018
[   28.046508] 1f40: c0101314 60070113 ffffffff c0100b60 c29a15c0 =
c0c805c0 00000000 1ed14000
[   28.055114] 1f60: c0c805c0 c0c805c0 00000040 c0d02d00 c0c79374 =
c29a15c0 c0deb720 c0d02080
[   28.063690] 1f80: 0dcf2f92 e0001fa0 c01012e0 c0101314 60070113 =
ffffffff 00000051 c01012e0
[   28.072265] 1fa0: c29a15c0 e01ddb8c e01dda50 00400140 0000000a =
ffff95a7 c1005c50 c0c805c0
[   28.080871] 1fc0: c0d02d00 c0c805c0 c29a15c0 c29a15c0 60070013 =
ffffffff e01dda84 e01ddab0
[   28.089447] 1fe0: c29a15c0 e01ddb8c e01dda50 c0136f10 c0905de0 =
c0137008 c0905de0 c0100b60
[   28.098052] [<c053f5a4>] (omap3_l3_app_irq) from [<c017d36c>] =
(__handle_irq_event_percpu+0xb0/0x1f8)
[   28.107666] [<c017d36c>] (__handle_irq_event_percpu) from =
[<c017d4d8>] (handle_irq_event_percpu+0x24/0x70)
[   28.117797] [<c017d4d8>] (handle_irq_event_percpu) from [<c017d55c>] =
(handle_irq_event+0x38/0x5c)
[   28.127136] [<c017d55c>] (handle_irq_event) from [<c0181c64>] =
(handle_level_irq+0x7c/0xb4)
[   28.135864] [<c0181c64>] (handle_level_irq) from [<c017ccbc>] =
(handle_irq_desc+0x1c/0x2c)
[   28.144470] [<c017ccbc>] (handle_irq_desc) from [<c0901018>] =
(generic_handle_arch_irq+0x2c/0x44)
[   28.153717] [<c0901018>] (generic_handle_arch_irq) from [<c0100b60>] =
(__irq_svc+0x80/0xb8)
[   28.162414] Exception stack(0xe0001fa0 to 0xe0001fe8)
[   28.167755] 1fa0: c29a15c0 e01ddb8c e01dda50 00400140 0000000a =
ffff95a7 c1005c50 c0c805c0
[   28.176330] 1fc0: c0d02d00 c0c805c0 c29a15c0 c29a15c0 60070013 =
ffffffff e01dda84 e01ddab0
[   28.184906] 1fe0: c29a15c0 e01ddb8c
[   28.188598] [<c0100b60>] (__irq_svc) from [<c0101314>] =
(__do_softirq+0x84/0x304)
[   28.196380] [<c0101314>] (__do_softirq) from [<c0136f10>] =
(__irq_exit_rcu+0x8c/0xd4)
[   28.204528] [<c0136f10>] (__irq_exit_rcu) from [<c0137008>] =
(irq_exit+0x8/0x10)
[   28.212219] [<c0137008>] (irq_exit) from [<c0100b60>] =
(__irq_svc+0x80/0xb8)
[   28.219543] Exception stack(0xe01ddaa0 to 0xe01ddae8)
[   28.224884] daa0: 7fffffff c0902e94 00000004 00000000 c29a15c0 =
e01ddb90 e01ddb90 ea298583
[   28.233459] dac0: 00000000 e01ddb8c e01ddb88 7fffffff 00000002 =
00000010 00000100 c202a000
[   28.242065] dae0: 97ff8010 c0902f54
[   28.245727] [<c0100b60>] (__irq_svc) from [<c0905de0>] =
(_raw_spin_unlock_irq+0x20/0x4c)
[   28.254150] [<c0905de0>] (_raw_spin_unlock_irq) from [<c0902e94>] =
(do_wait_for_common+0xa8/0x138)
[   28.263488] [<c0902e94>] (do_wait_for_common) from [<c0902f54>] =
(wait_for_common+0x30/0x48)
[   28.272277] [<c0902f54>] (wait_for_common) from [<c074edf8>] =
(mmc_wait_for_req_done+0x1c/0x90)
[   28.281341] [<c074edf8>] (mmc_wait_for_req_done) from [<c075a72c>] =
(mmc_io_rw_extended+0x1c0/0x2f4)
[   28.290893] [<c075a72c>] (mmc_io_rw_extended) from [<c075bd00>] =
(sdio_io_rw_ext_helper+0x118/0x140)
[   28.300415] [<c075bd00>] (sdio_io_rw_ext_helper) from [<c075bdd0>] =
(sdio_memcpy_toio+0x18/0x20)
[   28.309570] [<c075bdd0>] (sdio_memcpy_toio) from [<bf3de1ec>] =
(wl1251_sdio_write+0x34/0x54 [wl1251_sdio])
[   28.319702] [<bf3de1ec>] (wl1251_sdio_write [wl1251_sdio]) from =
[<bf40fc8c>] (wl1251_set_partition+0x90/0x404 [wl1251])
[   28.331207] [<bf40fc8c>] (wl1251_set_partition [wl1251]) from =
[<bf4074ec>] (wl1251_init_ieee80211+0x1c0/0x3dc [wl1251])
[   28.342712] [<bf4074ec>] (wl1251_init_ieee80211 [wl1251]) from =
[<bf3de474>] (wl1251_sdio_probe+0x1a0/0x250 [wl1251_sdio])
[   28.354339] [<bf3de474>] (wl1251_sdio_probe [wl1251_sdio]) from =
[<c075aee8>] (sdio_bus_probe+0x128/0x138)
[   28.364410] [<c075aee8>] (sdio_bus_probe) from [<c061c7d4>] =
(really_probe+0x170/0x2fc)
[   28.372741] [<c061c7d4>] (really_probe) from [<c061ca24>] =
(__driver_probe_device+0xc4/0xd8)
[   28.381530] [<c061ca24>] (__driver_probe_device) from [<c061ca68>] =
(driver_probe_device+0x30/0xac)
[   28.390960] [<c061ca68>] (driver_probe_device) from [<c061ce98>] =
(__driver_attach+0xc4/0xd8)
[   28.399841] [<c061ce98>] (__driver_attach) from [<c061acec>] =
(bus_for_each_dev+0x64/0xa0)
[   28.408447] [<c061acec>] (bus_for_each_dev) from [<c061bc2c>] =
(bus_add_driver+0x148/0x1a4)
[   28.417144] [<c061bc2c>] (bus_add_driver) from [<c061d700>] =
(driver_register+0xb4/0xf8)
[   28.425567] [<c061d700>] (driver_register) from [<bf29d00c>] =
(wl1251_sdio_init+0xc/0x1000 [wl1251_sdio])
[   28.435577] [<bf29d00c>] (wl1251_sdio_init [wl1251_sdio]) from =
[<c0101f94>] (do_one_initcall+0x90/0x1c8)
[   28.445587] [<c0101f94>] (do_one_initcall) from [<c08f4e00>] =
(do_init_module+0x4c/0x204)
[   28.454132] [<c08f4e00>] (do_init_module) from [<c01b5148>] =
(load_module+0x13f0/0x1928)
[   28.462524] [<c01b5148>] (load_module) from [<c01b58b8>] =
(sys_finit_module+0xa0/0xc0)
[   28.470794] [<c01b58b8>] (sys_finit_module) from [<c0100270>] =
(__sys_trace_return+0x0/0x10)
[   28.479583] Code: e0000002 e0011003 e1901001 0a000002 (e7f001f2)=20
[   28.485992] ---[ end trace 6855b0c4a2214070 ]---
[   28.490844] Kernel panic - not syncing: Fatal exception in interrupt
[   28.497528] ---[ end Kernel panic - not syncing: Fatal exception in =
interrupt ]---

