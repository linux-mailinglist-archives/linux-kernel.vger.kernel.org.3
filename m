Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5A550DB61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbiDYImg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiDYIm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:42:28 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F5F72E14;
        Mon, 25 Apr 2022 01:39:23 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 60549C0002;
        Mon, 25 Apr 2022 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650875962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WY9tBQrCibywyI6sCcwj7BM87mEpS3M/iN3ZKFRozpI=;
        b=FVMOXqAnT4hn+n18GiW9w0WvE95uGvFTg9SU/hKV+pYpNZnPKa0DfoE5I/qMmwCBtggdbJ
        9UxFWi16Ef9Qaeuka6ra+ppRK368Z8PJkhltVr6o9wo7phASCamdtuykmUMFtvDs1Glh0P
        SFGGmMuASnJ+r4vkre3EgtNxfhGA0wegLun9XALY/r47/0ijxLBRXWUNpcj4zmkZ1aea6g
        H+9lMFOx+HXga4ZFHOiuHavkyYiIsbPQfOL9nV8DgVCPfAiGfRvteuBFWbQKN2egGSxW2q
        h47yOwBd0EGQBz5g5C1j0CJDQ3nNma7Tk/KEiZ2VmFwdRqoGZbH/67LKD28OPw==
Date:   Mon, 25 Apr 2022 10:39:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: Regression? [PATCH 1/2] mtd: call of_platform_populate() for
 MTD partitions
Message-ID: <20220425103918.12b629be@xps13>
In-Reply-To: <YmX3Yn9cS1YjWOjs@makrotopia.org>
References: <20220406143225.28107-1-zajec5@gmail.com>
        <20220411090032.10999-1-miquel.raynal@bootlin.com>
        <YmX3Yn9cS1YjWOjs@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

daniel@makrotopia.org wrote on Mon, 25 Apr 2022 02:20:34 +0100:

