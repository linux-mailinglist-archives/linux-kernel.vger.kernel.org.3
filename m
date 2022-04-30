Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4B2515D6D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbiD3NUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiD3NUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:20:09 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5191195A26;
        Sat, 30 Apr 2022 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1651324568;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=3zGwMI7wb1IdcDUlZW1T5Z66DDsPImI+iGd0yDi8/Tg=;
    b=ri2xQlzzHPGNH1PrFvXjrkfFCJEgl71AtycxVxLUNYkG9/T04xQBHSr6+NblmQao9Z
    pZ/WbrsQoa9sRaF+vRS5+iMM+79iNTYBnMnqGeiXHyRvDwKPDgn0pxH/j9BX23xpC/lR
    wxuR0CCjI5Z6BY1ycsOuXix9RWPjYwUlyAIJo3TsDk3UGM4LKdCnTdZx+TLf3YkAICqf
    vEWIWIDKL+lKnN2/mtfPwRxHc4KppLCTBSiJH+R5l+EEmyL6pP2MEf/R26Yy2FVrcnIK
    w/QFDi5RD7UohKTlSmaArp9jW4MHi1PHekqRYtUgfis+yJwNZhMN/vKbX4LpeoCcy+sS
    4tcQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDOsdZY="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy3UDG8MGN
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 30 Apr 2022 15:16:08 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: kernel panic with v5.18-rc1 on OpenPandora (only)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAK8P3a3N9WBWC_ECB0pSRHUCT4iz=tdT+Dt9Cyd5Wh3qEaVqqA@mail.gmail.com>
Date:   Sat, 30 Apr 2022 15:16:07 +0200
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CE23DC3-B3E5-45C1-91F3-B88E5444AE7C@goldelico.com>
References: <FA654A0D-29B7-4B6B-B613-73598A92ADA8@goldelico.com>
 <YmkBAsa+fKlp/GcV@atomide.com>
 <CAK8P3a3N9WBWC_ECB0pSRHUCT4iz=tdT+Dt9Cyd5Wh3qEaVqqA@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 27.04.2022 um 11:37 schrieb Arnd Bergmann <arnd@arndb.de>:
>=20
> On Wed, Apr 27, 2022 at 10:38 AM Tony Lindgren <tony@atomide.com> =
wrote:
>> * H. Nikolaus Schaller <hns@goldelico.com> [220426 20:16]:
>>> [   28.245727] [<c0100b60>] (__irq_svc) from [<c0905de0>] =
(_raw_spin_unlock_irq+0x20/0x4c)
>>> [   28.254150] [<c0905de0>] (_raw_spin_unlock_irq) from [<c0902e94>] =
(do_wait_for_common+0xa8/0x138)
>>> [   28.263488] [<c0902e94>] (do_wait_for_common) from [<c0902f54>] =
(wait_for_common+0x30/0x48)
>>> [   28.272277] [<c0902f54>] (wait_for_common) from [<c074edf8>] =
(mmc_wait_for_req_done+0x1c/0x90)
>>> [   28.281341] [<c074edf8>] (mmc_wait_for_req_done) from =
[<c075a72c>] (mmc_io_rw_extended+0x1c0/0x2f4)
>>> [   28.290893] [<c075a72c>] (mmc_io_rw_extended) from [<c075bd00>] =
(sdio_io_rw_ext_helper+0x118/0x140)
>>> [   28.300415] [<c075bd00>] (sdio_io_rw_ext_helper) from =
[<c075bdd0>] (sdio_memcpy_toio+0x18/0x20)
>>> [   28.309570] [<c075bdd0>] (sdio_memcpy_toio) from [<bf3de1ec>] =
(wl1251_sdio_write+0x34/0x54 [wl1251_sdio])
>>> [   28.319702] [<bf3de1ec>] (wl1251_sdio_write [wl1251_sdio]) from =
[<bf40fc8c>] (wl1251_set_partition+0x90/0x404 [wl1251])
>>> [   28.331207] [<bf40fc8c>] (wl1251_set_partition [wl1251]) from =
[<bf4074ec>] (wl1251_init_ieee80211+0x1c0/0x3dc [wl1251])
>=20
> I think the problem is here: wl1251_set_partition() passes a local
> stack variable into
> an SDIO API function that is given to the hardware. This was never
> safe and could
> cause a corrupted stack because of the cache management, but with vmap =
stacks
> it turns into a reliable DMA error, which I guess is what the l3
> interrupt is about.

