Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29F750D682
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbiDYBYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiDYBYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:24:03 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E2081672;
        Sun, 24 Apr 2022 18:20:56 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ninP6-0006Zw-QT; Mon, 25 Apr 2022 03:20:41 +0200
Date:   Mon, 25 Apr 2022 02:20:34 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Regression? [PATCH 1/2] mtd: call of_platform_populate() for MTD
 partitions
Message-ID: <YmX3Yn9cS1YjWOjs@makrotopia.org>
References: <20220406143225.28107-1-zajec5@gmail.com>
 <20220411090032.10999-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411090032.10999-1-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafal,
Hi Miguel,


On Mon, Apr 11, 2022 at 11:00:32AM +0200, Miquel Raynal wrote:
> On Wed, 2022-04-06 at 14:32:24 UTC, =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= wrote:
> > From: Rafał Miłecki <rafal@milecki.pl>
> > 
> > Until this change MTD subsystem supported handling partitions only with
> > MTD partitions parsers. That's a specific / limited API designed around
> > partitions.
> > 
> > Some MTD partitions may however require different handling. They may
> > contain specific data that needs to be parsed and somehow extracted. For
> > that purpose MTD subsystem should allow binding of standard platform
> > drivers.
> > 
> > An example can be U-Boot (sub)partition with environment variables.
> > There exist a "u-boot,env" DT binding for MTD (sub)partition that
> > requires an NVMEM driver.
> > 
> > Ref: 5db1c2dbc04c ("dt-bindings: nvmem: add U-Boot environment variables binding")
> > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

I'm trying to use next-20220422 and noticed a few new oops'es.
Turns out it could be a problem with this commit according to

[daniel@box linux.git]$ git bisect good
68471517e883902cdff6ea399d043b17f803b1a8 is the first bad commit
commit 68471517e883902cdff6ea399d043b17f803b1a8
Author: Rafał Miłecki <rafal@milecki.pl>
Date:   Wed Apr 6 16:32:24 2022 +0200

    mtd: call of_platform_populate() for MTD partitions
[...]
---

So when ever there is at least one 'compatible' node for any of the
mtd partitions I get the oops messages below. It doesn't really matter
what the compatible string is, "nvmem-cells" as well as "denx,fit"
(used for OpenWrt mtdsplit not even present in linux-next, so just a
dead hint in DTS) make the kernel to oops.

Despite the messages being shown, both accessing MTD partitions and
also eth0 MAC address populated via NVMEM seem to work without
problems (at least looks like it on first sight).

Find the full device tree here:

https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/dts/mt7622-ubnt-unifi-6-lr-ubootmod.dts