> Hi Rafal,
> Hi Miguel,
>=20
>=20
> On Mon, Apr 11, 2022 at 11:00:32AM +0200, Miquel Raynal wrote:
> > On Wed, 2022-04-06 at 14:32:24 UTC, =3D?utf-8?b?UmFmYcWCIE1pxYJlY2tp?=
=3D wrote: =20
> > > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > >=20
> > > Until this change MTD subsystem supported handling partitions only wi=
th
> > > MTD partitions parsers. That's a specific / limited API designed arou=
nd
> > > partitions.
> > >=20
> > > Some MTD partitions may however require different handling. They may
> > > contain specific data that needs to be parsed and somehow extracted. =
For
> > > that purpose MTD subsystem should allow binding of standard platform
> > > drivers.
> > >=20
> > > An example can be U-Boot (sub)partition with environment variables.
> > > There exist a "u-boot,env" DT binding for MTD (sub)partition that
> > > requires an NVMEM driver.
> > >=20
> > > Ref: 5db1c2dbc04c ("dt-bindings: nvmem: add U-Boot environment variab=
les binding")
> > > Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> =20
> >=20
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.gi=
t mtd/next, thanks. =20
>=20
> I'm trying to use next-20220422 and noticed a few new oops'es.
> Turns out it could be a problem with this commit according to
>=20
> [daniel@box linux.git]$ git bisect good
> 68471517e883902cdff6ea399d043b17f803b1a8 is the first bad commit
> commit 68471517e883902cdff6ea399d043b17f803b1a8
> Author: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> Date:   Wed Apr 6 16:32:24 2022 +0200
>=20
>     mtd: call of_platform_populate() for MTD partitions
> [...]
> ---
>=20
> So when ever there is at least one 'compatible' node for any of the
> mtd partitions I get the oops messages below. It doesn't really matter
> what the compatible string is, "nvmem-cells" as well as "denx,fit"
> (used for OpenWrt mtdsplit not even present in linux-next, so just a
> dead hint in DTS) make the kernel to oops.
>=20
> Despite the messages being shown, both accessing MTD partitions and
> also eth0 MAC address populated via NVMEM seem to work without
> problems (at least looks like it on first sight).
>=20
> Find the full device tree here:
>=20
> https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/linu=
x/mediatek/dts/mt7622-ubnt-unifi-6-lr-ubootmod.dts

Even though these compatibles are not mainline, it feels like the
problem exists here as well. I'm dropping this change for now, let's
fix this first.

>=20
> ---
> [...]
> [    0.549448] mtk-spi-nor 11014000.spi: IRQ not available.
> [    0.556396] spi-nor spi0.0: w25q512jvq (65536 Kbytes)
> [    0.933381] Freeing initrd memory: 2124K
> [    0.941567] 7 fixed-partitions partitions found on MTD device spi0.0
> [    0.947966] OF: Bad cell count for /spi@11014000/flash@0/partitions
> [    0.954286] OF: Bad cell count for /spi@11014000/flash@0/partitions
> [    0.960583] ------------[ cut here ]------------
> [    0.965192] kobject: '(null)' (0000000097a89bbf): is not initialized, =
yet kobject_get() is being called.
> [    0.974688] WARNING: CPU: 0 PID: 1 at kobject_get+0x68/0x94
> [    0.980263] Modules linked in:
> [    0.983313] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G S                =
5.18.0-rc1+ #0
> [    0.991049] Hardware name: Ubiquiti UniFi 6 LR (U-Boot mod) (DT)
> [    0.997046] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    1.004000] pc : kobject_get+0x68/0x94
> [    1.007743] lr : kobject_get+0x68/0x94
> [    1.011484] sp : ffffffc008bdb4a0
> [    1.014789] x29: ffffffc008bdb4a0 x28: 0000000000000000 x27: ffffff800=
5c57810
> [    1.021920] x26: ffffff8005c74a20 x25: 0000000000000000 x24: 000000000=
0000001
> [    1.029050] x23: 0000000000000000 x22: 0000000000000000 x21: 000000000=
0000000
> [    1.036182] x20: ffffff8005c74a20 x19: ffffff8005c74a20 x18: ffffffc00=
8ab9630
> [    1.043312] x17: 6f6b20746579202c x16: 64657a696c616974 x15: 000000000=
0000074
> [    1.050443] x14: 000000000000015c x13: 0000000000000074 x12: 00000000f=
fffffea
> [    1.057574] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffffffc00=
8b11630
> [    1.064705] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 000000000=
0057fa8
> [    1.071835] x5 : 0000000000000fff x4 : 0000000000000000 x3 : ffffffc00=
8bdb1c0
> [    1.078966] x2 : 0000000000000000 x1 : ffffffc008ab9580 x0 : 000000000=
000005c
> [    1.086097] Call trace:
> [    1.088534]  kobject_get+0x68/0x94
> [    1.091930]  device_add+0xa4/0x840
> [    1.095328]  of_device_add+0x4c/0x5c
> [    1.098898]  of_platform_device_create_pdata+0xb8/0xf0
> [    1.104029]  of_platform_bus_create+0x104/0x350
> [    1.108552]  of_platform_populate+0x54/0xe0
> [    1.112728]  parse_mtd_partitions+0x430/0x490
> [    1.117080]  mtd_device_parse_register+0x90/0x2b0
> [    1.121777]  spi_nor_probe+0x1f8/0x2b0
> [    1.125521]  spi_mem_probe+0x68/0xa0
> [    1.129092]  spi_probe+0x80/0xdc
> [    1.132314]  really_probe.part.0+0x98/0x280
> [    1.136490]  __driver_probe_device+0x94/0x140
> [    1.140839]  driver_probe_device+0x40/0x114
> [    1.145014]  __device_attach_driver+0xb0/0x10c
> [    1.149450]  bus_for_each_drv+0x64/0xa0
> [    1.153280]  __device_attach+0xa8/0x16c
> [    1.157108]  device_initial_probe+0x10/0x20
> [    1.161283]  bus_probe_device+0x94/0x9c
> [    1.165114]  device_add+0x35c/0x840
> [    1.168596]  __spi_add_device+0x70/0x114
> [    1.172510]  spi_add_device+0x5c/0x90
> [    1.176165]  of_register_spi_device+0x204/0x330
> [    1.180688]  spi_register_controller+0x3e8/0x6dc
> [    1.185299]  devm_spi_register_controller+0x20/0x74
> [    1.190169]  mtk_nor_probe+0x344/0x4c0
> [    1.193911]  platform_probe+0x64/0xd0
> [    1.197566]  really_probe.part.0+0x98/0x280
> [    1.201741]  __driver_probe_device+0x94/0x140
> [    1.206089]  driver_probe_device+0x40/0x114
> [    1.210264]  __driver_attach+0xf0/0x180
> [    1.214092]  bus_for_each_dev+0x5c/0x90
> [    1.217922]  driver_attach+0x20/0x2c
> [    1.221491]  bus_add_driver+0x140/0x1ec
> [    1.225320]  driver_register+0x74/0x120
> [    1.229149]  __platform_driver_register+0x24/0x30
> [    1.233845]  mtk_nor_driver_init+0x18/0x20
> [    1.237938]  do_one_initcall+0x4c/0x1c0
> [    1.241768]  kernel_init_freeable+0x230/0x294
> [    1.246120]  kernel_init+0x20/0x120
> [    1.249601]  ret_from_fork+0x10/0x20
> [    1.253170] ---[ end trace 0000000000000000 ]---
> [    1.257796] ------------[ cut here ]------------


Thanks,
Miqu=C3=A8l