This seems to me to be a fitting explanation. Thanks!

>=20
> Can you change wl1251_set_partition() to use kmalloc()/kfree() to =
allocate the
> partitions[] array?

Yes, I have tried and made it use struct wl1251_partition_set. Diff is =
attached.

> You said that it still crashes without the wl1251
> driver, so I assume
> there is at least one more related bug. If you get a different call
> chain without the
> driver, or with the kmalloc() call, can you post that as well?

For some time it did disappear but reported  e.g.

[   29.457946] omap_hsmmc 480ad000.mmc: found wl1251
[   29.516174] wl1251: ERROR unsupported chip id: 0xdb0aea56

(value did change a little randomly), but just before sending out this =
mail I tried
again (now with v5.18-rc4) and got this log (with wl1251 driver fixed as =
below):

[   29.813232] omap_hsmmc 480ad000.mmc: found wl1251
[   30.131164] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP =
CCP2 was not initialized!
[   30.432006] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP =
CSI2a was not initialized!
[   30.660888] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP =
CCDC was not initialized!
[   30.791229] wl1251: 151 tx blocks at 0x3b788, 35 rx blocks at 0x3a780
[   30.811218] wl1251: firmware booted (Rev 4.0.4.3.7)
[   30.817047] ------------[ cut here ]------------
[   30.821899] kernel BUG at drivers/bus/omap_l3_smx.c:177!
[   30.827484] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[   30.833618] Modules linked in: snd_soc_omap_mcbsp snd_soc_ti_sdma =
omap3_isp(+) wl1251_sdio videobuf2_dma_contig videobuf2_memops wl1251 =
videobuf2_v4l2 usb_f_ecm videobuf2_common v4l2_fwnode g_ether v4l2_async =
usb_f_rndis u_ether libcomposite configfs mac80211 bq27xxx_battery_hdq =
videodev omap_sham libarc4 mc omap_aes_driver crypto_engine omap_hdq =
panel_tpo_td043mtea1 ads7846 omap_crypto omap2430 phy_twl4030_usb =
musb_hdrc twl4030_pwrbutton twl4030_charger twl4030_madc snd_soc_twl4030 =
industrialio twl4030_keypad ehci_omap bq27xxx_battery_i2c pandora_nub =
bq27xxx_battery omapdrm drm_kms_helper syscopyarea sysfillrect sysimgblt =
fb_sys_fops cfg80211 drm drm_panel_orientation_quirks cec ip_tables =
x_tables ipv6 autofs4
[   30.900390] CPU: 0 PID: 2143 Comm: depmod Not tainted =
5.18.0-rc4-letux+ #9499
[   30.907867] Hardware name: Generic OMAP3 (Flattened Device Tree)
[   30.914184] PC is at omap3_l3_app_irq+0x3c/0x120
[   30.919067] LR is at __handle_irq_event_percpu+0xb0/0x1dc
[   30.924743] pc : [<c04e6e9c>]    lr : [<c017d654>]    psr: 200f0193
[   30.931304] sp : e0001eb8  ip : c0c7d850  fp : c0def3e0
[   30.936828] r10: c0d04014  r9 : c1032200  r8 : c0c77370
[   30.942291] r7 : 00000000  r6 : 0000001a  r5 : 00000000  r4 : =
f8000000
[   30.949157] r3 : 00000000  r2 : 00400000  r1 : 00400000  r0 : =
00400000
[   30.956024] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  =
Segment none
[   30.963623] Control: 10c5387d  Table: 83618019  DAC: 00000051
[   30.969665] Register r0 information: non-paged memory
[   30.974975] Register r1 information: non-paged memory
[   30.980285] Register r2 information: non-paged memory
[   30.985626] Register r3 information: NULL pointer
[   30.990570] Register r4 information: 0-page vmalloc region starting =
at 0xf8000000 allocated at iotable_init+0x0/0xf4
[   31.001647] Register r5 information: NULL pointer
[   31.006591] Register r6 information: non-paged memory
[   31.011901] Register r7 information: NULL pointer
[   31.016845] Register r8 information: non-slab/vmalloc memory
[   31.022827] Register r9 information: slab kmalloc-256 start c1032200 =
pointer offset 0 size 256
[   31.031921] Register r10 information: non-slab/vmalloc memory
[   31.037994] Register r11 information: non-slab/vmalloc memory
[   31.044036] Register r12 information: non-slab/vmalloc memory
[   31.050079] Process depmod (pid: 2143, stack limit =3D 0x2035257a)
[   31.056396] Stack: (0xe0001eb8 to 0xe0002000)
[   31.060974] 1ea0:                                                     =
  0000001a c1119940