---
[...]
[    0.549448] mtk-spi-nor 11014000.spi: IRQ not available.
[    0.556396] spi-nor spi0.0: w25q512jvq (65536 Kbytes)
[    0.933381] Freeing initrd memory: 2124K
[    0.941567] 7 fixed-partitions partitions found on MTD device spi0.0
[    0.947966] OF: Bad cell count for /spi@11014000/flash@0/partitions
[    0.954286] OF: Bad cell count for /spi@11014000/flash@0/partitions
[    0.960583] ------------[ cut here ]------------
[    0.965192] kobject: '(null)' (0000000097a89bbf): is not initialized, yet kobject_get() is being called.
[    0.974688] WARNING: CPU: 0 PID: 1 at kobject_get+0x68/0x94
[    0.980263] Modules linked in:
[    0.983313] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S                5.18.0-rc1+ #0
[    0.991049] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
[    0.997046] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.004000] pc : kobject_get+0x68/0x94
[    1.007743] lr : kobject_get+0x68/0x94
[    1.011484] sp : ffffffc008bdb4a0
[    1.014789] x29: ffffffc008bdb4a0 x28: 0000000000000000 x27: ffffff8005c57810
[    1.021920] x26: ffffff8005c74a20 x25: 0000000000000000 x24: 0000000000000001
[    1.029050] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
[    1.036182] x20: ffffff8005c74a20 x19: ffffff8005c74a20 x18: ffffffc008ab9630
[    1.043312] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 0000000000000074
[    1.050443] x14: 000000000000015c x13: 0000000000000074 x12: 00000000ffffffea
[    1.057574] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc008b11630
[    1.064705] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[    1.071835] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc008bdb1c0
[    1.078966] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 000000000000005c
[    1.086097] Call trace:
[    1.088534]  kobject_get+0x68/0x94
[    1.091930]  device_add+0xa4/0x840
[    1.095328]  of_device_add+0x4c/0x5c
[    1.098898]  of_platform_device_create_pdata+0xb8/0xf0
[    1.104029]  of_platform_bus_create+0x104/0x350
[    1.108552]  of_platform_populate+0x54/0xe0
[    1.112728]  parse_mtd_partitions+0x430/0x490
[    1.117080]  mtd_device_parse_register+0x90/0x2b0
[    1.121777]  spi_nor_probe+0x1f8/0x2b0
[    1.125521]  spi_mem_probe+0x68/0xa0
[    1.129092]  spi_probe+0x80/0xdc
[    1.132314]  really_probe.part.0+0x98/0x280
[    1.136490]  __driver_probe_device+0x94/0x140
[    1.140839]  driver_probe_device+0x40/0x114
[    1.145014]  __device_attach_driver+0xb0/0x10c
[    1.149450]  bus_for_each_drv+0x64/0xa0
[    1.153280]  __device_attach+0xa8/0x16c
[    1.157108]  device_initial_probe+0x10/0x20
[    1.161283]  bus_probe_device+0x94/0x9c
[    1.165114]  device_add+0x35c/0x840
[    1.168596]  __spi_add_device+0x70/0x114
[    1.172510]  spi_add_device+0x5c/0x90
[    1.176165]  of_register_spi_device+0x204/0x330
[    1.180688]  spi_register_controller+0x3e8/0x6dc
[    1.185299]  devm_spi_register_controller+0x20/0x74
[    1.190169]  mtk_nor_probe+0x344/0x4c0
[    1.193911]  platform_probe+0x64/0xd0
[    1.197566]  really_probe.part.0+0x98/0x280
[    1.201741]  __driver_probe_device+0x94/0x140
[    1.206089]  driver_probe_device+0x40/0x114
[    1.210264]  __driver_attach+0xf0/0x180
[    1.214092]  bus_for_each_dev+0x5c/0x90
[    1.217922]  driver_attach+0x20/0x2c
[    1.221491]  bus_add_driver+0x140/0x1ec
[    1.225320]  driver_register+0x74/0x120
[    1.229149]  __platform_driver_register+0x24/0x30
[    1.233845]  mtk_nor_driver_init+0x18/0x20
[    1.237938]  do_one_initcall+0x4c/0x1c0
[    1.241768]  kernel_init_freeable+0x230/0x294
[    1.246120]  kernel_init+0x20/0x120
[    1.249601]  ret_from_fork+0x10/0x20
[    1.253170] ---[ end trace 0000000000000000 ]---
[    1.257796] ------------[ cut here ]------------
[    1.262408] refcount_t: addition on 0; use-after-free.
[    1.267550] WARNING: CPU: 0 PID: 1 at refcount_warn_saturate+0x98/0x140
[    1.274161] Modules linked in:
[    1.277206] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S      W         5.18.0-rc1+ #0
[    1.284941] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
[    1.290937] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.297891] pc : refcount_warn_saturate+0x98/0x140
[    1.302675] lr : refcount_warn_saturate+0x98/0x140
[    1.307459] sp : ffffffc008bdb490
[    1.310764] x29: ffffffc008bdb490 x28: 0000000000000000 x27: ffffff8005c57810
[    1.317895] x26: ffffff8005c74a20 x25: 0000000000000000 x24: 0000000000000001
[    1.325026] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
[    1.332157] x20: ffffff8005c74a20 x19: ffffff8005c74a20 x18: ffffffc008ab9630
[    1.339288] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 00000000000000b3
[    1.346419] x14: 0000000000000219 x13: 00000000000000b3 x12: 00000000ffffffea
[    1.353550] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc008b11630
[    1.360681] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[    1.367811] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc008bdb1b0
[    1.374942] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 000000000000002a
[    1.382073] Call trace:
[    1.384509]  refcount_warn_saturate+0x98/0x140
[    1.388946]  kobject_get+0x90/0x94
[    1.392342]  device_add+0xa4/0x840
[    1.395737]  of_device_add+0x4c/0x5c
[    1.399305]  of_platform_device_create_pdata+0xb8/0xf0
[    1.404436]  of_platform_bus_create+0x104/0x350
[    1.408959]  of_platform_populate+0x54/0xe0
[    1.413134]  parse_mtd_partitions+0x430/0x490
[    1.417484]  mtd_device_parse_register+0x90/0x2b0
[    1.422182]  spi_nor_probe+0x1f8/0x2b0
[    1.425925]  spi_mem_probe+0x68/0xa0
[    1.429493]  spi_probe+0x80/0xdc
[    1.432715]  really_probe.part.0+0x98/0x280
[    1.436890]  __driver_probe_device+0x94/0x140
[    1.441238]  driver_probe_device+0x40/0x114
[    1.445413]  __device_attach_driver+0xb0/0x10c
[    1.449849]  bus_for_each_drv+0x64/0xa0
[    1.453678]  __device_attach+0xa8/0x16c
[    1.457506]  device_initial_probe+0x10/0x20
[    1.461682]  bus_probe_device+0x94/0x9c
[    1.465511]  device_add+0x35c/0x840
[    1.468993]  __spi_add_device+0x70/0x114
[    1.472908]  spi_add_device+0x5c/0x90
[    1.476562]  of_register_spi_device+0x204/0x330
[    1.481085]  spi_register_controller+0x3e8/0x6dc
[    1.485695]  devm_spi_register_controller+0x20/0x74
[    1.490565]  mtk_nor_probe+0x344/0x4c0
[    1.494307]  platform_probe+0x64/0xd0
[    1.497962]  really_probe.part.0+0x98/0x280
[    1.502136]  __driver_probe_device+0x94/0x140
[    1.506485]  driver_probe_device+0x40/0x114
[    1.510660]  __driver_attach+0xf0/0x180
[    1.514488]  bus_for_each_dev+0x5c/0x90
[    1.518317]  driver_attach+0x20/0x2c
[    1.521887]  bus_add_driver+0x140/0x1ec
[    1.525716]  driver_register+0x74/0x120
[    1.529543]  __platform_driver_register+0x24/0x30
[    1.534240]  mtk_nor_driver_init+0x18/0x20
[    1.538330]  do_one_initcall+0x4c/0x1c0
[    1.542158]  kernel_init_freeable+0x230/0x294
[    1.546508]  kernel_init+0x20/0x120
[    1.549990]  ret_from_fork+0x10/0x20
[    1.553558] ---[ end trace 0000000000000000 ]---
[    1.558176] ------------[ cut here ]------------
[    1.562786] kobject: '(null)' (0000000097a89bbf): is not initialized, yet kobject_get() is being called.
[    1.572272] WARNING: CPU: 0 PID: 1 at kobject_get+0x68/0x94
[    1.577839] Modules linked in:
[    1.580885] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S      W         5.18.0-rc1+ #0
[    1.588620] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
[    1.594616] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.601570] pc : kobject_get+0x68/0x94
[    1.605312] lr : kobject_get+0x68/0x94
[    1.609054] sp : ffffffc008bdb3a0
[    1.612359] x29: ffffffc008bdb3a0 x28: 0000000000000000 x27: ffffff8005c57810
[    1.619490] x26: ffffff8005c74a20 x25: 0000000000000000 x24: 0000000000000001
[    1.626620] x23: 0000000000000000 x22: 0000000000000000 x21: ffffff8005c74a20
[    1.633751] x20: ffffff8005c57810 x19: ffffff8005c74a20 x18: ffffffc008ab9630
[    1.640882] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 00000000000000f3
[    1.648013] x14: 00000000000002d9 x13: 00000000000000f3 x12: 00000000ffffffea
[    1.655144] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc008b11630
[    1.662275] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[    1.669405] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc008bdb0c0
[    1.676536] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 000000000000005c
[    1.683666] Call trace:
[    1.686102]  kobject_get+0x68/0x94
[    1.689498]  kobject_add_internal+0x34/0x330
[    1.693762]  kobject_add+0x80/0xe0
[    1.697158]  device_add+0xd8/0x840
[    1.700553]  of_device_add+0x4c/0x5c
[    1.704121]  of_platform_device_create_pdata+0xb8/0xf0
[    1.709252]  of_platform_bus_create+0x104/0x350
[    1.713774]  of_platform_populate+0x54/0xe0
[    1.717949]  parse_mtd_partitions+0x430/0x490
[    1.722299]  mtd_device_parse_register+0x90/0x2b0
[    1.726996]  spi_nor_probe+0x1f8/0x2b0
[    1.730739]  spi_mem_probe+0x68/0xa0
[    1.734307]  spi_probe+0x80/0xdc
[    1.737529]  really_probe.part.0+0x98/0x280
[    1.741704]  __driver_probe_device+0x94/0x140
[    1.746053]  driver_probe_device+0x40/0x114
[    1.750228]  __device_attach_driver+0xb0/0x10c
[    1.754664]  bus_for_each_drv+0x64/0xa0
[    1.758493]  __device_attach+0xa8/0x16c
[    1.762320]  device_initial_probe+0x10/0x20
[    1.766496]  bus_probe_device+0x94/0x9c
[    1.770326]  device_add+0x35c/0x840
[    1.773808]  __spi_add_device+0x70/0x114
[    1.777723]  spi_add_device+0x5c/0x90
[    1.781378]  of_register_spi_device+0x204/0x330
[    1.785901]  spi_register_controller+0x3e8/0x6dc
[    1.790511]  devm_spi_register_controller+0x20/0x74
[    1.795381]  mtk_nor_probe+0x344/0x4c0
[    1.799123]  platform_probe+0x64/0xd0
[    1.802777]  really_probe.part.0+0x98/0x280
[    1.806952]  __driver_probe_device+0x94/0x140
[    1.811300]  driver_probe_device+0x40/0x114
[    1.815474]  __driver_attach+0xf0/0x180
[    1.819302]  bus_for_each_dev+0x5c/0x90
[    1.823132]  driver_attach+0x20/0x2c
[    1.826701]  bus_add_driver+0x140/0x1ec
[    1.830530]  driver_register+0x74/0x120
[    1.834359]  __platform_driver_register+0x24/0x30
[    1.839056]  mtk_nor_driver_init+0x18/0x20
[    1.843146]  do_one_initcall+0x4c/0x1c0
[    1.846975]  kernel_init_freeable+0x230/0x294
[    1.851325]  kernel_init+0x20/0x120
[    1.854806]  ret_from_fork+0x10/0x20
[    1.858374] ---[ end trace 0000000000000000 ]---
[    1.862989] ------------[ cut here ]------------
[    1.867596] refcount_t: saturated; leaking memory.
[    1.872392] WARNING: CPU: 0 PID: 1 at refcount_warn_saturate+0x6c/0x140
[    1.879001] Modules linked in:
[    1.882046] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S      W         5.18.0-rc1+ #0
[    1.889781] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
[    1.895776] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.902729] pc : refcount_warn_saturate+0x6c/0x140
[    1.907513] lr : refcount_warn_saturate+0x6c/0x140
[    1.912296] sp : ffffffc008bdb390
[    1.915601] x29: ffffffc008bdb390 x28: 0000000000000000 x27: ffffff8005c57810
[    1.922732] x26: ffffff8005c74a20 x25: 0000000000000000 x24: 0000000000000001
[    1.929864] x23: 0000000000000000 x22: 0000000000000000 x21: ffffff8005c74a20
[    1.936995] x20: ffffff8005c57810 x19: ffffff8005c74a20 x18: ffffffc008ab9630
[    1.944127] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 0000000000000134
[    1.951258] x14: 000000000000039c x13: 0000000000000134 x12: 00000000ffffffea
[    1.958389] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc008b11630
[    1.965520] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[    1.972650] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc008bdb0b0
[    1.979780] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 0000000000000026
[    1.986911] Call trace:
[    1.989348]  refcount_warn_saturate+0x6c/0x140
[    1.993786]  kobject_get+0x78/0x94
[    1.997181]  kobject_add_internal+0x34/0x330
[    2.001444]  kobject_add+0x80/0xe0
[    2.004840]  device_add+0xd8/0x840
[    2.008235]  of_device_add+0x4c/0x5c
[    2.011802]  of_platform_device_create_pdata+0xb8/0xf0
[    2.016933]  of_platform_bus_create+0x104/0x350
[    2.021456]  of_platform_populate+0x54/0xe0
[    2.025631]  parse_mtd_partitions+0x430/0x490
[    2.029982]  mtd_device_parse_register+0x90/0x2b0
[    2.034679]  spi_nor_probe+0x1f8/0x2b0
[    2.038421]  spi_mem_probe+0x68/0xa0
[    2.041989]  spi_probe+0x80/0xdc
[    2.045211]  really_probe.part.0+0x98/0x280
[    2.049385]  __driver_probe_device+0x94/0x140
[    2.053734]  driver_probe_device+0x40/0x114
[    2.057908]  __device_attach_driver+0xb0/0x10c
[    2.062344]  bus_for_each_drv+0x64/0xa0
[    2.066174]  __device_attach+0xa8/0x16c
[    2.070002]  device_initial_probe+0x10/0x20
[    2.074177]  bus_probe_device+0x94/0x9c
[    2.078007]  device_add+0x35c/0x840
[    2.081489]  __spi_add_device+0x70/0x114
[    2.085404]  spi_add_device+0x5c/0x90
[    2.089058]  of_register_spi_device+0x204/0x330
[    2.093581]  spi_register_controller+0x3e8/0x6dc
[    2.098191]  devm_spi_register_controller+0x20/0x74
[    2.103062]  mtk_nor_probe+0x344/0x4c0
[    2.106803]  platform_probe+0x64/0xd0
[    2.110458]  really_probe.part.0+0x98/0x280
[    2.114633]  __driver_probe_device+0x94/0x140
[    2.118981]  driver_probe_device+0x40/0x114
[    2.123156]  __driver_attach+0xf0/0x180
[    2.126984]  bus_for_each_dev+0x5c/0x90
[    2.130812]  driver_attach+0x20/0x2c
[    2.134382]  bus_add_driver+0x140/0x1ec
[    2.138212]  driver_register+0x74/0x120
[    2.142039]  __platform_driver_register+0x24/0x30
[    2.146736]  mtk_nor_driver_init+0x18/0x20
[    2.150826]  do_one_initcall+0x4c/0x1c0
[    2.154654]  kernel_init_freeable+0x230/0x294
[    2.159004]  kernel_init+0x20/0x120
[    2.162485]  ret_from_fork+0x10/0x20
[    2.166052] ---[ end trace 0000000000000000 ]---
[    2.170675] ------------[ cut here ]------------
[    2.175282] kobject: '(null)' (0000000097a89bbf): is not initialized, yet kobject_put() is being called.
[    2.184768] WARNING: CPU: 0 PID: 1 at kobject_put+0x68/0xf0
[    2.190335] Modules linked in:
[    2.193381] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S      W         5.18.0-rc1+ #0
[    2.201115] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
[    2.207111] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.214065] pc : kobject_put+0x68/0xf0
[    2.217808] lr : kobject_put+0x68/0xf0
[    2.221550] sp : ffffffc008bdb390
[    2.224855] x29: ffffffc008bdb390 x28: 0000000000000000 x27: ffffff8005c57810
[    2.231986] x26: ffffff8005c74a20 x25: 0000000000000000 x24: ffffffc008b55368
[    2.239117] x23: 0000000000000000 x22: 00000000fffffffe x21: ffffff8005c74a20
[    2.246248] x20: ffffff8005c57810 x19: ffffff8005c74a20 x18: ffffffc008ab9630
[    2.253379] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 0000000000000176
[    2.260510] x14: 0000000000000462 x13: 0000000000000176 x12: 00000000ffffffea
[    2.267640] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc008b11630
[    2.274771] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[    2.281902] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc008bdb0b0
[    2.289032] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 000000000000005c
[    2.296163] Call trace:
[    2.298599]  kobject_put+0x68/0xf0
[    2.301995]  kobject_add_internal+0x130/0x330
[    2.306345]  kobject_add+0x80/0xe0
[    2.309740]  device_add+0xd8/0x840
[    2.313135]  of_device_add+0x4c/0x5c
[    2.316702]  of_platform_device_create_pdata+0xb8/0xf0
[    2.321833]  of_platform_bus_create+0x104/0x350
[    2.326356]  of_platform_populate+0x54/0xe0
[    2.330531]  parse_mtd_partitions+0x430/0x490
[    2.334881]  mtd_device_parse_register+0x90/0x2b0
[    2.339578]  spi_nor_probe+0x1f8/0x2b0
[    2.343321]  spi_mem_probe+0x68/0xa0
[    2.346888]  spi_probe+0x80/0xdc
[    2.350110]  really_probe.part.0+0x98/0x280
[    2.354285]  __driver_probe_device+0x94/0x140
[    2.358634]  driver_probe_device+0x40/0x114
[    2.362809]  __device_attach_driver+0xb0/0x10c
[    2.367245]  bus_for_each_drv+0x64/0xa0
[    2.371073]  __device_attach+0xa8/0x16c
[    2.374900]  device_initial_probe+0x10/0x20
[    2.379075]  bus_probe_device+0x94/0x9c
[    2.382906]  device_add+0x35c/0x840
[    2.386388]  __spi_add_device+0x70/0x114
[    2.390303]  spi_add_device+0x5c/0x90
[    2.393958]  of_register_spi_device+0x204/0x330
[    2.398480]  spi_register_controller+0x3e8/0x6dc
[    2.403090]  devm_spi_register_controller+0x20/0x74
[    2.407961]  mtk_nor_probe+0x344/0x4c0
[    2.411702]  platform_probe+0x64/0xd0
[    2.415357]  really_probe.part.0+0x98/0x280
[    2.419532]  __driver_probe_device+0x94/0x140
[    2.423881]  driver_probe_device+0x40/0x114
[    2.428056]  __driver_attach+0xf0/0x180
[    2.431884]  bus_for_each_dev+0x5c/0x90
[    2.435714]  driver_attach+0x20/0x2c
[    2.439283]  bus_add_driver+0x140/0x1ec
[    2.443113]  driver_register+0x74/0x120
[    2.446941]  __platform_driver_register+0x24/0x30
[    2.451638]  mtk_nor_driver_init+0x18/0x20
[    2.455728]  do_one_initcall+0x4c/0x1c0
[    2.459556]  kernel_init_freeable+0x230/0x294
[    2.463906]  kernel_init+0x20/0x120
[    2.467386]  ret_from_fork+0x10/0x20
[    2.470955] ---[ end trace 0000000000000000 ]---
[    2.475571] ------------[ cut here ]------------
[    2.480182] refcount_t: underflow; use-after-free.
[    2.484974] WARNING: CPU: 0 PID: 1 at refcount_warn_saturate+0xec/0x140
[    2.491583] Modules linked in:
[    2.494628] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S      W         5.18.0-rc1+ #0
[    2.502363] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
[    2.508358] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.515312] pc : refcount_warn_saturate+0xec/0x140
[    2.520097] lr : refcount_warn_saturate+0xec/0x140
[    2.524881] sp : ffffffc008bdb380
[    2.528186] x29: ffffffc008bdb380 x28: 0000000000000000 x27: ffffff8005c57810
[    2.535317] x26: ffffff8005c74a20 x25: 0000000000000000 x24: ffffffc008b55368
[    2.542448] x23: 0000000000000000 x22: 00000000fffffffe x21: ffffff8005c74a20
[    2.549580] x20: ffffff8005c57810 x19: ffffff8005c74a20 x18: ffffffc008ab9630
[    2.556710] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 00000000000001b7
[    2.563841] x14: 0000000000000525 x13: 00000000000001b7 x12: 00000000ffffffea
[    2.570971] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc008b11630
[    2.578103] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[    2.585234] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc008bdb0a0
[    2.592364] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 0000000000000026
[    2.599494] Call trace:
[    2.601931]  refcount_warn_saturate+0xec/0x140
[    2.606367]  kobject_put+0xe4/0xf0
[    2.609763]  kobject_add_internal+0x130/0x330
[    2.614113]  kobject_add+0x80/0xe0
[    2.617509]  device_add+0xd8/0x840
[    2.620904]  of_device_add+0x4c/0x5c
[    2.624472]  of_platform_device_create_pdata+0xb8/0xf0
[    2.629602]  of_platform_bus_create+0x104/0x350
[    2.634125]  of_platform_populate+0x54/0xe0
[    2.638300]  parse_mtd_partitions+0x430/0x490
[    2.642651]  mtd_device_parse_register+0x90/0x2b0
[    2.647348]  spi_nor_probe+0x1f8/0x2b0
[    2.651091]  spi_mem_probe+0x68/0xa0
[    2.654659]  spi_probe+0x80/0xdc
[    2.657881]  really_probe.part.0+0x98/0x280
[    2.662056]  __driver_probe_device+0x94/0x140
[    2.666404]  driver_probe_device+0x40/0x114
[    2.670579]  __device_attach_driver+0xb0/0x10c
[    2.675015]  bus_for_each_drv+0x64/0xa0
[    2.678844]  __device_attach+0xa8/0x16c
[    2.682672]  device_initial_probe+0x10/0x20
[    2.686847]  bus_probe_device+0x94/0x9c
[    2.690677]  device_add+0x35c/0x840
[    2.694158]  __spi_add_device+0x70/0x114
[    2.698074]  spi_add_device+0x5c/0x90
[    2.701729]  of_register_spi_device+0x204/0x330
[    2.706252]  spi_register_controller+0x3e8/0x6dc
[    2.710861]  devm_spi_register_controller+0x20/0x74
[    2.715731]  mtk_nor_probe+0x344/0x4c0
[    2.719473]  platform_probe+0x64/0xd0
[    2.723128]  really_probe.part.0+0x98/0x280
[    2.727302]  __driver_probe_device+0x94/0x140
[    2.731650]  driver_probe_device+0x40/0x114
[    2.735825]  __driver_attach+0xf0/0x180
[    2.739653]  bus_for_each_dev+0x5c/0x90
[    2.743483]  driver_attach+0x20/0x2c
[    2.747052]  bus_add_driver+0x140/0x1ec
[    2.750881]  driver_register+0x74/0x120
[    2.754709]  __platform_driver_register+0x24/0x30
[    2.759406]  mtk_nor_driver_init+0x18/0x20
[    2.763496]  do_one_initcall+0x4c/0x1c0
[    2.767324]  kernel_init_freeable+0x230/0x294
[    2.771674]  kernel_init+0x20/0x120
[    2.775155]  ret_from_fork+0x10/0x20
[    2.778723] ---[ end trace 0000000000000000 ]---
[    2.783338] kobject_add_internal failed for 11014000.spi:flash@0:partitions:partition@110000 (error: -2 parent: (null))
[    2.794116] ------------[ cut here ]------------
[    2.798723] kobject: '(null)' (0000000097a89bbf): is not initialized, yet kobject_put() is being called.
[    2.808207] WARNING: CPU: 0 PID: 1 at kobject_put+0x68/0xf0
[    2.813776] Modules linked in:
[    2.816821] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S      W         5.18.0-rc1+ #0
[    2.824556] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
[    2.830552] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.837506] pc : kobject_put+0x68/0xf0
[    2.841248] lr : kobject_put+0x68/0xf0
[    2.844990] sp : ffffffc008bdb490
[    2.848295] x29: ffffffc008bdb490 x28: 0000000000000000 x27: ffffff8005c57810
[    2.855426] x26: ffffff8005c74a20 x25: 0000000000000000 x24: 0000000000000001
[    2.862557] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
[    2.869688] x20: ffffff8005c74a20 x19: ffffff8005c74a20 x18: ffffffc008ab9630
[    2.876819] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 00000000000001fa
[    2.883949] x14: 00000000000005ee x13: 00000000000001fa x12: 00000000ffffffea
[    2.891081] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc008b11630
[    2.898212] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[    2.905343] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc008bdb1b0
[    2.912473] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 000000000000005c
[    2.919604] Call trace:
[    2.922040]  kobject_put+0x68/0xf0
[    2.925436]  device_add+0xfc/0x840
[    2.928832]  of_device_add+0x4c/0x5c
[    2.932400]  of_platform_device_create_pdata+0xb8/0xf0
[    2.937530]  of_platform_bus_create+0x104/0x350
[    2.942053]  of_platform_populate+0x54/0xe0
[    2.946228]  parse_mtd_partitions+0x430/0x490
[    2.950579]  mtd_device_parse_register+0x90/0x2b0
[    2.955276]  spi_nor_probe+0x1f8/0x2b0
[    2.959018]  spi_mem_probe+0x68/0xa0
[    2.962586]  spi_probe+0x80/0xdc
[    2.965808]  really_probe.part.0+0x98/0x280
[    2.969983]  __driver_probe_device+0x94/0x140
[    2.974332]  driver_probe_device+0x40/0x114
[    2.978507]  __device_attach_driver+0xb0/0x10c
[    2.982943]  bus_for_each_drv+0x64/0xa0
[    2.986772]  __device_attach+0xa8/0x16c
[    2.990599]  device_initial_probe+0x10/0x20
[    2.994775]  bus_probe_device+0x94/0x9c
[    2.998605]  device_add+0x35c/0x840
[    3.002087]  __spi_add_device+0x70/0x114
[    3.006002]  spi_add_device+0x5c/0x90
[    3.009656]  of_register_spi_device+0x204/0x330
[    3.014178]  spi_register_controller+0x3e8/0x6dc
[    3.018788]  devm_spi_register_controller+0x20/0x74
[    3.023658]  mtk_nor_probe+0x344/0x4c0
[    3.027400]  platform_probe+0x64/0xd0
[    3.031054]  really_probe.part.0+0x98/0x280
[    3.035230]  __driver_probe_device+0x94/0x140
[    3.039578]  driver_probe_device+0x40/0x114
[    3.043753]  __driver_attach+0xf0/0x180
[    3.047581]  bus_for_each_dev+0x5c/0x90
[    3.051410]  driver_attach+0x20/0x2c
[    3.054980]  bus_add_driver+0x140/0x1ec
[    3.058810]  driver_register+0x74/0x120
[    3.062638]  __platform_driver_register+0x24/0x30
[    3.067335]  mtk_nor_driver_init+0x18/0x20
[    3.071425]  do_one_initcall+0x4c/0x1c0
[    3.075253]  kernel_init_freeable+0x230/0x294
[    3.079604]  kernel_init+0x20/0x120
[    3.083084]  ret_from_fork+0x10/0x20
[    3.086653] ---[ end trace 0000000000000000 ]---
[    3.091298] OF: Bad cell count for /spi@11014000/flash@0/partitions
[    3.097577] OF: Bad cell count for /spi@11014000/flash@0/partitions
[    3.103862] ------------[ cut here ]------------
[    3.108468] kobject: '(null)' (0000000097a89bbf): is not initialized, yet kobject_get() is being called.
[    3.117953] WARNING: CPU: 0 PID: 1 at kobject_get+0x68/0x94
[    3.123521] Modules linked in:
[    3.126566] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S      W         5.18.0-rc1+ #0
[    3.134302] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
[    3.140297] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.147251] pc : kobject_get+0x68/0x94
[    3.150994] lr : kobject_get+0x68/0x94
[    3.154736] sp : ffffffc008bdb4a0
[    3.158041] x29: ffffffc008bdb4a0 x28: 0000000000000000 x27: ffffff8005c57810
[    3.165173] x26: ffffff8005c74a20 x25: 0000000000000000 x24: 0000000000000001
[    3.172304] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
[    3.179434] x20: ffffff8005c74a20 x19: ffffff8005c74a20 x18: ffffffc008ab9630
[    3.186565] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 000000000000023b
[    3.193696] x14: 00000000000006b1 x13: 000000000000023b x12: 00000000ffffffea
[    3.200826] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc008b11630
[    3.207957] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[    3.215088] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc008bdb1c0
[    3.222218] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 000000000000005c
[    3.229350] Call trace:
[    3.231786]  kobject_get+0x68/0x94
[    3.235182]  device_add+0xa4/0x840
[    3.238578]  of_device_add+0x4c/0x5c
[    3.242145]  of_platform_device_create_pdata+0xb8/0xf0
[    3.247275]  of_platform_bus_create+0x104/0x350
[    3.251798]  of_platform_populate+0x54/0xe0
[    3.255973]  parse_mtd_partitions+0x430/0x490
[    3.260324]  mtd_device_parse_register+0x90/0x2b0
[    3.265022]  spi_nor_probe+0x1f8/0x2b0
[    3.268765]  spi_mem_probe+0x68/0xa0
[    3.272333]  spi_probe+0x80/0xdc
[    3.275555]  really_probe.part.0+0x98/0x280
[    3.279730]  __driver_probe_device+0x94/0x140
[    3.284079]  driver_probe_device+0x40/0x114
[    3.288254]  __device_attach_driver+0xb0/0x10c
[    3.292690]  bus_for_each_drv+0x64/0xa0
[    3.296519]  __device_attach+0xa8/0x16c
[    3.300347]  device_initial_probe+0x10/0x20
[    3.304522]  bus_probe_device+0x94/0x9c
[    3.308351]  device_add+0x35c/0x840
[    3.311833]  __spi_add_device+0x70/0x114
[    3.315749]  spi_add_device+0x5c/0x90
[    3.319404]  of_register_spi_device+0x204/0x330
[    3.323927]  spi_register_controller+0x3e8/0x6dc
[    3.328537]  devm_spi_register_controller+0x20/0x74
[    3.333407]  mtk_nor_probe+0x344/0x4c0
[    3.337149]  platform_probe+0x64/0xd0
[    3.340804]  really_probe.part.0+0x98/0x280
[    3.344978]  __driver_probe_device+0x94/0x140
[    3.349327]  driver_probe_device+0x40/0x114
[    3.353502]  __driver_attach+0xf0/0x180
[    3.357329]  bus_for_each_dev+0x5c/0x90
[    3.361159]  driver_attach+0x20/0x2c
[    3.364728]  bus_add_driver+0x140/0x1ec
[    3.368557]  driver_register+0x74/0x120
[    3.372385]  __platform_driver_register+0x24/0x30
[    3.377081]  mtk_nor_driver_init+0x18/0x20
[    3.381172]  do_one_initcall+0x4c/0x1c0
[    3.385001]  kernel_init_freeable+0x230/0x294
[    3.389351]  kernel_init+0x20/0x120
[    3.392831]  ret_from_fork+0x10/0x20
[    3.396399] ---[ end trace 0000000000000000 ]---
[    3.401017] ------------[ cut here ]------------
[    3.405623] kobject: '(null)' (0000000097a89bbf): is not initialized, yet kobject_get() is being called.
[    3.415108] WARNING: CPU: 0 PID: 1 at kobject_get+0x68/0x94
[    3.420676] Modules linked in:
[    3.423722] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S      W         5.18.0-rc1+ #0
[    3.431456] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
[    3.437452] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.444405] pc : kobject_get+0x68/0x94
[    3.448148] lr : kobject_get+0x68/0x94
[    3.451890] sp : ffffffc008bdb3a0
[    3.455194] x29: ffffffc008bdb3a0 x28: 0000000000000000 x27: ffffff8005c57810
[    3.462325] x26: ffffff8005c74a20 x25: 0000000000000000 x24: 0000000000000001
[    3.469456] x23: 0000000000000000 x22: 0000000000000000 x21: ffffff8005c74a20
[    3.476586] x20: ffffff8005c57810 x19: ffffff8005c74a20 x18: ffffffc008ab9630
[    3.483717] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 000000000000027a
[    3.490848] x14: 000000000000076e x13: 000000000000027a x12: 00000000ffffffea
[    3.497979] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc008b11630
[    3.505109] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[    3.512240] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc008bdb0c0
[    3.519372] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 000000000000005c
[    3.526502] Call trace:
[    3.528938]  kobject_get+0x68/0x94
[    3.532334]  kobject_add_internal+0x34/0x330
[    3.536598]  kobject_add+0x80/0xe0
[    3.539994]  device_add+0xd8/0x840
[    3.543389]  of_device_add+0x4c/0x5c
[    3.546957]  of_platform_device_create_pdata+0xb8/0xf0
[    3.552088]  of_platform_bus_create+0x104/0x350
[    3.556611]  of_platform_populate+0x54/0xe0
[    3.560786]  parse_mtd_partitions+0x430/0x490
[    3.565137]  mtd_device_parse_register+0x90/0x2b0
[    3.569835]  spi_nor_probe+0x1f8/0x2b0
[    3.573578]  spi_mem_probe+0x68/0xa0
[    3.577146]  spi_probe+0x80/0xdc
[    3.580368]  really_probe.part.0+0x98/0x280
[    3.584543]  __driver_probe_device+0x94/0x140
[    3.588891]  driver_probe_device+0x40/0x114
[    3.593066]  __device_attach_driver+0xb0/0x10c
[    3.597502]  bus_for_each_drv+0x64/0xa0
[    3.601331]  __device_attach+0xa8/0x16c
[    3.605159]  device_initial_probe+0x10/0x20
[    3.609334]  bus_probe_device+0x94/0x9c
[    3.613164]  device_add+0x35c/0x840
[    3.616646]  __spi_add_device+0x70/0x114
[    3.620561]  spi_add_device+0x5c/0x90
[    3.624215]  of_register_spi_device+0x204/0x330
[    3.628739]  spi_register_controller+0x3e8/0x6dc
[    3.633349]  devm_spi_register_controller+0x20/0x74
[    3.638219]  mtk_nor_probe+0x344/0x4c0
[    3.641961]  platform_probe+0x64/0xd0
[    3.645616]  really_probe.part.0+0x98/0x280
[    3.649791]  __driver_probe_device+0x94/0x140
[    3.654139]  driver_probe_device+0x40/0x114
[    3.658314]  __driver_attach+0xf0/0x180
[    3.662142]  bus_for_each_dev+0x5c/0x90
[    3.665971]  driver_attach+0x20/0x2c
[    3.669540]  bus_add_driver+0x140/0x1ec
[    3.673371]  driver_register+0x74/0x120
[    3.677199]  __platform_driver_register+0x24/0x30
[    3.681895]  mtk_nor_driver_init+0x18/0x20
[    3.685986]  do_one_initcall+0x4c/0x1c0
[    3.689814]  kernel_init_freeable+0x230/0x294
[    3.694164]  kernel_init+0x20/0x120
[    3.697644]  ret_from_fork+0x10/0x20
[    3.701212] ---[ end trace 0000000000000000 ]---
[    3.705829] ------------[ cut here ]------------
[    3.710440] kobject: '(null)' (0000000097a89bbf): is not initialized, yet kobject_put() is being called.
[    3.719924] WARNING: CPU: 0 PID: 1 at kobject_put+0x68/0xf0
[    3.725493] Modules linked in:
[    3.728538] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S      W         5.18.0-rc1+ #0
[    3.736274] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
[    3.742270] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.749224] pc : kobject_put+0x68/0xf0
[    3.752966] lr : kobject_put+0x68/0xf0
[    3.756708] sp : ffffffc008bdb390
[    3.760012] x29: ffffffc008bdb390 x28: 0000000000000000 x27: ffffff8005c57810
[    3.767143] x26: ffffff8005c74a20 x25: 0000000000000000 x24: ffffffc008b55368
[    3.774274] x23: 0000000000000000 x22: 00000000fffffffe x21: ffffff8005c74a20
[    3.781406] x20: ffffff8005c57810 x19: ffffff8005c74a20 x18: ffffffc008ab9630
[    3.788536] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 00000000000002bb
[    3.795667] x14: 0000000000000831 x13: 00000000000002bb x12: 00000000ffffffea
[    3.802798] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc008b11630
[    3.809928] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[    3.817059] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc008bdb0b0
[    3.824189] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 000000000000005c
[    3.831321] Call trace:
[    3.833757]  kobject_put+0x68/0xf0
[    3.837153]  kobject_add_internal+0x130/0x330
[    3.841503]  kobject_add+0x80/0xe0
[    3.844899]  device_add+0xd8/0x840
[    3.848294]  of_device_add+0x4c/0x5c
[    3.851861]  of_platform_device_create_pdata+0xb8/0xf0
[    3.856992]  of_platform_bus_create+0x104/0x350
[    3.861515]  of_platform_populate+0x54/0xe0
[    3.865690]  parse_mtd_partitions+0x430/0x490
[    3.870040]  mtd_device_parse_register+0x90/0x2b0
[    3.874737]  spi_nor_probe+0x1f8/0x2b0
[    3.878479]  spi_mem_probe+0x68/0xa0
[    3.882047]  spi_probe+0x80/0xdc
[    3.885269]  really_probe.part.0+0x98/0x280
[    3.889444]  __driver_probe_device+0x94/0x140
[    3.893792]  driver_probe_device+0x40/0x114
[    3.897968]  __device_attach_driver+0xb0/0x10c
[    3.902403]  bus_for_each_drv+0x64/0xa0
[    3.906233]  __device_attach+0xa8/0x16c
[    3.910061]  device_initial_probe+0x10/0x20
[    3.914235]  bus_probe_device+0x94/0x9c
[    3.918065]  device_add+0x35c/0x840
[    3.921547]  __spi_add_device+0x70/0x114
[    3.925461]  spi_add_device+0x5c/0x90
[    3.929116]  of_register_spi_device+0x204/0x330
[    3.933639]  spi_register_controller+0x3e8/0x6dc
[    3.938248]  devm_spi_register_controller+0x20/0x74
[    3.943118]  mtk_nor_probe+0x344/0x4c0
[    3.946860]  platform_probe+0x64/0xd0
[    3.950514]  really_probe.part.0+0x98/0x280
[    3.954689]  __driver_probe_device+0x94/0x140
[    3.959037]  driver_probe_device+0x40/0x114
[    3.963212]  __driver_attach+0xf0/0x180
[    3.967039]  bus_for_each_dev+0x5c/0x90
[    3.970869]  driver_attach+0x20/0x2c
[    3.974438]  bus_add_driver+0x140/0x1ec
[    3.978268]  driver_register+0x74/0x120
[    3.982096]  __platform_driver_register+0x24/0x30
[    3.986792]  mtk_nor_driver_init+0x18/0x20
[    3.990882]  do_one_initcall+0x4c/0x1c0
[    3.994711]  kernel_init_freeable+0x230/0x294
[    3.999061]  kernel_init+0x20/0x120
[    4.002541]  ret_from_fork+0x10/0x20
[    4.006109] ---[ end trace 0000000000000000 ]---
[    4.010725] kobject_add_internal failed for 11014000.spi:flash@0:partitions:partition@1000000 (error: -2 parent: (null))
[    4.021590] ------------[ cut here ]------------
[    4.026196] kobject: '(null)' (0000000097a89bbf): is not initialized, yet kobject_put() is being called.
[    4.035681] WARNING: CPU: 0 PID: 1 at kobject_put+0x68/0xf0
[    4.041248] Modules linked in:
[    4.044294] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S      W         5.18.0-rc1+ #0
[    4.052030] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
[    4.058025] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.064979] pc : kobject_put+0x68/0xf0
[    4.068722] lr : kobject_put+0x68/0xf0
[    4.072463] sp : ffffffc008bdb490
[    4.075768] x29: ffffffc008bdb490 x28: 0000000000000000 x27: ffffff8005c57810
[    4.082900] x26: ffffff8005c74a20 x25: 0000000000000000 x24: 0000000000000001
[    4.090031] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
[    4.097162] x20: ffffff8005c74a20 x19: ffffff8005c74a20 x18: ffffffc008ab9630
[    4.104293] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 00000000000002fd
[    4.111424] x14: 00000000000008f7 x13: 00000000000002fd x12: 00000000ffffffea
[    4.118554] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc008b11630
[    4.125685] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[    4.132816] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc008bdb1b0
[    4.139946] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 000000000000005c
[    4.147078] Call trace:
[    4.149514]  kobject_put+0x68/0xf0
[    4.152910]  device_add+0xfc/0x840
[    4.156305]  of_device_add+0x4c/0x5c
[    4.159872]  of_platform_device_create_pdata+0xb8/0xf0
[    4.165003]  of_platform_bus_create+0x104/0x350
[    4.169525]  of_platform_populate+0x54/0xe0
[    4.173700]  parse_mtd_partitions+0x430/0x490
[    4.178051]  mtd_device_parse_register+0x90/0x2b0
[    4.182749]  spi_nor_probe+0x1f8/0x2b0
[    4.186491]  spi_mem_probe+0x68/0xa0
[    4.190059]  spi_probe+0x80/0xdc
[    4.193281]  really_probe.part.0+0x98/0x280
[    4.197456]  __driver_probe_device+0x94/0x140
[    4.201804]  driver_probe_device+0x40/0x114
[    4.205979]  __device_attach_driver+0xb0/0x10c
[    4.210414]  bus_for_each_drv+0x64/0xa0
[    4.214244]  __device_attach+0xa8/0x16c
[    4.218072]  device_initial_probe+0x10/0x20
[    4.222248]  bus_probe_device+0x94/0x9c
[    4.226078]  device_add+0x35c/0x840
[    4.229560]  __spi_add_device+0x70/0x114
[    4.233476]  spi_add_device+0x5c/0x90
[    4.237130]  of_register_spi_device+0x204/0x330
[    4.241653]  spi_register_controller+0x3e8/0x6dc
[    4.246262]  devm_spi_register_controller+0x20/0x74
[    4.251132]  mtk_nor_probe+0x344/0x4c0
[    4.254875]  platform_probe+0x64/0xd0
[    4.258529]  really_probe.part.0+0x98/0x280
[    4.262705]  __driver_probe_device+0x94/0x140
[    4.267054]  driver_probe_device+0x40/0x114
[    4.271229]  __driver_attach+0xf0/0x180
[    4.275057]  bus_for_each_dev+0x5c/0x90
[    4.278887]  driver_attach+0x20/0x2c
[    4.282456]  bus_add_driver+0x140/0x1ec
[    4.286286]  driver_register+0x74/0x120
[    4.290113]  __platform_driver_register+0x24/0x30
[    4.294810]  mtk_nor_driver_init+0x18/0x20
[    4.298900]  do_one_initcall+0x4c/0x1c0
[    4.302728]  kernel_init_freeable+0x230/0x294
[    4.307079]  kernel_init+0x20/0x120
[    4.310559]  ret_from_fork+0x10/0x20
[    4.314127] ---[ end trace 0000000000000000 ]---
[    4.318748] Creating 7 MTD partitions on "spi0.0":
[    4.323538] 0x000000000000-0x000000020000 : "bl2"
[    4.328902] 0x000000020000-0x0000000c0000 : "fip"
[    4.334231] 0x0000000c0000-0x0000000d0000 : "u-boot-env"
[    4.340495] 0x0000000d0000-0x000000110000 : "factory"
[    4.346152] 0x000000110000-0x000000120000 : "eeprom"
[    4.352108] 0x000000120000-0x000001000000 : "recovery"
[    4.357862] 0x000001000000-0x000004000000 : "firmware"
[    4.363746] mtk-spi-nor 11014000.spi: spi frequency: 46666653 Hz
[...]
---


Best regards


Daniel