[   31.069580] 1ec0: 00000000 c11198c0 c103226c 0000001a 00000000 =
c017d654 c1032200 c37c0a40
[   31.078155] 1ee0: 00000000 c1032200 c103226c c1032218 e0001f84 =
c0c77370 c37c0a40 c0def3c0
[   31.086761] 1f00: c0d02080 c017d78c c1032200 c103226c c1032218 =
c017d7f0 c1032200 c103226c
[   31.095336] 1f20: c1032218 c0181ee0 e0001f50 00000000 ffffffff =
c017cf6c e0001f50 c08b4d7c
[   31.103942] 1f40: c01013c4 600f0113 ffffffff c0100bec c37c0a40 =
c0c7e6c0 00000000 1ed15000
[   31.112548] 1f60: c0c7e6c0 c0c7e6c0 00000040 c0d02d00 c0c77370 =
c37c0a40 c0def3c0 c0d02080
[   31.121154] 1f80: c0c7d850 e0001fa0 c0101390 c01013c4 600f0113 =
ffffffff 00000051 c0101390
[   31.129730] 1fa0: e01b9e94 c37c0a40 c37c0a40 00400000 0000000a =
ffff96d9 c1037850 c0c7e6c0
[   31.138336] 1fc0: c0d02d00 c0c7e6c0 c37c0a40 c37c0a40 600f0113 =
ffffffff e01b9e94 c37c0a40
[   31.146911] 1fe0: c37c0a40 e01b9f60 e01b9e58 c0137314 c0158434 =
c013740c c0158434 c04c9c6c
[   31.155517]  omap3_l3_app_irq from =
__handle_irq_event_percpu+0xb0/0x1dc
[   31.162475]  __handle_irq_event_percpu from =
handle_irq_event_percpu+0xc/0x38
[   31.169891]  handle_irq_event_percpu from handle_irq_event+0x38/0x5c
[   31.176605]  handle_irq_event from handle_level_irq+0x7c/0xb4
[   31.182647]  handle_level_irq from handle_irq_desc+0x1c/0x2c
[   31.188629]  handle_irq_desc from generic_handle_arch_irq+0x28/0x3c
[   31.195220]  generic_handle_arch_irq from __irq_svc+0x8c/0xcc
[   31.201263] Exception stack(0xe0001f50 to 0xe0001f98)
[   31.206604] 1f40:                                     c37c0a40 =
c0c7e6c0 00000000 1ed15000
[   31.215179] 1f60: c0c7e6c0 c0c7e6c0 00000040 c0d02d00 c0c77370 =
c37c0a40 c0def3c0 c0d02080
[   31.223785] 1f80: c0c7d850 e0001fa0 c0101390 c01013c4 600f0113 =
ffffffff
[   31.230743]  __irq_svc from __do_softirq+0x84/0x304
[   31.235870]  __do_softirq from __irq_exit_rcu+0x8c/0xd4
[   31.241363]  __irq_exit_rcu from irq_exit+0x8/0x10
[   31.246429]  irq_exit from call_with_stack+0x18/0x20
[   31.251647]  call_with_stack from __irq_svc+0x98/0xcc
[   31.256988] Exception stack(0xe01b9e60 to 0xe01b9ea8)
[   31.262298] 9e60: df993a40 c37c0a40 00000000 00000001 df993a40 =
c3245000 c133c2c0 00000002
[   31.270904] 9e80: c37c0a40 00000000 e01b9f60 e01b9edc e01b9ee0 =
e01b9eb0 c08ba55c c0158434
[   31.279479] 9ea0: 600f0113 ffffffff
[   31.283172]  __irq_svc from finish_task_switch+0x12c/0x1ec
[   31.288940]  finish_task_switch from __schedule+0x3cc/0x558
[   31.294799]  __schedule from schedule+0x70/0xc0
[   31.299591]  schedule from do_work_pending+0x30/0x3dc
[   31.304901]  do_work_pending from slow_work_pending+0xc/0x20
[   31.310852] Exception stack(0xe01b9fb0 to 0xe01b9ff8)
[   31.316192] 9fa0:                                     00002cf8 =
00000000 50000000 b6f99000
[   31.324768] 9fc0: b6f9bcfc b6f9bcf8 00000000 00000000 00000010 =
00000000 00001e94 00000000
[   31.333374] 9fe0: b6f9bcf8 bea66f80 b6f9bcfc 004bfc6a 40070030 =
ffffffff
[   31.340332] Code: e0000002 e0011003 e1901001 0a000002 (e7f001f2)=20
[   31.346740] ---[ end trace 0000000000000000 ]---
[   31.351593] Kernel panic - not syncing: Fatal exception in interrupt
[   31.358276] ---[ end Kernel panic - not syncing: Fatal exception in =
interrupt ]---

>=20
>       Arnd

rm -rf =
lib/modules/5.18.0-rc4-letux+/kernel/drivers/net/wireless/ti/wl1251

done on the SD card makes the problems go away.

BR and thanks,
Nikolaus


diff --git a/drivers/net/wireless/ti/wl1251/io.c =
b/drivers/net/wireless/ti/wl1251/io.c
index 5ebe7958ed5c7..76aceecc281fb 100644
--- a/drivers/net/wireless/ti/wl1251/io.c
+++ b/drivers/net/wireless/ti/wl1251/io.c
@@ -121,7 +121,13 @@ void wl1251_set_partition(struct wl1251 *wl,
                          u32 mem_start, u32 mem_size,
                          u32 reg_start, u32 reg_size)
 {
-       struct wl1251_partition partition[2];
+       struct wl1251_partition_set *partition;
+
+       partition =3D kmalloc(sizeof(*partition), GFP_KERNEL);
+       if (!partition) {
+               wl1251_error("can not set partition");
+               return;
+       }
=20
        wl1251_debug(DEBUG_SPI, "mem_start %08X mem_size %08X",
                     mem_start, mem_size);
@@ -164,10 +170,10 @@ void wl1251_set_partition(struct wl1251 *wl,
                             reg_start, reg_size);
        }
=20
-       partition[0].start =3D mem_start;
-       partition[0].size  =3D mem_size;
-       partition[1].start =3D reg_start;
-       partition[1].size  =3D reg_size;
+       partition->mem.start =3D mem_start;
+       partition->mem.size  =3D mem_size;
+       partition->reg.start =3D reg_start;
+       partition->reg.size  =3D reg_size;
=20
        wl->physical_mem_addr =3D mem_start;
        wl->physical_reg_addr =3D reg_start;
@@ -176,5 +182,7 @@ void wl1251_set_partition(struct wl1251 *wl,
        wl->virtual_reg_addr =3D mem_size;
=20
        wl->if_ops->write(wl, HW_ACCESS_PART0_SIZE_ADDR, partition,
-               sizeof(partition));
+               sizeof(*partition));
+
+       kfree(partition);
 }


